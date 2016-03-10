//**************************************************************************/
// Copyright (c) 2012 Autodesk, Inc.
// All rights reserved.
// 
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information written by Autodesk, Inc., and are
// protected by Federal copyright law. They may not be disclosed to third
// parties or copied or duplicated in any form, in whole or in part, without
// the prior written consent of Autodesk, Inc.
//**************************************************************************/
//
// Compiled Fragment: mayaLinearMotionBlur
//

////////////////////// 
// mayaLinearMotionBlur_VS

struct vertexInS 
{ 
    float3 Pm : POSITION; 
    float2 u0 : TEXCOORD0;
}; 
 
//  Declarations 
struct vertexOutS 
{ 
    float4 Pc : POSITION; 
    float3 u0 : TEXCOORD0;
}; 
 

struct fragInS 
{ 
    float4 Pc : POSITION; 
    float3 u0 : TEXCOORD0;
}; 
 

//  Globals 
uniform float4x4 WorldViewProj : worldviewprojection; 

//  Fragments 
float4 iPcQuad( float3 pm, float4x4 worldViewProjection )
{ 
	float4 Pc = mul(float4(pm, 1.0f), worldViewProjection);
	return Pc;
} 

float3 iU0( float2 u0 )
{ 
    return float3(u0, 0); 
} 

 // Vertex Shader 
 vertexOutS mayaLinearMotionBlur_VS( vertexInS inputs ) 
 { 
     // ShaderBody 
    vertexOutS s_fragInS1641; 
    s_fragInS1641.Pc = iPcQuad ( inputs.Pm, WorldViewProj ); 
    s_fragInS1641.u0 = iU0 ( inputs.u0 ); 

    return s_fragInS1641; 
 } 

////////////////////////////////////////////////////////////////////////////////// 
// mayaLinearMotionBlur pixel shader

//  Globals 
Texture2D currentScene; 
sampler   currentSceneSampler; 

Texture2D currentVelocity; 
sampler   currentVelocitySampler; 

Texture2D previousScene; 
sampler   previousSceneSampler;
 
uniform float	shutterOpenFraction = 1.000000; 
uniform float	zThreshold = 0.100000; 
uniform int		blurStepCount = 16; 
uniform float	motionFadeAmt = 0.0; 
uniform float	motionFadeEmphasis = 0.0; 
uniform float4	motionFadeTint = (float4)1; 

//  Fragments 

float4 mayaLinearMotionBlur( float3 pixelUV, 
			sampler curSceneSamp, Texture2D curScene, 
			sampler curVelocitySamp, Texture2D curVel, 
			sampler prevSceneSamp, Texture2D prevScene, 
            float shutterOpen,  float zThreshold, int nBlurSteps, 
            float fadeAmt,  float fadeEmphasis, float4 fadeTint ) 
{ 
    float4 V0 = curVel.SampleLevel( curVelocitySamp, pixelUV.xy, 0 ); // center pix, for pass thru v0.zw
	float4 bg = (V0.w > 0)? 
				  prevScene.SampleLevel( prevSceneSamp, pixelUV.xy, 0 )  //tex2D( prevSceneSamp, pixelUV.xy ) 
				:  curScene.SampleLevel( curSceneSamp,  pixelUV.xy, 0 ); //tex2D( curSceneSamp, pixelUV.xy ); 

	float z0 = V0.z; 
	float2 dUV = V0.xy * shutterOpen / (float)nBlurSteps; 
    float4 clr = (float4)0; 
    for( int n = 0; n < nBlurSteps; ++n ) 
    { 
        float2 sampleUV = pixelUV.xy + n * dUV; 
   		float4 Vn = curVel.SampleLevel( curVelocitySamp, sampleUV, 0 ); // tex2D( curVelocitySamp, sampleUV );
		float4 fg = curScene.SampleLevel( curSceneSamp,  sampleUV, 0 ); // tex2D( curSceneSamp, sampleUV );

		bool includeSample = (Vn.w > 0); // && (abs(z0-Vn.z) < zThreshold); 
        clr += includeSample ? fg : bg; 
    } 
    return clr / (float)nBlurSteps; 
} 


 // Pixel Shader 
 float4 mayaLinearMotionBlur_PS( fragInS inputs ) : SV_Target0
{ 
    // ShaderBody 
    float4 v_mayaLinearMotionBlur1639 = mayaLinearMotionBlur( inputs.u0, 
				currentSceneSampler, currentScene,
				currentVelocitySampler, currentVelocity, 
				previousSceneSampler, previousScene,  
				shutterOpenFraction, zThreshold, blurStepCount,
				motionFadeAmt, motionFadeEmphasis, motionFadeTint ); 

    return v_mayaLinearMotionBlur1639; 
 } 


/////////////////////// Techniques /////// 
technique10 main
{ 
    pass P0 
    { 
        SetVertexShader( CompileShader( vs_5_0, mayaLinearMotionBlur_VS() ));
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, mayaLinearMotionBlur_PS() ));
    } 
 } 
