//Maya ASCII 7.0ff08 scene
//Name: carrotTop.ma
//Last modified: Tue, May 10, 2005 04:27:22 PM
requires maya "7.0ff08";
requires "ikSpringSolver" "1.0";
requires "ik2Bsolver" "2.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 7.0 Beta";
fileInfo "version" "7.0 Beta 3";
fileInfo "cutIdentifier" "200505052030-000000";
fileInfo "osv" "Microsoft Windows XP Service Pack 1 (Build 2600)\n";
createNode transform -s -n "carrotTopCam";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 10.095419162392455 6.4824604478958596 -12.585958530452382 ;
	setAttr ".r" -type "double3" -21.938352729513859 -222.99999999982083 0 ;
	setAttr ".rp" -type "double3" -4.4408920985006262e-016 -2.2204460492503131e-016 
		8.8817841970012523e-016 ;
	setAttr ".rpt" -type "double3" 9.0162989125623697e-016 2.1408904712137003e-016 2.0652242228148514e-017 ;
createNode camera -s -n "carrotTopCamShape" -p "carrotTopCam";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999986;
	setAttr ".coi" 14.998205306066218;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".col" -type "float3" 0.366 0.50700003 0.62699997 ;
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
createNode transform -n "head1";
	setAttr ".t" -type "double3" 0.99695887480572098 -0.38448707470084242 -2.8501471804444858 ;
	setAttr ".r" -type "double3" 38.660780061285926 296.64078196513873 7.7533134289023762 ;
	setAttr ".s" -type "double3" 1.9519807980110859 1.9519807980110859 1.9519807980110859 ;
createNode nurbsSurface -n "headShape1" -p "head1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 77 ".cp[22:76]" -type "double3" -0.1996581115362262 1.4414371651827427 
		-0.42202955724195068 -0.28867551191034879 0.078118325323644267 -0.095139800060537696 
		0 0 0 0 0 0 -0.12888127981729658 -0.0086264821907124922 0.0013446672477838151 0.33500193772119524 
		0.21897001708015529 -0.02899970450899431 -0.19965811153622637 1.4414371651827427 
		-0.42202955724195068 0 0 0 0 0 0 0 0 0 0 0 0 -0.94180655242978772 0 0 0.1295389164000893 
		0.24124148377964222 -0.086443953865528889 0 0 0 0 0 0 0 0 0 -0.013679276289762399 
		-0.52512231451021596 -0.39263982489085669 0.94180655242978706 0 0 0.5160747798714197 
		-1.2817684423971587 -1.7951557935008893 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 13;
	setAttr ".cps" 12;
	setAttr ".nu" 8;
	setAttr ".nv" 6;
	setAttr ".eta" yes;
	setAttr ".nufa" 4.9248999999999992;
	setAttr ".nvfa" 6.1447000000000003;
createNode transform -n "curveBrush111" -p "headShape1";
	setAttr ".v" no;
createNode nurbsCurve -n "curveBrushShape111" -p "curveBrush111";
	setAttr -k off ".v";
	setAttr -s 15 ".cp";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 0 no 2
		17 0 0 0 0.083333333333333329 0.16666666666666666 0.25 0.33333333333333331
		 0.41666666666666663 0.5 0.58333333333333326 0.66666666666666663 0.75000000000000011
		 0.83333333333333326 0.91666666666666663 1 1 1
		15
		1.3931691301184697 7.6142918083091136
		1.2580209698889566 7.6737570902764141
		1.0373883301984246 7.632255081215205
		0.70740097249768463 7.5296436870965087
		0.53903754202804399 7.2065127848631967
		0.51006011318102706 6.8790294307753053
		0.53596517836717794 6.5376094630008055
		0.6185969077643706 6.2136175376917304
		0.62272380395525084 5.8716858704820947
		0.57045331143155042 5.5462273886474556
		0.53046614875993836 5.1995502420531601
		0.61705349435328605 4.8830346566855019
		0.77179125941347382 4.5644111710773005
		0.97479155054303557 4.4616017357258437
		1.1424357187505629 4.4607316864971311
		;
createNode transform -n "leftEye1" -p "head1";
	setAttr ".t" -type "double3" -0.40182629623538985 0.43137793193824148 -0.69020482831316765 ;
	setAttr ".r" -type "double3" 135.23463358581628 160.16807242036646 512.58583374520049 ;
createNode nurbsSurface -n "leftEyeShape1" -p "leftEye1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "curveBrush131" -p "leftEyeShape1";
createNode nurbsCurve -n "curveBrushShape131" -p "curveBrush131";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 10 0 no 2
		11 0 1 2 3 4 5 6 7 8 9 10
		11
		2.7591519999999998 7.0219870000000002
		2.7906019999999998 6.867267
		2.751754 6.7234350000000003
		2.7118549999999999 6.563536
		2.594916 6.5511200000000001
		2.5511029999999999 6.6938110000000002
		2.5690529999999998 6.8402599999999998
		2.6489259999999999 6.9513689999999997
		2.7631899999999998 7.0153049999999997
		2.8572820000000001 6.9106860000000001
		2.9196059999999999 6.7633539999999996
		;
createNode transform -n "rightEye1" -p "head1";
	setAttr ".t" -type "double3" 0.48665743417884005 0.42660742123465373 -0.73645888188218511 ;
	setAttr ".r" -type "double3" -79.562000462213305 44.210437842163017 284.19783511342314 ;
createNode nurbsSurface -n "rightEyeShape1" -p "rightEye1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".cc" -type "nurbsSurface" 
		3 3 0 2 no 
		9 0 0 0 1 2 3 4 4 4
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		
		77
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		9.5961577477086953e-017 -1 -2.5315347264529309e-016
		0.19991679083637254 -1 -0.19991679083637298
		0.2827250369469036 -1 -6.2206594289030728e-017
		0.1999167908363727 -1 0.19991679083637259
		1.2135439796163209e-016 -1 0.28272503694690354
		-0.19991679083637262 -1 0.19991679083637273
		-0.28272503694690365 -1 6.720514623308502e-017
		-0.19991679083637276 -1 -0.19991679083637262
		-1.8508399162477809e-016 -1 -0.28272503694690365
		0.19991679083637254 -1 -0.19991679083637298
		0.2827250369469036 -1 -6.2206594289030728e-017
		0.1999167908363727 -1 0.19991679083637259
		0.61642997969058899 -0.78361162489122427 -0.61642997969058999
		0.87176363753180319 -0.78361162489122427 1.0506347929072347e-016
		0.61642997969058932 -0.78361162489122427 0.61642997969058932
		2.1813357349663164e-016 -0.78361162489122427 0.87176363753180319
		-0.61642997969058932 -0.78361162489122427 0.61642997969058955
		-0.8717636375318033 -0.78361162489122427 1.9198677543608214e-016
		-0.61642997969058944 -0.78361162489122427 -0.6164299796905891
		-4.1463948959857793e-016 -0.78361162489122427 -0.87176363753180319
		0.61642997969058899 -0.78361162489122427 -0.61642997969058999
		0.87176363753180319 -0.78361162489122427 1.0506347929072347e-016
		0.61642997969058932 -0.78361162489122427 0.61642997969058932
		0.8672024474915413 6.5349917926833414e-017 -0.86720244749154252
		1.2264094625656803 1.2250836564410429e-017 2.9010801760341543e-016
		0.86720244749154163 -4.0848244798012482e-017 0.86720244749154185
		2.320702398321726e-016 -6.2842604447880506e-017 1.2264094625656803
		-0.86720244749154174 -4.0848244798012482e-017 0.86720244749154185
		-1.2264094625656805 1.2250836564410432e-017 2.6278660791661894e-016
		-0.86720244749154174 6.5349917926833353e-017 -0.86720244749154141
		-5.0851755259218981e-016 8.7344277576701401e-017 -1.2264094625656803
		0.8672024474915413 6.5349917926833414e-017 -0.86720244749154252
		1.2264094625656803 1.2250836564410429e-017 2.9010801760341543e-016
		0.86720244749154163 -4.0848244798012482e-017 0.86720244749154185
		0.61642997969058932 0.78361162489122449 -0.61642997969058999
		0.87176363753180341 0.78361162489122449 3.0736911915646848e-016
		0.61642997969058944 0.78361162489122449 0.61642997969058966
		1.1178951110797376e-016 0.78361162489122449 0.87176363753180341
		-0.61642997969058955 0.78361162489122449 0.61642997969058966
		-0.87176363753180353 0.78361162489122449 1.816042905245113e-016
		-0.61642997969058955 0.78361162489122449 -0.61642997969058944
		-3.0829542720992005e-016 0.78361162489122449 -0.87176363753180341
		0.61642997969058932 0.78361162489122449 -0.61642997969058999
		0.87176363753180341 0.78361162489122449 3.0736911915646848e-016
		0.61642997969058944 0.78361162489122449 0.61642997969058966
		0.19991679083637276 0.99999999999999989 -0.19991679083637284
		0.28272503694690371 0.99999999999999989 1.9596420542802007e-016
		0.1999167908363727 0.99999999999999989 0.19991679083637293
		-1.4355766373180937e-017 0.99999999999999989 0.28272503694690376
		-0.19991679083637284 0.99999999999999989 0.19991679083637282
		-0.28272503694690376 0.99999999999999989 5.3955617280509677e-017
		-0.19991679083637273 0.99999999999999989 -0.19991679083637273
		-4.9373827289965096e-017 0.99999999999999989 -0.28272503694690365
		0.19991679083637276 0.99999999999999989 -0.19991679083637284
		0.28272503694690371 0.99999999999999989 1.9596420542802007e-016
		0.1999167908363727 0.99999999999999989 0.19991679083637293
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		1.7399673366363372e-016 1 -1.6804838495427943e-017
		
		;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "curveBrush141" -p "rightEyeShape1";
createNode nurbsCurve -n "curveBrushShape141" -p "curveBrush141";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 2
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		2.5600809999999998 7.907114
		2.6764399999999999 7.9966439999999999
		2.7934070000000002 7.934774
		2.7868140000000001 7.7646839999999999
		2.7333219999999998 7.6057899999999998
		2.6328619999999998 7.50312
		2.5017749999999999 7.4682430000000002
		2.3634789999999999 7.4584330000000003
		2.3082880000000001 7.5628380000000002
		2.328986 7.7014570000000004
		2.370136 7.8362970000000001
		2.4669940000000001 7.9273790000000002
		2.578729 8.0052280000000007
		;
createNode transform -n "lLidParent" -p "head1";
	setAttr ".r" -type "double3" -63.850719677522612 37.394507175902199 -55.997159637977873 ;
createNode transform -n "leftEyeLid" -p "lLidParent";
	setAttr ".r" -type "double3" 78.016000000000005 25.360845963742374 12.704902716644957 ;
	setAttr ".s" -type "double3" 1.2181248426601048 1.1295268034051773 1.2181248426601048 ;
createNode nurbsSurface -n "leftEyeLidShape" -p "leftEyeLid";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "rLidParent" -p "head1";
	setAttr ".r" -type "double3" -63.850719677522612 37.394507175902199 -55.997159637977873 ;
createNode transform -n "rightEyeLid" -p "rLidParent";
	setAttr ".r" -type "double3" 101.984 19.686888950753232 8.8982182944848134 ;
	setAttr ".s" -type "double3" 1.2267965983912827 1.1665202666984986 1.2267965983912827 ;
createNode nurbsSurface -n "rightEyeLidShape" -p "rightEyeLid";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "controls" -p "head1";
	setAttr ".t" -type "double3" -0.13936760477653556 2.5297865734437157 -0.74176659956124236 ;
	setAttr ".r" -type "double3" -63.850719677522612 37.394507175902199 -55.997159637977873 ;
	setAttr ".s" -type "double3" 0.51230012150678994 0.51230012150678994 0.51230012150678994 ;
createNode annotationShape -n "carrotTopControl" -p "controls";
	addAttr -ci true -sn "mouthOpen" -ln "mouthOpen" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mouthOpenWidth" -ln "mouthOpenWidth" -dv 0.80000000000000004 
		-min 0 -max 1 -at "double";
	addAttr -ci true -sn "MouthOpenShift" -ln "MouthOpenShift" -dv 0.20000000000000001 
		-min -1 -max 1 -at "double";
	addAttr -ci true -sn "mouthWiggle" -ln "mouthWiggle" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "wiggleOffset" -ln "wiggleOffset" -min 0 -max 10 -at "double";
	addAttr -ci true -sn "mouthCornerSize" -ln "mouthCornerSize" -dv 0.3 -min 0 -max 
		1 -at "double";
	addAttr -ci true -sn "mouthNoise" -ln "mouthNoise" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mouthTurbulence" -ln "mouthTurbulence" -dv 0.20000000000000001 
		-min 0 -max 1 -at "double";
	addAttr -ci true -sn "teeth" -ln "teeth" -dv 5 -min 0 -max 20 -at "double";
	addAttr -ci true -sn "teethSize" -ln "teethSize" -dv 0.5 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "lineNoise" -ln "lineNoise" -dv 0.5 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "smile" -ln "smile" -dv 0.80000000000000004 -min -1 -max 1 
		-at "double";
	addAttr -ci true -sn "blink" -ln "blink" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "autoBlink" -ln "autoBlink" -dv 0.050000000000000003 -min 0 
		-max 1 -at "double";
	addAttr -ci true -sn "squint" -ln "squint" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "wink" -ln "wink" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "aggression" -ln "aggression" -min -1 -max 1 -at "double";
	addAttr -ci true -sn "eyeSize" -ln "eyeSize" -dv 0.5 -min 0 -max 1 -at "double";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "controls (extra attrs)";
	setAttr ".daro" no;
	setAttr -k on ".mouthOpen";
	setAttr -k on ".mouthOpenWidth" 0.46280000000000004;
	setAttr -k on ".MouthOpenShift" 0.090920000000000112;
	setAttr -k on ".mouthWiggle";
	setAttr -k on ".wiggleOffset";
	setAttr -k on ".mouthCornerSize" 0.38842000000000004;
	setAttr -k on ".mouthNoise";
	setAttr -k on ".mouthTurbulence" 0.11570000000000001;
	setAttr -k on ".teeth" 0;
	setAttr -k on ".teethSize" 0.26446000000000003;
	setAttr -k on ".lineNoise" 0.50414;
	setAttr -k on ".smile" 0.86776000000000009;
	setAttr -k on ".blink" 0.77686000000000011;
	setAttr -k on ".autoBlink" 0.099180000000000004;
	setAttr -k on ".squint";
	setAttr -k on ".wink";
	setAttr -k on ".aggression" -0.23967999999999989;
	setAttr -k on ".eyeSize" 0.43802000000000002;
createNode transform -n "hairSystem1";
createNode hairSystem -n "hairSystemShape1" -p "hairSystem1";
	setAttr -k off ".v";
	setAttr -s 4 ".ih";
	setAttr ".sfn" 0.98348000000000013;
	setAttr -s 2 ".sts[0:1]"  0 1 3 1 0.40000001 3;
	setAttr ".drg" 0.041320000000000003;
	setAttr ".itr" 31;
	setAttr ".grv" 9.5868;
	setAttr ".sct" 1;
	setAttr ".ssg" 2;
	setAttr ".cwd" 2.04576;
	setAttr -s 3 ".cws[0:2]"  0.014285714 0.18000001 3 0.97142857 
		1 3 0.2857143 0.5 3;
	setAttr ".clc[0]"  0 0.5 1;
	setAttr ".cfl[0]"  0 0 1;
	setAttr ".hwd" 0.80000000000000004;
	setAttr -s 3 ".hws[0:2]"  0.20714286 0.86000001 3 1 0.02 3 
		0.80714285 0.31999999 3;
	setAttr ".hcl" -type "float3" 1 0.83333331 0.5 ;
	setAttr -s 2 ".hcs";
	setAttr ".hcs[2].hcsp" 1;
	setAttr ".hcs[2].hcsc" -type "float3" 1 0.64217335 0.62400001 ;
	setAttr ".hcs[2].hcsi" 3;
	setAttr ".hcs[3].hcsp" 0;
	setAttr ".hcs[3].hcsc" -type "float3" 1 1 1 ;
	setAttr ".hcs[3].hcsi" 3;
	setAttr ".hpc" 5;
	setAttr ".spc" -type "float3" 0 0 0 ;
	setAttr ".dfr" 0;
	setAttr ".sra" 0;
	setAttr ".dsc[0]"  0 1 1;
	setAttr -s 4 ".oh";
	setAttr ".oh[4]" -type "vectorArray" 10 -0.24353575150253615 0.87481000229650985
		 -2.1879340105590175 -0.56830742677355428 1.1844939183555931 -1.9616253878488354 -0.84490010682943129
		 1.396972182824944 -1.6537007220109541 -1.0877547364371152 1.5140040142614013 -1.2250664176024788 -1.2610164178162881
		 1.5015112811291627 -0.69592624750467502 -1.3312562229357532 1.3487902882261458 -0.12905087289362197 -1.2936508214714488
		 1.0785845789084767 0.4204897046474193 -1.1657628897819157 0.73431177365038403 0.9127240406767172 -0.97722070927477311
		 0.35627447156952441 1.3435738415944969 -0.76210490126211961 -0.023471023264585184
		 1.7273760659764097 ;
	setAttr ".oh[5]" -type "vectorArray" 10 -0.32982743716765417 0.95070114447806353
		 -2.5411008070433723 -0.6907131537811162 1.2685012341988595 -2.5132082510212337 -1.0399036312092063
		 1.5053348806464537 -2.5842289453849481 -1.4263241768851604 1.6747977018010367 -2.7925290000819181 -1.8048834234778459
		 1.7275625635238911 -3.1581127331995371 -2.0974641978577786 1.6313248091368739 -3.6413685039981973 -2.2618402551757408
		 1.4005944026223451 -4.179384184970738 -2.2938020783130049 1.0823053462687942 -4.7058475229663497 -2.2259710931844237
		 0.723784349938143 -5.1928319272482231 -2.1075265535267214 0.36776806776338444 -5.6299144591502355 ;
	setAttr ".oh[6]" -type "vectorArray" 10 0.046860559110790151 1.190432608603522
		 -3.040430872690985 -0.19015877737843703 1.5958009158341373 -3.1482367968150036 -0.40222664211156239
		 1.9145046363757117 -3.3302530437554307 -0.61984583603138454 2.1796033516684994 -3.6388690035618478 -0.81792384442188504
		 2.3377502352916659 -4.08650735362807 -0.9548686242075447 2.3347665843256618 -4.6270453349431619 -1.0072986055528848
		 2.1632093124742351 -5.1930337388636465 -0.97529100211551456 1.8597158001829353 -5.7176312830155851 -0.88052041906045253
		 1.4790604065565711 -6.1761719535058059 -0.75583931776609237 1.0790458323136913 -6.5720217894500594 ;
	setAttr ".oh[7]" -type "vectorArray" 10 0.51202316148300508 1.3220414589740128
		 -2.241580199683642 0.41367426843866462 1.7593187965453359 -2.0644633628537963 0.38023443573126059
		 2.1239081021928108 -1.8570762019708269 0.42476506980674977 2.4686034093378999 -1.5688199238486855 0.57991667766971766
		 2.7533615040334962 -1.1908828582423057 0.85809446969831593 2.9133107484098195 -0.75937671326712597 1.2397945417225542
		 2.913475279060882 -0.33073185937282268 1.6780492554428696 2.7636587825334336 0.037950389852557345 2.1318685202352849
		 2.5106702317470373 0.32755219351956533 2.5708028667145659 2.2159881607533514 0.55264257701619246 ;
createNode transform -n "hairSystem1Follicles";
createNode transform -n "nurbsSphere1Follicle7412" -p "hairSystem1Follicles";
createNode follicle -n "nurbsSphere1FollicleShape7412" -p "nurbsSphere1Follicle7412";
	setAttr -k off ".v";
	setAttr ".pu" 0.97;
	setAttr ".pv" 0.095;
createNode transform -n "curve15" -p "nurbsSphere1Follicle7412";
	setAttr ".t" -type "double3" -2.5437863689124023 0.07863363408623586 -0.3074614702898012 ;
	setAttr ".r" -type "double3" 56.474540922806526 36.797901229426785 -98.515388680476775 ;
	setAttr ".s" -type "double3" 0.99999999999999978 0.99999999999999978 1 ;
createNode nurbsCurve -n "curveShape15" -p "curve15";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 9 0 no 3
		10 0 1 2 3 4 5 6 7 8 9
		10
		-0.39346220434473722 1.4186551857229059 -2.1238380319365553
		-0.69807762912621762 1.7388713499778801 -1.8386464728742309
		-0.94166441000226897 1.9413693075220124 -1.4416571035902581
		-1.1015935097314138 1.9974135849151124 -0.93364348935210206
		-1.1456932627782099 1.8865526420191445 -0.37632726402360972
		-1.0698607729395526 1.6333661928566607 0.15059875114388599
		-0.89662703467053961 1.2858325938011366 0.6096869662683353
		-0.65687509244715481 0.89369537334775029 0.99147856867625317
		-0.37655268105829265 0.48903341233249992 1.313857108355865
		-0.079873337069166717 0.091810186489670403 1.6001609126520799
		;
createNode transform -n "nurbsSphere1Follicle7437" -p "hairSystem1Follicles";
createNode follicle -n "nurbsSphere1FollicleShape7437" -p "nurbsSphere1Follicle7437";
	setAttr -k off ".v";
	setAttr ".pu" 0.95;
	setAttr ".pv" 0.505;
createNode transform -n "curve16" -p "nurbsSphere1Follicle7437";
	setAttr ".t" -type "double3" 2.4014656854435823 -1.4862120938456731 -0.96501012117681007 ;
	setAttr ".r" -type "double3" 74.356540291031394 42.795819229723691 60.74040739694005 ;
	setAttr ".s" -type "double3" 1 1 0.99999999999999989 ;
createNode nurbsCurve -n "curveShape16" -p "curve16";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 9 0 no 3
		10 0 1 2 3 4 5 6 7 8 9
		10
		-0.49472358050685877 1.5184283616884198 -2.4669472764507172
		-0.86247599130351249 1.8724138085855322 -2.4106291606449068
		-1.2464519194100938 2.1555415386834782 -2.5065765670942581
		-1.6320444915860526 2.3313147111049228 -2.7994228298544446
		-1.9342973478914571 2.3416580118016803 -3.2645821514998348
		-2.0857009170718022 2.1864213267470847 -3.8024963068078281
		-2.0877734832926498 1.9133918672141896 -4.336439136376911
		-1.9719489972718793 1.5786480322171488 -4.820081821988266
		-1.7779841963482117 1.2202839915252444 -5.2493915737813488
		-1.5492838539744596 0.86874616522556303 -5.6294650717046206
		;
createNode transform -n "nurbsSphere1Follicle7462" -p "hairSystem1Follicles";
createNode follicle -n "nurbsSphere1FollicleShape7462" -p "nurbsSphere1Follicle7462";
	setAttr -k off ".v";
	setAttr ".pu" 0.86;
	setAttr ".pv" 0.635;
createNode transform -n "curve17" -p "nurbsSphere1Follicle7462";
	setAttr ".t" -type "double3" 2.6952382996870305 1.0260432176704404 -1.9714586350545222 ;
	setAttr ".r" -type "double3" 95.67591211115672 26.756108669420168 127.18972357168974 ;
	setAttr ".s" -type "double3" 0.99999999999999944 0.99999999999999978 0.99999999999999956 ;
createNode nurbsCurve -n "curveShape17" -p "curve17";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 9 0 no 3
		10 0 1 2 3 4 5 6 7 8 9
		10
		-0.13401556658104721 1.7686035873886683 -2.972909351143258
		-0.36748596341497419 2.2165118020706407 -3.0549955380228608
		-0.5872136961446035 2.5956290491035205 -3.2507282648800384
		-0.79244989796798915 2.8847779387681305 -3.6116273536094945
		-0.93990468742154076 2.9981602194409658 -4.1219701923593854
		-0.9916793000441495 2.8910087678840313 -4.6788339248787842
		-0.95236034761071908 2.6004915837152383 -5.1920041674406079
		-0.84998951420006919 2.1960189348286687 -5.6165324541255854
		-0.71504526263951718 1.7349001646675799 -5.9591521746713152
		-0.57272697944240192 1.2645777194925589 -6.2439122759378343
		;
createNode transform -n "nurbsSphere1Follicle7487" -p "hairSystem1Follicles";
createNode follicle -n "nurbsSphere1FollicleShape7487" -p "nurbsSphere1Follicle7487";
	setAttr -k off ".v";
	setAttr ".pu" 0.86;
	setAttr ".pv" 0.845;
createNode transform -n "curve18" -p "nurbsSphere1Follicle7487";
	setAttr ".t" -type "double3" 0.96796129477034942 2.6070701132381733 -0.78772083620111333 ;
	setAttr ".r" -type "double3" 66.567239789246955 10.083863092070294 169.88152835190238 ;
	setAttr ".s" -type "double3" 0.99999999999999967 0.99999999999999978 0.99999999999999978 ;
createNode nurbsCurve -n "curveShape18" -p "curve18";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 9 0 no 3
		10 0 1 2 3 4 5 6 7 8 9
		10
		0.37918900328495231 1.832944433626513 -2.195515719268212
		0.30972274541418338 2.2888056071162124 -1.9747763135714631
		0.31504214213137732 2.6823551463224136 -1.7059152807363451
		0.43456668249970487 3.0108501227527551 -1.3500691989410187
		0.70501343421282348 3.1977926977518565 -0.93131905900744505
		1.1047159081123554 3.1776708140599603 -0.54391232855169969
		1.5714208693865339 2.9697398584464567 -0.27180449677128171
		2.0458127682821634 2.6474939936311288 -0.14888012040687626
		2.5036224146329795 2.2827048094786604 -0.15605832496772212
		2.9356844070847101 1.9245708351334603 -0.2429716884227528
		;
createNode transform -n "pfxHair1";
createNode pfxHair -n "pfxHairShape1" -p "pfxHair1";
	setAttr ".cch" yes;
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".mvbs" 17664;
createNode transform -n "pfxToon1";
createNode pfxToon -n "pfxToonShape1" -p "pfxToon1";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".cln" no;
	setAttr ".bln" no;
	setAttr ".sei" yes;
	setAttr ".lwd" 0.046284;
	setAttr ".dff" 6.1984000000000004;
	setAttr ".imn" 0;
	setAttr ".imx" 0;
	setAttr ".spf" no;
	setAttr -s 2 ".cwd[0:1]"  0 1 3 0.30000001 0.30000001 3;
	setAttr ".pwm" 0;
	setAttr ".pba" 116.03400000000001;
	setAttr ".let" 1.6528;
	setAttr ".pcl" -type "float3" 0.178 0 0 ;
createNode transform -n "pfxToon2";
createNode pfxToon -n "pfxToonShape2" -p "pfxToon2";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr -s 3 ".ins";
	setAttr ".iln" yes;
	setAttr ".lwd" 0.041322;
	setAttr ".lof" 0.16520000000000001;
	setAttr -s 2 ".cwd[0:1]"  0 1 3 0.30000001 0.30000001 3;
	setAttr ".pcl" -type "float3" 0.51599997 0.36480168 0.36171597 ;
	setAttr ".icl" -type "float3" 0.51599997 0.36480168 0.36171597 ;
createNode transform -n "strokeMouthBrush1";
createNode stroke -n "strokeShapeMouthBrush1" -p "strokeMouthBrush1";
	setAttr ".cch" yes;
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".mvbs" 312;
	setAttr ".lvbs" 2160;
	setAttr ".smo" 10;
	setAttr ".pcv[0].smp" 49;
	setAttr ".spm2" 1;
	setAttr ".psc[0]"  0 1 3;
	setAttr -s 49 ".psr[0:48]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
		1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
createNode transform -n "strokeBrush12";
createNode stroke -n "strokeShapeBrush11" -p "strokeBrush12";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".sed" 2;
	setAttr ".pcv[0].smp" 11;
	setAttr ".spm1" 5;
	setAttr ".spm2" 1;
	setAttr -s 3 ".psc[0:2]"  0 0.41999999 1 0.5642857 1 1 1 0.12 
		1;
	setAttr -s 11 ".psr[0:10]"  1 1 1 1 1 1 1 1 1 1 1;
createNode transform -n "strokeBrush13";
createNode stroke -n "strokeShapeBrush11" -p "strokeBrush13";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr ".sed" 3;
	setAttr ".pcv[0].smp" 13;
	setAttr ".spm1" 5;
	setAttr ".spm2" 1;
	setAttr -s 3 ".psc[0:2]"  0 0.059999999 1 0.44285715 1 1 1 
		0.2 1;
	setAttr -s 13 ".psr[0:12]"  1 1 1 1 1 1 1 1 1 1 1 1 1;
createNode transform -n "nurbsSphere4";
	setAttr ".s" -type "double3" 42.452680675512056 42.452680675512056 42.452680675512056 ;
createNode nurbsSurface -n "nurbsSphereShape4" -p "nurbsSphere4";
	setAttr -k off ".v";
	setAttr ".ovdt" 2;
	setAttr ".ove" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "pfxToon3";
createNode pfxToon -n "pfxToonShape3" -p "pfxToon3";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr -s 2 ".ins";
	setAttr ".pln" 0;
	setAttr ".cln" no;
	setAttr ".lwd" 0.058678000000000001;
	setAttr ".lof" 0.5786;
	setAttr ".spf" no;
	setAttr -s 2 ".cwd[0:1]"  0 1 3 0.30000001 0.30000001 3;
	setAttr ".pwm" 0;
	setAttr ".bwm" 0.67768000000000006;
	setAttr ".bba" 71.406000000000006;
	setAttr ".let" 2.2314000000000003;
	setAttr ".pcl" -type "float3" 0.69999999 0.4800978 0.42070001 ;
	setAttr ".bcl" -type "float3" 0.745 0.48597592 0.4023 ;
createNode transform -n "lineModifier1";
	setAttr ".t" -type "double3" -0.19114815728114865 2.2611701583510655 -2.1317634784815689 ;
createNode lineModifier -n "lineModifierShape1" -p "lineModifier1";
	setAttr -k off ".v";
	setAttr -s 2 ".drp[0:1]"  0 1 3 1 1 3;
createNode transform -n "pfxToon4";
createNode pfxToon -n "pfxToonShape4" -p "pfxToon4";
	setAttr -k off ".v";
	setAttr ".dpc" 100;
	setAttr -s 2 ".ins";
	setAttr ".cln" no;
	setAttr ".lwd" 0.052892000000000002;
	setAttr ".blw" 1.157;
	setAttr -s 2 ".cwd[0:1]"  0 1 3 0.30000001 0.30000001 3;
	setAttr ".pcl" -type "float3" 0.54100001 0.40953702 0.40953702 ;
	setAttr ".bcl" -type "float3" 0.44454989 0.54545999 0.54545999 ;
createNode lightLinker -n "lightLinker1";
	setAttr -s 6 ".lnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
	setAttr ".do" 1;
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode brush -n "brush2";
	setAttr ".dep" yes;
	setAttr ".sdn" 16.5288;
	setAttr ".sft" 0.057840000000000114;
	setAttr ".cl1" -type "float3" 1 1 1 ;
	setAttr ".rll" yes;
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
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
createNode surfaceShader -n "solidShader";
	setAttr ".oc" -type "float3" 1 0.82499999 0.84363753 ;
createNode shadingEngine -n "surfaceShader1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 1000 -ast 1 -aet 1000 ";
	setAttr ".st" 6;
createNode makeNurbSphere -n "makeNurbSphere2";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode surfaceShader -n "solidShader1";
	setAttr ".oc" -type "float3" 1 1 1 ;
createNode shadingEngine -n "surfaceShader2SG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode nurbsTessellate -n "nurbsTessellate1";
	setAttr ".cch" yes;
	setAttr ".f" 2;
createNode nurbsTessellate -n "nurbsTessellate2";
	setAttr ".cch" yes;
	setAttr ".f" 2;
createNode nurbsTessellate -n "nurbsTessellate3";
	setAttr ".cch" yes;
	setAttr ".f" 2;
createNode brush -n "mouthBrush";
	setAttr ".dep" yes;
	setAttr ".lvs" yes;
	setAttr ".flw" yes;
	setAttr ".brt" 5;
	setAttr ".bwd" 0.0082640000000000005;
	setAttr ".sft" 0.10743999999999998;
	setAttr ".cl2" -type "float3" 0.76033998 0.085284784 0 ;
	setAttr ".rll" yes;
	setAttr ".tub" yes;
	setAttr ".tps" 0;
	setAttr ".stb" 1;
	setAttr ".lnx" 0.5786;
	setAttr ".lnn" 0.16520000000000001;
	setAttr ".sgm" 66;
	setAttr ".tw1" 1.5;
	setAttr ".tw2" 1.5;
	setAttr ".lfx" 1;
	setAttr ".elm" 0.00826;
	setAttr ".elx" 0;
	setAttr ".fl1" 1;
	setAttr ".fl2" 1;
	setAttr ".twr" 0.01;
	setAttr ".twd" 0;
	setAttr ".spd" 0.0047107999999999994;
	setAttr ".ddl" 0;
	setAttr ".wgf" 6.6121;
	setAttr ".crf" 9.9181000000000008;
	setAttr ".nof" 1;
	setAttr ".noo" 0.05372;
	setAttr ".pfl" 1;
	setAttr ".trt" 4;
	setAttr ".tin" 2;
	setAttr ".trf" 0.50414;
	setAttr ".trs" 4;
	setAttr ".ran" 0.90910000000000002;
	setAttr ".grv" 1;
	setAttr ".ll1" 90;
	setAttr ".ll2" 90;
	setAttr ".lbn" -0.74399999999999977;
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".lsg" 8;
	setAttr ".lsd" 0.67768000000000006;
	setAttr ".lc1" -type "float3" 1 1 1 ;
	setAttr ".lc2" -type "float3" 1 1 1 ;
	setAttr ".lfs" 1;
	setAttr ".pif" 2;
	setAttr ".fw1" 95.208;
	setAttr ".fw2" 107.10600000000001;
	setAttr ".ftw" 0.024800000000000155;
	setAttr ".pbn" 0.082800000000000651;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".lpwl" -0.024799999999999933;
	setAttr ".fst" 0.01;
	setAttr ".nfl" 2.376;
	setAttr ".pft" 0;
	setAttr ".ptb" 0.090900000000000009;
	setAttr ".fsd" 1;
	setAttr ".fls" 1;
	setAttr -s 3 ".wsc[1:3]"  0.031750798 0.02 3 0.54455078 0.0099999998 
		3 1 0.02 3;
	setAttr -s 3 ".wsc";
	setAttr -s 5 ".lws[0:4]"  0 0.38 1 0.6785714 0.88 3 1 0 3 
		0.91428572 0.77999997 3 0.34285715 0.86000001 1;
	setAttr -s 2 ".pws[0:1]"  0 1 1 1 0.41999999 1;
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
createNode curveFromSurfaceCoS -n "curveFromSurfaceCoS1";
	setAttr ".ihi" 1;
	setAttr ".min" 0;
	setAttr ".max" 1;
	setAttr ".r" yes;
createNode brush -n "brush4";
	setAttr ".gsc" 5;
	setAttr ".dep" yes;
	setAttr ".rll" yes;
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
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
createNode curveFromSurfaceCoS -n "curveFromSurfaceCoS2";
	setAttr ".ihi" 1;
	setAttr ".min" 0;
	setAttr ".max" 1;
	setAttr ".r" yes;
createNode brush -n "brush5";
	setAttr ".gsc" 5;
	setAttr ".dep" yes;
	setAttr ".rll" yes;
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
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
createNode curveFromSurfaceCoS -n "curveFromSurfaceCoS3";
	setAttr ".ihi" 1;
	setAttr ".min" 0;
	setAttr ".max" 1;
	setAttr ".r" yes;
createNode makeNurbSphere -n "makeNurbSphere3";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode lambert -n "lambert2";
	setAttr ".c" -type "float3" 0.30512252 0.4281019 0.85949999 ;
	setAttr ".ic" -type "float3" 0.21053986 0.25224203 0.27272001 ;
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=sin(time *30) * .2 + 0.3";
createNode expression -n "expression2";
	setAttr -k on ".nds";
	setAttr -s 17 ".in";
	setAttr -s 17 ".in";
	setAttr -s 35 ".out";
	setAttr ".ixp" -type "string" (
		"float $eyeScale = .I[0] * 0.5 + 0.1;\r\n.O[0] = $eyeScale;\r\n.O[1] = $eyeScale;\r\n.O[2] = $eyeScale;\r\n.O[3] = $eyeScale;\r\n.O[4] = $eyeScale;\r\n.O[5] = $eyeScale;\r\nfloat $blink = .I[1];\r\nif( .I[2] > 0.00001){\r\n\tif( rand(1.1) < .I[2] ){\r\n\t\t$blink = 1.0;\r\n\t}\r\n}\r\nfloat $squint = $blink * $blink;\r\nif( .I[3] > $squint ){\r\n\t$squint = .I[3];\r\n}\r\nfloat $rightBlink = $blink;\r\nfloat $rightSquint = $squint;\r\nif( .I[4] > $rightBlink ){\r\n\t$rightBlink = .I[4];\r\n}\r\nif( .I[4] > $rightSquint ){\r\n\t$rightSquint = .I[4];\r\n}\r\n$blink *= 0.98;\r\n$rightBlink *= 0.98; // avoid fully closing eye\r\n.O[6] = 180 - $squint * 180;\r\n.O[7] = 180.01 + $blink * 179.99;\r\n.O[8] = 180 - $rightSquint * 180;\r\n.O[9] = 180.01 + $rightBlink * 179.99;\r\n\r\n.O[10] = .I[5] * 50 + 90;\r\n.O[11] = -.I[5] * 50 + 90;\r\nfloat $lnoise = .I[6];\r\nif( $lnoise > 0.7 ){\r\n  $lnoise = 0.7;\r\n}\r\n.O[12] = .I[7] * .1 + 0.02\r\n\t\t+.I[8] * .14\r\n\t\t+.I[9] * 0.08;\r\n.O[13] = $lnoise;\r\n.O[14] = 1.2 + .I[6] * 1.5;\r\n.O[15] = .I[6] * 0.1 + 0.02;\r\nfloat $midPoint = .I[10] * 0.49 + 0.5;\r\nfloat $min = $midPoint - .I[11] -.05;\r\n"
		+ "float $max = $midPoint + .I[11] +.05;\r\nif( $min < 0 ){\r\n  $min = 0;\r\n}\r\nif( $max > 1 ){\r\n  $max = 1;\r\n}\r\n.O[16] = $min;\r\n.O[17] = 0.02;\r\n.O[18] = 3;\r\n\r\n.O[19] = $midPoint;\r\n.O[20] = .I[7] * 0.95 + 0.01;\r\n.O[21] = 3;\r\n\r\n.O[22] = $max;\r\n.O[23] = 0.02;\r\n.O[24] = 3;\r\n\r\n.O[25] = .I[12] * 1.2;\r\nfloat $lstart = 0.5 - (.I[12]-1)/30;\r\nif( $lstart < 0.05 ){\r\n  $lstart = 0.05;\r\n}\r\n.O[26] = $lstart;\r\n.O[27] = -1.0 * .I[13];\r\n.O[28] = .I[13];\r\n.O[29] = .I[13];\r\n.O[30] = .I[14];\r\n.O[31] = .I[8] * 0.25 + 0.001;\r\n.O[32] = .I[9] * 0.03;\r\n.O[33] = .I[15] * 0.02;\r\n.O[34] = .I[16];");
createNode animCurveUL -n "curveBrushShape111_controlPoints_0__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.60683297201106201 -0.5 0.95607952362893645 
		-0.25 0.9944927834806937 0 1.167247296362909 0.80000001192092896 1.3694490000000001 
		1 1.449929025409622;
createNode animCurveUL -n "curveBrushShape111_controlPoints_1__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.78202496026312829 -0.5 1.0415547276239634 
		-0.25 1.0415547276239634 0 1.0415547276239634 0.80000001192092896 1.2580209698889566 
		1 1.2580209698889566;
createNode animCurveUL -n "curveBrushShape111_controlPoints_2__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.64058767179376264 -0.5 0.72869975753026539 
		-0.25 0.78318861570284226 0 0.78318861570284226 0.80000001192092896 1.0373883301984246 
		1 1.0373883301984246;
createNode animCurveUL -n "curveBrushShape111_controlPoints_3__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.60363011052322124 -0.5 0.64986805869922137 
		-0.25 0.64986805869922137 0 0.64986805869922137 0.80000001192092896 0.70740097249768463 
		1 0.70740097249768463;
createNode animCurveUL -n "curveBrushShape111_controlPoints_4__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.53268752103455763 -0.5 0.53268752103455763 
		-0.25 0.53268752103455763 0 0.53268752103455763 0.80000001192092896 0.53903754202804399 
		1 0.53903754202804399;
createNode animCurveUL -n "curveBrushShape111_controlPoints_5__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.52039127597420254 -0.5 0.52039127597420254 
		-0.25 0.52039127597420254 0 0.52039127597420254 0.80000001192092896 0.51006011318102706 
		1 0.51006011318102706;
createNode animCurveUL -n "curveBrushShape111_controlPoints_6__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.54814614490168967 -0.5 0.51778434565802511 
		-0.25 0.51778434565802511 0 0.51778434565802511 0.80000001192092896 0.53596517836717794 
		1 0.53596517836717794;
createNode animCurveUL -n "curveBrushShape111_controlPoints_7__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.67832011538903936 -0.5 0.60041607505521777 
		-0.25 0.60041607505521777 0 0.60041607505521777 0.80000001192092896 0.6185969077643706 
		1 0.6185969077643706;
createNode animCurveUL -n "curveBrushShape111_controlPoints_8__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.66819304437795124 -0.5 0.60454297124609802 
		-0.25 0.60454297124609802 0 0.60454297124609802 0.80000001192092896 0.62272380395525084 
		1 0.62272380395525084;
createNode animCurveUL -n "curveBrushShape111_controlPoints_9__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.59672428420355594 -0.5 0.57045331143155042 
		-0.25 0.57045331143155042 0 0.57045331143155042 0.80000001192092896 0.57045331143155042 
		1 0.57045331143155042;
createNode animCurveUL -n "curveBrushShape111_controlPoints_10__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.57922032846790394 -0.5 0.55163094526898981 
		-0.25 0.55163094526898981 0 0.55163094526898981 0.80000001192092896 0.53046614875993836 
		1 0.53046614875993836;
createNode animCurveUL -n "curveBrushShape111_controlPoints_11__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.72619476861321253 -0.5 0.65314942909620088 
		-0.25 0.65314942909620088 0 0.65314942909620088 0.80000001192092896 0.61705349435328605 
		1 0.61705349435328605;
createNode animCurveUL -n "curveBrushShape111_controlPoints_12__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0.93263258614334055 -0.5 0.74913609812539794 
		-0.25 0.74913609812539794 0 0.74913609812539794 0.80000001192092896 0.77179125941347382 
		1 0.77179125941347382;
createNode animCurveUL -n "curveBrushShape111_controlPoints_13__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 1.0948101523197189 -0.5 0.86619554903539109 
		-0.25 0.86619554903539109 0 0.86619554903539109 0.80000001192092896 0.97479155054303557 
		1 0.97479155054303557;
createNode animCurveUL -n "curveBrushShape111_controlPoints_14__xValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 1 -0.5 1.0308408702508196 -0.25 1.1136579256747992 
		0 1.1136579256747992 0.80000001192092896 1.076562 1 1.4220265694342016;
createNode animCurveUL -n "curveBrushShape111_controlPoints_0__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 8.0506155502453556 -0.5 8.1511163714512307 
		-0.25 7.9651596723811338 0 7.9144605079068189 0.80000001192092896 7.6600400000000004 
		1 7.4865928278437011;
createNode animCurveUL -n "curveBrushShape111_controlPoints_1__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 7.9737809836099478 -0.5 7.8378174852009765 
		-0.25 7.8378174852009765 0 7.8378174852009765 0.80000001192092896 7.6737570902764141 
		1 7.6737570902764141;
createNode animCurveUL -n "curveBrushShape111_controlPoints_2__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 7.7574077646908073 -0.5 7.7574077646908073 
		-0.25 7.6801888668205454 0 7.6801888668205454 0.80000001192092896 7.632255081215205 
		1 7.632255081215205;
createNode animCurveUL -n "curveBrushShape111_controlPoints_3__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 7.5037149636214933 -0.5 7.5037149636214933 
		-0.25 7.5037149636214933 0 7.5037149636214933 0.80000001192092896 7.5296436870965087 
		1 7.5296436870965087;
createNode animCurveUL -n "curveBrushShape111_controlPoints_4__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 7.1996158150411684 -0.5 7.1996158150411684 
		-0.25 7.1996158150411684 0 7.1996158150411684 0.80000001192092896 7.2065127848631967 
		1 7.2065127848631967;
createNode animCurveUL -n "curveBrushShape111_controlPoints_5__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 7 -0.5 7 -0.25 7 0 7 0.80000001192092896 
		6.8790294307753053 1 6.8790294307753053;
createNode animCurveUL -n "curveBrushShape111_controlPoints_6__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 6.5489302888827208 -0.5 6.5786012952712678 
		-0.25 6.5786012952712678 0 6.5786012952712678 0.80000001192092896 6.5376094630008055 
		1 6.5376094630008055;
createNode animCurveUL -n "curveBrushShape111_controlPoints_7__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 6.2546093699621927 -0.5 6.2546093699621927 
		-0.25 6.2546093699621927 0 6.2546093699621927 0.80000001192092896 6.2136175376917304 
		1 6.2136175376917304;
createNode animCurveUL -n "curveBrushShape111_controlPoints_8__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 5.912677702752557 -0.5 5.912677702752557 
		-0.25 5.912677702752557 0 5.912677702752557 0.80000001192092896 5.8716858704820947 
		1 5.8716858704820947;
createNode animCurveUL -n "curveBrushShape111_controlPoints_9__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 5.5645452200801273 -0.5 5.5462273886474556 
		-0.25 5.5462273886474556 0 5.5462273886474556 0.80000001192092896 5.5462273886474556 
		1 5.5462273886474556;
createNode animCurveUL -n "curveBrushShape111_controlPoints_10__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 4.9062628398409389 -0.5 4.8679327550154232 
		-0.25 4.8679327550154232 0 4.8679327550154232 0.80000001192092896 5.1995502420531601 
		1 5.1995502420531601;
createNode animCurveUL -n "curveBrushShape111_controlPoints_11__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 4.4072208093298721 -0.5 4.6960556907663822 
		-0.25 4.6960556907663822 0 4.6960556907663822 0.80000001192092896 4.8830346566855019 
		1 4.8830346566855019;
createNode animCurveUL -n "curveBrushShape111_controlPoints_12__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 4.1389319896681585 -0.5 4.3776517903673104 
		-0.25 4.3776517903673104 0 4.3776517903673104 0.80000001192092896 4.5644111710773005 
		1 4.5644111710773005;
createNode animCurveUL -n "curveBrushShape111_controlPoints_13__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 3.9638210074438112 -0.5 4.2885271051919727 
		-0.25 4.323467891033693 0 4.323467891033693 0.80000001192092896 4.4616017357258437 
		1 4.4616017357258437;
createNode animCurveUL -n "curveBrushShape111_controlPoints_14__yValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 3.7214135284403689 -0.5 4.0108581758683375 
		-0.25 4.1484635819956486 0 4.1484635819956486 0.80000001192092896 4.413848 1 4.5909750821565485;
createNode animCurveUL -n "curveBrushShape111_controlPoints_0__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_1__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_2__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_3__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_4__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_5__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_6__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_7__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_8__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_9__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_10__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_11__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_12__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_13__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode animCurveUL -n "curveBrushShape111_controlPoints_14__zValue";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  -1 0 -0.5 0 -0.25 0 0 0 0.80000001192092896 
		0 1 0;
createNode makeNurbSphere -n "makeLeftLid";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode surfaceShader -n "eyelidShader";
	setAttr ".oc" -type "float3" 0.71648347 0.71396697 0.71899998 ;
createNode shadingEngine -n "surfaceShader3SG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode makeNurbSphere -n "makeRightLid";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode nurbsTessellate -n "nurbsTessellate4";
	setAttr ".cch" yes;
	setAttr ".f" 2;
createNode nurbsTessellate -n "nurbsTessellate5";
	setAttr ".cch" yes;
	setAttr ".f" 2;
createNode unitConversion -n "unitConversion1";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion2";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion3";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion4";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion5";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "unitConversion6";
	setAttr ".cf" 0.017453292519943295;
select -ne :time1;
	setAttr ".o" 937;
select -ne :renderPartition;
	setAttr -s 6 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr ".ope" yes;
	setAttr ".oppf" yes;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "makeNurbSphere1.os" "headShape1.cr";
connectAttr "curveBrushShape111_controlPoints_0__xValue.o" "curveBrushShape111.cp[0].xv"
		;
connectAttr "curveBrushShape111_controlPoints_0__yValue.o" "curveBrushShape111.cp[0].yv"
		;
connectAttr "curveBrushShape111_controlPoints_0__zValue.o" "curveBrushShape111.cp[0].zv"
		;
connectAttr "curveBrushShape111_controlPoints_1__xValue.o" "curveBrushShape111.cp[1].xv"
		;
connectAttr "curveBrushShape111_controlPoints_1__yValue.o" "curveBrushShape111.cp[1].yv"
		;
connectAttr "curveBrushShape111_controlPoints_1__zValue.o" "curveBrushShape111.cp[1].zv"
		;
connectAttr "curveBrushShape111_controlPoints_2__xValue.o" "curveBrushShape111.cp[2].xv"
		;
connectAttr "curveBrushShape111_controlPoints_2__yValue.o" "curveBrushShape111.cp[2].yv"
		;
connectAttr "curveBrushShape111_controlPoints_2__zValue.o" "curveBrushShape111.cp[2].zv"
		;
connectAttr "curveBrushShape111_controlPoints_3__xValue.o" "curveBrushShape111.cp[3].xv"
		;
connectAttr "curveBrushShape111_controlPoints_3__yValue.o" "curveBrushShape111.cp[3].yv"
		;
connectAttr "curveBrushShape111_controlPoints_3__zValue.o" "curveBrushShape111.cp[3].zv"
		;
connectAttr "curveBrushShape111_controlPoints_4__xValue.o" "curveBrushShape111.cp[4].xv"
		;
connectAttr "curveBrushShape111_controlPoints_4__yValue.o" "curveBrushShape111.cp[4].yv"
		;
connectAttr "curveBrushShape111_controlPoints_4__zValue.o" "curveBrushShape111.cp[4].zv"
		;
connectAttr "curveBrushShape111_controlPoints_5__xValue.o" "curveBrushShape111.cp[5].xv"
		;
connectAttr "curveBrushShape111_controlPoints_5__yValue.o" "curveBrushShape111.cp[5].yv"
		;
connectAttr "curveBrushShape111_controlPoints_5__zValue.o" "curveBrushShape111.cp[5].zv"
		;
connectAttr "curveBrushShape111_controlPoints_6__xValue.o" "curveBrushShape111.cp[6].xv"
		;
connectAttr "curveBrushShape111_controlPoints_6__yValue.o" "curveBrushShape111.cp[6].yv"
		;
connectAttr "curveBrushShape111_controlPoints_6__zValue.o" "curveBrushShape111.cp[6].zv"
		;
connectAttr "curveBrushShape111_controlPoints_7__xValue.o" "curveBrushShape111.cp[7].xv"
		;
connectAttr "curveBrushShape111_controlPoints_7__yValue.o" "curveBrushShape111.cp[7].yv"
		;
connectAttr "curveBrushShape111_controlPoints_7__zValue.o" "curveBrushShape111.cp[7].zv"
		;
connectAttr "curveBrushShape111_controlPoints_8__xValue.o" "curveBrushShape111.cp[8].xv"
		;
connectAttr "curveBrushShape111_controlPoints_8__yValue.o" "curveBrushShape111.cp[8].yv"
		;
connectAttr "curveBrushShape111_controlPoints_8__zValue.o" "curveBrushShape111.cp[8].zv"
		;
connectAttr "curveBrushShape111_controlPoints_9__xValue.o" "curveBrushShape111.cp[9].xv"
		;
connectAttr "curveBrushShape111_controlPoints_9__yValue.o" "curveBrushShape111.cp[9].yv"
		;
connectAttr "curveBrushShape111_controlPoints_9__zValue.o" "curveBrushShape111.cp[9].zv"
		;
connectAttr "curveBrushShape111_controlPoints_10__xValue.o" "curveBrushShape111.cp[10].xv"
		;
connectAttr "curveBrushShape111_controlPoints_10__yValue.o" "curveBrushShape111.cp[10].yv"
		;
connectAttr "curveBrushShape111_controlPoints_10__zValue.o" "curveBrushShape111.cp[10].zv"
		;
connectAttr "curveBrushShape111_controlPoints_11__xValue.o" "curveBrushShape111.cp[11].xv"
		;
connectAttr "curveBrushShape111_controlPoints_11__yValue.o" "curveBrushShape111.cp[11].yv"
		;
connectAttr "curveBrushShape111_controlPoints_11__zValue.o" "curveBrushShape111.cp[11].zv"
		;
connectAttr "curveBrushShape111_controlPoints_12__xValue.o" "curveBrushShape111.cp[12].xv"
		;
connectAttr "curveBrushShape111_controlPoints_12__yValue.o" "curveBrushShape111.cp[12].yv"
		;
connectAttr "curveBrushShape111_controlPoints_12__zValue.o" "curveBrushShape111.cp[12].zv"
		;
connectAttr "curveBrushShape111_controlPoints_13__xValue.o" "curveBrushShape111.cp[13].xv"
		;
connectAttr "curveBrushShape111_controlPoints_13__yValue.o" "curveBrushShape111.cp[13].yv"
		;
connectAttr "curveBrushShape111_controlPoints_13__zValue.o" "curveBrushShape111.cp[13].zv"
		;
connectAttr "curveBrushShape111_controlPoints_14__xValue.o" "curveBrushShape111.cp[14].xv"
		;
connectAttr "curveBrushShape111_controlPoints_14__yValue.o" "curveBrushShape111.cp[14].yv"
		;
connectAttr "curveBrushShape111_controlPoints_14__zValue.o" "curveBrushShape111.cp[14].zv"
		;
connectAttr "expression2.out[3]" "leftEye1.sx";
connectAttr "expression2.out[4]" "leftEye1.sy";
connectAttr "expression2.out[5]" "leftEye1.sz";
connectAttr "makeNurbSphere2.os" "leftEyeShape1.cr";
connectAttr "expression2.out[0]" "rightEye1.sx";
connectAttr "expression2.out[1]" "rightEye1.sy";
connectAttr "expression2.out[2]" "rightEye1.sz";
connectAttr "leftEye1.t" "lLidParent.t";
connectAttr "leftEye1.s" "lLidParent.s";
connectAttr "unitConversion5.o" "leftEyeLid.rx";
connectAttr "makeLeftLid.os" "leftEyeLidShape.cr";
connectAttr "rightEye1.t" "rLidParent.t";
connectAttr "rightEye1.s" "rLidParent.s";
connectAttr "unitConversion6.o" "rightEyeLid.rx";
connectAttr "makeRightLid.os" "rightEyeLidShape.cr";
connectAttr ":time1.o" "hairSystemShape1.cti";
connectAttr "nurbsSphere1FollicleShape7412.oha" "hairSystemShape1.ih[4]";
connectAttr "nurbsSphere1FollicleShape7437.oha" "hairSystemShape1.ih[5]";
connectAttr "nurbsSphere1FollicleShape7462.oha" "hairSystemShape1.ih[6]";
connectAttr "nurbsSphere1FollicleShape7487.oha" "hairSystemShape1.ih[7]";
connectAttr "nurbsSphere1FollicleShape7412.ot" "nurbsSphere1Follicle7412.t" -l on
		;
connectAttr "nurbsSphere1FollicleShape7412.or" "nurbsSphere1Follicle7412.r" -l on
		;
connectAttr "headShape1.wm" "nurbsSphere1FollicleShape7412.iwm";
connectAttr "headShape1.l" "nurbsSphere1FollicleShape7412.is";
connectAttr "curveShape15.ws" "nurbsSphere1FollicleShape7412.sp";
connectAttr "nurbsSphere1FollicleShape7437.ot" "nurbsSphere1Follicle7437.t" -l on
		;
connectAttr "nurbsSphere1FollicleShape7437.or" "nurbsSphere1Follicle7437.r" -l on
		;
connectAttr "headShape1.wm" "nurbsSphere1FollicleShape7437.iwm";
connectAttr "headShape1.l" "nurbsSphere1FollicleShape7437.is";
connectAttr "curveShape16.ws" "nurbsSphere1FollicleShape7437.sp";
connectAttr "nurbsSphere1FollicleShape7462.ot" "nurbsSphere1Follicle7462.t" -l on
		;
connectAttr "nurbsSphere1FollicleShape7462.or" "nurbsSphere1Follicle7462.r" -l on
		;
connectAttr "headShape1.wm" "nurbsSphere1FollicleShape7462.iwm";
connectAttr "headShape1.l" "nurbsSphere1FollicleShape7462.is";
connectAttr "curveShape17.ws" "nurbsSphere1FollicleShape7462.sp";
connectAttr "nurbsSphere1FollicleShape7487.ot" "nurbsSphere1Follicle7487.t" -l on
		;
connectAttr "nurbsSphere1FollicleShape7487.or" "nurbsSphere1Follicle7487.r" -l on
		;
connectAttr "headShape1.wm" "nurbsSphere1FollicleShape7487.iwm";
connectAttr "headShape1.l" "nurbsSphere1FollicleShape7487.is";
connectAttr "curveShape18.ws" "nurbsSphere1FollicleShape7487.sp";
connectAttr "hairSystemShape1.orh" "pfxHairShape1.rhs";
connectAttr "brush2.obr" "pfxHairShape1.brs";
connectAttr "pfxHairShape1.omm" "pfxToonShape1.ins[0].srf";
connectAttr "pfxHairShape1.wm" "pfxToonShape1.ins[0].iwm";
connectAttr "lineModifierShape1.olm" "pfxToonShape1.lmd[0]";
connectAttr "nurbsTessellate1.op" "pfxToonShape2.ins[0].srf";
connectAttr "rightEyeShape1.wm" "pfxToonShape2.ins[0].iwm";
connectAttr "nurbsTessellate2.op" "pfxToonShape2.ins[1].srf";
connectAttr "leftEyeShape1.wm" "pfxToonShape2.ins[1].iwm";
connectAttr "nurbsTessellate3.op" "pfxToonShape2.ins[2].srf";
connectAttr "headShape1.wm" "pfxToonShape2.ins[2].iwm";
connectAttr "lineModifierShape1.olm" "pfxToonShape2.lmd[0]";
connectAttr "mouthBrush.obr" "strokeShapeMouthBrush1.brs";
connectAttr "curveFromSurfaceCoS1.oc" "strokeShapeMouthBrush1.pcv[0].crv";
connectAttr "expression2.out[12]" "strokeShapeMouthBrush1.sof";
connectAttr "brush4.obr" "|strokeBrush12|strokeShapeBrush11.brs";
connectAttr "curveFromSurfaceCoS2.oc" "|strokeBrush12|strokeShapeBrush11.pcv[0].crv"
		;
connectAttr "brush5.obr" "|strokeBrush13|strokeShapeBrush11.brs";
connectAttr "curveFromSurfaceCoS3.oc" "|strokeBrush13|strokeShapeBrush11.pcv[0].crv"
		;
connectAttr "makeNurbSphere3.os" "nurbsSphereShape4.cr";
connectAttr "strokeShapeMouthBrush1.omm" "pfxToonShape3.ins[0].srf";
connectAttr "strokeShapeMouthBrush1.wm" "pfxToonShape3.ins[0].iwm";
connectAttr "strokeShapeMouthBrush1.olm" "pfxToonShape3.ins[1].srf";
connectAttr "strokeShapeMouthBrush1.wm" "pfxToonShape3.ins[1].iwm";
connectAttr "expression1.out[0]" "lineModifierShape1.nfr";
connectAttr "expression2.out[13]" "lineModifierShape1.don";
connectAttr "expression2.out[14]" "lineModifierShape1.wsc";
connectAttr "expression2.out[15]" "lineModifierShape1.sof";
connectAttr "nurbsTessellate4.op" "pfxToonShape4.ins[0].srf";
connectAttr "rightEyeLidShape.wm" "pfxToonShape4.ins[0].iwm";
connectAttr "nurbsTessellate5.op" "pfxToonShape4.ins[1].srf";
connectAttr "leftEyeLidShape.wm" "pfxToonShape4.ins[1].iwm";
connectAttr "lineModifierShape1.olm" "pfxToonShape4.lmd[0]";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "surfaceShader1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "surfaceShader2SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "lambert2SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[5].llnk";
connectAttr "surfaceShader3SG.msg" "lightLinker1.lnk[5].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":time1.o" "brush2.tim";
connectAttr "solidShader.oc" "surfaceShader1SG.ss";
connectAttr "headShape1.iog" "surfaceShader1SG.dsm" -na;
connectAttr "surfaceShader1SG.msg" "materialInfo1.sg";
connectAttr "solidShader.msg" "materialInfo1.m";
connectAttr "solidShader.msg" "materialInfo1.t" -na;
connectAttr "solidShader1.oc" "surfaceShader2SG.ss";
connectAttr "leftEyeShape1.iog" "surfaceShader2SG.dsm" -na;
connectAttr "rightEyeShape1.iog" "surfaceShader2SG.dsm" -na;
connectAttr "surfaceShader2SG.msg" "materialInfo2.sg";
connectAttr "solidShader1.msg" "materialInfo2.m";
connectAttr "solidShader1.msg" "materialInfo2.t" -na;
connectAttr "rightEyeShape1.eta" "nurbsTessellate1.eta";
connectAttr "rightEyeShape1.cvto" "nurbsTessellate1.cvt";
connectAttr "rightEyeShape1.nufa" "nurbsTessellate1.nuf";
connectAttr "rightEyeShape1.nvfa" "nurbsTessellate1.nvf";
connectAttr "rightEyeShape1.mu" "nurbsTessellate1.ut";
connectAttr "rightEyeShape1.mv" "nurbsTessellate1.vt";
connectAttr "rightEyeShape1.nu" "nurbsTessellate1.un";
connectAttr "rightEyeShape1.nv" "nurbsTessellate1.vn";
connectAttr "rightEyeShape1.uch" "nurbsTessellate1.uch";
connectAttr "rightEyeShape1.ch" "nurbsTessellate1.cht";
connectAttr "rightEyeShape1.ucr" "nurbsTessellate1.ucr";
connectAttr "rightEyeShape1.chr" "nurbsTessellate1.chr";
connectAttr "rightEyeShape1.ues" "nurbsTessellate1.ues";
connectAttr "rightEyeShape1.esr" "nurbsTessellate1.esr";
connectAttr "rightEyeShape1.es" "nurbsTessellate1.es";
connectAttr "rightEyeShape1.l" "nurbsTessellate1.is";
connectAttr "leftEyeShape1.eta" "nurbsTessellate2.eta";
connectAttr "leftEyeShape1.cvto" "nurbsTessellate2.cvt";
connectAttr "leftEyeShape1.nufa" "nurbsTessellate2.nuf";
connectAttr "leftEyeShape1.nvfa" "nurbsTessellate2.nvf";
connectAttr "leftEyeShape1.mu" "nurbsTessellate2.ut";
connectAttr "leftEyeShape1.mv" "nurbsTessellate2.vt";
connectAttr "leftEyeShape1.nu" "nurbsTessellate2.un";
connectAttr "leftEyeShape1.nv" "nurbsTessellate2.vn";
connectAttr "leftEyeShape1.uch" "nurbsTessellate2.uch";
connectAttr "leftEyeShape1.ch" "nurbsTessellate2.cht";
connectAttr "leftEyeShape1.ucr" "nurbsTessellate2.ucr";
connectAttr "leftEyeShape1.chr" "nurbsTessellate2.chr";
connectAttr "leftEyeShape1.ues" "nurbsTessellate2.ues";
connectAttr "leftEyeShape1.esr" "nurbsTessellate2.esr";
connectAttr "leftEyeShape1.es" "nurbsTessellate2.es";
connectAttr "leftEyeShape1.l" "nurbsTessellate2.is";
connectAttr "headShape1.eta" "nurbsTessellate3.eta";
connectAttr "headShape1.cvto" "nurbsTessellate3.cvt";
connectAttr "headShape1.nufa" "nurbsTessellate3.nuf";
connectAttr "headShape1.nvfa" "nurbsTessellate3.nvf";
connectAttr "headShape1.mu" "nurbsTessellate3.ut";
connectAttr "headShape1.mv" "nurbsTessellate3.vt";
connectAttr "headShape1.nu" "nurbsTessellate3.un";
connectAttr "headShape1.nv" "nurbsTessellate3.vn";
connectAttr "headShape1.uch" "nurbsTessellate3.uch";
connectAttr "headShape1.ch" "nurbsTessellate3.cht";
connectAttr "headShape1.ucr" "nurbsTessellate3.ucr";
connectAttr "headShape1.chr" "nurbsTessellate3.chr";
connectAttr "headShape1.ues" "nurbsTessellate3.ues";
connectAttr "headShape1.esr" "nurbsTessellate3.esr";
connectAttr "headShape1.es" "nurbsTessellate3.es";
connectAttr "headShape1.l" "nurbsTessellate3.is";
connectAttr ":time1.o" "mouthBrush.tim";
connectAttr "expression2.out[16]" "mouthBrush.wsc[1].wscp";
connectAttr "expression2.out[17]" "mouthBrush.wsc[1].wscfv";
connectAttr "expression2.out[18]" "mouthBrush.wsc[1].wsci";
connectAttr "expression2.out[20]" "mouthBrush.wsc[2].wscfv";
connectAttr "expression2.out[19]" "mouthBrush.wsc[2].wscp";
connectAttr "expression2.out[21]" "mouthBrush.wsc[2].wsci";
connectAttr "expression2.out[22]" "mouthBrush.wsc[3].wscp";
connectAttr "expression2.out[23]" "mouthBrush.wsc[3].wscfv";
connectAttr "expression2.out[24]" "mouthBrush.wsc[3].wsci";
connectAttr "expression2.out[25]" "mouthBrush.nlc";
connectAttr "expression2.out[26]" "mouthBrush.lst";
connectAttr "expression2.out[27]" "mouthBrush.lln";
connectAttr "expression2.out[28]" "mouthBrush.leb";
connectAttr "expression2.out[29]" "mouthBrush.let";
connectAttr "expression2.out[30]" "mouthBrush.pln";
connectAttr "expression2.out[31]" "mouthBrush.tur";
connectAttr "expression2.out[32]" "mouthBrush.noi";
connectAttr "expression2.out[33]" "mouthBrush.wgl";
connectAttr "expression2.out[34]" "mouthBrush.wgo";
connectAttr "headShape1.ws" "curveFromSurfaceCoS1.is";
connectAttr "curveBrushShape111.ws" "curveFromSurfaceCoS1.cos";
connectAttr ":time1.o" "brush4.tim";
connectAttr "leftEyeShape1.ws" "curveFromSurfaceCoS2.is";
connectAttr "curveBrushShape131.ws" "curveFromSurfaceCoS2.cos";
connectAttr ":time1.o" "brush5.tim";
connectAttr "rightEyeShape1.ws" "curveFromSurfaceCoS3.is";
connectAttr "curveBrushShape141.ws" "curveFromSurfaceCoS3.cos";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "nurbsSphereShape4.iog" "lambert2SG.dsm" -na;
connectAttr "lambert2SG.msg" "materialInfo3.sg";
connectAttr "lambert2.msg" "materialInfo3.m";
connectAttr ":time1.o" "expression1.tim";
connectAttr "carrotTopControl.eyeSize" "expression2.in[0]";
connectAttr "carrotTopControl.blink" "expression2.in[1]";
connectAttr "carrotTopControl.autoBlink" "expression2.in[2]";
connectAttr "carrotTopControl.squint" "expression2.in[3]";
connectAttr "carrotTopControl.wink" "expression2.in[4]";
connectAttr "carrotTopControl.aggression" "expression2.in[5]";
connectAttr "carrotTopControl.lineNoise" "expression2.in[6]";
connectAttr "carrotTopControl.mouthOpen" "expression2.in[7]";
connectAttr "carrotTopControl.mouthTurbulence" "expression2.in[8]";
connectAttr "carrotTopControl.mouthNoise" "expression2.in[9]";
connectAttr "carrotTopControl.MouthOpenShift" "expression2.in[10]";
connectAttr "carrotTopControl.mouthOpenWidth" "expression2.in[11]";
connectAttr "carrotTopControl.teeth" "expression2.in[12]";
connectAttr "carrotTopControl.teethSize" "expression2.in[13]";
connectAttr "carrotTopControl.mouthCornerSize" "expression2.in[14]";
connectAttr "carrotTopControl.mouthWiggle" "expression2.in[15]";
connectAttr "carrotTopControl.wiggleOffset" "expression2.in[16]";
connectAttr ":time1.o" "expression2.tim";
connectAttr "strokeMouthBrush1.msg" "expression2.obm";
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_0__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_1__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_2__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_3__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_4__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_5__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_6__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_7__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_8__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_9__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_10__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_11__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_12__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_13__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_14__xValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_0__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_1__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_2__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_3__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_4__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_5__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_6__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_7__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_8__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_9__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_10__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_11__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_12__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_13__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_14__yValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_0__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_1__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_2__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_3__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_4__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_5__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_6__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_7__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_8__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_9__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_10__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_11__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_12__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_13__zValue.i"
		;
connectAttr "carrotTopControl.smile" "curveBrushShape111_controlPoints_14__zValue.i"
		;
connectAttr "unitConversion1.o" "makeLeftLid.ssw";
connectAttr "unitConversion2.o" "makeLeftLid.esw";
connectAttr "eyelidShader.oc" "surfaceShader3SG.ss";
connectAttr "leftEyeLidShape.iog" "surfaceShader3SG.dsm" -na;
connectAttr "rightEyeLidShape.iog" "surfaceShader3SG.dsm" -na;
connectAttr "surfaceShader3SG.msg" "materialInfo4.sg";
connectAttr "eyelidShader.msg" "materialInfo4.m";
connectAttr "eyelidShader.msg" "materialInfo4.t" -na;
connectAttr "unitConversion3.o" "makeRightLid.ssw";
connectAttr "unitConversion4.o" "makeRightLid.esw";
connectAttr "rightEyeLidShape.eta" "nurbsTessellate4.eta";
connectAttr "rightEyeLidShape.cvto" "nurbsTessellate4.cvt";
connectAttr "rightEyeLidShape.nufa" "nurbsTessellate4.nuf";
connectAttr "rightEyeLidShape.nvfa" "nurbsTessellate4.nvf";
connectAttr "rightEyeLidShape.mu" "nurbsTessellate4.ut";
connectAttr "rightEyeLidShape.mv" "nurbsTessellate4.vt";
connectAttr "rightEyeLidShape.nu" "nurbsTessellate4.un";
connectAttr "rightEyeLidShape.nv" "nurbsTessellate4.vn";
connectAttr "rightEyeLidShape.uch" "nurbsTessellate4.uch";
connectAttr "rightEyeLidShape.ch" "nurbsTessellate4.cht";
connectAttr "rightEyeLidShape.ucr" "nurbsTessellate4.ucr";
connectAttr "rightEyeLidShape.chr" "nurbsTessellate4.chr";
connectAttr "rightEyeLidShape.ues" "nurbsTessellate4.ues";
connectAttr "rightEyeLidShape.esr" "nurbsTessellate4.esr";
connectAttr "rightEyeLidShape.es" "nurbsTessellate4.es";
connectAttr "rightEyeLidShape.l" "nurbsTessellate4.is";
connectAttr "leftEyeLidShape.eta" "nurbsTessellate5.eta";
connectAttr "leftEyeLidShape.cvto" "nurbsTessellate5.cvt";
connectAttr "leftEyeLidShape.nufa" "nurbsTessellate5.nuf";
connectAttr "leftEyeLidShape.nvfa" "nurbsTessellate5.nvf";
connectAttr "leftEyeLidShape.mu" "nurbsTessellate5.ut";
connectAttr "leftEyeLidShape.mv" "nurbsTessellate5.vt";
connectAttr "leftEyeLidShape.nu" "nurbsTessellate5.un";
connectAttr "leftEyeLidShape.nv" "nurbsTessellate5.vn";
connectAttr "leftEyeLidShape.uch" "nurbsTessellate5.uch";
connectAttr "leftEyeLidShape.ch" "nurbsTessellate5.cht";
connectAttr "leftEyeLidShape.ucr" "nurbsTessellate5.ucr";
connectAttr "leftEyeLidShape.chr" "nurbsTessellate5.chr";
connectAttr "leftEyeLidShape.ues" "nurbsTessellate5.ues";
connectAttr "leftEyeLidShape.esr" "nurbsTessellate5.esr";
connectAttr "leftEyeLidShape.es" "nurbsTessellate5.es";
connectAttr "leftEyeLidShape.l" "nurbsTessellate5.is";
connectAttr "expression2.out[6]" "unitConversion1.i";
connectAttr "expression2.out[7]" "unitConversion2.i";
connectAttr "expression2.out[8]" "unitConversion3.i";
connectAttr "expression2.out[9]" "unitConversion4.i";
connectAttr "expression2.out[10]" "unitConversion5.i";
connectAttr "expression2.out[11]" "unitConversion6.i";
connectAttr "surfaceShader1SG.pa" ":renderPartition.st" -na;
connectAttr "surfaceShader2SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "surfaceShader3SG.pa" ":renderPartition.st" -na;
connectAttr "solidShader.msg" ":defaultShaderList1.s" -na;
connectAttr "solidShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "eyelidShader.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of carrotTop.ma
