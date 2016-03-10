//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include <shader.h>

//=============================================================================
// bifrost_illum_flat
//=============================================================================

struct bifrost_illum_flat_params
{
	miColor		color;		/* flat color */
	miScalar	weight;		/* flat weight */
	int			mode;		/* light mode: 0..2 */
	int			i_light;	/* index of first light */
	int			n_light;	/* number of lights */
	miTag		light[1];	/* list of lights */
};

// Simple flat illumination shader doing flat shading.
// It's as if the surface is always perpendicular to the light.
// Based on mib_illum_lambert
extern "C" DLLEXPORT
miBoolean bifrost_illum_flat(miColor* result, miState* state, bifrost_illum_flat_params *paras)
{
	result->r = 0.f;
	result->g = 0.f;
	result->b = 0.f;
	result->a = 0.f;

	/* check for illegal calls */
	if (state->type == miRAY_SHADOW || state->type == miRAY_DISPLACE)
		return miFALSE;

	miColor flat =  *mi_eval_color(&paras->color);
	miScalar w =  *mi_eval_scalar(&paras->weight);
	flat.r *= w;
	flat.g *= w;
	flat.b *= w;

	int m = *mi_eval_integer(&paras->mode);
	int n_l   = *mi_eval_integer(&paras->n_light);
	int i_l   = *mi_eval_integer(&paras->i_light);
	miTag* light =  mi_eval_tag(paras->light) + i_l;

	if (m == 1) /* modify light list (inclusive mode) */
		mi_inclusive_lightlist(&n_l, &light, state);
	else if (m == 2)/* modify light list (exclusive mode) */
		mi_exclusive_lightlist(&n_l, &light, state);
	else if (m == 4)
	{
		n_l = 0;
		light = 0;
	}

	/* Loop over all light sources */
	if( m==4 || n_l )
	{
		for( mi::shader::LightIterator iter(state, light, n_l); !iter.at_end(); ++iter )
		{
			miColor sum = { 0.f, 0.f, 0.f, 0.f }; /* summed sample colors */
			while( iter->sample() )
			{
				miColor color; /* color from light source */
				iter->get_contribution( &color );
				sum.r += flat.r * color.r;
				sum.g += flat.g * color.g;
				sum.b += flat.b * color.b;
			}

			int samples = iter->get_number_of_samples();
			if( samples )
			{
				result->r += sum.r / samples;
				result->g += sum.g / samples;
				result->b += sum.b / samples;
			}
		}
	}

	result->a  = 1.f;
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_illum_flat_version(void)
{
	return 1;
}
