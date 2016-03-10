//**************************************************************************/
// Copyright (c) 2010 Autodesk, Inc.
// All rights reserved.
// 
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information written by Autodesk, Inc., and are
// protected by Federal copyright law. They may not be disclosed to third
// parties or copied or duplicated in any form, in whole or in part, without
// the prior written consent of Autodesk, Inc.
//**************************************************************************/
// DESCRIPTION:  Spread the influence of DOF to neighboring pixels.
// AUTHOR:  Kells Elmquist
// CREATED: march 2011, port to hlsl
//**************************************************************************/

#include "Common10.fxh"    

/////////////////////////////////////////////////////////////////////////////
//
//	Spread DOF circles of confusion to affected pixels
//
// The  source image texure to be blurred
uniform Texture2D source;
uniform sampler sourceSamp;
// = sampler_state
//{
//    Texture = <source>;
//};

// the coc/depth texture is a float2 texture that has no-abs coc in .x & linear depth in .y
uniform Texture2D cocDepth;
uniform sampler   cocDepthSamp;
// = sampler_state
//{
//    Texture = <cocDepth>;
//};

uniform int		searchRadius = 8;   // in pixels, radius 4 = 9x9 samples; 8 = 17x17; side=2*radius+1
uniform float2	searchDirection;	// (0,1) for V pass or (1,0) for H pass
uniform int		sampleSpacing = 1;	// stride between pixel samples in motion spreading, 1x1 default
uniform float	acceptThreshold = 0.01f;	// similarity threshold to accept neighbor 


// DOF visualizer Pixel shader.
// NOTE: This expects the common screen quad vertex shader output in common.fxh.
float4 visualizeDOFBlur( VS_TO_PS_ScreenQuad In ) : SV_Target0
{
	// center pixel
    float4 c0 = cocDepth.SampleLevel( cocDepthSamp, In.UV, 0 ); 

	const float nearOffset = 0.0f;
	const float cocScale = 25.0f;

	float coc = abs( c0.x );
	float z = c0.y / (20.0f + c0.y);
	float isNear = (c0.x < nearOffset)? 0.4f : 0.0f;

    float4 clrSum = float4( cocScale * coc, 0.4f * z, isNear, 1.0f );

    return clrSum; 
}

// shader for either pass of the 2 pass h/v spreading technique.
technique10 spreadDOFPass
{
    pass p0
    {
        SetVertexShader( CompileShader( vs_5_0, VS_ScreenQuad() ));
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, visualizeDOFBlur() ));
    }
}
    

