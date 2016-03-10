//Maya ASCII 2016ff01 scene
//Name: arrow4way_ctrl.ma
//Last modified: Thu, Jun 12, 2014 11:12:14 AM
//Codeset: 1252
requires maya "2016ff01";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2016";
fileInfo "version" "Preview Release 42";
fileInfo "cutIdentifier" "201406040300-918499";
fileInfo "osv" "Microsoft Windows 7 Enterprise Edition, 64-bit Windows 7 Service Pack 1 (Build 7601)\n";
createNode transform -n "arrow4way_ctrl";
	rename -uid "B9B56BB7-4696-67C8-796E-6BAAEBAEA096";
	setAttr ".s" -type "double3" 0.58618913119794092 0.58618913119794092 0.58618913119794092 ;
createNode nurbsCurve -n "arrow4way_ctrlShape" -p "arrow4way_ctrl";
	rename -uid "8565BA66-4926-DEFE-D03B-E3A406F29876";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 24 0 no 3
		25 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
		25
		-0.54431204855699611 3 0
		-0.54431204855699611 0.46482326006361535 0
		-3 0.46482326006361535 0
		-3 2 0
		-5 0 0
		-3 -2 0
		-3 -0.46482326006361535 0
		-0.54431204855699611 -0.46482326006361535 0
		-0.54431204855699611 -3 0
		-2 -3 0
		0 -5 0
		2 -3 0
		0.54431204855699611 -3 0
		0.54431204855699611 -0.46482326006361535 0
		3 -0.46482326006361535 0
		3 -2 0
		5 0 0
		3 2 0
		3 0.46482326006361535 0
		0.54431204855699611 0.46482326006361535 0
		0.54431204855699611 3 0
		2 3 0
		0 5 0
		-2 3 0
		-0.54431204855699611 3 0
		;
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultColorMgtGlobals;
	setAttr ".vtn" -type "string" "sRGB gamma";
	setAttr ".wsn" -type "string" "scene-linear Rec 709/sRGB";
	setAttr ".din" -type "string" "sRGB";
	setAttr ".otn" -type "string" "sRGB gamma";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
select -ne :nle1;
	setAttr ".time" 1;
// End of arrow4way_ctrl.ma
