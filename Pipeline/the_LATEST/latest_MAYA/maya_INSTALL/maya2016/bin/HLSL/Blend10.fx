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

// Amount to blend source
float gBlendSrc = 0.3f;
float4 gUVTransform : RelativeViewportDimensions;

// Simple blending between 2 images
float4 PS_Blend(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
    float4 source = gSourceTex.Sample(gSourceSamp, In.UV * gUVTransform.zw + gUVTransform.xy);
    float4 source2 = gSourceTex2.Sample(gSourceSamp2, In.UV * gUVTransform.zw + gUVTransform.xy);
	float4 result = float4( lerp(source2, source, gBlendSrc).xyz, source.a);		
    return result;
}

float4 PS_Add(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
    float4 source = gSourceTex.Sample(gSourceSamp, In.UV * gUVTransform.zw + gUVTransform.xy);
    float4 source2 = gSourceTex2.Sample(gSourceSamp2, In.UV * gUVTransform.zw + gUVTransform.xy);
	return source2 + source;
}

// The main technique.
technique10 Main
{
    pass p0
    {
		SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Blend()));
    }
}

technique10 Add
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Add()));
    }
}
