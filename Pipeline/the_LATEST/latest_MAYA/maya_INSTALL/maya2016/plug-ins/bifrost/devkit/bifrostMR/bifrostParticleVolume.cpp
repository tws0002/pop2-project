//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostMentalrayHelpers.h"

#include <shader.h>

namespace
{

class ParticleVolumeShader
{
public:
	struct Params
	{
		miColor		color;			// Color
		miColor		transparency;	// Transparency
		miScalar	density;		// Density scaling
		miColor		blobMap;		// Transparency BLOB map(3D texture)
	};

	miBoolean init(miState* state, Params* paras);
	miBoolean execute(miColor* result, miState* state, Params* paras);
	miBoolean exit(miState* state, Params* paras);

private:
	// Particle sample on the ray
	struct ParticleSample
	{
		miScalar				dist;			// Distance from ray origin to sample
		enum { ENTER, LEAVE }	type;			// Enter or leave a particle
		miColor					color;			// Particle color
		miColor					transparency;	// Particle transparency
		miScalar				length;			// Length from enter to leave
		miScalar				weight;			// Weight of the sample
	};

	// Shade a particle
	void shadeParticle(
		miState*						state,
		Params*							paras,
		const miScalar&					particleSqrDist,
		const miVector&					particlePosition,
		const miVector&					rayOrg,
		const miVector&					rayDir,
		const miScalar&					radius,
		const miScalar&					density,
		std::vector<ParticleSample>&	samples
	);

	// Sort particle samples
	static int particleSampleCompare(const void* a, const void* b);

	// TLS particle sample array
	struct ParticleTLS
	{
		int											currentDepth;
		std::vector<std::vector<ParticleSample>* >	sampleStack;
	};
	
	// Scoped access to TLS particle sample array
	struct ScopedParticleTLS
	{
		ScopedParticleTLS(miState* state);
		~ScopedParticleTLS();

		ParticleTLS* tls;
		std::vector<ParticleSample>* samples;
	};

	miTag findMapObject(miState* state);
};

// The distance functor required by search() method.
// This class determines the distance from a particle to a ray.
// Used for comparsion and debugging ray-particle intersections.
class RayMapDistance : public mi::shader::Map_distance_base
{
public:
	RayMapDistance(const miVector& rayOrg, const miVector& rayDir, const miScalar& rayDist)
		: m_rayOrg(rayOrg), m_rayDir(rayDir), m_rayDist(rayDist) {}

	virtual ~RayMapDistance() {}

	miUint get_dimension() const
	{
		return 3;
	}

	const float *get_point() const
	{
		return &m_rayOrg.x;
	}

	float operator() (
		const float *min,
		const float *max) const
	{
		// If the ray intersects with AABB, the distance is 0
		const miVector originMin = {
			(min[0] - m_rayOrg.x) / m_rayDir.x,
			(min[1] - m_rayOrg.y) / m_rayDir.y,
			(min[2] - m_rayOrg.z) / m_rayDir.z
		};
		const miVector originMax = {
			(max[0] - m_rayOrg.x) / m_rayDir.x,
			(max[1] - m_rayOrg.y) / m_rayDir.y,
			(max[2] - m_rayOrg.z) / m_rayDir.z
		};
		const miVector originMinMin = {
			std::min(originMin.x, originMax.x),
			std::min(originMin.y, originMax.y),
			std::min(originMin.z, originMax.z)
		};
		const miVector originMaxMax = {
			std::max(originMin.x, originMax.x),
			std::max(originMin.y, originMax.y),
			std::max(originMin.z, originMax.z)
		};
		const miScalar rayBoxEnd = 
			std::min(std::min(originMaxMax.x, originMaxMax.y), originMaxMax.z);
		const miScalar rayBoxStart = std::max(0.0f,
			std::max(std::max(originMinMin.x, originMinMin.y), originMinMin.z));

		if (rayBoxStart < rayBoxEnd)
			return 0.0f;

		// The distance from line to box is the minimum distance
		// from line to 12 edges of the box
		const miVector B[12] = {
			min[0], min[1], min[2], min[0], min[1], min[2], min[0], min[1], min[2],
			max[0], max[1], min[2], max[0], max[1], min[2], max[0], max[1], min[2],
			max[0], min[1], max[2], max[0], min[1], max[2], max[0], min[1], max[2],
			min[0], max[1], max[2], min[0], max[1], max[2], min[0], max[1], max[2]
		};
		const miVector Bdir[12] = {
			 1.0f, 0.0f, 0.0f, 0.0f,  1.0f, 0.0f, 0.0f, 0.0f,  1.0f,
			-1.0f, 0.0f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f,  1.0f,
			-1.0f, 0.0f, 0.0f, 0.0f,  1.0f, 0.0f, 0.0f, 0.0f, -1.0f,
			 1.0f, 0.0f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f, 0.0f, -1.0f,
		};

		miScalar minDist2 = miHUGE_SCALAR;
		for (int i = 0; i < 12; i++)
		{
			if (std::abs(mi_vector_dot(&m_rayDir, &Bdir[i]) - 1.0f) < MAYA_EPS)
			{
				// Parallel case, reduce to ray-vertex distance
				miScalar d2 = rayPointDist2(B[i]);
				minDist2 = std::min(d2, minDist2);
			}
			else
			{
				// Point A: rayOrg
				// Point B: edge point
				// Vector Bdir: edge vector
				// N = rayDir x Bdir
				// d = | dot(AB, N) | / ||N||
				miVector N;
				mi_vector_prod(&N, &m_rayDir, &Bdir[i]);
				mi_vector_normalize(&N);

				const miVector AB = {
					B[i].x - m_rayOrg.x,
					B[i].y - m_rayOrg.y,
					B[i].z - m_rayOrg.z
				};

				const miScalar d = std::abs(mi_vector_dot(&AB, &N));

				minDist2 = std::min(d * d, minDist2);
			}
		}

		return minDist2;
	}

	float operator() (
		const mi::shader::Map_iterator_base *element) const
	{
		miVector P;
		element->get_position(P);

		return rayPointDist2(P);
	}

private:
	float rayPointDist2(const miVector& P) const
	{
		// Vector A: equal to rayDir
		// Vector B: from rayOrg to P
		// d       : distance from P to ray
		// d^2 = ( ||B|| * sinAB )^2
		//     = ||B||^2 * (1 - cosAB^2)
		//     = ||B||^2 * (1 - dot(A,B)^2)
		const miVector A = m_rayDir;
		const miVector rawB = {
			P.x - m_rayOrg.x,
			P.y - m_rayOrg.y,
			P.z - m_rayOrg.z
		};
		const miScalar lenB2 =
			rawB.x * rawB.x +
			rawB.y * rawB.y +
			rawB.z * rawB.z;
		if (lenB2 < MAYA_EPS) return 0.0f;
		const miScalar invLenB = 1.0f / std::sqrt(lenB2);
		const miVector B = {
			rawB.x * invLenB,
			rawB.y * invLenB,
			rawB.z * invLenB
		};

		const miScalar dotAB = mi_vector_dot(&A, &B);
		const miScalar d2 = lenB2 * (1.0f - dotAB * dotAB);

		if (dotAB < 0.0f)
			return miHUGE_SCALAR;

		if (std::sqrt(lenB2 - d2) > m_rayDist)
			return miHUGE_SCALAR;

		return d2;
	}

	const miVector&	m_rayOrg;
	const miVector&	m_rayDir;
	const miScalar&	m_rayDist;
};

miBoolean ParticleVolumeShader::init(miState* state, Params* paras)
{
	return miTRUE;
}

miBoolean ParticleVolumeShader::execute(miColor* result, miState* state, Params* paras)
{
	// Filter out empty rays
	if (state->dist < MAYA_EPS)
		return miTRUE;

	// Deal with different type of rays
	if (state->type == miRAY_SHADOW)
	{
		// Segment shadow mode is required to trace shadow rays
		// through the particle volume
		if (state->options->shadow == 's')
		{
			state->refraction_volume = state->volume;
			if (!mi_trace_shadow_seg(result, state))
			{
				result->r = result->g = result->b = 0.0f;
				return miFALSE;
			}
		}
	}

	// Find the map object
	const miTag tagMap = findMapObject(state);

	if (tagMap == miNULLTAG)
		return miFALSE;

	// Access to the map object
	mi::shader::Map_status status;
	mi::shader::Access_map map(tagMap);

	// Get the field ids
	mi::shader::Map_field_id radiusFieldId;
	mi::shader::Map_field_id densityFieldId;
	{
		mi::shader::Map_declaration declaration(map, &status);
		if (!status.is_ok())
			return miFALSE;

		radiusFieldId = declaration->get_global_field_id(0, &status);
		if (!status.is_ok())
			return miFALSE;

		densityFieldId = declaration->get_field_id("density", &status);
		if (!status.is_ok())
			return miFALSE;
	}

	// Get global map values
	miScalar radius = 0.01f;
	map->get(radiusFieldId, radius);

	// Get the sample array from TLS storage
	ScopedParticleTLS scopedParticleTLS(state);
	std::vector<ParticleSample>& samples = *scopedParticleTLS.samples;
	samples.clear();

	// Get the ray properties
	const miVector rayOrg  = state->org;
	const miVector rayDir  = state->dir;
	const miScalar rayDist = (state->type == miRAY_SHADOW) ? (miScalar)state->dist : miHUGE_SCALAR;
	
	// The particle search parameters
	const miInteger searchMaxElements	= 1000;
	const miScalar  searchMaxDist		= radius + MAYA_EPS;

	// The main loop to collect samples from particles along the ray
	mi::shader::Map_lookup lookup(map);
	lookup->search(rayOrg, rayDir, rayDist, searchMaxElements, searchMaxDist * searchMaxDist);
	// RayMapDistance rayMapDist(rayOrg, rayDir, rayDist);
	// lookup->search(rayMapDist, searchMaxElements, searchMaxDist * searchMaxDist);

	while (!lookup->is_empty())
	{
		// Shade particles in this search
		for (; !lookup->at_end(); lookup->next())
		{
			// Distance from particle center to ray
			const miScalar particleSqrDist = lookup->get_distance();

			// Particle center position
			miVector particlePosition;
			lookup->get_position(particlePosition);

			// Density
			miScalar particleDensity = 1.0f;
			lookup->get(densityFieldId, particleDensity);

			// Shade the particle
			shadeParticle(state, paras, particleSqrDist, particlePosition,
				rayOrg, rayDir, radius, particleDensity, samples);
		}

		// Find the remaining particles
		lookup->search_next();
	}

	// No hit ?
	if (samples.empty())
	{
		// Temporary hack to return white ..
		if (state->type == miRAY_SHADOW)
			result->r = result->g = result->b = 1.0f;
		return miTRUE;
	}

	// Sort particle samples
	std::qsort(&samples[0], samples.size(), sizeof(ParticleSample), particleSampleCompare);

	// Accumulation variables (interleaving particles)
	// If there is only 1 particle (particleStackCount = 1), the accumulated
	// values are just the values from the sole particle.
	// Otherwise, we accumulate values from each interleaving particles.
	miInteger	particleStackCount	= 0;
	miColor		accumulatedColor	= {0.0f, 0.0f, 0.0f, 0.0f};
	miColor		accumulatedTransp	= {0.0f, 0.0f, 0.0f, 0.0f};
	miScalar	accumulatedWeight	= 0.0f;

	// Output variables
	miColor		outColor			= {0.0f, 0.0f, 0.0f, 0.0f};
	miColor		outTransp			= {1.0f, 1.0f, 1.0f, 1.0f};

	// The main loop to integrate samples along the ray
	miScalar	prevDist, thisDist = samples[0].dist;
	for (std::vector<ParticleSample>::const_iterator it = samples.begin();
		it != samples.end();
		it++)
	{
		// Distance from previous sample to this sample
		prevDist = thisDist;
		thisDist = it->dist;
		const miScalar sampleDist = thisDist - prevDist;

		// Integrate current sample into the result
		if (particleStackCount > 0 && sampleDist > MAYA_EPS)
		{
			// The inverse of the total weight of all interleaving particles
			const miScalar invAccumulatedWeight = (accumulatedWeight > MAYA_EPS) ?
				1.0f / accumulatedWeight : 0.0f;

			// Weighted average of the total color of all interleaving particles
			miColor color = {
				accumulatedColor.r * invAccumulatedWeight,
				accumulatedColor.g * invAccumulatedWeight,
				accumulatedColor.b * invAccumulatedWeight,
				1.0f
			};

			// Total transparent of all interleaving particles
			miColor transp = {
				1.0f - std::exp(-sampleDist * accumulatedTransp.r),
				1.0f - std::exp(-sampleDist * accumulatedTransp.g),
				1.0f - std::exp(-sampleDist * accumulatedTransp.b),
				1.0f
			};
			transp.r *= outTransp.r;
			transp.g *= outTransp.g;
			transp.b *= outTransp.b;

			// Integrate to output color
			outColor.r += color.r * transp.r;
			outColor.g += color.g * transp.g;
			outColor.b += color.b * transp.b;

			// Integrate to output transparency
			outTransp.r -= transp.r;
			outTransp.g -= transp.g;
			outTransp.b -= transp.b;
		}

		// Add the current color and weight to accumulation
		if (it->type == ParticleSample::ENTER)
		{
			accumulatedWeight	+= it->weight;
			accumulatedColor.r	+= it->color.r;
			accumulatedColor.g	+= it->color.g;
			accumulatedColor.b	+= it->color.b;
			accumulatedTransp.r	+= it->transparency.r;
			accumulatedTransp.g	+= it->transparency.g;
			accumulatedTransp.b	+= it->transparency.b;
			particleStackCount++;
		}
		else
		{
			accumulatedWeight	-= it->weight;
			accumulatedColor.r	-= it->color.r;
			accumulatedColor.g	-= it->color.g;
			accumulatedColor.b	-= it->color.b;
			accumulatedTransp.r	-= it->transparency.r;
			accumulatedTransp.g	-= it->transparency.g;
			accumulatedTransp.b	-= it->transparency.b;
			particleStackCount--;
		}

		// Stop if contribution to final color is negligable
		if (outTransp.r < MAYA_EPS && outTransp.g < MAYA_EPS && outTransp.b < MAYA_EPS)
			break;
	}

	outTransp.a = mi_luminance(state, &outTransp);
	if (state->type != miRAY_SHADOW && state->type != miRAY_LIGHT)
	{
		result->r = result->r * outTransp.r + outColor.r;
		result->g = result->g * outTransp.g + outColor.g;
		result->b = result->b * outTransp.b + outColor.b;
		result->a = result->a * outTransp.a + (1.0f - outTransp.a);
	}
	else
	{
		result->r *= outTransp.r;
		result->g *= outTransp.g;
		result->b *= outTransp.b;
		return (result->r > MAYA_EPS || result->g > MAYA_EPS || result->b > MAYA_EPS) ? miTRUE : miFALSE;
	}

	return miTRUE;
}

void ParticleVolumeShader::shadeParticle(
	miState*						state,
	Params*							paras,
	const miScalar&					particleSqrDist,
	const miVector&					particlePosition,
	const miVector&					rayOrg,
	const miVector&					rayDir,
	const miScalar&					radius,
	const miScalar&					density,
	std::vector<ParticleSample>&	samples
)
{
	// Particle properties
	const miScalar particleSqrRadius	= radius * radius;			// Square particle radius

	// The ray does not intersect with the particle
	if (particleSqrDist > particleSqrRadius)
		return;

	// Length of ray segment in the particle
	const miScalar segmentHalfLength	= std::sqrt(particleSqrRadius - particleSqrDist);
	const miScalar segmentLength		= segmentHalfLength * 2.0f;

	// Distance from ray origin to particle center
	const miScalar distRayOrg2ParticlePosition = mi_vector_dist(&particlePosition, &rayOrg);

	// Distance from ray origin to closest point
	const miScalar distRayOrg2ParticleClosest =
		std::sqrt(std::abs(distRayOrg2ParticlePosition * distRayOrg2ParticlePosition - particleSqrDist));

	// The position of the closest point
	const miVector particleClosest = {
		rayOrg.x + rayDir.x * distRayOrg2ParticleClosest,
		rayOrg.y + rayDir.y * distRayOrg2ParticleClosest,
		rayOrg.z + rayDir.z * distRayOrg2ParticleClosest
	};

	// Vector from particle center to closest point
	const miVector vectorParticleCenter2ParticleClosest = {
		(particleClosest.x - particlePosition.x) / radius,
		(particleClosest.y - particlePosition.y) / radius,
		(particleClosest.z - particlePosition.z) / radius
	};

	// Enter and Leave dist
	miScalar distEnter = (distRayOrg2ParticleClosest - segmentHalfLength);
	miScalar distLeave = (distRayOrg2ParticleClosest + segmentHalfLength);

	if (distEnter < MAYA_EPS)
		distEnter = MAYA_EPS;

	// Weight of the particle (used to resolve interleaving particles)
	const miScalar ratioSqrDist2SqrClosest = particleSqrDist / particleSqrRadius;
	miScalar particleWeight = (ratioSqrDist2SqrClosest >= 1.0f)
		?  0.0f
		: (1.0f - ratioSqrDist2SqrClosest) * (1.0f - ratioSqrDist2SqrClosest);

	// Guard old state variables. We change state to evaluate parameters
	miVariableGuard<miVector>	statePointGuard(state->point);
	miVariableGuard<double>		stateDistGuard(state->dist);
	miVariableGuard<miVector>	stateNormalGuard(state->normal);
	miVariableGuard<miScalar>	stateDotND(state->dot_nd);
	miVariableGuard<miVector>	stateTexGuard(state->tex_list[0]);

	// Setup state for this particle
	state->point.x		= rayOrg.x + rayDir.x * distEnter;
	state->point.y		= rayOrg.y + rayDir.y * distEnter;
	state->point.z		= rayOrg.z + rayDir.z * distEnter;
	state->dist			= distEnter;
	mi_vector_to_camera(state, state->tex_list, &vectorParticleCenter2ParticleClosest);
	state->normal.x		= state->point.x - particlePosition.x;
	state->normal.y		= state->point.y - particlePosition.y;
	state->normal.z		= state->point.z - particlePosition.z;
	mi_vector_normalize(&state->normal);
	state->dot_nd		= mi_vector_dot(&state->normal, &state->dir);

	// Evaluate input parameters
	const miColor	particleColor		= *mi_call_color(&paras->color);
	const miColor	particleTransp		= *mi_call_color(&paras->transparency);
	const miScalar	particleDensity		= *mi_call_scalar(&paras->density);
	const miColor	particleBlobMap		= *mi_call_color(&paras->blobMap);

	// Compute color
	miColor color = {
		particleColor.r * particleWeight,
		particleColor.g * particleWeight,
		particleColor.b * particleWeight,
		1.0f
	};

	// Compute transparency
	miColor transparency = {
		particleBlobMap.r * particleWeight * particleDensity * density,
		particleBlobMap.g * particleWeight * particleDensity * density,
		particleBlobMap.b * particleWeight * particleDensity * density,
		1.0f
	};

	// Compute emission
	if (state->type != miRAY_SHADOW && state->type != miRAY_LIGHT)
	{
		miColor scatterColor = {0.0f, 0.0f, 0.0f, 0.0f};
		for (mi::shader::LightIterator it(state); !it.at_end(); ++it)
		{
			miColor lightColor = {0.0f, 0.0f, 0.0f, 0.0f};
			while (it->sample())
			{
				miColor lightSampleColor = {0.0f, 0.0f, 0.0f, 0.0f};
				it->get_contribution(&lightSampleColor);

				lightColor.r += lightSampleColor.r;
				lightColor.g += lightSampleColor.g;
				lightColor.b += lightSampleColor.b;
			}

			const int n_samples = it->get_number_of_samples();
			if (n_samples > 1)
			{
				lightColor.r /= (miScalar)n_samples;
				lightColor.g /= (miScalar)n_samples;
				lightColor.b /= (miScalar)n_samples;
			}

			scatterColor.r += lightColor.r;
			scatterColor.g += lightColor.g;
			scatterColor.b += lightColor.b;
		}

		color.r *= scatterColor.r;
		color.g *= scatterColor.g;
		color.b *= scatterColor.b;
	}

	transparency.r *= (particleTransp.r < 0.00390625f) ? 5.54518f : -std::log(particleTransp.r);
	transparency.g *= (particleTransp.g < 0.00390625f) ? 5.54518f : -std::log(particleTransp.g);
	transparency.b *= (particleTransp.b < 0.00390625f) ? 5.54518f : -std::log(particleTransp.b);

	// Emit samples
	ParticleSample sample;

	sample.dist			= distEnter;
	sample.type			= ParticleSample::ENTER;
	sample.color		= color;
	sample.transparency	= transparency;
	sample.length		= distLeave - distEnter;
	sample.weight		= particleWeight;
	samples.push_back(sample);

	sample.dist			= distLeave;
	sample.type			= ParticleSample::LEAVE;
	sample.color		= color;
	sample.transparency	= transparency;
	sample.length		= distLeave - distEnter;
	sample.weight		= particleWeight;
	samples.push_back(sample);
}

int ParticleVolumeShader::particleSampleCompare(const void* a, const void* b)
{
	const miScalar distA = reinterpret_cast<const ParticleSample*>(a)->dist;
	const miScalar distB = reinterpret_cast<const ParticleSample*>(b)->dist;

	if (distA < distB)
		return -1;
	else if (distA > distB)
		return 1;
	else
		return 0;
}

miBoolean ParticleVolumeShader::exit(miState* state, Params* paras)
{
	// Free all particle TLS at exit
	void** ptrs;
	int count = 0;
	mi_query(miQ_FUNC_TLS_GETALL, state, miNULLTAG, &ptrs, &count);

	for (int i = 0; i < count; i++)
	{
		ParticleTLS* tls = reinterpret_cast<ParticleTLS*>(ptrs[i]);
		if (tls)
		{
			for (size_t j = 0; j < tls->sampleStack.size(); j++)
				delete tls->sampleStack[j];
			tls->sampleStack.clear();
			delete tls;
		}
	}

	return miTRUE;
}

ParticleVolumeShader::ScopedParticleTLS::ScopedParticleTLS(miState* state)
{
	// Get the current particle TLS
	ParticleTLS* ptr = NULL;
	mi_query(miQ_FUNC_TLS_GET, state, miNULLTAG, &ptr);

	// Initialize if there is no existing TLS or increment the depth
	if (!ptr)
	{
		ptr = new ParticleTLS;
		ptr->currentDepth = 0;
		mi_query(miQ_FUNC_TLS_SET, state, miNULLTAG, &ptr);
	}
	else
	{
		ptr->currentDepth++;
	}

	// Allocate a new entry on the stack if necessary
	while (ptr->currentDepth >= (int)ptr->sampleStack.size())
		ptr->sampleStack.push_back(new std::vector<ParticleSample>());

	// return the current sample array
	tls = ptr;
	samples = ptr->sampleStack[ptr->currentDepth];
}

ParticleVolumeShader::ScopedParticleTLS::~ScopedParticleTLS()
{
	tls->currentDepth--;
}

miTag ParticleVolumeShader::findMapObject(miState* state)
{
	// Find the hull object. When a volume shader is assigned,
	// the map object becomes a hull object for volume rendering.
	if (state->type == miRAY_SHADOW || state->type == miRAY_LIGHT)
	{
		for (miState* s = state->parent; s; s = s->parent)
		{
			if (s->type == miRAY_HULL)
			{
				state = s;
				break;
			}
		}
	}

	miTag tagHull = state->instance;
	if (state->type == miRAY_HULL)
	{
		for (const miState* s = state->parent; s; s = s->parent)
		{
			if (s->type != miRAY_HULL)
			{
				tagHull = s->instance;
				break;
			}
		}
	}

	if (tagHull == miNULLTAG)
		return miNULLTAG;

	// Get the tag of the map object
	miTag tagMap = miNULLTAG;
	{
		miObjectAccess<miInstance> instance(tagHull);
		miObjectAccess<miObject> object(instance->item);
		if (object->type == miOBJECT_PLACEHOLDER)
		{
			miObjectAccess<miObject> placeholder(object->geo.placeholder_list.object);
			tagMap = placeholder->geo.map;
		}
		else if (object->type == miOBJECT_MAP)
		{
			tagMap = object->geo.map;
		}
	}

	return tagMap;
}

} // anonymous namespace

//==============================================================================
// bifrost_particle_volume
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_particle_volume(miColor* result, miState* state, void* paras)
{
	return miShaderUserExecute<ParticleVolumeShader>(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_particle_volume_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserInit<ParticleVolumeShader>(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_particle_volume_exit(miState* state, void* paras)
{
	miShaderUserExit<ParticleVolumeShader>(state, paras);
}

extern "C" DLLEXPORT
int bifrost_particle_volume_version(void)
{
	return 1;
};
