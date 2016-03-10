//Maya ASCII 5.0ff03 scene
//Name: TexSphere.ma
//Last modified: Tue, Jan 07, 2003 05:22:44 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Mainline";
fileInfo "cutIdentifier" "200301060019";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "nurbsSphere1";
	setAttr ".t" -type "double3" -0.036128515651230986 -1.0390541305798981 
		0 ;
	setAttr ".s" -type "double3" 1.4132792662492171 1.4132792662492171 1.4132792662492171 ;
createNode nurbsSurface -n "nurbsSphereShape1" -p "nurbsSphere1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "FluidTexture";
	setAttr ".t" -type "double3" 0 2.3384374343266821 0 ;
createNode fluidTexture3D -n "FluidTextureShape" -p "FluidTexture";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".iss" yes;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 10;
	setAttr ".ots" 0.248;
	setAttr ".srs" 0.25;
	setAttr ".dsc" 1.1239999532699585;
	setAttr ".grv" 0.10000000149011612;
	setAttr ".viy" 0.86776000261306763;
	setAttr ".fri" 0.8429800271987915;
	setAttr ".e2w" -type "matrix" -0.50301992893218994 0 -0.86427479982376099 0
		 -0.16695955395698547 0.98116356134414673 0.097172781825065613 0 0.84799492359161377 0.19317878782749176 -0.49354484677314758 0
		 3.7566595077514648 -0.066389977931976318 -2.1746633052825928 1;
	setAttr ".rin" 3;
	setAttr -s 4 ".cl";
	setAttr ".cl[0].clp" 0.0010000000474974513;
	setAttr ".cl[0].clc" -type "float3" 0.13846 0.35523155 0.46000001 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.77142858505249023;
	setAttr ".cl[1].clc" -type "float3" 1 0 0 ;
	setAttr ".cl[1].cli" 0;
	setAttr ".cl[2].clp" 0.30714285373687744;
	setAttr ".cl[2].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0;
	setAttr ".cl[3].clc" -type "float3" 0.301 0.77224249 1 ;
	setAttr ".cl[3].cli" 1;
	setAttr ".coi" 5;
	setAttr -s 3 ".opa[0:2]"  0.35714287 0 1 1 0.50714284 
		1 0 0 0;
	setAttr ".oib" -1;
	setAttr ".t" -type "float3" 0.75206 0.75206 0.75206 ;
	setAttr -s 12 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.15714286267757416;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 0.89999997615814209;
	setAttr ".i[2].ic" -type "float3" 1 1 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".i[3].ip" 0.25714287161827087;
	setAttr ".i[3].ic" -type "float3" 0 0 1 ;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ip" 0.36428570747375488;
	setAttr ".i[4].ic" -type "float3" 0 1 0 ;
	setAttr ".i[4].ii" 1;
	setAttr ".i[5].ip" 0.44285714626312256;
	setAttr ".i[5].ic" -type "float3" 1 0 0 ;
	setAttr ".i[5].ii" 1;
	setAttr ".i[6].ip" 0.52857142686843872;
	setAttr ".i[6].ic" -type "float3" 1 1 1 ;
	setAttr ".i[6].ii" 1;
	setAttr ".i[7].ip" 0.65714287757873535;
	setAttr ".i[7].ic" -type "float3" 0 0 0 ;
	setAttr ".i[7].ii" 1;
	setAttr ".i[8].ip" 0.75;
	setAttr ".i[8].ic" -type "float3" 0 1 1 ;
	setAttr ".i[8].ii" 1;
	setAttr ".i[9].ip" 0.81428569555282593;
	setAttr ".i[9].ic" -type "float3" 1 0 0 ;
	setAttr ".i[9].ii" 1;
	setAttr ".i[10].ip" 0.96428573131561279;
	setAttr ".i[10].ic" -type "float3" 1 1 1 ;
	setAttr ".i[10].ii" 1;
	setAttr ".i[11].ip" 0.75714302062988281;
	setAttr ".i[11].ic" -type "float3" 0.111111 0.88888901 0.88888901 ;
	setAttr ".i[11].ii" 1;
	setAttr ".ili" 5;
	setAttr ".iib" 0.56756001710891724;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 0;
	setAttr ".dos" 0;
	setAttr ".ctx" yes;
	setAttr ".itx" yes;
	setAttr ".otx" yes;
	setAttr ".a" 3;
	setAttr ".th" 0.206619992852211;
	setAttr ".fq" 4.0496001243591309;
	setAttr ".fr" 7.0247998237609863;
	setAttr ".nts" -type "string" (
		"Example Goal:\r\n"
		+ "An animated fluid color texture on a sphere.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "A 3D fluid texture is assigned to the shader Color.\r\n"
		+ "Density is created with a volume fluid emitter.\r\n"
		+ "Density and Velocity are set to Dynamic Grid.\r\n"
		+ "Colour, Incandescence and Opacity all use Density as inputs.\r\n"
		+ "Details are added by texturing Color, Incandescence and Opacity with Perlin Noise.\r\n"
		+ "The texture is animated by setting Texture Time to =time. \r\n"
		+ "Some playback is necessary to see the texture.\r\n"
		+ "\r\n"
		+ "Finer points: \r\n"
		+ "Increase the Resolution and Shading Quality for a better render result.\r\n"
		+ "Render using TexSphereCamera.\r\n"
		+ "Render Time: $");
createNode fluidEmitter -n "Emit";
	setAttr ".emt" 4;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".fde" 10;
	setAttr ".fhe" 10;
createNode transform -n "TexSphereCamera";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 4.52223421444649 -0.41997991128990797 -2.4567644246738163 ;
	setAttr ".r" -type "double3" -6.5999999999997927 117.19999999999941 0 ;
createNode camera -n "TexSphereCameraShape" -p "TexSphereCamera";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".cap" -type "double2" 1.41732 0.94488000000000005 ;
	setAttr ".ff" 0;
	setAttr ".ovr" 1.3;
	setAttr ".ncp" 0.01;
	setAttr ".coi" 5.1134256611411244;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
	setAttr ".dr" yes;
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time";
createNode lightLinker -n "lightLinker1";
	setAttr ".ihi" 0;
	setAttr -s 2 ".lnk";
select -ne :time1;
	setAttr ".o" 13;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :defaultTextureList1;
select -ne :lambert1;
	setAttr ".it" -type "float3" 0.29752001 0.29752001 0.29752001 ;
	setAttr ".crab" yes;
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :initialMaterialInfo;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".sdf" -type "string" "";
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 437;
	setAttr ".left" 218;
	setAttr ".bot" 22;
	setAttr ".rght" 490;
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
select -ne :defaultResolution;
	setAttr ".w" 720;
	setAttr ".h" 486;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
connectAttr "makeNurbSphere1.os" "nurbsSphereShape1.cr";
connectAttr "expression1.out[0]" "FluidTextureShape.tti";
connectAttr ":time1.o" "FluidTextureShape.cti";
connectAttr "Emit.ef" "FluidTextureShape.eml[0].emfr";
connectAttr "Emit.efc" "FluidTextureShape.fce[0]";
connectAttr ":time1.o" "Emit.ct";
connectAttr "FluidTextureShape.ifl" "Emit.full[0]";
connectAttr "FluidTextureShape.ots" "Emit.dt[0]";
connectAttr "FluidTextureShape.inh" "Emit.inh[0]";
connectAttr "FluidTextureShape.sti" "Emit.stt[0]";
connectAttr "FluidTextureShape.sd[0]" "Emit.sd[0]";
connectAttr ":time1.o" "expression1.tim";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "FluidTextureShape.msg" ":defaultTextureList1.tx" -na;
connectAttr "FluidTextureShape.ocl" ":lambert1.c";
connectAttr "nurbsSphereShape1.iog" ":initialShadingGroup.dsm" -na;
// End of TexSphere.ma
