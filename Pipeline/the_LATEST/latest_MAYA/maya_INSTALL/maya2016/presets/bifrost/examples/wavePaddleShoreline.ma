//Maya ASCII 2016 scene
//Name: wavePaddleShoreline.ma
//Last modified: Tue, Feb 24, 2015 12:50:46 PM
//Codeset: 1252
requires maya "2016";
requires -nodeType "bifrostLiquidMaterial" -nodeType "bifrostShape" "bifrostvisplugin" "3.0";
requires -nodeType "mentalrayFramebuffer" -nodeType "mentalrayOptions" -nodeType "mentalrayGlobals"
		 -nodeType "mentalrayItemsList" -nodeType "mib_data_string" -dataType "byteArray"
		 "Mayatomr" "2016.0 - 3.13.1.2 ";
requires -nodeType "bifrostContainer" -nodeType "bifrostAttrNotifier" "bifrostshellnode" "2015";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2016";
fileInfo "version" "2016";
fileInfo "cutIdentifier" "201502172200-952624";
fileInfo "osv" "Microsoft Windows 7 Business Edition, 64-bit Windows 7 Service Pack 1 (Build 7601)\n";
createNode transform -s -n "persp";
	rename -uid "8555FDC5-49D5-BCD3-9C07-55801BE422C4";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-014 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "6CFF720D-4BCE-A29F-1563-45997828C312";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "E561B8DF-4526-04DF-AC3A-9697A342DF73";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "A38BEDA5-42CB-BE82-728C-A8803F7B2C68";
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
	rename -uid "75C4862C-44F7-DFAB-4156-3D93CAF21F10";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "3B7A067F-4741-74F4-6774-998A3819BCEA";
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
	rename -uid "55A791A4-46EB-4CAB-C4B2-468D85651DC5";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "8D908A5E-44C0-BC87-31D8-9DB6EA2CBA1E";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "shorelineCollision1";
	rename -uid "9DD92B3A-47DB-DDF0-4F12-029681224457";
	setAttr ".s" -type "double3" 28.951226850625243 0.59167269732417838 25.95288359933441 ;
createNode mesh -n "shorelineCollisionShape1" -p "shorelineCollision1";
	rename -uid "6BD15949-4223-B598-2BE4-E9921AEA880B";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.5 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 26 ".pt";
	setAttr ".pt[0]" -type "float3" 0 0.54577881 0.066198163 ;
	setAttr ".pt[1]" -type "float3" 0 0.54577881 0.066198163 ;
	setAttr ".pt[2]" -type "float3" 0 -0.038785659 0.066198163 ;
	setAttr ".pt[3]" -type "float3" 0 -0.038785659 0.066198163 ;
	setAttr ".pt[14]" -type "float3" 0 0.20596005 0.066198163 ;
	setAttr ".pt[15]" -type "float3" 0 0.20596005 0.066198163 ;
	setAttr ".pt[18]" -type "float3" 0 0.54577881 0.066198163 ;
	setAttr ".pt[29]" -type "float3" 0 -1.6878445 0.22809491 ;
	setAttr ".pt[31]" -type "float3" 0 -0.82933664 0.22809491 ;
	setAttr ".pt[36]" -type "float3" 0 -0.82933664 0.22809491 ;
	setAttr ".pt[39]" -type "float3" 0 0.54577881 0.066198163 ;
	setAttr ".pt[42]" -type "float3" 0 0.083587319 0.066198163 ;
	setAttr ".pt[43]" -type "float3" 0 0.083587319 0.066198163 ;
	setAttr ".pt[48]" -type "float3" 0 -1.6878445 0.22809491 ;
	setAttr ".pt[49]" -type "float3" 0 -1.6878445 0.22809491 ;
	setAttr ".pt[54]" -type "float3" 0 0.0015993714 0.22809491 ;
	setAttr ".pt[55]" -type "float3" 0 0.0015993714 0.22809491 ;
	setAttr ".pt[56]" -type "float3" 0 0.37586936 0.066198163 ;
	setAttr ".pt[57]" -type "float3" 0 0.37586936 0.066198163 ;
	setAttr ".pt[60]" -type "float3" 0 0.54577881 0.066198163 ;
	setAttr ".pt[64]" -type "float3" 0 -1.6878445 0.22809491 ;
	setAttr ".pt[66]" -type "float3" 0 -1.6878445 0.22809491 ;
	setAttr ".pt[67]" -type "float3" 0 -0.41386884 0.22809491 ;
	setAttr ".pt[71]" -type "float3" 0 -1.2585905 0.22809491 ;
	setAttr ".pt[72]" -type "float3" 0 -0.41386884 0.22809491 ;
	setAttr ".pt[74]" -type "float3" 0 -1.2585905 0.22809491 ;
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness" 3;
	setAttr -k on ".bifrostColliderMode" 1;
createNode transform -n "waterEmitterMesh1";
	rename -uid "0A50406F-43C8-A8B2-D1D7-1780449C08B3";
	setAttr ".t" -type "double3" 0.054904804359459547 -0.19093122688435527 1.066226379990868 ;
	setAttr ".s" -type "double3" 28.633881770647797 0.26478368776505556 22.624873526964407 ;
createNode mesh -n "waterEmitterMesh1Shape" -p "waterEmitterMesh1";
	rename -uid "A3365F0D-45BA-B55E-3F2C-CDB7F9A1C997";
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
	setAttr -k off ".v" no;
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.5 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ccls" -type "string" "bifrostLiquidExpansionRate";
	setAttr -s 2 ".clst";
	setAttr ".clst[0].clsn" -type "string" "bifrostLiquidDensity";
	setAttr ".clst[0].rprt" 3;
	setAttr ".clst[1].clsn" -type "string" "bifrostLiquidExpansionRate";
	setAttr ".clst[1].rprt" 3;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 6 ".pt";
	setAttr ".pt[0]" -type "float3" 0 -0.85395002 0.026757166 ;
	setAttr ".pt[1]" -type "float3" 0 -0.85395002 0.026757166 ;
	setAttr ".pt[2]" -type "float3" 0 0 0.026757166 ;
	setAttr ".pt[3]" -type "float3" 0 0 0.026757166 ;
	setAttr ".pt[8]" -type "float3" 0 -0.85395002 0 ;
	setAttr ".pt[9]" -type "float3" 0 -0.85395002 0 ;
	setAttr -k on ".bifrostLiquidEnable";
	setAttr -k on ".bifrostLiquidContinuousEmission" no;
	setAttr -k on ".bifrostLiquidThickness";
	setAttr -k on ".bifrostLiquidMode";
	setAttr -k on ".bifrostLiquidDensity";
	setAttr -k on ".bifrostLiquidExpansionRate";
	setAttr -k on ".bifrostLiquidStictionStrength";
	setAttr -k on ".bifrostLiquidStictionBandwidth";
createNode transform -n "wavePaddle1";
	rename -uid "6B9C7F32-46C7-6590-4207-ABB2E2B6E67A";
	setAttr ".t" -type "double3" -2.2861304349530145e-034 -1.3639211261875295 15.865266502382726 ;
	setAttr ".s" -type "double3" 29.234804435064316 5.7484287876827889 0.85316959834136619 ;
	setAttr ".rp" -type "double3" 0 -1.4189969592539562 1.7763568394002509e-015 ;
	setAttr ".sp" -type "double3" 0 -0.49322660584748573 2.0820676719536641e-015 ;
	setAttr ".spt" -type "double3" 0 -0.92577035340647051 -3.0571083255341988e-016 ;
createNode mesh -n "wavePaddleShape1" -p "wavePaddle1";
	rename -uid "F6D7C7CA-4A13-53AB-25B8-518EE8B6AA04";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr -s 4 ".iog[0].og";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode mesh -n "wavePaddleShape3Orig1" -p "wavePaddle1";
	rename -uid "A3BF3390-4366-355C-61CC-3A92D19A1A5B";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "bifrostLiquid1";
	rename -uid "77819C1A-4861-DB63-F4A6-13A1F59154F5";
createNode bifrostContainer -n "bifrostLiquidContainer1" -p "bifrostLiquid1";
	rename -uid "1C13C7FD-4463-2A48-2488-8CA855305BB1";
	addAttr -r false -ci true -k true -m -sn "Emitters" -ln "Emitters" -dt "mesh";
	addAttr -r false -ci true -k true -m -sn "Colliders" -ln "Colliders" -dt "mesh";
	addAttr -r false -ci true -sn "masterVoxelSize" -ln "masterVoxelSize" -at "float";
	addAttr -r false -ci true -k true -m -sn "Accelerators" -ln "Accelerators" -dt "mesh";
	addAttr -r false -ci true -sn "vorticityEnable" -ln "vorticityEnable" -min 0 -max 
		1 -at "bool";
	addAttr -r false -ci true -sn "vorticityDecay" -ln "vorticityDecay" -at "float";
	addAttr -r false -ci true -sn "vorticityMax" -ln "vorticityMax" -at "float";
	addAttr -r false -ci true -sn "gravityMagnitude" -ln "gravityMagnitude" -at "float";
	addAttr -r false -ci true -sn "gravityDirection" -ln "gravityDirection" -at "float3" 
		-nc 3;
	addAttr -r false -ci true -sn "gravityDirectionX" -ln "gravityDirectionX" -at "float" 
		-p "gravityDirection";
	addAttr -r false -ci true -sn "gravityDirectionY" -ln "gravityDirectionY" -at "float" 
		-p "gravityDirection";
	addAttr -r false -ci true -sn "gravityDirectionZ" -ln "gravityDirectionZ" -at "float" 
		-p "gravityDirection";
	addAttr -r false -ci true -sn "solidVoxelScale" -ln "solidVoxelScale" -at "float";
	addAttr -r false -ci true -sn "forceVoxelScale" -ln "forceVoxelScale" -at "float";
	addAttr -r false -ci true -sn "vorticityMult" -ln "vorticityMult" -at "float";
	addAttr -r false -ci true -sn "transportStepAdaptivity" -ln "transportStepAdaptivity" 
		-min 0 -max 1 -at "float";
	addAttr -r false -ci true -sn "transportTimeScale" -ln "transportTimeScale" -at "float";
	addAttr -r false -ci true -sn "minSteps" -ln "minSteps" -at "long";
	addAttr -r false -ci true -sn "maxSteps" -ln "maxSteps" -at "long";
	addAttr -r false -ci true -sn "dropletThreshold" -ln "dropletThreshold" -at "float";
	addAttr -r false -ci true -sn "dropletMergeBackDepth" -ln "dropletMergeBackDepth" 
		-at "float";
	addAttr -r false -ci true -sn "surfaceBandWidth" -ln "surfaceBandWidth" -at "float";
	addAttr -r false -ci true -sn "interiorParticleDensity" -ln "interiorParticleDensity" 
		-at "float";
	addAttr -r false -ci true -sn "surfaceParticleDensity" -ln "surfaceParticleDensity" 
		-at "float";
	addAttr -r false -ci true -k true -m -sn "killplanes" -ln "killplanes" -at "matrix";
	addAttr -w false -s false -sn "Liquid" -ln "Liquid" -dt "string";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -r false -ci true -k true -sn "viscosityScale" -ln "viscosityScale" -at "float";
	addAttr -r false -ci true -k true -sn "surfaceTension" -ln "surfaceTension" -at "float";
	addAttr -r false -ci true -k true -sn "surfaceTensionEnable" -ln "surfaceTensionEnable" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -dcb 0 -ci true -k true -m -sn "cameraMatrixList" -ln "cameraMatrixList" 
		-at "matrix";
	addAttr -r false -ci true -k true -sn "enableFoam" -ln "enableFoam" -min 0 -max 
		1 -at "bool";
	addAttr -r false -ci true -k true -sn "enableGuiding" -ln "enableGuiding" -min 0 
		-max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "computeGuideFromHighResLiquid" -ln "computeGuideFromHighResLiquid" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "minSimulationDepth" -ln "minSimulationDepth" 
		-at "float";
	addAttr -r false -ci true -k true -sn "guideVoxelScale" -ln "guideVoxelScale" -at "float";
	addAttr -r false -ci true -k true -sn "reseedParticleDensity" -ln "reseedParticleDensity" 
		-at "float";
	addAttr -r false -ci true -k true -sn "reseedGuideOverlap" -ln "reseedGuideOverlap" 
		-at "float";
	addAttr -r false -ci true -k true -sn "reseedLiquidOverlap" -ln "reseedLiquidOverlap" 
		-at "float";
	addAttr -r false -dcb 0 -ci true -k true -m -sn "Guides" -ln "Guides" -dt "mesh";
	addAttr -r false -ci true -k true -sn "minReseedAirDistance" -ln "minReseedAirDistance" 
		-at "float";
	addAttr -r false -ci true -k true -sn "simulationCacheFilename" -ln "simulationCacheFilename" 
		-dt "string";
	addAttr -r false -ci true -k true -sn "simulationCachePath" -ln "simulationCachePath" 
		-dt "string";
	addAttr -r false -ci true -k true -sn "computeGuideFromSimulationCache" -ln "computeGuideFromSimulationCache" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "computeGuideFromMesh" -ln "computeGuideFromMesh" 
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
	addAttr -r false -ci true -k true -sn "liquidCacheControl" -ln "liquidCacheControl" 
		-at "long";
	addAttr -r false -ci true -k true -sn "liquidCompressionQuality" -ln "liquidCompressionQuality" 
		-at "long";
	addAttr -r false -ci true -k true -sn "liquidCachePath" -ln "liquidCachePath" -dt "string";
	addAttr -r false -ci true -k true -sn "liquidCacheFileName" -ln "liquidCacheFileName" 
		-dt "string";
	addAttr -r false -ci true -k true -sn "enableLiquidCache" -ln "enableLiquidCache" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "solidCacheControl" -ln "solidCacheControl" 
		-at "long";
	addAttr -r false -ci true -k true -sn "solidCompressionQuality" -ln "solidCompressionQuality" 
		-at "long";
	addAttr -r false -ci true -k true -sn "solidCachePath" -ln "solidCachePath" -dt "string";
	addAttr -r false -ci true -k true -sn "solidCacheFileName" -ln "solidCacheFileName" 
		-dt "string";
	addAttr -r false -ci true -k true -sn "enableSolidCache" -ln "enableSolidCache" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "foamCacheControl" -ln "foamCacheControl" 
		-at "long";
	addAttr -r false -ci true -k true -sn "foamCompressionQuality" -ln "foamCompressionQuality" 
		-at "long";
	addAttr -r false -ci true -k true -sn "foamCachePath" -ln "foamCachePath" -dt "string";
	addAttr -r false -ci true -k true -sn "foamCacheFileName" -ln "foamCacheFileName" 
		-dt "string";
	addAttr -r false -ci true -k true -sn "enableFoamCache" -ln "enableFoamCache" -min 
		0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "deleteExceedingParticles" -ln "deleteExceedingParticles" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "emissionRate" -ln "emissionRate" -at "float";
	addAttr -r false -ci true -k true -sn "minLiquidSpeed" -ln "minLiquidSpeed" -at "float";
	addAttr -r false -ci true -k true -sn "minLiquidChurn" -ln "minLiquidChurn" -at "float";
	addAttr -r false -ci true -k true -sn "minLiquidCurvature" -ln "minLiquidCurvature" 
		-at "float";
	addAttr -r false -ci true -k true -sn "minLiquidDepth" -ln "minLiquidDepth" -at "float";
	addAttr -r false -ci true -k true -sn "maxLiquidDepth" -ln "maxLiquidDepth" -at "float";
	addAttr -r false -ci true -k true -sn "inheritLiquidVelocity" -ln "inheritLiquidVelocity" 
		-at "float";
	addAttr -r false -ci true -k true -sn "emitFlatnessToSurface" -ln "emitFlatnessToSurface" 
		-at "float";
	addAttr -r false -ci true -k true -sn "dissipationRate" -ln "dissipationRate" -at "float";
	addAttr -r false -ci true -k true -sn "killDensityThreshold" -ln "killDensityThreshold" 
		-at "float";
	addAttr -r false -ci true -k true -sn "buoyancy" -ln "buoyancy" -at "float";
	addAttr -r false -ci true -k true -sn "collideKillDepth" -ln "collideKillDepth" 
		-at "float";
	addAttr -r false -ci true -k true -sn "windX" -ln "windX" -at "float";
	addAttr -r false -ci true -k true -sn "windZ" -ln "windZ" -at "float";
	addAttr -r false -ci true -k true -sn "surfaceOffset" -ln "surfaceOffset" -at "float";
	addAttr -r false -ci true -k true -sn "snapToSurface" -ln "snapToSurface" -min 0 
		-max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "pointRadius" -ln "pointRadius" -at "float";
	addAttr -r false -ci true -k true -sn "preserveVolume" -ln "preserveVolume" -at "float";
	addAttr -r false -ci true -k true -sn "maxSolidDepth" -ln "maxSolidDepth" -at "float";
	addAttr -r false -ci true -k true -sn "cameraAdaptivity" -ln "cameraAdaptivity" 
		-at "float";
	addAttr -r false -ci true -k true -sn "clipToCameraFrustum" -ln "clipToCameraFrustum" 
		-min 0 -max 1 -at "bool";
	addAttr -r false -ci true -k true -sn "cameraFov" -ln "cameraFov" -at "float";
	addAttr -r false -ci true -k true -sn "cameraAspect" -ln "cameraAspect" -at "float";
	addAttr -r false -ci true -k true -sn "cameraBuffer" -ln "cameraBuffer" -at "float";
	addAttr -w false -s false -sn "Solid" -ln "Solid" -dt "string";
	addAttr -w false -s false -sn "Foam" -ln "Foam" -dt "string";
	setAttr -k off ".v";
	setAttr ".sc" -type "string" (
		"{\"version\":3,\"runtimeVersion\":\"2.0\",\"graphName\":\"_bifrostLiquid1_bifrostLiquidContainer1::liquid\",\"graphCode\":\"{\\n    \\\"header\\\": {\\n        \\\"metadata\\\": [\\n            {\\n                \\\"metaName\\\": \\\"version\\\",\\n                \\\"metaValue\\\": \\\"100L\\\"\\n            },\\n            {\\n                \\\"metaName\\\": \\\"adskFileFormatVersion\\\",\\n                \\\"metaValue\\\": \\\"100L\\\"\\n            }\\n        ]\\n    },\\n    \\\"dependencies\\\": [\\n        {\\n            \\\"uri\\\": \\\"file:///createMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///keepMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createObjectWhenCaching.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///cacheObjectToDisk.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///solveLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeVoxelLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopePointLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeSolids.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///foam.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createEmptyItems.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///updateSubStepIterator.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///basenodes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///keepMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createObjectWhenCaching.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///cacheObjectToDisk.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///solveLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeVoxelLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopePointLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeSolids.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///foam.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createEmptyItems.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///updateSubStepIterator.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///basenodes.json\\\"\\n        }\\n    ],\\n    \\\"types\\\": [],\\n    \\\"operators\\\": [],\\n    \\\"compounds\\\": [\\n        {\\n            \\\"name\\\": \\\"_bifrostLiquid1_bifrostLiquidContainer1::liquid\\\",\\n            \\\"uriImported\\\": \\\"file:///liquid.json\\\",\\n            \\\"ports\\\": [\\n                {\\n                    \\\"portName\\\": \\\"Emitters\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Colliders\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Accelerators\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"masterVoxelSize\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"gravityMagnitude\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"gravityDirection\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"forceVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"transportStepAdaptivity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"transportTimeScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minSteps\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxSteps\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dropletThreshold\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dropletMergeBackDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceBandWidth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"interiorParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"killplanes\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"viscosityScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Liquid\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Solid\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceTension\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityDecay\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityMult\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityMax\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceTensionEnable\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityEnable\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Foam\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraMatrixList\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableFoam\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableGuiding\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromHighResLiquid\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minSimulationDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"guideVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedGuideOverlap\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedLiquidOverlap\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Guides\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minReseedAirDistance\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"simulationCacheFilename\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"simulationCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromSimulationCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromMesh\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxMin\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxMax\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxTransform\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableLiquidCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableSolidCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableFoamCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"deleteExceedingParticles\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"emissionRate\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidSpeed\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidChurn\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidCurvature\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxLiquidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"inheritLiquidVelocity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"emitFlatnessToSurface\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dissipationRate\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"killDensityThreshold\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"buoyancy\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"collideKillDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"windX\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"windZ\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceOffset\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"snapToSurface\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"pointRadius\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"preserveVolume\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxSolidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraAdaptivity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipToCameraFrustum\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraFov\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraAspect\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraBuffer\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                }\\n            ],\\n            \\\"compounds\\\": [\\n                {\\n                    \\\"name\\\": \\\"subStepLiquid\\\",\\n                    \\\"uriImported\\\": \\\"file:///liquid.json\\\",\\n                    \\\"ports\\\": [\\n                        {\\n                            \\\"portName\\\": \\\"Emitters\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Colliders\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Accelerators\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"masterVoxelSize\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"gravityMagnitude\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"gravityDirection\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"solidVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"forceVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"transportStepAdaptivity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"transportTimeScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minSteps\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"int\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"maxSteps\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"int\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dropletThreshold\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dropletMergeBackDepth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfaceBandWidth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"interiorPointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfacePointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"killPlanes\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"PIC\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"viscosityMult\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dynamicSurfaceTension\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityDecay\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityMul\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityMax\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfaceTensionEnable\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityEnable\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"simulationCacheFilename\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"string\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"simulationCachePath\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"string\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"enableGuiding\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromHighResLiquid\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minSimulationDepth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"guideVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedPointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedGuideOverlap\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedLiquidOverlap\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Guides\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minReseedAirDistance\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Liquid\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Object\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Solid\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Object\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"ittr_input\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"ittr_output\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromSimulationCache\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromMesh\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxMin\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxMax\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxTransform\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Mat44Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"deleteExceedingPoints\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        }\\n                    ],\\n                    \\\"compoundNodes\\\": [\\n                        {\\n                            \\\"nodeName\\\": \\\"solveLiquid\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::solveLiquid\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"updateSubStepIterator\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::_private::updateSubStepIterator\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"getLiquidObjectName\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::_privNames::getLiquidObjectName\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"voxel_liquid-volume\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"valueBool\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Math::valueBool\\\"\\n                        }\\n                    ],\\n                    \\\"connections\\\": [\\n                        {\\n                            \\\"source\\\": \\\".ittr_input\\\",\\n                            \\\"target\\\": \\\"valueBool.val\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"valueBool.value\\\",\\n                            \\\"target\\\": \\\".ittr_output\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Emitters\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Emitters\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Colliders\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Colliders\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".deleteExceedingPoints\\\",\\n                            \\\"target\\\": \\\"solveLiquid.deleteExceedingPoints\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Accelerators\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Accelerators\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".masterVoxelSize\\\",\\n                            \\\"target\\\": \\\"solveLiquid.masterVoxelSize\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".gravityMagnitude\\\",\\n                            \\\"target\\\": \\\"solveLiquid.gravityMagnitude\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".gravityDirection\\\",\\n                            \\\"target\\\": \\\"solveLiquid.gravityDirection\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".solidVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.solidVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".forceVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.forceVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".transportStepAdaptivity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.transportStepAdaptivity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".transportTimeScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.transportTimeScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minSteps\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minSteps\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".maxSteps\\\",\\n                            \\\"target\\\": \\\"solveLiquid.maxSteps\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dropletThreshold\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dropletThreshold\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dropletMergeBackDepth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dropletMergeBackDepth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfaceBandWidth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfaceBandWidth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".interiorPointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.interiorPointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfacePointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfacePointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".killPlanes\\\",\\n                            \\\"target\\\": \\\"solveLiquid.killPlanes\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".PIC\\\",\\n                            \\\"target\\\": \\\"solveLiquid.PIC\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".viscosityMult\\\",\\n                            \\\"target\\\": \\\"solveLiquid.viscosityMult\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dynamicSurfaceTension\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dynamicSurfaceTension\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityDecay\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityDecay\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityMul\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityMul\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityMax\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityMax\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfaceTensionEnable\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfaceTensionEnable\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityEnable\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityEnable\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".simulationCacheFilename\\\",\\n                            \\\"target\\\": \\\"solveLiquid.simulationCacheFilename\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".simulationCachePath\\\",\\n                            \\\"target\\\": \\\"solveLiquid.simulationCachePath\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".enableGuiding\\\",\\n                            \\\"target\\\": \\\"solveLiquid.enableGuiding\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromHighResLiquid\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromHighResLiquid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minSimulationDepth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minSimulationDepth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".guideVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.guideVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedPointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedPointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedGuideOverlap\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedGuideOverlap\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedLiquidOverlap\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedLiquidOverlap\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Guides\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Guides\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minReseedAirDistance\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minReseedAirDistance\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.Liquid\\\",\\n                            \\\"target\\\": \\\".Liquid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.Solid\\\",\\n                            \\\"target\\\": \\\".Solid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".masterVoxelSize\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.mvs\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.outLoopingCondition\\\",\\n                            \\\"target\\\": \\\".looping_condition\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromSimulationCache\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromSimulationCache\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromMesh\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromMesh\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxMin\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxMin\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxMax\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxMax\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxTransform\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxTransform\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"updateSubStepIterator.condition\\\",\\n                            \\\"target\\\": \\\"solveLiquid.loopingCondition\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"getLiquidObjectName.value\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.objectName\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"voxel_liquid-volume.value\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.compName\\\"\\n                        }\\n                    ],\\n                    \\\"values\\\": [\\n                        {\\n                            \\\"valueName\\\": \\\"voxel_liquid-volume.str\\\",\\n                            \\\"valueType\\\": \\\"string\\\",\\n                            \\\"value\\\": \\\"voxel_liquid-volume\\\"\\n                        }\\n                    ],\\n                    \\\"whileCompound\\\": {\\n                        \\\"ports\\\": [\\n                            {\\n                                \\\"portKind\\\": \\\"state\\\",\\n                                \\\"inputPortName\\\": \\\"ittr_input\\\",\\n                                \\\"outputPortName\\\": \\\"ittr_output\\\"\\n                            }\\n                        ]\\n                    }\\n                }\\n            ],\\n            \\\"compoundNodes\\\": [\\n                {\\n                    \\\"nodeName\\\": \\\"createMeshes\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::_private::createMeshes\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"keepMeshes\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::_private::keepMeshes\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createObjectWhenCaching\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createObjectWhenCaching\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"cacheObjectToDisk\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::cacheObjectToDisk\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"voxel_liquid\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"scopeLiquid\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::scopeLiquid\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createObjectWhenCaching1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createObjectWhenCaching\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"Solids\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"scopeSolids\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::scopeSolids\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"foamComp\\\",\\n                    \\\"nodeType\\\": \\\"foam\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"if\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::if\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject2\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createEmptyItems\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createEmptyItems\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"subStepLiquid\\\",\\n                    \\\"nodeType\\\": \\\"subStepLiquid\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"initTimestepCFL\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::_private::initTimestepCFL\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"cacheObjectToDisk1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::cacheObjectToDisk\\\"\\n                }\\n            ],\\n            \\\"connections\\\": [\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject.value\\\",\\n                    \\\"target\\\": \\\".Liquid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Emitters\\\",\\n                    \\\"target\\\": \\\"createMeshes.emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Colliders\\\",\\n                    \\\"target\\\": \\\"createMeshes.colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Accelerators\\\",\\n                    \\\"target\\\": \\\"createMeshes.accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject1.value\\\",\\n                    \\\"target\\\": \\\".Solid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraMatrixList\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraMatrixList\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"if.output\\\",\\n                    \\\"target\\\": \\\".Foam\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableFoam\\\",\\n                    \\\"target\\\": \\\"if.condition\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Guides\\\",\\n                    \\\"target\\\": \\\"createMeshes.guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".masterVoxelSize\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.masterVoxelSize\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".deleteExceedingParticles\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.deleteExceedingPoints\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityMagnitude\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.gravityMagnitude\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityDirection\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.gravityDirection\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.solidVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".forceVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.forceVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".transportStepAdaptivity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.transportStepAdaptivity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".transportTimeScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.transportTimeScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minSteps\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minSteps\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxSteps\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.maxSteps\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dropletThreshold\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dropletThreshold\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dropletMergeBackDepth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dropletMergeBackDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceBandWidth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfaceBandWidth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".interiorParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.interiorPointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfacePointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".killplanes\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.killPlanes\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".viscosityScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.viscosityMult\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceTension\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dynamicSurfaceTension\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityDecay\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityDecay\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityMult\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityMul\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityMax\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityMax\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceTensionEnable\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfaceTensionEnable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityEnable\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityEnable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableGuiding\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.enableGuiding\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromHighResLiquid\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromHighResLiquid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minSimulationDepth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minSimulationDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".guideVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.guideVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedPointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedGuideOverlap\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedGuideOverlap\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedLiquidOverlap\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedLiquidOverlap\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minReseedAirDistance\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minReseedAirDistance\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".simulationCacheFilename\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.simulationCacheFilename\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".simulationCachePath\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.simulationCachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromSimulationCache\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromSimulationCache\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromMesh\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromMesh\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxMin\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxMin\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxMax\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxMax\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxTransform\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxTransform\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCompressionQuality\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCachePath\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCacheFileName\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableLiquidCache\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableLiquidCache\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCacheControl\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableSolidCache\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCacheControl\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCacheControl\\\",\\n                    \\\"target\\\": \\\"foamComp.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCompressionQuality\\\",\\n                    \\\"target\\\": \\\"foamComp.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCachePath\\\",\\n                    \\\"target\\\": \\\"foamComp.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCacheFileName\\\",\\n                    \\\"target\\\": \\\"foamComp.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableFoamCache\\\",\\n                    \\\"target\\\": \\\"foamComp.enableFoamCache\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableSolidCache\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCacheFileName\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCachePath\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCompressionQuality\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".emissionRate\\\",\\n                    \\\"target\\\": \\\"foamComp.emissionRate\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidSpeed\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidSpeed\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidChurn\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidChurn\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidCurvature\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidCurvature\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxLiquidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.maxLiquidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".inheritLiquidVelocity\\\",\\n                    \\\"target\\\": \\\"foamComp.inheritLiquidVelocity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".emitFlatnessToSurface\\\",\\n                    \\\"target\\\": \\\"foamComp.emitFlatnessToSurface\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dissipationRate\\\",\\n                    \\\"target\\\": \\\"foamComp.dissipationRate\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".killDensityThreshold\\\",\\n                    \\\"target\\\": \\\"foamComp.killDensityThreshold\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".buoyancy\\\",\\n                    \\\"target\\\": \\\"foamComp.buoyancy\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".collideKillDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.collideKillDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".windX\\\",\\n                    \\\"target\\\": \\\"foamComp.windX\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".windZ\\\",\\n                    \\\"target\\\": \\\"foamComp.windZ\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceOffset\\\",\\n                    \\\"target\\\": \\\"foamComp.surfaceOffset\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".snapToSurface\\\",\\n                    \\\"target\\\": \\\"foamComp.snapToSurface\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".pointRadius\\\",\\n                    \\\"target\\\": \\\"foamComp.pointRadius\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".preserveVolume\\\",\\n                    \\\"target\\\": \\\"foamComp.preserveVolume\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityMagnitude\\\",\\n                    \\\"target\\\": \\\"foamComp.gravity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxSolidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.maxSolidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraAdaptivity\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraAdaptivity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipToCameraFrustum\\\",\\n                    \\\"target\\\": \\\"foamComp.clipToCameraFrustum\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraFov\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraFov\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraAspect\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraAspect\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraBuffer\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraBuffer\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.accelerators1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.colliders1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.emitters1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.guides1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.emitters1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.colliders1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.accelerators1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.guides1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching.outObject\\\",\\n                    \\\"target\\\": \\\"keepMeshes.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"keepMeshes.outObject\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"voxel_liquid.value\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.name\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Liquid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Liquid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.newObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching.outCacheControl\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"cacheObjectToDisk.outObject\\\",\\n                    \\\"target\\\": \\\"scopeLiquid.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"scopeLiquid.outObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject.value\\\",\\n                    \\\"target\\\": \\\"foamComp.liquidObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"Solids.value\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.name\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Solid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Solid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.newObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching1.outObject\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching1.outCacheControl\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"scopeSolids.outObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject1.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"cacheObjectToDisk1.outObject\\\",\\n                    \\\"target\\\": \\\"scopeSolids.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject1.value\\\",\\n                    \\\"target\\\": \\\"foamComp.solidObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"foamComp.Foam\\\",\\n                    \\\"target\\\": \\\"if.trueCase\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject2.value\\\",\\n                    \\\"target\\\": \\\"if.falseCase\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createEmptyItems.emptyObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject2.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"initTimestepCFL.value\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.ittr_input\\\"\\n                }\\n            ],\\n            \\\"values\\\": [\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.compNameToTest\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"_voxel\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.filePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFilePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.fileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFileNameHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cacheControl\\\",\\n                    \\\"value\\\": \\\"0L\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.compressionQuality\\\",\\n                    \\\"value\\\": \\\"0L\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cachePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putCachePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cacheFileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"liquid\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.pointComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid-particle\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.voxelComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid-volume\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"voxel_liquid.str\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.compNameToTest\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"_voxel\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.filePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFileNameHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.fileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFilePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"Solids.str\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"Solids\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.emissionRate\\\",\\n                    \\\"value\\\": \\\"1000f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidSpeed\\\",\\n                    \\\"value\\\": \\\"0.2f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidChurn\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidCurvature\\\",\\n                    \\\"value\\\": \\\"0.5f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.inheritLiquidVelocity\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.emitFlatnessToSurface\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.dissipationRate\\\",\\n                    \\\"value\\\": \\\"5f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.killDensityThreshold\\\",\\n                    \\\"value\\\": \\\"0.05f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.buoyancy\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.collideKillDepth\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.windX\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.windZ\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.surfaceOffset\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.snapToSurface\\\",\\n                    \\\"value\\\": \\\"false\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.pointRadius\\\",\\n                    \\\"value\\\": \\\"0.3f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.preserveVolume\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.gravity\\\",\\n                    \\\"value\\\": \\\"9.8f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.maxSolidDepth\\\",\\n                    \\\"value\\\": \\\"0.3f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraAdaptivity\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.clipToCameraFrustum\\\",\\n                    \\\"value\\\": \\\"false\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraFov\\\",\\n                    \\\"value\\\": \\\"110f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraAspect\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraBuffer\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"subStepLiquid.PIC\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk1.pointComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"none\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk1.voxelComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"Solids-volume\\\"\\n                }\\n            ]\\n        }\\n    ]\\n}\"}");
	setAttr ".srv" -type "string" "2.0";
	setAttr -k on ".pfc";
	setAttr -k on ".cc";
	setAttr -k on -cb off ".sfr";
	setAttr -k on ".Emitters[0]";
	setAttr -k on ".Emitters";
	setAttr -s 3 ".Colliders";
	setAttr -k on ".Colliders[0]";
	setAttr -k on ".Colliders[1]";
	setAttr -k on ".Colliders[2]";
	setAttr -k on ".Colliders";
	setAttr -k on ".masterVoxelSize" 0.20000000298023224;
	setAttr -k on ".vorticityEnable" yes;
	setAttr -k on ".vorticityDecay" 20;
	setAttr -k on ".vorticityMax" 100;
	setAttr -k on ".gravityMagnitude" 8;
	setAttr -k on ".gravityDirection" -type "float3" 0 -1 0 ;
	setAttr -k on ".gravityDirection";
	setAttr -k on ".gravityDirectionX";
	setAttr -k on ".gravityDirectionY";
	setAttr -k on ".gravityDirectionZ";
	setAttr -k on ".solidVoxelScale" 1;
	setAttr -k on ".forceVoxelScale" 1;
	setAttr -k on ".vorticityMult" 1;
	setAttr -k on ".transportStepAdaptivity" 0.31999999284744263;
	setAttr -k on ".transportTimeScale" 1;
	setAttr -k on ".minSteps" 1;
	setAttr -k on ".maxSteps" 2000;
	setAttr -k on ".dropletThreshold" 0.80000001192092896;
	setAttr -k on ".dropletMergeBackDepth" 2;
	setAttr -k on ".surfaceBandWidth" 1;
	setAttr -k on ".interiorParticleDensity" 1;
	setAttr -k on ".surfaceParticleDensity" 3;
	setAttr -k on ".killplanes[0]";
	setAttr -k on ".killplanes";
	setAttr ".nts" -type "string" "The resolution of this liquid is fairly low. Lower the master voxel size to 0.08 or lower for better ( but slower to compute) results. Also when rendering the output mesh may provide better results. If the output mesh is enabled hide this node to avoid rendering both the volume raytrace and the mesh.";
	setAttr -k on ".deleteExceedingParticles" yes;
createNode transform -n "bifrost1";
	rename -uid "91162CC3-46C8-CFE2-B903-4CA560DE1C41";
	setAttr ".s" -type "double3" 1.5751159544504019 1 1 ;
createNode bifrostShape -n "bifrostShape1" -p "bifrost1";
	rename -uid "6BAFF8B6-4789-703C-5C15-36A362060FF8";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".pch" -type "string" "position";
	setAttr ".vch" -type "string" "distance";
	setAttr ".p" yes;
	setAttr ".pcc" -type "string" "velocity";
	setAttr -s 4 ".pcr";
	setAttr ".pcr[0].pcrp" 0;
	setAttr ".pcr[0].pcrcv" -type "float3" 0.124362 0.18741721 0.28200001 ;
	setAttr ".pcr[0].pcri" 2;
	setAttr ".pcr[1].pcrp" 0.87826085090637207;
	setAttr ".pcr[1].pcrcv" -type "float3" 1 1 1 ;
	setAttr ".pcr[1].pcri" 2;
	setAttr ".pcr[2].pcrp" 0.44347825646400452;
	setAttr ".pcr[2].pcrcv" -type "float3" 0.36356202 0.57800001 0.57800001 ;
	setAttr ".pcr[2].pcri" 2;
	setAttr ".pcr[3].pcrp" 0.57391303777694702;
	setAttr ".pcr[3].pcrcv" -type "float3" 0.51493698 0.67837101 0.67837101 ;
	setAttr ".pcr[3].pcri" 2;
	setAttr ".pcrx" 3;
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
	setAttr ".mdf" 2.3448276519775391;
	setAttr ".msr" 1;
	setAttr ".mdr" 1;
	setAttr ".mkf" 3.4482758045196533;
createNode transform -n "bifrostMesh1";
	rename -uid "FBEA95D1-40C1-D76E-D592-0BB02B28D99C";
	addAttr -s false -ci true -sn "miData" -ln "miData" -at "message";
createNode mesh -n "bifrostMeshShape1" -p "bifrostMesh1";
	rename -uid "8387D361-4618-18FE-A135-BA84907192C3";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
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
	setAttr ".mvcs" -type "string" "bifrostVelocity";
createNode transform -n "bifrostKillplane1";
	rename -uid "02146BC1-4132-73D5-F48E-598E36A89230";
	setAttr ".t" -type "double3" 0 -2.0936136481684144 8.2024792694331499 ;
	setAttr ".r" -type "double3" 95.647899320084477 0 0 ;
	setAttr ".s" -type "double3" 5.8144334036121439 5.8144334036121439 5.8144334036121439 ;
createNode sketchPlane -n "bifrostKillplaneShape1" -p "bifrostKillplane1";
	rename -uid "CD3E9F49-4E36-498A-C533-1BA7CA391D7C";
	setAttr -k off ".v";
createNode transform -n "pSphere1";
	rename -uid "AD0702E8-4AB6-0265-760C-8697BAD63CBE";
	setAttr ".t" -type "double3" 0.30472247538034036 0.77345365603305083 -0.10278526316840959 ;
	setAttr ".r" -type "double3" 7.6623602971074609 0 0 ;
	setAttr ".s" -type "double3" 1.6913509497242885 1.7748940124300701 1.6913509497242885 ;
createNode mesh -n "pSphereShape1" -p "pSphere1";
	rename -uid "2E60CE8A-4FA2-AFA3-AEF6-8CAF3A5E590F";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.50000005960464478 0.82500004768371582 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 262 ".pt";
	setAttr ".pt[0]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[1]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[2]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[3]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[4]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[5]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[6]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[7]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[8]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[9]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[10]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[11]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[12]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[13]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[14]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[15]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[16]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[17]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[18]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[19]" -type "float3" 0 0.37393552 0 ;
	setAttr ".pt[20]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[21]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[22]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[23]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[24]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[25]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[26]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[27]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[28]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[29]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[30]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[31]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[32]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[33]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[34]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[35]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[36]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[37]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[38]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[39]" -type "float3" 0 0.34650117 0 ;
	setAttr ".pt[40]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[41]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[42]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[43]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[44]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[45]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[46]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[47]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[48]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[49]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[50]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[51]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[52]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[53]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[54]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[55]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[56]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[57]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[58]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[59]" -type "float3" 0 0.30152839 0 ;
	setAttr ".pt[60]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[61]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[62]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[63]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[64]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[65]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[66]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[67]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[68]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[69]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[70]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[71]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[72]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[73]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[74]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[75]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[76]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[77]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[78]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[79]" -type "float3" 0 0.24012467 0 ;
	setAttr ".pt[80]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[81]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[82]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[83]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[84]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[85]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[86]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[87]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[88]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[89]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[90]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[91]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[92]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[93]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[94]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[95]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[96]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[97]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[98]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[99]" -type "float3" 0 0.16380189 0 ;
	setAttr ".pt[100]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[101]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[102]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[103]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[104]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[105]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[106]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[107]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[108]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[109]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[110]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[111]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[112]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[113]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[114]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[115]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[116]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[117]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[118]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[119]" -type "float3" 0 0.074439421 0 ;
	setAttr ".pt[120]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[121]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[122]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[123]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[124]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[125]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[126]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[127]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[128]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[129]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[130]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[131]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[132]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[133]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[134]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[135]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[136]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[137]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[138]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[139]" -type "float3" 0 -0.025762331 0 ;
	setAttr ".pt[249]" -type "float3" 0 0.074689031 0.0057868194 ;
	setAttr ".pt[250]" -type "float3" 0 0.074689031 0.0057868194 ;
	setAttr ".pt[251]" -type "float3" 0 0.074689031 0.0057868194 ;
	setAttr ".pt[263]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[264]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[265]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[266]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[267]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[268]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[269]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[270]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[271]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[272]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[273]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[274]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[275]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[276]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[277]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[278]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[279]" -type "float3" 0 0.010564293 0.0057868194 ;
	setAttr ".pt[280]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[281]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[282]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[283]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[284]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[285]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[286]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[287]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[288]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[289]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[290]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[291]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[292]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[293]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[294]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[295]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[296]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[297]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[298]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[299]" -type "float3" 0 -0.046623763 0.0057868194 ;
	setAttr ".pt[300]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[301]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[302]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[303]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[304]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[305]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[306]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[307]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[308]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[309]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[310]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[311]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[312]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[313]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[314]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[315]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[316]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[317]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[318]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[319]" -type "float3" 0 -0.095467001 0.0057868194 ;
	setAttr ".pt[320]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[321]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[322]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[323]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[324]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[325]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[326]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[327]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[328]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[329]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[330]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[331]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[332]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[333]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[334]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[335]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[336]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[337]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[338]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[339]" -type "float3" 0 -0.1347627 0.0057868194 ;
	setAttr ".pt[340]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[341]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[342]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[343]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[344]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[345]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[346]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[347]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[348]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[349]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[350]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[351]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[352]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[353]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[354]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[355]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[356]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[357]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[358]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[359]" -type "float3" 0 -0.16354331 0.0057868194 ;
	setAttr ".pt[360]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[361]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[362]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[363]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[364]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[365]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[366]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[367]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[368]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[369]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[370]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[371]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[372]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[373]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[374]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[375]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[376]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[377]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[378]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[379]" -type "float3" 0 -0.18110007 0.0057868194 ;
	setAttr ".pt[380]" -type "float3" 0 0.383156 0 ;
	setAttr ".pt[381]" -type "float3" 0 -0.18700075 0.0057868194 ;
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode transform -n "directionalLight1";
	rename -uid "54308FBB-42B3-6C35-FDAB-79A1CFC1A139";
	setAttr ".r" -type "double3" 65.232657942359779 -39.195376035303433 -96.56156720766468 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	rename -uid "A1879051-451F-9766-AECF-78BC84D51E5B";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 1 0.90305984 0.79400003 ;
createNode transform -n "pointLight1";
	rename -uid "31D306F5-4B42-E829-8C0C-0B86D351D9EE";
	setAttr ".t" -type "double3" 13.183088312257308 5.9925099159794932 0 ;
createNode pointLight -n "pointLightShape1" -p "pointLight1";
	rename -uid "5F5526E9-42D6-89BE-4E52-F3A2C182F8CC";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.54699999 0.82413024 1 ;
	setAttr ".us" no;
createNode place3dTexture -n "place3dTexture1";
	rename -uid "4576C360-4BD3-14EE-54F1-2AA93DBC8589";
	setAttr ".v" no;
	setAttr ".s" -type "double3" 1.2782854543627238 1.3069278477878181 6.0133331147255324 ;
createNode transform -n "sine1Handle";
	rename -uid "5E4D6CE3-4651-491D-D2EE-E38BA6C2DA59";
	setAttr ".t" -type "double3" -2.2861304349530145e-034 0.052358465017585676 15.862379882912832 ;
	setAttr ".r" -type "double3" 0 90 90 ;
	setAttr ".s" -type "double3" 9.2802070706169282 14.665676894818571 9.2802070706169282 ;
	setAttr ".smd" 7;
createNode deformSine -n "sine1HandleShape" -p "sine1Handle";
	rename -uid "5D3AAA2C-40A3-1B26-0DFB-D7A3D2BACC5A";
	setAttr -k off ".v";
	setAttr ".dd" -type "doubleArray" 6 0 -1 1 0 1.645086701205162 0.012499999999999999 ;
	setAttr ".hw" 3.1621119350130531;
createNode transform -n "pSphere2";
	rename -uid "F96BE860-4948-6E13-4812-41984982A8F0";
	setAttr ".s" -type "double3" 86.844458802242215 86.844458802242215 86.844458802242215 ;
createNode mesh -n "pSphereShape2" -p "pSphere2";
	rename -uid "77384699-4F92-0D04-5772-0EAFD78D80DB";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".csh" no;
	setAttr ".rcsh" no;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ds" no;
	setAttr ".op" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "wavePanelShorelineCam";
	rename -uid "CCC67A18-4DA5-074B-FD47-FCB8FCD79E3F";
	setAttr ".t" -type "double3" 31.958312171247968 7.9820847087728666 11.319637275125917 ;
	setAttr ".r" -type "double3" -15.338352729603253 81.400000000000546 0 ;
createNode camera -n "wavePanelShorelineCamShape" -p "wavePanelShorelineCam";
	rename -uid "F6B806FB-4C85-24D9-9192-2EAC28B8CE4A";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 34.217250866230501;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "D58A0606-4CBA-0D86-5754-7CB353D84115";
	setAttr -s 6 ".lnk";
	setAttr -s 6 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "91A1E7DF-40DE-2190-DDC6-FABC61C4B008";
createNode displayLayer -n "defaultLayer";
	rename -uid "081357A6-4EFF-4CB0-B5CE-0BB7626EFD87";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "C96DD184-4607-0144-1F96-C7A6DBB0816D";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "5C8C4D1A-44DA-EB7D-C37B-B1B79B3F8E01";
	setAttr ".g" yes;
createNode mentalrayItemsList -s -n "mentalrayItemsList";
	rename -uid "F4BA1159-46A6-76EA-9B14-DAB8A0840B6A";
createNode mentalrayGlobals -s -n "mentalrayGlobals";
	rename -uid "C625FB30-4890-53B2-6BAF-0FB83A1FF579";
createNode mentalrayOptions -s -n "miDefaultOptions";
	rename -uid "BE29E18F-42DE-7056-9ADB-C19BF6FCBF9A";
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
	rename -uid "F7C3F3C2-440A-D0F0-AB7F-3BA7D2CA332A";
createNode polyCube -n "polyCube1";
	rename -uid "0B79A5F2-484D-4AA1-EC8B-AEAD738D6D71";
	setAttr ".cuv" 4;
createNode deleteComponent -n "deleteComponent1";
	rename -uid "0F2B4B2F-414A-5D17-05B7-908BF67550EB";
	setAttr ".dc" -type "componentList" 1 "f[1]";
createNode polyCube -n "polyCube2";
	rename -uid "09830C6C-4FF4-99E8-06EA-75BFD533498A";
	setAttr ".cuv" 4;
createNode polyTweak -n "polyTweak1";
	rename -uid "F9225996-4E52-7189-63E0-42AB4955FCD6";
	setAttr ".uopa" yes;
	setAttr -s 6 ".tk";
	setAttr ".tk[0]" -type "float3" 0 -2.8771544 0 ;
	setAttr ".tk[1]" -type "float3" 0 -2.8771544 0 ;
	setAttr ".tk[4]" -type "float3" 0 -0.034854636 -0.14611745 ;
	setAttr ".tk[5]" -type "float3" 0 -0.034854636 -0.14611745 ;
	setAttr ".tk[6]" -type "float3" 0 0.94002497 -0.14611745 ;
	setAttr ".tk[7]" -type "float3" 0 0.94002497 -0.14611745 ;
createNode deleteComponent -n "deleteComponent2";
	rename -uid "5AAD71B9-4C43-716E-8441-16BB4F53D7E6";
	setAttr ".dc" -type "componentList" 1 "f[0]";
createNode polyCube -n "polyCube3";
	rename -uid "21CC56E1-442A-9943-DC5D-CCB63170CF9A";
	setAttr ".sw" 33;
	setAttr ".cuv" 4;
createNode expression -n "expression1";
	rename -uid "CA4923C8-47A7-569B-C728-34AC61B254EE";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "// this expression simply uses a sin function to animate the rotation\n// of the wave paddle going back and forth\nfloat $paddleSpeed = 1.0;\nfloat $paddleAmplitude = 25; // degree of rotation\n.O[0]= -sin((time-0.04)* 1.0) * 25;";
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "1407F920-4416-8553-8BEA-FC90F994393B";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 120 -ast 1 -aet 200 ";
	setAttr ".st" 6;
createNode bifrostLiquidMaterial -n "bifrostLiquidMaterial1";
	rename -uid "FB5CC70B-400B-280B-96EA-639216AD2F27";
	setAttr -s 4 ".dcrm";
	setAttr ".dcrm[0].dcrmp" 0.46956521272659302;
	setAttr ".dcrm[0].dcrmcv" -type "float3" 0.24916498 0.47582403 0.565 ;
	setAttr ".dcrm[0].dcrmi" 1;
	setAttr ".dcrm[1].dcrmp" 1;
	setAttr ".dcrm[1].dcrmcv" -type "float3" 1.3 1.3 1.3 ;
	setAttr ".dcrm[1].dcrmi" 1;
	setAttr ".dcrm[2].dcrmp" 0;
	setAttr ".dcrm[2].dcrmcv" -type "float3" 0.11388001 0.17215042 0.31200001 ;
	setAttr ".dcrm[2].dcrmi" 1;
	setAttr ".dcrm[3].dcrmp" 0.60000002384185791;
	setAttr ".dcrm[3].dcrmcv" -type "float3" 0.47780201 0.78200001 0.78200001 ;
	setAttr ".dcrm[3].dcrmi" 1;
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
	setAttr ".rlc" -type "float3" 0.65487146 0.65487146 0.65487146 ;
	setAttr -s 2 ".rlcrm";
	setAttr ".rlcrm[0].rlcrmp" 0;
	setAttr ".rlcrm[0].rlcrmcv" -type "float3" 0 0 0 ;
	setAttr ".rlcrm[0].rlcrmi" 1;
	setAttr ".rlcrm[1].rlcrmp" 1;
	setAttr ".rlcrm[1].rlcrmcv" -type "float3" 1 1 1 ;
	setAttr ".rlcrm[1].rlcrmi" 1;
	setAttr -s 2 ".rlcvrm[0:1]"  0 0 1 1 1 1;
	setAttr ".rlw" 0.66371679306030273;
	setAttr -s 2 ".rlwrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".rrcrm";
	setAttr ".rrcrm[0].rrcrmp" 0.15652173757553101;
	setAttr ".rrcrm[0].rrcrmcv" -type "float3" 0.77100003 0.77100003 0.77100003 ;
	setAttr ".rrcrm[0].rrcrmi" 1;
	setAttr ".rrcrm[1].rrcrmp" 0.66956520080566406;
	setAttr ".rrcrm[1].rrcrmcv" -type "float3" 0.28799999 0.28799999 0.28799999 ;
	setAttr ".rrcrm[1].rrcrmi" 1;
	setAttr -s 2 ".rrcvrm[0:1]"  0 0 1 1 1 1;
	setAttr ".t" 1;
	setAttr -s 2 ".trm[0:1]"  0 0 1 1 1 1;
createNode shadingEngine -n "bifrostLiquidMaterial1SG";
	rename -uid "015AF06E-42A9-1210-4A89-9EA79AC4D9E6";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode mib_data_string -n "bifrostMeshMRUserData1";
	rename -uid "B51D7FBE-460C-A827-2851-94831BB7438D";
	setAttr ".nam" -type "string" "bifrostMeshObject";
createNode bifrostAttrNotifier -n "pCubeShape2AttrNotif";
	rename -uid "D29C007C-42F0-4A63-39CF-CEB96375D509";
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
	rename -uid "E21C2CEC-4477-2E29-2CD8-16BD97EDF7D5";
	setAttr ".colos" -type "string" "bifrostLiquidDensity";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode createColorSet -n "createColorSet2";
	rename -uid "DD029BA2-4404-1719-6995-1B94374511A9";
	setAttr ".colos" -type "string" "bifrostLiquidExpansionRate";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode bifrostAttrNotifier -n "pCubeShape1AttrNotif";
	rename -uid "EEC520BD-4A47-B8BB-AE62-A387189D6CDA";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode bifrostAttrNotifier -n "pCubeShape3AttrNotif";
	rename -uid "6BD9A3D9-4D88-6A88-F029-2B89A011F2B6";
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
	rename -uid "46CAC21F-4186-2FC6-C5D4-34977BB43CAD";
createNode polySphere -n "polySphere1";
	rename -uid "5516EF72-4BA7-CC8A-CD94-53A69096F8D3";
createNode bifrostAttrNotifier -n "pSphereShape1AttrNotif";
	rename -uid "BFE9037A-42BA-6C4B-52E3-C699B01EAA91";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode rampShader -n "rampShader1";
	rename -uid "EDF2F3EC-455C-272B-55E5-78A13CA7538A";
	setAttr ".dc" 1;
	setAttr ".clr[0].clrp" 0;
	setAttr ".clr[0].clrc" -type "float3" 0.061832007 0.236 0.23176189 ;
	setAttr ".clr[0].clri" 1;
	setAttr -s 6 ".it";
	setAttr ".it[0].itp" 0.52499997615814209;
	setAttr ".it[0].itc" -type "float3" 0.89447731 1 0.88800001 ;
	setAttr ".it[0].iti" 1;
	setAttr ".it[1].itp" 0.0062500000931322575;
	setAttr ".it[1].itc" -type "float3" 0.069265001 0.07 0.068530001 ;
	setAttr ".it[1].iti" 1;
	setAttr ".it[2].itp" 0.875;
	setAttr ".it[2].itc" -type "float3" 0.20370001 0.34999999 0.20682102 ;
	setAttr ".it[2].iti" 1;
	setAttr ".it[3].itp" 0.98750001192092896;
	setAttr ".it[3].itc" -type "float3" 0.0052200002 0.045000002 0.0060686348 ;
	setAttr ".it[3].iti" 1;
	setAttr ".it[4].itp" 0.26249998807907104;
	setAttr ".it[4].itc" -type "float3" 0.030104557 0.039000001 0.018135 ;
	setAttr ".it[4].iti" 1;
	setAttr ".it[5].itp" 0.40625;
	setAttr ".it[5].itc" -type "float3" 0.357054 0.45515701 0.29811901 ;
	setAttr ".it[5].iti" 1;
	setAttr -s 2 ".ic";
	setAttr ".ic[0].icp" 0.012500000186264515;
	setAttr ".ic[0].icc" -type "float3" 0 0 0 ;
	setAttr ".ic[0].ici" 1;
	setAttr ".ic[1].icp" 1;
	setAttr ".ic[1].icc" -type "float3" 0.05794828 0.055099998 0.057999998 ;
	setAttr ".ic[1].ici" 1;
	setAttr ".tc" 0.24271999299526215;
	setAttr ".trsd" 0.87375998497009277;
	setAttr ".ec" 0.18445999920368195;
	setAttr ".spl" 1;
	setAttr -s 2 ".sro[0:1]"  0 1 2 1 0 2;
	setAttr -s 2 ".sc";
	setAttr ".sc[0].scp" 0.92500001192092896;
	setAttr ".sc[0].scc" -type "float3" 0.064000003 0.064000003 0.064000003 ;
	setAttr ".sc[0].sci" 2;
	setAttr ".sc[1].scp" 1;
	setAttr ".sc[1].scc" -type "float3" 1 1 1 ;
	setAttr ".sc[1].sci" 2;
	setAttr -s 4 ".rfl";
	setAttr ".rfl[0].rflp" 0;
	setAttr ".rfl[0].rflfv" 0.8399999737739563;
	setAttr ".rfl[0].rfli" 1;
	setAttr ".rfl[1].rflp" 0.40869563817977905;
	setAttr ".rfl[1].rflfv" 0.11999999731779099;
	setAttr ".rfl[1].rfli" 1;
	setAttr ".rfl[2].rflp" 0.25217390060424805;
	setAttr ".rfl[2].rflfv" 0.63999998569488525;
	setAttr ".rfl[2].rfli" 1;
	setAttr ".rfl[4].rflp" 0.96521741151809692;
	setAttr ".rfl[4].rflfv" 0;
	setAttr ".rfl[4].rfli" 1;
	setAttr -s 4 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.18754201 0.414 0.40656462 ;
	setAttr ".env[0].envi" 1;
	setAttr ".env[1].envp" 0.51875001192092896;
	setAttr ".env[1].envc" -type "float3" 0.094122007 0.18444172 0.249 ;
	setAttr ".env[1].envi" 1;
	setAttr ".env[2].envp" 0.54374998807907104;
	setAttr ".env[2].envc" -type "float3" 0.30742002 0.47377729 0.80900002 ;
	setAttr ".env[2].envi" 1;
	setAttr ".env[3].envp" 1;
	setAttr ".env[3].envc" -type "float3" 0 0.20483799 0.73199999 ;
	setAttr ".env[3].envi" 0;
createNode shadingEngine -n "rampShader1SG";
	rename -uid "EDC690FD-4272-EE12-BDF2-F29C8C39D769";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
	rename -uid "A8B4B4C4-4EC3-6449-E4EB-37A84CD54991";
createNode polySubdFace -n "polySubdFace1";
	rename -uid "06E7DBAF-4E3F-3B31-1BB3-A792AC629632";
	setAttr ".ics" -type "componentList" 1 "f[*]";
	setAttr ".duv" 2;
	setAttr ".dvv" 2;
	setAttr ".sbm" 1;
createNode polyTweak -n "polyTweak2";
	rename -uid "BCB18446-40B8-FCAE-EB84-00A51610522D";
	setAttr ".uopa" yes;
	setAttr -s 6 ".tk[2:7]" -type "float3"  0 1.42495692 0 0 1.42495692
		 0 0 1.42495692 0 0 1.42495692 0 0 1.42495692 0 0 1.42495692 0;
createNode shadingEngine -n "blinn1SG";
	rename -uid "D1B27907-4113-CDAD-4237-7B9FA74838C8";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
	rename -uid "9915AE50-40D9-9767-4F5C-4A810AA02220";
createNode solidFractal -n "solidFractal1";
	rename -uid "A4B60F69-4365-AA9E-5A20-6FBCE3A0D926";
	setAttr ".f" 0.1310344785451889;
	setAttr ".ail" yes;
	setAttr ".a" 0.69655174016952515;
	setAttr ".ra" 0.475862056016922;
	setAttr ".fr" 2.8620688915252686;
	setAttr ".in" yes;
createNode bump3d -n "bump3d1";
	rename -uid "58E13051-4049-7C4C-AA4B-91ABBC8610BE";
	setAttr ".bd" 5;
createNode rampShader -n "rampShader2";
	rename -uid "AA4EAC1F-4220-3CE2-89E1-3CAFB9FD648E";
	setAttr ".dc" 0.48062014579772949;
	setAttr ".clr[0].clrp" 0;
	setAttr ".clr[0].clrc" -type "float3" 0.206 0.206 0.206 ;
	setAttr ".clr[0].clri" 1;
	setAttr ".it[0].itp" 0;
	setAttr ".it[0].itc" -type "float3" 0 0 0 ;
	setAttr ".it[0].iti" 1;
	setAttr ".ic[0].icp" 0;
	setAttr ".ic[0].icc" -type "float3" 0 0 0 ;
	setAttr ".ic[0].ici" 1;
	setAttr ".tcf" 0.5;
	setAttr ".trsd" 0.5;
	setAttr ".ec" 0.30232557654380798;
	setAttr ".spl" 0.31007751822471619;
	setAttr -s 2 ".sro[0:1]"  0 1 2 1 0.16 2;
	setAttr ".sc[0].scp" 0;
	setAttr ".sc[0].scc" -type "float3" 1 1 1 ;
	setAttr ".sc[0].sci" 1;
	setAttr -s 3 ".rfl[0:2]"  0.078260869 0.80000001 1 0.46956521 0.36000001 
		1 1 0.12 1;
	setAttr -s 7 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.21360001 0.25730833 0.30000001 ;
	setAttr ".env[0].envi" 1;
	setAttr ".env[1].envp" 0.54782611131668091;
	setAttr ".env[1].envc" -type "float3" 0.21359999 0.25730801 0.30000001 ;
	setAttr ".env[1].envi" 1;
	setAttr ".env[2].envp" 0.5565217137336731;
	setAttr ".env[2].envc" -type "float3" 0.46493602 0.56007445 0.653 ;
	setAttr ".env[2].envi" 1;
	setAttr ".env[3].envp" 0.67826086282730103;
	setAttr ".env[3].envc" -type "float3" 0.21359999 0.25730801 0.30000001 ;
	setAttr ".env[3].envi" 1;
	setAttr ".env[4].envp" 0.42608696222305298;
	setAttr ".env[4].envc" -type "float3" 0.25717598 0.46033996 0.52700001 ;
	setAttr ".env[4].envi" 1;
	setAttr ".env[5].envp" 0.39130434393882751;
	setAttr ".env[5].envc" -type "float3" 0.22249299 0.29874301 0.34632701 ;
	setAttr ".env[5].envi" 1;
	setAttr ".env[6].envp" 0.24347800016403198;
	setAttr ".env[6].envc" -type "float3" 0.11388601 0.14718632 0.171 ;
	setAttr ".env[6].envi" 1;
createNode nonLinear -n "sine1";
	rename -uid "CB05D5DD-46EE-4363-3137-A3853417CA02";
	addAttr -is true -ci true -k true -sn "amp" -ln "amplitude" -smn -5 -smx 5 -at "double";
	addAttr -is true -ci true -k true -sn "wav" -ln "wavelength" -dv 2 -min 0.001 -smn 
		0.1 -smx 10 -at "double";
	addAttr -is true -ci true -k true -sn "off" -ln "offset" -smn -10 -smx 10 -at "double";
	addAttr -is true -ci true -k true -sn "dr" -ln "dropoff" -min -1 -max 1 -at "double";
	addAttr -is true -ci true -k true -sn "lb" -ln "lowBound" -dv -1 -max 0 -smn -10 
		-smx 0 -at "double";
	addAttr -is true -ci true -k true -sn "hb" -ln "highBound" -dv 1 -min 0 -smn 0 -smx 
		10 -at "double";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k on ".amp";
	setAttr -k on ".wav" 1.645086701205162;
	setAttr -k on ".off";
	setAttr -k on ".dr";
	setAttr -k on ".lb";
	setAttr -k on ".hb";
	setAttr ".nts" -type "string" "This deformer adds secondary sine waves moving down the paddle to better simulate multiple waves coming in from different directions. The amplitude is keyed to rise from zero so the paddle starts out flat. Just set it to be always zero if you want linear waves, or delete this deformer.";
createNode tweak -n "tweak1";
	rename -uid "B18D3141-463E-ACBA-3BCF-D0B0944805A1";
	setAttr -s 2 ".vl";
createNode objectSet -n "sine1Set";
	rename -uid "27B63AA7-4917-1195-B49A-7C85C346ED29";
	setAttr ".ihi" 0;
	setAttr ".vo" yes;
createNode groupId -n "sine1GroupId";
	rename -uid "290DDAC0-4B73-766C-1A05-04941F9663EB";
	setAttr ".ihi" 0;
createNode groupParts -n "sine1GroupParts";
	rename -uid "760583B1-4B0C-D452-A0FA-379117108A0D";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "vtx[*]";
createNode objectSet -n "tweakSet1";
	rename -uid "FD46B063-4783-8665-771D-6BA2372415A6";
	setAttr ".ihi" 0;
	setAttr ".vo" yes;
createNode groupId -n "groupId2";
	rename -uid "10531B6A-4FF6-88A8-BE21-8290CA741755";
	setAttr ".ihi" 0;
createNode groupParts -n "groupParts2";
	rename -uid "6C9386EE-4F3B-E219-FE86-08A4AD3E48E0";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "vtx[*]";
createNode animCurveTU -n "sine1_amplitude";
	rename -uid "48B6DDDD-44D4-07A9-BB68-3093E01C7887";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 23 0.07;
createNode expression -n "expression3";
	rename -uid "93EA8DB1-4AD1-BC54-729E-EC8175F47FF6";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "// This expression animates the offset of the sine deformer on the paddle\n// moving at a fixed speed. The waves moving down the paddle keeps the generated\n// waves from just being simple linear waves. The amplitude of sine1 is keyed to start\n// at zero then increase over the first second. Just set it to be always zero if you\n// want linear waves, or delete the deformer.\n\nfloat $speed = 0.3;\n.O[0]= time * $speed;";
createNode polySubdFace -n "polySubdFace2";
	rename -uid "4C7BE3A0-433D-1DC4-D81F-B883A076D6B4";
	setAttr ".ics" -type "componentList" 1 "f[*]";
	setAttr ".duv" 2;
	setAttr ".dvv" 2;
	setAttr ".sbm" 1;
createNode polyTweak -n "polyTweak3";
	rename -uid "57D5AD3F-435F-D8C1-EBB0-749B530E6DB2";
	setAttr ".uopa" yes;
	setAttr -s 10 ".tk";
	setAttr ".tk[0]" -type "float3" 0 -0.85209078 0.10819577 ;
	setAttr ".tk[1]" -type "float3" 0 -0.85209078 0.10819577 ;
	setAttr ".tk[2]" -type "float3" 0 -0.047056518 0.14755656 ;
	setAttr ".tk[3]" -type "float3" 0 -0.047056518 0.14755656 ;
	setAttr ".tk[8]" -type "float3" 0 0.86422235 0 ;
	setAttr ".tk[9]" -type "float3" 0 0.86422235 0 ;
	setAttr ".tk[14]" -type "float3" 0 0.047056518 0.13159572 ;
	setAttr ".tk[15]" -type "float3" 0 0.047056518 0.13159572 ;
	setAttr ".tk[18]" -type "float3" 0 -0.85209078 0.10819577 ;
	setAttr ".tk[21]" -type "float3" 0 0.86422235 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace1";
	rename -uid "35CFCF98-4866-8C61-BA2E-7B9E249D02CE";
	setAttr ".ics" -type "componentList" 1 "f[0]";
	setAttr ".ix" -type "matrix" 28.633881770647797 0 0 0 0 0.26478368776505556 0 0 0 0 22.624873526964407 0
		 0.054904804359459547 -0.19093122688435527 1.066226379990868 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" 0.054904804 -0.90096474 12.378663 ;
	setAttr ".rs" 49282;
	setAttr ".lt" -type "double3" 0 3.3306690738754696e-016 2.8753623214105168 ;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -14.262036080964439 -1.7433900357394525 12.378663143473071 ;
	setAttr ".cbx" -type "double3" 14.371845689683358 -0.058539383001827483 12.378663143473071 ;
createNode polyTweak -n "polyTweak4";
	rename -uid "99A6F677-4CFD-E351-D349-6C9EB823CA42";
	setAttr ".uopa" yes;
	setAttr -s 6 ".tk";
	setAttr ".tk[0]" -type "float3" 0 -5.363121 0 ;
	setAttr ".tk[1]" -type "float3" 0 -5.363121 0 ;
	setAttr ".tk[4]" -type "float3" 0 0.41577798 0.51777107 ;
	setAttr ".tk[5]" -type "float3" 0 0.41577798 0.51777107 ;
	setAttr ".tk[6]" -type "float3" 0 0.6768381 0.51777107 ;
	setAttr ".tk[7]" -type "float3" 0 0.6768381 0.51777107 ;
createNode polySphere -n "polySphere2";
	rename -uid "B09A27D5-4E37-07A8-C4E2-278DE6197E15";
createNode lambert -n "lambert2";
	rename -uid "49E659A9-40C1-16EB-FC01-9CB94F641EDA";
	setAttr ".c" -type "float3" 0 0 0 ;
createNode shadingEngine -n "lambert2SG";
	rename -uid "247ED557-4651-44EF-BF71-AAA2EF8129DB";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
	rename -uid "4988F46F-4C12-122F-D4FA-159E3807C44F";
createNode ramp -n "ramp1";
	rename -uid "CE4755A0-455F-86EF-31E5-17BB020F12B5";
	setAttr ".in" 4;
	setAttr -s 8 ".cel";
	setAttr ".cel[0].ep" 0.1551155149936676;
	setAttr ".cel[0].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[1].ep" 0.53035145998001099;
	setAttr ".cel[1].ec" -type "float3" 0.824 1 0.9627291 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0 0.023242699 0.49399999 ;
	setAttr ".cel[3].ep" 0.57827478647232056;
	setAttr ".cel[3].ec" -type "float3" 0.51436502 0.69594991 0.79500002 ;
	setAttr ".cel[4].ep" 0.49520766735076904;
	setAttr ".cel[4].ec" -type "float3" 0.278478 0.3637318 0.382 ;
	setAttr ".cel[5].ep" 0.4057508111000061;
	setAttr ".cel[5].ec" -type "float3" 0.33500001 0.32722041 0.24053 ;
	setAttr ".cel[6].ep" 0.30670925974845886;
	setAttr ".cel[6].ec" -type "float3" 0.13500001 0.11746607 0.097740002 ;
	setAttr ".cel[7].ep" 0.64217251539230347;
	setAttr ".cel[7].ec" -type "float3" 0.13260999 0.196675 0.57160199 ;
	setAttr ".sn" 0.29268291592597961;
	setAttr ".vn" 0.016260163858532906;
createNode place2dTexture -n "place2dTexture1";
	rename -uid "290A9E0A-4782-C202-8B07-2AAAEBDC1A69";
createNode unitConversion -n "unitConversion1";
	rename -uid "7B35E276-459A-E1AB-E51F-2C99478BB620";
	setAttr ".cf" 0.017453292519943295;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "CA1524B2-41DC-DBFF-D692-51AF63A82726";
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
		+ "            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"wavePanelShorelineCam\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n"
		+ "                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -rendererName \"vp2Renderer\" \n                -objectFilterShowInHUD 1\n"
		+ "                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n"
		+ "                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 1416\n                -height 851\n                -sceneRenderFilter 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"wavePanelShorelineCam\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n"
		+ "            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n"
		+ "            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1416\n            -height 851\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n"
		+ "        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n                -docTag \"isolOutln_fromSeln\" \n                -showShapes 0\n                -showReferenceNodes 1\n                -showReferenceMembers 1\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 1\n                -showAssets 1\n                -showContainedOnly 1\n                -showPublishedAsConnected 0\n"
		+ "                -showContainerContents 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n"
		+ "                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 0\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n"
		+ "            -showPublishedAsConnected 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n"
		+ "            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n"
		+ "                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n"
		+ "                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n"
		+ "                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n"
		+ "                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n"
		+ "                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n"
		+ "                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n"
		+ "                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n"
		+ "                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n"
		+ "                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n"
		+ "                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"sequenceEditorPanel\" -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n"
		+ "                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n"
		+ "                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n"
		+ "                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n"
		+ "                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -activeTab -1\n                -editorMode \"default\" \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n"
		+ "                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -activeTab -1\n                -editorMode \"default\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"createNodePanel\" -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" (localizedPanelLabel(\"Blend Shape\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"profilerPanel\" -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"wavePanelShorelineCam\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1416\\n    -height 851\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"wavePanelShorelineCam\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1416\\n    -height 851\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode nodeGraphEditorInfo -n "hyperShadePrimaryNodeEditorSavedTabsInfo";
	rename -uid "DACFEC6F-4EBB-6E0C-3EAC-65951C14F47E";
	setAttr ".pee" yes;
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" 0 -30.95237972244389 ;
	setAttr ".tgi[0].vh" -type "double2" 114.28570974440821 0 ;
	setAttr -s 73 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[0].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[0].nvs" 1922;
	setAttr ".tgi[0].ni[1].x" 44.285713195800781;
	setAttr ".tgi[0].ni[1].y" -9364.2861328125;
	setAttr ".tgi[0].ni[1].nvs" 1923;
	setAttr ".tgi[0].ni[2].x" 2294.28564453125;
	setAttr ".tgi[0].ni[2].y" -2130;
	setAttr ".tgi[0].ni[2].nvs" 2034;
	setAttr ".tgi[0].ni[3].x" 44.285713195800781;
	setAttr ".tgi[0].ni[3].y" -8852.857421875;
	setAttr ".tgi[0].ni[3].nvs" 1923;
	setAttr ".tgi[0].ni[4].x" 2264.28564453125;
	setAttr ".tgi[0].ni[4].y" -1237.142822265625;
	setAttr ".tgi[0].ni[4].nvs" 2706;
	setAttr ".tgi[0].ni[5].x" 1125.7142333984375;
	setAttr ".tgi[0].ni[5].y" -5537.14306640625;
	setAttr ".tgi[0].ni[5].nvs" 1923;
	setAttr ".tgi[0].ni[6].x" 2294.28564453125;
	setAttr ".tgi[0].ni[6].y" -2948.571533203125;
	setAttr ".tgi[0].ni[6].nvs" 2034;
	setAttr ".tgi[0].ni[7].x" 262.85714721679687;
	setAttr ".tgi[0].ni[7].y" -10497.142578125;
	setAttr ".tgi[0].ni[7].nvs" 1922;
	setAttr ".tgi[0].ni[8].x" 44.285713195800781;
	setAttr ".tgi[0].ni[8].y" -8345.7138671875;
	setAttr ".tgi[0].ni[8].nvs" 1923;
	setAttr ".tgi[0].ni[9].x" 2961.428466796875;
	setAttr ".tgi[0].ni[9].y" -1261.4285888671875;
	setAttr ".tgi[0].ni[9].nvs" 3058;
	setAttr ".tgi[0].ni[10].x" 44.285713195800781;
	setAttr ".tgi[0].ni[10].y" -7834.28564453125;
	setAttr ".tgi[0].ni[10].nvs" 1923;
	setAttr ".tgi[0].ni[11].x" 3324.28564453125;
	setAttr ".tgi[0].ni[11].y" -1534.2857666015625;
	setAttr ".tgi[0].ni[11].nvs" 3122;
	setAttr ".tgi[0].ni[12].x" 3694.28564453125;
	setAttr ".tgi[0].ni[12].y" -2722.857177734375;
	setAttr ".tgi[0].ni[12].nvs" 1923;
	setAttr ".tgi[0].ni[13].x" 3694.28564453125;
	setAttr ".tgi[0].ni[13].y" -1847.142822265625;
	setAttr ".tgi[0].ni[13].nvs" 1922;
	setAttr ".tgi[0].ni[14].x" 2631.428466796875;
	setAttr ".tgi[0].ni[14].y" -2630;
	setAttr ".tgi[0].ni[14].nvs" 1923;
	setAttr ".tgi[0].ni[15].x" 298.57144165039062;
	setAttr ".tgi[0].ni[15].y" -9822.857421875;
	setAttr ".tgi[0].ni[15].nvs" 1922;
	setAttr ".tgi[0].ni[16].x" 44.285713195800781;
	setAttr ".tgi[0].ni[16].y" -7322.85693359375;
	setAttr ".tgi[0].ni[16].nvs" 1923;
	setAttr ".tgi[0].ni[17].x" 2294.28564453125;
	setAttr ".tgi[0].ni[17].y" -275.71429443359375;
	setAttr ".tgi[0].ni[17].nvs" 2034;
	setAttr ".tgi[0].ni[18].x" 44.285713195800781;
	setAttr ".tgi[0].ni[18].y" -6811.4287109375;
	setAttr ".tgi[0].ni[18].nvs" 1923;
	setAttr ".tgi[0].ni[19].x" 292.85714721679687;
	setAttr ".tgi[0].ni[19].y" -9221.4287109375;
	setAttr ".tgi[0].ni[19].nvs" 2050;
	setAttr ".tgi[0].ni[20].x" 298.57144165039062;
	setAttr ".tgi[0].ni[20].y" -8857.142578125;
	setAttr ".tgi[0].ni[20].nvs" 1923;
	setAttr ".tgi[0].ni[21].x" 292.85714721679687;
	setAttr ".tgi[0].ni[21].y" -8198.5712890625;
	setAttr ".tgi[0].ni[21].nvs" 2050;
	setAttr ".tgi[0].ni[22].x" 1464.2857666015625;
	setAttr ".tgi[0].ni[22].y" -24.285715103149414;
	setAttr ".tgi[0].ni[22].nvs" 1923;
	setAttr ".tgi[0].ni[23].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[23].y" -2852.857177734375;
	setAttr ".tgi[0].ni[23].nvs" 1923;
	setAttr ".tgi[0].ni[24].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[24].y" -3135.71435546875;
	setAttr ".tgi[0].ni[24].nvs" 1922;
	setAttr ".tgi[0].ni[25].x" 298.57144165039062;
	setAttr ".tgi[0].ni[25].y" -7834.28564453125;
	setAttr ".tgi[0].ni[25].nvs" 1923;
	setAttr ".tgi[0].ni[26].x" 574.28570556640625;
	setAttr ".tgi[0].ni[26].y" -4878.5712890625;
	setAttr ".tgi[0].ni[26].nvs" 1922;
	setAttr ".tgi[0].ni[27].x" 298.57144165039062;
	setAttr ".tgi[0].ni[27].y" -7322.85693359375;
	setAttr ".tgi[0].ni[27].nvs" 1923;
	setAttr ".tgi[0].ni[28].x" 290;
	setAttr ".tgi[0].ni[28].y" -6675.71435546875;
	setAttr ".tgi[0].ni[28].nvs" 1922;
	setAttr ".tgi[0].ni[29].x" 157.14285278320312;
	setAttr ".tgi[0].ni[29].y" -2310;
	setAttr ".tgi[0].ni[29].nvs" 1922;
	setAttr ".tgi[0].ni[30].x" 418.57144165039062;
	setAttr ".tgi[0].ni[30].y" -2367.142822265625;
	setAttr ".tgi[0].ni[30].nvs" 1922;
	setAttr ".tgi[0].ni[31].x" 1464.2857666015625;
	setAttr ".tgi[0].ni[31].y" -930;
	setAttr ".tgi[0].ni[31].nvs" 1922;
	setAttr ".tgi[0].ni[32].x" 680;
	setAttr ".tgi[0].ni[32].y" -2362.857177734375;
	setAttr ".tgi[0].ni[32].nvs" 1922;
	setAttr ".tgi[0].ni[33].x" 941.4285888671875;
	setAttr ".tgi[0].ni[33].y" -2362.857177734375;
	setAttr ".tgi[0].ni[33].nvs" 1922;
	setAttr ".tgi[0].ni[34].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[34].y" -10631.4287109375;
	setAttr ".tgi[0].ni[34].nvs" 1922;
	setAttr ".tgi[0].ni[35].x" 602.85711669921875;
	setAttr ".tgi[0].ni[35].y" -5564.28564453125;
	setAttr ".tgi[0].ni[35].nvs" 1922;
	setAttr ".tgi[0].ni[36].x" 34.285713195800781;
	setAttr ".tgi[0].ni[36].y" -6344.28564453125;
	setAttr ".tgi[0].ni[36].nvs" 1922;
	setAttr ".tgi[0].ni[37].x" 3378.571533203125;
	setAttr ".tgi[0].ni[37].y" -1178.5714111328125;
	setAttr ".tgi[0].ni[37].nvs" 1923;
	setAttr ".tgi[0].ni[38].x" 3694.28564453125;
	setAttr ".tgi[0].ni[38].y" -1590;
	setAttr ".tgi[0].ni[38].nvs" 1923;
	setAttr ".tgi[0].ni[39].x" 3378.571533203125;
	setAttr ".tgi[0].ni[39].y" -2730;
	setAttr ".tgi[0].ni[39].nvs" 1922;
	setAttr ".tgi[0].ni[40].x" 2595.71435546875;
	setAttr ".tgi[0].ni[40].y" -1921.4285888671875;
	setAttr ".tgi[0].ni[40].nvs" 2706;
	setAttr ".tgi[0].ni[41].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[41].y" -952.85711669921875;
	setAttr ".tgi[0].ni[41].nvs" 1922;
	setAttr ".tgi[0].ni[42].x" 2004.2857666015625;
	setAttr ".tgi[0].ni[42].y" -952.85711669921875;
	setAttr ".tgi[0].ni[42].nvs" 1922;
	setAttr ".tgi[0].ni[43].x" 2625.71435546875;
	setAttr ".tgi[0].ni[43].y" -2328.571533203125;
	setAttr ".tgi[0].ni[43].nvs" 2034;
	setAttr ".tgi[0].ni[44].x" 2625.71435546875;
	setAttr ".tgi[0].ni[44].y" -3158.571533203125;
	setAttr ".tgi[0].ni[44].nvs" 2034;
	setAttr ".tgi[0].ni[45].x" 298.57144165039062;
	setAttr ".tgi[0].ni[45].y" -6330;
	setAttr ".tgi[0].ni[45].nvs" 1922;
	setAttr ".tgi[0].ni[46].x" 2004.2857666015625;
	setAttr ".tgi[0].ni[46].y" -485.71429443359375;
	setAttr ".tgi[0].ni[46].nvs" 1922;
	setAttr ".tgi[0].ni[47].x" 2625.71435546875;
	setAttr ".tgi[0].ni[47].y" -911.4285888671875;
	setAttr ".tgi[0].ni[47].nvs" 2034;
	setAttr ".tgi[0].ni[48].x" 3694.28564453125;
	setAttr ".tgi[0].ni[48].y" -1371.4285888671875;
	setAttr ".tgi[0].ni[48].nvs" 1923;
	setAttr ".tgi[0].ni[49].x" 3955.71435546875;
	setAttr ".tgi[0].ni[49].y" -1700;
	setAttr ".tgi[0].ni[49].nvs" 1923;
	setAttr ".tgi[0].ni[50].x" 1464.2857666015625;
	setAttr ".tgi[0].ni[50].y" -2305.71435546875;
	setAttr ".tgi[0].ni[50].nvs" 1922;
	setAttr ".tgi[0].ni[51].x" 1202.857177734375;
	setAttr ".tgi[0].ni[51].y" -2362.857177734375;
	setAttr ".tgi[0].ni[51].nvs" 1922;
	setAttr ".tgi[0].ni[52].x" 2631.428466796875;
	setAttr ".tgi[0].ni[52].y" -248.57142639160156;
	setAttr ".tgi[0].ni[52].nvs" 1923;
	setAttr ".tgi[0].ni[53].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[53].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[53].nvs" 1923;
	setAttr ".tgi[0].ni[54].x" 2004.2857666015625;
	setAttr ".tgi[0].ni[54].y" -17.142856597900391;
	setAttr ".tgi[0].ni[54].nvs" 1923;
	setAttr ".tgi[0].ni[55].x" 2300;
	setAttr ".tgi[0].ni[55].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[55].nvs" 1923;
	setAttr ".tgi[0].ni[56].x" 2004.2857666015625;
	setAttr ".tgi[0].ni[56].y" -3267.142822265625;
	setAttr ".tgi[0].ni[56].nvs" 1922;
	setAttr ".tgi[0].ni[57].x" 2004.2857666015625;
	setAttr ".tgi[0].ni[57].y" -2935.71435546875;
	setAttr ".tgi[0].ni[57].nvs" 1922;
	setAttr ".tgi[0].ni[58].x" 2624.28564453125;
	setAttr ".tgi[0].ni[58].y" -3438.571533203125;
	setAttr ".tgi[0].ni[58].nvs" 2066;
	setAttr ".tgi[0].ni[59].x" 2624.28564453125;
	setAttr ".tgi[0].ni[59].y" -2900;
	setAttr ".tgi[0].ni[59].nvs" 2066;
	setAttr ".tgi[0].ni[60].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[60].y" -3680;
	setAttr ".tgi[0].ni[60].nvs" 1922;
	setAttr ".tgi[0].ni[61].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[61].y" -3931.428466796875;
	setAttr ".tgi[0].ni[61].nvs" 1922;
	setAttr ".tgi[0].ni[62].x" 2004.2857666015625;
	setAttr ".tgi[0].ni[62].y" -2310;
	setAttr ".tgi[0].ni[62].nvs" 1922;
	setAttr ".tgi[0].ni[63].x" 1725.7142333984375;
	setAttr ".tgi[0].ni[63].y" -2362.857177734375;
	setAttr ".tgi[0].ni[63].nvs" 1922;
	setAttr ".tgi[0].ni[64].x" 2631.428466796875;
	setAttr ".tgi[0].ni[64].y" -1230;
	setAttr ".tgi[0].ni[64].nvs" 1922;
	setAttr ".tgi[0].ni[65].x" 2300;
	setAttr ".tgi[0].ni[65].y" -987.14288330078125;
	setAttr ".tgi[0].ni[65].nvs" 1922;
	setAttr ".tgi[0].ni[66].x" 312.85714721679687;
	setAttr ".tgi[0].ni[66].y" -5054.28564453125;
	setAttr ".tgi[0].ni[66].nvs" 1922;
	setAttr ".tgi[0].ni[67].x" 574.28570556640625;
	setAttr ".tgi[0].ni[67].y" -4471.4287109375;
	setAttr ".tgi[0].ni[67].nvs" 1923;
	setAttr ".tgi[0].ni[68].x" 835.71429443359375;
	setAttr ".tgi[0].ni[68].y" -4804.28564453125;
	setAttr ".tgi[0].ni[68].nvs" 1923;
	setAttr ".tgi[0].ni[69].x" 312.85714721679687;
	setAttr ".tgi[0].ni[69].y" -4540;
	setAttr ".tgi[0].ni[69].nvs" 1923;
	setAttr ".tgi[0].ni[70].x" 51.428569793701172;
	setAttr ".tgi[0].ni[70].y" -4558.5712890625;
	setAttr ".tgi[0].ni[70].nvs" 1923;
	setAttr ".tgi[0].ni[71].x" 864.28570556640625;
	setAttr ".tgi[0].ni[71].y" -5560;
	setAttr ".tgi[0].ni[71].nvs" 1923;
	setAttr ".tgi[0].ni[72].x" 44.285713195800781;
	setAttr ".tgi[0].ni[72].y" -5832.85693359375;
	setAttr ".tgi[0].ni[72].nvs" 1922;
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
	setAttr -s 4 ".u";
select -ne :defaultRenderingList1;
select -ne :lightList1;
	setAttr -s 2 ".l";
select -ne :defaultTextureList1;
	setAttr -s 2 ".tx";
select -ne :initialShadingGroup;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
	setAttr -s 2 ".dsm";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
connectAttr "polySubdFace2.out" "shorelineCollisionShape1.i";
connectAttr "polyExtrudeFace1.out" "waterEmitterMesh1Shape.i";
connectAttr "unitConversion1.o" "wavePaddle1.rx";
connectAttr "sine1GroupId.id" "wavePaddleShape1.iog.og[0].gid";
connectAttr "sine1Set.mwc" "wavePaddleShape1.iog.og[0].gco";
connectAttr "groupId2.id" "wavePaddleShape1.iog.og[1].gid";
connectAttr "tweakSet1.mwc" "wavePaddleShape1.iog.og[1].gco";
connectAttr "sine1.og[0]" "wavePaddleShape1.i";
connectAttr "tweak1.vl[0].vt[0]" "wavePaddleShape1.twl";
connectAttr "polyCube3.out" "wavePaddleShape3Orig1.i";
connectAttr ":time1.o" "bifrostLiquidContainer1.ctm";
connectAttr "pCubeShape2AttrNotif.om" "bifrostLiquidContainer1.Emitters[0]";
connectAttr "pCubeShape1AttrNotif.om" "bifrostLiquidContainer1.Colliders[0]";
connectAttr "pCubeShape3AttrNotif.om" "bifrostLiquidContainer1.Colliders[1]";
connectAttr "pSphereShape1AttrNotif.om" "bifrostLiquidContainer1.Colliders[2]";
connectAttr "bifrostKillplane1.wm" "bifrostLiquidContainer1.killplanes[0]";
connectAttr "bifrostLiquidContainer1.Liquid" "bifrostShape1.obj";
connectAttr "bifrostMeshMRUserData1.msg" "bifrostMesh1.miData";
connectAttr "bifrostShape1.mout" "bifrostMeshShape1.i";
connectAttr "polySphere1.out" "pSphereShape1.i";
connectAttr "sine1.msg" "sine1Handle.sml";
connectAttr "sine1.amp" "sine1HandleShape.amp";
connectAttr "sine1.wav" "sine1HandleShape.wav";
connectAttr "sine1.off" "sine1HandleShape.off";
connectAttr "sine1.dr" "sine1HandleShape.dr";
connectAttr "sine1.lb" "sine1HandleShape.lb";
connectAttr "sine1.hb" "sine1HandleShape.hb";
connectAttr "polySphere2.out" "pSphereShape2.i";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bifrostLiquidMaterial1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "rampShader1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bifrostLiquidMaterial1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "rampShader1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":mentalrayGlobals.msg" ":mentalrayItemsList.glb";
connectAttr ":miDefaultOptions.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayItemsList.fb" -na;
connectAttr ":miDefaultOptions.msg" ":mentalrayGlobals.opt";
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayGlobals.fb";
connectAttr "polyCube1.out" "deleteComponent1.ig";
connectAttr "deleteComponent1.og" "polyTweak1.ip";
connectAttr "polyTweak1.out" "deleteComponent2.ig";
connectAttr ":time1.o" "expression1.tim";
connectAttr "bifrostLiquidMaterial1.oc" "bifrostLiquidMaterial1SG.ss";
connectAttr "bifrostShape1.iog" "bifrostLiquidMaterial1SG.dsm" -na;
connectAttr "bifrostLiquidContainer1.Liquid" "bifrostMeshMRUserData1.val";
connectAttr "waterEmitterMesh1Shape.bifrostLiquidEnable" "pCubeShape2AttrNotif.bifrostLiquidEnable"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidContinuousEmission" "pCubeShape2AttrNotif.bifrostLiquidContinuousEmission"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidThickness" "pCubeShape2AttrNotif.bifrostLiquidThickness"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidMode" "pCubeShape2AttrNotif.bifrostLiquidMode"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidDensity" "pCubeShape2AttrNotif.bifrostLiquidDensity"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidExpansionRate" "pCubeShape2AttrNotif.bifrostLiquidExpansionRate"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidStictionStrength" "pCubeShape2AttrNotif.bifrostLiquidStictionStrength"
		;
connectAttr "waterEmitterMesh1Shape.bifrostLiquidStictionBandwidth" "pCubeShape2AttrNotif.bifrostLiquidStictionBandwidth"
		;
connectAttr "waterEmitterMesh1Shape.w" "pCubeShape2AttrNotif.im";
connectAttr "polyCube2.out" "createColorSet1.ig";
connectAttr "createColorSet1.og" "createColorSet2.ig";
connectAttr "shorelineCollisionShape1.bifrostColliderEnable" "pCubeShape1AttrNotif.bifrostColliderEnable"
		;
connectAttr "shorelineCollisionShape1.bifrostColliderThickness" "pCubeShape1AttrNotif.bifrostColliderThickness"
		;
connectAttr "shorelineCollisionShape1.bifrostColliderMode" "pCubeShape1AttrNotif.bifrostColliderMode"
		;
connectAttr "shorelineCollisionShape1.w" "pCubeShape1AttrNotif.im";
connectAttr "wavePaddleShape1.bifrostColliderEnable" "pCubeShape3AttrNotif.bifrostColliderEnable"
		;
connectAttr "wavePaddleShape1.bifrostColliderThickness" "pCubeShape3AttrNotif.bifrostColliderThickness"
		;
connectAttr "wavePaddleShape1.bifrostColliderMode" "pCubeShape3AttrNotif.bifrostColliderMode"
		;
connectAttr "wavePaddleShape1.w" "pCubeShape3AttrNotif.im";
connectAttr "pSphereShape1.bifrostColliderEnable" "pSphereShape1AttrNotif.bifrostColliderEnable"
		;
connectAttr "pSphereShape1.bifrostColliderThickness" "pSphereShape1AttrNotif.bifrostColliderThickness"
		;
connectAttr "pSphereShape1.bifrostColliderMode" "pSphereShape1AttrNotif.bifrostColliderMode"
		;
connectAttr "pSphereShape1.w" "pSphereShape1AttrNotif.im";
connectAttr "rampShader1.oc" "rampShader1SG.ss";
connectAttr "bifrostMeshShape1.iog" "rampShader1SG.dsm" -na;
connectAttr "rampShader1SG.msg" "materialInfo1.sg";
connectAttr "rampShader1.msg" "materialInfo1.m";
connectAttr "rampShader1.msg" "materialInfo1.t" -na;
connectAttr "polyTweak2.out" "polySubdFace1.ip";
connectAttr "deleteComponent2.og" "polyTweak2.ip";
connectAttr "rampShader2.oc" "blinn1SG.ss";
connectAttr "pSphereShape1.iog" "blinn1SG.dsm" -na;
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "rampShader2.msg" "materialInfo2.m";
connectAttr "rampShader2.msg" "materialInfo2.t" -na;
connectAttr "place3dTexture1.wim" "solidFractal1.pm";
connectAttr "solidFractal1.oa" "bump3d1.bv";
connectAttr "bump3d1.o" "rampShader2.n";
connectAttr "sine1_amplitude.o" "sine1.amp";
connectAttr "expression3.out[0]" "sine1.off";
connectAttr "sine1GroupParts.og" "sine1.ip[0].ig";
connectAttr "sine1GroupId.id" "sine1.ip[0].gi";
connectAttr "sine1HandleShape.dd" "sine1.dd";
connectAttr "sine1Handle.wm" "sine1.ma";
connectAttr "groupParts2.og" "tweak1.ip[0].ig";
connectAttr "groupId2.id" "tweak1.ip[0].gi";
connectAttr "sine1GroupId.msg" "sine1Set.gn" -na;
connectAttr "wavePaddleShape1.iog.og[0]" "sine1Set.dsm" -na;
connectAttr "sine1.msg" "sine1Set.ub[0]";
connectAttr "tweak1.og[0]" "sine1GroupParts.ig";
connectAttr "sine1GroupId.id" "sine1GroupParts.gi";
connectAttr "groupId2.msg" "tweakSet1.gn" -na;
connectAttr "wavePaddleShape1.iog.og[1]" "tweakSet1.dsm" -na;
connectAttr "tweak1.msg" "tweakSet1.ub[0]";
connectAttr "wavePaddleShape3Orig1.w" "groupParts2.ig";
connectAttr "groupId2.id" "groupParts2.gi";
connectAttr ":time1.o" "expression3.tim";
connectAttr "polyTweak3.out" "polySubdFace2.ip";
connectAttr "polySubdFace1.out" "polyTweak3.ip";
connectAttr "polyTweak4.out" "polyExtrudeFace1.ip";
connectAttr "waterEmitterMesh1Shape.wm" "polyExtrudeFace1.mp";
connectAttr "createColorSet2.og" "polyTweak4.ip";
connectAttr "ramp1.oc" "lambert2.ic";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "pSphereShape2.iog" "lambert2SG.dsm" -na;
connectAttr "lambert2SG.msg" "materialInfo3.sg";
connectAttr "lambert2.msg" "materialInfo3.m";
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "expression1.out[0]" "unitConversion1.i";
connectAttr "defaultRenderLayer.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[0].dn"
		;
connectAttr "shorelineCollision1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[1].dn"
		;
connectAttr "shorelineCollisionShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "waterEmitterMesh1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[3].dn"
		;
connectAttr "waterEmitterMesh1Shape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[4].dn"
		;
connectAttr "wavePaddle1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[5].dn"
		;
connectAttr "wavePaddleShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[6].dn"
		;
connectAttr "wavePaddleShape3Orig1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[7].dn"
		;
connectAttr "bifrostLiquid1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[8].dn"
		;
connectAttr "bifrostLiquidContainer1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[9].dn"
		;
connectAttr "bifrost1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[10].dn"
		;
connectAttr "bifrostShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[11].dn"
		;
connectAttr "bifrostMesh1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[12].dn"
		;
connectAttr "bifrostMeshShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[13].dn"
		;
connectAttr "bifrostKillplane1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[14].dn"
		;
connectAttr "bifrostKillplaneShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[15].dn"
		;
connectAttr "pSphere1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[16].dn"
		;
connectAttr "pSphereShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[17].dn"
		;
connectAttr "directionalLight1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[18].dn"
		;
connectAttr "directionalLightShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[19].dn"
		;
connectAttr "pointLight1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[20].dn"
		;
connectAttr "pointLightShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[21].dn"
		;
connectAttr "place3dTexture1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[22].dn"
		;
connectAttr "sine1Handle.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[23].dn"
		;
connectAttr "sine1HandleShape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[24].dn"
		;
connectAttr "pSphere2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[25].dn"
		;
connectAttr "pSphereShape2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[26].dn"
		;
connectAttr "wavePanelShorelineCam.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[27].dn"
		;
connectAttr "wavePanelShorelineCamShape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[28].dn"
		;
connectAttr "polyCube1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[29].dn"
		;
connectAttr "deleteComponent1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[30].dn"
		;
connectAttr "polyCube2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[31].dn"
		;
connectAttr "polyTweak1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[32].dn"
		;
connectAttr "deleteComponent2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[33].dn"
		;
connectAttr "polyCube3.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[34].dn"
		;
connectAttr "expression1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[35].dn"
		;
connectAttr "sceneConfigurationScriptNode.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[36].dn"
		;
connectAttr "bifrostLiquidMaterial1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[37].dn"
		;
connectAttr "bifrostLiquidMaterial1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[38].dn"
		;
connectAttr "bifrostMeshMRUserData1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[39].dn"
		;
connectAttr "pCubeShape2AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[40].dn"
		;
connectAttr "createColorSet1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[41].dn"
		;
connectAttr "createColorSet2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[42].dn"
		;
connectAttr "pCubeShape1AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[43].dn"
		;
connectAttr "pCubeShape3AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[44].dn"
		;
connectAttr "bifrostKillplane1AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[45].dn"
		;
connectAttr "polySphere1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[46].dn"
		;
connectAttr "pSphereShape1AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[47].dn"
		;
connectAttr "rampShader1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[48].dn"
		;
connectAttr "rampShader1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[49].dn"
		;
connectAttr "polySubdFace1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[50].dn"
		;
connectAttr "polyTweak2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[51].dn"
		;
connectAttr "blinn1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[52].dn"
		;
connectAttr "solidFractal1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[53].dn"
		;
connectAttr "bump3d1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[54].dn"
		;
connectAttr "rampShader2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[55].dn"
		;
connectAttr "sine1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[56].dn"
		;
connectAttr "tweak1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[57].dn"
		;
connectAttr "sine1Set.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[58].dn"
		;
connectAttr "tweakSet1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[59].dn"
		;
connectAttr "sine1_amplitude.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[60].dn"
		;
connectAttr "expression3.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[61].dn"
		;
connectAttr "polySubdFace2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[62].dn"
		;
connectAttr "polyTweak3.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[63].dn"
		;
connectAttr "polyExtrudeFace1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[64].dn"
		;
connectAttr "polyTweak4.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[65].dn"
		;
connectAttr "polySphere2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[66].dn"
		;
connectAttr "lambert2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[67].dn"
		;
connectAttr "lambert2SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[68].dn"
		;
connectAttr "ramp1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[69].dn"
		;
connectAttr "place2dTexture1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[70].dn"
		;
connectAttr "unitConversion1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[71].dn"
		;
connectAttr "uiConfigurationScriptNode.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[72].dn"
		;
connectAttr "bifrostLiquidMaterial1SG.pa" ":renderPartition.st" -na;
connectAttr "rampShader1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "bifrostLiquidMaterial1.msg" ":defaultShaderList1.s" -na;
connectAttr "rampShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "rampShader2.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "bifrostMeshMRUserData1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "bump3d1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "pointLightShape1.ltd" ":lightList1.l" -na;
connectAttr "solidFractal1.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "shorelineCollisionShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "waterEmitterMesh1Shape.iog" ":initialShadingGroup.dsm" -na;
connectAttr "wavePaddleShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr ":perspShape.msg" ":defaultRenderGlobals.sc";
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
connectAttr "pointLight1.iog" ":defaultLightSet.dsm" -na;
// End of wavePaddleShoreline.ma
