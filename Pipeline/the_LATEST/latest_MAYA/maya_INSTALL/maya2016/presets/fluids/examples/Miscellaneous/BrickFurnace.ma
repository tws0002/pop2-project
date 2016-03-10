//Maya ASCII 4.5 scene
//Name: BrickFurnace.ma
//Last modified: Wed, Jul 24, 2002 11:26:53 AM
requires maya "4.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207220603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode transform -n "fluidFurnace";
	setAttr ".r" -type "double3" 0 90 0 ;
	setAttr -av ".ry";
createNode fluidShape -n "fluidFurnaceShape" -p "fluidFurnace";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 10;
	setAttr ".vqu" 2;
	setAttr ".dmt" 3;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr ".qua" 8;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.114884 0.18633692 0.308 ;
	setAttr ".cl[0].cli" 1;
	setAttr -s 6 ".opa[2:7]"  0.25 1 2 0.37857142 1 2 0 0 2 0.21428572 0 2 0.43571427 
		0 2 1 0.039999999 2;
	setAttr ".t" -type "float3" 0 0 0 ;
	setAttr -s 4 ".i";
	setAttr ".i[2].ip" 0.44285714626312256;
	setAttr ".i[2].ic" -type "float3" 0.2 0.2 0.2 ;
	setAttr ".i[2].ii" 1;
	setAttr ".i[3].ip" 0.93571430444717407;
	setAttr ".i[3].ic" -type "float3" 5 4.4641666 0 ;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ip" 1;
	setAttr ".i[4].ic" -type "float3" 10 9.8092432 8.2200003 ;
	setAttr ".i[4].ii" 1;
	setAttr ".i[5].ip" 0.85000002384185791;
	setAttr ".i[5].ic" -type "float3" 2 0.58617204 0.024000049 ;
	setAttr ".i[5].ii" 1;
	setAttr ".ili" 4;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".edr" 0.16665999591350555;
	setAttr ".srr" yes;
	setAttr ".ssf" yes;
	setAttr ".rl" no;
	setAttr ".tty" 1;
	setAttr ".otx" yes;
	setAttr ".otxg" 1.4118399620056152;
	setAttr ".ivt" yes;
	setAttr ".ra" 0.66666001081466675;
	setAttr ".th" 0.088239997625350952;
	setAttr ".fr" 4;
	setAttr ".sp" 0.41176000237464905;
	setAttr ".rnd" 0;
	setAttr ".nts" -type "string" (
		"Preset Gaol: \r\n"
		+ "Brick furnace. \r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "Only density is used in Contents Method, and it is set to a constant gradient.\r\n"
		+ "A soft surface render is used. There is no transparency.\r\n"
		+ "The hot center to cool blue exterior looke is achieved by using an incandescence ramp with its input set to Center Gradient. The colour is set to deep blue. The incandescence adds orange, yellow and white near the denser center of the fluid. A single large flat peak in the opacity ramp controls the shape on a large scale.\r\n"
		+ "The detail is achieved by texutring the opacity with the Billow texture.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Increase resolution and shading quality for better render quality;\r\n"
		+ "Considering adding lights. Render time: $$$");
createNode transform -n "BrickFurnaceCam";
	setAttr ".t" -type "double3" 21.198042184253456 11.683248851582702 -6.4216417871354601 ;
	setAttr ".r" -type "double3" -28.799999999997087 108.00000000000054 0 ;
createNode camera -n "BrickFurnaceCamShape" -p "BrickFurnaceCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".cap" -type "double2" 1.41732 0.94488 ;
	setAttr ".ff" 0;
	setAttr ".ncp" 0.01;
	setAttr ".coi" 24.378818036061499;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode phong -n "phong1";
	setAttr ".sc" -type "float3" 1 1 1 ;
createNode animCurveTA -n "fluid1_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 90 90;
createNode lightLinker -n "lightLinker1";
	setAttr ".ihi" 0;
	setAttr -s 3 ".lnk";
select -ne :time1;
	setAttr ".o" 90;
select -ne :renderPartition;
	setAttr -s 3 ".st";
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
select -ne :shaderGlow1;
	setAttr ".th" 0.098999999463558197;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".top" 194;
	setAttr ".left" 64;
	setAttr ".bot" 139;
	setAttr ".rght" 114;
	setAttr ".an" yes;
	setAttr ".fs" 1;
	setAttr ".ef" 90;
	setAttr ".ep" 4;
	setAttr ".pff" yes;
	setAttr ".ifp" -type "string" "Rock2";
	setAttr ".npu" 1;
	setAttr -k on ".mbf";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultRenderQuality;
	setAttr ".rfl" 10;
	setAttr ".rfr" 10;
	setAttr ".sl" 10;
	setAttr ".eaa" 0;
	setAttr ".ufil" yes;
	setAttr ".ss" 4;
select -ne :defaultResolution;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
connectAttr "fluid1_rotateY.o" "fluidFurnace.ry";
connectAttr ":time1.o" "fluidFurnaceShape.cti";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "fluidFurnaceShape.ocl" "fluidShape1SG.vs";
connectAttr "fluidFurnaceShape.iog" "fluidShape1SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidFurnaceShape.msg" ":defaultShaderList1.s" -na;
connectAttr "phong1.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of BrickFurnace.ma
