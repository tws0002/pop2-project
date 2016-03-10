//**************************************************************************/
// Copyright 2012 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/
//
// Sample shader useful for rendering a "depth" pass.
//

// World transformation.
float4x4 gWXf : World < string UIWidget = "None"; >;

// World-View-projection transformation.
float4x4 gWVPXf : WorldViewProjection < string UIWidget = "None"; >;

// Depth priority, which shifts the model a bit forward in the z-buffer
float gDepthPriority : DepthPriority
<
    string UIName =  "Depth Priority";
    string UIWidget = "Slider";
    float UIMin = -16/1048576.0f;    // divide by 2^24/16 by default
    float UIMax = 16/1048576.0f;
    float UIStep = 1/1048576.0f;
> = 0.0f;

// Vertex shader input structure.
struct VS_INPUT
{
    float3 Pos : POSITION;
};

// Vertex shader output structure.
struct VS_TO_PS
{
    // The vertex position in clip space.
    float4 HPos : SV_Position;
};

// Vertex shader.
VS_TO_PS VS_Depth(VS_INPUT In)
{
    VS_TO_PS Out;
    
    float4 HPm = float4(In.Pos, 1.0f);

    // Transform the position from object space to clip space for output.
    Out.HPos = mul(HPm, gWVPXf);

    // modify the HPos a bit by biasing the Z a bit forward, based on depth priority
    Out.HPos.z -= Out.HPos.w*gDepthPriority;

    return Out;
}

float4 PS_Depth(VS_TO_PS In) : SV_Target
{
    return float4(0.0f, 0.0f, 0.0f, 0.0f);
}

technique10 Main
{
    pass P0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_Depth()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Depth()));
    }
}
