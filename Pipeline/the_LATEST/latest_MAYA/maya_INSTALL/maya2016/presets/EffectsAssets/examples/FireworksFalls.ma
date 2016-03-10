//Maya ASCII 2011 scene
//Name: fireworkSilverFallsMod2.ma
//Last modified: Thu, Aug 19, 2010 05:56:14 PM
//Codeset: 1252
requires maya "2011";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2011";
fileInfo "version" "2011";
fileInfo "cutIdentifier" "201007310527-779257";
fileInfo "osv" "Microsoft Windows XP Professional Service Pack 3 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".t" -type "double3" 2.1880711843151897 -1.9759525324498064 28.511325752772841 ;
	setAttr ".r" -type "double3" -0.33835272960257057 2.5999999999999908 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v";
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 28.930630328762099;
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
createNode pointEmitter -n "primaryEmitter";
	setAttr ".r" -type "double3" -3.5051356913925851 -10.923375832580826 11.332598209771218 ;
	setAttr ".s" -type "double3" 0.13333334040479167 0.13333334040479167 0.13333334040479167 ;
	setAttr ".emt" 4;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".spd" 7.212121218838023;
	setAttr ".srnd" 2.4579124570971587;
	setAttr ".afc" 7.0370370280687453;
	setAttr ".alx" 10;
	setAttr ".rnd" 0.19528619515762888;
createNode transform -n "FireworksCTRL" -p "primaryEmitter";
	addAttr -ci true -sn "detonationFrame" -ln "detonationFrame" -at "double";
	setAttr ".r" -type "double3" 1.3314709544022345 11.388918320661078 -10.864579447313298 ;
	setAttr ".s" -type "double3" 7.4999996022304902 7.4999996022304884 7.4999996022304876 ;
	setAttr -k on ".detonationFrame" 2;
createNode locator -n "FireworksCTRLShape" -p "FireworksCTRL";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "FireworksCTRL";
	setAttr ".r" -type "double3" 1.391492673140288e-015 6.3611093629270351e-015 -6.7089825312121068e-015 ;
	setAttr ".s" -type "double3" 1 1.0000000000000002 1.0000000000000002 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "FireworksCTRL";
createNode transform -n "primaryNParticle";
createNode nParticle -n "primaryNParticleShape" -p "primaryNParticle";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -is true -ci true -sn "betterIllumination" -ln "betterIllumination" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "surfaceShading" -ln "surfaceShading" -min 0 -max 
		1 -at "float";
	addAttr -ci true -sn "incandescencePP" -ln "incandescencePP" -dt "vectorArray";
	addAttr -ci true -h true -sn "incandescencePP0" -ln "incandescencePP0" -dt "vectorArray";
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
	setAttr ".lfr" 2;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".cts" 1;
	setAttr ".chw" 180;
	setAttr ".prt" 8;
	setAttr ".cofl" 1;
	setAttr ".pmss" 3.2330000400543213;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".drg" 0.094276092946529388;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".ra" 0.15000000596046448;
	setAttr ".rdc[0]"  0 1 1;
	setAttr -s 2 ".mssc[0:1]"  0.5826087 1 1 1 0.54000002 1;
	setAttr ".msli" 2;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".op" 0.85858585845415636;
	setAttr -s 4 ".opc[0:3]"  0 1 1 0.73913044 1 1 1 0.25999999 
		1 0.94782609 0.69999999 1;
	setAttr ".oci" 2;
	setAttr ".cl[0].clp" 0.12173912674188614;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".coi" 1;
	setAttr -s 10 ".inca";
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 2.47616 2.7350667 2.9200001 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".inca[1].incap" 1;
	setAttr ".inca[1].incac" -type "float3" 0.33500001 0.32061735 0.31624001 ;
	setAttr ".inca[1].incai" 1;
	setAttr ".inca[2].incap" 0.61739099025726318;
	setAttr ".inca[2].incac" -type "float3" 1.363 1.2730421 1.2745414 ;
	setAttr ".inca[2].incai" 1;
	setAttr ".inca[3].incap" 0.31304299831390381;
	setAttr ".inca[3].incac" -type "float3" 13.936842 13.679176 13.988421 ;
	setAttr ".inca[3].incai" 1;
	setAttr ".inca[4].incap" 0.47826099395751953;
	setAttr ".inca[4].incac" -type "float3" 1.85 1.7575001 1.7713749 ;
	setAttr ".inca[4].incai" 1;
	setAttr ".inca[5].incap" 0.54782599210739136;
	setAttr ".inca[5].incac" -type "float3" 18.029476 16.93256 16.97974 ;
	setAttr ".inca[5].incai" 1;
	setAttr ".inca[6].incap" 0.72173899412155151;
	setAttr ".inca[6].incac" -type "float3" 16.63282 15.391675 15.323945 ;
	setAttr ".inca[6].incai" 1;
	setAttr ".inca[8].incap" 0.80000001192092896;
	setAttr ".inca[8].incac" -type "float3" 15.189734 14.059957 13.997057 ;
	setAttr ".inca[8].incai" 1;
	setAttr ".inca[9].incap" 0.2173909991979599;
	setAttr ".inca[9].incac" -type "float3" 12.26948 12.353728 12.769741 ;
	setAttr ".inca[9].incai" 1;
	setAttr ".inca[10].incap" 0.40869563817977905;
	setAttr ".inca[10].incac" -type "float3" 4.0650001 3.9024 3.9538901 ;
	setAttr ".inca[10].incai" 1;
	setAttr ".ini" 2;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 2;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr -k on ".betterIllumination";
	setAttr -k on ".surfaceShading";
	setAttr ".incandescencePP0" -type "vectorArray" 0 ;
createNode pointEmitter -n "secondaryEmitter" -p "primaryNParticle";
	setAttr ".rat" 23.569023746194361;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".spd" 0.30303030331252201;
	setAttr ".srnd" 0.90909090993756603;
createNode transform -n "secondaryNParticle";
createNode nParticle -n "secondaryNParticleShape" -p "secondaryNParticle";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -is true -ci true -sn "betterIllumination" -ln "betterIllumination" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "surfaceShading" -ln "surfaceShading" -min 0 -max 
		1 -at "float";
	addAttr -ci true -sn "incandescencePP" -ln "incandescencePP" -dt "vectorArray";
	addAttr -ci true -h true -sn "incandescencePP0" -ln "incandescencePP0" -dt "vectorArray";
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
	setAttr ".lfr" 3;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".inh" 0.26936026899024895;
	setAttr ".cts" 1;
	setAttr ".chw" 180;
	setAttr ".prt" 8;
	setAttr ".cofl" 1;
	setAttr ".cold" no;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".drg" 0.11447811871767044;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".ra" 0.30000001192092896;
	setAttr -s 3 ".rdc";
	setAttr ".rdc[1:2]" 0 1 1 1 0.25999999046325684 1;
	setAttr ".rdc[5].rdcp" 0.18260869383811951;
	setAttr ".rdc[5].rdcfv" 0.54000002145767212;
	setAttr ".rdc[5].rdci" 1;
	setAttr ".rci" 6;
	setAttr ".rsr" 0.016835017161136525;
	setAttr -s 2 ".mssc[0:1]"  0 1 1 1 0.57999998 1;
	setAttr ".msli" 6;
	setAttr ".msr" 0.36026935998400555;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".op" 0.10774410815489312;
	setAttr -s 3 ".opc";
	setAttr ".opc[0:1]" 0 1 1 0.41739130020141602 0.6600000262260437 
		1;
	setAttr ".opc[3].opcp" 1;
	setAttr ".opc[3].opcfv" 0.23999999463558197;
	setAttr ".opc[3].opci" 1;
	setAttr ".oci" 2;
	setAttr ".osr" 0.26599326593055067;
	setAttr ".cl[2].clp" 0.23478260636329651;
	setAttr ".cl[2].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[2].cli" 1;
	setAttr -s 6 ".inca";
	setAttr ".inca[1].incap" 0;
	setAttr ".inca[1].incac" -type "float3" 16.619999 19.323999 20 ;
	setAttr ".inca[1].incai" 1;
	setAttr ".inca[2].incap" 0.53043478727340698;
	setAttr ".inca[2].incac" -type "float3" 0.039000001 0.011388 0.0021840001 ;
	setAttr ".inca[2].incai" 0;
	setAttr ".inca[3].incap" 0.1304347813129425;
	setAttr ".inca[3].incac" -type "float3" 0.039000001 0.011388 0.0021839999 ;
	setAttr ".inca[3].incai" 0;
	setAttr ".inca[4].incap" 0.86086958646774292;
	setAttr ".inca[4].incac" -type "float3" 0.039000001 0.011388 0.0021840001 ;
	setAttr ".inca[4].incai" 1;
	setAttr ".inca[5].incap" 0.22608695924282074;
	setAttr ".inca[5].incac" -type "float3" 30 28.9275 28.83 ;
	setAttr ".inca[5].incai" 1;
	setAttr ".inca[6].incap" 0.7130434513092041;
	setAttr ".inca[6].incac" -type "float3" 10 9.4419994 9.3800001 ;
	setAttr ".inca[6].incai" 1;
	setAttr ".ini" 2;
	setAttr ".icar" 0.43434343474794818;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 3;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
	setAttr -k on ".betterIllumination";
	setAttr -k on ".surfaceShading";
	setAttr ".incandescencePP0" -type "vectorArray" 0 ;
createNode pointEmitter -n "trailsEmitter" -p "secondaryNParticle";
	setAttr ".rat" 33.670033856611759;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".spd" 0;
createNode transform -n "trailsNParticle";
createNode nParticle -n "trailsNParticleShape" -p "trailsNParticle";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -is true -ci true -sn "betterIllumination" -ln "betterIllumination" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "surfaceShading" -ln "surfaceShading" -min 0 -max 
		1 -at "float";
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
	setAttr ".lfr" 0.8;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".cts" 1;
	setAttr ".chw" 180;
	setAttr ".prt" 8;
	setAttr ".cofl" 1;
	setAttr ".cold" no;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".drg" 0.60606062412261963;
	setAttr ".vssc[0]"  0 1 1;
	setAttr ".stns[0]"  0 1 1;
	setAttr ".ra" 0.15000000596046448;
	setAttr -s 4 ".rdc[0:3]"  0 1 1 0.29565218 0.72000003 1 1 0.41999999 
		1 0.10434783 0.98000002 1;
	setAttr ".rci" 6;
	setAttr -s 2 ".mssc[0:1]"  0 1 1 1 0.31999999 1;
	setAttr ".msli" 6;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".frsc[0]"  0 1 1;
	setAttr ".stsc[0]"  0 1 1;
	setAttr ".clsc[0]"  0 1 1;
	setAttr ".bosc[0]"  0 1 1;
	setAttr ".op" 0.26599326593055067;
	setAttr -s 4 ".opc[0:3]"  0 1 1 0.19130434 0.77999997 1 1 0.2 
		1 0.46956521 0.40000001 1;
	setAttr ".oci" 2;
	setAttr ".osr" 0.31986531954233594;
	setAttr -s 12 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 10 8.8199997 8.8199997 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.35652172565460205;
	setAttr ".cl[1].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[1].cli" 0;
	setAttr ".cl[2].clp" 0.43478259444236755;
	setAttr ".cl[2].clc" -type "float3" 7.9169998 6.6740308 6.6740308 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0.68695652484893799;
	setAttr ".cl[3].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[3].cli" 0;
	setAttr ".cl[4].clp" 0.895652174949646;
	setAttr ".cl[4].clc" -type "float3" 2.4809999 2.0914829 2.0914829 ;
	setAttr ".cl[4].cli" 1;
	setAttr ".cl[5].clp" 1;
	setAttr ".cl[5].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[5].cli" 1;
	setAttr ".cl[6].clp" 0.52173912525177002;
	setAttr ".cl[6].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[6].cli" 0;
	setAttr ".cl[7].clp" 0.57391303777694702;
	setAttr ".cl[7].clc" -type "float3" 4.7501988 4.0044179 4.0044179 ;
	setAttr ".cl[7].cli" 1;
	setAttr ".cl[8].clp" 0.80869567394256592;
	setAttr ".cl[8].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[8].cli" 0;
	setAttr ".cl[9].clp" 0.72173911333084106;
	setAttr ".cl[9].clc" -type "float3" 2.192399 1.848193 1.848193 ;
	setAttr ".cl[9].cli" 1;
	setAttr ".cl[10].clp" 0.25217390060424805;
	setAttr ".cl[10].clc" -type "float3" 5.5419002 4.6718221 4.6718221 ;
	setAttr ".cl[10].cli" 1;
	setAttr ".cl[11].clp" 0.17391304671764374;
	setAttr ".cl[11].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[11].cli" 1;
	setAttr ".coi" 2;
	setAttr ".colr" 0.38720538725555947;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
	setAttr -k on ".betterIllumination";
	setAttr -k on ".surfaceShading";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 3 ".lnk";
	setAttr -s 3 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode nucleus -n "FireworksFallsNucleus";
	setAttr -s 3 ".niao";
	setAttr -s 3 ".nias";
	setAttr -s 3 ".noao";
	setAttr ".wisp" 0.63897764682769775;
	setAttr ".wnoi" 0.90095847845077515;
	setAttr ".sstp" 1;
	setAttr ".mcit" 0;
createNode shadingEngine -n "nParticleCloudSE";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode particleSamplerInfo -n "particleSamplerInfo1";
createNode blinn -n "npCloudBlinn";
createNode particleCloud -n "npCloudVolume";
	setAttr ".gi" 0.371747225522995;
	setAttr ".rdns" 0.8401486873626709;
createNode animCurveTU -n "emitter1_rate";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1.92 1000 2.88 0;
createNode imagePlane -n "imagePlane1";
	setAttr ".t" 1;
	setAttr ".fc" 12;
	setAttr ".s" -type "double2" 1.4173200000000001 1.0629900633591451 ;
	setAttr ".c" -type "double3" 1.8554930823462756 -5.1451482582208108 0.9874048504893338 ;
	setAttr ".w" 10;
	setAttr ".h" 10;
createNode ramp -n "ramp1";
	setAttr -s 2 ".cel";
	setAttr ".cel[2].ep" 0;
	setAttr ".cel[2].ec" -type "float3" 0.056122683 0.10530251 0.16960403 ;
	setAttr ".cel[3].ep" 0.4699999988079071;
	setAttr ".cel[3].ec" -type "float3" 0 0 0 ;
createNode place2dTexture -n "place2dTexture1";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 180 -ast 0.96 -aet 192 ";
	setAttr ".st" 6;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" "float $detonateFrame = .I[0];\n\n.O[0] = 0;\nif( frame >= $detonateFrame && frame < $detonateFrame + 1) {\n\t.O[0] = 1000;\n}";
createNode container -n "FireworksFallsAsset";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".isc" yes;
	setAttr -s 3 ".boc";
	setAttr ".ctor" -type "string" "";
	setAttr ".cdat" -type "string" "2010/08/18 16:33:49";
	setAttr ".ctyp" -type "string" "effects";
	setAttr ".aal" -type "attributeAlias" {"detonationFrame","borderConnections[0]","incandescence"
		,"borderConnections[1]","color","borderConnections[2]","nucleusSolver","publishedNodeInfo[0]"
		} ;
	setAttr ".nts" -type "string" "nParticle effect - This is a fireworks effect with 3 cascading nParticles. It is a freestanding effect that does not need to be applied to an object in the scene: it can be placed as needed, by positioning the primary emitter.";
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 15 ".hyp";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :defaultTextureList1;
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
select -ne :renderGlobalsList1;
select -ne :shaderGlow1;
	setAttr ".gi" 1.0780669450759888;
	setAttr ".gs" 0.019568772986531258;
	setAttr ".gfw" 10;
	setAttr ".hi" 0.26022306084632874;
	setAttr ".hs" 0.22304832935333252;
	setAttr ".qual" 50;
	setAttr ".th" 0.39033457636833191;
select -ne :defaultRenderGlobals;
	setAttr ".mcfr" 25;
	setAttr ".an" yes;
	setAttr ".fs" 0.96;
	setAttr ".ef" 172.8;
	setAttr ".ofc" 1;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
	setAttr ".hwfr" 25;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "imagePlane1.msg" ":perspShape.ip" -na;
connectAttr ":time1.o" "primaryEmitter.ct";
connectAttr "primaryNParticleShape.ifl" "primaryEmitter.full[0]";
connectAttr "primaryNParticleShape.tss" "primaryEmitter.dt[0]";
connectAttr "primaryNParticleShape.inh" "primaryEmitter.inh[0]";
connectAttr "primaryNParticleShape.stt" "primaryEmitter.stt[0]";
connectAttr "primaryNParticleShape.sd[0]" "primaryEmitter.sd[0]";
connectAttr "expression1.out[0]" "primaryEmitter.rat";
connectAttr "FireworksCTRLShape.wm" "annotationShape1.dom" -na;
connectAttr ":time1.o" "primaryNParticleShape.cti";
connectAttr "FireworksFallsNucleus.noao[0]" "primaryNParticleShape.nxst";
connectAttr "FireworksFallsNucleus.stf" "primaryNParticleShape.stf";
connectAttr "primaryEmitter.ot[0]" "primaryNParticleShape.npt[0]";
connectAttr "primaryNParticleShape.incr" "primaryNParticleShape.rgbPP";
connectAttr "primaryNParticleShape.inor" "primaryNParticleShape.opacityPP";
connectAttr "primaryNParticleShape.inmr" "primaryNParticleShape.mas";
connectAttr "primaryNParticleShape.inir" "primaryNParticleShape.incandescencePP"
		;
connectAttr ":time1.o" "secondaryEmitter.ct";
connectAttr "primaryNParticleShape.cwcn" "secondaryEmitter.ocd";
connectAttr "primaryNParticleShape.ctd" "secondaryEmitter.t";
connectAttr "primaryNParticleShape.cwps" "secondaryEmitter.opd";
connectAttr "primaryNParticleShape.cwvl" "secondaryEmitter.ovd";
connectAttr "primaryNParticleShape.id" "secondaryEmitter.paid";
connectAttr "secondaryNParticleShape.ifl" "secondaryEmitter.full[0]";
connectAttr "secondaryNParticleShape.tss" "secondaryEmitter.dt[0]";
connectAttr "secondaryNParticleShape.inh" "secondaryEmitter.inh[0]";
connectAttr "secondaryNParticleShape.stt" "secondaryEmitter.stt[0]";
connectAttr "secondaryNParticleShape.sd[0]" "secondaryEmitter.sd[0]";
connectAttr ":time1.o" "secondaryNParticleShape.cti";
connectAttr "FireworksFallsNucleus.noao[1]" "secondaryNParticleShape.nxst";
connectAttr "FireworksFallsNucleus.stf" "secondaryNParticleShape.stf";
connectAttr "secondaryEmitter.ot[0]" "secondaryNParticleShape.npt[0]";
connectAttr "secondaryNParticleShape.inor" "secondaryNParticleShape.opacityPP";
connectAttr "secondaryNParticleShape.inrr" "secondaryNParticleShape.radiusPP";
connectAttr "secondaryNParticleShape.inir" "secondaryNParticleShape.incandescencePP"
		;
connectAttr "secondaryNParticleShape.inmr" "secondaryNParticleShape.mas";
connectAttr ":time1.o" "trailsEmitter.ct";
connectAttr "secondaryNParticleShape.cwcn" "trailsEmitter.ocd";
connectAttr "secondaryNParticleShape.ctd" "trailsEmitter.t";
connectAttr "secondaryNParticleShape.cwps" "trailsEmitter.opd";
connectAttr "secondaryNParticleShape.cwvl" "trailsEmitter.ovd";
connectAttr "secondaryNParticleShape.id" "trailsEmitter.paid";
connectAttr "trailsNParticleShape.ifl" "trailsEmitter.full[0]";
connectAttr "trailsNParticleShape.tss" "trailsEmitter.dt[0]";
connectAttr "trailsNParticleShape.inh" "trailsEmitter.inh[0]";
connectAttr "trailsNParticleShape.stt" "trailsEmitter.stt[0]";
connectAttr "trailsNParticleShape.sd[0]" "trailsEmitter.sd[0]";
connectAttr ":time1.o" "trailsNParticleShape.cti";
connectAttr "FireworksFallsNucleus.noao[2]" "trailsNParticleShape.nxst";
connectAttr "FireworksFallsNucleus.stf" "trailsNParticleShape.stf";
connectAttr "trailsEmitter.ot[0]" "trailsNParticleShape.npt[0]";
connectAttr "trailsNParticleShape.incr" "trailsNParticleShape.rgbPP";
connectAttr "trailsNParticleShape.inor" "trailsNParticleShape.opacityPP";
connectAttr "trailsNParticleShape.inrr" "trailsNParticleShape.radiusPP";
connectAttr "trailsNParticleShape.inmr" "trailsNParticleShape.mas";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "nParticleCloudSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "nParticleCloudSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":time1.o" "FireworksFallsNucleus.cti";
connectAttr "primaryNParticleShape.cust" "FireworksFallsNucleus.niao[0]";
connectAttr "secondaryNParticleShape.cust" "FireworksFallsNucleus.niao[1]";
connectAttr "trailsNParticleShape.cust" "FireworksFallsNucleus.niao[2]";
connectAttr "primaryNParticleShape.stst" "FireworksFallsNucleus.nias[0]";
connectAttr "secondaryNParticleShape.stst" "FireworksFallsNucleus.nias[1]";
connectAttr "trailsNParticleShape.stst" "FireworksFallsNucleus.nias[2]";
connectAttr "npCloudBlinn.oc" "nParticleCloudSE.ss";
connectAttr "npCloudVolume.oi" "nParticleCloudSE.vs";
connectAttr "primaryNParticleShape.iog" "nParticleCloudSE.dsm" -na;
connectAttr "secondaryNParticleShape.iog" "nParticleCloudSE.dsm" -na;
connectAttr "trailsNParticleShape.iog" "nParticleCloudSE.dsm" -na;
connectAttr "nParticleCloudSE.msg" "materialInfo1.sg";
connectAttr "npCloudBlinn.msg" "materialInfo1.m";
connectAttr "particleSamplerInfo1.msg" "materialInfo1.t" -na;
connectAttr "particleSamplerInfo1.oc" "npCloudBlinn.c";
connectAttr "particleSamplerInfo1.ot" "npCloudBlinn.it";
connectAttr "particleSamplerInfo1.oi" "npCloudBlinn.ic";
connectAttr "particleSamplerInfo1.ot" "npCloudVolume.t";
connectAttr "particleSamplerInfo1.oc" "npCloudVolume.c";
connectAttr "particleSamplerInfo1.oi" "npCloudVolume.i";
connectAttr "ramp1.oc" "imagePlane1.stx";
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "FireworksCTRL.detonationFrame" "expression1.in[0]";
connectAttr ":time1.o" "expression1.tim";
connectAttr "primaryEmitter.msg" "expression1.obm";
connectAttr "FireworksCTRL.detonationFrame" "FireworksFallsAsset.boc[0]";
connectAttr "secondaryNParticleShape.inca" "FireworksFallsAsset.boc[1]";
connectAttr "trailsNParticleShape.cl" "FireworksFallsAsset.boc[2]";
connectAttr "hyperLayout1.msg" "FireworksFallsAsset.hl";
connectAttr "primaryEmitter.msg" "FireworksFallsAsset.rt";
connectAttr "FireworksFallsNucleus.msg" "FireworksFallsAsset.pni[0].pnod";
connectAttr "primaryEmitter.msg" "hyperLayout1.hyp[0].dn";
connectAttr "FireworksCTRLShape.msg" "hyperLayout1.hyp[1].dn";
connectAttr "annotation1.msg" "hyperLayout1.hyp[2].dn";
connectAttr "primaryNParticle.msg" "hyperLayout1.hyp[3].dn";
connectAttr "primaryNParticleShape.msg" "hyperLayout1.hyp[4].dn";
connectAttr "secondaryEmitter.msg" "hyperLayout1.hyp[5].dn";
connectAttr "secondaryNParticle.msg" "hyperLayout1.hyp[6].dn";
connectAttr "secondaryNParticleShape.msg" "hyperLayout1.hyp[7].dn";
connectAttr "trailsEmitter.msg" "hyperLayout1.hyp[8].dn";
connectAttr "trailsNParticle.msg" "hyperLayout1.hyp[9].dn";
connectAttr "trailsNParticleShape.msg" "hyperLayout1.hyp[10].dn";
connectAttr "FireworksCTRL.msg" "hyperLayout1.hyp[11].dn";
connectAttr "annotationShape1.msg" "hyperLayout1.hyp[12].dn";
connectAttr "FireworksFallsNucleus.msg" "hyperLayout1.hyp[13].dn";
connectAttr "expression1.msg" "hyperLayout1.hyp[14].dn";
connectAttr "nParticleCloudSE.pa" ":renderPartition.st" -na;
connectAttr "npCloudBlinn.msg" ":defaultShaderList1.s" -na;
connectAttr "npCloudVolume.msg" ":defaultShaderList1.s" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
// End of fireworkSilverFallsMod2.ma
