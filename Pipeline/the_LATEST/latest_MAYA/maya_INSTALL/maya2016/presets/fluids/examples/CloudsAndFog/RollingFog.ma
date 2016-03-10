//Maya ASCII 5.0ff03 scene
//Name: RollingFog.ma
//Last modified: Tue, Jan 07, 2003 04:40:09 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Mainline";
fileInfo "cutIdentifier" "200301060019";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Fog";
createNode fluidShape -n "FogShape" -p "Fog";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 10;
	setAttr ".ots" 1.248;
	setAttr ".dmt" 3;
	setAttr ".dsc" 0.10000000149011612;
	setAttr ".dsb" -0.5;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr ".cl[2].clp" 1;
	setAttr ".cl[2].clc" -type "float3" 1 0.91297501 0.85000002 ;
	setAttr ".cl[2].cli" 0;
	setAttr -s 5 ".opa[2:6]"  1 0.31999999 1 0.77857143 0 
		1 1 0 1 0.67142856 0.2 1 0.39285713 0 1;
	setAttr ".opi" 2;
	setAttr ".oib" 0.18919999897480011;
	setAttr ".t" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 0;
	setAttr ".ili" 4;
	setAttr ".iib" 0.86956000328063965;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".dos" 6;
	setAttr ".edr" 0.5;
	setAttr ".otx" yes;
	setAttr ".otxg" 0.96079999208450317;
	setAttr ".txsc" -type "float3" 1 1.5 1 ;
	setAttr ".tor" -type "float3" 0 -1 0 ;
	setAttr ".dm" 4;
	setAttr ".fr" 2.5;
	setAttr ".nts" -type "string" (
		"Example Goal:\r\n"
		+ "Rolling Fog.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Density is defined as a constant gradient.\r\n"
		+ "The shading uses a heavy Y Gradient Dropoff Shape.\r\n"
		+ "Opacity is textured with Perlin noise to control the details.\r\n"
		+ "\r\n"
		+ "Finer points:\r\n"
		+ "The Opacity is low throughout.\r\n"
		+ "Texture Time is animated and Texture Origin adds direction to the fog motion.\r\n"
		+ "A higher Depth Max value gives detail to the texture.\r\n"
		+ "Render with RollingFogCamera.\r\n"
		+ "Render Time: $");
createNode transform -n "defaultLight";
	setAttr ".r" -type "double3" -29.01478639167107 -20.949557806367267 5.4778433625059844 ;
createNode directionalLight -n "defaultLightShape" -p "defaultLight";
	setAttr -k off ".v";
createNode transform -n "Haze";
createNode fluidShape -n "HazeShape" -p "Haze";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 10;
	setAttr -s 3 ".cl";
	setAttr ".cl[0].clp" 0.67857140302658081;
	setAttr ".cl[0].clc" -type "float3" 0 0.14555202 0.352 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.82857143878936768;
	setAttr ".cl[1].clc" -type "float3" 0.099078007 0.17967826 0.294 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 0.82142859697341919;
	setAttr ".cl[2].clc" -type "float3" 0.61199999 0.55569601 0.60106766 ;
	setAttr ".cl[2].cli" 0;
	setAttr ".coi" 2;
	setAttr ".cib" 0.18000000715255737;
	setAttr ".opa[0]"  0 0.059999999 1;
	setAttr ".opi" 2;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.80000001192092896;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 1.5 1 0 ;
	setAttr ".i[2].ii" 0;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
createNode transform -n "RollingFogCamera";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0.11810277524392794 -1.8593888911245255 3.5934526562625151 ;
	setAttr ".r" -type "double3" 1.461647270397072 0.60000000000018761 -1.5530903724888977e-018 ;
createNode camera -n "RollingFogCameraShape" -p "RollingFogCamera";
	setAttr -k off ".v";
	setAttr ".ovr" 1.3;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 3.909944196762424;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time*0.3";
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "fluidShape3SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 4 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".sdf" -type "string" "";
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 239;
	setAttr ".rght" 319;
	setAttr ".ofe" -type "string" "";
	setAttr ".efe" -type "string" "";
	setAttr ".lse" -type "string" "";
	setAttr ".rse" -type "string" "";
	setAttr ".oft" -type "string" "";
	setAttr ".ifp" -type "string" "";
	setAttr -k on ".mbf";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".pfrm" -type "string" "";
	setAttr ".pfom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultLightSet;
connectAttr "expression1.out[0]" "FogShape.tti";
connectAttr ":time1.o" "FogShape.cti";
connectAttr ":time1.o" "HazeShape.cti";
connectAttr ":time1.o" "expression1.tim";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "FogShape.ocl" "fluidShape1SG.vs";
connectAttr "FogShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape3SG.msg" "materialInfo3.sg";
connectAttr "HazeShape.ocl" "fluidShape3SG.vs";
connectAttr "HazeShape.iog" "fluidShape3SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "fluidShape3SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape3SG.pa" ":renderPartition.st" -na;
connectAttr "FogShape.msg" ":defaultShaderList1.s" -na;
connectAttr "HazeShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "defaultLightShape.ltd" ":lightList1.l" -na;
connectAttr "defaultLightShape.iog" ":defaultLightSet.dsm" -na;
// End of RollingFog.ma
