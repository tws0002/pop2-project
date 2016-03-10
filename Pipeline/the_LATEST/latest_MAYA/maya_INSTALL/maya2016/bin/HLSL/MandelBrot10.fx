//**************************************************************************/
// Copyright 2011 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/

#include "Common10.fxh"

int gIterate <
    float UIMin = 2;
    float UIMax = 200;
    string UIName = "Iteration Count";
> = 50;

float gScale <
    string UIWidget = "slider";
    float UIMin = 0.001;
    float UIMax = 3.0;
    float UIStep = 0.001;
> = 0.423;

// float2 gCenter = {0.5,0.1};
float gCenterX <
    string UIWidget = "slider";
    string UIName = "X Center";
    float UIMin = 0.0;
    float UIMax = 1.0;
    float UIStep = 0.001;
> = 0.0f;

float gCenterY <
    string UIWidget = "slider";
    string UIName = "Y Center";
    float UIMin = 0.0;
    float UIMax = 1.0;
    float UIStep = 0.001;
> = 0.379f;

float gRange <
    string UIWidget = "slider";
    float UIMin = 0.0;
    float UIMax = 0.05;
    float UIStep = 0.001;
    string UIName = "Outer Color Gradation";
> = 0.05f;

float3 gInColor <
    string UIWidget = "Color";
    string UIName = "Inside Region";
> = {0.05,0.225,0.3};

float3 gOutColorA <
    string UIWidget = "Color";
    string UIName = "Outer Region";
> = {0.4,0.6,0.9};

float3 gOutColorB <
    string UIWidget = "Color";
    string UIName = "Edge Region";
> = {1,0.8,0.1};

/////////////////////////////////////////////////////

// Pixel shader.
// NOTE: This expects screen quad vertex shader output.
float4 PS_Mandelbrot(VS_TO_PS_ScreenQuad IN) : SV_TARGET 
{
    float2 pos = IN.UV.xy; // frac(IN.UV.xy);
    pos.y = 1 - pos.y;
    //float real = ((pos.x - 0.5)*gScale)-gCenterX;
    //float imag = ((pos.y - 0.5)*gScale)-gCenterY;
    float real = pos.x *gScale + (gCenterX);
    float imag = pos.y *gScale + (gCenterY);
    float Creal = real;
    float Cimag = imag;
    Creal = -0.765f;
    Cimag = 0.11f;
    float r2 = 0.0f;
    float i;
    for (i=0; (i<gIterate) && (r2<4.0); i++) {
		float tempreal = real;
		real = (tempreal*tempreal) - (imag*imag) + Creal;
		imag = 2.0*tempreal*imag + Cimag;
		r2 = (real*real) + (imag*imag);
    }
    float3 finalColor;
    if (r2 < 4.0f) {
       finalColor = gInColor;
    } else {
    	finalColor = lerp(gOutColorA,gOutColorB, frac(i * gRange));
    }
    return float4(finalColor,0);
}


#ifndef FX_COMPOSER

// Main technique.
technique10 Main
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_ScreenQuad()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Mandelbrot()));
    }
}

#endif