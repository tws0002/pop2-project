//**************************************************************************/
// Copyright 2010 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/

#include "Common10.fxh"

// Image to gamma correct
Texture2D gInputTex;

// Image input sampler.
SamplerState gInputSampler;

// Gamma value.
float gGamma = 2.2f;

// Pixel shader.
float4 PS_Gamma(VS_TO_PS_ScreenQuad In) : SV_Target
{
	float4 output = gInputTex.Sample(gInputSampler, In.UV.xy);
	return float4( pow( output.xyz, 1.0f / gGamma ), output.w );
}

// The main technique.
technique10 Main
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Gamma()));
    }
}
