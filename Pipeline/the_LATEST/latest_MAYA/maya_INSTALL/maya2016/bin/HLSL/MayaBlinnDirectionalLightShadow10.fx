//**************************************************************************/
// Copyright 2011 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/
//
// Maya Blinn (hlsl)
//

// Vertex input structure
struct vertexInS 
{ 
    float3 Pm : POSITION; 
    float3 Nm : NORMAL; 
}; 

// Vertex output structure
struct vertOutS 
{ 
    float3 Nw : TEXCOORD0; 
    float3 Pw : TEXCOORD1; 
    float3 Vw : TEXCOORD2; 
    float4 Pc : SV_Position; 
}; 

 
//  Globals 
extern float4x4 WorldIT : worldinversetranspose; 
extern float4x4 World : world; 
extern float3 cameraPosition : worldcameraposition; 
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

float3 iVw( float3 Pm, float3 Ew, float4x4 world  )
{ 
    float4 Pw = mul( float4(Pm,1), world ); 
    return Ew - Pw.xyz; 
} 

float4 iPcPriority( float3 pm, float depthPriority, float4x4 worldViewProjection )
{ 
    float4 P = mul( float4(pm,1), worldViewProjection ); 
    P.z -= P.w * depthPriority; 
    return P; 
} 

// Vertex Shader 
vertOutS MainVertexShader( vertexInS inputs ) 
{ 
    vertOutS s_vertOut; 
    s_vertOut.Nw = iNw( inputs.Nm, WorldIT ); 
    s_vertOut.Pw = iPw( inputs.Pm, World ); 
    s_vertOut.Vw = iVw( inputs.Pm, cameraPosition, World ); 
    s_vertOut.Pc = iPcPriority ( inputs.Pm, DepthPriority, WorldViewProj ); 
    return s_vertOut; 
} 

////////////////////// 
// Pixel shader 
//
struct fragInS 
{ 
    float3 Nw : TEXCOORD0; 
    float3 Pw : TEXCOORD1; 
    float3 Vw : TEXCOORD2; 
    bool isFrontFace : SV_IsFrontFace; 
}; 

//  Declarations 
struct irradiance { 
	float3 diffuseI; 
	float3 specularI; 
	float3 Ld; 
	float3 Ls; 
}; 

struct mayaSurfaceShaderOutput {
	float3 outColor;
	float3 outTransparency;
	float3 outGlowColor;
	float3 outMatteOpacity;
	float outAlphaPassThrough;
};

//  Globals 

extern float mayaNormalMultiplier = 1.000000; 
extern float mayaDirectionalLight_lightOn = 1.000000; 
extern float mayaDirectionalLight_intensity = 1.000000; 
extern float3 mayaDirectionalLight_color = { 1.000000, 1.000000, 1.000000 }; 
extern float mayaDirectionalLight_emitsDiffuse = 1.000000; 
extern float mayaDirectionalLight_emitsSpecular = 1.000000; 
extern float3 mayaDirectionalLight_direction = { 0.004568, -0.332722, -0.943014 }; 
extern Texture2D mayaShadowPCF1_shadowMap; 
extern sampler shadowSamp; 
extern float mayaShadowPCF1_shadowBias = 0.002200; 
extern int mayaShadowPCF1_shadowMapSize = 512; 
extern float4x4 mayaShadowPCF1_shadowViewProj; 
extern float3 mayaShadowPCF1_shadowColor = { 0.000000, 0.000000, 0.000000 }; 
extern bool mayaShadowPCF1_mayaGlobalShadowOn = 0; 
extern bool mayaShadowPCF1_mayaShadowOn = 0; 

extern float blinn1eccentricity = 0.300000; 
extern float blinn1specularRollOff = 0.700000; 
extern float blinn1translucence = 0.000000; 
extern float blinn1translucenceDepth = 0.500000; 
extern float blinn1translucenceFocus = 0.500000; 
uniform float3 blinn1color = { 0.200000, 0.600000, 1.000000 }; 
extern float3 blinn1transparency = { 0.000000, 0.000000, 0.000000 }; 
extern float3 blinn1ambientColor = { 0.000000, 0.000000, 0.000000 }; 
extern float3 blinn1incandescence = { 0.000000, 0.000000, 0.000000 }; 
extern float blinn1diffuse = 0.800000; 
uniform float3 blinn1specularColor = { 1.000000, 1.000000, 1.000000 }; 
extern float blinn1reflectivity = 0.500000; 
extern float3 blinn1reflectedColor = { 0.000000, 0.000000, 0.000000 }; 
extern float blinn1glowIntensity = 0.000000; 
extern bool blinn1hideSource = 0; 
extern float blinn1matteOpacity = 1.000000; 
extern int blinn1matteOpacityMode = 2; 
extern float blinn1outAlphaPassThrough = 1.000000; 
extern float extraOpacity = 1.000000; 

extern float3 ambientShader_ambientIllum = { 0.000000, 0.000000, 0.000000 }; 
extern float specularRollOff = 0.700000; 


//  Pixel Shader Fragments 

float3 Nw( float3 iNw )
{ 
    return normalize( iNw ); 
} 

bool isFrontFace( bool facing )
{ 
    return facing; 
} 

float FacingFactor( bool facing )
{ 
    return (facing == true) ? -1.0 : 1.0; 
} 

bool mayaIsBackFacing(float facingFactor) 
{ 
	return (facingFactor > 0.0f); 
} 

float3 mayaNormalFlip(float3 Nw, bool backFacing, float normalMultiplier) 
{ 
	return normalMultiplier * (backFacing ? -Nw : Nw); 
} 

float3 mayaNwPassThrough(float3 Nw) 
{ 
	return Nw; 
} 

irradiance mayaDirectionalLight( float lightOn, float intensity, float3 color, 
           float emitDiff, float emitSpec, float3 direction )
{ 
    float3 c = lightOn * intensity * color; 
    irradiance irrad; 
    irrad.diffuseI = emitDiff * c; 
    irrad.specularI = emitSpec * c;    
    irrad.Ls = irrad.Ld = normalize( -direction ); 
    return irrad; 
} 

float3 Pw( float3 ipw )
{ 
    return ipw; 
} 

irradiance mayaShadowPCF1( irradiance irradIn, texture2D shadowMap, sampler shadowSamp, 
                    float3 Pw, float bias, int shadowMapSize, 
                    float4x4 shadowViewProj, float3 shadowColor, bool globalShadowOn, bool shadowOn ) 
{ 
	if ( !( globalShadowOn && shadowOn ) ) return irradIn; 

   const float3 avgXYZ = float3(0.3333,0.3334,0.3333); // dot with this for average 
   float lightGain = 1.0f; // 1 is all light, 0 is all shadow 
   float4 Pndc = mul( float4(Pw,1.0f), shadowViewProj ); 
   Pndc.xyz /= Pndc.w; 

   if ( Pndc.x > -1.0f && Pndc.x < 1.0f && Pndc.y  > -1.0f   
     && Pndc.y <  1.0f && Pndc.z >  0.0f && Pndc.z <  1.0f ) 
   { 
        float2 uv = 0.5f * Pndc.xy + 0.5f; 
        uv.y = 1.0f - uv.y; 
        float z = Pndc.z - bias / Pndc.w; 
        float val = z - shadowMap.Sample(shadowSamp, uv ).x;  
        lightGain = (val >= 0.0f)? 0.0f : 1.0f;  
   } 

   float dIntens = saturate(dot(irradIn.diffuseI, avgXYZ)); 
   irradIn.diffuseI = lerp( dIntens * shadowColor, irradIn.diffuseI, lightGain ); 
   irradIn.specularI = irradIn.specularI * lightGain; 
   return irradIn; 
} 


float3 Vw( float3 iVw )
{ 
    return normalize( iVw ); 
} 

float3 mayaHVector(float3 L, float3 V) 
{ 
	return normalize(L + V); 
} 

float4 mayaShaderGeom(float3 N, float3 L, float3 V, float3 H) 
{ 
	float NL = saturate(dot(N, L)); 
	float NV = saturate(dot(N, V)); 
	float NH = saturate(dot(N, H)); 
	float VH = saturate(dot(V, H)); 
	return float4(NL, NV, NH, VH); 
} 

float3 mayaLambertDiffuse(float4 NL_NV_NH_VH, float3 diffuseI) 
{ 
	return NL_NV_NH_VH.x * diffuseI; 
} 

float3 mayaBlinnSpecular(
	float3 specularI, 
	float4 NL_NV_NH_VH, 
	float ecc, 
	float rolloff) 
{ 
	float ecc2 = ecc * ecc - 1.0f; 
	float NH = NL_NV_NH_VH.z; 
	float d = (ecc2 + 1.0f) / (1.0f + ecc2 * NH * NH); 
	d *= d; 
	float NL = NL_NV_NH_VH.x; 
	float NV = NL_NV_NH_VH.y; 
	float VH = NL_NV_NH_VH.w; 
	NH *= 2.0f; 
	float g = 1.0f; 

	if (NV < NL) 
		g = (NV * NH < VH) ? NH / VH : 1.0f / NV; 
	else 
		g = (NL * NH < VH) ? (NL * NH) / (VH * NV) : 1.0f / NV; 

	float k = 1.0f - VH; 
	k = k * k * k; 
	float f = k + (1.0f - k) * rolloff; 
	return specularI * saturate(d * g * f); 
} 

float mayaTranslucence(
	float4 NL_NV_NH_VH, 
	float translucence, 
	float depth, 
	float focus) 
{ 
	const float TRANSL_FADE = 0.15f; 
	const float TRANSL_ANGLE_FAC = -11.5f; 
	float bright = 0.0f; 
	float cosMinAngle = TRANSL_ANGLE_FAC * depth; 
	if (translucence != 0.0f && NL_NV_NH_VH.x > cosMinAngle) {  
		if (focus == 0.0f) { 
			bright = translucence; 
		} else { 
			float VL = saturate(NL_NV_NH_VH.w * NL_NV_NH_VH.w);  
			bright =  translucence * pow(VL,  focus /(1.00001f - focus));  
		} 
		float fade = saturate(TRANSL_FADE - cosMinAngle); 
		if (NL_NV_NH_VH.x < (fade + cosMinAngle)) { 
			bright *= (NL_NV_NH_VH.x - cosMinAngle) / fade; 
		} 
	}  
	return bright;  
} 

float3 ambientShader( float3 color )
{ 
    return color; 
} 

float mayaBlinnReflectionRolloff(
	float4 NL_NV_NH_VH, 
	float reflectance, 
	float rolloff) 
{ 
	float nv3 = 1.0f - NL_NV_NH_VH.y; 
	nv3 = nv3 * nv3 * nv3; 
	float r = saturate(reflectance); 
	r *= nv3 + (1.0f - nv3) * rolloff; 
	return r; 
} 

mayaSurfaceShaderOutput mayaADSRCombiner(
	float3 diffuseIrradIn, 
	float3 specularIrradIn, 
	float translucenceIn, 
	float3 color, 
	float3 transparency, 
	float3 ambientColor, 
	float3 ambientIn, 
	float3 incandescence, 
	float diffuse, 
	float3 specularColor, 
	float reflectivity, 
	float3 reflectedColor, 
	float glowIntensity, 
	bool hideSource, 
	float matteOpacity, 
	int matteOpacityMode, 
	float outAlphaPassThrough) 
{ 
	mayaSurfaceShaderOutput result; 

	result.outColor = (ambientColor+ambientIn) * color; 
	result.outColor += (diffuse + translucenceIn) * diffuseIrradIn * color; 
	result.outColor *= saturate(1.0f - transparency); 
	result.outColor += specularIrradIn * specularColor; 
	result.outColor += incandescence; 
	result.outColor += reflectivity * reflectedColor; 
	result.outTransparency = transparency; 
	result.outGlowColor = glowIntensity * result.outColor; 

	if (hideSource) { 
		result.outColor = float3(0.0f, 0.0f, 0.0f); 
		result.outTransparency = float3(1.0f, 1.0f, 1.0f); 
	} 

	if (matteOpacityMode == 0) { 
		result.outMatteOpacity = float3(-1.0e+06f, -1.0e+06f, -1.0e+06f); 
	} else if (matteOpacityMode == 1) { 
		result.outMatteOpacity = float3(matteOpacity, matteOpacity, matteOpacity); 
	} else { 
		result.outMatteOpacity = (1.0f - result.outTransparency) * matteOpacity; 
	} 

	result.outAlphaPassThrough = outAlphaPassThrough; 
	return result; 
} 


float4 mayaSurfaceToFloat4(
	mayaSurfaceShaderOutput input, 
	float extraOpacity) 
{ 
	const float3 intenseVec = { 0.3333, 0.3333, 0.3333 }; 
	float3 opacity = saturate(1.0f - input.outTransparency); 
	float cutoutA = input.outAlphaPassThrough * extraOpacity; 
	return float4(cutoutA*input.outColor, cutoutA*dot(opacity, intenseVec)); 
} 

// Pixel Shader 
//
float4 MainPixelShader( fragInS inputs ) : SV_Target
{ 
    mayaSurfaceShaderOutput s_mayaSurfaceShaderOutput; 

	float3 v_Nw = Nw( inputs.Nw ); 
    bool v_isFrontFace = isFrontFace( inputs.isFrontFace ); 
    float v_facingFactor = FacingFactor( v_isFrontFace ); 
    bool v_mayaIsBackFacing = mayaIsBackFacing( v_facingFactor ); 
    float3 v_mayaNormalFlip = mayaNormalFlip( v_Nw, v_mayaIsBackFacing, mayaNormalMultiplier ); 
    float3 v_mayaNwPassThrough = mayaNwPassThrough( v_mayaNormalFlip ); 
    irradiance s_mayaIrradiance; 
    irradiance v_mayaDirectionalLight = mayaDirectionalLight( mayaDirectionalLight_lightOn, mayaDirectionalLight_intensity, mayaDirectionalLight_color, mayaDirectionalLight_emitsDiffuse, mayaDirectionalLight_emitsSpecular, mayaDirectionalLight_direction ); 
    float3 v_Pw = Pw( inputs.Pw ); 
    s_mayaIrradiance = mayaShadowPCF1( v_mayaDirectionalLight, mayaShadowPCF1_shadowMap, shadowSamp, v_Pw, mayaShadowPCF1_shadowBias, mayaShadowPCF1_shadowMapSize, mayaShadowPCF1_shadowViewProj, mayaShadowPCF1_shadowColor, mayaShadowPCF1_mayaGlobalShadowOn, mayaShadowPCF1_mayaShadowOn ); 
    float3 v_Vw = Vw( inputs.Vw ); 
    float3 v_mayaHVector = mayaHVector( s_mayaIrradiance.Ls, v_Vw ); 
    float4 v_mayaShaderGeom = mayaShaderGeom( v_mayaNwPassThrough, s_mayaIrradiance.Ld, v_Vw, v_mayaHVector ); 
    float3 v_mayaLambertDiffuse = mayaLambertDiffuse( v_mayaShaderGeom, s_mayaIrradiance.diffuseI ); 
    float3 v_mayaBlinnSpecular = mayaBlinnSpecular( s_mayaIrradiance.specularI, v_mayaShaderGeom, blinn1eccentricity, blinn1specularRollOff ); 
    float v_mayaTranslucence = mayaTranslucence( v_mayaShaderGeom, blinn1translucence, blinn1translucenceDepth, blinn1translucenceFocus ); 
    float3 v_ambientShader = ambientShader( ambientShader_ambientIllum ); 
    float v_mayaBlinnReflectionRolloff = mayaBlinnReflectionRolloff( v_mayaShaderGeom, blinn1reflectivity, specularRollOff ); 
    s_mayaSurfaceShaderOutput = mayaADSRCombiner( v_mayaLambertDiffuse, v_mayaBlinnSpecular, v_mayaTranslucence, blinn1color, blinn1transparency, blinn1ambientColor, v_ambientShader, blinn1incandescence, blinn1diffuse, blinn1specularColor, v_mayaBlinnReflectionRolloff, blinn1reflectedColor, blinn1glowIntensity, blinn1hideSource, blinn1matteOpacity, blinn1matteOpacityMode, blinn1outAlphaPassThrough ); 
    float4 v_mayaSurfaceToFloat4 = mayaSurfaceToFloat4( s_mayaSurfaceShaderOutput, extraOpacity ); 

    return v_mayaSurfaceToFloat4; 
} 
technique10 main
{ 
    pass P0 
    { 
        SetVertexShader( CompileShader( vs_5_0, MainVertexShader() )); 
        SetGeometryShader( NULL ); 
        SetPixelShader( CompileShader( ps_5_0, MainPixelShader() )); 
    } 
 } 
