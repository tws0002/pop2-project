//Maya ASCII 7.0ff10 (Candidate) scene
//Name: ToonlineEdgeGlints.ma
//Last modified: Tue, Jul 12, 2005 02:10:51 PM
requires maya "7.0ff10 (Candidate)";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 7.0";
fileInfo "version" "7.0CG";
fileInfo "cutIdentifier" "200506192018-000000";
fileInfo "osv" "Microsoft Windows XP Service Pack 1 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 2.2372173735299157 1.6177835604353297 10.385665638749089 ;
	setAttr ".r" -type "double3" -12.938352729604118 0.9999999999998046 -1.4911121105328213e-016 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 3.8212760927284761;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".col" -type "float3" 0.32800001 0.43099999 0.39899999 ;
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
createNode transform -n "strokeCrystals1";
createNode stroke -n "strokeShapeCrystals1" -p "strokeCrystals1";
	setAttr ".cch" yes;
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".mvbs" 822;
	setAttr ".usn" yes;
	setAttr ".nml" -type "double3" 0 1 0 ;
	setAttr ".pcv[0].smp" 15;
	setAttr ".ps1" 0.187;
	setAttr ".px1" 1.5;
	setAttr ".ps2" 0.187;
	setAttr ".px3" 1.2;
	setAttr ".psc[0]"  0 1 1;
createNode transform -n "annotationLocator1" -p "strokeCrystals1";
	setAttr ".t" -type "double3" 2.7231909779019854 -0.10026332463795917 6.4403899254346317 ;
createNode locator -n "annotationLocator1Shape" -p "annotationLocator1";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "annotationLocator1";
	setAttr ".t" -type "double3" -0.25501774613772143 2.3886290302336759 -0.23671445954612214 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Description (see attribute editor notes)";
	setAttr ".nts" -type "string" "This scene creates glowing edge highlights on a pfx crystal preset by using toon lines. \r\nThis file should be be loaded with file->open rather than importing it, so that one will get the correct glow and render settings.\r\n\r\nThe crystals have a toonline assigned with only crease lines. The brush \"crystalEdge\" assigned to the toonline has illumination on with a very bright specular. The lines are soft and fairly transparent, so only the specular is dominant. A thresholded shader glow effect on these lines provides the added glint effect.";
createNode transform -n "curveCrystals";
	setAttr ".v" no;
createNode nurbsCurve -n "curveCrystalsShape" -p "curveCrystals";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		2 13 0 no 3
		16 0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 13
		15
		1.2155309999999999 0 7.2706770000000001
		1.2355240000000001 0 7.0213939999999999
		1.2150030000000001 0 6.7053890000000003
		1.231236 0 6.46584
		1.254969 0 6.2173449999999999
		1.2854369999999999 0 5.9270500000000004
		1.3662570000000001 0 5.6896560000000003
		1.5204800000000001 0 5.5343609999999996
		1.8007169999999999 0 5.5743130000000001
		2.1649259999999999 0 5.7634460000000001
		2.5061819999999999 0 5.9968250000000003
		2.8062299999999998 0 6.2737059999999998
		3.1075270000000002 0 6.4916
		3.4200750000000002 0 6.5868719999999996
		3.7219519999999999 0 6.6556550000000003
		;
createNode transform -n "pfxToon1";
createNode pfxToon -n "pfxToonShape1" -p "pfxToon1";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".pln" 0;
	setAttr ".bln" 0;
	setAttr ".lwd" 0.005;
	setAttr ".lof" 0.80000000000000004;
	setAttr ".amn" 1;
	setAttr ".amx" 1;
	setAttr ".hco" no;
	setAttr ".spf" no;
	setAttr -s 2 ".cwd[0:1]"  0 1 3 0.30000001 0.30000001 3;
	setAttr ".cba" 84.792;
	setAttr ".rcr" yes;
	setAttr ".msl" 0.01;
	setAttr ".ccl" -type "float3" 0.42148 0.42148 0.42148 ;
createNode transform -n "pfxToon1ProfileMeshes";
createNode transform -n "polySurface1" -p "pfxToon1ProfileMeshes";
createNode mesh -n "polySurfaceShape1" -p "polySurface1";
	setAttr -k off ".v";
	setAttr ".ovdt" 2;
	setAttr ".ove" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ds" no;
	setAttr ".op" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "pointLight1";
	setAttr ".t" -type "double3" -6.5579665557894007 9.3840340817116843 4.5526421749125854 ;
createNode pointLight -n "pointLightShape1" -p "pointLight1";
	setAttr -k off ".v";
	setAttr ".us" no;
createNode lightLinker -n "lightLinker1";
	setAttr -s 3 ".lnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
	setAttr ".do" 1;
createNode brush -n "crystals1";
	setAttr ".gsc" 2.71;
	setAttr ".dep" yes;
	setAttr ".ill" yes;
	setAttr ".brt" 5;
	setAttr ".bwd" 0.4896;
	setAttr ".sft" -0.38844;
	setAttr ".cl1" -type "float3" 0.093485594 0.20280574 0.2314 ;
	setAttr ".cl2" -type "float3" 0.48765683 0.35174015 0.57852 ;
	setAttr ".tn1" -type "float3" 0.013943998 0.038820777 0.249 ;
	setAttr ".tn2" -type "float3" 0.053671002 0.063215367 0.191 ;
	setAttr ".in1" -type "float3" 0.149408 0.3122198 0.322 ;
	setAttr ".spe" 0.99174;
	setAttr ".spp" 13.388400000000001;
	setAttr ".trn" 0.32232;
	setAttr ".chr" 0.15702;
	setAttr ".csr" 0.18182000000000001;
	setAttr ".cvr" 0.59504;
	setAttr ".brn" 0.57852000000000003;
	setAttr ".dps" 0.15702;
	setAttr ".rll" yes;
	setAttr ".tfl" no;
	setAttr ".tub" yes;
	setAttr ".tps" 3.5538;
	setAttr ".trd" 0;
	setAttr ".lnx" 0.82640000000000002;
	setAttr ".lnn" 0.10000000000000001;
	setAttr ".tw1" 0.13573;
	setAttr ".tw2" 0.130522;
	setAttr ".wdr" 0.41322;
	setAttr ".wdb" -0.057840000000000003;
	setAttr ".swb" 0.7686;
	setAttr ".elm" 0.01652;
	setAttr ".elx" 1;
	setAttr ".azn" -1;
	setAttr ".azx" 1;
	setAttr ".twd" 0;
	setAttr ".ldp" 0.79338;
	setAttr ".ll1" 0;
	setAttr ".ll2" 0;
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".ltwl" 0.5;
	setAttr ".lsg" 1;
	setAttr ".lst" 1;
	setAttr ".nlc" 1;
	setAttr ".lft" 0;
	setAttr ".lln" 0.81322000000000005;
	setAttr ".leb" 0.0248;
	setAttr ".let" 0.01652;
	setAttr ".ltr" 0;
	setAttr ".lsp" 0.90910000000000002;
	setAttr ".lc1" -type "float3" 0.31404001 0.31404001 0.31404001 ;
	setAttr ".lc2" -type "float3" 0.55104756 0.65289998 0.61971307 ;
	setAttr ".lvr" 0.3967;
	setAttr ".lub" no;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".txt" 3;
	setAttr ".tos" 0.30578;
	setAttr ".too" 0.0909;
	setAttr ".dsc" 0;
	setAttr ".bmi" 0.11572;
	setAttr ".bbl" 2.1818;
	setAttr ".lid" no;
	setAttr ".tc2" -type "float3" 0.0082599996 0.0057902597 0.0058396547 ;
	setAttr ".txu" 1;
	setAttr ".rpu" 1.73552;
	setAttr ".rpv" 2.27272;
	setAttr ".bmt" 0.41324;
	setAttr ".smr" 0.22314000000000001;
	setAttr ".fra" 0.65290000000000004;
	setAttr ".ppl" yes;
	setAttr -s 3 ".wsc[0:2]"  0 1 1 0.8142857 1 1 1 0 1;
	setAttr -s 2 ".lws[0:1]"  0 1 1 1 0 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 8 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.42069533 0.43799999 0.41391 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.64999997615814209;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 0.84285712242126465;
	setAttr ".env[2].envc" -type "float3" 0 0.14862955 0.66900003 ;
	setAttr ".env[2].envi" 2;
	setAttr ".env[3].envp" 0.49285712838172913;
	setAttr ".env[3].envc" -type "float3" 0.93800002 1 0.99865669 ;
	setAttr ".env[3].envi" 2;
	setAttr ".env[4].envp" 0.47142857313156128;
	setAttr ".env[4].envc" -type "float3" 0.26010889 0.31900001 0.23701701 ;
	setAttr ".env[4].envi" 2;
	setAttr ".env[5].envp" 0.20000000298023224;
	setAttr ".env[5].envc" -type "float3" 0.359332 0.392528 0.34631601 ;
	setAttr ".env[5].envi" 2;
	setAttr ".env[6].envp" 0.17142857611179352;
	setAttr ".env[6].envc" -type "float3" 0.4992893 0.57300001 0.38104501 ;
	setAttr ".env[6].envi" 2;
	setAttr ".env[7].envp" 0.86428570747375488;
	setAttr ".env[7].envc" -type "float3" 0.47365203 0.48188919 0.66900003 ;
	setAttr ".env[7].envi" 2;
	setAttr -s 4 ".rro[0:3]"  0 1 1 1 0.23999999 1 0.42857143 0.83999997 
		1 0.75714284 0.31999999 1;
	setAttr ".brf" 0.66942;
	setAttr ".lrf" 0.84298;
	setAttr ".hde" yes;
createNode surfaceShader -n "pfxToon1ProfileShader";
createNode shadingEngine -n "pfxToon1ProfileShaderSG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode brush -n "crystalEdge";
	setAttr ".dep" yes;
	setAttr ".mdp" no;
	setAttr ".ill" yes;
	setAttr ".sft" 0.57024000000000008;
	setAttr ".cl1" -type "float3" 0.66115999 0.66115999 0.66115999 ;
	setAttr ".tn1" -type "float3" 0.83472002 0.83472002 0.83472002 ;
	setAttr ".spe" 4;
	setAttr ".spp" 100;
	setAttr ".trn" 0.93388000000000004;
	setAttr ".glc" -type "float3" 1 1 1 ;
	setAttr ".gls" 3.9008000000000003;
	setAttr ".sgl" 1;
	setAttr ".bks" 0.45454000000000006;
	setAttr ".rll" yes;
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".txt" 3;
	setAttr ".tcs" 0.71900000000000008;
	setAttr ".txu" 1;
	setAttr ".rpu" 0.03;
	setAttr ".rpv" 0.005;
	setAttr ".bmt" 0;
	setAttr ".fra" 0.67768000000000006;
	setAttr ".fam" 0.52892;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 1;
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
select -ne :shaderGlow1;
	setAttr ".gt" 0;
	setAttr ".gi" 0.0099999997764825821;
	setAttr ".gs" 0.0099999997764825821;
	setAttr ".hi" 0.035000000149011612;
	setAttr ".hs" 0.035000000149011612;
	setAttr ".hn" 0.72729998826980591;
	setAttr ".qual" 500;
	setAttr ".th" 0.73600000143051147;
	setAttr ".ae" no;
select -ne :defaultRenderGlobals;
	setAttr ".ope" yes;
	setAttr ".oppf" yes;
select -ne :defaultRenderQuality;
	setAttr ".rfl" 10;
	setAttr ".rfr" 10;
	setAttr ".sl" 10;
	setAttr ".eaa" 0;
	setAttr ".ufil" yes;
	setAttr ".ss" 2;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "crystals1.obr" "strokeShapeCrystals1.brs";
connectAttr "curveCrystalsShape.ws" "strokeShapeCrystals1.pcv[0].crv";
connectAttr "annotationLocator1Shape.wm" "annotationShape1.dom" -na;
connectAttr "strokeShapeCrystals1.omm" "pfxToonShape1.ins[0].srf";
connectAttr "strokeShapeCrystals1.wm" "pfxToonShape1.ins[0].iwm";
connectAttr "crystalEdge.obr" "pfxToonShape1.brs";
connectAttr "pfxToonShape1.opm[0]" "polySurfaceShape1.i";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "pfxToon1ProfileShaderSG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":time1.o" "crystals1.tim";
connectAttr "pfxToonShape1.ocl" "pfxToon1ProfileShader.oc";
connectAttr "pfxToon1ProfileShader.oc" "pfxToon1ProfileShaderSG.ss";
connectAttr "polySurfaceShape1.iog" "pfxToon1ProfileShaderSG.dsm" -na;
connectAttr "pfxToon1ProfileShaderSG.msg" "materialInfo1.sg";
connectAttr "pfxToon1ProfileShader.msg" "materialInfo1.m";
connectAttr "pfxToon1ProfileShader.msg" "materialInfo1.t" -na;
connectAttr ":time1.o" "crystalEdge.tim";
connectAttr "pfxToon1ProfileShaderSG.pa" ":renderPartition.st" -na;
connectAttr "pfxToon1ProfileShader.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "pointLightShape1.ltd" ":lightList1.l" -na;
connectAttr "pointLight1.iog" ":defaultLightSet.dsm" -na;
// End of ToonlineEdgeGlints.ma