//Maya ASCII 5.0ff03 scene
//Name: Cigarette2D.ma
//Last modified: Tue, Jan 07, 2003 05:25:29 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Mainline";
fileInfo "cutIdentifier" "200301060019";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Cigarette";
	setAttr ".t" -type "double3" 2.3371999989623573 -3.0938842889482925 -0.20274953813781593 ;
	setAttr ".r" -type "double3" 21.131302092582011 -61.770092795080117 88.048890180733466 ;
	setAttr ".s" -type "double3" 0.17520635014153327 0.17520635014153327 0.17520635014153327 ;
createNode transform -n "cig" -p "Cigarette";
	setAttr ".t" -type "double3" -1.9008603423731356 2.2886547850887302 -0.75874069665789912 ;
	setAttr ".s" -type "double3" 1 9.0387621324440204 1 ;
createNode nurbsSurface -n "cigShape" -p "cig";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 49 ".cp[7:48]" -type "double3" -9.2448142760262128e-006 
		7.7315220906259974e-005 -0.00075136760617722231 0.00073637564901996022 0.00034922152013328045 
		6.6857715825792766e-007 -8.791301891813378e-006 0.00024603723926497345 0.0007501868320962668 
		-0.00076230579003699894 0.00051650886933440887 4.0802717506528523e-007 -9.2448142760262128e-006 
		7.7315220906259974e-005 -0.00075136760617722231 0.00073637564901996022 0.00034922152013328045 
		6.6857715825792766e-007 -8.791301891813378e-006 0.00024603723926497345 0.0007501868320962668 
		1.8555545846854656e-005 -0.00015518171412765014 0.0015080926071258105 -0.0014780017972901849 
		-0.00070093305651314219 -1.3419213993084945e-006 1.7645287447763669e-005 
		-0.00049382877111459056 -0.001505722639820295 0.0015300469661900795 -0.0010367005457183054 
		-8.1896366167961976e-007 1.8555545846854656e-005 -0.00015518171412765014 
		0.0015080926071258105 -0.0014780017972901849 -0.00070093305651314219 -1.3419213993084945e-006 
		1.7645287447763669e-005 -0.00049382877111459056 -0.001505722639820295 -2.6098375447911049e-005 
		0.00021826308270868344 -0.0021211322693024393 0.0020788095449235655 0.00098586235206444411 
		1.8874124630065704e-006 -2.4818096998752148e-005 0.00069457017226343121 0.0021177989102612038 
		-0.0021520110755803845 0.001458119329501309 1.1518723986650437e-006 -2.6098375447911049e-005 
		0.00021826308270868344 -0.0021211322693024393 0.0020788095449235655 0.00098586235206444411 
		1.8874124630065704e-006 -2.4818096998752148e-005 0.00069457017226343121 0.0021177989102612038 
		5.3969714640333954e-005 -0.0004513536221466552 0.0043863612706556143 -0.0042988406752832997 
		-0.0020386981528170978 -3.9030441598114207e-006 5.1322183468038851e-005 -0.0014363251870034288 
		-0.0043794681045945527 0.0044502166001523236 -0.0030152943536341237 -2.3819959450172967e-006 
		5.3969714640333954e-005 -0.0004513536221466552 0.0043863612706556143 -0.0042988406752832997 
		-0.0020386981528170978 -3.9030441598114207e-006 5.1322183468038851e-005 -0.0014363251870034288 
		-0.0043794681045945527 -0.00011129764044726098 0.00093079226906200851 -0.0090456594558085968 
		0.008865172384143305 0.0042042522459446729 8.0489512936867021e-006 -0.00010583783813977732 
		0.0029620242628676241 0.0090314442034169495 -0.0091773434484232475 0.0062182123630818431 
		4.9122091695626754e-006 -0.00011129764044726098 0.00093079226906200851 -0.0090456594558085968 
		0.008865172384143305 0.0042042522459446729 8.0489512936867021e-006 -0.00010583783813977732 
		0.0029620242628676241 0.0090314442034169495 0 -0.0092887000257406704 0 0 
		-0.0071913495895276069 0 0 -0.0092887000257404484 0 0 -0.012422215069870401 
		0 0 -0.0092887000257406704 0 0 -0.0071913495895276069 0 0 -0.0092887000257404484 
		0;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 16;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "heater" -p "Cigarette";
	setAttr ".t" -type "double3" -1.9008603423731356 10.797828788739634 -0.75874069665789912 ;
	setAttr ".s" -type "double3" 0.97307510148855092 1.5279143369891794 0.97307510148855092 ;
createNode nurbsSurface -n "heaterShape" -p "heater";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
createNode place3dTexture -n "place3dTexture1" -p "Cigarette";
	setAttr ".t" -type "double3" -2.9357775243807747 2.1758414157764401 -1.54361115325485 ;
createNode place3dTexture -n "place3dTexture2" -p "Cigarette";
	setAttr ".t" -type "double3" -1.9008603423731356 2.2886547850887302 -0.75874069665789912 ;
createNode place3dTexture -n "place3dTexture3" -p "Cigarette";
	setAttr ".t" -type "double3" -1.9008603423731356 2.2886547850887302 -0.75874069665789912 ;
createNode fluidEmitter -n "fluidEmitter1";
	setAttr ".t" -type "double3" 0.4629102359906927 -3.6321088077540709 -0.28370390370950194 ;
	setAttr -k off ".rat";
	setAttr -k off ".sro";
	setAttr -l on -k off ".urpp";
	setAttr -k off ".npuv";
	setAttr ".max" 0.14000000000000001;
	setAttr -k off ".dx";
	setAttr -k off ".dy";
	setAttr -k off ".dz";
	setAttr -k off ".spr";
	setAttr -k off ".spd";
	setAttr -k off ".srnd";
	setAttr -k off ".tspd";
	setAttr -k off ".nspd";
	setAttr -k off ".afc";
	setAttr -k off ".afa";
	setAttr -k off ".alx";
	setAttr -k off ".arx";
	setAttr -k off ".rnd";
	setAttr -k off ".drs";
	setAttr -k off ".ssz";
	setAttr -k off ".dss";
	setAttr ".fhe" 1;
	setAttr ".ffe" 1;
createNode transform -n "Smoke";
	setAttr ".t" -type "double3" 1.3423389517423718 2.5 -0.28296669172916822 ;
createNode fluidShape -n "SmokeShape" -p "Smoke";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 80;
	setAttr ".rh" 120;
	setAttr ".rd" 1;
	setAttr ".dw" 10;
	setAttr ".dh" 15.000000000000005;
	setAttr ".dd" 0.25;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 2;
	setAttr ".hss" no;
	setAttr ".ots" 1;
	setAttr ".bndx" 0;
	setAttr ".bndy" 0;
	setAttr ".dsc" 0.82643997669219971;
	setAttr ".dds" 0.56198000000000004;
	setAttr ".dsb" 12;
	setAttr ".vsw" 10;
	setAttr ".tbs" 0.029999999329447746;
	setAttr ".e2w" -type "matrix" 0.81106382608413696 0 0.58495765924453735 0
		 0.2242153137922287 0.92362314462661743 -0.31088221073150635 0 -0.54028046131134033 0.38330176472663879 0.74911731481552124 0
		 -0.40829378366470337 -2.9712951183319092 0.79784166812896729 1;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr -s 2 ".opa[0:1]"  0 0 1 1 1 1;
	setAttr ".t" -type "float3" 0.057859998 0.057859998 0.057859998 ;
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
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".nts" -type "string" (
		"Example Goal:\r\n"
		+ "Simple 2D Cigarette Smoke.\r\n"
		+ "\r\n"
		+ "This scene uses a 2D fluid to simulate cigarette smoke.  The motion is driven by bouyancy and swirl. Dissipation is increased to get the correct look and keep the smoke from revealing the edge of the volume. This would be useful for sequences involving limited camera movement where a quick smoke effect is required.\r\n"
		+ "\r\n"
		+ "Render using Cigarette2DCamera.\r\n"
		+ "Render Time: $\r\n");
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" -27.170846410278031 7.7158044187314756 -18.017107756418778 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
createNode transform -n "Cigarette2DCamera";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -1.1279848872880536 -1.7684026457900435 6.3754169169304893 ;
	setAttr ".r" -type "double3" 2.6616472703975185 -15.799999999999997 0 ;
createNode camera -n "Cigarette2DCameraShape" -p "Cigarette2DCamera";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 6.5168402296180803;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode rebuildSurface -n "rebuildSurface1";
	setAttr ".end" 1;
	setAttr ".kc" no;
	setAttr ".kr" 0;
createNode insertKnotSurface -n "insertKnotSurface1";
	setAttr -s 2 ".p[0:1]"  1.9602509296549 1.9792133934038001;
	setAttr -s 2 ".nk[0:1]"  1 1;
createNode makeNurbCylinder -n "makeNurbCylinder1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".s" 11;
	setAttr ".nsp" 4;
createNode materialInfo -n "materialInfo6";
createNode shadingEngine -n "lambert2SG2";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lambert -n "lambert6";
	setAttr ".dc" 0.80992001295089722;
createNode ramp -n "ramp1";
	setAttr ".t" 1;
	setAttr ".in" 0;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 1 0.52183998 0.31199998 ;
	setAttr ".cel[1].ep" 0.25999999046325684;
	setAttr ".cel[1].ec" -type "float3" 1 0.96268666 0.94200003 ;
createNode place2dTexture -n "place2dTexture1";
createNode detachSurface -n "detachSurface1";
	setAttr ".p[0]"  2.1746218690000001;
	setAttr -s 2 ".k[0:1]" yes yes;
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "lambert4SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lambert -n "lambert4";
	setAttr ".dc" 0.69422000646591187;
	setAttr ".gi" 0.19833999872207642;
createNode crater -n "crater2";
	setAttr ".sh" 3.1403999328613281;
	setAttr ".c1" -type "float3" 0.85299999 0.64508468 0.16718797 ;
	setAttr ".c2" -type "float3" 0.64300001 0.17778951 0 ;
	setAttr ".c3" -type "float3" 0 0 0 ;
createNode crater -n "crater1";
	setAttr ".c1" -type "float3" 0 0 0 ;
	setAttr ".c2" -type "float3" 0.099179998 0.099179998 0.099179998 ;
	setAttr ".c3" -type "float3" 0.43000001 0.11889501 0 ;
createNode bump3d -n "bump3d2";
	setAttr ".bd" 1.5291999578475952;
createNode brownian -n "brownian1";
	setAttr ".ail" yes;
	setAttr ".l" 3.3801400661468506;
	setAttr ".ic" 0.13223999738693237;
	setAttr ".oct" 3.281019926071167;
createNode materialInfo -n "materialInfo4";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lightLinker -n "lightLinker1";
	setAttr ".ihi" 0;
	setAttr -s 5 ".lnk";
select -ne :time1;
	setAttr ".o" 119;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 5 ".u";
select -ne :lightList1;
select -ne :defaultTextureList1;
	setAttr -s 4 ".tx";
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".sdf" -type "string" "";
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 215;
	setAttr ".left" 96;
	setAttr ".bot" 10;
	setAttr ".rght" 217;
	setAttr ".fs" 1;
	setAttr ".ef" 10;
	setAttr ".bf" 1;
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
select -ne :defaultLightSet;
connectAttr "rebuildSurface1.os" "cigShape.cr";
connectAttr "detachSurface1.os[1]" "heaterShape.cr";
connectAttr ":time1.o" "fluidEmitter1.ct";
connectAttr "SmokeShape.ifl" "fluidEmitter1.full[0]";
connectAttr "SmokeShape.ots" "fluidEmitter1.dt[0]";
connectAttr "SmokeShape.inh" "fluidEmitter1.inh[0]";
connectAttr "SmokeShape.sti" "fluidEmitter1.stt[0]";
connectAttr "SmokeShape.sd[0]" "fluidEmitter1.sd[0]";
connectAttr ":time1.o" "SmokeShape.cti";
connectAttr "fluidEmitter1.ef" "SmokeShape.eml[0].emfr";
connectAttr "fluidEmitter1.efc" "SmokeShape.fce[0]";
connectAttr "insertKnotSurface1.os" "rebuildSurface1.is";
connectAttr "makeNurbCylinder1.os" "insertKnotSurface1.is";
connectAttr "lambert2SG2.msg" "materialInfo6.sg";
connectAttr "lambert6.oc" "lambert2SG2.ss";
connectAttr "cigShape.iog" "lambert2SG2.dsm" -na;
connectAttr "ramp1.oc" "lambert6.c";
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "makeNurbSphere1.os" "detachSurface1.is";
connectAttr "lambert4SG.msg" "materialInfo3.sg";
connectAttr "lambert4.oc" "lambert4SG.ss";
connectAttr "heaterShape.iog" "lambert4SG.dsm" -na;
connectAttr "crater2.oc" "lambert4.ic";
connectAttr "crater1.oc" "lambert4.c";
connectAttr "bump3d2.o" "lambert4.n";
connectAttr "place3dTexture2.wim" "crater2.pm";
connectAttr "place3dTexture1.wim" "crater1.pm";
connectAttr "brownian1.oa" "bump3d2.bv";
connectAttr "place3dTexture3.wim" "brownian1.pm";
connectAttr "fluidShape1SG.msg" "materialInfo4.sg";
connectAttr "SmokeShape.ocl" "fluidShape1SG.vs";
connectAttr "SmokeShape.iog" "fluidShape1SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "lambert4SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[5].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[5].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[6].llnk";
connectAttr "lambert2SG2.msg" "lightLinker1.lnk[6].olnk";
connectAttr "lambert4SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2SG2.pa" ":renderPartition.st" -na;
connectAttr "lambert4.msg" ":defaultShaderList1.s" -na;
connectAttr "SmokeShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert6.msg" ":defaultShaderList1.s" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "bump3d2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "crater1.msg" ":defaultTextureList1.tx" -na;
connectAttr "crater2.msg" ":defaultTextureList1.tx" -na;
connectAttr "brownian1.msg" ":defaultTextureList1.tx" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of Cigarette2D.ma
