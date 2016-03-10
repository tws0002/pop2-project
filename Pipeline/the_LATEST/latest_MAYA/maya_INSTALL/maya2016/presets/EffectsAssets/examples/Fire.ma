//Maya ASCII 2011 scene
//Name: Fire.ma
//Last modified: Thu, Jul 29, 2010 05:44:19 PM
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
	setAttr ".t" -type "double3" 40.958246227668042 30.718684670751045 40.958246227668056 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-014 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 65.565184785780957;
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
createNode transform -n "FireCTRL";
	addAttr -ci true -sn "SmokeAmount" -ln "SmokeAmount" -dv 0.5 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "FireScale" -ln "FireScale" -dv 8 -min 0.1 -max 16 -at "double";
	addAttr -ci true -sn "FireColor" -ln "FireColor" -min 0 -max 360 -at "double";
	addAttr -ci true -sn "FlameSpeed" -ln "FlameSpeed" -dv 1 -min 0.5 -max 10 -at "double";
	addAttr -ci true -sn "Sparks" -ln "Sparks" -dv 5 -min 0 -at "double";
	addAttr -ci true -sn "SparkTurbulence" -ln "SparkTurbulence" -dv 50 -min 0 -max 
		200 -at "double";
	addAttr -ci true -sn "FireTurbulence" -ln "FireTurbulence" -min 0 -max 10 -at "double";
	addAttr -ci true -sn "FireAmount" -ln "FireAmount" -dv 150 -min 0 -at "double";
	addAttr -ci true -sn "FireVortexAmount" -ln "FireVortexAmount" -min 0 -at "double";
	addAttr -ci true -sn "FireTurbulenceSpeed" -ln "FireTurbulenceSpeed" -min 0 -at "double";
	addAttr -ci true -sn "FireTurbulenceFrequency" -ln "FireTurbulenceFrequency" -min 
		0 -at "double";
	addAttr -ci true -sn "SparksTurbulenceFrequency" -ln "SparksTurbulenceFrequency" 
		-dv 1 -at "double";
	addAttr -ci true -sn "SparkLifespan" -ln "SparkLifespan" -dv 2 -min 0 -at "double";
	addAttr -ci true -sn "SparkLifespanRandom" -ln "SparkLifespanRandom" -dv 1 -min 
		0 -at "double";
	addAttr -ci true -sn "FireComplexity" -ln "FireComplexity" -dv 40 -min 1 -at "double";
	addAttr -ci true -sn "FireHeight" -ln "FireHeight" -dv 80 -min 0 -at "double";
	addAttr -ci true -sn "FireTransparency" -ln "FireTransparency" -dv 0.8 -min 0 -max 
		1 -at "double";
	addAttr -ci true -sn "FireBaseScale" -ln "FireBaseScale" -dv 1 -min 0.001 -at "double";
	addAttr -ci true -sn "SparkColor" -ln "SparkColor" -min 0 -max 360 -at "double";
	addAttr -ci true -sn "SparkSat" -ln "SparkSat" -dv 1 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "SparksValue" -ln "SparksValue" -dv 0.8 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "SparkIncand1Val" -ln "SparkIncand1Val" -dv 0.5 -at "double";
	addAttr -ci true -sn "SparkIncand2Val" -ln "SparkIncand2Val" -dv 1 -max 1 -at "double";
	addAttr -ci true -sn "SparkSize" -ln "SparkSize" -dv 1 -min 1 -at "long";
	addAttr -ci true -sn "SparkTailSize" -ln "SparkTailSize" -dv 1 -min 0.01 -at "double";
	setAttr -k off ".v";
	setAttr ".t" -type "double3" 0.11627906976744207 1.5116279069767442 0.23255813953488413 ;
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".rx";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -k on ".SmokeAmount";
	setAttr -k on ".FireScale" 0.1;
	setAttr -k on ".FireColor";
	setAttr -k on ".FlameSpeed";
	setAttr -k on ".Sparks" 1000;
	setAttr -k on ".SparkTurbulence";
	setAttr -k on ".FireTurbulence" 1;
	setAttr -k on ".FireAmount" 800;
	setAttr -k on ".FireVortexAmount";
	setAttr -k on ".FireTurbulenceSpeed" 1;
	setAttr -k on ".FireTurbulenceFrequency" 5;
	setAttr -k on ".SparksTurbulenceFrequency";
	setAttr -k on ".SparkLifespan" 1;
	setAttr -k on ".SparkLifespanRandom" 0.5;
	setAttr -k on ".FireComplexity" 30;
	setAttr -k on ".FireHeight" 500;
	setAttr -k on ".FireTransparency" 0.92;
	setAttr -k on ".FireBaseScale";
	setAttr -k on ".SparkColor" 29.3;
	setAttr -k on ".SparkSize";
	setAttr -k on ".SparkTailSize" 2;
createNode locator -n "FireCTRLShape" -p "FireCTRL";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "FireCTRL";
	setAttr ".t" -type "double3" 9.9999999999999982 16.279069767441857 9.6511627906976738 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Surface Fire";
createNode transform -n "Sparks";
	addAttr -ci true -sn "SparkSize" -ln "SparkSize" -dv 1 -min 1 -at "long";
	setAttr -k on ".SparkSize";
createNode nParticle -n "SparksParticleShape" -p "Sparks";
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
	addAttr -is true -ci true -sn "lineWidth" -ln "lineWidth" -dv 1 -min 1 -max 20 -at "long";
	addAttr -is true -ci true -sn "tailFade" -ln "tailFade" -min -1 -max 1 -at "float";
	addAttr -is true -ci true -sn "tailSize" -ln "tailSize" -dv 1 -min -100 -max 100 
		-at "float";
	addAttr -is true -ci true -sn "normalDir" -ln "normalDir" -dv 2 -min 1 -max 3 -at "long";
	addAttr -ci true -sn "incandescencePP" -ln "incandescencePP" -dt "vectorArray";
	addAttr -ci true -h true -sn "incandescencePP0" -ln "incandescencePP0" -dt "vectorArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr -s 2 ".ifc";
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr ".lfm" 2;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".prt" 6;
	setAttr -s 2 ".ppfd";
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
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 0;
	setAttr ".coi" 2;
	setAttr ".colr" 0.089285714718114056;
	setAttr -s 3 ".inca";
	setAttr ".inca[0].incap" 0.6086956262588501;
	setAttr ".inca[0].incai" 1;
	setAttr ".inca[1].incap" 1;
	setAttr ".inca[1].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[1].incai" 1;
	setAttr ".inca[2].incap" 0.25217390060424805;
	setAttr ".inca[2].incai" 1;
	setAttr ".ini" 2;
	setAttr ".icar" 0.26190476168301846;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan";
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
	setAttr -k on ".colorAccum";
	setAttr -k on ".useLighting";
	setAttr -k on ".lineWidth";
	setAttr -k on ".tailFade";
	setAttr -k on ".tailSize";
	setAttr -k on ".normalDir";
	setAttr ".incandescencePP0" -type "vectorArray" 0 ;
createNode turbulenceField -n "SparksTurbulenceField";
	setAttr ".att" 1;
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
createNode vortexField -n "fireVortex";
	setAttr -s 2 ".ind";
	setAttr -s 2 ".of";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr ".axy" 1;
createNode transform -n "fireFluid";
	setAttr ".t" -type "double3" 0 5.7609088290686925 0 ;
createNode fluidShape -n "fireFluidShape" -p "fireFluid";
	addAttr -ci true -sn "lastResizeFrame" -ln "lastResizeFrame" -dv -1000 -at "long";
	addAttr -ci true -sn "startTranslate" -ln "startTranslate" -at "double3" -nc 3;
	addAttr -ci true -sn "startTranslateX" -ln "startTranslateX" -at "double" -p "startTranslate";
	addAttr -ci true -sn "startTranslateY" -ln "startTranslateY" -at "double" -p "startTranslate";
	addAttr -ci true -sn "startTranslateZ" -ln "startTranslateZ" -at "double" -p "startTranslate";
	addAttr -ci true -sn "startResolution" -ln "startResolution" -at "long3" -nc 3;
	addAttr -ci true -sn "startResolutionX" -ln "startResolutionX" -at "long" -p "startResolution";
	addAttr -ci true -sn "startResolutionY" -ln "startResolutionY" -at "long" -p "startResolution";
	addAttr -ci true -sn "startResolutionZ" -ln "startResolutionZ" -at "long" -p "startResolution";
	addAttr -ci true -sn "startDimensions" -ln "startDimensions" -at "double3" -nc 3;
	addAttr -ci true -sn "startDimensionsX" -ln "startDimensionsX" -at "double" -p "startDimensions";
	addAttr -ci true -sn "startDimensionsY" -ln "startDimensionsY" -at "double" -p "startDimensions";
	addAttr -ci true -sn "startDimensionsZ" -ln "startDimensionsZ" -at "double" -p "startDimensions";
	addAttr -ci true -sn "resizeDensityThreshold" -ln "resizeDensityThreshold" -dv 0.0001 
		-min 0 -max 10 -smx 0.1 -at "double";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".iss" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".sqvx" yes;
	setAttr ".rw" 30;
	setAttr ".rh" 30;
	setAttr ".rd" 30;
	setAttr ".dw" 15;
	setAttr ".dh" 15;
	setAttr ".dd" 15;
	setAttr ".aure" yes;
	setAttr ".ots" 0.1;
	setAttr ".hds" 3;
	setAttr ".dsc" 5;
	setAttr ".dds" 4.7861842129649101;
	setAttr ".dsb" 0;
	setAttr ".sfat" 5;
	setAttr ".vsw" 2.8947367668151855;
	setAttr ".tmet" 2;
	setAttr ".tmsc" 5;
	setAttr ".tds" 2.4;
	setAttr ".tdf" 0;
	setAttr ".ttb" 20;
	setAttr ".tttn" 0.44578313827514648;
	setAttr ".ss" yes;
	setAttr ".qua" 0.20000000298023224;
	setAttr ".rin" 3;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 0.33500001 0.29830635 0.29346001 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cib" 0.6974790096282959;
	setAttr -s 5 ".opa";
	setAttr ".opa[1:4]" 1 0.15999999642372131 1 0.095652170479297638 
		0.47999998927116394 1 0 0 1 0.63478261232376099 0.6600000262260437 1;
	setAttr ".opa[8].opap" 0.25217390060424805;
	setAttr ".opa[8].opai" 1;
	setAttr ".oib" 0.5;
	setAttr ".shp" 1;
	setAttr -s 8 ".i";
	setAttr ".i[0].ii" 3;
	setAttr ".i[1].ip" 0.9852670431137085;
	setAttr ".i[1].ic" -type "float3" 0.21299994 0.81685013 3 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ii" 1;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ii" 1;
	setAttr ".i[5].ii" 1;
	setAttr ".i[6].ii" 1;
	setAttr ".i[7].ii" 1;
	setAttr ".iib" 0.57983195781707764;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 0;
	setAttr ".ctl" 0.019999999552965164;
	setAttr ".lastResizeFrame" 1;
	setAttr ".startTranslate" -type "double3" -2.8301976178623951 7.9702329697206675 
		0.17382037939628958 ;
	setAttr ".startResolution" -type "long3" 40 40 40 ;
	setAttr ".startDimensions" -type "double3" 10 10 10 ;
createNode pointEmitter -n "SparksEmitter";
	setAttr ".s" -type "double3" 29.266235264014323 29.266235264014323 29.266235264014323 ;
	setAttr ".emt" 2;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".spd" 3;
createNode fluidEmitter -n "fireEmitter";
	setAttr ".s" -type "double3" 13.027759792463632 13.027759792463632 13.027759792463632 ;
	setAttr ".emt" 2;
	setAttr -k off ".rat";
	setAttr -k off ".sro";
	setAttr -l on -k off ".urpp";
	setAttr -k off ".npuv";
	setAttr ".cyi" 20;
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
	setAttr ".fhe" 1;
	setAttr ".ffe" 1;
createNode container -n "FireAsset";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".isc" yes;
	setAttr -s 24 ".boc";
	setAttr -s 5 ".pni";
	setAttr ".ctor" -type "string" "";
	setAttr ".cdat" -type "string" "2010/06/19 15:09:53";
	setAttr ".ctyp" -type "string" "effects";
	setAttr ".aal" -type "attributeAlias" {"FireScale","borderConnections[0]","SparksTurbulenceFrequency"
		,"borderConnections[10]","SparkLifespan","borderConnections[11]","SparkLifespanRandom"
		,"borderConnections[12]","FireComplexity","borderConnections[13]","FireHeight","borderConnections[14]"
		,"FireTransparency","borderConnections[15]","FireBaseScale","borderConnections[16]"
		,"SparkColor","borderConnections[17]","SparkSat","borderConnections[18]","SparksValue"
		,"borderConnections[19]","FireColor","borderConnections[1]","SparkIncand1Val","borderConnections[20]"
		,"SparkIncand2Val","borderConnections[21]","SparkSize","borderConnections[22]","SparkTailSize"
		,"borderConnections[23]","FlameSpeed","borderConnections[2]","Sparks","borderConnections[3]"
		,"SparkTurbulence","borderConnections[4]","FireAmount","borderConnections[5]","FireVortexAmount"
		,"borderConnections[6]","FireTurbulence","borderConnections[7]","FireTurbulenceSpeed"
		,"borderConnections[8]","FireTurbulenceFrequency","borderConnections[9]","targetFluid"
		,"publishedNodeInfo[0]","nucleusSolver","publishedNodeInfo[1]","targetParticle","publishedNodeInfo[2]"
		,"exampleParticleEmitter","publishedNodeInfo[3]","exampleFluidEmitter","publishedNodeInfo[4]"
		} ;
	setAttr ".nts" -type "string" "Fluid and nParticle effect - Applying this effect to a surface in the scene creates fluid and particle emitters for the surface, and connects them to the fireFluid and sparksParticles in this scene.";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode polySphere -n "polySphere1";
createNode nucleus -n "FireNucleus";
	setAttr ".grty" 37.254901885986328;
	setAttr ".nupl" yes;
	setAttr ".npor" -type "float3" 0 -1.5 0 ;
	setAttr ".npfr" 0.49673202633857727;
	setAttr ".sstp" 20;
	setAttr ".mcit" 20;
createNode particleSamplerInfo -n "particleSamplerInfo1";
createNode animCurveTU -n "emitter1_rate";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  2 100000 3 0;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 49 ".hyp";
	setAttr ".hyp[0].x" 316;
	setAttr ".hyp[0].y" 424;
	setAttr ".hyp[0].isf" yes;
	setAttr ".hyp[5].x" 323;
	setAttr ".hyp[5].y" 68;
	setAttr ".hyp[5].isf" yes;
	setAttr ".hyp[6].x" 130;
	setAttr ".hyp[6].y" 80;
	setAttr ".hyp[6].isf" yes;
	setAttr ".hyp[7].x" 544;
	setAttr ".hyp[7].y" 106;
	setAttr ".hyp[7].isf" yes;
	setAttr ".anf" yes;
createNode shadingEngine -n "nParticleCloudSE";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode blinn -n "npCloudBlinn";
createNode particleCloud -n "npCloudVolume";
createNode animCurveUU -n "fireFluidShape_incandescence_0__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0.97851443290710449 0.5 0 1 0;
createNode animCurveUU -n "fireFluidShape_incandescence_4__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0.9828115701675415 0.5 0.43387097120285034 
		1 0.05161290243268013;
createNode animCurveUU -n "fireFluidShape_incandescence_2__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0.9852670431137085 0.5 0.5854838490486145 
		1 0.20806451141834259;
createNode animCurveUU -n "fireFluidShape_incandescence_6__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0.98956412076950073 0.5 0.72419357299804688 
		1 0.46935483813285828;
createNode animCurveUU -n "fireFluidShape_incandescence_3__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0.99754452705383301 0.5 0.86612904071807861 
		1 0.69838708639144897;
createNode animCurveUU -n "fireFluidShape_incandescence_7__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0.99140578508377075 0.5 0.94838708639144897 
		1 0.94838708639144897;
createNode animCurveUU -n "fireFluidShape_incandescence_5__incandescence_Position";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 1 0.5 1 1 1;
createNode animCurveUU -n "fireFluidShape_opacity_8__opacity_FloatValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0 0.25 0 0.5 0.25999999046325684;
createNode animCurveUU -n "fireFluidShape_opacity_4__opacity_FloatValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  0 0 0.25 0.54000002145767212 0.5 0.57999998331069946;
createNode animCurveUU -n "fireFluidShape_opacity_1__opacity_FloatValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr ".ktv[0]"  0.25 0.15999999642372131;
createNode animCurveUU -n "fireFluidShape_opacity_3__opacity_FloatValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr ".ktv[0]"  0.25 0;
createNode animCurveUU -n "fireFluidShape_opacity_2__opacity_FloatValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr ".ktv[0]"  0.25 0;
createNode animCurveUU -n "fireFluidShape_opacity_4__opacity_FloatValue1";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0.6600000262260437 1 0.6600000262260437;
createNode animCurveUU -n "fireFluidShape_opacity_8__opacity_FloatValue1";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 1 0.98000001907348633;
createNode animCurveUU -n "fireFluidShape_opacity_1__opacity_FloatValue1";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0.15999999642372131 1 0.15999999642372131;
createNode animCurveUU -n "fireFluidShape_opacity_3__opacity_FloatValue1";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 1 0;
createNode animCurveUU -n "fireFluidShape_opacity_2__opacity_FloatValue1";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 1 0.95999997854232788;
createNode animCurveUU -n "fireFluidShape_incandescence_0__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0 120 0 240 0 360 0;
createNode animCurveUU -n "fireFluidShape_incandescence_0__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0 120 0 240 0 360 0;
createNode animCurveUU -n "fireFluidShape_incandescence_0__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0 120 0 240 0 360 0;
createNode animCurveUU -n "fireFluidShape_incandescence_4__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.11500000208616257 120 0.0047150012105703354 
		240 0.007644173689186573 360 0.11500000208616257;
createNode animCurveUU -n "fireFluidShape_incandescence_4__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.032286256551742554 120 0.11500000208616257 
		240 0.0020500004757195711 360 0.0047150012105703354;
createNode animCurveUU -n "fireFluidShape_incandescence_4__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.0047150012105703354 120 0.021257761865854263 
		240 0.05000000074505806 360 0.0047150012105703354;
createNode animCurveUU -n "fireFluidShape_incandescence_2__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.71200001239776611 120 0.029192006215453148 
		240 0.084850326180458069 360 0.71200001239776611;
createNode animCurveUU -n "fireFluidShape_incandescence_2__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.07471252977848053 120 0.71200001239776611 
		240 0.022755004465579987 360 0.029192006215453148;
createNode animCurveUU -n "fireFluidShape_incandescence_2__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.029192006215453148 120 0.32507553696632385 
		240 0.55500000715255737 360 0.074712485074996948;
createNode animCurveUU -n "fireFluidShape_incandescence_6__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 1.2349699735641479 120 0.050635010004043579 
		240 0.083069868385791779 360 1.2350000143051147;
createNode animCurveUU -n "fireFluidShape_incandescence_6__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.17342899739742279 120 1.2350000143051147 
		240 0.028167005628347397 360 0.050635010004043579;
createNode animCurveUU -n "fireFluidShape_incandescence_6__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.050633799284696579 120 0.30724743008613586 
		240 0.68699997663497925 360 0.24802900850772858;
createNode animCurveUU -n "fireFluidShape_incandescence_3__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 4.0085878372192383 120 0.25657603144645691 
		240 0.20732021331787109 360 0.875;
createNode animCurveUU -n "fireFluidShape_incandescence_3__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 1.0703829526901245 120 4.0089998245239258 
		240 0.093440018594264984 360 0.048999994993209839;
createNode animCurveUU -n "fireFluidShape_incandescence_3__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.2578519880771637 120 0.44861748814582825 
		240 1.4600000381469727 360 0.048999994993209839;
createNode animCurveUU -n "fireFluidShape_incandescence_7__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 10.55390453338623 120 0.14199995994567871 
		240 0.23490035533905029 360 0.98600000143051147;
createNode animCurveUU -n "fireFluidShape_incandescence_7__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 3.2762711048126221 120 2 240 0.14199995994567871 
		360 0;
createNode animCurveUU -n "fireFluidShape_incandescence_7__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.74932700395584106 120 0.29683315753936768 
		240 2 360 0.16433317959308624;
createNode animCurveUU -n "fireFluidShape_incandescence_5__incandescence_ColorR";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 4.7529997825622559 120 0.11409696936607361 
		240 0.67499995231628418 360 1;
createNode animCurveUU -n "fireFluidShape_incandescence_5__incandescence_ColorG";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 2.1772696971893311 120 1.6069999933242798 
		240 0.74708312749862671 360 0.022000014781951904;
createNode animCurveUU -n "fireFluidShape_incandescence_5__incandescence_ColorB";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  0 0.3374629020690918 120 0.13897866010665894 
		240 5 360 0.022000014781951904;
createNode hsvToRgb -n "hsvToRgb1";
	setAttr ".arp" 2;
createNode hsvToRgb -n "hsvToRgb2";
	setAttr ".arp" 2;
createNode hsvToRgb -n "hsvToRgb3";
	setAttr ".arp" 2;
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
select -ne :defaultRenderUtilityList1;
	setAttr -s 3 ".u";
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
connectAttr "FireCTRLShape.wm" "annotationShape1.dom" -na;
connectAttr "FireCTRL.SparkLifespan" "SparksParticleShape.lifespan";
connectAttr "FireCTRL.SparkSize" "SparksParticleShape.lineWidth";
connectAttr "FireCTRL.SparkTailSize" "SparksParticleShape.tailSize";
connectAttr ":time1.o" "SparksParticleShape.cti";
connectAttr "FireNucleus.noao[0]" "SparksParticleShape.nxst";
connectAttr "FireNucleus.stf" "SparksParticleShape.stf";
connectAttr "SparksEmitter.ot[0]" "SparksParticleShape.npt[0]";
connectAttr "SparksParticleShape.incr" "SparksParticleShape.rgbPP";
connectAttr "SparksParticleShape.inor" "SparksParticleShape.opacityPP";
connectAttr "SparksParticleShape.inrr" "SparksParticleShape.radiusPP";
connectAttr "SparksTurbulenceField.of[0]" "SparksParticleShape.ifc[0]";
connectAttr "fireVortex.of[1]" "SparksParticleShape.ifc[1]";
connectAttr "SparksParticleShape.inir" "SparksParticleShape.incandescencePP";
connectAttr "FireCTRL.SparkLifespanRandom" "SparksParticleShape.lfr";
connectAttr "hsvToRgb2.o" "SparksParticleShape.inca[0].incac";
connectAttr "hsvToRgb2.o" "SparksParticleShape.inca[2].incac";
connectAttr "SparksParticleShape.fd" "SparksTurbulenceField.ind[0]";
connectAttr "SparksParticleShape.ppfd[0]" "SparksTurbulenceField.ppda[0]";
connectAttr "FireCTRL.SparkTurbulence" "SparksTurbulenceField.mag";
connectAttr "FireCTRL.SparksTurbulenceFrequency" "SparksTurbulenceField.frq";
connectAttr "fireFluidShape.fd" "fireVortex.ind[0]";
connectAttr "SparksParticleShape.fd" "fireVortex.ind[1]";
connectAttr "FireCTRL.FireVortexAmount" "fireVortex.mag";
connectAttr "SparksParticleShape.ppfd[1]" "fireVortex.ppda[0]";
connectAttr ":time1.o" "fireFluidShape.cti";
connectAttr "fireFluidShape_opacity_1__opacity_FloatValue1.o" "fireFluidShape.opa[1].opafv"
		;
connectAttr "fireFluidShape_opacity_2__opacity_FloatValue1.o" "fireFluidShape.opa[2].opafv"
		;
connectAttr "fireFluidShape_opacity_3__opacity_FloatValue1.o" "fireFluidShape.opa[3].opafv"
		;
connectAttr "fireFluidShape_opacity_4__opacity_FloatValue1.o" "fireFluidShape.opa[4].opafv"
		;
connectAttr "fireFluidShape_opacity_8__opacity_FloatValue1.o" "fireFluidShape.opa[8].opafv"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_Position.o" "fireFluidShape.i[0].ip"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_ColorR.o" "fireFluidShape.i[0].icr"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_ColorG.o" "fireFluidShape.i[0].icg"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_ColorB.o" "fireFluidShape.i[0].icb"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_Position.o" "fireFluidShape.i[2].ip"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_ColorR.o" "fireFluidShape.i[2].icr"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_ColorG.o" "fireFluidShape.i[2].icg"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_ColorB.o" "fireFluidShape.i[2].icb"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_Position.o" "fireFluidShape.i[3].ip"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_ColorR.o" "fireFluidShape.i[3].icr"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_ColorG.o" "fireFluidShape.i[3].icg"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_ColorB.o" "fireFluidShape.i[3].icb"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_Position.o" "fireFluidShape.i[4].ip"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_ColorR.o" "fireFluidShape.i[4].icr"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_ColorG.o" "fireFluidShape.i[4].icg"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_ColorB.o" "fireFluidShape.i[4].icb"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_Position.o" "fireFluidShape.i[5].ip"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_ColorR.o" "fireFluidShape.i[5].icr"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_ColorG.o" "fireFluidShape.i[5].icg"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_ColorB.o" "fireFluidShape.i[5].icb"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_Position.o" "fireFluidShape.i[6].ip"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_ColorR.o" "fireFluidShape.i[6].icr"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_ColorG.o" "fireFluidShape.i[6].icg"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_ColorB.o" "fireFluidShape.i[6].icb"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_Position.o" "fireFluidShape.i[7].ip"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_ColorR.o" "fireFluidShape.i[7].icr"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_ColorG.o" "fireFluidShape.i[7].icg"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_ColorB.o" "fireFluidShape.i[7].icb"
		;
connectAttr "FireCTRL.FlameSpeed" "fireFluidShape.vsy";
connectAttr "FireCTRL.FireTurbulence" "fireFluidShape.tst";
connectAttr "FireCTRL.FireScale" "fireFluidShape.srs";
connectAttr "fireVortex.of[0]" "fireFluidShape.ifc[0]";
connectAttr "FireCTRL.FireComplexity" "fireFluidShape.bres";
connectAttr "FireCTRL.FireHeight" "fireFluidShape.buo";
connectAttr "FireCTRL.FireTransparency" "fireFluidShape.tr";
connectAttr "FireCTRL.FireTransparency" "fireFluidShape.tg";
connectAttr "FireCTRL.FireTransparency" "fireFluidShape.tb";
connectAttr ":time1.o" "SparksEmitter.ct";
connectAttr "SparksParticleShape.ifl" "SparksEmitter.full[0]";
connectAttr "SparksParticleShape.tss" "SparksEmitter.dt[0]";
connectAttr "SparksParticleShape.inh" "SparksEmitter.inh[0]";
connectAttr "SparksParticleShape.stt" "SparksEmitter.stt[0]";
connectAttr "SparksParticleShape.sd[0]" "SparksEmitter.sd[0]";
connectAttr "FireCTRL.Sparks" "SparksEmitter.rat";
connectAttr "FireCTRL.FireAmount" "fireEmitter.rat";
connectAttr ":time1.o" "fireEmitter.ct";
connectAttr "FireCTRL.FireTurbulence" "fireEmitter.trb";
connectAttr "FireCTRL.FireTurbulenceFrequency" "fireEmitter.tfx";
connectAttr "FireCTRL.FireTurbulenceFrequency" "fireEmitter.tfy";
connectAttr "FireCTRL.FireTurbulenceFrequency" "fireEmitter.tfz";
connectAttr "FireCTRL.FireTurbulenceSpeed" "fireEmitter.trs";
connectAttr "hyperLayout1.msg" "FireAsset.hl";
connectAttr "fireFluidShape.msg" "FireAsset.pni[0].pnod";
connectAttr "FireNucleus.msg" "FireAsset.pni[1].pnod";
connectAttr "SparksParticleShape.msg" "FireAsset.pni[2].pnod";
connectAttr "SparksEmitter.msg" "FireAsset.pni[3].pnod";
connectAttr "fireEmitter.msg" "FireAsset.pni[4].pnod";
connectAttr "FireCTRL.FireScale" "FireAsset.boc[0]";
connectAttr "FireCTRL.FireColor" "FireAsset.boc[1]";
connectAttr "FireCTRL.FlameSpeed" "FireAsset.boc[2]";
connectAttr "FireCTRL.Sparks" "FireAsset.boc[3]";
connectAttr "FireCTRL.SparkTurbulence" "FireAsset.boc[4]";
connectAttr "FireCTRL.FireAmount" "FireAsset.boc[5]";
connectAttr "FireCTRL.FireVortexAmount" "FireAsset.boc[6]";
connectAttr "FireCTRL.FireTurbulence" "FireAsset.boc[7]";
connectAttr "FireCTRL.FireTurbulenceSpeed" "FireAsset.boc[8]";
connectAttr "FireCTRL.FireTurbulenceFrequency" "FireAsset.boc[9]";
connectAttr "FireCTRL.SparksTurbulenceFrequency" "FireAsset.boc[10]";
connectAttr "FireCTRL.SparkLifespan" "FireAsset.boc[11]";
connectAttr "FireCTRL.SparkLifespanRandom" "FireAsset.boc[12]";
connectAttr "FireCTRL.FireComplexity" "FireAsset.boc[13]";
connectAttr "FireCTRL.FireHeight" "FireAsset.boc[14]";
connectAttr "FireCTRL.FireTransparency" "FireAsset.boc[15]";
connectAttr "FireCTRL.FireBaseScale" "FireAsset.boc[16]";
connectAttr "FireCTRL.SparkColor" "FireAsset.boc[17]";
connectAttr "FireCTRL.SparkSat" "FireAsset.boc[18]";
connectAttr "FireCTRL.SparksValue" "FireAsset.boc[19]";
connectAttr "FireCTRL.SparkIncand1Val" "FireAsset.boc[20]";
connectAttr "FireCTRL.SparkIncand2Val" "FireAsset.boc[21]";
connectAttr "FireCTRL.SparkSize" "FireAsset.boc[22]";
connectAttr "FireCTRL.SparkTailSize" "FireAsset.boc[23]";
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
connectAttr ":time1.o" "FireNucleus.cti";
connectAttr "SparksParticleShape.cust" "FireNucleus.niao[0]";
connectAttr "SparksParticleShape.stst" "FireNucleus.nias[0]";
connectAttr "fireFluidShape.ocl" "fluidShape1SG.vs";
connectAttr "fireFluidShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo3.sg";
connectAttr "FireCTRL.msg" "hyperLayout1.hyp[0].dn";
connectAttr "FireCTRLShape.msg" "hyperLayout1.hyp[5].dn";
connectAttr "annotation1.msg" "hyperLayout1.hyp[6].dn";
connectAttr "annotationShape1.msg" "hyperLayout1.hyp[7].dn";
connectAttr "Sparks.msg" "hyperLayout1.hyp[8].dn";
connectAttr "SparksParticleShape.msg" "hyperLayout1.hyp[9].dn";
connectAttr "SparksTurbulenceField.msg" "hyperLayout1.hyp[10].dn";
connectAttr "fireVortex.msg" "hyperLayout1.hyp[11].dn";
connectAttr "fireFluid.msg" "hyperLayout1.hyp[14].dn";
connectAttr "fireFluidShape.msg" "hyperLayout1.hyp[16].dn";
connectAttr "SparksEmitter.msg" "hyperLayout1.hyp[20].dn";
connectAttr "fireEmitter.msg" "hyperLayout1.hyp[21].dn";
connectAttr "fireFluidShape_opacity_3__opacity_FloatValue1.msg" "hyperLayout1.hyp[22].dn"
		;
connectAttr "fireFluidShape_opacity_4__opacity_FloatValue1.msg" "hyperLayout1.hyp[23].dn"
		;
connectAttr "fireFluidShape_opacity_8__opacity_FloatValue1.msg" "hyperLayout1.hyp[24].dn"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_Position.msg" "hyperLayout1.hyp[25].dn"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_ColorR.msg" "hyperLayout1.hyp[26].dn"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_ColorB.msg" "hyperLayout1.hyp[27].dn"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_Position.msg" "hyperLayout1.hyp[28].dn"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_ColorR.msg" "hyperLayout1.hyp[29].dn"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_ColorB.msg" "hyperLayout1.hyp[30].dn"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_ColorG.msg" "hyperLayout1.hyp[31].dn"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_ColorB.msg" "hyperLayout1.hyp[32].dn"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_Position.msg" "hyperLayout1.hyp[33].dn"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_ColorR.msg" "hyperLayout1.hyp[34].dn"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_ColorG.msg" "hyperLayout1.hyp[35].dn"
		;
connectAttr "fireFluidShape_incandescence_4__incandescence_ColorB.msg" "hyperLayout1.hyp[36].dn"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_ColorG.msg" "hyperLayout1.hyp[37].dn"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_ColorG.msg" "hyperLayout1.hyp[38].dn"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_Position.msg" "hyperLayout1.hyp[39].dn"
		;
connectAttr "fireFluidShape_incandescence_0__incandescence_ColorR.msg" "hyperLayout1.hyp[40].dn"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_ColorG.msg" "hyperLayout1.hyp[41].dn"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_ColorB.msg" "hyperLayout1.hyp[42].dn"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_ColorR.msg" "hyperLayout1.hyp[43].dn"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_ColorG.msg" "hyperLayout1.hyp[44].dn"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_Position.msg" "hyperLayout1.hyp[45].dn"
		;
connectAttr "fireFluidShape_incandescence_7__incandescence_ColorR.msg" "hyperLayout1.hyp[46].dn"
		;
connectAttr "fireFluidShape_opacity_1__opacity_FloatValue1.msg" "hyperLayout1.hyp[47].dn"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_ColorB.msg" "hyperLayout1.hyp[48].dn"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_ColorR.msg" "hyperLayout1.hyp[49].dn"
		;
connectAttr "fireFluidShape_incandescence_5__incandescence_Position.msg" "hyperLayout1.hyp[50].dn"
		;
connectAttr "fireFluidShape_opacity_2__opacity_FloatValue1.msg" "hyperLayout1.hyp[52].dn"
		;
connectAttr "fireFluidShape_incandescence_2__incandescence_ColorG.msg" "hyperLayout1.hyp[53].dn"
		;
connectAttr "fireFluidShape_incandescence_3__incandescence_Position.msg" "hyperLayout1.hyp[54].dn"
		;
connectAttr "fireFluidShape_incandescence_6__incandescence_ColorB.msg" "hyperLayout1.hyp[55].dn"
		;
connectAttr "FireNucleus.msg" "hyperLayout1.hyp[56].dn";
connectAttr "hsvToRgb2.msg" "hyperLayout1.hyp[57].dn";
connectAttr "hsvToRgb1.msg" "hyperLayout1.hyp[58].dn";
connectAttr "hsvToRgb3.msg" "hyperLayout1.hyp[59].dn";
connectAttr "npCloudBlinn.oc" "nParticleCloudSE.ss";
connectAttr "npCloudVolume.oi" "nParticleCloudSE.vs";
connectAttr "SparksParticleShape.iog" "nParticleCloudSE.dsm" -na;
connectAttr "nParticleCloudSE.msg" "materialInfo4.sg";
connectAttr "npCloudBlinn.msg" "materialInfo4.m";
connectAttr "particleSamplerInfo1.msg" "materialInfo4.t" -na;
connectAttr "particleSamplerInfo1.oc" "npCloudBlinn.c";
connectAttr "particleSamplerInfo1.ot" "npCloudBlinn.it";
connectAttr "particleSamplerInfo1.oi" "npCloudBlinn.ic";
connectAttr "particleSamplerInfo1.ot" "npCloudVolume.t";
connectAttr "particleSamplerInfo1.oc" "npCloudVolume.c";
connectAttr "particleSamplerInfo1.oi" "npCloudVolume.i";
connectAttr "FireCTRL.SmokeAmount" "fireFluidShape_opacity_4__opacity_FloatValue1.i"
		;
connectAttr "FireCTRL.SmokeAmount" "fireFluidShape_opacity_8__opacity_FloatValue1.i"
		;
connectAttr "FireCTRL.SmokeAmount" "fireFluidShape_opacity_1__opacity_FloatValue1.i"
		;
connectAttr "FireCTRL.SmokeAmount" "fireFluidShape_opacity_3__opacity_FloatValue1.i"
		;
connectAttr "FireCTRL.SmokeAmount" "fireFluidShape_opacity_2__opacity_FloatValue1.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_0__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_0__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_0__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_4__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_4__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_4__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_2__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_2__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_2__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_6__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_6__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_6__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_3__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_3__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_3__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_7__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_7__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_7__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_5__incandescence_ColorR.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_5__incandescence_ColorG.i"
		;
connectAttr "FireCTRL.FireColor" "fireFluidShape_incandescence_5__incandescence_ColorB.i"
		;
connectAttr "FireCTRL.SparkSat" "hsvToRgb1.ig";
connectAttr "FireCTRL.SparksValue" "hsvToRgb1.ib";
connectAttr "FireCTRL.SparkColor" "hsvToRgb1.ir";
connectAttr "FireCTRL.SparkSat" "hsvToRgb2.ig";
connectAttr "FireCTRL.SparkIncand1Val" "hsvToRgb2.ib";
connectAttr "FireCTRL.SparkColor" "hsvToRgb2.ir";
connectAttr "FireCTRL.SparkSat" "hsvToRgb3.ig";
connectAttr "FireCTRL.SparkIncand2Val" "hsvToRgb3.ib";
connectAttr "FireCTRL.SparkColor" "hsvToRgb3.ir";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "nParticleCloudSE.pa" ":renderPartition.st" -na;
connectAttr "fireFluidShape.msg" ":defaultShaderList1.s" -na;
connectAttr "npCloudBlinn.msg" ":defaultShaderList1.s" -na;
connectAttr "npCloudVolume.msg" ":defaultShaderList1.s" -na;
connectAttr "hsvToRgb1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "hsvToRgb2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "hsvToRgb3.msg" ":defaultRenderUtilityList1.u" -na;
// End of Fire.ma
