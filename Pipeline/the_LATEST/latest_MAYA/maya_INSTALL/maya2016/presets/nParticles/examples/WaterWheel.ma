//Maya ASCII 2009 scene
//Name: WaterWheel.ma
//Last modified: Mon, Feb 02, 2009 11:59:33 AM
//Codeset: 1252
requires maya "2009";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 2009";
fileInfo "version" "2009P03";
fileInfo "cutIdentifier" "200902020025-744193";
fileInfo "osv" "Microsoft Windows XP Service Pack 2 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 15.254283572961871 8.4531658625059389 14.520536468572502 ;
	setAttr ".r" -type "double3" -18.338352729612939 38.200000000004977 -2.0236220545270711e-015 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 28.091040519426453;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "pCylinder1";
	setAttr ".r" -type "double3" 90 0 0 ;
	setAttr ".s" -type "double3" 1 2.127468479993825 1 ;
createNode mesh -n "pCylinderShape1" -p "pCylinder1";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode mesh -n "outputCloth1" -p "pCylinder1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".qsp" 0;
createNode transform -n "nCloth1";
	setAttr -l on ".t";
	setAttr -l on ".r";
	setAttr -l on ".s";
createNode nCloth -n "nClothShape1" -p "nCloth1";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 142;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -k off ".dve";
	setAttr -k off ".lfm";
	setAttr -k off ".lfr";
	setAttr -k off ".ead";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr -k off ".dw";
	setAttr -k off ".fiw";
	setAttr -k off ".con";
	setAttr -k off ".eiw";
	setAttr -k off ".mxc";
	setAttr -k off ".lod";
	setAttr -k off ".inh";
	setAttr -k off ".stf";
	setAttr -k off ".igs";
	setAttr -k off ".ecfh";
	setAttr -k off ".tgs";
	setAttr -k off ".gsm";
	setAttr -k off ".chd";
	setAttr ".chw" 10000;
	setAttr -k off ".trd";
	setAttr -k off ".prt";
	setAttr ".thss" 0.076564371585845947;
	setAttr ".fron" 0.082639999687671661;
	setAttr ".scfl" 3;
	setAttr ".pmss" 10;
	setAttr ".scld" no;
	setAttr ".por" 0.30625748634338379;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".lsou" yes;
	setAttr ".rity" 3;
	setAttr ".lft" 0;
	setAttr ".drg" 0.29752001166343689;
	setAttr ".tdrg" 0.024800000712275505;
	setAttr -k on ".lifespan" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
createNode transform -n "dynamicConstraint1";
createNode dynamicConstraint -n "dynamicConstraintShape1" -p "dynamicConstraint1";
	setAttr -k off ".v";
	setAttr ".crr" 0;
	setAttr ".cdnr[0]"  0 1 1;
	setAttr ".sdp[0]"  0 1 1;
createNode transform -n "pPipe1";
	setAttr ".t" -type "double3" 7.6810108963904256 -4.174117428620308 -0.47049430265820258 ;
	setAttr ".r" -type "double3" 9.8625996158924902 49.138133962541893 66.299260592215433 ;
createNode mesh -n "pPipeShape1" -p "pPipe1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 6 ".pt";
	setAttr ".pt[4:8]" -type "float3" -0.46123779 -3.7007511 0.1022135  -0.063499868 
		-0.28464574 -0.20873152  -0.063499868 -0.28464574 -0.20873152  -0.46123779 -3.7007511 
		0.1022135  -0.46123779 -3.7007511 0.1022135 ;
	setAttr ".pt[11]" -type "float3" -0.46123779 -3.7007511 0.1022135 ;
	setAttr ".qsp" 0;
createNode transform -n "nRigid1";
	setAttr -l on ".t";
	setAttr -l on ".r";
	setAttr -l on ".s";
createNode nRigid -n "nRigidShape1" -p "nRigid1";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 32;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -k off ".dve";
	setAttr -k off ".lfm";
	setAttr -k off ".lfr";
	setAttr -k off ".ead";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr -k off ".dw";
	setAttr -k off ".fiw";
	setAttr -k off ".con";
	setAttr -k off ".eiw";
	setAttr -k off ".mxc";
	setAttr -k off ".lod";
	setAttr -k off ".inh";
	setAttr -k off ".stf";
	setAttr -k off ".igs";
	setAttr -k off ".ecfh";
	setAttr -k off ".tgs";
	setAttr -k off ".gsm";
	setAttr -k off ".chd";
	setAttr ".chw" 10000;
	setAttr -k off ".trd";
	setAttr -k off ".prt";
	setAttr ".thss" 0.049733523279428482;
	setAttr ".actv" no;
	setAttr ".scld" no;
	setAttr ".por" 0.19893409311771393;
	setAttr ".tpc" yes;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr -k on ".lifespan" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
createNode pointEmitter -n "emitter1";
	setAttr ".t" -type "double3" -1.7893312348750348 8.9348086137292562 0.22503488523056758 ;
	setAttr ".r" -type "double3" 0 0 38.405018288216702 ;
	setAttr ".s" -type "double3" 0.26073017646392893 0.41924985184173713 0.26073017646392893 ;
	setAttr ".emt" 4;
	setAttr ".rat" 300;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".vol" 2;
	setAttr ".afa" 0;
	setAttr ".alx" -3.8843999999999994;
createNode transform -n "nParticle1";
createNode nParticle -n "nParticleShape1" -p "nParticle1";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr ".lfm" 1;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".chw" 10000;
	setAttr ".prt" 7;
	setAttr ".fron" 0;
	setAttr ".cofl" 1;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr ".cwds" 0.80000001192092896;
	setAttr ".thr" 0;
	setAttr ".ra" 0.10000000149011612;
	setAttr ".rdc[0]"  0 1 1;
	setAttr ".rci" 1;
	setAttr ".mssc[0]"  0 1 1;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".opc[0]"  0 1 1;
	setAttr ".oci" 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 0 0.5 1 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".coi" 6;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 4;
	setAttr ".rgbPP0" -type "vectorArray" 0 ;
	setAttr ".opacityPP0" -type "doubleArray" 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 0 ;
createNode transform -n "WaterWheelCam";
	setAttr ".t" -type "double3" 15.004551504030719 6.0960245995882341 14.010088296200413 ;
	setAttr ".r" -type "double3" -13.53835272960252 37.400000000000276 -1.0009114256104396e-015 ;
createNode camera -n "WaterWheelCamShape" -p "WaterWheelCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 21.539140209250721;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode lightLinker -n "lightLinker1";
	setAttr -s 3 ".lnk";
	setAttr -s 3 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode polyCylinder -n "polyCylinder1";
	setAttr ".r" 5;
	setAttr ".h" 1;
	setAttr ".sa" 14;
	setAttr ".sc" 1;
	setAttr ".cuv" 3;
createNode polyExtrudeFace -n "polyExtrudeFace1";
	setAttr ".ics" -type "componentList" 1 "f[0:13]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 2.2204460492503131e-016 1 0 0 -1 2.2204460492503131e-016 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" 2.3841858e-007 -2.3841858e-007 0 ;
	setAttr ".rs" 37223;
	setAttr ".ls" -type "double3" 0.9007934948632208 0.63254318234470863 1 ;
	setAttr ".kft" no;
	setAttr ".c[0]"  0 1 1;
createNode polyExtrudeFace -n "polyExtrudeFace2";
	setAttr ".ics" -type "componentList" 1 "f[0:13]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 2.2204460492503131e-016 1 0 0 -1 2.2204460492503131e-016 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -2.3841858e-007 -2.3841858e-007 0 ;
	setAttr ".rs" 54201;
	setAttr ".lt" -type "double3" 1.1102230246251565e-015 4.7488739263653879e-016 -1.4441976792990958 ;
	setAttr ".ls" -type "double3" 0.63503426845816735 1 1 ;
	setAttr ".c[0]"  0 1 1;
createNode nucleus -n "nucleus1";
	setAttr -s 2 ".niao";
	setAttr -s 2 ".nias";
	setAttr -s 2 ".noao";
	setAttr ".grty" 5.7859997749328613;
createNode nComponent -n "nComponent1";
	setAttr ".ct" 2;
	setAttr -s 2 ".ci[0:1]"  28 29;
createNode polyPipe -n "polyPipe1";
	setAttr ".r" 1.6620000000000001;
	setAttr ".h" 12.406;
	setAttr ".sa" 4;
	setAttr ".sc" 0;
createNode shadingEngine -n "nParticleBallsSE";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode particleSamplerInfo -n "particleSamplerInfo1";
createNode blinn -n "npBallsBlinn";
createNode particleCloud -n "npBallsVolume";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 10000 -ast 1 -aet 10000 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 1;
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
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "polyExtrudeFace2.out" "pCylinderShape1.i";
connectAttr "nClothShape1.omsh" "outputCloth1.i";
connectAttr "nucleus1.stf" "nClothShape1.stf";
connectAttr ":time1.o" "nClothShape1.cti";
connectAttr "pCylinderShape1.w" "nClothShape1.imsh";
connectAttr "nucleus1.noao[0]" "nClothShape1.nxst";
connectAttr "nComponent1.ocp" "dynamicConstraintShape1.cid[0]";
connectAttr ":time1.o" "dynamicConstraintShape1.cti";
connectAttr "polyPipe1.out" "pPipeShape1.i";
connectAttr "nucleus1.stf" "nRigidShape1.stf";
connectAttr ":time1.o" "nRigidShape1.cti";
connectAttr "pPipeShape1.w" "nRigidShape1.imsh";
connectAttr ":time1.o" "emitter1.ct";
connectAttr "nParticleShape1.ifl" "emitter1.full[0]";
connectAttr "nParticleShape1.tss" "emitter1.dt[0]";
connectAttr "nParticleShape1.inh" "emitter1.inh[0]";
connectAttr "nParticleShape1.stt" "emitter1.stt[0]";
connectAttr "nParticleShape1.sd[0]" "emitter1.sd[0]";
connectAttr ":time1.o" "nParticleShape1.cti";
connectAttr "nucleus1.noao[1]" "nParticleShape1.nxst";
connectAttr "nucleus1.stf" "nParticleShape1.stf";
connectAttr "emitter1.ot[0]" "nParticleShape1.npt[0]";
connectAttr "nParticleShape1.incr" "nParticleShape1.rgbPP";
connectAttr "nParticleShape1.inor" "nParticleShape1.opacityPP";
connectAttr "nParticleShape1.inrr" "nParticleShape1.radiusPP";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "nParticleBallsSE.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[0].sllk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.slnk[0].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[1].sllk";
connectAttr ":initialParticleSE.msg" "lightLinker1.slnk[1].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[2].sllk";
connectAttr "nParticleBallsSE.msg" "lightLinker1.slnk[2].solk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "polyCylinder1.out" "polyExtrudeFace1.ip";
connectAttr "pCylinderShape1.wm" "polyExtrudeFace1.mp";
connectAttr "polyExtrudeFace1.out" "polyExtrudeFace2.ip";
connectAttr "pCylinderShape1.wm" "polyExtrudeFace2.mp";
connectAttr ":time1.o" "nucleus1.cti";
connectAttr "nClothShape1.cust" "nucleus1.niao[0]";
connectAttr "nParticleShape1.cust" "nucleus1.niao[1]";
connectAttr "nClothShape1.stst" "nucleus1.nias[0]";
connectAttr "nParticleShape1.stst" "nucleus1.nias[1]";
connectAttr "dynamicConstraintShape1.evs" "nucleus1.is[0]";
connectAttr "dynamicConstraintShape1.evc" "nucleus1.ic[0]";
connectAttr "nRigidShape1.cust" "nucleus1.nipo[0]";
connectAttr "nRigidShape1.stst" "nucleus1.nips[0]";
connectAttr "nClothShape1.nuid" "nComponent1.obid";
connectAttr "npBallsBlinn.oc" "nParticleBallsSE.ss";
connectAttr "npBallsVolume.oi" "nParticleBallsSE.vs";
connectAttr "nParticleShape1.iog" "nParticleBallsSE.dsm" -na;
connectAttr "nParticleBallsSE.msg" "materialInfo1.sg";
connectAttr "npBallsBlinn.msg" "materialInfo1.m";
connectAttr "particleSamplerInfo1.msg" "materialInfo1.t" -na;
connectAttr "particleSamplerInfo1.oc" "npBallsBlinn.c";
connectAttr "particleSamplerInfo1.ot" "npBallsBlinn.it";
connectAttr "particleSamplerInfo1.oi" "npBallsBlinn.ic";
connectAttr "particleSamplerInfo1.ot" "npBallsVolume.t";
connectAttr "particleSamplerInfo1.oc" "npBallsVolume.c";
connectAttr "particleSamplerInfo1.oi" "npBallsVolume.i";
connectAttr "nParticleBallsSE.pa" ":renderPartition.st" -na;
connectAttr "npBallsBlinn.msg" ":defaultShaderList1.s" -na;
connectAttr "npBallsVolume.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "pCylinderShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "outputCloth1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pPipeShape1.iog" ":initialShadingGroup.dsm" -na;
// End of WaterWheel.ma