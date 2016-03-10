//**************************************************************************/
// Copyright 2013 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/

#include "Common10.fxh"

// The single filter input, i.e. the image to be filtered.
Texture2D gInputTex;

// Filter input sampler.
SamplerState gInputSampler;

// Disable alpha output.
bool gDisableAlpha;

// Flip in V
bool gVerticalFlip = false;

// Vertex shader.
VS_TO_PS_ScreenQuad VS_Copy(VS_INPUT_ScreenQuad In)
{
    VS_TO_PS_ScreenQuad Out;
    
    // Transform the position from object space to clip space for output.
    Out.HPos = mul(float4(In.Pos, 1.0f), gWVPXf);

    // Pass the texture coordinates.
    Out.UV = gVerticalFlip ? float2( In.UV[0], 1.0f - In.UV[1] ) : In.UV;
    
    return Out;
}

// Pixel shader.
float4 PS_Copy(VS_TO_PS_ScreenQuad In) : SV_Target
{
	float4 output = gInputTex.Sample(gInputSampler, In.UV.xy); 
	if(gDisableAlpha)
	{
	    return float4( output.xyz, 1.0 );
	}
	else
	{
	    return output;
	}
}

// The main technique.
technique10 Main
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_Copy()));
		SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Copy()));
    }
}
