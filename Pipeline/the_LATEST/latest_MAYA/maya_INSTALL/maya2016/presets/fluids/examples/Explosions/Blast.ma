//Maya ASCII 5.0ff03 scene
//Name: Blast.ma
//Last modified: Thu, Jan 09, 2003 11:28:21 AM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Beta2";
fileInfo "cutIdentifier" "200301080105";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Blast";
createNode fluidShape -n "BlastShape" -p "Blast";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 40;
	setAttr ".rh" 40;
	setAttr ".rd" 40;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 10;
	setAttr ".scd" 20;
	setAttr ".ssd" 3;
	setAttr ".bod" 4;
	setAttr ".ots" 3;
	setAttr ".dmt" 0;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr ".qua" 3;
	setAttr ".rin" 3;
	setAttr -s 5 ".cl";
	setAttr ".cl[9].clp" 0.30000001192092896;
	setAttr ".cl[9].clc" -type "float3" 0.70599997 0.23245345 0.14614201 ;
	setAttr ".cl[9].cli" 1;
	setAttr ".cl[10].clp" 0.99285715818405151;
	setAttr ".cl[10].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[10].cli" 1;
	setAttr ".cl[11].clp" 0.43571427464485168;
	setAttr ".cl[11].clc" -type "float3" 1 0.89283335 0 ;
	setAttr ".cl[11].cli" 1;
	setAttr ".cl[12].clp" 0.12142857164144516;
	setAttr ".cl[12].clc" -type "float3" 0.045000002 0.014816439 0.0093150008 ;
	setAttr ".cl[12].cli" 1;
	setAttr ".cl[13].clp" 0;
	setAttr ".cl[13].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[13].cli" 1;
	setAttr ".coi" 4;
	setAttr -s 8 ".opa[0:7]"  0.12142857 0 1 0.31400001 0.89999998 
		1 0 0 0 0 0 0 0 0 1 0.2 0.059999999 1 1 0.36000001 1 0.214 
		0.57999998 1;
	setAttr ".opi" 4;
	setAttr ".oib" -0.34784001111984253;
	setAttr ".t" -type "float3" 0.30980393 0.30980393 0.30980393 ;
	setAttr ".shp" 0.60000002384185791;
	setAttr -s 4 ".i";
	setAttr ".i[2].ip" 0.3571428656578064;
	setAttr ".i[2].ic" -type "float3" 1 0.459306 0.075999975 ;
	setAttr ".i[2].ii" 1;
	setAttr ".i[3].ip" 0.66428571939468384;
	setAttr ".i[3].ic" -type "float3" 2 2 2 ;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ip" 0.22857142984867096;
	setAttr ".i[4].ic" -type "float3" 0.214 0.19717346 0.193028 ;
	setAttr ".i[4].ii" 1;
	setAttr ".i[5].ip" 0;
	setAttr ".i[5].ic" -type "float3" 0 0 0 ;
	setAttr ".i[5].ii" 1;
	setAttr ".ili" 4;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".edr" 0.32354000210762024;
	setAttr ".ssf" yes;
	setAttr ".rl" no;
	setAttr ".dl" -type "float3" 0.5 2 0.5 ;
	setAttr ".ctx" yes;
	setAttr ".ctxg" 0.6666799783706665;
	setAttr ".itx" yes;
	setAttr ".itxg" 0.78431999683380127;
	setAttr ".otx" yes;
	setAttr ".otxg" 0.58824002742767334;
	setAttr ".a" 1.5648499727249146;
	setAttr ".ra" 0.36276000738143921;
	setAttr ".th" 0.10000000149011612;
	setAttr ".tor" -type "float3" 0 -0.0099999998 0 ;
	setAttr ".dm" 3;
	setAttr ".fq" 2;
	setAttr ".fr" 3;
	setAttr ".in" yes;
	setAttr ".imp" 0.10000000149011612;
	setAttr ".imc" -type "float3" 0 -0.050000001 0 ;
	setAttr ".nts" -type "string" (
		"Example Goal:\r\n"
		+ "Explosive blast.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Density is defined as a constant gradient. \r\n"
		+ "The shading uses a cube Dropoff Shape. \r\n"
		+ "Color, Incandescence and Opacity all use Center Gradient as inputs. \r\n"
		+ "Texture Color, Incandescence and Opacity with Perlin Noise and turn Inflection on. \r\n"
		+ "Use Implode to add character to the shape. \r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Keyframe Glow Intensity, Color and Incandescence Input Bias, and Texture Time for desired motion. \r\n"
		+ "Increase Resolution and Shading Quality for a better render result, although it will take longer to render.\r\n"
		+ "Render using BlastCamera.\r\n"
		+ "Render time: $$$");
createNode transform -n "BlastCamera";
	addAttr -ci true -h true -sn "dfm" -ln "miDeriveFromMaya" -dv 1 -min 0 
		-max 1 -at "bool";
	addAttr -ci true -sn "hde" -ln "miHide" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "vsb" -ln "miVisible" -dv 2 -at "short";
	addAttr -ci true -sn "trc" -ln "miTrace" -dv 2 -at "short";
	addAttr -ci true -sn "shd" -ln "miShadow" -dv 2 -at "short";
	addAttr -ci true -sn "cst" -ln "miCaustic" -dv 5 -at "short";
	addAttr -ci true -sn "glb" -ln "miGlobillum" -dv 5 -at "short";
	addAttr -ci true -sn "mieg" -ln "miExportGeoShader" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "migs" -ln "miGeoShader" -at "message";
createNode camera -n "BlastCameraShape" -p "BlastCamera";
	setAttr -k off ".v";
	setAttr ".cap" -type "double2" 1.41732 0.94488000000000005 ;
	setAttr ".ff" 0;
	setAttr ".ovr" 1.3;
	setAttr ".ncp" 0.01;
	setAttr ".coi" 5.9249669613826574;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
	setAttr ".dr" yes;
	setAttr ".col" -type "float3" 0.015672732 0.016519999 0.015264479 ;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time*0.5";
createNode displayLayer -n "layer1";
	setAttr ".do" 1;
createNode displayLayerManager -n "layerManager";
	setAttr ".cdl" 3;
	setAttr -s 4 ".dli[1:3]"  1 2 3;
	setAttr -s 2 ".dli";
createNode animCurveTU -n "fluidShape1_colorInputBias";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 -1 3 0.36932000517845154 8 -0.47699999809265137;
createNode animCurveTU -n "fluidShape1_incandescenceInputBias";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 5 ".ktv[0:4]"  1 -1 3 0.32843328650920645 8 0.15320000052452087 
		45 -1 60 -1;
	setAttr -s 5 ".kit[1:4]"  1 9 9 9;
	setAttr -s 5 ".kot[1:4]"  1 9 9 9;
	setAttr -s 5 ".kix[1:4]"  0.99511235952377319 0.79650557041168213 
		0.88275110721588135 1;
	setAttr -s 5 ".kiy[1:4]"  -0.098749004304409027 -0.60463118553161621 
		-0.46984091401100159 0;
	setAttr -s 5 ".kox[1:4]"  0.99511235952377319 0.79650557041168213 
		0.88275110721588135 1;
	setAttr -s 5 ".koy[1:4]"  -0.098749369382858276 -0.60463118553161621 
		-0.46984091401100159 0;
createNode animCurveTU -n "fluidShape1_glowIntensity";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0.10000000149011612 3 0.40000000596046448 
		30 0;
	setAttr -s 3 ".kit[1:2]"  3 9;
	setAttr -s 3 ".kot[1:2]"  1 9;
	setAttr -s 3 ".ktl[1:2]" no yes;
	setAttr -s 3 ".kox[1:2]"  0.95257490873336792 0.94221466779708862;
	setAttr -s 3 ".koy[1:2]"  -0.30430415272712708 -0.33500966429710388;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode animCurveTU -n "fluid1_scaleX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0.20000000000000001 3 0.90000000000000002 
		45 1.1000000000000001;
createNode animCurveTU -n "fluid1_scaleY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0.20000000000000001 3 0.90000000000000002 
		45 1.1000000000000001;
createNode animCurveTU -n "fluid1_scaleZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0.20000000000000001 3 0.90000000000000002 
		45 1.1000000000000001;
createNode animCurveTU -n "camera1_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 60 1;
	setAttr -s 2 ".kot[0:1]"  5 5;
createNode animCurveTL -n "camera1_translateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -6.0334313048162835 60 -4.134529850498244;
createNode animCurveTL -n "camera1_translateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -1.2473773481825927 60 -0.42698108368725407;
createNode animCurveTL -n "camera1_translateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -7.482674226018232 60 -5.0762278779758629;
createNode animCurveTA -n "camera1_rotateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 11.999999999989432 60 10.199999999989355;
createNode animCurveTA -n "camera1_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -864.79999999997608 60 -864.39999999997576;
createNode animCurveTA -n "camera1_rotateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 60 0;
createNode animCurveTU -n "camera1_scaleX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 60 1;
createNode animCurveTU -n "camera1_scaleY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 60 1;
createNode animCurveTU -n "camera1_scaleZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 60 1;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 10;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 3 ".s";
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
	setAttr ".top" 156;
	setAttr ".left" 186;
	setAttr ".bot" 80;
	setAttr ".rght" 279;
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
connectAttr "layer1.di" "Blast.do";
connectAttr "fluid1_scaleX.o" "Blast.sx";
connectAttr "fluid1_scaleY.o" "Blast.sy";
connectAttr "fluid1_scaleZ.o" "Blast.sz";
connectAttr ":time1.o" "BlastShape.cti";
connectAttr "expression1.out[0]" "BlastShape.tti";
connectAttr "layer1.di" "BlastShape.do";
connectAttr "fluidShape1_colorInputBias.o" "BlastShape.cib";
connectAttr "fluidShape1_incandescenceInputBias.o" "BlastShape.iib";
connectAttr "fluidShape1_glowIntensity.o" "BlastShape.gi";
connectAttr "camera1_visibility.o" "BlastCamera.v";
connectAttr "camera1_translateX.o" "BlastCamera.tx";
connectAttr "camera1_translateY.o" "BlastCamera.ty";
connectAttr "camera1_translateZ.o" "BlastCamera.tz";
connectAttr "camera1_rotateX.o" "BlastCamera.rx";
connectAttr "camera1_rotateY.o" "BlastCamera.ry";
connectAttr "camera1_rotateZ.o" "BlastCamera.rz";
connectAttr "camera1_scaleX.o" "BlastCamera.sx";
connectAttr "camera1_scaleY.o" "BlastCamera.sy";
connectAttr "camera1_scaleZ.o" "BlastCamera.sz";
connectAttr ":time1.o" "expression1.tim";
connectAttr "layerManager.dli[1]" "layer1.id";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "BlastShape.ocl" "fluidShape1SG.vs";
connectAttr "BlastShape.iog" "fluidShape1SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "BlastShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of Blast.ma
