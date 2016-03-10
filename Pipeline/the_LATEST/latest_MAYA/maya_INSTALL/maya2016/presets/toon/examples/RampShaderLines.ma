//Maya ASCII 7.0ff10 (Candidate) scene
//Name: rampShaderLines.ma
//Last modified: Tue, Jul 12, 2005 01:56:23 PM
requires maya "7.0ff10 (Candidate)";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 7.0";
fileInfo "version" "7.0CG";
fileInfo "cutIdentifier" "200506192018-000000";
fileInfo "osv" "Microsoft Windows XP Service Pack 1 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -6.4202603040972477 3.4501488779490752 5.8864073518549107 ;
	setAttr ".r" -type "double3" -23.738352729603402 -56.200000000001069 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 9.2443816644415762;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".col" -type "float3" 1 1 1 ;
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
createNode transform -n "strokeTeapot1";
createNode stroke -n "strokeShapeTeapot1" -p "strokeTeapot1";
	setAttr -k off ".v" no;
	setAttr ".dpc" 100;
	setAttr ".mvbs" 8040;
	setAttr ".fvbs" 2880;
	setAttr ".lvbs" 2040;
	setAttr ".mpl" 100000;
	setAttr ".usn" yes;
	setAttr ".nml" -type "double3" 0 1 0 ;
	setAttr ".pcv[0].smp" 93;
	setAttr ".ps1" 0.58540000000000003;
	setAttr ".psc[0]"  0 1 1;
createNode transform -n "curveTeapot";
	setAttr ".v" no;
createNode nurbsCurve -n "curveTeapotShape" -p "curveTeapot";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		2 91 0 no 3
		94 0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
		 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
		 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80
		 81 82 83 84 85 86 87 88 89 90 91 91
		93
		-0.55151099999999997 0 1.2510129999999999
		-0.32181300000000002 0 1.1391530000000001
		-0.12002400000000001 0 1.0108269999999999
		0.115812 0 0.90001600000000004
		0.30549999999999999 0 0.74702199999999996
		0.48266199999999998 0 0.57374800000000004
		0.66545500000000002 0 0.38469700000000001
		0.86867099999999997 0 0.17910599999999999
		1.0540529999999999 0 0.030903799999999999
		1.302152 0 -0.124042
		1.5161480000000001 0 -0.300481
		1.7390140000000001 0 -0.46980100000000002
		1.948143 0 -0.57877500000000004
		2.1234869999999999 0 -0.72912100000000002
		2.4629590000000001 0 -0.50721700000000003
		2.8470629999999999 0 -0.18394199999999999
		3.1754869999999999 0 0.16365099999999999
		3.5434779999999999 0 0.47708299999999998
		3.8808180000000001 0 0.77632199999999996
		3.8825180000000001 0 1.0415779999999999
		3.9097879999999998 0 1.345448
		3.9702999999999999 0 1.671203
		3.924747 0 1.9183749999999999
		3.7503069999999998 0 2.1117469999999998
		3.5803579999999999 0 2.270648
		3.4056700000000002 0 2.4313739999999999
		3.2102789999999999 0 2.5721829999999999
		3.0150670000000002 0 2.7060040000000001
		2.8335599999999999 0 2.8605299999999998
		2.62826 0 3.050605
		2.4676369999999999 0 3.2143959999999998
		2.3172739999999998 0 3.3707630000000002
		2.1572740000000001 0 3.5340410000000002
		1.964728 0 3.6683569999999999
		1.75715 0 3.7717909999999999
		1.6545350000000001 0 4.0141710000000002
		1.506264 0 4.2011010000000004
		1.3925829999999999 0 4.3895970000000002
		1.2594810000000001 0 4.5796939999999999
		1.082838 0 4.7291449999999999
		0.71492800000000001 0 4.5132890000000003
		0.31069200000000002 0 4.308738
		-0.097019499999999995 0 4.1480649999999999
		-0.50300900000000004 0 4.1179230000000002
		-0.86580599999999996 0 4.1028229999999999
		-1.1756310000000001 0 4.1443260000000004
		-1.4050180000000001 0 4.2477780000000003
		-1.618987 0 4.3611659999999999
		-1.9059200000000001 0 4.4066169999999998
		-2.194604 0 4.3676700000000004
		-2.4692219999999998 0 4.0176309999999997
		-2.6846939999999999 0 3.6307390000000002
		-2.8733240000000002 0 3.2465160000000002
		-3.1258020000000002 0 2.8752810000000002
		-3.412458 0 2.5112589999999999
		-3.377993 0 2.2444500000000001
		-3.3471880000000001 0 1.923116
		-3.377799 0 1.59527
		-3.3857819999999998 0 1.2707269999999999
		-3.2620360000000002 0 1.0625789999999999
		-3.2350050000000001 0 0.78236700000000003
		-3.0833650000000001 0 0.98710200000000003
		-2.852268 0 1.376851
		-2.6146660000000002 0 1.794872
		-2.3317420000000002 0 2.2413729999999998
		-1.994156 0 2.704186
		-1.6971700000000001 0 3.0804580000000001
		-1.42486 0 3.461408
		-1.113982 0 3.8371740000000001
		-0.79617400000000005 0 4.1698599999999999
		-0.41321099999999999 0 4.4576669999999998
		0.0080251799999999998 0 4.6725570000000003
		0.45353399999999999 0 4.8561610000000002
		0.837947 0 4.9981070000000001
		1.18337 0 5.1114110000000004
		1.594287 0 5.2447889999999999
		1.92675 0 5.35344
		2.2066379999999999 0 5.383273
		2.1495820000000001 0 5.0824959999999999
		1.946842 0 4.7597800000000001
		1.680261 0 4.4100830000000002
		1.3253710000000001 0 4.1279669999999999
		0.92108800000000002 0 3.9433419999999999
		0.54611500000000002 0 3.8366829999999998
		0.19275 0 3.75353
		-0.11670700000000001 0 3.7383639999999998
		-0.093139100000000002 0 3.9836939999999998
		-0.043595399999999999 0 4.2971779999999997
		-0.049296100000000002 0 4.5837750000000002
		-0.070632299999999995 0 4.8386940000000003
		-0.080880400000000005 0 5.1094020000000002
		-0.20061000000000001 0 5.311985
		-0.29184100000000002 0 5.5229569999999999
		;
createNode transform -n "teapot1MeshGroup";
createNode transform -n "teapot1Main" -p "teapot1MeshGroup";
createNode mesh -n "teapot1MainShape" -p "teapot1Main";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ds" no;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "annotationLocator1" -p "teapot1Main";
	setAttr ".t" -type "double3" -0.33626139163970947 0.89500065198342327 2.4974095597863197 ;
createNode locator -n "annotationLocator1Shape" -p "annotationLocator1";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "annotationLocator1";
	setAttr ".t" -type "double3" -2.1016934202694992 1.9176463630210492 0.73046491271381031 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Description (see attribute editor notes)";
	setAttr ".nts" -type "string" "This creates lines using a ramp shader with a facing angle technique. The color ramp on rampShader1 has a black band at around an 80 degree view angle. This moves the line in from the edge slightly so that the fill extends slightly beyond the line. The transparency on the ramp shader also ramps to fully transparent at the edge( note that the transparency on a ramp shader always indexes with facing angle ). An additional black band was required on the transparency ramp so that the line is opaque. Also the surfaces were set to singlesided to make the transparency look more like the edge of a watercolor fill.\r\n\r\nThe lines wiggle because of a noise texture bump map. The facing angle is perturbed by this, making the edge transparency and color wiggle.";
createNode transform -n "teapot1Leaf" -p "teapot1MeshGroup";
createNode mesh -n "teapot1LeafShape" -p "teapot1Leaf";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ds" no;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "teapot1Flower" -p "teapot1MeshGroup";
createNode mesh -n "teapot1FlowerShape" -p "teapot1Flower";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".ds" no;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "nurbsTorus1";
	setAttr ".t" -type "double3" -2.1284528377650438 0.57423452648488071 1.526236030503898 ;
createNode nurbsSurface -n "nurbsTorusShape1" -p "nurbsTorus1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".ds" no;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "nurbsCylinder1";
	setAttr ".t" -type "double3" -0.71733135315596575 1.0808933074544853 3.3206560262379976 ;
createNode nurbsSurface -n "nurbsCylinderShape1" -p "nurbsCylinder1";
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
createNode place3dTexture -n "place3dTexture1";
createNode lightLinker -n "lightLinker1";
	setAttr -s 6 ".lnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
	setAttr ".do" 1;
createNode brush -n "teapot1";
	setAttr ".gsc" 4.475;
	setAttr ".dep" yes;
	setAttr ".ill" yes;
	setAttr ".csd" yes;
	setAttr ".lvs" yes;
	setAttr ".flw" yes;
	setAttr ".brt" 5;
	setAttr ".bwd" 0.28048800000000002;
	setAttr ".sdn" 12.8096;
	setAttr ".sft" 0;
	setAttr ".cl1" -type "float3" 0.80992001 0.79854524 0.78886211 ;
	setAttr ".cl2" -type "float3" 0.84298003 0.82641417 0.82106256 ;
	setAttr ".spc" -type "float3" 1 0.94718665 0.72799999 ;
	setAttr ".spe" 0.6;
	setAttr ".spp" 206.71000000000001;
	setAttr ".trn" 0.3;
	setAttr ".glc" -type "float3" 0.53333336 0.53333336 0.53333336 ;
	setAttr ".gls" 1;
	setAttr ".dps" 0.6504;
	setAttr ".rll" yes;
	setAttr ".ldr" -type "double3" -0.5 -0.5 -0.5 ;
	setAttr ".grn" 1;
	setAttr ".tfl" no;
	setAttr ".tub" yes;
	setAttr ".tps" 0.070000000000000007;
	setAttr ".trd" 0;
	setAttr ".lnx" 0.40000000000000002;
	setAttr ".lnn" 0.40000000000000002;
	setAttr ".sgm" 66;
	setAttr ".tw1" 0.5;
	setAttr ".tw2" 0.5;
	setAttr ".wdb" -0.262;
	setAttr ".elm" 1;
	setAttr ".elx" 1;
	setAttr ".azn" 0;
	setAttr ".azx" 0;
	setAttr ".twd" 0;
	setAttr ".bnb" -0.2562;
	setAttr ".ddl" 0;
	setAttr ".wgf" 5;
	setAttr ".crf" 7.7661;
	setAttr ".nof" 1.26698;
	setAttr ".smd" 5;
	setAttr ".srd" 0.17476;
	setAttr ".spa" 26.214;
	setAttr ".ssd" 0.6602;
	setAttr ".slb" 0.00972;
	setAttr ".slt" 0.02912;
	setAttr ".nbr" 1;
	setAttr ".bdr" 0.26214;
	setAttr ".mbr" yes;
	setAttr ".mms" 0;
	setAttr ".cva" 0.204;
	setAttr ".tin" 2;
	setAttr ".tur" 0.004;
	setAttr ".trf" 0.2233;
	setAttr ".trs" 0.2233;
	setAttr ".dfm" -0.10000000000000001;
	setAttr ".dfx" 0.09708;
	setAttr ".tic" 3;
	setAttr ".ta1" 129.42;
	setAttr ".ta2" 55.923000000000002;
	setAttr ".ttw" 0.32040000000000002;
	setAttr ".twl" 0.5786;
	setAttr ".tst" 0.30578;
	setAttr ".ntc" 1;
	setAttr ".twb" 0.04958;
	setAttr ".twt" 0.42976;
	setAttr ".bat" yes;
	setAttr ".ll1" 59.505000000000003;
	setAttr ".ll2" 65.454;
	setAttr ".lbn" -0.7;
	setAttr ".lcl[0]"  0.33571428 0.5 1;
	setAttr ".ltwl" 1;
	setAttr ".lsg" 16;
	setAttr ".lst" 0.52066;
	setAttr ".nlc" 1;
	setAttr ".lft" -0.011560000000000001;
	setAttr ".lln" 0.103611;
	setAttr ".leb" 0.14050000000000001;
	setAttr ".let" 0.0909;
	setAttr ".lsd" 0.80700000000000005;
	setAttr ".ltr" 0.3;
	setAttr ".lsp" 0.6;
	setAttr ".lc1" -type "float3" 0.76859999 0.76859999 0.76859999 ;
	setAttr ".lc2" -type "float3" 0.76033998 0.76033998 0.76033998 ;
	setAttr ".lim" -type "string" "sideleaf.rgb";
	setAttr ".fw1" -58.014000000000003;
	setAttr ".fw2" -60.990000000000002;
	setAttr ".ftw" 0;
	setAttr ".pbn" -3.3884;
	setAttr ".pcl[0]"  0.11428571 0.5 1;
	setAttr ".psg" 23;
	setAttr ".fst" 0.6033;
	setAttr ".nfl" 1;
	setAttr ".pft" 0.33058;
	setAttr ".pln" 0.36364000000000002;
	setAttr ".ptb" 0.07438;
	setAttr ".ptt" 0.0909;
	setAttr ".fsd" 1;
	setAttr ".ftr" 0.3;
	setAttr ".fsp" 0.6033;
	setAttr ".pc1" -type "float3" 0.80166 0.80166 0.80166 ;
	setAttr ".pc2" -type "float3" 0.79338002 0.79338002 0.79338002 ;
	setAttr ".fls" 1;
	setAttr ".smp" 1;
	setAttr ".spl" 1;
	setAttr ".txt" 3;
	setAttr ".mmd" 3;
	setAttr ".dsc" 0.041320000000000003;
	setAttr ".bmi" 0.90908;
	setAttr ".bbl" 1.47108;
	setAttr ".lid" no;
	setAttr ".al1" 0;
	setAttr ".al2" 1;
	setAttr ".rpu" 0.3966;
	setAttr ".bmt" 0.9256;
	setAttr ".smr" 0.20326;
	setAttr ".imn" -type "string" "wrapBark.iff";
	setAttr ".fra" 0.52066;
	setAttr ".tbs" 30;
	setAttr ".ppl" yes;
	setAttr -s 10 ".wsc";
	setAttr ".wsc[0:1]" 0 0.0010000000474974513 3 0.85000002384185791 
		0.31999999284744263 3;
	setAttr ".wsc[3:5]" 0.40714284777641296 0.86000001430511475 3 0.092857144773006439 
		0.77999997138977051 3 1 0.0030000000260770321 3;
	setAttr ".wsc[7:11]" 0.72142857313156128 0.56000000238418579 1 0.88571429252624512 
		0.23999999463558197 3 0.93571430444717407 0.14000000059604645 3 0.97857141494750977 
		0.18000000715255737 3 0.02857142873108387 0.46000000834465027 3;
	setAttr -s 6 ".lws[0:5]"  0 1 3 0.60000002 0.74000001 3 1 0.5 
		1 0.97142857 0.66000003 1 0.22857143 0.89999998 3 0.80714285 0.69999999 
		3;
	setAttr -s 11 ".pws[0:10]"  0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 1 3 0.26428571 0.54000002 3 0.8214286 0.69999999 3 0.042857144 0.81999999 
		3 1 0.86000001 1 0.92142856 0.94 3;
	setAttr ".tls[0]"  0 1 1;
	setAttr ".nth" 100;
	setAttr ".tln" 0.28100000000000003;
	setAttr ".tbwd" 0.14049600000000001;
	setAttr ".ttwd" 0.0082640000000000005;
	setAttr ".tel" 1.00828;
	setAttr -s 7 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.37144801 0.40200001 0.37345934 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.52857142686843872;
	setAttr ".env[1].envc" -type "float3" 0.72809201 0.73951674 0.764 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0.400107 0.4425171 0.59100002 ;
	setAttr ".env[2].envi" 2;
	setAttr ".env[3].envp" 0.5;
	setAttr ".env[3].envc" -type "float3" 0.22551499 0.2326552 0.26499999 ;
	setAttr ".env[3].envi" 2;
	setAttr ".env[4].envp" 0.32857143878936768;
	setAttr ".env[4].envc" -type "float3" 0.54320502 0.63879848 0.685 ;
	setAttr ".env[4].envi" 2;
	setAttr ".env[5].envp" 0;
	setAttr ".env[5].envc" -type "float3" 0 0 0 ;
	setAttr ".env[5].envi" 0;
	setAttr ".env[6].envp" 0.71428573131561279;
	setAttr ".env[6].envc" -type "float3" 0.59761798 0.67640859 0.71399999 ;
	setAttr ".env[6].envi" 2;
	setAttr -s 4 ".rro[0:3]"  0 1 1 1 0.16 3 0.15714286 1 3 
		0.52142859 0.47999999 3;
	setAttr ".brf" 0.56198000000000004;
	setAttr ".lrf" 0.56198000000000004;
	setAttr ".frf" 0.55176;
createNode rampShader -n "rampShader1";
	setAttr ".dc" 0;
	setAttr -s 6 ".clr";
	setAttr ".clr[2].clrp" 0.99285715818405151;
	setAttr ".clr[2].clrc" -type "float3" 0.76999998 0.014373332 0 ;
	setAttr ".clr[2].clri" 1;
	setAttr ".clr[3].clrp" 0;
	setAttr ".clr[3].clrc" -type "float3" 1 0.97799999 0.99907231 ;
	setAttr ".clr[3].clri" 1;
	setAttr ".clr[5].clrp" 0.30714285373687744;
	setAttr ".clr[5].clrc" -type "float3" 0 0 0 ;
	setAttr ".clr[5].clri" 0;
	setAttr ".clr[6].clrp" 0.34285715222358704;
	setAttr ".clr[6].clrc" -type "float3" 0.87199998 0.34630719 0.090687975 ;
	setAttr ".clr[6].clri" 1;
	setAttr ".clr[7].clrp" 0.30000001192092896;
	setAttr ".clr[7].clrc" -type "float3" 0.93000001 0.4321315 0.10137003 ;
	setAttr ".clr[7].clri" 1;
	setAttr ".clr[8].clrp" 0.48571428656578064;
	setAttr ".clr[8].clrc" -type "float3" 0.86000001 0.09200453 0.07912001 ;
	setAttr ".clr[8].clri" 1;
	setAttr ".cin" 1;
	setAttr -s 6 ".it";
	setAttr ".it[1].itp" 0.80000001192092896;
	setAttr ".it[1].itc" -type "float3" 0 0 0 ;
	setAttr ".it[1].iti" 1;
	setAttr ".it[2].itp" 0;
	setAttr ".it[2].itc" -type "float3" 1 1 1 ;
	setAttr ".it[2].iti" 1;
	setAttr ".it[3].itp" 0.28571429848670959;
	setAttr ".it[3].itc" -type "float3" 1 0.58699536 0.46200001 ;
	setAttr ".it[3].iti" 1;
	setAttr ".it[4].itp" 0.33571428060531616;
	setAttr ".it[4].itc" -type "float3" 1 0.45504001 0.36000001 ;
	setAttr ".it[4].iti" 1;
	setAttr ".it[5].itp" 0.29285714030265808;
	setAttr ".it[5].itc" -type "float3" 0 0 0 ;
	setAttr ".it[5].iti" 0;
	setAttr ".it[6].itp" 0.54285717010498047;
	setAttr ".it[6].itc" -type "float3" 0.32499999 0.094040863 0.054925006 ;
	setAttr ".it[6].iti" 1;
	setAttr ".ic[0].icp" 0;
	setAttr ".ic[0].icc" -type "float3" 0 0 0 ;
	setAttr ".ic[0].ici" 1;
	setAttr ".tc" 1;
	setAttr ".trsd" 5;
	setAttr -s 2 ".sro[0:1]"  0 1 2 0.5 0.5 2;
	setAttr ".sc[0].scp" 0;
	setAttr ".sc[0].scc" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".sc[0].sci" 1;
	setAttr ".rfl[0]"  0 1 1;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
createNode shadingEngine -n "rampShader1SG";
	setAttr ".ihi" 0;
	setAttr -s 5 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode makeNurbTorus -n "makeNurbTorus1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".s" 18;
	setAttr ".nsp" 18;
	setAttr ".hr" 0.5;
createNode makeNurbCylinder -n "makeNurbCylinder1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode volumeNoise -n "volumeNoise1";
	setAttr ".ail" yes;
	setAttr ".ag" 0.019999999552965164;
	setAttr ".a" 0.66114002466201782;
	setAttr ".fq" 8.2639999389648437;
	setAttr ".nty" 0;
createNode bump3d -n "bump3d1";
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
select -ne :defaultRenderUtilityList1;
	setAttr -s 2 ".u";
select -ne :lightList1;
select -ne :defaultTextureList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderQuality;
	setAttr ".rfl" 10;
	setAttr ".rfr" 10;
	setAttr ".sl" 10;
	setAttr ".eaa" 0;
	setAttr ".ufil" yes;
	setAttr ".ss" 2;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "teapot1.obr" "strokeShapeTeapot1.brs";
connectAttr "curveTeapotShape.ws" "strokeShapeTeapot1.pcv[0].crv";
connectAttr "strokeShapeTeapot1.wmm" "teapot1MainShape.i";
connectAttr "annotationLocator1Shape.wm" "annotationShape1.dom" -na;
connectAttr "strokeShapeTeapot1.wlm" "teapot1LeafShape.i";
connectAttr "strokeShapeTeapot1.wfm" "teapot1FlowerShape.i";
connectAttr "makeNurbTorus1.os" "nurbsTorusShape1.cr";
connectAttr "makeNurbCylinder1.os" "nurbsCylinderShape1.cr";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[5].llnk";
connectAttr "rampShader1SG.msg" "lightLinker1.lnk[5].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":time1.o" "teapot1.tim";
connectAttr "bump3d1.o" "rampShader1.n";
connectAttr "rampShader1.oc" "rampShader1SG.ss";
connectAttr "teapot1FlowerShape.iog" "rampShader1SG.dsm" -na;
connectAttr "teapot1LeafShape.iog" "rampShader1SG.dsm" -na;
connectAttr "teapot1MainShape.iog" "rampShader1SG.dsm" -na;
connectAttr "nurbsCylinderShape1.iog" "rampShader1SG.dsm" -na;
connectAttr "nurbsTorusShape1.iog" "rampShader1SG.dsm" -na;
connectAttr "rampShader1SG.msg" "materialInfo4.sg";
connectAttr "rampShader1.msg" "materialInfo4.m";
connectAttr "rampShader1.msg" "materialInfo4.t" -na;
connectAttr "place3dTexture1.wim" "volumeNoise1.pm";
connectAttr "volumeNoise1.oa" "bump3d1.bv";
connectAttr "rampShader1SG.pa" ":renderPartition.st" -na;
connectAttr "rampShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "place3dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "bump3d1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "volumeNoise1.msg" ":defaultTextureList1.tx" -na;
// End of rampShaderLines.ma
