//**************************************************************************/
// Copyright 2010 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/

#ifndef _COMMON_FXH_
#define _COMMON_FXH_

// World-view-projection transformation.
float4x4 gWVPXf : WorldViewProjection < string UIWidget = "None"; >;

// Screen size, in pixels.
float2 gScreenSize : ViewportPixelSize < string UIWidget = "None"; >;
static float2 gTexelSize = 1.0f / gScreenSize;

////////////////////////////////////////////////////////////////////////////////////////////////////
// Screen Quad Vertex Shader
////////////////////////////////////////////////////////////////////////////////////////////////////

// Vertex shader input structure.
struct VS_INPUT_ScreenQuad
{
    float3 Pos : POSITION;
    float2 UV : TEXCOORD0;
};

// Vertex shader output structure.
struct VS_TO_PS_ScreenQuad
{
    float4 HPos : SV_Position;
    float2 UV : TEXCOORD0;
};

// Vertex shader.
VS_TO_PS_ScreenQuad VS_ScreenQuad(VS_INPUT_ScreenQuad In)
{
    VS_TO_PS_ScreenQuad Out;
    
    // Output the position and texture coordinates directly.
    Out.HPos = mul(float4(In.Pos, 1.0f), gWVPXf);
    Out.UV = In.UV;
    
    return Out;
}

#endif // _COMMON_FXH_