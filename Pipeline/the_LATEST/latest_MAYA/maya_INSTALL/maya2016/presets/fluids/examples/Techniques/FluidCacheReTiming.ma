//Maya ASCII 5.0 scene
//Name: FluidCacheReTiming.ma
//Last modified: Thu, Apr 17, 2003 02:37:54 PM
requires maya "5.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200304040010";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "gunBlast";
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
	setAttr ".t" -type "double3" -4.5400610958407732 3.914679614842429 -14.925723693594215 ;
	setAttr ".rp" -type "double3" -20.25879103091879 -0.003812470486129098 0.019330824464815665 ;
	setAttr ".rpt" -type "double3" 5.0379097428274227 -2.2761287345407166 13.154341524792706 ;
	setAttr ".sp" -type "double3" -27.923336746507243 -0.0052548494654902841 
		0.026644290880677893 ;
	setAttr ".spt" -type "double3" 7.6645457155884538 0.0014423789793611859 
		-0.0073134664158622277 ;
createNode fluidShape -n "gunBlastShape" -p "gunBlast";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 55;
	setAttr ".rh" 16;
	setAttr ".rd" 8;
	setAttr ".dw" 55;
	setAttr ".dh" 16;
	setAttr ".dd" 8;
	setAttr ".vqu" 2;
	setAttr ".sch" 7;
	setAttr ".ssh" 3;
	setAttr ".bod" 4;
	setAttr ".ots" 1;
	setAttr ".dsc" 0.23299999535083771;
	setAttr ".dds" 0.14564000000000002;
	setAttr ".ddf" 0.36892000000000003;
	setAttr ".dsb" 0;
	setAttr ".grv" 0;
	setAttr ".viy" 0.02913999930024147;
	setAttr ".fri" 0.019419999793171883;
	setAttr ".vsw" 10;
	setAttr ".tmet" 2;
	setAttr ".ss" yes;
	setAttr ".rin" 3;
	setAttr -s 5 ".cl";
	setAttr ".cl[0].clp" 0.81428569555282593;
	setAttr ".cl[0].clc" -type "float3" 1 0.92511195 0.11199999 ;
	setAttr ".cl[0].cli" 2;
	setAttr ".cl[1].clp" 0;
	setAttr ".cl[1].clc" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 0.6071428656578064;
	setAttr ".cl[2].clc" -type "float3" 1 0.43795079 0.14300001 ;
	setAttr ".cl[2].cli" 2;
	setAttr ".cl[3].clp" 0.3571428656578064;
	setAttr ".cl[3].clc" -type "float3" 0.745 0.69881004 0.69881004 ;
	setAttr ".cl[3].cli" 2;
	setAttr ".cl[4].clp" 1;
	setAttr ".cl[4].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[4].cli" 2;
	setAttr ".coi" 5;
	setAttr -s 3 ".opa[0:2]"  0.071428575 0 3 1 1 3 0.22857143 
		0.47999999 3;
	setAttr ".t" -type "float3" 0.40496001 0.40496001 0.40496001 ;
	setAttr -s 5 ".i";
	setAttr ".i[0].ip" 0.61428570747375488;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.77142858505249023;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 0 0 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".i[3].ip" 0.86428570747375488;
	setAttr ".i[3].ic" -type "float3" 1.425 0.89999998 0 ;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ip" 0.67142856121063232;
	setAttr ".i[4].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[4].ii" 1;
	setAttr ".ili" 0;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 2;
	setAttr ".ctx" yes;
	setAttr ".otx" yes;
	setAttr ".ra" 0.33009999990463257;
	setAttr ".th" 0.36893999576568604;
	setAttr ".dm" 3;
	setAttr ".in" yes;
	setAttr ".cvel" no;
	setAttr ".ctmp" no;
	setAttr ".ccol" no;
	setAttr ".crea" no;
	setAttr ".catc" no;
	setAttr ".nts" -type "string" (
		"Preset Goal:\r\n"
		+ "Changing the timing of a fluid cache.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "This method/script allows you to create a fluid cache at one time range, and play it at another, as well as manipulating time via an animation curve.\r\n"
		+ "\r\n"
		+ "This fluid simulates a gun blast. There are several animated parameters, mainly for shading. There is an existing initial state you can assign called \r\n"
		+ "gunApply.mel. To do this, select the fluid, go to Fluid Effects> Get Fluid Example (or go to visor), and in the tab Fluid Initial States, you will find Miscellaneous> 3D. Drag and drop gunApply.mel onto the fluid. You can now create a playback cache, given the existing settings for the fluid. Creat a cache from frame 1 to frame 45. (Fluid Effects> Create Cache). \r\n"
		+ "\r\n"
		+ "This new cache is the one whose timing we will change. You can also use this cache in the Destroyer.ma preset that uses the same setup for a gun. Just assign the cache to the gun's fluid. First make a dummy cache so that you will have a node in the attribute editor with which you can assign the cache.\r\n"
		+ "\r\n"
		+ "Now to start manipulating the timing of the playback cache. Copy and paste the script below into the script editor making sure that every line in the script editor ends with a semi-colon or a comment. This will avoid syntax errors when the script runs. You could also highlight and drag the script to the shelf, and click on it when you want to run it. The script is also available as a file called fluidCacheAnimCurve.mel.\r\n"
		+ "\r\n"
		+ "//This script creates a timing curve for a\r\n"
		+ "//fluids playback cache.\r\n"
		+ "pickWalk -d down;\r\n"
		+ "string $fluishape[] = `ls -sl`;\r\n"
		+ "CBdeleteConnection ($fluishape[0] + \".currentTime\");\r\n"
		+ "setAttr -keyable 1 ($fluishape[0] + \".currentTime\");\r\n"
		+ "setAttr ($fluishape[0] + \".currentTime\") 1;\r\n"
		+ "setKeyframe -time 1 ($fluishape[0] + \".currentTime\");\r\n"
		+ "setAttr ($fluishape[0] + \".currentTime\") 100;\r\n"
		+ "setKeyframe -time 100 ($fluishape[0] + \".currentTime\");\r\n"
		+ "selectKey -add -k -t 1 -t 100 ($fluishape[0] + \"_\"+\"currentTime\") ; //selects anim curve\r\n"
		+ "setInfinity -poi cycleRelative; //So get normal behaviour after frame 100\r\n"
		+ "//Won't worry about pre frame one since solver by default doesn't solve before then. \r\n"
		+ "animCurveEditor -edit -displayInfinities 1 graphEditor1GraphEd; //show infinity post.\r\n"
		+ "\r\n"
		+ "Now run the script with the fluid selected. If you have the channel box open, you can see the currentTime parameter now exposed, and connected to an animation curve as inidicated by the yellow colour. This is the parameter you can keyframe to change the time that the fluid sees. The script created an animation curve for it. Take a look at it in the Graph Editor. Move the last keyframe to 95 and the first keyframe to 50. We have completed our task.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "The provided script only works on fluids, but a similar technique also works with particle caches. If the animation curve is sinusoidal in shape, you can make the fluid cache cycle back and forth. This is a simple method for easily manipulating cache timing without resimulation. Stretching the cache out too much may give an undesiraable effect.\r\n");
createNode volumeAxisField -n "volumeAxisField2" -p "gunBlast";
	setAttr ".t" -type "double3" -25.765622457766458 -0.95056274381421257 -0.023611185572779192 ;
	setAttr ".r" -type "double3" -89.999999998093401 -89.945328706984753 0.010782401916078875 ;
	setAttr ".s" -type "double3" 1.8087111602427959 5.5027088041368932 1.8087111602427959 ;
	setAttr ".mag" 5000;
	setAttr ".att" 1;
	setAttr -k off ".apv";
	setAttr ".vol" 3;
	setAttr -k off ".vex";
	setAttr ".afa" 0;
	setAttr ".alx" 1;
createNode animCurveTU -n "fluidShape2_glowIntensity";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0.83517441887755028 5 1 24 0.10000000149011612;
	setAttr -s 3 ".kit[0:2]"  10 3 3;
	setAttr -s 3 ".kot[0:2]"  10 3 3;
createNode animCurveTU -n "fluidShape2_colorInputBias";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0.78255999088287354 10 0.78255999088287354 
		33 0.21739999949932098;
	setAttr -s 3 ".kit[2]"  3;
	setAttr -s 3 ".kot[2]"  3;
createNode animCurveTU -n "fluidShape2_opacityInputBias";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  50 0.086999997496604919 70 -0.065200001001358032;
createNode materialInfo -n "head__materialInfo2";
createNode shadingEngine -n "head__fluidShape2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lightLinker -n "lightLinker1";
	setAttr ".ihi" 0;
	setAttr -s 5 ".lnk";
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
	setAttr -k on ".cch";
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr -k on ".cch";
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".outf" 3;
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 483;
	setAttr ".rght" 717;
	setAttr ".an" yes;
	setAttr ".ef" 75;
	setAttr ".oft" -type "string" "";
	setAttr ".pff" yes;
	setAttr -k on ".mbf";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultRenderQuality;
	setAttr ".eaa" 0;
select -ne :defaultResolution;
	setAttr ".w" 720;
	setAttr ".h" 486;
	setAttr ".pa" 0.75;
	setAttr ".al" yes;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
connectAttr ":time1.o" "gunBlastShape.cti";
connectAttr "fluidShape2_glowIntensity.o" "gunBlastShape.gi";
connectAttr "fluidShape2_colorInputBias.o" "gunBlastShape.cib";
connectAttr "fluidShape2_opacityInputBias.o" "gunBlastShape.oib";
connectAttr "volumeAxisField2.of[2]" "gunBlastShape.ifc[0]";
connectAttr "gunBlastShape.fd" "volumeAxisField2.ind[2]";
connectAttr "head__fluidShape2SG.msg" "head__materialInfo2.sg";
connectAttr "gunBlastShape.ocl" "head__fluidShape2SG.vs";
connectAttr "gunBlastShape.iog" "head__fluidShape2SG.dsm" -na;
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[8].llnk";
connectAttr "head__fluidShape2SG.msg" "lightLinker1.lnk[8].olnk";
connectAttr "head__fluidShape2SG.pa" ":renderPartition.st" -na;
connectAttr "gunBlastShape.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of FluidCacheReTiming.ma
