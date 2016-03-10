// Copyright 2012 Autodesk, Inc.  All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk license agreement
// provided at the time of installation or download, or which otherwise
// accompanies this software in either electronic or hard copy form.

#include "Common10.fxh"

// The source texture
Texture2D gSourceTex : LeftSourceTexture
<
    string UIName = "Left Texture";
>;

// Sampler of source texture
SamplerState gSourceSamp;

// The 2nd source texture
Texture2D gSourceTex2 : RightSourceTexture
<
    string UIName = "Right Texture";
>;

// Sampler of 2nd source texture
SamplerState gSourceSamp2;

float4 gUVTransform : RelativeViewportDimensions;
float2 gViewportSizePixels = { 0.0f, 0.0f };
float2 gSourceSizePixels = { 0.0f, 0.0f };
float  gBorderSizePixels = 10.0f;
float4 gBorderColor = { 0, 0, 0, 1 };
float4 gBackgroundColor = { 0.1, 0.1, 0.1, 1 };


float inRect( float2 inp, float2 wh )
{
	float val = (inp.x >= 0.0f && inp.x < wh.x && inp.y >= 0.0f && inp.y < wh.y) ? 1.0f : 0.0f;
	return val;
} 

float4 PS_FreeView(VS_TO_PS_ScreenQuad In) : SV_TARGET
{
	// scale the incoming uvs to reflect a smaller than full raster viewport
	float2 vpScale = gSourceSizePixels.xy / gViewportSizePixels.xy;
	float2 UV = (In.UV * gUVTransform.zw + gUVTransform.xy) * vpScale;
	
	// how much do we scale the sources to fit the given viewport
	float sourceScale = (gScreenSize[0] - gBorderSizePixels) / (2.0f * gSourceSizePixels.x);
	// find width & height in UV space
	float2 wh = sourceScale * gSourceSizePixels / gScreenSize; 
	// find L0, R0 & B0 in UV space. they are the origins of the left eye vp, the right eye vp & the border rectangle
	float2 L0 = float2( 0, (1.0f - wh.y)/2.0 );
	float2 R0 = float2( wh.x + gBorderSizePixels/gScreenSize[0], L0.y );
	float2 B0 = float2( 0, L0.y - gBorderSizePixels/gScreenSize[1] );

	float2 Luv = UV - L0;
	float2 Ruv = UV - R0;

	float xL = inRect( Luv, wh );
	float xR = inRect( Ruv, wh );
	float xB = (1.0f-xL) * (1.0f-xR) * inRect( UV - B0, float2( 1.0f, 1.0f-2.0f*B0.y ) );

	float4 leftEye = gSourceTex.Sample(gSourceSamp, Luv/(wh*vpScale) );
	float4 rightEye = gSourceTex2.Sample(gSourceSamp2, Ruv/(wh*vpScale) );

	float4 result = (1.0f - (xB+xR+xL))*gBackgroundColor + xB * gBorderColor + xR * rightEye + xL * leftEye;
	return result;
}


technique10 Main
{
    pass p0
    {
		SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_FreeView()));
    }
}

