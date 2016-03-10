// Copyright 2012 Autodesk, Inc.  All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk license agreement
// provided at the time of installation or download, or which otherwise
// accompanies this software in either electronic or hard copy form.
//
// Simple shader to output different colors to different output targets
//
#include "Common10.fxh"

// Colors to set for output targets 
float4 gTargetColor1 <
    string UIWidget = "Color";
    string UIName = "Color For Target 1";
> = {1.0f,0.0f,0.0f,1.0f};

float4 gTargetColor2 <
    string UIWidget = "Color";
    string UIName = "Color For Target 2";
> = {0.0f,1.0f,0.0f,1.0f};

// Output to 2 diferent targets as an example
struct PixelShaderOutput {
	float4 color1 : SV_Target0;
	float4 color2 : SV_Target1;
};

PixelShaderOutput PS_BlitToMRT(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
	PixelShaderOutput result;
	result.color1 = gTargetColor1;
	result.color2 = gTargetColor2;
    return result;
}

technique10 Main
{
    pass p0
    {
		SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_BlitToMRT()));
    }
}
