//Maya ASCII 5.0ff03 scene
//Name: Perlin2DClouds.ma
//Last modified: Tue, Jan 07, 2003 04:23:19 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Mainline";
fileInfo "cutIdentifier" "200301060019";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Clouds";
	setAttr ".r" -type "double3" 90 0 0 ;
createNode fluidShape -n "CloudsShape" -p "Clouds";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 40;
	setAttr ".rh" 40;
	setAttr ".rd" 40;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 0.5;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".hss" no;
	setAttr ".dmt" 3;
	setAttr ".dsc" 0.59508001804351807;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr ".qua" 2;
	setAttr ".rin" 3;
	setAttr -s 3 ".cl";
	setAttr ".cl[2].clp" 0.014285714365541935;
	setAttr ".cl[2].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0.10000000149011612;
	setAttr ".cl[3].clc" -type "float3" 0.069759011 0.14360662 0.33700001 ;
	setAttr ".cl[3].cli" 1;
	setAttr ".cl[4].clp" 0.18571428954601288;
	setAttr ".cl[4].clc" -type "float3" 0.38336799 0.43051901 0.55400002 ;
	setAttr ".cl[4].cli" 1;
	setAttr ".coi" 3;
	setAttr ".cib" -0.63959997892379761;
	setAttr -s 7 ".opa[0:6]"  0.2 0 1 1 1 0 0.24285714 
		0.41999999 1 0.4642857 0.86000001 1 0 0 0 0 0 0 0.32142857 0.69999999 
		1;
	setAttr ".opi" 3;
	setAttr ".oib" 0.045079998672008514;
	setAttr ".t" -type "float3" 0.42976001 0.42976001 0.42976001 ;
	setAttr ".i[4].ip" 0;
	setAttr ".i[4].ic" -type "float3" 0.2 0.2 0.2 ;
	setAttr ".i[4].ii" 0;
	setAttr ".ili" 3;
	setAttr ".iib" -0.10000000149011612;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".edr" 0.18184000253677368;
	setAttr ".ctl" 0.26519998908042908;
	setAttr ".rl" no;
	setAttr ".dl" -type "float3" 0.5 0.02 0.5 ;
	setAttr ".ctx" yes;
	setAttr ".ctxg" 0.28999999165534973;
	setAttr ".itxg" 0.75700002908706665;
	setAttr ".otx" yes;
	setAttr ".ivt" yes;
	setAttr ".a" 0.80000001192092896;
	setAttr ".ra" 0.57025998830795288;
	setAttr ".th" 0.082639999687671661;
	setAttr ".txsc" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".tor" -type "float3" 0 0 -0.0099999998 ;
	setAttr ".dm" 4;
	setAttr ".fq" 1.7769999504089355;
	setAttr ".fr" 2.2999999523162842;
	setAttr ".in" yes;
	setAttr ".nts" -type "string" (
		"Example Goal: \r\n"
		+ "Thicker clouds.\r\n"
		+ "\r\n"
		+ "Basic contruction: \r\n"
		+ "Density is defined as a constant gradient in a 2D container.\r\n"
		+ "Color and Opacity are textured using Perlin Noise to add complexity and details to the fluid.\r\n"
		+ "Invert Texture and Inflection are turned on.\r\n"
		+ "Color, Incandescence and Opacity Inputs are defined as Z Gradient.\r\n"
		+ "\r\n"
		+ "Finer points:\r\n"
		+ "The Z size of the container is increased to add thickness. \r\n"
		+ "Increase the Resolution and Shading Quality for a better render result, but expect the render to take longer.\r\n"
		+ "Render with CloudPerlin2DCamera. \r\n"
		+ "Render time: $\r\n"
		+ "\r\n");
createNode transform -n "Haze";
createNode fluidShape -n "HazeShape" -p "Haze";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rh" 3;
	setAttr ".dw" 20;
	setAttr ".dh" 4;
	setAttr ".dd" 20;
	setAttr ".dmt" 3;
	setAttr ".dgr" 9;
	setAttr ".vmt" 0;
	setAttr ".cl[1].clp" 0.31428572535514832;
	setAttr ".cl[1].clc" -type "float3" 0.25982502 0.44093668 0.54699999 ;
	setAttr ".cl[1].cli" 0;
	setAttr -s 2 ".opa[0:1]"  1 0.2 1 0 0 1;
	setAttr ".opi" 2;
	setAttr ".oib" -0.33327999711036682;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 0;
	setAttr ".i[1].ip" 0.80000001192092896;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 0;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 1.5 1 0 ;
	setAttr ".i[2].ii" 0;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".edr" 0.17355999350547791;
createNode transform -n "Perlin2DCloudsCamera";
	setAttr ".t" -type "double3" 5.3020360527628601 -1.0139572563293469 2.8984902145537927 ;
	setAttr ".r" -type "double3" 13.461647270397609 56.600000000000023 1.4444441239544701e-015 ;
createNode camera -n "Perlin2DCloudsCameraShape" -p "Perlin2DCloudsCamera";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 6.134444493546928;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time";
createNode displayLayer -n "layer1";
	setAttr ".do" 1;
createNode displayLayerManager -n "layerManager";
	setAttr -s 2 ".dli[1]"  1;
	setAttr -s 2 ".dli";
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo7";
createNode shadingEngine -n "fluidShape6SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lightLinker -n "lightLinker1";
	setAttr ".ihi" 0;
	setAttr -s 4 ".lnk";
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
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 90;
	setAttr ".left" 200;
	setAttr ".bot" 37;
	setAttr ".rght" 244;
	setAttr ".oft" -type "string" "";
	setAttr -k on ".mbf";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
connectAttr "layer1.di" "Clouds.do";
connectAttr "expression1.out[0]" "CloudsShape.tti";
connectAttr ":time1.o" "CloudsShape.cti";
connectAttr "layer1.di" "CloudsShape.do";
connectAttr ":time1.o" "HazeShape.cti";
connectAttr ":time1.o" "expression1.tim";
connectAttr "layerManager.dli[1]" "layer1.id";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "CloudsShape.ocl" "fluidShape1SG.vs";
connectAttr "CloudsShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape6SG.msg" "materialInfo7.sg";
connectAttr "HazeShape.ocl" "fluidShape6SG.vs";
connectAttr "HazeShape.iog" "fluidShape6SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "fluidShape6SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape6SG.pa" ":renderPartition.st" -na;
connectAttr "CloudsShape.msg" ":defaultShaderList1.s" -na;
connectAttr "HazeShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of Perlin2DClouds.ma
