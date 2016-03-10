//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostAABB.h"
#include "bifrostMentalrayHelpers.h"
#include "bifrostObjectUserData.h"

#include <bifrostapi/bifrost_pointchannel.h>
#include <bifrostapi/bifrost_tile.h>
#include <bifrostapi/bifrost_tileaccessor.h>
#include <bifrostapi/bifrost_tiledataaccessor.h>
#include <bifrostapi/bifrost_visitor.h>

#include <shader.h>

#include <limits>
#include <memory>

namespace
{

// Isosurface Particle volume shader renders particles as isosurfaces.
// This is a volume shader that traces the particle surfaces and evaluates the
// surface material at ray-particle intersection.
class IsosurfaceParticleVolumeShader
{
public:
	struct Params
	{
		miTag		object;					// Bifrost JSON object
		miTag		file;					// Bifrost Cache file
		miScalar	threshold;				// Threshold distance at which to create surface
		miTag		material;				// Surface material
		miScalar	minStepSize;			// Minimum distance between samples along ray
		miScalar	maxStepSize;			// Maximum distance between samples
		miScalar	maxSteps;				// Maximum steps allows per rayspan through volume
		miScalar	shadowBias;				// Distance hit point moved along surface normal before shader invoked
		miBoolean	computeRedistance;		// Not used
		miTag		instance;				// Box instance
		miScalar	particleSize;			// Particle radius
		miBoolean	faceCamera;				// Normal is always facing the camera
	};

	miBoolean init(miState* state, Params* paras);
	miBoolean execute(miColor* result, miState* state, Params* paras);
	miBoolean exit(miState* state, Params* paras) { return miTRUE; }

	// Input arguments for the trace call
	struct TraceIn
	{
		amino::Math::vec3f org;	// Ray origin
		amino::Math::vec3f dir;	// Ray direction
		float start;			// Min start distance for intersection.
		float end;				// Max end distance for intersection.

		amino::Math::vec3f idir;
		int sign[3];
	};

	// Output arguments for the trace call
	struct TraceOut
	{
		float s;
		amino::Math::vec3f pos, normal;
		bool ret;

		amino::Math::vec3f bestP;

		TraceOut() : ret(false), s(std::numeric_limits<float>::max()) {}
	};

private:
	// Ray trace through the volume
	void trace(miState* state, const TraceIn& ray, TraceOut& hit);

	float	m_maxSteps;
	float	m_maxStepSize;
	float	m_minStepSize;
	float	m_threshold;
	float	m_shadowBias;
	miTag	m_material;
	miTag	m_instance;
	bool	m_faceCamera;

	// Cached data
	Bifrost::API::Component		m_component;
	Bifrost::API::Layout		m_layout;
	Bifrost::Math::Similarity	m_toWorld;
	Bifrost::API::PointChannel	m_positionChannel;

	float	m_voxelScale;
	float	m_voxelScaleInv;
	float	m_particleSize;
	float	m_particleSize2;
};

// Iterate the particles and find the intersection.
class ParticleLayoutVisitor : public Bifrost::API::Visitor
{
public:
	ParticleLayoutVisitor(
		const miScalar&									particleSize,
		const miScalar&									particleSize2,
		const Bifrost::API::PointChannel&				positionChannel,
		const IsosurfaceParticleVolumeShader::TraceIn&	ray,
		IsosurfaceParticleVolumeShader::TraceOut&		hit
	)
		: m_particleSize(particleSize),
		  m_particleSize2(particleSize2),
		  m_positionChannel(positionChannel),
		  m_ray(ray),
		  m_hit(hit)
	{}

	virtual ~ParticleLayoutVisitor() {}

	void tileBounds(const Bifrost::API::Tile& tile)
	{
		// Get the voxel space coordinate and dimension info
		const Bifrost::API::TileCoord	coord	= tile.coord();
		const Bifrost::API::TileInfo	info	= tile.info();

		m_tileBounds[0] = amino::Math::vec3f(
			(float)coord.i - m_particleSize,
			(float)coord.j - m_particleSize,
			(float)coord.k - m_particleSize
		);

		m_tileBounds[1] = amino::Math::vec3f(
			(float)(coord.i + info.dimInfo.depthWidth) + m_particleSize,
			(float)(coord.j + info.dimInfo.depthWidth) + m_particleSize,
			(float)(coord.k + info.dimInfo.depthWidth) + m_particleSize
		);
	}

	void beginTraverse(const Bifrost::API::TileAccessor& accessor)
	{
		// Initialize the tile data accessor
		m_positionAccessor = m_positionChannel.tileDataAccessor();
	}

	void beginTile(const Bifrost::API::TileAccessor& accessor, const Bifrost::API::TreeIndex& index)
	{
		// Fetch the current tile
		const Bifrost::API::Tile tile = accessor.tile(index);
		tileBounds(tile);

		// Ray-tile AABB intersection
		int h0, h1;
		float t0, t1;

		if (!aabb_test<IsosurfaceParticleVolumeShader::TraceIn>(m_tileBounds, m_ray, h0, h1, t0, t1))
		{
			m_skipTile = true;
			return;
		}

		if (t0 > m_hit.s)
		{
			m_skipTile = true;
			return;
		}

		// Retrieve tile where we can loop on particles
		const Bifrost::API::TileData<amino::Math::vec3f> positionTile =
			m_positionAccessor.tileData<amino::Math::vec3f>(index);

		for (size_t i = 0; i < positionTile.count(); i++)
		{
			const amino::Math::vec3f& position = positionTile[i];

			// Convert to world space
			float dist = 0.0f;
			if (intersect<IsosurfaceParticleVolumeShader::TraceIn>(m_ray, dist, position, m_particleSize2))
			{
				m_hit.ret = true;
				if (dist < m_hit.s)
				{
					m_hit.s		= dist;
					m_hit.bestP	= position;
				}
			}
		}

		m_skipTile = false;
	}

	bool visitVoxel(
		const Bifrost::API::TileAccessor& accessor,
		const Bifrost::API::TreeIndex& index,
		const Bifrost::API::TileCoord& coord
	)
	{
		return !m_skipTile;
	}

private:
	const miScalar&							m_particleSize;
	const miScalar&							m_particleSize2;
	const Bifrost::API::PointChannel&		m_positionChannel;

	Bifrost::API::TileDataAccessor					m_positionAccessor;
	amino::Math::vec3f								m_tileBounds[2];
	bool											m_skipTile;
	const IsosurfaceParticleVolumeShader::TraceIn&	m_ray;
	IsosurfaceParticleVolumeShader::TraceOut&		m_hit;
};

miBoolean IsosurfaceParticleVolumeShader::init(miState* state, IsosurfaceParticleVolumeShader::Params* paras)
{
	// Eval and cache the global shader parameters
	m_maxSteps		= *mi_eval_scalar(&paras->maxSteps);
	m_maxStepSize	= *mi_eval_scalar(&paras->maxStepSize);
	m_minStepSize	= *mi_eval_scalar(&paras->minStepSize);
	m_threshold		= *mi_eval_scalar(&paras->threshold);
	m_shadowBias	= *mi_eval_scalar(&paras->shadowBias);
	m_material		= *mi_eval_tag(&paras->material);
	m_instance		= *mi_eval_tag(&paras->instance);
	m_faceCamera	= *mi_eval_boolean(&paras->faceCamera) != 0;
	m_particleSize	= *mi_eval_scalar(&paras->particleSize) + m_threshold;

	// Find the position point channel
	std::string object		= miTag2String(*mi_eval_tag(&paras->object));
	std::string file		= miTag2String(*mi_eval_tag(&paras->file));
	std::string component, channel;
	{
		// Check the existence of the Bifrost object
		BifrostObjectUserData objectRef(object, file);
		if (!objectRef.objectExists())
		{
			mi_warning("Unable to retrieve object: %s", objectRef.object().c_str());
			return miFALSE;
		}

		// Get the position point channel
		m_positionChannel = objectRef.findPointChannel("position");
		if (!m_positionChannel.valid())
		{
			mi_warning("Can't find point channel: %s %s", objectRef.object().c_str(), channel.c_str());
			return miFALSE;
		}
	}

	mi_debug("Using particle channel: %s", channel.c_str());
	m_component		= m_positionChannel.component();
	m_layout		= m_component.layout();
	m_toWorld		= m_component.world();
	m_voxelScale	= m_layout.voxelScale();
	m_voxelScaleInv	= 1.0f / m_voxelScale;

	// Convert particle size to tile space we want to do the intersection in tile space to avoid
	// converting all the bounding boxes and particle positions to world space
	{
		amino::Math::vec3f zero(0.0f, 0.0f, 0.0f);
		zero = m_voxelScaleInv * m_toWorld.inverseApply(zero);

		amino::Math::vec3f particleSize(m_particleSize, 0.0f, 0.0f);
		particleSize = m_voxelScaleInv * m_toWorld.inverseApply(particleSize);

		particleSize -= zero;
		m_particleSize = mi_vector_norm((miVector*)&particleSize);
	}

	m_particleSize2	= m_particleSize * m_particleSize;

	return miTRUE;
}

miBoolean IsosurfaceParticleVolumeShader::execute(miColor* result, miState* state, IsosurfaceParticleVolumeShader::Params* paras)
{
	if (state->type == miRAY_LIGHT)
		return miTRUE;

	// Filter out empty rays
	if (state->dist < MAYA_EPS)
		return miTRUE;

	// Variables to trace a ray in the volume
	TraceIn ray;
	ray.org = amino::Math::vec3f(state->org.x, state->org.y, state->org.z);
	ray.dir = amino::Math::vec3f(state->dir.x, state->dir.y, state->dir.z);
	ray.start = m_shadowBias; // set beginS a little > 0 to avoid self intersection at the start of secondary rays
	ray.end = state->dist < MAYA_EPS ? std::numeric_limits<float>::max() : (float)state->dist;

	// Convert the ray to tile space
	{
		amino::Math::vec3f lookat = ray.org + ray.end * ray.dir;
		ray.org = m_voxelScaleInv * m_toWorld.inverseApply(ray.org);
		ray.dir = m_voxelScaleInv * m_toWorld.inverseApply(lookat);
		ray.dir -= ray.org;
		ray.end = state->dist < MAYA_EPS ? std::numeric_limits<float>::max() : mi_vector_norm((miVector*)&ray.dir);
		mi_vector_normalize((miVector*)&ray.dir);
	}

	// Data used by the aabb intersection code
	ray.idir = amino::Math::vec3f(1.0f / ray.dir[0], 1.0f / ray.dir[1], 1.0f / ray.dir[2]);
	ray.sign[0] = (ray.idir[0] < 0);
	ray.sign[1] = (ray.idir[1] < 0);
	ray.sign[2] = (ray.idir[2] < 0);

	// The output color of this volume shader
	miColor surfaceColor = *result;
	double  surfaceDist  = miHUGE_SCALAR;

	// Volume shaders share distance value between each other
	miShaderState<double> distState(state, "BVZ", miHUGE_SCALAR);

	// Trace the ray
	TraceOut hit;
	trace(state, ray, hit);
	if (hit.ret)
	{
		// Move the position on the ray based on hit.
		// Also flip the surface normal when if it points away from the camera
		miUpdateStateAfterHit(state, hit.pos, hit.normal, /*flipNormal=*/true);

		// Switch material to use
		state->material = m_material;
		state->instance = m_instance;

		// Stack the dist shader state.
		miScopedShaderState<double> scopedDistState(distState);
		distState.set(miHUGE_SCALAR);

		// The output color of the surface shader
		miColor outColor = {0.0f, 0.0f, 0.0f, 0.0f};

		// Eval the material differently depending on the incoming ray type
		if (state->type == miRAY_SHADOW)
		{
			mi_call_shadow_material(&outColor, state);
		}
		else if (miRAY_PHOTON(state->type))
		{
			mi_call_photon_material(&outColor, state);
		}
		else
		{
			mi_call_material(&outColor, state);
		}

		surfaceColor = outColor;
		surfaceDist  = state->dist;
	}

	// Deal with autovolume
	if (state->options->autovolume)
	{
		// autovolume is on, we need to compare the distance
		miColor* userColor = mi_volume_user_color(state);

		// The first volume shader is responsible for initialize user color and shared distance.
		// Update the user color and distance if the volume shader is closer to the ray origin.
		if (mi_volume_cur_shader(state) == 0 || surfaceDist < distState.get())
		{
			*userColor = surfaceColor;
			distState.set(surfaceDist);
		}

		// The last volume shader is responsible for setting the result.
		// This is the output of all volume shaders.
		if (mi_volume_cur_shader(state) == mi_volume_num_shaders(state)-1)
		{
			*result = *userColor;
		}
	}
	else
	{
		// autovolume is off, set result color directly
		*result = surfaceColor;
	}

	return miTRUE;
}

void IsosurfaceParticleVolumeShader::trace(miState* state, const TraceIn& ray, TraceOut& hit)
{
	hit.ret = false;
	ParticleLayoutVisitor visitor(m_particleSize, m_particleSize2, m_positionChannel, ray, hit);
	m_layout.traverse(visitor, Bifrost::API::DepthFirst);

	// We have a hit
	if (hit.ret)
	{
		hit.pos = ray.org + ray.dir * hit.s;

		// Convert to world space
		hit.pos   = m_toWorld.apply(m_voxelScale * hit.pos);
		hit.bestP = m_toWorld.apply(m_voxelScale * hit.bestP);

		// Compute the normal. Face camera
		if (m_faceCamera)
		{
			const miVector zneg = {0.0f, 0.0f, -1.0f};
			mi_vector_from_camera(state, (miVector*)&hit.normal, &zneg);
		}
		// Compute the normal. Sphere like
		else
		{
			hit.normal = hit.bestP - hit.pos;
			mi_vector_normalize((miVector*)&hit.normal);
		}
	}
}


} // anonymous namespace

//==============================================================================
// bifrost_isosurface_particle_volume
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_isosurface_particle_volume(miColor* result, miState* state, void* paras)
{
	return miShaderUserExecute<IsosurfaceParticleVolumeShader>(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_isosurface_particle_volume_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserInit<IsosurfaceParticleVolumeShader>(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_isosurface_particle_volume_exit(miState* state, void* paras)
{
	miShaderUserExit<IsosurfaceParticleVolumeShader>(state, paras);
}

extern "C" DLLEXPORT
int bifrost_isosurface_particle_volume_version(void)
{
	return 1;
};
