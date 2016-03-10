//Maya ASCII 2016ff01 scene
//Name: square_ctrl.ma
//Last modified: Thu, Jun 12, 2014 11:13:41 AM
//Codeset: 1252
requires maya "2016ff01";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2016";
fileInfo "version" "Preview Release 42";
fileInfo "cutIdentifier" "201406040300-918499";
fileInfo "osv" "Microsoft Windows 7 Enterprise Edition, 64-bit Windows 7 Service Pack 1 (Build 7601)\n";
createNode transform -n "square_ctrl";
	rename -uid "578D9B24-4BBF-826D-0A6F-5980D4B61A0E";
createNode nurbsCurve -n "square_ctrlShape" -p "square_ctrl";
	rename -uid "0359673E-4FFF-B5CD-E759-B58C47FEFF29";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 10 1 no 3
		15 0 0 0 1 1 1 2 2 2 3 3 3 4 4 4
		13
		-0.86019333955922972 0 0.86019333955922972
		-0.86019333955922972 0 0.28673111318640998
		-0.86019333955922972 0 -0.28673111318640998
		-0.86019333955922972 0 -0.86019333955922972
		-0.28673111318640987 0 -0.86019333955922972
		0.28673111318641015 0 -0.86019333955922972
		0.86019333955922972 0 -0.86019333955922972
		0.86019333955923027 0 -0.28673111318640998
		0.86019333955923027 0 0.28673111318640998
		0.86019333955923027 0 0.86019333955922972
		0.28673111318641026 0 0.86019333955922994
		-0.2867311131864097 0 0.86019333955922994
		-0.86019333955922972 0 0.86019333955922994
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
// End of square_ctrl.ma
