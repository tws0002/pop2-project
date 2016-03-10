//**************************************************************************/
// Copyright 2012 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/
//
// Sample shader to that can be used for shadow casting
// 
struct vertexInS 
{ 
    float3 Pm : POSITION; 
    float width : TEXCOORD0; 
    float3 curveVec : TEXCOORD1; 
    float offsetFlag : TEXCOORD2; 
}; 

//  Declarations 

struct vertOutS 
{ 
    float3 Pw : TEXCOORD1; 
    float4 Pc : SV_Position; 
}; 

//  Globals 

uniform float4x4 World : world; 
uniform float4x4 ViewProj : viewprojection; 
uniform float DepthPriority : depthpriority; 
uniform float4x4 WorldViewProj : worldviewprojection; 
uniform float3 cameraDirection; 
uniform bool camIsOrtho; 

//  Fragments 

float3 iPw( float3 pm, float4x4 world ) 
{ 
    return mul( float4(pm, 1.0f), world ).xyz; 
} 

float4 iPcPriority( float3 pm, float depthPriority, float4x4 worldViewProjectionC )
{ 
    float4 P = mul( float4(pm,1), worldViewProjectionC ); 
    P.z -= P.w * depthPriority; 
    return P; 
} 

float3 xgenVSWidthVec(float3 Pm, float width, float3 curveVec, float4x4 world, float3 viewDirection, bool camIsOrtho)
{
    float3 viewVec = viewDirection;
    if (!camIsOrtho) {
    float3 pw = mul(float4(Pm, 1.0f), world).xyz;
		// viewDirection is worldCameraPosition when camIsOrtho is false.
        viewVec = pw - viewDirection;
    }

    return normalize(cross(viewVec, curveVec)) * width;
}

float3 xgenVSOffset(float3 Pm, float offsetFlag, float3 widthVecFinal)
{
    return Pm + offsetFlag * widthVecFinal;
}

// Vertex Shader 
//
 vertOutS VS( vertexInS inputs ) 
{ 
    vertOutS vOut; 
    float3 widthVecFinal = xgenVSWidthVec( inputs.Pm, inputs.width, inputs.curveVec, World, cameraDirection, camIsOrtho ); 
    float3 pm3 = xgenVSOffset( inputs.Pm, inputs.offsetFlag, widthVecFinal ); 

    vOut.Pw = iPw( pm3, World ); 
    vOut.Pc = iPcPriority ( pm3, DepthPriority, WorldViewProj ); 

    return vOut; 
} 

struct fragInS 
{ 
    float3 Pw : TEXCOORD1; 
}; 

// Pixel Shader 
//
float4 mayaCreateShadowMapPS( float3 Pw, float4x4 shadowViewProj )
{
	float4 Pndc = mul( float4(Pw,1.0f), shadowViewProj );
	float retZ = Pndc.z / Pndc.w;
	retZ += fwidth(retZ);
	return (retZ).xxxx;
}

float4 FS( fragInS inputs ) : SV_TARGET
{
	return mayaCreateShadowMapPS( inputs.Pw, ViewProj );
} 

/////////////////////// Techniques /////// 

technique10 main
{ 
    pass P0 
    { 
        SetVertexShader( CompileShader( vs_5_0, VS() )); 
        SetGeometryShader( NULL ); 
        SetPixelShader( CompileShader( ps_5_0, FS() )); 
    } 
 }
 
