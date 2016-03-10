//Maya ASCII 4.5 scene
//Name: Swirl.ma
//Last modified: Thu, Jul 25, 2002 11:44:57 AM
requires maya "4.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "/usr/alias_cuts/maya_main_irix_r+d/bin/maya.bin";
fileInfo "product" "Maya Unlimited 4.5";
fileInfo "version" "4.5CG";
fileInfo "cutIdentifier" "200207240603";
fileInfo "osv" "IRIX64 6.5 04151556 IP30";
createNode fluidEmitter -n "fluidEmitter1";
	setAttr ".t" -type "double3" 0 -3.5885433942627203 0 ;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".max" 0.4958;
	setAttr ".fhe" 1;
	setAttr ".ffe" 1;
createNode transform -n "fluid1";
createNode fluidShape -n "fluidShape1" -p "fluid1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".is2" yes;
	setAttr ".rw" 60;
	setAttr ".rh" 60;
	setAttr ".rd" 1;
	setAttr ".dw" 10;
	setAttr ".dh" 10;
	setAttr ".dd" 1;
	setAttr ".scd" 0;
	setAttr ".ssd" 1;
	setAttr ".hss" no;
	setAttr ".dsc" 1.3884400129318237;
	setAttr ".vsw" 10;
	setAttr ".e2w" -type "matrix" 0.99994516372680664 -2.7105054312137611e-20 0.010471784509718418 0
		 -0.00037672001053579152 0.99935269355773926 0.035972796380519867 0 -0.010465005412697792 -0.035974767059087753 0.99929791688919067 0
		 0.17157243192195892 -0.85494589805603027 6.6516499519348145 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 0.11900002 0.35246494 1 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".coi" 5;
	setAttr -s 2 ".opa[0:1]"  0 0 1 1 1 1;
	setAttr ".t" -type "float3" 0.10744 0.10744 0.10744 ;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0.0071428571827709675;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.82142859697341919;
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
		+ "To show the effect of the swirl parameter on producing eddies in fluid simulations.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "This is a dynamic simulation of a 2 dimensional fluid. Both density and velocity are set to dynamic in Contents Method. The other salient point is that swirl is set to 10 in Contents Details > Velocity. Just press the play button below to run the simulation.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Swirl adds eddies to the dynamic simulation, giving it a more interesting, and more realistic appearance. This 2D fluid, simulates and renders quickly. Try changing the swirl parameter as it plays to see its effects. You may also try setting Container Properties > Boundary X, Y and Z to none to get rid of the effect of the fluid colliding with the sides to see just the swirl in action. This is different from adding turbulence.");
createNode transform -n "SwirlCam";
	setAttr ".t" -type "double3" 1.8610081183788674 -0.54970921487870217 15.156694821351097 ;
	setAttr ".r" -type "double3" 2.0616472703976143 6.9999999999999574 -5.0069376437244222e-17 ;
createNode camera -n "SwirlCamShape" -p "SwirlCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 15.280409986160857;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lightLinker -n "lightLinker1";
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
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
connectAttr ":time1.o" "fluidEmitter1.ct";
connectAttr "fluidShape1.ifl" "fluidEmitter1.full[0]";
connectAttr "fluidShape1.ots" "fluidEmitter1.dt[0]";
connectAttr "fluidShape1.inh" "fluidEmitter1.inh[0]";
connectAttr "fluidShape1.sti" "fluidEmitter1.stt[0]";
connectAttr "fluidShape1.sd[0]" "fluidEmitter1.sd[0]";
connectAttr ":time1.o" "fluidShape1.cti";
connectAttr "fluidEmitter1.ef" "fluidShape1.eml[0].emfr";
connectAttr "fluidEmitter1.efc" "fluidShape1.fce[0]";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "fluidShape1.ocl" "fluidShape1SG.vs";
connectAttr "fluidShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of Swirl.ma
