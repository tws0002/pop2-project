//**************************************************************************/
// Copyright 2011 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/

#include "Common10.fxh"

// The source buffer and sampler
Texture2D gSourceTex < string UIWidget = "None"; > = NULL;
SamplerState gSourceSamp;

// The 2nd buffer and sampler
Texture2D gSourceTex2 < string UIWidget = "None"; > = NULL;
SamplerState gSourceSamp2;

float4 gUVTransform : RelativeViewportDimensions;

// Red / cyan anaglpyh between 2 images
//
float4 PS_Anaglyph(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
    float4 source = gSourceTex.Sample(gSourceSamp, In.UV * gUVTransform.zw + gUVTransform.xy);
    float4 source2 = gSourceTex2.Sample(gSourceSamp2, In.UV * gUVTransform.zw + gUVTransform.xy);

	float4 result;
	result.x = source.x;
	result.yz = source2.yz;
	result.w = saturate(source.w + source2.w);
	
	return result;
}

// Luminance anaglyph between 2 images
//
float4 PS_Anaglyph_Luminance(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
    float4 source = gSourceTex.Sample(gSourceSamp, In.UV * gUVTransform.zw + gUVTransform.xy);
    float4 source2 = gSourceTex2.Sample(gSourceSamp2, In.UV * gUVTransform.zw + gUVTransform.xy);

	float3 RGBtoLum = { 0.1140, 0.5870, 0.2989 };
	float sourceLuminance = dot( RGBtoLum, source.xyz );
	float source2Luminance = dot( RGBtoLum, source2.xyz ); 

	float4 result;
	result.x = sourceLuminance;
	result.y = source2Luminance;
	result.z = source2Luminance;
	result.w  = source2.w;
	return result;
}

// The main technique.
technique10 Main
{
    pass p0
    {
		SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Anaglyph()));
    }
}

technique10 AnaglyphLuminance
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Anaglyph_Luminance()));
    }
}
