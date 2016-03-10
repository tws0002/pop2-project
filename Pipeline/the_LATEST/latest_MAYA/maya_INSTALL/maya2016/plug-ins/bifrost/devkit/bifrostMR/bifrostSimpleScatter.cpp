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
#include <shader_lightlist.h>

namespace
{

class SimpleScatterShader
{
public:
	struct Params
	{
		miColor		scatter;
		miScalar	directionality;
	};

	miBoolean init(miState* state, Params* paras) { return miTRUE; }
	miBoolean execute(miColor* result, miState* state, Params* paras);
	miBoolean exit(miState* state, Params* paras) { return miTRUE; }
};

// Perform simple scattering
miBoolean SimpleScatterShader::execute(miColor* result, miState* state, SimpleScatterShader::Params* paras)
{
	// Sample the light for scatter colors using schlick volume scattering function
	miScalar	directionality	= *mi_eval_scalar(&paras->directionality);
	miColor		scatterColor	= {0.0f, 0.0f, 0.0f, 0.0f};

	for (mi::shader::LightIterator it(state); !it.at_end(); ++it)
	{
		miColor lightColor = {0.0f, 0.0f, 0.0f, 0.0f};
		while (it->sample())
		{
			miVector lightDir = it->get_direction();

			miScalar s = mi_schlick_scatter(&state->dir, &lightDir, directionality);
			if (s > 0.0f)
			{
				miColor lightSampleColor = {0.0f, 0.0f, 0.0f, 0.0f};
				it->get_contribution(&lightSampleColor);

				lightColor.r += s * lightSampleColor.r;
				lightColor.g += s * lightSampleColor.g;
				lightColor.b += s * lightSampleColor.b;
			}
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

	// Blend colors together
	miColor scatter = *mi_eval_color(&paras->scatter);
	result->r = scatter.r * scatterColor.r;
	result->g = scatter.g * scatterColor.g;
	result->b = scatter.b * scatterColor.b;
	result->a = 1.f;

	return miTRUE;
}

} // anonymous namespace

//==============================================================================
// bifrost_simple_scatter
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_simple_scatter(miColor* result, miState* state, void* paras)
{
	return miShaderUserExecute<SimpleScatterShader>(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_simple_scatter_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserInit<SimpleScatterShader>(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_simple_scatter_exit(miState* state, void* paras)
{
	miShaderUserExit<SimpleScatterShader>(state, paras);
}

extern "C" DLLEXPORT
int bifrost_simple_scatter_version(void)
{
	return 1;
};
