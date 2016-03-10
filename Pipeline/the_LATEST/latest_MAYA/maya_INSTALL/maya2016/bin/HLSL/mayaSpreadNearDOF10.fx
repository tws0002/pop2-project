//**************************************************************************/
// Copyright (c) 2010 Autodesk, Inc.
// All rights reserved.
// 
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information written by Autodesk, Inc., and are
// protected by Federal copyright law. They may not be disclosed to third
// parties or copied or duplicated in any form, in whole or in part, without
// the prior written consent of Autodesk, Inc.
//**************************************************************************/
// DESCRIPTION:  Spread the influence of DOF to neighboring pixels.
// AUTHOR:  Kells Elmquist
// CREATED: November 2010
//**************************************************************************/

#include "Common10.fxh"    

/////////////////////////////////////////////////////////////////////////////
//
//	Spread DOF vectors to affected pixels
//
// The  source image texure
uniform Texture2D source;
uniform sampler sourceSamp;

uniform Texture2D cocDepth;
uniform sampler cocDepthSamp;

uniform int searchRadius = 8;   // in pixels, radius 4 = 9x9 samples; 8 = 17x17; side=2*radius+1
uniform float2 searchDirection;	// (0,1) for V pass or (1,0) for H pass
uniform int sampleSpacing = 1;	// stride between pixel samples in motion spreading, 2x2 default


// filter kernel, return value of kernel of radius r at a distance x from the filter center
// both x & r must be positive
float filter( float r, float x, float widthInv )
{
	//// box filter
	// return 1.0f;

	// test for sharp
	if( r <= 0.00001f ) r = 0.00001f;

	// unit linear (triangle) kernel
	//return saturate( 1.0f - x/r );

	// normalized linear (triangle) kernel: 1/(r*w) * (1 - x/r)
	float h = ( widthInv / r );
	return saturate( h * (1.0f - x/r) );

	// unit gaussian kernel
	//return 0.79788f * exp( -x*x/(0.375 * r*r) ) / r;
}

// Pixel shader.
// NOTE: This expects screen quad vertex shader output.
float4 spreadNearDOFBlur( VS_TO_PS_ScreenQuad In ) : SV_Target0
{
    // Compute the offset between samples in uv space
    float2 offset = searchDirection * gTexelSize;
	// size of one pixel in the search direction in uv space
	float pixelInv = dot( offset, (float2)1 );
    offset *= (float)sampleSpacing;
    
	// center pixel
    float4 c0 = cocDepth.SampleLevel( cocDepthSamp, In.UV, 0 ); 

	//c0.x = min( abs( c0.x ), maxCoc );
	float coc0 = abs( c0.x );

	// get start uv, clr & weight sums
    float2 UV = In.UV - offset * searchRadius;
    float4 clrSum = (float4)0;

    // collect each qualified sample point, then weight & average them
    for (int i = 0; i < (2*searchRadius+1); i++)
    {
        float4 cn = cocDepth.SampleLevel( cocDepthSamp, UV, 0 ); 

		// fixup the coc for bgnd pixels, buffer is cleared to 10e6
		//if( cn.y > 999990 )
		//	cn.x = cocAtInfinity;

		//float coc = min( abs( cn.x ), maxCoc );
		float coc = abs( cn.x );
        float d = dot( UV - In.UV, (float2)1 );	// H or V distance from center to sample in uv space

		// qualify samples by z, note z is stored in y field of float2
        // & see if coc's overlap
        if( ( coc > d )
		 && (  cn.x <= -0.001f ) // in near out-of-focus zone only
        ){
			// yes, coc of sample overlaps this pixel, get it's weight & add it
			float w = filter( coc, d, pixelInv );
			clrSum += w * source.SampleLevel( sourceSamp, UV, 0 );
 		}	
		
        // Increment the texture coordinates by the offset.
        UV += offset;
	}
  //  if( wSum != 0.0f )
		//clrSum.xyz /= wSum;
		
    return  clrSum; //* hits / (float)(2*searchRadius+1); 
}

// shader for either pass of the 2 pass h/v spreading technique.
technique10 spreadNearDOFPass
{
    pass p0
    {
        SetVertexShader( CompileShader( vs_5_0, VS_ScreenQuad() ));
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, spreadNearDOFBlur() ));
    }
}
    

