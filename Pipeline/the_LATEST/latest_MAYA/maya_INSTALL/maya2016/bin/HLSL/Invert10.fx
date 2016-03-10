//**************************************************************************/
// Copyright 2011 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/

#include "Common10.fxh"

// Image to invert
Texture2D gInputTex;

// Image sampler.
SamplerState gInputSampler;

// Pixel shader.
float4 PS_Invert(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
	float4 output = gInputTex.Sample(gInputSampler, In.UV);
	return 1.0f - output;
}

// The main technique.
technique10 Main
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Invert()));
    }
}
