//Maya ASCII 4.5 scene
//Name: Perlin3DClouds.ma
//Last modified: Wed, Aug 21, 2002 12:18:10 PM
requires maya "4.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5";
fileInfo "cutIdentifier" "200208160514";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
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
	setAttr ".qua" 2;
	setAttr ".rin" 3;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.59799999 0.54477799 0.56564987 ;
	setAttr ".cl[0].cli" 1;
	setAttr -s 6 ".opa[0:5]"  0.5 0 1 1 1 1 0 0 0 0.58571428 0.66000003 1 0.67142856 
		0.86000001 1 0.50700003 0.36000001 1;
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
		"Target: \r\n"
		+ "A relatively detailed cloud bank.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Constant density gradient.\r\n"
		+ "Density opacity uses a Y gradient with a fast dropoff in the graph, basically erasing the lighter desnities. The use of a Y gradient for input puts more density at the bottom of the container.\r\n"
		+ "A Y gradient is used for incandescence. The incandescence has just enough colour to brighten up the dark side of the clouds and show more detail than colour alone.\r\n"
		+ "Perlin noise is used to texture the opacity. Inflection is on, to give the cloud a more billowy look. This is faster than the billow texture.\r\n"
		+ "Self shadow is on to give the light scattering and shadowing effect in the cloud.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Increasing resolution and shading quality will give\r\n"
		+ "better rendered results.\r\n"
		+ "Adding the second fluid as an environment fog adds a haze, giving the clouds a more realistic look;\r\n"
		+ "Render time: $.");
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" -90.57294489978284 0.32237996717612794 29.364287310456497 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	addAttr -ci true -sn "milt" -ln "miExportMrLight" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mils" -ln "miLightShader" -at "message";
	addAttr -ci true -sn "phot" -ln "emitPhotons" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "eng" -ln "energy" -at "compound" -nc 3;
	addAttr -ci true -sn "engr" -ln "energyR" -dv 8000 -at "float" -p "energy";
	addAttr -ci true -sn "engg" -ln "energyG" -dv 8000 -at "float" -p "energy";
	addAttr -ci true -sn "engb" -ln "energyB" -dv 8000 -at "float" -p "energy";
	addAttr -ci true -sn "exp" -ln "exponent" -dv 2 -at "float";
	addAttr -ci true -sn "cph" -ln "causticPhotons" -dv 10000 -at "long";
	addAttr -ci true -sn "gph" -ln "globIllPhotons" -dv 10000 -at "long";
	addAttr -ci true -sn "phy" -ln "physical" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "usm" -ln "shadowMap" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "smr" -ln "smapResolution" -dv 256 -at "long";
	addAttr -ci true -sn "smsa" -ln "smapSamples" -dv 1 -at "short";
	addAttr -ci true -sn "smso" -ln "smapSoftness" -at "float";
	addAttr -ci true -sn "smf" -ln "smapFilename" -dt "string";
	setAttr -k off ".v";
	setAttr ".in" 1.5;
createNode transform -n "Perlin3DCloudsCam";
	setAttr ".t" -type "double3" -8.0178510194643504 -6.4217176178484729 1.0596881784580416 ;
	setAttr ".r" -type "double3" 73.799999999999869 -79.999999999999773 -1.8316084419635984e-14 ;
	setAttr ".rp" -type "double3" 1.1102230246251565e-16 0 -4.4408920985006262e-16 ;
	setAttr ".rpt" -type "double3" 2.3117205048574121e-17 4.264560640962733e-16 
		5.4249142460932976e-16 ;
createNode camera -n "Perlin3DCloudsCamShape" -p "Perlin3DCloudsCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".cap" -type "double2" 1.41732 0.94488 ;
	setAttr ".ff" 0;
	setAttr ".ncp" 0.01;
	setAttr ".coi" 9.988402140214383;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
	setAttr ".col" -type "float3" 0.21011998 0.40053192 0.61799997 ;
createNode transform -n "environmentFog";
	setAttr ".t" -type "double3" -3.4565936436396161 0.79492967737459197 -2.6552044870568765 ;
	setAttr ".r" -type "double3" 6.3594588368780895 15.750664756896217 22.333213620275604 ;
createNode fluidShape -n "environmentFogShape" -p "environmentFog";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rd" 15;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 15;
	setAttr ".sli" 5;
	setAttr ".vqu" 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.1 0.0004000008 0.0004000008 ;
	setAttr ".cl[0].cli" 0;
	setAttr ".cl[1].clp" 0.97857141494750977;
	setAttr ".cl[1].clc" -type "float3" 0.22760001 0.24644907 0.40000001 ;
	setAttr ".cl[1].cli" 0;
	setAttr -s 3 ".opa[0:2]"  0 0 1 0.34 0.19285715 0 0 0 0;
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
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode cameraView -n "cameraView1";
	setAttr ".e" -type "double3" -8.0178510194643504 -6.4217176178484729 1.0596881784580419 ;
	setAttr ".coi" -type "double3" -5.273511519155301 3.1700818874014525 0.57578708032955883 ;
	setAttr ".u" -type "double3" -0.94570466682332055 0.27899110603923172 0.16675324854286475 ;
	setAttr ".ha" 1.41732;
	setAttr ".ow" 30;
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
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".fs" 1;
	setAttr ".ef" 10;
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultLightSet;
connectAttr ":time1.o" "CloudsShape.cti";
connectAttr "cameraView1.msg" "Perlin3DCloudsCamShape.b" -na;
connectAttr ":time1.o" "environmentFogShape.cti";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "CloudsShape.ocl" "fluidShape1SG.vs";
connectAttr "CloudsShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape3SG.msg" "materialInfo3.sg";
connectAttr "environmentFogShape.ocl" "fluidShape3SG.vs";
connectAttr "environmentFogShape.iog" "fluidShape3SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "fluidShape3SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape3SG.pa" ":renderPartition.st" -na;
connectAttr "CloudsShape.msg" ":defaultShaderList1.s" -na;
connectAttr "environmentFogShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of Perlin3DClouds.ma
