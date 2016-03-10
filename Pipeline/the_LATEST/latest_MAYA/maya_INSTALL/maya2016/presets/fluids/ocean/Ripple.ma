//Maya ASCII 5.0 scene
//Name: ripple.ma
//Last modified: Wed, Apr 16, 2003 12:53:27 AM
requires maya "5.0";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200304040010";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "Pond1";
	addAttr -ci true -h true -sn "dfm" -ln "miDeriveFromMaya" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "hde" -ln "miHide" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "vsb" -ln "miVisible" -bt "UNKN" -dv 2 -at "short";
	addAttr -ci true -sn "trc" -ln "miTrace" -bt "UNKN" -dv 2 -at "short";
	addAttr -ci true -sn "shd" -ln "miShadow" -bt "UNKN" -dv 2 -at "short";
	addAttr -ci true -sn "cst" -ln "miCaustic" -bt "UNKN" -dv 5 -at "short";
	addAttr -ci true -sn "glb" -ln "miGlobillum" -bt "UNKN" -dv 5 -at "short";
	addAttr -ci true -sn "mieg" -ln "miExportGeoShader" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "migs" -ln "miGeoShader" -bt "UNKN" -at "message";
	setAttr ".t" -type "double3" -0.020502391129632258 0 -0.056947582123314078 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode fluidShape -n "PondShape1" -p "Pond1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 100;
	setAttr ".rh" 100;
	setAttr ".rd" 1;
	setAttr ".dw" 50;
	setAttr ".dh" 50;
	setAttr ".dd" 20;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".bod" 4;
	setAttr ".hss" no;
	setAttr ".sol" 2;
	setAttr ".bndx" 0;
	setAttr ".bndy" 0;
	setAttr ".dsc" 6;
	setAttr ".dsb" 0;
	setAttr ".vdp" 0.10000000149011612;
	setAttr ".qua" 3;
	setAttr ".rin" 3;
	setAttr -s 3 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0.089645997 0.18954401 0.44600001 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.5;
	setAttr ".cl[1].clc" -type "float3" 0.630252 0.73199999 0.68521303 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 1;
	setAttr ".cl[2].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".coi" 6;
	setAttr -s 2 ".opa[0:1]"  0 0 1 1 1 1;
	setAttr ".t" -type "float3" 0 0 0 ;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0.30000001192092896;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.5;
	setAttr ".i[1].ic" -type "float3" 0.061627999 0.19939101 0.21699999 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 0.24928799 0.40799999 0.34237301 ;
	setAttr ".i[2].ii" 1;
	setAttr ".ili" 5;
	setAttr ".spc" -type "float3" 0.95867997 0.95867997 0.95867997 ;
	setAttr -s 4 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.042744 0.108427 0.54799998 ;
	setAttr ".env[0].envi" 1;
	setAttr ".env[1].envp" 0.44999998807907104;
	setAttr ".env[1].envc" -type "float3" 0.087080002 0.15601701 0.28 ;
	setAttr ".env[1].envi" 1;
	setAttr ".env[2].envp" 0.60000002384185791;
	setAttr ".env[2].envc" -type "float3" 0.79049999 0.93000001 0.87143302 ;
	setAttr ".env[2].envi" 1;
	setAttr ".env[3].envp" 1;
	setAttr ".env[3].envc" -type "float3" 0.140119 0.215084 0.54100001 ;
	setAttr ".env[3].envi" 1;
	setAttr ".dos" 0;
	setAttr ".edr" 0.33057999610900879;
	setAttr ".hfld" yes;
	setAttr ".srr" yes;
	setAttr ".nts" -type "string" (
		"Preset Goal: to create a ripple in a pond.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "The emitter is keyed to emit density for a few frames as if falls to \"drop\" some fluid onto the pond. This gives part of a splash and a ripple. The 2D fluid uses a spring mesh solver to model a water surface. The y size parameter can be increased to provide a larger range of travel, although the volume rendering may be a bit slower.  \r\n"
		+ "The boundaries are turned off so they don't reflect the ripple. \r\n"
		+ "The Shading dropoff shape is set to sphere with a higher than default edge dropoff to fade out the ripple more naturally as it approaches the edge.\r\n"
		+ "This method is good for a pond, not an ocean. Attach a wake to an ocean for a similar effect.\r\n"
		+ "Although this emitter is animated in y, it needn't be. Just the emission animation matters. \r\n"
		+ "There is no foam. \r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Paricle emission may give the look of bits of water breaking off of the little water spout when the emitter hits the pond.\r\n"
		+ "Shading quality> render interpolation set to smooth compensates for lower resolutions of the fluid to degree and produces a smoother surface.\r\n"
		+ "Negative density emission will push the surface down while positive values will push the surface up.\r\n"
		+ "Some damping is added in Contents Details> Velocity to restrict how long you see the small ripples. Render time: $$");
createNode fluidEmitter -n "PondWakeEmitter1";
	setAttr ".t" -type "double3" 0 0 0.0082168549757311929 ;
	setAttr ".s" -type "double3" 1.5 1.5 1.5 ;
	setAttr ".emt" 4;
	setAttr -l on ".urpp";
	setAttr ".max" 1;
	setAttr ".vol" 1;
	setAttr ".fdo" 0.5;
	setAttr ".fjt" no;
	setAttr ".fde" 3;
	setAttr ".ffe" 1;
createNode transform -n "defaultLight";
	setAttr ".t" -type "double3" 0.85293691079335332 1.9136371402280936 29.740515917257149 ;
	setAttr ".r" -type "double3" -48.001705267202759 13.184447622085079 -5.8911752262423045 ;
createNode directionalLight -n "defaultLightShape" -p "defaultLight";
	addAttr -ci true -sn "milt" -ln "miExportMrLight" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mils" -ln "miLightShader" -bt "UNKN" -at "message";
	addAttr -ci true -sn "mipe" -ln "miPhotonEmitter" -bt "UNKN" -at "message";
	addAttr -ci true -sn "phot" -ln "emitPhotons" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "eng" -ln "energy" -bt "UNKN" -at "float3" -nc 3;
	addAttr -ci true -sn "engr" -ln "energyR" -bt "UNKN" -dv 8000 -at "float" 
		-p "energy";
	addAttr -ci true -sn "engg" -ln "energyG" -bt "UNKN" -dv 8000 -at "float" 
		-p "energy";
	addAttr -ci true -sn "engb" -ln "energyB" -bt "UNKN" -dv 8000 -at "float" 
		-p "energy";
	addAttr -ci true -sn "exp" -ln "exponent" -bt "UNKN" -dv 2 -at "float";
	addAttr -ci true -sn "cph" -ln "causticPhotons" -bt "UNKN" -dv 10000 -at "long";
	addAttr -ci true -sn "gph" -ln "globIllPhotons" -bt "UNKN" -dv 10000 -at "long";
	addAttr -ci true -sn "phy" -ln "physical" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "usm" -ln "shadowMap" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "smr" -ln "smapResolution" -bt "UNKN" -dv 256 -at "long";
	addAttr -ci true -sn "smsa" -ln "smapSamples" -bt "UNKN" -dv 1 -at "short";
	addAttr -ci true -sn "smso" -ln "smapSoftness" -bt "UNKN" -at "float";
	addAttr -ci true -sn "smf" -ln "smapFilename" -bt "UNKN" -dt "string";
	setAttr -k off ".v";
createNode transform -n "rippleCam";
	addAttr -ci true -h true -sn "dfm" -ln "miDeriveFromMaya" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "hde" -ln "miHide" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "vsb" -ln "miVisible" -bt "UNKN" -dv 2 -at "short";
	addAttr -ci true -sn "trc" -ln "miTrace" -bt "UNKN" -dv 2 -at "short";
	addAttr -ci true -sn "shd" -ln "miShadow" -bt "UNKN" -dv 2 -at "short";
	addAttr -ci true -sn "cst" -ln "miCaustic" -bt "UNKN" -dv 5 -at "short";
	addAttr -ci true -sn "glb" -ln "miGlobillum" -bt "UNKN" -dv 5 -at "short";
	addAttr -ci true -sn "mieg" -ln "miExportGeoShader" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "migs" -ln "miGeoShader" -bt "UNKN" -at "message";
	setAttr ".t" -type "double3" 0.35719707259688938 5.3840426088433109 20.463806583692381 ;
	setAttr ".r" -type "double3" -14.738352729602486 1.0000000000000941 -1.2425934254440182e-015 ;
createNode camera -n "rippleCamShape" -p "rippleCam";
	setAttr -k off ".v";
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 21.163243713034277;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".col" -type "float3" 0.51999998 0.74904007 1 ;
createNode animCurveTL -n "PondWakeEmitter1_translateX";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  0 0 10 0;
createNode animCurveTL -n "PondWakeEmitter1_translateY";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  0 12 10 0;
createNode animCurveTU -n "PondWakeEmitter1_rate";
	setAttr ".tan" 2;
	setAttr -s 2 ".ktv[0:1]"  10 10 11 0;
	setAttr -s 2 ".kot[0:1]"  5 5;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode cameraView -n "cameraView1";
	setAttr ".e" -type "double3" 0.35719707259688938 5.3840426088433109 20.463806583692381 ;
	setAttr ".coi" -type "double3" 1.8485213360008856e-014 -3.8191672047105385e-014 
		-1.7763568394002505e-014 ;
	setAttr ".u" -type "double3" -0.0044399857204934614 0.96709767523561518 
		-0.25436661156816626 ;
	setAttr ".fl" 34.999999999999993;
	setAttr ".d" -type "string" "rippleShot";
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 18;
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
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".outf" 3;
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 483;
	setAttr ".rght" 717;
	setAttr ".an" yes;
	setAttr ".fs" 1;
	setAttr ".ef" 80;
	setAttr ".oft" -type "string" "";
	setAttr ".pff" yes;
	setAttr ".ifp" -type "string" "ripple";
	setAttr -k on ".mbf";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultRenderQuality;
	setAttr ".eaa" 0;
select -ne :defaultResolution;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
select -ne :defaultLightSet;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr ":time1.o" "PondShape1.cti";
connectAttr "PondWakeEmitter1.ef" "PondShape1.eml[0].emfr";
connectAttr "PondWakeEmitter1.efc" "PondShape1.fce[0]";
connectAttr ":time1.o" "PondWakeEmitter1.ct";
connectAttr "PondShape1.ifl" "PondWakeEmitter1.full[0]";
connectAttr "PondShape1.ots" "PondWakeEmitter1.dt[0]";
connectAttr "PondShape1.inh" "PondWakeEmitter1.inh[0]";
connectAttr "PondShape1.sti" "PondWakeEmitter1.stt[0]";
connectAttr "PondShape1.sd[0]" "PondWakeEmitter1.sd[0]";
connectAttr "PondWakeEmitter1_translateX.o" "PondWakeEmitter1.tx";
connectAttr "PondWakeEmitter1_translateY.o" "PondWakeEmitter1.ty";
connectAttr "PondWakeEmitter1_rate.o" "PondWakeEmitter1.rat";
connectAttr "cameraView1.msg" "rippleCamShape.b" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "PondShape1.ocl" "fluidShape1SG.vs";
connectAttr "PondShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "PondShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "defaultLightShape.ltd" ":lightList1.l" -na;
connectAttr "defaultLightShape.iog" ":defaultLightSet.dsm" -na;
// End of ripple.ma
