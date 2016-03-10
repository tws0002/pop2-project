//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include <shader.h>

//==============================================================================
// bifrost_scalar_if
//==============================================================================

struct bifrost_scalar_if_params
{
	miBoolean	input;
	miScalar	if_true;
	miScalar	if_false;
};

extern "C" DLLEXPORT
miBoolean bifrost_scalar_if(miScalar* result, miState* state, bifrost_scalar_if_params* paras)
{
	*result = *mi_eval_boolean(&paras->input) != 0 ? *mi_eval_scalar(&paras->if_true) : *mi_eval_scalar(&paras->if_false);
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_scalar_if_version(void)
{
	return 1;
}

//==============================================================================
// bifrost_color_if
//==============================================================================

struct bifrost_color_if_params
{
	miBoolean	input;
	miColor		if_true;
	miColor		if_false;
};

extern "C" DLLEXPORT
miBoolean bifrost_color_if(miColor* result, miState* state, bifrost_color_if_params* paras)
{
	*result = *mi_eval_boolean(&paras->input) != 0 ? *mi_eval_color(&paras->if_true) : *mi_eval_color(&paras->if_false);
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_color_if_version(void)
{
	return 1;
}
