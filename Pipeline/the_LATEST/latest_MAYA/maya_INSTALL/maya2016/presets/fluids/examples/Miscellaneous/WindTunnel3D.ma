//Maya ASCII 4.5 scene
//Name: WindTunnel3D.ma
//Last modified: Tue, Jul 23, 2002 03:16:12 PM
requires maya "4.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207220603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 9.2662288146435134 3.8555931258165921 28.725529206028721 ;
	setAttr ".r" -type "double3" 5.0616472703945643 12.999999999999956 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".coi" 31.96007923941341;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
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
createNode transform -n "fluid1";
	setAttr ".t" -type "double3" 0.58903712839838107 5.2304438834679141 0 ;
	setAttr ".r" -type "double3" 0.0093761700667096947 -0.2392616801904531 0.056942074030959591 ;
	setAttr ".s" -type "double3" 1.0299097217414335 1.0321402496293275 1 ;
createNode fluidShape -n "windTunnelShape" -p "fluid1";
	addAttr -ci true -sn "windSpeed" -ln "windSpeed" -dv 10 -min 0 -max 200 
		-at "double";
	addAttr -ci true -sn "tracers" -ln "tracers" -dv 4 -min 0 -max 30 -at "long";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 60;
	setAttr ".rh" 20;
	setAttr ".rd" 8;
	setAttr ".dw" 30;
	setAttr ".dh" 10;
	setAttr ".dd" 4;
	setAttr ".ssd" 3;
	setAttr ".bod" 4;
	setAttr ".vdl" 0.63104;
	setAttr ".bndx" 0;
	setAttr ".dsc" 1;
	setAttr ".dsb" 0;
	setAttr ".tgr" 6;
	setAttr ".tmsc" 0.87379997968673706;
	setAttr ".tds" 0;
	setAttr ".tdf" 0;
	setAttr ".ttb" 0;
	setAttr ".buo" 1000;
	setAttr ".rin" 3;
	setAttr -s 5 ".cl";
	setAttr ".cl[1].clp" 0.30714285373687744;
	setAttr ".cl[1].clc" -type "float3" 0.082200006 0.25158674 0.685 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 0.48571428656578064;
	setAttr ".cl[2].clc" -type "float3" 1 0 0.0043334961 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0;
	setAttr ".cl[3].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[3].cli" 1;
	setAttr ".cl[4].clp" 0.63571429252624512;
	setAttr ".cl[4].clc" -type "float3" 1 0.97907501 0.069999993 ;
	setAttr ".cl[4].cli" 1;
	setAttr ".cl[5].clp" 0.97142899036407471;
	setAttr ".cl[5].clc" -type "float3" 1 0.93780303 0.91799998 ;
	setAttr ".cl[5].cli" 1;
	setAttr ".coi" 9;
	setAttr ".cib" -0.60868000984191895;
	setAttr -s 2 ".opa[0:1]"  0 0 1 1 1 1;
	setAttr ".t" -type "float3" 0.035294119 0.035294119 0.035294119 ;
	setAttr ".shp" 1;
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
	setAttr ".edr" 0.11649999767541885;
	setAttr -k on ".windSpeed" 50.484;
	setAttr -k on ".tracers" 3;
	setAttr ".nts" -type "string" (
		"You will see 2 errors when this scene is imported from Visor.  They are safe to ignore.  More details are below. \n\n"+
		"This node simulates wind flowing through a 3D tunnel. Smoke tracers allow one to see the flow. The flow is colored based on its speed, with faster speeds being both brighter and warmer colors. \n"
		+ "Open the extra attributes section above to see custom wind tunnel attributes. Wind speed controls the velocity at the minX boundary and tracers is the number of smoke trails. These added attributes are used in an expression that uses setFluidAttr calls to set the boundary velocity(wind speed) and density( tracers ).\n"
		+ "One can move the object to see how it interacts with the flow while playing back. Any geometry can collide with the flow. Select the object and the fluid then make collide under the fluids menu. Note that the collision is on a per voxel basis, so that unless the fluid is at fairly high resolution the slope of boundaries will not be well represented."

	+ "\n\nYou will see 2 errors when this scene is imported from Visor.  They are safe to ignore. Press Play to start the fluid simulation.  The errors are:\n\n"
	+" // Error: line: No object matches: windTunnelShape\n"
	+" // Error: line: An execution error occured in the expression WindTunnelParticles:expression1.");

createNode transform -n "nurbsSphere1";
	setAttr ".t" -type "double3" -7.5094132213510623 5.0511754990098243 -0.36986874252857094 ;
	setAttr ".r" -type "double3" 57.771327317678868 21.017773268639846 -6.7790399523549079 ;
	setAttr ".s" -type "double3" 7.4068585427955371 1.2705243374433466 -5.178979882381249 ;
createNode nurbsSurface -n "nurbsSphereShape1" -p "nurbsSphere1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 35 ".cp[0:34]" -type "double3" -1.7897152354996198e-17 0.32171257761534611 
		0 -1.7897152354996198e-17 0.32171257761534611 0 -1.7897152354996198e-17 0.32171257761534611 
		0 -1.7897152354996198e-17 0.32171257761534611 0 0 0 0 0 0 0 0 0 0 -1.7897152354996198e-17 
		0.32171257761534611 0 -0.00068969200685364829 0.10533405530923168 -0.010182961341068697 
		-1.7897152354996198e-17 0.32171257761534611 0 0 0.32171257761534611 0 0 0 
		0 0 0 0 0 0 0 0 0 0 -0.0014740330252349665 -0.46245147784984653 -0.02176336852140523 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0074032145167114939 0.94369258297542158 0.016706511175925531 
		-0.00051809506682798379 -0.16254305379838252 -0.0076494173980289123 0.0074032145167114947 
		0.94369258297542136 0.016706511175925531 0.0092373898783492114 1.4202116274491678 
		0.020178193975839139 0 0 0 0 0 0 0 0 0 0.0074032145167114947 0.94369258297542125 
		0.01670651117592541 0.0074032145167114947 0.94369258297542125 0.01670651117592541 
		0.0074032145167114947 0.94369258297542125 0.01670651117592541 0.0074032145167114947 
		0.94369258297542125 0.01670651117592541 0 0 0 0 0 0 0 0 0;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "WindTunnelCam";
	setAttr ".t" -type "double3" 4.0862496709420073 2.7659706054800561 30.462359813381763 ;
	setAttr ".r" -type "double3" 2.0616472703975894 6.2000000000000481 0 ;
createNode camera -n "WindTunnelCamShape" -p "WindTunnelCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".coi" 31.370302026505833;
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
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 5000 -ast 0 -aet 5000 ";
	setAttr ".st" 6;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr -s 4 ".in";
	setAttr -s 4 ".in";
	setAttr ".ixp" -type "string" (
		"float $vel = .I[0];\n"
		+ "int $tracers = .I[1];\n"
		+ "int $yres = .I[2];\n"
		+ "int $zres = .I[3];\n"
		+ "int $zIndex = (float)$zres/2.0;\n"
		+ "float $density = 3.0;\n"
		+ "// set velocity at the min X boundary\n"
		+ "setFluidAttr -at velocity -xi 0 -vv $vel 0 0 windTunnelShape;\n"
		+ "int $i;\n"
		+ "for($i = 0; $i < $tracers; $i++ ){\n"
		+ "    // emit the tracer densities\n"
		+ "    int $yIndex = (float)$yres *(((float)$i + 0.5)/(float)$tracers);\n"
		+ "    setFluidAttr -at density -xi 0 -yi $yIndex -zi $zIndex -fv $density windTunnelShape;\n"
		+ "}");
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 0.5;
	setAttr ".s" 4;
	setAttr ".nsp" 2;
createNode geoConnector -n "geoConnector1";
select -ne :time1;
	setAttr ".o" 0;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 3 ".s";
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
	setAttr ".top" 239;
	setAttr ".rght" 319;
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
connectAttr ":time1.o" "windTunnelShape.cti";
connectAttr "geoConnector1.res" "windTunnelShape.crs" -na;
connectAttr "geoConnector1.fri" "windTunnelShape.cfr" -na;
connectAttr "geoConnector1.swg" "windTunnelShape.cge" -na;
connectAttr "makeNurbSphere1.os" "nurbsSphereShape1.cr";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "windTunnelShape.ocl" "fluidShape1SG.vs";
connectAttr "windTunnelShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr ":time1.o" "expression1.tim";
connectAttr "windTunnelShape.windSpeed" "expression1.in[0]";
connectAttr "windTunnelShape.tracers" "expression1.in[1]";
connectAttr "windTunnelShape.rh" "expression1.in[2]";
connectAttr "windTunnelShape.rd" "expression1.in[3]";
connectAttr "nurbsSphereShape1.msg" "geoConnector1.own";
connectAttr "nurbsSphereShape1.wm" "geoConnector1.wm";
connectAttr "nurbsSphereShape1.l" "geoConnector1.lge";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "windTunnelShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "nurbsSphereShape1.iog" ":initialShadingGroup.dsm" -na;
// End of WindTunnel3D.ma
