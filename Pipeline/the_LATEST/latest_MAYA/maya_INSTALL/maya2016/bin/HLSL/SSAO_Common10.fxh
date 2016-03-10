//**************************************************************************/
// Copyright (c) 2008 Autodesk, Inc.
// All rights reserved.
// 
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information written by Autodesk, Inc., and are
// protected by Federal copyright law. They may not be disclosed to third
// parties or copied or duplicated in any form, in whole or in part, without
// the prior written consent of Autodesk, Inc.
//**************************************************************************/
// DESCRIPTION: Screen space ambient occlusion - common definitions (D3D10).
// AUTHOR: Mauricio Vives
// CREATED: October 2008
//**************************************************************************/

#ifndef _SSAO_COMMON_FXH_
#define _SSAO_COMMON_FXH_

// The offset of the current tile, relative to the full image.  This is (0.0, 0.0) when not tiling.
float2 gTileOffset : TileOffset;

// The scale of the current tile, relative to the full image.  This is (1.0, 1.0) when not tiling.
float2 gTileScale : TileScale;

// Screen size, in pixels.
float2 gScreenSize : ViewportPixelSize < string UIWidget = "None"; >;
static float2 gFullScreenSize = gScreenSize / gTileScale;

// World transformation.
float4x4 gWXf : World < string UIWidget = "None"; >;

// World-view-projection transformation.
float4x4 gWVPXf : WorldViewProjection < string UIWidget = "None"; >;

// World-view transformation.
float4x4 gWVXf : WorldView < string UIWidget = "None"; >;

// World-view transformation, inverse transpose.
float4x4 gWVITXf : WorldViewInverseTranspose < string UIWidget = "None"; >;

// Projection transformation and view scale, i.e. view-space size at a distance of one.
// NOTE: This need to be the projection transformation of the scene, not the screen quad used for
// post-processing.  In general, the SSAO effect is split into multiple independent passes, so the
// "Projection" semantic is not appropriate and the value must be set manually.  For FX Composer,
// the SSAO effect is a set of *related* passes in a central technique using SAS scripting, which
// include the scene passes, so the "Projection" semantic can be used.
// NOTE: The matrix elements used here could be negative, e.g. in a right-handed coordinate system,
// so the absolute value is used to get a positive scale.
#ifdef FX_COMPOSER
float4x4 gProjection : Projection < string UIWidget = "None"; >;
#else
float4x4 gProjection < string UIWidget = "None"; >;
#endif
static float2 gViewScale = 1.0f / abs(float2(gProjection[0][0], gProjection[1][1]));

// Whether a perspective view is being used.
bool gPerspectiveFlag
<
    string UIName = "Perspective View";
> = false;

// The radius of the SSAO samples, as a fraction of the screen width.
float gSampleRadius
<
    string UIName = "Sample Radius";
    string UIWidget = "Slider";
    float UIMin = 0.0f;
    float UIMax = 0.5f;
    float UIStep = 0.05f;
> = 0.1f;

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
    float2 UVTile : TEXCOORD1;
};

// Vertex shader.
VS_TO_PS_ScreenQuad VS_ScreenQuad(VS_INPUT_ScreenQuad In)
{
    VS_TO_PS_ScreenQuad Out;
    
    // Output the position in clip space, and the texture coordinates modified by the tile offset
    // the scale.  The "UV" texture coordinates are thus relative to the *full* image, not the tile.
    // Also output the unmodified texture coordinates as "UVTile" (the tile texture coordinates).
    Out.HPos = mul(float4(In.Pos, 1.0f), gWVPXf);
    Out.UV = (In.UV * gTileScale) + gTileOffset;
    Out.UVTile = In.UV;
    
    return Out;
}

#endif //_SSAO_COMMON_FXH_