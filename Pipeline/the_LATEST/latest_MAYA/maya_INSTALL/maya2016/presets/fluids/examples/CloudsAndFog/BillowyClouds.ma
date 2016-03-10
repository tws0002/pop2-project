//Maya ASCII 4.5 scene
//Name: BillowyClouds.ma
//Last modified: Tue, Jul 23, 2002 12:34:34 PM
requires maya "4.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207220603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode transform -s -n "BillowyCloudsCam";
	setAttr ".t" -type "double3" 21.649233874650122 7.8447639776631766 30.360146480621427 ;
	setAttr ".r" -type "double3" -25.800000000000022 26 -1.9462802207110654e-14 ;
	setAttr ".rp" -type "double3" 3.5527136788005009e-15 -2.2204460492503131e-16 
		-4.4408920985006262e-15 ;
	setAttr ".rpt" -type "double3" -1.9332153059695767e-15 -1.7548449780274878e-15 
		-5.4943763039114331e-16 ;
createNode camera -s -n "BillowyCloudsCamShape" -p "BillowyCloudsCam";
	setAttr -k off ".v";
	setAttr ".ovr" 1.3;
	setAttr ".coi" 45.750401833333292;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
createNode transform -n "BillowyClouds";
	setAttr ".t" -type "double3" 0 0.76692186306582211 0 ;
	setAttr ".r" -type "double3" -170.40022407469863 0 0 ;
createNode fluidShape -n "BillowyCloudsShape" -p "BillowyClouds";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 50;
	setAttr ".rh" 5;
	setAttr ".rd" 60;
	setAttr ".dw" 50;
	setAttr ".dh" 5;
	setAttr ".dd" 60;
	setAttr ".bod" 4;
	setAttr ".dmt" 3;
	setAttr ".dsc" 0.29752001166343689;
	setAttr ".ss" yes;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".coi" 5;
	setAttr -s 3 ".opa[1:3]"  1 1 1 0.19285715 0 1 0.26428571 0.47999999 1;
	setAttr ".t" -type "float3" 0.52065998 0.52065998 0.52065998 ;
	setAttr ".shp" 0.32232001423835754;
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0.2 0.2 0.2 ;
	setAttr ".i[0].ii" 1;
	setAttr ".ili" 5;
	setAttr ".iib" -0.53152000904083252;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 7;
	setAttr ".edr" 0.30577999353408813;
	setAttr ".tty" 1;
	setAttr ".otx" yes;
	setAttr ".otxg" 1.0578399896621704;
	setAttr ".a" 0.76033997535705566;
	setAttr ".th" 0.206619992852211;
	setAttr ".txsc" -type "float3" 2 1 1 ;
	setAttr ".dm" 4;
	setAttr ".fq" 0.74383997917175293;
	setAttr ".in" yes;
	setAttr ".tti" 4.5;
	setAttr ".sp" 0.54545998573303223;
	setAttr ".sr" 0.40496000647544861;
	setAttr ".nts" -type "string" (
		"Goal: \r\n"
		+ "Bank of clouds.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "The container is extended by 20 in x and z, and reduced in y by 5. \r\n"
		+ "Density is set to a constant gradient. \r\n"
		+ "The Shading> opacity graph is pulled away from zero at the low end.  The colour input is density.\r\n"
		+ "Inflection is turend on in Texturing for more puffiness.\r\n"
		+ "Texturing depth max is increased for more levels of detail. Frequency is increased for detail too. \r\n"
		+ "Texture scale is stretched in X.\r\n"
		+ "Threshold up to thicken up the layer. \r\n"
		+ "Lighting> Shadow is on and opacity set below the default.\r\n"
		+ "Try BillowyCloudsCam, Panels> Perspective> BillowyCloudsCamera. \r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Adjust or animate texture time to get a diffent placement of the clouds. The billow texture can be mimiced by using perlin with inflection which renders faster. \r\n"
		+ "Increasing the Lighting> Shadow Opacity will give more the look of storm clouds. Depth max costs more render time, but does give better detail.\r\n"
		+ "Render Time: $$");
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" 0 -77.068507193124731 -57.068469653616482 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
createNode imagePlane -n "imagePlane1";
	setAttr ".t" 1;
	setAttr ".s" -type "double2" 1.4173200000000001 1.06 ;
	setAttr ".c" -type "double3" 0 0 -11.39922536338478 ;
	setAttr ".w" 10;
	setAttr ".h" 10;
createNode ramp -n "ramp1";
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.24699998 0.89257205 1 ;
	setAttr ".cel[1].ep" 0.085000000894069672;
	setAttr ".cel[1].ec" -type "float3" 0.22724 0.82116598 1 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0 0 1 ;
createNode place2dTexture -n "place2dTexture1";
createNode cameraView -n "billowyClouds";
	setAttr ".e" -type "double3" 21.649233874650118 7.8447639776631766 30.360146480621427 ;
	setAttr ".coi" -type "double3" 3.5927501990620812 -12.067233708984233 -6.6611313648505863 ;
	setAttr ".u" -type "double3" -0.19079275615011823 0.9003187714021933 -0.39118312088008944 ;
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "fluidShape3SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 1.25;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 3 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
select -ne :lightList1;
select -ne :defaultTextureList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr ".fs" 1;
	setAttr ".ef" 10;
select -ne :defaultLightSet;
connectAttr "imagePlane1.msg" ":perspShape.ip" -na;
connectAttr "imagePlane1.msg" ":BillowyCloudsCamShape.ip" -na;
connectAttr "billowyClouds.msg" ":BillowyCloudsCamShape.b" -na;
connectAttr ":time1.o" "BillowyCloudsShape.cti";
connectAttr "ramp1.oc" "imagePlane1.stx";
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "fluidShape3SG.msg" "materialInfo3.sg";
connectAttr "BillowyCloudsShape.ocl" "fluidShape3SG.vs";
connectAttr "BillowyCloudsShape.iog" "fluidShape3SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape3SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "fluidShape3SG.pa" ":renderPartition.st" -na;
connectAttr "BillowyCloudsShape.msg" ":defaultShaderList1.s" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of BillowyClouds.ma
