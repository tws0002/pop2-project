//Maya ASCII 4.5 scene
//Name: RedGooCollision.ma
//Last modified: Wed, Jul 24, 2002 12:07:13 PM
requires maya "4.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207220603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602382 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".coi" 44.82186966202994;
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
	setAttr ".t" -type "double3" 0.031544468888705879 -0.019657731682621638 
		0.0072933330210749325 ;
	setAttr ".s" -type "double3" 1.0025193257591714 1.0025193257591714 1.0025193257591714 ;
createNode fluidShape -n "fluidShape1" -p "fluid1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 20;
	setAttr ".rd" 20;
	setAttr ".dw" 20;
	setAttr ".dh" 10;
	setAttr ".dd" 20;
	setAttr ".bod" 5;
	setAttr ".dsb" -5;
	setAttr ".qua" 2;
	setAttr ".rin" 3;
	setAttr -s 4 ".cl";
	setAttr ".cl[0].clp" 0.0071428571827709675;
	setAttr ".cl[0].clc" -type "float3" 0.34400001 0.047816001 0.053986497 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.98571425676345825;
	setAttr ".cl[1].clc" -type "float3" 1 0.94211 0.17299998 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 0.71428573131561279;
	setAttr ".cl[2].clc" -type "float3" 0.79400003 0.11988208 0.11512999 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0.79285717010498047;
	setAttr ".cl[3].clc" -type "float3" 1 0.94211 0.17299999 ;
	setAttr ".cl[3].cli" 1;
	setAttr -s 2 ".opa[0:1]"  0.0099999998 0 1 1 1 1;
	setAttr ".t" -type "float3" 0 0 0 ;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.80000001192092896;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 1.5 1 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".ili" 5;
	setAttr ".spc" -type "float3" 0.95867997 0.95867997 0.95867997 ;
	setAttr -s 4 ".env";
	setAttr ".env[1].envp" 0.04285714402794838;
	setAttr ".env[1].envc" -type "float3" 0.53500003 0.26194993 0.071155012 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0.32499999 0.74349993 1 ;
	setAttr ".env[2].envi" 2;
	setAttr ".env[3].envp" 0.56428569555282593;
	setAttr ".env[3].envc" -type "float3" 0.332836 0.725532 0.96534199 ;
	setAttr ".env[3].envi" 2;
	setAttr ".env[4].envp" 0.46428570151329041;
	setAttr ".env[4].envc" -type "float3" 0.53500003 0.26194999 0.071154997 ;
	setAttr ".env[4].envi" 2;
	setAttr ".edr" 0.63635998964309692;
	setAttr ".srr" yes;
	setAttr ".srt" 0.0010000000474974513;
	setAttr ".stl" 0.016000000759959221;
	setAttr ".ctx" yes;
	setAttr ".cvel" no;
	setAttr ".ctmp" no;
	setAttr ".ccol" no;
	setAttr ".crea" no;
	setAttr ".nts" -type "string" (
		"The surface is set to collide with the fluid by selecting the fluid container and the surface and using Fluid Effects> Make Collide. \r\n"
		+ "Buoyancy is set to -5, to make the fluid fall. \r\n"
		+ "See where the collision occurs in the container by switching Display> Shaded Display to Collision. The density emitted is set to Surface> hard surface to appear as a surface rather than a volume. Try creating a cache for density by using Fluid Effects> Create Cache. This will allow you to see playback, without paying for the simulation time. The container is turned off in the Display. A higher container resolution will give more accurate collisions.\r\n");
createNode transform -n "nurbsPlane1";
	setAttr ".t" -type "double3" 0 -1.3108584439755098 -0.43852332123081689 ;
	setAttr ".r" -type "double3" 20.217423415609691 0 0 ;
	setAttr ".s" -type "double3" 5.2121051698961569 5.2121051698961569 5.2121051698961569 ;
createNode nurbsSurface -n "nurbsPlaneShape1" -p "nurbsPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 64 ".cp[0:63]" -type "double3" 0.16983772741276137 0.65435102745757423 
		0.15659605025281476 0.14288125722805955 0.79036349830241059 0.072838569482772009 
		0.11098279864271965 0.69555493944654023 0.014347418724427907 0.16902885361727593 
		0.77350323389149089 -0.065943167269156056 0.013902321233290049 0.52150984929407085 
		-0.012224606036107144 -0.012228003170930535 0.47566078173297699 0.024284443992748761 
		-0.0079364149680767326 0.43215519531872937 -0.0054223903254320138 -0.0098082254757874132 
		0.3521918757970251 -0.01662525866013409 0.12950408969000637 0.48352040240374317 
		0.13540862433235334 0.17064632229348686 0.6710297346024755 0.07165226233179034 
		0.12070481910647901 0.58040347738244658 -0.0030378592458388809 0.16536301073926607 
		0.63937293245547244 -0.04244981006110049 0.064205258816573796 0.53314432955537439 
		0.0027199477137498929 0.0067998590974407414 0.48711226217741788 0.022351058140955393 
		-0.0068456263333680489 0.40641403118902086 -0.0075301583637612524 0.00085849722967257236 
		0.31795080230649475 -0.017454062658900149 0.011687315578339463 0.087221144481659268 
		0.00048294692472472533 0.018928515089461806 0.13749813934134925 0.00024390841749455383 
		0.018892103946305694 0.14167267880823003 -0.00087596606533035803 -0.012224220743211944 
		0.10355211345172143 -0.0020876101780993861 -0.023034218881768265 0.064107569055440142 
		0.009133769898346189 0.012089342229192335 0.20031366406569143 0.0091874793157280532 
		0.015045253947355341 0.31100306359681618 -0.0017906377842216159 0.0067167827742213859 
		0.18900817119852265 -0.012892802152133953 -0.00061510719582580364 -0.011199248667583157 
		-0.00035464619220104687 -0.0074693284627376788 -0.10303271247972649 -0.0033704856748713041 
		-0.0033193388994807171 -0.14260869299003157 -0.015803531579285268 0.028095531331616186 
		-0.021005076993817234 -0.0065968711522658152 0.023304546920592417 -0.12553997363001146 
		0.013281481985159604 -0.0033536854444530806 -0.037617203227813492 0.0015820139181785819 
		0 0 0 0 0 0 0 -0.040752610930504085 0 0.00075215953564555793 -0.084265892669609543 
		-0.0056479775793700782 0.0041995756905798265 -0.03887478569768707 -0.012014283932806569 
		-0.024783090540158814 0.50815987520293948 0.069802994028479004 -0.078443481299943607 
		0.5328475453845456 -0.029505162846966693 -0.00045687877412614597 0.0035127617476682755 
		9.8050655807702114e-05 0 0 0 0 0 0 0 0 0 0 0 0 0.0014191477776812622 0.10082377628520393 
		0.012341472957040578 0.018668371277920315 0.24547316106326253 0.042504654083456161 
		-0.04689674868559246 0.48518425073927329 0.033435825574417988 -0.028111495279556253 
		0.27199312500799355 0.04016759832450667 -0.019540321921027948 0.30640456060765925 
		0.001090471860186959 -0.0019841985449626787 0.13542313286644772 -0.0092800522815883468 
		0 0 0 0 0 0 0 0.038980758281351724 0 0.005373422083005952 0.26130441697801532 
		0.032916310379233371 0.0017849246629719762 0.46933270249773062 0.036048888082664376 
		0.0013119803014345344 0.37054585052375849 0.090915675568596033 -0.0042324741931314414 
		0.43213088244843334 -0.0065324102256627548 0.0050137926897524387 0.18570772074904668 
		-0.065294616848389886 0 0 0 0 0 0 0 0.0011812350994349009 0 0.0071371769589476663 
		0.18132277127220831 0.010701339122220765 0.032893632201270506 0.33188208904029548 
		0.01668693768106505 0.034906132221390163 0.28387183801325722 0.06954746605860529 
		0.0066118165432875742 0.38960928202362616 -0.0086205716352678596 0.010057238336375285 
		0.13171984616844046 -0.043713714521648406;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode fluidEmitter -n "fluidEmitter1";
	setAttr ".t" -type "double3" 2.2156909683322832 3.5419765828314183 -7.8474714912629064 ;
	setAttr ".s" -type "double3" 0.87803743113230892 0.87803743113230892 0.87803743113230892 ;
	setAttr ".emt" 4;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".vol" 1;
	setAttr ".fdo" 0;
	setAttr ".fde" 2;
createNode transform -n "directionalLight1";
	setAttr ".t" -type "double3" -0.20026777322245515 8.7332361429740839 0.89492847634357542 ;
	setAttr ".r" -type "double3" -71.477460517462205 -12.410435396439114 32.678919200180808 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
	setAttr ".urs" yes;
	setAttr ".sc" -type "float3" 0.47621399 0.71414167 0.83399999 ;
	setAttr ".shr" 2;
createNode transform -n "pCylinder1";
	setAttr ".t" -type "double3" -1.3722412014166228 0.16202408921549794 -1.4672782119966166 ;
	setAttr ".s" -type "double3" 1.6253910549060644 4.1053791359618872 1.6253910549060644 ;
createNode mesh -n "pCylinderShape1" -p "pCylinder1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".ns" 1;
createNode transform -n "RedGooCam";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 6.762327827 12.905413060000001 12.835177699999999 ;
	setAttr ".r" -type "double3" -39.938352729999998 22.2 2.57640328e-15 ;
	setAttr ".rp" -type "double3" -5.5511151229999998e-16 -4.4408920990000004e-15 
		1.776356839e-15 ;
	setAttr ".rpt" -type "double3" 3.7894463530000001e-15 1.70395981e-15 -3.638664338e-15 ;
createNode camera -n "RedGooCamShape" -p "RedGooCam";
	setAttr -k off ".v" no;
	setAttr ".cap" -type "double2" 1.41732 0.94488 ;
	setAttr ".ovr" 1.3;
	setAttr ".coi" 22.16400415;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".tp" -type "double3" 22.803787069999998 0.49995017050000001 -0.2499747276 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
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
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".w" 4;
	setAttr ".u" 5;
	setAttr ".v" 5;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 350 -ast 1 -aet 800 ";
	setAttr ".st" 6;
createNode phong -n "phong1";
	setAttr ".c" -type "float3" 0.074999988 0.5 0.075424969 ;
createNode shadingEngine -n "phong1SG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode polyCylinder -n "polyCylinder1";
	setAttr ".sc" 1;
	setAttr ".tx" 1;
createNode geoConnector -n "geoConnector1";
	setAttr ".tf" 300;
createNode geoConnector -n "geoConnector2";
	setAttr ".tf" 300;
createNode cameraView -n "cameraView3";
	setAttr ".e" -type "double3" 12.05594196234385 14.093257951516291 17.646191632988568 ;
	setAttr ".coi" -type "double3" -0.3385416015049536 -3.0267945363782633 -0.8684668673892304 ;
	setAttr ".u" -type "double3" -0.3389466620623976 0.79294566899907548 -0.50631247890247322 ;
	setAttr ".tp" -type "double3" 22.803787073846227 0.49995017051696777 -0.24997472763061523 ;
	setAttr ".fl" 34.999999999999979;
select -ne :time1;
	setAttr ".o" 0;
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
	setAttr ".fs" 1;
	setAttr ".ef" 10;
	setAttr -k on ".mbf";
select -ne :defaultLightSet;
connectAttr "cameraView3.msg" ":perspShape.b" -na;
connectAttr ":time1.o" "fluidShape1.cti";
connectAttr "fluidEmitter1.ef" "fluidShape1.eml[0].emfr";
connectAttr "fluidEmitter1.efc" "fluidShape1.fce[1]";
connectAttr "geoConnector1.res" "fluidShape1.crs" -na;
connectAttr "geoConnector2.res" "fluidShape1.crs" -na;
connectAttr "geoConnector1.fri" "fluidShape1.cfr" -na;
connectAttr "geoConnector2.fri" "fluidShape1.cfr" -na;
connectAttr "geoConnector1.swg" "fluidShape1.cge" -na;
connectAttr "geoConnector2.swg" "fluidShape1.cge" -na;
connectAttr "makeNurbPlane1.os" "nurbsPlaneShape1.cr";
connectAttr ":time1.o" "fluidEmitter1.ct";
connectAttr "fluidShape1.ifl" "fluidEmitter1.full[0]";
connectAttr "fluidShape1.ots" "fluidEmitter1.dt[0]";
connectAttr "fluidShape1.inh" "fluidEmitter1.inh[0]";
connectAttr "fluidShape1.sti" "fluidEmitter1.stt[0]";
connectAttr "fluidShape1.sd[1]" "fluidEmitter1.sd[0]";
connectAttr "polyCylinder1.out" "pCylinderShape1.i";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "phong1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "fluidShape1.ocl" "fluidShape1SG.vs";
connectAttr "fluidShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "phong1.oc" "phong1SG.ss";
connectAttr "nurbsPlaneShape1.iog" "phong1SG.dsm" -na;
connectAttr "pCylinderShape1.iog" "phong1SG.dsm" -na;
connectAttr "phong1SG.msg" "materialInfo2.sg";
connectAttr "nurbsPlaneShape1.msg" "geoConnector1.own";
connectAttr "nurbsPlaneShape1.wm" "geoConnector1.wm";
connectAttr "nurbsPlaneShape1.l" "geoConnector1.lge";
connectAttr "pCylinderShape1.msg" "geoConnector2.own";
connectAttr "pCylinderShape1.wm" "geoConnector2.wm";
connectAttr "pCylinderShape1.o" "geoConnector2.lge";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "phong1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "phong1.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of RedGooCollision.ma
