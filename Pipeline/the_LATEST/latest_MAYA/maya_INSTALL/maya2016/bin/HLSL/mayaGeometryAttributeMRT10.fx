// Copyright 2012 Autodesk, Inc.  All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk license agreement
// provided at the time of installation or download, or which otherwise
// accompanies this software in either electronic or hard copy form.
//
// Simple shader to output some vertex attributes to different output targets
// For now will write out 2 outputs: position and normals in world space.
//

#include "Common10.fxh"

// Vertex input structure
struct VS_INPUT 
{ 
    float3 Pm : POSITION; 
    float3 Nm : NORMAL; 
}; 

// Vertex output structure
struct VS_TO_PS 
{ 
    float4 HPos : SV_Position; 
    float3 Pw : TEXCOORD0; 
    float3 Nw : TEXCOORD1; 
}; 

// Globals
extern float4x4 WorldIT : worldinversetranspose; 
extern float4x4 World : world; 
extern float DepthPriority : depthpriority; 
extern float4x4 WorldViewProj : worldviewprojection; 

//  Vertex shader fragments 
//
float3 iNw( float3 nm, float4x4 worldIT )
{ 
     return mul( float4(nm,0), worldIT ).xyz; 
} 

float3 iPw( float3 pm, float4x4 world ) 
{ 
    return mul( float4(pm,1), world).xyz; 
} 

float4 iPcPriority( float3 pm, float depthPriority, float4x4 worldViewProjection )
{ 
    float4 P = mul( float4(pm,1), worldViewProjection ); 
    P.z -= P.w * depthPriority; 
    return P; 
} 

VS_TO_PS VS_GeometryAttributes(VS_INPUT inputs)
{
	VS_TO_PS vertexOutput; 
    vertexOutput.Nw = iNw( inputs.Nm, WorldIT ); 
    vertexOutput.Pw = iPw( inputs.Pm, World ); 
	vertexOutput.HPos = iPcPriority ( inputs.Pm, DepthPriority, WorldViewProj ); 
    return vertexOutput;     
}

// Pixel shader output structure.
struct PS_OUT
{
    float4 Position : SV_Target0;
    float4 Normal  : SV_Target1;
};

// Pixel shader
PS_OUT PS_GeometryAttributes(VS_TO_PS inputs)
{
    PS_OUT Out;
    Out.Position = float4( inputs.Pw, 1.0f);
    Out.Normal = float4((normalize(inputs.Nw) + 1.0f) * 0.5f, 1.0f);
    return Out;
}

// Technique.
technique10 Main
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_GeometryAttributes()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_GeometryAttributes()));
    }
}
