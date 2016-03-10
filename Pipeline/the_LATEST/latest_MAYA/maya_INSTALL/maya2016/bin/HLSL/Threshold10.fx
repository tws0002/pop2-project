//**************************************************************************/
// Copyright (c) 2011 Autodesk, Inc.
// All rights reserved.
// 
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information written by Autodesk, Inc., and are
// protected by Federal copyright law. They may not be disclosed to third
// parties or copied or duplicated in any form, in whole or in part, without
// the prior written consent of Autodesk, Inc.

#include "Common10.fxh"


// The source texture
Texture2D gSourceTex;

// Sampler of source texture
SamplerState gSourceSamp;

float gBrightThreshold = 0.8f;
float4 gUVTransform : RelativeViewportDimensions;

// Pixel shader: Simple blending between 2 images
float4 PS_Threshold(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
    float4 val = gSourceTex.Sample(gSourceSamp, In.UV * gUVTransform.zw + gUVTransform.xy);

	float4 brightnessFactor = float4(0.212671f, 0.715160f, 0.072169f, 1.0f);
	float brightness = dot(brightnessFactor.xyz, val.xyz);
	return ( brightness > gBrightThreshold) ? float4(val.xyz, 1.0f) : float4(0.0f, 0.0f, 0.0f, 1.0f);
}

// The main technique.
technique10 Main
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
		SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Threshold()));
    }
}
