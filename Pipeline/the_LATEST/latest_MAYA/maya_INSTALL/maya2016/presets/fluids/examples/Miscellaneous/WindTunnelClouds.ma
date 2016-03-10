//Maya ASCII 4.5 scene
//Name: WindTunnelClouds.ma
//Last modified: Tue, Jul 23, 2002 03:20:52 PM
requires maya "4.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207220603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -0.6604661725619968 4.2840393439008997 31.28532606398592 ;
	setAttr ".r" -type "double3" 1.461647270408482 -720.99999999989495 -3.1064835636099454e-18 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".coi" 34.837503622037353;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".col" -type "float3" 0.098099001 0.17662907 0.373 ;
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "windTunnel";
	setAttr ".t" -type "double3" 0 5.2304438834679141 0 ;
	setAttr ".s" -type "double3" 1.0299097217414335 1.0321402496293275 1 ;
createNode fluidShape -n "windTunnelShape" -p "windTunnel";
	addAttr -ci true -sn "windSpeed" -ln "windSpeed" -dv 10 -min 0 -max 200 
		-at "double";
	addAttr -ci true -sn "cloudScaleU" -ln "cloudScaleU" -dv 1 -min 0 -max 100 
		-at "double";
	addAttr -ci true -sn "cloudScaleV" -ln "cloudScaleV" -dv 1 -min 0 -max 100 
		-at "double";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".sso" yes;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 100;
	setAttr ".rh" 30;
	setAttr ".rd" 1;
	setAttr ".dw" 33;
	setAttr ".dh" 10;
	setAttr ".dd" 0.5;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 4;
	setAttr ".vdl" 0.63104;
	setAttr ".hss" no;
	setAttr ".bndx" 0;
	setAttr ".dsc" 0.58256000280380249;
	setAttr ".dsb" 0;
	setAttr ".tgr" 6;
	setAttr ".tmsc" 0.87379997968673706;
	setAttr ".tds" 0;
	setAttr ".tdf" 0;
	setAttr ".ttb" 0;
	setAttr ".buo" 1000;
	setAttr ".rin" 3;
	setAttr -s 2 ".cl";
	setAttr ".cl[4].clp" 0;
	setAttr ".cl[4].clc" -type "float3" 0.51100004 0.65778148 1 ;
	setAttr ".cl[4].cli" 1;
	setAttr ".cl[5].clp" 0.63571429252624512;
	setAttr ".cl[5].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[5].cli" 1;
	setAttr ".coi" 5;
	setAttr ".cib" 0.043519999831914902;
	setAttr -s 4 ".opa[0:3]"  0 0 3 1 1 1 0.54285717 0.18000001 3 0.6857143 
		0.51999998 3;
	setAttr ".oib" 0.13043999671936035;
	setAttr ".t" -type "float3" 0.086274512 0.086274512 0.086274512 ;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.56428569555282593;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 1.5 1 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 0;
	setAttr ".edr" 0.13594000041484833;
	setAttr ".smpm" 0;
	setAttr ".rl" no;
	setAttr ".fq" 1.4078400135040283;
	setAttr ".csd" 1;
	setAttr -k on ".windSpeed" 38.836;
	setAttr -k on ".cloudScaleU" 47.572;
	setAttr -k on ".cloudScaleV" 75.728000000000009;
	setAttr ".nts" -type "string" (
		"You will see 2 errors when this scene is imported from Visor.  They are safe to ignore.  More details are below. \n\n"+
		"This node simulates a flowing bank of clouds that can be used in a flying animation. An expression computes a cloud density and flow velocity at the inflow boundary. At any given time step a slice out of a 2D noise function is used to seed the density at the inflow boundary. This slice changes at a rate that matches the inflow speed, creating a continually varying textured inflow.\n"
		+ "Open the extra attributes section above to see custom wind tunnel attributes. Wind speed controls the velocity at the minX boundary. The scale of the noise function can be adjusted with the cloudScaleUV attributes. \n"
		+ "Any geometry can collide with the flow. Select the object and the fluid then make collide under the fluids menu. The flow will collide with the cross section of the object along the mid point of the fluid.\n"
		+ "To create clean collision edges one thing that can help is to make a slightly inset collision object. One should generally use a higher resolution grid for final output.  To make the flow smoother when doing this, especially at fast wind speeds, it is recomended to cache the fluid with oversampling."
	+ "\n\nYou will see 2 errors when this scene is imported from Visor.  They are safe to ignore. Press Play to start the fluid simulation.  The errors are:\n\n"
	+" // Error: line: No object matches: windTunnelShape\n"
	+" // Error: line: An execution error occured in the expression WindTunnelParticles:expression1.");
createNode transform -n "nurbsSphere1";
	setAttr ".t" -type "double3" -3.4150930889640159 3.9621668857445727 -0.35275056182439046 ;
	setAttr ".s" -type "double3" 7.3036878152982672 3.5361671714351415 -7.7183509390219367 ;
createNode nurbsSurface -n "nurbsSphereShape1" -p "nurbsSphere1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 35 ".cp[0:34]" -type "double3" 0 0.17791211646996064 0 0 0.17791211646996064 
		0 0 0.17791211646996064 0 0 0.17791211646996064 0 0 0 0 0 0 0 0 0 0 0.24378930433296211 
		0.43059612374587375 -0.37829845639456483 -0.32619544780080872 0.24432931901540228 
		0 -0.062754142183892331 -2.2204460492503131e-16 0.5016780826252335 -0.68286754578055431 
		-2.7755575615628914e-16 0 0 0 0 0 0 0 0 0 0 0.069570641612902107 0.15339620503645579 
		-0.017349986811602713 0 0 0 0.170295309729799 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0.24378930433296211 -0.43059612374587325 -0.37829845639456483 -0.32619544780080872 
		-0.24432931901540228 0 -0.14024623180932028 0 0.50167808262523372 -0.41470898535837253 
		-0.011307156382805383 0 0 0 0 0 0 0 0 0 0 0 -0.18762393390757165 0 0 -0.18762393390757165 
		0 0 -0.18762393390757165 0 0 -0.18762393390757165 0 0 0 0 0 0 0 0 0 0;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "WindTunnelCam";
	setAttr ".t" -type "double3" 4.0926190098919228 5.8397673302806075 31.847533380357685 ;
	setAttr ".r" -type "double3" -1.5383527296034269 5.800000000000038 1.2487971285615664e-17 ;
createNode camera -n "WindTunnelCamShape" -p "WindTunnelCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".coi" 32.472514509845638;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode lightLinker -n "lightLinker1";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
createNode renderLayer -s -n "globalRender";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 150 -ast 0 -aet 5000 ";
	setAttr ".st" 6;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr -s 4 ".in";
	setAttr -s 4 ".in";
	setAttr ".ixp" -type "string" (
		"float $vel = .I[0];\n"
		+ "int $yres = .I[1];\n"
		+ "float $density = 0.6;\n"
		+ "// set the velocity at an extra column for stability of flow\n"
		+ "setFluidAttr -at velocity -xi 0 -vv $vel 0 0 windTunnelShape;\n"
		+ "setFluidAttr -at velocity -xi 1 -vv $vel 0 0 windTunnelShape;\n"
		+ "int $i,$j;\n"
		+ "float $uscale = .0001 * .I[2];\n"
		+ "float $vscale = .1 * .I[3];\n"
		+ "// We scale the rate at which we change the u value of the texture to\n"
		+ "// keep up with the wind.\n"
		+ "float $u = frame * $uscale * $vel;\n"
		+ "// if velocity > than a fixed amount we need to set the density of \n"
		+ "// more columns to avoid banding in the flow.\n"
		+ "int $numCol = 1 + $vel/15.0;\n"
		+ "for($j = 0; $j < $numCol; $j++ ){\n"
		+ "    for($i = 0; $i < $yres; $i++ ){\n"
		+ "        float $v = $vscale * (float)$i/(float)($yres);\n"
		+ "        float $nval = (noise($u,$v)* 0.5 + 0.4) * $density;\n"
		+ "\t$nval += (noise($u * 3.0, $v * 3.0)* 0.5 + 0.4) * $density *.7;\n"
		+ "        if( $nval < 0 ) $nval =0.0;\n"
		+ "        setFluidAttr -at density -xi $j -yi $i -fv $nval windTunnelShape;\n"
		+ "    }\n"
		+ "    $u -= $uscale * 10; // the uvalue for each extra column we set must be offset to avoid banding\n"
		+ "}");
createNode animCurveTA -n "nurbsSphere1_rotateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  0 14.130780616107035 23 13.612415116024437 38 
		5.4094696840578953 55 5.4094696840578953 71 1.6715337353652528 101 -2.3140128817345258;
createNode animCurveTL -n "nurbsSphere1_translateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  0 3.9621668857445727 23 3.9621668857445727 38 
		7.1693069675265182 55 6.8158171247238819 71 7.0472349127083973 101 3.4918140116988248;
createNode animCurveTA -n "nurbsSphere1_rotateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  0 -19.773370381826524 23 -13.51604802299001 38 
		-7.2984482290903028 55 -7.2984482290903028 71 22.619379914602849 101 0.055086695915395265;
createNode animCurveTA -n "nurbsSphere1_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  0 29.70109631395696 23 24.189216954803246 38 11.612552328583869 
		55 11.612552328583869 71 2.0154986675844571 101 -5.5101686333478641;
createNode geoConnector -n "geoConnector1";
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 0.5;
	setAttr ".s" 4;
	setAttr ".nsp" 2;
createNode blinn -n "blinn1";
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode rampShader -n "rampShader1";
	setAttr ".dc" 0.48543998599052429;
	setAttr ".clr[0].clrp" 0;
	setAttr ".clr[0].clrc" -type "float3" 0.243 0.22185899 0.22334592 ;
	setAttr ".clr[0].clri" 1;
	setAttr ".it[0].itp" 0;
	setAttr ".it[0].itc" -type "float3" 0 0 0 ;
	setAttr ".it[0].iti" 1;
	setAttr ".ic[0].icp" 0;
	setAttr ".ic[0].icc" -type "float3" 0 0 0 ;
	setAttr ".ic[0].ici" 1;
	setAttr ".ec" 0.15535999834537506;
	setAttr ".spl" 0.77670001983642578;
	setAttr -s 2 ".sro[0:1]"  0 1 2 0.5 0.5 2;
	setAttr ".sc[0].scp" 0;
	setAttr ".sc[0].scc" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".sc[0].sci" 1;
	setAttr -s 2 ".rfl";
	setAttr ".rfl[0].rflp" 0;
	setAttr ".rfl[0].rflfv" 0.89999997615814209;
	setAttr ".rfl[0].rfli" 2;
	setAttr ".rfl[2].rflp" 0.22857142984867096;
	setAttr ".rfl[2].rflfv" 0.23999999463558197;
	setAttr ".rfl[2].rfli" 1;
	setAttr -s 4 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.21848398 0.30599999 0.2923767 ;
	setAttr ".env[0].envi" 1;
	setAttr ".env[1].envp" 0.25714287161827087;
	setAttr ".env[1].envc" -type "float3" 0.17448199 0.242 0.22000039 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0.11760001 0.14807475 0.49000001 ;
	setAttr ".env[2].envi" 1;
	setAttr ".env[3].envp" 0.60000002384185791;
	setAttr ".env[3].envc" -type "float3" 0.61151993 0.86352909 0.95999998 ;
	setAttr ".env[3].envi" 1;
createNode shadingEngine -n "rampShader1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
select -ne :time1;
	setAttr ".o" 0;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr ".sdf" -type "string" "";
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 102;
	setAttr ".left" 214;
	setAttr ".bot" 37;
	setAttr ".rght" 321;
	setAttr ".an" yes;
	setAttr ".fs" 1;
	setAttr ".ef" 100;
	setAttr ".ofc" 1;
	setAttr ".ofe" -type "string" "";
	setAttr ".efe" -type "string" "";
	setAttr ".lse" -type "string" "";
	setAttr ".rse" -type "string" "";
	setAttr ".oft" -type "string" "";
	setAttr ".ifp" -type "string" "";
	setAttr ".npu" 1;
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".pfrm" -type "string" "";
	setAttr ".pfom" -type "string" "";
select -ne :defaultRenderQuality;
	setAttr ".eaa" 0;
	setAttr ".mss" 4;
select -ne :defaultResolution;
	setAttr ".w" 400;
	setAttr ".h" 120;
	setAttr ".dar" 3.3333332538604736;
connectAttr ":time1.o" "windTunnelShape.cti";
connectAttr "geoConnector1.res" "windTunnelShape.crs" -na;
connectAttr "geoConnector1.fri" "windTunnelShape.cfr" -na;
connectAttr "geoConnector1.swg" "windTunnelShape.cge" -na;
connectAttr "nurbsSphere1_translateY.o" "nurbsSphere1.ty";
connectAttr "nurbsSphere1_rotateX.o" "nurbsSphere1.rx";
connectAttr "nurbsSphere1_rotateY.o" "nurbsSphere1.ry";
connectAttr "nurbsSphere1_rotateZ.o" "nurbsSphere1.rz";
connectAttr "makeNurbSphere1.os" "nurbsSphereShape1.cr";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "rampShader1SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "windTunnelShape.ocl" "fluidShape1SG.vs";
connectAttr "windTunnelShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr ":time1.o" "expression1.tim";
connectAttr "windTunnelShape.windSpeed" "expression1.in[0]";
connectAttr "windTunnelShape.rh" "expression1.in[1]";
connectAttr "windTunnelShape.cloudScaleU" "expression1.in[2]";
connectAttr "windTunnelShape.cloudScaleV" "expression1.in[3]";
connectAttr "nurbsSphereShape1.msg" "geoConnector1.own";
connectAttr "nurbsSphereShape1.wm" "geoConnector1.wm";
connectAttr "nurbsSphereShape1.l" "geoConnector1.lge";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "rampShader1.oc" "rampShader1SG.ss";
connectAttr "nurbsSphereShape1.iog" "rampShader1SG.dsm" -na;
connectAttr "rampShader1SG.msg" "materialInfo3.sg";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "rampShader1SG.pa" ":renderPartition.st" -na;
connectAttr "windTunnelShape.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "rampShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of WindTunnelClouds.ma
