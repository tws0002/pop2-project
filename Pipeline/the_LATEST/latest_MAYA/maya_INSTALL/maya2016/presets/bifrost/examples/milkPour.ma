//Maya ASCII 2016 scene
//Name: milkPour.ma
//Last modified: Tue, Feb 24, 2015 01:22:07 PM
//Codeset: 1252
requires maya "2016";
requires -nodeType "bifrostLiquidMaterial" -nodeType "bifrostShape" "bifrostvisplugin" "3.0";
requires -nodeType "mentalrayFramebuffer" -nodeType "mentalrayOptions" -nodeType "mentalrayGlobals"
		 -nodeType "mentalrayItemsList" -nodeType "mia_material_x" -nodeType "misss_fast_shader2_x"
		 -nodeType "misss_fast_lmap_maya" -nodeType "mib_data_string" -dataType "byteArray"
		 "Mayatomr" "2016.0 - 3.13.1.2 ";
requires -nodeType "bifrostContainer" -nodeType "bifrostAttrNotifier" "bifrostshellnode" "2015";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2016";
fileInfo "version" "2016";
fileInfo "cutIdentifier" "201502172200-952624";
fileInfo "osv" "Microsoft Windows 7 Business Edition, 64-bit Windows 7 Service Pack 1 (Build 7601)\n";
createNode transform -s -n "persp";
	rename -uid "63F8EC06-4D10-2656-E53D-A0A81003F8AD";
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "75E85D26-4CCF-0597-9089-CF89ED6AEE37";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "DF3719EF-4DFB-E1BD-5C61-DE93B89EF9AA";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "B93D37F6-4883-7051-C0B3-1C8D6168FDCF";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "FCAF2826-4B64-771D-EF6D-F5B9FBB28023";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "124BBFFD-4EFF-25F6-724C-1A829148EC23";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "27E0020D-4108-A5E7-57C9-5589212E4F01";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "B1921282-4225-E1F8-CEDE-C48E6A2851BC";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "glassMesh";
	rename -uid "A5497F39-481B-9E6E-590D-88ACA45E6B23";
	setAttr ".t" -type "double3" 0 1.605583116404238 0 ;
createNode mesh -n "glassMeshShape" -p "glassMesh";
	rename -uid "63D21848-4B22-8BDB-C772-E485320D5B1F";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostAcceleratorEnable" -ln "bifrostAcceleratorEnable" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostAcceleratorMode" -ln "bifrostAcceleratorMode" -min 
		0 -max 1 -en "Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostAcceleratorInfluence" -ln "bifrostAcceleratorInfluence" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorInheritVelocity" -ln "bifrostAcceleratorInheritVelocity" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorFalloffBandwidth" -ln "bifrostAcceleratorFalloffBandwidth" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirectionMagnitude" -ln "bifrostAcceleratorDirectionMagnitude" 
		-dv 10 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirection" -ln "bifrostAcceleratorDirection" 
		-at "double3" -nc 3;
	addAttr -ci true -sn "bifrostAcceleratorDirectionX" -ln "bifrostAcceleratorDirectionX" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionY" -ln "bifrostAcceleratorDirectionY" 
		-dv 1 -at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionZ" -ln "bifrostAcceleratorDirectionZ" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerStrength" -ln "bifrostAcceleratorBoundaryLayerStrength" 
		-at "double";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerBandwidth" -ln "bifrostAcceleratorBoundaryLayerBandwidth" 
		-dv 1 -at "double";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.49999997019767761 0.34437408298254013 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ccls" -type "string" "bifrostAcceleratorInfluence";
	setAttr ".clst[0].clsn" -type "string" "bifrostAcceleratorInfluence";
	setAttr ".clst[0].rprt" 3;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".sdt" 0;
	setAttr ".ugsdt" no;
	setAttr ".bnr" 0;
	setAttr ".vnm" 0;
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness" 2;
	setAttr -k on ".bifrostColliderMode";
	setAttr -k on ".bifrostAcceleratorEnable" no;
	setAttr ".bifrostAcceleratorInheritVelocity" 0;
	setAttr ".bifrostAcceleratorFalloffBandwidth" 0;
	setAttr ".bifrostAcceleratorDirectionMagnitude" 0;
	setAttr ".bifrostAcceleratorBoundaryLayerStrength" 0.002;
	setAttr ".bifrostAcceleratorBoundaryLayerBandwidth" 0.05;
createNode transform -n "milkEmitter";
	rename -uid "8842B48B-4F02-0FC5-A637-D4B1724CC6A1";
	setAttr ".t" -type "double3" 0.70733712747140909 4.3746841554951148 0.18364744953178649 ;
	setAttr ".s" -type "double3" 0.19064620661398565 0.35123034011502741 0.19064620661398565 ;
createNode mesh -n "milkEmitterShape" -p "milkEmitter";
	rename -uid "4D93281D-49E1-6CE2-FDB9-EFB0D70F67DC";
	addAttr -ci true -sn "bifrostLiquidEnable" -ln "bifrostLiquidEnable" -dv 1 -min 
		0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostLiquidContinuousEmission" -ln "bifrostLiquidContinuousEmission" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostLiquidThickness" -ln "bifrostLiquidThickness" -at "double";
	addAttr -ci true -sn "bifrostLiquidMode" -ln "bifrostLiquidMode" -min 0 -max 1 -en 
		"Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostLiquidDensity" -ln "bifrostLiquidDensity" -dv 1000 
		-at "double";
	addAttr -ci true -sn "bifrostLiquidExpansionRate" -ln "bifrostLiquidExpansionRate" 
		-at "double";
	addAttr -ci true -sn "bifrostLiquidStictionStrength" -ln "bifrostLiquidStictionStrength" 
		-at "double";
	addAttr -ci true -sn "bifrostLiquidStictionBandwidth" -ln "bifrostLiquidStictionBandwidth" 
		-at "double";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "bifrostAcceleratorEnable" -ln "bifrostAcceleratorEnable" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostAcceleratorMode" -ln "bifrostAcceleratorMode" -min 
		0 -max 1 -en "Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostAcceleratorInfluence" -ln "bifrostAcceleratorInfluence" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorInheritVelocity" -ln "bifrostAcceleratorInheritVelocity" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorFalloffBandwidth" -ln "bifrostAcceleratorFalloffBandwidth" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirectionMagnitude" -ln "bifrostAcceleratorDirectionMagnitude" 
		-dv 10 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirection" -ln "bifrostAcceleratorDirection" 
		-at "double3" -nc 3;
	addAttr -ci true -sn "bifrostAcceleratorDirectionX" -ln "bifrostAcceleratorDirectionX" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionY" -ln "bifrostAcceleratorDirectionY" 
		-dv 1 -at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionZ" -ln "bifrostAcceleratorDirectionZ" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerStrength" -ln "bifrostAcceleratorBoundaryLayerStrength" 
		-at "double";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerBandwidth" -ln "bifrostAcceleratorBoundaryLayerBandwidth" 
		-dv 1 -at "double";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ccls" -type "string" "bifrostAcceleratorInfluence1";
	setAttr -s 4 ".clst";
	setAttr ".clst[0].clsn" -type "string" "bifrostLiquidDensity";
	setAttr ".clst[0].rprt" 3;
	setAttr ".clst[1].clsn" -type "string" "bifrostLiquidExpansionRate";
	setAttr ".clst[1].rprt" 3;
	setAttr ".clst[2].clsn" -type "string" "bifrostAcceleratorInfluence";
	setAttr ".clst[2].rprt" 3;
	setAttr ".clst[3].clsn" -type "string" "bifrostAcceleratorInfluence1";
	setAttr ".clst[3].rprt" 3;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".sdt" 0;
	setAttr ".ugsdt" no;
	setAttr ".bnr" 0;
	setAttr ".qsp" 0;
	setAttr ".vnm" 0;
	setAttr -k on ".bifrostLiquidEnable";
	setAttr -k on ".bifrostLiquidContinuousEmission";
	setAttr -k on ".bifrostLiquidThickness";
	setAttr -k on ".bifrostLiquidMode";
	setAttr -k on ".bifrostLiquidDensity";
	setAttr -k on ".bifrostLiquidExpansionRate";
	setAttr -k on ".bifrostLiquidStictionStrength";
	setAttr -k on ".bifrostLiquidStictionBandwidth";
	setAttr ".nts" -type "string" "This emitter has continuous emission with an added accelerator with directionalMagnitude to create a continuous flow. A bit of boundarylayer provides a bit of drag inside the emitter region that smooths the flow and keeps it from accelerating too much. As well the direction of the flow was set from the emitter mesh rotation by doing the following:\n1. create a pointMatrixMult node\n2. connectAttr emitter.worldMatrix pointMatrixMult.inMatrix\n3. set the pointMatrixMult vectorMultiply true and inPoint to 0 1 0\n4. connectattr pointMatrixMult.output emitter.bifrostAcceleratorDirection\n\nThus one can animate the rotation of the emitter and the direction of the \"hose\" will match. ";
	setAttr -k on ".bifrostAcceleratorEnable";
	setAttr -k on ".bifrostAcceleratorMode";
	setAttr -k on ".bifrostAcceleratorInfluence";
	setAttr -k on ".bifrostAcceleratorInheritVelocity";
	setAttr -k on ".bifrostAcceleratorFalloffBandwidth" 0.2;
	setAttr -k on ".bifrostAcceleratorDirectionMagnitude";
	setAttr -k on ".bifrostAcceleratorDirection";
	setAttr -k on ".bifrostAcceleratorDirectionX";
	setAttr -k on ".bifrostAcceleratorDirectionY";
	setAttr -k on ".bifrostAcceleratorDirectionZ";
	setAttr -k on ".bifrostAcceleratorBoundaryLayerStrength" 0.2;
	setAttr -k on ".bifrostAcceleratorBoundaryLayerBandwidth" 0.2;
createNode transform -n "bifrostLiquid1";
	rename -uid "04C9951D-4D91-4A11-CC25-718BBD5B3F89";
	setAttr ".v" no;
createNode bifrostContainer -n "bifrostLiquidContainer1" -p "bifrostLiquid1";
	rename -uid "0B1B23C9-4346-FABF-3491-2FA967A8DF79";
	addAttr -r false -ci true -k true -m -sn "Emitters" -ln "Emitters" -dt "mesh";
	addAttr -r false -ci true -k true -m -sn "Colliders" -ln "Colliders" -dt "mesh";
	addAttr -r false -ci true -k true -sn "masterVoxelSize" -ln "masterVoxelSize" -at "float";
	addAttr -r false -ci true -k true -m -sn "Accelerators" -ln "Accelerators" -dt "mesh";
	addAttr -r false -ci true -k true -sn "vorticityEnable" -ln "vorticityEnable" -min 
		0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "vorticityDecay" -ln "vorticityDecay" -at "float";
	addAttr -r false -ci true -k true -sn "vorticityMax" -ln "vorticityMax" -at "float";
	addAttr -r false -ci true -k true -sn "gravityMagnitude" -ln "gravityMagnitude" 
		-at "float";
	addAttr -r false -ci true -k true -sn "gravityDirection" -ln "gravityDirection" 
		-at "float3" -nc 3;
	addAttr -r false -ci true -k true -sn "gravityDirectionX" -ln "gravityDirectionX" 
		-at "float" -p "gravityDirection";
	addAttr -r false -ci true -k true -sn "gravityDirectionY" -ln "gravityDirectionY" 
		-at "float" -p "gravityDirection";
	addAttr -r false -ci true -k true -sn "gravityDirectionZ" -ln "gravityDirectionZ" 
		-at "float" -p "gravityDirection";
	addAttr -r false -ci true -k true -sn "solidVoxelScale" -ln "solidVoxelScale" -at "float";
	addAttr -r false -ci true -k true -sn "forceVoxelScale" -ln "forceVoxelScale" -at "float";
	addAttr -r false -ci true -k true -sn "vorticityMult" -ln "vorticityMult" -at "float";
	addAttr -r false -ci true -k true -sn "transportStepAdaptivity" -ln "transportStepAdaptivity" 
		-min 0 -max 1 -at "float";
	addAttr -r false -ci true -k true -sn "transportTimeScale" -ln "transportTimeScale" 
		-at "float";
	addAttr -r false -ci true -k true -sn "minSteps" -ln "minSteps" -at "long";
	addAttr -r false -ci true -k true -sn "maxSteps" -ln "maxSteps" -at "long";
	addAttr -r false -ci true -k true -sn "dropletThreshold" -ln "dropletThreshold" 
		-at "float";
	addAttr -r false -ci true -k true -sn "dropletMergeBackDepth" -ln "dropletMergeBackDepth" 
		-at "float";
	addAttr -r false -ci true -k true -sn "surfaceBandWidth" -ln "surfaceBandWidth" 
		-at "float";
	addAttr -r false -ci true -k true -sn "interiorParticleDensity" -ln "interiorParticleDensity" 
		-at "float";
	addAttr -r false -ci true -k true -sn "surfaceParticleDensity" -ln "surfaceParticleDensity" 
		-at "float";
	addAttr -r false -ci true -k true -m -sn "killplanes" -ln "killplanes" -at "matrix";
	addAttr -w false -s false -sn "Liquid" -ln "Liquid" -dt "string";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -r false -ci true -k true -sn "viscosityScale" -ln "viscosityScale" -at "float";
	addAttr -r false -ci true -sn "surfaceTension" -ln "surfaceTension" -at "float";
	addAttr -r false -ci true -k true -sn "surfaceTensionEnable" -ln "surfaceTensionEnable" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -dcb 0 -ci true -k true -m -sn "cameraMatrixList" -ln "cameraMatrixList" 
		-at "matrix";
	addAttr -r false -ci true -k true -sn "enableFoam" -ln "enableFoam" -min 0 -max 
		1 -at "bool";
	addAttr -r false -ci true -k true -sn "enableGuiding" -ln "enableGuiding" -min 0 
		-max 1 -at "bool";
	addAttr -r false -ci true -sn "computeGuideFromHighResLiquid" -ln "computeGuideFromHighResLiquid" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "minSimulationDepth" -ln "minSimulationDepth" -at "float";
	addAttr -r false -ci true -sn "guideVoxelScale" -ln "guideVoxelScale" -at "float";
	addAttr -r false -ci true -sn "reseedParticleDensity" -ln "reseedParticleDensity" 
		-at "float";
	addAttr -r false -ci true -sn "reseedGuideOverlap" -ln "reseedGuideOverlap" -at "float";
	addAttr -r false -ci true -sn "reseedLiquidOverlap" -ln "reseedLiquidOverlap" -at "float";
	addAttr -r false -dcb 0 -ci true -k true -m -sn "Guides" -ln "Guides" -dt "mesh";
	addAttr -r false -ci true -sn "minReseedAirDistance" -ln "minReseedAirDistance" 
		-at "float";
	addAttr -r false -ci true -sn "simulationCacheFilename" -ln "simulationCacheFilename" 
		-dt "string";
	addAttr -r false -ci true -sn "simulationCachePath" -ln "simulationCachePath" -dt "string";
	addAttr -r false -ci true -sn "computeGuideFromSimulationCache" -ln "computeGuideFromSimulationCache" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "computeGuideFromMesh" -ln "computeGuideFromMesh" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "clipBBoxMin" -ln "clipBBoxMin" -at "float3" 
		-nc 3;
	addAttr -r false -ci true -k true -sn "clipBBoxMinX" -ln "clipBBoxMinX" -at "float" 
		-p "clipBBoxMin";
	addAttr -r false -ci true -k true -sn "clipBBoxMinY" -ln "clipBBoxMinY" -at "float" 
		-p "clipBBoxMin";
	addAttr -r false -ci true -k true -sn "clipBBoxMinZ" -ln "clipBBoxMinZ" -at "float" 
		-p "clipBBoxMin";
	addAttr -r false -ci true -k true -sn "clipBBoxMax" -ln "clipBBoxMax" -at "float3" 
		-nc 3;
	addAttr -r false -ci true -k true -sn "clipBBoxMaxX" -ln "clipBBoxMaxX" -at "float" 
		-p "clipBBoxMax";
	addAttr -r false -ci true -k true -sn "clipBBoxMaxY" -ln "clipBBoxMaxY" -at "float" 
		-p "clipBBoxMax";
	addAttr -r false -ci true -k true -sn "clipBBoxMaxZ" -ln "clipBBoxMaxZ" -at "float" 
		-p "clipBBoxMax";
	addAttr -r false -ci true -k true -sn "clipBBoxTransform" -ln "clipBBoxTransform" 
		-at "matrix";
	addAttr -r false -ci true -sn "liquidCacheControl" -ln "liquidCacheControl" -at "long";
	addAttr -r false -ci true -sn "liquidCompressionQuality" -ln "liquidCompressionQuality" 
		-at "long";
	addAttr -r false -ci true -sn "liquidCachePath" -ln "liquidCachePath" -dt "string";
	addAttr -r false -ci true -sn "liquidCacheFileName" -ln "liquidCacheFileName" -dt "string";
	addAttr -r false -ci true -k true -sn "enableLiquidCache" -ln "enableLiquidCache" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "solidCacheControl" -ln "solidCacheControl" -at "long";
	addAttr -r false -ci true -sn "solidCompressionQuality" -ln "solidCompressionQuality" 
		-at "long";
	addAttr -r false -ci true -sn "solidCachePath" -ln "solidCachePath" -dt "string";
	addAttr -r false -ci true -sn "solidCacheFileName" -ln "solidCacheFileName" -dt "string";
	addAttr -r false -ci true -k true -sn "enableSolidCache" -ln "enableSolidCache" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "foamCacheControl" -ln "foamCacheControl" -at "long";
	addAttr -r false -ci true -sn "foamCompressionQuality" -ln "foamCompressionQuality" 
		-at "long";
	addAttr -r false -ci true -sn "foamCachePath" -ln "foamCachePath" -dt "string";
	addAttr -r false -ci true -sn "foamCacheFileName" -ln "foamCacheFileName" -dt "string";
	addAttr -r false -ci true -k true -sn "enableFoamCache" -ln "enableFoamCache" -min 
		0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "deleteExceedingParticles" -ln "deleteExceedingParticles" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "emissionRate" -ln "emissionRate" -at "float";
	addAttr -r false -ci true -sn "minLiquidSpeed" -ln "minLiquidSpeed" -at "float";
	addAttr -r false -ci true -sn "minLiquidChurn" -ln "minLiquidChurn" -at "float";
	addAttr -r false -ci true -sn "minLiquidCurvature" -ln "minLiquidCurvature" -at "float";
	addAttr -r false -ci true -sn "minLiquidDepth" -ln "minLiquidDepth" -at "float";
	addAttr -r false -ci true -sn "maxLiquidDepth" -ln "maxLiquidDepth" -at "float";
	addAttr -r false -ci true -sn "inheritLiquidVelocity" -ln "inheritLiquidVelocity" 
		-at "float";
	addAttr -r false -ci true -sn "emitFlatnessToSurface" -ln "emitFlatnessToSurface" 
		-at "float";
	addAttr -r false -ci true -sn "dissipationRate" -ln "dissipationRate" -at "float";
	addAttr -r false -ci true -sn "killDensityThreshold" -ln "killDensityThreshold" 
		-at "float";
	addAttr -r false -ci true -sn "buoyancy" -ln "buoyancy" -at "float";
	addAttr -r false -ci true -sn "collideKillDepth" -ln "collideKillDepth" -at "float";
	addAttr -r false -ci true -sn "windX" -ln "windX" -at "float";
	addAttr -r false -ci true -sn "windZ" -ln "windZ" -at "float";
	addAttr -r false -ci true -sn "surfaceOffset" -ln "surfaceOffset" -at "float";
	addAttr -r false -ci true -sn "snapToSurface" -ln "snapToSurface" -min 0 -max 1 
		-at "bool";
	addAttr -r false -ci true -sn "pointRadius" -ln "pointRadius" -at "float";
	addAttr -r false -ci true -sn "preserveVolume" -ln "preserveVolume" -at "float";
	addAttr -r false -ci true -sn "maxSolidDepth" -ln "maxSolidDepth" -at "float";
	addAttr -r false -ci true -sn "cameraAdaptivity" -ln "cameraAdaptivity" -at "float";
	addAttr -r false -ci true -sn "clipToCameraFrustum" -ln "clipToCameraFrustum" -min 
		0 -max 1 -at "bool";
	addAttr -r false -ci true -sn "cameraFov" -ln "cameraFov" -at "float";
	addAttr -r false -ci true -sn "cameraAspect" -ln "cameraAspect" -at "float";
	addAttr -r false -ci true -sn "cameraBuffer" -ln "cameraBuffer" -at "float";
	addAttr -w false -s false -sn "Solid" -ln "Solid" -dt "string";
	addAttr -w false -s false -sn "Foam" -ln "Foam" -dt "string";
	setAttr -k off ".v" no;
	setAttr ".sc" -type "string" (
		"{\"version\":3,\"runtimeVersion\":\"2.0\",\"graphName\":\"_bifrostLiquid1_bifrostLiquidContainer1::liquid\",\"graphCode\":\"{\\n    \\\"header\\\": {\\n        \\\"metadata\\\": [\\n            {\\n                \\\"metaName\\\": \\\"version\\\",\\n                \\\"metaValue\\\": \\\"100L\\\"\\n            },\\n            {\\n                \\\"metaName\\\": \\\"adskFileFormatVersion\\\",\\n                \\\"metaValue\\\": \\\"100L\\\"\\n            }\\n        ]\\n    },\\n    \\\"dependencies\\\": [\\n        {\\n            \\\"uri\\\": \\\"file:///createMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///keepMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createObjectWhenCaching.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///cacheObjectToDisk.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///solveLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeVoxelLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopePointLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeSolids.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///foam.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createEmptyItems.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///updateSubStepIterator.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///basenodes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///keepMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createObjectWhenCaching.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///cacheObjectToDisk.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///solveLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeVoxelLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopePointLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeSolids.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///foam.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createEmptyItems.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///updateSubStepIterator.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///basenodes.json\\\"\\n        }\\n    ],\\n    \\\"types\\\": [],\\n    \\\"operators\\\": [],\\n    \\\"compounds\\\": [\\n        {\\n            \\\"name\\\": \\\"_bifrostLiquid1_bifrostLiquidContainer1::liquid\\\",\\n            \\\"uriImported\\\": \\\"file:///liquid.json\\\",\\n            \\\"ports\\\": [\\n                {\\n                    \\\"portName\\\": \\\"Emitters\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Colliders\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Accelerators\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"masterVoxelSize\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"gravityMagnitude\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"gravityDirection\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"forceVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"transportStepAdaptivity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"transportTimeScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minSteps\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxSteps\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dropletThreshold\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dropletMergeBackDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceBandWidth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"interiorParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"killplanes\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"viscosityScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Liquid\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Solid\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceTension\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityDecay\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityMult\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityMax\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceTensionEnable\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityEnable\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Foam\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraMatrixList\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableFoam\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableGuiding\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromHighResLiquid\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minSimulationDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"guideVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedGuideOverlap\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedLiquidOverlap\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Guides\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minReseedAirDistance\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"simulationCacheFilename\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"simulationCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromSimulationCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromMesh\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxMin\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxMax\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxTransform\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableLiquidCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableSolidCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableFoamCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"deleteExceedingParticles\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"emissionRate\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidSpeed\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidChurn\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidCurvature\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxLiquidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"inheritLiquidVelocity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"emitFlatnessToSurface\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dissipationRate\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"killDensityThreshold\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"buoyancy\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"collideKillDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"windX\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"windZ\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceOffset\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"snapToSurface\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"pointRadius\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"preserveVolume\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxSolidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraAdaptivity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipToCameraFrustum\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraFov\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraAspect\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraBuffer\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                }\\n            ],\\n            \\\"compounds\\\": [\\n                {\\n                    \\\"name\\\": \\\"subStepLiquid\\\",\\n                    \\\"uriImported\\\": \\\"file:///liquid.json\\\",\\n                    \\\"ports\\\": [\\n                        {\\n                            \\\"portName\\\": \\\"Emitters\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Colliders\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Accelerators\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"masterVoxelSize\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"gravityMagnitude\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"gravityDirection\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"solidVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"forceVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"transportStepAdaptivity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"transportTimeScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minSteps\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"int\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"maxSteps\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"int\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dropletThreshold\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dropletMergeBackDepth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfaceBandWidth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"interiorPointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfacePointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"killPlanes\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"PIC\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"viscosityMult\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dynamicSurfaceTension\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityDecay\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityMul\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityMax\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfaceTensionEnable\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityEnable\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"simulationCacheFilename\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"string\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"simulationCachePath\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"string\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"enableGuiding\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromHighResLiquid\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minSimulationDepth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"guideVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedPointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedGuideOverlap\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedLiquidOverlap\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Guides\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minReseedAirDistance\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Liquid\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Object\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Solid\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Object\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"ittr_input\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"ittr_output\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromSimulationCache\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromMesh\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxMin\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxMax\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxTransform\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Mat44Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"deleteExceedingPoints\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        }\\n                    ],\\n                    \\\"compoundNodes\\\": [\\n                        {\\n                            \\\"nodeName\\\": \\\"solveLiquid\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::solveLiquid\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"updateSubStepIterator\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::_private::updateSubStepIterator\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"getLiquidObjectName\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::_privNames::getLiquidObjectName\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"voxel_liquid-volume\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"valueBool\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Math::valueBool\\\"\\n                        }\\n                    ],\\n                    \\\"connections\\\": [\\n                        {\\n                            \\\"source\\\": \\\".ittr_input\\\",\\n                            \\\"target\\\": \\\"valueBool.val\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"valueBool.value\\\",\\n                            \\\"target\\\": \\\".ittr_output\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Emitters\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Emitters\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Colliders\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Colliders\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".deleteExceedingPoints\\\",\\n                            \\\"target\\\": \\\"solveLiquid.deleteExceedingPoints\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Accelerators\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Accelerators\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".masterVoxelSize\\\",\\n                            \\\"target\\\": \\\"solveLiquid.masterVoxelSize\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".gravityMagnitude\\\",\\n                            \\\"target\\\": \\\"solveLiquid.gravityMagnitude\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".gravityDirection\\\",\\n                            \\\"target\\\": \\\"solveLiquid.gravityDirection\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".solidVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.solidVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".forceVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.forceVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".transportStepAdaptivity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.transportStepAdaptivity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".transportTimeScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.transportTimeScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minSteps\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minSteps\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".maxSteps\\\",\\n                            \\\"target\\\": \\\"solveLiquid.maxSteps\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dropletThreshold\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dropletThreshold\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dropletMergeBackDepth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dropletMergeBackDepth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfaceBandWidth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfaceBandWidth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".interiorPointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.interiorPointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfacePointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfacePointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".killPlanes\\\",\\n                            \\\"target\\\": \\\"solveLiquid.killPlanes\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".PIC\\\",\\n                            \\\"target\\\": \\\"solveLiquid.PIC\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".viscosityMult\\\",\\n                            \\\"target\\\": \\\"solveLiquid.viscosityMult\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dynamicSurfaceTension\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dynamicSurfaceTension\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityDecay\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityDecay\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityMul\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityMul\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityMax\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityMax\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfaceTensionEnable\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfaceTensionEnable\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityEnable\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityEnable\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".simulationCacheFilename\\\",\\n                            \\\"target\\\": \\\"solveLiquid.simulationCacheFilename\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".simulationCachePath\\\",\\n                            \\\"target\\\": \\\"solveLiquid.simulationCachePath\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".enableGuiding\\\",\\n                            \\\"target\\\": \\\"solveLiquid.enableGuiding\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromHighResLiquid\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromHighResLiquid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minSimulationDepth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minSimulationDepth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".guideVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.guideVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedPointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedPointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedGuideOverlap\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedGuideOverlap\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedLiquidOverlap\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedLiquidOverlap\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Guides\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Guides\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minReseedAirDistance\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minReseedAirDistance\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.Liquid\\\",\\n                            \\\"target\\\": \\\".Liquid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.Solid\\\",\\n                            \\\"target\\\": \\\".Solid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".masterVoxelSize\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.mvs\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.outLoopingCondition\\\",\\n                            \\\"target\\\": \\\".looping_condition\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromSimulationCache\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromSimulationCache\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromMesh\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromMesh\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxMin\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxMin\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxMax\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxMax\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxTransform\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxTransform\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"updateSubStepIterator.condition\\\",\\n                            \\\"target\\\": \\\"solveLiquid.loopingCondition\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"getLiquidObjectName.value\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.objectName\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"voxel_liquid-volume.value\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.compName\\\"\\n                        }\\n                    ],\\n                    \\\"values\\\": [\\n                        {\\n                            \\\"valueName\\\": \\\"voxel_liquid-volume.str\\\",\\n                            \\\"valueType\\\": \\\"string\\\",\\n                            \\\"value\\\": \\\"voxel_liquid-volume\\\"\\n                        }\\n                    ],\\n                    \\\"whileCompound\\\": {\\n                        \\\"ports\\\": [\\n                            {\\n                                \\\"portKind\\\": \\\"state\\\",\\n                                \\\"inputPortName\\\": \\\"ittr_input\\\",\\n                                \\\"outputPortName\\\": \\\"ittr_output\\\"\\n                            }\\n                        ]\\n                    }\\n                }\\n            ],\\n            \\\"compoundNodes\\\": [\\n                {\\n                    \\\"nodeName\\\": \\\"createMeshes\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::_private::createMeshes\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"keepMeshes\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::_private::keepMeshes\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createObjectWhenCaching\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createObjectWhenCaching\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"cacheObjectToDisk\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::cacheObjectToDisk\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"voxel_liquid\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"scopeLiquid\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::scopeLiquid\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createObjectWhenCaching1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createObjectWhenCaching\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"Solids\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"scopeSolids\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::scopeSolids\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"foamComp\\\",\\n                    \\\"nodeType\\\": \\\"foam\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"if\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::if\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject2\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createEmptyItems\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createEmptyItems\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"subStepLiquid\\\",\\n                    \\\"nodeType\\\": \\\"subStepLiquid\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"initTimestepCFL\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::_private::initTimestepCFL\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"cacheObjectToDisk1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::cacheObjectToDisk\\\"\\n                }\\n            ],\\n            \\\"connections\\\": [\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject.value\\\",\\n                    \\\"target\\\": \\\".Liquid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Emitters\\\",\\n                    \\\"target\\\": \\\"createMeshes.emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Colliders\\\",\\n                    \\\"target\\\": \\\"createMeshes.colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Accelerators\\\",\\n                    \\\"target\\\": \\\"createMeshes.accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject1.value\\\",\\n                    \\\"target\\\": \\\".Solid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraMatrixList\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraMatrixList\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"if.output\\\",\\n                    \\\"target\\\": \\\".Foam\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableFoam\\\",\\n                    \\\"target\\\": \\\"if.condition\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Guides\\\",\\n                    \\\"target\\\": \\\"createMeshes.guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".masterVoxelSize\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.masterVoxelSize\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".deleteExceedingParticles\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.deleteExceedingPoints\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityMagnitude\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.gravityMagnitude\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityDirection\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.gravityDirection\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.solidVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".forceVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.forceVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".transportStepAdaptivity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.transportStepAdaptivity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".transportTimeScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.transportTimeScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minSteps\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minSteps\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxSteps\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.maxSteps\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dropletThreshold\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dropletThreshold\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dropletMergeBackDepth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dropletMergeBackDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceBandWidth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfaceBandWidth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".interiorParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.interiorPointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfacePointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".killplanes\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.killPlanes\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".viscosityScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.viscosityMult\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceTension\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dynamicSurfaceTension\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityDecay\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityDecay\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityMult\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityMul\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityMax\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityMax\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceTensionEnable\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfaceTensionEnable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityEnable\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityEnable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableGuiding\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.enableGuiding\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromHighResLiquid\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromHighResLiquid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minSimulationDepth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minSimulationDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".guideVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.guideVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedPointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedGuideOverlap\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedGuideOverlap\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedLiquidOverlap\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedLiquidOverlap\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minReseedAirDistance\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minReseedAirDistance\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".simulationCacheFilename\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.simulationCacheFilename\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".simulationCachePath\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.simulationCachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromSimulationCache\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromSimulationCache\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromMesh\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromMesh\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxMin\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxMin\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxMax\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxMax\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxTransform\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxTransform\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCompressionQuality\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCachePath\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCacheFileName\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableLiquidCache\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableLiquidCache\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCacheControl\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableSolidCache\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCacheControl\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCacheControl\\\",\\n                    \\\"target\\\": \\\"foamComp.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCompressionQuality\\\",\\n                    \\\"target\\\": \\\"foamComp.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCachePath\\\",\\n                    \\\"target\\\": \\\"foamComp.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCacheFileName\\\",\\n                    \\\"target\\\": \\\"foamComp.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableFoamCache\\\",\\n                    \\\"target\\\": \\\"foamComp.enableFoamCache\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableSolidCache\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCacheFileName\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCachePath\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCompressionQuality\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".emissionRate\\\",\\n                    \\\"target\\\": \\\"foamComp.emissionRate\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidSpeed\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidSpeed\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidChurn\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidChurn\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidCurvature\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidCurvature\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxLiquidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.maxLiquidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".inheritLiquidVelocity\\\",\\n                    \\\"target\\\": \\\"foamComp.inheritLiquidVelocity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".emitFlatnessToSurface\\\",\\n                    \\\"target\\\": \\\"foamComp.emitFlatnessToSurface\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dissipationRate\\\",\\n                    \\\"target\\\": \\\"foamComp.dissipationRate\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".killDensityThreshold\\\",\\n                    \\\"target\\\": \\\"foamComp.killDensityThreshold\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".buoyancy\\\",\\n                    \\\"target\\\": \\\"foamComp.buoyancy\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".collideKillDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.collideKillDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".windX\\\",\\n                    \\\"target\\\": \\\"foamComp.windX\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".windZ\\\",\\n                    \\\"target\\\": \\\"foamComp.windZ\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceOffset\\\",\\n                    \\\"target\\\": \\\"foamComp.surfaceOffset\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".snapToSurface\\\",\\n                    \\\"target\\\": \\\"foamComp.snapToSurface\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".pointRadius\\\",\\n                    \\\"target\\\": \\\"foamComp.pointRadius\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".preserveVolume\\\",\\n                    \\\"target\\\": \\\"foamComp.preserveVolume\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityMagnitude\\\",\\n                    \\\"target\\\": \\\"foamComp.gravity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxSolidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.maxSolidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraAdaptivity\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraAdaptivity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipToCameraFrustum\\\",\\n                    \\\"target\\\": \\\"foamComp.clipToCameraFrustum\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraFov\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraFov\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraAspect\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraAspect\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraBuffer\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraBuffer\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.accelerators1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.colliders1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.emitters1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.guides1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.emitters1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.colliders1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.accelerators1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.guides1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching.outObject\\\",\\n                    \\\"target\\\": \\\"keepMeshes.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"keepMeshes.outObject\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"voxel_liquid.value\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.name\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Liquid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Liquid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.newObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching.outCacheControl\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"cacheObjectToDisk.outObject\\\",\\n                    \\\"target\\\": \\\"scopeLiquid.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"scopeLiquid.outObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject.value\\\",\\n                    \\\"target\\\": \\\"foamComp.liquidObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"Solids.value\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.name\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Solid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Solid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.newObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching1.outObject\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching1.outCacheControl\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"scopeSolids.outObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject1.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"cacheObjectToDisk1.outObject\\\",\\n                    \\\"target\\\": \\\"scopeSolids.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject1.value\\\",\\n                    \\\"target\\\": \\\"foamComp.solidObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"foamComp.Foam\\\",\\n                    \\\"target\\\": \\\"if.trueCase\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject2.value\\\",\\n                    \\\"target\\\": \\\"if.falseCase\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createEmptyItems.emptyObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject2.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"initTimestepCFL.value\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.ittr_input\\\"\\n                }\\n            ],\\n            \\\"values\\\": [\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.compNameToTest\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"_voxel\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.filePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFilePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.fileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFileNameHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cacheControl\\\",\\n                    \\\"value\\\": \\\"0L\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.compressionQuality\\\",\\n                    \\\"value\\\": \\\"0L\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cachePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putCachePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cacheFileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"liquid\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.pointComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid-particle\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.voxelComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid-volume\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"voxel_liquid.str\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.compNameToTest\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"_voxel\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.filePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFileNameHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.fileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFilePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"Solids.str\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"Solids\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.emissionRate\\\",\\n                    \\\"value\\\": \\\"1000f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidSpeed\\\",\\n                    \\\"value\\\": \\\"0.2f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidChurn\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidCurvature\\\",\\n                    \\\"value\\\": \\\"0.5f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.inheritLiquidVelocity\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.emitFlatnessToSurface\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.dissipationRate\\\",\\n                    \\\"value\\\": \\\"5f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.killDensityThreshold\\\",\\n                    \\\"value\\\": \\\"0.05f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.buoyancy\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.collideKillDepth\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.windX\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.windZ\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.surfaceOffset\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.snapToSurface\\\",\\n                    \\\"value\\\": \\\"false\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.pointRadius\\\",\\n                    \\\"value\\\": \\\"0.3f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.preserveVolume\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.gravity\\\",\\n                    \\\"value\\\": \\\"9.8f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.maxSolidDepth\\\",\\n                    \\\"value\\\": \\\"0.3f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraAdaptivity\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.clipToCameraFrustum\\\",\\n                    \\\"value\\\": \\\"false\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraFov\\\",\\n                    \\\"value\\\": \\\"110f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraAspect\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraBuffer\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"subStepLiquid.PIC\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk1.pointComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"none\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk1.voxelComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"Solids-volume\\\"\\n                }\\n            ]\\n        }\\n    ]\\n}\"}");
	setAttr ".srv" -type "string" "2.0";
	setAttr -k on ".pfc";
	setAttr -k on ".euc";
	setAttr -k on ".spa";
	setAttr -k on ".tsa";
	setAttr -k on ".mis";
	setAttr -k on ".mas";
	setAttr -k on -cb off ".sfr";
	setAttr -k on ".Emitters[0]";
	setAttr -k on ".Emitters";
	setAttr -k on ".Colliders[0]";
	setAttr -k on ".Colliders";
	setAttr -k on ".masterVoxelSize" 0.029999999329447746;
	setAttr -s 2 ".Accelerators";
	setAttr -k on ".Accelerators[0]";
	setAttr -k on ".Accelerators[1]";
	setAttr -k on ".Accelerators";
	setAttr -k on ".vorticityEnable" yes;
	setAttr -k on ".vorticityDecay" 20;
	setAttr -k on ".vorticityMax" 100;
	setAttr -k on ".gravityMagnitude" 9.8000001907348633;
	setAttr -k on ".gravityDirection" -type "float3" 0 -1 0 ;
	setAttr -k on ".solidVoxelScale" 1;
	setAttr -k on ".forceVoxelScale" 1;
	setAttr -k on ".vorticityMult" 1;
	setAttr -k on ".transportStepAdaptivity" 0.31999999284744263;
	setAttr -k on ".transportTimeScale" 1;
	setAttr -k on ".minSteps" 1;
	setAttr -k on ".maxSteps" 3000;
	setAttr -k on ".dropletThreshold" 1;
	setAttr -k on ".dropletMergeBackDepth" 2;
	setAttr -k on ".surfaceBandWidth" 1;
	setAttr -k on ".interiorParticleDensity" 1;
	setAttr -k on ".surfaceParticleDensity" 4;
	setAttr -k on ".killplanes[0]";
	setAttr -k on ".killplanes";
	setAttr ".nts" -type "string" "This simulation has an output mesh currently with everything else hidden. A subsurface scatter shader is applied to the mesh to create a milk look. When adjusting the simulation disable the output mesh and show the bifrost shape to preview the simulation as particles, which is much quicker than the output mesh.";
	setAttr -k on ".surfaceTension";
	setAttr -k on ".deleteExceedingParticles" yes;
createNode transform -n "bifrost1";
	rename -uid "F3C4F69A-4BDE-E3C6-EFBD-39BBA73F822B";
	setAttr ".v" no;
createNode bifrostShape -n "bifrostShape1" -p "bifrost1";
	rename -uid "B5D0FA29-469B-8935-A693-0985B510F801";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".pch" -type "string" "position";
	setAttr ".vch" -type "string" "distance";
	setAttr ".pcc" -type "string" "velocity";
	setAttr -s 2 ".pcr";
	setAttr ".pcr[0].pcrp" 0;
	setAttr ".pcr[0].pcrcv" -type "float3" 0 0 1 ;
	setAttr ".pcr[0].pcri" 2;
	setAttr ".pcr[1].pcrp" 1;
	setAttr ".pcr[1].pcrcv" -type "float3" 1 1 1 ;
	setAttr ".pcr[1].pcri" 2;
	setAttr ".pcrx" 20;
	setAttr -s 2 ".pcvr[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".por";
	setAttr ".por[0].porp" 0;
	setAttr ".por[0].porcv" -type "float3" 0 0 0 ;
	setAttr ".por[0].pori" 2;
	setAttr ".por[1].porp" 1;
	setAttr ".por[1].porcv" -type "float3" 1 1 1 ;
	setAttr ".por[1].pori" 2;
	setAttr -s 2 ".povr[0:1]"  0 0 1 1 1 1;
	setAttr ".pnc" -type "string" "velocity";
	setAttr ".pvc" -type "string" "velocity";
	setAttr ".vt" 1;
	setAttr ".vcc" -type "string" "velocity";
	setAttr -s 2 ".vcr";
	setAttr ".vcr[0].vcrp" 0;
	setAttr ".vcr[0].vcrcv" -type "float3" 0 0 1 ;
	setAttr ".vcr[0].vcri" 2;
	setAttr ".vcr[1].vcrp" 1;
	setAttr ".vcr[1].vcrcv" -type "float3" 1 1 1 ;
	setAttr ".vcr[1].vcri" 2;
	setAttr -s 2 ".vcvr[0:1]"  0 0 1 1 1 1;
	setAttr ".brt" 1;
	setAttr -s 3 ".tfc";
	setAttr ".tfc[0].tfcp" 0;
	setAttr ".tfc[0].tfccv" -type "float3" 1 0 0 ;
	setAttr ".tfc[0].tfci" 1;
	setAttr ".tfc[1].tfcp" 0.5;
	setAttr ".tfc[1].tfccv" -type "float3" 0 1 0 ;
	setAttr ".tfc[1].tfci" 1;
	setAttr ".tfc[2].tfcp" 1;
	setAttr ".tfc[2].tfccv" -type "float3" 0 0 1 ;
	setAttr ".tfc[2].tfci" 1;
	setAttr ".men" yes;
	setAttr ".msr" 3.5172414779663086;
	setAttr ".mdr" 1.3103448152542114;
	setAttr ".mkf" 3;
createNode transform -n "bifrostMesh1";
	rename -uid "E315654D-4E34-19E4-7AB4-80B118F478D1";
	addAttr -s false -ci true -sn "miData" -ln "miData" -at "message";
createNode mesh -n "bifrostMeshShape1" -p "bifrostMesh1";
	rename -uid "86151832-4564-B390-B5F8-CBA29761232E";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr -s 2 ".clst";
	setAttr ".clst[0].clsn" -type "string" "bifrostVelocity";
	setAttr ".clst[1].clsn" -type "string" "bifrostVorticity";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".sdt" 0;
	setAttr ".ugsdt" no;
	setAttr ".bnr" 0;
	setAttr ".vnm" 0;
	setAttr ".mvcs" -type "string" "bifrostVelocity";
createNode transform -n "bifrostKillplane1";
	rename -uid "2B67A735-4BAF-2D06-0717-5B9B5CEC8186";
	setAttr ".t" -type "double3" 0 -0.25725215152498682 0 ;
	setAttr ".r" -type "double3" 90 0 0 ;
createNode sketchPlane -n "bifrostKillplaneShape1" -p "bifrostKillplane1";
	rename -uid "9CCE9B7E-4CF4-62BC-0625-1BA90A11706C";
	setAttr -k off ".v";
createNode transform -n "spotLight1";
	rename -uid "F5CD3A97-4781-D989-562B-7B873CCB94C3";
	setAttr ".t" -type "double3" -10.573138810920526 7.2334438894204585 2.41750302645488 ;
	setAttr ".r" -type "double3" -20.042738821006026 -72.414949829496464 -12.343659787930481 ;
createNode spotLight -n "spotLightShape1" -p "spotLight1";
	rename -uid "C3625243-4403-4DAE-1D56-C8980AF5E018";
	setAttr -k off ".v";
	setAttr ".in" 1.2781955003738403;
	setAttr ".urs" no;
	setAttr ".rdl" 1;
	setAttr ".ca" 50.402520987478184;
	setAttr ".pa" 2.7999999985098842;
	setAttr ".dro" 8.1599999278038737;
createNode transform -n "milkPourCam";
	rename -uid "C9337C77-4F24-C896-EAA5-5B826B5B5122";
	setAttr ".t" -type "double3" 1.5104689469979695 2.6563179268120205 8.421259581237571 ;
	setAttr ".r" -type "double3" -4.538352729602722 11.000000000000416 2.0250525957655327e-016 ;
createNode camera -n "milkPourCamShape" -p "milkPourCam";
	rename -uid "7F12D266-4B72-4FE4-2B25-5F86FEBA962B";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 8.7381106181499586;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "F8DF75D2-4CB6-BFA5-1948-1CA2DC80195D";
	setAttr -s 6 ".lnk";
	setAttr -s 6 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "FF66B44E-4E99-71A9-906A-0AA512927F23";
createNode displayLayer -n "defaultLayer";
	rename -uid "D321DEAA-4D27-0170-79AA-85BA1571BA25";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "4105C4C1-4160-98ED-C3B1-908084A088C1";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "649B0811-49DF-129C-3F25-DAA5E04930D6";
	setAttr ".g" yes;
createNode mentalrayItemsList -s -n "mentalrayItemsList";
	rename -uid "802A5C57-4618-F31A-BBF6-768C159B5C3C";
	setAttr -s 2 ".opt";
createNode mentalrayGlobals -s -n "mentalrayGlobals";
	rename -uid "828F65AB-46FB-F0CF-E18A-55B0754F0D82";
createNode mentalrayOptions -s -n "miDefaultOptions";
	rename -uid "091D4B80-40AF-653F-4A34-BB9035F72C28";
	addAttr -ci true -m -sn "stringOptions" -ln "stringOptions" -at "compound" -nc 
		3;
	addAttr -ci true -sn "name" -ln "name" -dt "string" -p "stringOptions";
	addAttr -ci true -sn "value" -ln "value" -dt "string" -p "stringOptions";
	addAttr -ci true -sn "type" -ln "type" -dt "string" -p "stringOptions";
	setAttr -s 81 ".stringOptions";
	setAttr ".stringOptions[0].name" -type "string" "rast motion factor";
	setAttr ".stringOptions[0].value" -type "string" "1.0";
	setAttr ".stringOptions[0].type" -type "string" "scalar";
	setAttr ".stringOptions[1].name" -type "string" "rast transparency depth";
	setAttr ".stringOptions[1].value" -type "string" "8";
	setAttr ".stringOptions[1].type" -type "string" "integer";
	setAttr ".stringOptions[2].name" -type "string" "rast useopacity";
	setAttr ".stringOptions[2].value" -type "string" "true";
	setAttr ".stringOptions[2].type" -type "string" "boolean";
	setAttr ".stringOptions[3].name" -type "string" "importon";
	setAttr ".stringOptions[3].value" -type "string" "false";
	setAttr ".stringOptions[3].type" -type "string" "boolean";
	setAttr ".stringOptions[4].name" -type "string" "importon density";
	setAttr ".stringOptions[4].value" -type "string" "1.0";
	setAttr ".stringOptions[4].type" -type "string" "scalar";
	setAttr ".stringOptions[5].name" -type "string" "importon merge";
	setAttr ".stringOptions[5].value" -type "string" "0.0";
	setAttr ".stringOptions[5].type" -type "string" "scalar";
	setAttr ".stringOptions[6].name" -type "string" "importon trace depth";
	setAttr ".stringOptions[6].value" -type "string" "0";
	setAttr ".stringOptions[6].type" -type "string" "integer";
	setAttr ".stringOptions[7].name" -type "string" "importon traverse";
	setAttr ".stringOptions[7].value" -type "string" "true";
	setAttr ".stringOptions[7].type" -type "string" "boolean";
	setAttr ".stringOptions[8].name" -type "string" "shadowmap pixel samples";
	setAttr ".stringOptions[8].value" -type "string" "3";
	setAttr ".stringOptions[8].type" -type "string" "integer";
	setAttr ".stringOptions[9].name" -type "string" "ambient occlusion";
	setAttr ".stringOptions[9].value" -type "string" "false";
	setAttr ".stringOptions[9].type" -type "string" "boolean";
	setAttr ".stringOptions[10].name" -type "string" "ambient occlusion rays";
	setAttr ".stringOptions[10].value" -type "string" "64";
	setAttr ".stringOptions[10].type" -type "string" "integer";
	setAttr ".stringOptions[11].name" -type "string" "ambient occlusion cache";
	setAttr ".stringOptions[11].value" -type "string" "false";
	setAttr ".stringOptions[11].type" -type "string" "boolean";
	setAttr ".stringOptions[12].name" -type "string" "ambient occlusion cache density";
	setAttr ".stringOptions[12].value" -type "string" "1.0";
	setAttr ".stringOptions[12].type" -type "string" "scalar";
	setAttr ".stringOptions[13].name" -type "string" "ambient occlusion cache points";
	setAttr ".stringOptions[13].value" -type "string" "64";
	setAttr ".stringOptions[13].type" -type "string" "integer";
	setAttr ".stringOptions[14].name" -type "string" "irradiance particles";
	setAttr ".stringOptions[14].value" -type "string" "false";
	setAttr ".stringOptions[14].type" -type "string" "boolean";
	setAttr ".stringOptions[15].name" -type "string" "irradiance particles rays";
	setAttr ".stringOptions[15].value" -type "string" "256";
	setAttr ".stringOptions[15].type" -type "string" "integer";
	setAttr ".stringOptions[16].name" -type "string" "irradiance particles interpolate";
	setAttr ".stringOptions[16].value" -type "string" "1";
	setAttr ".stringOptions[16].type" -type "string" "integer";
	setAttr ".stringOptions[17].name" -type "string" "irradiance particles interppoints";
	setAttr ".stringOptions[17].value" -type "string" "64";
	setAttr ".stringOptions[17].type" -type "string" "integer";
	setAttr ".stringOptions[18].name" -type "string" "irradiance particles indirect passes";
	setAttr ".stringOptions[18].value" -type "string" "0";
	setAttr ".stringOptions[18].type" -type "string" "integer";
	setAttr ".stringOptions[19].name" -type "string" "irradiance particles scale";
	setAttr ".stringOptions[19].value" -type "string" "1.0";
	setAttr ".stringOptions[19].type" -type "string" "scalar";
	setAttr ".stringOptions[20].name" -type "string" "irradiance particles env";
	setAttr ".stringOptions[20].value" -type "string" "true";
	setAttr ".stringOptions[20].type" -type "string" "boolean";
	setAttr ".stringOptions[21].name" -type "string" "irradiance particles env rays";
	setAttr ".stringOptions[21].value" -type "string" "256";
	setAttr ".stringOptions[21].type" -type "string" "integer";
	setAttr ".stringOptions[22].name" -type "string" "irradiance particles env scale";
	setAttr ".stringOptions[22].value" -type "string" "1";
	setAttr ".stringOptions[22].type" -type "string" "integer";
	setAttr ".stringOptions[23].name" -type "string" "irradiance particles rebuild";
	setAttr ".stringOptions[23].value" -type "string" "true";
	setAttr ".stringOptions[23].type" -type "string" "boolean";
	setAttr ".stringOptions[24].name" -type "string" "irradiance particles file";
	setAttr ".stringOptions[24].value" -type "string" "";
	setAttr ".stringOptions[24].type" -type "string" "string";
	setAttr ".stringOptions[25].name" -type "string" "geom displace motion factor";
	setAttr ".stringOptions[25].value" -type "string" "1.0";
	setAttr ".stringOptions[25].type" -type "string" "scalar";
	setAttr ".stringOptions[26].name" -type "string" "contrast all buffers";
	setAttr ".stringOptions[26].value" -type "string" "false";
	setAttr ".stringOptions[26].type" -type "string" "boolean";
	setAttr ".stringOptions[27].name" -type "string" "finalgather normal tolerance";
	setAttr ".stringOptions[27].value" -type "string" "25.842";
	setAttr ".stringOptions[27].type" -type "string" "scalar";
	setAttr ".stringOptions[28].name" -type "string" "trace camera clip";
	setAttr ".stringOptions[28].value" -type "string" "false";
	setAttr ".stringOptions[28].type" -type "string" "boolean";
	setAttr ".stringOptions[29].name" -type "string" "unified sampling";
	setAttr ".stringOptions[29].value" -type "string" "true";
	setAttr ".stringOptions[29].type" -type "string" "boolean";
	setAttr ".stringOptions[30].name" -type "string" "samples quality";
	setAttr ".stringOptions[30].value" -type "string" "0.25 0.25 0.25 0.25";
	setAttr ".stringOptions[30].type" -type "string" "color";
	setAttr ".stringOptions[31].name" -type "string" "samples min";
	setAttr ".stringOptions[31].value" -type "string" "1.0";
	setAttr ".stringOptions[31].type" -type "string" "scalar";
	setAttr ".stringOptions[32].name" -type "string" "samples max";
	setAttr ".stringOptions[32].value" -type "string" "100.0";
	setAttr ".stringOptions[32].type" -type "string" "scalar";
	setAttr ".stringOptions[33].name" -type "string" "samples error cutoff";
	setAttr ".stringOptions[33].value" -type "string" "0.0 0.0 0.0 0.0";
	setAttr ".stringOptions[33].type" -type "string" "color";
	setAttr ".stringOptions[34].name" -type "string" "samples per object";
	setAttr ".stringOptions[34].value" -type "string" "false";
	setAttr ".stringOptions[34].type" -type "string" "boolean";
	setAttr ".stringOptions[35].name" -type "string" "progressive";
	setAttr ".stringOptions[35].value" -type "string" "false";
	setAttr ".stringOptions[35].type" -type "string" "boolean";
	setAttr ".stringOptions[36].name" -type "string" "progressive max time";
	setAttr ".stringOptions[36].value" -type "string" "0";
	setAttr ".stringOptions[36].type" -type "string" "integer";
	setAttr ".stringOptions[37].name" -type "string" "progressive subsampling size";
	setAttr ".stringOptions[37].value" -type "string" "4";
	setAttr ".stringOptions[37].type" -type "string" "integer";
	setAttr ".stringOptions[38].name" -type "string" "iray";
	setAttr ".stringOptions[38].value" -type "string" "false";
	setAttr ".stringOptions[38].type" -type "string" "boolean";
	setAttr ".stringOptions[39].name" -type "string" "light relative scale";
	setAttr ".stringOptions[39].value" -type "string" "0.31831";
	setAttr ".stringOptions[39].type" -type "string" "scalar";
	setAttr ".stringOptions[40].name" -type "string" "trace camera motion vectors";
	setAttr ".stringOptions[40].value" -type "string" "false";
	setAttr ".stringOptions[40].type" -type "string" "boolean";
	setAttr ".stringOptions[41].name" -type "string" "ray differentials";
	setAttr ".stringOptions[41].value" -type "string" "true";
	setAttr ".stringOptions[41].type" -type "string" "boolean";
	setAttr ".stringOptions[42].name" -type "string" "environment lighting mode";
	setAttr ".stringOptions[42].value" -type "string" "off";
	setAttr ".stringOptions[42].type" -type "string" "string";
	setAttr ".stringOptions[43].name" -type "string" "environment lighting quality";
	setAttr ".stringOptions[43].value" -type "string" "0.2";
	setAttr ".stringOptions[43].type" -type "string" "scalar";
	setAttr ".stringOptions[44].name" -type "string" "environment lighting shadow";
	setAttr ".stringOptions[44].value" -type "string" "transparent";
	setAttr ".stringOptions[44].type" -type "string" "string";
	setAttr ".stringOptions[45].name" -type "string" "environment lighting resolution";
	setAttr ".stringOptions[45].value" -type "string" "512";
	setAttr ".stringOptions[45].type" -type "string" "integer";
	setAttr ".stringOptions[46].name" -type "string" "environment lighting shader samples";
	setAttr ".stringOptions[46].value" -type "string" "2";
	setAttr ".stringOptions[46].type" -type "string" "integer";
	setAttr ".stringOptions[47].name" -type "string" "environment lighting scale";
	setAttr ".stringOptions[47].value" -type "string" "1 1 1";
	setAttr ".stringOptions[47].type" -type "string" "color";
	setAttr ".stringOptions[48].name" -type "string" "environment lighting caustic photons";
	setAttr ".stringOptions[48].value" -type "string" "0";
	setAttr ".stringOptions[48].type" -type "string" "integer";
	setAttr ".stringOptions[49].name" -type "string" "environment lighting global illum photons";
	setAttr ".stringOptions[49].value" -type "string" "0";
	setAttr ".stringOptions[49].type" -type "string" "integer";
	setAttr ".stringOptions[50].name" -type "string" "light importance sampling";
	setAttr ".stringOptions[50].value" -type "string" "all";
	setAttr ".stringOptions[50].type" -type "string" "string";
	setAttr ".stringOptions[51].name" -type "string" "light importance sampling quality";
	setAttr ".stringOptions[51].value" -type "string" "1.0";
	setAttr ".stringOptions[51].type" -type "string" "scalar";
	setAttr ".stringOptions[52].name" -type "string" "light importance sampling samples";
	setAttr ".stringOptions[52].value" -type "string" "4";
	setAttr ".stringOptions[52].type" -type "string" "integer";
	setAttr ".stringOptions[53].name" -type "string" "light importance sampling resolution";
	setAttr ".stringOptions[53].value" -type "string" "1.0";
	setAttr ".stringOptions[53].type" -type "string" "scalar";
	setAttr ".stringOptions[54].name" -type "string" "light importance sampling precomputed";
	setAttr ".stringOptions[54].value" -type "string" "false";
	setAttr ".stringOptions[54].type" -type "string" "boolean";
	setAttr ".stringOptions[55].name" -type "string" "mila quality";
	setAttr ".stringOptions[55].value" -type "string" "1.0";
	setAttr ".stringOptions[55].type" -type "string" "scalar";
	setAttr ".stringOptions[56].name" -type "string" "mila glossy quality";
	setAttr ".stringOptions[56].value" -type "string" "1.0";
	setAttr ".stringOptions[56].type" -type "string" "scalar";
	setAttr ".stringOptions[57].name" -type "string" "mila scatter quality";
	setAttr ".stringOptions[57].value" -type "string" "1.0";
	setAttr ".stringOptions[57].type" -type "string" "scalar";
	setAttr ".stringOptions[58].name" -type "string" "mila scatter scale";
	setAttr ".stringOptions[58].value" -type "string" "1.0";
	setAttr ".stringOptions[58].type" -type "string" "scalar";
	setAttr ".stringOptions[59].name" -type "string" "mila diffuse quality";
	setAttr ".stringOptions[59].value" -type "string" "1.0";
	setAttr ".stringOptions[59].type" -type "string" "scalar";
	setAttr ".stringOptions[60].name" -type "string" "mila diffuse detail";
	setAttr ".stringOptions[60].value" -type "string" "false";
	setAttr ".stringOptions[60].type" -type "string" "boolean";
	setAttr ".stringOptions[61].name" -type "string" "mila diffuse detail distance";
	setAttr ".stringOptions[61].value" -type "string" "10.0";
	setAttr ".stringOptions[61].type" -type "string" "scalar";
	setAttr ".stringOptions[62].name" -type "string" "mila use max distance inside";
	setAttr ".stringOptions[62].value" -type "string" "true";
	setAttr ".stringOptions[62].type" -type "string" "boolean";
	setAttr ".stringOptions[63].name" -type "string" "mila clamp output";
	setAttr ".stringOptions[63].value" -type "string" "false";
	setAttr ".stringOptions[63].type" -type "string" "boolean";
	setAttr ".stringOptions[64].name" -type "string" "mila clamp level";
	setAttr ".stringOptions[64].value" -type "string" "1.0";
	setAttr ".stringOptions[64].type" -type "string" "scalar";
	setAttr ".stringOptions[65].name" -type "string" "gi gpu";
	setAttr ".stringOptions[65].value" -type "string" "off";
	setAttr ".stringOptions[65].type" -type "string" "string";
	setAttr ".stringOptions[66].name" -type "string" "gi gpu rays";
	setAttr ".stringOptions[66].value" -type "string" "34";
	setAttr ".stringOptions[66].type" -type "string" "integer";
	setAttr ".stringOptions[67].name" -type "string" "gi gpu passes";
	setAttr ".stringOptions[67].value" -type "string" "4";
	setAttr ".stringOptions[67].type" -type "string" "integer";
	setAttr ".stringOptions[68].name" -type "string" "gi gpu presample density";
	setAttr ".stringOptions[68].value" -type "string" "1.0";
	setAttr ".stringOptions[68].type" -type "string" "scalar";
	setAttr ".stringOptions[69].name" -type "string" "gi gpu presample depth";
	setAttr ".stringOptions[69].value" -type "string" "2";
	setAttr ".stringOptions[69].type" -type "string" "integer";
	setAttr ".stringOptions[70].name" -type "string" "gi gpu filter";
	setAttr ".stringOptions[70].value" -type "string" "1.0";
	setAttr ".stringOptions[70].type" -type "string" "integer";
	setAttr ".stringOptions[71].name" -type "string" "gi gpu depth";
	setAttr ".stringOptions[71].value" -type "string" "3";
	setAttr ".stringOptions[71].type" -type "string" "integer";
	setAttr ".stringOptions[72].name" -type "string" "gi gpu devices";
	setAttr ".stringOptions[72].value" -type "string" "0";
	setAttr ".stringOptions[72].type" -type "string" "integer";
	setAttr ".stringOptions[73].name" -type "string" "shutter shape function";
	setAttr ".stringOptions[73].value" -type "string" "none";
	setAttr ".stringOptions[73].type" -type "string" "string";
	setAttr ".stringOptions[74].name" -type "string" "shutter full open";
	setAttr ".stringOptions[74].value" -type "string" "0.2";
	setAttr ".stringOptions[74].type" -type "string" "scalar";
	setAttr ".stringOptions[75].name" -type "string" "shutter full close";
	setAttr ".stringOptions[75].value" -type "string" "0.8";
	setAttr ".stringOptions[75].type" -type "string" "scalar";
	setAttr ".stringOptions[76].name" -type "string" "gi";
	setAttr ".stringOptions[76].value" -type "string" "off";
	setAttr ".stringOptions[76].type" -type "string" "boolean";
	setAttr ".stringOptions[77].name" -type "string" "gi rays";
	setAttr ".stringOptions[77].value" -type "string" "100";
	setAttr ".stringOptions[77].type" -type "string" "integer";
	setAttr ".stringOptions[78].name" -type "string" "gi depth";
	setAttr ".stringOptions[78].value" -type "string" "0";
	setAttr ".stringOptions[78].type" -type "string" "integer";
	setAttr ".stringOptions[79].name" -type "string" "gi freeze";
	setAttr ".stringOptions[79].value" -type "string" "off";
	setAttr ".stringOptions[79].type" -type "string" "boolean";
	setAttr ".stringOptions[80].name" -type "string" "gi filter";
	setAttr ".stringOptions[80].value" -type "string" "1.0";
	setAttr ".stringOptions[80].type" -type "string" "scalar";
createNode mentalrayFramebuffer -s -n "miDefaultFramebuffer";
	rename -uid "A1A6F8CB-4B7B-54AD-80AE-6BA867E1A81E";
createNode polyCylinder -n "polyCylinder1";
	rename -uid "E2F42EF2-4202-9F48-FFB7-458D18B06430";
	setAttr ".h" 3;
	setAttr ".sa" 50;
	setAttr ".cuv" 3;
createNode deleteComponent -n "deleteComponent1";
	rename -uid "470FE6DC-40BD-8119-16DB-0F986A3436C6";
	setAttr ".dc" -type "componentList" 1 "f[51]";
createNode polyBevel2 -n "polyBevel1";
	rename -uid "7D85E909-45A8-0836-74A4-43A3CDC14E73";
	setAttr ".ics" -type "componentList" 1 "e[0:49]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 1.0565190765994665 0 1;
	setAttr ".ws" yes;
	setAttr ".oaf" yes;
	setAttr ".f" 0.2;
	setAttr ".sg" 2;
	setAttr ".at" 180;
	setAttr ".fn" yes;
	setAttr ".mv" yes;
	setAttr ".mvt" 0.0001;
	setAttr ".sa" 30;
	setAttr ".ma" 180;
	setAttr ".m15" no;
createNode polyExtrudeFace -n "polyExtrudeFace1";
	rename -uid "63B7DD51-480E-1E13-EF6C-53B40F482FAA";
	setAttr ".ics" -type "componentList" 1 "f[0:150]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 1.5397311913879825 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -2.9802322e-007 1.5397311 -2.682209e-007 ;
	setAttr ".rs" 55968;
	setAttr ".lt" -type "double3" -4.0452260681791974e-016 -1.1275702593849246e-017 
		0.13 ;
	setAttr ".c[0]"  0 1 1;
	setAttr ".m12" no;
	setAttr ".cbn" -type "double3" -1.0000005960464478 0.039731191387982534 -0.99802756309509277 ;
	setAttr ".cbx" -type "double3" 1 3.0397311913879825 0.99802702665328979 ;
createNode blinn -n "blinn1";
	rename -uid "A579AD9C-4038-73D1-3DE7-05AA25612AA9";
	setAttr ".rfi" 1.4922221899032593;
	setAttr ".rfc" yes;
	setAttr ".dc" 0.82051283121109009;
	setAttr ".c" -type "float3" 0.58974594 0.58974594 0.58974594 ;
	setAttr ".it" -type "float3" 0.97436482 0.97436482 0.97436482 ;
	setAttr ".fll" 3;
	setAttr ".sc" -type "float3" 4 4 4 ;
	setAttr ".rfl" 0.21367521584033966;
	setAttr ".ec" 0.17092308402061462;
	setAttr ".sro" 0.13675214350223541;
	setAttr ".mirfb" 0.30000001192092896;
	setAttr ".mirfl" 2;
	setAttr ".mircb" 10;
	setAttr ".mircr" 2;
	setAttr ".mircl" 5;
createNode shadingEngine -n "blinn1SG";
	rename -uid "0FD544D9-4670-580B-78E2-EE99AC6CC6E0";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
	rename -uid "56EA1AB0-46A2-2FD3-0D9D-70B443EFA080";
createNode polyCylinder -n "polyCylinder2";
	rename -uid "57043372-4AFE-4F31-4F3F-42B3020383B3";
	setAttr ".sc" 1;
	setAttr ".cuv" 3;
createNode bifrostLiquidMaterial -n "bifrostLiquidMaterial1";
	rename -uid "DFF4BA80-4B21-2384-0891-C48BDBDD9BDF";
	setAttr ".dc" -type "float3" 0.80000001 0.80000001 0.80000001 ;
	setAttr -s 2 ".dcrm";
	setAttr ".dcrm[0].dcrmp" 0;
	setAttr ".dcrm[0].dcrmcv" -type "float3" 0 0 0 ;
	setAttr ".dcrm[0].dcrmi" 1;
	setAttr ".dcrm[1].dcrmp" 1;
	setAttr ".dcrm[1].dcrmcv" -type "float3" 1 1 1 ;
	setAttr ".dcrm[1].dcrmi" 1;
	setAttr -s 2 ".dcvrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".fcrm";
	setAttr ".fcrm[0].fcrmp" 0;
	setAttr ".fcrm[0].fcrmcv" -type "float3" 0 0 0 ;
	setAttr ".fcrm[0].fcrmi" 1;
	setAttr ".fcrm[1].fcrmp" 1;
	setAttr ".fcrm[1].fcrmcv" -type "float3" 1 1 1 ;
	setAttr ".fcrm[1].fcrmi" 1;
	setAttr -s 2 ".fcvrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".fwrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".rlcrm";
	setAttr ".rlcrm[0].rlcrmp" 0;
	setAttr ".rlcrm[0].rlcrmcv" -type "float3" 0 0 0 ;
	setAttr ".rlcrm[0].rlcrmi" 1;
	setAttr ".rlcrm[1].rlcrmp" 1;
	setAttr ".rlcrm[1].rlcrmcv" -type "float3" 1 1 1 ;
	setAttr ".rlcrm[1].rlcrmi" 1;
	setAttr -s 2 ".rlcvrm[0:1]"  0 0 1 1 1 1;
	setAttr ".rlw" 0.78761059045791626;
	setAttr -s 2 ".rlwrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".rrcrm";
	setAttr ".rrcrm[0].rrcrmp" 0;
	setAttr ".rrcrm[0].rrcrmcv" -type "float3" 0 0 0 ;
	setAttr ".rrcrm[0].rrcrmi" 1;
	setAttr ".rrcrm[1].rrcrmp" 1;
	setAttr ".rrcrm[1].rrcrmcv" -type "float3" 1 1 1 ;
	setAttr ".rrcrm[1].rrcrmi" 1;
	setAttr -s 2 ".rrcvrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".trm[0:1]"  0 0 1 1 1 1;
createNode shadingEngine -n "bifrostLiquidMaterial1SG";
	rename -uid "FA6D9656-4B84-974C-ABBE-27A34301333B";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode mib_data_string -n "bifrostMeshMRUserData1";
	rename -uid "18EAA819-4628-CB17-621B-EC805EE5324E";
	setAttr ".nam" -type "string" "bifrostMeshObject";
createNode bifrostAttrNotifier -n "pCylinderShape2AttrNotif";
	rename -uid "0CEFC5E0-45E5-7457-E22F-479F2FB03ACE";
	addAttr -ci true -sn "bifrostLiquidEnable" -ln "bifrostLiquidEnable" -dv 1 -min 
		0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostLiquidContinuousEmission" -ln "bifrostLiquidContinuousEmission" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostLiquidThickness" -ln "bifrostLiquidThickness" -at "double";
	addAttr -ci true -sn "bifrostLiquidMode" -ln "bifrostLiquidMode" -min 0 -max 1 -en 
		"Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostLiquidDensity" -ln "bifrostLiquidDensity" -dv 1000 
		-at "double";
	addAttr -ci true -sn "bifrostLiquidExpansionRate" -ln "bifrostLiquidExpansionRate" 
		-at "double";
	addAttr -ci true -sn "bifrostLiquidStictionStrength" -ln "bifrostLiquidStictionStrength" 
		-at "double";
	addAttr -ci true -sn "bifrostLiquidStictionBandwidth" -ln "bifrostLiquidStictionBandwidth" 
		-at "double";
	setAttr -k on ".bifrostLiquidEnable";
	setAttr -k on ".bifrostLiquidContinuousEmission";
	setAttr -k on ".bifrostLiquidThickness";
	setAttr -k on ".bifrostLiquidMode";
	setAttr -k on ".bifrostLiquidDensity";
	setAttr -k on ".bifrostLiquidExpansionRate";
	setAttr -k on ".bifrostLiquidStictionStrength";
	setAttr -k on ".bifrostLiquidStictionBandwidth";
createNode createColorSet -n "createColorSet1";
	rename -uid "89594697-4334-70BA-58DE-20B95601C7A1";
	setAttr ".colos" -type "string" "bifrostLiquidDensity";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode createColorSet -n "createColorSet2";
	rename -uid "9571720E-4F7F-DDE3-C053-83B11A92660F";
	setAttr ".colos" -type "string" "bifrostLiquidExpansionRate";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode bifrostAttrNotifier -n "pCylinderShape1AttrNotif";
	rename -uid "E8454F84-4601-2147-92A7-08806F269AB9";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode bifrostAttrNotifier -n "bifrostKillplane1AttrNotif";
	rename -uid "0C82104E-4BF7-A527-A210-7F99FFFDFFEA";
createNode createColorSet -n "createColorSet3";
	rename -uid "D5BC7EF9-4925-E185-08EF-B2A0CA13CC69";
	setAttr ".colos" -type "string" "bifrostAcceleratorInfluence";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode bifrostAttrNotifier -n "glassMeshShapeAttrNotif";
	rename -uid "EB9565F3-42DF-903F-D674-B886E0729150";
	addAttr -ci true -sn "bifrostAcceleratorEnable" -ln "bifrostAcceleratorEnable" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostAcceleratorMode" -ln "bifrostAcceleratorMode" -min 
		0 -max 1 -en "Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostAcceleratorInfluence" -ln "bifrostAcceleratorInfluence" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorInheritVelocity" -ln "bifrostAcceleratorInheritVelocity" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorFalloffBandwidth" -ln "bifrostAcceleratorFalloffBandwidth" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirectionMagnitude" -ln "bifrostAcceleratorDirectionMagnitude" 
		-dv 10 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirection" -ln "bifrostAcceleratorDirection" 
		-at "double3" -nc 3;
	addAttr -ci true -sn "bifrostAcceleratorDirectionX" -ln "bifrostAcceleratorDirectionX" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionY" -ln "bifrostAcceleratorDirectionY" 
		-dv 1 -at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionZ" -ln "bifrostAcceleratorDirectionZ" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerStrength" -ln "bifrostAcceleratorBoundaryLayerStrength" 
		-at "double";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerBandwidth" -ln "bifrostAcceleratorBoundaryLayerBandwidth" 
		-dv 1 -at "double";
	setAttr -k on ".bifrostAcceleratorEnable";
	setAttr -k on ".bifrostAcceleratorMode";
	setAttr -k on ".bifrostAcceleratorInfluence";
	setAttr -k on ".bifrostAcceleratorInheritVelocity";
	setAttr -k on ".bifrostAcceleratorFalloffBandwidth";
	setAttr -k on ".bifrostAcceleratorDirectionMagnitude";
	setAttr -k on ".bifrostAcceleratorDirection";
	setAttr -k on ".bifrostAcceleratorDirectionX";
	setAttr -k on ".bifrostAcceleratorDirectionY";
	setAttr -k on ".bifrostAcceleratorDirectionZ";
	setAttr -k on ".bifrostAcceleratorBoundaryLayerStrength";
	setAttr -k on ".bifrostAcceleratorBoundaryLayerBandwidth";
createNode createColorSet -n "createColorSet4";
	rename -uid "22C82CA0-471F-C0A3-B496-4A837C3588E3";
	setAttr ".colos" -type "string" "bifrostAcceleratorInfluence";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "2D8016FC-4ED0-FA4C-29D6-67A10E23B81C";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 300 -ast 1 -aet 300 ";
	setAttr ".st" 6;
createNode misss_fast_shader2_x -n "misss_fast_shader2_x1";
	rename -uid "EE1FBAE8-47C0-4B27-613D-C58C773CA349";
	setAttr ".S06" 0.30000001192092896;
	setAttr ".S07" -type "float3" 1 1 1 ;
	setAttr ".S08" 1;
	setAttr ".S09" -type "float3" 20 18 17 ;
	setAttr ".S11" -type "float3" 0.82081604 0.89932096 0.97600001 ;
	setAttr ".S12" 2;
	setAttr ".S13" -type "float3" 20 19 15 ;
	setAttr ".S15" 4;
	setAttr ".S16" 1;
	setAttr ".S17" 4;
	setAttr ".S20" 2000;
createNode shadingEngine -n "misss_fast_shader2_x1SG";
	rename -uid "1F6FB084-427F-00C9-8440-1293AD171A6C";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
	rename -uid "4D29DDF4-42BE-C239-9EED-AA9C057E0E60";
createNode mentalrayTexture -n "mentalrayTexture1";
	rename -uid "AFF5E642-4DCE-4812-2B9B-D08830E44BC0";
	setAttr ".miw" yes;
	setAttr ".miwd" 1920;
	setAttr ".mihg" 1080;
	setAttr ".midp" 4;
	setAttr ".cp" 2;
createNode misss_fast_lmap_maya -n "misss_fast_lmap_maya1";
	rename -uid "B633D008-4336-ED66-73B8-ED9EFE79C3FC";
	setAttr ".S04" -type "float3" 0.030485 0.032769062 0.035 ;
createNode mentalrayOptions -s -n "miContourPreset";
	rename -uid "06B1016E-49DE-72B9-F1B6-FABF603794A9";
	setAttr ".splck" yes;
	setAttr ".fil" 0;
	setAttr ".rflr" 1;
	setAttr ".rfrr" 1;
	setAttr ".maxr" 1;
	setAttr ".shrd" 2;
createNode mia_material_x -n "mia_material_x1";
	rename -uid "F767E37D-43BD-C45B-8C8C-B4980F94CB80";
	setAttr ".S00" 0;
	setAttr ".S01" -type "float3" 0 0 0 ;
	setAttr ".S03" 0.35042735934257507;
	setAttr ".S05" 0.64401710033416748;
	setAttr ".S13" 1.3179486989974976;
	setAttr ".S22" yes;
createNode shadingEngine -n "mia_material_x1SG";
	rename -uid "FA4B4D2A-4A1F-81ED-6FC3-9C9CEDAC4F12";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
	rename -uid "4E189BD2-44FC-99D1-F4DD-CBAF19E7B91C";
createNode animCurveTA -n "persp_rotateX";
	rename -uid "2C788938-4EB4-4E12-28BE-7D8486523AD0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 -1.5383527296062423 300 -3.9383527296062426;
createNode animCurveTA -n "persp_rotateY";
	rename -uid "929D83E8-496D-E53E-A16A-BDAE87608D2A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 3.0000000000000973 300 2.6000000000000894;
createNode animCurveTA -n "persp_rotateZ";
	rename -uid "4C7FB2FB-49F8-CB04-4391-7B8B08DC8C5B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 1.2441091808405437e-017 300 0;
createNode animCurveTU -n "persp_visibility";
	rename -uid "FB172C6E-4605-28AB-3B23-63BEB04EC413";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 0 300 0;
	setAttr -s 2 ".kot[0:1]"  5 5;
createNode animCurveTL -n "persp_translateX";
	rename -uid "3C375615-4C5A-4F7E-B3E5-979BE46F2BD7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 0.18089266237085344 300 0.031781454851275502;
createNode animCurveTL -n "persp_translateY";
	rename -uid "B6F97BCA-40D9-2C03-D7D2-F0A1A78FE5CE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 1.7379664704108175 300 1.8763369932840195;
createNode animCurveTL -n "persp_translateZ";
	rename -uid "163C60E2-4FFB-CA92-7A10-7C9313CECF38";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 7.6121361909908671 300 4.0815699543133155;
createNode animCurveTU -n "persp_scaleX";
	rename -uid "BA0E3D6D-4A89-ACCB-8871-C9A8CF939A23";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 1 300 1;
createNode animCurveTU -n "persp_scaleY";
	rename -uid "343B89DD-4245-668C-6E34-12BA210502C8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 1 300 1;
createNode animCurveTU -n "persp_scaleZ";
	rename -uid "805F5779-4D46-B59C-0B64-3AB70ED78CC4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  100 1 300 1;
createNode pointMatrixMult -n "pointMatrixMult1";
	rename -uid "3C4A4B7C-4AD9-6989-E5EF-D387EB94662F";
	setAttr ".ip" -type "double3" 0 -1 0 ;
	setAttr ".vm" yes;
createNode animCurveTU -n "milkEmitterShape_bifrostAcceleratorDirectionMagnitude";
	rename -uid "9C86ACD7-4CEF-0EDD-3D53-E4BFC70FEC7D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 5 ".ktv[0:4]"  1 10 15 50 60 9 199 4 230 0;
createNode animCurveTU -n "milkEmitterShape_bifrostLiquidEnable";
	rename -uid "EB19E579-4BC5-626C-1D80-3A829A977CD3";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  216 1 219 0;
	setAttr -s 2 ".kot[0:1]"  5 5;
createNode polyBevel2 -n "polyBevel2";
	rename -uid "564D72AE-4459-9F39-BFC8-DAB05DE8DD7C";
	setAttr ".ics" -type "componentList" 50 "e[0:49]" "e[603]" "e[607]" "e[610]" "e[613]" "e[616]" "e[619]" "e[622]" "e[625]" "e[628]" "e[631]" "e[634]" "e[637]" "e[640]" "e[643]" "e[646]" "e[649]" "e[652]" "e[655]" "e[658]" "e[661]" "e[664]" "e[667]" "e[670]" "e[673]" "e[676]" "e[679]" "e[682]" "e[685]" "e[688]" "e[691]" "e[694]" "e[697]" "e[700]" "e[703]" "e[706]" "e[709]" "e[712]" "e[715]" "e[718]" "e[721]" "e[724]" "e[727]" "e[730]" "e[733]" "e[736]" "e[739]" "e[742]" "e[745]" "e[748:749]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 1.605583116404238 0 1;
	setAttr ".ws" yes;
	setAttr ".oaf" yes;
	setAttr ".f" 0.2;
	setAttr ".at" 180;
	setAttr ".fn" yes;
	setAttr ".mv" yes;
	setAttr ".mvt" 0.0001;
	setAttr ".sa" 30;
	setAttr ".ma" 180;
	setAttr ".m15" no;
createNode polySmoothFace -n "polySmoothFace1";
	rename -uid "F9C541CB-47F5-121E-D0D9-E98F5EF03BBF";
	setAttr ".ics" -type "componentList" 1 "f[*]";
	setAttr ".sdt" 2;
	setAttr ".dv" 2;
	setAttr ".suv" yes;
	setAttr ".bnr" 0;
	setAttr ".ps" 0.10000000149011612;
	setAttr ".ro" 1;
	setAttr ".ma" yes;
	setAttr ".m08" yes;
createNode animCurveTA -n "milkEmitter_rotateX";
	rename -uid "92717A04-4312-D6E0-481B-39AF6782FCAB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  31 0 80 0.32484207884174604;
createNode animCurveTA -n "milkEmitter_rotateY";
	rename -uid "0141E101-4C68-1AD7-138B-3DA0340899DC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  31 0 80 0.84285935221547936;
createNode animCurveTA -n "milkEmitter_rotateZ";
	rename -uid "D861EA76-4A13-FE45-E687-78A2F75AFB23";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  31 -49.450883107335756 80 -34.06737607327495;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "190E4409-4F85-0413-DC06-FCA5A77E1C31";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"top\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n"
		+ "                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n"
		+ "                -rendererName \"vp2Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 1\n                -height 1\n                -sceneRenderFilter 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n"
		+ "                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n"
		+ "            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n"
		+ "            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n"
		+ "        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"side\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n"
		+ "                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -rendererName \"vp2Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n"
		+ "                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n"
		+ "                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 1\n                -height 1\n                -sceneRenderFilter 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n"
		+ "            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n"
		+ "            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n"
		+ "            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"front\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -rendererName \"vp2Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n"
		+ "                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n"
		+ "                -width 1\n                -height 1\n                -sceneRenderFilter 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n"
		+ "            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n"
		+ "            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n"
		+ "            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"milkPourCam\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n"
		+ "                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -rendererName \"vp2Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n"
		+ "                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n"
		+ "                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 1615\n                -height 851\n                -sceneRenderFilter 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"milkPourCam\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n"
		+ "            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n"
		+ "            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1615\n            -height 851\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n"
		+ "            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n                -docTag \"isolOutln_fromSeln\" \n                -showShapes 0\n                -showReferenceNodes 1\n                -showReferenceMembers 1\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 1\n                -showAssets 1\n                -showContainedOnly 1\n                -showPublishedAsConnected 0\n                -showContainerContents 1\n                -ignoreDagHierarchy 0\n"
		+ "                -expandConnections 0\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n"
		+ "                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 0\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n"
		+ "            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n"
		+ "            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n"
		+ "                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n"
		+ "                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n"
		+ "                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n"
		+ "                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n"
		+ "                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n"
		+ "                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n"
		+ "                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n"
		+ "                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n"
		+ "                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"sequenceEditorPanel\" -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n"
		+ "                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n"
		+ "                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n"
		+ "                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"createNodePanel\" -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" (localizedPanelLabel(\"Blend Shape\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"profilerPanel\" -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"Stereo\" -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels `;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"milkPourCam\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n"
		+ "                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n"
		+ "                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n"
		+ "                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 0\n                -height 0\n                -sceneRenderFilter 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n            stereoCameraView -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"milkPourCam\" \n                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n"
		+ "                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 0\n                -height 0\n                -sceneRenderFilter 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n"
		+ "                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n            stereoCameraView -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -activeTab -1\n                -editorMode \"default\" \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -activeTab -1\n                -editorMode \"default\" \n"
		+ "                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"milkPourCam\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1615\\n    -height 851\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"milkPourCam\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1615\\n    -height 851\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode bifrostAttrNotifier -n "milkEmitterShapeAttrNotif";
	rename -uid "831F0886-438D-2D7D-1FCD-479336D60CB8";
	addAttr -ci true -sn "bifrostAcceleratorEnable" -ln "bifrostAcceleratorEnable" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostAcceleratorMode" -ln "bifrostAcceleratorMode" -min 
		0 -max 1 -en "Solid:Shell" -at "enum";
	addAttr -ci true -sn "bifrostAcceleratorInfluence" -ln "bifrostAcceleratorInfluence" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorInheritVelocity" -ln "bifrostAcceleratorInheritVelocity" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorFalloffBandwidth" -ln "bifrostAcceleratorFalloffBandwidth" 
		-dv 1 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirectionMagnitude" -ln "bifrostAcceleratorDirectionMagnitude" 
		-dv 10 -at "double";
	addAttr -ci true -sn "bifrostAcceleratorDirection" -ln "bifrostAcceleratorDirection" 
		-at "double3" -nc 3;
	addAttr -ci true -sn "bifrostAcceleratorDirectionX" -ln "bifrostAcceleratorDirectionX" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionY" -ln "bifrostAcceleratorDirectionY" 
		-dv 1 -at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorDirectionZ" -ln "bifrostAcceleratorDirectionZ" 
		-at "double" -p "bifrostAcceleratorDirection";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerStrength" -ln "bifrostAcceleratorBoundaryLayerStrength" 
		-at "double";
	addAttr -ci true -sn "bifrostAcceleratorBoundaryLayerBandwidth" -ln "bifrostAcceleratorBoundaryLayerBandwidth" 
		-dv 1 -at "double";
	setAttr -k on ".bifrostAcceleratorEnable";
	setAttr -k on ".bifrostAcceleratorMode";
	setAttr -k on ".bifrostAcceleratorInfluence";
	setAttr -k on ".bifrostAcceleratorInheritVelocity";
	setAttr -k on ".bifrostAcceleratorFalloffBandwidth";
	setAttr -k on ".bifrostAcceleratorDirectionMagnitude";
	setAttr -k on ".bifrostAcceleratorDirection";
	setAttr -k on ".bifrostAcceleratorDirectionX";
	setAttr -k on ".bifrostAcceleratorDirectionY";
	setAttr -k on ".bifrostAcceleratorDirectionZ";
	setAttr -k on ".bifrostAcceleratorBoundaryLayerStrength";
	setAttr -k on ".bifrostAcceleratorBoundaryLayerBandwidth";
createNode createColorSet -n "createColorSet5";
	rename -uid "B717E646-4305-5CB9-0CDB-D886A7BBBAC2";
	setAttr ".colos" -type "string" "bifrostAcceleratorInfluence1";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode nodeGraphEditorInfo -n "hyperShadePrimaryNodeEditorSavedTabsInfo";
	rename -uid "21C6B259-4C49-F49A-457D-7688628CC914";
	setAttr ".pee" yes;
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" 0 -30.95237972244389 ;
	setAttr ".tgi[0].vh" -type "double2" 114.28570974440821 0 ;
	setAttr -s 61 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[0].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[0].nvs" 1922;
	setAttr ".tgi[0].ni[1].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[1].y" -2915.71435546875;
	setAttr ".tgi[0].ni[1].nvs" 1923;
	setAttr ".tgi[0].ni[2].x" 2192.857177734375;
	setAttr ".tgi[0].ni[2].y" -5527.14306640625;
	setAttr ".tgi[0].ni[2].nvs" 3474;
	setAttr ".tgi[0].ni[3].x" 1457.142822265625;
	setAttr ".tgi[0].ni[3].y" -7304.28564453125;
	setAttr ".tgi[0].ni[3].nvs" 1923;
	setAttr ".tgi[0].ni[4].x" 2192.857177734375;
	setAttr ".tgi[0].ni[4].y" -6554.28564453125;
	setAttr ".tgi[0].ni[4].nvs" 3474;
	setAttr ".tgi[0].ni[5].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[5].y" -2332.857177734375;
	setAttr ".tgi[0].ni[5].nvs" 1923;
	setAttr ".tgi[0].ni[6].x" 3027.142822265625;
	setAttr ".tgi[0].ni[6].y" -5112.85693359375;
	setAttr ".tgi[0].ni[6].nvs" 3058;
	setAttr ".tgi[0].ni[7].x" 255.71427917480469;
	setAttr ".tgi[0].ni[7].y" -3502.857177734375;
	setAttr ".tgi[0].ni[7].nvs" 1923;
	setAttr ".tgi[0].ni[8].x" 3390;
	setAttr ".tgi[0].ni[8].y" -5254.28564453125;
	setAttr ".tgi[0].ni[8].nvs" 3122;
	setAttr ".tgi[0].ni[9].x" 3760;
	setAttr ".tgi[0].ni[9].y" -6714.28564453125;
	setAttr ".tgi[0].ni[9].nvs" 1923;
	setAttr ".tgi[0].ni[10].x" 3760;
	setAttr ".tgi[0].ni[10].y" -5441.4287109375;
	setAttr ".tgi[0].ni[10].nvs" 1922;
	setAttr ".tgi[0].ni[11].x" 2662.857177734375;
	setAttr ".tgi[0].ni[11].y" -5587.14306640625;
	setAttr ".tgi[0].ni[11].nvs" 1923;
	setAttr ".tgi[0].ni[12].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[12].y" -1697.142822265625;
	setAttr ".tgi[0].ni[12].nvs" 1922;
	setAttr ".tgi[0].ni[13].x" 255.71427917480469;
	setAttr ".tgi[0].ni[13].y" -2920;
	setAttr ".tgi[0].ni[13].nvs" 1923;
	setAttr ".tgi[0].ni[14].x" 250;
	setAttr ".tgi[0].ni[14].y" -2157.142822265625;
	setAttr ".tgi[0].ni[14].nvs" 2050;
	setAttr ".tgi[0].ni[15].x" 255.71427917480469;
	setAttr ".tgi[0].ni[15].y" -1754.2857666015625;
	setAttr ".tgi[0].ni[15].nvs" 1923;
	setAttr ".tgi[0].ni[16].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[16].y" -1031.4285888671875;
	setAttr ".tgi[0].ni[16].nvs" 1922;
	setAttr ".tgi[0].ni[17].x" 111.42857360839844;
	setAttr ".tgi[0].ni[17].y" -5902.85693359375;
	setAttr ".tgi[0].ni[17].nvs" 1922;
	setAttr ".tgi[0].ni[18].x" 372.85714721679687;
	setAttr ".tgi[0].ni[18].y" -5952.85693359375;
	setAttr ".tgi[0].ni[18].nvs" 1922;
	setAttr ".tgi[0].ni[19].x" 634.28570556640625;
	setAttr ".tgi[0].ni[19].y" -5778.5712890625;
	setAttr ".tgi[0].ni[19].nvs" 2210;
	setAttr ".tgi[0].ni[20].x" 921.4285888671875;
	setAttr ".tgi[0].ni[20].y" -5482.85693359375;
	setAttr ".tgi[0].ni[20].nvs" 1922;
	setAttr ".tgi[0].ni[21].x" 2262.857177734375;
	setAttr ".tgi[0].ni[21].y" -4985.71435546875;
	setAttr ".tgi[0].ni[21].nvs" 1923;
	setAttr ".tgi[0].ni[22].x" 2662.857177734375;
	setAttr ".tgi[0].ni[22].y" -5365.71435546875;
	setAttr ".tgi[0].ni[22].nvs" 1923;
	setAttr ".tgi[0].ni[23].x" 921.4285888671875;
	setAttr ".tgi[0].ni[23].y" -6552.85693359375;
	setAttr ".tgi[0].ni[23].nvs" 1922;
	setAttr ".tgi[0].ni[24].x" 3444.28564453125;
	setAttr ".tgi[0].ni[24].y" -6452.85693359375;
	setAttr ".tgi[0].ni[24].nvs" 1923;
	setAttr ".tgi[0].ni[25].x" 3760;
	setAttr ".tgi[0].ni[25].y" -6082.85693359375;
	setAttr ".tgi[0].ni[25].nvs" 1923;
	setAttr ".tgi[0].ni[26].x" 3444.28564453125;
	setAttr ".tgi[0].ni[26].y" -6721.4287109375;
	setAttr ".tgi[0].ni[26].nvs" 1922;
	setAttr ".tgi[0].ni[27].x" 2627.142822265625;
	setAttr ".tgi[0].ni[27].y" -6555.71435546875;
	setAttr ".tgi[0].ni[27].nvs" 2706;
	setAttr ".tgi[0].ni[28].x" 1182.857177734375;
	setAttr ".tgi[0].ni[28].y" -6564.28564453125;
	setAttr ".tgi[0].ni[28].nvs" 1922;
	setAttr ".tgi[0].ni[29].x" 1457.142822265625;
	setAttr ".tgi[0].ni[29].y" -6564.28564453125;
	setAttr ".tgi[0].ni[29].nvs" 1922;
	setAttr ".tgi[0].ni[30].x" 2657.142822265625;
	setAttr ".tgi[0].ni[30].y" -5835.71435546875;
	setAttr ".tgi[0].ni[30].nvs" 2034;
	setAttr ".tgi[0].ni[31].x" 255.71427917480469;
	setAttr ".tgi[0].ni[31].y" -1201.4285888671875;
	setAttr ".tgi[0].ni[31].nvs" 1922;
	setAttr ".tgi[0].ni[32].x" 1822.857177734375;
	setAttr ".tgi[0].ni[32].y" -6568.5712890625;
	setAttr ".tgi[0].ni[32].nvs" 1922;
	setAttr ".tgi[0].ni[33].x" 2592.857177734375;
	setAttr ".tgi[0].ni[33].y" -6121.4287109375;
	setAttr ".tgi[0].ni[33].nvs" 3474;
	setAttr ".tgi[0].ni[34].x" 1182.857177734375;
	setAttr ".tgi[0].ni[34].y" -5834.28564453125;
	setAttr ".tgi[0].ni[34].nvs" 1922;
	setAttr ".tgi[0].ni[35].x" 500;
	setAttr ".tgi[0].ni[35].y" -3547.142822265625;
	setAttr ".tgi[0].ni[35].nvs" 1922;
	setAttr ".tgi[0].ni[36].x" 3760;
	setAttr ".tgi[0].ni[36].y" -4505.71435546875;
	setAttr ".tgi[0].ni[36].nvs" 1923;
	setAttr ".tgi[0].ni[37].x" 4021.428466796875;
	setAttr ".tgi[0].ni[37].y" -5090;
	setAttr ".tgi[0].ni[37].nvs" 1923;
	setAttr ".tgi[0].ni[38].x" 3444.28564453125;
	setAttr ".tgi[0].ni[38].y" -4882.85693359375;
	setAttr ".tgi[0].ni[38].nvs" 1922;
	setAttr ".tgi[0].ni[39].x" 3760;
	setAttr ".tgi[0].ni[39].y" -5011.4287109375;
	setAttr ".tgi[0].ni[39].nvs" 1922;
	setAttr ".tgi[0].ni[40].x" 3444.28564453125;
	setAttr ".tgi[0].ni[40].y" -4307.14306640625;
	setAttr ".tgi[0].ni[40].nvs" 1923;
	setAttr ".tgi[0].ni[41].x" 3760;
	setAttr ".tgi[0].ni[41].y" -4252.85693359375;
	setAttr ".tgi[0].ni[41].nvs" 1923;
	setAttr ".tgi[0].ni[42].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[42].y" -561.4285888671875;
	setAttr ".tgi[0].ni[42].nvs" 1922;
	setAttr ".tgi[0].ni[43].x" 255.71427917480469;
	setAttr ".tgi[0].ni[43].y" -565.71429443359375;
	setAttr ".tgi[0].ni[43].nvs" 1922;
	setAttr ".tgi[0].ni[44].x" 510;
	setAttr ".tgi[0].ni[44].y" -2897.142822265625;
	setAttr ".tgi[0].ni[44].nvs" 1922;
	setAttr ".tgi[0].ni[45].x" 510;
	setAttr ".tgi[0].ni[45].y" -2337.142822265625;
	setAttr ".tgi[0].ni[45].nvs" 1922;
	setAttr ".tgi[0].ni[46].x" 510;
	setAttr ".tgi[0].ni[46].y" -1754.2857666015625;
	setAttr ".tgi[0].ni[46].nvs" 1922;
	setAttr ".tgi[0].ni[47].x" 510;
	setAttr ".tgi[0].ni[47].y" -1171.4285888671875;
	setAttr ".tgi[0].ni[47].nvs" 1922;
	setAttr ".tgi[0].ni[48].x" 510;
	setAttr ".tgi[0].ni[48].y" -588.5714111328125;
	setAttr ".tgi[0].ni[48].nvs" 1922;
	setAttr ".tgi[0].ni[49].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[49].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[49].nvs" 1922;
	setAttr ".tgi[0].ni[50].x" 255.71427917480469;
	setAttr ".tgi[0].ni[50].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[50].nvs" 1922;
	setAttr ".tgi[0].ni[51].x" 510;
	setAttr ".tgi[0].ni[51].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[51].nvs" 1922;
	setAttr ".tgi[0].ni[52].x" 1822.857177734375;
	setAttr ".tgi[0].ni[52].y" -7327.14306640625;
	setAttr ".tgi[0].ni[52].nvs" 1922;
	setAttr ".tgi[0].ni[53].x" 1730;
	setAttr ".tgi[0].ni[53].y" -6838.5712890625;
	setAttr ".tgi[0].ni[53].nvs" 1922;
	setAttr ".tgi[0].ni[54].x" 1788.5714111328125;
	setAttr ".tgi[0].ni[54].y" -7085.71435546875;
	setAttr ".tgi[0].ni[54].nvs" 1922;
	setAttr ".tgi[0].ni[55].x" 1444.2857666015625;
	setAttr ".tgi[0].ni[55].y" -5694.28564453125;
	setAttr ".tgi[0].ni[55].nvs" 2210;
	setAttr ".tgi[0].ni[56].x" 1822.857177734375;
	setAttr ".tgi[0].ni[56].y" -5747.14306640625;
	setAttr ".tgi[0].ni[56].nvs" 1922;
	setAttr ".tgi[0].ni[57].x" 1182.857177734375;
	setAttr ".tgi[0].ni[57].y" -6981.4287109375;
	setAttr ".tgi[0].ni[57].nvs" 1922;
	setAttr ".tgi[0].ni[58].x" 1182.857177734375;
	setAttr ".tgi[0].ni[58].y" -7281.4287109375;
	setAttr ".tgi[0].ni[58].nvs" 1922;
	setAttr ".tgi[0].ni[59].x" 1182.857177734375;
	setAttr ".tgi[0].ni[59].y" -7581.4287109375;
	setAttr ".tgi[0].ni[59].nvs" 1922;
	setAttr ".tgi[0].ni[60].x" 764.28570556640625;
	setAttr ".tgi[0].ni[60].y" -3547.142822265625;
	setAttr ".tgi[0].ni[60].nvs" 1922;
createNode animCurveTU -n "milkEmitterShape_bifrostAcceleratorDirectionMagnitude1";
	rename -uid "6FA9F990-4B1E-2D1E-B4F9-05B05EB70839";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 5 ".ktv[0:4]"  1 10 15 50 60 9 199 4 230 0;
createNode nodeGraphEditorInfo -n "MayaNodeEditorSavedTabsInfo";
	rename -uid "E17BDEA9-468B-9A7C-9D13-058700C64E81";
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -605.9523568739977 -291.66665507687509 ;
	setAttr ".tgi[0].vh" -type "double2" 597.61902387180123 301.19046422224244 ;
	setAttr -s 5 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" -408.09521484375;
	setAttr ".tgi[0].ni[0].y" 87.857139587402344;
	setAttr ".tgi[0].ni[0].nvs" 18304;
	setAttr ".tgi[0].ni[1].x" 219.047607421875;
	setAttr ".tgi[0].ni[1].y" -51.190475463867187;
	setAttr ".tgi[0].ni[1].nvs" 18304;
	setAttr ".tgi[0].ni[2].x" 107.14286041259766;
	setAttr ".tgi[0].ni[2].y" 66.666664123535156;
	setAttr ".tgi[0].ni[2].nvs" 18304;
	setAttr ".tgi[0].ni[3].x" -60.714282989501953;
	setAttr ".tgi[0].ni[3].y" -44.047618865966797;
	setAttr ".tgi[0].ni[3].nvs" 18304;
	setAttr ".tgi[0].ni[4].x" 96.428573608398438;
	setAttr ".tgi[0].ni[4].y" 151.19047546386719;
	setAttr ".tgi[0].ni[4].nvs" 18304;
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
select -ne :renderPartition;
	setAttr -s 6 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 8 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 2 ".u";
select -ne :defaultRenderingList1;
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
connectAttr "persp_rotateX.o" ":persp.rx";
connectAttr "persp_rotateY.o" ":persp.ry";
connectAttr "persp_rotateZ.o" ":persp.rz";
connectAttr "persp_visibility.o" ":persp.v";
connectAttr "persp_translateX.o" ":persp.tx";
connectAttr "persp_translateY.o" ":persp.ty";
connectAttr "persp_translateZ.o" ":persp.tz";
connectAttr "persp_scaleX.o" ":persp.sx";
connectAttr "persp_scaleY.o" ":persp.sy";
connectAttr "persp_scaleZ.o" ":persp.sz";
connectAttr "polySmoothFace1.out" "glassMeshShape.i";
connectAttr "milkEmitter_rotateX.o" "milkEmitter.rx";
connectAttr "milkEmitter_rotateY.o" "milkEmitter.ry";
connectAttr "milkEmitter_rotateZ.o" "milkEmitter.rz";
connectAttr "milkEmitterShape_bifrostLiquidEnable.o" "milkEmitterShape.bifrostLiquidEnable"
		;
connectAttr "milkEmitterShape_bifrostAcceleratorDirectionMagnitude1.o" "milkEmitterShape.bifrostAcceleratorDirectionMagnitude"
		;
connectAttr "pointMatrixMult1.o" "milkEmitterShape.bifrostAcceleratorDirection";
connectAttr "createColorSet5.og" "milkEmitterShape.i";
connectAttr ":time1.o" "bifrostLiquidContainer1.ctm";
connectAttr "pCylinderShape2AttrNotif.om" "bifrostLiquidContainer1.Emitters[0]";
connectAttr "pCylinderShape1AttrNotif.om" "bifrostLiquidContainer1.Colliders[0]"
		;
connectAttr "bifrostKillplane1.wm" "bifrostLiquidContainer1.killplanes[0]";
connectAttr "milkEmitterShapeAttrNotif.om" "bifrostLiquidContainer1.Accelerators[0]"
		;
connectAttr "glassMeshShapeAttrNotif.om" "bifrostLiquidContainer1.Accelerators[1]"
		;
connectAttr "bifrostLiquidContainer1.Liquid" "bifrostShape1.obj";
connectAttr "bifrostMeshMRUserData1.msg" "bifrostMesh1.miData";
connectAttr "bifrostShape1.mout" "bifrostMeshShape1.i";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bifrostLiquidMaterial1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "misss_fast_shader2_x1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "mia_material_x1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bifrostLiquidMaterial1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "misss_fast_shader2_x1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "mia_material_x1SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":mentalrayGlobals.msg" ":mentalrayItemsList.glb";
connectAttr ":miDefaultOptions.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miContourPreset.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayItemsList.fb" -na;
connectAttr ":miDefaultOptions.msg" ":mentalrayGlobals.opt";
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayGlobals.fb";
connectAttr "mentalrayTexture1.msg" ":mentalrayGlobals.tx[0]";
connectAttr "polyCylinder1.out" "deleteComponent1.ig";
connectAttr "deleteComponent1.og" "polyBevel1.ip";
connectAttr "glassMeshShape.wm" "polyBevel1.mp";
connectAttr "polyBevel1.out" "polyExtrudeFace1.ip";
connectAttr "glassMeshShape.wm" "polyExtrudeFace1.mp";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "glassMeshShape.iog" "blinn1SG.dsm" -na;
connectAttr "blinn1SG.msg" "materialInfo1.sg";
connectAttr "blinn1.msg" "materialInfo1.m";
connectAttr "bifrostLiquidMaterial1.oc" "bifrostLiquidMaterial1SG.ss";
connectAttr "bifrostShape1.iog" "bifrostLiquidMaterial1SG.dsm" -na;
connectAttr "bifrostLiquidContainer1.Liquid" "bifrostMeshMRUserData1.val";
connectAttr "milkEmitterShape.bifrostLiquidEnable" "pCylinderShape2AttrNotif.bifrostLiquidEnable"
		;
connectAttr "milkEmitterShape.bifrostLiquidContinuousEmission" "pCylinderShape2AttrNotif.bifrostLiquidContinuousEmission"
		;
connectAttr "milkEmitterShape.bifrostLiquidThickness" "pCylinderShape2AttrNotif.bifrostLiquidThickness"
		;
connectAttr "milkEmitterShape.bifrostLiquidMode" "pCylinderShape2AttrNotif.bifrostLiquidMode"
		;
connectAttr "milkEmitterShape.bifrostLiquidDensity" "pCylinderShape2AttrNotif.bifrostLiquidDensity"
		;
connectAttr "milkEmitterShape.bifrostLiquidExpansionRate" "pCylinderShape2AttrNotif.bifrostLiquidExpansionRate"
		;
connectAttr "milkEmitterShape.bifrostLiquidStictionStrength" "pCylinderShape2AttrNotif.bifrostLiquidStictionStrength"
		;
connectAttr "milkEmitterShape.bifrostLiquidStictionBandwidth" "pCylinderShape2AttrNotif.bifrostLiquidStictionBandwidth"
		;
connectAttr "milkEmitterShape.w" "pCylinderShape2AttrNotif.im";
connectAttr "polyCylinder2.out" "createColorSet1.ig";
connectAttr "createColorSet1.og" "createColorSet2.ig";
connectAttr "glassMeshShape.bifrostColliderEnable" "pCylinderShape1AttrNotif.bifrostColliderEnable"
		;
connectAttr "glassMeshShape.bifrostColliderThickness" "pCylinderShape1AttrNotif.bifrostColliderThickness"
		;
connectAttr "glassMeshShape.bifrostColliderMode" "pCylinderShape1AttrNotif.bifrostColliderMode"
		;
connectAttr "glassMeshShape.w" "pCylinderShape1AttrNotif.im";
connectAttr "createColorSet2.og" "createColorSet3.ig";
connectAttr "glassMeshShape.bifrostAcceleratorEnable" "glassMeshShapeAttrNotif.bifrostAcceleratorEnable"
		;
connectAttr "glassMeshShape.bifrostAcceleratorMode" "glassMeshShapeAttrNotif.bifrostAcceleratorMode"
		;
connectAttr "glassMeshShape.bifrostAcceleratorInfluence" "glassMeshShapeAttrNotif.bifrostAcceleratorInfluence"
		;
connectAttr "glassMeshShape.bifrostAcceleratorInheritVelocity" "glassMeshShapeAttrNotif.bifrostAcceleratorInheritVelocity"
		;
connectAttr "glassMeshShape.bifrostAcceleratorFalloffBandwidth" "glassMeshShapeAttrNotif.bifrostAcceleratorFalloffBandwidth"
		;
connectAttr "glassMeshShape.bifrostAcceleratorDirectionMagnitude" "glassMeshShapeAttrNotif.bifrostAcceleratorDirectionMagnitude"
		;
connectAttr "glassMeshShape.bifrostAcceleratorDirection" "glassMeshShapeAttrNotif.bifrostAcceleratorDirection"
		;
connectAttr "glassMeshShape.bifrostAcceleratorBoundaryLayerStrength" "glassMeshShapeAttrNotif.bifrostAcceleratorBoundaryLayerStrength"
		;
connectAttr "glassMeshShape.bifrostAcceleratorBoundaryLayerBandwidth" "glassMeshShapeAttrNotif.bifrostAcceleratorBoundaryLayerBandwidth"
		;
connectAttr "glassMeshShape.w" "glassMeshShapeAttrNotif.im";
connectAttr "polyExtrudeFace1.out" "createColorSet4.ig";
connectAttr "mentalrayTexture1.msg" "misss_fast_shader2_x1.s00";
connectAttr "mia_material_x1.msg" "misss_fast_shader2_x1.S05";
connectAttr "misss_fast_shader2_x1.msg" "misss_fast_shader2_x1SG.mims";
connectAttr "bifrostMeshShape1.iog" "misss_fast_shader2_x1SG.dsm" -na;
connectAttr "misss_fast_lmap_maya1.msg" "misss_fast_shader2_x1SG.milm";
connectAttr "misss_fast_shader2_x1SG.msg" "materialInfo2.sg";
connectAttr "misss_fast_shader2_x1.msg" "materialInfo2.m";
connectAttr "mentalrayTexture1.msg" "misss_fast_lmap_maya1.s00";
connectAttr "mia_material_x1.msg" "mia_material_x1SG.mims";
connectAttr "mia_material_x1.msg" "mia_material_x1SG.mips";
connectAttr "mia_material_x1.msg" "mia_material_x1SG.miss";
connectAttr "mia_material_x1SG.msg" "materialInfo3.sg";
connectAttr "mia_material_x1.msg" "materialInfo3.m";
connectAttr "milkEmitter.wm" "pointMatrixMult1.im";
connectAttr "createColorSet4.og" "polyBevel2.ip";
connectAttr "glassMeshShape.wm" "polyBevel2.mp";
connectAttr "polyBevel2.out" "polySmoothFace1.ip";
connectAttr "milkEmitterShape.bifrostAcceleratorEnable" "milkEmitterShapeAttrNotif.bifrostAcceleratorEnable"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorMode" "milkEmitterShapeAttrNotif.bifrostAcceleratorMode"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorInfluence" "milkEmitterShapeAttrNotif.bifrostAcceleratorInfluence"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorInheritVelocity" "milkEmitterShapeAttrNotif.bifrostAcceleratorInheritVelocity"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorFalloffBandwidth" "milkEmitterShapeAttrNotif.bifrostAcceleratorFalloffBandwidth"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorDirectionMagnitude" "milkEmitterShapeAttrNotif.bifrostAcceleratorDirectionMagnitude"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorDirection" "milkEmitterShapeAttrNotif.bifrostAcceleratorDirection"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorBoundaryLayerStrength" "milkEmitterShapeAttrNotif.bifrostAcceleratorBoundaryLayerStrength"
		;
connectAttr "milkEmitterShape.bifrostAcceleratorBoundaryLayerBandwidth" "milkEmitterShapeAttrNotif.bifrostAcceleratorBoundaryLayerBandwidth"
		;
connectAttr "milkEmitterShape.w" "milkEmitterShapeAttrNotif.im";
connectAttr "createColorSet3.og" "createColorSet5.ig";
connectAttr "defaultRenderLayer.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[0].dn"
		;
connectAttr "glassMesh.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[1].dn"
		;
connectAttr "glassMeshShape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "milkEmitter.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[3].dn"
		;
connectAttr "milkEmitterShape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[4].dn"
		;
connectAttr "bifrostLiquid1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[5].dn"
		;
connectAttr "bifrostLiquidContainer1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[6].dn"
		;
connectAttr "bifrost1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[7].dn"
		;
connectAttr "bifrostShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[8].dn"
		;
connectAttr "bifrostMesh1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[9].dn"
		;
connectAttr "bifrostMeshShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[10].dn"
		;
connectAttr "bifrostKillplane1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[11].dn"
		;
connectAttr "bifrostKillplaneShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[12].dn"
		;
connectAttr "spotLight1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[13].dn"
		;
connectAttr "spotLightShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[14].dn"
		;
connectAttr "milkPourCam.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[15].dn"
		;
connectAttr "milkPourCamShape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[16].dn"
		;
connectAttr "polyCylinder1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[17].dn"
		;
connectAttr "deleteComponent1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[18].dn"
		;
connectAttr "polyBevel1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[19].dn"
		;
connectAttr "polyExtrudeFace1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[20].dn"
		;
connectAttr "blinn1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[21].dn"
		;
connectAttr "blinn1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[22].dn"
		;
connectAttr "polyCylinder2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[23].dn"
		;
connectAttr "bifrostLiquidMaterial1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[24].dn"
		;
connectAttr "bifrostLiquidMaterial1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[25].dn"
		;
connectAttr "bifrostMeshMRUserData1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[26].dn"
		;
connectAttr "pCylinderShape2AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[27].dn"
		;
connectAttr "createColorSet1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[28].dn"
		;
connectAttr "createColorSet2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[29].dn"
		;
connectAttr "pCylinderShape1AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[30].dn"
		;
connectAttr "bifrostKillplane1AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[31].dn"
		;
connectAttr "createColorSet3.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[32].dn"
		;
connectAttr "glassMeshShapeAttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[33].dn"
		;
connectAttr "createColorSet4.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[34].dn"
		;
connectAttr "sceneConfigurationScriptNode.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[35].dn"
		;
connectAttr "misss_fast_shader2_x1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[36].dn"
		;
connectAttr "misss_fast_shader2_x1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[37].dn"
		;
connectAttr "mentalrayTexture1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[38].dn"
		;
connectAttr "misss_fast_lmap_maya1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[39].dn"
		;
connectAttr "mia_material_x1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[40].dn"
		;
connectAttr "mia_material_x1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[41].dn"
		;
connectAttr "persp_rotateX.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[42].dn"
		;
connectAttr "persp_rotateY.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[43].dn"
		;
connectAttr "persp_rotateZ.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[44].dn"
		;
connectAttr "persp_visibility.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[45].dn"
		;
connectAttr "persp_translateX.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[46].dn"
		;
connectAttr "persp_translateY.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[47].dn"
		;
connectAttr "persp_translateZ.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[48].dn"
		;
connectAttr "persp_scaleX.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[49].dn"
		;
connectAttr "persp_scaleY.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[50].dn"
		;
connectAttr "persp_scaleZ.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[51].dn"
		;
connectAttr "pointMatrixMult1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[52].dn"
		;
connectAttr "milkEmitterShape_bifrostAcceleratorDirectionMagnitude.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[53].dn"
		;
connectAttr "milkEmitterShape_bifrostLiquidEnable.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[54].dn"
		;
connectAttr "polyBevel2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[55].dn"
		;
connectAttr "polySmoothFace1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[56].dn"
		;
connectAttr "milkEmitter_rotateX.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[57].dn"
		;
connectAttr "milkEmitter_rotateY.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[58].dn"
		;
connectAttr "milkEmitter_rotateZ.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[59].dn"
		;
connectAttr "uiConfigurationScriptNode.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[60].dn"
		;
connectAttr "pointMatrixMult1.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[0].dn"
		;
connectAttr "bifrostLiquidContainer1.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[1].dn"
		;
connectAttr "bifrostLiquid1.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[2].dn";
connectAttr "milkEmitterShape.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[3].dn"
		;
connectAttr "milkEmitter.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[4].dn";
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "bifrostLiquidMaterial1SG.pa" ":renderPartition.st" -na;
connectAttr "misss_fast_shader2_x1SG.pa" ":renderPartition.st" -na;
connectAttr "mia_material_x1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "bifrostLiquidMaterial1.msg" ":defaultShaderList1.s" -na;
connectAttr "misss_fast_shader2_x1.msg" ":defaultShaderList1.s" -na;
connectAttr "mia_material_x1.msg" ":defaultShaderList1.s" -na;
connectAttr "bifrostMeshMRUserData1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "misss_fast_lmap_maya1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "spotLightShape1.ltd" ":lightList1.l" -na;
connectAttr "milkEmitterShape.iog" ":initialShadingGroup.dsm" -na;
connectAttr ":perspShape.msg" ":defaultRenderGlobals.sc";
connectAttr "spotLight1.iog" ":defaultLightSet.dsm" -na;
// End of milkPour.ma
