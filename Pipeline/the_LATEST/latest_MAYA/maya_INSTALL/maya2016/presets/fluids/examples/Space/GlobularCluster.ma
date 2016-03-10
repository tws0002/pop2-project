//Maya ASCII 4.5 scene
//Name: GlobularCluster.ma
//Last modified: Thu, Jul 25, 2002 01:02:48 PM
requires maya "4.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207240603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode transform -n "globularCluster";
createNode fluidShape -n "globularClusterShape" -p "globularCluster";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 10;
	setAttr ".sli" 12;
	setAttr ".vqu" 2;
	setAttr ".bod" 5;
	setAttr ".dmt" 3;
	setAttr ".dsc" 0.69999998807907104;
	setAttr ".vmt" 0;
	setAttr ".rin" 3;
	setAttr -s 4 ".cl";
	setAttr ".cl[1].clp" 0.24285714328289032;
	setAttr ".cl[1].clc" -type "float3" 0.54799998 0.11179199 0.12829512 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 1;
	setAttr ".cl[2].clc" -type "float3" 1 0.64199996 0.64796662 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0.37857142090797424;
	setAttr ".cl[3].clc" -type "float3" 0.283061 0.713 0.31767112 ;
	setAttr ".cl[3].cli" 1;
	setAttr ".cl[4].clp" 0.72142899036407471;
	setAttr ".cl[4].cli" 1;
	setAttr ".coi" 4;
	setAttr ".cib" -0.36932000517845154;
	setAttr -s 13 ".opa[0:12]"  0 0 2 1 0.16 2 0.44285715 0.28 2 0.49285713 
		0 2 0.65714288 0.22 2 0.63571429 0 2 0.38571429 0 2 0.70714283 0 2 0.91428572 
		0 2 0 0 2 0.11428571 0.31999999 2 0.085714288 0 2 0.16428572 0 2;
	setAttr ".opi" 4;
	setAttr ".oib" 0.099079996347427368;
	setAttr ".t" -type "float3" 0.38016 0.38016 0.38016 ;
	setAttr -s 4 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 3;
	setAttr ".i[1].ip" 0.28571429848670959;
	setAttr ".i[1].ic" -type "float3" 0.35787967 0.081859022 0.75099999 ;
	setAttr ".i[1].ii" 3;
	setAttr ".i[4].ip" 0.93571430444717407;
	setAttr ".i[4].ic" -type "float3" 1 1 1 ;
	setAttr ".i[4].ii" 3;
	setAttr ".i[6].ip" 0.75;
	setAttr ".i[6].ic" -type "float3" 0.38099998 0.58310348 1 ;
	setAttr ".i[6].ii" 3;
	setAttr ".ili" 5;
	setAttr ".iib" -0.4593999981880188;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 1;
	setAttr ".edr" 0.5;
	setAttr ".otx" yes;
	setAttr ".otxg" 1.6694400310516357;
	setAttr ".a" 0.76858001947402954;
	setAttr ".ra" 0.75204002857208252;
	setAttr ".dm" 4;
	setAttr ".fq" 0.24799999594688416;
	setAttr ".fr" 2.4131999015808105;
	setAttr ".imp" 2.6447999477386475;
	setAttr ".nts" -type "string" (
		"Preset Goal: \r\n"
		+ "To create a gaseous stellar nebula, glowing from a star's radiation. \r\n"
		+ "\r\n"
		+ "\r\n"
		+ "Basic Consuction: \r\n"
		+ "This is not a dynamic simulation. The effect is achieved with only the contents method for density. It is set to a constant gradient. Colour, incandescence and opacity are set to a center gradient. Note the colour ranges and placement used for the colour and incandescence ramps, to give a range from the center of the container to the perimeter. The opacity graph emphasizes only short ranges of the density. This gives the spottiness. The colours and incandescence are distributed from the center out, while the opacity is driven by the amount of density. The texture values are crucial to this look. The threshold and amplitude are below default and implode is used. Depth max is up for detail and frequency is quite low.\r\n"
		+ "Have a look through globularClusterCamera.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "This is 3 dimensional fluid so the camera can be placed inside the nebula. The colours of the nebula depend on both the colour ramp and the incandescence ramp. Try changing the colours, their postions or the Input bias. The latter skews the entire range of colour without effecting the end colours.Try adding a glow to the fluid or the light in the scene. Adjusting the frequency ratio, depth max, frequency and texture scale will have interesting effects. Adjusting the opacity graph will have a large effect on how much of the fluid you see. Texture time will do the most to vary the texture. Try keyframing positions of the opacity graph to animate the opacity at different parts of the fluid. Render time: $.");
createNode transform -n "GlobularClusterCam";
	setAttr ".t" -type "double3" 7.1109940868807167 2.5431950817159308 8.8838236593996935 ;
	setAttr ".r" -type "double3" -11.999999999999932 40.800000000000018 9.7686102163982087e-14 ;
	setAttr ".rp" -type "double3" 8.8817841970012523e-16 1.1102230246251565e-16 
		-2.6645352591003757e-15 ;
	setAttr ".rpt" -type "double3" -1.9339303983664941e-15 -5.5641413464395882e-16 
		9.3744735001683287e-17 ;
createNode camera -n "GlobularClusterCamShape" -p "GlobularClusterCam";
	setAttr -k off ".v";
	setAttr ".cap" -type "double2" 1.41732 0.94488 ;
	setAttr ".ff" 0;
	setAttr ".ovr" 1.3;
	setAttr ".ncp" 0.01;
	setAttr ".coi" 11.651746491066035;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
	setAttr ".dr" yes;
createNode transform -n "pointLight1";
createNode pointLight -n "pointLightShape1" -p "pointLight1";
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
	addAttr -ci true -sn "algt" -ln "areaLight" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atyp" -ln "areaType" -at "short";
	addAttr -ci true -sn "ano" -ln "areaNormal" -at "compound" -nc 3;
	addAttr -ci true -sn "anox" -ln "areaNormalX" -at "float" -p "areaNormal";
	addAttr -ci true -sn "anoy" -ln "areaNormalY" -dv 2 -at "float" -p "areaNormal";
	addAttr -ci true -sn "anoz" -ln "areaNormalZ" -at "float" -p "areaNormal";
	addAttr -ci true -sn "aed" -ln "areaEdge" -at "compound" -nc 3;
	addAttr -ci true -sn "aedx" -ln "areaEdgeX" -dv 2 -at "float" -p "areaEdge";
	addAttr -ci true -sn "aedy" -ln "areaEdgeY" -at "float" -p "areaEdge";
	addAttr -ci true -sn "aedz" -ln "areaEdgeZ" -at "float" -p "areaEdge";
	addAttr -ci true -sn "arad" -ln "areaRadius" -dv 2 -at "float";
	addAttr -ci true -sn "asa" -ln "areaSampling" -at "compound" -nc 2;
	addAttr -ci true -sn "asau" -ln "areaSamplingU" -dv 3 -at "short" -p "areaSampling";
	addAttr -ci true -sn "asav" -ln "areaSamplingV" -dv 3 -at "short" -p "areaSampling";
	addAttr -ci true -sn "alev" -ln "areaLowLevel" -at "short";
	addAttr -ci true -sn "alo" -ln "areaLowSampling" -at "compound" -nc 2;
	addAttr -ci true -sn "alou" -ln "areaLowSamplingU" -dv 2 -at "short" -p "areaLowSampling";
	addAttr -ci true -sn "alov" -ln "areaLowSamplingV" -dv 2 -at "short" -p "areaLowSampling";
	addAttr -ci true -sn "avis" -ln "areaVisible" -min 0 -max 1 -at "bool";
	setAttr -k off ".v";
	setAttr ".in" 2;
	setAttr ".us" no;
createNode animCurveTU -n "globularClusterShape_color_4__color_ColorR";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  1 0.23600000143051147 60 1;
createNode animCurveTU -n "globularClusterShape_color_4__color_ColorG";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  1 0.23600000143051147 60 1;
createNode animCurveTU -n "globularClusterShape_color_4__color_ColorB";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  1 0 60 0;
createNode animCurveTU -n "globularClusterShape_threshold";
	setAttr ".tan" 2;
	setAttr -s 3 ".ktv[0:2]"  1 0.32234001159667969 30 0.35199999809265137 60 
		0.39817921607502971;
createNode animCurveTU -n "globularClusterShape_textureTime";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  1 4.049799919128418 60 5;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode cameraView -n "globularCluster1";
	setAttr ".e" -type "double3" 7.1109940868807167 2.5431950817159308 8.8838236593996935 ;
	setAttr ".coi" -type "double3" -0.33612409268947285 0.12066076777849677 
		0.25625420970063217 ;
	setAttr ".u" -type "double3" -0.13585378259074438 0.97814760073380569 -0.15738812196124052 ;
	setAttr ".ha" 1.41732;
	setAttr ".ow" 30;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 60;
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
	setAttr -k on ".mwc";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".sdf" -type "string" "";
	setAttr ".outf" 3;
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 238;
	setAttr ".rght" 318;
	setAttr ".an" yes;
	setAttr ".ef" 60;
	setAttr ".bf" 1.248;
	setAttr ".ofe" -type "string" "";
	setAttr ".efe" -type "string" "";
	setAttr ".lse" -type "string" "";
	setAttr ".rse" -type "string" "";
	setAttr ".oft" -type "string" "";
	setAttr ".pff" yes;
	setAttr ".ifp" -type "string" "";
	setAttr -k on ".mbf";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".pfrm" -type "string" "";
	setAttr ".pfom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultRenderQuality;
	setAttr ".rfl" 10;
	setAttr ".rfr" 10;
	setAttr ".sl" 10;
	setAttr ".eaa" 0;
	setAttr ".ufil" yes;
	setAttr ".ss" 2;
select -ne :defaultResolution;
	setAttr ".pa" 0.67500001192092896;
	setAttr ".al" yes;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
select -ne :defaultLightSet;
connectAttr "globularClusterShape_color_4__color_ColorR.o" "globularClusterShape.cl[4].clcr"
		;
connectAttr "globularClusterShape_color_4__color_ColorG.o" "globularClusterShape.cl[4].clcg"
		;
connectAttr "globularClusterShape_color_4__color_ColorB.o" "globularClusterShape.cl[4].clcb"
		;
connectAttr ":time1.o" "globularClusterShape.cti";
connectAttr "globularClusterShape_threshold.o" "globularClusterShape.th"
		;
connectAttr "globularClusterShape_textureTime.o" "globularClusterShape.tti"
		;
connectAttr "globularCluster1.msg" "GlobularClusterCamShape.b" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "globularClusterShape.ocl" "fluidShape1SG.vs";
connectAttr "globularClusterShape.iog" "fluidShape1SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "globularClusterShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "pointLightShape1.ltd" ":lightList1.l" -na;
connectAttr "pointLight1.iog" ":defaultLightSet.dsm" -na;
// End of GlobularCluster.ma
