//Maya ASCII 5.0ff03 scene
//Name: Chrysanthemums.ma
//Last modified: Tue, Jan 07, 2003 05:13:42 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Mainline";
fileInfo "cutIdentifier" "200301060019";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Chrysanthemum1";
createNode fluidShape -n "Chrysanthemum1Shape" -p "Chrysanthemum1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 60;
	setAttr ".rh" 60;
	setAttr ".rd" 1;
	setAttr ".dw" 12;
	setAttr ".dh" 12;
	setAttr ".dd" 3.01;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 2;
	setAttr ".hss" no;
	setAttr ".ots" 43;
	setAttr ".dmt" 3;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr ".cl[12].clp" 0;
	setAttr ".cl[12].clc" -type "float3" 1.2 1.2 1.2 ;
	setAttr ".cl[12].cli" 0;
	setAttr ".coi" 5;
	setAttr ".cib" 0.36935999989509583;
	setAttr -s 8 ".opa";
	setAttr ".opa[0:4]" 0.22857142984867096 0 1 0.24300000071525574 
		0.2199999988079071 1 0 0 0 1 0.039999999105930328 1 0.86428570747375488 
		0.039999999105930328 1;
	setAttr ".opa[9:11]" 0.76428574323654175 0 1 0.87099999189376831 
		1 1 0 0 0;
	setAttr ".opi" 4;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.79285717010498047;
	setAttr ".i[1].ic" -type "float3" 0 0.31922197 0.77200001 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 0 0.67899805 0.84399998 ;
	setAttr ".i[2].ii" 1;
	setAttr ".ili" 5;
	setAttr ".gi" 0.10000000149011612;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".rl" no;
	setAttr ".tty" 3;
	setAttr ".otx" yes;
	setAttr ".otxg" 1.6200000047683716;
	setAttr -av ".a" 0.4050000011920929;
	setAttr ".ra" 0.74699997901916504;
	setAttr ".fq" 4.0500001907348633;
	setAttr -av ".imp" 0.7685999870300293;
	setAttr ".imc" -type "float3" 0 0 3 ;
	setAttr ".nts" -type "string" (
		"Example Goal:\r\n"
		+ "An animated flower in a 2D container.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Density is defined as a constant gradient in a 2D container.\r\n"
		+ "Opacity Input is defined as Center Gradient.\r\n"
		+ "Opacity is textured using Wispy noise. \r\n"
		+ "The implode value is high to add character.\r\n"
		+ "\r\n"
		+ "Finer points:\r\n"
		+ "Use Frequency to control the number of flower petals.\r\n"
		+ "Increase Resolution and Shading Quality for a better render result.\r\n"
		+ "Increase the Z size of the container to add depth.\r\n"
		+ "Render using the ChrysanthemumsCamera.\r\n"
		+ "Render Time: $");
createNode transform -n "Chrysanthemum2";
	setAttr ".r" -type "double3" 0 0 69.173660419393357 ;
createNode fluidShape -n "ChrysanthemumShape2" -p "Chrysanthemum2";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 60;
	setAttr ".rh" 60;
	setAttr ".rd" 1;
	setAttr ".dw" 12;
	setAttr ".dh" 12;
	setAttr ".dd" 3.01;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 2;
	setAttr ".hss" no;
	setAttr ".ots" 43;
	setAttr ".dmt" 3;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 0;
	setAttr ".cl[12].clp" 0.22857142984867096;
	setAttr ".cl[12].clc" -type "float3" 1.2 1.2 1.2 ;
	setAttr ".cl[12].cli" 0;
	setAttr ".coi" 5;
	setAttr ".cib" 0.36935999989509583;
	setAttr -s 8 ".opa";
	setAttr ".opa[0:4]" 0.76399999856948853 0 1 0.24300000071525574 
		0.2199999988079071 1 0 0 0 0.86400002241134644 0 1 0.22900000214576721 
		0 1;
	setAttr ".opa[9:11]" 0.87099999189376831 1 1 1 0 0 0 
		0 0;
	setAttr ".opi" 4;
	setAttr ".t" -type "float3" 0.26446 0.26446 0.26446 ;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 0;
	setAttr ".i[1].ip" 0.80000001192092896;
	setAttr ".i[1].ic" -type "float3" 0 0.24530996 0.66299999 ;
	setAttr ".i[1].ii" 0;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 0 0.56408596 0.78600001 ;
	setAttr ".i[2].ii" 0;
	setAttr ".ili" 5;
	setAttr ".gi" 0.10000000149011612;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".rl" no;
	setAttr ".tty" 3;
	setAttr ".otx" yes;
	setAttr ".otxg" 1.6198400259017944;
	setAttr ".a" 0.40498000383377075;
	setAttr ".fq" 4.0496001243591309;
	setAttr ".imp" 0.7685999870300293;
	setAttr ".imc" -type "float3" 0 0 3 ;
	setAttr ".nts" -type "string" (
		"Example Goal:\r\n"
		+ "An animated flower in a 2D container.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Density is defined as a constant gradient in a 2D container.\r\n"
		+ "Opacity Input is defined as Center Gradient.\r\n"
		+ "Opacity is textured using Wispy noise. \r\n"
		+ "The implode value is high to add character.\r\n"
		+ "\r\n"
		+ "Finer points:\r\n"
		+ "Use Frequency to control the number of flower petals.\r\n"
		+ "Increase Resolution and Shading Quality for a better render result.\r\n"
		+ "Increase the Z size of the container to add depth.\r\n"
		+ "Render using the ChrysanthemumsCamera.\r\n"
		+ "Render Time: $");
createNode transform -n "ChrysanthemumsCamera";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -1.7899525892925205 -7.0809158758028383 10.886134861174909 ;
	setAttr ".r" -type "double3" 27.861647270399359 0.60000000000069431 -4.969889191964474e-017 ;
	setAttr ".s" -type "double3" 1 1 1 ;
createNode camera -n "ChrysanthemumsCameraShape" -p "ChrysanthemumsCamera";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 11.732450383471283;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode animCurveTU -n "fluidShape1_textureTime";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 3 80 5.4545998573303223;
createNode animCurveTU -n "fluidShape1_opacityInputBias";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -1 45 -0.45943999290466309;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode animCurveTL -n "fluid1_translateX";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  55 -2.2147035646924143 80 0;
	setAttr -s 2 ".kit[1]"  2;
	setAttr -s 2 ".kot[1]"  2;
createNode animCurveTL -n "fluid1_translateY";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  55 -1.1118627362877538 80 0;
createNode animCurveTA -n "fluid1_rotateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 80 360;
createNode animCurveTU -n "fluidShape2_opacityInputBias";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -1 80 -0.45943999290466309;
createNode animCurveTU -n "fluidShape2_textureTime";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 3 90 5.4545998573303223;
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "fluidShape2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode animCurveTL -n "fluid2_translateX";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr ".ktv[0]"  90 -3.0585094231659475;
createNode animCurveTL -n "fluid2_translateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr ".ktv[0]"  90 -1.3708078777667141;
createNode animCurveTL -n "fluid2_translateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr ".ktv[0]"  90 -2.8998281570353597;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 80;
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
connectAttr "fluid1_translateX.o" "Chrysanthemum1.tx";
connectAttr "fluid1_translateY.o" "Chrysanthemum1.ty";
connectAttr "fluid1_rotateZ.o" "Chrysanthemum1.rz";
connectAttr ":time1.o" "Chrysanthemum1Shape.cti";
connectAttr "fluidShape1_textureTime.o" "Chrysanthemum1Shape.tti";
connectAttr "fluidShape1_opacityInputBias.o" "Chrysanthemum1Shape.oib";
connectAttr "fluid2_translateX.o" "Chrysanthemum2.tx";
connectAttr "fluid2_translateY.o" "Chrysanthemum2.ty";
connectAttr "fluid2_translateZ.o" "Chrysanthemum2.tz";
connectAttr ":time1.o" "ChrysanthemumShape2.cti";
connectAttr "fluidShape2_opacityInputBias.o" "ChrysanthemumShape2.oib";
connectAttr "fluidShape2_textureTime.o" "ChrysanthemumShape2.tti";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "Chrysanthemum1Shape.ocl" "fluidShape1SG.vs";
connectAttr "Chrysanthemum1Shape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape2SG.msg" "materialInfo2.sg";
connectAttr "ChrysanthemumShape2.ocl" "fluidShape2SG.vs";
connectAttr "ChrysanthemumShape2.iog" "fluidShape2SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "fluidShape2SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape2SG.pa" ":renderPartition.st" -na;
connectAttr "Chrysanthemum1Shape.msg" ":defaultShaderList1.s" -na;
connectAttr "ChrysanthemumShape2.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of Chrysanthemums.ma
