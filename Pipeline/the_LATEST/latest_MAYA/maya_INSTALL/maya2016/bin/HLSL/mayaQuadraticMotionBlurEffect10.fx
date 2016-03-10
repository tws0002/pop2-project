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
// Compiled Fragment: mayaQuadraticMotionBlur
//

////////////////////// 
// mayaQuadraticMotionBlur_VS

struct vertexInS 
{ 
    float3 Pm : POSITION; 
    float2 U0 : TEXCOORD0; 
}; 
 
//  Declarations 
struct vertexOutS 
{ 
    float4 Pc : POSITION; 
    float3 U0 : TEXCOORD0; 
}; 
 

struct fragInS 
{ 
    float4 Pc : POSITION; 
    float3 U0 : TEXCOORD0; 
}; 
 

//  Globals 
uniform float DepthPriority : depthpriority; 
uniform float4x4 WorldViewProj : worldviewprojection; 

//  Fragments 
float4 iPcPriority( float3 pm, float depthPriority, float4x4 worldViewProjection )
{ 
    float4 P = mul( float4(pm,1), worldViewProjectionC ); 
    P.z -= P.w * depthPriority; 
    return P; 
} 

float3 iU0( float2 uv )
{ 
    return float3(uv,0); 
} 


 // Vertex Shader 
 vertexOutS mayaQuadraticMotionBlur_VS( vertexInS inputs ) 
 { 

     // ShaderBody 
    vertexOutS s_fragInS8644; 
    s_fragInS8644.Pc = iPcPriority ( inputs.Pm, DepthPriority, WorldViewProj ); 
    s_fragInS8644.U0 = iU0( inputs.U0 ); 

    return s_fragInS8644; 
 } 

////////////////////// 
// mayaQuadraticMotionBlur


//  Globals 
Texture2D currentScene; 
sampler   currentSceneSampler; 

Texture2D currentVelocity; 
sampler   currentVelocitySampler; 

Texture2D previousScene; 
sampler   previousSceneSampler;
 
Texture2D previousVelocity; 
sampler   previousVelocitySampler;

uniform float	shutterOpenFraction = 1.000000; 
uniform float	zThreshold = 0.100000; 
uniform int		blurStepCount = 16; 
uniform float	motionFadeAmt = 0.0; 
uniform float	motionFadeEmphasis = 0.0; 
uniform float4	motionFadeTint = (float4)1; 


//  Fragments 
float3 U0( float3 iUV0 )
{ 
    return iUV0; 
} 

float4 mayaQuadraticMotionBlur( float3 pixelUV, 
			sampler curSceneSamp, Texture2D curScene, 
			sampler curVelocitySamp, Texture2D curVel, 
			sampler prevSceneSamp, Texture2D prevScene, 
			sampler prevVelocitySamp, Texture2D prevVel, 
            float shutterOpen,  float zThreshold, int nBlurSteps, 
            float fadeAmt,  float fadeEmphasis, float4 fadeTint ) 
    { 
    // float4 V0 = tex2D( curVelocitySamp, pixelUV.xy ); 
    float4 V0 = curVel.SampleLevel( curVelocitySamp, pixelUV.xy, 0 ); // center pix, for pass thru v0.zw
    
	float4 bg = (V0.w > 0)? 
				  prevScene.SampleLevel( prevSceneSamp, pixelUV.xy, 0 )  //tex2D( prevSceneSamp, pixelUV.xy ) 
				:  curScene.SampleLevel( curSceneSamp,  pixelUV.xy, 0 ); //tex2D( curSceneSamp, pixelUV.xy ); 

	// P0 is (0,0), P1 is relative position one frame ago, P2 is position 2 frames ago
	float2 P1 = -V0.xy;
	float z0 = V0.z; 
	// dependent texture lookup gets prev velocity at previous position
	
	float4 V1 = prevVel.SampleLevel( prevVelocitySamp, pixelUV.xy + P1, 0 ); //float4 V1 = tex2D( prevVelocitySamp, pixelUV.xy + P1 ); 
	float2 P2 = P1 - V1.xy; 
	// from the 3 positions (0, P1, P2), get the coeffs of the quadratic
	float2 a, b;
	//if( V1.w > 0 )
	//{
		// coeffs of quadratic q = a*t*t + b*t + c; at t=0.5 q == P1; at t=1 q==P2;
		a = 2 * P2 - 4 * P1;
		b = 4 * P1 - P2;		
	//} else {
	//	a = (float2)0;
	//	b = 2 * P1;				// coeffs of linear q = 0*t*t + b*t + c, evaluated 0..0.5 
	//}
	// blur along the pixels motion trace on the raster
	float4 clr = (float4)0; 
	float2 q; // current value of the quadratic 
	for( int n = 0; n < nBlurSteps; ++n ) 
	{ 
		// evaluate the quadratic. 
		// we want to evaluate t=0..0.5, where q=p1; not to t=1 where q=p2
		float t = 0.5f * shutterOpen * (float)n / (float)(nBlurSteps-1);
		q = pixelUV - t * (t * a + b);
		float4 Vn = curVel.SampleLevel( curVelocitySamp, q, 0 ); // tex2D( curVelocitySamp, q );
		float4 fg = curScene.SampleLevel( curSceneSamp,  q, 0 ); // tex2D( curSceneSamp, q );

		// is the sampled pixel moving & close enough to us ?
		bool includeSample = (Vn.w > 0); // && (abs(z0-Vn.z) < zThreshold); 
		// add sample if similar else add background
		if( includeSample ) {
			clr += fg; 
		} else {
			clr += bg; 
		}
	}
    return clr / nBlurSteps; 
} 


// mayaQuadraticMotionBlur Pixel Shader 
float4 mayaQuadraticMotionBlur_PS( fragInS inputs ) : SV_Target0
{ 
     // ShaderBody 
    float3 v_U08643 = U0( inputs.U0 ); 
    float4 v_mayaQuadraticMotionBlur8641 = mayaQuadraticMotionBlur( v_U08643, 
		currentSceneSampler, currentScene, currentVelocitySampler, currentVelocity, 
		previousSceneSampler, previousScene, previousVelocitySampler, previousVelocity, 
		shutterOpenFraction, zThreshold, blurStepCount,
		motionFadeAmt, motionFadeEmphasis, motionFadeTint ); 

    return v_mayaQuadraticMotionBlur8641; 
 } 


/////////////////////// Techniques /////// 
technique10 main
{ 
    pass P0 
    { 
        SetVertexShader( CompileShader( vs_5_0, mayaQuadraticMotionBlur_VS() ));
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, mayaQuadraticMotionBlur_PS() ));
    } 
 } 
