//Maya ASCII 2014 scene
//Name: DaisyLarge3.ma
//Last modified: Mon, Jun 03, 2013 11:10:04 AM
//Codeset: 1252
requires maya "2014";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya batch mode";
fileInfo "version" "2014 Preview Release 28 x64";
fileInfo "cutIdentifier" "201305270939-000000";
fileInfo "osv" "Microsoft Windows 8 Enterprise Edition, 64-bit  (Build 9200)\n";
createNode transform -n "daisyLarge3LeafShaderSG_materialRef";
createNode mesh -n "daisyLarge3LeafShaderSG_materialRefShape" -p "daisyLarge3LeafShaderSG_materialRef";
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
createNode transform -n "daisyLarge3ShaderSG_materialRef";
createNode mesh -n "daisyLarge3ShaderSG_materialRefShape" -p "daisyLarge3ShaderSG_materialRef";
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
createNode transform -n "daisyLarge3FlowerShaderSG_materialRef";
createNode mesh -n "daisyLarge3FlowerShaderSG_materialRefShape" -p "daisyLarge3FlowerShaderSG_materialRef";
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
createNode shadingEngine -n "daisyLarge3LeafShaderSG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode shadingEngine -n "daisyLarge3ShaderSG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode shadingEngine -n "daisyLarge3FlowerShaderSG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo11";
createNode phong -n "daisyLarge3LeafShader";
	setAttr ".dc" 0.67479997873306274;
	setAttr ".tc" 0.32519999146461487;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1;
	setAttr ".fakc" 0;
	setAttr ".sc" -type "float3" 0.15534 0.15534 0.15534 ;
	setAttr ".cp" 10.485600471496582;
createNode ramp -n "ramp11";
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.062745094 0.20392157 0.098039217 ;
	setAttr ".cel[1].ep" 1;
	setAttr ".cel[1].ec" -type "float3" 0.14509805 0.21960784 0.10980392 ;
createNode materialInfo -n "materialInfo10";
createNode phong -n "daisyLarge3Shader";
	setAttr ".dc" 0.5121999979019165;
	setAttr ".tc" 0.4878000020980835;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1;
	setAttr ".fakc" 0;
	setAttr ".sc" -type "float3" 0.15534 0.15534 0.15534 ;
	setAttr ".cp" 10.485600471496582;
createNode ramp -n "ramp10";
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.1435992 0.21346863 0.10968237 ;
	setAttr ".cel[1].ep" 1;
	setAttr ".cel[1].ec" -type "float3" 0.17269155 0.4627451 0.35025415 ;
createNode materialInfo -n "materialInfo12";
createNode phong -n "daisyLarge3FlowerShader";
	setAttr ".dc" 0.422760009765625;
	setAttr ".tc" 0.577239990234375;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1;
	setAttr ".fakc" 0;
	setAttr ".sc" -type "float3" 0.15534 0.15534 0.15534 ;
	setAttr ".cp" 10.485600471496582;
createNode ramp -n "ramp12";
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.84313726 0.90588236 0.89411765 ;
	setAttr ".cel[1].ep" 1;
	setAttr ".cel[1].ec" -type "float3" 1 1 1 ;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 31 ".lnk";
	setAttr -s 31 ".slnk";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 31 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 31 ".s";
select -ne :defaultTextureList1;
	setAttr -s 28 ".tx";
select -ne :lightList1;
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :defaultRenderGlobals;
	setAttr ".ren" -type "string" "mentalRay";
	setAttr ".ep" 1;
select -ne :defaultResolution;
	setAttr ".w" 1024;
	setAttr ".h" 1024;
	setAttr ".pa" 1;
	setAttr ".dar" 1;
select -ne :defaultLightSet;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "daisyLarge3LeafShader.oc" "daisyLarge3LeafShaderSG.ss";
connectAttr "daisyLarge3LeafShape.iog" "daisyLarge3LeafShaderSG.dsm" -na;
connectAttr "daisyLarge3LeafShaderSG_materialRefShape.iog" "daisyLarge3LeafShaderSG.dsm"
		 -na;
connectAttr "daisyLarge3Shader.oc" "daisyLarge3ShaderSG.ss";
connectAttr "daisyLarge3MainShape.iog" "daisyLarge3ShaderSG.dsm" -na;
connectAttr "daisyLarge3ShaderSG_materialRefShape.iog" "daisyLarge3ShaderSG.dsm"
		 -na;
connectAttr "daisyLarge3FlowerShader.oc" "daisyLarge3FlowerShaderSG.ss";
connectAttr "daisyLarge3FlowerShape.iog" "daisyLarge3FlowerShaderSG.dsm" -na;
connectAttr "daisyLarge3FlowerShaderSG_materialRefShape.iog" "daisyLarge3FlowerShaderSG.dsm"
		 -na;
connectAttr "daisyLarge3LeafShaderSG.msg" "materialInfo11.sg";
connectAttr "daisyLarge3LeafShader.msg" "materialInfo11.m";
connectAttr "ramp11.msg" "materialInfo11.t" -na;
connectAttr "ramp11.oc" "daisyLarge3LeafShader.c";
connectAttr "daisyLarge3ShaderSG.msg" "materialInfo10.sg";
connectAttr "daisyLarge3Shader.msg" "materialInfo10.m";
connectAttr "ramp10.msg" "materialInfo10.t" -na;
connectAttr "ramp10.oc" "daisyLarge3Shader.c";
connectAttr "daisyLarge3FlowerShaderSG.msg" "materialInfo12.sg";
connectAttr "daisyLarge3FlowerShader.msg" "materialInfo12.m";
connectAttr "ramp12.msg" "materialInfo12.t" -na;
connectAttr "ramp12.oc" "daisyLarge3FlowerShader.c";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "daisyLarge3ShaderSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "daisyLarge3LeafShaderSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "daisyLarge3FlowerShaderSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "daisyLarge3ShaderSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "daisyLarge3LeafShaderSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "daisyLarge3FlowerShaderSG.message" ":defaultLightSet.message";
connectAttr "daisyLarge3ShaderSG.pa" ":renderPartition.st" -na;
connectAttr "daisyLarge3LeafShaderSG.pa" ":renderPartition.st" -na;
connectAttr "daisyLarge3FlowerShaderSG.pa" ":renderPartition.st" -na;
connectAttr "daisyLarge3Shader.msg" ":defaultShaderList1.s" -na;
connectAttr "daisyLarge3LeafShader.msg" ":defaultShaderList1.s" -na;
connectAttr "daisyLarge3FlowerShader.msg" ":defaultShaderList1.s" -na;
connectAttr "ramp10.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp11.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp12.msg" ":defaultTextureList1.tx" -na;
// End of DaisyLarge3.ma
