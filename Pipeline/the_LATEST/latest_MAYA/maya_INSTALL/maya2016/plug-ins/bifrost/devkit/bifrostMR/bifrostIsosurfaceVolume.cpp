//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostHelpers.h"
#include "bifrostMentalrayHelpers.h"
#include "bifrostObjectUserData.h"

#include <shader.h>

#include <limits>
#include <memory>

namespace
{

class IsosurfaceVolumeShader
{
public:
	struct Params
	{
		miTag		object;					// Bifrost JSON object
		miTag		file;					// Bifrost Cache file
		miTag		shape;					// Volume component
		miTag		channel;				// Distance channel
		miScalar	threshold;				// Threshold distance at which to create surface
		miTag		material;				// Surface material
		miScalar	minStepSize;			// Minimum distance between samples along ray
		miScalar	maxStepSize;			// Maximum distance between samples
		miScalar	maxSteps;				// Maximum steps allows per rayspan through volume
		miScalar	shadowBias;				// Distance hit point moved along surface normal before shader invoked
		miBoolean	computeRedistance;		// Not used
		miTag		instance;				// Box instance
	};

	miBoolean init(miState* state, Params* paras);
	miBoolean execute(miColor* result, miState* state, Params* paras);
	miBoolean exit(miState* state, Params* paras);

private:
	// Input arguments for the trace call
	struct TraceIn
	{
		amino::Math::vec3f org;	// Ray origin
		amino::Math::vec3f dir;	// Ray direction
		float start;			// Min start distance for intersection.
		float end;				// Max end distance for intersection.
	};

	// Output arguments for the trace call
	struct TraceOut
	{
		float s;
		amino::Math::vec3f pos, normal;
		bool ret;

		TraceOut() : ret(false), s(std::numeric_limits<float>::max()) {}
	};

	// Ray trace through the volume
	void trace(miState* state, const TraceIn& ray, TraceOut& hit);

	float	m_maxSteps;
	float	m_maxStepSize;
	float	m_minStepSize;
	float	m_threshold;
	float	m_shadowBias;
	miTag	m_material;
	miTag	m_instance;

	Bifrost::API::VoxelChannel m_channel;
};

miBoolean IsosurfaceVolumeShader::init(miState* state, IsosurfaceVolumeShader::Params* paras)
{
	// Eval and cache the global shader parameters
	m_maxSteps		= *mi_eval_scalar(&paras->maxSteps);
	m_maxStepSize	= *mi_eval_scalar(&paras->maxStepSize);
	m_minStepSize	= *mi_eval_scalar(&paras->minStepSize);
	m_threshold		= *mi_eval_scalar(&paras->threshold);
	m_shadowBias	= *mi_eval_scalar(&paras->shadowBias);
	m_material		= *mi_eval_tag(&paras->material);
	m_instance		= *mi_eval_tag(&paras->instance);

	// Find the isosurface voxel channel
	std::string object		= miTag2String(*mi_eval_tag(&paras->object));
	std::string file		= miTag2String(*mi_eval_tag(&paras->file));
	std::string component	= miTag2String(*mi_eval_tag(&paras->shape));
	std::string channel		= miTag2String(*mi_eval_tag(&paras->channel));
	{
		// Check the existence of the Bifrost object
		BifrostObjectUserData objectRef(object, file);
		if (!objectRef.objectExists())
		{
			mi_warning("Unable to retrieve object: %s", objectRef.object().c_str());
			return miFALSE;
		}

		// Find the isosurface voxel channel
		m_channel = objectRef.findVoxelChannel(channel.c_str());
		if (!m_channel.valid())
		{
			mi_warning("Can't find voxel channel: %s %s", objectRef.object().c_str(), channel.c_str());
			return miFALSE;
		}

		mi_debug("Using voxel channel: %s %s", objectRef.object().c_str(), channel.c_str());

		// Step sizes need to be modulated by dx.
		Bifrost::API::Layout layout = m_channel.layout();
		const float scaling = layout.voxelScale();
		m_maxStepSize *= scaling;
		m_minStepSize *= scaling;
		m_shadowBias  *= scaling;

		// More steps when dx is smaller
		m_maxSteps /= scaling;
	}

	return miTRUE;
}

miBoolean IsosurfaceVolumeShader::execute(miColor* result, miState* state, IsosurfaceVolumeShader::Params* paras)
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
		miUpdateStateAfterHit(state, hit.pos, hit.normal, /*flipNormal=*/state->type != miRAY_SHADOW);

		// Switch material to use
		state->material = m_material;
		state->instance = m_instance;

		// Stack the dist shader state.
		miScopedShaderState<double> scopedDistState(distState);
		distState.set(miHUGE_SCALAR);

		// The output color of the surface shader
		miColor outColor = {0.f, 0.f, 0.f, 0.f};

		// Eval the material differently depending on the incomming ray type
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

miBoolean IsosurfaceVolumeShader::exit(miState* state, Params* paras)
{
	// Delete all voxel samplers from the thread-local storage
	{
		Bifrost::API::VoxelSampler** samplers = NULL;
		int samplerCount = 0;

		mi_query(miQ_FUNC_TLS_GETALL, state, miNULLTAG, &samplers, &samplerCount);
		for (int i = 0; i < samplerCount; i++)
			delete samplers[i];
	}

	return miTRUE;
}

void IsosurfaceVolumeShader::trace(miState* state, const TraceIn& ray, TraceOut& hit)
{
	// Retrieve the voxel sampler from thread-local storage
	Bifrost::API::VoxelSampler* sampler = NULL;
	mi_query(miQ_FUNC_TLS_GET, state, miNULLTAG, &sampler);

	// Create a voxel sampler if it doesn't exist
	if (!sampler)
	{
		sampler = new Bifrost::API::VoxelSampler(m_channel.createSampler(
			Bifrost::API::VoxelSamplerQBSplineType, Bifrost::API::WorldSpace));
		mi_query(miQ_FUNC_TLS_SET, state, miNULLTAG, &sampler);
	}

	// Fail if we have an invalid sampler..
	if (!sampler || !sampler->valid())
		return;

	// Call the trace function
	hit.ret = TraceIsosurface(ray.org, ray.dir, ray.start, ray.end, *sampler, m_minStepSize, m_maxStepSize, m_threshold, m_maxSteps, &hit.s, &hit.normal);

	// Front/Back face culling
	const char face = state->face ? state->face : state->options->face;
	if (face == 'f' || face == 'b')
	{
		// Loop until we find an intersection on the required face type
		while (hit.ret)
		{
			// Compute the dot product of ray direction and isosurface normal
			// dot_nd < 0 : front face
			// dot_nd > 0 : back face
			const float dot_nd = ray.dir[0] * hit.normal[0] + ray.dir[1] * hit.normal[1] + ray.dir[2] * hit.normal[2];
			
			// Hit a front face
			if (face == 'f' && dot_nd < 0)
				break;

			// Hit a back face
			if (face == 'b' && dot_nd > 0)
				break;

			// Cull this face and find the next intersection
			hit.ret = TraceIsosurface(ray.org, ray.dir, hit.s + m_shadowBias, ray.end, *sampler, m_minStepSize, m_maxStepSize, m_threshold, m_maxSteps, &hit.s, &hit.normal);
		}
	}

	// We have a hit
	if (hit.ret)
	{
		hit.pos = ray.org + ray.dir * hit.s;
	}
}

} // anonymous namespace

//==============================================================================
// bifrost_isosurface_volume
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_isosurface_volume(miColor* result, miState* state, void* paras)
{
	return miShaderUserExecute<IsosurfaceVolumeShader>(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_isosurface_volume_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserInit<IsosurfaceVolumeShader>(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_isosurface_volume_exit(miState* state, void* paras)
{
	miShaderUserExit<IsosurfaceVolumeShader>(state, paras);
}

extern "C" DLLEXPORT
int bifrost_isosurface_volume_version(void)
{
	return 1;
};
