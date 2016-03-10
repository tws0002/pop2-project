//Maya ASCII 2016 scene
//Name: propellerTank.ma
//Last modified: Tue, Feb 24, 2015 12:49:30 PM
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
	rename -uid "3CA0A068-495B-0AFA-C6B6-6F9002218E8F";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-014 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "A35BF646-4A39-D6B2-C196-87A510BA8AD8";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "92C18320-44A2-1997-C68C-43B2E7FEB846";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "8E3E77F8-46E3-6A49-E8B4-1886345B190D";
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
	rename -uid "76BA8414-4BD0-3650-7B90-8DACC0BDA2D0";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "8F4B354D-4655-92AE-FEE2-5C842BB4A7A6";
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
	rename -uid "C3B44BB0-4A20-56FA-5579-208B079641F0";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "4F83481F-466B-54AB-64D2-4D9872524354";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "bifrostLiquid";
	rename -uid "36AA5FE4-423F-53FA-5311-7E9C755BECA0";
createNode bifrostContainer -n "bifrostLiquidContainer" -p "bifrostLiquid";
	rename -uid "A3187F24-4625-4178-B5FA-10A108C99E26";
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
		-at "float";
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
	addAttr -w false -s false -sn "Liquid" -ln "Liquid" -dt "string";
	addAttr -r false -ci true -k true -m -sn "killplanes" -ln "killplanes" -at "matrix";
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
	setAttr ".ove" yes;
	setAttr ".sc" -type "string" (
		"{\"version\":3,\"runtimeVersion\":\"2.0\",\"graphName\":\"_bifrostLiquid_bifrostLiquidContainer::liquid\",\"graphCode\":\"{\\n    \\\"header\\\": {\\n        \\\"metadata\\\": [\\n            {\\n                \\\"metaName\\\": \\\"version\\\",\\n                \\\"metaValue\\\": \\\"100L\\\"\\n            },\\n            {\\n                \\\"metaName\\\": \\\"adskFileFormatVersion\\\",\\n                \\\"metaValue\\\": \\\"100L\\\"\\n            }\\n        ]\\n    },\\n    \\\"dependencies\\\": [\\n        {\\n            \\\"uri\\\": \\\"file:///createMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///keepMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createObjectWhenCaching.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///cacheObjectToDisk.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///solveLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeVoxelLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopePointLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeSolids.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///foam.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createEmptyItems.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///updateSubStepIterator.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///basenodes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///keepMeshes.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createObjectWhenCaching.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///cacheObjectToDisk.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///solveLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeVoxelLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopePointLiquid.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///scopeSolids.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///foam.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///createEmptyItems.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///updateSubStepIterator.json\\\"\\n        },\\n        {\\n            \\\"uri\\\": \\\"file:///basenodes.json\\\"\\n        }\\n    ],\\n    \\\"types\\\": [],\\n    \\\"operators\\\": [],\\n    \\\"compounds\\\": [\\n        {\\n            \\\"name\\\": \\\"_bifrostLiquid_bifrostLiquidContainer::liquid\\\",\\n            \\\"uriImported\\\": \\\"file:///liquid.json\\\",\\n            \\\"ports\\\": [\\n                {\\n                    \\\"portName\\\": \\\"Emitters\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Colliders\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Accelerators\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"masterVoxelSize\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"gravityMagnitude\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"gravityDirection\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"forceVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"transportStepAdaptivity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"transportTimeScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minSteps\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxSteps\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dropletThreshold\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dropletMergeBackDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceBandWidth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"interiorParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"killplanes\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"viscosityScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Liquid\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Solid\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceTension\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityDecay\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityMult\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityMax\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceTensionEnable\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"vorticityEnable\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Foam\\\",\\n                    \\\"portDirection\\\": \\\"output\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::ObjectDescriptor\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraMatrixList\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableFoam\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableGuiding\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromHighResLiquid\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minSimulationDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"guideVoxelScale\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedParticleDensity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedGuideOverlap\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"reseedLiquidOverlap\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"Guides\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minReseedAirDistance\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"simulationCacheFilename\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"simulationCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromSimulationCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"computeGuideFromMesh\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxMin\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxMax\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipBBoxTransform\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"Bifrost::Types::Mat44Float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"liquidCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableLiquidCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"solidCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableSolidCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCacheControl\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCompressionQuality\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"int\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCachePath\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"foamCacheFileName\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"string\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"enableFoamCache\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"deleteExceedingParticles\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"emissionRate\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidSpeed\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidChurn\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidCurvature\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"minLiquidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxLiquidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"inheritLiquidVelocity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"emitFlatnessToSurface\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"dissipationRate\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"killDensityThreshold\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"buoyancy\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"collideKillDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"windX\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"windZ\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"surfaceOffset\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"snapToSurface\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"pointRadius\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"preserveVolume\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"maxSolidDepth\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraAdaptivity\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"clipToCameraFrustum\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"bool\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraFov\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraAspect\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                },\\n                {\\n                    \\\"portName\\\": \\\"cameraBuffer\\\",\\n                    \\\"portDirection\\\": \\\"input\\\",\\n                    \\\"portType\\\": \\\"float\\\"\\n                }\\n            ],\\n            \\\"compounds\\\": [\\n                {\\n                    \\\"name\\\": \\\"subStepLiquid\\\",\\n                    \\\"uriImported\\\": \\\"file:///liquid.json\\\",\\n                    \\\"ports\\\": [\\n                        {\\n                            \\\"portName\\\": \\\"Emitters\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Colliders\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Accelerators\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"masterVoxelSize\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"gravityMagnitude\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"gravityDirection\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"solidVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"forceVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"transportStepAdaptivity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"transportTimeScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minSteps\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"int\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"maxSteps\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"int\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dropletThreshold\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dropletMergeBackDepth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfaceBandWidth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"interiorPointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfacePointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"killPlanes\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Mat44FloatArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"PIC\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"viscosityMult\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"dynamicSurfaceTension\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityDecay\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityMul\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityMax\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"surfaceTensionEnable\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"vorticityEnable\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"simulationCacheFilename\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"string\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"simulationCachePath\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"string\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"enableGuiding\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromHighResLiquid\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minSimulationDepth\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"guideVoxelScale\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedPointDensity\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedGuideOverlap\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"reseedLiquidOverlap\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Guides\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::IOMeshArray\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"minReseedAirDistance\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Liquid\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Object\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"Solid\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Object\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"ittr_input\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"ittr_output\\\",\\n                            \\\"portDirection\\\": \\\"output\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromSimulationCache\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"computeGuideFromMesh\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxMin\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxMax\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Vec3Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"bboxTransform\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"Bifrost::Types::Mat44Float\\\"\\n                        },\\n                        {\\n                            \\\"portName\\\": \\\"deleteExceedingPoints\\\",\\n                            \\\"portDirection\\\": \\\"input\\\",\\n                            \\\"portType\\\": \\\"bool\\\"\\n                        }\\n                    ],\\n                    \\\"compoundNodes\\\": [\\n                        {\\n                            \\\"nodeName\\\": \\\"solveLiquid\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::solveLiquid\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"updateSubStepIterator\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::_private::updateSubStepIterator\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"getLiquidObjectName\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::_privNames::getLiquidObjectName\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"voxel_liquid-volume\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                        },\\n                        {\\n                            \\\"nodeName\\\": \\\"valueBool\\\",\\n                            \\\"nodeType\\\": \\\"Bifrost::Nodes::Math::valueBool\\\"\\n                        }\\n                    ],\\n                    \\\"connections\\\": [\\n                        {\\n                            \\\"source\\\": \\\".ittr_input\\\",\\n                            \\\"target\\\": \\\"valueBool.val\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"valueBool.value\\\",\\n                            \\\"target\\\": \\\".ittr_output\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Emitters\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Emitters\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Colliders\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Colliders\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".deleteExceedingPoints\\\",\\n                            \\\"target\\\": \\\"solveLiquid.deleteExceedingPoints\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Accelerators\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Accelerators\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".masterVoxelSize\\\",\\n                            \\\"target\\\": \\\"solveLiquid.masterVoxelSize\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".gravityMagnitude\\\",\\n                            \\\"target\\\": \\\"solveLiquid.gravityMagnitude\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".gravityDirection\\\",\\n                            \\\"target\\\": \\\"solveLiquid.gravityDirection\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".solidVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.solidVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".forceVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.forceVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".transportStepAdaptivity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.transportStepAdaptivity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".transportTimeScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.transportTimeScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minSteps\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minSteps\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".maxSteps\\\",\\n                            \\\"target\\\": \\\"solveLiquid.maxSteps\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dropletThreshold\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dropletThreshold\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dropletMergeBackDepth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dropletMergeBackDepth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfaceBandWidth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfaceBandWidth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".interiorPointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.interiorPointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfacePointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfacePointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".killPlanes\\\",\\n                            \\\"target\\\": \\\"solveLiquid.killPlanes\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".PIC\\\",\\n                            \\\"target\\\": \\\"solveLiquid.PIC\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".viscosityMult\\\",\\n                            \\\"target\\\": \\\"solveLiquid.viscosityMult\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".dynamicSurfaceTension\\\",\\n                            \\\"target\\\": \\\"solveLiquid.dynamicSurfaceTension\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityDecay\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityDecay\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityMul\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityMul\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityMax\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityMax\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".surfaceTensionEnable\\\",\\n                            \\\"target\\\": \\\"solveLiquid.surfaceTensionEnable\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".vorticityEnable\\\",\\n                            \\\"target\\\": \\\"solveLiquid.vorticityEnable\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".simulationCacheFilename\\\",\\n                            \\\"target\\\": \\\"solveLiquid.simulationCacheFilename\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".simulationCachePath\\\",\\n                            \\\"target\\\": \\\"solveLiquid.simulationCachePath\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".enableGuiding\\\",\\n                            \\\"target\\\": \\\"solveLiquid.enableGuiding\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromHighResLiquid\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromHighResLiquid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minSimulationDepth\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minSimulationDepth\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".guideVoxelScale\\\",\\n                            \\\"target\\\": \\\"solveLiquid.guideVoxelScale\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedPointDensity\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedPointDensity\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedGuideOverlap\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedGuideOverlap\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".reseedLiquidOverlap\\\",\\n                            \\\"target\\\": \\\"solveLiquid.reseedLiquidOverlap\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".Guides\\\",\\n                            \\\"target\\\": \\\"solveLiquid.Guides\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".minReseedAirDistance\\\",\\n                            \\\"target\\\": \\\"solveLiquid.minReseedAirDistance\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.Liquid\\\",\\n                            \\\"target\\\": \\\".Liquid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.Solid\\\",\\n                            \\\"target\\\": \\\".Solid\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".masterVoxelSize\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.mvs\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"solveLiquid.outLoopingCondition\\\",\\n                            \\\"target\\\": \\\".looping_condition\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromSimulationCache\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromSimulationCache\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".computeGuideFromMesh\\\",\\n                            \\\"target\\\": \\\"solveLiquid.computeGuideFromMesh\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxMin\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxMin\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxMax\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxMax\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\".bboxTransform\\\",\\n                            \\\"target\\\": \\\"solveLiquid.bboxTransform\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"updateSubStepIterator.condition\\\",\\n                            \\\"target\\\": \\\"solveLiquid.loopingCondition\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"getLiquidObjectName.value\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.objectName\\\"\\n                        },\\n                        {\\n                            \\\"source\\\": \\\"voxel_liquid-volume.value\\\",\\n                            \\\"target\\\": \\\"updateSubStepIterator.compName\\\"\\n                        }\\n                    ],\\n                    \\\"values\\\": [\\n                        {\\n                            \\\"valueName\\\": \\\"voxel_liquid-volume.str\\\",\\n                            \\\"valueType\\\": \\\"string\\\",\\n                            \\\"value\\\": \\\"voxel_liquid-volume\\\"\\n                        }\\n                    ],\\n                    \\\"whileCompound\\\": {\\n                        \\\"ports\\\": [\\n                            {\\n                                \\\"portKind\\\": \\\"state\\\",\\n                                \\\"inputPortName\\\": \\\"ittr_input\\\",\\n                                \\\"outputPortName\\\": \\\"ittr_output\\\"\\n                            }\\n                        ]\\n                    }\\n                }\\n            ],\\n            \\\"compoundNodes\\\": [\\n                {\\n                    \\\"nodeName\\\": \\\"createMeshes\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::_private::createMeshes\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"keepMeshes\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::_private::keepMeshes\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createObjectWhenCaching\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createObjectWhenCaching\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"cacheObjectToDisk\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::cacheObjectToDisk\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"voxel_liquid\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"scopeLiquid\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::scopeLiquid\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createObjectWhenCaching1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createObjectWhenCaching\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"Solids\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::valueString\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"scopeSolids\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::scopeSolids\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"foamComp\\\",\\n                    \\\"nodeType\\\": \\\"foam\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"if\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::if\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"setDescriptorFromObject2\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Object::setDescriptorFromObject\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"createEmptyItems\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::createEmptyItems\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"subStepLiquid\\\",\\n                    \\\"nodeType\\\": \\\"subStepLiquid\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"initTimestepCFL\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::_private::initTimestepCFL\\\"\\n                },\\n                {\\n                    \\\"nodeName\\\": \\\"cacheObjectToDisk1\\\",\\n                    \\\"nodeType\\\": \\\"Bifrost::Nodes::Misc::cacheObjectToDisk\\\"\\n                }\\n            ],\\n            \\\"connections\\\": [\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject.value\\\",\\n                    \\\"target\\\": \\\".Liquid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Emitters\\\",\\n                    \\\"target\\\": \\\"createMeshes.emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Colliders\\\",\\n                    \\\"target\\\": \\\"createMeshes.colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Accelerators\\\",\\n                    \\\"target\\\": \\\"createMeshes.accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject1.value\\\",\\n                    \\\"target\\\": \\\".Solid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraMatrixList\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraMatrixList\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"if.output\\\",\\n                    \\\"target\\\": \\\".Foam\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableFoam\\\",\\n                    \\\"target\\\": \\\"if.condition\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".Guides\\\",\\n                    \\\"target\\\": \\\"createMeshes.guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".masterVoxelSize\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.masterVoxelSize\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".deleteExceedingParticles\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.deleteExceedingPoints\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityMagnitude\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.gravityMagnitude\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityDirection\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.gravityDirection\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.solidVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".forceVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.forceVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".transportStepAdaptivity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.transportStepAdaptivity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".transportTimeScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.transportTimeScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minSteps\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minSteps\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxSteps\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.maxSteps\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dropletThreshold\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dropletThreshold\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dropletMergeBackDepth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dropletMergeBackDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceBandWidth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfaceBandWidth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".interiorParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.interiorPointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfacePointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".killplanes\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.killPlanes\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".viscosityScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.viscosityMult\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceTension\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.dynamicSurfaceTension\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityDecay\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityDecay\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityMult\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityMul\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityMax\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityMax\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceTensionEnable\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.surfaceTensionEnable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".vorticityEnable\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.vorticityEnable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableGuiding\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.enableGuiding\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromHighResLiquid\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromHighResLiquid\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minSimulationDepth\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minSimulationDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".guideVoxelScale\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.guideVoxelScale\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedParticleDensity\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedPointDensity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedGuideOverlap\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedGuideOverlap\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".reseedLiquidOverlap\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.reseedLiquidOverlap\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minReseedAirDistance\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.minReseedAirDistance\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".simulationCacheFilename\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.simulationCacheFilename\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".simulationCachePath\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.simulationCachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromSimulationCache\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromSimulationCache\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".computeGuideFromMesh\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.computeGuideFromMesh\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxMin\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxMin\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxMax\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxMax\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipBBoxTransform\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.bboxTransform\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCompressionQuality\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCachePath\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCacheFileName\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableLiquidCache\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableLiquidCache\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".liquidCacheControl\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableSolidCache\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCacheControl\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCacheControl\\\",\\n                    \\\"target\\\": \\\"foamComp.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCompressionQuality\\\",\\n                    \\\"target\\\": \\\"foamComp.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCachePath\\\",\\n                    \\\"target\\\": \\\"foamComp.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".foamCacheFileName\\\",\\n                    \\\"target\\\": \\\"foamComp.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableFoamCache\\\",\\n                    \\\"target\\\": \\\"foamComp.enableFoamCache\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".enableSolidCache\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.enable\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCacheFileName\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cacheFileName\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCachePath\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cachePath\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".solidCompressionQuality\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.compressionQuality\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".emissionRate\\\",\\n                    \\\"target\\\": \\\"foamComp.emissionRate\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidSpeed\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidSpeed\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidChurn\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidChurn\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidCurvature\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidCurvature\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".minLiquidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.minLiquidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxLiquidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.maxLiquidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".inheritLiquidVelocity\\\",\\n                    \\\"target\\\": \\\"foamComp.inheritLiquidVelocity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".emitFlatnessToSurface\\\",\\n                    \\\"target\\\": \\\"foamComp.emitFlatnessToSurface\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".dissipationRate\\\",\\n                    \\\"target\\\": \\\"foamComp.dissipationRate\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".killDensityThreshold\\\",\\n                    \\\"target\\\": \\\"foamComp.killDensityThreshold\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".buoyancy\\\",\\n                    \\\"target\\\": \\\"foamComp.buoyancy\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".collideKillDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.collideKillDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".windX\\\",\\n                    \\\"target\\\": \\\"foamComp.windX\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".windZ\\\",\\n                    \\\"target\\\": \\\"foamComp.windZ\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".surfaceOffset\\\",\\n                    \\\"target\\\": \\\"foamComp.surfaceOffset\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".snapToSurface\\\",\\n                    \\\"target\\\": \\\"foamComp.snapToSurface\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".pointRadius\\\",\\n                    \\\"target\\\": \\\"foamComp.pointRadius\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".preserveVolume\\\",\\n                    \\\"target\\\": \\\"foamComp.preserveVolume\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".gravityMagnitude\\\",\\n                    \\\"target\\\": \\\"foamComp.gravity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".maxSolidDepth\\\",\\n                    \\\"target\\\": \\\"foamComp.maxSolidDepth\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraAdaptivity\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraAdaptivity\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".clipToCameraFrustum\\\",\\n                    \\\"target\\\": \\\"foamComp.clipToCameraFrustum\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraFov\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraFov\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraAspect\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraAspect\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\".cameraBuffer\\\",\\n                    \\\"target\\\": \\\"foamComp.cameraBuffer\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.accelerators1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.colliders1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.emitters1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.guides1\\\",\\n                    \\\"target\\\": \\\"keepMeshes.guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.emitters1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Emitters\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.colliders1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Colliders\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.accelerators1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Accelerators\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createMeshes.guides1\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.Guides\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching.outObject\\\",\\n                    \\\"target\\\": \\\"keepMeshes.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"keepMeshes.outObject\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"voxel_liquid.value\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.name\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Liquid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Liquid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching.newObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching.outCacheControl\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"cacheObjectToDisk.outObject\\\",\\n                    \\\"target\\\": \\\"scopeLiquid.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"scopeLiquid.outObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject.value\\\",\\n                    \\\"target\\\": \\\"foamComp.liquidObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"Solids.value\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.name\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Solid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"subStepLiquid.Solid\\\",\\n                    \\\"target\\\": \\\"createObjectWhenCaching1.newObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching1.outObject\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createObjectWhenCaching1.outCacheControl\\\",\\n                    \\\"target\\\": \\\"cacheObjectToDisk1.cacheControl\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"scopeSolids.outObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject1.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"cacheObjectToDisk1.outObject\\\",\\n                    \\\"target\\\": \\\"scopeSolids.inObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject1.value\\\",\\n                    \\\"target\\\": \\\"foamComp.solidObject\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"foamComp.Foam\\\",\\n                    \\\"target\\\": \\\"if.trueCase\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"setDescriptorFromObject2.value\\\",\\n                    \\\"target\\\": \\\"if.falseCase\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"createEmptyItems.emptyObject\\\",\\n                    \\\"target\\\": \\\"setDescriptorFromObject2.object\\\"\\n                },\\n                {\\n                    \\\"source\\\": \\\"initTimestepCFL.value\\\",\\n                    \\\"target\\\": \\\"subStepLiquid.ittr_input\\\"\\n                }\\n            ],\\n            \\\"values\\\": [\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.compNameToTest\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"_voxel\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.filePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFilePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching.fileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFileNameHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cacheControl\\\",\\n                    \\\"value\\\": \\\"0L\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.compressionQuality\\\",\\n                    \\\"value\\\": \\\"0L\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cachePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putCachePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.cacheFileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"liquid\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.pointComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid-particle\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk.voxelComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid-volume\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"voxel_liquid.str\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"voxel_liquid\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.compNameToTest\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"_voxel\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.filePath\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFileNameHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"createObjectWhenCaching1.fileName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"putFilePathHere\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"Solids.str\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"Solids\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.emissionRate\\\",\\n                    \\\"value\\\": \\\"1000f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidSpeed\\\",\\n                    \\\"value\\\": \\\"0.2f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidChurn\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.minLiquidCurvature\\\",\\n                    \\\"value\\\": \\\"0.5f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.inheritLiquidVelocity\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.emitFlatnessToSurface\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.dissipationRate\\\",\\n                    \\\"value\\\": \\\"5f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.killDensityThreshold\\\",\\n                    \\\"value\\\": \\\"0.05f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.buoyancy\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.collideKillDepth\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.windX\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.windZ\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.surfaceOffset\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.snapToSurface\\\",\\n                    \\\"value\\\": \\\"false\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.pointRadius\\\",\\n                    \\\"value\\\": \\\"0.3f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.preserveVolume\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.gravity\\\",\\n                    \\\"value\\\": \\\"9.8f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.maxSolidDepth\\\",\\n                    \\\"value\\\": \\\"0.3f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraAdaptivity\\\",\\n                    \\\"value\\\": \\\"0f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.clipToCameraFrustum\\\",\\n                    \\\"value\\\": \\\"false\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraFov\\\",\\n                    \\\"value\\\": \\\"110f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraAspect\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"foamComp.cameraBuffer\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"subStepLiquid.PIC\\\",\\n                    \\\"value\\\": \\\"1f\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk1.pointComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"none\\\"\\n                },\\n                {\\n                    \\\"valueName\\\": \\\"cacheObjectToDisk1.voxelComponentName\\\",\\n                    \\\"valueType\\\": \\\"string\\\",\\n                    \\\"value\\\": \\\"Solids-volume\\\"\\n                }\\n            ]\\n        }\\n    ]\\n}\"}");
	setAttr ".srv" -type "string" "2.0";
	setAttr -k on ".pfc";
	setAttr -k on ".euc";
	setAttr -k on ".cn";
	setAttr -k on ".cd";
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
	setAttr -k on ".gravityMagnitude" 9.8000001907348633;
	setAttr -k on ".gravityDirection" -type "float3" 0 -1 0 ;
	setAttr -k on ".solidVoxelScale" 1;
	setAttr -k on ".forceVoxelScale" 1;
	setAttr -k on ".vorticityMult" 1;
	setAttr -k on ".transportStepAdaptivity" 0.31999999284744263;
	setAttr -k on ".transportTimeScale" 1;
	setAttr -k on ".minSteps" 1;
	setAttr -k on ".maxSteps" 2000;
	setAttr -k on ".dropletThreshold" 1;
	setAttr -k on ".dropletMergeBackDepth" 2;
	setAttr -k on ".surfaceBandWidth" 1;
	setAttr -k on ".interiorParticleDensity" 1;
	setAttr -k on ".surfaceParticleDensity" 4;
	setAttr -k on ".deleteExceedingParticles" yes;
createNode transform -n "bifrost1";
	rename -uid "95F858F5-4946-05F0-DA90-CC9FD3E2A774";
createNode bifrostShape -n "bifrostShape1" -p "bifrost1";
	rename -uid "B4545AA0-4329-508A-0256-80BDF31388F1";
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
	setAttr ".pcr[0].pcrcv" -type "float3" 0 0 0.40599999 ;
	setAttr ".pcr[0].pcri" 2;
	setAttr ".pcr[1].pcrp" 1;
	setAttr ".pcr[1].pcrcv" -type "float3" 1 1 1 ;
	setAttr ".pcr[1].pcri" 2;
	setAttr ".pcr[2].pcrp" 0.41739130020141602;
	setAttr ".pcr[2].pcrcv" -type "float3" 0.64700001 0.97508407 1 ;
	setAttr ".pcr[2].pcri" 2;
	setAttr ".pcr[3].pcrp" 0.095652170479297638;
	setAttr ".pcr[3].pcrcv" -type "float3" 0 0.2843833 1 ;
	setAttr ".pcr[3].pcri" 2;
	setAttr ".pcrx" 6;
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
createNode transform -n "bifrostMesh1";
	rename -uid "AE6E427B-4DC6-FA9A-10D2-808074AC7077";
	addAttr -s false -ci true -sn "miData" -ln "miData" -at "message";
createNode mesh -n "bifrostMeshShape1" -p "bifrostMesh1";
	rename -uid "024DAFAB-4820-C27D-419B-F5802EC4879B";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".mvcs" -type "string" "bifrostVelocity";
createNode transform -n "tank";
	rename -uid "EAD7BAEE-46B2-73AB-14B8-AA8249CC2C41";
	setAttr ".v" no;
createNode transform -n "liquidEmitterPipe1" -p "tank";
	rename -uid "7A34A21A-4A5B-7B17-282F-F59B91F69396";
	setAttr ".t" -type "double3" 6.6484899683103365 0 0 ;
	setAttr ".s" -type "double3" 9.1345215399064745 4.7851463845511431 9.1345215399064745 ;
createNode mesh -n "liquidEmitterPipeShape1" -p "liquidEmitterPipe1";
	rename -uid "BC283396-40FD-B905-765F-3EABDD710073";
	addAttr -ci true -sn "bifrostLiquidEnable" -ln "bifrostLiquidEnable" -dv 1 -min 
		0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostLiquidContinuousEmission" -ln "bifrostLiquidContinuousEmission" 
		-min 0 -max 1 -at "bool";
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
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
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
	setAttr -k on ".bifrostLiquidEnable";
	setAttr -k on ".bifrostLiquidContinuousEmission";
	setAttr -k on ".bifrostLiquidThickness";
	setAttr -k on ".bifrostLiquidMode";
	setAttr -k on ".bifrostLiquidDensity";
	setAttr -k on ".bifrostLiquidExpansionRate";
	setAttr -k on ".bifrostLiquidStictionStrength";
	setAttr -k on ".bifrostLiquidStictionBandwidth";
createNode transform -n "colliderPipe1" -p "tank";
	rename -uid "905BB2C6-4B59-15D2-5C01-EEB98902293C";
	setAttr ".t" -type "double3" 6.6484899683103365 1.4134702627665705 0 ;
	setAttr ".s" -type "double3" 9.1345215399064745 7.6153893456195103 9.1345215399064745 ;
createNode mesh -n "colliderPipeShape1" -p "colliderPipe1";
	rename -uid "43F3038D-4265-DFA6-7C06-1F857DB2939F";
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
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode mesh -n "polySurfaceShape1" -p "colliderPipe1";
	rename -uid "EB18E6EC-4152-26A7-D0D6-F28BAD0B54AD";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.5 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 180 ".uvst[0].uvsp[0:179]" -type "float2" 0 1 0.028571429 1
		 0.057142857 1 0.085714288 1 0.11428571 1 0.14285715 1 0.17142858 1 0.2 1 0.22857143
		 1 0.25714287 1 0.2857143 1 0.31428573 1 0.34285715 1 0.37142858 1 0.40000001 1 0.42857143
		 1 0.45714286 1 0.48571429 1 0.51428574 1 0.54285717 1 0.5714286 1 0.60000002 1 0.62857145
		 1 0.65714288 1 0.6857143 1 0.71428573 1 0.74285716 1 0.77142859 1 0.80000001 1 0.82857144
		 1 0.85714287 1 0.88571429 1 0.91428572 1 0.94285715 1 0.97142857 1 1 1 0 0.75 0.028571429
		 0.75 0.057142857 0.75 0.085714288 0.75 0.11428571 0.75 0.14285715 0.75 0.17142858
		 0.75 0.2 0.75 0.22857143 0.75 0.25714287 0.75 0.2857143 0.75 0.31428573 0.75 0.34285715
		 0.75 0.37142858 0.75 0.40000001 0.75 0.42857143 0.75 0.45714286 0.75 0.48571429 0.75
		 0.51428574 0.75 0.54285717 0.75 0.5714286 0.75 0.60000002 0.75 0.62857145 0.75 0.65714288
		 0.75 0.6857143 0.75 0.71428573 0.75 0.74285716 0.75 0.77142859 0.75 0.80000001 0.75
		 0.82857144 0.75 0.85714287 0.75 0.88571429 0.75 0.91428572 0.75 0.94285715 0.75 0.97142857
		 0.75 1 0.75 0 0.5 0.028571429 0.5 0.057142857 0.5 0.085714288 0.5 0.11428571 0.5
		 0.14285715 0.5 0.17142858 0.5 0.2 0.5 0.22857143 0.5 0.25714287 0.5 0.2857143 0.5
		 0.31428573 0.5 0.34285715 0.5 0.37142858 0.5 0.40000001 0.5 0.42857143 0.5 0.45714286
		 0.5 0.48571429 0.5 0.51428574 0.5 0.54285717 0.5 0.5714286 0.5 0.60000002 0.5 0.62857145
		 0.5 0.65714288 0.5 0.6857143 0.5 0.71428573 0.5 0.74285716 0.5 0.77142859 0.5 0.80000001
		 0.5 0.82857144 0.5 0.85714287 0.5 0.88571429 0.5 0.91428572 0.5 0.94285715 0.5 0.97142857
		 0.5 1 0.5 0 0.25 0.028571429 0.25 0.057142857 0.25 0.085714288 0.25 0.11428571 0.25
		 0.14285715 0.25 0.17142858 0.25 0.2 0.25 0.22857143 0.25 0.25714287 0.25 0.2857143
		 0.25 0.31428573 0.25 0.34285715 0.25 0.37142858 0.25 0.40000001 0.25 0.42857143 0.25
		 0.45714286 0.25 0.48571429 0.25 0.51428574 0.25 0.54285717 0.25 0.5714286 0.25 0.60000002
		 0.25 0.62857145 0.25 0.65714288 0.25 0.6857143 0.25 0.71428573 0.25 0.74285716 0.25
		 0.77142859 0.25 0.80000001 0.25 0.82857144 0.25 0.85714287 0.25 0.88571429 0.25 0.91428572
		 0.25 0.94285715 0.25 0.97142857 0.25 1 0.25 0 0 0.028571429 0 0.057142857 0 0.085714288
		 0 0.11428571 0 0.14285715 0 0.17142858 0 0.2 0 0.22857143 0 0.25714287 0 0.2857143
		 0 0.31428573 0 0.34285715 0 0.37142858 0 0.40000001 0 0.42857143 0 0.45714286 0 0.48571429
		 0 0.51428574 0 0.54285717 0 0.5714286 0 0.60000002 0 0.62857145 0 0.65714288 0 0.6857143
		 0 0.71428573 0 0.74285716 0 0.77142859 0 0.80000001 0 0.82857144 0 0.85714287 0 0.88571429
		 0 0.91428572 0 0.94285715 0 0.97142857 0 1 0;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 140 ".vt[0:139]"  0.5 -0.5 -1.110223e-016 0.49196479 -0.5 -0.089278445
		 0.46811742 -0.5 -0.1756874 0.42922437 -0.5 -0.25644964 0.37653571 -0.5 -0.32896936
		 0.31174487 -0.5 -0.39091575 0.2369343 -0.5 -0.44029775 0.15450847 -0.5 -0.47552821
		 0.067116626 -0.5 -0.49547482 -0.022432409 -0.5 -0.49949646 -0.11126044 -0.5 -0.48746389
		 -0.19651248 -0.5 -0.45976382 -0.27544844 -0.5 -0.41728657 -0.34553126 -0.5 -0.36139739
		 -0.40450841 -0.5 -0.29389259 -0.45048434 -0.5 -0.21694185 -0.48198134 -0.5 -0.13301842
		 -0.49798703 -0.5 -0.044819668 -0.497987 -0.5 0.044819616 -0.48198128 -0.5 0.13301834
		 -0.45048428 -0.5 0.21694176 -0.40450838 -0.5 0.29389247 -0.34553123 -0.5 0.36139727
		 -0.27544844 -0.5 0.41728643 -0.19651251 -0.5 0.45976368 -0.1112605 -0.5 0.48746374
		 -0.022432491 -0.5 0.49949631 0.067116514 -0.5 0.49547467 0.15450834 -0.5 0.47552806
		 0.23693414 -0.5 0.4402976 0.31174469 -0.5 0.39091563 0.37653551 -0.5 0.3289693 0.42922413 -0.5 0.25644964
		 0.46811718 -0.5 0.17568746 0.49196452 -0.5 0.089278549 0.5 0.5 1.110223e-016 0.49196479 0.5 -0.089278445
		 0.46811742 0.5 -0.1756874 0.42922437 0.5 -0.25644964 0.37653571 0.5 -0.32896936 0.31174487 0.5 -0.39091575
		 0.2369343 0.5 -0.44029775 0.15450847 0.5 -0.47552821 0.067116626 0.5 -0.49547482
		 -0.022432409 0.5 -0.49949646 -0.11126044 0.5 -0.48746389 -0.19651248 0.5 -0.45976382
		 -0.27544844 0.5 -0.41728657 -0.34553126 0.5 -0.36139739 -0.40450841 0.5 -0.29389259
		 -0.45048434 0.5 -0.21694185 -0.48198134 0.5 -0.13301842 -0.49798703 0.5 -0.044819668
		 -0.497987 0.5 0.044819616 -0.48198128 0.5 0.13301834 -0.45048428 0.5 0.21694176 -0.40450838 0.5 0.29389247
		 -0.34553123 0.5 0.36139727 -0.27544844 0.5 0.41728643 -0.19651251 0.5 0.45976368
		 -0.1112605 0.5 0.48746374 -0.022432491 0.5 0.49949631 0.067116514 0.5 0.49547467
		 0.15450834 0.5 0.47552806 0.23693414 0.5 0.4402976 0.31174469 0.5 0.39091563 0.37653551 0.5 0.3289693
		 0.42922413 0.5 0.25644964 0.46811718 0.5 0.17568746 0.49196452 0.5 0.089278549 1 0.5 1.110223e-016
		 0.98392957 0.5 -0.17855689 0.93623483 0.5 -0.3513748 0.85844874 0.5 -0.51289928 0.75307143 0.5 -0.65793872
		 0.62348974 0.5 -0.7818315 0.47386861 0.5 -0.88059551 0.30901694 0.5 -0.95105642 0.13423325 0.5 -0.99094963
		 -0.044864818 0.5 -0.99899292 -0.22252089 0.5 -0.97492778 -0.39302495 0.5 -0.91952765
		 -0.55089688 0.5 -0.83457315 -0.69106251 0.5 -0.72279477 -0.80901682 0.5 -0.58778518
		 -0.90096867 0.5 -0.4338837 -0.96396267 0.5 -0.26603684 -0.99597406 0.5 -0.089639336
		 -0.995974 0.5 0.089639232 -0.96396255 0.5 0.26603669 -0.90096855 0.5 0.43388352 -0.80901676 0.5 0.58778495
		 -0.69106245 0.5 0.72279453 -0.55089688 0.5 0.83457285 -0.39302501 0.5 0.91952735
		 -0.22252101 0.5 0.97492748 -0.044864982 0.5 0.99899262 0.13423303 0.5 0.99094933
		 0.30901667 0.5 0.95105612 0.47386828 0.5 0.88059521 0.62348938 0.5 0.78183126 0.75307101 0.5 0.6579386
		 0.85844827 0.5 0.51289928 0.93623435 0.5 0.35137492 0.98392904 0.5 0.1785571 1 -0.5 -1.110223e-016
		 0.98392957 -0.5 -0.17855689 0.93623483 -0.5 -0.3513748 0.85844874 -0.5 -0.51289928
		 0.75307143 -0.5 -0.65793872 0.62348974 -0.5 -0.7818315 0.47386861 -0.5 -0.88059551
		 0.30901694 -0.5 -0.95105642 0.13423325 -0.5 -0.99094963 -0.044864818 -0.5 -0.99899292
		 -0.22252089 -0.5 -0.97492778 -0.39302495 -0.5 -0.91952765 -0.55089688 -0.5 -0.83457315
		 -0.69106251 -0.5 -0.72279477 -0.80901682 -0.5 -0.58778518 -0.90096867 -0.5 -0.4338837
		 -0.96396267 -0.5 -0.26603684 -0.99597406 -0.5 -0.089639336 -0.995974 -0.5 0.089639232
		 -0.96396255 -0.5 0.26603669 -0.90096855 -0.5 0.43388352 -0.80901676 -0.5 0.58778495
		 -0.69106245 -0.5 0.72279453 -0.55089688 -0.5 0.83457285 -0.39302501 -0.5 0.91952735
		 -0.22252101 -0.5 0.97492748 -0.044864982 -0.5 0.99899262 0.13423303 -0.5 0.99094933
		 0.30901667 -0.5 0.95105612 0.47386828 -0.5 0.88059521 0.62348938 -0.5 0.78183126
		 0.75307101 -0.5 0.6579386 0.85844827 -0.5 0.51289928 0.93623435 -0.5 0.35137492 0.98392904 -0.5 0.1785571;
	setAttr -s 280 ".ed";
	setAttr ".ed[0:165]"  0 1 0 1 2 0 2 3 0 3 4 0 4 5 0 5 6 0 6 7 0 7 8 0 8 9 0
		 9 10 0 10 11 0 11 12 0 12 13 0 13 14 0 14 15 0 15 16 0 16 17 0 17 18 0 18 19 0 19 20 0
		 20 21 0 21 22 0 22 23 0 23 24 0 24 25 0 25 26 0 26 27 0 27 28 0 28 29 0 29 30 0 30 31 0
		 31 32 0 32 33 0 33 34 0 34 0 0 35 36 0 36 37 0 37 38 0 38 39 0 39 40 0 40 41 0 41 42 0
		 42 43 0 43 44 0 44 45 0 45 46 0 46 47 0 47 48 0 48 49 0 49 50 0 50 51 0 51 52 0 52 53 0
		 53 54 0 54 55 0 55 56 0 56 57 0 57 58 0 58 59 0 59 60 0 60 61 0 61 62 0 62 63 0 63 64 0
		 64 65 0 65 66 0 66 67 0 67 68 0 68 69 0 69 35 0 70 71 0 71 72 0 72 73 0 73 74 0 74 75 0
		 75 76 0 76 77 0 77 78 0 78 79 0 79 80 0 80 81 0 81 82 0 82 83 0 83 84 0 84 85 0 85 86 0
		 86 87 0 87 88 0 88 89 0 89 90 0 90 91 0 91 92 0 92 93 0 93 94 0 94 95 0 95 96 0 96 97 0
		 97 98 0 98 99 0 99 100 0 100 101 0 101 102 0 102 103 0 103 104 0 104 70 0 105 106 0
		 106 107 0 107 108 0 108 109 0 109 110 0 110 111 0 111 112 0 112 113 0 113 114 0 114 115 0
		 115 116 0 116 117 0 117 118 0 118 119 0 119 120 0 120 121 0 121 122 0 122 123 0 123 124 0
		 124 125 0 125 126 0 126 127 0 127 128 0 128 129 0 129 130 0 130 131 0 131 132 0 132 133 0
		 133 134 0 134 135 0 135 136 0 136 137 0 137 138 0 138 139 0 139 105 0 0 35 1 1 36 1
		 2 37 1 3 38 1 4 39 1 5 40 1 6 41 1 7 42 1 8 43 1 9 44 1 10 45 1 11 46 1 12 47 1 13 48 1
		 14 49 1 15 50 1 16 51 1 17 52 1 18 53 1 19 54 1 20 55 1 21 56 1 22 57 1 23 58 1 24 59 1
		 25 60 1;
	setAttr ".ed[166:279]" 26 61 1 27 62 1 28 63 1 29 64 1 30 65 1 31 66 1 32 67 1
		 33 68 1 34 69 1 35 70 1 36 71 1 37 72 1 38 73 1 39 74 1 40 75 1 41 76 1 42 77 1 43 78 1
		 44 79 1 45 80 1 46 81 1 47 82 1 48 83 1 49 84 1 50 85 1 51 86 1 52 87 1 53 88 1 54 89 1
		 55 90 1 56 91 1 57 92 1 58 93 1 59 94 1 60 95 1 61 96 1 62 97 1 63 98 1 64 99 1 65 100 1
		 66 101 1 67 102 1 68 103 1 69 104 1 70 105 1 71 106 1 72 107 1 73 108 1 74 109 1
		 75 110 1 76 111 1 77 112 1 78 113 1 79 114 1 80 115 1 81 116 1 82 117 1 83 118 1
		 84 119 1 85 120 1 86 121 1 87 122 1 88 123 1 89 124 1 90 125 1 91 126 1 92 127 1
		 93 128 1 94 129 1 95 130 1 96 131 1 97 132 1 98 133 1 99 134 1 100 135 1 101 136 1
		 102 137 1 103 138 1 104 139 1 105 0 1 106 1 1 107 2 1 108 3 1 109 4 1 110 5 1 111 6 1
		 112 7 1 113 8 1 114 9 1 115 10 1 116 11 1 117 12 1 118 13 1 119 14 1 120 15 1 121 16 1
		 122 17 1 123 18 1 124 19 1 125 20 1 126 21 1 127 22 1 128 23 1 129 24 1 130 25 1
		 131 26 1 132 27 1 133 28 1 134 29 1 135 30 1 136 31 1 137 32 1 138 33 1 139 34 1;
	setAttr -s 140 -ch 560 ".fc[0:139]" -type "polyFaces" 
		f 4 -1 140 35 -142
		mu 0 4 1 0 36 37
		f 4 -2 141 36 -143
		mu 0 4 2 1 37 38
		f 4 -3 142 37 -144
		mu 0 4 3 2 38 39
		f 4 -4 143 38 -145
		mu 0 4 4 3 39 40
		f 4 -5 144 39 -146
		mu 0 4 5 4 40 41
		f 4 -6 145 40 -147
		mu 0 4 6 5 41 42
		f 4 -7 146 41 -148
		mu 0 4 7 6 42 43
		f 4 -8 147 42 -149
		mu 0 4 8 7 43 44
		f 4 -9 148 43 -150
		mu 0 4 9 8 44 45
		f 4 -10 149 44 -151
		mu 0 4 10 9 45 46
		f 4 -11 150 45 -152
		mu 0 4 11 10 46 47
		f 4 -12 151 46 -153
		mu 0 4 12 11 47 48
		f 4 -13 152 47 -154
		mu 0 4 13 12 48 49
		f 4 -14 153 48 -155
		mu 0 4 14 13 49 50
		f 4 -15 154 49 -156
		mu 0 4 15 14 50 51
		f 4 -16 155 50 -157
		mu 0 4 16 15 51 52
		f 4 -17 156 51 -158
		mu 0 4 17 16 52 53
		f 4 -18 157 52 -159
		mu 0 4 18 17 53 54
		f 4 -19 158 53 -160
		mu 0 4 19 18 54 55
		f 4 -20 159 54 -161
		mu 0 4 20 19 55 56
		f 4 -21 160 55 -162
		mu 0 4 21 20 56 57
		f 4 -22 161 56 -163
		mu 0 4 22 21 57 58
		f 4 -23 162 57 -164
		mu 0 4 23 22 58 59
		f 4 -24 163 58 -165
		mu 0 4 24 23 59 60
		f 4 -25 164 59 -166
		mu 0 4 25 24 60 61
		f 4 -26 165 60 -167
		mu 0 4 26 25 61 62
		f 4 -27 166 61 -168
		mu 0 4 27 26 62 63
		f 4 -28 167 62 -169
		mu 0 4 28 27 63 64
		f 4 -29 168 63 -170
		mu 0 4 29 28 64 65
		f 4 -30 169 64 -171
		mu 0 4 30 29 65 66
		f 4 -31 170 65 -172
		mu 0 4 31 30 66 67
		f 4 -32 171 66 -173
		mu 0 4 32 31 67 68
		f 4 -33 172 67 -174
		mu 0 4 33 32 68 69
		f 4 -34 173 68 -175
		mu 0 4 34 33 69 70
		f 4 -35 174 69 -141
		mu 0 4 35 34 70 71
		f 4 -36 175 70 -177
		mu 0 4 37 36 72 73
		f 4 -37 176 71 -178
		mu 0 4 38 37 73 74
		f 4 -38 177 72 -179
		mu 0 4 39 38 74 75
		f 4 -39 178 73 -180
		mu 0 4 40 39 75 76
		f 4 -40 179 74 -181
		mu 0 4 41 40 76 77
		f 4 -41 180 75 -182
		mu 0 4 42 41 77 78
		f 4 -42 181 76 -183
		mu 0 4 43 42 78 79
		f 4 -43 182 77 -184
		mu 0 4 44 43 79 80
		f 4 -44 183 78 -185
		mu 0 4 45 44 80 81
		f 4 -45 184 79 -186
		mu 0 4 46 45 81 82
		f 4 -46 185 80 -187
		mu 0 4 47 46 82 83
		f 4 -47 186 81 -188
		mu 0 4 48 47 83 84
		f 4 -48 187 82 -189
		mu 0 4 49 48 84 85
		f 4 -49 188 83 -190
		mu 0 4 50 49 85 86
		f 4 -50 189 84 -191
		mu 0 4 51 50 86 87
		f 4 -51 190 85 -192
		mu 0 4 52 51 87 88
		f 4 -52 191 86 -193
		mu 0 4 53 52 88 89
		f 4 -53 192 87 -194
		mu 0 4 54 53 89 90
		f 4 -54 193 88 -195
		mu 0 4 55 54 90 91
		f 4 -55 194 89 -196
		mu 0 4 56 55 91 92
		f 4 -56 195 90 -197
		mu 0 4 57 56 92 93
		f 4 -57 196 91 -198
		mu 0 4 58 57 93 94
		f 4 -58 197 92 -199
		mu 0 4 59 58 94 95
		f 4 -59 198 93 -200
		mu 0 4 60 59 95 96
		f 4 -60 199 94 -201
		mu 0 4 61 60 96 97
		f 4 -61 200 95 -202
		mu 0 4 62 61 97 98
		f 4 -62 201 96 -203
		mu 0 4 63 62 98 99
		f 4 -63 202 97 -204
		mu 0 4 64 63 99 100
		f 4 -64 203 98 -205
		mu 0 4 65 64 100 101
		f 4 -65 204 99 -206
		mu 0 4 66 65 101 102
		f 4 -66 205 100 -207
		mu 0 4 67 66 102 103
		f 4 -67 206 101 -208
		mu 0 4 68 67 103 104
		f 4 -68 207 102 -209
		mu 0 4 69 68 104 105
		f 4 -69 208 103 -210
		mu 0 4 70 69 105 106
		f 4 -70 209 104 -176
		mu 0 4 71 70 106 107
		f 4 -71 210 105 -212
		mu 0 4 73 72 108 109
		f 4 -72 211 106 -213
		mu 0 4 74 73 109 110
		f 4 -73 212 107 -214
		mu 0 4 75 74 110 111
		f 4 -74 213 108 -215
		mu 0 4 76 75 111 112
		f 4 -75 214 109 -216
		mu 0 4 77 76 112 113
		f 4 -76 215 110 -217
		mu 0 4 78 77 113 114
		f 4 -77 216 111 -218
		mu 0 4 79 78 114 115
		f 4 -78 217 112 -219
		mu 0 4 80 79 115 116
		f 4 -79 218 113 -220
		mu 0 4 81 80 116 117
		f 4 -80 219 114 -221
		mu 0 4 82 81 117 118
		f 4 -81 220 115 -222
		mu 0 4 83 82 118 119
		f 4 -82 221 116 -223
		mu 0 4 84 83 119 120
		f 4 -83 222 117 -224
		mu 0 4 85 84 120 121
		f 4 -84 223 118 -225
		mu 0 4 86 85 121 122
		f 4 -85 224 119 -226
		mu 0 4 87 86 122 123
		f 4 -86 225 120 -227
		mu 0 4 88 87 123 124
		f 4 -87 226 121 -228
		mu 0 4 89 88 124 125
		f 4 -88 227 122 -229
		mu 0 4 90 89 125 126
		f 4 -89 228 123 -230
		mu 0 4 91 90 126 127
		f 4 -90 229 124 -231
		mu 0 4 92 91 127 128
		f 4 -91 230 125 -232
		mu 0 4 93 92 128 129
		f 4 -92 231 126 -233
		mu 0 4 94 93 129 130
		f 4 -93 232 127 -234
		mu 0 4 95 94 130 131
		f 4 -94 233 128 -235
		mu 0 4 96 95 131 132
		f 4 -95 234 129 -236
		mu 0 4 97 96 132 133
		f 4 -96 235 130 -237
		mu 0 4 98 97 133 134
		f 4 -97 236 131 -238
		mu 0 4 99 98 134 135
		f 4 -98 237 132 -239
		mu 0 4 100 99 135 136
		f 4 -99 238 133 -240
		mu 0 4 101 100 136 137
		f 4 -100 239 134 -241
		mu 0 4 102 101 137 138
		f 4 -101 240 135 -242
		mu 0 4 103 102 138 139
		f 4 -102 241 136 -243
		mu 0 4 104 103 139 140
		f 4 -103 242 137 -244
		mu 0 4 105 104 140 141
		f 4 -104 243 138 -245
		mu 0 4 106 105 141 142
		f 4 -105 244 139 -211
		mu 0 4 107 106 142 143
		f 4 -106 245 0 -247
		mu 0 4 109 108 144 145
		f 4 -107 246 1 -248
		mu 0 4 110 109 145 146
		f 4 -108 247 2 -249
		mu 0 4 111 110 146 147
		f 4 -109 248 3 -250
		mu 0 4 112 111 147 148
		f 4 -110 249 4 -251
		mu 0 4 113 112 148 149
		f 4 -111 250 5 -252
		mu 0 4 114 113 149 150
		f 4 -112 251 6 -253
		mu 0 4 115 114 150 151
		f 4 -113 252 7 -254
		mu 0 4 116 115 151 152
		f 4 -114 253 8 -255
		mu 0 4 117 116 152 153
		f 4 -115 254 9 -256
		mu 0 4 118 117 153 154
		f 4 -116 255 10 -257
		mu 0 4 119 118 154 155
		f 4 -117 256 11 -258
		mu 0 4 120 119 155 156
		f 4 -118 257 12 -259
		mu 0 4 121 120 156 157
		f 4 -119 258 13 -260
		mu 0 4 122 121 157 158
		f 4 -120 259 14 -261
		mu 0 4 123 122 158 159
		f 4 -121 260 15 -262
		mu 0 4 124 123 159 160
		f 4 -122 261 16 -263
		mu 0 4 125 124 160 161
		f 4 -123 262 17 -264
		mu 0 4 126 125 161 162
		f 4 -124 263 18 -265
		mu 0 4 127 126 162 163
		f 4 -125 264 19 -266
		mu 0 4 128 127 163 164
		f 4 -126 265 20 -267
		mu 0 4 129 128 164 165
		f 4 -127 266 21 -268
		mu 0 4 130 129 165 166
		f 4 -128 267 22 -269
		mu 0 4 131 130 166 167
		f 4 -129 268 23 -270
		mu 0 4 132 131 167 168
		f 4 -130 269 24 -271
		mu 0 4 133 132 168 169
		f 4 -131 270 25 -272
		mu 0 4 134 133 169 170
		f 4 -132 271 26 -273
		mu 0 4 135 134 170 171
		f 4 -133 272 27 -274
		mu 0 4 136 135 171 172
		f 4 -134 273 28 -275
		mu 0 4 137 136 172 173
		f 4 -135 274 29 -276
		mu 0 4 138 137 173 174
		f 4 -136 275 30 -277
		mu 0 4 139 138 174 175
		f 4 -137 276 31 -278
		mu 0 4 140 139 175 176
		f 4 -138 277 32 -279
		mu 0 4 141 140 176 177
		f 4 -139 278 33 -280
		mu 0 4 142 141 177 178
		f 4 -140 279 34 -246
		mu 0 4 143 142 178 179;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -n "motor";
	rename -uid "11F5DEF1-4A58-5058-FBBE-16B7C0894015";
	setAttr ".rp" -type "double3" 0 2.2163823583419746 0.83290021624618515 ;
	setAttr ".sp" -type "double3" 0 2.2163823583419746 0.83290021624618515 ;
createNode transform -n "nurbsToPoly5" -p "motor";
	rename -uid "02E187A9-4EE7-AA78-6300-4AB5403A7CE5";
	setAttr ".t" -type "double3" 0 0 -1.7370659067081089 ;
	setAttr ".s" -type "double3" 0.33725416221104415 0.33725416221104415 0.33725416221104415 ;
	setAttr ".rp" -type "double3" -3.7747582837255322e-015 -3.219646771412954e-015 -2.6645352591003757e-015 ;
	setAttr ".sp" -type "double3" -3.5527136788005009e-015 0 0 ;
createNode mesh -n "nurbsToPoly5Shape" -p "nurbsToPoly5";
	rename -uid "1DCFBB2E-44A1-EB0D-C20F-E08D3DE3BD41";
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
	setAttr -s 2 ".ciog";
	setAttr ".pv" -type "double2" 0 0.094749182462692261 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 520 ".uvst[0].uvsp";
	setAttr ".uvst[0].uvsp[0:249]" -type "float2" 1 0.83424538 1 1 0.72823781
		 0.83424532 1 0.64928812 1 0.83424538 1 1 0.72823787 1 1 0.64928812 0.72823787 0.64928812
		 0.72823781 0.83424532 0.72823787 1 0.4548842 1 1 0.4608151 1 0.4608151 0.4548842
		 0.83424538 0.4548842 1 1 0.24562939 1 0.24562939 0.72823787 0.64928812 0.72823787
		 0.4608151 0.4548842 0.64928812 0.2171921 1 0.2171921 1 1 0.094749182 1 0.094749182
		 0.72823787 0.4608151 0.4548842 0.83424538 0.2171921 0.83424538 0 1 0 1 1 0.011538818
		 1 0.011538818 0.72823787 0.24562939 0.72823787 0.24562939 0.4548842 0.64928812 0.4548842
		 0.4608151 0.2171921 0.64928812 0.2171921 0.83424538 0 0.83424538 0 0.83424538 0.97482848
		 0.0087760063 0.72823787 0.094749182 0.72823787 0.094749182 0.97482848 0.0087760063
		 0.4548842 0.4608151 0 0.64928812 0 0.64928812 0.72823787 0.0082081323 0.72823787
		 0.0082081323 0.4548842 0.24562939 0.4548842 0.24562939 0.2171921 0.64928812 0.2171921
		 0.4608151 0 0.4608151 0 0.4608151 0.70401263 0.0083968937 0.4548842 0.094749182 0.7085852
		 0.009068789 0.4548842 0.094749182 0.70401263 0.0083968937 0.7085852 0.009068789 0.2171921
		 0.4608151 0 0.24562939 0 0.24562939 0.4548842 0.0035510119 0.4548842 0.0035510119
		 0.2171921 0.24562939 0.2171921 0.24562939 0 0.094749182 0 0.094749182 0.44568348
		 0.0036676188 0.2171921 0.094749182 0.2171921 0.094749182 0.44568348 0.0036676188
		 0 0 0 0 -1.5760097e-017 0.0046529025 0.2171921 0.011338186 0.21719211 0.008804203
		 0.28392464 0.0074463775 0.40882382 0.0049050152 0.19267225 0.010696682 0.21368855
		 0.012161213 0.0037599467 8.3844862e-019 0.042131554 0.011921116 0.12788983 0.0095258951
		 0.19997096 0.0075126537 0.13956378 0.01335248 0.067947604 0.015352735 0.037204385
		 0.01621139 0.2151158 0.0092590051 1 0.83424538 1 1 0.72823781 0.83424532 1 0.64928812
		 1 0.83424538 1 1 0.72823787 1 1 0.64928812 0.72823787 0.64928812 0.72823781 0.83424532
		 0.72823787 1 0.4548842 1 1 0.4608151 1 0.4608151 0.4548842 0.83424538 0.4548842 1
		 1 0.24562939 1 0.24562939 0.72823787 0.64928812 0.72823787 0.4608151 0.4548842 0.64928812
		 0.2171921 1 0.2171921 1 1 0.094749182 1 0.094749182 0.72823787 0.4608151 0.4548842
		 0.83424538 0.2171921 0.83424538 0 1 0 1 1 0.0076989722 1 0.0076989722 0.72823787
		 0.24562939 0.72823787 0.24562939 0.4548842 0.64928812 0.4548842 0.4608151 0.2171921
		 0.64928812 0.2171921 0.83424538 0 0.83424538 0 0.83424538 0.97888213 0.0073626833
		 0.72823787 0.094749182 0.72823787 0.094749182 0.97888213 0.0073626833 0.4548842 0.4608151
		 0 0.64928812 0 0.64928812 0.72823793 0.0039363317 0.82158262 0.014757193 0.72823793
		 0.0039363317 0.82158262 0.014757193 0.4548842 0.24562939 0.4548842 0.24562939 0.2171921
		 0.64928812 0.2171921 0.4608151 0 0.4608151 0 0.4608151 0.71883148 0.0032604334 0.4548842
		 0.094749182 0.4548842 0.094749182 0.71883148 0.0032604334 0.2171921 0.4608151 0 0.24562939
		 0 0.24562939 0.4548842 0.0056409701 0.4548842 0.0056409701 0.2171921 0.24562939 0.2171921
		 0.24562939 0 0.094749182 0 0.094749182 0.43815827 0.0066673169 0.2171921 0.094749182
		 0.2171921 0.094749182 0.43815827 0.0066673169 0 0 0 0 -1.095519e-017 0.0034752039
		 0.21719211 0.0061004264 0.36181125 0.011874367 0.2171921 0.0029313422 0.36196363
		 0.011644364 0.36853135 0.011266545 0.38253456 0.010460988 0.20165442 0.0067782504
		 0.0089444453 7.9757433e-018 0.054458823 0.0076912176 0.097767264 0.015009643 0.17007895
		 0.0072969724 0.21029881 0.0030071726 0.13613547 0.014896687 0.10540754 0.018174091
		 0.094112903 0.019378765 0.0057986118 0.0044550784 1 0.83424538 1 1 0.72823781 0.83424532
		 1 0.64928812 1 0.83424538 1 1 0.72823787 1 1 0.64928812 0.72823787 0.64928812 0.72823781
		 0.83424532 0.72823787 1 0.4548842 1 1 0.4608151 1 0.4608151 0.4548842 0.83424538
		 0.4548842 1 1 0.24562939 1 0.24562939 0.72823787 0.64928812 0.72823787 0.4608151
		 0.4548842 0.64928812 0.2171921 1 0.2171921 1 1 0.094749182 1 0.094749182 0.72823787
		 0.4608151 0.4548842 0.83424538 0.2171921 0.83424538 0 1 0 1 1 0.0096071493 1 0.0096071493
		 0.72823787 0.24562939 0.72823787 0.24562939 0.4548842 0.64928812 0.4548842 0.4608151
		 0.2171921 0.64928812 0.2171921 0.83424538 0 0.83424538 0 0.83424538 0.96632302 0.011741388
		 0.72823787 0.094749182 0.72823787 0.094749182 0.96632302 0.011741388 0.4548842 0.4608151
		 0 0.64928812 0 0.64928812 0.72823787 0.0025710831 0.93967974 0.014281612 0.72823787
		 0.0025710831 0.93967974 0.014281612 0.4548842 0.24562939 0.4548842 0.24562939 0.2171921
		 0.64928812 0.2171921 0.4608151 0 0.4608151 0 0.4608151 0.72103298 0.0024973385 0.4548842
		 0.094749182 0.4548842 0.094749182 0.72103298 0.0024973385 0.2171921 0.4608151 0 0.24562939
		 0 0.24562939 0.4548842 0.006599295 0.51901102 0.0098515414;
	setAttr ".uvst[0].uvsp[250:499]" 0.4548842 0.006599295 0.51901102 0.0098515414
		 0.2171921 0.24562939 0.2171921 0.24562939 0 0.094749182 0 0.094749182 0.43986583
		 0.0059866421 0.2171921 0.094749182 0.2171921 0.094749182 0.43986583 0.0059866421
		 -1.9219631e-019 0.0034509653 7.6878523e-019 0.0079203993 0.2171921 0.0055851745 0.2171921
		 0.002546855 0.4040117 0.0059219995 0.19815607 0.0083043901 0.20915031 0.0035081983
		 0.15647894 0.013018662 0.15452155 0.016766056 0.13350138 0.016083164 0.21307878 0.0030385756
		 0.5276705 0.1417274 0.51775205 0.13053176 0.55534101 0.12720482 0.5625 0.15625 0.5
		 0.14999999 0.53550404 0.10481352 0.59375 0.15625 0.53125 0.15625 0.50376678 0.12522784
		 0.58301157 0.11268222 0.58301157 0.19981779 0.55534101 0.18529521 0.4889186 0.12703073
		 0.5276705 0.1707726 0.55325609 0.079095274 0.50753355 0.094205692 0.61068201 0.2143404
		 0.625 0.15625 0.47660905 0.13552742 0.47783718 0.097811475 0.51775205 0.18196824
		 0.61068201 0.098159641 0.51130033 0.063183539 0.57100815 0.259123 0.55325603 0.23340473
		 0.53550404 0.2076865 0.46965808 0.14877138 0.46675584 0.068592213 0.50376678 0.18727216
		 0.57100815 0.053377032 0.58876014 0.28484124 0.63835251 0.228863 0.65625 0.15625
		 0.46965808 0.16372861 0.45321807 0.11480481 0.5150671 0.032161385 0.50753355 0.21829431
		 0.4889186 0.18546925 0.63835251 0.083637036 0.51883382 0.31136078 0.51130033 0.24931645
		 0.5150671 0.28033862 0.47660905 0.17697258 0.43931612 0.17120722 0.43931615 0.14129275
		 0.42982712 0.094082236 0.45567441 0.039372951 0.47783718 0.21468852 0.58876014 0.02765879
		 0.54807705 0.3125 0.56730783 0.3125 0.56730783 0.60527217 0.55884457 0.57993257 0.55718935
		 0.57612807 0.55718935 0.60353905 0.55884457 0.60734355 0.56730783 0.63268316 0.56730783
		 0.68843985 0.54807705 0.68843985 0.58653861 0.3125 0.58653861 0.66230577 0.58333027
		 0.65760159 0.58239561 0.65585613 0.57377088 0.63271505 0.57316971 0.63089281 0.45567438
		 0.27312705 0.6057694 0.3125 0.6057694 0.68843985 0.60148025 0.68843985 0.59489876
		 0.68065417 0.59307182 0.67794794 0.62500018 0.3125 0.62500018 0.68843985 0.4089742
		 0.17868583 0.40897423 0.13381414 0.51883394 0.0011392236 0.46675578 0.24390778 0.45321807
		 0.19769517 0.375 0.3125 0.39423078 0.3125 0.39423078 0.58271539 0.39279288 0.57931954
		 0.39032575 0.57492965 0.39032578 0.6023407 0.39279291 0.60673052 0.39423078 0.61012638
		 0.39423078 0.68843985 0.375 0.68843985 0.52884626 0.3125 0.52884626 0.68843985 0.58566773
		 0.68843985 0.57316965 0.6583038 0.57377088 0.66012597 0.58239567 0.68326718 0.58333027
		 0.68501252 0.51883394 0.68863922 0.58876014 0.71515876 0.5150671 0.7196613 0.44459298
		 0.30234629 0.65225816 0.82755464 0.65625 0.84375 0.65337777 0.84008849 0.63835251
		 0.916363 0.63284302 0.88640177 0.65355623 0.84375 0.42982712 0.21841775 0.37863228
		 0.18616444 0.37863228 0.12633552 0.40643615 0.073359646 0.44459301 0.010153681 0.41346157
		 0.3125 0.41346154 0.64760745 0.4069013 0.63292968 0.40647659 0.63184285 0.4134616
		 0.67501843 0.41346157 0.68843985 0.40647659 0.65925384 0.40690133 0.66034061 0.58876014
		 0.97234124 0.61068201 0.90184039 0.50961548 0.3125 0.51785171 0.68843985 0.51229668
		 0.68070054 0.50961548 0.67601502 0.44459304 0.69765359 0.45567441 0.72687292 0.4525699
		 0.718687 0.47375503 0.72144103 0.47457033 0.71889436 0.46950638 0.70768046 0.44745263
		 0.70519382 0.63732874 0.77067709 0.57100815 0.74087703 0.63610673 0.76860207 0.3830452
		 0.2598629 0.40643618 0.23914032 0.625 0.84375 0.62884617 0.86466599 0.61950999 0.88121587
		 0.62191212 0.88569343 0.63165361 0.88851029 0.34829035 0.11885688 0.38304523 0.052637056
		 0.43269235 0.3125 0.43269235 0.68474555 0.4283686 0.68067223 0.42624199 0.67816973
		 0.41668421 0.65773916 0.41576263 0.65533054 0.41822317 0.68843985 0.4157626 0.68274152
		 0.41668421 0.68515021 0.51883382 0.99886078 0.57100815 0.94662291 0.4903847 0.3125
		 0.50923324 0.67569327 0.49965531 0.65820813 0.49912408 0.65700233 0.49071318 0.63127047
		 0.49038473 0.63014573 0.40940517 0.72194207 0.43770385 0.70906544 0.46675584 0.75609213
		 0.40643615 0.76085967 0.42537564 0.72948694 0.63773453 0.77146137 0.61068201 0.78565973
		 0.55325609 0.7665953 0.51130033 0.75068355 0.59375 0.84375 0.63900369 0.84375 0.34829032
		 0.19364305 0.45192313 0.3125 0.45192313 0.68843985 0.43504933 0.68843985 0.50045156
		 0.99662876 0.46839184 0.98349053 0.46658304 0.98297918 0.5150671 0.9678387 0.58301157
		 0.88731772 0.47115391 0.3125 0.48928326 0.62792009 0.47570562 0.57973468 0.47352356
		 0.57371646 0.47352356 0.60112745 0.47570565 0.60714567 0.48928326 0.65533108 0.49038467
		 0.65755665 0.4903847 0.68843985 0.47115391 0.68843985 0.42982712 0.78158224 0.38916624
		 0.74555981 0.39689326 0.74244714 0.63786101 0.82030761 0.63622385 0.80050808 0.63639563
		 0.80390215 0.50753355 0.78170568 0.58301157 0.80018228 0.43704951 0.98463941 0.3830452
		 0.9473629 0.40643618 0.92664033 0.45567438 0.96062702 0.44909161 0.97798443 0.40539885
		 0.93021488 0.39647084 0.94160533 0.46523193 0.98253661 0.55325603 0.9209047 0.50120038
		 0.68843985 0.49071315 0.65868145 0.49912408 0.68441331 0.49965531 0.68561918 0.34829032
		 0.88114303 0.34829035 0.80635691 0.37863228 0.8736645 0.45321807 0.8023048 0.47783718
		 0.78531146 0.37863228 0.8138355 0.4089742 0.82131416 0.38230225 0.75254542 0.38874024
		 0.7461521 0.53550404 0.79231352 0.55534101 0.81470484 0.5625 0.84375 0.46675578 0.93140781
		 0.51130033 0.93681645 0.55534101 0.87279516 0.36783707 0.76911378 0.43931615 0.82879275
		 0.4889186 0.81453073;
	setAttr ".uvst[0].uvsp[500:519]" 0.4089742 0.86618584 0.51775205 0.81803179
		 0.50376678 0.81272781 0.42982712 0.90591776 0.47783718 0.90218848 0.50753355 0.90579432
		 0.53550404 0.89518654 0.43931612 0.85870725 0.46965808 0.83627141 0.47660905 0.82302743
		 0.5 0.83749992 0.5276705 0.82922733 0.53125 0.84375 0.4889186 0.87296927 0.50376678
		 0.87477219 0.51775205 0.86946821 0.5276705 0.85827267 0.45321807 0.88519514 0.46965808
		 0.85122859 0.47660905 0.86447257;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".clst[0].clsn" -type "string" "Colors";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 400 ".pt";
	setAttr ".pt[0:165]" -type "float3"  71.551941 -27.295567 -25.101711 90.354172 
		-30.442974 -22.441074 85.502541 -5.9112816 -40.583279 50.71413 -18.239054 -30.906828 
		71.551941 -27.295567 -13.367374 90.354172 -30.442974 -10.706736 112.96901 -10.804501 
		-30.518505 50.71413 -18.239054 -19.172487 64.336578 2.3600903 -48.872829 85.502541 
		-5.9112816 -29.12262 112.96901 -10.804501 -18.784166 118.94952 9.9392738 -39.09964 
		31.210064 -7.1895032 -28.521633 31.210064 -7.1895032 -40.255974 95.479446 16.08882 
		-50.500237 118.94952 9.9392738 -27.365299 16.331869 4.064137 -43.886414 16.331869 
		4.064137 -55.620747 64.336578 2.3600903 -37.412167 44.226803 10.944373 -57.696785 
		71.12764 27.237326 -63.557926 117.78684 29.25247 -36.360012 117.78684 29.25247 -48.094345 
		8.3560934 11.911646 -60.556057 8.3560934 11.911646 -72.29039 44.226803 10.944373 
		-46.236122 95.479446 16.08882 -39.039574 97.863327 42.222466 -60.770615 109.55208 
		50.814697 -47.963692 109.55208 50.814697 -59.698025 -2.8323641 20.206802 -82.679878 
		-2.8323641 20.206802 -94.140533 26.415625 23.16707 -60.408867 26.415625 23.16707 
		-71.869522 71.12764 27.237326 -52.097267 51.398754 38.907192 -76.963181 76.12571 
		57.857178 -75.521317 97.863327 42.222466 -49.309959 98.603134 66.123878 -57.009964 
		98.603134 66.123878 -68.744293 -2.8323636 22.396475 -85.196121 12.366819 32.578651 
		-80.16346 12.366819 32.578651 -91.624115 -2.8323636 22.396475 -96.656776 51.398754 
		38.907192 -65.502525 77.684975 84.095161 -70.413551 77.684975 84.095161 -82.147881 
		-2.8323612 36.021343 -105.34267 -2.8323612 36.021343 -116.80332 32.117107 46.846973 
		-78.906624 32.117107 46.846973 -90.367279 76.12571 57.857178 -64.060661 51.061596 
		70.268372 -91.864563 43.542442 95.009872 -90.457016 43.542442 95.009872 -102.19135 
		-2.9855344 37.418438 -106.74345 10.264353 48.428017 -96.589355 -2.832361 37.126591 
		-106.2732 10.264353 48.428017 -108.05001 -2.9855344 37.418438 -118.20411 -2.832361 
		37.126591 -117.73386 51.061596 70.268372 -80.403908 3.1284447 86.992393 -114.3267 
		3.1284447 86.992393 -126.06103 -6.9078841 44.891853 -117.5021 -6.9078841 44.891853 
		-128.96275 24.739262 68.406487 -95.943535 24.739262 68.406487 -107.40419 -16.879072 
		77.503784 -127.63201 -16.879072 77.503784 -139.28688 -7.1556172 45.363869 -118.00625 
		3.2971938 60.505268 -110.30451 3.2971938 60.505268 -121.76517 -7.1556172 45.363869 
		-129.46692 -34.422626 64.423515 -151.40417 -34.422626 64.423515 -153.70401 -33.561104 
		65.065849 -141.53537 -11.622189 53.874214 -125.31688 -12.075432 53.672768 -137.23357 
		-10.613103 51.257412 -134.93964 -7.8761535 46.736736 -130.64624 -14.014726 55.742256 
		-127.41042 -11.800443 54.213848 -125.45136 -34.063023 64.225288 -153.44632 -28.185844 
		63.848007 -149.00247 -20.427349 58.996048 -143.48926 -13.90622 54.9179 -138.85532 
		-18.60232 58.908848 -130.64624 -25.081385 62.960686 -135.25029 -27.862703 64.700058 
		-137.2267 -12.186963 53.871422 -137.3192 -51.369469 153.06819 -25.101711 -58.044849 
		170.92509 -22.441074 -76.864098 154.45761 -40.583279 -48.793728 130.49385 -30.906828 
		-51.369469 153.06819 -13.367374 -58.044849 170.92509 -10.706736 -86.359688 180.69089 
		-30.518505 -48.793728 130.49385 -19.172487 -73.444336 131.99167 -48.872829 -76.864098 
		154.45761 -29.12262 -86.359688 180.69089 -18.784166 -107.31457 175.49826 -39.09964 
		-48.610882 108.07806 -28.521633 -48.610882 108.07806 -40.255974 -100.9052 152.09782 
		-50.500237 -107.31457 175.49826 -27.365299 -50.917728 89.566338 -43.886414 -50.917728 
		89.566338 -55.620747 -73.444336 131.99167 -37.412167 -70.823654 110.28394 -57.696785 
		-98.384178 125.43428 -63.557926 -123.45895 164.83476 -36.360012 -123.45895 164.83476 
		-48.094345 -53.725983 78.735367 -60.556057 -53.725983 78.735367 -72.29039 -70.823654 
		110.28394 -46.236122 -100.9052 152.09782 -39.039574 -124.72955 141.0955 -60.770615 
		-138.01501 146.92215 -47.963692 -138.01501 146.92215 -59.698025 -55.38892 64.259766 
		-83.688187 -55.38892 64.259766 -95.148842 -72.503235 88.747665 -60.408867 -72.503235 
		88.747665 -71.869522 -98.384178 125.43428 -52.097267 -98.626129 102.51363 -76.963181 
		-127.40079 114.45281 -75.521317 -124.72955 141.0955 -49.309959 -145.79868 129.78549 
		-57.009964 -145.79868 129.78549 -68.744293 -56.94199 63.670761 -85.278862 -73.629501 
		71.875259 -80.16346 -73.629501 71.875259 -91.624115 -56.94199 63.670761 -96.739517 
		-98.626129 102.51363 -65.502525 -150.90317 102.68417 -70.413551 -150.90317 102.68417 
		-82.147881 -68.783401 56.256325 -106.58556 -64.882782 60.659222 -95.873459 -68.783401 
		56.256325 -118.04621 -64.882782 60.659222 -107.33411 -95.861366 81.845345 -78.906624 
		-95.861366 81.845345 -90.367279 -127.40079 114.45281 -64.060661 -125.61713 86.541054 
		-91.864563 -143.28432 67.658531 -90.457016 -143.28432 67.658531 -102.19135 -69.183487 
		55.804722 -107.34744 -86.304214 62.12978 -96.589355 -86.304214 62.12978 -108.05001 
		-69.183487 55.804722 -118.8081 -125.61713 86.541054 -80.403908 -116.134 36.667713 
		-114.3267 -116.134 36.667713 -126.06103 -74.922638 49.326553 -117.02284 -74.922638 
		49.326553 -128.48351 -110.84354 64.676186 -95.943535 -110.84354 64.676186 -107.40419 
		-97.912857 24.085003 -127.55254 -97.912857 24.085003 -139.28688 -75.544594 48.624512 
		-117.7526 -93.279839 50.057419 -110.30451 -93.279839 50.057419 -121.76517 -75.544594 
		48.624512 -129.21326 -77.813232 15.431971 -150.23027;
	setAttr ".pt[166:331]" -77.813232 15.431971 -153.70401 -78.550446 15.749346 
		-141.71457 -79.248451 39.849236 -126.25954 -77.679512 46.214691 -119.71945 -78.746849 
		39.484306 -138.29056 -77.640495 46.19421 -131.21571 -77.467934 46.409588 -131.03389 
		-77.100014 46.868801 -130.64624 -79.68718 38.069252 -127.39103 -77.832573 16.408596 
		-153.09099 -79.562569 22.080629 -148.80122 -81.20871 27.477753 -144.71938 -79.728951 
		34.668957 -140.93687 -78.905899 38.66872 -138.83302 -81.267715 31.656788 -130.64624 
		-81.896523 28.600975 -132.25357 -82.127655 27.477753 -132.84438 -78.770851 16.471972 
		-141.16805 -146.10835 -43.566765 -25.101711 -158.2352 -58.276264 -22.441074 -134.56432 
		-66.340477 -40.583279 -127.84628 -30.048939 -30.906828 -146.10835 -43.566765 -13.367374 
		-158.2352 -58.276264 -10.706736 -152.5352 -87.680527 -30.518505 -127.84628 -30.048939 
		-19.172487 -116.81812 -52.145897 -48.872829 -134.56432 -66.340477 -29.12262 -152.5352 
		-87.680527 -18.784166 -137.56082 -103.23168 -39.09964 -108.52505 -18.682692 -28.521633 
		-108.52505 -18.682692 -40.255974 -120.50012 -85.980782 -50.500237 -137.56082 -103.23168 
		-27.365299 -91.340012 -11.424621 -43.886414 -91.340012 -11.424621 -55.620747 -116.81812 
		-52.145897 -37.412167 -99.329018 -39.022461 -57.696785 -98.669327 -70.465744 -63.557926 
		-120.25376 -111.88137 -36.360012 -120.25376 -111.88137 -48.094345 -80.555977 -8.4411526 
		-60.556057 -80.555977 -8.4411526 -72.29039 -99.329018 -39.022461 -46.236122 -120.50012 
		-85.980782 -39.039574 -99.059662 -101.11211 -60.770615 -97.462952 -115.53098 -47.963692 
		-97.462952 -115.53098 -59.698025 -67.4813 -2.7705884 -83.187119 -67.4813 -2.7705884 
		-94.647774 -79.838264 -29.708878 -60.408867 -79.838264 -29.708878 -71.869522 -98.669327 
		-70.465744 -52.097267 -78.698486 -59.214958 -76.963181 -74.650795 -90.104126 -75.521317 
		-99.059662 -101.11211 -49.309959 -78.730331 -113.70351 -57.009964 -78.730331 -113.70351 
		-68.744293 -65.8396 -4.6236911 -85.022545 -64.663193 -22.248043 -80.16346 -64.663193 
		-22.248043 -91.624115 -65.8396 -4.6236911 -96.4832 -78.698486 -59.214958 -65.502525 
		-52.707661 -104.57348 -70.413551 -52.707661 -104.57348 -82.147881 -53.392925 -10.06124 
		-106.98278 -64.88279 -5.7037053 -86.442375 -53.392925 -10.06124 -118.44344 -64.88279 
		-5.7037053 -97.90303 -62.181606 -46.486458 -78.906624 -62.181606 -46.486458 -90.367279 
		-74.650795 -90.104126 -64.060661 -51.370331 -74.603561 -91.864563 -26.183983 -80.462532 
		-90.457016 -26.183983 -80.462532 -102.19135 -52.994423 -10.212373 -107.43717 -49.886005 
		-28.351938 -96.589355 -49.886005 -28.351938 -108.05001 -52.994423 -10.212373 -118.89783 
		-51.370331 -74.603561 -80.403908 -12.920321 -41.454247 -114.3267 -12.920321 -41.454247 
		-126.06103 -44.546921 -12.268442 -116.80309 -46.839134 -12.546767 -113.57402 -44.546921 
		-12.268442 -128.26375 -46.839134 -12.546767 -125.03468 -39.821598 -50.876812 -95.943535 
		-39.821598 -50.876812 -107.40419 -11.133942 -19.382925 -127.62119 -11.133942 -19.382925 
		-139.28688 -43.628853 -12.156969 -117.81016 -35.943222 -28.356825 -110.30451 -35.943222 
		-28.356825 -121.76517 -43.628853 -12.156969 -129.27081 -13.59691 1.5588028 -153.17891 
		-13.476336 0.53361672 -141.03818 -34.107761 -11.000903 -126.35227 -34.045216 -10.409489 
		-138.35977 -42.095798 -11.970824 -130.64624 -31.989302 -10.743675 -127.39857 -33.146416 
		-10.264347 -138.83549 -27.966211 -9.4716539 -140.99837 -27.682144 -10.220694 -129.10164 
		-25.735632 -8.8771133 -130.64624 -33.585484 -10.33525 -138.6031 -53.133701 21.618452 
		109.37814 -49.135551 17.105551 109.37814 -63.19574 16.337503 97.428284 -65.940247 
		27.47245 97.428284 -41.979813 27.47245 113.49533 -55.590919 7.7534199 97.428284 -74.958511 
		27.47245 78.816338 -54.576565 27.47245 109.37814 -43.498142 14.967555 109.37814 -71.181007 
		12.146503 78.816338 -71.181007 42.798405 78.816338 -63.19574 38.607426 97.428284 
		-37.512947 15.694302 109.37814 -53.133701 33.326443 109.37814 -60.713806 0.33153111 
		78.816338 -44.867905 3.6867385 97.428284 -76.307823 45.489193 55.363991 -80.748581 
		27.47245 55.363991 -32.551037 19.119278 109.37814 -33.483368 5.0690794 97.428284 
		-49.135551 37.839329 109.37814 -76.307823 9.4557133 55.363991 -45.954922 -5.2657738 
		78.816338 -64.002991 59.378483 55.363991 -60.713806 54.613403 78.816338 -55.590919 
		47.191521 97.428284 -29.749109 24.457848 109.37814 -30.285402 -3.3631499 78.816338 
		-43.498142 39.977345 109.37814 -64.002991 -4.4336109 55.363991 -65.136337 61.020473 
		29.366863 -78.074463 46.416382 29.366863 -82.743782 27.47245 29.366863 -29.749109 
		30.487051 109.37814 -24.0452 11.583761 97.428284 -46.652901 -11.013633 55.363991 
		-44.867905 51.258175 97.428284 -37.512947 39.250641 109.37814 -78.074478 8.5285378 
		29.366863 -46.893379 67.939194 29.366863 -45.954922 60.210678 78.816338 -46.652901 
		65.958618 55.363991 -32.551037 35.825611 109.37814 -18.715647 33.206558 97.428284 
		-18.715647 21.738333 97.428284 -17.294895 5.6035466 78.816338 -28.232206 -8.7769642 
		55.363991 -33.483368 49.875828 97.428284 -65.136345 -6.0755687 29.366863 -64.882782 
		60.659222 -130.64624 -46.839123 67.502274 -130.64624 -28.232206 63.721889 55.363991 
		-82.297752 27.477753 -130.64624 -77.679527 8.7408295 -130.64624 -9.9594326 35.36478 
		78.816338 -9.9594326 19.580132 78.816338 -46.893391 -12.994235 29.366863 -30.285402 
		58.30806 78.816338 -24.0452 43.361156 97.428284 -64.88279 -5.7037053 -130.64624 -27.524723 
		65.587326 29.366863;
	setAttr ".pt[332:399]" -27.682129 65.176193 -130.64624 -46.601265 65.543335 
		-156.14651 -17.294895 49.341404 78.816338 -4.3375974 36.750435 55.363991 -4.3375974 
		18.194471 55.363991 -12.960969 1.7640057 55.363991 -27.524738 -10.642459 29.366863 
		-46.839134 -12.546767 -130.64624 -75.93222 9.6578684 -156.14651 -11.467606 54.503941 
		29.366863 -28.381884 63.331097 -156.14651 -63.761799 59.035202 -156.14651 -12.960969 
		53.180874 55.363991 -80.324425 27.477753 -156.14651 -2.4004493 17.716991 29.366863 
		-11.467615 0.44098601 29.366863 -63.761799 -4.0796928 -156.14651 -2.4004455 37.227879 
		29.366863 -30.412642 57.976433 -179.15065 -13.277501 52.905296 -156.14651 -75.93222 
		45.297634 -156.14651 -60.508598 54.322121 -179.15065 -45.910973 59.858273 -179.15065 
		-74.59761 27.477753 -179.15065 -11.800452 0.74164367 -130.64624 -46.601265 -10.587826 
		-156.14651 -70.861366 12.319254 -179.15065 -2.832361 37.126591 -130.64624 -2.8323646 
		17.828899 -130.64624 -17.564085 49.107712 -179.15065 -44.835819 51.003574 -197.40681 
		-70.861366 42.636253 -179.15065 -13.277501 2.0502079 -156.14651 -28.381884 -8.3755913 
		-156.14651 -60.508598 0.6333847 -179.15065 -4.7483463 18.301157 -156.14651 -24.240599 
		43.192841 -197.40681 -33.575623 49.636337 -197.40681 -4.7483463 36.65435 -156.14651 
		-10.308755 35.283833 -179.15065 -55.441612 46.981331 -197.40681 -62.963345 38.491047 
		-197.40681 -65.677879 27.477753 -197.40681 -30.412642 -3.0209246 -179.15065 -45.910973 
		-4.9027638 -179.15065 -62.963345 16.464457 -197.40681 -18.969292 33.1492 -197.40681 
		-37.561211 39.127213 -209.12801 -10.308755 19.671673 -179.15065 -49.056843 37.731388 
		-209.12801 -43.481045 39.846008 -209.12801 -17.564085 5.8477921 -179.15065 -33.575623 
		5.3191667 -197.40681 -44.835819 3.95193 -197.40681 -55.441612 7.9741759 -197.40681 
		-18.969292 21.806305 -197.40681 -29.882206 30.45941 -209.12801 -32.6535 35.739662 
		-209.12801 -41.979267 27.477753 -213.16685 -53.011246 33.267784 -209.12801 -54.438366 
		27.477753 -209.12801 -37.561211 15.828294 -209.12801 -43.481045 15.109496 -209.12801 
		-49.056843 17.224115 -209.12801 -53.011246 21.687721 -209.12801 -24.240599 11.762667 
		-197.40681 -29.882206 24.496096 -209.12801 -32.6535 19.215843 -209.12801;
	setAttr -s 400 ".vt";
	setAttr ".vt[0:165]"  -75.015228271 28.96692657 27.96537781 -94.39057922 32.21027374 25.22364044
		 -89.3910675 6.93080902 43.91885376 -53.54224014 19.63435364 33.94744492 -75.015228271 28.96692657 16.15537834
		 -94.39057922 32.21027374 13.41363907 -117.69476318 11.97318268 33.54728699 -53.54224014 19.63435364 22.13744354
		 -67.57992554 -1.59268951 52.46108246 -89.3910675 6.93080902 32.10885239 -117.69476318 11.97318268 21.73728561
		 -123.85757446 -9.4029007 42.38998795 -33.44365311 8.24799347 31.7715683 -33.44365311 8.24799347 43.58156967
		 -99.67208862 -15.73989487 54.13809586 -123.85757446 -9.4029007 30.57998657 -18.11194229 -3.34867859 47.60469055
		 -18.11194229 -3.34867859 59.41469193 -67.57992554 -1.59268951 40.65108109 -46.85716629 -10.43863678 61.55400848
		 -74.57798767 -27.22822952 67.59381104 -122.65945435 -29.30479813 39.84886932 -122.65945435 -29.30479813 51.6588707
		 -9.89305115 -11.43539429 64.78245544 -9.89305115 -11.43539429 76.592453 -46.85716629 -10.43863678 49.74400711
		 -99.67208862 -15.73989487 42.32809448 -102.12863159 -42.67014313 64.72153473 -114.17367554 -51.52428055 51.80625153
		 -114.17367554 -51.52428055 63.6162529 1.63645124 -19.98340225 87.29863739 1.63645124 -19.98340225 99.10863495
		 -28.50307083 -23.033905029 64.34876251 -28.50307083 -23.033905029 76.15876007 -74.57798767 -27.22822952 55.78380966
		 -54.24773026 -39.2538147 81.40768433 -79.72840881 -58.78142929 79.92186737 -102.12863159 -42.67014313 52.91153717
		 -102.89099121 -67.30011749 61.1282692 -102.89099121 -67.30011749 72.93827057 1.63645077 -22.23982048 89.89157867
		 -14.026031494 -32.73236847 84.705513 -14.026031494 -32.73236847 96.51551056 1.63645077 -22.23982048 101.70157623
		 -54.24773026 -39.2538147 69.59768677 -81.33520508 -85.81919861 74.94042206 -81.33520508 -85.81919861 86.75041962
		 1.63644814 -36.27999878 110.65222931 1.63644814 -36.27999878 122.46222687 -34.37834549 -47.43561554 83.41036224
		 -34.37834549 -47.43561554 95.2203598 -79.72840881 -58.78142929 68.11186981 -53.90029526 -71.57093811 96.76328278
		 -46.15194321 -97.066604614 95.59484863 -46.15194321 -97.066604614 107.40484619 1.79429054 -37.71968079 112.095710754
		 -11.859478 -49.064849854 101.63209534 1.63644791 -37.41893768 111.61112213 -11.859478 -49.064849854 113.4420929
		 1.79429054 -37.71968079 123.90570831 1.63644791 -37.41893768 123.42111969 -53.90029526 -71.57093811 84.95328522
		 -4.50605392 -88.80474091 120.19212341 -4.50605392 -88.80474091 132.0021209717 5.83620071 -45.42089844 123.18229675
		 5.83620071 -45.42089844 134.99229431 -26.77560806 -69.65229797 100.96659088 -26.77560806 -69.65229797 112.77658844
		 16.11132813 -79.026901245 133.82112122 16.11132813 -79.026901245 145.63111877 6.091485023 -45.90730286 123.70182037
		 -4.6799469 -61.51023865 115.76531982 -4.6799469 -61.51023865 127.57531738 6.091485023 -45.90730286 135.51182556
		 34.18964386 -65.54792023 158.11776733 34.18964386 -65.54792023 160.48771667 33.30186081 -66.20983887 147.94815063
		 10.69420624 -54.67705917 131.23526001 11.16126442 -54.46947098 143.51521301 9.65436172 -51.98049164 141.15136719
		 6.83398438 -47.32201767 136.72709656 13.15967178 -56.60204315 133.39263916 10.87789345 -55.027046204 131.37387085
		 33.81907654 -65.34365082 160.22216797 27.76275253 -64.95487213 155.64286804 19.76776314 -59.95501709 149.96159363
		 13.047859192 -55.75255966 145.18640137 17.88710403 -59.86515808 136.72709656 24.56366348 -64.040504456 141.47149658
		 27.42976189 -65.83289337 143.50814819 11.27619553 -54.67418289 143.60346985 51.6530571 -156.89465332 27.96537781
		 58.53191376 -175.29586792 25.22364044 77.92481232 -158.32643127 43.91885376 48.99880219 -133.63220215 33.94744492
		 51.6530571 -156.89465332 16.15537834 58.53191376 -175.29586792 13.41363907 87.70983887 -185.35934448 33.54728699
		 48.99880219 -133.63220215 22.13744354 74.40080261 -135.17567444 52.46108246 77.92481232 -158.32643127 32.10885239
		 87.70983887 -185.35934448 21.73728561 109.3034668 -180.0084381104 42.38998795 48.81038284 -110.53314209 31.7715683
		 48.81038284 -110.53314209 43.58156967 102.69873047 -155.8946991 54.13809586 109.3034668 -180.0084381104 30.57998657
		 51.18754578 -91.45714569 47.60469055 51.18754578 -91.45714569 59.41469193 74.40080261 -135.17567444 40.65108109
		 71.70024109 -112.80625916 61.55400848 100.1008606 -128.41841125 67.59381104 125.93995667 -169.019897461 39.84886932
		 125.93995667 -169.019897461 51.6588707 54.081401825 -80.29602814 64.78245544 54.081401825 -80.29602814 76.592453
		 71.70024109 -112.80625916 49.74400711 102.69873047 -155.8946991 42.32809448 127.24928284 -144.55702209 64.72153473
		 140.93971252 -150.56126404 51.80625153 140.93971252 -150.56126404 63.6162529 55.79502869 -65.37918091 88.337677
		 55.79502869 -65.37918091 100.14767456 73.43101501 -90.61351776 64.34876251 73.43101501 -90.61351776 76.15876007
		 100.1008606 -128.41841125 55.78380966 100.35018921 -104.79909515 81.40768433 130.001953125 -117.10220337 79.92186737
		 127.24928284 -144.55702209 52.91153717 148.96064758 -132.9022522 61.1282692 148.96064758 -132.9022522 72.93827057
		 57.39543915 -64.77222443 89.97683716 74.59161377 -73.22680664 84.705513 74.59161377 -73.22680664 96.51551056
		 57.39543915 -64.77222443 101.78683472 100.35018921 -104.79909515 69.59768677 154.22073364 -104.97483826 74.94042206
		 154.22073364 -104.97483826 86.75041962 69.59780121 -57.13177872 111.93299866 65.57827759 -61.66888428 100.89437866
		 69.59780121 -57.13177872 123.74299622 65.57827759 -61.66888428 112.70437622 97.50115204 -83.50080109 83.41036224
		 97.50115204 -83.50080109 95.2203598 130.001953125 -117.10220337 68.11186981 128.16392517 -88.33964539 96.76328278
		 146.36964417 -68.88154602 95.59484863 146.36964417 -68.88154602 107.40484619 70.01007843 -56.66641235 112.71810913
		 87.65267944 -63.18426895 101.63209534 87.65267944 -63.18426895 113.4420929 70.01007843 -56.66641235 124.52810669
		 128.16392517 -88.33964539 84.95328522 118.39172363 -36.94607162 120.19212341 118.39172363 -36.94607162 132.0021209717
		 75.92417145 -49.99077606 122.68843842 75.92417145 -49.99077606 134.4984436 112.94000244 -65.8082962 100.96659088
		 112.94000244 -65.8082962 112.77658844 99.61517334 -23.97981834 133.82112122 99.61517334 -23.97981834 145.63111877
		 76.56508636 -49.2673378 123.44043732 94.84093475 -50.74391937 115.76531982 94.84093475 -50.74391937 127.57531738
		 76.56508636 -49.2673378 135.2504425 78.90287781 -15.063024521 156.90808105;
	setAttr ".vt[166:331]" 78.90287781 -15.063024521 160.48771667 79.66255951 -15.39007378 148.1328125
		 80.38184357 -40.22457123 132.2066803 78.76507568 -46.78405762 125.46723938 79.86495209 -39.84851837 144.60443115
		 78.72486877 -46.76295471 137.31393433 78.54705048 -46.98489761 137.12657166 78.16791534 -47.45810699 136.72709656
		 80.83394623 -38.39033127 133.37266541 78.92280579 -16.069419861 159.85600281 80.70553589 -21.91434669 155.43548584
		 82.40185547 -27.47598457 151.22921753 80.87698364 -34.88639069 147.33140564 80.028846741 -39.0080718994 145.16343689
		 82.46265411 -31.78240395 136.72709656 83.11063385 -28.63344383 138.38342285 83.34880829 -27.47598457 138.99223328
		 79.88968658 -16.13472748 147.56962585 149.27975464 45.73410034 27.96537781 161.77624512 60.89197159 25.22364044
		 137.38383484 69.20199585 43.91885376 130.46101379 31.80422592 33.94744492 149.27975464 45.73410034 16.15537834
		 161.77624512 60.89197159 13.41363907 155.9025116 91.1925354 33.54728699 130.46101379 31.80422592 22.13744354
		 119.096694946 54.57474136 52.46108246 137.38383484 69.20199585 32.10885239 155.9025116 91.1925354 21.73728561
		 140.47167969 107.2177124 42.38998795 110.55084229 20.091514587 31.7715683 110.55084229 20.091514587 43.58156967
		 122.89093781 89.44097137 54.13809586 140.47167969 107.2177124 30.57998657 92.84197235 12.61220455 47.60469055
		 92.84197235 12.61220455 59.41469193 119.096694946 54.57474136 40.65108109 101.074501038 41.051277161 61.55400848
		 100.3946991 73.45301056 67.59381104 122.6370697 116.13106537 39.84886932 122.6370697 116.13106537 51.6588707
		 81.72922516 9.53779507 64.78245544 81.72922516 9.53779507 76.592453 101.074501038 41.051277161 49.74400711
		 122.89093781 89.44097137 42.32809448 100.79693604 105.033538818 64.72153473 99.15155029 119.89191437 51.80625153
		 99.15155029 119.89191437 63.6162529 68.25600433 3.69438171 87.82133484 68.25600433 3.69438171 99.6313324
		 80.98963165 31.4538002 64.34876251 80.98963165 31.4538002 76.15876007 100.3946991 73.45301056 55.78380966
		 79.81510925 61.85927963 81.40768433 75.64404297 93.69001007 79.92186737 100.79693604 105.033538818 52.91153717
		 79.84793091 118.0087432861 61.1282692 79.84793091 118.0087432861 72.93827057 66.56426239 5.60397053 89.71270752
		 65.35199738 23.76554489 84.705513 65.35199738 23.76554489 96.51551056 66.56426239 5.60397053 101.52270508
		 79.81510925 61.85927963 69.59768677 53.032039642 108.60041046 74.94042206 53.032039642 108.60041046 86.75041962
		 53.73819351 11.20726585 112.34233093 65.57828522 6.71690559 91.1758194 53.73819351 11.20726585 124.15232849
		 65.57828522 6.71690559 102.98581696 62.79476929 48.74279022 83.41036224 62.79476929 48.74279022 95.2203598
		 75.64404297 93.69001007 68.11186981 51.65394592 77.71695709 96.76328278 25.69987106 83.7545166 95.59484863
		 25.69987106 83.7545166 107.40484619 53.32754135 11.36300564 112.81057739 50.12437439 30.055498123 101.63209534
		 50.12437439 30.055498123 113.4420929 53.32754135 11.36300564 124.62057495 51.65394592 77.71695709 84.95328522
		 12.031908035 43.55718994 120.19212341 12.031908035 43.55718994 132.0021209717 44.62254333 13.48174763 122.46198273
		 46.98463058 13.76855659 119.13448334 44.62254333 13.48174763 134.27198792 46.98463058 13.76855659 130.94448853
		 39.75318527 53.26697159 100.96659088 39.75318527 53.26697159 112.77658844 10.19107628 20.81309319 133.82112122
		 10.19107628 20.81309319 145.63111877 43.67649078 13.3668766 123.49974823 35.75658798 30.060533524 115.76531982
		 35.75658798 30.060533524 127.57531738 43.67649078 13.3668766 135.30975342 12.72912025 -0.76697731 159.9466095
		 12.60487175 0.28945839 147.43580627 33.86518097 12.17557144 132.30224609 33.80072784 11.56612968 144.67575073
		 42.09670639 13.17505741 136.72709656 31.68214607 11.91050339 133.38043213 32.87453079 11.41656399 145.16598511
		 27.53642464 10.59970856 147.39477539 27.24369812 11.37158012 135.13542175 25.2378521 9.98704529 136.72709656
		 33.32698441 11.48962784 144.92649841 53.34487915 -21.50946236 -106.12026978 49.26993561 -16.90979767 -106.12026978
		 63.60033417 -16.12698364 -94.041793823 66.39761353 -27.47598457 -94.041793823 41.97662354 -27.47598457 -110.28222656
		 55.84932709 -7.37790298 -94.041793823 75.5892334 -27.47598457 -75.22914124 54.81549835 -27.47598457 -106.12026978
		 43.52417755 -14.73072052 -106.12026978 71.73910522 -11.85542679 -75.22914124 71.73910522 -43.096542358 -75.22914124
		 63.60033417 -38.8249855 -94.041793823 37.42389679 -15.47142887 -106.12026978 53.34487915 -33.44250488 -106.12026978
		 61.070762634 0.18664932 -75.22914124 44.92024994 -3.2330513 -94.041793823 76.96452332 -45.83905029 -51.52380753
		 81.49061584 -27.47598457 -51.52380753 32.36658859 -18.9622364 -106.12026978 33.31682205 -4.64196396 -94.041793823
		 49.26993561 -38.042171478 -106.12026978 76.96452332 -9.11291695 -51.52380753 46.028175354 5.89155006 -75.22914124
		 64.42312622 -59.99536133 -51.52380753 61.070762634 -55.13861847 -75.22914124 55.84932709 -47.57406616 -94.041793823
		 29.5108223 -24.40344048 -106.12026978 30.057426453 3.95234871 -75.22914124 43.52417755 -40.22124863 -106.12026978
		 64.42312622 5.043390274 -51.52380753 65.57827759 -61.66888428 -25.24623489 78.76507568 -46.78405762 -25.24623489
		 83.52409363 -27.47598457 -25.24623489 29.5108223 -30.54852867 -106.12026978 23.69724846 -11.2818737 -94.041793823
		 46.73950958 11.74990273 -51.52380753 44.92024994 -51.71891785 -94.041793823 37.42389679 -39.48054123 -106.12026978
		 78.76509094 -8.16792488 -25.24623489 46.98461533 -68.72052765 -25.24623489 46.028175354 -60.84352112 -75.22914124
		 46.73950958 -66.70187378 -51.52380753 32.36658859 -35.98973083 -106.12026978 18.2652626 -33.32030869 -94.041793823
		 18.2652626 -21.63166046 -94.041793823 16.8172226 -5.18670273 -75.22914124 27.96476746 9.47023582 -51.52380753
		 33.31682205 -50.31000519 -94.041793823 65.57828522 6.71690559 -25.24623489 65.57827759 -61.66888428 136.72709656
		 46.98461533 -68.72052765 136.72709656 27.96476746 -64.42220306 -51.52380753 83.52409363 -27.47598457 136.72709656
		 78.76509094 -8.16792488 136.72709656 9.34073639 -35.52000809 -75.22914124 9.34073639 -19.43196106 -75.22914124
		 46.98463058 13.76855659 -25.24623489 30.057426453 -58.90431976 -75.22914124 23.69724846 -43.67009735 -94.041793823
		 65.57828522 6.71690559 136.72709656 27.24368286 -66.32353973 -25.24623489;
	setAttr ".vt[332:399]" 27.24368286 -66.32353973 136.72709656 46.73950958 -66.70187378 163.0046691895
		 16.8172226 -49.76526642 -75.22914124 3.61083603 -36.93230057 -51.52380753 3.61083603 -18.019668579 -51.52380753
		 12.39997482 -1.27336121 -51.52380753 27.24369812 11.37158012 -25.24623489 46.98463058 13.76855659 136.72709656
		 76.96452332 -9.11291695 163.0046691895 10.87789345 -55.027046204 -25.24623489 27.96476746 -64.42220306 163.0046691895
		 64.42312622 -59.99536133 163.0046691895 12.39997482 -53.67860794 -51.52380753 81.49061584 -27.47598457 163.0046691895
		 1.63645172 -17.5330162 -25.24623489 10.87790298 0.075090408 -25.24623489 64.42312622 5.043390274 163.0046691895
		 1.63644791 -37.41893768 -25.24623489 30.057426453 -58.90431976 186.71000671 12.39997482 -53.67860794 163.0046691895
		 76.96452332 -45.83905029 163.0046691895 61.070762634 -55.13861847 186.71000671 46.028175354 -60.84352112 186.71000671
		 75.5892334 -27.47598457 186.71000671 10.87790298 0.075090408 136.72709656 46.73950958 11.74990273 163.0046691895
		 71.73910522 -11.85542679 186.71000671 1.63644791 -37.41893768 136.72709656 1.63645172 -17.5330162 136.72709656
		 16.8172226 -49.76526642 186.71000671 44.92024994 -51.71891785 205.5226593 71.73910522 -43.096542358 186.71000671
		 12.39997482 -1.27336121 163.0046691895 27.96476746 9.47023582 163.0046691895 61.070762634 0.18664932 186.71000671
		 3.61083603 -18.019668579 163.0046691895 23.69724846 -43.67009735 205.5226593 33.31682205 -50.31000519 205.5226593
		 3.61083603 -36.93230057 163.0046691895 9.34073639 -35.52000809 186.71000671 55.84932709 -47.57406616 205.5226593
		 63.60033417 -38.8249855 205.5226593 66.39761353 -27.47598457 205.5226593 30.057426453 3.95234871 186.71000671
		 46.028175354 5.89155006 186.71000671 63.60033417 -16.12698364 205.5226593 18.2652626 -33.32030869 205.5226593
		 37.42389679 -39.48054123 217.60113525 9.34073639 -19.43196106 186.71000671 49.26993561 -38.042171478 217.60113525
		 43.52417755 -40.22124863 217.60113525 16.8172226 -5.18670273 186.71000671 33.31682205 -4.64196396 205.5226593
		 44.92024994 -3.2330513 205.5226593 55.84932709 -7.37790298 205.5226593 18.2652626 -21.63166046 205.5226593
		 29.5108223 -30.54852867 217.60113525 32.36658859 -35.98973083 217.60113525 41.97662354 -27.47598457 221.76309204
		 53.34487915 -33.44250488 217.60113525 54.81549835 -27.47598457 217.60113525 37.42389679 -15.47142887 217.60113525
		 43.52417755 -14.73072052 217.60113525 49.26993561 -16.90979767 217.60113525 53.34487915 -21.50946236 217.60113525
		 23.69724846 -11.2818737 205.5226593 29.5108223 -24.40344048 217.60113525 32.36658859 -18.9622364 217.60113525;
	setAttr -s 774 ".ed";
	setAttr ".ed[0:165]"  0 1 0 2 0 1 3 0 0 4 5 0 5 1 0 0 4 1 1 6 0 6 2 1 7 4 0
		 3 7 1 2 8 1 8 3 1 4 9 1 5 10 0 10 6 0 6 11 0 12 7 0 3 13 0 13 12 1 2 14 1 9 10 1
		 10 15 0 15 11 1 11 14 1 16 12 0 13 17 0 17 16 1 18 7 1 18 9 1 8 19 1 19 13 1 14 20 1
		 20 8 1 15 21 0 21 22 1 22 11 0 23 16 0 17 24 0 24 23 1 25 12 1 25 18 1 26 9 1 14 27 1
		 26 15 1 21 28 0 28 29 1 29 22 0 22 27 1 30 23 0 24 31 0 31 30 0 32 16 1 17 33 1 32 25 1
		 19 33 1 34 18 1 34 26 1 20 35 1 35 19 1 36 20 1 27 36 1 26 37 1 37 21 1 28 38 0 38 39 1
		 39 29 0 40 41 1 41 23 1 30 40 0 24 42 1 42 43 1 43 31 0 41 32 1 33 42 1 44 25 1 44 34 1
		 27 39 1 37 38 1 38 45 0 45 46 1 46 39 0 47 41 1 40 47 0 42 48 1 48 43 0 49 32 1 33 50 1
		 49 44 1 35 50 1 51 34 1 51 37 1 52 35 1 36 52 1 46 36 1 51 45 1 45 53 0 53 54 1 54 46 0
		 55 56 1 56 41 1 47 57 0 57 55 0 58 59 1 59 60 0 60 48 0 42 58 1 56 49 1 50 58 1 61 44 1
		 61 51 1 61 53 1 53 62 0 62 63 1 63 54 0 54 52 1 64 56 1 55 64 0 58 65 1 65 59 0 66 49 1
		 50 67 1 66 61 1 52 67 1 66 62 1 62 68 0 68 69 1 69 63 0 63 67 1 70 71 1 71 56 1 64 70 0
		 58 72 1 72 73 1 73 65 0 71 66 1 67 72 1 71 68 1 74 75 0 75 69 0 68 76 0 76 74 0 69 72 1
		 77 71 1 70 77 0 72 78 1 78 79 0 79 80 0 80 73 0 81 68 1 77 82 0 82 81 0 83 75 0 74 83 0
		 83 84 0 84 85 0 85 86 0 86 69 1 81 87 0 87 88 0 88 89 0 89 76 0 86 90 0 90 78 0 91 92 0
		 93 91 1 94 91 0;
	setAttr ".ed[166:331]" 95 96 0 96 92 0 91 95 1 92 97 0 97 93 1 98 95 0 94 98 1
		 93 99 1 99 94 1 95 100 1 96 101 0 101 97 0 97 102 0 103 98 0 94 104 0 104 103 1 93 105 1
		 100 101 1 101 106 0 106 102 1 102 105 1 107 103 0 104 108 0 108 107 1 109 98 1 109 100 1
		 99 110 1 110 104 1 105 111 1 111 99 1 106 112 0 112 113 1 113 102 0 114 107 0 108 115 0
		 115 114 1 116 103 1 116 109 1 117 100 1 105 118 1 117 106 1 112 119 0 119 120 1 120 113 0
		 113 118 1 121 114 0 115 122 0 122 121 0 123 107 1 108 124 1 123 116 1 110 124 1 125 109 1
		 125 117 1 111 126 1 126 110 1 127 111 1 118 127 1 117 128 1 128 112 1 119 129 0 129 130 1
		 130 120 0 131 132 1 132 114 1 121 131 0 115 133 1 133 134 1 134 122 0 132 123 1 124 133 1
		 135 116 1 135 125 1 118 130 1 128 129 1 129 136 0 136 137 1 137 130 0 138 132 1 131 139 0
		 139 138 0 133 140 1 140 141 0 141 134 0 142 123 1 124 143 1 142 135 1 126 143 1 144 125 1
		 144 128 1 145 126 1 127 145 1 137 127 1 144 136 1 136 146 0 146 147 1 147 137 0 148 149 1
		 149 132 1 138 148 0 133 150 1 150 151 1 151 140 0 149 142 1 143 150 1 152 135 1 152 144 1
		 152 146 1 146 153 0 153 154 1 154 147 0 147 145 1 155 149 1 148 155 0 150 156 1 156 151 0
		 157 142 1 143 158 1 157 152 1 145 158 1 157 153 1 153 159 0 159 160 1 160 154 0 154 158 1
		 161 162 1 162 149 1 155 161 0 150 163 1 163 164 1 164 156 0 162 157 1 158 163 1 162 159 1
		 165 166 0 166 160 0 159 167 0 167 165 0 160 163 1 168 162 1 161 169 0 169 168 0 163 170 1
		 170 171 0 171 172 0 172 173 0 173 164 0 174 159 1 168 174 0 175 166 0 165 175 0 175 176 0
		 176 177 0 177 178 0 178 179 0 179 160 1 174 180 0 180 181 0 181 182 0 182 183 0 183 167 0
		 179 170 0 184 185 0 186 184 1 187 184 0 188 189 0;
	setAttr ".ed[332:497]" 189 185 0 184 188 1 185 190 0 190 186 1 191 188 0 187 191 1
		 186 192 1 192 187 1 188 193 1 189 194 0 194 190 0 190 195 0 196 191 0 187 197 0 197 196 1
		 186 198 1 193 194 1 194 199 0 199 195 1 195 198 1 200 196 0 197 201 0 201 200 1 202 191 1
		 202 193 1 192 203 1 203 197 1 198 204 1 204 192 1 199 205 0 205 206 1 206 195 0 207 200 0
		 201 208 0 208 207 1 209 196 1 209 202 1 210 193 1 198 211 1 210 199 1 205 212 0 212 213 1
		 213 206 0 206 211 1 214 207 0 208 215 0 215 214 0 216 200 1 201 217 1 216 209 1 203 217 1
		 218 202 1 218 210 1 204 219 1 219 203 1 220 204 1 211 220 1 210 221 1 221 205 1 212 222 0
		 222 223 1 223 213 0 224 225 1 225 207 1 214 224 0 208 226 1 226 227 1 227 215 0 225 216 1
		 217 226 1 228 209 1 228 218 1 211 223 1 221 222 1 222 229 0 229 230 1 230 223 0 231 225 1
		 224 232 0 232 231 0 226 233 1 233 234 0 234 227 0 235 216 1 217 236 1 235 228 1 219 236 1
		 237 218 1 237 221 1 238 219 1 220 238 1 230 220 1 237 229 1 229 239 0 239 240 1 240 230 0
		 241 242 1 242 225 1 231 241 0 226 243 1 243 244 1 244 233 0 242 235 1 236 243 1 245 228 1
		 245 237 1 245 239 1 239 246 0 246 247 1 247 240 0 240 238 1 248 242 1 241 249 0 249 248 0
		 243 250 1 250 251 0 251 244 0 252 235 1 236 253 1 252 245 1 238 253 1 252 246 1 246 254 0
		 254 255 1 255 247 0 247 253 1 256 257 1 257 242 1 248 256 0 243 258 1 258 259 1 259 250 0
		 257 252 1 253 258 1 257 254 1 260 255 0 254 261 0 261 260 0 255 258 1 262 257 1 256 262 0
		 258 263 1 263 264 0 264 259 0 265 254 1 262 265 0 266 255 1 260 267 0 267 266 0 265 268 0
		 268 269 0 269 261 0 266 270 0 270 263 0 271 272 1 273 271 1 273 274 1 271 275 1 275 272 1
		 272 276 1 276 273 1 277 274 1 278 271 1 274 278 1 279 272 1 275 279 1;
	setAttr ".ed[498:663]" 278 275 1 280 273 1 277 281 1 280 277 1 274 282 1 283 279 1
		 275 283 1 278 284 1 284 275 1 276 285 1 285 280 1 279 286 1 286 276 1 287 281 1 281 282 1
		 288 277 1 282 284 1 289 283 1 275 289 1 283 290 1 290 286 1 284 291 1 291 275 1 292 280 1
		 286 293 1 293 285 1 287 294 1 288 287 1 281 295 1 292 288 1 282 296 1 297 289 1 275 297 1
		 290 298 1 298 293 1 296 291 1 291 299 1 299 275 1 285 300 1 300 292 1 301 294 1 294 295 1
		 302 287 1 295 296 1 303 288 1 304 297 1 275 304 1 305 289 1 305 290 1 306 293 1 296 307 1
		 307 299 1 299 308 1 308 275 1 309 292 1 306 300 1 301 310 1 302 301 1 311 295 1 294 312 1
		 312 311 1 303 302 1 309 303 1 313 304 1 275 313 1 304 314 1 314 315 1 315 297 1 315 305 1
		 305 316 1 316 298 1 298 317 1 317 306 1 311 307 1 307 318 1 318 308 1 308 313 1 300 319 1
		 319 309 1 301 139 1 141 320 1 320 321 1 321 310 1 310 312 1 302 169 1 312 322 1 303 323 1
		 323 180 1 309 324 1 324 323 1 314 325 1 325 326 1 326 315 1 326 316 1 327 306 1 311 328 1
		 328 318 1 318 329 1 329 313 1 319 232 1 234 330 1 330 324 1 327 319 1 331 310 1 321 332 1
		 332 331 1 173 320 1 333 321 1 331 322 1 322 328 1 323 181 1 324 183 1 182 323 1 329 314 1
		 329 334 1 334 325 1 325 335 1 335 336 1 336 326 1 337 316 1 337 317 1 317 338 1 338 327 1
		 328 334 1 327 249 1 251 339 1 339 330 1 340 324 1 341 331 1 332 87 1 82 341 1 333 342 1
		 342 84 1 89 332 1 172 343 1 343 320 1 343 333 1 322 344 1 345 176 1 340 345 1 336 337 1
		 346 336 1 337 347 1 347 338 1 338 268 1 344 334 1 264 339 1 348 330 1 348 340 1 349 341 1
		 57 349 1 332 88 1 350 342 1 351 85 1 342 351 1 171 352 1 352 343 1 343 353 1 353 354 1
		 354 333 1 341 344 1 355 345 1 345 177 1 344 335 1 346 347 1 335 349 1;
	setAttr ".ed[664:773]" 349 346 1 347 356 1 356 269 1 270 357 1 357 339 1 357 348 1
		 358 340 1 60 359 1 359 360 1 360 346 1 350 361 1 354 350 1 361 351 1 351 90 1 178 352 1
		 362 354 1 355 363 1 358 355 1 345 352 1 360 356 1 356 364 1 364 365 1 365 267 1 365 357 1
		 366 348 1 366 358 1 80 359 1 367 360 1 368 361 1 362 369 1 369 350 1 370 351 1 361 371 1
		 371 370 1 370 79 1 352 363 1 363 353 1 353 372 1 372 362 1 373 363 1 374 355 1 375 365 1
		 375 376 1 376 357 1 376 366 1 377 358 1 370 359 1 367 364 1 370 367 1 368 378 1 378 371 1
		 369 368 1 379 369 1 371 380 1 380 367 1 372 381 1 381 382 1 382 362 1 373 372 1 374 373 1
		 377 374 1 364 383 1 383 375 1 375 384 1 384 385 1 385 376 1 385 386 1 386 366 1 386 377 1
		 380 383 1 378 387 1 387 380 1 388 378 1 389 368 1 379 389 1 382 379 1 381 390 1 390 382 1
		 391 373 1 392 374 1 384 393 1 393 394 1 394 385 1 394 395 1 395 386 1 396 377 1 387 397 1
		 397 383 1 388 398 1 398 387 1 389 388 1 379 390 1 390 389 1 391 381 1 391 390 1 392 391 1
		 396 392 1 397 384 1 397 399 1 399 393 1 393 390 1 390 394 1 395 396 1 390 395 1 398 399 1
		 388 390 1 390 398 1 392 390 1 396 390 1 399 390 1;
	setAttr -s 376 -ch 1548 ".fc[0:375]" -type "polyFaces" 
		f 4 1 0 6 7
		mu 0 4 2 0 1 6
		f 4 2 -2 10 11
		mu 0 4 3 0 2 8
		f 4 3 4 -1 5
		mu 0 4 4 5 1 0
		f 4 8 -6 -3 9
		mu 0 4 7 4 0 3
		f 4 -4 12 20 -14
		mu 0 4 5 4 9 10
		f 4 13 14 -7 -5
		mu 0 4 5 10 6 1
		f 4 -8 15 23 -20
		mu 0 4 2 6 11 14
		f 4 16 -10 17 18
		mu 0 4 12 7 3 13
		f 4 -13 -9 -28 28
		mu 0 4 9 4 7 18
		f 4 -18 -12 29 30
		mu 0 4 13 3 8 19
		f 4 -11 19 31 32
		mu 0 4 8 2 14 20
		f 4 21 22 -16 -15
		mu 0 4 10 15 11 6
		f 4 24 -19 25 26
		mu 0 4 16 12 13 17
		f 4 27 -17 -40 40
		mu 0 4 18 7 12 25
		f 4 -22 -21 -42 43
		mu 0 4 15 10 9 26
		f 4 33 34 35 -23
		mu 0 4 15 21 22 11
		f 4 -24 -36 47 -43
		mu 0 4 14 11 22 27
		f 4 36 -27 37 38
		mu 0 4 23 16 17 24
		f 4 39 -25 -52 53
		mu 0 4 25 12 16 32
		f 4 -26 -31 54 -53
		mu 0 4 17 13 19 33
		f 4 41 -29 -56 56
		mu 0 4 26 9 18 34
		f 4 -30 -33 57 58
		mu 0 4 19 8 20 35
		f 4 -32 42 60 59
		mu 0 4 20 14 27 36
		f 4 -34 -44 61 62
		mu 0 4 21 15 26 37
		f 4 44 45 46 -35
		mu 0 4 21 28 29 22
		f 4 48 -39 49 50
		mu 0 4 30 23 24 31
		f 4 51 -37 -68 72
		mu 0 4 32 16 23 41
		f 4 -38 52 73 -70
		mu 0 4 24 17 33 42
		f 4 55 -41 -75 75
		mu 0 4 34 18 25 44
		f 4 -45 -63 77 -64
		mu 0 4 28 21 37 38
		f 4 63 64 65 -46
		mu 0 4 28 38 39 29
		f 4 -48 -47 -66 -77
		mu 0 4 27 22 29 39
		f 4 66 67 -49 68
		mu 0 4 40 41 23 30
		f 4 -50 69 70 71
		mu 0 4 31 24 42 43
		f 4 74 -54 -86 87
		mu 0 4 44 25 32 49
		f 4 -55 -59 88 -87
		mu 0 4 33 19 35 50
		f 4 -62 -57 -90 90
		mu 0 4 37 26 34 51
		f 4 -58 -60 92 91
		mu 0 4 35 20 36 52
		f 4 -61 76 -81 93
		mu 0 4 36 27 39 46
		f 4 78 79 80 -65
		mu 0 4 38 45 46 39
		f 3 81 -67 82
		mu 0 3 47 41 40
		f 3 -71 83 84
		mu 0 3 43 42 48
		f 4 85 -73 -100 106
		mu 0 4 49 32 41 56
		f 4 -74 86 107 -106
		mu 0 4 42 33 50 58
		f 4 89 -76 -109 109
		mu 0 4 51 34 44 61
		f 4 -78 -91 94 -79
		mu 0 4 38 37 51 45
		f 4 95 96 97 -80
		mu 0 4 45 53 54 46
		f 5 98 99 -82 100 101
		mu 0 5 55 56 41 47 57
		f 5 102 103 104 -84 105
		mu 0 5 58 59 60 48 42
		f 4 108 -88 -120 121
		mu 0 4 61 44 49 66
		f 4 -89 -92 122 -121
		mu 0 4 50 35 52 67
		f 4 -93 -94 -98 114
		mu 0 4 52 36 46 54
		f 4 -95 -110 110 -96
		mu 0 4 45 51 61 53
		f 4 111 112 113 -97
		mu 0 4 53 62 63 54
		f 3 115 -99 116
		mu 0 3 64 56 55
		f 3 -103 117 118
		mu 0 3 59 58 65
		f 4 119 -107 -130 134
		mu 0 4 66 49 56 71
		f 4 -108 120 135 -132
		mu 0 4 58 50 67 72
		f 4 -111 -122 123 -112
		mu 0 4 53 61 66 62
		f 4 124 125 126 -113
		mu 0 4 62 68 69 63
		f 4 -114 127 -123 -115
		mu 0 4 54 63 67 52
		f 4 128 129 -116 130
		mu 0 4 70 71 56 64
		f 4 -118 131 132 133
		mu 0 4 65 58 72 73
		f 4 -124 -135 136 -125
		mu 0 4 62 66 71 68
		f 5 137 138 -126 139 140
		mu 0 5 74 75 69 68 76
		f 4 -127 141 -136 -128
		mu 0 4 63 69 72 67
		f 3 142 -129 143
		mu 0 3 77 71 70
		f 5 -133 144 145 146 147
		mu 0 5 73 72 78 79 80
		f 5 148 -137 -143 149 150
		mu 0 5 81 68 71 77 82
		f 3 151 -138 152
		mu 0 3 83 75 74
		f 6 -152 153 154 155 156 -139
		mu 0 6 75 83 84 85 86 69
		f 6 -140 -149 157 158 159 160
		mu 0 6 76 68 81 87 88 89
		f 5 -157 161 162 -145 -142
		mu 0 5 69 86 90 78 72
		f 4 164 163 169 170
		mu 0 4 93 91 92 97
		f 4 165 -165 173 174
		mu 0 4 94 91 93 99
		f 4 166 167 -164 168
		mu 0 4 95 96 92 91
		f 4 171 -169 -166 172
		mu 0 4 98 95 91 94
		f 4 -167 175 183 -177
		mu 0 4 96 95 100 101
		f 4 176 177 -170 -168
		mu 0 4 96 101 97 92
		f 4 -171 178 186 -183
		mu 0 4 93 97 102 105
		f 4 179 -173 180 181
		mu 0 4 103 98 94 104
		f 4 -176 -172 -191 191
		mu 0 4 100 95 98 109
		f 4 -181 -175 192 193
		mu 0 4 104 94 99 110
		f 4 -174 182 194 195
		mu 0 4 99 93 105 111
		f 4 184 185 -179 -178
		mu 0 4 101 106 102 97
		f 4 187 -182 188 189
		mu 0 4 107 103 104 108
		f 4 190 -180 -203 203
		mu 0 4 109 98 103 116
		f 4 -185 -184 -205 206
		mu 0 4 106 101 100 117
		f 4 196 197 198 -186
		mu 0 4 106 112 113 102
		f 4 -187 -199 210 -206
		mu 0 4 105 102 113 118
		f 4 199 -190 200 201
		mu 0 4 114 107 108 115
		f 4 202 -188 -215 216
		mu 0 4 116 103 107 123
		f 4 -189 -194 217 -216
		mu 0 4 108 104 110 124
		f 4 204 -192 -219 219
		mu 0 4 117 100 109 125
		f 4 -193 -196 220 221
		mu 0 4 110 99 111 126
		f 4 -195 205 223 222
		mu 0 4 111 105 118 127
		f 4 -197 -207 224 225
		mu 0 4 112 106 117 128
		f 4 207 208 209 -198
		mu 0 4 112 119 120 113
		f 4 211 -202 212 213
		mu 0 4 121 114 115 122
		f 4 214 -200 -231 235
		mu 0 4 123 107 114 132
		f 4 -201 215 236 -233
		mu 0 4 115 108 124 133
		f 4 218 -204 -238 238
		mu 0 4 125 109 116 135
		f 4 -208 -226 240 -227
		mu 0 4 119 112 128 129
		f 4 226 227 228 -209
		mu 0 4 119 129 130 120
		f 4 -211 -210 -229 -240
		mu 0 4 118 113 120 130
		f 4 229 230 -212 231
		mu 0 4 131 132 114 121
		f 4 -213 232 233 234
		mu 0 4 122 115 133 134
		f 4 237 -217 -251 252
		mu 0 4 135 116 123 142
		f 4 -218 -222 253 -252
		mu 0 4 124 110 126 143
		f 4 -225 -220 -255 255
		mu 0 4 128 117 125 144
		f 4 -221 -223 257 256
		mu 0 4 126 111 127 145
		f 4 -224 239 -244 258
		mu 0 4 127 118 130 137
		f 4 241 242 243 -228
		mu 0 4 129 136 137 130
		f 4 244 -230 245 246
		mu 0 4 138 132 131 139
		f 4 -234 247 248 249
		mu 0 4 134 133 140 141
		f 4 250 -236 -265 269
		mu 0 4 142 123 132 149
		f 4 -237 251 270 -267
		mu 0 4 133 124 143 150
		f 4 254 -239 -272 272
		mu 0 4 144 125 135 152
		f 4 -241 -256 259 -242
		mu 0 4 129 128 144 136
		f 4 260 261 262 -243
		mu 0 4 136 146 147 137
		f 4 263 264 -245 265
		mu 0 4 148 149 132 138
		f 4 -248 266 267 268
		mu 0 4 140 133 150 151
		f 4 271 -253 -283 284
		mu 0 4 152 135 142 157
		f 4 -254 -257 285 -284
		mu 0 4 143 126 145 158
		f 4 -258 -259 -263 277
		mu 0 4 145 127 137 147
		f 4 -260 -273 273 -261
		mu 0 4 136 144 152 146
		f 4 274 275 276 -262
		mu 0 4 146 153 154 147
		f 3 278 -264 279
		mu 0 3 155 149 148
		f 3 -268 280 281
		mu 0 3 151 150 156
		f 4 282 -270 -293 297
		mu 0 4 157 142 149 162
		f 4 -271 283 298 -295
		mu 0 4 150 143 158 163
		f 4 -274 -285 286 -275
		mu 0 4 146 152 157 153
		f 4 287 288 289 -276
		mu 0 4 153 159 160 154
		f 4 -277 290 -286 -278
		mu 0 4 147 154 158 145
		f 4 291 292 -279 293
		mu 0 4 161 162 149 155
		f 4 -281 294 295 296
		mu 0 4 156 150 163 164
		f 4 -287 -298 299 -288
		mu 0 4 153 157 162 159
		f 5 300 301 -289 302 303
		mu 0 5 165 166 160 159 167
		f 4 -290 304 -299 -291
		mu 0 4 154 160 163 158
		f 4 305 -292 306 307
		mu 0 4 168 162 161 169
		f 6 -296 308 309 310 311 312
		mu 0 6 164 163 170 171 172 173
		f 4 313 -300 -306 314
		mu 0 4 174 159 162 168
		f 3 315 -301 316
		mu 0 3 175 166 165
		f 7 -316 317 318 319 320 321 -302
		mu 0 7 166 175 176 177 178 179 160
		f 7 -303 -314 322 323 324 325 326
		mu 0 7 167 159 174 180 181 182 183
		f 4 -309 -305 -322 327
		mu 0 4 170 163 160 179
		f 4 329 328 334 335
		mu 0 4 186 184 185 190
		f 4 330 -330 338 339
		mu 0 4 187 184 186 192
		f 4 331 332 -329 333
		mu 0 4 188 189 185 184
		f 4 336 -334 -331 337
		mu 0 4 191 188 184 187
		f 4 -332 340 348 -342
		mu 0 4 189 188 193 194
		f 4 341 342 -335 -333
		mu 0 4 189 194 190 185
		f 4 -336 343 351 -348
		mu 0 4 186 190 195 198
		f 4 344 -338 345 346
		mu 0 4 196 191 187 197
		f 4 -341 -337 -356 356
		mu 0 4 193 188 191 202
		f 4 -346 -340 357 358
		mu 0 4 197 187 192 203
		f 4 -339 347 359 360
		mu 0 4 192 186 198 204
		f 4 349 350 -344 -343
		mu 0 4 194 199 195 190
		f 4 352 -347 353 354
		mu 0 4 200 196 197 201
		f 4 355 -345 -368 368
		mu 0 4 202 191 196 209
		f 4 -350 -349 -370 371
		mu 0 4 199 194 193 210
		f 4 361 362 363 -351
		mu 0 4 199 205 206 195
		f 4 -352 -364 375 -371
		mu 0 4 198 195 206 211
		f 4 364 -355 365 366
		mu 0 4 207 200 201 208
		f 4 367 -353 -380 381
		mu 0 4 209 196 200 216
		f 4 -354 -359 382 -381
		mu 0 4 201 197 203 217
		f 4 369 -357 -384 384
		mu 0 4 210 193 202 218
		f 4 -358 -361 385 386
		mu 0 4 203 192 204 219
		f 4 -360 370 388 387
		mu 0 4 204 198 211 220
		f 4 -362 -372 389 390
		mu 0 4 205 199 210 221
		f 4 372 373 374 -363
		mu 0 4 205 212 213 206
		f 4 376 -367 377 378
		mu 0 4 214 207 208 215
		f 4 379 -365 -396 400
		mu 0 4 216 200 207 225
		f 4 -366 380 401 -398
		mu 0 4 208 201 217 226
		f 4 383 -369 -403 403
		mu 0 4 218 202 209 228
		f 4 -373 -391 405 -392
		mu 0 4 212 205 221 222
		f 4 391 392 393 -374
		mu 0 4 212 222 223 213
		f 4 -376 -375 -394 -405
		mu 0 4 211 206 213 223
		f 4 394 395 -377 396
		mu 0 4 224 225 207 214
		f 4 -378 397 398 399
		mu 0 4 215 208 226 227
		f 4 402 -382 -416 417
		mu 0 4 228 209 216 235
		f 4 -383 -387 418 -417
		mu 0 4 217 203 219 236
		f 4 -390 -385 -420 420
		mu 0 4 221 210 218 237
		f 4 -386 -388 422 421
		mu 0 4 219 204 220 238
		f 4 -389 404 -409 423
		mu 0 4 220 211 223 230
		f 4 406 407 408 -393
		mu 0 4 222 229 230 223
		f 4 409 -395 410 411
		mu 0 4 231 225 224 232
		f 4 -399 412 413 414
		mu 0 4 227 226 233 234
		f 4 415 -401 -430 434
		mu 0 4 235 216 225 242
		f 4 -402 416 435 -432
		mu 0 4 226 217 236 243
		f 4 419 -404 -437 437
		mu 0 4 237 218 228 245
		f 4 -406 -421 424 -407
		mu 0 4 222 221 237 229
		f 4 425 426 427 -408
		mu 0 4 229 239 240 230
		f 4 428 429 -410 430
		mu 0 4 241 242 225 231
		f 4 -413 431 432 433
		mu 0 4 233 226 243 244
		f 4 436 -418 -450 451
		mu 0 4 245 228 235 252
		f 4 -419 -422 452 -451
		mu 0 4 236 219 238 253
		f 4 -423 -424 -428 442
		mu 0 4 238 220 230 240
		f 4 -425 -438 438 -426
		mu 0 4 229 237 245 239
		f 4 439 440 441 -427
		mu 0 4 239 246 247 240
		f 4 443 -429 444 445
		mu 0 4 248 242 241 249
		f 4 -433 446 447 448
		mu 0 4 244 243 250 251
		f 4 449 -435 -460 464
		mu 0 4 252 235 242 257
		f 4 -436 450 465 -462
		mu 0 4 243 236 253 258
		f 4 -439 -452 453 -440
		mu 0 4 239 245 252 246
		f 4 454 455 456 -441
		mu 0 4 246 254 255 247
		f 4 -442 457 -453 -443
		mu 0 4 240 247 253 238
		f 4 458 459 -444 460
		mu 0 4 256 257 242 248
		f 4 -447 461 462 463
		mu 0 4 250 243 258 259
		f 4 -454 -465 466 -455
		mu 0 4 246 252 257 254
		f 4 467 -456 468 469
		mu 0 4 260 255 254 261
		f 4 -457 470 -466 -458
		mu 0 4 247 255 258 253
		f 3 471 -459 472
		mu 0 3 262 257 256
		f 4 -463 473 474 475
		mu 0 4 259 258 263 264
		f 4 476 -467 -472 477
		mu 0 4 265 254 257 262
		f 4 478 -468 479 480
		mu 0 4 266 255 260 267
		f 5 -469 -477 481 482 483
		mu 0 5 261 254 265 268 269
		f 5 -479 484 485 -474 -471
		mu 0 5 255 266 270 263 258
		f 4 487 486 491 492
		mu 0 4 273 271 272 276
		f 4 -488 488 495 494
		mu 0 4 271 273 274 278
		f 3 -487 489 490
		mu 0 3 272 271 275
		f 4 493 -489 -500 501
		mu 0 4 277 274 273 280
		f 3 496 -491 497
		mu 0 3 279 272 275
		f 3 -495 498 -490
		mu 0 3 271 278 275
		f 4 499 -493 507 508
		mu 0 4 280 273 276 285
		f 4 -492 -497 509 510
		mu 0 4 276 272 279 286
		f 4 -494 500 512 -503
		mu 0 4 274 277 281 282
		f 4 -496 502 514 -506
		mu 0 4 278 274 282 284
		f 3 503 -498 504
		mu 0 3 283 279 275
		f 3 505 506 -499
		mu 0 3 278 284 275
		f 4 511 -501 -514 525
		mu 0 4 287 281 277 288
		f 4 513 -502 -522 527
		mu 0 4 288 277 280 292
		f 3 515 -505 516
		mu 0 3 289 283 275
		f 4 -504 517 518 -510
		mu 0 4 279 283 290 286
		f 3 519 520 -507
		mu 0 3 284 291 275
		f 4 521 -509 536 537
		mu 0 4 292 280 285 300
		f 4 -511 522 523 -508
		mu 0 4 276 286 293 285
		f 4 -512 524 539 -527
		mu 0 4 281 287 294 295
		f 4 -513 526 541 -529
		mu 0 4 282 281 295 296
		f 4 -515 528 533 -520
		mu 0 4 284 282 296 291
		f 3 529 -517 530
		mu 0 3 297 289 275
		f 4 -518 -516 -546 546
		mu 0 4 290 283 289 305
		f 4 -519 531 532 -523
		mu 0 4 286 290 298 293
		f 3 534 535 -521
		mu 0 3 291 299 275
		f 4 -537 -524 -548 553
		mu 0 4 300 285 293 306
		f 4 538 -525 -541 555
		mu 0 4 301 294 287 302
		f 4 540 -526 -543 559
		mu 0 4 302 287 288 303
		f 4 542 -528 -553 560
		mu 0 4 303 288 292 309
		f 3 543 -531 544
		mu 0 3 304 297 275
		f 4 545 -530 -566 566
		mu 0 4 305 289 297 315
		f 4 -532 -547 567 568
		mu 0 4 298 290 305 316
		f 4 547 -533 569 570
		mu 0 4 306 293 298 317
		f 4 -534 548 549 -535
		mu 0 4 291 296 307 299
		f 3 550 551 -536
		mu 0 3 299 308 275
		f 4 552 -538 575 576
		mu 0 4 309 292 300 319
		f 4 -539 554 581 -558
		mu 0 4 294 301 310 312
		f 4 556 -540 557 558
		mu 0 4 311 295 294 312
		f 4 -542 -557 571 -549
		mu 0 4 296 295 311 307
		f 3 561 -545 562
		mu 0 3 313 304 275
		f 4 -544 563 564 565
		mu 0 4 297 304 314 315
		f 4 -550 572 573 -551
		mu 0 4 299 307 318 308
		f 3 574 -563 -552
		mu 0 3 308 313 275
		f 4 -576 -554 -593 600
		mu 0 4 319 300 306 346
		f 10 -555 577 -246 -232 -214 -235 -250 578 579 580
		mu 0 10 320 321 322 323 324 325 326 327 328 329
		f 8 -556 582 -307 -294 -280 -266 -247 -578
		mu 0 8 321 330 331 332 333 334 335 322
		f 4 -559 583 607 -594
		mu 0 4 311 312 336 347
		f 7 -560 584 585 -323 -315 -308 -583
		mu 0 7 330 337 338 339 340 341 331
		f 4 -561 586 587 -585
		mu 0 4 337 342 343 338
		f 4 -564 -562 -597 611
		mu 0 4 314 304 313 348
		f 4 -565 588 589 590
		mu 0 4 315 314 344 345
		f 4 -567 -591 591 -568
		mu 0 4 305 315 345 316
		f 4 -570 -569 -618 618
		mu 0 4 317 298 316 379
		f 4 592 -571 619 620
		mu 0 4 346 306 317 380
		f 4 -573 -572 593 594
		mu 0 4 318 307 311 347
		f 4 -574 595 596 -575
		mu 0 4 308 318 348 313
		f 10 -577 597 -411 -397 -379 -400 -415 598 599 -587
		mu 0 10 349 350 351 352 353 354 355 356 357 358
		f 4 601 -581 602 603
		mu 0 4 359 320 329 360
		f 7 604 -579 -249 -269 -282 -297 -313
		mu 0 7 361 328 327 362 363 364 365
		f 4 605 -580 -634 634
		mu 0 4 368 366 367 403
		f 4 -584 -582 -602 606
		mu 0 4 336 312 310 369
		f 3 -586 608 -324
		mu 0 3 370 371 372
		f 4 -588 609 -326 610
		mu 0 4 371 373 374 375
		f 4 -612 612 613 -589
		mu 0 4 314 348 376 344
		f 4 -590 614 615 616
		mu 0 4 345 344 377 378
		f 4 617 -592 -617 638
		mu 0 4 379 316 345 378
		f 4 -595 621 -613 -596
		mu 0 4 318 347 376 348
		f 6 -601 622 -445 -431 -412 -598
		mu 0 6 350 381 382 383 384 351
		f 6 623 624 -599 -414 -434 -449
		mu 0 6 385 386 357 356 387 388
		f 4 625 -600 -646 646
		mu 0 4 390 373 389 424
		f 6 626 -604 627 -158 -151 628
		mu 0 6 391 359 360 392 393 394
		f 9 -603 -606 629 630 -154 -153 -141 -161 631
		mu 0 9 395 366 368 396 397 398 399 400 401
		f 4 632 633 -605 -312
		mu 0 4 402 403 367 404
		f 4 -607 -627 658 -636
		mu 0 4 336 369 405 406
		f 4 -608 635 643 -622
		mu 0 4 347 336 406 376
		f 3 -609 -611 -325
		mu 0 3 372 371 375
		f 8 636 -318 -317 -304 -327 -610 -626 637
		mu 0 8 407 408 409 410 411 374 373 390
		f 4 -615 -614 -644 661
		mu 0 4 377 344 376 406
		f 4 639 -616 663 664
		mu 0 4 412 378 377 442
		f 4 -619 640 641 -620
		mu 0 4 317 379 413 380
		f 8 -621 642 -482 -478 -473 -461 -446 -623
		mu 0 8 381 414 415 416 417 418 419 382
		f 5 644 -624 -448 -464 -476
		mu 0 5 420 386 385 421 422
		f 4 645 -625 -669 669
		mu 0 4 424 389 423 449
		f 8 647 -629 -150 -144 -131 -117 -102 648
		mu 0 8 425 391 394 426 427 428 429 430
		f 3 -628 649 -159
		mu 0 3 431 395 432
		f 3 -650 -632 -160
		mu 0 3 432 395 401
		f 4 650 -630 -658 675
		mu 0 4 433 396 368 439
		f 4 651 -155 -631 652
		mu 0 4 434 435 397 396
		f 4 653 654 -633 -311
		mu 0 4 436 437 403 402
		f 4 -635 655 656 657
		mu 0 4 368 403 438 439
		f 4 659 -638 -671 681
		mu 0 4 440 407 390 450
		f 3 -637 660 -319
		mu 0 3 408 407 441
		f 4 -641 -639 -640 662
		mu 0 4 413 379 378 412
		f 5 -643 -642 665 666 -483
		mu 0 5 415 414 443 444 445
		f 5 -645 -475 -486 667 668
		mu 0 5 423 446 447 448 449
		f 4 670 -647 -689 689
		mu 0 4 450 390 424 477
		f 12 -665 -649 -101 -83 -69 -51 -72 -85 -105 671 672 673
		mu 0 12 451 425 430 452 453 454 455 456 457 458 459 460
		f 4 -659 -648 -664 -662
		mu 0 4 406 405 442 377
		f 4 -651 674 676 -653
		mu 0 4 396 433 461 434
		f 4 -652 677 -162 -156
		mu 0 4 435 434 462 463
		f 5 678 -654 -310 -328 -321
		mu 0 5 464 437 436 465 466
		f 4 -656 -655 699 700
		mu 0 4 438 403 437 468
		f 4 679 -657 701 702
		mu 0 4 467 439 438 491
		f 4 -660 680 -700 -683
		mu 0 4 407 440 468 437
		f 4 -679 -320 -661 682
		mu 0 4 437 464 441 407
		f 4 -663 -674 683 -666
		mu 0 4 443 451 460 444
		f 7 -667 684 685 686 -480 -470 -484
		mu 0 7 469 470 471 472 473 474 475
		f 5 -668 -485 -481 -687 687
		mu 0 5 449 448 476 473 472
		f 4 688 -670 -708 708
		mu 0 4 477 424 449 495
		f 6 690 -672 -104 -119 -134 -148
		mu 0 6 478 459 458 479 480 481
		f 4 691 -673 -711 712
		mu 0 4 484 482 483 487
		f 4 692 -675 -695 715
		mu 0 4 485 461 433 486
		f 4 -676 -680 693 694
		mu 0 4 433 439 467 486
		f 4 695 -677 696 697
		mu 0 4 487 434 461 488
		f 5 698 -146 -163 -678 -696
		mu 0 5 487 489 490 462 434
		f 4 703 -681 -705 723
		mu 0 4 492 468 440 493
		f 4 704 -682 -710 724
		mu 0 4 493 440 450 496
		f 4 -685 -684 -692 711
		mu 0 4 471 470 482 484
		f 4 705 -686 725 726
		mu 0 4 494 472 471 503
		f 4 -688 -706 706 707
		mu 0 4 449 472 494 495
		f 4 709 -690 -732 732
		mu 0 4 496 450 477 506
		f 4 -699 710 -691 -147
		mu 0 4 489 487 483 497
		f 4 -697 -693 713 714
		mu 0 4 488 461 485 498
		f 4 716 -694 -722 739
		mu 0 4 499 486 467 502
		f 4 -713 -698 717 718
		mu 0 4 484 487 488 500
		f 4 -702 -701 -704 722
		mu 0 4 491 438 468 492
		f 4 -703 719 720 721
		mu 0 4 467 491 501 502
		f 4 -707 727 728 729
		mu 0 4 495 494 504 505
		f 4 -709 -730 730 731
		mu 0 4 477 495 505 506
		f 4 -712 -719 733 -726
		mu 0 4 471 484 500 503
		f 4 -718 -715 734 735
		mu 0 4 500 488 498 507
		f 4 736 -714 -738 754
		mu 0 4 508 498 485 509
		f 4 737 -716 -717 738
		mu 0 4 509 485 486 499
		f 4 -720 -723 -743 757
		mu 0 4 501 491 492 511
		f 3 -721 740 741
		mu 0 3 502 501 510
		f 4 742 -724 -744 759
		mu 0 4 511 492 493 512
		f 4 743 -725 -750 760
		mu 0 4 512 493 496 516
		f 4 -728 -727 -752 761
		mu 0 4 504 494 503 517
		f 4 -729 744 745 746
		mu 0 4 505 504 513 514
		f 4 -731 -747 747 748
		mu 0 4 506 505 514 515
		f 4 749 -733 -749 766
		mu 0 4 516 496 506 515
		f 4 -734 -736 750 751
		mu 0 4 503 500 507 517
		f 4 -735 -737 752 753
		mu 0 4 507 498 508 518
		f 3 -739 755 756
		mu 0 3 509 499 510
		f 3 -740 -742 -756
		mu 0 3 499 502 510
		f 3 -758 758 -741
		mu 0 3 501 511 510
		f 4 -762 762 763 -745
		mu 0 4 504 517 519 513
		f 3 -746 764 765
		mu 0 3 514 513 510
		f 3 -748 -766 767
		mu 0 3 515 514 510
		f 4 -763 -751 -754 768
		mu 0 4 519 517 507 518
		f 3 -753 769 770
		mu 0 3 518 508 510
		f 3 -755 -757 -770
		mu 0 3 508 509 510
		f 3 -760 771 -759
		mu 0 3 511 512 510
		f 3 -761 772 -772
		mu 0 3 512 516 510
		f 3 -764 773 -765
		mu 0 3 513 519 510
		f 3 -767 -768 -773
		mu 0 3 516 515 510
		f 3 -769 -771 -774
		mu 0 3 519 518 510;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".dr" 1;
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode transform -n "pCylinder1" -p "motor";
	rename -uid "6723BAEA-40D8-7C08-9A41-B29D8BA35834";
	setAttr ".t" -type "double3" 0 1.3590625787559336 0.87561035744751192 ;
	setAttr ".s" -type "double3" 0.15004375327696107 1.4759449670115683 0.19836646252039283 ;
createNode mesh -n "pCylinderShape1" -p "pCylinder1";
	rename -uid "52F40F8C-4678-D7E1-5B7C-7AA7610B452F";
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
	setAttr ".pv" -type "double2" 0.49999998509883881 0.78156328201293945 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 82 ".pt[0:81]" -type "float3"  0.46086079 0.1902052 0.11086923 
		0.40090781 0.21429278 0.0806036 0.30752879 0.23340875 0.056584835 0.18986411 0.24568203 
		0.041163713 0.059431806 0.24991107 0.035849944 -0.071000539 0.24568203 0.041163713 
		-0.188665 0.23340875 0.056584805 -0.28204459 0.21429278 0.0806036 -0.34199715 0.1902052 
		0.11086917 -0.36265612 0.16350397 0.14441887 -0.34199715 0.13680272 0.17796841 -0.28204459 
		0.11271518 0.20823404 -0.18866488 0.093599185 0.23225287 -0.071000658 0.081325963 
		0.24767384 0.059431836 0.077096879 0.25298777 0.18986408 0.081325978 0.24767384 0.30752838 
		0.093599185 0.23225293 0.40090764 0.11271518 0.2082341 0.46086067 0.13680272 0.17796841 
		0.48151934 0.16350397 0.14441887 -0.57858145 5.5511151e-017 0.90003973 -0.49217081 
		5.5511151e-017 1.0051329 -0.35758302 5.5511151e-017 1.0885354 -0.18799256 5.5511151e-017 
		1.1420828 -7.2521694e-008 5.5511151e-017 1.160534 0.18799239 5.5511151e-017 1.1420828 
		0.35758278 5.5511151e-017 1.0885353 0.49217045 5.5511151e-017 1.0051328 0.57858109 
		5.5511151e-017 0.90003967 0.60835618 5.5511151e-017 0.78354299 0.57858109 5.5511151e-017 
		0.66704631 0.49217045 5.5511151e-017 0.56195313 0.35758272 5.5511151e-017 0.47855067 
		0.18799233 5.5511151e-017 0.42500308 -5.4391272e-008 5.5511151e-017 0.40655181 -0.18799242 
		5.5511151e-017 0.42500308 -0.35758278 5.5511151e-017 0.4785507 -0.49217045 5.5511151e-017 
		0.56195313 -0.57858109 5.5511151e-017 0.66704637 -0.60835618 5.5511151e-017 0.78354299 
		-0.57858145 0 0.97403979 -0.49217081 0 1.079133 -0.35758302 0 1.1625355 -0.18799256 
		0 1.216083 -7.2521694e-008 0 1.2345343 0.18799239 0 1.2160829 0.35758278 0 1.1625354 
		0.49217045 0 1.0791329 0.57858109 0 0.97403967 0.60835618 0 0.85754287 0.57858109 
		0 0.74104619 0.49217045 0 0.63595301 0.35758272 0 0.55255055 0.18799233 0 0.49900281 
		-5.4391272e-008 0 0.4805516 -0.18799242 0 0.49900287 -0.35758278 0 0.55255055 -0.49217045 
		0 0.63595301 -0.57858109 0 0.74104619 -0.60835618 0 0.85754287 -0.57858145 0 0.87129188 
		-0.49217081 0 0.97638535 -0.35758302 0 1.0597878 -0.18799256 0 1.1133353 -7.2521694e-008 
		0 1.1317865 0.18799239 0 1.1133351 0.35758278 0 1.0597876 0.49217045 0 0.97638512 
		0.57858109 0 0.87129176 0.60835618 0 0.75479519 0.57858109 0 0.63829845 0.49217045 
		0 0.53320527 0.35758272 0 0.44980276 0.18799233 0 0.3962552 -5.4391272e-008 0 0.37780398 
		-0.18799242 0 0.39625525 -0.35758278 0 0.44980276 -0.49217045 0 0.53320527 -0.57858109 
		0 0.63829845 -0.60835618 0 0.75479519 0.059431806 0.16350397 0.14441887 -7.2521694e-008 
		0 0.75479519;
	setAttr ".dr" 1;
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode transform -n "pCylinder2" -p "motor";
	rename -uid "B8909B29-402D-996C-EEAE-CFACD423D449";
	setAttr ".t" -type "double3" 0 -2.4651903288156619e-032 0.68047982318516143 ;
	setAttr ".r" -type "double3" 90 0 0 ;
	setAttr ".s" -type "double3" 0.39591021251410058 0.02808409866132593 0.39591021251410058 ;
createNode mesh -n "pCylinderShape2" -p "pCylinder2";
	rename -uid "7179191E-4B8B-1883-0D6C-AEB2179EC84F";
	setAttr -k off ".v";
	setAttr -s 2 ".iog";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "propellerTankCam";
	rename -uid "E0B2CFD0-4B1E-E5A8-454D-F38A47CCE7F9";
	setAttr ".t" -type "double3" -21.381413054095834 7.3934421664442223 -0.85464356841302913 ;
	setAttr ".r" -type "double3" -15.938352729597437 -90.999999999999375 7.6333312355124402e-014 ;
createNode camera -n "propellerTankCamShape" -p "propellerTankCam";
	rename -uid "C2490490-4EAB-944D-F38A-F58A590D2316";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 23.342546716267105;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "C6A80819-47EE-25D0-EDEC-1F8D3D5C7E62";
	setAttr -s 5 ".lnk";
	setAttr -s 5 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "3E817A55-4FEA-16CB-2894-C49D2305EBFF";
createNode displayLayer -n "defaultLayer";
	rename -uid "4CAC69B6-452B-451F-9D03-D7A0FF3811ED";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "23C950C1-4C8A-B564-1EAE-42ADD22905E7";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "4BE74392-436B-F7C1-4966-A19F652CEFBA";
	setAttr ".g" yes;
createNode mentalrayItemsList -s -n "mentalrayItemsList";
	rename -uid "39EE13BB-42AC-F1BF-4BEF-1C8C673E7B0C";
createNode mentalrayGlobals -s -n "mentalrayGlobals";
	rename -uid "462ACE35-42A3-C28C-9AFB-94B763AD1089";
createNode mentalrayOptions -s -n "miDefaultOptions";
	rename -uid "7417DD1C-4052-935B-F2A5-1DB70C3D4EB8";
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
	rename -uid "AD8BD85E-4239-F8BE-61D3-FFBCF86A0031";
createNode groupId -n "groupId1";
	rename -uid "991CC9D5-4FC1-3C3B-CDD9-9C95EE1FC0A7";
	setAttr ".ihi" 0;
createNode blinn -n "blinn1";
	rename -uid "F7C95790-4093-7902-F5B7-66BD64050447";
createNode shadingEngine -n "blinn1SG";
	rename -uid "55683A45-4C05-2F7F-9CF6-A88A5892C6B4";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
	rename -uid "A40B6DEB-473D-8793-442D-A19A8603E6CC";
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "D529DD82-4F30-C898-3EA9-38BF92A11E4C";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 120 -ast 1 -aet 200 ";
	setAttr ".st" 6;
createNode groupId -n "groupId11";
	rename -uid "A93BBCD3-4ADA-0141-E279-AB9DA69E582E";
	setAttr ".ihi" 0;
createNode polyPipe -n "polyPipe1";
	rename -uid "B4C4B1CF-4F3A-6182-CBD8-A99CD97FDA5E";
	setAttr ".sa" 35;
	setAttr ".sc" 0;
createNode polyExtrudeFace -n "polyExtrudeFace1";
	rename -uid "7A7C412B-41FD-CABB-878D-36955CAFABD7";
	setAttr ".ics" -type "componentList" 1 "f[0:139]";
	setAttr ".ix" -type "matrix" 9.1345215399064745 0 0 0 0 7.6153893456195103 0 0 0 0 9.1345215399064745 0
		 6.6484899683103365 1.4134702627665705 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" 6.6668773 1.4134703 -1.3611498e-006 ;
	setAttr ".rs" 39411;
	setAttr ".lt" -type "double3" 0 0 0.78 ;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -2.4492565713284264 -2.3942244100431846 -9.1253223452404306 ;
	setAttr ".cbx" -type "double3" 15.783011508216811 5.2211649355763257 9.1253196229408733 ;
createNode bifrostLiquidMaterial -n "bifrostLiquidMaterial1";
	rename -uid "2216BE84-4FB4-A518-E53B-DC878C16EFB9";
	setAttr -s 2 ".dcrm";
	setAttr ".dcrm[0].dcrmp" 0;
	setAttr ".dcrm[0].dcrmcv" -type "float3" 0 0 0 ;
	setAttr ".dcrm[0].dcrmi" 1;
	setAttr ".dcrm[1].dcrmp" 1;
	setAttr ".dcrm[1].dcrmcv" -type "float3" 1 1 1 ;
	setAttr ".dcrm[1].dcrmi" 1;
	setAttr -s 2 ".dcvrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".fcvrm[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".rlcrm";
	setAttr ".rlcrm[0].rlcrmp" 0;
	setAttr ".rlcrm[0].rlcrmcv" -type "float3" 0 0 0 ;
	setAttr ".rlcrm[0].rlcrmi" 1;
	setAttr ".rlcrm[1].rlcrmp" 1;
	setAttr ".rlcrm[1].rlcrmcv" -type "float3" 1 1 1 ;
	setAttr ".rlcrm[1].rlcrmi" 1;
	setAttr -s 2 ".rlcvrm[0:1]"  0 0 1 1 1 1;
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
	rename -uid "B295D996-4FE5-13CA-82F3-9797EB823CD3";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode mib_data_string -n "bifrostMeshMRUserData1";
	rename -uid "89527C6F-47FA-0A3F-EE6E-A59DA865715D";
	setAttr ".nam" -type "string" "bifrostMeshObject";
createNode createColorSet -n "createColorSet1";
	rename -uid "56D6FF55-431F-A065-434D-768DC121C230";
	setAttr ".colos" -type "string" "bifrostLiquidDensity";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode createColorSet -n "createColorSet2";
	rename -uid "FD53F9CC-4B5A-FAD6-5C78-14AE3201E15A";
	setAttr ".colos" -type "string" "bifrostLiquidExpansionRate";
	setAttr ".clam" no;
	setAttr ".rprt" 3;
createNode expression -n "expression1";
	rename -uid "8C8E24C4-4B10-9973-C32E-E29815D93AC6";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * -300";
createNode unitConversion -n "unitConversion1";
	rename -uid "1A92E9E9-4055-C575-21D9-0C9408A671FD";
	setAttr ".cf" 0.017453292519943295;
createNode polyCylinder -n "polyCylinder1";
	rename -uid "821F11F0-4B4A-A982-B042-A2A7859103C7";
	setAttr ".sh" 3;
	setAttr ".sc" 1;
	setAttr ".cuv" 3;
createNode polyCylinder -n "polyCylinder2";
	rename -uid "5B59536C-428C-D346-C185-3395C6B57746";
	setAttr ".sc" 1;
	setAttr ".cuv" 3;
createNode lambert -n "lambert2";
	rename -uid "C59BD67E-4B20-03B9-9C59-8EAC76888748";
	setAttr ".c" -type "float3" 0 0 0 ;
createNode shadingEngine -n "lambert2SG";
	rename -uid "6450C213-432C-3685-3CF5-1990C2143BA4";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
	rename -uid "32C0E906-4529-A05B-ABA5-4AA1B4A91079";
createNode bifrostAttrNotifier -n "pCylinderShape1AttrNotif";
	rename -uid "FABFAAD3-4998-3067-77FC-7AA4A50EA72F";
	addAttr -ci true -sn "bifrostColliderEnable" -ln "bifrostColliderEnable" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -ci true -sn "bifrostColliderThickness" -ln "bifrostColliderThickness" -dv 
		1 -at "double";
	addAttr -ci true -sn "bifrostColliderMode" -ln "bifrostColliderMode" -min 0 -max 
		1 -en "Solid:Shell" -at "enum";
	setAttr -k on ".bifrostColliderEnable";
	setAttr -k on ".bifrostColliderThickness";
	setAttr -k on ".bifrostColliderMode";
createNode script -n "uiConfigurationScriptNode";
	rename -uid "025D2815-437F-75D6-D434-75A1BF2DC80D";
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
		+ "            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"propellerTankCam\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n"
		+ "                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -rendererName \"vp2Renderer\" \n                -objectFilterShowInHUD 1\n"
		+ "                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n"
		+ "                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 1416\n                -height 851\n                -sceneRenderFilter 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"propellerTankCam\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n"
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
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"propellerTankCam\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1416\\n    -height 851\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"propellerTankCam\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1416\\n    -height 851\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode nodeGraphEditorInfo -n "hyperShadePrimaryNodeEditorSavedTabsInfo";
	rename -uid "4DCB1B22-435E-B3E8-08E1-CABD349415C2";
	setAttr ".pee" yes;
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" 0 -30.95237972244389 ;
	setAttr ".tgi[0].vh" -type "double2" 114.28570974440821 0 ;
	setAttr -s 40 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[0].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[0].nvs" 1922;
	setAttr ".tgi[0].ni[1].x" 32.857143402099609;
	setAttr ".tgi[0].ni[1].y" -7650;
	setAttr ".tgi[0].ni[1].nvs" 1923;
	setAttr ".tgi[0].ni[2].x" 1240;
	setAttr ".tgi[0].ni[2].y" -882.85711669921875;
	setAttr ".tgi[0].ni[2].nvs" 3058;
	setAttr ".tgi[0].ni[3].x" 32.857143402099609;
	setAttr ".tgi[0].ni[3].y" -7167.14306640625;
	setAttr ".tgi[0].ni[3].nvs" 1923;
	setAttr ".tgi[0].ni[4].x" 1602.857177734375;
	setAttr ".tgi[0].ni[4].y" -1152.857177734375;
	setAttr ".tgi[0].ni[4].nvs" 3122;
	setAttr ".tgi[0].ni[5].x" 1972.857177734375;
	setAttr ".tgi[0].ni[5].y" -2327.142822265625;
	setAttr ".tgi[0].ni[5].nvs" 1923;
	setAttr ".tgi[0].ni[6].x" 1972.857177734375;
	setAttr ".tgi[0].ni[6].y" -1585.7142333984375;
	setAttr ".tgi[0].ni[6].nvs" 1922;
	setAttr ".tgi[0].ni[7].x" 32.857143402099609;
	setAttr ".tgi[0].ni[7].y" -6680;
	setAttr ".tgi[0].ni[7].nvs" 1923;
	setAttr ".tgi[0].ni[8].x" 32.857143402099609;
	setAttr ".tgi[0].ni[8].y" -6192.85693359375;
	setAttr ".tgi[0].ni[8].nvs" 1923;
	setAttr ".tgi[0].ni[9].x" 891.4285888671875;
	setAttr ".tgi[0].ni[9].y" -1538.5714111328125;
	setAttr ".tgi[0].ni[9].nvs" 2706;
	setAttr ".tgi[0].ni[10].x" 32.857143402099609;
	setAttr ".tgi[0].ni[10].y" -5705.71435546875;
	setAttr ".tgi[0].ni[10].nvs" 1923;
	setAttr ".tgi[0].ni[11].x" 921.4285888671875;
	setAttr ".tgi[0].ni[11].y" -768.5714111328125;
	setAttr ".tgi[0].ni[11].nvs" 2034;
	setAttr ".tgi[0].ni[12].x" 927.14288330078125;
	setAttr ".tgi[0].ni[12].y" -24.285715103149414;
	setAttr ".tgi[0].ni[12].nvs" 1922;
	setAttr ".tgi[0].ni[13].x" 287.14285278320312;
	setAttr ".tgi[0].ni[13].y" -8141.4287109375;
	setAttr ".tgi[0].ni[13].nvs" 1923;
	setAttr ".tgi[0].ni[14].x" 524.28570556640625;
	setAttr ".tgi[0].ni[14].y" -4760;
	setAttr ".tgi[0].ni[14].nvs" 1923;
	setAttr ".tgi[0].ni[15].x" 921.4285888671875;
	setAttr ".tgi[0].ni[15].y" -2695.71435546875;
	setAttr ".tgi[0].ni[15].nvs" 2034;
	setAttr ".tgi[0].ni[16].x" 32.857143402099609;
	setAttr ".tgi[0].ni[16].y" -5214.28564453125;
	setAttr ".tgi[0].ni[16].nvs" 1923;
	setAttr ".tgi[0].ni[17].x" 620;
	setAttr ".tgi[0].ni[17].y" -2172.857177734375;
	setAttr ".tgi[0].ni[17].nvs" 2034;
	setAttr ".tgi[0].ni[18].x" 287.14285278320312;
	setAttr ".tgi[0].ni[18].y" -7650;
	setAttr ".tgi[0].ni[18].nvs" 1923;
	setAttr ".tgi[0].ni[19].x" 304.28570556640625;
	setAttr ".tgi[0].ni[19].y" -3680;
	setAttr ".tgi[0].ni[19].nvs" 1922;
	setAttr ".tgi[0].ni[20].x" 287.14285278320312;
	setAttr ".tgi[0].ni[20].y" -7167.14306640625;
	setAttr ".tgi[0].ni[20].nvs" 1923;
	setAttr ".tgi[0].ni[21].x" 287.14285278320312;
	setAttr ".tgi[0].ni[21].y" -6544.28564453125;
	setAttr ".tgi[0].ni[21].nvs" 1922;
	setAttr ".tgi[0].ni[22].x" 861.4285888671875;
	setAttr ".tgi[0].ni[22].y" -4532.85693359375;
	setAttr ".tgi[0].ni[22].nvs" 1923;
	setAttr ".tgi[0].ni[23].x" 1122.857177734375;
	setAttr ".tgi[0].ni[23].y" -4650;
	setAttr ".tgi[0].ni[23].nvs" 1923;
	setAttr ".tgi[0].ni[24].x" 277.14285278320312;
	setAttr ".tgi[0].ni[24].y" -6237.14306640625;
	setAttr ".tgi[0].ni[24].nvs" 1922;
	setAttr ".tgi[0].ni[25].x" 98.571426391601563;
	setAttr ".tgi[0].ni[25].y" -1774.2857666015625;
	setAttr ".tgi[0].ni[25].nvs" 1922;
	setAttr ".tgi[0].ni[26].x" 1291.4285888671875;
	setAttr ".tgi[0].ni[26].y" -1.4285714626312256;
	setAttr ".tgi[0].ni[26].nvs" 1922;
	setAttr ".tgi[0].ni[27].x" 1972.857177734375;
	setAttr ".tgi[0].ni[27].y" -1212.857177734375;
	setAttr ".tgi[0].ni[27].nvs" 1923;
	setAttr ".tgi[0].ni[28].x" 2234.28564453125;
	setAttr ".tgi[0].ni[28].y" -1405.7142333984375;
	setAttr ".tgi[0].ni[28].nvs" 1923;
	setAttr ".tgi[0].ni[29].x" 1657.142822265625;
	setAttr ".tgi[0].ni[29].y" -2338.571533203125;
	setAttr ".tgi[0].ni[29].nvs" 1922;
	setAttr ".tgi[0].ni[30].x" 360;
	setAttr ".tgi[0].ni[30].y" -1797.142822265625;
	setAttr ".tgi[0].ni[30].nvs" 1922;
	setAttr ".tgi[0].ni[31].x" 625.71429443359375;
	setAttr ".tgi[0].ni[31].y" -1792.857177734375;
	setAttr ".tgi[0].ni[31].nvs" 1922;
	setAttr ".tgi[0].ni[32].x" 1.4285714626312256;
	setAttr ".tgi[0].ni[32].y" -4782.85693359375;
	setAttr ".tgi[0].ni[32].nvs" 1922;
	setAttr ".tgi[0].ni[33].x" 262.85714721679687;
	setAttr ".tgi[0].ni[33].y" -4782.85693359375;
	setAttr ".tgi[0].ni[33].nvs" 1923;
	setAttr ".tgi[0].ni[34].x" 360;
	setAttr ".tgi[0].ni[34].y" -2364.28564453125;
	setAttr ".tgi[0].ni[34].nvs" 1922;
	setAttr ".tgi[0].ni[35].x" 42.857143402099609;
	setAttr ".tgi[0].ni[35].y" -3837.142822265625;
	setAttr ".tgi[0].ni[35].nvs" 1922;
	setAttr ".tgi[0].ni[36].x" 304.28570556640625;
	setAttr ".tgi[0].ni[36].y" -4342.85693359375;
	setAttr ".tgi[0].ni[36].nvs" 1923;
	setAttr ".tgi[0].ni[37].x" 565.71429443359375;
	setAttr ".tgi[0].ni[37].y" -4141.4287109375;
	setAttr ".tgi[0].ni[37].nvs" 1923;
	setAttr ".tgi[0].ni[38].x" 921.4285888671875;
	setAttr ".tgi[0].ni[38].y" -2380;
	setAttr ".tgi[0].ni[38].nvs" 2034;
	setAttr ".tgi[0].ni[39].x" 287.14285278320312;
	setAttr ".tgi[0].ni[39].y" -5750;
	setAttr ".tgi[0].ni[39].nvs" 1922;
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
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 7 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
select -ne :defaultRenderingList1;
select -ne :initialShadingGroup;
	setAttr -s 5 ".dsm";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
connectAttr ":time1.o" "bifrostLiquidContainer.ctm";
connectAttr "liquidEmitterPipeShape1.w" "bifrostLiquidContainer.Emitters[0]";
connectAttr "nurbsToPoly5Shape.w" "bifrostLiquidContainer.Colliders[0]";
connectAttr "colliderPipeShape1.w" "bifrostLiquidContainer.Colliders[1]";
connectAttr "pCylinderShape1AttrNotif.om" "bifrostLiquidContainer.Colliders[2]";
connectAttr "bifrostLiquidContainer.Liquid" "bifrostShape1.obj";
connectAttr "bifrostMeshMRUserData1.msg" "bifrostMesh1.miData";
connectAttr "bifrostShape1.mout" "bifrostMeshShape1.i";
connectAttr "createColorSet2.og" "liquidEmitterPipeShape1.i";
connectAttr "polyExtrudeFace1.out" "colliderPipeShape1.i";
connectAttr "unitConversion1.o" "nurbsToPoly5.rz";
connectAttr "groupId11.id" "nurbsToPoly5Shape.ciog.cog[0].cgid";
connectAttr "polyCylinder1.out" "pCylinderShape1.i";
connectAttr "polyCylinder2.out" "pCylinderShape2.i";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bifrostLiquidMaterial1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bifrostLiquidMaterial1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":mentalrayGlobals.msg" ":mentalrayItemsList.glb";
connectAttr ":miDefaultOptions.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayItemsList.fb" -na;
connectAttr ":miDefaultOptions.msg" ":mentalrayGlobals.opt";
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayGlobals.fb";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "blinn1SG.msg" "materialInfo1.sg";
connectAttr "blinn1.msg" "materialInfo1.m";
connectAttr "polySurfaceShape1.o" "polyExtrudeFace1.ip";
connectAttr "colliderPipeShape1.wm" "polyExtrudeFace1.mp";
connectAttr "bifrostLiquidMaterial1.oc" "bifrostLiquidMaterial1SG.ss";
connectAttr "bifrostShape1.iog" "bifrostLiquidMaterial1SG.dsm" -na;
connectAttr "bifrostMeshShape1.iog" "bifrostLiquidMaterial1SG.dsm" -na;
connectAttr "bifrostLiquidContainer.Liquid" "bifrostMeshMRUserData1.val";
connectAttr "polyPipe1.out" "createColorSet1.ig";
connectAttr "createColorSet1.og" "createColorSet2.ig";
connectAttr ":time1.o" "expression1.tim";
connectAttr "expression1.out[0]" "unitConversion1.i";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "pCylinderShape2.iog" "lambert2SG.dsm" -na;
connectAttr "lambert2SG.msg" "materialInfo2.sg";
connectAttr "lambert2.msg" "materialInfo2.m";
connectAttr "pCylinderShape1.bifrostColliderEnable" "pCylinderShape1AttrNotif.bifrostColliderEnable"
		;
connectAttr "pCylinderShape1.bifrostColliderThickness" "pCylinderShape1AttrNotif.bifrostColliderThickness"
		;
connectAttr "pCylinderShape1.bifrostColliderMode" "pCylinderShape1AttrNotif.bifrostColliderMode"
		;
connectAttr "pCylinderShape1.w" "pCylinderShape1AttrNotif.im";
connectAttr "defaultRenderLayer.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[0].dn"
		;
connectAttr "bifrostLiquid.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[1].dn"
		;
connectAttr "bifrostLiquidContainer.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "bifrost1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[3].dn"
		;
connectAttr "bifrostShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[4].dn"
		;
connectAttr "bifrostMesh1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[5].dn"
		;
connectAttr "bifrostMeshShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[6].dn"
		;
connectAttr "tank.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[7].dn"
		;
connectAttr "liquidEmitterPipe1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[8].dn"
		;
connectAttr "liquidEmitterPipeShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[9].dn"
		;
connectAttr "colliderPipe1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[10].dn"
		;
connectAttr "colliderPipeShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[11].dn"
		;
connectAttr "polySurfaceShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[12].dn"
		;
connectAttr "motor.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[13].dn"
		;
connectAttr "nurbsToPoly5.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[14].dn"
		;
connectAttr "nurbsToPoly5Shape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[15].dn"
		;
connectAttr "pCylinder1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[16].dn"
		;
connectAttr "pCylinderShape1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[17].dn"
		;
connectAttr "pCylinder2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[18].dn"
		;
connectAttr "pCylinderShape2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[19].dn"
		;
connectAttr "propellerTankCam.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[20].dn"
		;
connectAttr "propellerTankCamShape.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[21].dn"
		;
connectAttr "blinn1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[22].dn"
		;
connectAttr "blinn1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[23].dn"
		;
connectAttr "sceneConfigurationScriptNode.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[24].dn"
		;
connectAttr "polyPipe1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[25].dn"
		;
connectAttr "polyExtrudeFace1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[26].dn"
		;
connectAttr "bifrostLiquidMaterial1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[27].dn"
		;
connectAttr "bifrostLiquidMaterial1SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[28].dn"
		;
connectAttr "bifrostMeshMRUserData1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[29].dn"
		;
connectAttr "createColorSet1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[30].dn"
		;
connectAttr "createColorSet2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[31].dn"
		;
connectAttr "expression1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[32].dn"
		;
connectAttr "unitConversion1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[33].dn"
		;
connectAttr "polyCylinder1.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[34].dn"
		;
connectAttr "polyCylinder2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[35].dn"
		;
connectAttr "lambert2.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[36].dn"
		;
connectAttr "lambert2SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[37].dn"
		;
connectAttr "pCylinderShape1AttrNotif.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[38].dn"
		;
connectAttr "uiConfigurationScriptNode.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[39].dn"
		;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "bifrostLiquidMaterial1SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "bifrostLiquidMaterial1.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "bifrostMeshMRUserData1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "nurbsToPoly5Shape.iog" ":initialShadingGroup.dsm" -na;
connectAttr "nurbsToPoly5Shape.ciog.cog[0]" ":initialShadingGroup.dsm" -na;
connectAttr "liquidEmitterPipeShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "colliderPipeShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pCylinderShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr ":perspShape.msg" ":defaultRenderGlobals.sc";
// End of propellerTank.ma
