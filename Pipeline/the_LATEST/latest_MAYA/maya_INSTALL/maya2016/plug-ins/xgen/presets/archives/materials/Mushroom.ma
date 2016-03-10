//Maya ASCII 2014 scene
//Name: Mushroom.ma
//Last modified: Mon, Jun 03, 2013 01:51:30 PM
//Codeset: 1252
requires maya "2014";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya batch mode";
fileInfo "version" "2014 Preview Release 28 x64";
fileInfo "cutIdentifier" "201305270939-000000";
fileInfo "osv" "Microsoft Windows 8 Enterprise Edition, 64-bit  (Build 9200)\n";
createNode transform -n "initialShadingGroup_materialRef";
createNode mesh -n "initialShadingGroup_materialRefShape" -p "initialShadingGroup_materialRef";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0.375 0 0.625 0 0.375
		 0.25 0.625 0.25 0.375 0.5 0.625 0.5 0.375 0.75 0.625 0.75 0.375 1 0.625 1 0.875 0
		 0.875 0.25 0.125 0 0.125 0.25;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 0 1 3 2
		f 4 1 7 -3 -7
		mu 0 4 2 3 5 4
		f 4 2 9 -4 -9
		mu 0 4 4 5 7 6
		f 4 3 11 -1 -11
		mu 0 4 6 7 9 8
		f 4 -12 -10 -8 -6
		mu 0 4 1 10 11 3
		f 4 10 4 6 8
		mu 0 4 12 0 2 13;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "phong1SG_materialRef";
createNode mesh -n "phong1SG_materialRefShape" -p "phong1SG_materialRef";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0.375 0 0.625 0 0.375
		 0.25 0.625 0.25 0.375 0.5 0.625 0.5 0.375 0.75 0.625 0.75 0.375 1 0.625 1 0.875 0
		 0.875 0.25 0.125 0 0.125 0.25;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 0 1 3 2
		f 4 1 7 -3 -7
		mu 0 4 2 3 5 4
		f 4 2 9 -4 -9
		mu 0 4 4 5 7 6
		f 4 3 11 -1 -11
		mu 0 4 6 7 9 8
		f 4 -12 -10 -8 -6
		mu 0 4 1 10 11 3
		f 4 10 4 6 8
		mu 0 4 12 0 2 13;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "phong2SG_materialRef";
createNode mesh -n "phong2SG_materialRefShape" -p "phong2SG_materialRef";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0.375 0 0.625 0 0.375
		 0.25 0.625 0.25 0.375 0.5 0.625 0.5 0.375 0.75 0.625 0.75 0.375 1 0.625 1 0.875 0
		 0.875 0.25 0.125 0 0.125 0.25;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 0 1 3 2
		f 4 1 7 -3 -7
		mu 0 4 2 3 5 4
		f 4 2 9 -4 -9
		mu 0 4 4 5 7 6
		f 4 3 11 -1 -11
		mu 0 4 6 7 9 8
		f 4 -12 -10 -8 -6
		mu 0 4 1 10 11 3
		f 4 10 4 6 8
		mu 0 4 12 0 2 13;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode shadingEngine -n "phong1SG";
	setAttr ".ihi" 0;
	setAttr -s 11 ".dsm";
	setAttr ".ro" yes;
	setAttr -s 10 ".gn";
createNode shadingEngine -n "phong2SG";
	setAttr ".ihi" 0;
	setAttr -s 11 ".dsm";
	setAttr ".ro" yes;
	setAttr -s 10 ".gn";
createNode materialInfo -n "materialInfo1";
createNode phong -n "phong1";
	setAttr ".c" -type "float3" 0.41800001 0.058937989 0.24923442 ;
createNode materialInfo -n "materialInfo2";
createNode phong -n "phong2";
	setAttr ".c" -type "float3" 0.55900002 0.50662422 0.43378404 ;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 4 ".st";
select -ne :initialShadingGroup;
	setAttr -s 4 ".dsm";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :defaultRenderGlobals;
	setAttr ".ren" -type "string" "mentalRay";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 18 ",NURBS Curves," ",NURBS Surfaces," ",Polygons," ",Subdiv Surfaces," ",Particles," ",Fluids," ",Image Planes," ",UI:," ",Lights," ",Cameras," ",Locators," ",Joints," ",IK Handles," ",Deformers," ",Motion Trails," ",Components," ",Misc. UI," ",Ornaments,"  ;
	setAttr ".otfva" -type "Int32Array" 18 0 1 1 1 1 1
		 1 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".msaa" yes;
	setAttr ".aasc" 16;
	setAttr ".laa" yes;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "phong1.oc" "phong1SG.ss";
connectAttr "groupId34.msg" "phong1SG.gn" -na;
connectAttr "groupId36.msg" "phong1SG.gn" -na;
connectAttr "groupId38.msg" "phong1SG.gn" -na;
connectAttr "groupId49.msg" "phong1SG.gn" -na;
connectAttr "groupId51.msg" "phong1SG.gn" -na;
connectAttr "groupId53.msg" "phong1SG.gn" -na;
connectAttr "groupId63.msg" "phong1SG.gn" -na;
connectAttr "groupId67.msg" "phong1SG.gn" -na;
connectAttr "groupId77.msg" "phong1SG.gn" -na;
connectAttr "groupId81.msg" "phong1SG.gn" -na;
connectAttr "MushroomShape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_loShape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_medShape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_lo1Shape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_med1Shape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_lo2Shape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_med2Shape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroomphong1SGShape.iog" "phong1SG.dsm" -na;
connectAttr "Mushroom_lo3Shape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "Mushroom_med3Shape.iog.og[1]" "phong1SG.dsm" -na;
connectAttr "phong1SG_materialRefShape.iog" "phong1SG.dsm" -na;
connectAttr "phong2.oc" "phong2SG.ss";
connectAttr "groupId35.msg" "phong2SG.gn" -na;
connectAttr "groupId37.msg" "phong2SG.gn" -na;
connectAttr "groupId39.msg" "phong2SG.gn" -na;
connectAttr "groupId50.msg" "phong2SG.gn" -na;
connectAttr "groupId52.msg" "phong2SG.gn" -na;
connectAttr "groupId54.msg" "phong2SG.gn" -na;
connectAttr "groupId64.msg" "phong2SG.gn" -na;
connectAttr "groupId68.msg" "phong2SG.gn" -na;
connectAttr "groupId78.msg" "phong2SG.gn" -na;
connectAttr "groupId82.msg" "phong2SG.gn" -na;
connectAttr "MushroomShape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_loShape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_medShape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_lo1Shape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_med1Shape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_lo2Shape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_med2Shape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_lo3Shape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroom_med3Shape.iog.og[2]" "phong2SG.dsm" -na;
connectAttr "Mushroomphong2SGShape.iog" "phong2SG.dsm" -na;
connectAttr "phong2SG_materialRefShape.iog" "phong2SG.dsm" -na;
connectAttr "phong1SG.msg" "materialInfo1.sg";
connectAttr "phong1.msg" "materialInfo1.m";
connectAttr "phong2SG.msg" "materialInfo2.sg";
connectAttr "phong2.msg" "materialInfo2.m";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "phong1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "phong2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "phong1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "phong2SG.message" ":defaultLightSet.message";
connectAttr "phong1SG.pa" ":renderPartition.st" -na;
connectAttr "phong2SG.pa" ":renderPartition.st" -na;
connectAttr "initialShadingGroup_materialRefShape.iog" ":initialShadingGroup.dsm"
		 -na;
connectAttr "phong1.msg" ":defaultShaderList1.s" -na;
connectAttr "phong2.msg" ":defaultShaderList1.s" -na;
// End of Mushroom.ma
