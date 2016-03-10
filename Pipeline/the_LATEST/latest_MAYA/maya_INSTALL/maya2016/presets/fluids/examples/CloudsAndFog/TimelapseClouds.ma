//Maya ASCII 5.0ff03 scene
//Name: TimelapseClouds.ma
//Last modified: Tue, Jan 07, 2003 04:46:10 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Mainline";
fileInfo "cutIdentifier" "200301060019";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Clouds";
createNode fluidShape -n "CloudsShape" -p "Clouds";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 30;
	setAttr ".rh" 3;
	setAttr ".rd" 30;
	setAttr ".dw" 20;
	setAttr ".dh" 2;
	setAttr ".dd" 20;
	setAttr ".bod" 5;
	setAttr ".dmt" 3;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr ".qua" 4;
	setAttr ".rin" 3;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.59799999 0.54477799 0.56564987 ;
	setAttr ".cl[0].cli" 1;
	setAttr -s 6 ".opa[0:5]"  0.5 0 1 1 1 1 0 0 0 0.58571428 
		0.66000003 1 0.67142856 0.86000001 1 0.50700003 0.36000001 1;
	setAttr ".opi" 2;
	setAttr ".oib" 0.10000000149011612;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0.55000001192092896;
	setAttr ".i[0].ic" -type "float3" 0.187332 0.19966076 0.26800001 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.8571428656578064;
	setAttr ".i[1].ic" -type "float3" 0.136353 0.16151655 0.301 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 0.4285714328289032;
	setAttr ".i[2].ic" -type "float3" 0.195021 0.19689654 0.27900001 ;
	setAttr ".i[2].ii" 1;
	setAttr ".ili" 2;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".dos" 6;
	setAttr ".edr" 0.37189999222755432;
	setAttr ".dl" -type "float3" 0.5 -0.80000001 0.5 ;
	setAttr ".otx" yes;
	setAttr ".a" 0.94213998317718506;
	setAttr ".ra" 0.61984002590179443;
	setAttr ".dm" 4;
	setAttr ".fq" 1.5;
	setAttr ".fr" 3.752000093460083;
	setAttr ".in" yes;
	setAttr ".imp" 0.25619998574256897;
	setAttr ".imc" -type "float3" 0 0 -3 ;
	setAttr ".nts" -type "string" (
		"Example Goal: \r\n"
		+ "A relatively detailed cloud with rapidly evolving animation.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Density is defined as a constant gradient.\r\n"
		+ "The shading uses a heavy Y Gradient Dropoff Shape.\r\n"
		+ "Incandescence Input is defined as Y Gradient.\r\n"
		+ "Opacity Input is defined as Y Gradient, which controls the cloud shape on a large scale.\r\n"
		+ "Opacity is textured with Perlin noise to control the details.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Increase Resolution and Shading Quality for a better render result.\r\n"
		+ "Self Shadow is turned on.\r\n"
		+ "Adding a second fluidShape as environment fog gives the clouds a more realistic look.\r\n"
		+ "Render with TimelapseCloudsCamera.\r\n"
		+ "Render time: $$");
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" -90.57294489978284 0.32237996717612794 29.364287310456497 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
	setAttr ".in" 1.5;
createNode transform -n "Haze";
createNode fluidShape -n "HazeShape" -p "Haze";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 20;
	setAttr ".rh" 5;
	setAttr ".rd" 20;
	setAttr ".dw" 20;
	setAttr ".dh" 5;
	setAttr ".dd" 20;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.1 0.0004000008 0.0004000008 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.97857141494750977;
	setAttr ".cl[1].clc" -type "float3" 0.22760001 0.24644907 0.40000001 ;
	setAttr ".cl[1].cli" 0;
	setAttr -s 3 ".opa[0:2]"  0 0 1 0.80714285 0.28 0 0 
		0 0;
	setAttr ".opi" 2;
	setAttr ".oib" -0.0089600002393126488;
	setAttr ".t" -type "float3" 0.77686 0.77686 0.77686 ;
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 0;
	setAttr ".ili" 2;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".edr" 0.04960000142455101;
createNode transform -n "TimelapseCloudsCamera";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -8.7164883973443636 -1.9254529898596409 -0.48278619419142926 ;
	setAttr ".r" -type "double3" 24.861647270351963 286.59999999999752 7.4636436209506398e-015 ;
	setAttr ".s" -type "double3" 1 1 -1 ;
createNode camera -n "TimelapseCloudsCameraShape" -p "TimelapseCloudsCamera";
	setAttr -k off ".v" no;
	setAttr ".ovr" 1.3;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 7.3913593825977095;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
	setAttr ".col" -type "float3" 0.27479702 0.37396255 0.57852 ;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time*0.5\r";
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "fluidShape3SG";
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
	setAttr ".sdf" -type "string" "";
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 225;
	setAttr ".left" 7;
	setAttr ".bot" 126;
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
connectAttr "expression1.out[0]" "CloudsShape.tti";
connectAttr ":time1.o" "CloudsShape.cti";
connectAttr ":time1.o" "HazeShape.cti";
connectAttr ":time1.o" "expression1.tim";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "CloudsShape.ocl" "fluidShape1SG.vs";
connectAttr "CloudsShape.iog" "fluidShape1SG.dsm" -na;
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
connectAttr "CloudsShape.msg" ":defaultShaderList1.s" -na;
connectAttr "HazeShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of TimelapseClouds.ma
