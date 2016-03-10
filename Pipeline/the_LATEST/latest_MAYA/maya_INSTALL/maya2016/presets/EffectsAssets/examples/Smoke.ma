//Maya ASCII 2011 scene
//Name: Smoke.ma
//Last modified: Fri, Jul 30, 2010 05:30:36 PM
//Codeset: 1252
requires maya "2011";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2011";
fileInfo "version" "2011";
fileInfo "cutIdentifier" "201007280519-779045";
fileInfo "osv" "Microsoft Windows XP Professional Service Pack 3 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0.70736874045192777 5.9134658416112469 -16.743483973353676 ;
	setAttr ".r" -type "double3" -18.93835272952504 -180.19999999999706 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999986;
	setAttr ".coi" 19.877990138742788;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
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
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
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
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "SmokeGroup";
createNode transform -n "fluid1" -p "SmokeGroup";
	addAttr -ci true -sn "SmokeTension" -ln "SmokeTension" -at "double";
	setAttr -k on ".SmokeTension" 5;
createNode fluidShape -n "fluidShape1" -p "fluid1";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".sqvx" yes;
	setAttr ".aure" yes;
	setAttr ".aurt" 0.05000000074505806;
	setAttr ".mres" 1000;
	setAttr ".bod" 5;
	setAttr ".ots" 0.5;
	setAttr ".bndy" 2;
	setAttr ".vsw" 2;
	setAttr ".tst" 0.5;
	setAttr ".tfr" 1;
	setAttr ".tbs" 5;
	setAttr ".ss" yes;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr -s 4 ".opa[0:3]"  0 0 1 1 1 1 0.30434781 0 1 0.66087002 
		0.46000001 1;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.80000001192092896;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 1.5 1 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 2;
createNode transform -n "Smoke_Control";
	addAttr -ci true -sn "SmokeResolution" -ln "SmokeResolution" -at "double";
	addAttr -ci true -sn "SmokeDensity" -ln "SmokeDensity" -at "double";
	addAttr -ci true -sn "SmokeEmitters" -ln "SmokeEmitters" -at "double";
	addAttr -ci true -sn "EmissionTurbulence" -ln "EmissionTurbulence" -at "double";
	addAttr -ci true -sn "SmokeStart" -ln "SmokeStart" -at "double";
	addAttr -ci true -sn "SmokeTransparency" -ln "SmokeTransparency" -min 0 -max 10 
		-at "double";
	addAttr -ci true -sn "SourceScale" -ln "SourceScale" -at "double";
	addAttr -ci true -sn "SmokeSelfShade" -ln "SmokeSelfShade" -min 0 -max 10 -at "double";
	addAttr -ci true -sn "SmokeType" -ln "SmokeType" -min 0 -max 1 -en "Wispy:Heavy" 
		-at "enum";
	addAttr -ci true -sn "SmokeFade" -ln "SmokeFade" -min 0 -max 10 -at "double";
	addAttr -ci true -sn "SmokeDetail" -ln "SmokeDetail" -at "double";
	addAttr -ci true -sn "SmokeDirection" -ln "SmokeDirection" -at "double3" -nc 3;
	addAttr -ci true -sn "SmokeDirectionX" -ln "SmokeDirectionX" -at "double" -p "SmokeDirection";
	addAttr -ci true -sn "SmokeDirectionY" -ln "SmokeDirectionY" -at "double" -p "SmokeDirection";
	addAttr -ci true -sn "SmokeDirectionZ" -ln "SmokeDirectionZ" -at "double" -p "SmokeDirection";
	addAttr -ci true -sn "SimulationRate" -ln "SimulationRate" -at "double";
	addAttr -ci true -sn "SmokeMass" -ln "SmokeMass" -at "double";
	addAttr -ci true -sn "SmokeTension" -ln "SmokeTension" -at "double";
	addAttr -ci true -sn "DirectionMultiplier" -ln "DirectionMultiplier" -min 1 -at "double";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -k on ".SmokeResolution" 30;
	setAttr -k on ".SmokeDensity" 0.5;
	setAttr -k on ".SmokeEmitters" 2.5;
	setAttr -k on ".EmissionTurbulence" 1;
	setAttr -k on ".SmokeStart" 100;
	setAttr -k on ".SmokeTransparency" 5;
	setAttr -k on ".SourceScale" 1;
	setAttr -k on ".SmokeSelfShade";
	setAttr -l on -k on ".SmokeType";
	setAttr -k on ".SmokeFade" 0.01;
	setAttr -l on -k on ".SmokeDetail";
	setAttr -k on ".SmokeDirection" -type "double3" 1 1 0 ;
	setAttr -k on ".SmokeDirection";
	setAttr -k on ".SmokeDirectionX";
	setAttr -k on ".SmokeDirectionY";
	setAttr -k on ".SmokeDirectionZ";
	setAttr -k on ".SimulationRate" 0.5;
	setAttr -k on ".SmokeMass" 0.01;
	setAttr -l on -k on ".SmokeTension";
	setAttr -k on ".DirectionMultiplier" 3;
createNode locator -n "Smoke_ControlShape" -p "Smoke_Control";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "Smoke_Control";
	setAttr ".t" -type "double3" 1.5 1.5 1.5 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Smoke Control";
	setAttr ".daro" no;
createNode uniformField -n "uniformField1";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
createNode transform -n "nurbsCircle1";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -0.026957781200763864 0.23304855755277543 0.0069763481726636822 ;
createNode nurbsCurve -n "nurbsCircleShape1" -p "nurbsCircle1";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode pointEmitter -n "ringEmission1" -p "nurbsCircle1";
	setAttr ".v" no;
	setAttr ".emt" 3;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".d" -type "double3" 0 1 0 ;
	setAttr ".afa" 0;
createNode transform -n "nParticle1";
	setAttr ".v" no;
createNode nParticle -n "nParticleShape1" -p "nParticle1";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -is true -ci true -sn "colorAccum" -ln "colorAccum" -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "useLighting" -ln "useLighting" -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "pointSize" -ln "pointSize" -dv 2 -min 1 -max 60 -at "long";
	addAttr -is true -ci true -sn "normalDir" -ln "normalDir" -dv 2 -min 1 -max 3 -at "long";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -s 2 ".xi";
	setAttr ".irbx" -type "string" "// Drives the emission of the fluid from nParticle based on speed-variable adjusted by uniform field magnitude\n\nfloat $jimmy;\n\n$jimmy = .I[0];\n\n\nif (.I[1] > 2*$jimmy) {\n\t.O[0] = 0;\n}\nelse\t{\n\t.O[0] = 1;\n}";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0.97;
	setAttr ".sd[0]"  5;
	setAttr ".cts" 1;
	setAttr ".chw" 500;
	setAttr ".cofl" 1;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".igsg" yes;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".rdc[0]"  0 1 1;
	setAttr ".rci" 1;
	setAttr ".mssc[0]"  0 1 1;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".opc[0]"  0 1 1;
	setAttr ".oci" 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 0 0.5 1 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".coi" 1;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
	setAttr -k on ".colorAccum";
	setAttr -k on ".useLighting";
	setAttr -k on ".pointSize";
	setAttr -k on ".normalDir";
createNode fluidEmitter -n "nEmission1" -p "nParticle1";
	setAttr ".emt" 2;
	setAttr -k off ".rat";
	setAttr -k off ".sro";
	setAttr -l on -k off ".urpp";
	setAttr -k off ".npuv";
	setAttr ".max" 1;
	setAttr -k off ".dx";
	setAttr -k off ".dy";
	setAttr -k off ".dz";
	setAttr -k off ".spr";
	setAttr -k off ".spd";
	setAttr -k off ".srnd";
	setAttr -k off ".tspd";
	setAttr -k off ".nspd";
	setAttr -k off ".afc";
	setAttr -k off ".afa";
	setAttr -k off ".alx";
	setAttr -k off ".arx";
	setAttr -k off ".rnd";
	setAttr -k off ".drs";
	setAttr -k off ".ssz";
	setAttr -k off ".dss";
	setAttr ".fdo" 1;
	setAttr ".trs" 1;
	setAttr ".fhe" 1;
	setAttr ".ffe" 1;
createNode container -n "SmokeAsset";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".isc" yes;
	setAttr -s 17 ".boc";
	setAttr ".ctor" -type "string" "";
	setAttr ".cdat" -type "string" "2010/06/11 13:10:28";
	setAttr ".ctyp" -type "string" "effects";
	setAttr ".aal" -type "attributeAlias" {"SmokeResolution","borderConnections[0]","SmokeDirectionX"
		,"borderConnections[10]","SmokeDirectionY","borderConnections[11]","SmokeDirectionZ"
		,"borderConnections[12]","SimulationRate","borderConnections[13]","SmokeMass","borderConnections[14]"
		,"DirectionMultiplier","borderConnections[15]","opacity","borderConnections[16]","SmokeDensity"
		,"borderConnections[1]","SmokeEmitters","borderConnections[2]","EmissionTurbulence"
		,"borderConnections[3]","SmokeStart","borderConnections[4]","SmokeTransparency","borderConnections[5]"
		,"SourceScale","borderConnections[6]","SmokeSelfShade","borderConnections[7]","SmokeFade"
		,"borderConnections[8]","SmokeDirection","borderConnections[9]","child","canBeChild[0]"
		,"nucleusSolver","publishedNodeInfo[0]"} ;
	setAttr ".nts" -type "string" "Fluids and nParticle effect- In this effect particles  emit into the fluid to generate the actual visible effect. Applying  the effect to an object in the scene parents the nParticle emitter \nto the object. ";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode makeNurbCircle -n "makeNurbCircle1";
	setAttr ".nr" -type "double3" 0 1 0 ;
	setAttr ".r" 0.28529878441122758;
createNode geoConnector -n "geoConnector1";
createNode nucleus -n "SmokeNucleus";
	setAttr ".sti" 100;
createNode shadingEngine -n "nParticleCloudSE";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode particleSamplerInfo -n "particleSamplerInfo1";
createNode blinn -n "npCloudBlinn";
createNode particleCloud -n "npCloudVolume";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 500 -ast 1 -aet 5000 ";
	setAttr ".st" 6;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 42 ".hyp";
createNode animCurveUU -n "fluidShape1_transparencyR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 10 1;
createNode animCurveUU -n "fluidShape1_transparencyG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 10 1;
createNode animCurveUU -n "fluidShape1_transparencyB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 10 1;
createNode expression -n "ScaleExpression";
	setAttr -k on ".nds";
	setAttr -s 3 ".out";
	setAttr ".ixp" -type "string" "// Determines scale of particle emitter curve\n.O[0] = .I[0];\n.O[1] = .O[0];\n.O[2] = .O[0];";
createNode expression -n "nParticleEmissionExpression";
	setAttr -k on ".nds";
	setAttr -s 3 ".in";
	setAttr -s 3 ".in";
	setAttr -s 3 ".out";
	setAttr ".ixp" -type "string" "// Base Res of container\n.O[0] = .I[0];\n\n// adjusts density\n.O[1] = .I[1];\n\n// determines the number of emitting nParticles\n.O[2] = .I[2]";
createNode expression -n "EmissionTurbulenceExpression";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "// fluid emission turbulence\n.O[0] = .I[0];";
createNode expression -n "StartExpression";
	setAttr -k on ".nds";
	setAttr -s 2 ".out";
	setAttr ".ixp" -type "string" "// Emission start and nucleus start frame\n.O[0] = .I[0];\n.O[1] = .I[0];";
createNode blendWeighted -n "blendWeighted1";
	setAttr -s 2 ".i";
	setAttr -s 2 ".i";
	setAttr ".c" 1;
createNode animCurveUU -n "animCurveUU1";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 -0.300000005031762 10 0.69999999496823806;
createNode blendWeighted -n "blendWeighted2";
	setAttr -s 2 ".i";
	setAttr -s 2 ".i";
	setAttr ".c" 1;
createNode animCurveUU -n "animCurveUU2";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 -0.300000005031762 10 0.69999999496823806;
createNode blendWeighted -n "blendWeighted3";
	setAttr -s 2 ".i";
	setAttr -s 2 ".i";
	setAttr ".c" 1;
createNode animCurveUU -n "animCurveUU3";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 -0.300000005031762 10 0.69999999496823806;
createNode animCurveUU -n "fluidShape1_shadowOpacity";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 10 1;
createNode expression -n "SimRateExpression";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "//Simulation Rate Scale \n.O[0] = .I[0];";
createNode expression -n "SmokeMassExpression";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "// Smoke Mass\n.O[0] = .I[0];";
createNode expression -n "SmokeTensionExpression";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "// Density tension as Channel\n.O[0] = .I[0];";
createNode expression -n "UNFExpression";
	setAttr -k on ".nds";
	setAttr -s 3 ".in";
	setAttr -s 3 ".in";
	setAttr -s 3 ".out";
	setAttr ".ixp" -type "string" "//Uniform field as channel\n.O[0] = .I[0];\n.O[1] = .I[1];\n.O[2] = .I[2];";
createNode expression -n "DirectionMultExpression";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "// Uses Magnitude as a multiplier on Direction and Fluid Emission \n.O[0] = .I[0];";
createNode expression -n "DissipateExpression";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "//Drives dissipation of Density\n.O[0] = .I[0];";
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 4 ".st";
	setAttr -k on ".an";
	setAttr -k on ".pt";
select -ne :initialShadingGroup;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -k on ".an";
	setAttr -k on ".il";
	setAttr -k on ".vo";
	setAttr -k on ".eo";
	setAttr -k on ".fo";
	setAttr -k on ".epo";
	setAttr ".ro" yes;
	setAttr -cb on ".mimt";
	setAttr -cb on ".miop";
	setAttr -cb on ".mise";
	setAttr -cb on ".mism";
	setAttr -cb on ".mice";
	setAttr -av -cb on ".micc";
	setAttr -cb on ".mica";
	setAttr -cb on ".micw";
	setAttr -cb on ".mirw";
select -ne :initialParticleSE;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -k on ".an";
	setAttr -k on ".il";
	setAttr -k on ".vo";
	setAttr -k on ".eo";
	setAttr -k on ".fo";
	setAttr -k on ".epo";
	setAttr ".ro" yes;
	setAttr -cb on ".mimt";
	setAttr -cb on ".miop";
	setAttr -cb on ".mise";
	setAttr -cb on ".mism";
	setAttr -cb on ".mice";
	setAttr -cb on ".micc";
	setAttr -cb on ".mica";
	setAttr -cb on ".micw";
	setAttr -cb on ".mirw";
select -ne :defaultShaderList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -k on ".mwc";
	setAttr -k on ".an";
	setAttr -k on ".il";
	setAttr -k on ".vo";
	setAttr -k on ".eo";
	setAttr -k on ".fo";
	setAttr -k on ".epo";
	setAttr -k on ".ro" yes;
select -ne :hardwareRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
	setAttr -k off -cb on ".ehql";
	setAttr -k off -cb on ".eams";
	setAttr -k off -cb on ".eeaa";
	setAttr -k off -cb on ".engm";
	setAttr -k off -cb on ".mes";
	setAttr -k off -cb on ".emb";
	setAttr -k off -cb on ".mbbf";
	setAttr -k off -cb on ".mbs";
	setAttr -k off -cb on ".trm";
	setAttr -k off -cb on ".tshc";
	setAttr -k off -cb on ".clmt";
	setAttr -k off -cb on ".tcov";
	setAttr -k off -cb on ".lith";
	setAttr -k off -cb on ".sobc";
	setAttr -k off -cb on ".cuth";
	setAttr -k off -cb on ".hgcd";
	setAttr -k off -cb on ".hgci";
	setAttr -k off -cb on ".mgcs";
	setAttr -k off -cb on ".twa";
	setAttr -k off -cb on ".twz";
	setAttr -k on ".hwcc";
	setAttr -k on ".hwdp";
	setAttr -k on ".hwql";
select -ne :defaultHardwareRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".rp";
	setAttr -k on ".cai";
	setAttr -k on ".coi";
	setAttr -cb on ".bc";
	setAttr -av -k on ".bcb";
	setAttr -av -k on ".bcg";
	setAttr -av -k on ".bcr";
	setAttr -k on ".ei";
	setAttr -k on ".ex";
	setAttr -av -k on ".es";
	setAttr -av -k on ".ef";
	setAttr -k on ".bf";
	setAttr -k on ".fii";
	setAttr -av -k on ".sf";
	setAttr -k on ".gr";
	setAttr -k on ".li";
	setAttr -k on ".ls";
	setAttr -k on ".mb";
	setAttr -k on ".ti";
	setAttr -k on ".txt";
	setAttr -k on ".mpr";
	setAttr -k on ".wzd";
	setAttr -k on ".fn" -type "string" "im";
	setAttr -k on ".if";
	setAttr -k on ".res" -type "string" "ntsc_4d 646 485 1.333";
	setAttr -k on ".as";
	setAttr -k on ".ds";
	setAttr -k on ".lm";
	setAttr -k on ".fir";
	setAttr -k on ".aap";
	setAttr -k on ".gh";
	setAttr -cb on ".sd";
connectAttr ":time1.o" "fluidShape1.cti";
connectAttr "nEmission1.ef" "fluidShape1.eml[0].emfr";
connectAttr "nEmission1.efc" "fluidShape1.fce[0]";
connectAttr "nParticleEmissionExpression.out[0]" "fluidShape1.bres";
connectAttr "nParticleEmissionExpression.out[1]" "fluidShape1.dsc";
connectAttr "StartExpression.out[0]" "fluidShape1.stf";
connectAttr "blendWeighted1.o" "fluidShape1.tr";
connectAttr "blendWeighted2.o" "fluidShape1.tg";
connectAttr "blendWeighted3.o" "fluidShape1.tb";
connectAttr "fluidShape1_shadowOpacity.o" "fluidShape1.shp";
connectAttr "SimRateExpression.out[0]" "fluidShape1.srs";
connectAttr "SmokeMassExpression.out[0]" "fluidShape1.vdp";
connectAttr "SmokeTensionExpression.out[0]" "fluidShape1.dstn";
connectAttr "DissipateExpression.out[0]" "fluidShape1.dds";
connectAttr "Smoke_ControlShape.wm" "annotationShape1.dom" -na;
connectAttr "DirectionMultExpression.out[0]" "uniformField1.mag";
connectAttr "nParticleShape1.fd" "uniformField1.ind[0]";
connectAttr "nParticleShape1.ppfd[1]" "uniformField1.ppda[0]";
connectAttr "UNFExpression.out[0]" "uniformField1.dx";
connectAttr "UNFExpression.out[1]" "uniformField1.dy";
connectAttr "UNFExpression.out[2]" "uniformField1.dz";
connectAttr "ScaleExpression.out[0]" "nurbsCircle1.sx";
connectAttr "ScaleExpression.out[1]" "nurbsCircle1.sy";
connectAttr "ScaleExpression.out[2]" "nurbsCircle1.sz";
connectAttr "makeNurbCircle1.oc" "nurbsCircleShape1.cr";
connectAttr ":time1.o" "ringEmission1.ct";
connectAttr "geoConnector1.ocd" "ringEmission1.ocd";
connectAttr "geoConnector1.ocl" "ringEmission1.t";
connectAttr "geoConnector1.pos" "ringEmission1.opd";
connectAttr "geoConnector1.vel" "ringEmission1.ovd";
connectAttr "geoConnector1.swg" "ringEmission1.swge";
connectAttr "nParticleShape1.ifl" "ringEmission1.full[0]";
connectAttr "nParticleShape1.tss" "ringEmission1.dt[0]";
connectAttr "nParticleShape1.inh" "ringEmission1.inh[0]";
connectAttr "nParticleShape1.stt" "ringEmission1.stt[0]";
connectAttr "nParticleShape1.sd[0]" "ringEmission1.sd[0]";
connectAttr "nParticleEmissionExpression.out[2]" "ringEmission1.rat";
connectAttr ":time1.o" "nParticleShape1.cti";
connectAttr "SmokeNucleus.noao[0]" "nParticleShape1.nxst";
connectAttr "SmokeNucleus.stf" "nParticleShape1.stf";
connectAttr "ringEmission1.ot[0]" "nParticleShape1.npt[0]";
connectAttr "nParticleShape1.incr" "nParticleShape1.rgbPP";
connectAttr "nParticleShape1.inor" "nParticleShape1.opacityPP";
connectAttr "nParticleShape1.inrr" "nParticleShape1.radiusPP";
connectAttr "uniformField1.of[0]" "nParticleShape1.ifc[1]";
connectAttr "uniformField1.mag" "nParticleShape1.xi[0]";
connectAttr "nParticleShape1.vel" "nParticleShape1.xi[1]";
connectAttr ":time1.o" "nEmission1.ct";
connectAttr "nParticleShape1.cwcn" "nEmission1.ocd";
connectAttr "nParticleShape1.ctd" "nEmission1.t";
connectAttr "nParticleShape1.cwps" "nEmission1.opd";
connectAttr "nParticleShape1.cwvl" "nEmission1.ovd";
connectAttr "nParticleShape1.id" "nEmission1.paid";
connectAttr "fluidShape1.ifl" "nEmission1.full[0]";
connectAttr "fluidShape1.ots" "nEmission1.dt[0]";
connectAttr "fluidShape1.inh" "nEmission1.inh[0]";
connectAttr "fluidShape1.sti" "nEmission1.stt[0]";
connectAttr "fluidShape1.sd[0]" "nEmission1.sd[0]";
connectAttr "EmissionTurbulenceExpression.out[0]" "nEmission1.trb";
connectAttr "nParticleShape1.xo[0]" "nEmission1.fde";
connectAttr "hyperLayout1.msg" "SmokeAsset.hl";
connectAttr "Smoke_Control.SmokeResolution" "SmokeAsset.boc[0]";
connectAttr "Smoke_Control.SmokeDensity" "SmokeAsset.boc[1]";
connectAttr "Smoke_Control.SmokeEmitters" "SmokeAsset.boc[2]";
connectAttr "Smoke_Control.EmissionTurbulence" "SmokeAsset.boc[3]";
connectAttr "Smoke_Control.SmokeStart" "SmokeAsset.boc[4]";
connectAttr "Smoke_Control.SmokeTransparency" "SmokeAsset.boc[5]";
connectAttr "Smoke_Control.SourceScale" "SmokeAsset.boc[6]";
connectAttr "Smoke_Control.SmokeSelfShade" "SmokeAsset.boc[7]";
connectAttr "Smoke_Control.SmokeFade" "SmokeAsset.boc[8]";
connectAttr "Smoke_Control.SmokeDirection" "SmokeAsset.boc[9]";
connectAttr "Smoke_Control.SmokeDirectionX" "SmokeAsset.boc[10]";
connectAttr "Smoke_Control.SmokeDirectionY" "SmokeAsset.boc[11]";
connectAttr "Smoke_Control.SmokeDirectionZ" "SmokeAsset.boc[12]";
connectAttr "Smoke_Control.SimulationRate" "SmokeAsset.boc[13]";
connectAttr "Smoke_Control.SmokeMass" "SmokeAsset.boc[14]";
connectAttr "Smoke_Control.DirectionMultiplier" "SmokeAsset.boc[15]";
connectAttr "fluidShape1.opa" "SmokeAsset.boc[16]";
connectAttr "nurbsCircle1.msg" "SmokeAsset.cbc[0]";
connectAttr "SmokeNucleus.msg" "SmokeAsset.pni[0].pnod";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "fluidShape1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "nParticleCloudSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "fluidShape1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "nParticleCloudSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "fluidShape1.ocl" "fluidShape1SG.vs";
connectAttr "fluidShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr ":time1.o" "geoConnector1.ct";
connectAttr "nurbsCircleShape1.l" "geoConnector1.lge";
connectAttr "nurbsCircleShape1.wm" "geoConnector1.wm";
connectAttr "nurbsCircleShape1.msg" "geoConnector1.own";
connectAttr "StartExpression.out[1]" "SmokeNucleus.stf";
connectAttr ":time1.o" "SmokeNucleus.cti";
connectAttr "nParticleShape1.cust" "SmokeNucleus.niao[0]";
connectAttr "nParticleShape1.stst" "SmokeNucleus.nias[0]";
connectAttr "npCloudBlinn.oc" "nParticleCloudSE.ss";
connectAttr "npCloudVolume.oi" "nParticleCloudSE.vs";
connectAttr "nParticleShape1.iog" "nParticleCloudSE.dsm" -na;
connectAttr "nParticleCloudSE.msg" "materialInfo2.sg";
connectAttr "npCloudBlinn.msg" "materialInfo2.m";
connectAttr "particleSamplerInfo1.msg" "materialInfo2.t" -na;
connectAttr "particleSamplerInfo1.oc" "npCloudBlinn.c";
connectAttr "particleSamplerInfo1.ot" "npCloudBlinn.it";
connectAttr "particleSamplerInfo1.oi" "npCloudBlinn.ic";
connectAttr "particleSamplerInfo1.ot" "npCloudVolume.t";
connectAttr "particleSamplerInfo1.oc" "npCloudVolume.c";
connectAttr "particleSamplerInfo1.oi" "npCloudVolume.i";
connectAttr "fluid1.msg" "hyperLayout1.hyp[0].dn";
connectAttr "nurbsCircle1.msg" "hyperLayout1.hyp[1].dn";
connectAttr "nParticle1.msg" "hyperLayout1.hyp[2].dn";
connectAttr "fluidShape1.msg" "hyperLayout1.hyp[4].dn";
connectAttr "nurbsCircleShape1.msg" "hyperLayout1.hyp[5].dn";
connectAttr "ringEmission1.msg" "hyperLayout1.hyp[6].dn";
connectAttr "nParticleShape1.msg" "hyperLayout1.hyp[7].dn";
connectAttr "nEmission1.msg" "hyperLayout1.hyp[8].dn";
connectAttr "SmokeNucleus.msg" "hyperLayout1.hyp[9].dn";
connectAttr "particleSamplerInfo1.msg" "hyperLayout1.hyp[10].dn";
connectAttr "npCloudVolume.msg" "hyperLayout1.hyp[11].dn";
connectAttr "makeNurbCircle1.msg" "hyperLayout1.hyp[12].dn";
connectAttr "nParticleCloudSE.msg" "hyperLayout1.hyp[13].dn";
connectAttr "fluidShape1SG.msg" "hyperLayout1.hyp[14].dn";
connectAttr "geoConnector1.msg" "hyperLayout1.hyp[15].dn";
connectAttr "npCloudBlinn.msg" "hyperLayout1.hyp[16].dn";
connectAttr "SmokeGroup.msg" "hyperLayout1.hyp[17].dn";
connectAttr "Smoke_Control.msg" "hyperLayout1.hyp[18].dn";
connectAttr "Smoke_ControlShape.msg" "hyperLayout1.hyp[19].dn";
connectAttr "annotation1.msg" "hyperLayout1.hyp[20].dn";
connectAttr "annotationShape1.msg" "hyperLayout1.hyp[21].dn";
connectAttr "uniformField1.msg" "hyperLayout1.hyp[22].dn";
connectAttr "ScaleExpression.msg" "hyperLayout1.hyp[23].dn";
connectAttr "UNFExpression.msg" "hyperLayout1.hyp[24].dn";
connectAttr "nParticleEmissionExpression.msg" "hyperLayout1.hyp[25].dn";
connectAttr "SmokeMassExpression.msg" "hyperLayout1.hyp[26].dn";
connectAttr "DissipateExpression.msg" "hyperLayout1.hyp[27].dn";
connectAttr "EmissionTurbulenceExpression.msg" "hyperLayout1.hyp[28].dn";
connectAttr "SmokeTensionExpression.msg" "hyperLayout1.hyp[29].dn";
connectAttr "SimRateExpression.msg" "hyperLayout1.hyp[30].dn";
connectAttr "StartExpression.msg" "hyperLayout1.hyp[31].dn";
connectAttr "DirectionMultExpression.msg" "hyperLayout1.hyp[32].dn";
connectAttr "blendWeighted1.msg" "hyperLayout1.hyp[33].dn";
connectAttr "blendWeighted2.msg" "hyperLayout1.hyp[34].dn";
connectAttr "animCurveUU3.msg" "hyperLayout1.hyp[35].dn";
connectAttr "fluidShape1_transparencyB.msg" "hyperLayout1.hyp[36].dn";
connectAttr "animCurveUU2.msg" "hyperLayout1.hyp[37].dn";
connectAttr "fluidShape1_transparencyG.msg" "hyperLayout1.hyp[38].dn";
connectAttr "animCurveUU1.msg" "hyperLayout1.hyp[39].dn";
connectAttr "fluidShape1_transparencyR.msg" "hyperLayout1.hyp[40].dn";
connectAttr "blendWeighted3.msg" "hyperLayout1.hyp[41].dn";
connectAttr "fluidShape1_shadowOpacity.msg" "hyperLayout1.hyp[42].dn";
connectAttr "Smoke_Control.SourceScale" "ScaleExpression.in[0]";
connectAttr ":time1.o" "ScaleExpression.tim";
connectAttr "nurbsCircle1.msg" "ScaleExpression.obm";
connectAttr "Smoke_Control.SmokeResolution" "nParticleEmissionExpression.in[0]";
connectAttr "Smoke_Control.SmokeDensity" "nParticleEmissionExpression.in[1]";
connectAttr "Smoke_Control.SmokeEmitters" "nParticleEmissionExpression.in[2]";
connectAttr ":time1.o" "nParticleEmissionExpression.tim";
connectAttr "Smoke_Control.msg" "nParticleEmissionExpression.obm";
connectAttr "Smoke_Control.EmissionTurbulence" "EmissionTurbulenceExpression.in[0]"
		;
connectAttr ":time1.o" "EmissionTurbulenceExpression.tim";
connectAttr "nEmission1.msg" "EmissionTurbulenceExpression.obm";
connectAttr "Smoke_Control.SmokeStart" "StartExpression.in[0]";
connectAttr ":time1.o" "StartExpression.tim";
connectAttr "fluidShape1.msg" "StartExpression.obm";
connectAttr "fluidShape1_transparencyR.o" "blendWeighted1.i[0]";
connectAttr "animCurveUU1.o" "blendWeighted1.i[1]";
connectAttr "Smoke_Control.SmokeTransparency" "animCurveUU1.i";
connectAttr "fluidShape1_transparencyG.o" "blendWeighted2.i[0]";
connectAttr "animCurveUU2.o" "blendWeighted2.i[1]";
connectAttr "Smoke_Control.SmokeTransparency" "animCurveUU2.i";
connectAttr "fluidShape1_transparencyB.o" "blendWeighted3.i[0]";
connectAttr "animCurveUU3.o" "blendWeighted3.i[1]";
connectAttr "Smoke_Control.SmokeTransparency" "animCurveUU3.i";
connectAttr "Smoke_Control.SmokeSelfShade" "fluidShape1_shadowOpacity.i";
connectAttr "Smoke_Control.SimulationRate" "SimRateExpression.in[0]";
connectAttr ":time1.o" "SimRateExpression.tim";
connectAttr "fluidShape1.msg" "SimRateExpression.obm";
connectAttr "Smoke_Control.SmokeMass" "SmokeMassExpression.in[0]";
connectAttr ":time1.o" "SmokeMassExpression.tim";
connectAttr "fluidShape1.msg" "SmokeMassExpression.obm";
connectAttr "Smoke_Control.SmokeTension" "SmokeTensionExpression.in[0]";
connectAttr ":time1.o" "SmokeTensionExpression.tim";
connectAttr "fluidShape1.msg" "SmokeTensionExpression.obm";
connectAttr "Smoke_Control.SmokeDirectionX" "UNFExpression.in[0]";
connectAttr "Smoke_Control.SmokeDirectionY" "UNFExpression.in[1]";
connectAttr "Smoke_Control.SmokeDirectionZ" "UNFExpression.in[2]";
connectAttr ":time1.o" "UNFExpression.tim";
connectAttr "uniformField1.msg" "UNFExpression.obm";
connectAttr "Smoke_Control.DirectionMultiplier" "DirectionMultExpression.in[0]";
connectAttr ":time1.o" "DirectionMultExpression.tim";
connectAttr "uniformField1.msg" "DirectionMultExpression.obm";
connectAttr "Smoke_Control.SmokeFade" "DissipateExpression.in[0]";
connectAttr ":time1.o" "DissipateExpression.tim";
connectAttr "fluidShape1.msg" "DissipateExpression.obm";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "nParticleCloudSE.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "npCloudBlinn.msg" ":defaultShaderList1.s" -na;
connectAttr "npCloudVolume.msg" ":defaultShaderList1.s" -na;
// End of Smoke.ma