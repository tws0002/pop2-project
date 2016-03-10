//Maya ASCII 2014 scene
//Name: TreeSimple2.ma
//Last modified: Mon, Jun 03, 2013 10:35:27 AM
//Codeset: 1252
requires maya "2014";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya batch mode";
fileInfo "version" "2014 Preview Release 28 x64";
fileInfo "cutIdentifier" "201305270939-000000";
fileInfo "osv" "Microsoft Windows 8 Enterprise Edition, 64-bit  (Build 9200)\n";
createNode transform -n "treeSimple2ShaderSG_materialRef";
createNode mesh -n "treeSimple2ShaderSG_materialRefShape" -p "treeSimple2ShaderSG_materialRef";
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
createNode transform -n "treeSimple2LeafShaderSG_materialRef";
createNode mesh -n "treeSimple2LeafShaderSG_materialRefShape" -p "treeSimple2LeafShaderSG_materialRef";
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
createNode shadingEngine -n "treeSimple2ShaderSG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode shadingEngine -n "treeSimple2LeafShaderSG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo15";
createNode phong -n "treeSimple2Shader";
	setAttr ".tc" 0.20000000298023224;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1;
	setAttr ".fakc" 0;
	setAttr ".sc" -type "float3" 0 0 0 ;
	setAttr ".cp" 10;
createNode ramp -n "ramp15";
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[1].ep" 1;
	setAttr ".cel[1].ec" -type "float3" 1 1 1 ;
createNode materialInfo -n "materialInfo16";
createNode phong -n "treeSimple2LeafShader";
	setAttr ".dc" 0.43902000784873962;
	setAttr ".tc" 0.56098002195358276;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1;
	setAttr ".fakc" 0;
	setAttr ".sc" -type "float3" 0 0 0 ;
	setAttr ".cp" 10;
createNode ramp -n "ramp16";
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.16078432 0.49411765 0.24705882 ;
	setAttr ".cel[1].ep" 1;
	setAttr ".cel[1].ec" -type "float3" 0.43529412 0.66274512 0.32549021 ;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 30 ".lnk";
	setAttr -s 30 ".slnk";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 30 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 30 ".s";
select -ne :defaultTextureList1;
	setAttr -s 28 ".tx";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :defaultRenderGlobals;
	setAttr ".ep" 1;
select -ne :defaultResolution;
	setAttr ".w" 640;
	setAttr ".h" 480;
	setAttr ".pa" 1;
	setAttr ".dar" 1.3333332538604736;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "treeSimple2Shader.oc" "treeSimple2ShaderSG.ss";
connectAttr "treeSimple2MainShape.iog" "treeSimple2ShaderSG.dsm" -na;
connectAttr "treeSimple2ShaderSG_materialRefShape.iog" "treeSimple2ShaderSG.dsm"
		 -na;
connectAttr "treeSimple2LeafShader.oc" "treeSimple2LeafShaderSG.ss";
connectAttr "treeSimple2LeafShape.iog" "treeSimple2LeafShaderSG.dsm" -na;
connectAttr "treeSimple2LeafShaderSG_materialRefShape.iog" "treeSimple2LeafShaderSG.dsm"
		 -na;
connectAttr "treeSimple2ShaderSG.msg" "materialInfo15.sg";
connectAttr "treeSimple2Shader.msg" "materialInfo15.m";
connectAttr "ramp15.msg" "materialInfo15.t" -na;
connectAttr "ramp15.oc" "treeSimple2Shader.c";
connectAttr "treeSimple2LeafShaderSG.msg" "materialInfo16.sg";
connectAttr "treeSimple2LeafShader.msg" "materialInfo16.m";
connectAttr "ramp16.msg" "materialInfo16.t" -na;
connectAttr "ramp16.oc" "treeSimple2LeafShader.c";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "treeSimple2ShaderSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "treeSimple2LeafShaderSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "treeSimple2ShaderSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "treeSimple2LeafShaderSG.message" ":defaultLightSet.message";
connectAttr "treeSimple2ShaderSG.pa" ":renderPartition.st" -na;
connectAttr "treeSimple2LeafShaderSG.pa" ":renderPartition.st" -na;
connectAttr "treeSimple2Shader.msg" ":defaultShaderList1.s" -na;
connectAttr "treeSimple2LeafShader.msg" ":defaultShaderList1.s" -na;
connectAttr "ramp15.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp16.msg" ":defaultTextureList1.tx" -na;
// End of TreeSimple2.ma
