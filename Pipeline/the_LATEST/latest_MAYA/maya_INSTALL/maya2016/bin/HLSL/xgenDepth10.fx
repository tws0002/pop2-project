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
    float width : TEXCOORD0; 
    float3 curveVec : TEXCOORD1; 
    float offsetFlag : TEXCOORD2; 
};

// Vertex shader output structure.
struct VS_TO_PS
{
    // The vertex position in clip space.
    float4 HPos : SV_Position;
};

//  Globals 
extern float4x4 World : world; 
extern float3 cameraDirection : viewdirection; 
extern float3 cameraPosition : worldcameraposition; 
extern bool camIsOrtho : isorthographic; 

float3 xgenVSWidthVec(float3 Pm, float width, float3 curveVec, float4x4 world, float3 viewDirection, float3 worldCameraPosition, bool camIsOrtho)
{
    float3 viewVec = viewDirection;
    if (!camIsOrtho) {
    float3 pw = mul(float4(Pm, 1.0f), world).xyz;
        viewVec = pw - worldCameraPosition;
    }

    return normalize(cross(viewVec, curveVec)) * width;
}

float3 xgenVSOffset(float3 Pm, float offsetFlag, float3 widthVecFinal)
{
    return Pm + offsetFlag * widthVecFinal;
}

float3 xgenVSNw(float3 widthVecFinal, float3 curveVec)
{
    return normalize(cross(widthVecFinal, curveVec));
}

// Vertex shader.
VS_TO_PS VS_Depth(VS_INPUT In)
{
    VS_TO_PS Out;
    
    float3 widthVecFinal = xgenVSWidthVec( In.Pos, In.width, In.curveVec, World, cameraDirection, cameraPosition, camIsOrtho ); 
    float4 pm4 = float4(xgenVSOffset( In.Pos, In.offsetFlag, widthVecFinal ), 1.0f);

    // Transform the position from object space to clip space for output.
    Out.HPos = mul(pm4, gWVPXf);

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
