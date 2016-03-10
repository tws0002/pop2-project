//Maya ASCII 8.5 scene
//Name: itsSlinky.ma
//Last modified: Thu, Apr 05, 2007 03:32:17 PM
//Codeset: 1252
requires maya "8.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 8.5";
fileInfo "version" "8.5P04";
fileInfo "cutIdentifier" "200703092011-000000";
fileInfo "osv" "Microsoft Windows XP Service Pack 2 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".rp" -type "double3" 2.2026824808563106e-013 -5.3290705182007514e-015 
		1.0302869668521453e-013 ;
	setAttr ".rpt" -type "double3" -3.8190717699997149e-016 2.416303449782779e-014 -6.2898262484024878e-015 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999986;
	setAttr ".coi" 51.314450714054736;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" 4.5087996632443055 7.7209500197562608 0 ;
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
	setAttr ".ow" 4.1991924629878854;
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
	setAttr ".ow" 3.1090174966352624;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "nurbsCylinder1";
createNode nurbsSurface -n "nurbsCylinderShape1" -p "nurbsCylinder1";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 44 ".cp[11:43]" -type "double3" 0 0.0050247184923049582 -0.0042472174943544161 
		0 1.3631552492898713e-005 -0.0042632402588527766 0 -0.0049974553873190497 -0.0042792630233507989 
		0 -0.0070731155600197437 -0.0042858998697130612 0 -0.0049974553873188832 -0.0042792630233507989 
		0 1.3631552492898713e-005 -0.0042632402588527775 0 0.0050247184923052357 -0.0042472174943544161 
		0 0.0071003786650056522 -0.0042405806479923758 0 0 0 0 0 0 0 0 0 0 0.0050110869398118929 
		1.6022764498302422e-005 0 0 0 1.1102230246251565e-016 -0.0050110869398118929 -1.60227644981914e-005 
		1.9081958235744878e-016 -0.0070867471125127812 -2.2659610860120694e-005 4.4408920985006262e-016 
		-0.0050110869398118929 -1.60227644981914e-005 0 -1.1102230246251565e-016 0 0 0.0050110869398118929 
		1.6022764498302422e-005 -6.591949208711867e-017 0.0070867471125128367 2.2659610860342738e-005 
		0 0 0 0 0 0 0 0 0 1.1102230246251565e-016 0.0049974553873192162 0.0042792630233510209 
		1.1102230246251565e-016 -1.3631552492454624e-005 0.0042632402588527775 -1.1102230246251565e-016 
		-0.0050247184923052357 0.0042472174943544161 1.1102230246251565e-016 -0.0071003786650056799 
		0.0042405806479930419 2.2204460492503131e-016 -0.0050247184923051247 0.0042472174943544161 
		-8.8817841970012523e-016 -1.3631552492787691e-005 0.0042632402588527792 -2.2204460492503131e-016 
		0.0049974553873193273 0.0042792630233510209 -5.5511151231257827e-017 0.0070731155600201046 
		0.0042858998697135053 0 0 0 0 0 0 0 0 0;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "curve1" -p "nurbsCylinderShape1";
createNode nurbsCurve -n "curveShape1" -p "curve1";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 1 0 no 2
		2 0 1
		2
		0 0
		2 300
		;
createNode transform -n "duplicatedCurve1";
	setAttr ".s" -type "double3" 1.2187173563878959 1 1.2187173563878959 ;
createNode nurbsCurve -n "duplicatedCurveShape1" -p "duplicatedCurve1";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "duplicatedCurve2";
createNode nurbsCurve -n "duplicatedCurveShape2" -p "duplicatedCurve2";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "loftedSurface1";
	setAttr ".t" -type "double3" 0 1.2449618579754782 0 ;
createNode nurbsSurface -n "loftedSurfaceShape1" -p "loftedSurface1";
	setAttr -k off ".v" no;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 12;
createNode transform -n "nurbsToPoly1";
	setAttr ".t" -type "double3" 2.8256737345334639 9.9882235362769833 -0.010855312696417485 ;
	setAttr ".r" -type "double3" 0 0 -90 ;
createNode mesh -n "nurbsToPolyShape1" -p "nurbsToPoly1";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".bw" 3;
createNode mesh -n "outputCloth1" -p "nurbsToPoly1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".bw" 3;
	setAttr ".qsp" 0;
createNode transform -n "nCloth1";
	setAttr -l on ".t";
	setAttr -l on ".r";
	setAttr -l on ".s";
createNode nCloth -n "nClothShape1" -p "nCloth1";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 828;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -k off ".dve";
	setAttr -k off ".lfm";
	setAttr -k off ".lfr";
	setAttr -k off ".ead";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr -k off ".isd";
	setAttr -k off ".dw";
	setAttr -k off ".fiw";
	setAttr -k off ".con";
	setAttr -k off ".eiw";
	setAttr -k off ".mxc";
	setAttr -k off ".lod";
	setAttr -k off ".inh";
	setAttr ".cts" 1;
	setAttr -k off ".stf";
	setAttr -k off ".igs";
	setAttr -k off ".ecfh";
	setAttr -k off ".tgs";
	setAttr -k off ".gsm";
	setAttr -k off ".chd";
	setAttr ".chw" 400;
	setAttr -k off ".trd";
	setAttr -k off ".prt";
	setAttr ".thss" 0.027957413345575333;
	setAttr ".boce" 0.56199997663497925;
	setAttr ".fron" 0.14878000319004059;
	setAttr ".scfl" 4;
	setAttr ".msci" 13;
	setAttr ".mxit" 20000;
	setAttr ".pmss" 10;
	setAttr ".por" 0.11182965338230133;
	setAttr ".lsou" yes;
	setAttr ".stch" 3000;
	setAttr ".comr" 3000;
	setAttr ".bnd" 500;
	setAttr ".shr" 1000;
	setAttr -k on ".lifespan" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
createNode transform -n "pPlane1";
	setAttr ".s" -type "double3" 29.184604002859711 16.448799600368428 11.948303094738064 ;
createNode mesh -n "pPlaneShape1" -p "pPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 6 ".pt";
	setAttr ".pt[0:2]" -type "float3" 0.019120378 0.20008039 0  0 0.048079249 
		0  0 0.035598412 0 ;
	setAttr ".pt[9:11]" -type "float3" 0.019120378 0.20008039 0  0 0.048079249 
		0  0 0.035598412 0 ;
	setAttr ".qsp" 0;
createNode mesh -n "polySurfaceShape1" -p "pPlane1";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 18 ".uvst[0].uvsp[0:17]" -type "float2" 0 0 0.125 0 0.25 
		0 0.375 0 0.5 0 0.625 0 0.75 0 0.875 0 1 0 0 1 0.125 1 0.25 1 0.375 1 0.5 1 0.625 
		1 0.75 1 0.875 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 44 ".pt";
	setAttr ".pt[0:19]" -type "float3" 0.27693203 0.55668932 0  0.51463258 
		0.42191339 0  0.39594778 0.4336569 0  0.27693245 0.36453253 0  0.26280287 0.36170691 
		0  0.14129183 0.24302191 0  0.12716259 0.24019605 0  0.0028258013 0.12151086 0  -0.0056516724 
		0.12151089 0  0.27693203 0.55668932 0  0.51463246 0.42191336 0  0.39594778 0.4336569 
		0  0.2769323 0.36453256 0  0.26280287 0.36170697 0  0.14129183 0.24302191 0  0.12716259 
		0.24019599 0  0.0028258013 0.12151086 0  -0.0056516724 0.12151089 0  0 -5.9604645e-008 
		0  0 -5.9604645e-008 0 ;
	setAttr ".pt[21:26]" -type "float3" 0 -5.9604645e-008 0  0 -5.9604645e-008 
		0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 
		0 ;
	setAttr ".pt[28:33]" -type "float3" 0 -5.9604645e-008 0  0 -5.9604645e-008 
		0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 
		0 ;
	setAttr ".pt[35:40]" -type "float3" 0 -5.9604645e-008 0  0 -5.9604645e-008 
		0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 
		0 ;
	setAttr ".pt[42:47]" -type "float3" 0 -5.9604645e-008 0  0 -5.9604645e-008 
		0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 0  0 -5.9604645e-008 
		0 ;
	setAttr -s 18 ".vt[0:17]"  -0.5 -1.110223e-016 0.5 -0.375 -1.110223e-016 
		0.5 -0.25 -1.110223e-016 0.5 -0.125 -1.110223e-016 0.5 0 -1.110223e-016 0.5 0.125 
		-1.110223e-016 0.5 0.25 -1.110223e-016 0.5 0.375 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 -0.375 1.110223e-016 -0.5 -0.25 1.110223e-016 -0.5 -0.125 
		1.110223e-016 -0.5 0 1.110223e-016 -0.5 0.125 1.110223e-016 -0.5 0.25 1.110223e-016 
		-0.5 0.375 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 25 ".ed[0:24]"  0 1 0 0 9 0 
		1 2 0 1 10 1 2 3 0 2 11 1 
		3 4 0 3 12 1 4 5 0 4 13 1 
		5 6 0 5 14 1 6 7 0 6 15 1 
		7 8 0 7 16 1 8 17 0 9 10 0 
		10 11 0 11 12 0 12 13 0 13 14 0 
		14 15 0 15 16 0 16 17 0;
	setAttr -s 8 ".fc[0:7]" -type "polyFaces" 
		f 4 0 3 -18 -2 
		mu 0 4 0 1 10 9 
		f 4 2 5 -19 -4 
		mu 0 4 1 2 11 10 
		f 4 4 7 -20 -6 
		mu 0 4 2 3 12 11 
		f 4 6 9 -21 -8 
		mu 0 4 3 4 13 12 
		f 4 8 11 -22 -10 
		mu 0 4 4 5 14 13 
		f 4 10 13 -23 -12 
		mu 0 4 5 6 15 14 
		f 4 12 15 -24 -14 
		mu 0 4 6 7 16 15 
		f 4 14 16 -25 -16 
		mu 0 4 7 8 17 16 ;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".qsp" 0;
createNode transform -n "nRigid1";
	setAttr -l on ".t";
	setAttr -l on ".r";
	setAttr -l on ".s";
createNode nRigid -n "nRigidShape1" -p "nRigid1";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 54;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -k off ".dve";
	setAttr -k off ".lfm";
	setAttr -k off ".lfr";
	setAttr -k off ".ead";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr -k off ".isd";
	setAttr -k off ".dw";
	setAttr -k off ".fiw";
	setAttr -k off ".con";
	setAttr -k off ".eiw";
	setAttr -k off ".mxc";
	setAttr -k off ".lod";
	setAttr -k off ".inh";
	setAttr ".cts" 1;
	setAttr -k off ".stf";
	setAttr -k off ".igs";
	setAttr -k off ".ecfh";
	setAttr -k off ".tgs";
	setAttr -k off ".gsm";
	setAttr -k off ".chd";
	setAttr ".chw" 400;
	setAttr -k off ".trd";
	setAttr -k off ".prt";
	setAttr ".thss" 0.11004997044801712;
	setAttr ".fron" 0.87602001428604126;
	setAttr ".actv" no;
	setAttr ".scld" no;
	setAttr ".por" 0.44019988179206848;
	setAttr -k on ".lifespan" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
createNode transform -n "pCylinder1";
	setAttr ".t" -type "double3" 3.8835298090564203 7.7209500495585832 0 ;
	setAttr ".r" -type "double3" 90 0 0 ;
createNode mesh -n "pCylinderShape1" -p "pCylinder1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".qsp" 0;
createNode transform -n "nRigid2";
	setAttr -l on ".t";
	setAttr -l on ".r";
	setAttr -l on ".s";
createNode nRigid -n "nRigidShape2" -p "nRigid2";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 90;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -k off ".dve";
	setAttr -k off ".lfm";
	setAttr -k off ".lfr";
	setAttr -k off ".ead";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr -k off ".isd";
	setAttr -k off ".dw";
	setAttr -k off ".fiw";
	setAttr -k off ".con";
	setAttr -k off ".eiw";
	setAttr -k off ".mxc";
	setAttr -k off ".lod";
	setAttr -k off ".inh";
	setAttr ".cts" 1;
	setAttr -k off ".stf";
	setAttr -k off ".igs";
	setAttr -k off ".ecfh";
	setAttr -k off ".tgs";
	setAttr -k off ".gsm";
	setAttr -k off ".chd";
	setAttr ".chw" 400;
	setAttr -k off ".trd";
	setAttr -k off ".prt";
	setAttr ".thss" 0.021170312538743019;
	setAttr ".fron" 1;
	setAttr ".actv" no;
	setAttr ".scld" no;
	setAttr ".por" 0.084681250154972076;
	setAttr -k on ".lifespan" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
createNode transform -n "spotLight1";
	setAttr ".t" -type "double3" -8.1993936271995693 39.475203321883363 -3.8221647453894008 ;
	setAttr ".r" -type "double3" -254.73388647373602 -82.726059327716428 -180 ;
createNode spotLight -n "spotLightShape1" -p "spotLight1";
	setAttr -k off ".v";
	setAttr ".in" 27.767999649047852;
	setAttr ".urs" yes;
	setAttr ".shr" 10;
	setAttr ".rdl" 2;
	setAttr ".col" 43.398398341204121;
	setAttr ".de" 1;
	setAttr ".lr" 4;
	setAttr ".ca" 83.306729577951316;
	setAttr ".pa" -10;
	setAttr ".dro" 2.108;
createNode transform -n "pPlane2";
	setAttr ".s" -type "double3" 221.11844960718935 221.11844960718935 221.11844960718935 ;
createNode mesh -n "pPlaneShape2" -p "pPlane2";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "spotLight2";
	setAttr ".t" -type "double3" 38.269697896060535 27.696498934644708 -44.948201000729185 ;
	setAttr ".r" -type "double3" 146.88427889277153 33.695557089906622 180 ;
createNode spotLight -n "spotLightShape2" -p "spotLight2";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.59684002 0.69400001 0.6808672 ;
	setAttr ".in" 80;
	setAttr ".urs" yes;
	setAttr ".shr" 10;
	setAttr ".rdl" 2;
	setAttr ".col" 26.77950708759893;
	setAttr ".de" 1;
	setAttr ".lr" 5;
	setAttr ".ca" 72.893729577951319;
	setAttr ".pa" -7.8512000000000013;
	setAttr ".dro" 10.536;
createNode transform -n "spotLight3";
	setAttr ".t" -type "double3" 5.2482541328227352 39.424942988604286 41.72197882023378 ;
	setAttr ".r" -type "double3" -44.793091308345772 -5.772606025982701 1.2347507759895388e-013 ;
createNode spotLight -n "spotLightShape3" -p "spotLight3";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.81299996 0.8342557 1 ;
	setAttr ".in" 0.49579998850822449;
	setAttr ".urs" yes;
	setAttr ".col" 55.239019244289715;
	setAttr ".lr" 5;
	setAttr ".pa" -10;
createNode transform -n "pPlane3";
	setAttr ".t" -type "double3" 0 44.764570468877409 0 ;
	setAttr ".s" -type "double3" 22.828948152296491 22.828948152296491 22.828948152296491 ;
createNode mesh -n "pPlaneShape3" -p "pPlane3";
	setAttr -k off ".v";
	setAttr ".mb" no;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".csh" no;
	setAttr ".rcsh" no;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "pPlane4";
	setAttr ".t" -type "double3" -2.805630299968584 43.369492569273355 51.791217043547938 ;
	setAttr ".s" -type "double3" 22.828948152296491 22.828948152296491 22.828948152296491 ;
createNode mesh -n "pPlaneShape4" -p "pPlane4";
	setAttr -k off ".v";
	setAttr ".mb" no;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".csh" no;
	setAttr ".rcsh" no;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 0 
		1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
createNode transform -n "pPlane5";
	setAttr ".t" -type "double3" 49.078655015914784 43.369492569273355 -35.763997490831073 ;
	setAttr ".s" -type "double3" 46.538339664492057 46.538339664492057 83.309888261862881 ;
createNode mesh -n "pPlaneShape5" -p "pPlane5";
	setAttr -k off ".v";
	setAttr ".mb" no;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".csh" no;
	setAttr ".rcsh" no;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 0 
		1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
createNode lightLinker -n "lightLinker1";
	setAttr -s 6 ".lnk";
	setAttr -s 6 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode makeNurbCylinder -n "makeNurbCylinder1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode curveFromSurfaceCoS -n "curveFromSurfaceCoS1";
	setAttr ".ihi" 1;
	setAttr ".min" 0;
	setAttr ".max" 1;
	setAttr ".r" yes;
createNode curveFromSurfaceCoS -n "curveFromSurfaceCoS2";
	setAttr ".ihi" 1;
	setAttr ".min" 0;
	setAttr ".max" 1;
	setAttr ".r" yes;
createNode loft -n "loft1";
	setAttr -s 2 ".ic";
	setAttr ".u" yes;
	setAttr ".rsn" yes;
createNode blinn -n "blinn1";
	addAttr -ci true -sn "mircl" -ln "miReflectionBlurLimit" -dv 1 -min 0 -smx 10 -at "short";
	addAttr -ci true -sn "mirfl" -ln "miRefractionBlurLimit" -dv 1 -min 0 -smx 10 -at "short";
	addAttr -ci true -sn "miibr" -ln "miScatterRadius" -min 0 -smx 10 -at "float";
	addAttr -ci true -uac -sn "miibc" -ln "miScatterColor" -at "float3" -nc 3;
	addAttr -ci true -sn "miibcr" -ln "miScatterColorR" -dv 0.5 -at "float" -p "miScatterColor";
	addAttr -ci true -sn "miibcg" -ln "miScatterColorG" -dv 0.5 -at "float" -p "miScatterColor";
	addAttr -ci true -sn "miibcb" -ln "miScatterColorB" -dv 0.5 -at "float" -p "miScatterColor";
	addAttr -ci true -sn "miiba" -ln "miScatterAccuracy" -dv 97 -min 0 -smx 256 -at "short";
	addAttr -ci true -sn "miibf" -ln "miScatterFalloff" -min 0 -max 3 -en "None:Linear:Quadratic:Exponential" 
		-at "enum";
	addAttr -ci true -sn "miibl" -ln "miScatterLimit" -dv 1 -min 0 -smx 10 -at "short";
	addAttr -ci true -sn "miibx" -ln "miScatterCache" -at "short";
	setAttr ".dc" 0.92562001943588257;
	setAttr ".fll" 2;
	setAttr ".sc" -type "float3" 1 1 1 ;
	setAttr ".rfl" 0.80992001295089722;
	setAttr ".ec" 0.42969998717308044;
	setAttr ".sro" 1;
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 400 -ast 1 -aet 630 ";
	setAttr ".st" 6;
createNode ramp -n "ramp1";
	setAttr ".t" 4;
	setAttr -s 4 ".cel";
	setAttr ".cel[0].ep" 0.014999999664723873;
	setAttr ".cel[0].ec" -type "float3" 0.77481645 0.7885049 0.81818002 ;
	setAttr ".cel[1].ep" 0.99000000953674316;
	setAttr ".cel[1].ec" -type "float3" 0.75917202 0.77258426 0.80166 ;
	setAttr ".cel[2].ep" 0.70499998331069946;
	setAttr ".cel[2].ec" -type "float3" 0.73553997 0.73553997 0.73553997 ;
	setAttr ".cel[3].ep" 0.15000000596046448;
	setAttr ".cel[3].ec" -type "float3" 0.61829537 0.62921745 0.65289998 ;
createNode place2dTexture -n "place2dTexture1";
createNode nurbsTessellate -n "nurbsTessellate1";
	setAttr ".f" 2;
	setAttr ".pt" 1;
	setAttr ".chr" 0.9;
	setAttr ".ut" 1;
	setAttr ".un" 414;
	setAttr ".vt" 1;
	setAttr ".vn" 1;
	setAttr ".ucr" no;
	setAttr ".cht" 0.01;
	setAttr ".mnd" yes;
	setAttr ".ntr" no;
createNode nucleus -n "nucleus1";
	setAttr -s 2 ".nipo";
	setAttr -s 2 ".nips";
	setAttr ".nupl" yes;
	setAttr ".npfr" 0.87602001428604126;
	setAttr ".sstp" 20;
	setAttr ".mcit" 20;
	setAttr ".spsc" 0.40000000596046448;
createNode polySoftEdge -n "polySoftEdge1";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 1 "e[*]";
	setAttr ".ix" -type "matrix" 21.432097287352569 0 0 0 0 21.432097287352569 0 0 0 0 21.432097287352569 0
		 0 0 0 1;
	setAttr ".a" 0;
createNode polyCylinder -n "polyCylinder1";
	setAttr ".sa" 15;
	setAttr ".cuv" 3;
createNode polySmoothFace -n "polySmoothFace1";
	setAttr ".ics" -type "componentList" 1 "f[*]";
	setAttr ".suv" yes;
	setAttr ".kb" no;
	setAttr ".ps" 0.10000000149011612;
	setAttr ".ro" 1;
	setAttr ".ma" yes;
createNode polyExtrudeFace -n "polyExtrudeFace1";
	setAttr ".ics" -type "componentList" 1 "f[0:1651]";
	setAttr ".ix" -type "matrix" 2.2204460492503131e-016 -1 0 0 1 2.2204460492503131e-016 0 0
		 0 0 1 0 2.8256737345334639 9.9882235362769833 -0.010855312696417485 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" 4.0706286 9.988225 -0.011523421 ;
	setAttr ".rs" 41738;
	setAttr ".lt" -type "double3" 2.5725407047649806e-016 2.193449415155424e-015 0.029 ;
	setAttr ".c[0]"  0 1 1;
createNode polyPlane -n "polyPlane1";
	setAttr ".sw" 6;
	setAttr ".sh" 6;
	setAttr ".cuv" 2;
createNode lambert -n "lambert2";
	setAttr ".c" -type "float3" 0.20307909 0.37189999 0.1952475 ;
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode polyPlane -n "polyPlane2";
	setAttr ".sw" 1;
	setAttr ".sh" 1;
	setAttr ".cuv" 2;
createNode lambert -n "lambert3";
	setAttr ".ic" -type "float3" 1 1 1 ;
createNode shadingEngine -n "lambert3SG";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode blinn -n "blinn2";
	addAttr -ci true -sn "mircl" -ln "miReflectionBlurLimit" -dv 1 -min 0 -smx 10 -at "short";
	addAttr -ci true -sn "mirfl" -ln "miRefractionBlurLimit" -dv 1 -min 0 -smx 10 -at "short";
	addAttr -ci true -sn "miibr" -ln "miScatterRadius" -min 0 -smx 10 -at "float";
	addAttr -ci true -uac -sn "miibc" -ln "miScatterColor" -at "float3" -nc 3;
	addAttr -ci true -sn "miibcr" -ln "miScatterColorR" -dv 0.5 -at "float" -p "miScatterColor";
	addAttr -ci true -sn "miibcg" -ln "miScatterColorG" -dv 0.5 -at "float" -p "miScatterColor";
	addAttr -ci true -sn "miibcb" -ln "miScatterColorB" -dv 0.5 -at "float" -p "miScatterColor";
	addAttr -ci true -sn "miiba" -ln "miScatterAccuracy" -dv 97 -min 0 -smx 256 -at "short";
	addAttr -ci true -sn "miibf" -ln "miScatterFalloff" -min 0 -max 3 -en "None:Linear:Quadratic:Exponential" 
		-at "enum";
	addAttr -ci true -sn "miibl" -ln "miScatterLimit" -dv 1 -min 0 -smx 10 -at "short";
	addAttr -ci true -sn "miibx" -ln "miScatterCache" -at "short";
	setAttr ".c" -type "float3" 0.70248002 0.70248002 0.70248002 ;
	setAttr ".sc" -type "float3" 0.77686 0.77686 0.77686 ;
	setAttr ".rfl" 0.72728002071380615;
	setAttr ".ec" 0.37185999751091003;
	setAttr ".sro" 0.10745999962091446;
createNode shadingEngine -n "blinn2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode animCurveTU -n "persp_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 0 293 0 400 0;
	setAttr -s 3 ".kot[0:2]"  5 5 5;
createNode animCurveTL -n "persp_translateX";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 10.812181577784871 293 26.882810708352164 
		400 30.554042999179241;
	setAttr -s 3 ".kit[1:2]"  10 3;
	setAttr -s 3 ".kot[1:2]"  10 10;
createNode animCurveTL -n "persp_translateY";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 12.212605793029629 293 8.6293874714426373 
		400 4.3287734992154689;
	setAttr -s 3 ".kit[1:2]"  10 3;
	setAttr -s 3 ".kot[1:2]"  10 10;
createNode animCurveTL -n "persp_translateZ";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 9.6829073093809477 293 16.222579545207616 
		400 0.83563085159433259;
	setAttr -s 3 ".kit[1:2]"  10 3;
	setAttr -s 3 ".kot[1:2]"  10 10;
createNode animCurveTA -n "persp_rotateX";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 -20.138352729604382 293 -20.138352729604382 
		400 -16.995095040184616;
createNode animCurveTA -n "persp_rotateY";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 27.800000000005731 293 27.800000000005731 
		400 2.1663450661784558;
createNode animCurveTA -n "persp_rotateZ";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 0 293 -8.9888737452507948e-016 400 -0.01930176377034178;
createNode animCurveTU -n "persp_scaleX";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 1 293 1 400 1;
createNode animCurveTU -n "persp_scaleY";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 1 293 1 400 1;
createNode animCurveTU -n "persp_scaleZ";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  84 1 293 1 400 1;
select -ne :time1;
	setAttr ".ihi" 0;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 6 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultRenderQuality;
	setAttr ".ert" yes;
select -ne :defaultShaderList1;
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
select -ne :lightList1;
	setAttr -s 3 ".l";
select -ne :defaultTextureList1;
select -ne :lambert1;
	setAttr ".c" -type "float3" 0.64462 0.29583278 0.29201287 ;
select -ne :initialShadingGroup;
	setAttr -k on ".cch";
	setAttr -k on ".nds";
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr -k on ".cch";
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr ".an" yes;
	setAttr ".ef" 400;
	setAttr ".ofc" 1;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
	setAttr -s 3 ".dsm";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
select -ne :ikSystem;
	setAttr -s 4 ".sol";
connectAttr "persp_visibility.o" ":persp.v";
connectAttr "persp_translateX.o" ":persp.tx";
connectAttr "persp_translateY.o" ":persp.ty";
connectAttr "persp_translateZ.o" ":persp.tz";
connectAttr "persp_rotateX.o" ":persp.rx";
connectAttr "persp_rotateY.o" ":persp.ry";
connectAttr "persp_rotateZ.o" ":persp.rz";
connectAttr "persp_scaleX.o" ":persp.sx";
connectAttr "persp_scaleY.o" ":persp.sy";
connectAttr "persp_scaleZ.o" ":persp.sz";
connectAttr "makeNurbCylinder1.os" "nurbsCylinderShape1.cr";
connectAttr "curveFromSurfaceCoS1.oc" "duplicatedCurveShape1.cr";
connectAttr "curveFromSurfaceCoS2.oc" "duplicatedCurveShape2.cr";
connectAttr "loft1.os" "loftedSurfaceShape1.cr";
connectAttr "nurbsTessellate1.op" "nurbsToPolyShape1.i";
connectAttr "polyExtrudeFace1.out" "outputCloth1.i";
connectAttr "nucleus1.stf" "nClothShape1.stf";
connectAttr ":time1.o" "nClothShape1.cti";
connectAttr "nurbsToPolyShape1.w" "nClothShape1.imsh";
connectAttr "nucleus1.noao[0]" "nClothShape1.nxst";
connectAttr "polySoftEdge1.out" "pPlaneShape1.i";
connectAttr "nucleus1.stf" "nRigidShape1.stf";
connectAttr ":time1.o" "nRigidShape1.cti";
connectAttr "pPlaneShape1.w" "nRigidShape1.imsh";
connectAttr "polyCylinder1.out" "pCylinderShape1.i";
connectAttr "nucleus1.stf" "nRigidShape2.stf";
connectAttr ":time1.o" "nRigidShape2.cti";
connectAttr "pCylinderShape1.w" "nRigidShape2.imsh";
connectAttr "polyPlane1.out" "pPlaneShape2.i";
connectAttr "polyPlane2.out" "pPlaneShape3.i";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "lambert2SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "lambert3SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[5].llnk";
connectAttr "blinn2SG.msg" "lightLinker1.lnk[5].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[0].sllk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.slnk[0].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[1].sllk";
connectAttr ":initialParticleSE.msg" "lightLinker1.slnk[1].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[2].sllk";
connectAttr "blinn1SG.msg" "lightLinker1.slnk[2].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[3].sllk";
connectAttr "lambert2SG.msg" "lightLinker1.slnk[3].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[4].sllk";
connectAttr "lambert3SG.msg" "lightLinker1.slnk[4].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[5].sllk";
connectAttr "blinn2SG.msg" "lightLinker1.slnk[5].solk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "nurbsCylinderShape1.ws" "curveFromSurfaceCoS1.is";
connectAttr "curveShape1.ws" "curveFromSurfaceCoS1.cos";
connectAttr "nurbsCylinderShape1.ws" "curveFromSurfaceCoS2.is";
connectAttr "curveShape1.ws" "curveFromSurfaceCoS2.cos";
connectAttr "duplicatedCurveShape2.ws" "loft1.ic[0]";
connectAttr "duplicatedCurveShape1.ws" "loft1.ic[1]";
connectAttr "ramp1.oc" "blinn1.c";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "loftedSurfaceShape1.iog" "blinn1SG.dsm" -na;
connectAttr "nurbsToPolyShape1.iog" "blinn1SG.dsm" -na;
connectAttr "outputCloth1.iog" "blinn1SG.dsm" -na;
connectAttr "blinn1SG.msg" "materialInfo1.sg";
connectAttr "blinn1.msg" "materialInfo1.m";
connectAttr "ramp1.msg" "materialInfo1.t" -na;
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "loftedSurfaceShape1.ws" "nurbsTessellate1.is";
connectAttr ":time1.o" "nucleus1.cti";
connectAttr "nClothShape1.cust" "nucleus1.niao[0]";
connectAttr "nClothShape1.stst" "nucleus1.nias[0]";
connectAttr "nRigidShape1.cust" "nucleus1.nipo[0]";
connectAttr "nRigidShape2.cust" "nucleus1.nipo[1]";
connectAttr "nRigidShape1.stst" "nucleus1.nips[0]";
connectAttr "nRigidShape2.stst" "nucleus1.nips[1]";
connectAttr "polySurfaceShape1.o" "polySoftEdge1.ip";
connectAttr "pPlaneShape1.wm" "polySoftEdge1.mp";
connectAttr "nClothShape1.omsh" "polySmoothFace1.ip";
connectAttr "polySmoothFace1.out" "polyExtrudeFace1.ip";
connectAttr "outputCloth1.wm" "polyExtrudeFace1.mp";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "pPlaneShape2.iog" "lambert2SG.dsm" -na;
connectAttr "lambert2SG.msg" "materialInfo2.sg";
connectAttr "lambert2.msg" "materialInfo2.m";
connectAttr "lambert3.oc" "lambert3SG.ss";
connectAttr "pPlaneShape3.iog" "lambert3SG.dsm" -na;
connectAttr "pPlaneShape4.iog" "lambert3SG.dsm" -na;
connectAttr "pPlaneShape5.iog" "lambert3SG.dsm" -na;
connectAttr "lambert3SG.msg" "materialInfo3.sg";
connectAttr "lambert3.msg" "materialInfo3.m";
connectAttr "blinn2.oc" "blinn2SG.ss";
connectAttr "pPlaneShape1.iog" "blinn2SG.dsm" -na;
connectAttr "blinn2SG.msg" "materialInfo4.sg";
connectAttr "blinn2.msg" "materialInfo4.m";
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "lambert3SG.pa" ":renderPartition.st" -na;
connectAttr "blinn2SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn2.msg" ":defaultShaderList1.s" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "spotLightShape1.ltd" ":lightList1.l" -na;
connectAttr "spotLightShape2.ltd" ":lightList1.l" -na;
connectAttr "spotLightShape3.ltd" ":lightList1.l" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "nurbsCylinderShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pCylinderShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "spotLight1.iog" ":defaultLightSet.dsm" -na;
connectAttr "spotLight2.iog" ":defaultLightSet.dsm" -na;
connectAttr "spotLight3.iog" ":defaultLightSet.dsm" -na;

webTutorialNotify "http://area.autodesk.com/blogs/duncan/its_slinky_its_slinky/" "" "";

// End of itsSlinky.ma
