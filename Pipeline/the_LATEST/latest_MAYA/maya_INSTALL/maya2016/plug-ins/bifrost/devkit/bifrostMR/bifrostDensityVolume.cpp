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
#include <geoshader.h> // for mi_api_tag_lookup()

#include <limits>
#include <memory>

namespace
{

class DensityVolumeShader
{
public:
	struct Params
	{
		miScalar	minStepSize;			// Minimum distance between samples along ray
		miScalar	maxStepSize;			// Maximum distance between samples along ray
		miInteger	maxSteps;				// Maximum steps allows per rayspan through volume
		miScalar	density;				// Density callback, can plug a scalar channel directly
		miScalar	density_threshold;		// Density at which absorption happens
		miScalar	density_scale;			// Density scale factor
		miBoolean	density_absorb;			// Absorption color is multplied by density
		miBoolean	density_emit;			// Emit color is multplied by density
		miBoolean	density_scatter;		// Scatter color is multplied by density
		miColor		absorb;					// Absorption color per unit
		miColor		emit;					// Emissive color per unit
		miColor		scatter;				// Scatter color per unit
		miColor		in_scatter;				// Input color from scattering
		miScalar	scatter_density_cutoff;	// Scattering will occur only if the density is above the cutoff value
		miScalar	shadow_opacity_scale;	// Scale transparency for shadow rays
		miScalar	colored_opacity;		// Do physically correct coloring of opacity based on scatter and absorb colors
		miVector	displacement;			// Apply 3d noise to the density sampling position
		miBoolean	light_absorb;			// Light rays are absorbed when passing in the volume
		miScalar	lightStepSize;			// Min distance between samples along a light ray
		miInteger	lightMaxSteps;			// Maximum steps allows per light rayspan through volume
		miBoolean	shadow_absorb;			// Shadow rays are absorbed when passing in the volume
		miScalar	shadowStepSize;			// Min distance between samples along a shadow ray
		miInteger	shadowMaxSteps;			// Maximum steps allows per shadow rayspan through volume
		miBoolean	depth_jitter;			// Randomly offset depth of sample to avoid banding artifacts
	};

	miBoolean init(miState* state, Params* paras);
	miBoolean execute(miColor* result, miState* state, Params* paras);
	miBoolean exit(miState* state, Params* paras) { return miTRUE; }

private:
	miInteger	m_maxSteps;
	miScalar	m_minStepSize;
	miScalar	m_maxStepSize;
	miScalar	m_densityThreshold;
	bool		m_densityAbsorb;
	bool		m_densityEmit;
	bool		m_densityScatter;
	bool		m_lightAbsorb;
	bool		m_shadowAbsorb;
	miInteger	m_lightMaxSteps;
	miScalar	m_lightStepSize;
	miInteger	m_shadowMaxSteps;
	miScalar	m_shadowStepSize;
	bool		m_depthJitter;
};

miBoolean DensityVolumeShader::init(miState* state, DensityVolumeShader::Params* paras)
{
	// Eval and cache the global shader parameters
	m_maxSteps		= *mi_eval_integer(&paras->maxSteps);
	m_minStepSize	= *mi_eval_scalar(&paras->minStepSize);
	m_maxStepSize	= *mi_eval_scalar(&paras->maxStepSize);

	m_densityThreshold	= *mi_eval_scalar(&paras->density_threshold);
	m_densityAbsorb		= *mi_eval_boolean(&paras->density_absorb) != 0;
	m_densityScatter	= *mi_eval_boolean(&paras->density_scatter) != 0;
	m_densityEmit		= *mi_eval_boolean(&paras->density_emit) != 0;

	m_lightAbsorb	= *mi_eval_boolean(&paras->light_absorb) != 0;
	m_lightMaxSteps	= *mi_eval_integer(&paras->lightMaxSteps);
	m_lightStepSize	= *mi_eval_scalar(&paras->lightStepSize);

	m_shadowAbsorb		= *mi_eval_boolean(&paras->shadow_absorb) != 0;
	m_shadowMaxSteps	= *mi_eval_integer(&paras->shadowMaxSteps);
	m_shadowStepSize	= *mi_eval_scalar(&paras->shadowStepSize);
	m_depthJitter		= *mi_eval_boolean(&paras->depth_jitter) != 0;

	return miTRUE;
}

miBoolean DensityVolumeShader::execute(miColor* result, miState* state, DensityVolumeShader::Params* paras)
{
	// Filter out empty rays
	if (state->dist < MAYA_EPS)
		return miTRUE;

	// When suporting tracing of light or shadow rays don't scatter or emit unless told so
	bool		absorbOnly	= false;
	miScalar	stepSize	= m_minStepSize;
	miInteger	maxSteps	= m_maxSteps;

	if (state->type == miRAY_LIGHT)
	{
		// Don't modify the color of the light ray
		if (!m_lightAbsorb)
			return miTRUE;

		absorbOnly	= true;
		stepSize	= m_lightStepSize;
		maxSteps	= m_lightMaxSteps;
	}
	else if (state->type == miRAY_SHADOW)
	{
		// Don't modify the color of the shadow ray
		if (!m_shadowAbsorb)
			return miTRUE;

		absorbOnly	= true;
		stepSize	= m_shadowStepSize;
		maxSteps	= m_shadowMaxSteps;

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

	// Find the volume hull object
	miTag tagStateInstance = state->instance;
	miTag tagHullInstance  = state->instance;
	if (state->type == miRAY_HULL)
	{
		for (const miState* s = state->parent; s; s = s->parent)
		{
			if (s->type != miRAY_HULL)
			{
				tagHullInstance = s->instance;
				break;
			}
		}
	}

	// Special case for render swatches
	{
		miTag tagItem = miNULLTAG;
		if (mi_query(miQ_INST_ITEM, NULL, tagHullInstance, &tagItem) && tagItem)
		{
			const char* itemName = mi_api_tag_lookup(tagItem);
			if (itemName && !strcmp(itemName, "swatch::miSwatchPreviewReserved_bifrostAeroShape"))
				stepSize *= 3.0f;
		}
	}

	// Remember org to increasing precision
	miVector org = state->org;

	// get normalized ray direction
	miVector dir = state->dir;
	mi_vector_normalize(&dir);

	// Use a normal that points toward the camera
	const miVector zeroVec = {0.0f, 0.0f, 0.0f};
	miVector camPos = {0.0f, 0.0f, 0.0f};
	mi_point_from_camera(state, &camPos, &zeroVec);

	// Threshold Constants
	const miScalar minT = 0.0001f;
	const miScalar maxT = 1.0f - minT;

	// For now, use the alpha channel has transparency as a starting point
	// TODO use transparency color channel
	miColor transpChannel	= {1.0f, 1.0f, 1.0f, 1.0f};
	miColor accumChannel	= {0.0f, 0.0f, 0.0f, 0.0f};

	// We'll subtract from the remainingDist to know if we finished tracing the whole ray span
	miScalar dist = (miScalar)state->dist;

	miScalar t = 0.0f;
	if (m_depthJitter)
	{	
		double qmc;
		mi_sample(&qmc, NULL, state, 1, NULL);
		t = -stepSize * (float)M_PI * std::acos((float)qmc);
	}

	miInteger i = 0;
	while (t < dist && i < maxSteps && !mi_par_aborted())
	{
		// 't' is the destination of this step
		i++;
		t += stepSize;

		// 'dtJit' is the length of this step
		miScalar dtJit = std::min(t, stepSize);
		if (t > dist)
		{
			dtJit -= t-dist;
			t = dist;
		}

		// 'tMid' is the middle point of this step
		miScalar tMid = t - 0.5f*dtJit;

		// Step further update pos and normal
		miVector p;
		p.x = org.x + tMid * dir.x;
		p.y = org.y + tMid * dir.y;
		p.z = org.z + tMid * dir.z;
		miVector n;
		mi_vector_sub(&n, &camPos, &p);
		mi_vector_normalize(&n);

		// Update the miState hit point
		miUpdateStateAfterHit(state, p, n, /*flipNormal=*/true);

		// Set the hull instance so that other bifrost shaders can find the voxels
		state->instance = tagHullInstance;

		// Apply displacement
		miVector displacement = *mi_call_vector(&paras->displacement);
		mi_vector_add(&state->point, &state->point, &displacement);

		// Evaluate density and scatter if above threshold
		miScalar density = *mi_call_scalar(&paras->density);
		miScalar scaledDensity = density * *mi_call_scalar(&paras->density_scale);

		// Revert displacement
		state->point = p;

		if (density > m_densityThreshold)
		{
			// Accumulation into transpChannel
			miColor absorb = *mi_call_color(&paras->absorb);
			miColor baseAbsorb = absorb;
			if (m_densityAbsorb)
			{
				absorb.r *= scaledDensity;
				absorb.g *= scaledDensity;
				absorb.b *= scaledDensity;
			}

			miColor scatter = *mi_call_color(&paras->scatter);
			miColor baseScatter = scatter;

			if (m_densityScatter)
			{
				scatter.r *= scaledDensity;
				scatter.g *= scaledDensity;
				scatter.b *= scaledDensity;
			}

			miScalar fac = dtJit;
			if (absorbOnly)
			{
				miScalar shadowOpacityScale = *mi_call_scalar(&paras->shadow_opacity_scale);
				fac *= shadowOpacityScale;
			}

			miColor transp;
			transp.r = std::exp(-(scatter.r + absorb.r) * fac);
			transp.g = std::exp(-(scatter.g + absorb.g) * fac);
			transp.b = std::exp(-(scatter.b + absorb.b) * fac);

			// this sample so transparent it has no effect
			if (transp.r > maxT && transp.g > maxT && transp.b > maxT)
				continue;


			// Can skip accumulation of scatter and emit
			if (!absorbOnly)
			{ 
				// Scatter
				miScalar cutoff = *mi_call_scalar(&paras->scatter_density_cutoff);
				miColor inScatter = {0.0f, 0.0f, 0.0f, 0.0f};
				if (density > cutoff) // Cutoff doesn't use scaled density
					inScatter = *mi_call_color(&paras->in_scatter);

				// We divide the scatter by the scatter terms(without density scaling) to get the albedo*light
				miScalar ab = baseScatter.r + baseAbsorb.r;
				if (ab > MAYA_EPS)
					inScatter.r /= ab;
				else
					inScatter.r = 0;

				ab = baseScatter.g + baseAbsorb.g;
				if (ab > MAYA_EPS)
					inScatter.g /= ab;
				else
					inScatter.g = 0;

				ab = baseScatter.b + baseAbsorb.b;
				if (ab > MAYA_EPS)
					inScatter.b /= ab;
				else
					inScatter.b = 0;

				// Emit
				miColor emit = *mi_call_color(&paras->emit);

				// Accumulate emit and scatter				
				accumChannel.r += (emit.r + inScatter.r) * (1.0f - transp.r) * transpChannel.r;
				accumChannel.g += (emit.g + inScatter.g) * (1.0f - transp.g) * transpChannel.g;
				accumChannel.b += (emit.b + inScatter.b) * (1.0f - transp.b) * transpChannel.b;
			}

			// When coloredOpacity is not 1 the shading is no longer strictly physical, but
			// this allows users to more easily adjust the scatter color without affecting
			// the color of the transparency
			miScalar coloredOpacity = *mi_call_scalar(&paras->colored_opacity);
			miScalar avgT = (1.0f - coloredOpacity) * (transp.r + transp.g + transp.b) / 3.0f;
			transp.r = transp.r * coloredOpacity + avgT;
			transp.g = transp.g * coloredOpacity + avgT;
			transp.b = transp.b * coloredOpacity + avgT;

			transpChannel.r *= transp.r;
			transpChannel.g *= transp.g;
			transpChannel.b *= transp.b;

			// Stop if contribution to final color is negligable
			if (transpChannel.r < minT && transpChannel.g < minT && transpChannel.g < minT)
				break;
		}
	}

	transpChannel.a = (transpChannel.r + transpChannel.g + transpChannel.b) / 3.0f;
	if (!absorbOnly)
	{
		// Compute final color based on accum and absorb
		result->r = result->r * transpChannel.r + accumChannel.r;
		result->g = result->g * transpChannel.g + accumChannel.g;
		result->b = result->b * transpChannel.b + accumChannel.b;
		result->a = result->a * transpChannel.a + (1.0f - transpChannel.a);
	}
	else
	{
		// Compute final color based on absorb only
		// The light ray color is modulated by transparency
		result->r *= transpChannel.r;
		result->g *= transpChannel.g;
		result->b *= transpChannel.b;
		return (result->r > MAYA_EPS || result->g > MAYA_EPS || result->b > MAYA_EPS) ? miTRUE : miFALSE;
	}

	state->instance = tagStateInstance;
	return miTRUE;
}

} // anonymous namespace

//==============================================================================
// bifrost_density_volume
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_density_volume(miColor* result, miState* state, void* paras)
{
	return miShaderUserExecute<DensityVolumeShader>(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_density_volume_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserInit<DensityVolumeShader>(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_density_volume_exit(miState* state, void* paras)
{
	miShaderUserExit<DensityVolumeShader>(state, paras);
}

extern "C" DLLEXPORT
int bifrost_density_volume_version(void)
{
	return 1;
};
