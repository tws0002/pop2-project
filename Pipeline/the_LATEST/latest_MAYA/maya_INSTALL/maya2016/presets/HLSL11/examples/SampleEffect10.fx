//**************************************************************************/
// Copyright 2014 Autodesk, Inc.  
// All rights reserved.
// Use of this software is subject to the terms of the Autodesk license 
// agreement provided at the time of installation or download, or which 
// otherwise accompanies this software in either electronic or hard copy form.   
//**************************************************************************/


#define PI 3.14



// World-View-projection transformation.
float4x4 gWVPXf : WorldViewProjection < string UIWidget = "None"; >;
float4x4 viewInv: ViewInverse < string UIWidget = "None"; >; 
float4x4 world 	: World 	< string UIWidget = "None"; >;

float Tmh : Time < string UIWidget = "None"; > = 2.1;

// Vertex shader input structure.
struct VS_INPUT
{
    float3 Pos : POSITION;
	
	float2 texCoord0	: TEXCOORD0; 
	
	float3 normal   	: NORMAL;
	float3 tangent 	    : TANGENT; 
};

// Vertex shader output structure.
struct VS_TO_PS
{
    // The vertex position in clip space.
    float4 HPos : SV_Position;
	
	float2 texCoord0	: TEXCOORD0; 
	
	float3 worldNormal   	: NORMAL;
	float4 worldTangent 	: TANGENT; 
	
	float3 worldPosition : TEXCOORD3;
	float4 amCol : COLOR;
};


float WaveAmplitude <
 string UIName = "Wave Amplitude"; 
 > = 3.0f;

 float TransparencyStd <
 string UIName = "Liquid Transparency"; 
 > = 0.0f;
 
 float texScale <
 string UIName = "Height map scale factor"; 
 > = 0.1f;
 
 float waterSpeed  <
 string UIName = "Water speed"; 
 > = 0.02f;
 
float3 DiffuseColor : Diffuse
<
	string UIGroup = "Diffuse";
	string UIName = "Diffuse Color";
	string UIWidget = "ColorPicker";
	int UIOrder = 203;
> = {0.0f, 0.5f, 1.0f };

Texture2D gHeightMap  <
    string ResourceName = "SeaHeightMap.jpg";
    string ResourceType = "2D";
    string UIName = "Sea Height Map";
	int mipmaplevels = 0;
>;

Texture2D gSeaNormalMap  <
    string ResourceName = "SeaNormalMap.jpg";
    string ResourceType = "2D";
    string UIName = "Sea Normal Map";
	int mipmaplevels = 0;
>;



SamplerState SamplerAnisoWrap
{
	Filter = ANISOTROPIC;
	AddressU = Wrap;
	AddressV = Wrap;
};

//------------------------------------
// Shadow Maps
//------------------------------------
Texture2D light0ShadowMap : SHADOWMAP
<
	string Object = "Light 0";	// UI Group for lights, auto-closed
	string UIWidget = "None";
	int UIOrder = 5010;
>;

//------------------------------------
// Lighting
//------------------------------------
float rimFresnelMin
<
	string UIGroup = "Lighting";
	string UIWidget = "Slider";
	float UIMin = 0.0;
	float UIMax = 1.0;
	float UIStep = 0.001;
	string UIName = "Rim Light Min";
	int UIOrder = 60;
> = 0.8;

float rimFresnelMax
<
	string UIGroup = "Lighting";
	string UIWidget = "Slider";
	float UIMin = 0.0;
	float UIMax = 1.0;
	float UIStep = 0.001;
	string UIName = "Rim Light Max";
	int UIOrder = 61;
> = 1.0;

float rimBrightness
<
	string UIGroup = "Lighting";
	string UIWidget = "Slider";
	float UIMin = 0.0;
	float UISoftMax = 10.0;
	float UIMax = 100000.0;
	float UIStep = 0.001;
	string UIName = "Rim Light Brightness";
	int UIOrder = 62;
> = 0.0;

float3 SpecularColor : Specular
<
	string UIGroup = "Specular";
	string UIName = "Specular Color";
	string UIWidget = "ColorPicker";
	int UIOrder = 404;
> = {1.0f, 1.0f, 1.0f };

float SpecPower
<
	string UIGroup = "Specular";
	string UIWidget = "Slider";
	float UIMin = 0.0;	// 0 for anisotropic
	float UISoftMax = 100.0;
	float UIMax = 1000000;
	float UIStep = 0.01;
	string UIName = "Specular Power";
	int UIOrder = 405;
> = 20.0;


// ---------------------------------------------
// Light 0 GROUP
// ---------------------------------------------
// This value is controlled by Maya to tell us if a light should be calculated
// For example the artist may disable a light in the scene, or choose to see only the selected light
// This flag allows Maya to tell our shader not to contribute this light into the lighting
bool light0Enable : LIGHTENABLE
<
	string Object = "Light 0";	// UI Group for lights, auto-closed
	string UIName = "Enable Light 0";
	int UIOrder = 20;
	> = false;	// maya manages lights itself and defaults to no lights


// follows LightParameterInfo::ELightType
// spot = 2, point = 3, directional = 4, ambient = 5,
int light0Type : LIGHTTYPE
<
	string Object = "Light 0";
	string UIName = "Light 0 Type";
	string UIFieldNames ="None:Default:Spot:Point:Directional:Ambient";
	int UIOrder = 21;
	float UIMin = 0;
	float UIMax = 5;
	float UIStep = 1;
> = 2;	// default to spot so the cone angle etc work when "Use Shader Settings" option is used

float3 light0Pos : POSITION 
< 
	string Object = "Light 0";
	string UIName = "Light 0 Position"; 
	string Space = "World"; 
	int UIOrder = 22;
> = {100.0f, 100.0f, 100.0f}; 

float3 light0Color : LIGHTCOLOR 
<
	string Object = "Light 0";
	string UIName = "Light 0 Color"; 
	string UIWidget = "Color"; 
	int UIOrder = 23;
> = { 1.0f, 1.0f, 1.0f};

float light0Intensity : LIGHTINTENSITY 
<
		string Object = "Light 0";
		string UIName = "Light 0 Intensity"; 
		float UIMin = 0.0;
		float UIMax = 10;
		float UIStep = 0.01;
		int UIOrder = 24;
> = { 1.0f };

float3 light0Dir : DIRECTION 
< 
	string Object = "Light 0";
	string UIName = "Light 0 Direction"; 
	string Space = "World"; 
	int UIOrder = 25;
> = {100.0f, 100.0f, 100.0f}; 


float light0ConeAngle : HOTSPOT // In radians
<
	string Object = "Light 0";
	string UIName = "Light 0 Cone Angle"; 
	float UIMin = 0;
	float UIMax = PI/2;
	int UIOrder = 26;
> = { 0.46f };

float light0FallOff : FALLOFF // In radians. Sould be HIGHER then cone angle or lighted area will invert
<
	string Object = "Light 0";
	string UIName = "Light 0 Penumbra Angle"; 
	float UIMin = 0;
	float UIMax = PI/2;
	int UIOrder = 27;
> = { 0.7f };

float light0AttenScale : DECAYRATE
<
	string Object = "Light 0";
	string UIName = "Light 0 Decay";
	float UIMin = 0.0;
	float UIMax = 20.0;
	float UIStep = 0.01;
	int UIOrder = 28;
> = {0.0};

bool light0ShadowOn : SHADOWFLAG
<
	string Object = "Light 0";
	string UIName = "Light 0 Casts Shadow";
	string UIWidget = "None";
	int UIOrder = 29;		
> = true;

float4x4 light0Matrix : SHADOWMAPMATRIX		
< 
	string Object = "Light 0";
	string UIWidget = "None"; 
>;

int DiffuseModel
<
	string UIGroup = "Diffuse";
	string UIName = "Diffuse Model";
	string UIFieldNames ="Lambert:Soften Diffuse (Hair)";
	float UIMin = 0;
	float UIMax = 1;
	float UIStep = 1;
	int UIOrder = 198;
> = 0;

// Calculate a light:
struct lightOut
{
	float Specular;
	float3 Color;
};


//Functions

// Spot light cone
float lightConeangle(float coneAngle, float coneFalloff, float3 lightVec, float3 lightDir) 
{ 
	// the cone falloff should be equal or bigger then the coneAngle or the light inverts
	// this is added to make manually tweaking the spot settings easier.
	if (coneFalloff < coneAngle)
		coneFalloff = coneAngle;

	float LdotDir = dot(normalize(lightVec), lightDir); 

	// cheaper cone, no fall-off control would be:
	// float cone = pow(saturate(LdotDir), 1 / coneAngle); 

	// higher quality cone (more expensive):
	float cone = smoothstep( cos(coneFalloff), cos(coneAngle), LdotDir);

	return cone; 
} 

lightOut CalculateLight	(	bool lightEnable, int lightType, float lightAtten, float3 lightPos, float3 vertWorldPos, 
							float3 lightColor, float lightIntensity, float3 lightDir, float lightConeAngle, float lightFallOff, float4x4 lightViewPrjMatrix, 
							uniform Texture2D lightShadowMap, bool lightShadowOn, float3 vertexNormal, float3 normal, float3 diffuseColorIn, 
							float3 eyeVec, float roughness,	float3 specularColorIn, float3 thickness, float softenMask, 
							float gammaCorrection, float rim, float glossiness, float opacity, float3 ambientOcclusion, float4 anisotropicDir )
{
	lightOut OUT = (lightOut)0;

	OUT.Specular = 0.0;
	OUT.Color = float3(0,0,0);

	if (lightEnable)
	{
		// For Maya, flip the lightDir:
		lightDir = -lightDir;

		// Ambient light does no diffuse, specular shading or shadow casting.
		// Because it does equal shading from all directions to the object, we will also not have it do any translucency.
		bool isAmbientLight = (lightType == 5);
		if (isAmbientLight)
		{
			OUT.Color = diffuseColorIn * lightColor * lightIntensity;
			// Ambient Occlusion (and sometimes Lightmap) should affect the contribution of the ambient light:
			OUT.Color.rgb *= ambientOcclusion;
			return OUT;
		}

		// directional light has no position, so we use lightDir instead
		bool isDirectionalLight = (lightType == 4);
		float3 lightVec = lerp(lightPos - vertWorldPos, lightDir, isDirectionalLight);

		float3 L = normalize(lightVec);	

		// Diffuse:
		float3 diffuseColor = float3(0,0,0);
		if (DiffuseModel == 0)	// Lambert:
		{
			diffuseColor = saturate(dot(normal, L)) * diffuseColorIn;
		}
		else if (DiffuseModel == 1) // (hair/fur):
		{
			/// lerp to shift the shadow boundary for a softer look:
			diffuseColor = saturate( lerp(0.25, 1.0, dot(normal, L) ) ) * diffuseColorIn;
		}

		// Rim Light:
		float3 rimColor = rim * saturate(dot(normal, -L));	 

		// Specular:
		float3 specularColor = float3(0,0,0);

		// BLINN
		{
			// Phong:
			// float3 R = -reflect(L, normal); 
			// float RdotV = saturate(dot(R,eyeVec));
			// specularColor = (pow(RdotV, glossiness) * specularColorIn);

			float3 H = normalize(L + eyeVec); // half angle
			float NdotH = saturate( dot(normal, H) );
			specularColor = specularColorIn * pow(NdotH, glossiness);
			specularColor *= saturate( dot(normal, L) );	// prevent spec leak on back side of model
		}
		

		// Light Attenuation:
		bool enableAttenuation = lightAtten > 0.0001f;
		float attenuation = 1.0f;
		if (!isDirectionalLight)	// directional lights do not support attenuation, skip calculation
		{
			attenuation = lerp(1.0, 1 / pow(length(lightVec), lightAtten), enableAttenuation);
		}

		// compensate diffuse and specular color with various light settings:
		specularColor *= (lightColor * lightIntensity * attenuation);
		diffuseColor *= (lightColor * lightIntensity * attenuation);

		// Spot light Cone Angle:
		if (lightType == 2)
		{
			float angle = lightConeangle(lightConeAngle, lightFallOff, lightVec, lightDir);
			diffuseColor *= angle;
			specularColor *= angle;
		}

		// Add specular and rim light on top of final output color
		// multiply OUT.Color with opacity since we are using a pre-multiplied alpha render state
		// if we don't do this, the rim may have halo's around it when the object is fully transparent
		OUT.Color += diffuseColor;
		OUT.Color *= opacity;

		OUT.Color += specularColor + rimColor;

		// Output specular and rim for opacity:
		OUT.Specular = dot(saturate(specularColor), float3(0.3f, 0.6f, 0.1f)) + rimColor.r;


	} // end if light enabled

	return OUT;
}

VS_TO_PS VS_Flat_Wave(VS_INPUT In)
{

  VS_TO_PS Out;
  float4 INP = float4(In.Pos, 1.0f);


  Out.HPos = mul(INP, gWVPXf);
  
  
  float4 worldPos = mul( INP, world );
  Out.worldPosition.xyz = worldPos.xyz;
  
  Out.texCoord0 = In.texCoord0;
    
  return Out;
}

VS_TO_PS VS_Wave(VS_INPUT In)
{

  VS_TO_PS Out;
  float4 INP = float4(In.Pos, 1.0f);


  //float2 t = (INP.xy + VOfs.xy) * DMParameters.x;
  float2 inTex = INP.xz;//In.texCoord0;//
  float2 t1 = 0.1*inTex*texScale * 0.8 + float2(0.0f, -waterSpeed * 0.6) * Tmh;
  float2 t2 = 0.1*inTex*texScale      +  float2(0.0f, -waterSpeed)       * Tmh;
  float2 t3 = 0.1*inTex*texScale * 1.3 + float2(0.0f, -waterSpeed * 1.3) * Tmh;
  float3 vDisp1 = gHeightMap.SampleLevel(SamplerAnisoWrap, t1,0).xyz;
  float3 vDisp2 = gHeightMap.SampleLevel(SamplerAnisoWrap, t2,0).xyz;
  float3 vDisp3 = gHeightMap.SampleLevel(SamplerAnisoWrap, t3,0).xyz;
  float vDisp = 1.1 * WaveAmplitude * (vDisp1.x  -0.5 )
               + 0.9 * WaveAmplitude * (vDisp2.x -0.5)
			   + 0.8 * WaveAmplitude * (vDisp3.x -0.5);
  //TODO: try to include gSeaNormalMap texture in gNormalMap texture			   
  float3 vNormal1 = gSeaNormalMap.SampleLevel(SamplerAnisoWrap, t1,0).xyz;
  float3 vNormal2 = gSeaNormalMap.SampleLevel(SamplerAnisoWrap, t2,0).xyz;
  float3 vNormal3 = gSeaNormalMap.SampleLevel(SamplerAnisoWrap, t3,0).xyz;
  float3 vNormalTotal = vNormal1 + vNormal2 + vNormal3;
  vNormalTotal = normalize(vNormalTotal);
  
  if(In.Pos.y > 0)
  {
    INP.y += (vDisp);
  }
  Out.HPos = mul(INP, gWVPXf);
  
  
  float4 worldPos = mul( INP, world );
  Out.worldPosition.xyz = worldPos.xyz;
  
  Out.texCoord0 = In.texCoord0;
  
  Out.worldNormal = mul(vNormalTotal, (float3x3)world);
  Out.worldTangent = normalize( mul(float4(In.tangent,0.0), world) );
  Out.amCol = float4(vNormalTotal, vDisp);
  
  return Out;
  

}

float4 PS_Normal(VS_TO_PS In) : SV_Target
{
	return float4(In.amCol.xyz,1.0);	
}

float4 PS_Wave(VS_TO_PS In) : SV_Target
{

	float3 N = In.worldNormal.xyz;
	float3 Nw = N;
	float3 V = normalize( viewInv[3].xyz - In.worldPosition.xyz );
	
	float roughness = 0;
	float3 specularColorIn = float3(0.0,0.0,0.0);
	float3 thickness = float3(0.0,0.0,0.0);
	float softenMask = 0;
	float gammaCorrection = 0;
	float rim = saturate((saturate(1.0f - dot(N, V))-rimFresnelMin)/(max(rimFresnelMax, rimFresnelMin)  - rimFresnelMin));
		rim *= rimBrightness;	
	float glossiness = max(1.0, SpecPower);
	float opacity = 1.0f-TransparencyStd;
	float3 ambientOcclusion = float3(1,1,1);
	float4 anisotropicDir = float4(1.0,1.0,1.0,1.0);
	
	// light 0:
	lightOut light0 = CalculateLight(	light0Enable, light0Type, light0AttenScale, light0Pos, In.worldPosition.xyz, 
										light0Color, light0Intensity, light0Dir, light0ConeAngle, light0FallOff, light0Matrix, 
										light0ShadowMap, light0ShadowOn, Nw, N, DiffuseColor, V, roughness, SpecularColor,
										thickness, softenMask, gammaCorrection, rim, glossiness, opacity, ambientOcclusion, anisotropicDir );
	
	float3 lightTotal =  light0.Color;
	
	lightTotal += DiffuseColor;//* diffuseIBLcolor * DiffuseIBLIntensity * opacity;
	float specTotal = light0.Specular;
	
	float transparency = (specTotal) + opacity;
	transparency = saturate(transparency);	// keep 0-1 range
	
	
  	return float4(lightTotal,transparency);  
	
	
}

technique10 Main <
		string Transparency = "Transparent";
>
{
    pass P0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_Wave()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Wave()));
    }
}

technique10 Normal <
		string Transparency = "Transparent";
		string overridesDrawState = "true";
>
{
    pass P0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_Wave()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PS_Normal()));
    }
}




