//Maya ASCII 8.0 scene
//Name: BurnPaper.ma
//Last modified: Tue, Jul 04, 2006 04:45:43 PM
requires maya "8.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 8.0";
fileInfo "version" "8.0";
fileInfo "cutIdentifier" "200607060022-678979";
fileInfo "osv" "Linux 2.6.12-1.1398_FC4smp #1 SMP Fri Jul 15 01:05:24 EDT 2005 x86_64";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602361 45 -1.3722363927165826e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".coi" 44.82186966202994;
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
createNode transform -n "nurbsPlane1";
	setAttr ".s" -type "double3" 9.1062458488537974 9.1062458488537974 9.1062458488537974 ;
createNode nurbsSurface -n "nurbsPlaneShape1" -p "nurbsPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 49 ".cp[0:48]" -type "double3" 0.049126180008866427 0.109312689285003 
		-0.053710104755429033 0.019569294443417928 0.04460686520949201 -0.038902497497894761 
		0 0 0 0 0.061194827455018821 0 0 0.038615904367449286 0 0 0 0 0 0.048379450619609708 
		-0.059270652435642335 0.03028027530007299 0.094585807903545607 -0.06442859413600488 
		0.03028027530007299 0.033971999868385318 -0.032805313346349896 0 0 0 0 0.042826263901681108 
		0 0 0 0 0 0 0 0 0.027505578070217765 -0.059270652435642335 0 0.040340112380771655 
		-0.019214078985478056 0 0.017276575454773943 -0.028564383065218801 0 0 0 0 0.01995908493862502 
		0 0 0 0 0 0.014898644570723716 0 0 0.027505578070217765 -0.059270652435642335 0 0.062758011615407491 
		-0.045527663030964394 0 0.007589116432909708 0 0 0 0 0 0.042826263901681108 0 0 0.041794866307333721 
		0 0 0 0 0 0.027505578070217765 -0.059270652435642335 0 0.042612039207236926 0 0 0.051720245520166373 
		0 0 0 0 0 0.062060732906352015 0 0 0 0 0 0 0 0 0.073498529709397159 -0.047803588238447881 
		-0.030997044665220241 0.063638807248620699 -0.012171854457705522 0.020006677039416054 
		0.043665457211624611 0.022839116192025444 -0.009375432402638828 0.044131129087256638 
		0 0 0.042826263901681108 0 0 0 0 0 0 0 0 0.070997433956597383 -0.057400874194217799 
		-0.062863357801581976 0.1465612762397219 -0.018740295394717332 -0.030997044665220241 
		0.048164386755532654 -0.012171854457705522 -0.018929746998865848 0.065458456521334071 
		0 0 0.06394755266590961 0 0 0 0 0 0 0 -0.015893451987597063 0.027505578070217765 
		-0.059270652435642335;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "burnPaper";
	addAttr -ci true -sn "resolution" -ln "resolution" -dv 32 -at "long";
	setAttr ".t" -type "double3" 14.94933772694154 0.20040379447364742 -1.6625958402922407 ;
	setAttr ".resolution" 64;
createNode fluidTexture2D -n "burnPaperShape" -p "burnPaper";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 40;
	setAttr ".rh" 40;
	setAttr ".rd" 1;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 0.1;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 2;
	setAttr ".opg" 0.02913999930024147;
	setAttr ".hss" no;
	setAttr ".ots" 1;
	setAttr ".dmt" 1;
	setAttr ".vmt" 0;
	setAttr ".tmet" 2;
	setAttr ".tmsc" 0.13595999777317047;
	setAttr ".tds" 3.0527999999999995;
	setAttr ".tdf" 0.36892;
	setAttr ".fmet" 2;
	setAttr ".resp" 0.04853999987244606;
	setAttr ".fuit" 0.09707999974489212;
	setAttr ".mxrt" 0.92232000827789307;
	setAttr ".hre" 17.586599349975586;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0.77857142686843872;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].cli" 1;
	setAttr ".coi" 7;
	setAttr ".cib" 0.52167999744415283;
	setAttr -s 4 ".opa[0:3]"  0 0 1 1 1 1 0.48571429 0.74000001 1 0.15000001 0.57999998 
		1;
	setAttr ".opi" 7;
	setAttr ".oib" -0.43479999899864197;
	setAttr ".t" -type "float3" 0.047058824 0.047058824 0.047058824 ;
	setAttr -s 4 ".i";
	setAttr ".i[1].ip" 0.99285715818405151;
	setAttr ".i[1].ic" -type "float3" 4 1.09096 0.27999997 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 0.76428574323654175;
	setAttr ".i[2].ic" -type "float3" 0 0 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".i[6].ip" 0.87142854928970337;
	setAttr ".i[6].ic" -type "float3" 0.46700001 0.08365909 0.034091007 ;
	setAttr ".i[6].ii" 1;
	setAttr ".i[7].ip" 0.92857140302658081;
	setAttr ".i[7].ic" -type "float3" 1.4752721 0.315763 0.110119 ;
	setAttr ".i[7].ii" 1;
	setAttr ".iib" -0.34784001111984253;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 0;
	setAttr ".itx" yes;
	setAttr ".itxg" 0.15000000596046448;
	setAttr ".a" 0.88349997997283936;
	setAttr ".ra" 0.66017997264862061;
	setAttr ".dm" 3;
	setAttr ".fq" 8.9711999893188477;
	setAttr ".nts" -type "string" (
		"This node simulates a burn effect using the fuel grid to control opacity and color. It is applied as a 2D texture on the paper object.\nOne must first assign the initial state for this fluid from:\nMiscellaneous/2D/burnPaperApply.mel\nOr one could paint the fuel grid just to the point where the paper appears opaque with no black then paint a little temperature where one wishes to start the burning. The fuel will start burning wherever the temperature grid is above the ignition temperature.\nOne can customize the texture on the paper by mapping the second (white) ramp index on the color ramp. Currently this is mapped with a grid texture to create the blue lines on the paper. When mapped in this manner the textured color will blacken properly when the paper burns.\nTo make playback quicker for previewing the burn effect temporarily turn off \"always evaluate\" on the expression that transfers the temperature over to the smoke fluid(expression2). Also disable evaluation on the node smokeShape and turn of texture display on the paper's shader. Once done the burn effects should play back in real time.\n"
		+ "Note that this example works best at 30 fps.To see the same behavior at a different frame rate, you need to modify the Reaction Speed to compensate:\ne.g. for 24 fps, multiply the old speed by 1.25\nsetAttr burnPaperShape.reactionSpeed .061;\nSee the node smokeShape for more notes.");
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" -145.43570891359244 16.559443391630801 15.888296615034495 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 1 0.82809716 0.801 ;
	setAttr ".in" 1.9417999982833862;
createNode transform -n "ambientLight1";
	setAttr ".t" -type "double3" 0.16021876083119646 5.1388704519878523 2.9365753968232067 ;
createNode ambientLight -n "ambientLightShape1" -p "ambientLight1";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.022914002 0.11711493 0.134 ;
createNode transform -n "smoke";
	setAttr ".t" -type "double3" -0.1370510665333482 0.39816084149147457 -3.4897431152197669 ;
	setAttr ".r" -type "double3" -90.696896399216584 0 0 ;
	setAttr ".s" -type "double3" 1.7331384372506593 1.7331384372506593 1.7331384372506593 ;
createNode fluidShape -n "smokeShape" -p "smoke";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".sso" yes;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 60;
	setAttr ".rh" 60;
	setAttr ".rd" 1;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 0.9;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 4;
	setAttr ".hss" no;
	setAttr ".ots" 0.8;
	setAttr ".bndx" 2;
	setAttr ".dsc" 0.058279998600482941;
	setAttr ".dds" 0.20388;
	setAttr ".dsb" 0.72839999198913574;
	setAttr ".vsw" 11.571599960327148;
	setAttr ".tst" 0.058279998600482941;
	setAttr ".tfr" 0.3495199978351593;
	setAttr ".tbs" 0.27188000082969666;
	setAttr ".tmet" 2;
	setAttr ".tmsc" 0.95143997669219971;
	setAttr ".tds" 27.1845;
	setAttr ".tdf" 0;
	setAttr ".ttb" 0;
	setAttr ".buo" 59.937999725341797;
	setAttr ".qua" 0.5;
	setAttr -s 3 ".cl";
	setAttr ".cl[2].clp" 0.94285714626312256;
	setAttr ".cl[2].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[2].cli" 2;
	setAttr ".cl[3].clp" 0.05714285746216774;
	setAttr ".cl[3].clc" -type "float3" 0.12800001 0.12800001 0.12800001 ;
	setAttr ".cl[3].cli" 2;
	setAttr ".cl[4].clp" 0.25;
	setAttr ".cl[4].clc" -type "float3" 0.17900001 0.17900001 0.17900001 ;
	setAttr ".cl[4].cli" 2;
	setAttr ".coi" 6;
	setAttr ".cib" 0.86956000328063965;
	setAttr -s 5 ".opa[0:4]"  0.18571429 0 1 1 1 1 0.38571429 0.039999999 1 0.44285715 
		0.16 1 0.69999999 0.30000001 1;
	setAttr ".oib" 0.65211999416351318;
	setAttr ".t" -type "float3" 0.66274512 0.66274512 0.66274512 ;
	setAttr -s 5 ".i";
	setAttr ".i[1].ip" 0.83571428060531616;
	setAttr ".i[1].ic" -type "float3" 2 0.44433331 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 0.92857140302658081;
	setAttr ".i[2].ic" -type "float3" 8 3.5761399 0.44000006 ;
	setAttr ".i[2].ii" 1;
	setAttr ".i[3].ip" 0.82857143878936768;
	setAttr ".i[3].ic" -type "float3" 0.815 0.18106583 0 ;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ip" 0.75714284181594849;
	setAttr ".i[4].ic" -type "float3" 0 0 0 ;
	setAttr ".i[4].ii" 1;
	setAttr ".i[5].ip" 0.80714285373687744;
	setAttr ".i[5].ic" -type "float3" 0.228 0.050653998 0 ;
	setAttr ".i[5].ii" 1;
	setAttr ".iib" 0.78255999088287354;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 2;
	setAttr ".edr" 0.14565999805927277;
	setAttr ".smpm" 0;
	setAttr ".rl" no;
	setAttr ".itx" yes;
	setAttr ".itxg" 0.75727999210357666;
	setAttr ".a" 0.71842002868652344;
	setAttr ".ra" 0.62137997150421143;
	setAttr ".txsc" -type "float3" 1 1.5 1 ;
	setAttr ".dm" 3;
	setAttr ".fq" 3.5922400951385498;
	setAttr ".in" yes;
	setAttr ".nts" -type "string" "The temperature and density grids of this node are set in an expression that uses the temperature of the fluid \"burnPaper\". The temperature dissipates very quickly, while the density lasts longer and becomes the smoke. The temperature affects the incandescence to create the flames. A texture is used on incandescence to provide more detail in the flames. The time and y origin of the texture are animated to help the motion of the flames.\nSee the node burnPaperShape for more notes.";
createNode transform -n "BurnPaperCam";
	setAttr ".t" -type "double3" -1.9555629314032998 16.59824523624647 6.4695356050113135 ;
	setAttr ".r" -type "double3" -63.938352729600695 -9.0000000000001545 -8.0505017391089558e-16 ;
createNode camera -n "BurnPaperCamShape" -p "BurnPaperCam";
	setAttr -k off ".v";
	setAttr ".coi" 17.846954422052331;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".col" -type "float3" 0.10448301 0.163 0.13884223 ;
createNode lightLinker -n "lightLinker1";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".u" 4;
	setAttr ".v" 4;
createNode lambert -n "lambert2";
	addAttr -ci true -sn "resolution" -ln "resolution" -dv 32 -at "long";
	setAttr ".miic" -type "float3" 3.1415927 3.1415927 3.1415927 ;
	setAttr ".resolution" 64;
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode place2dTexture -n "place2dTexture1";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 120 -ast 0 -aet 5000 ";
	setAttr ".st" 6;
createNode grid -n "grid1";
	setAttr ".fo" 0.0097200004383921623;
	setAttr ".dc" -type "float3" 0.89999998 0.89999998 0.89999998 ;
	setAttr ".fc" -type "float3" 0.89999998 0.89999998 0.89999998 ;
	setAttr ".lc" -type "float3" 0.16525102 0.23794857 0.64300001 ;
	setAttr ".uw" 0;
	setAttr ".vw" 0.05000000074505806;
createNode place2dTexture -n "place2dTexture2";
	setAttr ".tf" -type "float2" 0 -0.079999998 ;
	setAttr ".wv" no;
	setAttr ".re" -type "float2" 0.5 20 ;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]= time";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode expression -n "expression2";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" (
		"// This expression emits from the temperature grid of the fluid \"burnPaper\"\n// into the temperature and density of the fluid \"smoke\". Currently one can't\n// use a fluid as an emitter so it must be done using get and setFluidAttr.\nint $xRes = `getAttr smoke.resolutionW`; \nint $yRes = `getAttr smoke.resolutionH`; \nint $xpRes = `getAttr burnPaper.resolutionW`; \nint $ypRes = `getAttr burnPaper.resolutionH`; \nfloat $xScale = 0.5;\nfloat $yScale = 0.5;\nint $xSize = (float)$xRes * $xScale;\nint $ySize = (float)$yRes * $yScale;\nint $xi,$yi;\nfloat $xfac = (float)$xpRes/(float)$xSize;\nfloat $yfac = (float)$ypRes/(float)$ySize;\n// We map to half the x width and centered\n// while the y is 10 units below center.\nint $startX = ($xRes - $xSize)/2;\nint $startY = ($yRes - $ySize)/2 - 10.0;\nfor( $xi = 0; $xi < $xSize; $xi++ ){\n\t$xpi = (int)((float)$xi * $xfac);\n\t$xii = $xi + $startX; \n\tfor( $yi = 0; $yi < $ySize; $yi++ ){\n\t\t$ypi = (int)((float)$yi * $yfac);\n\t\t$yii = $yi + $startY;\n\t\tfloat $temp[] = `getFluidAttr -at \"temperature\" -xi $xpi -yi $ypi burnPaper`;\n"
		+ "\t\tsetFluidAttr -at \"density\" -xi $xii -yi $yii -ad -fv ($temp[0]*0.1) smoke;\n\t\tsetFluidAttr -at \"temperature\" -xi $xii -yi $yii -ad -fv ($temp[0]*0.02) smoke;\n\t}\n}");
createNode expression -n "expression3";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]= -time* 0.15;";
createNode expression -n "expression4";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * .5";
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 4 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 2 ".u";
select -ne :lightList1;
	setAttr -s 2 ".l";
select -ne :defaultTextureList1;
	setAttr -s 2 ".tx";
select -ne :lambert1;
	setAttr ".miic" -type "float3" 3.1415927 3.1415927 3.1415927 ;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultLightSet;
	setAttr -s 2 ".dsm";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "makeNurbPlane1.os" "nurbsPlaneShape1.cr";
connectAttr "place2dTexture1.o" "burnPaperShape.uv";
connectAttr "place2dTexture1.ofs" "burnPaperShape.uvfs";
connectAttr ":time1.o" "burnPaperShape.cti";
connectAttr "grid1.oc" "burnPaperShape.cl[1].clc";
connectAttr "expression1.out[0]" "burnPaperShape.tti";
connectAttr "expression4.out[0]" "smokeShape.tti";
connectAttr ":time1.o" "smokeShape.cti";
connectAttr "expression3.out[0]" "smokeShape.tory";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "lambert2SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[0].sllk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.slnk[0].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[1].sllk";
connectAttr ":initialParticleSE.msg" "lightLinker1.slnk[1].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[2].sllk";
connectAttr "lambert2SG.msg" "lightLinker1.slnk[2].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[3].sllk";
connectAttr "fluidShape1SG.msg" "lightLinker1.slnk[3].solk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "burnPaperShape.ocl" "lambert2.c";
connectAttr "burnPaperShape.ot" "lambert2.it";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "nurbsPlaneShape1.iog" "lambert2SG.dsm" -na;
connectAttr "lambert2SG.msg" "materialInfo1.sg";
connectAttr "lambert2.msg" "materialInfo1.m";
connectAttr "burnPaperShape.msg" "materialInfo1.t" -na;
connectAttr "place2dTexture2.o" "grid1.uv";
connectAttr "place2dTexture2.ofs" "grid1.fs";
connectAttr ":time1.o" "expression1.tim";
connectAttr "smokeShape.ocl" "fluidShape1SG.vs";
connectAttr "smokeShape.iog" "fluidShape1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo2.sg";
connectAttr ":time1.o" "expression2.tim";
connectAttr "burnPaper.msg" "expression2.obm";
connectAttr ":time1.o" "expression3.tim";
connectAttr ":time1.o" "expression4.tim";
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "smokeShape.msg" ":defaultShaderList1.s" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "ambientLightShape1.ltd" ":lightList1.l" -na;
connectAttr "burnPaperShape.msg" ":defaultTextureList1.tx" -na;
connectAttr "grid1.msg" ":defaultTextureList1.tx" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
connectAttr "ambientLight1.iog" ":defaultLightSet.dsm" -na;
// End of BurnPaper.ma