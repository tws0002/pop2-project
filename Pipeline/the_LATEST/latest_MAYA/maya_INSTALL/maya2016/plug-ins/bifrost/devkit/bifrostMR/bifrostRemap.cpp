//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include <shader.h>

namespace
{

inline miScalar remap(miScalar input, miScalar intensity, miScalar offset)
{
	miScalar result = input * intensity + offset;
	return result < 0.0f ? 0.0f : result;
}

} // anonymous namespace

//==============================================================================
// bifrost_scalar_remap
//==============================================================================

struct bifrost_scalar_remap_params
{
	miScalar	input;
	miScalar	intensity;
	miScalar	offset;
};

extern "C" DLLEXPORT
miBoolean bifrost_scalar_remap(miScalar* result, miState* state, bifrost_scalar_remap_params* paras)
{
	miScalar	input		= *mi_eval_scalar(&paras->input);
	miScalar	intensity	= *mi_eval_scalar(&paras->intensity);
	miScalar	offset		= *mi_eval_scalar(&paras->offset);

	// Perform scalar remapping
	*result = remap(input, intensity, offset);
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_scalar_remap_version(void)
{
	return 1;
}

//==============================================================================
// bifrost_color_remap
//==============================================================================

struct bifrost_color_remap_params
{
	miColor		input;
	miScalar	intensity;
	miScalar	offset;
};

extern "C" DLLEXPORT
miBoolean bifrost_color_remap(miColor* result, miState* state, bifrost_color_remap_params* paras)
{
	miColor		input		= *mi_eval_color(&paras->input);
	miScalar	intensity	= *mi_eval_scalar(&paras->intensity);
	miScalar	offset		= *mi_eval_scalar(&paras->offset);

	// Perform color remapping
	result->r = remap(input.r, intensity, offset);
	result->g = remap(input.g, intensity, offset);
	result->b = remap(input.b, intensity, offset);
	result->a = 1.0f;
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_color_remap_version(void)
{
	return 1;
}
