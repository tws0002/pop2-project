//Maya ASCII 2011 scene
//Name: Rain.ma
//Last modified: Fri, Jul 30, 2010 06:02:38 PM
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
	setAttr ".t" -type "double3" -13.834573660465825 -1.8769007316830377 114.54847872993943 ;
	setAttr ".r" -type "double3" -1.5383527296028408 -0.59999999999995368 6.3676705272044829e-017 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 100.48971663697696;
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
createNode transform -n "spotLight1";
	setAttr ".t" -type "double3" 35.583877051005423 56.983993263764809 83.046916084727457 ;
	setAttr ".r" -type "double3" -43.800000000000232 27.200000000000102 0 ;
createNode spotLight -n "spotLightShape1" -p "spotLight1";
	setAttr -k off ".v";
	setAttr ".col" 115.82849486260881;
createNode transform -n "RainParticles";
createNode nParticle -n "RainParticlesShape" -p "RainParticles";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "event" -ln "event" -dt "doubleArray";
	addAttr -ci true -h true -sn "event0" -ln "event0" -dt "doubleArray";
	addAttr -ci true -sn "eventCountCache" -ln "eventCountCache" -at "long";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr -s 3 ".ifc";
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr ".lfm" 3;
	setAttr -s 2 ".xi";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "vector $dropPos = .I[0];\n\nif ($dropPos.y < .I[1] )\n\t.O[0] = 0;";
	setAttr ".icx" -type "string" "";
	setAttr ".cts" 1;
	setAttr ".chw" 204;
	setAttr ".evn[0]" -type "string" "event0";
	setAttr ".evv[0]"  1;
	setAttr ".ecp[0]"  0;
	setAttr ".eve[0]"  1;
	setAttr ".evs[0]"  0;
	setAttr ".evd[0]"  1;
	setAttr ".evr[0]"  0;
	setAttr ".esp[0]"  0;
	setAttr ".epr[0]" -type "string" "";
	setAttr ".prt" 7;
	setAttr -s 3 ".ppfd";
	setAttr ".fron" 0;
	setAttr ".cofl" 1;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".drg" 0;
	setAttr ".esph" yes;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".thr" 0.6;
	setAttr ".rdc[0]"  0 1 1;
	setAttr ".mssc[0]"  0 1 1;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".opc[0]"  0 1 1;
	setAttr ".oci" 1;
	setAttr ".cl[0].clp" 0.53043478727340698;
	setAttr ".cl[0].cli" 1;
	setAttr ".coi" 1;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".event0" -type "doubleArray" 0 ;
createNode transform -n "RainTrails";
createNode nParticle -n "RainTrailsShape" -p "RainTrails";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr ".lfm" 2;
	setAttr ".lfr" 0.25;
	setAttr -s 2 ".xi";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "vector $trailPos = .I[0];\n\nif ($trailPos.y < .I[1] )\n\t.O[0] = 0;";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 204;
	setAttr ".prt" 7;
	setAttr ".fron" 0.080168776214122772;
	setAttr ".adng" 0.71729958057403564;
	setAttr ".clst" 0.025316456332802773;
	setAttr ".cofl" 1;
	setAttr ".pmss" 0.29632911086082458;
	setAttr ".cll" 1;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr ".pff" 1;
	setAttr ".sfat" 10;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".drg" 0;
	setAttr ".esph" yes;
	setAttr ".incp" 0.05000000074505806;
	setAttr ".visc" 0.32911393046379089;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".thr" 0.6;
	setAttr -s 3 ".rdc[0:2]"  0.078260869 1 1 1 0 1 0.36521739 
		0.46000001 1;
	setAttr ".rci" 2;
	setAttr ".mssc[0]"  0 1 1;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".opc[0]"  0 1 1;
	setAttr ".oci" 1;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].cli" 1;
	setAttr ".coi" 1;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".brs" 6.7932489454620502;
	setAttr ".mts" 0.12658228189979173;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
createNode transform -n "RainCTRL";
	setAttr ".t" -type "double3" -0.035083770751953125 -4.7363367080688477 0.090067712924412291 ;
createNode locator -n "RainCTRLShape" -p "RainCTRL";
	setAttr -k off ".v";
createNode transform -n "channels" -p "RainCTRL";
	addAttr -ci true -sn "RainPlaneSize" -ln "RainPlaneSize" -dv 50 -min 1 -at "double";
	addAttr -ci true -sn "RainAmount" -ln "RainAmount" -dv 100 -min 0 -at "double";
	addAttr -ci true -sn "RainSpeed" -ln "RainSpeed" -dv 9.8 -min 0 -at "double";
	addAttr -ci true -sn "RainTurbulence" -ln "RainTurbulence" -dv 15 -min 0 -at "double";
	addAttr -ci true -sn "RainDropSize" -ln "RainDropSize" -dv 0.2 -min 0.05 -max 10 
		-at "double";
	addAttr -ci true -sn "RainWindSpeed" -ln "RainWindSpeed" -min 0 -at "double";
	addAttr -ci true -sn "RainWindAngle" -ln "RainWindAngle" -min 0 -max 360 -at "double";
	addAttr -ci true -sn "RainRandomSize" -ln "RainRandomSize" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "RainDiesLevel" -ln "RainDiesLevel" -at "double";
	addAttr -ci true -sn "RainHue" -ln "RainHue" -dv 0.3 -min 0 -max 360 -at "double";
	addAttr -ci true -sn "RainTransparency" -ln "RainTransparency" -dv 0.1 -min 0 -max 
		1 -at "double";
	addAttr -ci true -sn "RainVortexMagnitude" -ln "RainVortexMagnitude" -min -500 -max 
		500 -at "double";
	addAttr -ci true -sn "colorSaturation" -ln "colorSaturation" -dv 0.5 -min 0 -max 
		1 -at "double";
	addAttr -ci true -sn "colorValue" -ln "colorValue" -dv 0.85 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "RainStart" -ln "RainStart" -dv 1 -min 1 -at "double";
	addAttr -ci true -sn "RainEnd" -ln "RainEnd" -dv 200 -min 1 -at "double";
	setAttr -k off ".v";
	setAttr ".t" -type "double3" 32.418500140309334 28.883234217762947 32.517009778282571 ;
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -k on ".RainPlaneSize" 102.1;
	setAttr -k on ".RainAmount";
	setAttr -k on ".RainSpeed" 1;
	setAttr -k on ".RainTurbulence" 0;
	setAttr -k on ".RainDropSize" 0.3;
	setAttr -k on ".RainWindSpeed";
	setAttr -k on ".RainWindAngle";
	setAttr -k on ".RainRandomSize";
	setAttr -k on ".RainDiesLevel" -40;
	setAttr -k on ".RainHue" 333.1;
	setAttr -k on ".RainTransparency";
	setAttr -k on ".RainVortexMagnitude";
	setAttr -k on ".RainStart";
	setAttr -l on -k on ".RainEnd";
createNode annotationShape -n "channelsShape" -p "channels";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Rain on surface";
createNode turbulenceField -n "RainTurbulence";
	setAttr ".att" 1;
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
createNode airField -n "RainWind1";
	setAttr ".att" 1;
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr ".dx" 1;
	setAttr ".spd" 0.5;
	setAttr ".spr" 1;
	setAttr ".ir" yes;
createNode vortexField -n "RainVortex";
	setAttr ".att" 1;
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr ".axy" 1;
createNode transform -n "emissionGroup";
createNode transform -n "RainPlane" -p "emissionGroup";
	setAttr ".t" -type "double3" 0 23.957532236804017 0 ;
createNode mesh -n "RainPlaneShape" -p "RainPlane";
	setAttr -k off ".v";
	setAttr ".ovs" no;
	setAttr ".ovt" no;
	setAttr ".ove" yes;
	setAttr ".mb" no;
	setAttr ".csh" no;
	setAttr ".rcsh" no;
	setAttr ".vis" no;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 121 ".uvst[0].uvsp[0:120]" -type "float2" 0 0 0.1 0 0.2 0 
		0.30000001 0 0.40000001 0 0.5 0 0.60000002 0 0.69999999 0 0.80000001 0 0.90000004 
		0 1 0 0 0.1 0.1 0.1 0.2 0.1 0.30000001 0.1 0.40000001 0.1 0.5 0.1 0.60000002 0.1 
		0.69999999 0.1 0.80000001 0.1 0.90000004 0.1 1 0.1 0 0.2 0.1 0.2 0.2 0.2 0.30000001 
		0.2 0.40000001 0.2 0.5 0.2 0.60000002 0.2 0.69999999 0.2 0.80000001 0.2 0.90000004 
		0.2 1 0.2 0 0.30000001 0.1 0.30000001 0.2 0.30000001 0.30000001 0.30000001 0.40000001 
		0.30000001 0.5 0.30000001 0.60000002 0.30000001 0.69999999 0.30000001 0.80000001 
		0.30000001 0.90000004 0.30000001 1 0.30000001 0 0.40000001 0.1 0.40000001 0.2 0.40000001 
		0.30000001 0.40000001 0.40000001 0.40000001 0.5 0.40000001 0.60000002 0.40000001 
		0.69999999 0.40000001 0.80000001 0.40000001 0.90000004 0.40000001 1 0.40000001 0 
		0.5 0.1 0.5 0.2 0.5 0.30000001 0.5 0.40000001 0.5 0.5 0.5 0.60000002 0.5 0.69999999 
		0.5 0.80000001 0.5 0.90000004 0.5 1 0.5 0 0.60000002 0.1 0.60000002 0.2 0.60000002 
		0.30000001 0.60000002 0.40000001 0.60000002 0.5 0.60000002 0.60000002 0.60000002 
		0.69999999 0.60000002 0.80000001 0.60000002 0.90000004 0.60000002 1 0.60000002 0 
		0.69999999 0.1 0.69999999 0.2 0.69999999 0.30000001 0.69999999 0.40000001 0.69999999 
		0.5 0.69999999 0.60000002 0.69999999 0.69999999 0.69999999 0.80000001 0.69999999 
		0.90000004 0.69999999 1 0.69999999 0 0.80000001 0.1 0.80000001 0.2 0.80000001 0.30000001 
		0.80000001 0.40000001 0.80000001 0.5 0.80000001 0.60000002 0.80000001 0.69999999 
		0.80000001 0.80000001 0.80000001 0.90000004 0.80000001 1 0.80000001 0 0.90000004 
		0.1 0.90000004 0.2 0.90000004 0.30000001 0.90000004 0.40000001 0.90000004 0.5 0.90000004 
		0.60000002 0.90000004 0.69999999 0.90000004 0.80000001 0.90000004 0.90000004 0.90000004 
		1 0.90000004 0 1 0.1 1 0.2 1 0.30000001 1 0.40000001 1 0.5 1 0.60000002 1 0.69999999 
		1 0.80000001 1 0.90000004 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".smo" no;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 121 ".vt[0:120]"  -0.5 -1.110223e-016 0.5 -0.40000001 -1.110223e-016 
		0.5 -0.30000001 -1.110223e-016 0.5 -0.19999999 -1.110223e-016 0.5 -0.099999994 -1.110223e-016 
		0.5 0 -1.110223e-016 0.5 0.10000002 -1.110223e-016 0.5 0.19999999 -1.110223e-016 
		0.5 0.30000001 -1.110223e-016 0.5 0.40000004 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 -8.8817843e-017 0.40000001 -0.40000001 -8.8817843e-017 0.40000001 -0.30000001 
		-8.8817843e-017 0.40000001 -0.19999999 -8.8817843e-017 0.40000001 -0.099999994 -8.8817843e-017 
		0.40000001 0 -8.8817843e-017 0.40000001 0.10000002 -8.8817843e-017 0.40000001 0.19999999 
		-8.8817843e-017 0.40000001 0.30000001 -8.8817843e-017 0.40000001 0.40000004 -8.8817843e-017 
		0.40000001 0.5 -8.8817843e-017 0.40000001 -0.5 -6.6613384e-017 0.30000001 -0.40000001 
		-6.6613384e-017 0.30000001 -0.30000001 -6.6613384e-017 0.30000001 -0.19999999 -6.6613384e-017 
		0.30000001 -0.099999994 -6.6613384e-017 0.30000001 0 -6.6613384e-017 0.30000001 0.10000002 
		-6.6613384e-017 0.30000001 0.19999999 -6.6613384e-017 0.30000001 0.30000001 -6.6613384e-017 
		0.30000001 0.40000004 -6.6613384e-017 0.30000001 0.5 -6.6613384e-017 0.30000001 -0.5 
		-4.4408918e-017 0.19999999 -0.40000001 -4.4408918e-017 0.19999999 -0.30000001 -4.4408918e-017 
		0.19999999 -0.19999999 -4.4408918e-017 0.19999999 -0.099999994 -4.4408918e-017 0.19999999 
		0 -4.4408918e-017 0.19999999 0.10000002 -4.4408918e-017 0.19999999 0.19999999 -4.4408918e-017 
		0.19999999 0.30000001 -4.4408918e-017 0.19999999 0.40000004 -4.4408918e-017 0.19999999 
		0.5 -4.4408918e-017 0.19999999 -0.5 -2.2204459e-017 0.099999994 -0.40000001 -2.2204459e-017 
		0.099999994 -0.30000001 -2.2204459e-017 0.099999994 -0.19999999 -2.2204459e-017 0.099999994 
		-0.099999994 -2.2204459e-017 0.099999994 0 -2.2204459e-017 0.099999994 0.10000002 
		-2.2204459e-017 0.099999994 0.19999999 -2.2204459e-017 0.099999994 0.30000001 -2.2204459e-017 
		0.099999994 0.40000004 -2.2204459e-017 0.099999994 0.5 -2.2204459e-017 0.099999994 
		-0.5 0 0 -0.40000001 0 0 -0.30000001 0 0 -0.19999999 0 0 -0.099999994 0 0 0 0 0 0.10000002 
		0 0 0.19999999 0 0 0.30000001 0 0 0.40000004 0 0 0.5 0 0 -0.5 2.2204466e-017 -0.10000002 
		-0.40000001 2.2204466e-017 -0.10000002 -0.30000001 2.2204466e-017 -0.10000002 -0.19999999 
		2.2204466e-017 -0.10000002 -0.099999994 2.2204466e-017 -0.10000002 0 2.2204466e-017 
		-0.10000002 0.10000002 2.2204466e-017 -0.10000002 0.19999999 2.2204466e-017 -0.10000002 
		0.30000001 2.2204466e-017 -0.10000002 0.40000004 2.2204466e-017 -0.10000002 0.5 2.2204466e-017 
		-0.10000002 -0.5 4.4408918e-017 -0.19999999 -0.40000001 4.4408918e-017 -0.19999999 
		-0.30000001 4.4408918e-017 -0.19999999 -0.19999999 4.4408918e-017 -0.19999999 -0.099999994 
		4.4408918e-017 -0.19999999 0 4.4408918e-017 -0.19999999 0.10000002 4.4408918e-017 
		-0.19999999 0.19999999 4.4408918e-017 -0.19999999 0.30000001 4.4408918e-017 -0.19999999 
		0.40000004 4.4408918e-017 -0.19999999 0.5 4.4408918e-017 -0.19999999 -0.5 6.6613384e-017 
		-0.30000001 -0.40000001 6.6613384e-017 -0.30000001 -0.30000001 6.6613384e-017 -0.30000001 
		-0.19999999 6.6613384e-017 -0.30000001 -0.099999994 6.6613384e-017 -0.30000001 0 
		6.6613384e-017 -0.30000001 0.10000002 6.6613384e-017 -0.30000001 0.19999999 6.6613384e-017 
		-0.30000001 0.30000001 6.6613384e-017 -0.30000001 0.40000004 6.6613384e-017 -0.30000001 
		0.5 6.6613384e-017 -0.30000001 -0.5 8.881785e-017 -0.40000004 -0.40000001 8.881785e-017 
		-0.40000004 -0.30000001 8.881785e-017 -0.40000004 -0.19999999 8.881785e-017 -0.40000004 
		-0.099999994 8.881785e-017 -0.40000004 0 8.881785e-017 -0.40000004 0.10000002 8.881785e-017 
		-0.40000004 0.19999999 8.881785e-017 -0.40000004 0.30000001 8.881785e-017 -0.40000004 
		0.40000004 8.881785e-017 -0.40000004 0.5 8.881785e-017 -0.40000004 -0.5 1.110223e-016 
		-0.5 -0.40000001 1.110223e-016 -0.5 -0.30000001 1.110223e-016 -0.5 -0.19999999 1.110223e-016 
		-0.5 -0.099999994 1.110223e-016 -0.5 0 1.110223e-016 -0.5 0.10000002 1.110223e-016 
		-0.5 0.19999999 1.110223e-016 -0.5 0.30000001 1.110223e-016 -0.5 0.40000004 1.110223e-016 
		-0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 220 ".ed";
	setAttr ".ed[0:165]"  0 1 0 0 11 0 1 2 
		0 1 12 1 2 3 0 2 13 1 3 4 
		0 3 14 1 4 5 0 4 15 1 5 6 
		0 5 16 1 6 7 0 6 17 1 7 8 
		0 7 18 1 8 9 0 8 19 1 9 10 
		0 9 20 1 10 21 0 11 12 1 11 22 
		0 12 13 1 12 23 1 13 14 1 13 24 
		1 14 15 1 14 25 1 15 16 1 15 26 
		1 16 17 1 16 27 1 17 18 1 17 28 
		1 18 19 1 18 29 1 19 20 1 19 30 
		1 20 21 1 20 31 1 21 32 0 22 23 
		1 22 33 0 23 24 1 23 34 1 24 25 
		1 24 35 1 25 26 1 25 36 1 26 27 
		1 26 37 1 27 28 1 27 38 1 28 29 
		1 28 39 1 29 30 1 29 40 1 30 31 
		1 30 41 1 31 32 1 31 42 1 32 43 
		0 33 34 1 33 44 0 34 35 1 34 45 
		1 35 36 1 35 46 1 36 37 1 36 47 
		1 37 38 1 37 48 1 38 39 1 38 49 
		1 39 40 1 39 50 1 40 41 1 40 51 
		1 41 42 1 41 52 1 42 43 1 42 53 
		1 43 54 0 44 45 1 44 55 0 45 46 
		1 45 56 1 46 47 1 46 57 1 47 48 
		1 47 58 1 48 49 1 48 59 1 49 50 
		1 49 60 1 50 51 1 50 61 1 51 52 
		1 51 62 1 52 53 1 52 63 1 53 54 
		1 53 64 1 54 65 0 55 56 1 55 66 
		0 56 57 1 56 67 1 57 58 1 57 68 
		1 58 59 1 58 69 1 59 60 1 59 70 
		1 60 61 1 60 71 1 61 62 1 61 72 
		1 62 63 1 62 73 1 63 64 1 63 74 
		1 64 65 1 64 75 1 65 76 0 66 67 
		1 66 77 0 67 68 1 67 78 1 68 69 
		1 68 79 1 69 70 1 69 80 1 70 71 
		1 70 81 1 71 72 1 71 82 1 72 73 
		1 72 83 1 73 74 1 73 84 1 74 75 
		1 74 85 1 75 76 1 75 86 1 76 87 
		0 77 78 1 77 88 0 78 79 1 78 89 
		1 79 80 1 79 90 1 80 81 1 80 91 
		1 81 82 1 81 92 1 82 83 1 82 93 
		1 83 84 1 83 94 1 84 85 1 84 95 
		1 85 86 1 85 96 1 86 87 1;
	setAttr ".ed[166:219]" 86 97 1 87 98 0 88 89 
		1 88 99 0 89 90 1 89 100 1 90 91 
		1 90 101 1 91 92 1 91 102 1 92 93 
		1 92 103 1 93 94 1 93 104 1 94 95 
		1 94 105 1 95 96 1 95 106 1 96 97 
		1 96 107 1 97 98 1 97 108 1 98 109 
		0 99 100 1 99 110 0 100 101 1 100 111 
		1 101 102 1 101 112 1 102 103 1 102 113 
		1 103 104 1 103 114 1 104 105 1 104 115 
		1 105 106 1 105 116 1 106 107 1 106 117 
		1 107 108 1 107 118 1 108 109 1 108 119 
		1 109 120 0 110 111 0 111 112 0 112 113 
		0 113 114 0 114 115 0 115 116 0 116 117 
		0 117 118 0 118 119 0 119 120 0;
	setAttr -s 100 ".fc[0:99]" -type "polyFaces" 
		f 4 0 3 -22 -2 
		mu 0 4 0 1 12 11 
		f 4 2 5 -24 -4 
		mu 0 4 1 2 13 12 
		f 4 4 7 -26 -6 
		mu 0 4 2 3 14 13 
		f 4 6 9 -28 -8 
		mu 0 4 3 4 15 14 
		f 4 8 11 -30 -10 
		mu 0 4 4 5 16 15 
		f 4 10 13 -32 -12 
		mu 0 4 5 6 17 16 
		f 4 12 15 -34 -14 
		mu 0 4 6 7 18 17 
		f 4 14 17 -36 -16 
		mu 0 4 7 8 19 18 
		f 4 16 19 -38 -18 
		mu 0 4 8 9 20 19 
		f 4 18 20 -40 -20 
		mu 0 4 9 10 21 20 
		f 4 21 24 -43 -23 
		mu 0 4 11 12 23 22 
		f 4 23 26 -45 -25 
		mu 0 4 12 13 24 23 
		f 4 25 28 -47 -27 
		mu 0 4 13 14 25 24 
		f 4 27 30 -49 -29 
		mu 0 4 14 15 26 25 
		f 4 29 32 -51 -31 
		mu 0 4 15 16 27 26 
		f 4 31 34 -53 -33 
		mu 0 4 16 17 28 27 
		f 4 33 36 -55 -35 
		mu 0 4 17 18 29 28 
		f 4 35 38 -57 -37 
		mu 0 4 18 19 30 29 
		f 4 37 40 -59 -39 
		mu 0 4 19 20 31 30 
		f 4 39 41 -61 -41 
		mu 0 4 20 21 32 31 
		f 4 42 45 -64 -44 
		mu 0 4 22 23 34 33 
		f 4 44 47 -66 -46 
		mu 0 4 23 24 35 34 
		f 4 46 49 -68 -48 
		mu 0 4 24 25 36 35 
		f 4 48 51 -70 -50 
		mu 0 4 25 26 37 36 
		f 4 50 53 -72 -52 
		mu 0 4 26 27 38 37 
		f 4 52 55 -74 -54 
		mu 0 4 27 28 39 38 
		f 4 54 57 -76 -56 
		mu 0 4 28 29 40 39 
		f 4 56 59 -78 -58 
		mu 0 4 29 30 41 40 
		f 4 58 61 -80 -60 
		mu 0 4 30 31 42 41 
		f 4 60 62 -82 -62 
		mu 0 4 31 32 43 42 
		f 4 63 66 -85 -65 
		mu 0 4 33 34 45 44 
		f 4 65 68 -87 -67 
		mu 0 4 34 35 46 45 
		f 4 67 70 -89 -69 
		mu 0 4 35 36 47 46 
		f 4 69 72 -91 -71 
		mu 0 4 36 37 48 47 
		f 4 71 74 -93 -73 
		mu 0 4 37 38 49 48 
		f 4 73 76 -95 -75 
		mu 0 4 38 39 50 49 
		f 4 75 78 -97 -77 
		mu 0 4 39 40 51 50 
		f 4 77 80 -99 -79 
		mu 0 4 40 41 52 51 
		f 4 79 82 -101 -81 
		mu 0 4 41 42 53 52 
		f 4 81 83 -103 -83 
		mu 0 4 42 43 54 53 
		f 4 84 87 -106 -86 
		mu 0 4 44 45 56 55 
		f 4 86 89 -108 -88 
		mu 0 4 45 46 57 56 
		f 4 88 91 -110 -90 
		mu 0 4 46 47 58 57 
		f 4 90 93 -112 -92 
		mu 0 4 47 48 59 58 
		f 4 92 95 -114 -94 
		mu 0 4 48 49 60 59 
		f 4 94 97 -116 -96 
		mu 0 4 49 50 61 60 
		f 4 96 99 -118 -98 
		mu 0 4 50 51 62 61 
		f 4 98 101 -120 -100 
		mu 0 4 51 52 63 62 
		f 4 100 103 -122 -102 
		mu 0 4 52 53 64 63 
		f 4 102 104 -124 -104 
		mu 0 4 53 54 65 64 
		f 4 105 108 -127 -107 
		mu 0 4 55 56 67 66 
		f 4 107 110 -129 -109 
		mu 0 4 56 57 68 67 
		f 4 109 112 -131 -111 
		mu 0 4 57 58 69 68 
		f 4 111 114 -133 -113 
		mu 0 4 58 59 70 69 
		f 4 113 116 -135 -115 
		mu 0 4 59 60 71 70 
		f 4 115 118 -137 -117 
		mu 0 4 60 61 72 71 
		f 4 117 120 -139 -119 
		mu 0 4 61 62 73 72 
		f 4 119 122 -141 -121 
		mu 0 4 62 63 74 73 
		f 4 121 124 -143 -123 
		mu 0 4 63 64 75 74 
		f 4 123 125 -145 -125 
		mu 0 4 64 65 76 75 
		f 4 126 129 -148 -128 
		mu 0 4 66 67 78 77 
		f 4 128 131 -150 -130 
		mu 0 4 67 68 79 78 
		f 4 130 133 -152 -132 
		mu 0 4 68 69 80 79 
		f 4 132 135 -154 -134 
		mu 0 4 69 70 81 80 
		f 4 134 137 -156 -136 
		mu 0 4 70 71 82 81 
		f 4 136 139 -158 -138 
		mu 0 4 71 72 83 82 
		f 4 138 141 -160 -140 
		mu 0 4 72 73 84 83 
		f 4 140 143 -162 -142 
		mu 0 4 73 74 85 84 
		f 4 142 145 -164 -144 
		mu 0 4 74 75 86 85 
		f 4 144 146 -166 -146 
		mu 0 4 75 76 87 86 
		f 4 147 150 -169 -149 
		mu 0 4 77 78 89 88 
		f 4 149 152 -171 -151 
		mu 0 4 78 79 90 89 
		f 4 151 154 -173 -153 
		mu 0 4 79 80 91 90 
		f 4 153 156 -175 -155 
		mu 0 4 80 81 92 91 
		f 4 155 158 -177 -157 
		mu 0 4 81 82 93 92 
		f 4 157 160 -179 -159 
		mu 0 4 82 83 94 93 
		f 4 159 162 -181 -161 
		mu 0 4 83 84 95 94 
		f 4 161 164 -183 -163 
		mu 0 4 84 85 96 95 
		f 4 163 166 -185 -165 
		mu 0 4 85 86 97 96 
		f 4 165 167 -187 -167 
		mu 0 4 86 87 98 97 
		f 4 168 171 -190 -170 
		mu 0 4 88 89 100 99 
		f 4 170 173 -192 -172 
		mu 0 4 89 90 101 100 
		f 4 172 175 -194 -174 
		mu 0 4 90 91 102 101 
		f 4 174 177 -196 -176 
		mu 0 4 91 92 103 102 
		f 4 176 179 -198 -178 
		mu 0 4 92 93 104 103 
		f 4 178 181 -200 -180 
		mu 0 4 93 94 105 104 
		f 4 180 183 -202 -182 
		mu 0 4 94 95 106 105 
		f 4 182 185 -204 -184 
		mu 0 4 95 96 107 106 
		f 4 184 187 -206 -186 
		mu 0 4 96 97 108 107 
		f 4 186 188 -208 -188 
		mu 0 4 97 98 109 108 
		f 4 189 192 -211 -191 
		mu 0 4 99 100 111 110 
		f 4 191 194 -212 -193 
		mu 0 4 100 101 112 111 
		f 4 193 196 -213 -195 
		mu 0 4 101 102 113 112 
		f 4 195 198 -214 -197 
		mu 0 4 102 103 114 113 
		f 4 197 200 -215 -199 
		mu 0 4 103 104 115 114 
		f 4 199 202 -216 -201 
		mu 0 4 104 105 116 115 
		f 4 201 204 -217 -203 
		mu 0 4 105 106 117 116 
		f 4 203 206 -218 -205 
		mu 0 4 106 107 118 117 
		f 4 205 208 -219 -207 
		mu 0 4 107 108 119 118 
		f 4 207 209 -220 -209 
		mu 0 4 108 109 120 119 ;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
createNode pointEmitter -n "RainEmitter" -p "RainPlane";
	setAttr ".emt" 2;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".max" 0.01;
	setAttr ".min" 0.005;
	setAttr ".spd" 0;
	setAttr ".nspd" 0;
createNode transform -n "RainSurfaceTrailEmitterParticles";
	setAttr ".v" no;
createNode nParticle -n "RainSurfaceTrailEmitterParticlesShape" -p "RainSurfaceTrailEmitterParticles";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
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
	setAttr ".inh" 0.178;
	setAttr ".cts" 1;
	setAttr ".chw" 204;
	setAttr ".prt" 7;
	setAttr ".fron" 0;
	setAttr ".clst" 0.016877638176083565;
	setAttr ".cofl" 1;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr ".pff" 1;
	setAttr ".sfat" 2.4050633907318115;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".drg" 0;
	setAttr ".esph" yes;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".thr" 0.6;
	setAttr ".rdc[0]"  0 1 1;
	setAttr ".rci" 2;
	setAttr ".mssc[0]"  0 1 1;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".op" 0.3;
	setAttr ".opc[0]"  0 1 1;
	setAttr ".oci" 1;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.5 0.69999999 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".coi" 1;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 10;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
createNode pointEmitter -n "RainTrailEmitter" -p "RainSurfaceTrailEmitterParticles";
	setAttr ".rat" 50;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".max" 0.01;
	setAttr ".min" 0.005;
	setAttr ".spd" 0;
	setAttr ".nspd" 0;
createNode container -n "RainAsset";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".isc" yes;
	setAttr -s 15 ".boc";
	setAttr ".ctor" -type "string" "";
	setAttr ".cdat" -type "string" "2010/07/02 20:35:47";
	setAttr ".ctyp" -type "string" "effects";
	setAttr ".aal" -type "attributeAlias" {"RainPlaneSize","borderConnections[0]","RainVortexMagnitude"
		,"borderConnections[10]","colorSaturation","borderConnections[11]","colorValue","borderConnections[12]"
		,"RainStart","borderConnections[13]","RainSpeed","borderConnections[14]","RainAmount"
		,"borderConnections[1]","RainTurbulence","borderConnections[2]","RainDropSize","borderConnections[3]"
		,"RainWindSpeed","borderConnections[4]","RainWindAngle","borderConnections[5]","RainRandomSize"
		,"borderConnections[6]","RainDiesLevel","borderConnections[7]","RainHue","borderConnections[8]"
		,"RainTransparency","borderConnections[9]","child","canBeChild[0]","nucleusSolver"
		,"publishedNodeInfo[0]"} ;
	setAttr ".nts" -type "string" "nParticle effect- This is a freestanding effect that  does not need to be applied to an object in the scene since it has a rain emitter plane that can be placed as needed. Selecting meshes in the scene, then selecting Collide with Effect, creates a collision event defined for the  for the rain particles that creates water trails running down the collision objects. ";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 5 ".lnk";
	setAttr -s 5 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lambert -n "lambert2";
	setAttr ".dc" 0.68374001979827881;
	setAttr ".c" -type "float3" 0.82296485 0.7291829 0.70612651 ;
createNode geoConnector -n "geoConnector1";
createNode nucleus -n "RainNucleus";
	setAttr -s 3 ".niao";
	setAttr -s 3 ".nias";
	setAttr -s 3 ".noao";
	setAttr -l on ".stf";
	setAttr ".widi" -type "float3" 1 1 1 ;
	setAttr ".wnoi" 1;
	setAttr ".clra" 2.2000000476837158;
	setAttr ".sstp" 4;
	setAttr ".mcit" 9;
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "nParticleWaterSE";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode blinn -n "RainShader";
	setAttr ".rfi" 1.2999999523162842;
	setAttr ".rfc" yes;
	setAttr ".dc" 0.78881984949111938;
	setAttr ".sc" -type "float3" 1 1 1 ;
	setAttr ".rfl" 0.18633539974689484;
	setAttr ".ec" 0.012421118095517159;
	setAttr ".sro" 0.96583849191665649;
createNode particleSamplerInfo -n "particleSamplerInfo1";
createNode particleCloud -n "npWaterVolume";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 204 -ast 1 -aet 204 ";
	setAttr ".st" 6;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 28 ".hyp";
	setAttr ".hyp[0].x" 71;
	setAttr ".hyp[0].y" 1997;
	setAttr ".hyp[0].isf" yes;
	setAttr ".hyp[1].x" 71;
	setAttr ".hyp[1].y" 1997;
	setAttr ".hyp[1].isf" yes;
	setAttr ".hyp[2].x" 663;
	setAttr ".hyp[2].y" 1997;
	setAttr ".hyp[2].isf" yes;
	setAttr ".hyp[3].x" 1091;
	setAttr ".hyp[3].y" 2021;
	setAttr ".hyp[3].isf" yes;
	setAttr ".hyp[4].x" 737;
	setAttr ".hyp[4].y" 413;
	setAttr ".hyp[4].isf" yes;
	setAttr ".hyp[5].x" 1086;
	setAttr ".hyp[5].y" 440;
	setAttr ".hyp[5].isf" yes;
	setAttr ".hyp[6].x" 1403;
	setAttr ".hyp[6].y" 555;
	setAttr ".hyp[6].isf" yes;
	setAttr ".hyp[7].x" 379;
	setAttr ".hyp[7].y" 575;
	setAttr ".hyp[7].isf" yes;
	setAttr ".hyp[8].x" 379;
	setAttr ".hyp[8].y" 1997;
	setAttr ".hyp[8].isf" yes;
	setAttr ".hyp[9].x" 2350;
	setAttr ".hyp[9].y" 2116;
	setAttr ".hyp[9].isf" yes;
	setAttr ".hyp[10].x" 138;
	setAttr ".hyp[10].y" 1172;
	setAttr ".hyp[10].isf" yes;
	setAttr ".hyp[11].x" 2538;
	setAttr ".hyp[11].y" 2116;
	setAttr ".hyp[11].isf" yes;
	setAttr ".hyp[12].x" 58;
	setAttr ".hyp[12].y" 252;
	setAttr ".hyp[12].isf" yes;
	setAttr ".hyp[13].x" 663;
	setAttr ".hyp[13].y" 1477;
	setAttr ".hyp[13].isf" yes;
	setAttr ".hyp[14].x" 663;
	setAttr ".hyp[14].y" 1477;
	setAttr ".hyp[14].isf" yes;
	setAttr ".hyp[15].x" 663;
	setAttr ".hyp[15].y" 1477;
	setAttr ".hyp[15].isf" yes;
	setAttr ".hyp[16].x" 663;
	setAttr ".hyp[16].y" 1477;
	setAttr ".hyp[16].isf" yes;
	setAttr ".hyp[17].x" 1290;
	setAttr ".hyp[17].y" 1474;
	setAttr ".hyp[17].isf" yes;
	setAttr ".hyp[18].x" 663;
	setAttr ".hyp[18].y" 1737;
	setAttr ".hyp[18].isf" yes;
	setAttr ".anf" yes;
createNode unitConversion -n "unitConversion1";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion2";
	setAttr ".i" -45;
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion3";
createNode unitConversion -n "unitConversion4";
createNode hsvToRgb -n "hsvToRgb1";
	setAttr ".arp" 2;
createNode place2dTexture -n "place2dTexture1";
createNode shadingEngine -n "lambert3SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode multiplyDivide -n "multiplyDivide1";
	setAttr ".i2" -type "float3" 9.8000002 1 1 ;
	setAttr -av ".i2x";
createNode condition -n "condEndBeforeStartTest";
	setAttr ".op" 2;
createNode condition -n "conditionTurnOff";
	setAttr ".op" 2;
	setAttr ".cf" -type "float3" 0 1 1 ;
createNode timeToUnitConversion -n "timeToUnitConversion1";
	setAttr ".cf" 0.004;
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
	setAttr -s 5 ".st";
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
select -ne :lightList1;
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 7 ".u";
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
connectAttr ":time1.o" "RainParticlesShape.cti";
connectAttr "RainNucleus.noao[3]" "RainParticlesShape.nxst";
connectAttr "channels.RainStart" "RainParticlesShape.stf";
connectAttr "RainEmitter.ot[0]" "RainParticlesShape.npt[0]";
connectAttr "RainParticlesShape.incr" "RainParticlesShape.rgbPP";
connectAttr "RainParticlesShape.inor" "RainParticlesShape.opacityPP";
connectAttr "RainSurfaceTrailEmitterParticlesShape.msg" "RainParticlesShape.etg[0]"
		;
connectAttr "RainTurbulence.of[0]" "RainParticlesShape.ifc[0]";
connectAttr "RainWind1.of[0]" "RainParticlesShape.ifc[1]";
connectAttr "RainVortex.of[0]" "RainParticlesShape.ifc[2]";
connectAttr "channels.RainDropSize" "RainParticlesShape.ra";
connectAttr "channels.RainRandomSize" "RainParticlesShape.rsr";
connectAttr "RainParticlesShape.pos" "RainParticlesShape.xi[0]";
connectAttr "channels.RainDiesLevel" "RainParticlesShape.xi[1]";
connectAttr "channels.RainTransparency" "RainParticlesShape.op";
connectAttr "hsvToRgb1.o" "RainParticlesShape.cl[0].clc";
connectAttr "RainParticlesShape.xo[0]" "RainParticlesShape.lifespanPP";
connectAttr ":time1.o" "RainTrailsShape.cti";
connectAttr "RainNucleus.noao[1]" "RainTrailsShape.nxst";
connectAttr "RainNucleus.stf" "RainTrailsShape.stf";
connectAttr "RainTrailEmitter.ot[0]" "RainTrailsShape.npt[0]";
connectAttr "RainTrailsShape.incr" "RainTrailsShape.rgbPP";
connectAttr "RainTrailsShape.inor" "RainTrailsShape.opacityPP";
connectAttr "RainTrailsShape.inrr" "RainTrailsShape.radiusPP";
connectAttr "channels.RainDropSize" "RainTrailsShape.ra";
connectAttr "RainTrailsShape.pos" "RainTrailsShape.xi[0]";
connectAttr "channels.RainDiesLevel" "RainTrailsShape.xi[1]";
connectAttr "hsvToRgb1.o" "RainTrailsShape.cl[0].clc";
connectAttr "channels.RainTransparency" "RainTrailsShape.op";
connectAttr "RainTrailsShape.xo[0]" "RainTrailsShape.lifespanPP";
connectAttr "RainCTRLShape.wm" "channelsShape.dom" -na;
connectAttr "RainParticlesShape.fd" "RainTurbulence.ind[0]";
connectAttr "RainParticlesShape.ppfd[0]" "RainTurbulence.ppda[0]";
connectAttr "channels.RainTurbulence" "RainTurbulence.mag";
connectAttr "RainParticlesShape.fd" "RainWind1.ind[0]";
connectAttr "RainParticlesShape.ppfd[1]" "RainWind1.ppda[0]";
connectAttr "unitConversion2.o" "RainWind1.rx";
connectAttr "unitConversion1.o" "RainWind1.ry";
connectAttr "channels.RainWindSpeed" "RainWind1.mag";
connectAttr "RainParticlesShape.fd" "RainVortex.ind[0]";
connectAttr "RainParticlesShape.ppfd[2]" "RainVortex.ppda[0]";
connectAttr "channels.RainVortexMagnitude" "RainVortex.mag";
connectAttr "channels.RainPlaneSize" "RainPlane.sx";
connectAttr "channels.RainPlaneSize" "RainPlane.sy";
connectAttr "channels.RainPlaneSize" "RainPlane.sz";
connectAttr ":time1.o" "RainEmitter.ct";
connectAttr "geoConnector1.ocd" "RainEmitter.ocd";
connectAttr "geoConnector1.ocl" "RainEmitter.t";
connectAttr "geoConnector1.pos" "RainEmitter.opd";
connectAttr "geoConnector1.vel" "RainEmitter.ovd";
connectAttr "geoConnector1.swg" "RainEmitter.swge";
connectAttr "RainParticlesShape.ifl" "RainEmitter.full[0]";
connectAttr "RainParticlesShape.tss" "RainEmitter.dt[0]";
connectAttr "RainParticlesShape.inh" "RainEmitter.inh[0]";
connectAttr "RainParticlesShape.stt" "RainEmitter.stt[0]";
connectAttr "RainParticlesShape.sd[0]" "RainEmitter.sd[0]";
connectAttr "conditionTurnOff.ocr" "RainEmitter.rat";
connectAttr ":time1.o" "RainSurfaceTrailEmitterParticlesShape.cti";
connectAttr "RainNucleus.noao[0]" "RainSurfaceTrailEmitterParticlesShape.nxst";
connectAttr "RainNucleus.stf" "RainSurfaceTrailEmitterParticlesShape.stf";
connectAttr "RainSurfaceTrailEmitterParticlesShape.incr" "RainSurfaceTrailEmitterParticlesShape.rgbPP"
		;
connectAttr "RainSurfaceTrailEmitterParticlesShape.inor" "RainSurfaceTrailEmitterParticlesShape.opacityPP"
		;
connectAttr "RainSurfaceTrailEmitterParticlesShape.inrr" "RainSurfaceTrailEmitterParticlesShape.radiusPP"
		;
connectAttr ":time1.o" "RainTrailEmitter.ct";
connectAttr "RainSurfaceTrailEmitterParticlesShape.cwcn" "RainTrailEmitter.ocd";
connectAttr "RainSurfaceTrailEmitterParticlesShape.ctd" "RainTrailEmitter.t";
connectAttr "RainSurfaceTrailEmitterParticlesShape.cwps" "RainTrailEmitter.opd";
connectAttr "RainSurfaceTrailEmitterParticlesShape.cwvl" "RainTrailEmitter.ovd";
connectAttr "RainSurfaceTrailEmitterParticlesShape.id" "RainTrailEmitter.paid";
connectAttr "RainTrailsShape.ifl" "RainTrailEmitter.full[0]";
connectAttr "RainTrailsShape.tss" "RainTrailEmitter.dt[0]";
connectAttr "RainTrailsShape.inh" "RainTrailEmitter.inh[0]";
connectAttr "RainTrailsShape.stt" "RainTrailEmitter.stt[0]";
connectAttr "RainTrailsShape.sd[0]" "RainTrailEmitter.sd[0]";
connectAttr "hyperLayout1.msg" "RainAsset.hl";
connectAttr "emissionGroup.msg" "RainAsset.cbc[0]";
connectAttr "channels.RainPlaneSize" "RainAsset.boc[0]";
connectAttr "channels.RainAmount" "RainAsset.boc[1]";
connectAttr "channels.RainTurbulence" "RainAsset.boc[2]";
connectAttr "channels.RainDropSize" "RainAsset.boc[3]";
connectAttr "channels.RainWindSpeed" "RainAsset.boc[4]";
connectAttr "channels.RainWindAngle" "RainAsset.boc[5]";
connectAttr "channels.RainRandomSize" "RainAsset.boc[6]";
connectAttr "channels.RainDiesLevel" "RainAsset.boc[7]";
connectAttr "channels.RainHue" "RainAsset.boc[8]";
connectAttr "channels.RainTransparency" "RainAsset.boc[9]";
connectAttr "channels.RainVortexMagnitude" "RainAsset.boc[10]";
connectAttr "channels.colorSaturation" "RainAsset.boc[11]";
connectAttr "channels.colorValue" "RainAsset.boc[12]";
connectAttr "channels.RainStart" "RainAsset.boc[13]";
connectAttr "channels.RainSpeed" "RainAsset.boc[14]";
connectAttr "RainNucleus.msg" "RainAsset.pni[0].pnod";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "nParticleWaterSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert3SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "nParticleWaterSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert3SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "lambert2SG.msg" "materialInfo2.sg";
connectAttr "lambert2.msg" "materialInfo2.m";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr ":time1.o" "geoConnector1.ct";
connectAttr "RainPlaneShape.o" "geoConnector1.lge";
connectAttr "RainPlaneShape.wm" "geoConnector1.wm";
connectAttr "RainPlaneShape.msg" "geoConnector1.own";
connectAttr ":time1.o" "RainNucleus.cti";
connectAttr "RainSurfaceTrailEmitterParticlesShape.cust" "RainNucleus.niao[0]";
connectAttr "RainTrailsShape.cust" "RainNucleus.niao[1]";
connectAttr "RainParticlesShape.cust" "RainNucleus.niao[3]";
connectAttr "RainSurfaceTrailEmitterParticlesShape.stst" "RainNucleus.nias[0]";
connectAttr "RainTrailsShape.stst" "RainNucleus.nias[1]";
connectAttr "RainParticlesShape.stst" "RainNucleus.nias[3]";
connectAttr "multiplyDivide1.ox" "RainNucleus.grty";
connectAttr "nParticleWaterSE.msg" "materialInfo3.sg";
connectAttr "RainShader.msg" "materialInfo3.m";
connectAttr "hsvToRgb1.msg" "materialInfo3.t" -na;
connectAttr "RainShader.oc" "nParticleWaterSE.ss";
connectAttr "npWaterVolume.oi" "nParticleWaterSE.vs";
connectAttr "RainParticlesShape.iog" "nParticleWaterSE.dsm" -na;
connectAttr "RainSurfaceTrailEmitterParticlesShape.iog" "nParticleWaterSE.dsm" -na
		;
connectAttr "RainTrailsShape.iog" "nParticleWaterSE.dsm" -na;
connectAttr "hsvToRgb1.o" "RainShader.c";
connectAttr "channels.RainTransparency" "RainShader.itr";
connectAttr "channels.RainTransparency" "RainShader.itg";
connectAttr "channels.RainTransparency" "RainShader.itb";
connectAttr "particleSamplerInfo1.ot" "npWaterVolume.t";
connectAttr "particleSamplerInfo1.oc" "npWaterVolume.c";
connectAttr "particleSamplerInfo1.oi" "npWaterVolume.i";
connectAttr "RainCTRL.msg" "hyperLayout1.hyp[0].dn";
connectAttr "RainPlaneShape.msg" "hyperLayout1.hyp[1].dn";
connectAttr "RainEmitter.msg" "hyperLayout1.hyp[2].dn";
connectAttr "RainParticlesShape.msg" "hyperLayout1.hyp[3].dn";
connectAttr "RainSurfaceTrailEmitterParticlesShape.msg" "hyperLayout1.hyp[4].dn"
		;
connectAttr "RainTrailEmitter.msg" "hyperLayout1.hyp[5].dn";
connectAttr "RainTrailsShape.msg" "hyperLayout1.hyp[6].dn";
connectAttr "RainNucleus.msg" "hyperLayout1.hyp[7].dn";
connectAttr "geoConnector1.msg" "hyperLayout1.hyp[8].dn";
connectAttr "RainCTRLShape.msg" "hyperLayout1.hyp[9].dn";
connectAttr "channels.msg" "hyperLayout1.hyp[10].dn";
connectAttr "channelsShape.msg" "hyperLayout1.hyp[11].dn";
connectAttr "RainPlane.msg" "hyperLayout1.hyp[12].dn";
connectAttr "RainParticles.msg" "hyperLayout1.hyp[13].dn";
connectAttr "RainSurfaceTrailEmitterParticles.msg" "hyperLayout1.hyp[14].dn";
connectAttr "RainTrails.msg" "hyperLayout1.hyp[15].dn";
connectAttr "RainTurbulence.msg" "hyperLayout1.hyp[16].dn";
connectAttr "RainWind1.msg" "hyperLayout1.hyp[17].dn";
connectAttr "RainVortex.msg" "hyperLayout1.hyp[18].dn";
connectAttr "emissionGroup.msg" "hyperLayout1.hyp[19].dn";
connectAttr "unitConversion2.msg" "hyperLayout1.hyp[20].dn";
connectAttr "conditionTurnOff.msg" "hyperLayout1.hyp[21].dn";
connectAttr "timeToUnitConversion1.msg" "hyperLayout1.hyp[22].dn";
connectAttr "hsvToRgb1.msg" "hyperLayout1.hyp[23].dn";
connectAttr "unitConversion1.msg" "hyperLayout1.hyp[24].dn";
connectAttr "multiplyDivide1.msg" "hyperLayout1.hyp[25].dn";
connectAttr "condEndBeforeStartTest.msg" "hyperLayout1.hyp[26].dn";
connectAttr "RainShader.msg" "hyperLayout1.hyp[27].dn";
connectAttr "channels.RainWindAngle" "unitConversion1.i";
connectAttr "channels.RainHue" "hsvToRgb1.ir";
connectAttr "channels.colorValue" "hsvToRgb1.ib";
connectAttr "channels.colorSaturation" "hsvToRgb1.ig";
connectAttr "lambert3SG.msg" "materialInfo4.sg";
connectAttr "channels.RainSpeed" "multiplyDivide1.i1x";
connectAttr "channels.RainStart" "condEndBeforeStartTest.st";
connectAttr "channels.RainEnd" "condEndBeforeStartTest.ft";
connectAttr "channels.RainStart" "condEndBeforeStartTest.cfr";
connectAttr "channels.RainEnd" "condEndBeforeStartTest.ctr";
connectAttr "channels.RainEnd" "conditionTurnOff.ft";
connectAttr "timeToUnitConversion1.o" "conditionTurnOff.st";
connectAttr "channels.RainAmount" "conditionTurnOff.ctr";
connectAttr "RainParticlesShape.cti" "timeToUnitConversion1.i";
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "nParticleWaterSE.pa" ":renderPartition.st" -na;
connectAttr "lambert3SG.pa" ":renderPartition.st" -na;
connectAttr "RainPlaneShape.iog" ":initialShadingGroup.dsm" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "RainShader.msg" ":defaultShaderList1.s" -na;
connectAttr "npWaterVolume.msg" ":defaultShaderList1.s" -na;
connectAttr "spotLightShape1.ltd" ":lightList1.l" -na;
connectAttr "unitConversion3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "unitConversion4.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "hsvToRgb1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "multiplyDivide1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "condEndBeforeStartTest.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "conditionTurnOff.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "spotLight1.iog" ":defaultLightSet.dsm" -na;
// End of Rain.ma
