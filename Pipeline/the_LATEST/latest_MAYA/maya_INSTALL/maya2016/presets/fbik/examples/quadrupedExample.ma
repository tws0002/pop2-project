//Maya ASCII 8.5ff04 (Beta 1) scene
//Name: quadrupedExample.ma
//Last modified: Mon, Sep 18, 2006 10:26:40 PM
//Codeset: 1252
requires maya "8.5ff04 (Beta 1)";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited Forge Beta";
fileInfo "version" "8.5 Beta 2";
fileInfo "cutIdentifier" "200609071350-000000";
fileInfo "osv" "Microsoft Windows XP Professional Service Pack 2 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 33.937580516597379 58.460454896367132 58.415565715723197 ;
	setAttr ".r" -type "double3" -33.938352729603992 22.600000000000396 -4.3063792819169688e-015 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 90.588662712644975;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
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
createNode transform -n "camel_group";
createNode joint -n "hips" -p "camel_group";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" -0.00049479072913527489 26.183620452880859 -10.282029151916504 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0 0 1.6241061001019118e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 26.970952347969227 -10.282503041808209 1;
	setAttr ".dl" yes;
	setAttr ".typ" 1;
	setAttr ".radi" 0.7;
	setAttr ".hni" 1;
createNode joint -n "spine" -p "hips";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 5.0829577716841228e-006 0.44673156738266329 2.8025708198547363 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -4.9152604602607521e-005 -5.8305022205466427e-005 -0.0095627770257976016 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -89.99999999999946 -86.633539336570365 89.99999999999946 ;
	setAttr ".pa" -type "double3" -1.4651031677882296e-005 -3.3395335121570713e-005 
		-0.0095138780028962994 ;
	setAttr ".bps" -type "matrix" 2.2204460492503131e-016 0.058722021951467439 0.99827437317499601 0
		 -6.9388939039072284e-018 0.99827437317499612 -0.058722021951467439 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 0 27.417676046437993 -7.4805305219585989 1;
	setAttr ".dl" yes;
	setAttr ".typ" 6;
	setAttr ".radi" 0.7;
	setAttr ".hni" 8;
	setAttr ".liw" yes;
createNode joint -n "spine1" -p "spine";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 2.9961788778331528 6.7652521451577741e-007 4.8575177893689283e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.3579303913160849e-005 -1.2915966774196908e-005 6.8373897779578114e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -8.3905359219690592 ;
	setAttr ".pa" -type "double3" -1.5671155363394142e-006 -4.5198400492033624e-029 
		1.7017043616534145e-005 ;
	setAttr ".bps" -type "matrix" 2.2068046000887714e-016 -0.087574328611501023 0.99615798795584865 0
		 2.5536041102592532e-017 0.99615798795584876 0.087574328611501023 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 6.6528525102028851e-016 27.593617700717729 -4.489522399202901 1;
	setAttr ".dl" yes;
	setAttr ".typ" 6;
	setAttr ".radi" 0.7;
	setAttr ".hni" 23;
	setAttr ".liw" yes;
createNode joint -n "spine2" -p "spine1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 3.2145016823787227 -4.7175372621666156e-006 2.3749355353430701e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 5.1450648550043141e-006 4.3883109458822716e-005 -2.3811337677751944e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -7.2568791465601254 ;
	setAttr ".pa" -type "double3" -2.605350219717898e-005 -3.9508867621236515e-005 4.0911253928095844e-005 ;
	setAttr ".bps" -type "matrix" 2.1568709983502383e-016 -0.21270559641498993 0.9771163335313473 0
		 5.3207422317561853e-017 0.97711633353134741 0.21270559641498987 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 1.3746599879648755e-015 27.312111053870137 -1.2873842913115028 1;
	setAttr ".dl" yes;
	setAttr ".typ" 6;
	setAttr ".radi" 0.7;
	setAttr ".hni" 24;
	setAttr ".liw" yes;
createNode joint -n "neck" -p "spine2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 10.602233116250289 -1.6380360022409839 1.0108771880013023e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 5.4733293188310168e-006 -3.2982412236868594e-005 -8.6157319497048225e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 15.582820079428565 ;
	setAttr ".pa" -type "double3" 6.430416711976002e-005 -2.916047342254149e-005 -2.669980077803623e-005 ;
	setAttr ".bps" -type "matrix" 2.2205228668777798e-016 0.057596535094823487 0.99833994167571527 0
		 -6.6885575165193559e-018 0.99833994167571538 -0.057596535094823542 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.1497485022357877e-014 23.456416358991589 8.723781300441404 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 20;
	setAttr ".liw" yes;
createNode joint -n "neck1" -p "neck";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 1.7628140243797663 -0.097840232852718145 1.4321359045332827e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.0510102840306454e-005 4.4190269501853575e-005 0.00018444168865852184 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 12.270677922375246 ;
	setAttr ".pa" -type "double3" 1.6141458484548679e-006 9.6351129592685107e-005 0.00066166356966416561 ;
	setAttr ".bps" -type "matrix" 2.1555786275123656e-016 0.2684582377865361 0.96329132382916616 0
		 -5.3728601610706321e-017 0.96329132382916627 -0.26845823778653616 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.1301446612033374e-014 23.460265575235628 10.489288485866842 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 32;
	setAttr ".liw" yes;
createNode joint -n "neck2" -p "neck1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 1.7878593315707985 -0.15190731279147596 5.4956813097901102e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 5.4238458097493334e-005 9.8454185637754236e-005 0.00033994215172325368 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 27.452522392307838 ;
	setAttr ".pa" -type "double3" 1.2877341693296334e-006 0.00011471777915343378 9.1881671380307892e-006 ;
	setAttr ".bps" -type "matrix" 1.6651496377478358e-016 0.68231825035866001 0.73105526824413003 0
		 -1.4705346532470919e-016 0.73105526824413014 -0.68231825035866001 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.1104636194080921e-014 23.793899999984536 12.252299999995582 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 33;
	setAttr ".liw" yes;
createNode joint -n "neck3" -p "neck2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 1.8883603432159823 -0.45260337784383964 1.0961593892133692e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -2.4140391013323549e-006 0.00012594799270547254 -0.00011710058292895795 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 29.556963218679044 ;
	setAttr ".pa" -type "double3" 2.5581767803373169e-005 0.00014889326094722933 0.00026085570422762115 ;
	setAttr ".bps" -type "matrix" 7.2305854554563951e-017 0.95414648758716925 0.29934007453908984 0
		 -2.100567023973698e-016 0.29934007453908984 -0.95414648758716925 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.0914024756055748e-014 24.751491638051071 13.941603344769486 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 34;
	setAttr ".liw" yes;
createNode joint -n "neck4" -p "neck3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" 1.9416646241617004 -0.43577346477582662 2.1906142102995959e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -3.2133219834271287e-006 8.3669241232402717e-006 0.00091992655114084753 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 5.883350138558411 ;
	setAttr ".pa" -type "double3" -3.9050316101213449e-005 1.5410873626100085e-005 0.0013240787409622725 ;
	setAttr ".bps" -type "matrix" 5.0393451691560903e-017 0.97980405878003796 0.19996001199780888 0
		 -2.1636186089866498e-016 0.19996001199780888 -0.97980405878003796 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.0797847440029734e-014 26.47368160373281 14.938610034316937 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 35;
	setAttr ".liw" yes;
createNode joint -n "neck5" -p "neck4";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 1.7170732287420307 -0.32653275912548629 1.3851348996674062e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -4.060250680145554e-005 4.541312578457024e-005 -0.00035197764389212647 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -7.435787154842183 ;
	setAttr ".pa" -type "double3" 4.9666883255811489e-005 6.3824160774594651e-005 -0.00068265324656149092 ;
	setAttr ".bps" -type "matrix" 7.7970133464690261e-017 0.94568659930426491 0.32507976851279835 0
		 -2.0802070356678762e-016 0.32507976851279835 -0.94568659930426491 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.0719056066624529e-014 28.090779931345519 15.601911706705998 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 36;
	setAttr ".liw" yes;
createNode joint -n "neck6" -p "neck5";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 1.6152440631807785 0.16632405570084874 -3.2545045113152723e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.1271155296780189e-005 2.2200813575224633e-005 0.0003972365494399493 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -6.5895573633371978 ;
	setAttr ".pa" -type "double3" -4.0396517564476917e-005 7.9265758943546742e-005 0.00061788702978327341 ;
	setAttr ".bps" -type "matrix" 1.0132668342361708e-016 0.90213422163484835 0.43145549730567367 0
		 -1.9769890756221449e-016 0.43145549730567367 -0.90213422163484835 0 -0.99999999999999989 6.9388939039072284e-018 2.2204460492503131e-016 0
		 -1.0673187562567216e-014 29.672356727701203 15.969711706708917 1;
	setAttr ".dl" yes;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 37;
	setAttr ".liw" yes;
createNode joint -n "head" -p "neck6";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 1.7356002791208969 0.46312666553392567 1.3567762171072919e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.0012256735529949916 -7.8828194610804778e-005 0.00027993775322467259 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" -91.346772323228478 -25.734737869250051 90.584863114045817 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 179.9999999999973 88.786829793603914 115.74093004589348 ;
	setAttr ".pa" -type "double3" 0.0020154654998542775 -0.00015569781006076255 0.0004851703754282023 ;
	setAttr ".bps" -type "matrix" -2.7852531806017741e-015 0.90213422163484225 0.43145549730568633 0
		 -1.9740557469624831e-015 0.43145549730568633 -0.90213422163484225 0 -0.99999999999999989 -3.3635625084512524e-015 5.7912614883746585e-016 0
		 -1.0630817682053382e-014 31.437907925271485 16.300730307015819 1;
	setAttr ".dl" yes;
	setAttr ".typ" 8;
	setAttr ".radi" 0.7;
	setAttr ".hni" 15;
	setAttr ".liw" yes;
createNode joint -n "manidlbe" -p "head";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.6747636278503526 -0.9606636601703713 1.2912644978983694e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -141.14146449768199 ;
	setAttr ".bps" -type "matrix" 3.4073913540722421e-015 -0.97318461277683921 0.2300254539271544 0
		 -2.1027489712668742e-016 0.2300254539271544 0.97318461277683921 0 -0.99999999999999989 -3.3635625084512524e-015 5.7912614883746585e-016 0
		 -1.074292805321047e-014 31.632151668227458 17.45850834695446 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "ramus" -p "manidlbe";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 2.0062051877250671 -1.7763568394002505e-015 4.5519401352660017e-017 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 88.571694201093806 ;
	setAttr ".bps" -type "matrix" -1.2527673286586046e-016 0.20569632926565892 0.97861586954567292 0
		 -3.4115739933893216e-015 0.97861586954567292 -0.20569632926565892 0 -0.99999999999999989 -3.3635625084512524e-015 5.7912614883746585e-016 0
		 -3.9525212434138567e-015 29.679743649460352 17.919986605931928 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "lower_dent" -p "ramus";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 5.6950204966294571 -3.5527136788005009e-015 6.2227345973616145e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 11.870264531587951 90 0 ;
	setAttr ".bps" -type "matrix" 0.99999999999999989 3.3863993885344137e-015 -4.7047796177414835e-016 0
		 -3.392144989767547e-015 0.99999999999999989 1.8628987241697814e-012 0 4.6812814613475562e-016 -1.8628709685941658e-012 1 0
		 -5.2882482645718546e-015 30.851188460709718 23.493224041321398 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "forehead" -p "head";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 1.6396683892805015 -0.26309181965592593 1.0890979187257185e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -93.050494494141233 ;
	setAttr ".bps" -type "matrix" 2.1194786542807306e-015 -0.47885213068220694 0.87789557291349329 0
		 -2.6762551459485791e-015 0.87789557291349329 0.47885213068220694 0 -0.99999999999999989 -3.3635625084512524e-015 5.7912614883746585e-016 0
		 -1.4787261151731059e-014 32.803596479487602 17.245518381273044 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "maxilla" -p "forehead";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 3.5583421609652515 1.0658141036401503e-014 3.4187196120580635e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 40.567043909114318 ;
	setAttr ".bps" -type "matrix" -1.3041634050026948e-016 0.20717044190276201 0.97830486454980603 0
		 -3.4113813844685298e-015 0.97830486454980603 -0.20717044190276201 0 -0.99999999999999989 -3.3635625084512524e-015 5.7912614883746585e-016 0
		 -7.5873028581438753e-015 31.099676754013071 20.369371211295878 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "upperdent" -p "maxilla";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 3.0842715359223973 -3.5527136788005009e-015 3.3691355984293955e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -2.4326054092359382 ;
	setAttr ".bps" -type "matrix" 1.4494605988993387e-017 0.16546036138784864 0.98621644115751916 0
		 -3.4138425972158012e-015 0.98621644115751916 -0.16546036138784864 0 -0.99999999999999989 -3.3635625084512524e-015 5.7912614883746585e-016 0
		 -8.3264558248109471e-015 31.738646651058222 23.386729058481261 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "rightCollar" -p "spine2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 5.6635816195701665 1.1350426142872898 1.5569653462825415 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0001876472714278466 -9.341511483841676e-006 -0.0001164171242002511 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -68.99428907373327 15.02797018801977 125.76735558007856 ;
	setAttr ".bps" -type "matrix" 0.25929055206411272 0.88578741477613032 -0.38490137104784045 0
		 0.90161687827735248 -0.36486380591829909 -0.23229594903100539 0 -0.34620140729882842 -0.28680142774232043 -0.89324662139258992 0
		 -1.5569199999999941 27.216499999998895 4.4878900000019062 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 9;
	setAttr ".radi" 0.7;
	setAttr ".hni" 19;
	setAttr ".liw" yes;
createNode joint -n "rightArm" -p "rightCollar";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" -8.2277080834793246 0.28105923766000807 0.29476292877568078 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.10007856912537735 -0.0022547152895184106 0.012176292365428151 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 17.466628038504869 19.772434782806265 72.965649543178841 ;
	setAttr ".pa" -type "double3" 0.46102338900269135 -0.0030468453368823465 -0.010577359432861316 ;
	setAttr ".bps" -type "matrix" 0.99983273298636077 0.012919619894399048 -0.012945635202988082 0
		 0.012918537072134084 -0.99991653822795845 -0.00016726664834693095 0 -0.012946715758851299 1.8621770792037751e-012 -0.99991618776328406 0
		 -3.5388500000000436 19.741499999993636 7.3260899999880316 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 10;
	setAttr ".radi" 0.7;
	setAttr ".hni" 12;
	setAttr ".liw" yes;
createNode joint -n "rightForeArm" -p "rightArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.097489401631646544 5.5557758087637268 0.84386480319638579 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.2525819080959661 0.24770910048625269 3.0910091897674832 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -90.742344823243755 2.169075692488355 -89.287837898608842 ;
	setAttr ".pa" -type "double3" -1.4070694552527461 0.25433481718607659 2.3210219657576934 ;
	setAttr ".bps" -type "matrix" 7.7021722333370235e-015 0.9999996619149274 -0.00082229558605552487 0
		 -3.9898639947466563e-017 0.00082229558605541818 0.99999966191492717 0 1 -7.7229889150487452e-015 -6.7654215563095477e-017 0
		 -3.3805200000000779 14.187499999995213 6.4801199999777079 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".radi" 0.7;
	setAttr ".hni" 13;
	setAttr ".liw" yes;
createNode joint -n "rightHand" -p "rightForeArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" -4.8586764431553711 -2.2195167003857819e-005 -9.5563183863944801e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -3.9650456489582506 -0.17124492167296629 -8.0860334900075479 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.30999869958052301 -11.484817864476279 -3.7258250610684343 ;
	setAttr ".pa" -type "double3" -3.8923500260212243 -0.14150135284925819 -7.7067104489903668 ;
	setAttr ".bps" -type "matrix" 0.19910826868539783 0.97785355223527781 -0.064485096898060423 0
		 0.0053021404111682647 0.064726732213862673 0.99788894043574539 0 0.97996315474009721 -0.19902984830864873 0.007702910753254368 0
		 -3.3805200000001077 9.328879684382354 6.4841120438292457 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 12;
	setAttr ".radi" 0.7;
	setAttr ".hni" 14;
	setAttr ".liw" yes;
createNode joint -n "rightFingerBase" -p "rightHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" -6.9086452100529643 -3.5948482173253637e-005 -1.6294996619592439e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -35.372765778541307 0.043476205555139431 -0.0027149772334631151 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 89.902687924632659 1.2844772731181067 79.183460170496105 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -89.481498847328652 -79.185209177225929 0.77518666190962016 ;
	setAttr ".pa" -type "double3" -35.355734399330935 0.20099614069503188 -0.018852249027342883 ;
	setAttr ".bps" -type "matrix" 0.19910826868540044 0.97785355223527537 -0.064485096898090094 0
		 0.0053021404111668995 0.064726732213893259 0.99788894043574339 0 0.97996315474009665 -0.19902984830865103 0.0077029107532619731 0
		 -4.75608000000015 2.573275028482497 6.9296170939510668 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 13;
	setAttr ".radi" 0.7;
	setAttr ".hni" 22;
	setAttr ".liw" yes;
createNode joint -n "joint49" -p "rightFingerBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" -2.1050931685222549 0.82701914119643671 -0.92472174102757521 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0079772484580771449 -0.037859236810926351 -51.401997632856791 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 168.51964501046248 -0.44719444492333632 -90.675396012266944 ;
	setAttr ".pa" -type "double3" -0.0080019768740467439 -0.038191239498713676 -51.400134011431199 ;
	setAttr ".bps" -type "matrix" -6.0932162093685349e-016 -0.077799885510317995 -0.99696899541288697 0
		 -1.6736612096224235e-014 -0.99696899541288719 0.077799885510317981 0 -1 1.6792123247455493e-014 -5.8807125835613761e-016 0
		 -6.0770300000001694 0.75237769519318132 7.8835008629422436 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 82;
	setAttr ".liw" yes;
createNode joint -n "joint50" -p "joint49";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" -0.95399203931586918 9.2784544700741378e-006 2.3813065048727822e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 9.0665785524105506e-005 3.1739317850294528e-005 -5.1294305305180775e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -18.191138466817993 ;
	setAttr ".pa" -type "double3" 2.5799909116757991e-005 0.00018663194401828608 -0.0010566574721349016 ;
	setAttr ".bps" -type "matrix" 4.6461013406412209e-015 0.23733027187463951 -0.97142902059384106 0
		 -1.6090344919538313e-014 -0.97142902059384129 -0.23733027187463945 0 -1 1.6792123247455493e-014 -5.8807125835613761e-016 0
		 -6.077030000000172 0.82659708779981855 8.8345920563538431 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 83;
	setAttr ".liw" yes;
createNode joint -n "joint51" -p "joint50";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" -0.81644344527709223 -2.7472112768069301e-007 1.7763568394002505e-015 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -6.0571094974662161e-005 9.7764601979651342e-005 -3.1922922884637198e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -15.945395900922621 89.999999999999815 0 ;
	setAttr ".pa" -type "double3" -6.356153631266764e-005 0.00029100968923566735 0.00017695816994611375 ;
	setAttr ".bps" -type "matrix" 0.99999999999999978 -1.5975305697400594e-014 -2.7552876245461402e-015 0
		 -1.5859455746863293e-014 -0.99925190670784125 0.038673336302208317 0 -3.283689076236151e-015 -0.038673336302208344 -0.99925190670784092 0
		 -6.0770300000001773 0.63283060983401485 9.6277089779692702 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 84;
	setAttr ".liw" yes;
createNode joint -n "joint52" -p "rightFingerBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" -1.7063610686666557 0.83763707673201737 1.0377523938760973 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.007414412701857569 -0.035997281831974287 -51.743572392793936 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 168.51964501046248 -0.44719444492333632 -90.675396012266944 ;
	setAttr ".pa" -type "double3" -0.0075113846695191444 -0.035884151978461731 -51.742031579306946 ;
	setAttr ".bps" -type "matrix" -6.0932162093685349e-016 -0.077799885510317995 -0.99696899541288697 0
		 -1.6736612096224235e-014 -0.99696899541288719 0.077799885510317981 0 -1 1.6792123247455493e-014 -5.8807125835613761e-016 0
		 -4.0744400000001706 0.752377695193164 7.8835008629422507 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 78;
	setAttr ".liw" yes;
createNode joint -n "joint53" -p "joint52";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" -0.95398780609286504 4.4682759074987644e-006 5.5219928087879566e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.0974143489216723e-005 3.4905338486333538e-005 -0.0011934130094712338 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -18.191138466817993 ;
	setAttr ".pa" -type "double3" 7.9547982542381212e-005 0.00011718313914364205 -0.0048275676560156581 ;
	setAttr ".bps" -type "matrix" 4.6461013406412209e-015 0.23733027187463951 -0.97142902059384106 0
		 -1.6090344919538313e-014 -0.97142902059384129 -0.23733027187463945 0 -1 1.6792123247455493e-014 -5.8807125835613761e-016 0
		 -4.0744400000001733 0.82659708779980146 8.834592056353852 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 79;
	setAttr ".liw" yes;
createNode joint -n "joint54" -p "joint53";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" -0.81644064200182065 -5.5497536877169296e-007 2.0296583405077229e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.00068991149257325364 8.5182972359983952e-005 3.3604851296954383e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -15.945395900922621 89.999999999999815 0 ;
	setAttr ".pa" -type "double3" -0.0028573569402075391 -0.00018642644969406208 -4.3552958745710148e-005 ;
	setAttr ".bps" -type "matrix" 0.99999999999999978 -1.5975305697400594e-014 -2.7552876245461402e-015 0
		 -1.5859455746863293e-014 -0.99925190670784125 0.038673336302208317 0 -3.283689076236151e-015 -0.038673336302208344 -0.99925190670784092 0
		 -4.0744400000001786 0.63283060983399797 9.6277089779692773 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 80;
	setAttr ".liw" yes;
createNode joint -n "leftCollar" -p "spine2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 5.6636211540421471 1.1350458843428051 -1.5570507098049349 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.00019326157182519586 0.00099061351238121601 -0.00011333140114003099 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 28.143408984026692 3.975693351829396e-016 11.645415210482525 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -68.994289073733412 15.027970188019347 -54.232644419921485 ;
	setAttr ".pa" -type "double3" 6.442884683459635e-006 0.0015155036778494156 -0.00017099305055985457 ;
	setAttr ".bps" -type "matrix" 0.43594845666330773 -0.79390464256355719 0.42386833055668405 0
		 0.56920630860399213 0.60804228349353329 0.55343360914330664 0 -0.69710337926185439 -1.3220258221480208e-012 0.71697062605221351 0
		 1.5569178443028091 27.216498354625408 4.4878851097236581 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 9;
	setAttr ".radi" 0.7;
	setAttr ".hni" 18;
	setAttr ".liw" yes;
createNode joint -n "leftArm" -p "leftCollar";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 8.0016081908740784 -1.8462215962532049 0.65329561373768552 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.085875177425802501 -0.0023713159952117287 0.015151493678466433 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" -85.447175911264893 -80.613023509161238 86.248150671496717 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -0.70127930465630139 43.44872395990113 51.532236853460759 ;
	setAttr ".pa" -type "double3" 0.42871074819279226 0.0043075843350801144 0.032626012612220583 ;
	setAttr ".bps" -type "matrix" 8.8817841970012523e-016 0.16260067971429448 0.98669195748037253 0
		 2.4424906541753444e-015 0.98669195748037264 -0.16260067971429465 0 -1 2.55351295663786e-015 5.8286708792820718e-016 0
		 3.5388492340534383 19.741494989661494 7.3260881119727408 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 10;
	setAttr ".radi" 0.7;
	setAttr ".hni" 9;
	setAttr ".liw" yes;
createNode joint -n "leftForeArm" -p "leftArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" -1.7378291755205044 -5.3425705949080964 0.15833114609195009 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.2391318517520584 0.24765076003970254 3.1194552178414492 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 7.0195835743237771e-015 180 78.472861075879692 ;
	setAttr ".pa" -type "double3" -1.3651802660162409 0.2522245400941886 2.6153512165964137 ;
	setAttr ".bps" -type "matrix" -2.4316403619277648e-015 -0.99999966191492751 0.00082229558606686237 0
		 -4.7657221499231419e-016 -0.00082229558606691788 -0.9999996619149274 0 1 -2.4311400802465517e-015 -5.7823175170103636e-016 0
		 3.3805168767463694 14.187503635512243 6.4801159189460922 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".radi" 0.7;
	setAttr ".hni" 10;
	setAttr ".liw" yes;
createNode joint -n "leftHand" -p "leftForeArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 4.8586634787737104 9.060678600292249e-006 2.3317271042877508e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -3.9671222974010805 -0.17403959724246332 -8.0992291136035046 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.30999869956365156 -11.484817864476284 -3.7258250610684263 ;
	setAttr ".pa" -type "double3" -3.9230900088513176 -0.14486954976657984 -7.8580824739715762 ;
	setAttr ".bps" -type "matrix" 0.19910826868538839 -0.97785355223527914 0.064485096898071442 0
		 0.0053021404108786318 -0.064726732213932853 -0.99788894043574261 0 0.97996315474010065 0.19902984830862008 -0.0077029107535511255 0
		 3.3805168767463578 9.3288786796190557 6.4841111461524079 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 12;
	setAttr ".radi" 0.7;
	setAttr ".hni" 11;
	setAttr ".liw" yes;
createNode joint -n "leftFingerBase" -p "leftHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" 6.9086806243182544 4.1255593466793528e-005 1.8855900058234454e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -35.373994664317131 -0.029012697128286469 -0.00071321615797168871 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" -89.512567939945711 -1.3521043098749777 -77.677662865465209 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 87.719878515896355 -77.656687429287928 3.5796217186557571 ;
	setAttr ".pa" -type "double3" -35.45862648265237 -0.14289622871302057 -0.015665918124132181 ;
	setAttr ".bps" -type "matrix" 0.19910826868538833 -0.97785355223527981 0.064485096898061423 0
		 0.0053021404108788616 -0.064726732213922569 -0.99788894043574328 0 0.97996315474010065 0.19902984830862011 -0.0077029107535488478 0
		 4.7560769269998788 2.5732763616724545 6.929613102024839 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 13;
	setAttr ".radi" 0.7;
	setAttr ".hni" 21;
	setAttr ".liw" yes;
createNode joint -n "joint12" -p "leftFingerBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 2.1050987924763298 -0.82701085056268842 0.9247303681047514 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0092644134333211645 -0.043303089030142121 -51.352093326102697 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 168.51964501046209 -0.44719444490646437 -90.675396012266944 ;
	setAttr ".pa" -type "double3" -0.0093622158022338593 -0.04347817318650439 -51.352927431918822 ;
	setAttr ".bps" -type "matrix" -1.0009354456386177e-015 0.077799885510288658 0.99696899541288941 0
		 -8.3266726846886741e-016 0.99696899541288964 -0.077799885510288602 0 -1 -8.6042284408449632e-016 -8.066464163292153e-016 0
		 6.0770258610652217 0.75237766621115254 7.8835005191375531 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 58;
	setAttr ".liw" yes;
createNode joint -n "joint40" -p "joint12";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.95398133267236584 8.146063819544586e-016 1.7763568394002505e-015 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -2.8350380827242806e-005 -9.962919140427032e-006 3.3682692977588839e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -18.191138466817993 ;
	setAttr ".pa" -type "double3" 4.3870772712936604e-005 1.7367183456272222e-005 9.421962650642542e-005 ;
	setAttr ".bps" -type "matrix" -6.909603188742474e-016 -0.23733027187466815 0.97142902059383429 0
		 -1.103530871365356e-015 0.97142902059383451 0.23733027187466815 0 -1 -8.6042284408449632e-016 -8.066464163292153e-016 0
		 6.077025861065219 0.82659730467201598 8.8345903300145707 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 59;
	setAttr ".liw" yes;
createNode joint -n "joint41" -p "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.81643949178381092 6.8874415326547478e-006 5.73259993519315e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 6.9453779611246559e-005 -1.6086390554973217e-005 5.1431381760865443e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -15.94539590092287 90 0 ;
	setAttr ".pa" -type "double3" 5.4533139135496745e-005 0.00026829591340494607 -6.96173955172433e-005 ;
	setAttr ".bps" -type "matrix" 1 8.3407389085691579e-016 9.1449670287444937e-016 0
		 -8.157388104140112e-016 0.99925190670784236 -0.038673336302182976 0 -1.0785604415807112e-015 0.038673336302183003 0.99925190670784225 0
		 6.0770258610652199 0.6328309652822649 9.6277055268691907 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 60;
	setAttr ".liw" yes;
createNode joint -n "joint42" -p "leftFingerBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 1.7063607092712205 -0.83762321275050322 -1.0377373674328259 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.008581034620731242 -0.040949663156601722 -51.742507381791341 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 168.51964501046209 -0.44719444490646437 -90.675396012266944 ;
	setAttr ".pa" -type "double3" -0.0085443437454880995 -0.040774268369458154 -51.741117718698341 ;
	setAttr ".bps" -type "matrix" -1.0009354456386177e-015 0.077799885510288658 0.99696899541288941 0
		 -8.3266726846886741e-016 0.99696899541288964 -0.077799885510288602 0 -1 -8.6042284408449632e-016 -8.066464163292153e-016 0
		 4.0744423231322777 0.75237766621115121 7.8835005191375531 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 54;
	setAttr ".liw" yes;
createNode joint -n "joint40" -p "joint42";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.95400202181239724 2.7113734626382779e-006 4.1634280014690717e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 3.2159727752912649e-005 0.00014339755025802675 0.00013332690865194372 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -18.191138466817993 ;
	setAttr ".pa" -type "double3" 4.50844185403435e-005 0.0003663186661254916 -0.0060733910751227275 ;
	setAttr ".bps" -type "matrix" -6.909603188742474e-016 -0.23733027187466815 0.97142902059383429 0
		 -1.103530871365356e-015 0.97142902059383451 0.23733027187466815 0 -1 -8.6042284408449632e-016 -8.066464163292153e-016 0
		 4.0744423231322751 0.82659730467201464 8.8345903300145707 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 55;
	setAttr ".liw" yes;
createNode joint -n "joint41" -p "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.81642987773782671 -2.1827988367917328e-006 -7.5630721863007011e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.00011513399428203629 -0.00013902628301423051 -4.5439780623894664e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -15.94539590092287 90 0 ;
	setAttr ".pa" -type "double3" -0.0037096626768529511 -0.00035042571958600192 -0.0001469636479405195 ;
	setAttr ".bps" -type "matrix" 1 8.3407389085691579e-016 9.1449670287444937e-016 0
		 -8.157388104140112e-016 0.99925190670784236 -0.038673336302182976 0 -1.0785604415807112e-015 0.038673336302183003 0.99925190670784225 0
		 4.0744423231322759 0.63283096528226357 9.6277055268691907 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 56;
	setAttr ".liw" yes;
createNode joint -n "leftUpLeg" -p "hips";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 2.1417591571807861 -3.5522689819335938 -1.0272312164306641 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.55332006988211413 -0.086751403699225252 0.088802471411954284 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" -99.935290050891382 -80.805886483922521 100.36226567740323 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -0.015226296299518218 1.5796415921997371 -0.55233164393637202 ;
	setAttr ".pa" -type "double3" -0.54694113234587094 -0.08566660203454167 0.085946333499138244 ;
	setAttr ".bps" -type "matrix" 3.219646771412954e-015 0.15744342990648638 0.98752800789612105 0
		 -6.106226635438361e-016 0.98752800789612105 -0.15744342990648638 0 -1 -8.3266726846886741e-017 3.219646771412954e-015 0
		 2.1417031251845469 23.418688528382138 -11.309735618605885 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 2;
	setAttr ".radi" 0.7;
	setAttr ".hni" 2;
	setAttr ".liw" yes;
createNode joint -n "leftLeg" -p "leftUpLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" -0.72200071060088788 -6.4677020862605943 -1.329510656984449 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.14817847419898617 0.20525519063265468 0.93056390853277826 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 7.0195835743237771e-015 180 60.430605940803652 ;
	setAttr ".pa" -type "double3" -0.14811219737026837 0.20195879572271641 0.91674245082521622 ;
	setAttr ".bps" -type "matrix" -9.3526772283495106e-016 -0.93660579753559958 -0.35038490267519162 0
		 -3.1016440946901687e-015 0.35038490267519162 -0.93660579753559958 0 1 1.9796406791578376e-016 -3.1767384136030065e-015 0
		 3.4711938132400046 16.918036115086494 -11.004439193633077 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 3;
	setAttr ".radi" 0.7;
	setAttr ".hni" 3;
	setAttr ".liw" yes;
createNode joint -n "leftFoot" -p "leftLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 7.9355508573936921 7.450200705250154e-006 0.28067320043699118 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.12999340065956172 -0.04396884436773256 -0.44105217740991914 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -16.832620560969833 ;
	setAttr ".pa" -type "double3" 0.1276072988649023 -0.043013610502924148 -0.43575943974238235 ;
	setAttr ".bps" -type "matrix" 2.9681532372812983e-018 -0.9979400560503332 -0.064153289317523399 0
		 -3.2395853119758444e-015 0.064153289317523399 -0.9979400560503332 0 1 1.9796406791578376e-016 -3.1767384136030065e-015 0
		 3.7518759122894951 9.4855813355190115 -13.784925873759072 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 4;
	setAttr ".radi" 0.7;
	setAttr ".hni" 4;
	setAttr ".liw" yes;
createNode joint -n "leftToeBase" -p "leftFoot";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 7.5014492294218442 -1.7601086225838003e-005 1.5345661962996076 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -54.743259836247759 0.0022377542971581425 -0.00097236332038566544 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" -90.097043772013592 3.6765384370141376 -89.538122004099804 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 101.68899110005115 -89.52198647985368 -15.365139190694018 ;
	setAttr ".pa" -type "double3" -76.243557369499996 4.5775748882597937e-005 8.4752794625161821e-006 ;
	setAttr ".bps" -type "matrix" -4.3824127940314567e-015 -0.99794005605034042 -0.064153289317411724 0
		 -8.0135443178642629e-015 0.064153289317411724 -0.99794005605034042 0 1 -3.8721180671098147e-015 -8.222199944198542e-015 0
		 5.2864123428074574 1.9996556582567946 -14.266163953011663 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 5;
	setAttr ".radi" 0.7;
	setAttr ".hni" 16;
	setAttr ".liw" yes;
createNode joint -n "joint43" -p "leftToeBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 1.2649929712147028 -0.45379683411979249 -0.79596205097811268 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.031269729914860614 -0.10144864646816507 -58.510859183758647 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 7.0195835743237771e-015 180.00000000000003 84.076018712111519 ;
	setAttr ".pa" -type "double3" 0.00034870119582462158 -0.0088300577550604314 -76.260111671546738 ;
	setAttr ".bps" -type "matrix" 8.7446820509852671e-015 0.039185566695464844 0.99923195073153825 0
		 3.5319406228577285e-015 0.99923195073153825 -0.039185566695464844 0 -1 3.8847212650657905e-015 8.543581492075032e-015 0
		 4.4904564028746572 0.70815482922842499 -13.894463897091114 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 102;
	setAttr ".liw" yes;
createNode joint -n "joint40" -p "joint43";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.95398450118622158 -1.5622906965009897e-005 -4.8878134952801133e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 3.5612625283302125e-006 -0.00016420329315134828 6.6846237037615464e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -18.191138466817993 ;
	setAttr ".pa" -type "double3" 1.0900049311273107e-005 -2.6194037597726165e-005 5.1537049027199365e-005 ;
	setAttr ".bps" -type "matrix" 7.2049964332693788e-015 -0.27472112789727315 0.96152394764085325 0
		 6.0854001620922246e-015 0.96152394764085325 0.27472112789727315 0 -1 3.8847212650657905e-015 8.543581492075032e-015 0
		 4.4904564028746634 0.74553712836608721 -12.941215269083434 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 103;
	setAttr ".liw" yes;
createNode joint -n "joint41" -p "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 0.81644183701999751 -1.7348086806465157e-006 1.7346008878149632e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.015701628193063578 -1.8706079632393063e-005 1.7443139774258339e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -15.94539590092287 90 0 ;
	setAttr ".pa" -type "double3" -0.011370401458022702 2.1965175110880586e-005 -5.1116587265023643e-006 ;
	setAttr ".bps" -type "matrix" 1 -3.915221437220045e-015 -8.4368308895350968e-015 0
		 3.9274043914159271e-015 1 -1.0935696792557792e-013 0 8.4885423070295735e-015 1.0935696792557792e-013 1.0000000000000002 0
		 4.4904564028746714 0.52124333354083463 -12.156186987194728 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 104;
	setAttr ".liw" yes;
createNode joint -n "joint44" -p "leftToeBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 1.2649966631498195 -0.45379907504399902 1.0501403917603263 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.018471767928372372 -0.068151998828402074 -58.213561363631548 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 7.0195835743237771e-015 180.00000000000003 84.076018712111519 ;
	setAttr ".pa" -type "double3" 1.2586222736784553e-005 -3.0981872716555945e-006 -71.665614482302288 ;
	setAttr ".bps" -type "matrix" 8.7446820509852671e-015 0.039185566695464844 0.99923195073153825 0
		 3.5319406228577285e-015 0.99923195073153825 -0.039185566695464844 0 -1 3.8847212650657905e-015 8.543581492075032e-015 0
		 6.3365440361057139 0.70815482922841833 -13.894463897091132 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 106;
	setAttr ".liw" yes;
createNode joint -n "joint40" -p "joint44";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.95398489226115935 -1.69738759848298e-006 -1.3599680901421607e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -5.0012611644063117e-005 8.0513192259996097e-005 2.6328201065890546e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -18.191138466817993 ;
	setAttr ".pa" -type "double3" 7.7053563236531598e-006 -7.5875268396320706e-006 -4.5498325109367774e-006 ;
	setAttr ".bps" -type "matrix" 7.2049964332693788e-015 -0.27472112789727315 0.96152394764085325 0
		 6.0854001620922246e-015 0.96152394764085325 0.27472112789727315 0 -1 3.8847212650657905e-015 8.543581492075032e-015 0
		 6.3365440361057201 0.74553712836608055 -12.941215269083452 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 107;
	setAttr ".liw" yes;
createNode joint -n "joint41" -p "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 0.81644389986935018 -7.9612589895250441e-006 9.5243880871009878e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0056432921992207452 -0.00010876152631251261 1.7024367610954726e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -15.94539590092287 90 0 ;
	setAttr ".pa" -type "double3" -0.0050264341641492469 1.8831265408192497e-005 -1.8361004209599848e-005 ;
	setAttr ".bps" -type "matrix" 1 -3.915221437220045e-015 -8.4368308895350968e-015 0
		 3.9274043914159271e-015 1 -1.0935696792557792e-013 0 8.4885423070295735e-015 1.0935696792557792e-013 1.0000000000000002 0
		 6.3365440361057281 0.52124333354082797 -12.156186987194745 1;
	setAttr ".dl" yes;
	setAttr ".sd" 1;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 108;
	setAttr ".liw" yes;
createNode joint -n "joint7" -p "leftFoot";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" -0.83166541358587731 1.2322521916238138 -0.49120154652060521 ;
	setAttr ".r" -type "double3" 2.6670857381372066e-006 1.0349607515725286e-005 2.9698848759431886e-006 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".pa" -type "double3" 2.6670857381372066e-006 1.0349607515725286e-005 2.9698848759431886e-006 ;
	setAttr ".bps" -type "matrix" 2.9681532372812983e-018 -0.9979400560503332 -0.064153289317523399 0
		 -3.2395853119758444e-015 0.064153289317523399 -0.9979400560503332 0 1 1.9796406791578376e-016 -3.1767384136030065e-015 0
		 3.2606743657688861 10.39458659632942 -14.961285623043132 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "rightUpLeg" -p "hips";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" -2.1417570445887519 -3.5522803639972089 -1.0272026062011737 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.55672554433220678 -0.08729231080807065 0.086781850859727228 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 179.98477370370037 -1.579641592199718 0.5523316439363718 ;
	setAttr ".pa" -type "double3" -0.54709894425278571 -0.085844494756797243 0.085890259160295107 ;
	setAttr ".bps" -type "matrix" 0.99957352625180351 0.0096361930383182144 0.027566454256276123 0
		 0.0096325306855134553 -0.99995357081402947 0.00026564800841356081 0 0.027567734203734227 2.6710675771896009e-015 -0.99961993779179514 0
		 -2.1417000000000002 23.418700000000001 -11.309699999999999 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 2;
	setAttr ".radi" 0.7;
	setAttr ".hni" 5;
	setAttr ".liw" yes;
createNode joint -n "rightLeg" -p "rightUpLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" -1.3831770901401348 6.4877554624216245 -0.34184185616041685 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.14891332657366699 0.2068731722576376 0.93714463798389847 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -88.313421770990175 20.502713097095882 -88.85700158071505 ;
	setAttr ".pa" -type "double3" -0.14829511241679155 0.20202590513424054 0.91708724585037305 ;
	setAttr ".bps" -type "matrix" 6.9388939039072284e-018 0.93660579753560036 0.35038490267519007 0
		 -3.570060913560269e-015 -0.35038490267519007 0.93660579753560025 0 1.0000000000000002 -1.3843093338294921e-015 3.4139358007223564e-015 0
		 -3.47119 16.917999999999996 -11.004399999999981 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 3;
	setAttr ".radi" 0.7;
	setAttr ".hni" 6;
	setAttr ".liw" yes;
createNode joint -n "rightFoot" -p "rightLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" -7.935530093344366 -3.1516350638582935e-005 -0.28069488066744208 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.13153648595351314 -0.04459023101097051 -0.44400556789992834 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.4787793316728459e-006 0 -16.832620560969829 ;
	setAttr ".pa" -type "double3" 0.12766538336612437 -0.043052024009929128 -0.43589251666713524 ;
	setAttr ".bps" -type "matrix" 1.0404483632150656e-015 0.99794005605033353 0.064153289317521733 0
		 2.5809564833040834e-008 -0.064153289317521733 0.99794005605033309 0 0.99999999999999989 1.6557673146734267e-009 -2.5756398570240328e-008 0
		 -3.7518800000000012 9.4855799999999881 -13.784899999999956 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 4;
	setAttr ".radi" 0.7;
	setAttr ".hni" 7;
	setAttr ".liw" yes;
createNode joint -n "rightToeBase" -p "rightFoot";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" -7.501427817003834 -7.0301225097324505e-005 -1.534550134875539 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -54.743539591795361 -0.0028591346640018007 -0.0017280353859317242 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 89.953081289993705 -3.9238443062175894 89.329798096787485 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -86.023689219032178 -89.324962630115621 -7.8998813177856206 ;
	setAttr ".pa" -type "double3" -76.243596253390777 3.1988356301775213e-005 3.0591686425792734e-006 ;
	setAttr ".bps" -type "matrix" -1.8079842094723892e-016 0.9979400560503372 0.06415328931746539 0
		 2.5809556284323544e-008 -0.06415328931746539 0.99794005605033675 0 0.99999999999999989 1.6557679849747232e-009 -2.5756389960786012e-008 0
		 -5.2864100000000018 1.9996599999999898 -14.266199999999934 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 5;
	setAttr ".radi" 0.7;
	setAttr ".hni" 17;
	setAttr ".liw" yes;
createNode joint -n "joint59" -p "rightToeBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" -1.2650028265652296 0.45379252303375078 0.79595869644012129 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.037381346966402731 -0.12161845338214484 -58.52854092425693 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -7.0195835743237771e-015 180.00000147088227 84.076018712111207 ;
	setAttr ".pa" -type "double3" 0.00047764837368253831 -0.012432373465104658 -76.287597413454222 ;
	setAttr ".bps" -type "matrix" 1.2745185774973845e-014 -0.039185566695414245 -0.99923195073154059 0
		 2.6637751398899423e-009 -0.99923195073154047 0.03918556669541412 0 -1.0000000000000002 -2.661729601854859e-009 1.0436873038156322e-010 0
		 -4.490460000000005 0.70815500000001008 -13.894499999999848 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 126;
	setAttr ".liw" yes;
createNode joint -n "joint60" -p "joint59";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" -0.95403265348658228 2.3119484334129956e-006 -5.3290705182007514e-015 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.4480424391020308e-005 -1.34387343940715e-005 -0.0022019088659671771 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.478779335817519e-006 0 -18.191138466817989 ;
	setAttr ".pa" -type "double3" -2.1527939293048407e-005 -1.0708757733573247e-005 
		-0.00041829529324508442 ;
	setAttr ".bps" -type "matrix" -8.3158649672512107e-010 0.27472112789732184 -0.96152394764083959 0
		 -2.3278923759390807e-008 -0.96152394764083926 -0.27472112789732189 0 -1 2.2154788416549943e-008 7.1948024499242261e-009 0
		 -4.4904600000000059 0.74553700000006851 -12.941199999999853 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 127;
	setAttr ".liw" yes;
createNode joint -n "joint61" -p "joint60";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" -0.81641954074535761 2.0041248201492501e-005 3.6652143347026822e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.015416027368440395 -6.4994494766759946e-005 -2.9797901083164809e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 74.054602863394194 90.000001478779339 89.999999507073554 ;
	setAttr ".pa" -type "double3" -0.014423400401611473 -1.1878022963247361e-005 0 ;
	setAttr ".bps" -type "matrix" 1.0000000000000004 2.6617297346937221e-009 -1.0436880789254081e-010 0
		 2.6617298534472905e-009 -1.0000000000000002 3.4509309854158232e-009 0 -1.043688033527646e-010 -3.4509310409269744e-009 -1.0000000000000004 0
		 -4.4904599993210637 0.52124300000011636 -12.156199999999835 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 128;
	setAttr ".liw" yes;
createNode joint -n "joint62" -p "rightToeBase";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" -1.2650014111016716 0.45378438572107704 -1.0501405188984458 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.021773291394849455 -0.080535487563510089 -58.179456938112011 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -7.0195835743237771e-015 180.00000147088227 84.076018712111207 ;
	setAttr ".pa" -type "double3" -3.7448214166118258e-006 -3.7520009615720492e-005 
		-71.665466130817492 ;
	setAttr ".bps" -type "matrix" 1.2745185774973845e-014 -0.039185566695414245 -0.99923195073154059 0
		 2.6637751398899423e-009 -0.99923195073154047 0.03918556669541412 0 -1.0000000000000002 -2.661729601854859e-009 1.0436873038156322e-010 0
		 -6.3365400000000047 0.70815500000000942 -13.894499999999864 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 130;
	setAttr ".liw" yes;
createNode joint -n "joint63" -p "joint62";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" -0.95404114915505289 -4.0465688757179707e-006 -5.8204023645203051e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -2.4780025033294089e-005 2.3936091633547703e-005 -0.0019396932610465953 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.478779335817519e-006 0 -18.191138466817989 ;
	setAttr ".pa" -type "double3" -1.0969323910435933e-005 2.3646536784995604e-006 -0.00035807982048503459 ;
	setAttr ".bps" -type "matrix" -8.3158649672512107e-010 0.27472112789732184 -0.96152394764083959 0
		 -2.3278923759390807e-008 -0.96152394764083926 -0.27472112789732189 0 -1 2.2154788416549943e-008 7.1948024499242261e-009 0
		 -6.3365400000000047 0.74553700000006784 -12.941199999999869 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 131;
createNode joint -n "joint64" -p "joint63";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" -0.81642115303058915 1.4894658093761448e-005 4.787169232578492e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0011255162493622663 0.00017989098818079093 4.3001253079566707e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 74.054602863394194 90.000001478779339 89.999999507073554 ;
	setAttr ".pa" -type "double3" -0.0002028409932460284 2.7107540567359175e-005 1.1899135173899024e-005 ;
	setAttr ".bps" -type "matrix" 1.0000000000000004 2.6617297346937221e-009 -1.0436880789254081e-010 0
		 2.6617298534472905e-009 -1.0000000000000002 3.4509309854158232e-009 0 -1.043688033527646e-010 -3.4509310409269744e-009 -1.0000000000000004 0
		 -6.3365399993210625 0.52124300000011514 -12.156199999999851 1;
	setAttr ".dl" yes;
	setAttr ".sd" 2;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 132;
createNode joint -n "joint65" -p "rightFoot";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.83169167032834124 -1.2322982930618527 0.49121690978115939 ;
	setAttr ".r" -type "double3" 9.8171249540779779e-006 -6.8561569380781947e-006 -6.8169458316948735e-006 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.9090959104164216e-006 0 0 ;
	setAttr ".pa" -type "double3" 9.8171249540779779e-006 -6.8561569380781947e-006 -6.8169458316948735e-006 ;
	setAttr ".bps" -type "matrix" 1.0404483632150656e-015 0.99794005605033353 0.064153289317521733 0
		 5.9129574206166076e-008 -0.064153289317521636 0.99794005605033165 0 0.99999999999999845 3.7933555160500671e-009 -5.9007770591654559e-008 0
		 -3.260670000000002 10.394599999999988 -14.961299999999962 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
	setAttr ".liw" yes;
createNode joint -n "taile1" -p "hips";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" 1.8189894035458565e-012 0.059649512003009164 -1.8076987360362171 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -89.999999999999986 49.82037006301897 -89.999999999999986 ;
	setAttr ".bps" -type "matrix" 2.2204460492503131e-016 -0.64518609860756182 -0.76402545648921494 0
		 1.1102230246251565e-016 0.76402545648921505 -0.64518609860756182 0 0.99999999999999989 0 2.2204460492503131e-016 0
		 0 27.03060440702254 -12.090201864087975 1;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode joint -n "tail2" -p "taile1";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 2.0725637812393884 4.2379607305429549e-047 -4.6020160598722754e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -22.699060905848675 ;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode joint -n "tail3" -p "tail2";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 1.6209197536256967 -1.7763568394002505e-015 -1.6679161729460663e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -8.196664741119319 ;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode joint -n "tail4" -p "tail3";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 1.3019682416701235 2.6197923710891093e-032 -1.4492762943394549e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -12.29212980091247 ;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode joint -n "tail5" -p "tail4";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 1.5232930478649265 -4.4408920985006262e-016 -1.8223148671428404e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -8.1013153295240219 ;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode joint -n "tail6" -p "tail5";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 1.3727959617026371 -1.2212453270876722e-015 -1.6765296777713882e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -6.0270569253444535 ;
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode joint -n "tail7" -p "tail6";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 1.3486820103939958 -1.7763568394002505e-015 -1.8242182155082681e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".dl" yes;
	setAttr ".radi" 0.7;
createNode transform -n "humanIK1";
createNode transform -n "humanIK2";
createNode hikHandle -n "hikHandle1" -p "humanIK2";
	setAttr ".v" no;
	setAttr ".io" yes;
	setAttr -k off ".pvx";
	setAttr -k off ".pvy";
	setAttr -k off ".pvz";
	setAttr -k off ".off";
	setAttr -k off ".rol";
	setAttr -k off ".twi";
	setAttr -s 28 ".eff";
	setAttr -s 54 ".jt";
	setAttr -s 54 ".fj";
	setAttr -s 54 ".dm";
	setAttr ".dm[0]" -type "matrix" 0.99998259544372559 2.8345505498350576e-008 1.7559054654725514e-008 0
		 -2.8345752411951253e-008 0.99999129772186279 -2.4886664435366758e-016 0 -1.7559207421413703e-008 -2.4886664435366758e-016 0.99999129772186279 0
		 -0.00049479072913527489 26.183620452880859 -10.282029151916504 1;
	setAttr ".dm[1]" -type "matrix" -1.0192699164690566e-006 0.058555148541927338 0.99827975034713745 0
		 8.3073661016896949e-007 0.99828034639358521 -0.058555182069540024 0 -0.99999141693115234 7.7112849794502836e-007 -1.0661806300049648e-006 0
		 -0.00048972043441608548 26.630352020263672 -7.4794583320617676 1;
	setAttr ".dm[2]" -type "matrix" -1.3548483366321307e-006 -0.087739840149879456 0.99614846706390381 0
		 9.089759487324045e-007 0.99614912271499634 0.087739892303943634 0 -1.0000004768371582 1.0281805771228392e-006 -1.2697424836005666e-006 0
		 -0.00049349834444001317 26.805795669555664 -4.4884200096130371 1;
	setAttr ".dm[3]" -type "matrix" -6.9290274495870108e-007 -0.21286754310131073 0.97707927227020264 0
		 6.4074902184074745e-007 0.97707974910736084 0.21286764740943909 0 -1.0000001192092896 7.8231107636383967e-007 -5.3923582754578092e-007 0
		 -0.000499068817589432 26.523754119873047 -1.286323070526123 1;
	setAttr ".dm[4]" -type "matrix" -1.0709712796597159e-006 0.05742964893579483 0.99835765361785889 0
		 7.0781158001409494e-007 0.99835884571075439 -0.057429712265729904 0 -1.0000017881393433 6.4075101136040757e-007 -1.1096726666437462e-006 0
		 -0.00051571318181231618 22.666385650634766 8.7242393493652344 1;
	setAttr ".dm[5]" -type "matrix" -1.2479755184813257e-007 0.26830059289932251 0.96333807706832886 0
		 1.102688997889345e-006 0.96333837509155273 -0.2683006227016449 0 -1.0000019073486328 9.9837961897719651e-007 -4.0978267179525574e-007 0
		 -0.00052036368288099766 22.669940948486328 10.489765167236328 1;
	setAttr ".dm[6]" -type "matrix" 2.1159792140679201e-006 0.68220710754394531 0.73116844892501831 0
		 8.9407578229838691e-008 0.73116850852966309 -0.68220710754394531 0 -1.0000104904174805 1.4603289173464873e-006 1.5050328556753811e-006 0
		 -0.00052740686805918813 23.003284454345703 12.252830505371094 1;
	setAttr ".dm[7]" -type "matrix" 4.0829304452927317e-006 0.95410144329071045 0.2994941771030426 0
		 -9.2387398353821482e-007 0.29949408769607544 -0.95410060882568359 0 -1.0000097751617432 3.4869053706643172e-006 2.1755904526798986e-006 0
		 -0.00053160043898969889 23.960605621337891 13.942295074462891 1;
	setAttr ".dm[8]" -type "matrix" 4.1127304939436726e-006 0.97977763414382935 0.2001020610332489 0
		 -1.2815002037314116e-006 0.20010171830654144 -0.97977554798126221 0 -1.0000102519989014 3.6359201658342499e-006 2.1755915895482758e-006 0
		 -0.0005266586085781455 25.682634353637695 14.939581871032715 1;
	setAttr ".dm[9]" -type "matrix" 5.0365765673632268e-006 0.94563460350036621 0.32522115111351013 0
		 -2.9802238898923861e-008 0.32522127032279968 -0.94563502073287964 0 -0.99999153614044189 4.7683311095170211e-006 1.66891595654306e-006 0
		 -0.00051866885041818023 27.299638748168945 15.603099822998047 1;
	setAttr ".dm[10]" -type "matrix" 5.3942580962029751e-006 0.90207850933074951 0.43158811330795288 0
		 7.4506306191324256e-007 0.43158790469169617 -0.90207821130752563 0 -1.000009298324585 5.2452573982009199e-006 1.6093404155981261e-006 0
		 -0.00051115715177729726 28.88116455078125 15.971129417419434 1;
	setAttr ".dm[11]" -type "matrix" 8.0466355711905635e-007 0.90206384658813477 0.43160492181777954 0
		 5.9604715829664201e-008 0.43160495162010193 -0.90206396579742432 0 -1.0000005960464478 7.7486095051426673e-007 2.6822110044122383e-007 0
		 -0.00050290109356865287 30.64668083190918 16.30241584777832 1;
	setAttr ".dm[12]" -type "matrix" 0.25929006934165955 0.88585358858108521 -0.38475450873374939 0
		 0.90162003040313721 -0.36482381820678711 -0.23235435783863068 0 -0.34619879722595215 -0.28665456175804138 -0.89329653978347778 0
		 -1.5574685335159302 26.427186965942383 4.4890751838684082 1;
	setAttr ".dm[13]" -type "matrix" 0.99983519315719604 0.012711616232991219 -0.012980115599930286 0
		 0.012685693800449371 -0.99991714954376221 -0.0020768493413925171 0 -0.013005439192056656 0.0019118451746180654 -0.99991363286972046 0
		 -3.5394721031188965 18.951625823974609 7.3260998725891113 1;
	setAttr ".dm[14]" -type "matrix" -0.0040860623121261597 0.99559980630874634 0.093579873442649841 0
		 -0.021822508424520493 -0.093646839261054993 0.99536073207855225 0 0.99974846839904785 0.0020251467358320951 0.022109394893050194 0
		 -3.3824872970581055 13.399160385131836 6.4695048332214355 1;
	setAttr ".dm[15]" -type "matrix" 0.19978542625904083 0.97384130954742432 -0.10834114998579025 0
		 -0.056714989244937897 0.12187778204679489 0.99093168973922729 0 0.97820711135864258 -0.19182755053043365 0.079580321907997131 0
		 -3.3626494407653809 8.5618515014648437 6.0148077011108398 1;
	setAttr ".dm[16]" -type "matrix" 0.23076382279396057 0.72428315877914429 -0.64975643157958984 0
		 -0.037785276770591736 0.6739463210105896 0.73782795667648315 0 0.9722868800163269 -0.14571118354797363 0.18288770318031311 0
		 -4.742891788482666 1.8339862823486328 6.7632536888122559 1;
	setAttr ".dm[17]" -type "matrix" 0.051825795322656631 0.14400604367256165 -0.98822766542434692 0
		 0.012814891524612904 -0.98957216739654541 -0.14352992177009583 0 -0.99857550859451294 -0.0052253976464271545 -0.053129807114601135 0
		 -6.1590042114257812 1.0014127492904663 8.5721120834350586 1;
	setAttr ".dm[18]" -type "matrix" 0.045234676450490952 0.44573447108268738 -0.8940126895904541 0
		 0.028351770713925362 -0.89514076709747314 -0.44486239552497864 0 -0.99857413768768311 -0.0052237366326153278 -0.053129561245441437 0
		 -6.2084484100341797 0.86402487754821777 9.5148649215698242 1;
	setAttr ".dm[19]" -type "matrix" 0.99857938289642334 0.0052239862270653248 0.053131699562072754 0
		 0.014834685251116753 -0.98316496610641479 -0.18214306235313416 0 0.051285441964864731 0.18267153203487396 -0.98184055089950562 0
		 -6.2453813552856445 0.50010514259338379 10.244780540466309 1;
	setAttr ".dm[20]" -type "matrix" 0.05178181454539299 0.14990325272083282 -0.98735398054122925 0
		 0.013117757625877857 -0.98869645595550537 -0.14941911399364471 0 -0.99857091903686523 -0.0052145789377391338 -0.053161602467298508 0
		 -4.1593198776245117 1.011417031288147 8.6797771453857422 1;
	setAttr ".dm[21]" -type "matrix" 0.045097839087247849 0.45108169317245483 -0.89133542776107788 0
		 0.028628470376133919 -0.8924604058265686 -0.4502025842666626 0 -0.99857223033905029 -0.0052144820801913738 -0.053162388503551483 0
		 -4.2087292671203613 0.86840057373046875 9.6216917037963867 1;
	setAttr ".dm[22]" -type "matrix" 0.99857926368713379 0.0052136522717773914 0.053164206445217133 0
		 0.015136582776904106 -0.9820561408996582 -0.18800199031829834 0 0.051229704171419144 0.18853828310966492 -0.98073285818099976 0
		 -4.245546817779541 0.50011879205703735 10.349417686462402 1;
	setAttr ".dm[23]" -type "matrix" 0.43595167994499207 -0.79398125410079956 0.42372193932533264 0
		 0.56920605897903442 0.60794264078140259 0.55354398488998413 0 -0.6971021294593811 -0.00013333564857020974 0.71697252988815308 0
		 1.5565475225448608 26.427179336547852 4.4891161918640137 1;
	setAttr ".dm[24]" -type "matrix" -0.00010395953722763807 0.16094519197940826 0.98696523904800415 0
		 -0.00027339966618455946 0.98696571588516235 -0.16094529628753662 0 -0.99999833106994629 -0.00028657121583819389 -5.8601046475814655e-005 0
		 3.5385608673095703 18.951572418212891 7.3260021209716797 1;
	setAttr ".dm[25]" -type "matrix" -0.0040314057841897011 -0.99555325508117676 -0.093841999769210815 0
		 -0.021593602374196053 0.093909978866577148 -0.99534541368484497 0 0.99975895881652832 -0.0019864144269376993 -0.02187669463455677 0
		 3.3818778991699219 13.398908615112305 6.4706792831420898 1;
	setAttr ".dm[26]" -type "matrix" 0.19983769953250885 -0.97383028268814087 0.10835883766412735 0
		 -0.056469235569238663 -0.12185097485780716 -0.9909440279006958 0 0.97820723056793213 0.19190745055675507 -0.079341210424900055 0
		 3.3622922897338867 8.5617275238037109 6.014711856842041 1;
	setAttr ".dm[27]" -type "matrix" 0.241427943110466 -0.7245030403137207 0.6456153392791748 0
		 -0.050994817167520523 -0.67384731769561768 -0.73711520433425903 0 0.96908169984817505 0.14503616094589233 -0.19963005185127258 0
		 4.7429132461547852 1.8339171409606934 6.7632761001586914 1;
	setAttr ".dm[28]" -type "matrix" 0.068691901862621307 -0.14327037334442139 0.98729926347732544 0
		 0.01595677062869072 0.98966604471206665 0.14250360429286957 0 -0.99751073122024536 0.005965264979749918 0.070268012583255768 0
		 6.189450740814209 1.0001704692840576 8.5473489761352539 1;
	setAttr ".dm[29]" -type "matrix" 0.060276675969362259 -0.44506910443305969 0.89346140623092651 0
		 0.036604322493076324 0.89547270536422729 0.44360145926475525 0 -0.99750697612762451 0.0059657935053110123 0.070267818868160248 0
		 6.2549805641174316 0.86349523067474365 9.4892129898071289 1;
	setAttr ".dm[30]" -type "matrix" 0.99751496315002441 -0.0059649641625583172 -0.070267930626869202 0
		 0.018636010587215424 0.98329699039459229 0.18108358979225159 0 0.068013750016689301 -0.1819421648979187 0.98095959424972534 0
		 6.3041810989379883 0.50012505054473877 10.218674659729004 1;
	setAttr ".dm[31]" -type "matrix" 0.068624317646026611 -0.15001234412193298 0.98631221055984497 0
		 0.016417944803833961 0.98868119716644287 0.14923034608364105 0 -0.99752539396286011 0.0059523521922528744 0.07030981034040451 0
		 4.1919426918029785 1.0115795135498047 8.6895112991333008 1;
	setAttr ".dm[32]" -type "matrix" 0.060070868581533432 -0.45116078853607178 0.89041876792907715 0
		 0.037019863724708557 0.89242267608642578 0.44967862963676453 0 -0.99750804901123047 0.0059506334364414215 0.070310585200786591 0
		 4.2574048042297363 0.86847096681594849 9.6304416656494141 1;
	setAttr ".dm[33]" -type "matrix" 0.99751442670822144 -0.0059518739581108093 -0.070308782160282135 0
		 0.01909375935792923 0.9820326566696167 0.18776266276836395 0 0.067927561700344086 -0.18863725662231445 0.97969937324523926 0
		 4.3064470291137695 0.50012660026550293 10.357404708862305 1;
	setAttr ".dm[34]" -type "matrix" -0.0017028725706040859 0.16693851351737976 0.98596584796905518 0
		 -0.0015529637457802892 0.98596704006195068 -0.16694137454032898 0 -0.99999737739562988 -0.0018154531717300415 -0.0014197244308888912 0
		 2.141270637512207 22.631351470947266 -11.309259414672852 1;
	setAttr ".dm[35]" -type "matrix" -0.0013800339074805379 -0.93427038192749023 -0.35657820105552673 0
		 -0.0019071495626121759 0.35658025741577148 -0.93426823616027832 0 0.9999992847442627 -0.00060936925001442432 -0.002273802412673831 0
		 3.4820449352264404 16.136302947998047 -10.939515113830566 1;
	setAttr ".dm[36]" -type "matrix" 1.5914447430986911e-005 -0.99800920486450195 -0.063078880310058594 0
		 3.7908568629063666e-005 0.063079021871089935 -0.9980090856552124 0 1.0000005960464478 1.3321644473762717e-005 3.8981455872999504e-005 0
		 3.7517642974853516 8.7222347259521484 -13.769789695739746 1;
	setAttr ".dm[37]" -type "matrix" 0.001593652181327343 -0.6276276707649231 0.77851444482803345 0
		 -0.0075064166449010372 -0.77850115299224854 -0.62760180234909058 0 0.99997138977050781 -0.0048437449149787426 -0.0059516471810638905 0
		 5.2864513397216797 1.2357335090637207 -14.242895126342773 1;
	setAttr ".dm[38]" -type "matrix" 0.004055744968354702 -0.025515943765640259 0.99965286254882813 0
		 0.0055395932868123055 0.99964702129364014 0.0254933200776577 0 -0.99996191263198853 0.0054343403317034245 0.0041957092471420765 0
		 4.4959335327148437 0.79892730712890625 -12.968540191650391 1;
	setAttr ".dm[39]" -type "matrix" 0.0021208506077528 -0.33632692694664001 0.94175970554351807 0
		 0.006529003381729126 0.94174641370773315 0.33630752563476563 0 -0.9999890923500061 0.0054353722371160984 0.004193104337900877 0
		 4.4998059272766113 0.7745698094367981 -12.014874458312988 1;
	setAttr ".dm[40]" -type "matrix" 0.99997931718826294 -0.0054350551217794418 -0.004192716907709837 0
		 0.0056937206536531448 0.99791246652603149 0.06437208503484726 0 0.0038340883329510689 -0.064394444227218628 0.99792003631591797 0
		 4.5015363693237305 0.49998128414154053 -11.24599552154541 1;
	setAttr ".dm[41]" -type "matrix" 0.0046627870760858059 -0.020331863313913345 0.99978899955749512 0
		 0.0052860374562442303 0.99978655576705933 0.020307159051299095 0 -0.99997937679290771 0.0051901917904615402 0.0047692237421870232 0
		 6.3419861793518066 0.78998363018035889 -12.979524612426758 1;
	setAttr ".dm[42]" -type "matrix" 0.0027809292078018188 -0.33143842220306396 0.94348567724227905 0
		 0.006478418130427599 0.94347578287124634 0.3314158022403717 0 -0.99998319149017334 0.0051906220614910126 0.0047708661295473576 0
		 6.3464341163635254 0.77058517932891846 -12.025747299194336 1;
	setAttr ".dm[43]" -type "matrix" 0.99998939037322998 -0.0051904129795730114 -0.0047689736820757389 0
		 0.0054642162285745144 0.99822986125946045 0.059327881783246994 0 0.0044525451958179474 -0.059352636337280273 0.99823629856109619 0
		 6.3487014770507812 0.49997970461845398 -11.255456924438477 1;
	setAttr ".dm[44]" -type "matrix" 0.9996451735496521 0.0081217838451266289 0.026044286787509918 0
		 0.0078651178628206253 -0.999919593334198 0.0099371280521154404 0 0.026122454553842545 -0.0097285928204655647 -0.99961143732070923 0
		 -2.1422543525695801 22.631340026855469 -11.309232711791992 1;
	setAttr ".dm[45]" -type "matrix" -0.0014365284005180001 0.93424373865127563 0.35662630200386047 0
		 -0.0018998036393895745 -0.35662832856178284 0.93424171209335327 0 0.99999469518661499 0.00066467950819060206 0.0022873820271342993 0
		 -3.4828164577484131 16.136203765869141 -10.939074516296387 1;
	setAttr ".dm[46]" -type "matrix" -2.9265911507536657e-005 0.99800944328308105 0.063081808388233185 0
		 5.5045125918695703e-005 -0.063082039356231689 0.99801266193389893 0 1.0000007152557373 3.263356484239921e-005 -5.3107774874661118e-005 0
		 -3.7521111965179443 8.7222871780395508 -13.769772529602051 1;
	setAttr ".dm[47]" -type "matrix" 0.0036067124456167221 0.62764674425125122 -0.7784760594367981 0
		 -0.010213740170001984 0.77846366167068481 0.62758934497833252 0 0.99993270635604858 0.0056877238675951958 0.0092184487730264664 0
		 -5.28643798828125 1.235748291015625 -14.242962837219238 1;
	setAttr ".dm[48]" -type "matrix" 0.006945975124835968 0.025859696790575981 -0.99965119361877441 0
		 0.0065765785984694958 -0.99965381622314453 -0.025814071297645569 0 -0.99996447563171387 -0.0063949297182261944 -0.0071133500896394253 0
		 -4.4997215270996094 0.7995573878288269 -12.966041564941406 1;
	setAttr ".dm[49]" -type "matrix" 0.0045450972393155098 0.33668076992034912 -0.94160908460617065 0
		 0.0084159905090928078 -0.94159817695617676 -0.33663627505302429 0 -0.99995243549346924 -0.0063945082947611809 -0.0071130855940282345 0
		 -4.5063486099243164 0.77488446235656738 -12.012351036071777 1;
	setAttr ".dm[50]" -type "matrix" 0.99995672702789307 0.0063951481133699417 0.0071120625361800194 0
		 0.0068422821350395679 -0.99787890911102295 -0.064735375344753265 0 0.0066829696297645569 0.064781084656715393 -0.99787712097167969 0
		 -4.510063648223877 0.49999311566352844 -11.243611335754395 1;
	setAttr ".dm[51]" -type "matrix" 0.0076988688670098782 0.019772682338953018 -0.99977940320968628 0
		 0.0062487884424626827 -0.99979060888290405 -0.019724784418940544 0 -0.99995654821395874 -0.0060955304652452469 -0.0078207701444625854 0
		 -6.3457136154174805 0.78905069828033447 -12.983065605163574 1;
	setAttr ".dm[52]" -type "matrix" 0.0053634527139365673 0.33094045519828796 -0.94364595413208008 0
		 0.0083405934274196625 -0.94364094734191895 -0.33089137077331543 0 -0.99996542930603027 -0.0060958703979849815 -0.0078211966902017593 0
		 -6.3530588150024414 0.77019041776657104 -12.029238700866699 1;
	setAttr ".dm[53]" -type "matrix" 0.99996232986450195 0.0060949008911848068 0.0078244572505354881 0
		 0.0065453280694782734 -0.99824684858322144 -0.058900725096464157 0 0.0074516581371426582 0.058949027210474014 -0.99823737144470215 0
		 -6.3574428558349609 0.49999159574508667 -11.258838653564453 1;
	setAttr -s 54 ".sm";
	setAttr ".sm[0]" -type "matrix" 0.9999997615814209 -5.7104852402289907e-008 -2.961694889336286e-008 0
		 -2.961694889336286e-008 1.1920927533992653e-007 -0.99999988079071045 0 5.7104863060430944e-008 0.99999988079071045 1.1920927533992653e-007 0
		 -0.00048065185546875 26.183620452880859 -10.282027244567871 1;
	setAttr ".sm[1]" -type "matrix" -1.1324883644192596e-006 0.99828439950942993 -0.058555580675601959 0
		 1.7881399116959074e-007 -0.058555446565151215 -0.99828463792800903 0 -1.0000001192092896 -1.2516975402832031e-006 0 0
		 -0.00047537294449284673 28.986190795898438 -10.728758811950684 1;
	setAttr ".sm[2]" -type "matrix" -1.5199187828329741e-006 0.99614369869232178 0.087740056216716766 0
		 8.0466281815461116e-007 0.08774007111787796 -0.99614357948303223 0 -1 -1.4901161193847656e-006 -8.9406967163085938e-007 0
		 -0.00047899960190989077 31.977228164672852 -10.904202461242676 1;
	setAttr ".sm[3]" -type "matrix" -2.0861625671386719e-006 0.97708094120025635 0.21286800503730774 0
		 3.5762795391747204e-007 0.21286801993846893 -0.97708117961883545 0 -1 -1.9669532775878906e-006 -8.0466270446777344e-007 0
		 -0.0004844077629968524 35.1793212890625 -10.622162818908691 1;
	setAttr ".sm[4]" -type "matrix" -2.0861627945123473e-006 0.99834972620010376 -0.057430095970630646 0
		 5.9604651880817983e-008 -0.057430066168308258 -0.99834972620010376 0 -0.99999988079071045 -2.1457669845403871e-006 1.1920927533992653e-007 0
		 -0.00050054211169481277 45.189872741699219 -6.7647981643676758 1;
	setAttr ".sm[5]" -type "matrix" -7.7486049576691585e-007 0.96333569288253784 -0.26829949021339417 0
		 7.7486038208007813e-007 -0.26829946041107178 -0.96333557367324829 0 -1.0000001192092896 -9.5367443009308772e-007 -4.7683721504654386e-007 0
		 -0.00050510326400399208 46.955398559570312 -6.7683534622192383 1;
	setAttr ".sm[6]" -type "matrix" 1.072883719643869e-006 0.73116415739059448 -0.6822018027305603 0
		 1.2814999763577362e-006 -0.6822018027305603 -0.73116415739059448 0 -1.0000004768371582 -1.4901166878189542e-007 -1.5497213325943449e-006 0
		 -0.00051205750787630677 48.718463897705078 -7.1016969680786133 1;
	setAttr ".sm[7]" -type "matrix" 3.7550926208496094e-006 0.29949331283569336 -0.95409846305847168 0
		 1.1920927533992653e-007 -0.95409828424453735 -0.29949328303337097 0 -1.0000002384185791 9.8347675248078303e-007 -3.3974652069446165e-006 0
		 -0.00051616632845252752 50.407928466796875 -8.0590143203735352 1;
	setAttr ".sm[8]" -type "matrix" 3.2782554626464844e-006 0.20009949803352356 -0.97977566719055176 0
		 -2.011656192735245e-007 -0.97977524995803833 -0.20009943842887878 0 -1.0000003576278687 8.270146167888015e-007 -2.920628276115167e-006 0
		 -0.00051117560360580683 51.405216217041016 -9.7810430526733398 1;
	setAttr ".sm[9]" -type "matrix" 4.3511381591088139e-006 0.32522207498550415 -0.94563758373260498 0
		 3.1292435664909135e-007 -0.94563758373260498 -0.32522210478782654 0 -1 1.0877846534640412e-006 -3.993510745203821e-006 0
		 -0.00050315359840169549 52.068733215332031 -11.39804744720459 1;
	setAttr ".sm[10]" -type "matrix" 5.1856059144483879e-006 0.43158438801765442 -0.90207308530807495 0
		 1.1175875442859251e-006 -0.9020729660987854 -0.43158441781997681 0 -1.0000007152557373 1.1920935776288388e-006 -5.0067933443642687e-006 0
		 -0.00049562467029318213 52.436763763427734 -12.979573249816895 1;
	setAttr ".sm[11]" -type "matrix" -1.1920928955078125e-007 0.90206313133239746 0.43160414695739746 0
		 7.4505805969238281e-007 0.43160414695739746 -0.90206313133239746 0 -1 2.0861625671386719e-007 -7.4505805969238281e-007 0
		 -0.00048735339078120887 52.768047332763672 -14.745089530944824 1;
	setAttr ".sm[12]" -type "matrix" 0.88585120439529419 -0.38475364446640015 0.25929194688796997 0
		 -0.36482587456703186 -0.2323547899723053 0.90161722898483276 0 -0.28665274381637573 -0.89329499006271362 -0.34619981050491333 0
		 -1.5574287176132202 40.95458984375 -10.525594711303711 1;
	setAttr ".sm[13]" -type "matrix" 0.012707655318081379 -0.99983537197113037 -0.012981952168047428 0
		 -0.99991774559020996 -0.0126839280128479 -0.0019059120677411556 0 0.0017409357242286205 0.013005100190639496 -0.99991393089294434 0
		 -9.0329647064208984 43.791622161865234 -12.507597923278809 1;
	setAttr ".sm[14]" -type "matrix" 0.99558651447296143 0.093762435019016266 -0.004082895815372467 0
		 -0.09382946789264679 0.99535030126571655 -0.021771484985947609 0 0.0020225632470101118 0.022058485075831413 0.99975472688674927 0
		 -14.585554122924805 43.6346435546875 -13.363239288330078 1;
	setAttr ".sm[15]" -type "matrix" 0.97383522987365723 -0.10831449925899506 0.19978456199169159 0
		 0.12184032052755356 0.99093127250671387 -0.05666186660528183 0 -0.19183541834354401 0.079521119594573975 0.97820067405700684 0
		 -19.422767639160156 43.1790771484375 -13.343419075012207 1;
	setAttr ".sm[16]" -type "matrix" 0.7242966890335083 -0.64972764253616333 0.23075687885284424 0
		 0.67391502857208252 0.73784244060516357 -0.037779338657855988 0 -0.14571590721607208 0.18287394940853119 0.97227799892425537 0
		 -26.150629043579102 43.927364349365234 -14.723659515380859 1;
	setAttr ".sm[17]" -type "matrix" 0.14403644204139709 -0.98821538686752319 0.051819957792758942 0
		 -0.9895591139793396 -0.14356015622615814 0.012813505716621876 0 -0.0052232104353606701 -0.053124476224184036 -0.99857449531555176 0
		 -26.983261108398438 45.7362060546875 -16.139759063720703 1;
	setAttr ".sm[18]" -type "matrix" 0.44576776027679443 -0.89400547742843628 0.045230086892843246 0
		 -0.895133376121521 -0.44489571452140808 0.028350131586194038 0 -0.0052224989049136639 -0.053124543279409409 -0.99857449531555176 0
		 -27.12067985534668 46.678955078125 -16.189197540283203 1;
	setAttr ".sm[19]" -type "matrix" 0.0052225026302039623 0.053124874830245972 0.99857485294342041 0
		 -0.98315471410751343 -0.18217407166957855 0.014833573251962662 0 0.1827024519443512 -0.98183053731918335 0.051278609782457352 0
		 -27.484622955322266 47.408859252929688 -16.226125717163086 1;
	setAttr ".sm[20]" -type "matrix" 0.14993298053741455 -0.98733967542648315 0.051776360720396042 0
		 -0.98868280649185181 -0.14944884181022644 0.013116582296788692 0 -0.0052125961519777775 -0.053156968206167221 -0.99857223033905029 0
		 -26.973260879516602 45.843856811523438 -14.14007568359375 1;
	setAttr ".sm[21]" -type "matrix" 0.45111271739006042 -0.891326904296875 0.045093055814504623 0
		 -0.89245176315307617 -0.45023378729820251 0.028625274077057838 0 -0.0052120573818683624 -0.053156610578298569 -0.99857258796691895 0
		 -27.116308212280273 46.7857666015625 -14.189479827880859 1;
	setAttr ".sm[22]" -type "matrix" 0.0052120708860456944 0.053155984729528427 0.9985731840133667 0
		 -0.98204630613327026 -0.18803277611732483 0.015135051682591438 0 0.18856897950172424 -0.98072344064712524 0.051221676170825958 0
		 -27.484613418579102 47.513481140136719 -14.226293563842773 1;
	setAttr ".sm[23]" -type "matrix" 0.79398143291473389 0.4237220287322998 -0.43595007061958313 0
		 -0.6079413890838623 0.5535433292388916 -0.56920677423477173 0 0.00013178582594264299 0.7169719934463501 0.69710159301757813 0
		 1.5565026998519897 40.954757690429688 -10.525588989257812 1;
	setAttr ".sm[24]" -type "matrix" -0.16107754409313202 -0.00010266901517752558 0.9869418740272522 0
		 -0.98694181442260742 -0.00027763846446759999 -0.16107757389545441 0 0.00029057261417619884 -0.99999982118606567 -5.6564800615888089e-005 0
		 9.0320920944213867 43.791652679443359 -12.507586479187012 1;
	setAttr ".sm[25]" -type "matrix" 0.99556297063827515 -0.094000130891799927 0.0040259505622088909 0
		 -0.094065509736537933 -0.99533241987228394 0.021550374105572701 0 0.001981423469260335 -0.021833483129739761 -0.99975937604904175 0
		 14.584863662719727 43.634986877441406 -13.362159729003906 1;
	setAttr ".sm[26]" -type "matrix" 0.97382336854934692 0.1083265095949173 -0.19983889162540436 0
		 0.12181048095226288 -0.9909483790397644 0.056424908339977264 0 -0.19191752374172211 -0.07929026335477829 -0.97820276021957397 0
		 19.421962738037109 43.178268432617188 -13.342602729797363 1;
	setAttr ".sm[27]" -type "matrix" 0.72452050447463989 0.64558959007263184 -0.24142515659332275 0
		 0.67381995916366577 -0.73713409900665283 0.050989545881748199 0 -0.14504434168338776 -0.19961996376514435 -0.96907931566238403 0
		 26.149774551391602 43.926624298095703 -14.723236083984375 1;
	setAttr ".sm[28]" -type "matrix" 0.14330239593982697 0.98729252815246582 -0.068685583770275116 0
		 -0.98966056108474731 0.14253625273704529 -0.015953106805682182 0 -0.0059601948596537113 0.070261552929878235 0.99751055240631104 0
		 26.983577728271484 45.710678100585938 -16.169765472412109 1;
	setAttr ".sm[29]" -type "matrix" 0.44510063529014587 0.89344942569732666 -0.060273274779319763 0
		 -0.89546036720275879 0.44363340735435486 -0.036598950624465942 0 -0.0059600714594125748 0.070262566208839417 0.99751037359237671 0
		 27.120285034179688 46.652538299560547 -16.23529052734375 1;
	setAttr ".sm[30]" -type "matrix" 0.0059607010334730148 -0.070262320339679718 -0.99751049280166626 0
		 -0.98328524827957153 0.18111473321914673 -0.01863294281065464 0 0.18197304010391235 0.98094862699508667 -0.068008311092853546 0
		 27.483678817749023 47.381988525390625 -16.284488677978516 1;
	setAttr ".sm[31]" -type "matrix" 0.15004362165927887 0.98629599809646606 -0.068617679178714752 0
		 -0.98866242170333862 0.14926159381866455 -0.016415033489465714 0 -0.0059481007046997547 0.070302650332450867 0.9975089430809021 0
		 26.972177505493164 45.852828979492188 -14.172255516052246 1;
	setAttr ".sm[32]" -type "matrix" 0.45119193196296692 0.89040344953536987 -0.060064766556024551 0
		 -0.89240700006484985 0.44971022009849548 -0.037015672773122787 0 -0.0059471474960446358 0.070303395390510559 0.99750804901123047 0
		 27.115318298339844 46.793754577636719 -14.237711906433105 1;
	setAttr ".sm[33]" -type "matrix" 0.0059480988420546055 -0.070302359759807587 -0.99750840663909912 0
		 -0.98202300071716309 0.18779478967189789 -0.019091133028268814 0 0.18866890668869019 0.97968924045562744 -0.067921437323093414 0
		 27.483686447143555 47.520706176757813 -14.286750793457031 1;
	setAttr ".sm[34]" -type "matrix" -0.0017022431129589677 0.16693052649497986 0.98596692085266113 0
		 -0.0015510617522522807 0.98596692085266113 -0.16693319380283356 0 -0.99999737739562988 -0.0018134638667106628 -0.0014194352552294731 0
		 2.1412794589996338 25.156389236450195 -6.7297582626342773 1;
	setAttr ".sm[35]" -type "matrix" -0.0013800564920529723 -0.93426764011383057 -0.35657081007957458 0
		 -0.0019079744815826416 0.35657292604446411 -0.9342656135559082 0 0.99999707937240601 -0.00060909974854439497 -0.002274602185934782 0
		 3.4820389747619629 18.661342620849609 -6.3600673675537109 1;
	setAttr ".sm[36]" -type "matrix" 1.5854835510253906e-005 -0.063077628612518311 0.99800872802734375 0
		 3.5218890843680128e-005 -0.99800848960876465 -0.063077621161937714 0 1.0000001192092896 3.6139041185379028e-005 -1.3291835784912109e-005 0
		 3.7517671585083008 11.247258186340332 -9.1902942657470703 1;
	setAttr ".sm[37]" -type "matrix" 0.0015937085263431072 0.77851271629333496 0.62762635946273804 0
		 -0.0075065195560455322 -0.62760031223297119 0.7784995436668396 0 0.99997031688690186 -0.0059519992209970951 0.0048437109217047691 0
		 5.2864456176757813 10.774147033691406 -1.7038278579711914 1;
	setAttr ".sm[38]" -type "matrix" 0.0040539195761084557 0.99966597557067871 0.025517279282212257 0
		 0.0055400128476321697 0.025494690984487534 -0.99965953826904297 0 -0.99997615814208984 0.0041939006187021732 -0.005434779915958643 0
		 4.4959297180175781 12.048501014709473 -1.2670207023620605 1;
	setAttr ".sm[39]" -type "matrix" 0.0021216582972556353 0.94174492359161377 0.33632278442382813 0
		 0.0065280832350254059 0.33630326390266418 -0.94173163175582886 0 -0.9999767541885376 0.0041936351917684078 -0.005434306338429451 0
		 4.4998016357421875 13.002166748046875 -1.2426619529724121 1;
	setAttr ".sm[40]" -type "matrix" 0.99997711181640625 -0.0041923443786799908 0.0054344921372830868 0
		 0.0056931376457214355 0.064372576773166656 -0.9979102611541748 0 0.0038337488658726215 0.9979177713394165 0.064394935965538025 0
		 4.5015320777893066 13.771045684814453 -0.96807253360748291 1;
	setAttr ".sm[41]" -type "matrix" 0.0046608755365014076 0.99978268146514893 0.020333146676421165 0
		 0.0052856225520372391 0.020308442413806915 -0.99978017807006836 0 -0.99997520446777344 0.0047672688961029053 -0.0051897764205932617 0
		 6.3419780731201172 12.037517547607422 -1.2580779790878296 1;
	setAttr ".sm[42]" -type "matrix" 0.0027783229015767574 0.94347435235977173 0.33143576979637146 0
		 0.0064770611934363842 0.33141317963600159 -0.94346415996551514 0 -0.99997538328170776 0.0047678654082119465 -0.0051901047118008137 0
		 6.3464255332946777 12.991294860839844 -1.2386785745620728 1;
	setAttr ".sm[43]" -type "matrix" 0.99997568130493164 -0.0047685485333204269 0.005189795047044754 0
		 0.0054636173881590366 0.059327855706214905 -0.99822378158569336 0 0.0044521787203848362 0.99822759628295898 0.059352453798055649 0
		 6.3486928939819336 13.761585235595703 -0.96807277202606201 1;
	setAttr ".sm[44]" -type "matrix" 0.99962884187698364 0.0081213628873229027 0.0260439682751894 0
		 0.007864917628467083 -0.999919593334198 0.0099337315186858177 0 0.026122530922293663 -0.0097252018749713898 -0.99961143732070923 0
		 -2.1422278881072998 25.156417846679688 -6.7297463417053223 1;
	setAttr ".sm[45]" -type "matrix" -0.0014359354972839355 0.93424677848815918 0.35662457346916199 0
		 -0.0019017751328647137 -0.35662662982940674 0.93424487113952637 0 0.99999713897705078 0.00066345924278721213 0.0022890565451234579 0
		 -3.4827890396118164 18.661283493041992 -6.359611988067627 1;
	setAttr ".sm[46]" -type "matrix" -2.7792990294983611e-005 0.063081525266170502 -0.99800825119018555 0
		 5.3331263188738376e-005 0.99800854921340942 0.063081540167331696 0 0.99999988079071045 -5.1464878197293729e-005 -3.1101630156626925e-005 0
		 -3.7520966529846191 11.247359275817871 -9.1902904510498047 1;
	setAttr ".sm[47]" -type "matrix" 0.0036061848513782024 -0.77848440408706665 -0.62765347957611084 0
		 -0.010213431902229786 0.62759613990783691 -0.77847188711166382 0 0.99994134902954102 0.0092177083715796471 -0.0056877280585467815 0
		 -5.286433219909668 10.774173736572266 -1.7037692070007324 1;
	setAttr ".sm[48]" -type "matrix" 0.0069468650035560131 -0.999642014503479 -0.025859756395220757 0
		 0.0065760621801018715 -0.025814030319452286 0.99964535236358643 0 -0.99995481967926025 -0.0071143242530524731 0.0063945087604224682 0
		 -4.4997177124023437 12.051094055175781 -1.267578125 1;
	setAttr ".sm[49]" -type "matrix" 0.0045457491651177406 -0.94160813093185425 -0.3366808295249939 0
		 0.0084164738655090332 -0.3366362452507019 0.94159716367721558 0 -0.9999542236328125 -0.0071139335632324219 0.0063947439193725586 0
		 -4.5063447952270508 13.00478458404541 -1.2429045438766479 1;
	setAttr ".sm[50]" -type "matrix" 0.9999539852142334 0.0071121202781796455 -0.0063949776813387871 0
		 0.0068421359173953533 -0.064735636115074158 0.99787890911102295 0 0.0066830543801188469 -0.99787712097167969 -0.064781345427036285 0
		 -4.5100598335266113 13.773524284362793 -0.96801269054412842 1;
	setAttr ".sm[51]" -type "matrix" 0.0076997298747301102 -0.99977511167526245 -0.019772773608565331 0
		 0.0062484168447554111 -0.019724823534488678 0.99978631734848022 0 -0.99995112419128418 -0.007821621373295784 0.0060951723717153072 0
		 -6.3457088470458984 12.034070014953613 -1.2570717334747314 1;
	setAttr ".sm[52]" -type "matrix" 0.0053640012629330158 -0.94363778829574585 -0.33093729615211487 0
		 0.0083401799201965332 -0.33088815212249756 0.94363319873809814 0 -0.99995124340057373 -0.0078215915709733963 0.0060954107902944088 0
		 -6.3530540466308594 12.987896919250488 -1.2382115125656128 1;
	setAttr ".sm[53]" -type "matrix" 0.99995148181915283 0.0078244460746645927 -0.0060946838930249214 0
		 0.0065451581031084061 -0.058900728821754456 0.99824255704879761 0 0.0074517084285616875 -0.99823325872421265 -0.058949034661054611 0
		 -6.3574380874633789 13.758296966552734 -0.96801316738128662 1;
	setAttr ".pt" 1;
createNode hikEffector -n "HipsEff" -p "humanIK2";
	setAttr ".t" -type "double3" -0.00049185752868652344 22.631345748901367 -11.309246063232422 ;
	setAttr ".r" -type "double3" 89.999993169810836 -4.2779447709857352e-006 3.7915166395467818e-022 ;
	setAttr ".radi" 1.2325618516015442;
createNode hikFloorContactMarker -n "hikFloorContactMarker1" -p "HipsEff";
	setAttr -k off ".v";
	setAttr ".msz" 0.35216052902901268;
	setAttr ".hct" 3;
	setAttr ".hh" 1.8339109420776367;
	setAttr ".hb" 1.100346565246582;
	setAttr ".hm" 3.1787788867950439;
	setAttr ".hf" 1.7116501331329346;
	setAttr ".his" 1.7819904088973999;
	setAttr ".hos" 1.7819904088973999;
	setAttr ".fct" 3;
	setAttr ".fh" 1.235755443572998;
	setAttr ".fra" 0.74145328998565674;
	setAttr ".fma" 2.1419761180877686;
	setAttr ".ffm" 2.4947865009307861;
	setAttr ".fia" 1.7819904088973999;
	setAttr ".foa" 1.7819904088973999;
createNode hikEffector -n "LeftFootEff" -p "humanIK2";
	setAttr ".t" -type "double3" 3.7517642974853516 8.7222347259521484 -13.769789695739746 ;
	setAttr ".r" -type "double3" 90.00006147159749 -0.00015408502783221083 -6.5755315300471897e-006 ;
	setAttr ".ei" 1;
	setAttr ".radi" 1.2325618516015442;
createNode hikEffector -n "LeftFootIndex1Eff" -p "LeftFootEff";
	setAttr ".t" -type "double3" 0.74977980267702815 2.5238009793316429 8.2222506480278703 ;
	setAttr ".r" -type "double3" -0.00010928291839624989 -2.4789229309962612e-005 -0.0001750921582839664 ;
	setAttr ".ei" 33;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "LeftFootMiddle1Eff" -p "LeftFootEff";
	setAttr ".t" -type "double3" 2.5969448849531025 2.5143346088754672 8.2222520257179497 ;
	setAttr ".r" -type "double3" -8.8792353295330274e-005 -2.4666594164986957e-005 -0.00017479977299404833 ;
	setAttr ".ei" 34;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "RightFootEff" -p "humanIK2";
	setAttr ".t" -type "double3" -3.7521111965179443 8.7222871780395508 -13.769772529602051 ;
	setAttr ".r" -type "double3" 90.000010245284372 9.0281468185526628e-005 8.5781757978951005e-005 ;
	setAttr ".ei" 2;
	setAttr ".radi" 1.2325618516015442;
createNode hikEffector -n "RightFootIndex1Eff" -p "RightFootEff";
	setAttr ".t" -type "double3" -0.75796874240458489 2.5261614697733119 8.2222924758672526 ;
	setAttr ".r" -type "double3" -3.7566031383235894e-005 -7.7122327610870572e-005 8.5998851971432597e-005 ;
	setAttr ".ei" 39;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "RightFootMiddle1Eff" -p "RightFootEff";
	setAttr ".t" -type "double3" -2.6053479260197614 2.5109312410312405 8.2222912326607407 ;
	setAttr ".r" -type "double3" -3.0735846863405807e-005 -7.7347045912008858e-005 8.6113707588324868e-005 ;
	setAttr ".ei" 40;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "LeftHandEff" -p "humanIK2";
	setAttr ".t" -type "double3" 3.3622922897338867 8.5617275238037109 6.014711856842041 ;
	setAttr ".r" -type "double3" 89.9975001701672 -0.0023495847930022737 -90.000464452808174 ;
	setAttr ".ei" 3;
	setAttr ".radi" 1.2325618516015442;
createNode hikEffector -n "LeftHandIndex1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 8.0617713480667792 4.3424034510632632 -0.94403062924719761 ;
	setAttr ".r" -type "double3" 0.0021480905587032703 0.0003893400224039028 -0.00044223748135237636 ;
	setAttr ".ei" 21;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "LeftHandMiddle1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 8.0617510146537015 4.2037605644386771 -2.9417707499451633 ;
	setAttr ".r" -type "double3" 0.0021856563521733697 0.00035519065416539467 -0.00047809768754258035 ;
	setAttr ".ei" 22;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "RightHandEff" -p "humanIK2";
	setAttr ".t" -type "double3" -3.3626494407653809 8.5618515014648437 6.0148077011108398 ;
	setAttr ".r" -type "double3" 89.996999853915298 0.0021276036717974771 90.000389320736303 ;
	setAttr ".ei" 4;
	setAttr ".radi" 1.2325618516015442;
createNode hikEffector -n "RightHandIndex1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -8.0618876644989541 4.3343568482846626 -0.88272519965792817 ;
	setAttr ".r" -type "double3" 0.0025408283465440389 -0.00039958121801294145 0.00029026208203035712 ;
	setAttr ".ei" 27;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "RightHandMiddle1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -8.06188383966626 4.2298244186922789 -2.8825652135239501 ;
	setAttr ".r" -type "double3" 0.0026142530305169145 -0.00040299550909600706 0.00027489375858531198 ;
	setAttr ".ei" 28;
	setAttr ".radi" 0.30814046290038605;
createNode hikEffector -n "LeftLegEff" -p "humanIK2";
	setAttr ".t" -type "double3" 3.4820449352264404 16.136302947998047 -10.939515113830566 ;
	setAttr ".r" -type "double3" 0.00033490602689659221 -4.6535555566466882e-005 -1.4460820445378015e-005 ;
	setAttr ".ei" 5;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "RightLegEff" -p "humanIK2";
	setAttr ".t" -type "double3" -3.4828164577484131 16.136203765869141 -10.939074516296387 ;
	setAttr ".r" -type "double3" 0.00015003743022543072 9.1591200769742178e-005 7.2730927169106481e-005 ;
	setAttr ".ei" 6;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "LeftForeArmEff" -p "humanIK2";
	setAttr ".t" -type "double3" 3.3818778991699219 13.398908615112305 6.4706792831420898 ;
	setAttr ".r" -type "double3" 89.997500163922879 -0.0089594995026870041 -90.000081962260253 ;
	setAttr ".ei" 7;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "RightForeArmEff" -p "humanIK2";
	setAttr ".t" -type "double3" -3.3824872970581055 13.399160385131836 6.4695048332214355 ;
	setAttr ".r" -type "double3" 89.997068124838137 0.010470678632860541 89.999907792457179 ;
	setAttr ".ei" 8;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "SpineEff" -p "humanIK2";
	setAttr ".t" -type "double3" -0.00048972043441608548 26.630352020263672 -7.4794583320617676 ;
	setAttr -k off ".tz";
	setAttr -k off ".ty";
	setAttr -k off ".tx";
	setAttr ".r" -type "double3" 90.00000341508543 1.1564355961393416e-005 -3.4146448087740254e-005 ;
	setAttr ".ei" 9;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "LeftToeBaseEff" -p "humanIK2";
	setAttr ".t" -type "double3" 5.2864513397216797 1.2357335090637207 -14.242895126342773 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr ".r" -type "double3" 89.999993169810836 -1.4489031411614125e-005 -4.8296596314360232e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr ".pin" 3;
	setAttr ".ei" 11;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "RightToeBaseEff" -p "humanIK2";
	setAttr ".t" -type "double3" -5.28643798828125 1.235748291015625 -14.242962837219238 ;
	setAttr ".r" -type "double3" 89.999993169805137 -4.1655906684414336e-005 -3.0185335547605364e-006 ;
	setAttr ".pin" 3;
	setAttr ".ei" 12;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "LeftArmEff" -p "humanIK2";
	setAttr ".t" -type "double3" 3.5385608673095703 18.951572418212891 7.3260021209716797 ;
	setAttr ".r" -type "double3" 0.00011348227673771335 0.007700914012021812 -90.000225129803113 ;
	setAttr ".ei" 13;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "RightArmEff" -p "humanIK2";
	setAttr ".ei" 14;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "HeadEff" -p "humanIK2";
	setAttr ".t" -type "double3" -0.00050290109356865287 30.64668083190918 16.30241584777832 ;
	setAttr ".r" -type "double3" 2.0490552854047985e-005 5.521566363073134e-005 -3.069638755323334e-005 ;
	setAttr ".ei" 15;
	setAttr ".radi" 1.2325618516015442;
createNode hikEffector -n "LeftUpLegEff" -p "humanIK2";
	setAttr ".t" -type "double3" 2.141270637512207 22.631351470947266 -11.309259414672852 ;
	setAttr -k off ".tz";
	setAttr -k off ".ty";
	setAttr -k off ".tx";
	setAttr ".r" -type "double3" -0.00046103776896503983 -2.2085932923993919e-005 0.00011349862529128658 ;
	setAttr ".ei" 16;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "RightUpLegEff" -p "humanIK2";
	setAttr ".t" -type "double3" -2.1422543525695801 22.631340026855469 -11.309232711791992 ;
	setAttr -k off ".tz";
	setAttr -k off ".ty";
	setAttr -k off ".tx";
	setAttr ".r" -type "double3" -0.00019466039134461124 4.4656555105093836e-006 1.1419215190616938e-005 ;
	setAttr ".ei" 17;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "LeftFingerBaseEff" -p "humanIK2";
	setAttr ".t" -type "double3" 4.7429132461547852 1.8339171409606934 6.7632761001586914 ;
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 89.99971825846535 -0.0018919621738546445 -90.000112698107898 ;
	setAttr ".pin" 3;
	setAttr ".ei" 18;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "RightFingerBaseEff" -p "humanIK2";
	setAttr ".t" -type "double3" -4.742891788482666 1.8339862823486328 6.7632536888122559 ;
	setAttr ".r" -type "double3" 89.999588481486441 0.0018646414204708693 90.000010245282539 ;
	setAttr ".pin" 3;
	setAttr ".ei" 19;
	setAttr ".radi" 0.61628092580077209;
createNode hikEffector -n "NeckEff" -p "humanIK2";
	setAttr ".t" -type "double3" -0.00046050548553466797 26.427183151245117 4.4890956878662109 ;
	setAttr ".r" -type "double3" 89.999993169786407 8.0160813639183377e-005 5.4719691699505384e-006 ;
	setAttr ".ei" 10;
	setAttr ".radi" 0.61628092580077209;
createNode joint -n "hipsFK" -p "humanIK2";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -0.00049479072913527489 26.183620452880859 -10.282029151916504 ;
	setAttr ".r" -type "double3" -0.00055780822697237159 -0.00077451302678496303 89.999993169020684 ;
	setAttr ".ra" -type "double3" -89.999991821958318 -89.999322949401247 -80.943213755695538 ;
	setAttr ".jo" -type "double3" 89.999999999385892 -80.943205575447465 89.999322950007723 ;
	setAttr ".typ" 1;
	setAttr ".radi" 0.7;
	setAttr ".hni" 1;
createNode joint -n "spineFK" -p "hipsFK";
	setAttr ".t" -type "double3" 5.2795465034493347e-006 2.8025708731171752 -0.446731233238296 ;
	setAttr ".r" -type "double3" -1.781459312480043e-005 3.31600841164282e-005 1.0244661163974735e-005 ;
	setAttr ".ra" -type "double3" -80.737440510099162 -89.999325959867008 -95.905652098471521 ;
	setAttr ".jo" -type "double3" 89.998147182860237 -86.643092607405137 90.001184386588108 ;
	setAttr ".typ" 6;
	setAttr ".radi" 0.7;
	setAttr ".hni" 8;
createNode joint -n "spine1FK" -p "spineFK";
	setAttr ".t" -type "double3" -2.49875358032366e-006 2.9910378665370754 -0.17544329262062064 ;
	setAttr ".r" -type "double3" -2.6152845194798624e-006 2.9692463095461504e-005 3.7565875655104128e-005 ;
	setAttr ".ra" -type "double3" 89.999999838112828 89.998901341102837 95.03360665382057 ;
	setAttr ".jo" -type "double3" 89.999999999964487 -84.966393183974731 -90.001098658861793 ;
	setAttr ".typ" 6;
	setAttr ".radi" 0.7;
	setAttr ".hni" 23;
createNode joint -n "spine2FK" -p "spine1FK";
	setAttr ".t" -type "double3" -8.6134077127431041e-006 3.2020962721571218 0.2820433117380361 ;
	setAttr ".r" -type "double3" -6.7536295431821502e-005 -1.5509803613992977e-005 -2.7321235530051349e-005 ;
	setAttr ".ra" -type "double3" 73.536658901950389 89.998927832094736 94.609807967091086 ;
	setAttr ".jo" -type "double3" 89.999154926270691 -68.926850935316736 -90.00023965336176 ;
	setAttr ".typ" 6;
	setAttr ".radi" 0.7;
	setAttr ".hni" 24;
createNode joint -n "neckFK" -p "spine2FK";
	setAttr ".t" -type "double3" -3.118442553651235e-005 10.010562069145855 3.857373339509838 ;
	setAttr ".r" -type "double3" -2.3059113244140821e-005 4.7255472541072726e-005 -5.8057187671171284e-005 ;
	setAttr ".ra" -type "double3" 53.517078394397643 89.998615073115374 -126.52362242996966 ;
	setAttr ".jo" -type "double3" 88.840956906305095 89.959290839132905 -91.160156329696633 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 20;
createNode joint -n "neck1FK" -p "neckFK";
	setAttr ".t" -type "double3" -4.9710795430499798e-006 1.7655258172345771 -0.003555613562006954 ;
	setAttr ".r" -type "double3" 3.9093768656658539e-005 -9.3526603203332663e-006 -7.8547326289771845e-005 ;
	setAttr ".ra" -type "double3" 90.000000567138386 -89.998804693158576 100.70657758028686 ;
	setAttr ".jo" -type "double3" 90.000000000063693 -79.293421852212845 90.001195306778826 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 32;
createNode joint -n "neck2FK" -p "neck1FK";
	setAttr ".t" -type "double3" -7.1891687159790149e-006 1.7630653778718397 -0.33334329568539545 ;
	setAttr ".r" -type "double3" -3.4666943876699676e-005 -6.1277786757407422e-005 -2.7319295558674777e-005 ;
	setAttr ".ra" -type "double3" 113.34635670537149 -89.99887587320201 96.191242820489407 ;
	setAttr ".jo" -type "double3" 90.000903617350573 -60.462400474204031 90.000245913762669 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 33;
createNode joint -n "neck3FK" -p "neck2FK";
	setAttr ".t" -type "double3" -2.6877409316965542e-007 1.6894662100239302 -0.95731888495061312 ;
	setAttr ".r" -type "double3" 8.8154135327531771e-007 2.3208287188395879e-005 4.7811105721399083e-005 ;
	setAttr ".ra" -type "double3" -89.999982939172568 -89.99983394801491 -30.076646821611192 ;
	setAttr ".jo" -type "double3" 89.999999999942858 -30.076629762278206 89.999833948043559 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 34;
createNode joint -n "neck4FK" -p "neck3FK";
	setAttr ".t" -type "double3" -5.7373620000467085e-006 0.99728499211604138 -1.7220293775776057 ;
	setAttr ".r" -type "double3" -4.0367765074638295e-005 1.3821949730858285e-006 0.00012635406681050501 ;
	setAttr ".ra" -type "double3" -100.36878030750495 -89.999731215344127 -11.94131377550803 ;
	setAttr ".jo" -type "double3" 90.000052291079086 -22.310094086957911 89.999715753986521 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 35;
createNode joint -n "neck5FK" -p "neck4FK";
	setAttr ".t" -type "double3" 7.9258968214819753e-006 0.66351670929203266 -1.6170045131185589 ;
	setAttr ".r" -type "double3" 9.8510775202585951e-006 4.2335376115943668e-005 -0.00011611536991365674 ;
	setAttr ".ra" -type "double3" -100.33984429149075 -89.999734031045051 -2.760106615766925 ;
	setAttr ".jo" -type "double3" 90.000049013319455 -13.099950907650635 89.999727241366898 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 36;
createNode joint -n "neck6FK" -p "neck5FK";
	setAttr ".t" -type "double3" 7.0870610069066883e-006 0.36803008781585689 -1.5815261316500724 ;
	setAttr ".r" -type "double3" 2.5661763643384998e-005 -7.2718311723552545e-006 4.780976765841826e-005 ;
	setAttr ".ra" -type "double3" -100.33750684466402 -89.999736174981877 -0.28997263805916795 ;
	setAttr ".jo" -type "double3" 90.000048168645208 -10.627479486884869 89.999731574053484 ;
	setAttr ".typ" 7;
	setAttr ".radi" 0.7;
	setAttr ".hni" 37;
createNode joint -n "headFK" -p "neck6FK";
	setAttr ".t" -type "double3" 6.3580548350657779e-006 0.33127962452628523 -1.7655200078358959 ;
	setAttr ".r" -type "double3" -90.000030735025874 -1.8661692419891016e-005 -2.1541085637167604e-005 ;
	setAttr ".jo" -type "double3" -8.3721045009587162e-009 4.3422025825002859e-014 -1.2495479969118207e-014 ;
	setAttr ".typ" 8;
	setAttr ".radi" 0.7;
	setAttr ".hni" 15;
createNode joint -n "rightCollarFK" -p "spine2FK";
	setAttr ".t" -type "double3" -1.5569771235301719 5.7753970088432176 0.096567305383860713 ;
	setAttr ".r" -type "double3" -85.432767363024141 34.43415001998833 -3.1841674956225479 ;
	setAttr ".ra" -type "double3" 90.00000000076956 75.150708379996217 159.85522519212839 ;
	setAttr ".jo" -type "double3" 90.000000000210065 -20.144774808615434 -104.84929162007612 ;
	setAttr ".sd" 2;
	setAttr ".typ" 9;
	setAttr ".radi" 0.7;
	setAttr ".hni" 19;
createNode joint -n "rightArmFK" -p "rightCollarFK";
	setAttr ".t" -type "double3" -7.4755570449109214 2.8370245491486878 -1.9820187592492524 ;
	setAttr ".r" -type "double3" -1.8378402437655437 1.3547223941280637 89.955459772081269 ;
	setAttr ".ra" -type "double3" -89.999999999220293 88.380597733122073 8.7567939231657519 ;
	setAttr ".jo" -type "double3" 89.999999999977703 8.7567939223861586 -88.380597733125484 ;
	setAttr ".sd" 2;
	setAttr ".typ" 10;
	setAttr ".radi" 0.7;
	setAttr ".hni" 12;
createNode joint -n "rightForeArmFK" -p "rightArmFK";
	setAttr ".t" -type "double3" -5.552610456839135 -0.1569735608755698 -0.85564737479822117 ;
	setAttr ".r" -type "double3" 0.21381353275455892 0.2355753303580333 -89.996169407899202 ;
	setAttr ".ra" -type "double3" -89.999999998975397 89.765231371721242 5.3802009458694515 ;
	setAttr ".jo" -type "double3" 89.999999999995808 5.3802009448464574 -89.765231371721654 ;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".radi" 0.7;
	setAttr ".hni" 13;
createNode joint -n "rightHandFK" -p "rightForeArmFK";
	setAttr ".t" -type "double3" -4.8372222000970524 -0.45558014750580611 0.019822537926915906 ;
	setAttr ".r" -type "double3" 0.00044881187746193744 0.0083435746960660966 0.00016364725423428854 ;
	setAttr ".ra" -type "double3" 90.00000000076929 78.406462525590911 173.78197777903947 ;
	setAttr ".jo" -type "double3" 90.000000000155509 -6.2180222217141212 -101.59353747442593 ;
	setAttr ".sd" 2;
	setAttr ".typ" 12;
	setAttr ".radi" 0.7;
	setAttr ".hni" 14;
createNode joint -n "rightFingerBaseFK" -p "rightHandFK";
	setAttr ".t" -type "double3" -6.7278895936785617 0.74826917772399604 -1.3802503550356411 ;
	setAttr ".r" -type "double3" -0.0011764254473485417 0.0016864502504637883 -0.0016388634896979768 ;
	setAttr ".ra" -type "double3" 90.000000000770683 30.454541249633593 132.2449427734343 ;
	setAttr ".jo" -type "double3" 90.000000000988194 -47.755057226956346 -149.54545875109793 ;
	setAttr ".sd" 2;
	setAttr ".typ" 13;
	setAttr ".radi" 0.7;
	setAttr ".hni" 22;
createNode joint -n "joint49FK" -p "rightFingerBaseFK";
	setAttr ".t" -type "double3" -0.83263300753785918 1.8088413577843276 -1.416099348859313 ;
	setAttr ".r" -type "double3" 3.3978544010777214e-005 4.8360073553221027e-005 -8.811552504655897e-005 ;
	setAttr ".ra" -type "double3" 90.000000000770839 70.213212969355112 98.805706037785228 ;
	setAttr ".jo" -type "double3" 90.000000001704691 -81.194293962940165 -109.78678703232951 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 82;
createNode joint -n "joint50FK" -p "joint49FK";
	setAttr ".t" -type "double3" -0.13740910750510893 0.94274964209602352 -0.049435776522719799 ;
	setAttr ".r" -type "double3" -3.7323089610463962e-005 -7.7970325193264949e-005 -1.9106442396001854e-005 ;
	setAttr ".ra" -type "double3" 90.000000000771934 84.206278450718784 116.61903393465515 ;
	setAttr ".jo" -type "double3" 90.000000000173856 -63.380966066112848 -95.793721549436668 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 83;
createNode joint -n "joint51FK" -p "joint50FK";
	setAttr ".t" -type "double3" -0.36394312557039593 0.72990392555145078 -0.036928379002737266 ;
	setAttr ".r" -type "double3" -8.5377336722301252e-005 2.0490358202141961e-005 3.9273453738048444e-005 ;
	setAttr ".jo" -type "double3" -7.7052972487205805e-010 -4.4838366583798121e-014 
		-3.1805546814358776e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 84;
createNode joint -n "joint52FK" -p "rightFingerBaseFK";
	setAttr ".t" -type "double3" -0.82263151032117543 1.916492503581896 0.58358454584863306 ;
	setAttr ".r" -type "double3" 4.7582538698742724e-005 4.8295230658403616e-005 -0.00011620772203676764 ;
	setAttr ".ra" -type "double3" 90.000000000770811 70.946397618052572 99.127810801853869 ;
	setAttr ".jo" -type "double3" 90.000000001586301 -80.872189198874722 -109.05360238351363 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 78;
createNode joint -n "joint53FK" -p "joint52FK";
	setAttr ".t" -type "double3" -0.14304755260850732 0.94191016052586285 -0.049403598692608242 ;
	setAttr ".r" -type "double3" -2.2036412247425592e-005 1.3193701861576421e-005 5.7087843975552338e-005 ;
	setAttr ".ra" -type "double3" 90.000000000771706 84.291908049155424 116.95938274044407 ;
	setAttr ".jo" -type "double3" 90.000000000169265 -63.040617260323842 -95.708091950995438 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 79;
createNode joint -n "joint54FK" -p "joint53FK";
	setAttr ".t" -type "double3" -0.36830535552743787 0.72771410765922617 -0.036813471541030651 ;
	setAttr ".r" -type "double3" -0.00011611327947795359 -4.781123745766677e-005 -1.3660690719254633e-005 ;
	setAttr ".jo" -type "double3" -7.7048360682917679e-010 -6.948766536514035e-014 -3.8961794847651746e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 80;
createNode joint -n "leftCollarFK" -p "spine2FK";
	setAttr ".t" -type "double3" 1.5570389324694551 5.7754423735645561 0.096575232184417104 ;
	setAttr ".r" -type "double3" 85.432703183830725 -34.432733955351388 -3.1834322161175344 ;
	setAttr ".ra" -type "double3" -89.999999999230639 75.150854638660178 -20.143753865399297 ;
	setAttr ".jo" -type "double3" 89.999999999789964 -20.143753866142948 -75.15085463858783 ;
	setAttr ".sd" 1;
	setAttr ".typ" 9;
	setAttr ".radi" 0.7;
	setAttr ".hni" 18;
createNode joint -n "leftArmFK" -p "leftCollarFK";
	setAttr ".t" -type "double3" 7.4756116737587384 2.836889284702095 -1.9820050237991271 ;
	setAttr ".r" -type "double3" 1.8360027465464288 -1.352402568268481 89.955526774841971 ;
	setAttr ".ra" -type "double3" 90.00000000076507 88.383886912406453 -171.25422971598809 ;
	setAttr ".jo" -type "double3" 90.000000000021842 8.7457702832475395 -91.61611308759025 ;
	setAttr ".sd" 1;
	setAttr ".typ" 10;
	setAttr ".radi" 0.7;
	setAttr ".hni" 9;
createNode joint -n "leftForeArmFK" -p "leftArmFK";
	setAttr ".t" -type "double3" 5.5527771707285929 -0.15666861145421285 -0.8545765616276384 ;
	setAttr ".r" -type "double3" 179.78943463821955 180.23582114254799 90.003481567521689 ;
	setAttr ".ra" -type "double3" 90.000000001708599 89.768343651205612 -174.60616432236674 ;
	setAttr ".jo" -type "double3" 90.000000000006935 5.393835675927102 -90.231656348793749 ;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".radi" 0.7;
	setAttr ".hni" 10;
createNode joint -n "leftHandFK" -p "leftForeArmFK";
	setAttr ".t" -type "double3" 4.8371051290279485 -0.45672412422793673 0.019556782556928276 ;
	setAttr ".r" -type "double3" -0.00034380962178780005 -0.0066115932771108488 7.6873138495116302e-005 ;
	setAttr ".ra" -type "double3" -89.999999999213912 78.403170034267887 -6.2185672635319715 ;
	setAttr ".jo" -type "double3" 89.999999999841037 -6.2185672643020258 -78.403170034250678 ;
	setAttr ".sd" 1;
	setAttr ".typ" 12;
	setAttr ".radi" 0.7;
	setAttr ".hni" 11;
createNode joint -n "leftFingerBaseFK" -p "leftHandFK";
	setAttr ".t" -type "double3" 6.7278283940952086 0.74835044167956788 -1.3806388303354189 ;
	setAttr ".r" -type "double3" 0.00085897385604214013 -0.0015875136456666938 -0.0014124727248082147 ;
	setAttr ".ra" -type "double3" -89.999999999228507 29.959847471881499 -46.897497070424052 ;
	setAttr ".jo" -type "double3" 89.999999999021881 -46.897497070809294 -29.959847471167333 ;
	setAttr ".sd" 1;
	setAttr ".typ" 13;
	setAttr ".radi" 0.7;
	setAttr ".hni" 21;
createNode joint -n "joint12FK" -p "leftFingerBaseFK";
	setAttr ".t" -type "double3" 0.83380622612993405 1.7840509731380161 -1.4465268251363446 ;
	setAttr ".r" -type "double3" 9.9023595123633843e-007 4.5904249755537933e-006 0.00010394231013791993 ;
	setAttr ".ra" -type "double3" -89.999999999228621 64.391354253469615 -80.856197977180784 ;
	setAttr ".jo" -type "double3" 89.999999997901895 -80.856197977876377 -64.39135425139817 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 58;
createNode joint -n "joint40FK" -p "joint12FK";
	setAttr ".t" -type "double3" 0.13670880654882867 0.94185900642039222 -0.065529555600075007 ;
	setAttr ".r" -type "double3" 6.6825352460957879e-005 -1.6700506260898301e-005 -5.0848281872284308e-005 ;
	setAttr ".ra" -type "double3" -89.999999999228848 82.29005527402019 -63.310396640373881 ;
	setAttr ".jo" -type "double3" 89.99999999976967 -63.310396641138063 -82.290055273814389 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 59;
createNode joint -n "joint41FK" -p "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK";
	setAttr ".t" -type "double3" 0.36339379551932199 0.72944990880895588 -0.049197922142258044 ;
	setAttr ".r" -type "double3" 6.8299990791853626e-006 8.1962687903942643e-005 -7.3424223676984128e-005 ;
	setAttr ".jo" -type "double3" -7.7147275933511193e-010 -5.3584891957823003e-014 
		-1.1927080055211139e-014 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.7;
	setAttr ".hni" 60;
createNode joint -n "joint42FK" -p "leftFingerBaseFK";
	setAttr ".t" -type "double3" 0.82240843557401822 1.9262029267670977 0.55097637488970008 ;
	setAttr ".r" -type "double3" 1.9815046377896975e-005 4.7138490859485716e-005 5.3461325556549528e-005 ;
	setAttr ".ra" -type "double3" -89.999999999228649 65.425840387811903 -80.503592121827069 ;
	setAttr ".jo" -type "double3" 89.999999998055586 -80.503592122528559 -65.425840385894134 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 54;
createNode joint -n "joint40FK" -p "joint42FK";
	setAttr ".t" -type "double3" 0.14314111164279564 0.94092596374533422 -0.065455979497803796 ;
	setAttr ".r" -type "double3" 5.5071388744106724e-005 7.9842392839485455e-005 6.1054740667190315e-005 ;
	setAttr ".ra" -type "double3" -89.999999999229018 82.41705165323485 -62.923851986866133 ;
	setAttr ".jo" -type "double3" 89.999999999776449 -62.923851987630371 -82.417051653035784 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 55;
createNode joint -n "joint41FK" -p "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK";
	setAttr ".t" -type "double3" 0.36836657358131736 0.7269441689419267 -0.049035709825671958 ;
	setAttr ".r" -type "double3" 6.3179143174027551e-005 -1.7074767448281153e-005 -9.7330165497781513e-005 ;
	setAttr ".jo" -type "double3" -7.7147753016713408e-010 -6.6704680018860022e-014 
		-1.1927080055211131e-014 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.7;
	setAttr ".hni" 56;
createNode joint -n "leftUpLegFK" -p "hipsFK";
	setAttr ".t" -type "double3" 2.1417624525311303 -1.0272317285729642 3.5522688594645828 ;
	setAttr ".r" -type "double3" -11.252846091603505 12.060218612427315 87.612572478222688 ;
	setAttr ".ra" -type "double3" -90.000000000478011 78.336377726404123 -3.1905714034795492 ;
	setAttr ".jo" -type "double3" 90.000000000096819 -3.1905714030114218 -78.336377726409509 ;
	setAttr ".sd" 1;
	setAttr ".typ" 2;
	setAttr ".radi" 0.7;
	setAttr ".hni" 2;
createNode joint -n "leftLegFK" -p "leftUpLegFK";
	setAttr ".t" -type "double3" 1.3407661000723632 -6.4950553910938602 0.36969293351543442 ;
	setAttr ".r" -type "double3" 9.5474902327234579e-005 -0.00010053175371511085 -0.0007945287358494343 ;
	setAttr ".ra" -type "double3" -90.000000000474515 87.916470140330276 20.881058495035806 ;
	setAttr ".jo" -type "double3" 90.00000000001846 20.881058495509986 -87.916470140323739 ;
	setAttr ".sd" 1;
	setAttr ".typ" 3;
	setAttr ".radi" 0.7;
	setAttr ".hni" 3;
createNode joint -n "leftFootFK" -p "leftLegFK";
	setAttr ".t" -type "double3" 0.26972067533646316 -7.4140902036810461 -2.830233170812388 ;
	setAttr ".r" -type "double3" 11.099881909034817 12.049709519709788 -87.645403173194424 ;
	setAttr ".ra" -type "double3" -90.00000000047919 78.41521733779831 3.5425511026448606 ;
	setAttr ".jo" -type "double3" 90.000000000096406 3.5425511031143202 -78.415217337792356 ;
	setAttr ".sd" 1;
	setAttr ".typ" 4;
	setAttr ".radi" 0.7;
	setAttr ".hni" 4;
createNode joint -n "leftToeBaseFK" -p "leftFootFK";
	setAttr ".t" -type "double3" 1.5346839617243555 -0.473100561489737 7.4864914979630459 ;
	setAttr ".r" -type "double3" -7.981276325044413e-005 -0.00012880473648432686 3.4561450903476371e-005 ;
	setAttr ".ra" -type "double3" 89.999999999521663 28.92325370558758 125.32625786628198 ;
	setAttr ".jo" -type "double3" 89.999999999275943 -54.673742133486684 -151.07674629382174 ;
	setAttr ".sd" 1;
	setAttr ".typ" 5;
	setAttr ".radi" 0.7;
	setAttr ".hni" 16;
createNode joint -n "joint43FK" -p "leftToeBaseFK";
	setAttr ".t" -type "double3" -0.79051639179698441 1.2743544123049801 0.43680677570719817 ;
	setAttr ".r" -type "double3" -0.00011263068827107362 3.3617301732924826e-005 5.6438483190247373e-005 ;
	setAttr ".ra" -type "double3" -90.000000000478281 80.967570536079521 -88.518502675719517 ;
	setAttr ".jo" -type "double3" 90.000000002904386 -88.51850267524722 -80.96757053898294 ;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 102;
createNode joint -n "joint40FK" -p "joint43FK";
	setAttr ".t" -type "double3" 0.0038718870398426475 0.95366572381428583 0.024358785675966499 ;
	setAttr ".r" -type "double3" 0.00014398916083939326 -3.4195446730216764e-005 5.079892623985388e-007 ;
	setAttr ".ra" -type "double3" -90.000000000478479 89.63894002993807 -70.346499156032252 ;
	setAttr ".jo" -type "double3" 90.000000000008995 -70.346499155554383 -89.638940029946539 ;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 103;
createNode joint -n "joint41FK" -p "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK";
	setAttr ".t" -type "double3" 0.0017302555155325194 0.76887880691388055 0.27458936691199526 ;
	setAttr ".r" -type "double3" 1.998255431000125e-005 2.6890186501059044e-005 -4.7872232429982262e-005 ;
	setAttr ".jo" -type "double3" 4.7876571564602158e-010 3.2799470152620928e-015 7.2357619003321571e-014 ;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 104;
createNode joint -n "joint44FK" -p "leftToeBaseFK";
	setAttr ".t" -type "double3" 1.0555324472402194 1.2633708434343482 0.44575003391278623 ;
	setAttr ".r" -type "double3" -0.00011077813139897304 2.3426766502282536e-006 7.6014616307242471e-005 ;
	setAttr ".ra" -type "double3" -90.000000000478394 77.087053791914883 -88.804577747530814 ;
	setAttr ".jo" -type "double3" 90.000000005123596 -88.804577747064528 -77.087053797037356 ;
	setAttr ".sd" 1;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 106;
createNode joint -n "joint40FK" -p "joint44FK";
	setAttr ".t" -type "double3" 0.004447548987514871 0.95377730351896339 0.01939943461942828 ;
	setAttr ".r" -type "double3" -6.0041007601506199e-005 -2.4212601094209941e-005 2.4668129965970241e-008 ;
	setAttr ".ra" -type "double3" -90.000000000481407 89.520000384999591 -70.64282064251681 ;
	setAttr ".jo" -type "double3" 90.00000000001215 -70.642820642035545 -89.520000385011073 ;
	setAttr ".sd" 1;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 107;
createNode joint -n "joint41FK" -p "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK";
	setAttr ".t" -type "double3" 0.0022670251940972719 0.77029024710562588 0.27060584088302359 ;
	setAttr ".r" -type "double3" 5.4616894585229902e-005 -1.1017999810862519e-005 0.00014017366014607986 ;
	setAttr ".jo" -type "double3" 4.7861543443732247e-010 -2.0474820761918393e-014 8.587497639954143e-014 ;
	setAttr ".sd" 1;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 108;
createNode joint -n "rightUpLegFK" -p "hipsFK";
	setAttr ".t" -type "double3" -2.1417565590694596 -1.0272033811738108 3.552282492543636 ;
	setAttr ".r" -type "double3" 11.250217232624689 -12.058964057548634 87.613101199549106 ;
	setAttr ".ra" -type "double3" 89.999999999521478 78.338208403837541 176.8056363886044 ;
	setAttr ".jo" -type "double3" 89.999999999903125 -3.1943636109269753 -101.66179159615709 ;
	setAttr ".sd" 2;
	setAttr ".typ" 2;
	setAttr ".radi" 0.7;
	setAttr ".hni" 5;
createNode joint -n "rightLegFK" -p "rightUpLegFK";
	setAttr ".t" -type "double3" -1.3405665079944229 -6.4951350623782567 0.37013558170101035 ;
	setAttr ".r" -type "double3" -0.00011489529570404129 2.1784083043549434e-005 -0.00034130789239981046 ;
	setAttr ".ra" -type "double3" 89.999999999524775 87.919670223632778 -159.11545252523476 ;
	setAttr ".jo" -type "double3" 89.999999999981512 20.884547475240176 -92.080329776373802 ;
	setAttr ".sd" 2;
	setAttr ".typ" 3;
	setAttr ".radi" 0.7;
	setAttr ".hni" 6;
createNode joint -n "rightFootFK" -p "rightLegFK";
	setAttr ".t" -type "double3" -0.26930738176587576 -7.4139285486193085 -2.8306819385994544 ;
	setAttr ".r" -type "double3" -11.097187054919903 -12.04714208808331 -87.646617038993327 ;
	setAttr ".ra" -type "double3" 89.999999999518991 78.417813386852828 -176.45688569715452 ;
	setAttr ".jo" -type "double3" 89.999999999903238 3.5431143033167452 -101.58218661315316 ;
	setAttr ".sd" 2;
	setAttr ".typ" 4;
	setAttr ".radi" 0.7;
	setAttr ".hni" 7;
createNode joint -n "rightToeBaseFK" -p "rightFootFK";
	setAttr ".t" -type "double3" -1.5343294979234101 -0.47318847734137037 7.4865317844212615 ;
	setAttr ".r" -type "double3" 0.0001240584340955248 5.2990865332498005e-005 8.5941952893165723e-005 ;
	setAttr ".ra" -type "double3" -90.00000000047865 29.005968427655208 -54.836613600448665 ;
	setAttr ".jo" -type "double3" 90.000000000726871 -54.836613600216573 -29.005968428249385 ;
	setAttr ".sd" 2;
	setAttr ".typ" 5;
	setAttr ".radi" 0.7;
	setAttr ".hni" 17;
createNode joint -n "joint59FK" -p "rightToeBaseFK";
	setAttr ".t" -type "double3" 0.7867155325080013 1.2769203276469003 0.43619077201691014 ;
	setAttr ".r" -type "double3" -9.3906843909722368e-005 2.1001681722629625e-005 2.7531307411402436e-005 ;
	setAttr ".ra" -type "double3" 89.999999999521421 74.965216584963088 91.5345047899348 ;
	setAttr ".jo" -type "double3" 89.999999995362899 -88.465495209602963 -105.0347834104015 ;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 126;
createNode joint -n "joint60FK" -p "joint59FK";
	setAttr ".t" -type "double3" -0.0066271376775377533 0.95369052557521705 0.024673574517938501 ;
	setAttr ".r" -type "double3" 2.4666524207427141e-005 -3.5694731004877291e-005 -5.664591034985209e-007 ;
	setAttr ".ra" -type "double3" 89.99999999951936 89.225764906652628 109.67806241649438 ;
	setAttr ".jo" -type "double3" 89.999999999980744 -70.321937583025232 -90.774235093329239 ;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 127;
createNode joint -n "joint61FK" -p "joint60FK";
	setAttr ".t" -type "double3" -0.0037150783220329942 0.76873971676178243 0.27489183660692301 ;
	setAttr ".r" -type "double3" 0 2.3744458253940272e-005 3.6165902456918524e-005 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr ".jo" -type "double3" 4.7904401418064972e-010 -1.9878466759143421e-014 -4.2937488199731064e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.7;
	setAttr ".hni" 128;
createNode joint -n "joint62FK" -p "rightToeBaseFK";
	setAttr ".t" -type "double3" -1.0592740578806277 1.259905572385513 0.44670220618978806 ;
	setAttr ".r" -type "double3" -9.0268445888307312e-005 2.0152079391310149e-005 8.5924359197624504e-006 ;
	setAttr ".ra" -type "double3" 89.999999999521236 68.721124426545202 91.215620748085968 ;
	setAttr ".jo" -type "double3" 89.999999991810938 -88.784379251467911 -111.27887556526758 ;
	setAttr ".sd" 2;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 130;
createNode joint -n "joint63FK" -p "joint62FK";
	setAttr ".t" -type "double3" -0.0073452109584009051 0.95382690535134351 0.018860222756300837 ;
	setAttr ".r" -type "double3" 1.7764347227935066e-005 2.1913473438942332e-005 -2.7084233094505855e-005 ;
	setAttr ".ra" -type "double3" 89.999999999519659 89.070482955216363 109.32935921334206 ;
	setAttr ".jo" -type "double3" 89.999999999976453 -70.670640786177501 -90.929517044761411 ;
	setAttr ".sd" 2;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 131;
createNode joint -n "joint64FK" -p "joint63FK";
	setAttr ".t" -type "double3" -0.0043840275738675771 0.77040009604792026 0.27019832562319035 ;
	setAttr ".r" -type "double3" -4.0981136972097773e-005 -2.658043825778591e-005 1.9980619966431587e-005 ;
	setAttr ".jo" -type "double3" 4.7834111159604624e-010 2.3854160111006865e-015 -4.8503458892292097e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 26;
	setAttr ".radi" 0.7;
	setAttr ".hni" 132;
createNode lightLinker -n "lightLinker1";
	setAttr -s 6 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode phong -n "plastic";
	setAttr ".c" -type "float3" 1 1 1 ;
	setAttr ".sc" -type "float3" 1 1 1 ;
createNode shadingEngine -n "plasticSG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode phong -n "CAMELUNA";
	setAttr ".sc" -type "float3" 1 1 1 ;
createNode file -n "file1";
	setAttr ".ftn" -type "string" "D:/maya/projects/MaLibrary/animals/taschen/DROMEDAR/3DMODEL/CAME2REF.JPG";
createNode shadingEngine -n "CAMELUNASG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode phong -n "CAMEYE";
	setAttr ".c" -type "float3" 0.070588239 0.031372551 0 ;
	setAttr ".sc" -type "float3" 0.98039222 0.98039222 0.98039222 ;
createNode shadingEngine -n "CAMEYESG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode phong -n "Material__1";
	setAttr ".sc" -type "float3" 1 1 1 ;
createNode file -n "file2";
	setAttr ".ftn" -type "string" "D:/maya/projects/MaLibrary/animals/taschen/DROMEDAR/3DMODEL/CAME2REF.JPG";
createNode shadingEngine -n "Material__1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode imagePlane -n "imagePlane1";
	setAttr ".imn" -type "string" "D:/maya/projects/default//sourceimages/camelskel.jpg";
	setAttr ".cov" -type "short2" 365 246 ;
	setAttr ".dm" 0;
	setAttr ".cg" -type "float3" 0.32743999 0.32743999 0.32743999 ;
	setAttr ".dlc" no;
	setAttr ".s" -type "double2" 1.4173200000000001 1.0629926294108702 ;
	setAttr ".c" -type "double3" -36.464 15.067 4.75 ;
	setAttr ".w" 60.365;
	setAttr ".h" 135.335;
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Top View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Top View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"top\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n"
		+ "                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 4096\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n"
		+ "                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n"
		+ "                -manipulators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Top View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n            -textureMaxSize 4096\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n"
		+ "            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Side View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Side View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"side\" \n"
		+ "                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 4096\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n"
		+ "                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n"
		+ "                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Side View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n"
		+ "            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 4096\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n"
		+ "            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Front View\"`;\n\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Front View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"front\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 4096\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n"
		+ "                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n"
		+ "                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Front View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n"
		+ "            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 4096\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n"
		+ "            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Persp View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Persp View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n"
		+ "                -textureDisplay \"modulate\" \n                -textureMaxSize 4096\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n"
		+ "                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Persp View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n"
		+ "        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 4096\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n"
		+ "            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n"
		+ "            -manipulators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" \"Outliner\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l \"Outliner\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n                -mainListConnection \"worldList\" \n                -selectionConnection \"modelList\" \n                -showShapes 0\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -autoExpand 0\n                -showDagOnly 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUnitlessCurves 1\n                -showCompounds 1\n"
		+ "                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l \"Outliner\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -mainListConnection \"worldList\" \n            -selectionConnection \"modelList\" \n            -showShapes 0\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -autoExpand 0\n            -showDagOnly 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n"
		+ "            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" \"Graph Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l \"Graph Editor\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"graphEditorList\" \n                -selectionConnection \"graphEditor1FromOutliner\" \n                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 1\n                -showDagOnly 0\n"
		+ "                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n"
		+ "                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -mainListConnection \"graphEditor1FromOutliner\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Graph Editor\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"graphEditorList\" \n                -selectionConnection \"graphEditor1FromOutliner\" \n"
		+ "                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 1\n                -showDagOnly 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -mainListConnection \"graphEditor1FromOutliner\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" \"Dope Sheet\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l \"Dope Sheet\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"animationList\" \n                -selectionConnection \"dopeSheetPanel1OutlinerSelection\" \n                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 0\n                -showDagOnly 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n"
		+ "                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -mainListConnection \"dopeSheetPanel1FromOutliner\" \n                -highlightConnection \"dopeSheetPanel1OutlinerSelection\" \n                -displayKeys 1\n                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Dope Sheet\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"animationList\" \n                -selectionConnection \"dopeSheetPanel1OutlinerSelection\" \n                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 0\n"
		+ "                -showDagOnly 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n"
		+ "                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -mainListConnection \"dopeSheetPanel1FromOutliner\" \n                -highlightConnection \"dopeSheetPanel1OutlinerSelection\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" \"Trax Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l \"Trax Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -mainListConnection \"lockedList1\" \n                -highlightConnection \"clipEditorPanel1HighlightConnection\" \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Trax Editor\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -mainListConnection \"lockedList1\" \n                -highlightConnection \"clipEditorPanel1HighlightConnection\" \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n"
		+ "                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" \"Hypergraph Hierarchy\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l \"Hypergraph Hierarchy\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -zoom 1\n                -animateTransition 0\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -freeform 0\n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n"
		+ "                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Hypergraph Hierarchy\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -zoom 1\n                -animateTransition 0\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -freeform 0\n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -updateSelection 1\n                -updateNodeAdded 1\n"
		+ "                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" \"Hypershade\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l \"Hypershade\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Hypershade\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" \"Visor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l \"Visor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Visor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\tif ($useSceneConfig) {\n\t\tscriptedPanel -e -to $panelName;\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" \"UV Texture Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l \"UV Texture Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"UV Texture Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"multiListerPanel\" \"Multilister\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"multiListerPanel\" -l \"Multilister\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Multilister\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" \"Render View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l \"Render View\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Render View\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" \"Blend Shape\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l \"Blend Shape\" -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l \"Blend Shape\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" \"Dynamic Relationships\"`;\n\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l \"Dynamic Relationships\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Dynamic Relationships\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"devicePanel\" \"Devices\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tdevicePanel -unParent -l \"Devices\" -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tdevicePanel -edit -l \"Devices\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" \"Relationship Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l \"Relationship Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Relationship Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" \"Reference Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l \"Reference Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Reference Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" \"Component Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l \"Component Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Component Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" \"Paint Effects\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l \"Paint Effects\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Paint Effects\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"webBrowserPanel\" \"Web Browser\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"webBrowserPanel\" -l \"Web Browser\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Web Browser\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" \"Script Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l \"Script Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Script Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label \"Current Layout\"\n\t\t\t\t-defaultImage \"\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t\"Persp View\"\n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l \\\"Persp View\\\" -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"wireframe\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 4096\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l \\\"Persp View\\\" -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"wireframe\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 4096\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode character -n "fbikCharacter";
	setAttr -s 15 ".dnsm";
	setAttr ".am" -type "characterMapping" 15 "_leftArm.message" 4 0 "_rightArm.message" 
		4 0 "_leftLeg.message" 4 0 "_rightLeg.message" 4 0 "_spine.message" 
		4 0 "_head.message" 4 0 "_hips.message" 4 0 "_rightFingerMiddle.message" 
		4 0 "_rightFingerIndex.message" 4 0 "_leftFingerMiddle.message" 
		4 0 "_leftFingerIndex.message" 4 0 "_leftFootIndex.message" 4 
		0 "_leftFootMiddle.message" 4 0 "_rightFootIndex.message" 4 0 "_rightFootMiddle.message" 
		4 0  ;
createNode character -n "_leftArm";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 77 ".dnsm";
	setAttr -s 23 ".uv[1:23]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 
		0 0 0;
	setAttr -s 23 ".uv";
	setAttr -s 27 ".lv[1:27]"  5.7754342341882445 -0.09657159595164444 
		1.5569865937001226 2.8368941780665988 -7.4755914994777442 1.9819978238883751 -0.85457352975269973 
		-5.5527711698220106 -0.1566657595498957 -0.45671915351666481 -4.8370990024703815 
		-0.019557300889319951 0.74835690740304184 -6.7278114121723736 1.3806334357417369 
		0 0 0 0 0 0 0 0 0 0 0 0;
	setAttr -s 27 ".lv";
	setAttr -s 27 ".av";
	setAttr -s 27 ".av";
	setAttr ".am" -type "characterMapping" 77 "leftCollarFK.scaleZ" 0 1 "leftCollarFK.scaleY" 
		0 2 "leftCollarFK.scaleX" 0 3 "leftCollarFK.rotateZ" 2 1 "leftCollarFK.rotateY" 
		2 2 "leftCollarFK.rotateX" 2 3 "leftCollarFK.translateZ" 1 
		1 "leftCollarFK.translateY" 1 2 "leftCollarFK.translateX" 1 3 "leftArmFK.scaleZ" 
		0 4 "leftArmFK.scaleY" 0 5 "leftArmFK.scaleX" 0 6 "leftArmFK.rotateZ" 
		2 4 "leftArmFK.rotateY" 2 5 "leftArmFK.rotateX" 2 6 "leftArmFK.translateZ" 
		1 4 "leftArmFK.translateY" 1 5 "leftArmFK.translateX" 1 
		6 "leftForeArmFK.scaleZ" 0 7 "leftForeArmFK.scaleY" 0 8 "leftForeArmFK.scaleX" 
		0 9 "leftForeArmFK.rotateZ" 2 7 "leftForeArmFK.rotateY" 2 
		8 "leftForeArmFK.rotateX" 2 9 "leftForeArmFK.translateZ" 1 7 "leftForeArmFK.translateY" 
		1 8 "leftForeArmFK.translateX" 1 9 "leftHandFK.scaleZ" 0 
		10 "leftHandFK.scaleY" 0 11 "leftHandFK.scaleX" 0 12 "leftHandFK.rotateZ" 
		2 10 "leftHandFK.rotateY" 2 11 "leftHandFK.rotateX" 2 12 "leftHandFK.translateZ" 
		1 10 "leftHandFK.translateY" 1 11 "leftHandFK.translateX" 1 
		12 "leftFingerBaseFK.scaleZ" 0 13 "leftFingerBaseFK.scaleY" 0 14 "leftFingerBaseFK.scaleX" 
		0 15 "leftFingerBaseFK.rotateZ" 2 13 "leftFingerBaseFK.rotateY" 
		2 14 "leftFingerBaseFK.rotateX" 2 15 "leftFingerBaseFK.translateZ" 
		1 13 "leftFingerBaseFK.translateY" 1 14 "leftFingerBaseFK.translateX" 
		1 15 "LeftHandEff.reachRotation" 0 16 "LeftHandEff.reachTranslation" 
		0 17 "LeftHandEff.rotateZ" 2 16 "LeftHandEff.rotateY" 2 17 "LeftHandEff.rotateX" 
		2 18 "LeftHandEff.translateZ" 1 16 "LeftHandEff.translateY" 1 
		17 "LeftHandEff.translateX" 1 18 "LeftForeArmEff.reachRotation" 0 
		18 "LeftForeArmEff.reachTranslation" 0 19 "LeftForeArmEff.rotateZ" 2 
		19 "LeftForeArmEff.rotateY" 2 20 "LeftForeArmEff.rotateX" 2 21 "LeftForeArmEff.translateZ" 
		1 19 "LeftForeArmEff.translateY" 1 20 "LeftForeArmEff.translateX" 
		1 21 "LeftArmEff.reachRotation" 0 20 "LeftArmEff.reachTranslation" 
		0 21 "LeftArmEff.rotateZ" 2 22 "LeftArmEff.rotateY" 2 23 "LeftArmEff.rotateX" 
		2 24 "LeftArmEff.translateZ" 1 22 "LeftArmEff.translateY" 1 
		23 "LeftArmEff.translateX" 1 24 "LeftFingerBaseEff.reachRotation" 0 
		22 "LeftFingerBaseEff.reachTranslation" 0 23 "LeftFingerBaseEff.rotateZ" 
		2 25 "LeftFingerBaseEff.rotateY" 2 26 "LeftFingerBaseEff.rotateX" 
		2 27 "LeftFingerBaseEff.translateZ" 1 25 "LeftFingerBaseEff.translateY" 
		1 26 "LeftFingerBaseEff.translateX" 1 27  ;
	setAttr ".aal" -type "attributeAlias" {"leftHandFK_rotateZ","angularValues[10]","leftHandFK_rotateY"
		,"angularValues[11]","leftHandFK_rotateX","angularValues[12]","leftFingerBaseFK_rotateZ"
		,"angularValues[13]","leftFingerBaseFK_rotateY","angularValues[14]","leftFingerBaseFK_rotateX"
		,"angularValues[15]","LeftHandEff_rotateZ","angularValues[16]","LeftHandEff_rotateY"
		,"angularValues[17]","LeftHandEff_rotateX","angularValues[18]","LeftForeArmEff_rotateZ"
		,"angularValues[19]","leftCollarFK_rotateZ","angularValues[1]","LeftForeArmEff_rotateY"
		,"angularValues[20]","LeftForeArmEff_rotateX","angularValues[21]","LeftArmEff_rotateZ"
		,"angularValues[22]","LeftArmEff_rotateY","angularValues[23]","LeftArmEff_rotateX"
		,"angularValues[24]","LeftFingerBaseEff_rotateZ","angularValues[25]","LeftFingerBaseEff_rotateY"
		,"angularValues[26]","LeftFingerBaseEff_rotateX","angularValues[27]","leftCollarFK_rotateY"
		,"angularValues[2]","leftCollarFK_rotateX","angularValues[3]","leftArmFK_rotateZ"
		,"angularValues[4]","leftArmFK_rotateY","angularValues[5]","leftArmFK_rotateX","angularValues[6]"
		,"leftForeArmFK_rotateZ","angularValues[7]","leftForeArmFK_rotateY","angularValues[8]"
		,"leftForeArmFK_rotateX","angularValues[9]","leftHandFK_translateZ","linearValues[10]"
		,"leftHandFK_translateY","linearValues[11]","leftHandFK_translateX","linearValues[12]"
		,"leftFingerBaseFK_translateZ","linearValues[13]","leftFingerBaseFK_translateY","linearValues[14]"
		,"leftFingerBaseFK_translateX","linearValues[15]","LeftHandEff_translateZ","linearValues[16]"
		,"LeftHandEff_translateY","linearValues[17]","LeftHandEff_translateX","linearValues[18]"
		,"LeftForeArmEff_translateZ","linearValues[19]","leftCollarFK_translateZ","linearValues[1]"
		,"LeftForeArmEff_translateY","linearValues[20]","LeftForeArmEff_translateX","linearValues[21]"
		,"LeftArmEff_translateZ","linearValues[22]","LeftArmEff_translateY","linearValues[23]"
		,"LeftArmEff_translateX","linearValues[24]","LeftFingerBaseEff_translateZ","linearValues[25]"
		,"LeftFingerBaseEff_translateY","linearValues[26]","LeftFingerBaseEff_translateX"
		,"linearValues[27]","leftCollarFK_translateY","linearValues[2]","leftCollarFK_translateX"
		,"linearValues[3]","leftArmFK_translateZ","linearValues[4]","leftArmFK_translateY"
		,"linearValues[5]","leftArmFK_translateX","linearValues[6]","leftForeArmFK_translateZ"
		,"linearValues[7]","leftForeArmFK_translateY","linearValues[8]","leftForeArmFK_translateX"
		,"linearValues[9]","leftHandFK_scaleZ","unitlessValues[10]","leftHandFK_scaleY","unitlessValues[11]"
		,"leftHandFK_scaleX","unitlessValues[12]","leftFingerBaseFK_scaleZ","unitlessValues[13]"
		,"leftFingerBaseFK_scaleY","unitlessValues[14]","leftFingerBaseFK_scaleX","unitlessValues[15]"
		,"LeftHandEff_reachRotation","unitlessValues[16]","LeftHandEff_reachTranslation","unitlessValues[17]"
		,"LeftForeArmEff_reachRotation","unitlessValues[18]","LeftForeArmEff_reachTranslation"
		,"unitlessValues[19]","leftCollarFK_scaleZ","unitlessValues[1]","LeftArmEff_reachRotation"
		,"unitlessValues[20]","LeftArmEff_reachTranslation","unitlessValues[21]","LeftFingerBaseEff_reachRotation"
		,"unitlessValues[22]","LeftFingerBaseEff_reachTranslation","unitlessValues[23]","leftCollarFK_scaleY"
		,"unitlessValues[2]","leftCollarFK_scaleX","unitlessValues[3]","leftArmFK_scaleZ"
		,"unitlessValues[4]","leftArmFK_scaleY","unitlessValues[5]","leftArmFK_scaleX","unitlessValues[6]"
		,"leftForeArmFK_scaleZ","unitlessValues[7]","leftForeArmFK_scaleY","unitlessValues[8]"
		,"leftForeArmFK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightArm";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 77 ".dnsm";
	setAttr -s 23 ".uv[1:23]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 
		0 0 0;
	setAttr -s 23 ".uv";
	setAttr -s 27 ".lv[1:27]"  5.7752670970886042 -0.096567263976666595 
		-1.5569438734737615 2.8370312195266933 -7.4755355573139362 -1.9820034161578612 -0.85564111827055189 
		-5.5525901359158762 0.15697966370801897 -0.4555685375310059 -4.8372117410277582 0.019820516106291652 
		0.74828755982367579 -6.7278616259923858 -1.3802408484283903 0 0 0 0 0 0 0 0 0 0 0 
		0;
	setAttr -s 27 ".lv";
	setAttr -s 27 ".av";
	setAttr -s 27 ".av";
	setAttr ".am" -type "characterMapping" 77 "rightCollarFK.scaleZ" 0 1 "rightCollarFK.scaleY" 
		0 2 "rightCollarFK.scaleX" 0 3 "rightCollarFK.rotateZ" 2 
		1 "rightCollarFK.rotateY" 2 2 "rightCollarFK.rotateX" 2 3 "rightCollarFK.translateZ" 
		1 1 "rightCollarFK.translateY" 1 2 "rightCollarFK.translateX" 
		1 3 "rightArmFK.scaleZ" 0 4 "rightArmFK.scaleY" 0 5 "rightArmFK.scaleX" 
		0 6 "rightArmFK.rotateZ" 2 4 "rightArmFK.rotateY" 2 5 "rightArmFK.rotateX" 
		2 6 "rightArmFK.translateZ" 1 4 "rightArmFK.translateY" 1 
		5 "rightArmFK.translateX" 1 6 "rightForeArmFK.scaleZ" 0 7 "rightForeArmFK.scaleY" 
		0 8 "rightForeArmFK.scaleX" 0 9 "rightForeArmFK.rotateZ" 2 
		7 "rightForeArmFK.rotateY" 2 8 "rightForeArmFK.rotateX" 2 9 "rightForeArmFK.translateZ" 
		1 7 "rightForeArmFK.translateY" 1 8 "rightForeArmFK.translateX" 
		1 9 "rightHandFK.scaleZ" 0 10 "rightHandFK.scaleY" 0 11 "rightHandFK.scaleX" 
		0 12 "rightHandFK.rotateZ" 2 10 "rightHandFK.rotateY" 2 11 "rightHandFK.rotateX" 
		2 12 "rightHandFK.translateZ" 1 10 "rightHandFK.translateY" 1 
		11 "rightHandFK.translateX" 1 12 "rightFingerBaseFK.scaleZ" 0 13 "rightFingerBaseFK.scaleY" 
		0 14 "rightFingerBaseFK.scaleX" 0 15 "rightFingerBaseFK.rotateZ" 
		2 13 "rightFingerBaseFK.rotateY" 2 14 "rightFingerBaseFK.rotateX" 
		2 15 "rightFingerBaseFK.translateZ" 1 13 "rightFingerBaseFK.translateY" 
		1 14 "rightFingerBaseFK.translateX" 1 15 "RightHandEff.reachRotation" 
		0 16 "RightHandEff.reachTranslation" 0 17 "RightHandEff.rotateZ" 
		2 16 "RightHandEff.rotateY" 2 17 "RightHandEff.rotateX" 2 
		18 "RightHandEff.translateZ" 1 16 "RightHandEff.translateY" 1 17 "RightHandEff.translateX" 
		1 18 "RightForeArmEff.reachRotation" 0 18 "RightForeArmEff.reachTranslation" 
		0 19 "RightForeArmEff.rotateZ" 2 19 "RightForeArmEff.rotateY" 2 
		20 "RightForeArmEff.rotateX" 2 21 "RightForeArmEff.translateZ" 1 
		19 "RightForeArmEff.translateY" 1 20 "RightForeArmEff.translateX" 1 
		21 "RightArmEff.reachRotation" 0 20 "RightArmEff.reachTranslation" 0 
		21 "RightArmEff.rotateZ" 2 22 "RightArmEff.rotateY" 2 23 "RightArmEff.rotateX" 
		2 24 "RightArmEff.translateZ" 1 22 "RightArmEff.translateY" 1 
		23 "RightArmEff.translateX" 1 24 "RightFingerBaseEff.reachRotation" 
		0 22 "RightFingerBaseEff.reachTranslation" 0 23 "RightFingerBaseEff.rotateZ" 
		2 25 "RightFingerBaseEff.rotateY" 2 26 "RightFingerBaseEff.rotateX" 
		2 27 "RightFingerBaseEff.translateZ" 1 25 "RightFingerBaseEff.translateY" 
		1 26 "RightFingerBaseEff.translateX" 1 27  ;
	setAttr ".aal" -type "attributeAlias" {"rightHandFK_rotateZ","angularValues[10]"
		,"rightHandFK_rotateY","angularValues[11]","rightHandFK_rotateX","angularValues[12]"
		,"rightFingerBaseFK_rotateZ","angularValues[13]","rightFingerBaseFK_rotateY","angularValues[14]"
		,"rightFingerBaseFK_rotateX","angularValues[15]","RightHandEff_rotateZ","angularValues[16]"
		,"RightHandEff_rotateY","angularValues[17]","RightHandEff_rotateX","angularValues[18]"
		,"RightForeArmEff_rotateZ","angularValues[19]","rightCollarFK_rotateZ","angularValues[1]"
		,"RightForeArmEff_rotateY","angularValues[20]","RightForeArmEff_rotateX","angularValues[21]"
		,"RightArmEff_rotateZ","angularValues[22]","RightArmEff_rotateY","angularValues[23]"
		,"RightArmEff_rotateX","angularValues[24]","RightFingerBaseEff_rotateZ","angularValues[25]"
		,"RightFingerBaseEff_rotateY","angularValues[26]","RightFingerBaseEff_rotateX","angularValues[27]"
		,"rightCollarFK_rotateY","angularValues[2]","rightCollarFK_rotateX","angularValues[3]"
		,"rightArmFK_rotateZ","angularValues[4]","rightArmFK_rotateY","angularValues[5]","rightArmFK_rotateX"
		,"angularValues[6]","rightForeArmFK_rotateZ","angularValues[7]","rightForeArmFK_rotateY"
		,"angularValues[8]","rightForeArmFK_rotateX","angularValues[9]","rightHandFK_translateZ"
		,"linearValues[10]","rightHandFK_translateY","linearValues[11]","rightHandFK_translateX"
		,"linearValues[12]","rightFingerBaseFK_translateZ","linearValues[13]","rightFingerBaseFK_translateY"
		,"linearValues[14]","rightFingerBaseFK_translateX","linearValues[15]","RightHandEff_translateZ"
		,"linearValues[16]","RightHandEff_translateY","linearValues[17]","RightHandEff_translateX"
		,"linearValues[18]","RightForeArmEff_translateZ","linearValues[19]","rightCollarFK_translateZ"
		,"linearValues[1]","RightForeArmEff_translateY","linearValues[20]","RightForeArmEff_translateX"
		,"linearValues[21]","RightArmEff_translateZ","linearValues[22]","RightArmEff_translateY"
		,"linearValues[23]","RightArmEff_translateX","linearValues[24]","RightFingerBaseEff_translateZ"
		,"linearValues[25]","RightFingerBaseEff_translateY","linearValues[26]","RightFingerBaseEff_translateX"
		,"linearValues[27]","rightCollarFK_translateY","linearValues[2]","rightCollarFK_translateX"
		,"linearValues[3]","rightArmFK_translateZ","linearValues[4]","rightArmFK_translateY"
		,"linearValues[5]","rightArmFK_translateX","linearValues[6]","rightForeArmFK_translateZ"
		,"linearValues[7]","rightForeArmFK_translateY","linearValues[8]","rightForeArmFK_translateX"
		,"linearValues[9]","rightHandFK_scaleZ","unitlessValues[10]","rightHandFK_scaleY"
		,"unitlessValues[11]","rightHandFK_scaleX","unitlessValues[12]","rightFingerBaseFK_scaleZ"
		,"unitlessValues[13]","rightFingerBaseFK_scaleY","unitlessValues[14]","rightFingerBaseFK_scaleX"
		,"unitlessValues[15]","RightHandEff_reachRotation","unitlessValues[16]","RightHandEff_reachTranslation"
		,"unitlessValues[17]","RightForeArmEff_reachRotation","unitlessValues[18]","RightForeArmEff_reachTranslation"
		,"unitlessValues[19]","rightCollarFK_scaleZ","unitlessValues[1]","RightArmEff_reachRotation"
		,"unitlessValues[20]","RightArmEff_reachTranslation","unitlessValues[21]","RightFingerBaseEff_reachRotation"
		,"unitlessValues[22]","RightFingerBaseEff_reachTranslation","unitlessValues[23]","rightCollarFK_scaleY"
		,"unitlessValues[2]","rightCollarFK_scaleX","unitlessValues[3]","rightArmFK_scaleZ"
		,"unitlessValues[4]","rightArmFK_scaleY","unitlessValues[5]","rightArmFK_scaleX","unitlessValues[6]"
		,"rightForeArmFK_scaleZ","unitlessValues[7]","rightForeArmFK_scaleY","unitlessValues[8]"
		,"rightForeArmFK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftLeg";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 68 ".dnsm";
	setAttr -s 20 ".uv[1:20]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0;
	setAttr -s 20 ".uv";
	setAttr -s 24 ".lv[1:24]"  -1.0272313387652119 -3.5522689184926435 
		2.141759203728248 0.3696909642580728 -6.4950470690987032 1.3407595199290778 -2.8302263814577113 
		-7.4140839771905913 0.26972803565468162 -0.4731106627615258 -7.4864650444928502 1.5346785565449244 
		0 0 0 0 0 0 0 0 0 0 0 0;
	setAttr -s 24 ".lv";
	setAttr -s 24 ".av";
	setAttr -s 24 ".av";
	setAttr ".am" -type "characterMapping" 68 "leftUpLegFK.scaleZ" 0 1 "leftUpLegFK.scaleY" 
		0 2 "leftUpLegFK.scaleX" 0 3 "leftUpLegFK.rotateZ" 2 1 "leftUpLegFK.rotateY" 
		2 2 "leftUpLegFK.rotateX" 2 3 "leftUpLegFK.translateZ" 1 
		1 "leftUpLegFK.translateY" 1 2 "leftUpLegFK.translateX" 1 3 "leftLegFK.scaleZ" 
		0 4 "leftLegFK.scaleY" 0 5 "leftLegFK.scaleX" 0 6 "leftLegFK.rotateZ" 
		2 4 "leftLegFK.rotateY" 2 5 "leftLegFK.rotateX" 2 6 "leftLegFK.translateZ" 
		1 4 "leftLegFK.translateY" 1 5 "leftLegFK.translateX" 1 
		6 "leftFootFK.scaleZ" 0 7 "leftFootFK.scaleY" 0 8 "leftFootFK.scaleX" 
		0 9 "leftFootFK.rotateZ" 2 7 "leftFootFK.rotateY" 2 8 "leftFootFK.rotateX" 
		2 9 "leftFootFK.translateZ" 1 7 "leftFootFK.translateY" 1 
		8 "leftFootFK.translateX" 1 9 "leftToeBaseFK.scaleZ" 0 10 "leftToeBaseFK.scaleY" 
		0 11 "leftToeBaseFK.scaleX" 0 12 "leftToeBaseFK.rotateZ" 2 
		10 "leftToeBaseFK.rotateY" 2 11 "leftToeBaseFK.rotateX" 2 12 "leftToeBaseFK.translateZ" 
		1 10 "leftToeBaseFK.translateY" 1 11 "leftToeBaseFK.translateX" 
		1 12 "LeftFootEff.reachRotation" 0 13 "LeftFootEff.reachTranslation" 
		0 14 "LeftFootEff.rotateZ" 2 13 "LeftFootEff.rotateY" 2 14 "LeftFootEff.rotateX" 
		2 15 "LeftFootEff.translateZ" 1 13 "LeftFootEff.translateY" 1 
		14 "LeftFootEff.translateX" 1 15 "LeftLegEff.reachRotation" 0 15 "LeftLegEff.reachTranslation" 
		0 16 "LeftLegEff.rotateZ" 2 16 "LeftLegEff.rotateY" 2 17 "LeftLegEff.rotateX" 
		2 18 "LeftLegEff.translateZ" 1 16 "LeftLegEff.translateY" 1 
		17 "LeftLegEff.translateX" 1 18 "LeftToeBaseEff.reachRotation" 0 
		17 "LeftToeBaseEff.reachTranslation" 0 18 "LeftToeBaseEff.rotateZ" 2 
		19 "LeftToeBaseEff.rotateY" 2 20 "LeftToeBaseEff.rotateX" 2 21 "LeftToeBaseEff.translateZ" 
		1 19 "LeftToeBaseEff.translateY" 1 20 "LeftToeBaseEff.translateX" 
		1 21 "LeftUpLegEff.reachRotation" 0 19 "LeftUpLegEff.reachTranslation" 
		0 20 "LeftUpLegEff.rotateZ" 2 22 "LeftUpLegEff.rotateY" 2 
		23 "LeftUpLegEff.rotateX" 2 24 "LeftUpLegEff.translateZ" 1 22 "LeftUpLegEff.translateY" 
		1 23 "LeftUpLegEff.translateX" 1 24  ;
	setAttr ".aal" -type "attributeAlias" {"leftToeBaseFK_rotateZ","angularValues[10]"
		,"leftToeBaseFK_rotateY","angularValues[11]","leftToeBaseFK_rotateX","angularValues[12]"
		,"LeftFootEff_rotateZ","angularValues[13]","LeftFootEff_rotateY","angularValues[14]"
		,"LeftFootEff_rotateX","angularValues[15]","LeftLegEff_rotateZ","angularValues[16]"
		,"LeftLegEff_rotateY","angularValues[17]","LeftLegEff_rotateX","angularValues[18]"
		,"LeftToeBaseEff_rotateZ","angularValues[19]","leftUpLegFK_rotateZ","angularValues[1]"
		,"LeftToeBaseEff_rotateY","angularValues[20]","LeftToeBaseEff_rotateX","angularValues[21]"
		,"LeftUpLegEff_rotateZ","angularValues[22]","LeftUpLegEff_rotateY","angularValues[23]"
		,"LeftUpLegEff_rotateX","angularValues[24]","leftUpLegFK_rotateY","angularValues[2]"
		,"leftUpLegFK_rotateX","angularValues[3]","leftLegFK_rotateZ","angularValues[4]","leftLegFK_rotateY"
		,"angularValues[5]","leftLegFK_rotateX","angularValues[6]","leftFootFK_rotateZ","angularValues[7]"
		,"leftFootFK_rotateY","angularValues[8]","leftFootFK_rotateX","angularValues[9]","leftToeBaseFK_translateZ"
		,"linearValues[10]","leftToeBaseFK_translateY","linearValues[11]","leftToeBaseFK_translateX"
		,"linearValues[12]","LeftFootEff_translateZ","linearValues[13]","LeftFootEff_translateY"
		,"linearValues[14]","LeftFootEff_translateX","linearValues[15]","LeftLegEff_translateZ"
		,"linearValues[16]","LeftLegEff_translateY","linearValues[17]","LeftLegEff_translateX"
		,"linearValues[18]","LeftToeBaseEff_translateZ","linearValues[19]","leftUpLegFK_translateZ"
		,"linearValues[1]","LeftToeBaseEff_translateY","linearValues[20]","LeftToeBaseEff_translateX"
		,"linearValues[21]","LeftUpLegEff_translateZ","linearValues[22]","LeftUpLegEff_translateY"
		,"linearValues[23]","LeftUpLegEff_translateX","linearValues[24]","leftUpLegFK_translateY"
		,"linearValues[2]","leftUpLegFK_translateX","linearValues[3]","leftLegFK_translateZ"
		,"linearValues[4]","leftLegFK_translateY","linearValues[5]","leftLegFK_translateX"
		,"linearValues[6]","leftFootFK_translateZ","linearValues[7]","leftFootFK_translateY"
		,"linearValues[8]","leftFootFK_translateX","linearValues[9]","leftToeBaseFK_scaleZ"
		,"unitlessValues[10]","leftToeBaseFK_scaleY","unitlessValues[11]","leftToeBaseFK_scaleX"
		,"unitlessValues[12]","LeftFootEff_reachRotation","unitlessValues[13]","LeftFootEff_reachTranslation"
		,"unitlessValues[14]","LeftLegEff_reachRotation","unitlessValues[15]","LeftLegEff_reachTranslation"
		,"unitlessValues[16]","LeftToeBaseEff_reachRotation","unitlessValues[17]","LeftToeBaseEff_reachTranslation"
		,"unitlessValues[18]","LeftUpLegEff_reachRotation","unitlessValues[19]","leftUpLegFK_scaleZ"
		,"unitlessValues[1]","LeftUpLegEff_reachTranslation","unitlessValues[20]","leftUpLegFK_scaleY"
		,"unitlessValues[2]","leftUpLegFK_scaleX","unitlessValues[3]","leftLegFK_scaleZ","unitlessValues[4]"
		,"leftLegFK_scaleY","unitlessValues[5]","leftLegFK_scaleX","unitlessValues[6]","leftFootFK_scaleZ"
		,"unitlessValues[7]","leftFootFK_scaleY","unitlessValues[8]","leftFootFK_scaleX","unitlessValues[9]"
		} ;
createNode character -n "_rightLeg";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 68 ".dnsm";
	setAttr -s 20 ".uv[1:20]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0;
	setAttr -s 20 ".uv";
	setAttr -s 24 ".lv[1:24]"  -1.0272015302523378 -3.5522804894488189 
		-2.1417467128651744 0.37013380136650298 -6.4951341841230956 -1.340561132735258 -2.8306771333253007 
		-7.4139241245559901 -0.26930759050838216 -0.47318516134493116 -7.4865201850745695 
		-1.5343363975566242 0 0 0 0 0 0 0 0 0 0 0 0;
	setAttr -s 24 ".lv";
	setAttr -s 24 ".av";
	setAttr -s 24 ".av";
	setAttr ".am" -type "characterMapping" 68 "rightUpLegFK.scaleZ" 0 1 "rightUpLegFK.scaleY" 
		0 2 "rightUpLegFK.scaleX" 0 3 "rightUpLegFK.rotateZ" 2 1 "rightUpLegFK.rotateY" 
		2 2 "rightUpLegFK.rotateX" 2 3 "rightUpLegFK.translateZ" 1 
		1 "rightUpLegFK.translateY" 1 2 "rightUpLegFK.translateX" 1 3 "rightLegFK.scaleZ" 
		0 4 "rightLegFK.scaleY" 0 5 "rightLegFK.scaleX" 0 6 "rightLegFK.rotateZ" 
		2 4 "rightLegFK.rotateY" 2 5 "rightLegFK.rotateX" 2 6 "rightLegFK.translateZ" 
		1 4 "rightLegFK.translateY" 1 5 "rightLegFK.translateX" 1 
		6 "rightFootFK.scaleZ" 0 7 "rightFootFK.scaleY" 0 8 "rightFootFK.scaleX" 
		0 9 "rightFootFK.rotateZ" 2 7 "rightFootFK.rotateY" 2 8 "rightFootFK.rotateX" 
		2 9 "rightFootFK.translateZ" 1 7 "rightFootFK.translateY" 1 
		8 "rightFootFK.translateX" 1 9 "rightToeBaseFK.scaleZ" 0 10 "rightToeBaseFK.scaleY" 
		0 11 "rightToeBaseFK.scaleX" 0 12 "rightToeBaseFK.rotateZ" 2 
		10 "rightToeBaseFK.rotateY" 2 11 "rightToeBaseFK.rotateX" 2 12 "rightToeBaseFK.translateZ" 
		1 10 "rightToeBaseFK.translateY" 1 11 "rightToeBaseFK.translateX" 
		1 12 "RightFootEff.reachRotation" 0 13 "RightFootEff.reachTranslation" 
		0 14 "RightFootEff.rotateZ" 2 13 "RightFootEff.rotateY" 2 
		14 "RightFootEff.rotateX" 2 15 "RightFootEff.translateZ" 1 13 "RightFootEff.translateY" 
		1 14 "RightFootEff.translateX" 1 15 "RightLegEff.reachRotation" 
		0 15 "RightLegEff.reachTranslation" 0 16 "RightLegEff.rotateZ" 
		2 16 "RightLegEff.rotateY" 2 17 "RightLegEff.rotateX" 2 18 "RightLegEff.translateZ" 
		1 16 "RightLegEff.translateY" 1 17 "RightLegEff.translateX" 1 
		18 "RightToeBaseEff.reachRotation" 0 17 "RightToeBaseEff.reachTranslation" 
		0 18 "RightToeBaseEff.rotateZ" 2 19 "RightToeBaseEff.rotateY" 2 
		20 "RightToeBaseEff.rotateX" 2 21 "RightToeBaseEff.translateZ" 1 
		19 "RightToeBaseEff.translateY" 1 20 "RightToeBaseEff.translateX" 1 
		21 "RightUpLegEff.reachRotation" 0 19 "RightUpLegEff.reachTranslation" 
		0 20 "RightUpLegEff.rotateZ" 2 22 "RightUpLegEff.rotateY" 2 
		23 "RightUpLegEff.rotateX" 2 24 "RightUpLegEff.translateZ" 1 22 "RightUpLegEff.translateY" 
		1 23 "RightUpLegEff.translateX" 1 24  ;
	setAttr ".aal" -type "attributeAlias" {"rightToeBaseFK_rotateZ","angularValues[10]"
		,"rightToeBaseFK_rotateY","angularValues[11]","rightToeBaseFK_rotateX","angularValues[12]"
		,"RightFootEff_rotateZ","angularValues[13]","RightFootEff_rotateY","angularValues[14]"
		,"RightFootEff_rotateX","angularValues[15]","RightLegEff_rotateZ","angularValues[16]"
		,"RightLegEff_rotateY","angularValues[17]","RightLegEff_rotateX","angularValues[18]"
		,"RightToeBaseEff_rotateZ","angularValues[19]","rightUpLegFK_rotateZ","angularValues[1]"
		,"RightToeBaseEff_rotateY","angularValues[20]","RightToeBaseEff_rotateX","angularValues[21]"
		,"RightUpLegEff_rotateZ","angularValues[22]","RightUpLegEff_rotateY","angularValues[23]"
		,"RightUpLegEff_rotateX","angularValues[24]","rightUpLegFK_rotateY","angularValues[2]"
		,"rightUpLegFK_rotateX","angularValues[3]","rightLegFK_rotateZ","angularValues[4]"
		,"rightLegFK_rotateY","angularValues[5]","rightLegFK_rotateX","angularValues[6]","rightFootFK_rotateZ"
		,"angularValues[7]","rightFootFK_rotateY","angularValues[8]","rightFootFK_rotateX"
		,"angularValues[9]","rightToeBaseFK_translateZ","linearValues[10]","rightToeBaseFK_translateY"
		,"linearValues[11]","rightToeBaseFK_translateX","linearValues[12]","RightFootEff_translateZ"
		,"linearValues[13]","RightFootEff_translateY","linearValues[14]","RightFootEff_translateX"
		,"linearValues[15]","RightLegEff_translateZ","linearValues[16]","RightLegEff_translateY"
		,"linearValues[17]","RightLegEff_translateX","linearValues[18]","RightToeBaseEff_translateZ"
		,"linearValues[19]","rightUpLegFK_translateZ","linearValues[1]","RightToeBaseEff_translateY"
		,"linearValues[20]","RightToeBaseEff_translateX","linearValues[21]","RightUpLegEff_translateZ"
		,"linearValues[22]","RightUpLegEff_translateY","linearValues[23]","RightUpLegEff_translateX"
		,"linearValues[24]","rightUpLegFK_translateY","linearValues[2]","rightUpLegFK_translateX"
		,"linearValues[3]","rightLegFK_translateZ","linearValues[4]","rightLegFK_translateY"
		,"linearValues[5]","rightLegFK_translateX","linearValues[6]","rightFootFK_translateZ"
		,"linearValues[7]","rightFootFK_translateY","linearValues[8]","rightFootFK_translateX"
		,"linearValues[9]","rightToeBaseFK_scaleZ","unitlessValues[10]","rightToeBaseFK_scaleY"
		,"unitlessValues[11]","rightToeBaseFK_scaleX","unitlessValues[12]","RightFootEff_reachRotation"
		,"unitlessValues[13]","RightFootEff_reachTranslation","unitlessValues[14]","RightLegEff_reachRotation"
		,"unitlessValues[15]","RightLegEff_reachTranslation","unitlessValues[16]","RightToeBaseEff_reachRotation"
		,"unitlessValues[17]","RightToeBaseEff_reachTranslation","unitlessValues[18]","RightUpLegEff_reachRotation"
		,"unitlessValues[19]","rightUpLegFK_scaleZ","unitlessValues[1]","RightUpLegEff_reachTranslation"
		,"unitlessValues[20]","rightUpLegFK_scaleY","unitlessValues[2]","rightUpLegFK_scaleX"
		,"unitlessValues[3]","rightLegFK_scaleZ","unitlessValues[4]","rightLegFK_scaleY","unitlessValues[5]"
		,"rightLegFK_scaleX","unitlessValues[6]","rightFootFK_scaleZ","unitlessValues[7]"
		,"rightFootFK_scaleY","unitlessValues[8]","rightFootFK_scaleX","unitlessValues[9]"
		} ;
createNode character -n "_spine";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 43 ".dnsm";
	setAttr -s 13 ".uv[1:13]"  1 1 1 1 1 1 1 1 1 0 0 0 0;
	setAttr -s 13 ".uv";
	setAttr -s 15 ".lv[1:15]"  2.8025693893466945 0.44673156735957065 5.2789207986487542e-006 
		2.9910374169905305 0.1754429430063098 -3.6266592501177754e-006 3.2020912329659215 
		-0.2820393411622355 -5.4081648655841157e-006 0 0 0 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 43 "spineFK.scaleZ" 0 1 "spineFK.scaleY" 
		0 2 "spineFK.scaleX" 0 3 "spineFK.rotateZ" 2 1 "spineFK.rotateY" 
		2 2 "spineFK.rotateX" 2 3 "spineFK.translateZ" 1 1 "spineFK.translateY" 
		1 2 "spineFK.translateX" 1 3 "spine1FK.scaleZ" 0 4 "spine1FK.scaleY" 
		0 5 "spine1FK.scaleX" 0 6 "spine1FK.rotateZ" 2 4 "spine1FK.rotateY" 
		2 5 "spine1FK.rotateX" 2 6 "spine1FK.translateZ" 1 4 "spine1FK.translateY" 
		1 5 "spine1FK.translateX" 1 6 "spine2FK.scaleZ" 0 7 "spine2FK.scaleY" 
		0 8 "spine2FK.scaleX" 0 9 "spine2FK.rotateZ" 2 7 "spine2FK.rotateY" 
		2 8 "spine2FK.rotateX" 2 9 "spine2FK.translateZ" 1 7 "spine2FK.translateY" 
		1 8 "spine2FK.translateX" 1 9 "SpineEff.reachRotation" 0 
		10 "SpineEff.reachTranslation" 0 11 "SpineEff.rotateZ" 2 10 "SpineEff.rotateY" 
		2 11 "SpineEff.rotateX" 2 12 "SpineEff.translateZ" 1 10 "SpineEff.translateY" 
		1 11 "SpineEff.translateX" 1 12 "NeckEff.reachRotation" 0 
		12 "NeckEff.reachTranslation" 0 13 "NeckEff.rotateZ" 2 13 "NeckEff.rotateY" 
		2 14 "NeckEff.rotateX" 2 15 "NeckEff.translateZ" 1 13 "NeckEff.translateY" 
		1 14 "NeckEff.translateX" 1 15  ;
	setAttr ".aal" -type "attributeAlias" {"SpineEff_rotateZ","angularValues[10]","SpineEff_rotateY"
		,"angularValues[11]","SpineEff_rotateX","angularValues[12]","NeckEff_rotateZ","angularValues[13]"
		,"NeckEff_rotateY","angularValues[14]","NeckEff_rotateX","angularValues[15]","spineFK_rotateZ"
		,"angularValues[1]","spineFK_rotateY","angularValues[2]","spineFK_rotateX","angularValues[3]"
		,"spine1FK_rotateZ","angularValues[4]","spine1FK_rotateY","angularValues[5]","spine1FK_rotateX"
		,"angularValues[6]","spine2FK_rotateZ","angularValues[7]","spine2FK_rotateY","angularValues[8]"
		,"spine2FK_rotateX","angularValues[9]","SpineEff_translateZ","linearValues[10]","SpineEff_translateY"
		,"linearValues[11]","SpineEff_translateX","linearValues[12]","NeckEff_translateZ"
		,"linearValues[13]","NeckEff_translateY","linearValues[14]","NeckEff_translateX","linearValues[15]"
		,"spineFK_translateZ","linearValues[1]","spineFK_translateY","linearValues[2]","spineFK_translateX"
		,"linearValues[3]","spine1FK_translateZ","linearValues[4]","spine1FK_translateY","linearValues[5]"
		,"spine1FK_translateX","linearValues[6]","spine2FK_translateZ","linearValues[7]","spine2FK_translateY"
		,"linearValues[8]","spine2FK_translateX","linearValues[9]","SpineEff_reachRotation"
		,"unitlessValues[10]","SpineEff_reachTranslation","unitlessValues[11]","NeckEff_reachRotation"
		,"unitlessValues[12]","NeckEff_reachTranslation","unitlessValues[13]","spineFK_scaleZ"
		,"unitlessValues[1]","spineFK_scaleY","unitlessValues[2]","spineFK_scaleX","unitlessValues[3]"
		,"spine1FK_scaleZ","unitlessValues[4]","spine1FK_scaleY","unitlessValues[5]","spine1FK_scaleX"
		,"unitlessValues[6]","spine2FK_scaleZ","unitlessValues[7]","spine2FK_scaleY","unitlessValues[8]"
		,"spine2FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_head";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 80 ".dnsm";
	setAttr -s 26 ".uv[1:26]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
		1 1 1 1 0 0;
	setAttr -s 26 ".uv";
	setAttr -s 27 ".lv[1:27]"  10.010551569090117 -3.8573615183378855 -1.6134341193559847e-005 
		1.7655250410870522 0.0035541798285088078 -4.5611533821967405e-006 1.7630650670434758 
		0.33334425226353659 -6.9542407353728134e-006 1.6894646806086655 0.95731724585714417 
		-4.1088102466930445e-006 0.99728641805295304 1.7220278237214153 4.9907007396878108e-006 
		0.66351506734959642 1.6170054082933447 8.0220104341609125e-006 0.36803112508189173 
		1.5815256767019719 7.5289102521461457e-006 0.33128377243217599 1.7655157034899673 
		8.2712937640627335e-006 0 0 0;
	setAttr -s 27 ".lv";
	setAttr -s 27 ".av";
	setAttr -s 27 ".av";
	setAttr ".am" -type "characterMapping" 80 "neckFK.scaleZ" 0 1 "neckFK.scaleY" 
		0 2 "neckFK.scaleX" 0 3 "neckFK.rotateZ" 2 1 "neckFK.rotateY" 
		2 2 "neckFK.rotateX" 2 3 "neckFK.translateZ" 1 1 "neckFK.translateY" 
		1 2 "neckFK.translateX" 1 3 "neck1FK.scaleZ" 0 4 "neck1FK.scaleY" 
		0 5 "neck1FK.scaleX" 0 6 "neck1FK.rotateZ" 2 4 "neck1FK.rotateY" 
		2 5 "neck1FK.rotateX" 2 6 "neck1FK.translateZ" 1 4 "neck1FK.translateY" 
		1 5 "neck1FK.translateX" 1 6 "neck2FK.scaleZ" 0 7 "neck2FK.scaleY" 
		0 8 "neck2FK.scaleX" 0 9 "neck2FK.rotateZ" 2 7 "neck2FK.rotateY" 
		2 8 "neck2FK.rotateX" 2 9 "neck2FK.translateZ" 1 7 "neck2FK.translateY" 
		1 8 "neck2FK.translateX" 1 9 "neck3FK.scaleZ" 0 10 "neck3FK.scaleY" 
		0 11 "neck3FK.scaleX" 0 12 "neck3FK.rotateZ" 2 10 "neck3FK.rotateY" 
		2 11 "neck3FK.rotateX" 2 12 "neck3FK.translateZ" 1 10 "neck3FK.translateY" 
		1 11 "neck3FK.translateX" 1 12 "neck4FK.scaleZ" 0 13 "neck4FK.scaleY" 
		0 14 "neck4FK.scaleX" 0 15 "neck4FK.rotateZ" 2 13 "neck4FK.rotateY" 
		2 14 "neck4FK.rotateX" 2 15 "neck4FK.translateZ" 1 13 "neck4FK.translateY" 
		1 14 "neck4FK.translateX" 1 15 "neck5FK.scaleZ" 0 16 "neck5FK.scaleY" 
		0 17 "neck5FK.scaleX" 0 18 "neck5FK.rotateZ" 2 16 "neck5FK.rotateY" 
		2 17 "neck5FK.rotateX" 2 18 "neck5FK.translateZ" 1 16 "neck5FK.translateY" 
		1 17 "neck5FK.translateX" 1 18 "neck6FK.scaleZ" 0 19 "neck6FK.scaleY" 
		0 20 "neck6FK.scaleX" 0 21 "neck6FK.rotateZ" 2 19 "neck6FK.rotateY" 
		2 20 "neck6FK.rotateX" 2 21 "neck6FK.translateZ" 1 19 "neck6FK.translateY" 
		1 20 "neck6FK.translateX" 1 21 "headFK.scaleZ" 0 22 "headFK.scaleY" 
		0 23 "headFK.scaleX" 0 24 "headFK.rotateZ" 2 22 "headFK.rotateY" 
		2 23 "headFK.rotateX" 2 24 "headFK.translateZ" 1 22 "headFK.translateY" 
		1 23 "headFK.translateX" 1 24 "HeadEff.reachRotation" 0 25 "HeadEff.reachTranslation" 
		0 26 "HeadEff.rotateZ" 2 25 "HeadEff.rotateY" 2 26 "HeadEff.rotateX" 
		2 27 "HeadEff.translateZ" 1 25 "HeadEff.translateY" 1 26 "HeadEff.translateX" 
		1 27  ;
	setAttr ".aal" -type "attributeAlias" {"neck3FK_rotateZ","angularValues[10]","neck3FK_rotateY"
		,"angularValues[11]","neck3FK_rotateX","angularValues[12]","neck4FK_rotateZ","angularValues[13]"
		,"neck4FK_rotateY","angularValues[14]","neck4FK_rotateX","angularValues[15]","neck5FK_rotateZ"
		,"angularValues[16]","neck5FK_rotateY","angularValues[17]","neck5FK_rotateX","angularValues[18]"
		,"neck6FK_rotateZ","angularValues[19]","neckFK_rotateZ","angularValues[1]","neck6FK_rotateY"
		,"angularValues[20]","neck6FK_rotateX","angularValues[21]","headFK_rotateZ","angularValues[22]"
		,"headFK_rotateY","angularValues[23]","headFK_rotateX","angularValues[24]","HeadEff_rotateZ"
		,"angularValues[25]","HeadEff_rotateY","angularValues[26]","HeadEff_rotateX","angularValues[27]"
		,"neckFK_rotateY","angularValues[2]","neckFK_rotateX","angularValues[3]","neck1FK_rotateZ"
		,"angularValues[4]","neck1FK_rotateY","angularValues[5]","neck1FK_rotateX","angularValues[6]"
		,"neck2FK_rotateZ","angularValues[7]","neck2FK_rotateY","angularValues[8]","neck2FK_rotateX"
		,"angularValues[9]","neck3FK_translateZ","linearValues[10]","neck3FK_translateY","linearValues[11]"
		,"neck3FK_translateX","linearValues[12]","neck4FK_translateZ","linearValues[13]","neck4FK_translateY"
		,"linearValues[14]","neck4FK_translateX","linearValues[15]","neck5FK_translateZ","linearValues[16]"
		,"neck5FK_translateY","linearValues[17]","neck5FK_translateX","linearValues[18]","neck6FK_translateZ"
		,"linearValues[19]","neckFK_translateZ","linearValues[1]","neck6FK_translateY","linearValues[20]"
		,"neck6FK_translateX","linearValues[21]","headFK_translateZ","linearValues[22]","headFK_translateY"
		,"linearValues[23]","headFK_translateX","linearValues[24]","HeadEff_translateZ","linearValues[25]"
		,"HeadEff_translateY","linearValues[26]","HeadEff_translateX","linearValues[27]","neckFK_translateY"
		,"linearValues[2]","neckFK_translateX","linearValues[3]","neck1FK_translateZ","linearValues[4]"
		,"neck1FK_translateY","linearValues[5]","neck1FK_translateX","linearValues[6]","neck2FK_translateZ"
		,"linearValues[7]","neck2FK_translateY","linearValues[8]","neck2FK_translateX","linearValues[9]"
		,"neck3FK_scaleZ","unitlessValues[10]","neck3FK_scaleY","unitlessValues[11]","neck3FK_scaleX"
		,"unitlessValues[12]","neck4FK_scaleZ","unitlessValues[13]","neck4FK_scaleY","unitlessValues[14]"
		,"neck4FK_scaleX","unitlessValues[15]","neck5FK_scaleZ","unitlessValues[16]","neck5FK_scaleY"
		,"unitlessValues[17]","neck5FK_scaleX","unitlessValues[18]","neck6FK_scaleZ","unitlessValues[19]"
		,"neckFK_scaleZ","unitlessValues[1]","neck6FK_scaleY","unitlessValues[20]","neck6FK_scaleX"
		,"unitlessValues[21]","headFK_scaleZ","unitlessValues[22]","headFK_scaleY","unitlessValues[23]"
		,"headFK_scaleX","unitlessValues[24]","HeadEff_reachRotation","unitlessValues[25]"
		,"HeadEff_reachTranslation","unitlessValues[26]","neckFK_scaleY","unitlessValues[2]"
		,"neckFK_scaleX","unitlessValues[3]","neck1FK_scaleZ","unitlessValues[4]","neck1FK_scaleY"
		,"unitlessValues[5]","neck1FK_scaleX","unitlessValues[6]","neck2FK_scaleZ","unitlessValues[7]"
		,"neck2FK_scaleY","unitlessValues[8]","neck2FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_hips";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 17 ".dnsm";
	setAttr -s 5 ".uv[1:5]"  1 1 1 1 1;
	setAttr -s 5 ".uv";
	setAttr -s 6 ".lv[1:6]"  -10.282027244567871 26.183620452880859 -0.00048065185546875 
		0 0 0;
	setAttr -s 6 ".lv";
	setAttr -s 6 ".av";
	setAttr -s 6 ".av";
	setAttr ".am" -type "characterMapping" 17 "hipsFK.scaleZ" 0 1 "hipsFK.scaleY" 
		0 2 "hipsFK.scaleX" 0 3 "hipsFK.rotateZ" 2 1 "hipsFK.rotateY" 
		2 2 "hipsFK.rotateX" 2 3 "hipsFK.translateZ" 1 1 "hipsFK.translateY" 
		1 2 "hipsFK.translateX" 1 3 "HipsEff.reachRotation" 0 4 "HipsEff.reachTranslation" 
		0 5 "HipsEff.rotateZ" 2 4 "HipsEff.rotateY" 2 5 "HipsEff.rotateX" 
		2 6 "HipsEff.translateZ" 1 4 "HipsEff.translateY" 1 5 "HipsEff.translateX" 
		1 6  ;
	setAttr ".aal" -type "attributeAlias" {"hipsFK_rotateZ","angularValues[1]","hipsFK_rotateY"
		,"angularValues[2]","hipsFK_rotateX","angularValues[3]","HipsEff_rotateZ","angularValues[4]"
		,"HipsEff_rotateY","angularValues[5]","HipsEff_rotateX","angularValues[6]","hipsFK_translateZ"
		,"linearValues[1]","hipsFK_translateY","linearValues[2]","hipsFK_translateX","linearValues[3]"
		,"HipsEff_translateZ","linearValues[4]","HipsEff_translateY","linearValues[5]","HipsEff_translateX"
		,"linearValues[6]","hipsFK_scaleZ","unitlessValues[1]","hipsFK_scaleY","unitlessValues[2]"
		,"hipsFK_scaleX","unitlessValues[3]","HipsEff_reachRotation","unitlessValues[4]","HipsEff_reachTranslation"
		,"unitlessValues[5]"} ;
createNode character -n "_rightFingerMiddle";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.8088425088498532 -0.83263307891926641 
		-1.4160984771750948 0.94274746953619726 -0.13741872165010982 -0.049437989370063384 
		0.72990488134828446 -0.36394381859382569 -0.036927773115963625 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint49FK.scaleZ" 0 1 "joint49FK.scaleY" 
		0 2 "joint49FK.scaleX" 0 3 "joint49FK.rotateZ" 2 1 "joint49FK.rotateY" 
		2 2 "joint49FK.rotateX" 2 3 "joint49FK.translateZ" 1 1 "joint49FK.translateY" 
		1 2 "joint49FK.translateX" 1 3 "joint50FK.scaleZ" 0 4 "joint50FK.scaleY" 
		0 5 "joint50FK.scaleX" 0 6 "joint50FK.rotateZ" 2 4 "joint50FK.rotateY" 
		2 5 "joint50FK.rotateX" 2 6 "joint50FK.translateZ" 1 4 "joint50FK.translateY" 
		1 5 "joint50FK.translateX" 1 6 "joint51FK.scaleZ" 0 7 "joint51FK.scaleY" 
		0 8 "joint51FK.scaleX" 0 9 "joint51FK.rotateZ" 2 7 "joint51FK.rotateY" 
		2 8 "joint51FK.rotateX" 2 9 "joint51FK.translateZ" 1 7 "joint51FK.translateY" 
		1 8 "joint51FK.translateX" 1 9 "RightHandMiddle1Eff.reachRotation" 
		0 10 "RightHandMiddle1Eff.reachTranslation" 0 11 "RightHandMiddle1Eff.rotateZ" 
		2 10 "RightHandMiddle1Eff.rotateY" 2 11 "RightHandMiddle1Eff.rotateX" 
		2 12 "RightHandMiddle1Eff.translateZ" 1 10 "RightHandMiddle1Eff.translateY" 
		1 11 "RightHandMiddle1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"RightHandMiddle1Eff_rotateZ","angularValues[10]"
		,"RightHandMiddle1Eff_rotateY","angularValues[11]","RightHandMiddle1Eff_rotateX","angularValues[12]"
		,"joint49FK_rotateZ","angularValues[1]","joint49FK_rotateY","angularValues[2]","joint49FK_rotateX"
		,"angularValues[3]","joint50FK_rotateZ","angularValues[4]","joint50FK_rotateY","angularValues[5]"
		,"joint50FK_rotateX","angularValues[6]","joint51FK_rotateZ","angularValues[7]","joint51FK_rotateY"
		,"angularValues[8]","joint51FK_rotateX","angularValues[9]","RightHandMiddle1Eff_translateZ"
		,"linearValues[10]","RightHandMiddle1Eff_translateY","linearValues[11]","RightHandMiddle1Eff_translateX"
		,"linearValues[12]","joint49FK_translateZ","linearValues[1]","joint49FK_translateY"
		,"linearValues[2]","joint49FK_translateX","linearValues[3]","joint50FK_translateZ"
		,"linearValues[4]","joint50FK_translateY","linearValues[5]","joint50FK_translateX"
		,"linearValues[6]","joint51FK_translateZ","linearValues[7]","joint51FK_translateY"
		,"linearValues[8]","joint51FK_translateX","linearValues[9]","RightHandMiddle1Eff_reachRotation"
		,"unitlessValues[10]","RightHandMiddle1Eff_reachTranslation","unitlessValues[11]"
		,"joint49FK_scaleZ","unitlessValues[1]","joint49FK_scaleY","unitlessValues[2]","joint49FK_scaleX"
		,"unitlessValues[3]","joint50FK_scaleZ","unitlessValues[4]","joint50FK_scaleY","unitlessValues[5]"
		,"joint50FK_scaleX","unitlessValues[6]","joint51FK_scaleZ","unitlessValues[7]","joint51FK_scaleY"
		,"unitlessValues[8]","joint51FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFingerIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.9164917909729553 -0.82263194705255382 
		0.58358366563391861 0.94191057334339057 -0.14304729078650025 -0.049404873326009735 
		0.72771626934429534 -0.36830505202441888 -0.036814266527120942 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint52FK.scaleZ" 0 1 "joint52FK.scaleY" 
		0 2 "joint52FK.scaleX" 0 3 "joint52FK.rotateZ" 2 1 "joint52FK.rotateY" 
		2 2 "joint52FK.rotateX" 2 3 "joint52FK.translateZ" 1 1 "joint52FK.translateY" 
		1 2 "joint52FK.translateX" 1 3 "joint53FK.scaleZ" 0 4 "joint53FK.scaleY" 
		0 5 "joint53FK.scaleX" 0 6 "joint53FK.rotateZ" 2 4 "joint53FK.rotateY" 
		2 5 "joint53FK.rotateX" 2 6 "joint53FK.translateZ" 1 4 "joint53FK.translateY" 
		1 5 "joint53FK.translateX" 1 6 "joint54FK.scaleZ" 0 7 "joint54FK.scaleY" 
		0 8 "joint54FK.scaleX" 0 9 "joint54FK.rotateZ" 2 7 "joint54FK.rotateY" 
		2 8 "joint54FK.rotateX" 2 9 "joint54FK.translateZ" 1 7 "joint54FK.translateY" 
		1 8 "joint54FK.translateX" 1 9 "RightHandIndex1Eff.reachRotation" 
		0 10 "RightHandIndex1Eff.reachTranslation" 0 11 "RightHandIndex1Eff.rotateZ" 
		2 10 "RightHandIndex1Eff.rotateY" 2 11 "RightHandIndex1Eff.rotateX" 
		2 12 "RightHandIndex1Eff.translateZ" 1 10 "RightHandIndex1Eff.translateY" 
		1 11 "RightHandIndex1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"RightHandIndex1Eff_rotateZ","angularValues[10]"
		,"RightHandIndex1Eff_rotateY","angularValues[11]","RightHandIndex1Eff_rotateX","angularValues[12]"
		,"joint52FK_rotateZ","angularValues[1]","joint52FK_rotateY","angularValues[2]","joint52FK_rotateX"
		,"angularValues[3]","joint53FK_rotateZ","angularValues[4]","joint53FK_rotateY","angularValues[5]"
		,"joint53FK_rotateX","angularValues[6]","joint54FK_rotateZ","angularValues[7]","joint54FK_rotateY"
		,"angularValues[8]","joint54FK_rotateX","angularValues[9]","RightHandIndex1Eff_translateZ"
		,"linearValues[10]","RightHandIndex1Eff_translateY","linearValues[11]","RightHandIndex1Eff_translateX"
		,"linearValues[12]","joint52FK_translateZ","linearValues[1]","joint52FK_translateY"
		,"linearValues[2]","joint52FK_translateX","linearValues[3]","joint53FK_translateZ"
		,"linearValues[4]","joint53FK_translateY","linearValues[5]","joint53FK_translateX"
		,"linearValues[6]","joint54FK_translateZ","linearValues[7]","joint54FK_translateY"
		,"linearValues[8]","joint54FK_translateX","linearValues[9]","RightHandIndex1Eff_reachRotation"
		,"unitlessValues[10]","RightHandIndex1Eff_reachTranslation","unitlessValues[11]","joint52FK_scaleZ"
		,"unitlessValues[1]","joint52FK_scaleY","unitlessValues[2]","joint52FK_scaleX","unitlessValues[3]"
		,"joint53FK_scaleZ","unitlessValues[4]","joint53FK_scaleY","unitlessValues[5]","joint53FK_scaleX"
		,"unitlessValues[6]","joint54FK_scaleZ","unitlessValues[7]","joint54FK_scaleY","unitlessValues[8]"
		,"joint54FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFingerMiddle";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.784051974369496 -0.83380273550697326 1.4465288375066274 
		0.9418587179517619 -0.13670786114585964 0.06552479840891845 0.72945026733509977 -0.36339435464637437 
		0.049197072662024333 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint12FK.scaleZ" 0 1 "joint12FK.scaleY" 
		0 2 "joint12FK.scaleX" 0 3 "joint12FK.rotateZ" 2 1 "joint12FK.rotateY" 
		2 2 "joint12FK.rotateX" 2 3 "joint12FK.translateZ" 1 1 "joint12FK.translateY" 
		1 2 "joint12FK.translateX" 1 3 "joint12FK|joint40FK.scaleZ" 0 
		4 "joint12FK|joint40FK.scaleY" 0 5 "joint12FK|joint40FK.scaleX" 0 
		6 "joint12FK|joint40FK.rotateZ" 2 4 "joint12FK|joint40FK.rotateY" 
		2 5 "joint12FK|joint40FK.rotateX" 2 6 "joint12FK|joint40FK.translateZ" 
		1 4 "joint12FK|joint40FK.translateY" 1 5 "joint12FK|joint40FK.translateX" 
		1 6 "joint12FK|joint40FK|joint41FK.scaleZ" 0 7 "joint12FK|joint40FK|joint41FK.scaleY" 
		0 8 "joint12FK|joint40FK|joint41FK.scaleX" 0 9 "joint12FK|joint40FK|joint41FK.rotateZ" 
		2 7 "joint12FK|joint40FK|joint41FK.rotateY" 2 8 "joint12FK|joint40FK|joint41FK.rotateX" 
		2 9 "joint12FK|joint40FK|joint41FK.translateZ" 1 7 "joint12FK|joint40FK|joint41FK.translateY" 
		1 8 "joint12FK|joint40FK|joint41FK.translateX" 1 9 "LeftHandMiddle1Eff.reachRotation" 
		0 10 "LeftHandMiddle1Eff.reachTranslation" 0 11 "LeftHandMiddle1Eff.rotateZ" 
		2 10 "LeftHandMiddle1Eff.rotateY" 2 11 "LeftHandMiddle1Eff.rotateX" 
		2 12 "LeftHandMiddle1Eff.translateZ" 1 10 "LeftHandMiddle1Eff.translateY" 
		1 11 "LeftHandMiddle1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"LeftHandMiddle1Eff_rotateZ","angularValues[10]"
		,"LeftHandMiddle1Eff_rotateY","angularValues[11]","LeftHandMiddle1Eff_rotateX","angularValues[12]"
		,"joint12FK_rotateZ","angularValues[1]","joint12FK_rotateY","angularValues[2]","joint12FK_rotateX"
		,"angularValues[3]","joint40FK_rotateZ","angularValues[4]","joint40FK_rotateY","angularValues[5]"
		,"joint40FK_rotateX","angularValues[6]","joint41FK_rotateZ","angularValues[7]","joint41FK_rotateY"
		,"angularValues[8]","joint41FK_rotateX","angularValues[9]","LeftHandMiddle1Eff_translateZ"
		,"linearValues[10]","LeftHandMiddle1Eff_translateY","linearValues[11]","LeftHandMiddle1Eff_translateX"
		,"linearValues[12]","joint12FK_translateZ","linearValues[1]","joint12FK_translateY"
		,"linearValues[2]","joint12FK_translateX","linearValues[3]","joint40FK_translateZ"
		,"linearValues[4]","joint40FK_translateY","linearValues[5]","joint40FK_translateX"
		,"linearValues[6]","joint41FK_translateZ","linearValues[7]","joint41FK_translateY"
		,"linearValues[8]","joint41FK_translateX","linearValues[9]","LeftHandMiddle1Eff_reachRotation"
		,"unitlessValues[10]","LeftHandMiddle1Eff_reachTranslation","unitlessValues[11]","joint12FK_scaleZ"
		,"unitlessValues[1]","joint12FK_scaleY","unitlessValues[2]","joint12FK_scaleX","unitlessValues[3]"
		,"joint40FK_scaleZ","unitlessValues[4]","joint40FK_scaleY","unitlessValues[5]","joint40FK_scaleX"
		,"unitlessValues[6]","joint41FK_scaleZ","unitlessValues[7]","joint41FK_scaleY","unitlessValues[8]"
		,"joint41FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFingerIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.9262066652768235 -0.82240323612225952 
		-0.55098075892644616 0.94092540123074109 -0.14313990713529823 0.065456494378421937 
		0.72695187647692627 -0.36836842186231705 0.049039264827806406 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint42FK.scaleZ" 0 1 "joint42FK.scaleY" 
		0 2 "joint42FK.scaleX" 0 3 "joint42FK.rotateZ" 2 1 "joint42FK.rotateY" 
		2 2 "joint42FK.rotateX" 2 3 "joint42FK.translateZ" 1 1 "joint42FK.translateY" 
		1 2 "joint42FK.translateX" 1 3 "joint42FK|joint40FK.scaleZ" 0 
		4 "joint42FK|joint40FK.scaleY" 0 5 "joint42FK|joint40FK.scaleX" 0 
		6 "joint42FK|joint40FK.rotateZ" 2 4 "joint42FK|joint40FK.rotateY" 
		2 5 "joint42FK|joint40FK.rotateX" 2 6 "joint42FK|joint40FK.translateZ" 
		1 4 "joint42FK|joint40FK.translateY" 1 5 "joint42FK|joint40FK.translateX" 
		1 6 "joint42FK|joint40FK|joint41FK.scaleZ" 0 7 "joint42FK|joint40FK|joint41FK.scaleY" 
		0 8 "joint42FK|joint40FK|joint41FK.scaleX" 0 9 "joint42FK|joint40FK|joint41FK.rotateZ" 
		2 7 "joint42FK|joint40FK|joint41FK.rotateY" 2 8 "joint42FK|joint40FK|joint41FK.rotateX" 
		2 9 "joint42FK|joint40FK|joint41FK.translateZ" 1 7 "joint42FK|joint40FK|joint41FK.translateY" 
		1 8 "joint42FK|joint40FK|joint41FK.translateX" 1 9 "LeftHandIndex1Eff.reachRotation" 
		0 10 "LeftHandIndex1Eff.reachTranslation" 0 11 "LeftHandIndex1Eff.rotateZ" 
		2 10 "LeftHandIndex1Eff.rotateY" 2 11 "LeftHandIndex1Eff.rotateX" 
		2 12 "LeftHandIndex1Eff.translateZ" 1 10 "LeftHandIndex1Eff.translateY" 
		1 11 "LeftHandIndex1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"LeftHandIndex1Eff_rotateZ","angularValues[10]"
		,"LeftHandIndex1Eff_rotateY","angularValues[11]","LeftHandIndex1Eff_rotateX","angularValues[12]"
		,"joint42FK_rotateZ","angularValues[1]","joint42FK_rotateY","angularValues[2]","joint42FK_rotateX"
		,"angularValues[3]","joint40FK_rotateZ","angularValues[4]","joint40FK_rotateY","angularValues[5]"
		,"joint40FK_rotateX","angularValues[6]","joint41FK_rotateZ","angularValues[7]","joint41FK_rotateY"
		,"angularValues[8]","joint41FK_rotateX","angularValues[9]","LeftHandIndex1Eff_translateZ"
		,"linearValues[10]","LeftHandIndex1Eff_translateY","linearValues[11]","LeftHandIndex1Eff_translateX"
		,"linearValues[12]","joint42FK_translateZ","linearValues[1]","joint42FK_translateY"
		,"linearValues[2]","joint42FK_translateX","linearValues[3]","joint40FK_translateZ"
		,"linearValues[4]","joint40FK_translateY","linearValues[5]","joint40FK_translateX"
		,"linearValues[6]","joint41FK_translateZ","linearValues[7]","joint41FK_translateY"
		,"linearValues[8]","joint41FK_translateX","linearValues[9]","LeftHandIndex1Eff_reachRotation"
		,"unitlessValues[10]","LeftHandIndex1Eff_reachTranslation","unitlessValues[11]","joint42FK_scaleZ"
		,"unitlessValues[1]","joint42FK_scaleY","unitlessValues[2]","joint42FK_scaleX","unitlessValues[3]"
		,"joint40FK_scaleZ","unitlessValues[4]","joint40FK_scaleY","unitlessValues[5]","joint40FK_scaleX"
		,"unitlessValues[6]","joint41FK_scaleZ","unitlessValues[7]","joint41FK_scaleY","unitlessValues[8]"
		,"joint41FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFootIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.2743540481956135 -0.43680704175680651 
		-0.79051612165479845 0.95366560934100697 -0.024358586692088569 0.0038721552252640734 
		0.76887904534490481 -0.27458931624091421 0.0017303983561935965 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint43FK.scaleZ" 0 1 "joint43FK.scaleY" 
		0 2 "joint43FK.scaleX" 0 3 "joint43FK.rotateZ" 2 1 "joint43FK.rotateY" 
		2 2 "joint43FK.rotateX" 2 3 "joint43FK.translateZ" 1 1 "joint43FK.translateY" 
		1 2 "joint43FK.translateX" 1 3 "joint43FK|joint40FK.scaleZ" 0 
		4 "joint43FK|joint40FK.scaleY" 0 5 "joint43FK|joint40FK.scaleX" 0 
		6 "joint43FK|joint40FK.rotateZ" 2 4 "joint43FK|joint40FK.rotateY" 
		2 5 "joint43FK|joint40FK.rotateX" 2 6 "joint43FK|joint40FK.translateZ" 
		1 4 "joint43FK|joint40FK.translateY" 1 5 "joint43FK|joint40FK.translateX" 
		1 6 "joint43FK|joint40FK|joint41FK.scaleZ" 0 7 "joint43FK|joint40FK|joint41FK.scaleY" 
		0 8 "joint43FK|joint40FK|joint41FK.scaleX" 0 9 "joint43FK|joint40FK|joint41FK.rotateZ" 
		2 7 "joint43FK|joint40FK|joint41FK.rotateY" 2 8 "joint43FK|joint40FK|joint41FK.rotateX" 
		2 9 "joint43FK|joint40FK|joint41FK.translateZ" 1 7 "joint43FK|joint40FK|joint41FK.translateY" 
		1 8 "joint43FK|joint40FK|joint41FK.translateX" 1 9 "LeftFootIndex1Eff.reachRotation" 
		0 10 "LeftFootIndex1Eff.reachTranslation" 0 11 "LeftFootIndex1Eff.rotateZ" 
		2 10 "LeftFootIndex1Eff.rotateY" 2 11 "LeftFootIndex1Eff.rotateX" 
		2 12 "LeftFootIndex1Eff.translateZ" 1 10 "LeftFootIndex1Eff.translateY" 
		1 11 "LeftFootIndex1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"LeftFootIndex1Eff_rotateZ","angularValues[10]"
		,"LeftFootIndex1Eff_rotateY","angularValues[11]","LeftFootIndex1Eff_rotateX","angularValues[12]"
		,"joint43FK_rotateZ","angularValues[1]","joint43FK_rotateY","angularValues[2]","joint43FK_rotateX"
		,"angularValues[3]","joint40FK_rotateZ","angularValues[4]","joint40FK_rotateY","angularValues[5]"
		,"joint40FK_rotateX","angularValues[6]","joint41FK_rotateZ","angularValues[7]","joint41FK_rotateY"
		,"angularValues[8]","joint41FK_rotateX","angularValues[9]","LeftFootIndex1Eff_translateZ"
		,"linearValues[10]","LeftFootIndex1Eff_translateY","linearValues[11]","LeftFootIndex1Eff_translateX"
		,"linearValues[12]","joint43FK_translateZ","linearValues[1]","joint43FK_translateY"
		,"linearValues[2]","joint43FK_translateX","linearValues[3]","joint40FK_translateZ"
		,"linearValues[4]","joint40FK_translateY","linearValues[5]","joint40FK_translateX"
		,"linearValues[6]","joint41FK_translateZ","linearValues[7]","joint41FK_translateY"
		,"linearValues[8]","joint41FK_translateX","linearValues[9]","LeftFootIndex1Eff_reachRotation"
		,"unitlessValues[10]","LeftFootIndex1Eff_reachTranslation","unitlessValues[11]","joint43FK_scaleZ"
		,"unitlessValues[1]","joint43FK_scaleY","unitlessValues[2]","joint43FK_scaleX","unitlessValues[3]"
		,"joint40FK_scaleZ","unitlessValues[4]","joint40FK_scaleY","unitlessValues[5]","joint40FK_scaleX"
		,"unitlessValues[6]","joint41FK_scaleZ","unitlessValues[7]","joint41FK_scaleY","unitlessValues[8]"
		,"joint41FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFootMiddle";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.2633702723686895 -0.44574968607165488 
		1.0555319857586332 0.95377726080535297 -0.019399227506891825 0.004447629711813228 
		0.77029084782865453 -0.27060582371481412 0.0022670732665526216 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint44FK.scaleZ" 0 1 "joint44FK.scaleY" 
		0 2 "joint44FK.scaleX" 0 3 "joint44FK.rotateZ" 2 1 "joint44FK.rotateY" 
		2 2 "joint44FK.rotateX" 2 3 "joint44FK.translateZ" 1 1 "joint44FK.translateY" 
		1 2 "joint44FK.translateX" 1 3 "joint44FK|joint40FK.scaleZ" 0 
		4 "joint44FK|joint40FK.scaleY" 0 5 "joint44FK|joint40FK.scaleX" 0 
		6 "joint44FK|joint40FK.rotateZ" 2 4 "joint44FK|joint40FK.rotateY" 
		2 5 "joint44FK|joint40FK.rotateX" 2 6 "joint44FK|joint40FK.translateZ" 
		1 4 "joint44FK|joint40FK.translateY" 1 5 "joint44FK|joint40FK.translateX" 
		1 6 "joint44FK|joint40FK|joint41FK.scaleZ" 0 7 "joint44FK|joint40FK|joint41FK.scaleY" 
		0 8 "joint44FK|joint40FK|joint41FK.scaleX" 0 9 "joint44FK|joint40FK|joint41FK.rotateZ" 
		2 7 "joint44FK|joint40FK|joint41FK.rotateY" 2 8 "joint44FK|joint40FK|joint41FK.rotateX" 
		2 9 "joint44FK|joint40FK|joint41FK.translateZ" 1 7 "joint44FK|joint40FK|joint41FK.translateY" 
		1 8 "joint44FK|joint40FK|joint41FK.translateX" 1 9 "LeftFootMiddle1Eff.reachRotation" 
		0 10 "LeftFootMiddle1Eff.reachTranslation" 0 11 "LeftFootMiddle1Eff.rotateZ" 
		2 10 "LeftFootMiddle1Eff.rotateY" 2 11 "LeftFootMiddle1Eff.rotateX" 
		2 12 "LeftFootMiddle1Eff.translateZ" 1 10 "LeftFootMiddle1Eff.translateY" 
		1 11 "LeftFootMiddle1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"LeftFootMiddle1Eff_rotateZ","angularValues[10]"
		,"LeftFootMiddle1Eff_rotateY","angularValues[11]","LeftFootMiddle1Eff_rotateX","angularValues[12]"
		,"joint44FK_rotateZ","angularValues[1]","joint44FK_rotateY","angularValues[2]","joint44FK_rotateX"
		,"angularValues[3]","joint40FK_rotateZ","angularValues[4]","joint40FK_rotateY","angularValues[5]"
		,"joint40FK_rotateX","angularValues[6]","joint41FK_rotateZ","angularValues[7]","joint41FK_rotateY"
		,"angularValues[8]","joint41FK_rotateX","angularValues[9]","LeftFootMiddle1Eff_translateZ"
		,"linearValues[10]","LeftFootMiddle1Eff_translateY","linearValues[11]","LeftFootMiddle1Eff_translateX"
		,"linearValues[12]","joint44FK_translateZ","linearValues[1]","joint44FK_translateY"
		,"linearValues[2]","joint44FK_translateX","linearValues[3]","joint40FK_translateZ"
		,"linearValues[4]","joint40FK_translateY","linearValues[5]","joint40FK_translateX"
		,"linearValues[6]","joint41FK_translateZ","linearValues[7]","joint41FK_translateY"
		,"linearValues[8]","joint41FK_translateX","linearValues[9]","LeftFootMiddle1Eff_reachRotation"
		,"unitlessValues[10]","LeftFootMiddle1Eff_reachTranslation","unitlessValues[11]","joint44FK_scaleZ"
		,"unitlessValues[1]","joint44FK_scaleY","unitlessValues[2]","joint44FK_scaleX","unitlessValues[3]"
		,"joint40FK_scaleZ","unitlessValues[4]","joint40FK_scaleY","unitlessValues[5]","joint40FK_scaleX"
		,"unitlessValues[6]","joint41FK_scaleZ","unitlessValues[7]","joint41FK_scaleY","unitlessValues[8]"
		,"joint41FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFootIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.2769203899641042 -0.43619087555744684 
		0.78671588861059316 0.95369051769191238 -0.024673455826633495 -0.0066272894986045827 
		0.76874026740464707 -0.27489173918613963 -0.0037148248682994378 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint59FK.scaleZ" 0 1 "joint59FK.scaleY" 
		0 2 "joint59FK.scaleX" 0 3 "joint59FK.rotateZ" 2 1 "joint59FK.rotateY" 
		2 2 "joint59FK.rotateX" 2 3 "joint59FK.translateZ" 1 1 "joint59FK.translateY" 
		1 2 "joint59FK.translateX" 1 3 "joint60FK.scaleZ" 0 4 "joint60FK.scaleY" 
		0 5 "joint60FK.scaleX" 0 6 "joint60FK.rotateZ" 2 4 "joint60FK.rotateY" 
		2 5 "joint60FK.rotateX" 2 6 "joint60FK.translateZ" 1 4 "joint60FK.translateY" 
		1 5 "joint60FK.translateX" 1 6 "joint61FK.scaleZ" 0 7 "joint61FK.scaleY" 
		0 8 "joint61FK.scaleX" 0 9 "joint61FK.rotateZ" 2 7 "joint61FK.rotateY" 
		2 8 "joint61FK.rotateX" 2 9 "joint61FK.translateZ" 1 7 "joint61FK.translateY" 
		1 8 "joint61FK.translateX" 1 9 "RightFootIndex1Eff.reachRotation" 
		0 10 "RightFootIndex1Eff.reachTranslation" 0 11 "RightFootIndex1Eff.rotateZ" 
		2 10 "RightFootIndex1Eff.rotateY" 2 11 "RightFootIndex1Eff.rotateX" 
		2 12 "RightFootIndex1Eff.translateZ" 1 10 "RightFootIndex1Eff.translateY" 
		1 11 "RightFootIndex1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"RightFootIndex1Eff_rotateZ","angularValues[10]"
		,"RightFootIndex1Eff_rotateY","angularValues[11]","RightFootIndex1Eff_rotateX","angularValues[12]"
		,"joint59FK_rotateZ","angularValues[1]","joint59FK_rotateY","angularValues[2]","joint59FK_rotateX"
		,"angularValues[3]","joint60FK_rotateZ","angularValues[4]","joint60FK_rotateY","angularValues[5]"
		,"joint60FK_rotateX","angularValues[6]","joint61FK_rotateZ","angularValues[7]","joint61FK_rotateY"
		,"angularValues[8]","joint61FK_rotateX","angularValues[9]","RightFootIndex1Eff_translateZ"
		,"linearValues[10]","RightFootIndex1Eff_translateY","linearValues[11]","RightFootIndex1Eff_translateX"
		,"linearValues[12]","joint59FK_translateZ","linearValues[1]","joint59FK_translateY"
		,"linearValues[2]","joint59FK_translateX","linearValues[3]","joint60FK_translateZ"
		,"linearValues[4]","joint60FK_translateY","linearValues[5]","joint60FK_translateX"
		,"linearValues[6]","joint61FK_translateZ","linearValues[7]","joint61FK_translateY"
		,"linearValues[8]","joint61FK_translateX","linearValues[9]","RightFootIndex1Eff_reachRotation"
		,"unitlessValues[10]","RightFootIndex1Eff_reachTranslation","unitlessValues[11]","joint59FK_scaleZ"
		,"unitlessValues[1]","joint59FK_scaleY","unitlessValues[2]","joint59FK_scaleX","unitlessValues[3]"
		,"joint60FK_scaleZ","unitlessValues[4]","joint60FK_scaleY","unitlessValues[5]","joint60FK_scaleX"
		,"unitlessValues[6]","joint61FK_scaleZ","unitlessValues[7]","joint61FK_scaleY","unitlessValues[8]"
		,"joint61FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFootMiddle";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 35 ".dnsm";
	setAttr -s 11 ".uv[1:11]"  1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 11 ".uv";
	setAttr -s 12 ".lv[1:12]"  1.2598965336183383 -0.44669731779080468 
		-1.0592751158774965 0.95382642952728958 -0.01886011759691697 -0.0073452431725220535 
		0.77040069060363692 -0.27019818129614703 -0.0043838456019011929 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 35 "joint62FK.scaleZ" 0 1 "joint62FK.scaleY" 
		0 2 "joint62FK.scaleX" 0 3 "joint62FK.rotateZ" 2 1 "joint62FK.rotateY" 
		2 2 "joint62FK.rotateX" 2 3 "joint62FK.translateZ" 1 1 "joint62FK.translateY" 
		1 2 "joint62FK.translateX" 1 3 "joint63FK.scaleZ" 0 4 "joint63FK.scaleY" 
		0 5 "joint63FK.scaleX" 0 6 "joint63FK.rotateZ" 2 4 "joint63FK.rotateY" 
		2 5 "joint63FK.rotateX" 2 6 "joint63FK.translateZ" 1 4 "joint63FK.translateY" 
		1 5 "joint63FK.translateX" 1 6 "joint64FK.scaleZ" 0 7 "joint64FK.scaleY" 
		0 8 "joint64FK.scaleX" 0 9 "joint64FK.rotateZ" 2 7 "joint64FK.rotateY" 
		2 8 "joint64FK.rotateX" 2 9 "joint64FK.translateZ" 1 7 "joint64FK.translateY" 
		1 8 "joint64FK.translateX" 1 9 "RightFootMiddle1Eff.reachRotation" 
		0 10 "RightFootMiddle1Eff.reachTranslation" 0 11 "RightFootMiddle1Eff.rotateZ" 
		2 10 "RightFootMiddle1Eff.rotateY" 2 11 "RightFootMiddle1Eff.rotateX" 
		2 12 "RightFootMiddle1Eff.translateZ" 1 10 "RightFootMiddle1Eff.translateY" 
		1 11 "RightFootMiddle1Eff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"RightFootMiddle1Eff_rotateZ","angularValues[10]"
		,"RightFootMiddle1Eff_rotateY","angularValues[11]","RightFootMiddle1Eff_rotateX","angularValues[12]"
		,"joint62FK_rotateZ","angularValues[1]","joint62FK_rotateY","angularValues[2]","joint62FK_rotateX"
		,"angularValues[3]","joint63FK_rotateZ","angularValues[4]","joint63FK_rotateY","angularValues[5]"
		,"joint63FK_rotateX","angularValues[6]","joint64FK_rotateZ","angularValues[7]","joint64FK_rotateY"
		,"angularValues[8]","joint64FK_rotateX","angularValues[9]","RightFootMiddle1Eff_translateZ"
		,"linearValues[10]","RightFootMiddle1Eff_translateY","linearValues[11]","RightFootMiddle1Eff_translateX"
		,"linearValues[12]","joint62FK_translateZ","linearValues[1]","joint62FK_translateY"
		,"linearValues[2]","joint62FK_translateX","linearValues[3]","joint63FK_translateZ"
		,"linearValues[4]","joint63FK_translateY","linearValues[5]","joint63FK_translateX"
		,"linearValues[6]","joint64FK_translateZ","linearValues[7]","joint64FK_translateY"
		,"linearValues[8]","joint64FK_translateX","linearValues[9]","RightFootMiddle1Eff_reachRotation"
		,"unitlessValues[10]","RightFootMiddle1Eff_reachTranslation","unitlessValues[11]"
		,"joint62FK_scaleZ","unitlessValues[1]","joint62FK_scaleY","unitlessValues[2]","joint62FK_scaleX"
		,"unitlessValues[3]","joint63FK_scaleZ","unitlessValues[4]","joint63FK_scaleY","unitlessValues[5]"
		,"joint63FK_scaleX","unitlessValues[6]","joint64FK_scaleZ","unitlessValues[7]","joint64FK_scaleY"
		,"unitlessValues[8]","joint64FK_scaleX","unitlessValues[9]"} ;
createNode dagPose -n "hikStancePose";
	addAttr -ci true -sn "hikPose" -ln "hikPose" -bt "HIKP" -min 0 -max 1 -at "bool";
	setAttr -s 70 ".wm";
	setAttr ".wm[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[1]" -type "matrix" 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -2.9616950625523631e-008 0.99999999999999956 0 0 5.7104873122579865e-008 1.6912722077482399e-015 0.99999999999999833 0
		 -0.00048065185546875 26.183620452880859 -10.282027244567871 1;
	setAttr ".wm[2]" -type "matrix" -1.2104283371119827e-006 0.058555572825567427 0.9982841503748342 0
		 2.4569004365086242e-007 0.99828415037555274 -0.05855557282531168 0 -0.99999999999923728 1.7439115184822854e-007 -1.2227379452687962e-006 0
		 -0.00047537293467104889 26.630352020263828 -7.4794578552249078 1;
	setAttr ".wm[3]" -type "matrix" -1.6824341907112954e-006 -0.087740045299188024 0.99614340556370995 0
		 8.5309136375005799e-007 0.99614340556463132 0.087740045300710029 0 -0.99999999999822087 9.9741818846169785e-007 -1.6010954493947005e-006 0
		 -0.00047899959391984936 26.805794963266411 -4.4884204382341588 1;
	setAttr ".wm[4]" -type "matrix" -2.1653249628222915e-006 -0.21286796550855355 0.97708097374555436 0
		 3.5762774893407113e-007 0.9770809737476176 0.21286796550979567 0 -0.99999999999759182 8.1035958868074106e-007 -2.0395703317503814e-006 0
		 -0.0004844077587905153 26.523755622079996 -1.2863292052703685 1;
	setAttr ".wm[5]" -type "matrix" -2.1937303374406593e-006 0.057430238599340377 0.99834952180567027 0
		 2.0489091456713579e-008 0.9983495218080749 -0.057430238599433671 0 -0.99999999999759359 -1.0553118203373755e-007 -2.1912863266917441e-006 0
		 -0.000500542100044178 22.666394103607672 8.7242223637679412 1;
	setAttr ".wm[6]" -type "matrix" -7.5250864289195153e-007 0.26829961035063121 0.96333551740041912 0
		 7.4505808690068716e-007 0.96333551740057488 -0.26829961035009264 0 -0.99999999999943934 5.1584314197510518e-007 -9.2481709717371661e-007 0
		 -0.0005051032534253132 22.669948283403588 10.489747404855056 1;
	setAttr ".wm[7]" -type "matrix" 1.1622905836426603e-006 0.68220174930207944 0.73116398519609249 0
		 1.2516974498018903e-006 0.73116398519502113 -0.68220174930306965 0 -0.99999999999854117 1.7081127650266975e-006 -4.0851746819394453e-009 0
		 -0.00051205749410623694 23.0032925356637 12.252812471899178 1;
	setAttr ".wm[8]" -type "matrix" 3.7252897181714271e-006 0.95409838501140476 0.29949335836500846 0
		 1.192087947219258e-007 0.29949335836666086 -0.95409838501815147 0 -0.999999999993054 3.5899951461202506e-006 1.0019626101396539e-006 0
		 -0.00051616630419762009 23.960609781527253 13.942277152504218 1;
	setAttr ".wm[9]" -type "matrix" 3.248453264039488e-006 0.97977558210036253 0.20009949702421342 0
		 -1.1920921157215169e-007 0.20009949702564728 -0.97977558210544768 0 -0.99999999999471667 3.1589014844506438e-006 7.6681213898450141e-007 0
		 -0.00051117560317688539 25.682637605228784 14.939563570591513 1;
	setAttr ".wm[10]" -type "matrix" 4.2915341341802434e-006 0.94563765812402234 0.32522210798052659 0
		 3.2782526410173429e-007 0.3252221079821736 -0.94563765813313716 0 -0.99999999999073763 4.164852311895319e-006 1.0856978626555456e-006 0
		 -0.00050315359247898558 27.299643013478519 15.603078638047361 1;
	setAttr ".wm[11]" -type "matrix" 5.2452082832095287e-006 0.90207265287670235 0.43158420835855016 0
		 1.1324878230976465e-006 0.43158420835885186 -0.9020726528910965 0 -0.99999999998560263 5.2203228116187216e-006 1.2421627697330686e-006 0
		 -0.00049562468196861847 28.881168690147597 15.971109763270643 1;
	setAttr ".wm[12]" -type "matrix" -1.1920927741539527e-007 0.90206311913668147 0.43160413470376641 0
		 7.7486036203628687e-007 0.43160413470372327 -0.90206311913637727 0 -0.99999999999969269 2.2689864346784483e-007 -7.504241720223124e-007 0
		 -0.00048735338791605154 30.646684393589148 16.302393535960803 1;
	setAttr ".wm[13]" -type "matrix" -3.9331919302485191e-007 -0.97322250050332837 0.22986510068710803 0
		 -6.7817360968647669e-007 0.22986510068733257 0.97322250050311865 0 -0.99999999999969269 2.2689864346784483e-007 -7.504241720223124e-007 0
		 -0.00048817820619219762 30.840737368618676 17.460203565422983 1;
	setAttr ".wm[14]" -type "matrix" -6.8776679614974594e-007 0.20553508145634553 0.97864974852613162 0
		 3.7629279370035782e-007 0.9786497485263469 -0.20553508145612628 0 -0.99999999999969269 2.2689864346784483e-007 -7.504241720223124e-007 0
		 -0.00048896728519772143 28.888253339298135 17.921360122898403 1;
	setAttr ".wm[15]" -type "matrix" 0.99999999999969291 -2.268986434450259e-007 7.5042417213096459e-007 0
		 2.267749941090093e-007 0.99999998642565335 0.00016476844912069466 0 -7.5046154776345357e-007 -0.00016476844895038645 0.99999998642539778 0
		 -0.00049288413119931765 30.058779840968423 23.494790499775988 1;
	setAttr ".wm[16]" -type "matrix" -7.6741855946065679e-007 -0.47899677367235621 0.87781666127437152 0
		 -1.6027534767467107e-007 0.87781666127467772 0.47899677367238308 0 -0.99999999999969269 2.2689864346784483e-007 -7.504241720223124e-007 0
		 -0.00048775271102267481 32.012217258003112 17.247406619775422 1;
	setAttr ".wm[17]" -type "matrix" -6.871991069745617e-007 0.20700924531724879 0.97833898642173645 0
		 3.7732853039529272e-007 0.97833898642195172 -0.2070092453170293 0 -0.99999999999969269 2.2689864346784483e-007 -7.504241720223124e-007 0
		 -0.00049048344883825281 30.307782843278446 20.370978655185777 1;
	setAttr ".wm[18]" -type "matrix" -7.0259524426480416e-007 0.16529786179033082 0.98624369041685156 0
		 3.4782086655832851e-007 0.98624369041707605 -0.16529786179012068 0 -0.99999999999969269 2.2689864346784483e-007 -7.504241720223124e-007 0
		 -0.00049260295748374265 30.94625556628321 23.388441743489508 1;
	setAttr ".wm[19]" -type "matrix" 0.25929205465482558 0.88585115330368169 -0.38475364141670743 0
		 0.90161705654316382 -0.3648259298007277 -0.23235473805256521 0 -0.34619981765350566 -0.28665270822996214 -0.89329497430642002 0
		 -1.5574282812325506 26.427188358025795 4.488937891816942 1;
	setAttr ".wm[20]" -type "matrix" 0.99983497803458732 0.012707704327935082 -0.012981947053139986 0
		 0.012684009648110062 -0.99991773831377506 -0.0019059130914046429 0 -0.01300509891632512 0.0017409354322073245 -0.99991391456764789 0
		 -3.5394316973905302 18.951652800673781 7.3259691112432153 1;
	setAttr ".wm[21]" -type "matrix" -0.0040829175573533173 0.99558622959361154 0.093762408393753466 0
		 -0.021771545794167353 -0.09382946558872543 0.99535020529513463 0 0.99975463468690784 0.002022580260798601 0.022058549162088881 0
		 -3.3824520336826009 13.399062664769394 6.4703279928980741 1;
	setAttr ".wm[22]" -type "matrix" 0.1997844661266476 0.97383475316225288 -0.10831454485850389 0
		 -0.056661824801817862 0.12184038247495962 0.99093105653646951 0 0.97820018641616435 -0.19183533233419234 0.079521069935027361 0
		 -3.3626315175763866 8.5618509237477625 6.014759455302003 1;
	setAttr ".wm[23]" -type "matrix" 0.2307568435586633 0.72429643793793053 -0.6497275961056822 0
		 -0.037779356885411952 0.67391509844109654 0.73784223265305982 0 0.97227773776023863 -0.14571585391971975 0.18287397456248283 0
		 -4.7428723660048817 1.8339892977453367 6.7630470150351911 1;
	setAttr ".wm[24]" -type "matrix" 0.051819856257927149 0.14403634620329744 -0.98821466973012095 0
		 0.012813537982660467 -0.98955861302864301 -0.14356031702805572 0 -0.99857424147720475 -0.0052232512128727593 -0.053124400278897393 0
		 -6.1589708431799863 1.001356218801766 8.5718895238738497 1;
	setAttr ".wm[25]" -type "matrix" 0.045230034659720586 0.44576763598389924 -0.89400529007048213 0
		 0.02835014469408274 -0.89513347605390015 -0.44489586348210397 0 -0.99857424023479857 -0.0052225240055115835 -0.053124495127076593 0
		 -6.2084088325500497 0.86393749713897716 9.5146369934082013 1;
	setAttr ".wm[26]" -type "matrix" 0.99857422709337074 0.0052225198770805194 0.053124742550068056 0
		 0.014833649635407054 -0.98315437612901402 -0.18217419009525909 0 0.051278414789963339 0.18270248488869303 -0.98183009028656587 0
		 -6.2453366056660196 0.49999367853533572 10.244541874751585 1;
	setAttr ".wm[27]" -type "matrix" 0.051776346821789498 0.14993295363827097 -0.98733951573057888 0
		 0.013116537956170335 -0.98868242562019137 -0.14944904717601754 0 -0.99857256438469932 -0.0052125505349353563 -0.053156965442796078 0
		 -4.1592887003709746 1.0113573506669984 8.6795388059970868 1;
	setAttr ".wm[28]" -type "matrix" 0.045093057217880386 0.45111285057854611 -0.89132699512224112 0
		 0.028625263080738837 -0.89245169651440681 -0.45023389888158805 0 -0.99857258649749836 -0.0052120467626415902 -0.053156599442031327 0
		 -4.2086935736969844 0.86831005986783216 9.6214493793385465 1;
	setAttr ".wm[29]" -type "matrix" 0.99857261954640608 0.0052119009259965548 0.053155992897943496 0
		 0.015135000845054515 -0.98204612768649635 -0.18803280257810986 0 0.051221628650881826 0.18856892422850549 -0.98072325636422808 0
		 -4.2455078402241089 0.50000500783362667 10.349165648677893 1;
	setAttr ".wm[30]" -type "matrix" 0.4359502559574614 -0.79398167687718857 0.42372216264187956 0
		 0.56920698754573473 0.60794167435413726 0.55354342730502903 0 -0.69710169965345359 -0.00013178306344974181 0.71697224700366935 0
		 1.5565021859413313 26.427184026050757 4.4891050289165797 1;
	setAttr ".wm[31]" -type "matrix" -0.00010272812277550836 0.16107758778080034 0.98694174101699206 0
		 -0.00027765327482566493 0.986941703587907 -0.16107761057222975 0 -0.99999995617779502 -0.00029057480701065761 -5.6662948749952591e-005 0
		 3.5385000098295896 18.951592526534867 7.3259992068827628 1;
	setAttr ".wm[32]" -type "matrix" -0.0040259954739129767 -0.99556403946562322 -0.094000184485644817 0
		 -0.021550444117205386 0.094065493894517363 -0.99533273894549057 0 0.9997596559767733 -0.0019814593792671707 -0.021833554450274024 0
		 3.3818342502796073 13.398821356724339 6.4714256770554694 1;
	setAttr ".wm[33]" -type "matrix" 0.19983880796819137 -0.97382228465663656 0.10832639907234562 0
		 -0.056424921487343675 -0.12181046456777352 -0.99094825241126028 0 0.97820278013559137 0.19191760895736468 -0.079290303991651906 0
		 3.3622769493902078 8.5617223542601124 6.0147065234736772 1;
	setAttr ".wm[34]" -type "matrix" 0.24142483632800482 -0.72451984173987749 0.64558891512263328 0
		 -0.050989565070478637 -0.67381983827466518 -0.73713424137088357 0 0.96907900227892674 0.1450442155783081 -0.1996197957852722 0
		 4.742910385131835 1.8339109420776385 6.763063430786131 1;
	setAttr ".wm[35]" -type "matrix" 0.068685619062759024 -0.14330244888082611 0.98729260803407415 0
		 0.015953083215221125 0.98966099478731961 0.14253636214138843 0 -0.9975107943625946 0.0059601628611054558 0.070261593981173986 0
		 6.1894392226384491 1.0001082065466187 8.547115405144396 1;
	setAttr ".wm[36]" -type "matrix" 0.060273381722300817 -0.44510083355758551 0.89344970055515727 0
		 0.036598960642489346 0.89546062224259881 0.44363362146346319 0 -0.99751071950914283 0.0059600318153481225 0.070262667791030659 0
		 6.2549640210473649 0.86340034538807542 9.4889741230943176 1;
	setAttr ".wm[37]" -type "matrix" 0.99751073243628363 -0.0059605370449705682 -0.070262441407662218 0
		 0.018632851763535047 0.98328545511324328 0.18111468907269759 0 0.068008495863294438 -0.18197303580716889 0.98094885632714579 0
		 6.3041610937093866 0.50000599073187924 10.218424390424527 1;
	setAttr ".wm[38]" -type "matrix" 0.068617665448665571 -0.15004327593058991 0.98629540774374092 0
		 0.016415066624258054 0.9886615370671652 0.14926121636818862 0 -0.99750797569548111 0.0059481486201001244 0.070302616963360959 0
		 4.1919296262053765 1.0115077059294502 8.6892700960518781 1;
	setAttr ".wm[39]" -type "matrix" 0.060064752095628816 -0.45119166523413062 0.89040345168858293 0
		 0.037015675105549865 0.89240725707687663 0.4497100480454107 0 -0.99750792746332173 0.0059471623298039383 0.070303384755301471 0
		 4.2573861205837975 0.8683677987814824 9.6301954972806918 1;
	setAttr ".wm[40]" -type "matrix" 0.9975079950337592 -0.0059479567633281809 -0.070302358808735699 0
		 0.019091006873894201 0.98202277138463301 0.18779459507287544 0 0.067921523100351183 -0.18866875282458878 0.9796891182448354 0
		 4.3064253854115986 0.4999993769093754 10.35714737375266 1;
	setAttr ".wm[41]" -type "matrix" -0.0017023634671706231 0.16693056486863581 0.98596718427707519 0
		 -0.0015510688961977099 0.98596698615537492 -0.16693320938916167 0 -0.9999973480684361 -0.0018134840293254672 -0.0014195533700748658 0
		 2.1412785518727797 22.63135153437964 -11.309258583303418 1;
	setAttr ".wm[42]" -type "matrix" -0.0013803541332574601 -0.93426731787079298 -0.35657071301633958 0
		 -0.0019079446363262041 0.35657286423931617 -0.93426556836663677 0 0.99999722718102124 -0.00060930015948447392 -0.0022747271449865538 0
		 3.4820380718018584 16.13630446528402 -10.9395676189911 1;
	setAttr ".wm[43]" -type "matrix" 1.5735624606947989e-005 -0.99800862951989644 -0.063077532895694996 0
		 3.5256144306305623e-005 0.063077533417974688 -0.99800862898820086 0 0.99999999925469696 1.3480418538004127e-005 3.6178500648376046e-005 0
		 3.7517661074565445 8.722220488069798 -13.769794000386913 1;
	setAttr ".wm[44]" -type "matrix" 0.0015937088924628967 -0.62762649907579682 0.77851296569153217 0
		 -0.0075065791870439274 -0.77849952837206327 -0.62760029922983862 0 0.99997055524694034 -0.004843757047308923 -0.0059520296363442648 0
		 5.286444664001464 1.2357554435729963 -14.242904663085936 1;
	setAttr ".wm[45]" -type "matrix" 0.0040538961314691389 -0.025517125802526401 0.99966616538569164 0
		 0.0055400635538965801 0.99965961135033532 0.025494492164280246 0 -0.99997643653336798 0.0054348620657582681 0.004193882729897752 0
		 4.4959285423466655 0.7989484018268318 -12.968550614886672 1;
	setAttr ".wm[46]" -type "matrix" 0.002121577022175082 -0.33632241696447446 0.94174451458880981 0
		 0.0065281839792507646 0.94173122453564961 0.33630296393061698 0 -0.99997644058491242 0.0054343888119213774 0.0041935299413299295 0
		 4.4998006975719296 0.77458981514270564 -12.014885005545455 1;
	setAttr ".wm[47]" -type "matrix" 0.99997644502278216 -0.0054344892018344457 -0.0041923414356482922 0
		 0.005693134966376562 0.99790970212899655 0.064372467803176819 0 0.0038337467120990888 -0.064394819076782919 0.99791713566919771 0
		 4.5015310959281214 0.50000049890821696 -11.246005960198262 1;
	setAttr ".wm[48]" -type "matrix" 0.004660743356998993 -0.020333155781023651 0.99978239644801936 0
		 0.0052856476350414197 0.99977978989655725 0.02030846236112787 0 -0.99997516939193931 0.0051898449283010184 0.0047671909109890387 0
		 6.3419766497600998 0.79000575751188895 -12.979534390713519 1;
	setAttr ".wm[49]" -type "matrix" 0.0027779952169845411 -0.331435286045483 0.94347386498329833 0
		 0.0064772505077729057 0.94346367728319336 0.33141263535528193 0 -0.9999751636757952 0.0051904538551683132 0.0047677269577232348 0
		 6.3464242794719121 0.77060653001295965 -12.025757129908012 1;
	setAttr ".wm[50]" -type "matrix" 0.99997516319657265 -0.0051897928237641944 -0.0047685469939575346 0
		 0.0054636166425888182 0.99822360470503502 0.059327766710604864 0 0.0044521773515890511 -0.059352346711242822 0.99822716706003223 0
		 6.348691352738463 0.50000070630457949 -11.255466282077094 1;
	setAttr ".wm[51]" -type "matrix" 1.5554991707120267e-005 -0.99800862625273601 -0.063077584633277201 0
		 3.5302692918189842e-005 0.063077585149641915 -0.99800862571693705 0 0.99999999925588079 1.3297207296339064e-005 3.6213563376299497e-005 0
		 3.2605949189883763 9.629950554895828 -14.947150689168895 1;
	setAttr ".wm[52]" -type "matrix" 0.99962780891810044 0.00812135654371237 0.026043947578802386 0
		 0.0078649183238096703 -0.99991972880542968 0.0099337306907330905 0 0.026122532368767572 -0.0097251999242231497 -0.99961144140564773 0
		 -2.1422273647206431 22.631339963423461 -11.309228774790547 1;
	setAttr ".wm[53]" -type "matrix" -0.00143623335415069 0.93424671375832824 0.35662447345284232 0
		 -0.0019019243708303379 -0.35662674825586427 0.93424501342642252 0 0.99999715995468719 0.0006635210719374712 0.0022890658240925892 0
		 -3.4827884974559034 16.136205779303452 -10.939094973369803 1;
	setAttr ".wm[54]" -type "matrix" -2.7828231865224535e-005 0.99800838018908478 0.063081473492215323 0
		 5.331857173026958e-005 -0.06308147194616795 0.99800837925051267 0 0.99999999819135987 3.1136222650447309e-005 -5.1456935578707893e-005 0
		 -3.7520960879642873 8.7222816547238189 -13.76977210663317 1;
	setAttr ".wm[55]" -type "matrix" 0.0036057159563475131 0.62765338632671086 -0.77848456981821723 0
		 -0.010213642876580024 0.77847213865948783 0.62759605705430732 0 0.99994133843522659 0.0056882302639897813 0.0092175769501537264 0
		 -5.2864324855209137 1.2357614696452996 -14.24295726791556 1;
	setAttr ".wm[56]" -type "matrix" 0.0069466225056336057 0.025859853539098025 -0.99964144192340343 0
		 0.0065759298653278965 -0.99964512780284887 -0.025814252002203834 0 -0.99995424974454272 -0.006394250148638923 -0.0071142099256431088 0
		 -4.4997165969103206 0.79957059409851783 -12.966036877947809 1;
	setAttr ".wm[57]" -type "matrix" 0.0045458594657850132 0.3366808745289892 -0.94160783975501849 0
		 0.0084164267089407944 -0.94159709902990552 -0.33663640156691432 0 -0.99995424841498182 -0.0063946715992713957 -0.0071140179903562304 0
		 -4.5063438864089234 0.77489713827985063 -12.012346360255691 1;
	setAttr ".wm[58]" -type "matrix" 0.99995425993202458 0.0063949795638866044 0.0071121220585192843 0
		 0.0068421367803019667 -0.99787898890999982 -0.064735683021324458 0 0.0066830537987840151 0.064781384118704641 -0.99787710118209849 0
		 -4.510058711277221 0.50000539910013841 -11.243606092848749 1;
	setAttr ".wm[59]" -type "matrix" 0.0076996677825896609 0.019772906919011634 -0.99977484828735819 0
		 0.0062484363213411147 -0.99978591771230085 -0.019725004124489732 0 -0.99995083487118341 -0.0060951534964332329 -0.0078215691698675874 0
		 -6.3457076013984119 0.7890641518650181 -12.983060734293488 1;
	setAttr ".wm[60]" -type "matrix" 0.0053638773018163527 0.33093715910642985 -0.94363754987964354 0
		 0.0083401331843401226 -0.94363310933108513 -0.33088819433853556 0 -0.99995083429074616 -0.006095219168689138 -0.0078215921989782753 0
		 -6.3530528445709331 0.77020403427606987 -12.029234304766042 1;
	setAttr ".wm[61]" -type "matrix" 0.99995081528039564 0.0060946811250916551 0.0078244413255099537 0
		 0.0065451577996442946 -0.99824237574428232 -0.058900935287898984 0 0.007451706479099332 0.058949250465081628 -0.99823316812263596 0
		 -6.3574366901728325 0.5000058529863558 -11.258833614160151 1;
	setAttr ".wm[62]" -type "matrix" -2.7708575700547221e-005 0.9980083876981134 0.063081354744862636 0
		 5.3523229581848441e-005 -0.063081353198623819 0.99800838674526926 0 0.99999999818374952 3.1029708766236928e-005 -5.1668737608883153e-005 0
		 -3.2609680279651365 9.6300673962871262 -14.94717706930637 1;
	setAttr ".wm[63]" -type "matrix" -2.4521131928503412e-008 -0.64518609860756293 -0.76402545648921394 0
		 -5.9471374411899057e-008 0.76402545648921361 -0.64518609860756082 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.00048075684869337761 26.243269964883865 -12.089725980604085 1;
	setAttr ".wm[64]" -type "matrix" 3.2763018479741223e-010 -0.8900433190846232 -0.45587595917401452 0
		 -6.4327466481724274e-008 0.45587595917401336 -0.89004331908462142 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.00048080767030374782 24.906080624750686 -13.67321746966852 1;
	setAttr ".wm[65]" -type "matrix" 9.4955349273812054e-009 -0.94594594594594761 -0.32432432432431957 0
		 -6.3623620628963216e-008 0.32432432432431818 -0.94594594594594605 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.00048080713924167617 23.463391827263841 -14.412155817096741 1;
	setAttr ".wm[66]" -type "matrix" 2.2823073710759976e-008 -0.99330738030125332 -0.11550085817456493 0
		 -6.0143475056639069e-008 0.11550085817456326 -0.99330738030125199 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.00048079477635690795 22.231800247305614 -14.834415787368126 1;
	setAttr ".wm[67]" -type "matrix" 3.1070965740420649e-008 -0.99967143090948096 0.025632600792545368 0
		 -5.6326950684844947e-008 -0.025632600792547214 -0.99967143090947985 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.0004807600101275757 20.718702020499791 -15.010357441647873 1;
	setAttr ".wm[68]" -type "matrix" 3.6813441213760548e-008 -0.99145429554254294 0.13045451257138904 0
		 -5.2753206836137882e-008 -0.13045451257139098 -0.99145429554254205 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.00048071735603144871 19.346357117117758 -14.97516911079193 1;
	setAttr ".wm[69]" -type "matrix" 3.6813441213760548e-008 -0.99145429554254294 0.13045451257138904 0
		 -5.2753206836137882e-008 -0.13045451257139098 -0.99145429554254205 0 0.99999999999999789 2.9616950625523585e-008 -5.7104873122579892e-008 0
		 -0.00048066770640572542 18.009200544591678 -14.799227456512178 1;
	setAttr -s 70 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 0 5.7104873122579912e-008 2.9616950625523631e-008 0 -0.00048065185546875
		 26.183620452880859 -10.282027244567871 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 -2.7859998460739993e-007 -1.2657009896238894e-006
		 -0.00016673603449966789 0 5.1321112550795078e-006 0.4467315673828125 2.8025693893432617 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.02077033235773984 -0.70680166475026696 0.02077033235773984 0.70680166475026729 1
		 1 1 yes;
	setAttr ".xm[3]" -type "matrix" "xform" 1 1 1 -7.8665585057306529e-007 -4.4911076215721137e-007
		 3.7898847178334178e-007 0 2.9961784085900582 -3.5527136788005009e-015 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.073155829013207815 0.99732052254096837 1
		 1 1 yes;
	setAttr ".xm[4]" -type "matrix" "xform" 1 1 1 2.7610865495584327e-007 -3.886066814501769e-007
		 1.8232758120232513e-007 0 3.2144882103111967 -3.5527136788005009e-015 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.063285896504139585 0.99799543851846706 1
		 1 1 yes;
	setAttr ".xm[5]" -type "matrix" "xform" 1 1 1 9.0566602718253854e-007 -2.0406541649304504e-007
		 -3.9749891309989095e-007 0 10.602228173509161 -1.6380288024392204 -7.408732625297865e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1355670349323666 0.99076817623480751 1
		 1 1 yes;
	setAttr ".xm[6]" -type "matrix" "xform" 1 1 1 -2.5879875511729871e-007 1.3867492795047522e-006
		 1.9036551072953474e-006 0 1.7628151979089672 -0.097846210663328853 6.9200742222347983e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.10687734006210302 0.99427221332050186 1
		 1 1 yes;
	setAttr ".xm[7]" -type "matrix" "xform" 1 1 1 -2.4361968085569514e-007 1.4865744442334657e-006
		 5.3202910571594673e-006 0 1.7878593315707985 -0.15190731279147596 5.4956813097901102e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.2372834252112305 0.97144046452679045 1
		 1 1 yes;
	setAttr ".xm[8]" -type "matrix" "xform" 1 1 1 3.9625729238484211e-007 2.0968055703566505e-006
		 -1.3059803470973301e-006 0 1.8883592284796151 -0.45259986791813489 5.7371141407342807e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.25508263319488211 0.96691925735418327 1
		 1 1 yes;
	setAttr ".xm[9]" -type "matrix" "xform" 1 1 1 -1.4413306488759172e-007 -4.6942853431068694e-007
		 1.8292060121870722e-005 0 1.9416646241617004 -0.43577346477582662 2.1906142102995959e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.051319362306604215 0.99868229335081504 1
		 1 1 yes;
	setAttr ".xm[10]" -type "matrix" "xform" 1 1 1 -2.5607099684910703e-008 1.0549736719271692e-006
		 -8.1561215935086225e-006 0 1.7170714464192793 -0.32653389257472215 -2.4052585053174411e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.064843955985602955 0.99789541604926579 1
		 1 1 yes;
	setAttr ".xm[11]" -type "matrix" "xform" 1 1 1 -3.1438168626345061e-007 1.0196388568026464e-006
		 7.8394920026604287e-006 0 1.6152420955282278 0.16632302302046967 -5.4251903349999868e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.057473048633413494 0.99834705823214664 1
		 1 1 yes;
	setAttr ".xm[12]" -type "matrix" "xform" 1 1 1 2.1979076135103526e-005 -2.0076416484826609e-006
		 5.4539611964443679e-006 0 1.7356002791208969 0.46312666553392567 1.3567762171072919e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.3800244743381333 -0.60511776960689123 0.37206190807714878 0.59243887479468971 
		0.38002447433813419 0.60511776960689057 -0.37206190807714762 0.5924388747946906 1
		 1 1 yes;
	setAttr ".xm[13]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.6747636278503526 -0.9606636601703713
		 1.2912644978983694e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.94305286080297024 0.33264290422513704 1
		 1 1 yes;
	setAttr ".xm[14]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0062051877250671 -1.7763568394002505e-015
		 4.5519401352660017e-017 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.69823847750373125 0.71586523070566255 1
		 1 1 yes;
	setAttr ".xm[15]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6950204966294571 -3.5527136788005009e-015
		 6.2227345973616145e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.073116568667283333 0.70331640631107306 -0.073116568667283319 0.70331640631107317 1
		 1 1 yes;
	setAttr ".xm[16]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6396683892805015 -0.26309181965592593
		 1.0890979187257185e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.72567762236316991 0.6880348744077851 1
		 1 1 yes;
	setAttr ".xm[17]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.5583421609652515 1.0658141036401503e-014
		 3.4187196120580635e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.34666590398502029 0.93798867318014489 1
		 1 1 yes;
	setAttr ".xm[18]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.0842715359223973 -3.5527136788005009e-015
		 3.3691355984293955e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.021226892500907132 0.9997746841337577 1
		 1 1 yes;
	setAttr ".xm[19]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6634630471861103 1.1350147640320845
		 1.5569320161523725 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.35185873179284466 -0.4506603257573456 0.76102427634828762 0.30650082293197733 1
		 1 1 yes;
	setAttr ".xm[20]" -type "matrix" "xform" 1 1 1 0.0015754060177820147 -4.0430757314638881e-005
		 0.00021328062450717833 0 -8.2276876256385876 0.2810634784977557 0.29474600398294837 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.019366872308588384 0.22538402883032238 0.55800092667654044 0.7984121301892384 1
		 1 1 yes;
	setAttr ".xm[21]" -type "matrix" "xform" 1 1 1 -0.021810003544931442 0.0043218440216389892
		 0.054302242532188023 0 0.097500972608858053 5.5557552796549157 0.84385922314703754 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49691189527222213 0.5094623894031769 -0.48398130119985677 0.50920402807663179 1
		 1 1 yes;
	setAttr ".xm[22]" -type "matrix" "xform" 1 1 1 -0.069229713695449821 -0.0029986464787973639
		 -0.14127107762839608 0 -4.8586575277963071 -8.7680967571224233e-006 -1.7177128883716364e-005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.00056239164445333551 -0.10009049078503375 -0.032074443570282142 0.9944610638128103 1
		 1 1 yes;
	setAttr ".xm[23]" -type "matrix" "xform" 1 1 1 -0.61737509963179171 0.00071319625567028684
		 -4.5154723725825168e-005 0 -6.9086265733531222 -1.6886453267750401e-005 -5.6569402708817051e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5393474791308005 0.45634997808107003 0.44489981094681186 0.55037546500561663 
		-0.53934747913080905 -0.45634997808106376 -0.44489981094681924 0.55037546500560741 1
		 1 1 yes;
	setAttr ".xm[24]" -type "matrix" "xform" 1 1 1 -0.00013932958192253153 -0.0006591456413014285
		 -0.89713355823343743 0 -2.1051024829507892 0.82701568163179484 -0.92472296478456251 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69911923204802129 -0.70796460134009176 -0.0684086932885756 0.073066225525201339 1
		 1 1 yes;
	setAttr ".xm[25]" -type "matrix" "xform" 1 1 1 6.0871486804063856e-007 4.0901647429730493e-007
		 -2.0785324405773813e-006 0 -0.95399203931586918 9.2784544700741378e-006 2.3813065048727822e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.15808170862502213 0.9874260343935608 1
		 1 1 yes;
	setAttr ".xm[26]" -type "matrix" "xform" 1 1 1 -1.7243571390327827e-006 2.4435541631074536e-007
		 -4.1210553843750699e-008 0 -0.81644344527709223 -2.7472112768069301e-007 1.7763568394002505e-015 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076567485786123 0.70027208063023938 0.098076567485785804 0.70027208063024171 1
		 1 1 yes;
	setAttr ".xm[27]" -type "matrix" "xform" 1 1 1 -0.00012970703980563769 -0.00062612041475240687
		 -0.90309483293727411 0 -1.7063610686666557 0.83763707673201737 1.0377523938760973 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69911923204802129 -0.70796460134009176 -0.0684086932885756 0.073066225525201339 1
		 1 1 yes;
	setAttr ".xm[28]" -type "matrix" "xform" 1 1 1 6.150113742262279e-007 -9.9965340086754383e-008
		 -2.0971289496557589e-005 0 -0.95399103601995394 1.2683838618687826e-005 1.0884485114992515e-005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.15808170862502213 0.9874260343935608 1
		 1 1 yes;
	setAttr ".xm[29]" -type "matrix" "xform" 1 1 1 -1.1756146548633206e-005 -5.6904141867174178e-007
		 2.5777538319728504e-007 0 -0.81644036538437881 -1.8827659275938435e-006 -1.5817366030290714e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076567485786123 0.70027208063023938 0.098076567485785804 0.70027208063024171 1
		 1 1 yes;
	setAttr ".xm[30]" -type "matrix" "xform" 1 1 1 1.1361583991284204e-006 1.7028442943031507e-005
		 -2.8741018544039406e-006 0 5.6636205331335123 1.135047223104001 -1.5569984513584081 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24188157017566167 0.024666290023030939 0.098406274655394352 0.96498760886049895 
		-0.45066032575734799 0.35185873179284261 -0.30650082293197928 0.7610242763482864 1
		 1 1 yes;
	setAttr ".xm[31]" -type "matrix" "xform" 1 1 1 0.0013648811281759762 -4.1310670471213829e-005
		 0.00027194178122494665 0 8.0015900693396897 -1.8462124761725232 0.65330549789499548 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.052781366630427484 -0.70052892121396293 0.062633241664551587 0.70890791709362044 
		-0.16601699794380798 0.33086324844354431 0.40585668270714487 0.83561248215010708 1
		 1 1 yes;
	setAttr ".xm[32]" -type "matrix" "xform" 1 1 1 -0.021581385258503616 0.0043206208964656767
		 0.054735701923426028 0 -1.737825178907257 -5.3425652769625698 0.15832767075170961 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63252191002364921 0.77454246709914787 3.8730796625051605e-017 4.7427047656833279e-017 1
		 1 1 yes;
	setAttr ".xm[33]" -type "matrix" "xform" 1 1 1 -0.069261314709484698 -0.0030456566002668327
		 -0.14147124792085297 0 4.8586522444880993 4.8878998551576958e-006 3.7172860669620889e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.00056239164459974574 -0.10009049078502906 -0.032074443570296804 0.99446106381281019 1
		 1 1 yes;
	setAttr ".xm[34]" -type "matrix" "xform" 1 1 1 -0.61740098556011924 -0.00046750115859214505
		 -1.532127095496073e-005 0 6.9086636291802401 3.2730946618819701e-005 1.653877342278065e-005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.55364328432166832 0.43500195657436164 -0.45177136872171131 0.5478640724717263 
		0.55364328432167087 -0.43500195657435969 0.45177136872171331 0.54786407247172386 1
		 1 1 yes;
	setAttr ".xm[35]" -type "matrix" "xform" 1 1 1 -0.00016070809862167579 -0.00075730009869623416
		 -0.89626299260508979 0 2.1050987924763298 -0.82701085056268842 0.9247303681047514 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69911923204803206 -0.70796460134008166 -0.068408693288681127 0.073066225525099671 1
		 1 1 yes;
	setAttr ".xm[36]" -type "matrix" "xform" 1 1 1 -3.6177139861153733e-007 1.0222353413951579e-006
		 -3.4531491566197192e-007 0 0.95398133267236584 8.146063819544586e-016 1.7763568394002505e-015 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.15808170862502213 0.9874260343935608 1
		 1 1 yes;
	setAttr ".xm[37]" -type "matrix" "xform" 1 1 1 -1.2281914235432198e-007 -3.1488788580140285e-007
		 -4.5554267764388441e-007 0 0.81643952702382627 3.890559389457815e-006 1.2672539395630622e-005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076567485787483 0.70027208063024027 0.098076567485787469 0.70027208063024038 1
		 1 1 yes;
	setAttr ".xm[38]" -type "matrix" "xform" 1 1 1 -0.00014983524065570464 -0.00071592079286020294
		 -0.90307740880092613 0 1.7063646942876483 -0.83762700408640933 -1.0377376975720927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69911923204803206 -0.70796460134008166 -0.068408693288681127 0.073066225525099671 1
		 1 1 yes;
	setAttr ".xm[39]" -type "matrix" "xform" 1 1 1 5.3310352149949077e-007 1.1315476078542186e-006
		 8.5600043977698453e-007 0 0.9539990546789987 1.2219987894368387e-006 4.7254289610165756e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.15808170862502213 0.9874260343935608 1
		 1 1 yes;
	setAttr ".xm[40]" -type "matrix" "xform" 1 1 1 3.0226489381274089e-007 -1.1595827784261654e-006
		 -5.8619495407951523e-007 0 0.81643075299111167 -1.8681674338744125e-006 -6.2475455475663466e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076567485787483 0.70027208063024027 0.098076567485787469 0.70027208063024038 1
		 1 1 yes;
	setAttr ".xm[41]" -type "matrix" "xform" 1 1 1 -0.0096491441559367949 -0.0015139031126946703
		 0.0015481539509049078 0 2.1417591571807861 -3.5522689819335938 -1.0272312164306641 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.053160020118264095 -0.71481317794434329 0.058412508137675734 0.69484106944768342 
		-6.6419084124636499e-005 0.013785016960734144 -0.00481769462404214 0.99989337367261666 1
		 1 1 yes;
	setAttr ".xm[42]" -type "matrix" "xform" 1 1 1 -0.0025875596946542956 0.0035808081423582827
		 0.016227437692200031 0 -0.72200117698180577 -6.4676952931969831 -1.3295020962513417 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.50325076543905367 0.86414042092995891 3.0815221953169624e-017 5.2913340025286033e-017 1
		 1 1 yes;
	setAttr ".xm[43]" -type "matrix" "xform" 1 1 1 0.0022670228238841485 -0.0007673066497180742
		 -0.0076932187527889101 0 7.9355398704638462 7.2731960184093183e-006 0.28068268307363597 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.14636463691145296 0.9892307077025958 1
		 1 1 yes;
	setAttr ".xm[44]" -type "matrix" "xform" 1 1 1 -0.95544878283289503 3.6567854948987843e-005
		 -1.7066817658673017e-005 0 7.5014235215222289 -5.1183381408748119e-006 1.5345605182845325 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.48621677652415257 0.51423571405192481 -0.48118533155718174 0.51731571918333819 
		0.48621677652414763 -0.51423571405192758 0.48118533155717724 0.51731571918334429 1
		 1 1 yes;
	setAttr ".xm[45]" -type "matrix" "xform" 1 1 1 -0.00054604905285415839 -0.0017726680477858636
		 -1.021207977098042 0 1.2649929712147028 -0.45379683411979249 -0.79596205097811268 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66962345274978285 0.7427007684979593 -1.0768366411215989e-016 -1.1943539277538125e-016 1
		 1 1 yes;
	setAttr ".xm[46]" -type "matrix" "xform" 1 1 1 5.6434820555935641e-007 -1.7307941995972853e-007
		 1.162610548011442e-006 0 0.95398450118622158 -1.5622906965009897e-005 -4.8878134952801133e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.15808170862502213 0.9874260343935608 1
		 1 1 yes;
	setAttr ".xm[47]" -type "matrix" "xform" 1 1 1 -0.00027434418954619969 -1.192518232093716e-006
		 -2.3320599541420193e-008 0 0.81644183701999751 -1.7348086806465157e-006 1.7346008878149632e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076567485787483 0.70027208063024027 0.098076567485787469 0.70027208063024038 1
		 1 1 yes;
	setAttr ".xm[48]" -type "matrix" "xform" 1 1 1 -0.00032192526166952007 -0.0011916397464064588
		 -1.0160197359407359 0 1.2649966631498195 -0.45379907504399902 1.0501403917603263 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66962345274978285 0.7427007684979593 -1.0768366411215989e-016 -1.1943539277538125e-016 1
		 1 1 yes;
	setAttr ".xm[49]" -type "matrix" "xform" 1 1 1 -7.5219006716560187e-007 3.0394211310218626e-007
		 9.2171509351345921e-007 0 0.95398489226115935 -1.69738759848298e-006 -1.3599680901421607e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.15808170862502213 0.9874260343935608 1
		 1 1 yes;
	setAttr ".xm[50]" -type "matrix" "xform" 1 1 1 -0.00014146871234554936 8.5790480360116981e-007
		 6.110822538596736e-007 0 0.81644389986935018 -7.9612589895250441e-006 9.5243880871009878e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076567485787483 0.70027208063024027 0.098076567485787469 0.70027208063024038 1
		 1 1 yes;
	setAttr ".xm[51]" -type "matrix" "xform" 1 1 1 4.6549427563477553e-008 1.8063472743855704e-007
		 5.1834269490391977e-008 0 -0.83166541358587731 1.2322521916238138 -0.49120154652060521 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[52]" -type "matrix" "xform" 1 1 1 -0.0097133025667588413 -0.0015233679732479374
		 0.0015149165355136749 0 -2.1417467594146729 -3.5522804260253906 -1.0272016525268555 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99989337367261666 0.0048176946240421235 0.013785016960733983 6.6419084125731286e-005 1
		 1 1 yes;
	setAttr ".xm[53]" -type "matrix" "xform" 1 1 1 -0.0026010068519497593 0.0036104698090962291
		 0.016350091201520454 0 -1.3831717430240633 6.4877462176259657 -0.34184235585810741 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.40015590942770363 0.5710441148004437 -0.40566800110805434 0.59094613965983467 1
		 1 1 yes;
	setAttr ".xm[54]" -type "matrix" "xform" 1 1 1 0.0022959463121459303 -0.0007787693611576073
		 -0.0077468610629225099 0 -7.9355362030631449 -3.0141337321618576e-005 -0.28070572682982142 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.2765808731799243e-008 -1.8888040427396335e-009 -0.14636463691145291 0.98923070770259569 1
		 1 1 yes;
	setAttr ".xm[55]" -type "matrix" "xform" 1 1 1 -0.95545488468699469 -4.7342039041402708e-005
		 -2.8121407544681766e-005 0 -7.5014164025024117 -6.3851492650192663e-005 -1.5345451480825627 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.51943930772196811 0.4793478094602765 0.51418956184149656 0.48581640323501496 
		-0.51943930772198377 -0.47934780946026423 -0.51418956184150699 0.48581640323499953 1
		 1 1 yes;
	setAttr ".xm[56]" -type "matrix" "xform" 1 1 1 -0.00065136720323621944 -0.0021209750987924991
		 -1.0215163113713643 0 -1.2650028265652296 0.45379252303375078 0.79595869644012129 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66962345274978075 0.74270076849796096 -8.5951990494979328e-009 -9.5332099155739258e-009 1
		 1 1 yes;
	setAttr ".xm[57]" -type "matrix" "xform" 1 1 1 -3.5804504706550221e-007 -3.2261708900220508e-007
		 -3.8537540832469731e-005 0 -0.95403265348658228 2.3119484334129956e-006 -5.3290705182007514e-015 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.274251984804599e-008 -2.040010329487119e-009 -0.15808170862502208 0.98742603439356069 1
		 1 1 yes;
	setAttr ".xm[58]" -type "matrix" "xform" 1 1 1 -0.00026927158460564473 -1.9190743535746407e-006
		 -1.5916682114218041e-007 0 -0.81641954074535761 2.0041248201492501e-005 3.6652143347026822e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076580751325138 0.70027208130365015 0.098076562677605117 0.70027207877233599 1
		 1 1 yes;
	setAttr ".xm[59]" -type "matrix" "xform" 1 1 1 -0.00037921908966254136 -0.0014038266381071196
		 -1.0154235511906275 0 -1.2650005403475753 0.45378373823334939 -1.0501407010956223 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66962345274978075 0.74270076849796096 -8.5951990494979328e-009 -9.5332099155739258e-009 1
		 1 1 yes;
	setAttr ".xm[60]" -type "matrix" "xform" 1 1 1 -9.5404985119248036e-008 0 -3.3211677967708908e-005 0 -0.95404114915505289
		 -4.0465688757179707e-006 -5.8204023645203051e-007 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 1 1.274251984804599e-008 -2.040010329487119e-009 -0.15808170862502208 0.98742603439356069 1
		 1 1 yes;
	setAttr ".xm[61]" -type "matrix" "xform" 1 1 1 -1.8839659025715605e-005 2.868868050556887e-006
		 3.9391961159651601e-007 0 -0.81642115303058915 1.4894658093761448e-005 4.787169232578492e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098076580751325138 0.70027208130365015 0.098076562677605117 0.70027207877233599 1
		 1 1 yes;
	setAttr ".xm[62]" -type "matrix" "xform" 1 1 1 1.7134115352835784e-007 -1.1966251260291748e-007
		 -1.1897814969317876e-007 0 0.83169167032834124 -1.2322982930618527 0.49121690978115939 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.6660004686562634e-008 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[63]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.8189894035458565e-012
		 0.059649512003009164 -1.8076987360362171 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.24288605533808694 0.66408310031373607 -0.24288605533808696 0.66408310031373619 1
		 1 1 yes;
	setAttr ".xm[64]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0725637812393884 4.2379607305429549e-047
		 -4.6020160598722754e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.19679378236834771 0.98044490269528117 1
		 1 1 yes;
	setAttr ".xm[65]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6209197536256967 -1.7763568394002505e-015
		 -1.6679161729460663e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.071468413165579683 0.99744286348622191 1
		 1 1 yes;
	setAttr ".xm[66]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3019682416701235 2.6197923710891093e-032
		 -1.4492762943394549e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.10706346888527128 0.99425218814456351 1
		 1 1 yes;
	setAttr ".xm[67]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.5232930478649265 -4.4408920985006262e-016
		 -1.8223148671428404e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.070638435678044911 0.99750198566466963 1
		 1 1 yes;
	setAttr ".xm[68]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3727959617026371 -1.2212453270876722e-015
		 -1.6765296777713882e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.052571747409160513 0.99861714954948944 1
		 1 1 yes;
	setAttr ".xm[69]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3486820103939958 -1.7763568394002505e-015
		 -1.8242182155082681e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr -s 70 ".m";
	setAttr -s 70 ".p";
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 6 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
select -ne :lightList1;
select -ne :defaultTextureList1;
	setAttr -s 2 ".tx";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :characterPartition;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
select -ne :ikSystem;
	setAttr -s 4 ".sol";
connectAttr "imagePlane1.msg" ":sideShape.ip" -na;
connectAttr "hips.s" "spine.is";
connectAttr "spine.s" "spine1.is";
connectAttr "spine1.s" "spine2.is";
connectAttr "spine2.s" "neck.is";
connectAttr "neck.s" "neck1.is";
connectAttr "neck1.s" "neck2.is";
connectAttr "neck2.s" "neck3.is";
connectAttr "neck3.s" "neck4.is";
connectAttr "neck4.s" "neck5.is";
connectAttr "neck5.s" "neck6.is";
connectAttr "neck6.s" "head.is";
connectAttr "head.s" "manidlbe.is";
connectAttr "manidlbe.s" "ramus.is";
connectAttr "ramus.s" "lower_dent.is";
connectAttr "head.s" "forehead.is";
connectAttr "forehead.s" "maxilla.is";
connectAttr "maxilla.s" "upperdent.is";
connectAttr "spine2.s" "rightCollar.is";
connectAttr "rightCollar.s" "rightArm.is";
connectAttr "rightArm.s" "rightForeArm.is";
connectAttr "rightForeArm.s" "rightHand.is";
connectAttr "rightHand.s" "rightFingerBase.is";
connectAttr "rightFingerBase.s" "joint49.is";
connectAttr "joint49.s" "joint50.is";
connectAttr "joint50.s" "joint51.is";
connectAttr "rightFingerBase.s" "joint52.is";
connectAttr "joint52.s" "joint53.is";
connectAttr "joint53.s" "joint54.is";
connectAttr "spine2.s" "leftCollar.is";
connectAttr "leftCollar.s" "leftArm.is";
connectAttr "leftArm.s" "leftForeArm.is";
connectAttr "leftForeArm.s" "leftHand.is";
connectAttr "leftHand.s" "leftFingerBase.is";
connectAttr "leftFingerBase.s" "joint12.is";
connectAttr "joint12.s" "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40.is"
		;
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40.s" "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40|joint41.is"
		;
connectAttr "leftFingerBase.s" "joint42.is";
connectAttr "joint42.s" "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40.is"
		;
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40.s" "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40|joint41.is"
		;
connectAttr "hips.s" "leftUpLeg.is";
connectAttr "leftUpLeg.s" "leftLeg.is";
connectAttr "leftLeg.s" "leftFoot.is";
connectAttr "leftFoot.s" "leftToeBase.is";
connectAttr "leftToeBase.s" "joint43.is";
connectAttr "joint43.s" "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40.is"
		;
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40.s" "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40|joint41.is"
		;
connectAttr "leftToeBase.s" "joint44.is";
connectAttr "joint44.s" "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40.is"
		;
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40.s" "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40|joint41.is"
		;
connectAttr "leftFoot.s" "joint7.is";
connectAttr "hips.s" "rightUpLeg.is";
connectAttr "rightUpLeg.s" "rightLeg.is";
connectAttr "rightLeg.s" "rightFoot.is";
connectAttr "rightFoot.s" "rightToeBase.is";
connectAttr "rightToeBase.s" "joint59.is";
connectAttr "joint59.s" "joint60.is";
connectAttr "joint60.s" "joint61.is";
connectAttr "rightToeBase.s" "joint62.is";
connectAttr "joint62.s" "joint63.is";
connectAttr "joint63.s" "joint64.is";
connectAttr "rightFoot.s" "joint65.is";
connectAttr "hips.s" "taile1.is";
connectAttr "taile1.s" "tail2.is";
connectAttr "tail2.s" "tail3.is";
connectAttr "tail3.s" "tail4.is";
connectAttr "tail4.s" "tail5.is";
connectAttr "tail5.s" "tail6.is";
connectAttr "tail6.s" "tail7.is";
connectAttr ":time1.o" "hikHandle1.tim";
connectAttr "hips.msg" "hikHandle1.jt[0]";
connectAttr "spine.msg" "hikHandle1.jt[1]";
connectAttr "spine1.msg" "hikHandle1.jt[2]";
connectAttr "spine2.msg" "hikHandle1.jt[3]";
connectAttr "neck.msg" "hikHandle1.jt[4]";
connectAttr "neck1.msg" "hikHandle1.jt[5]";
connectAttr "neck2.msg" "hikHandle1.jt[6]";
connectAttr "neck3.msg" "hikHandle1.jt[7]";
connectAttr "neck4.msg" "hikHandle1.jt[8]";
connectAttr "neck5.msg" "hikHandle1.jt[9]";
connectAttr "neck6.msg" "hikHandle1.jt[10]";
connectAttr "head.msg" "hikHandle1.jt[11]";
connectAttr "rightCollar.msg" "hikHandle1.jt[12]";
connectAttr "rightArm.msg" "hikHandle1.jt[13]";
connectAttr "rightForeArm.msg" "hikHandle1.jt[14]";
connectAttr "rightHand.msg" "hikHandle1.jt[15]";
connectAttr "rightFingerBase.msg" "hikHandle1.jt[16]";
connectAttr "joint49.msg" "hikHandle1.jt[17]";
connectAttr "joint50.msg" "hikHandle1.jt[18]";
connectAttr "joint51.msg" "hikHandle1.jt[19]";
connectAttr "joint52.msg" "hikHandle1.jt[20]";
connectAttr "joint53.msg" "hikHandle1.jt[21]";
connectAttr "joint54.msg" "hikHandle1.jt[22]";
connectAttr "leftCollar.msg" "hikHandle1.jt[23]";
connectAttr "leftArm.msg" "hikHandle1.jt[24]";
connectAttr "leftForeArm.msg" "hikHandle1.jt[25]";
connectAttr "leftHand.msg" "hikHandle1.jt[26]";
connectAttr "leftFingerBase.msg" "hikHandle1.jt[27]";
connectAttr "joint12.msg" "hikHandle1.jt[28]";
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40.msg" "hikHandle1.jt[29]"
		;
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40|joint41.msg" "hikHandle1.jt[30]"
		;
connectAttr "joint42.msg" "hikHandle1.jt[31]";
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40.msg" "hikHandle1.jt[32]"
		;
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40|joint41.msg" "hikHandle1.jt[33]"
		;
connectAttr "leftUpLeg.msg" "hikHandle1.jt[34]";
connectAttr "leftLeg.msg" "hikHandle1.jt[35]";
connectAttr "leftFoot.msg" "hikHandle1.jt[36]";
connectAttr "leftToeBase.msg" "hikHandle1.jt[37]";
connectAttr "joint43.msg" "hikHandle1.jt[38]";
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40.msg" "hikHandle1.jt[39]"
		;
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40|joint41.msg" "hikHandle1.jt[40]"
		;
connectAttr "joint44.msg" "hikHandle1.jt[41]";
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40.msg" "hikHandle1.jt[42]"
		;
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40|joint41.msg" "hikHandle1.jt[43]"
		;
connectAttr "rightUpLeg.msg" "hikHandle1.jt[44]";
connectAttr "rightLeg.msg" "hikHandle1.jt[45]";
connectAttr "rightFoot.msg" "hikHandle1.jt[46]";
connectAttr "rightToeBase.msg" "hikHandle1.jt[47]";
connectAttr "joint59.msg" "hikHandle1.jt[48]";
connectAttr "joint60.msg" "hikHandle1.jt[49]";
connectAttr "joint61.msg" "hikHandle1.jt[50]";
connectAttr "joint62.msg" "hikHandle1.jt[51]";
connectAttr "joint63.msg" "hikHandle1.jt[52]";
connectAttr "joint64.msg" "hikHandle1.jt[53]";
connectAttr "hipsFK.msg" "hikHandle1.fj[0]";
connectAttr "spineFK.msg" "hikHandle1.fj[1]";
connectAttr "spine1FK.msg" "hikHandle1.fj[2]";
connectAttr "spine2FK.msg" "hikHandle1.fj[3]";
connectAttr "neckFK.msg" "hikHandle1.fj[4]";
connectAttr "neck1FK.msg" "hikHandle1.fj[5]";
connectAttr "neck2FK.msg" "hikHandle1.fj[6]";
connectAttr "neck3FK.msg" "hikHandle1.fj[7]";
connectAttr "neck4FK.msg" "hikHandle1.fj[8]";
connectAttr "neck5FK.msg" "hikHandle1.fj[9]";
connectAttr "neck6FK.msg" "hikHandle1.fj[10]";
connectAttr "headFK.msg" "hikHandle1.fj[11]";
connectAttr "rightCollarFK.msg" "hikHandle1.fj[12]";
connectAttr "rightArmFK.msg" "hikHandle1.fj[13]";
connectAttr "rightForeArmFK.msg" "hikHandle1.fj[14]";
connectAttr "rightHandFK.msg" "hikHandle1.fj[15]";
connectAttr "rightFingerBaseFK.msg" "hikHandle1.fj[16]";
connectAttr "joint49FK.msg" "hikHandle1.fj[17]";
connectAttr "joint50FK.msg" "hikHandle1.fj[18]";
connectAttr "joint51FK.msg" "hikHandle1.fj[19]";
connectAttr "joint52FK.msg" "hikHandle1.fj[20]";
connectAttr "joint53FK.msg" "hikHandle1.fj[21]";
connectAttr "joint54FK.msg" "hikHandle1.fj[22]";
connectAttr "leftCollarFK.msg" "hikHandle1.fj[23]";
connectAttr "leftArmFK.msg" "hikHandle1.fj[24]";
connectAttr "leftForeArmFK.msg" "hikHandle1.fj[25]";
connectAttr "leftHandFK.msg" "hikHandle1.fj[26]";
connectAttr "leftFingerBaseFK.msg" "hikHandle1.fj[27]";
connectAttr "joint12FK.msg" "hikHandle1.fj[28]";
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.msg" "hikHandle1.fj[29]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.msg" "hikHandle1.fj[30]"
		;
connectAttr "joint42FK.msg" "hikHandle1.fj[31]";
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.msg" "hikHandle1.fj[32]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.msg" "hikHandle1.fj[33]"
		;
connectAttr "leftUpLegFK.msg" "hikHandle1.fj[34]";
connectAttr "leftLegFK.msg" "hikHandle1.fj[35]";
connectAttr "leftFootFK.msg" "hikHandle1.fj[36]";
connectAttr "leftToeBaseFK.msg" "hikHandle1.fj[37]";
connectAttr "joint43FK.msg" "hikHandle1.fj[38]";
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.msg" "hikHandle1.fj[39]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.msg" "hikHandle1.fj[40]"
		;
connectAttr "joint44FK.msg" "hikHandle1.fj[41]";
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.msg" "hikHandle1.fj[42]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.msg" "hikHandle1.fj[43]"
		;
connectAttr "rightUpLegFK.msg" "hikHandle1.fj[44]";
connectAttr "rightLegFK.msg" "hikHandle1.fj[45]";
connectAttr "rightFootFK.msg" "hikHandle1.fj[46]";
connectAttr "rightToeBaseFK.msg" "hikHandle1.fj[47]";
connectAttr "joint59FK.msg" "hikHandle1.fj[48]";
connectAttr "joint60FK.msg" "hikHandle1.fj[49]";
connectAttr "joint61FK.msg" "hikHandle1.fj[50]";
connectAttr "joint62FK.msg" "hikHandle1.fj[51]";
connectAttr "joint63FK.msg" "hikHandle1.fj[52]";
connectAttr "joint64FK.msg" "hikHandle1.fj[53]";
connectAttr "HipsEff.ha" "hikHandle1.eff[0]";
connectAttr "LeftFootEff.ha" "hikHandle1.eff[1]";
connectAttr "RightFootEff.ha" "hikHandle1.eff[2]";
connectAttr "LeftHandEff.ha" "hikHandle1.eff[3]";
connectAttr "RightHandEff.ha" "hikHandle1.eff[4]";
connectAttr "LeftLegEff.ha" "hikHandle1.eff[5]";
connectAttr "RightLegEff.ha" "hikHandle1.eff[6]";
connectAttr "LeftForeArmEff.ha" "hikHandle1.eff[7]";
connectAttr "RightForeArmEff.ha" "hikHandle1.eff[8]";
connectAttr "SpineEff.ha" "hikHandle1.eff[9]";
connectAttr "LeftToeBaseEff.ha" "hikHandle1.eff[10]";
connectAttr "RightToeBaseEff.ha" "hikHandle1.eff[11]";
connectAttr "LeftArmEff.ha" "hikHandle1.eff[12]";
connectAttr "RightArmEff.ha" "hikHandle1.eff[13]";
connectAttr "HeadEff.ha" "hikHandle1.eff[14]";
connectAttr "LeftUpLegEff.ha" "hikHandle1.eff[15]";
connectAttr "RightUpLegEff.ha" "hikHandle1.eff[16]";
connectAttr "LeftFingerBaseEff.ha" "hikHandle1.eff[17]";
connectAttr "RightFingerBaseEff.ha" "hikHandle1.eff[18]";
connectAttr "LeftHandIndex1Eff.ha" "hikHandle1.eff[19]";
connectAttr "LeftHandMiddle1Eff.ha" "hikHandle1.eff[20]";
connectAttr "RightHandIndex1Eff.ha" "hikHandle1.eff[21]";
connectAttr "RightHandMiddle1Eff.ha" "hikHandle1.eff[22]";
connectAttr "LeftFootIndex1Eff.ha" "hikHandle1.eff[23]";
connectAttr "LeftFootMiddle1Eff.ha" "hikHandle1.eff[24]";
connectAttr "RightFootIndex1Eff.ha" "hikHandle1.eff[25]";
connectAttr "RightFootMiddle1Eff.ha" "hikHandle1.eff[26]";
connectAttr "NeckEff.ha" "hikHandle1.eff[27]";
connectAttr "hikFloorContactMarker1.fec" "hikHandle1.fec";
connectAttr "hikFloorContactMarker1.hfc" "hikHandle1.hfc";
connectAttr "hikFloorContactMarker1.fic" "hikHandle1.fic";
connectAttr "hikFloorContactMarker1.tfc" "hikHandle1.tfc";
connectAttr "hikFloorContactMarker1.hfp" "hikHandle1.hfp";
connectAttr "hikFloorContactMarker1.hct" "hikHandle1.hct";
connectAttr "hikFloorContactMarker1.hcs" "hikHandle1.hcs";
connectAttr "hikFloorContactMarker1.hh" "hikHandle1.hh";
connectAttr "hikFloorContactMarker1.hb" "hikHandle1.hb";
connectAttr "hikFloorContactMarker1.hm" "hikHandle1.hm";
connectAttr "hikFloorContactMarker1.hf" "hikHandle1.hf";
connectAttr "hikFloorContactMarker1.his" "hikHandle1.his";
connectAttr "hikFloorContactMarker1.hos" "hikHandle1.hos";
connectAttr "hikFloorContactMarker1.fpv" "hikHandle1.fpv";
connectAttr "hikFloorContactMarker1.fct" "hikHandle1.fct";
connectAttr "hikFloorContactMarker1.fcs" "hikHandle1.fcs";
connectAttr "hikFloorContactMarker1.fh" "hikHandle1.fh";
connectAttr "hikFloorContactMarker1.fra" "hikHandle1.fra";
connectAttr "hikFloorContactMarker1.fma" "hikHandle1.fma";
connectAttr "hikFloorContactMarker1.ffm" "hikHandle1.ffm";
connectAttr "hikFloorContactMarker1.fia" "hikHandle1.fia";
connectAttr "hikFloorContactMarker1.foa" "hikHandle1.foa";
connectAttr "hikFloorContactMarker1.fcm" "hikHandle1.fcm";
connectAttr "hikFloorContactMarker1.hcr" "hikHandle1.hcr";
connectAttr "hikFloorContactMarker1.tct" "hikHandle1.tct";
connectAttr "hikFloorContactMarker1.fcr" "hikHandle1.fcr";
connectAttr "hips.msg" "HipsEff.jt";
connectAttr "hipsFK.msg" "HipsEff.fj";
connectAttr "_hips.uv[4]" "HipsEff.rr";
connectAttr "_hips.uv[5]" "HipsEff.rt";
connectAttr "_hips.av[4]" "HipsEff.rz";
connectAttr "_hips.av[5]" "HipsEff.ry";
connectAttr "_hips.av[6]" "HipsEff.rx";
connectAttr "_hips.lv[4]" "HipsEff.tz";
connectAttr "_hips.lv[5]" "HipsEff.ty";
connectAttr "_hips.lv[6]" "HipsEff.tx";
connectAttr "leftFoot.msg" "LeftFootEff.jt";
connectAttr "leftFootFK.msg" "LeftFootEff.fj";
connectAttr "_leftLeg.uv[13]" "LeftFootEff.rr";
connectAttr "_leftLeg.uv[14]" "LeftFootEff.rt";
connectAttr "_leftLeg.av[13]" "LeftFootEff.rz";
connectAttr "_leftLeg.av[14]" "LeftFootEff.ry";
connectAttr "_leftLeg.av[15]" "LeftFootEff.rx";
connectAttr "_leftLeg.lv[13]" "LeftFootEff.tz";
connectAttr "_leftLeg.lv[14]" "LeftFootEff.ty";
connectAttr "_leftLeg.lv[15]" "LeftFootEff.tx";
connectAttr "joint43.msg" "LeftFootIndex1Eff.jt";
connectAttr "joint43FK.msg" "LeftFootIndex1Eff.fj";
connectAttr "_leftFootIndex.uv[10]" "LeftFootIndex1Eff.rr";
connectAttr "_leftFootIndex.uv[11]" "LeftFootIndex1Eff.rt";
connectAttr "_leftFootIndex.av[10]" "LeftFootIndex1Eff.rz";
connectAttr "_leftFootIndex.av[11]" "LeftFootIndex1Eff.ry";
connectAttr "_leftFootIndex.av[12]" "LeftFootIndex1Eff.rx";
connectAttr "_leftFootIndex.lv[10]" "LeftFootIndex1Eff.tz";
connectAttr "_leftFootIndex.lv[11]" "LeftFootIndex1Eff.ty";
connectAttr "_leftFootIndex.lv[12]" "LeftFootIndex1Eff.tx";
connectAttr "joint44.msg" "LeftFootMiddle1Eff.jt";
connectAttr "joint44FK.msg" "LeftFootMiddle1Eff.fj";
connectAttr "_leftFootMiddle.uv[10]" "LeftFootMiddle1Eff.rr";
connectAttr "_leftFootMiddle.uv[11]" "LeftFootMiddle1Eff.rt";
connectAttr "_leftFootMiddle.av[10]" "LeftFootMiddle1Eff.rz";
connectAttr "_leftFootMiddle.av[11]" "LeftFootMiddle1Eff.ry";
connectAttr "_leftFootMiddle.av[12]" "LeftFootMiddle1Eff.rx";
connectAttr "_leftFootMiddle.lv[10]" "LeftFootMiddle1Eff.tz";
connectAttr "_leftFootMiddle.lv[11]" "LeftFootMiddle1Eff.ty";
connectAttr "_leftFootMiddle.lv[12]" "LeftFootMiddle1Eff.tx";
connectAttr "rightFoot.msg" "RightFootEff.jt";
connectAttr "rightFootFK.msg" "RightFootEff.fj";
connectAttr "_rightLeg.uv[13]" "RightFootEff.rr";
connectAttr "_rightLeg.uv[14]" "RightFootEff.rt";
connectAttr "_rightLeg.av[13]" "RightFootEff.rz";
connectAttr "_rightLeg.av[14]" "RightFootEff.ry";
connectAttr "_rightLeg.av[15]" "RightFootEff.rx";
connectAttr "_rightLeg.lv[13]" "RightFootEff.tz";
connectAttr "_rightLeg.lv[14]" "RightFootEff.ty";
connectAttr "_rightLeg.lv[15]" "RightFootEff.tx";
connectAttr "joint59.msg" "RightFootIndex1Eff.jt";
connectAttr "joint59FK.msg" "RightFootIndex1Eff.fj";
connectAttr "_rightFootIndex.uv[10]" "RightFootIndex1Eff.rr";
connectAttr "_rightFootIndex.uv[11]" "RightFootIndex1Eff.rt";
connectAttr "_rightFootIndex.av[10]" "RightFootIndex1Eff.rz";
connectAttr "_rightFootIndex.av[11]" "RightFootIndex1Eff.ry";
connectAttr "_rightFootIndex.av[12]" "RightFootIndex1Eff.rx";
connectAttr "_rightFootIndex.lv[10]" "RightFootIndex1Eff.tz";
connectAttr "_rightFootIndex.lv[11]" "RightFootIndex1Eff.ty";
connectAttr "_rightFootIndex.lv[12]" "RightFootIndex1Eff.tx";
connectAttr "joint62.msg" "RightFootMiddle1Eff.jt";
connectAttr "joint62FK.msg" "RightFootMiddle1Eff.fj";
connectAttr "_rightFootMiddle.uv[10]" "RightFootMiddle1Eff.rr";
connectAttr "_rightFootMiddle.uv[11]" "RightFootMiddle1Eff.rt";
connectAttr "_rightFootMiddle.av[10]" "RightFootMiddle1Eff.rz";
connectAttr "_rightFootMiddle.av[11]" "RightFootMiddle1Eff.ry";
connectAttr "_rightFootMiddle.av[12]" "RightFootMiddle1Eff.rx";
connectAttr "_rightFootMiddle.lv[10]" "RightFootMiddle1Eff.tz";
connectAttr "_rightFootMiddle.lv[11]" "RightFootMiddle1Eff.ty";
connectAttr "_rightFootMiddle.lv[12]" "RightFootMiddle1Eff.tx";
connectAttr "leftHand.msg" "LeftHandEff.jt";
connectAttr "leftHandFK.msg" "LeftHandEff.fj";
connectAttr "_leftArm.uv[16]" "LeftHandEff.rr";
connectAttr "_leftArm.uv[17]" "LeftHandEff.rt";
connectAttr "_leftArm.av[16]" "LeftHandEff.rz";
connectAttr "_leftArm.av[17]" "LeftHandEff.ry";
connectAttr "_leftArm.av[18]" "LeftHandEff.rx";
connectAttr "_leftArm.lv[16]" "LeftHandEff.tz";
connectAttr "_leftArm.lv[17]" "LeftHandEff.ty";
connectAttr "_leftArm.lv[18]" "LeftHandEff.tx";
connectAttr "joint42.msg" "LeftHandIndex1Eff.jt";
connectAttr "joint42FK.msg" "LeftHandIndex1Eff.fj";
connectAttr "_leftFingerIndex.uv[10]" "LeftHandIndex1Eff.rr";
connectAttr "_leftFingerIndex.uv[11]" "LeftHandIndex1Eff.rt";
connectAttr "_leftFingerIndex.av[10]" "LeftHandIndex1Eff.rz";
connectAttr "_leftFingerIndex.av[11]" "LeftHandIndex1Eff.ry";
connectAttr "_leftFingerIndex.av[12]" "LeftHandIndex1Eff.rx";
connectAttr "_leftFingerIndex.lv[10]" "LeftHandIndex1Eff.tz";
connectAttr "_leftFingerIndex.lv[11]" "LeftHandIndex1Eff.ty";
connectAttr "_leftFingerIndex.lv[12]" "LeftHandIndex1Eff.tx";
connectAttr "joint12.msg" "LeftHandMiddle1Eff.jt";
connectAttr "joint12FK.msg" "LeftHandMiddle1Eff.fj";
connectAttr "_leftFingerMiddle.uv[10]" "LeftHandMiddle1Eff.rr";
connectAttr "_leftFingerMiddle.uv[11]" "LeftHandMiddle1Eff.rt";
connectAttr "_leftFingerMiddle.av[10]" "LeftHandMiddle1Eff.rz";
connectAttr "_leftFingerMiddle.av[11]" "LeftHandMiddle1Eff.ry";
connectAttr "_leftFingerMiddle.av[12]" "LeftHandMiddle1Eff.rx";
connectAttr "_leftFingerMiddle.lv[10]" "LeftHandMiddle1Eff.tz";
connectAttr "_leftFingerMiddle.lv[11]" "LeftHandMiddle1Eff.ty";
connectAttr "_leftFingerMiddle.lv[12]" "LeftHandMiddle1Eff.tx";
connectAttr "rightHand.msg" "RightHandEff.jt";
connectAttr "rightHandFK.msg" "RightHandEff.fj";
connectAttr "_rightArm.uv[16]" "RightHandEff.rr";
connectAttr "_rightArm.uv[17]" "RightHandEff.rt";
connectAttr "_rightArm.av[16]" "RightHandEff.rz";
connectAttr "_rightArm.av[17]" "RightHandEff.ry";
connectAttr "_rightArm.av[18]" "RightHandEff.rx";
connectAttr "_rightArm.lv[16]" "RightHandEff.tz";
connectAttr "_rightArm.lv[17]" "RightHandEff.ty";
connectAttr "_rightArm.lv[18]" "RightHandEff.tx";
connectAttr "joint52.msg" "RightHandIndex1Eff.jt";
connectAttr "joint52FK.msg" "RightHandIndex1Eff.fj";
connectAttr "_rightFingerIndex.uv[10]" "RightHandIndex1Eff.rr";
connectAttr "_rightFingerIndex.uv[11]" "RightHandIndex1Eff.rt";
connectAttr "_rightFingerIndex.av[10]" "RightHandIndex1Eff.rz";
connectAttr "_rightFingerIndex.av[11]" "RightHandIndex1Eff.ry";
connectAttr "_rightFingerIndex.av[12]" "RightHandIndex1Eff.rx";
connectAttr "_rightFingerIndex.lv[10]" "RightHandIndex1Eff.tz";
connectAttr "_rightFingerIndex.lv[11]" "RightHandIndex1Eff.ty";
connectAttr "_rightFingerIndex.lv[12]" "RightHandIndex1Eff.tx";
connectAttr "joint49.msg" "RightHandMiddle1Eff.jt";
connectAttr "joint49FK.msg" "RightHandMiddle1Eff.fj";
connectAttr "_rightFingerMiddle.uv[10]" "RightHandMiddle1Eff.rr";
connectAttr "_rightFingerMiddle.uv[11]" "RightHandMiddle1Eff.rt";
connectAttr "_rightFingerMiddle.av[10]" "RightHandMiddle1Eff.rz";
connectAttr "_rightFingerMiddle.av[11]" "RightHandMiddle1Eff.ry";
connectAttr "_rightFingerMiddle.av[12]" "RightHandMiddle1Eff.rx";
connectAttr "_rightFingerMiddle.lv[10]" "RightHandMiddle1Eff.tz";
connectAttr "_rightFingerMiddle.lv[11]" "RightHandMiddle1Eff.ty";
connectAttr "_rightFingerMiddle.lv[12]" "RightHandMiddle1Eff.tx";
connectAttr "leftLeg.msg" "LeftLegEff.jt";
connectAttr "leftLegFK.msg" "LeftLegEff.fj";
connectAttr "_leftLeg.uv[15]" "LeftLegEff.rr";
connectAttr "_leftLeg.uv[16]" "LeftLegEff.rt";
connectAttr "_leftLeg.av[16]" "LeftLegEff.rz";
connectAttr "_leftLeg.av[17]" "LeftLegEff.ry";
connectAttr "_leftLeg.av[18]" "LeftLegEff.rx";
connectAttr "_leftLeg.lv[16]" "LeftLegEff.tz";
connectAttr "_leftLeg.lv[17]" "LeftLegEff.ty";
connectAttr "_leftLeg.lv[18]" "LeftLegEff.tx";
connectAttr "rightLeg.msg" "RightLegEff.jt";
connectAttr "rightLegFK.msg" "RightLegEff.fj";
connectAttr "_rightLeg.uv[15]" "RightLegEff.rr";
connectAttr "_rightLeg.uv[16]" "RightLegEff.rt";
connectAttr "_rightLeg.av[16]" "RightLegEff.rz";
connectAttr "_rightLeg.av[17]" "RightLegEff.ry";
connectAttr "_rightLeg.av[18]" "RightLegEff.rx";
connectAttr "_rightLeg.lv[16]" "RightLegEff.tz";
connectAttr "_rightLeg.lv[17]" "RightLegEff.ty";
connectAttr "_rightLeg.lv[18]" "RightLegEff.tx";
connectAttr "leftForeArm.msg" "LeftForeArmEff.jt";
connectAttr "leftForeArmFK.msg" "LeftForeArmEff.fj";
connectAttr "_leftArm.uv[18]" "LeftForeArmEff.rr";
connectAttr "_leftArm.uv[19]" "LeftForeArmEff.rt";
connectAttr "_leftArm.av[19]" "LeftForeArmEff.rz";
connectAttr "_leftArm.av[20]" "LeftForeArmEff.ry";
connectAttr "_leftArm.av[21]" "LeftForeArmEff.rx";
connectAttr "_leftArm.lv[19]" "LeftForeArmEff.tz";
connectAttr "_leftArm.lv[20]" "LeftForeArmEff.ty";
connectAttr "_leftArm.lv[21]" "LeftForeArmEff.tx";
connectAttr "rightForeArm.msg" "RightForeArmEff.jt";
connectAttr "rightForeArmFK.msg" "RightForeArmEff.fj";
connectAttr "_rightArm.uv[18]" "RightForeArmEff.rr";
connectAttr "_rightArm.uv[19]" "RightForeArmEff.rt";
connectAttr "_rightArm.av[19]" "RightForeArmEff.rz";
connectAttr "_rightArm.av[20]" "RightForeArmEff.ry";
connectAttr "_rightArm.av[21]" "RightForeArmEff.rx";
connectAttr "_rightArm.lv[19]" "RightForeArmEff.tz";
connectAttr "_rightArm.lv[20]" "RightForeArmEff.ty";
connectAttr "_rightArm.lv[21]" "RightForeArmEff.tx";
connectAttr "spine.msg" "SpineEff.jt";
connectAttr "spineFK.msg" "SpineEff.fj";
connectAttr "_spine.uv[10]" "SpineEff.rr";
connectAttr "_spine.uv[11]" "SpineEff.rt";
connectAttr "_spine.av[10]" "SpineEff.rz";
connectAttr "_spine.av[11]" "SpineEff.ry";
connectAttr "_spine.av[12]" "SpineEff.rx";
connectAttr "_spine.lv[10]" "SpineEff.tz" -l on;
connectAttr "_spine.lv[11]" "SpineEff.ty" -l on;
connectAttr "_spine.lv[12]" "SpineEff.tx" -l on;
connectAttr "leftToeBase.msg" "LeftToeBaseEff.jt";
connectAttr "leftToeBaseFK.msg" "LeftToeBaseEff.fj";
connectAttr "_leftLeg.uv[17]" "LeftToeBaseEff.rr";
connectAttr "_leftLeg.uv[18]" "LeftToeBaseEff.rt";
connectAttr "_leftLeg.av[19]" "LeftToeBaseEff.rz";
connectAttr "_leftLeg.av[20]" "LeftToeBaseEff.ry";
connectAttr "_leftLeg.av[21]" "LeftToeBaseEff.rx";
connectAttr "_leftLeg.lv[19]" "LeftToeBaseEff.tz";
connectAttr "_leftLeg.lv[20]" "LeftToeBaseEff.ty";
connectAttr "_leftLeg.lv[21]" "LeftToeBaseEff.tx";
connectAttr "rightToeBase.msg" "RightToeBaseEff.jt";
connectAttr "rightToeBaseFK.msg" "RightToeBaseEff.fj";
connectAttr "_rightLeg.uv[17]" "RightToeBaseEff.rr";
connectAttr "_rightLeg.uv[18]" "RightToeBaseEff.rt";
connectAttr "_rightLeg.av[19]" "RightToeBaseEff.rz";
connectAttr "_rightLeg.av[20]" "RightToeBaseEff.ry";
connectAttr "_rightLeg.av[21]" "RightToeBaseEff.rx";
connectAttr "_rightLeg.lv[19]" "RightToeBaseEff.tz";
connectAttr "_rightLeg.lv[20]" "RightToeBaseEff.ty";
connectAttr "_rightLeg.lv[21]" "RightToeBaseEff.tx";
connectAttr "leftArm.msg" "LeftArmEff.jt";
connectAttr "leftArmFK.msg" "LeftArmEff.fj";
connectAttr "_leftArm.uv[20]" "LeftArmEff.rr";
connectAttr "_leftArm.uv[21]" "LeftArmEff.rt";
connectAttr "_leftArm.av[22]" "LeftArmEff.rz";
connectAttr "_leftArm.av[23]" "LeftArmEff.ry";
connectAttr "_leftArm.av[24]" "LeftArmEff.rx";
connectAttr "_leftArm.lv[22]" "LeftArmEff.tz";
connectAttr "_leftArm.lv[23]" "LeftArmEff.ty";
connectAttr "_leftArm.lv[24]" "LeftArmEff.tx";
connectAttr "rightArm.msg" "RightArmEff.jt";
connectAttr "rightArmFK.msg" "RightArmEff.fj";
connectAttr "_rightArm.uv[20]" "RightArmEff.rr";
connectAttr "_rightArm.uv[21]" "RightArmEff.rt";
connectAttr "_rightArm.av[22]" "RightArmEff.rz";
connectAttr "_rightArm.av[23]" "RightArmEff.ry";
connectAttr "_rightArm.av[24]" "RightArmEff.rx";
connectAttr "_rightArm.lv[22]" "RightArmEff.tz";
connectAttr "_rightArm.lv[23]" "RightArmEff.ty";
connectAttr "_rightArm.lv[24]" "RightArmEff.tx";
connectAttr "head.msg" "HeadEff.jt";
connectAttr "headFK.msg" "HeadEff.fj";
connectAttr "_head.uv[25]" "HeadEff.rr";
connectAttr "_head.uv[26]" "HeadEff.rt";
connectAttr "_head.av[25]" "HeadEff.rz";
connectAttr "_head.av[26]" "HeadEff.ry";
connectAttr "_head.av[27]" "HeadEff.rx";
connectAttr "_head.lv[25]" "HeadEff.tz";
connectAttr "_head.lv[26]" "HeadEff.ty";
connectAttr "_head.lv[27]" "HeadEff.tx";
connectAttr "leftUpLeg.msg" "LeftUpLegEff.jt";
connectAttr "leftUpLegFK.msg" "LeftUpLegEff.fj";
connectAttr "_leftLeg.uv[19]" "LeftUpLegEff.rr";
connectAttr "_leftLeg.uv[20]" "LeftUpLegEff.rt";
connectAttr "_leftLeg.av[22]" "LeftUpLegEff.rz";
connectAttr "_leftLeg.av[23]" "LeftUpLegEff.ry";
connectAttr "_leftLeg.av[24]" "LeftUpLegEff.rx";
connectAttr "_leftLeg.lv[22]" "LeftUpLegEff.tz" -l on;
connectAttr "_leftLeg.lv[23]" "LeftUpLegEff.ty" -l on;
connectAttr "_leftLeg.lv[24]" "LeftUpLegEff.tx" -l on;
connectAttr "rightUpLeg.msg" "RightUpLegEff.jt";
connectAttr "rightUpLegFK.msg" "RightUpLegEff.fj";
connectAttr "_rightLeg.uv[19]" "RightUpLegEff.rr";
connectAttr "_rightLeg.uv[20]" "RightUpLegEff.rt";
connectAttr "_rightLeg.av[22]" "RightUpLegEff.rz";
connectAttr "_rightLeg.av[23]" "RightUpLegEff.ry";
connectAttr "_rightLeg.av[24]" "RightUpLegEff.rx";
connectAttr "_rightLeg.lv[22]" "RightUpLegEff.tz" -l on;
connectAttr "_rightLeg.lv[23]" "RightUpLegEff.ty" -l on;
connectAttr "_rightLeg.lv[24]" "RightUpLegEff.tx" -l on;
connectAttr "leftFingerBase.msg" "LeftFingerBaseEff.jt";
connectAttr "leftFingerBaseFK.msg" "LeftFingerBaseEff.fj";
connectAttr "_leftArm.uv[22]" "LeftFingerBaseEff.rr";
connectAttr "_leftArm.uv[23]" "LeftFingerBaseEff.rt";
connectAttr "_leftArm.av[25]" "LeftFingerBaseEff.rz";
connectAttr "_leftArm.av[26]" "LeftFingerBaseEff.ry";
connectAttr "_leftArm.av[27]" "LeftFingerBaseEff.rx";
connectAttr "_leftArm.lv[25]" "LeftFingerBaseEff.tz";
connectAttr "_leftArm.lv[26]" "LeftFingerBaseEff.ty";
connectAttr "_leftArm.lv[27]" "LeftFingerBaseEff.tx";
connectAttr "rightFingerBase.msg" "RightFingerBaseEff.jt";
connectAttr "rightFingerBaseFK.msg" "RightFingerBaseEff.fj";
connectAttr "_rightArm.uv[22]" "RightFingerBaseEff.rr";
connectAttr "_rightArm.uv[23]" "RightFingerBaseEff.rt";
connectAttr "_rightArm.av[25]" "RightFingerBaseEff.rz";
connectAttr "_rightArm.av[26]" "RightFingerBaseEff.ry";
connectAttr "_rightArm.av[27]" "RightFingerBaseEff.rx";
connectAttr "_rightArm.lv[25]" "RightFingerBaseEff.tz";
connectAttr "_rightArm.lv[26]" "RightFingerBaseEff.ty";
connectAttr "_rightArm.lv[27]" "RightFingerBaseEff.tx";
connectAttr "spine2.msg" "NeckEff.jt";
connectAttr "spine2FK.msg" "NeckEff.fj";
connectAttr "_spine.uv[12]" "NeckEff.rr";
connectAttr "_spine.uv[13]" "NeckEff.rt";
connectAttr "_spine.av[13]" "NeckEff.rz";
connectAttr "_spine.av[14]" "NeckEff.ry";
connectAttr "_spine.av[15]" "NeckEff.rx";
connectAttr "_spine.lv[13]" "NeckEff.tz";
connectAttr "_spine.lv[14]" "NeckEff.ty";
connectAttr "_spine.lv[15]" "NeckEff.tx";
connectAttr "_hips.uv[1]" "hipsFK.sz";
connectAttr "_hips.uv[2]" "hipsFK.sy";
connectAttr "_hips.uv[3]" "hipsFK.sx";
connectAttr "_hips.av[1]" "hipsFK.rz";
connectAttr "_hips.av[2]" "hipsFK.ry";
connectAttr "_hips.av[3]" "hipsFK.rx";
connectAttr "_hips.lv[1]" "hipsFK.tz";
connectAttr "_hips.lv[2]" "hipsFK.ty";
connectAttr "_hips.lv[3]" "hipsFK.tx";
connectAttr "hipsFK.s" "spineFK.is";
connectAttr "_spine.uv[1]" "spineFK.sz";
connectAttr "_spine.uv[2]" "spineFK.sy";
connectAttr "_spine.uv[3]" "spineFK.sx";
connectAttr "_spine.av[1]" "spineFK.rz";
connectAttr "_spine.av[2]" "spineFK.ry";
connectAttr "_spine.av[3]" "spineFK.rx";
connectAttr "_spine.lv[1]" "spineFK.tz";
connectAttr "_spine.lv[2]" "spineFK.ty";
connectAttr "_spine.lv[3]" "spineFK.tx";
connectAttr "spineFK.s" "spine1FK.is";
connectAttr "_spine.uv[4]" "spine1FK.sz";
connectAttr "_spine.uv[5]" "spine1FK.sy";
connectAttr "_spine.uv[6]" "spine1FK.sx";
connectAttr "_spine.av[4]" "spine1FK.rz";
connectAttr "_spine.av[5]" "spine1FK.ry";
connectAttr "_spine.av[6]" "spine1FK.rx";
connectAttr "_spine.lv[4]" "spine1FK.tz";
connectAttr "_spine.lv[5]" "spine1FK.ty";
connectAttr "_spine.lv[6]" "spine1FK.tx";
connectAttr "spine1FK.s" "spine2FK.is";
connectAttr "_spine.uv[7]" "spine2FK.sz";
connectAttr "_spine.uv[8]" "spine2FK.sy";
connectAttr "_spine.uv[9]" "spine2FK.sx";
connectAttr "_spine.av[7]" "spine2FK.rz";
connectAttr "_spine.av[8]" "spine2FK.ry";
connectAttr "_spine.av[9]" "spine2FK.rx";
connectAttr "_spine.lv[7]" "spine2FK.tz";
connectAttr "_spine.lv[8]" "spine2FK.ty";
connectAttr "_spine.lv[9]" "spine2FK.tx";
connectAttr "spine2FK.s" "neckFK.is";
connectAttr "_head.uv[1]" "neckFK.sz";
connectAttr "_head.uv[2]" "neckFK.sy";
connectAttr "_head.uv[3]" "neckFK.sx";
connectAttr "_head.av[1]" "neckFK.rz";
connectAttr "_head.av[2]" "neckFK.ry";
connectAttr "_head.av[3]" "neckFK.rx";
connectAttr "_head.lv[1]" "neckFK.tz";
connectAttr "_head.lv[2]" "neckFK.ty";
connectAttr "_head.lv[3]" "neckFK.tx";
connectAttr "neckFK.s" "neck1FK.is";
connectAttr "_head.uv[4]" "neck1FK.sz";
connectAttr "_head.uv[5]" "neck1FK.sy";
connectAttr "_head.uv[6]" "neck1FK.sx";
connectAttr "_head.av[4]" "neck1FK.rz";
connectAttr "_head.av[5]" "neck1FK.ry";
connectAttr "_head.av[6]" "neck1FK.rx";
connectAttr "_head.lv[4]" "neck1FK.tz";
connectAttr "_head.lv[5]" "neck1FK.ty";
connectAttr "_head.lv[6]" "neck1FK.tx";
connectAttr "neck1FK.s" "neck2FK.is";
connectAttr "_head.uv[7]" "neck2FK.sz";
connectAttr "_head.uv[8]" "neck2FK.sy";
connectAttr "_head.uv[9]" "neck2FK.sx";
connectAttr "_head.av[7]" "neck2FK.rz";
connectAttr "_head.av[8]" "neck2FK.ry";
connectAttr "_head.av[9]" "neck2FK.rx";
connectAttr "_head.lv[7]" "neck2FK.tz";
connectAttr "_head.lv[8]" "neck2FK.ty";
connectAttr "_head.lv[9]" "neck2FK.tx";
connectAttr "neck2FK.s" "neck3FK.is";
connectAttr "_head.uv[10]" "neck3FK.sz";
connectAttr "_head.uv[11]" "neck3FK.sy";
connectAttr "_head.uv[12]" "neck3FK.sx";
connectAttr "_head.av[10]" "neck3FK.rz";
connectAttr "_head.av[11]" "neck3FK.ry";
connectAttr "_head.av[12]" "neck3FK.rx";
connectAttr "_head.lv[10]" "neck3FK.tz";
connectAttr "_head.lv[11]" "neck3FK.ty";
connectAttr "_head.lv[12]" "neck3FK.tx";
connectAttr "neck3FK.s" "neck4FK.is";
connectAttr "_head.uv[13]" "neck4FK.sz";
connectAttr "_head.uv[14]" "neck4FK.sy";
connectAttr "_head.uv[15]" "neck4FK.sx";
connectAttr "_head.av[13]" "neck4FK.rz";
connectAttr "_head.av[14]" "neck4FK.ry";
connectAttr "_head.av[15]" "neck4FK.rx";
connectAttr "_head.lv[13]" "neck4FK.tz";
connectAttr "_head.lv[14]" "neck4FK.ty";
connectAttr "_head.lv[15]" "neck4FK.tx";
connectAttr "neck4FK.s" "neck5FK.is";
connectAttr "_head.uv[16]" "neck5FK.sz";
connectAttr "_head.uv[17]" "neck5FK.sy";
connectAttr "_head.uv[18]" "neck5FK.sx";
connectAttr "_head.av[16]" "neck5FK.rz";
connectAttr "_head.av[17]" "neck5FK.ry";
connectAttr "_head.av[18]" "neck5FK.rx";
connectAttr "_head.lv[16]" "neck5FK.tz";
connectAttr "_head.lv[17]" "neck5FK.ty";
connectAttr "_head.lv[18]" "neck5FK.tx";
connectAttr "neck5FK.s" "neck6FK.is";
connectAttr "_head.uv[19]" "neck6FK.sz";
connectAttr "_head.uv[20]" "neck6FK.sy";
connectAttr "_head.uv[21]" "neck6FK.sx";
connectAttr "_head.av[19]" "neck6FK.rz";
connectAttr "_head.av[20]" "neck6FK.ry";
connectAttr "_head.av[21]" "neck6FK.rx";
connectAttr "_head.lv[19]" "neck6FK.tz";
connectAttr "_head.lv[20]" "neck6FK.ty";
connectAttr "_head.lv[21]" "neck6FK.tx";
connectAttr "neck6FK.s" "headFK.is";
connectAttr "_head.uv[22]" "headFK.sz";
connectAttr "_head.uv[23]" "headFK.sy";
connectAttr "_head.uv[24]" "headFK.sx";
connectAttr "_head.av[22]" "headFK.rz";
connectAttr "_head.av[23]" "headFK.ry";
connectAttr "_head.av[24]" "headFK.rx";
connectAttr "_head.lv[22]" "headFK.tz";
connectAttr "_head.lv[23]" "headFK.ty";
connectAttr "_head.lv[24]" "headFK.tx";
connectAttr "spine2FK.s" "rightCollarFK.is";
connectAttr "_rightArm.uv[1]" "rightCollarFK.sz";
connectAttr "_rightArm.uv[2]" "rightCollarFK.sy";
connectAttr "_rightArm.uv[3]" "rightCollarFK.sx";
connectAttr "_rightArm.av[1]" "rightCollarFK.rz";
connectAttr "_rightArm.av[2]" "rightCollarFK.ry";
connectAttr "_rightArm.av[3]" "rightCollarFK.rx";
connectAttr "_rightArm.lv[1]" "rightCollarFK.tz";
connectAttr "_rightArm.lv[2]" "rightCollarFK.ty";
connectAttr "_rightArm.lv[3]" "rightCollarFK.tx";
connectAttr "rightCollarFK.s" "rightArmFK.is";
connectAttr "_rightArm.uv[4]" "rightArmFK.sz";
connectAttr "_rightArm.uv[5]" "rightArmFK.sy";
connectAttr "_rightArm.uv[6]" "rightArmFK.sx";
connectAttr "_rightArm.av[4]" "rightArmFK.rz";
connectAttr "_rightArm.av[5]" "rightArmFK.ry";
connectAttr "_rightArm.av[6]" "rightArmFK.rx";
connectAttr "_rightArm.lv[4]" "rightArmFK.tz";
connectAttr "_rightArm.lv[5]" "rightArmFK.ty";
connectAttr "_rightArm.lv[6]" "rightArmFK.tx";
connectAttr "rightArmFK.s" "rightForeArmFK.is";
connectAttr "_rightArm.uv[7]" "rightForeArmFK.sz";
connectAttr "_rightArm.uv[8]" "rightForeArmFK.sy";
connectAttr "_rightArm.uv[9]" "rightForeArmFK.sx";
connectAttr "_rightArm.av[7]" "rightForeArmFK.rz";
connectAttr "_rightArm.av[8]" "rightForeArmFK.ry";
connectAttr "_rightArm.av[9]" "rightForeArmFK.rx";
connectAttr "_rightArm.lv[7]" "rightForeArmFK.tz";
connectAttr "_rightArm.lv[8]" "rightForeArmFK.ty";
connectAttr "_rightArm.lv[9]" "rightForeArmFK.tx";
connectAttr "rightForeArmFK.s" "rightHandFK.is";
connectAttr "_rightArm.uv[10]" "rightHandFK.sz";
connectAttr "_rightArm.uv[11]" "rightHandFK.sy";
connectAttr "_rightArm.uv[12]" "rightHandFK.sx";
connectAttr "_rightArm.av[10]" "rightHandFK.rz";
connectAttr "_rightArm.av[11]" "rightHandFK.ry";
connectAttr "_rightArm.av[12]" "rightHandFK.rx";
connectAttr "_rightArm.lv[10]" "rightHandFK.tz";
connectAttr "_rightArm.lv[11]" "rightHandFK.ty";
connectAttr "_rightArm.lv[12]" "rightHandFK.tx";
connectAttr "rightHandFK.s" "rightFingerBaseFK.is";
connectAttr "_rightArm.uv[13]" "rightFingerBaseFK.sz";
connectAttr "_rightArm.uv[14]" "rightFingerBaseFK.sy";
connectAttr "_rightArm.uv[15]" "rightFingerBaseFK.sx";
connectAttr "_rightArm.av[13]" "rightFingerBaseFK.rz";
connectAttr "_rightArm.av[14]" "rightFingerBaseFK.ry";
connectAttr "_rightArm.av[15]" "rightFingerBaseFK.rx";
connectAttr "_rightArm.lv[13]" "rightFingerBaseFK.tz";
connectAttr "_rightArm.lv[14]" "rightFingerBaseFK.ty";
connectAttr "_rightArm.lv[15]" "rightFingerBaseFK.tx";
connectAttr "rightFingerBaseFK.s" "joint49FK.is";
connectAttr "_rightFingerMiddle.uv[1]" "joint49FK.sz";
connectAttr "_rightFingerMiddle.uv[2]" "joint49FK.sy";
connectAttr "_rightFingerMiddle.uv[3]" "joint49FK.sx";
connectAttr "_rightFingerMiddle.av[1]" "joint49FK.rz";
connectAttr "_rightFingerMiddle.av[2]" "joint49FK.ry";
connectAttr "_rightFingerMiddle.av[3]" "joint49FK.rx";
connectAttr "_rightFingerMiddle.lv[1]" "joint49FK.tz";
connectAttr "_rightFingerMiddle.lv[2]" "joint49FK.ty";
connectAttr "_rightFingerMiddle.lv[3]" "joint49FK.tx";
connectAttr "joint49FK.s" "joint50FK.is";
connectAttr "_rightFingerMiddle.uv[4]" "joint50FK.sz";
connectAttr "_rightFingerMiddle.uv[5]" "joint50FK.sy";
connectAttr "_rightFingerMiddle.uv[6]" "joint50FK.sx";
connectAttr "_rightFingerMiddle.av[4]" "joint50FK.rz";
connectAttr "_rightFingerMiddle.av[5]" "joint50FK.ry";
connectAttr "_rightFingerMiddle.av[6]" "joint50FK.rx";
connectAttr "_rightFingerMiddle.lv[4]" "joint50FK.tz";
connectAttr "_rightFingerMiddle.lv[5]" "joint50FK.ty";
connectAttr "_rightFingerMiddle.lv[6]" "joint50FK.tx";
connectAttr "joint50FK.s" "joint51FK.is";
connectAttr "_rightFingerMiddle.uv[7]" "joint51FK.sz";
connectAttr "_rightFingerMiddle.uv[8]" "joint51FK.sy";
connectAttr "_rightFingerMiddle.uv[9]" "joint51FK.sx";
connectAttr "_rightFingerMiddle.av[7]" "joint51FK.rz";
connectAttr "_rightFingerMiddle.av[8]" "joint51FK.ry";
connectAttr "_rightFingerMiddle.av[9]" "joint51FK.rx";
connectAttr "_rightFingerMiddle.lv[7]" "joint51FK.tz";
connectAttr "_rightFingerMiddle.lv[8]" "joint51FK.ty";
connectAttr "_rightFingerMiddle.lv[9]" "joint51FK.tx";
connectAttr "rightFingerBaseFK.s" "joint52FK.is";
connectAttr "_rightFingerIndex.uv[1]" "joint52FK.sz";
connectAttr "_rightFingerIndex.uv[2]" "joint52FK.sy";
connectAttr "_rightFingerIndex.uv[3]" "joint52FK.sx";
connectAttr "_rightFingerIndex.av[1]" "joint52FK.rz";
connectAttr "_rightFingerIndex.av[2]" "joint52FK.ry";
connectAttr "_rightFingerIndex.av[3]" "joint52FK.rx";
connectAttr "_rightFingerIndex.lv[1]" "joint52FK.tz";
connectAttr "_rightFingerIndex.lv[2]" "joint52FK.ty";
connectAttr "_rightFingerIndex.lv[3]" "joint52FK.tx";
connectAttr "joint52FK.s" "joint53FK.is";
connectAttr "_rightFingerIndex.uv[4]" "joint53FK.sz";
connectAttr "_rightFingerIndex.uv[5]" "joint53FK.sy";
connectAttr "_rightFingerIndex.uv[6]" "joint53FK.sx";
connectAttr "_rightFingerIndex.av[4]" "joint53FK.rz";
connectAttr "_rightFingerIndex.av[5]" "joint53FK.ry";
connectAttr "_rightFingerIndex.av[6]" "joint53FK.rx";
connectAttr "_rightFingerIndex.lv[4]" "joint53FK.tz";
connectAttr "_rightFingerIndex.lv[5]" "joint53FK.ty";
connectAttr "_rightFingerIndex.lv[6]" "joint53FK.tx";
connectAttr "joint53FK.s" "joint54FK.is";
connectAttr "_rightFingerIndex.uv[7]" "joint54FK.sz";
connectAttr "_rightFingerIndex.uv[8]" "joint54FK.sy";
connectAttr "_rightFingerIndex.uv[9]" "joint54FK.sx";
connectAttr "_rightFingerIndex.av[7]" "joint54FK.rz";
connectAttr "_rightFingerIndex.av[8]" "joint54FK.ry";
connectAttr "_rightFingerIndex.av[9]" "joint54FK.rx";
connectAttr "_rightFingerIndex.lv[7]" "joint54FK.tz";
connectAttr "_rightFingerIndex.lv[8]" "joint54FK.ty";
connectAttr "_rightFingerIndex.lv[9]" "joint54FK.tx";
connectAttr "spine2FK.s" "leftCollarFK.is";
connectAttr "_leftArm.uv[1]" "leftCollarFK.sz";
connectAttr "_leftArm.uv[2]" "leftCollarFK.sy";
connectAttr "_leftArm.uv[3]" "leftCollarFK.sx";
connectAttr "_leftArm.av[1]" "leftCollarFK.rz";
connectAttr "_leftArm.av[2]" "leftCollarFK.ry";
connectAttr "_leftArm.av[3]" "leftCollarFK.rx";
connectAttr "_leftArm.lv[1]" "leftCollarFK.tz";
connectAttr "_leftArm.lv[2]" "leftCollarFK.ty";
connectAttr "_leftArm.lv[3]" "leftCollarFK.tx";
connectAttr "leftCollarFK.s" "leftArmFK.is";
connectAttr "_leftArm.uv[4]" "leftArmFK.sz";
connectAttr "_leftArm.uv[5]" "leftArmFK.sy";
connectAttr "_leftArm.uv[6]" "leftArmFK.sx";
connectAttr "_leftArm.av[4]" "leftArmFK.rz";
connectAttr "_leftArm.av[5]" "leftArmFK.ry";
connectAttr "_leftArm.av[6]" "leftArmFK.rx";
connectAttr "_leftArm.lv[4]" "leftArmFK.tz";
connectAttr "_leftArm.lv[5]" "leftArmFK.ty";
connectAttr "_leftArm.lv[6]" "leftArmFK.tx";
connectAttr "leftArmFK.s" "leftForeArmFK.is";
connectAttr "_leftArm.uv[7]" "leftForeArmFK.sz";
connectAttr "_leftArm.uv[8]" "leftForeArmFK.sy";
connectAttr "_leftArm.uv[9]" "leftForeArmFK.sx";
connectAttr "_leftArm.av[7]" "leftForeArmFK.rz";
connectAttr "_leftArm.av[8]" "leftForeArmFK.ry";
connectAttr "_leftArm.av[9]" "leftForeArmFK.rx";
connectAttr "_leftArm.lv[7]" "leftForeArmFK.tz";
connectAttr "_leftArm.lv[8]" "leftForeArmFK.ty";
connectAttr "_leftArm.lv[9]" "leftForeArmFK.tx";
connectAttr "leftForeArmFK.s" "leftHandFK.is";
connectAttr "_leftArm.uv[10]" "leftHandFK.sz";
connectAttr "_leftArm.uv[11]" "leftHandFK.sy";
connectAttr "_leftArm.uv[12]" "leftHandFK.sx";
connectAttr "_leftArm.av[10]" "leftHandFK.rz";
connectAttr "_leftArm.av[11]" "leftHandFK.ry";
connectAttr "_leftArm.av[12]" "leftHandFK.rx";
connectAttr "_leftArm.lv[10]" "leftHandFK.tz";
connectAttr "_leftArm.lv[11]" "leftHandFK.ty";
connectAttr "_leftArm.lv[12]" "leftHandFK.tx";
connectAttr "leftHandFK.s" "leftFingerBaseFK.is";
connectAttr "_leftArm.uv[13]" "leftFingerBaseFK.sz";
connectAttr "_leftArm.uv[14]" "leftFingerBaseFK.sy";
connectAttr "_leftArm.uv[15]" "leftFingerBaseFK.sx";
connectAttr "_leftArm.av[13]" "leftFingerBaseFK.rz";
connectAttr "_leftArm.av[14]" "leftFingerBaseFK.ry";
connectAttr "_leftArm.av[15]" "leftFingerBaseFK.rx";
connectAttr "_leftArm.lv[13]" "leftFingerBaseFK.tz";
connectAttr "_leftArm.lv[14]" "leftFingerBaseFK.ty";
connectAttr "_leftArm.lv[15]" "leftFingerBaseFK.tx";
connectAttr "leftFingerBaseFK.s" "joint12FK.is";
connectAttr "_leftFingerMiddle.uv[1]" "joint12FK.sz";
connectAttr "_leftFingerMiddle.uv[2]" "joint12FK.sy";
connectAttr "_leftFingerMiddle.uv[3]" "joint12FK.sx";
connectAttr "_leftFingerMiddle.av[1]" "joint12FK.rz";
connectAttr "_leftFingerMiddle.av[2]" "joint12FK.ry";
connectAttr "_leftFingerMiddle.av[3]" "joint12FK.rx";
connectAttr "_leftFingerMiddle.lv[1]" "joint12FK.tz";
connectAttr "_leftFingerMiddle.lv[2]" "joint12FK.ty";
connectAttr "_leftFingerMiddle.lv[3]" "joint12FK.tx";
connectAttr "joint12FK.s" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.is"
		;
connectAttr "_leftFingerMiddle.uv[4]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.sz"
		;
connectAttr "_leftFingerMiddle.uv[5]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.sy"
		;
connectAttr "_leftFingerMiddle.uv[6]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.sx"
		;
connectAttr "_leftFingerMiddle.av[4]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.rz"
		;
connectAttr "_leftFingerMiddle.av[5]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.ry"
		;
connectAttr "_leftFingerMiddle.av[6]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.rx"
		;
connectAttr "_leftFingerMiddle.lv[4]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.tz"
		;
connectAttr "_leftFingerMiddle.lv[5]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.ty"
		;
connectAttr "_leftFingerMiddle.lv[6]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.tx"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.s" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.is"
		;
connectAttr "_leftFingerMiddle.uv[7]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.sz"
		;
connectAttr "_leftFingerMiddle.uv[8]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.sy"
		;
connectAttr "_leftFingerMiddle.uv[9]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.sx"
		;
connectAttr "_leftFingerMiddle.av[7]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.rz"
		;
connectAttr "_leftFingerMiddle.av[8]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.ry"
		;
connectAttr "_leftFingerMiddle.av[9]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.rx"
		;
connectAttr "_leftFingerMiddle.lv[7]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.tz"
		;
connectAttr "_leftFingerMiddle.lv[8]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.ty"
		;
connectAttr "_leftFingerMiddle.lv[9]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.tx"
		;
connectAttr "leftFingerBaseFK.s" "joint42FK.is";
connectAttr "_leftFingerIndex.uv[1]" "joint42FK.sz";
connectAttr "_leftFingerIndex.uv[2]" "joint42FK.sy";
connectAttr "_leftFingerIndex.uv[3]" "joint42FK.sx";
connectAttr "_leftFingerIndex.av[1]" "joint42FK.rz";
connectAttr "_leftFingerIndex.av[2]" "joint42FK.ry";
connectAttr "_leftFingerIndex.av[3]" "joint42FK.rx";
connectAttr "_leftFingerIndex.lv[1]" "joint42FK.tz";
connectAttr "_leftFingerIndex.lv[2]" "joint42FK.ty";
connectAttr "_leftFingerIndex.lv[3]" "joint42FK.tx";
connectAttr "joint42FK.s" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.is"
		;
connectAttr "_leftFingerIndex.uv[4]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.sz"
		;
connectAttr "_leftFingerIndex.uv[5]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.sy"
		;
connectAttr "_leftFingerIndex.uv[6]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.sx"
		;
connectAttr "_leftFingerIndex.av[4]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.rz"
		;
connectAttr "_leftFingerIndex.av[5]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.ry"
		;
connectAttr "_leftFingerIndex.av[6]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.rx"
		;
connectAttr "_leftFingerIndex.lv[4]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.tz"
		;
connectAttr "_leftFingerIndex.lv[5]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.ty"
		;
connectAttr "_leftFingerIndex.lv[6]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.tx"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.s" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.is"
		;
connectAttr "_leftFingerIndex.uv[7]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.sz"
		;
connectAttr "_leftFingerIndex.uv[8]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.sy"
		;
connectAttr "_leftFingerIndex.uv[9]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.sx"
		;
connectAttr "_leftFingerIndex.av[7]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.rz"
		;
connectAttr "_leftFingerIndex.av[8]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.ry"
		;
connectAttr "_leftFingerIndex.av[9]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.rx"
		;
connectAttr "_leftFingerIndex.lv[7]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.tz"
		;
connectAttr "_leftFingerIndex.lv[8]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.ty"
		;
connectAttr "_leftFingerIndex.lv[9]" "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.tx"
		;
connectAttr "hipsFK.s" "leftUpLegFK.is";
connectAttr "_leftLeg.uv[1]" "leftUpLegFK.sz";
connectAttr "_leftLeg.uv[2]" "leftUpLegFK.sy";
connectAttr "_leftLeg.uv[3]" "leftUpLegFK.sx";
connectAttr "_leftLeg.av[1]" "leftUpLegFK.rz";
connectAttr "_leftLeg.av[2]" "leftUpLegFK.ry";
connectAttr "_leftLeg.av[3]" "leftUpLegFK.rx";
connectAttr "_leftLeg.lv[1]" "leftUpLegFK.tz";
connectAttr "_leftLeg.lv[2]" "leftUpLegFK.ty";
connectAttr "_leftLeg.lv[3]" "leftUpLegFK.tx";
connectAttr "leftUpLegFK.s" "leftLegFK.is";
connectAttr "_leftLeg.uv[4]" "leftLegFK.sz";
connectAttr "_leftLeg.uv[5]" "leftLegFK.sy";
connectAttr "_leftLeg.uv[6]" "leftLegFK.sx";
connectAttr "_leftLeg.av[4]" "leftLegFK.rz";
connectAttr "_leftLeg.av[5]" "leftLegFK.ry";
connectAttr "_leftLeg.av[6]" "leftLegFK.rx";
connectAttr "_leftLeg.lv[4]" "leftLegFK.tz";
connectAttr "_leftLeg.lv[5]" "leftLegFK.ty";
connectAttr "_leftLeg.lv[6]" "leftLegFK.tx";
connectAttr "leftLegFK.s" "leftFootFK.is";
connectAttr "_leftLeg.uv[7]" "leftFootFK.sz";
connectAttr "_leftLeg.uv[8]" "leftFootFK.sy";
connectAttr "_leftLeg.uv[9]" "leftFootFK.sx";
connectAttr "_leftLeg.av[7]" "leftFootFK.rz";
connectAttr "_leftLeg.av[8]" "leftFootFK.ry";
connectAttr "_leftLeg.av[9]" "leftFootFK.rx";
connectAttr "_leftLeg.lv[7]" "leftFootFK.tz";
connectAttr "_leftLeg.lv[8]" "leftFootFK.ty";
connectAttr "_leftLeg.lv[9]" "leftFootFK.tx";
connectAttr "leftFootFK.s" "leftToeBaseFK.is";
connectAttr "_leftLeg.uv[10]" "leftToeBaseFK.sz";
connectAttr "_leftLeg.uv[11]" "leftToeBaseFK.sy";
connectAttr "_leftLeg.uv[12]" "leftToeBaseFK.sx";
connectAttr "_leftLeg.av[10]" "leftToeBaseFK.rz";
connectAttr "_leftLeg.av[11]" "leftToeBaseFK.ry";
connectAttr "_leftLeg.av[12]" "leftToeBaseFK.rx";
connectAttr "_leftLeg.lv[10]" "leftToeBaseFK.tz";
connectAttr "_leftLeg.lv[11]" "leftToeBaseFK.ty";
connectAttr "_leftLeg.lv[12]" "leftToeBaseFK.tx";
connectAttr "leftToeBaseFK.s" "joint43FK.is";
connectAttr "_leftFootIndex.uv[1]" "joint43FK.sz";
connectAttr "_leftFootIndex.uv[2]" "joint43FK.sy";
connectAttr "_leftFootIndex.uv[3]" "joint43FK.sx";
connectAttr "_leftFootIndex.av[1]" "joint43FK.rz";
connectAttr "_leftFootIndex.av[2]" "joint43FK.ry";
connectAttr "_leftFootIndex.av[3]" "joint43FK.rx";
connectAttr "_leftFootIndex.lv[1]" "joint43FK.tz";
connectAttr "_leftFootIndex.lv[2]" "joint43FK.ty";
connectAttr "_leftFootIndex.lv[3]" "joint43FK.tx";
connectAttr "joint43FK.s" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.is"
		;
connectAttr "_leftFootIndex.uv[4]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.sz"
		;
connectAttr "_leftFootIndex.uv[5]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.sy"
		;
connectAttr "_leftFootIndex.uv[6]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.sx"
		;
connectAttr "_leftFootIndex.av[4]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.rz"
		;
connectAttr "_leftFootIndex.av[5]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.ry"
		;
connectAttr "_leftFootIndex.av[6]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.rx"
		;
connectAttr "_leftFootIndex.lv[4]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.tz"
		;
connectAttr "_leftFootIndex.lv[5]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.ty"
		;
connectAttr "_leftFootIndex.lv[6]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.tx"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.s" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.is"
		;
connectAttr "_leftFootIndex.uv[7]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.sz"
		;
connectAttr "_leftFootIndex.uv[8]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.sy"
		;
connectAttr "_leftFootIndex.uv[9]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.sx"
		;
connectAttr "_leftFootIndex.av[7]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.rz"
		;
connectAttr "_leftFootIndex.av[8]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.ry"
		;
connectAttr "_leftFootIndex.av[9]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.rx"
		;
connectAttr "_leftFootIndex.lv[7]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.tz"
		;
connectAttr "_leftFootIndex.lv[8]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.ty"
		;
connectAttr "_leftFootIndex.lv[9]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.tx"
		;
connectAttr "leftToeBaseFK.s" "joint44FK.is";
connectAttr "_leftFootMiddle.uv[1]" "joint44FK.sz";
connectAttr "_leftFootMiddle.uv[2]" "joint44FK.sy";
connectAttr "_leftFootMiddle.uv[3]" "joint44FK.sx";
connectAttr "_leftFootMiddle.av[1]" "joint44FK.rz";
connectAttr "_leftFootMiddle.av[2]" "joint44FK.ry";
connectAttr "_leftFootMiddle.av[3]" "joint44FK.rx";
connectAttr "_leftFootMiddle.lv[1]" "joint44FK.tz";
connectAttr "_leftFootMiddle.lv[2]" "joint44FK.ty";
connectAttr "_leftFootMiddle.lv[3]" "joint44FK.tx";
connectAttr "joint44FK.s" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.is"
		;
connectAttr "_leftFootMiddle.uv[4]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.sz"
		;
connectAttr "_leftFootMiddle.uv[5]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.sy"
		;
connectAttr "_leftFootMiddle.uv[6]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.sx"
		;
connectAttr "_leftFootMiddle.av[4]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.rz"
		;
connectAttr "_leftFootMiddle.av[5]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.ry"
		;
connectAttr "_leftFootMiddle.av[6]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.rx"
		;
connectAttr "_leftFootMiddle.lv[4]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.tz"
		;
connectAttr "_leftFootMiddle.lv[5]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.ty"
		;
connectAttr "_leftFootMiddle.lv[6]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.tx"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.s" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.is"
		;
connectAttr "_leftFootMiddle.uv[7]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.sz"
		;
connectAttr "_leftFootMiddle.uv[8]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.sy"
		;
connectAttr "_leftFootMiddle.uv[9]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.sx"
		;
connectAttr "_leftFootMiddle.av[7]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.rz"
		;
connectAttr "_leftFootMiddle.av[8]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.ry"
		;
connectAttr "_leftFootMiddle.av[9]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.rx"
		;
connectAttr "_leftFootMiddle.lv[7]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.tz"
		;
connectAttr "_leftFootMiddle.lv[8]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.ty"
		;
connectAttr "_leftFootMiddle.lv[9]" "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.tx"
		;
connectAttr "hipsFK.s" "rightUpLegFK.is";
connectAttr "_rightLeg.uv[1]" "rightUpLegFK.sz";
connectAttr "_rightLeg.uv[2]" "rightUpLegFK.sy";
connectAttr "_rightLeg.uv[3]" "rightUpLegFK.sx";
connectAttr "_rightLeg.av[1]" "rightUpLegFK.rz";
connectAttr "_rightLeg.av[2]" "rightUpLegFK.ry";
connectAttr "_rightLeg.av[3]" "rightUpLegFK.rx";
connectAttr "_rightLeg.lv[1]" "rightUpLegFK.tz";
connectAttr "_rightLeg.lv[2]" "rightUpLegFK.ty";
connectAttr "_rightLeg.lv[3]" "rightUpLegFK.tx";
connectAttr "rightUpLegFK.s" "rightLegFK.is";
connectAttr "_rightLeg.uv[4]" "rightLegFK.sz";
connectAttr "_rightLeg.uv[5]" "rightLegFK.sy";
connectAttr "_rightLeg.uv[6]" "rightLegFK.sx";
connectAttr "_rightLeg.av[4]" "rightLegFK.rz";
connectAttr "_rightLeg.av[5]" "rightLegFK.ry";
connectAttr "_rightLeg.av[6]" "rightLegFK.rx";
connectAttr "_rightLeg.lv[4]" "rightLegFK.tz";
connectAttr "_rightLeg.lv[5]" "rightLegFK.ty";
connectAttr "_rightLeg.lv[6]" "rightLegFK.tx";
connectAttr "rightLegFK.s" "rightFootFK.is";
connectAttr "_rightLeg.uv[7]" "rightFootFK.sz";
connectAttr "_rightLeg.uv[8]" "rightFootFK.sy";
connectAttr "_rightLeg.uv[9]" "rightFootFK.sx";
connectAttr "_rightLeg.av[7]" "rightFootFK.rz";
connectAttr "_rightLeg.av[8]" "rightFootFK.ry";
connectAttr "_rightLeg.av[9]" "rightFootFK.rx";
connectAttr "_rightLeg.lv[7]" "rightFootFK.tz";
connectAttr "_rightLeg.lv[8]" "rightFootFK.ty";
connectAttr "_rightLeg.lv[9]" "rightFootFK.tx";
connectAttr "rightFootFK.s" "rightToeBaseFK.is";
connectAttr "_rightLeg.uv[10]" "rightToeBaseFK.sz";
connectAttr "_rightLeg.uv[11]" "rightToeBaseFK.sy";
connectAttr "_rightLeg.uv[12]" "rightToeBaseFK.sx";
connectAttr "_rightLeg.av[10]" "rightToeBaseFK.rz";
connectAttr "_rightLeg.av[11]" "rightToeBaseFK.ry";
connectAttr "_rightLeg.av[12]" "rightToeBaseFK.rx";
connectAttr "_rightLeg.lv[10]" "rightToeBaseFK.tz";
connectAttr "_rightLeg.lv[11]" "rightToeBaseFK.ty";
connectAttr "_rightLeg.lv[12]" "rightToeBaseFK.tx";
connectAttr "rightToeBaseFK.s" "joint59FK.is";
connectAttr "_rightFootIndex.uv[1]" "joint59FK.sz";
connectAttr "_rightFootIndex.uv[2]" "joint59FK.sy";
connectAttr "_rightFootIndex.uv[3]" "joint59FK.sx";
connectAttr "_rightFootIndex.av[1]" "joint59FK.rz";
connectAttr "_rightFootIndex.av[2]" "joint59FK.ry";
connectAttr "_rightFootIndex.av[3]" "joint59FK.rx";
connectAttr "_rightFootIndex.lv[1]" "joint59FK.tz";
connectAttr "_rightFootIndex.lv[2]" "joint59FK.ty";
connectAttr "_rightFootIndex.lv[3]" "joint59FK.tx";
connectAttr "joint59FK.s" "joint60FK.is";
connectAttr "_rightFootIndex.uv[4]" "joint60FK.sz";
connectAttr "_rightFootIndex.uv[5]" "joint60FK.sy";
connectAttr "_rightFootIndex.uv[6]" "joint60FK.sx";
connectAttr "_rightFootIndex.av[4]" "joint60FK.rz";
connectAttr "_rightFootIndex.av[5]" "joint60FK.ry";
connectAttr "_rightFootIndex.av[6]" "joint60FK.rx";
connectAttr "_rightFootIndex.lv[4]" "joint60FK.tz";
connectAttr "_rightFootIndex.lv[5]" "joint60FK.ty";
connectAttr "_rightFootIndex.lv[6]" "joint60FK.tx";
connectAttr "joint60FK.s" "joint61FK.is";
connectAttr "_rightFootIndex.uv[7]" "joint61FK.sz";
connectAttr "_rightFootIndex.uv[8]" "joint61FK.sy";
connectAttr "_rightFootIndex.uv[9]" "joint61FK.sx";
connectAttr "_rightFootIndex.av[7]" "joint61FK.rz";
connectAttr "_rightFootIndex.av[8]" "joint61FK.ry";
connectAttr "_rightFootIndex.av[9]" "joint61FK.rx";
connectAttr "_rightFootIndex.lv[7]" "joint61FK.tz";
connectAttr "_rightFootIndex.lv[8]" "joint61FK.ty";
connectAttr "_rightFootIndex.lv[9]" "joint61FK.tx";
connectAttr "rightToeBaseFK.s" "joint62FK.is";
connectAttr "_rightFootMiddle.uv[1]" "joint62FK.sz";
connectAttr "_rightFootMiddle.uv[2]" "joint62FK.sy";
connectAttr "_rightFootMiddle.uv[3]" "joint62FK.sx";
connectAttr "_rightFootMiddle.av[1]" "joint62FK.rz";
connectAttr "_rightFootMiddle.av[2]" "joint62FK.ry";
connectAttr "_rightFootMiddle.av[3]" "joint62FK.rx";
connectAttr "_rightFootMiddle.lv[1]" "joint62FK.tz";
connectAttr "_rightFootMiddle.lv[2]" "joint62FK.ty";
connectAttr "_rightFootMiddle.lv[3]" "joint62FK.tx";
connectAttr "joint62FK.s" "joint63FK.is";
connectAttr "_rightFootMiddle.uv[4]" "joint63FK.sz";
connectAttr "_rightFootMiddle.uv[5]" "joint63FK.sy";
connectAttr "_rightFootMiddle.uv[6]" "joint63FK.sx";
connectAttr "_rightFootMiddle.av[4]" "joint63FK.rz";
connectAttr "_rightFootMiddle.av[5]" "joint63FK.ry";
connectAttr "_rightFootMiddle.av[6]" "joint63FK.rx";
connectAttr "_rightFootMiddle.lv[4]" "joint63FK.tz";
connectAttr "_rightFootMiddle.lv[5]" "joint63FK.ty";
connectAttr "_rightFootMiddle.lv[6]" "joint63FK.tx";
connectAttr "joint63FK.s" "joint64FK.is";
connectAttr "_rightFootMiddle.uv[7]" "joint64FK.sz";
connectAttr "_rightFootMiddle.uv[8]" "joint64FK.sy";
connectAttr "_rightFootMiddle.uv[9]" "joint64FK.sx";
connectAttr "_rightFootMiddle.av[7]" "joint64FK.rz";
connectAttr "_rightFootMiddle.av[8]" "joint64FK.ry";
connectAttr "_rightFootMiddle.av[9]" "joint64FK.rx";
connectAttr "_rightFootMiddle.lv[7]" "joint64FK.tz";
connectAttr "_rightFootMiddle.lv[8]" "joint64FK.ty";
connectAttr "_rightFootMiddle.lv[9]" "joint64FK.tx";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "plasticSG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "CAMELUNASG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "CAMEYESG.msg" "lightLinker1.lnk[4].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[5].llnk";
connectAttr "Material__1SG.msg" "lightLinker1.lnk[5].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[0].sllk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.slnk[0].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[1].sllk";
connectAttr ":initialParticleSE.msg" "lightLinker1.slnk[1].solk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "plastic.oc" "plasticSG.ss";
connectAttr "plasticSG.msg" "materialInfo1.sg";
connectAttr "plastic.msg" "materialInfo1.m";
connectAttr "file1.oc" "CAMELUNA.c";
connectAttr "CAMELUNA.oc" "CAMELUNASG.ss";
connectAttr "CAMELUNASG.msg" "materialInfo2.sg";
connectAttr "CAMELUNA.msg" "materialInfo2.m";
connectAttr "file1.msg" "materialInfo2.t" -na;
connectAttr "CAMEYE.oc" "CAMEYESG.ss";
connectAttr "CAMEYESG.msg" "materialInfo3.sg";
connectAttr "CAMEYE.msg" "materialInfo3.m";
connectAttr "CAMEYE.msg" "materialInfo3.t" -na;
connectAttr "file2.oc" "Material__1.c";
connectAttr "Material__1.oc" "Material__1SG.ss";
connectAttr "Material__1SG.msg" "materialInfo4.sg";
connectAttr "Material__1.msg" "materialInfo4.m";
connectAttr "file2.msg" "materialInfo4.t" -na;
connectAttr "_leftArm.msg" "fbikCharacter.dnsm[0]";
connectAttr "_rightArm.msg" "fbikCharacter.dnsm[1]";
connectAttr "_leftLeg.msg" "fbikCharacter.dnsm[2]";
connectAttr "_rightLeg.msg" "fbikCharacter.dnsm[3]";
connectAttr "_spine.msg" "fbikCharacter.dnsm[4]";
connectAttr "_head.msg" "fbikCharacter.dnsm[5]";
connectAttr "_hips.msg" "fbikCharacter.dnsm[6]";
connectAttr "_rightFingerMiddle.msg" "fbikCharacter.dnsm[7]";
connectAttr "_rightFingerIndex.msg" "fbikCharacter.dnsm[8]";
connectAttr "_leftFingerMiddle.msg" "fbikCharacter.dnsm[9]";
connectAttr "_leftFingerIndex.msg" "fbikCharacter.dnsm[10]";
connectAttr "_leftFootIndex.msg" "fbikCharacter.dnsm[11]";
connectAttr "_leftFootMiddle.msg" "fbikCharacter.dnsm[12]";
connectAttr "_rightFootIndex.msg" "fbikCharacter.dnsm[13]";
connectAttr "_rightFootMiddle.msg" "fbikCharacter.dnsm[14]";
connectAttr "leftCollarFK.sz" "_leftArm.dnsm[0]";
connectAttr "leftCollarFK.sy" "_leftArm.dnsm[1]";
connectAttr "leftCollarFK.sx" "_leftArm.dnsm[2]";
connectAttr "leftCollarFK.rz" "_leftArm.dnsm[3]";
connectAttr "leftCollarFK.ry" "_leftArm.dnsm[4]";
connectAttr "leftCollarFK.rx" "_leftArm.dnsm[5]";
connectAttr "leftCollarFK.tz" "_leftArm.dnsm[6]";
connectAttr "leftCollarFK.ty" "_leftArm.dnsm[7]";
connectAttr "leftCollarFK.tx" "_leftArm.dnsm[8]";
connectAttr "leftArmFK.sz" "_leftArm.dnsm[9]";
connectAttr "leftArmFK.sy" "_leftArm.dnsm[10]";
connectAttr "leftArmFK.sx" "_leftArm.dnsm[11]";
connectAttr "leftArmFK.rz" "_leftArm.dnsm[12]";
connectAttr "leftArmFK.ry" "_leftArm.dnsm[13]";
connectAttr "leftArmFK.rx" "_leftArm.dnsm[14]";
connectAttr "leftArmFK.tz" "_leftArm.dnsm[15]";
connectAttr "leftArmFK.ty" "_leftArm.dnsm[16]";
connectAttr "leftArmFK.tx" "_leftArm.dnsm[17]";
connectAttr "leftForeArmFK.sz" "_leftArm.dnsm[18]";
connectAttr "leftForeArmFK.sy" "_leftArm.dnsm[19]";
connectAttr "leftForeArmFK.sx" "_leftArm.dnsm[20]";
connectAttr "leftForeArmFK.rz" "_leftArm.dnsm[21]";
connectAttr "leftForeArmFK.ry" "_leftArm.dnsm[22]";
connectAttr "leftForeArmFK.rx" "_leftArm.dnsm[23]";
connectAttr "leftForeArmFK.tz" "_leftArm.dnsm[24]";
connectAttr "leftForeArmFK.ty" "_leftArm.dnsm[25]";
connectAttr "leftForeArmFK.tx" "_leftArm.dnsm[26]";
connectAttr "leftHandFK.sz" "_leftArm.dnsm[27]";
connectAttr "leftHandFK.sy" "_leftArm.dnsm[28]";
connectAttr "leftHandFK.sx" "_leftArm.dnsm[29]";
connectAttr "leftHandFK.rz" "_leftArm.dnsm[30]";
connectAttr "leftHandFK.ry" "_leftArm.dnsm[31]";
connectAttr "leftHandFK.rx" "_leftArm.dnsm[32]";
connectAttr "leftHandFK.tz" "_leftArm.dnsm[33]";
connectAttr "leftHandFK.ty" "_leftArm.dnsm[34]";
connectAttr "leftHandFK.tx" "_leftArm.dnsm[35]";
connectAttr "leftFingerBaseFK.sz" "_leftArm.dnsm[36]";
connectAttr "leftFingerBaseFK.sy" "_leftArm.dnsm[37]";
connectAttr "leftFingerBaseFK.sx" "_leftArm.dnsm[38]";
connectAttr "leftFingerBaseFK.rz" "_leftArm.dnsm[39]";
connectAttr "leftFingerBaseFK.ry" "_leftArm.dnsm[40]";
connectAttr "leftFingerBaseFK.rx" "_leftArm.dnsm[41]";
connectAttr "leftFingerBaseFK.tz" "_leftArm.dnsm[42]";
connectAttr "leftFingerBaseFK.ty" "_leftArm.dnsm[43]";
connectAttr "leftFingerBaseFK.tx" "_leftArm.dnsm[44]";
connectAttr "LeftHandEff.rr" "_leftArm.dnsm[45]";
connectAttr "LeftHandEff.rt" "_leftArm.dnsm[46]";
connectAttr "LeftHandEff.rz" "_leftArm.dnsm[47]";
connectAttr "LeftHandEff.ry" "_leftArm.dnsm[48]";
connectAttr "LeftHandEff.rx" "_leftArm.dnsm[49]";
connectAttr "LeftHandEff.tz" "_leftArm.dnsm[50]";
connectAttr "LeftHandEff.ty" "_leftArm.dnsm[51]";
connectAttr "LeftHandEff.tx" "_leftArm.dnsm[52]";
connectAttr "LeftForeArmEff.rr" "_leftArm.dnsm[53]";
connectAttr "LeftForeArmEff.rt" "_leftArm.dnsm[54]";
connectAttr "LeftForeArmEff.rz" "_leftArm.dnsm[55]";
connectAttr "LeftForeArmEff.ry" "_leftArm.dnsm[56]";
connectAttr "LeftForeArmEff.rx" "_leftArm.dnsm[57]";
connectAttr "LeftForeArmEff.tz" "_leftArm.dnsm[58]";
connectAttr "LeftForeArmEff.ty" "_leftArm.dnsm[59]";
connectAttr "LeftForeArmEff.tx" "_leftArm.dnsm[60]";
connectAttr "LeftArmEff.rr" "_leftArm.dnsm[61]";
connectAttr "LeftArmEff.rt" "_leftArm.dnsm[62]";
connectAttr "LeftArmEff.rz" "_leftArm.dnsm[63]";
connectAttr "LeftArmEff.ry" "_leftArm.dnsm[64]";
connectAttr "LeftArmEff.rx" "_leftArm.dnsm[65]";
connectAttr "LeftArmEff.tz" "_leftArm.dnsm[66]";
connectAttr "LeftArmEff.ty" "_leftArm.dnsm[67]";
connectAttr "LeftArmEff.tx" "_leftArm.dnsm[68]";
connectAttr "LeftFingerBaseEff.rr" "_leftArm.dnsm[69]";
connectAttr "LeftFingerBaseEff.rt" "_leftArm.dnsm[70]";
connectAttr "LeftFingerBaseEff.rz" "_leftArm.dnsm[71]";
connectAttr "LeftFingerBaseEff.ry" "_leftArm.dnsm[72]";
connectAttr "LeftFingerBaseEff.rx" "_leftArm.dnsm[73]";
connectAttr "LeftFingerBaseEff.tz" "_leftArm.dnsm[74]";
connectAttr "LeftFingerBaseEff.ty" "_leftArm.dnsm[75]";
connectAttr "LeftFingerBaseEff.tx" "_leftArm.dnsm[76]";
connectAttr "rightCollarFK.sz" "_rightArm.dnsm[0]";
connectAttr "rightCollarFK.sy" "_rightArm.dnsm[1]";
connectAttr "rightCollarFK.sx" "_rightArm.dnsm[2]";
connectAttr "rightCollarFK.rz" "_rightArm.dnsm[3]";
connectAttr "rightCollarFK.ry" "_rightArm.dnsm[4]";
connectAttr "rightCollarFK.rx" "_rightArm.dnsm[5]";
connectAttr "rightCollarFK.tz" "_rightArm.dnsm[6]";
connectAttr "rightCollarFK.ty" "_rightArm.dnsm[7]";
connectAttr "rightCollarFK.tx" "_rightArm.dnsm[8]";
connectAttr "rightArmFK.sz" "_rightArm.dnsm[9]";
connectAttr "rightArmFK.sy" "_rightArm.dnsm[10]";
connectAttr "rightArmFK.sx" "_rightArm.dnsm[11]";
connectAttr "rightArmFK.rz" "_rightArm.dnsm[12]";
connectAttr "rightArmFK.ry" "_rightArm.dnsm[13]";
connectAttr "rightArmFK.rx" "_rightArm.dnsm[14]";
connectAttr "rightArmFK.tz" "_rightArm.dnsm[15]";
connectAttr "rightArmFK.ty" "_rightArm.dnsm[16]";
connectAttr "rightArmFK.tx" "_rightArm.dnsm[17]";
connectAttr "rightForeArmFK.sz" "_rightArm.dnsm[18]";
connectAttr "rightForeArmFK.sy" "_rightArm.dnsm[19]";
connectAttr "rightForeArmFK.sx" "_rightArm.dnsm[20]";
connectAttr "rightForeArmFK.rz" "_rightArm.dnsm[21]";
connectAttr "rightForeArmFK.ry" "_rightArm.dnsm[22]";
connectAttr "rightForeArmFK.rx" "_rightArm.dnsm[23]";
connectAttr "rightForeArmFK.tz" "_rightArm.dnsm[24]";
connectAttr "rightForeArmFK.ty" "_rightArm.dnsm[25]";
connectAttr "rightForeArmFK.tx" "_rightArm.dnsm[26]";
connectAttr "rightHandFK.sz" "_rightArm.dnsm[27]";
connectAttr "rightHandFK.sy" "_rightArm.dnsm[28]";
connectAttr "rightHandFK.sx" "_rightArm.dnsm[29]";
connectAttr "rightHandFK.rz" "_rightArm.dnsm[30]";
connectAttr "rightHandFK.ry" "_rightArm.dnsm[31]";
connectAttr "rightHandFK.rx" "_rightArm.dnsm[32]";
connectAttr "rightHandFK.tz" "_rightArm.dnsm[33]";
connectAttr "rightHandFK.ty" "_rightArm.dnsm[34]";
connectAttr "rightHandFK.tx" "_rightArm.dnsm[35]";
connectAttr "rightFingerBaseFK.sz" "_rightArm.dnsm[36]";
connectAttr "rightFingerBaseFK.sy" "_rightArm.dnsm[37]";
connectAttr "rightFingerBaseFK.sx" "_rightArm.dnsm[38]";
connectAttr "rightFingerBaseFK.rz" "_rightArm.dnsm[39]";
connectAttr "rightFingerBaseFK.ry" "_rightArm.dnsm[40]";
connectAttr "rightFingerBaseFK.rx" "_rightArm.dnsm[41]";
connectAttr "rightFingerBaseFK.tz" "_rightArm.dnsm[42]";
connectAttr "rightFingerBaseFK.ty" "_rightArm.dnsm[43]";
connectAttr "rightFingerBaseFK.tx" "_rightArm.dnsm[44]";
connectAttr "RightHandEff.rr" "_rightArm.dnsm[45]";
connectAttr "RightHandEff.rt" "_rightArm.dnsm[46]";
connectAttr "RightHandEff.rz" "_rightArm.dnsm[47]";
connectAttr "RightHandEff.ry" "_rightArm.dnsm[48]";
connectAttr "RightHandEff.rx" "_rightArm.dnsm[49]";
connectAttr "RightHandEff.tz" "_rightArm.dnsm[50]";
connectAttr "RightHandEff.ty" "_rightArm.dnsm[51]";
connectAttr "RightHandEff.tx" "_rightArm.dnsm[52]";
connectAttr "RightForeArmEff.rr" "_rightArm.dnsm[53]";
connectAttr "RightForeArmEff.rt" "_rightArm.dnsm[54]";
connectAttr "RightForeArmEff.rz" "_rightArm.dnsm[55]";
connectAttr "RightForeArmEff.ry" "_rightArm.dnsm[56]";
connectAttr "RightForeArmEff.rx" "_rightArm.dnsm[57]";
connectAttr "RightForeArmEff.tz" "_rightArm.dnsm[58]";
connectAttr "RightForeArmEff.ty" "_rightArm.dnsm[59]";
connectAttr "RightForeArmEff.tx" "_rightArm.dnsm[60]";
connectAttr "RightArmEff.rr" "_rightArm.dnsm[61]";
connectAttr "RightArmEff.rt" "_rightArm.dnsm[62]";
connectAttr "RightArmEff.rz" "_rightArm.dnsm[63]";
connectAttr "RightArmEff.ry" "_rightArm.dnsm[64]";
connectAttr "RightArmEff.rx" "_rightArm.dnsm[65]";
connectAttr "RightArmEff.tz" "_rightArm.dnsm[66]";
connectAttr "RightArmEff.ty" "_rightArm.dnsm[67]";
connectAttr "RightArmEff.tx" "_rightArm.dnsm[68]";
connectAttr "RightFingerBaseEff.rr" "_rightArm.dnsm[69]";
connectAttr "RightFingerBaseEff.rt" "_rightArm.dnsm[70]";
connectAttr "RightFingerBaseEff.rz" "_rightArm.dnsm[71]";
connectAttr "RightFingerBaseEff.ry" "_rightArm.dnsm[72]";
connectAttr "RightFingerBaseEff.rx" "_rightArm.dnsm[73]";
connectAttr "RightFingerBaseEff.tz" "_rightArm.dnsm[74]";
connectAttr "RightFingerBaseEff.ty" "_rightArm.dnsm[75]";
connectAttr "RightFingerBaseEff.tx" "_rightArm.dnsm[76]";
connectAttr "leftUpLegFK.sz" "_leftLeg.dnsm[0]";
connectAttr "leftUpLegFK.sy" "_leftLeg.dnsm[1]";
connectAttr "leftUpLegFK.sx" "_leftLeg.dnsm[2]";
connectAttr "leftUpLegFK.rz" "_leftLeg.dnsm[3]";
connectAttr "leftUpLegFK.ry" "_leftLeg.dnsm[4]";
connectAttr "leftUpLegFK.rx" "_leftLeg.dnsm[5]";
connectAttr "leftUpLegFK.tz" "_leftLeg.dnsm[6]";
connectAttr "leftUpLegFK.ty" "_leftLeg.dnsm[7]";
connectAttr "leftUpLegFK.tx" "_leftLeg.dnsm[8]";
connectAttr "leftLegFK.sz" "_leftLeg.dnsm[9]";
connectAttr "leftLegFK.sy" "_leftLeg.dnsm[10]";
connectAttr "leftLegFK.sx" "_leftLeg.dnsm[11]";
connectAttr "leftLegFK.rz" "_leftLeg.dnsm[12]";
connectAttr "leftLegFK.ry" "_leftLeg.dnsm[13]";
connectAttr "leftLegFK.rx" "_leftLeg.dnsm[14]";
connectAttr "leftLegFK.tz" "_leftLeg.dnsm[15]";
connectAttr "leftLegFK.ty" "_leftLeg.dnsm[16]";
connectAttr "leftLegFK.tx" "_leftLeg.dnsm[17]";
connectAttr "leftFootFK.sz" "_leftLeg.dnsm[18]";
connectAttr "leftFootFK.sy" "_leftLeg.dnsm[19]";
connectAttr "leftFootFK.sx" "_leftLeg.dnsm[20]";
connectAttr "leftFootFK.rz" "_leftLeg.dnsm[21]";
connectAttr "leftFootFK.ry" "_leftLeg.dnsm[22]";
connectAttr "leftFootFK.rx" "_leftLeg.dnsm[23]";
connectAttr "leftFootFK.tz" "_leftLeg.dnsm[24]";
connectAttr "leftFootFK.ty" "_leftLeg.dnsm[25]";
connectAttr "leftFootFK.tx" "_leftLeg.dnsm[26]";
connectAttr "leftToeBaseFK.sz" "_leftLeg.dnsm[27]";
connectAttr "leftToeBaseFK.sy" "_leftLeg.dnsm[28]";
connectAttr "leftToeBaseFK.sx" "_leftLeg.dnsm[29]";
connectAttr "leftToeBaseFK.rz" "_leftLeg.dnsm[30]";
connectAttr "leftToeBaseFK.ry" "_leftLeg.dnsm[31]";
connectAttr "leftToeBaseFK.rx" "_leftLeg.dnsm[32]";
connectAttr "leftToeBaseFK.tz" "_leftLeg.dnsm[33]";
connectAttr "leftToeBaseFK.ty" "_leftLeg.dnsm[34]";
connectAttr "leftToeBaseFK.tx" "_leftLeg.dnsm[35]";
connectAttr "LeftFootEff.rr" "_leftLeg.dnsm[36]";
connectAttr "LeftFootEff.rt" "_leftLeg.dnsm[37]";
connectAttr "LeftFootEff.rz" "_leftLeg.dnsm[38]";
connectAttr "LeftFootEff.ry" "_leftLeg.dnsm[39]";
connectAttr "LeftFootEff.rx" "_leftLeg.dnsm[40]";
connectAttr "LeftFootEff.tz" "_leftLeg.dnsm[41]";
connectAttr "LeftFootEff.ty" "_leftLeg.dnsm[42]";
connectAttr "LeftFootEff.tx" "_leftLeg.dnsm[43]";
connectAttr "LeftLegEff.rr" "_leftLeg.dnsm[44]";
connectAttr "LeftLegEff.rt" "_leftLeg.dnsm[45]";
connectAttr "LeftLegEff.rz" "_leftLeg.dnsm[46]";
connectAttr "LeftLegEff.ry" "_leftLeg.dnsm[47]";
connectAttr "LeftLegEff.rx" "_leftLeg.dnsm[48]";
connectAttr "LeftLegEff.tz" "_leftLeg.dnsm[49]";
connectAttr "LeftLegEff.ty" "_leftLeg.dnsm[50]";
connectAttr "LeftLegEff.tx" "_leftLeg.dnsm[51]";
connectAttr "LeftToeBaseEff.rr" "_leftLeg.dnsm[52]";
connectAttr "LeftToeBaseEff.rt" "_leftLeg.dnsm[53]";
connectAttr "LeftToeBaseEff.rz" "_leftLeg.dnsm[54]";
connectAttr "LeftToeBaseEff.ry" "_leftLeg.dnsm[55]";
connectAttr "LeftToeBaseEff.rx" "_leftLeg.dnsm[56]";
connectAttr "LeftToeBaseEff.tz" "_leftLeg.dnsm[57]";
connectAttr "LeftToeBaseEff.ty" "_leftLeg.dnsm[58]";
connectAttr "LeftToeBaseEff.tx" "_leftLeg.dnsm[59]";
connectAttr "LeftUpLegEff.rr" "_leftLeg.dnsm[60]";
connectAttr "LeftUpLegEff.rt" "_leftLeg.dnsm[61]";
connectAttr "LeftUpLegEff.rz" "_leftLeg.dnsm[62]";
connectAttr "LeftUpLegEff.ry" "_leftLeg.dnsm[63]";
connectAttr "LeftUpLegEff.rx" "_leftLeg.dnsm[64]";
connectAttr "LeftUpLegEff.tz" "_leftLeg.dnsm[65]";
connectAttr "LeftUpLegEff.ty" "_leftLeg.dnsm[66]";
connectAttr "LeftUpLegEff.tx" "_leftLeg.dnsm[67]";
connectAttr "rightUpLegFK.sz" "_rightLeg.dnsm[0]";
connectAttr "rightUpLegFK.sy" "_rightLeg.dnsm[1]";
connectAttr "rightUpLegFK.sx" "_rightLeg.dnsm[2]";
connectAttr "rightUpLegFK.rz" "_rightLeg.dnsm[3]";
connectAttr "rightUpLegFK.ry" "_rightLeg.dnsm[4]";
connectAttr "rightUpLegFK.rx" "_rightLeg.dnsm[5]";
connectAttr "rightUpLegFK.tz" "_rightLeg.dnsm[6]";
connectAttr "rightUpLegFK.ty" "_rightLeg.dnsm[7]";
connectAttr "rightUpLegFK.tx" "_rightLeg.dnsm[8]";
connectAttr "rightLegFK.sz" "_rightLeg.dnsm[9]";
connectAttr "rightLegFK.sy" "_rightLeg.dnsm[10]";
connectAttr "rightLegFK.sx" "_rightLeg.dnsm[11]";
connectAttr "rightLegFK.rz" "_rightLeg.dnsm[12]";
connectAttr "rightLegFK.ry" "_rightLeg.dnsm[13]";
connectAttr "rightLegFK.rx" "_rightLeg.dnsm[14]";
connectAttr "rightLegFK.tz" "_rightLeg.dnsm[15]";
connectAttr "rightLegFK.ty" "_rightLeg.dnsm[16]";
connectAttr "rightLegFK.tx" "_rightLeg.dnsm[17]";
connectAttr "rightFootFK.sz" "_rightLeg.dnsm[18]";
connectAttr "rightFootFK.sy" "_rightLeg.dnsm[19]";
connectAttr "rightFootFK.sx" "_rightLeg.dnsm[20]";
connectAttr "rightFootFK.rz" "_rightLeg.dnsm[21]";
connectAttr "rightFootFK.ry" "_rightLeg.dnsm[22]";
connectAttr "rightFootFK.rx" "_rightLeg.dnsm[23]";
connectAttr "rightFootFK.tz" "_rightLeg.dnsm[24]";
connectAttr "rightFootFK.ty" "_rightLeg.dnsm[25]";
connectAttr "rightFootFK.tx" "_rightLeg.dnsm[26]";
connectAttr "rightToeBaseFK.sz" "_rightLeg.dnsm[27]";
connectAttr "rightToeBaseFK.sy" "_rightLeg.dnsm[28]";
connectAttr "rightToeBaseFK.sx" "_rightLeg.dnsm[29]";
connectAttr "rightToeBaseFK.rz" "_rightLeg.dnsm[30]";
connectAttr "rightToeBaseFK.ry" "_rightLeg.dnsm[31]";
connectAttr "rightToeBaseFK.rx" "_rightLeg.dnsm[32]";
connectAttr "rightToeBaseFK.tz" "_rightLeg.dnsm[33]";
connectAttr "rightToeBaseFK.ty" "_rightLeg.dnsm[34]";
connectAttr "rightToeBaseFK.tx" "_rightLeg.dnsm[35]";
connectAttr "RightFootEff.rr" "_rightLeg.dnsm[36]";
connectAttr "RightFootEff.rt" "_rightLeg.dnsm[37]";
connectAttr "RightFootEff.rz" "_rightLeg.dnsm[38]";
connectAttr "RightFootEff.ry" "_rightLeg.dnsm[39]";
connectAttr "RightFootEff.rx" "_rightLeg.dnsm[40]";
connectAttr "RightFootEff.tz" "_rightLeg.dnsm[41]";
connectAttr "RightFootEff.ty" "_rightLeg.dnsm[42]";
connectAttr "RightFootEff.tx" "_rightLeg.dnsm[43]";
connectAttr "RightLegEff.rr" "_rightLeg.dnsm[44]";
connectAttr "RightLegEff.rt" "_rightLeg.dnsm[45]";
connectAttr "RightLegEff.rz" "_rightLeg.dnsm[46]";
connectAttr "RightLegEff.ry" "_rightLeg.dnsm[47]";
connectAttr "RightLegEff.rx" "_rightLeg.dnsm[48]";
connectAttr "RightLegEff.tz" "_rightLeg.dnsm[49]";
connectAttr "RightLegEff.ty" "_rightLeg.dnsm[50]";
connectAttr "RightLegEff.tx" "_rightLeg.dnsm[51]";
connectAttr "RightToeBaseEff.rr" "_rightLeg.dnsm[52]";
connectAttr "RightToeBaseEff.rt" "_rightLeg.dnsm[53]";
connectAttr "RightToeBaseEff.rz" "_rightLeg.dnsm[54]";
connectAttr "RightToeBaseEff.ry" "_rightLeg.dnsm[55]";
connectAttr "RightToeBaseEff.rx" "_rightLeg.dnsm[56]";
connectAttr "RightToeBaseEff.tz" "_rightLeg.dnsm[57]";
connectAttr "RightToeBaseEff.ty" "_rightLeg.dnsm[58]";
connectAttr "RightToeBaseEff.tx" "_rightLeg.dnsm[59]";
connectAttr "RightUpLegEff.rr" "_rightLeg.dnsm[60]";
connectAttr "RightUpLegEff.rt" "_rightLeg.dnsm[61]";
connectAttr "RightUpLegEff.rz" "_rightLeg.dnsm[62]";
connectAttr "RightUpLegEff.ry" "_rightLeg.dnsm[63]";
connectAttr "RightUpLegEff.rx" "_rightLeg.dnsm[64]";
connectAttr "RightUpLegEff.tz" "_rightLeg.dnsm[65]";
connectAttr "RightUpLegEff.ty" "_rightLeg.dnsm[66]";
connectAttr "RightUpLegEff.tx" "_rightLeg.dnsm[67]";
connectAttr "spineFK.sz" "_spine.dnsm[0]";
connectAttr "spineFK.sy" "_spine.dnsm[1]";
connectAttr "spineFK.sx" "_spine.dnsm[2]";
connectAttr "spineFK.rz" "_spine.dnsm[3]";
connectAttr "spineFK.ry" "_spine.dnsm[4]";
connectAttr "spineFK.rx" "_spine.dnsm[5]";
connectAttr "spineFK.tz" "_spine.dnsm[6]";
connectAttr "spineFK.ty" "_spine.dnsm[7]";
connectAttr "spineFK.tx" "_spine.dnsm[8]";
connectAttr "spine1FK.sz" "_spine.dnsm[9]";
connectAttr "spine1FK.sy" "_spine.dnsm[10]";
connectAttr "spine1FK.sx" "_spine.dnsm[11]";
connectAttr "spine1FK.rz" "_spine.dnsm[12]";
connectAttr "spine1FK.ry" "_spine.dnsm[13]";
connectAttr "spine1FK.rx" "_spine.dnsm[14]";
connectAttr "spine1FK.tz" "_spine.dnsm[15]";
connectAttr "spine1FK.ty" "_spine.dnsm[16]";
connectAttr "spine1FK.tx" "_spine.dnsm[17]";
connectAttr "spine2FK.sz" "_spine.dnsm[18]";
connectAttr "spine2FK.sy" "_spine.dnsm[19]";
connectAttr "spine2FK.sx" "_spine.dnsm[20]";
connectAttr "spine2FK.rz" "_spine.dnsm[21]";
connectAttr "spine2FK.ry" "_spine.dnsm[22]";
connectAttr "spine2FK.rx" "_spine.dnsm[23]";
connectAttr "spine2FK.tz" "_spine.dnsm[24]";
connectAttr "spine2FK.ty" "_spine.dnsm[25]";
connectAttr "spine2FK.tx" "_spine.dnsm[26]";
connectAttr "SpineEff.rr" "_spine.dnsm[27]";
connectAttr "SpineEff.rt" "_spine.dnsm[28]";
connectAttr "SpineEff.rz" "_spine.dnsm[29]";
connectAttr "SpineEff.ry" "_spine.dnsm[30]";
connectAttr "SpineEff.rx" "_spine.dnsm[31]";
connectAttr "SpineEff.tz" "_spine.dnsm[32]";
connectAttr "SpineEff.ty" "_spine.dnsm[33]";
connectAttr "SpineEff.tx" "_spine.dnsm[34]";
connectAttr "NeckEff.rr" "_spine.dnsm[35]";
connectAttr "NeckEff.rt" "_spine.dnsm[36]";
connectAttr "NeckEff.rz" "_spine.dnsm[37]";
connectAttr "NeckEff.ry" "_spine.dnsm[38]";
connectAttr "NeckEff.rx" "_spine.dnsm[39]";
connectAttr "NeckEff.tz" "_spine.dnsm[40]";
connectAttr "NeckEff.ty" "_spine.dnsm[41]";
connectAttr "NeckEff.tx" "_spine.dnsm[42]";
connectAttr "neckFK.sz" "_head.dnsm[0]";
connectAttr "neckFK.sy" "_head.dnsm[1]";
connectAttr "neckFK.sx" "_head.dnsm[2]";
connectAttr "neckFK.rz" "_head.dnsm[3]";
connectAttr "neckFK.ry" "_head.dnsm[4]";
connectAttr "neckFK.rx" "_head.dnsm[5]";
connectAttr "neckFK.tz" "_head.dnsm[6]";
connectAttr "neckFK.ty" "_head.dnsm[7]";
connectAttr "neckFK.tx" "_head.dnsm[8]";
connectAttr "neck1FK.sz" "_head.dnsm[9]";
connectAttr "neck1FK.sy" "_head.dnsm[10]";
connectAttr "neck1FK.sx" "_head.dnsm[11]";
connectAttr "neck1FK.rz" "_head.dnsm[12]";
connectAttr "neck1FK.ry" "_head.dnsm[13]";
connectAttr "neck1FK.rx" "_head.dnsm[14]";
connectAttr "neck1FK.tz" "_head.dnsm[15]";
connectAttr "neck1FK.ty" "_head.dnsm[16]";
connectAttr "neck1FK.tx" "_head.dnsm[17]";
connectAttr "neck2FK.sz" "_head.dnsm[18]";
connectAttr "neck2FK.sy" "_head.dnsm[19]";
connectAttr "neck2FK.sx" "_head.dnsm[20]";
connectAttr "neck2FK.rz" "_head.dnsm[21]";
connectAttr "neck2FK.ry" "_head.dnsm[22]";
connectAttr "neck2FK.rx" "_head.dnsm[23]";
connectAttr "neck2FK.tz" "_head.dnsm[24]";
connectAttr "neck2FK.ty" "_head.dnsm[25]";
connectAttr "neck2FK.tx" "_head.dnsm[26]";
connectAttr "neck3FK.sz" "_head.dnsm[27]";
connectAttr "neck3FK.sy" "_head.dnsm[28]";
connectAttr "neck3FK.sx" "_head.dnsm[29]";
connectAttr "neck3FK.rz" "_head.dnsm[30]";
connectAttr "neck3FK.ry" "_head.dnsm[31]";
connectAttr "neck3FK.rx" "_head.dnsm[32]";
connectAttr "neck3FK.tz" "_head.dnsm[33]";
connectAttr "neck3FK.ty" "_head.dnsm[34]";
connectAttr "neck3FK.tx" "_head.dnsm[35]";
connectAttr "neck4FK.sz" "_head.dnsm[36]";
connectAttr "neck4FK.sy" "_head.dnsm[37]";
connectAttr "neck4FK.sx" "_head.dnsm[38]";
connectAttr "neck4FK.rz" "_head.dnsm[39]";
connectAttr "neck4FK.ry" "_head.dnsm[40]";
connectAttr "neck4FK.rx" "_head.dnsm[41]";
connectAttr "neck4FK.tz" "_head.dnsm[42]";
connectAttr "neck4FK.ty" "_head.dnsm[43]";
connectAttr "neck4FK.tx" "_head.dnsm[44]";
connectAttr "neck5FK.sz" "_head.dnsm[45]";
connectAttr "neck5FK.sy" "_head.dnsm[46]";
connectAttr "neck5FK.sx" "_head.dnsm[47]";
connectAttr "neck5FK.rz" "_head.dnsm[48]";
connectAttr "neck5FK.ry" "_head.dnsm[49]";
connectAttr "neck5FK.rx" "_head.dnsm[50]";
connectAttr "neck5FK.tz" "_head.dnsm[51]";
connectAttr "neck5FK.ty" "_head.dnsm[52]";
connectAttr "neck5FK.tx" "_head.dnsm[53]";
connectAttr "neck6FK.sz" "_head.dnsm[54]";
connectAttr "neck6FK.sy" "_head.dnsm[55]";
connectAttr "neck6FK.sx" "_head.dnsm[56]";
connectAttr "neck6FK.rz" "_head.dnsm[57]";
connectAttr "neck6FK.ry" "_head.dnsm[58]";
connectAttr "neck6FK.rx" "_head.dnsm[59]";
connectAttr "neck6FK.tz" "_head.dnsm[60]";
connectAttr "neck6FK.ty" "_head.dnsm[61]";
connectAttr "neck6FK.tx" "_head.dnsm[62]";
connectAttr "headFK.sz" "_head.dnsm[63]";
connectAttr "headFK.sy" "_head.dnsm[64]";
connectAttr "headFK.sx" "_head.dnsm[65]";
connectAttr "headFK.rz" "_head.dnsm[66]";
connectAttr "headFK.ry" "_head.dnsm[67]";
connectAttr "headFK.rx" "_head.dnsm[68]";
connectAttr "headFK.tz" "_head.dnsm[69]";
connectAttr "headFK.ty" "_head.dnsm[70]";
connectAttr "headFK.tx" "_head.dnsm[71]";
connectAttr "HeadEff.rr" "_head.dnsm[72]";
connectAttr "HeadEff.rt" "_head.dnsm[73]";
connectAttr "HeadEff.rz" "_head.dnsm[74]";
connectAttr "HeadEff.ry" "_head.dnsm[75]";
connectAttr "HeadEff.rx" "_head.dnsm[76]";
connectAttr "HeadEff.tz" "_head.dnsm[77]";
connectAttr "HeadEff.ty" "_head.dnsm[78]";
connectAttr "HeadEff.tx" "_head.dnsm[79]";
connectAttr "hipsFK.sz" "_hips.dnsm[0]";
connectAttr "hipsFK.sy" "_hips.dnsm[1]";
connectAttr "hipsFK.sx" "_hips.dnsm[2]";
connectAttr "hipsFK.rz" "_hips.dnsm[3]";
connectAttr "hipsFK.ry" "_hips.dnsm[4]";
connectAttr "hipsFK.rx" "_hips.dnsm[5]";
connectAttr "hipsFK.tz" "_hips.dnsm[6]";
connectAttr "hipsFK.ty" "_hips.dnsm[7]";
connectAttr "hipsFK.tx" "_hips.dnsm[8]";
connectAttr "HipsEff.rr" "_hips.dnsm[9]";
connectAttr "HipsEff.rt" "_hips.dnsm[10]";
connectAttr "HipsEff.rz" "_hips.dnsm[11]";
connectAttr "HipsEff.ry" "_hips.dnsm[12]";
connectAttr "HipsEff.rx" "_hips.dnsm[13]";
connectAttr "HipsEff.tz" "_hips.dnsm[14]";
connectAttr "HipsEff.ty" "_hips.dnsm[15]";
connectAttr "HipsEff.tx" "_hips.dnsm[16]";
connectAttr "joint49FK.sz" "_rightFingerMiddle.dnsm[0]";
connectAttr "joint49FK.sy" "_rightFingerMiddle.dnsm[1]";
connectAttr "joint49FK.sx" "_rightFingerMiddle.dnsm[2]";
connectAttr "joint49FK.rz" "_rightFingerMiddle.dnsm[3]";
connectAttr "joint49FK.ry" "_rightFingerMiddle.dnsm[4]";
connectAttr "joint49FK.rx" "_rightFingerMiddle.dnsm[5]";
connectAttr "joint49FK.tz" "_rightFingerMiddle.dnsm[6]";
connectAttr "joint49FK.ty" "_rightFingerMiddle.dnsm[7]";
connectAttr "joint49FK.tx" "_rightFingerMiddle.dnsm[8]";
connectAttr "joint50FK.sz" "_rightFingerMiddle.dnsm[9]";
connectAttr "joint50FK.sy" "_rightFingerMiddle.dnsm[10]";
connectAttr "joint50FK.sx" "_rightFingerMiddle.dnsm[11]";
connectAttr "joint50FK.rz" "_rightFingerMiddle.dnsm[12]";
connectAttr "joint50FK.ry" "_rightFingerMiddle.dnsm[13]";
connectAttr "joint50FK.rx" "_rightFingerMiddle.dnsm[14]";
connectAttr "joint50FK.tz" "_rightFingerMiddle.dnsm[15]";
connectAttr "joint50FK.ty" "_rightFingerMiddle.dnsm[16]";
connectAttr "joint50FK.tx" "_rightFingerMiddle.dnsm[17]";
connectAttr "joint51FK.sz" "_rightFingerMiddle.dnsm[18]";
connectAttr "joint51FK.sy" "_rightFingerMiddle.dnsm[19]";
connectAttr "joint51FK.sx" "_rightFingerMiddle.dnsm[20]";
connectAttr "joint51FK.rz" "_rightFingerMiddle.dnsm[21]";
connectAttr "joint51FK.ry" "_rightFingerMiddle.dnsm[22]";
connectAttr "joint51FK.rx" "_rightFingerMiddle.dnsm[23]";
connectAttr "joint51FK.tz" "_rightFingerMiddle.dnsm[24]";
connectAttr "joint51FK.ty" "_rightFingerMiddle.dnsm[25]";
connectAttr "joint51FK.tx" "_rightFingerMiddle.dnsm[26]";
connectAttr "RightHandMiddle1Eff.rr" "_rightFingerMiddle.dnsm[27]";
connectAttr "RightHandMiddle1Eff.rt" "_rightFingerMiddle.dnsm[28]";
connectAttr "RightHandMiddle1Eff.rz" "_rightFingerMiddle.dnsm[29]";
connectAttr "RightHandMiddle1Eff.ry" "_rightFingerMiddle.dnsm[30]";
connectAttr "RightHandMiddle1Eff.rx" "_rightFingerMiddle.dnsm[31]";
connectAttr "RightHandMiddle1Eff.tz" "_rightFingerMiddle.dnsm[32]";
connectAttr "RightHandMiddle1Eff.ty" "_rightFingerMiddle.dnsm[33]";
connectAttr "RightHandMiddle1Eff.tx" "_rightFingerMiddle.dnsm[34]";
connectAttr "joint52FK.sz" "_rightFingerIndex.dnsm[0]";
connectAttr "joint52FK.sy" "_rightFingerIndex.dnsm[1]";
connectAttr "joint52FK.sx" "_rightFingerIndex.dnsm[2]";
connectAttr "joint52FK.rz" "_rightFingerIndex.dnsm[3]";
connectAttr "joint52FK.ry" "_rightFingerIndex.dnsm[4]";
connectAttr "joint52FK.rx" "_rightFingerIndex.dnsm[5]";
connectAttr "joint52FK.tz" "_rightFingerIndex.dnsm[6]";
connectAttr "joint52FK.ty" "_rightFingerIndex.dnsm[7]";
connectAttr "joint52FK.tx" "_rightFingerIndex.dnsm[8]";
connectAttr "joint53FK.sz" "_rightFingerIndex.dnsm[9]";
connectAttr "joint53FK.sy" "_rightFingerIndex.dnsm[10]";
connectAttr "joint53FK.sx" "_rightFingerIndex.dnsm[11]";
connectAttr "joint53FK.rz" "_rightFingerIndex.dnsm[12]";
connectAttr "joint53FK.ry" "_rightFingerIndex.dnsm[13]";
connectAttr "joint53FK.rx" "_rightFingerIndex.dnsm[14]";
connectAttr "joint53FK.tz" "_rightFingerIndex.dnsm[15]";
connectAttr "joint53FK.ty" "_rightFingerIndex.dnsm[16]";
connectAttr "joint53FK.tx" "_rightFingerIndex.dnsm[17]";
connectAttr "joint54FK.sz" "_rightFingerIndex.dnsm[18]";
connectAttr "joint54FK.sy" "_rightFingerIndex.dnsm[19]";
connectAttr "joint54FK.sx" "_rightFingerIndex.dnsm[20]";
connectAttr "joint54FK.rz" "_rightFingerIndex.dnsm[21]";
connectAttr "joint54FK.ry" "_rightFingerIndex.dnsm[22]";
connectAttr "joint54FK.rx" "_rightFingerIndex.dnsm[23]";
connectAttr "joint54FK.tz" "_rightFingerIndex.dnsm[24]";
connectAttr "joint54FK.ty" "_rightFingerIndex.dnsm[25]";
connectAttr "joint54FK.tx" "_rightFingerIndex.dnsm[26]";
connectAttr "RightHandIndex1Eff.rr" "_rightFingerIndex.dnsm[27]";
connectAttr "RightHandIndex1Eff.rt" "_rightFingerIndex.dnsm[28]";
connectAttr "RightHandIndex1Eff.rz" "_rightFingerIndex.dnsm[29]";
connectAttr "RightHandIndex1Eff.ry" "_rightFingerIndex.dnsm[30]";
connectAttr "RightHandIndex1Eff.rx" "_rightFingerIndex.dnsm[31]";
connectAttr "RightHandIndex1Eff.tz" "_rightFingerIndex.dnsm[32]";
connectAttr "RightHandIndex1Eff.ty" "_rightFingerIndex.dnsm[33]";
connectAttr "RightHandIndex1Eff.tx" "_rightFingerIndex.dnsm[34]";
connectAttr "joint12FK.sz" "_leftFingerMiddle.dnsm[0]";
connectAttr "joint12FK.sy" "_leftFingerMiddle.dnsm[1]";
connectAttr "joint12FK.sx" "_leftFingerMiddle.dnsm[2]";
connectAttr "joint12FK.rz" "_leftFingerMiddle.dnsm[3]";
connectAttr "joint12FK.ry" "_leftFingerMiddle.dnsm[4]";
connectAttr "joint12FK.rx" "_leftFingerMiddle.dnsm[5]";
connectAttr "joint12FK.tz" "_leftFingerMiddle.dnsm[6]";
connectAttr "joint12FK.ty" "_leftFingerMiddle.dnsm[7]";
connectAttr "joint12FK.tx" "_leftFingerMiddle.dnsm[8]";
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.sz" "_leftFingerMiddle.dnsm[9]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.sy" "_leftFingerMiddle.dnsm[10]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.sx" "_leftFingerMiddle.dnsm[11]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.rz" "_leftFingerMiddle.dnsm[12]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.ry" "_leftFingerMiddle.dnsm[13]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.rx" "_leftFingerMiddle.dnsm[14]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.tz" "_leftFingerMiddle.dnsm[15]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.ty" "_leftFingerMiddle.dnsm[16]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK.tx" "_leftFingerMiddle.dnsm[17]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.sz" "_leftFingerMiddle.dnsm[18]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.sy" "_leftFingerMiddle.dnsm[19]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.sx" "_leftFingerMiddle.dnsm[20]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.rz" "_leftFingerMiddle.dnsm[21]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.ry" "_leftFingerMiddle.dnsm[22]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.rx" "_leftFingerMiddle.dnsm[23]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.tz" "_leftFingerMiddle.dnsm[24]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.ty" "_leftFingerMiddle.dnsm[25]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint12FK|joint40FK|joint41FK.tx" "_leftFingerMiddle.dnsm[26]"
		;
connectAttr "LeftHandMiddle1Eff.rr" "_leftFingerMiddle.dnsm[27]";
connectAttr "LeftHandMiddle1Eff.rt" "_leftFingerMiddle.dnsm[28]";
connectAttr "LeftHandMiddle1Eff.rz" "_leftFingerMiddle.dnsm[29]";
connectAttr "LeftHandMiddle1Eff.ry" "_leftFingerMiddle.dnsm[30]";
connectAttr "LeftHandMiddle1Eff.rx" "_leftFingerMiddle.dnsm[31]";
connectAttr "LeftHandMiddle1Eff.tz" "_leftFingerMiddle.dnsm[32]";
connectAttr "LeftHandMiddle1Eff.ty" "_leftFingerMiddle.dnsm[33]";
connectAttr "LeftHandMiddle1Eff.tx" "_leftFingerMiddle.dnsm[34]";
connectAttr "joint42FK.sz" "_leftFingerIndex.dnsm[0]";
connectAttr "joint42FK.sy" "_leftFingerIndex.dnsm[1]";
connectAttr "joint42FK.sx" "_leftFingerIndex.dnsm[2]";
connectAttr "joint42FK.rz" "_leftFingerIndex.dnsm[3]";
connectAttr "joint42FK.ry" "_leftFingerIndex.dnsm[4]";
connectAttr "joint42FK.rx" "_leftFingerIndex.dnsm[5]";
connectAttr "joint42FK.tz" "_leftFingerIndex.dnsm[6]";
connectAttr "joint42FK.ty" "_leftFingerIndex.dnsm[7]";
connectAttr "joint42FK.tx" "_leftFingerIndex.dnsm[8]";
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.sz" "_leftFingerIndex.dnsm[9]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.sy" "_leftFingerIndex.dnsm[10]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.sx" "_leftFingerIndex.dnsm[11]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.rz" "_leftFingerIndex.dnsm[12]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.ry" "_leftFingerIndex.dnsm[13]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.rx" "_leftFingerIndex.dnsm[14]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.tz" "_leftFingerIndex.dnsm[15]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.ty" "_leftFingerIndex.dnsm[16]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK.tx" "_leftFingerIndex.dnsm[17]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.sz" "_leftFingerIndex.dnsm[18]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.sy" "_leftFingerIndex.dnsm[19]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.sx" "_leftFingerIndex.dnsm[20]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.rz" "_leftFingerIndex.dnsm[21]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.ry" "_leftFingerIndex.dnsm[22]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.rx" "_leftFingerIndex.dnsm[23]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.tz" "_leftFingerIndex.dnsm[24]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.ty" "_leftFingerIndex.dnsm[25]"
		;
connectAttr "|humanIK2|hipsFK|spineFK|spine1FK|spine2FK|leftCollarFK|leftArmFK|leftForeArmFK|leftHandFK|leftFingerBaseFK|joint42FK|joint40FK|joint41FK.tx" "_leftFingerIndex.dnsm[26]"
		;
connectAttr "LeftHandIndex1Eff.rr" "_leftFingerIndex.dnsm[27]";
connectAttr "LeftHandIndex1Eff.rt" "_leftFingerIndex.dnsm[28]";
connectAttr "LeftHandIndex1Eff.rz" "_leftFingerIndex.dnsm[29]";
connectAttr "LeftHandIndex1Eff.ry" "_leftFingerIndex.dnsm[30]";
connectAttr "LeftHandIndex1Eff.rx" "_leftFingerIndex.dnsm[31]";
connectAttr "LeftHandIndex1Eff.tz" "_leftFingerIndex.dnsm[32]";
connectAttr "LeftHandIndex1Eff.ty" "_leftFingerIndex.dnsm[33]";
connectAttr "LeftHandIndex1Eff.tx" "_leftFingerIndex.dnsm[34]";
connectAttr "joint43FK.sz" "_leftFootIndex.dnsm[0]";
connectAttr "joint43FK.sy" "_leftFootIndex.dnsm[1]";
connectAttr "joint43FK.sx" "_leftFootIndex.dnsm[2]";
connectAttr "joint43FK.rz" "_leftFootIndex.dnsm[3]";
connectAttr "joint43FK.ry" "_leftFootIndex.dnsm[4]";
connectAttr "joint43FK.rx" "_leftFootIndex.dnsm[5]";
connectAttr "joint43FK.tz" "_leftFootIndex.dnsm[6]";
connectAttr "joint43FK.ty" "_leftFootIndex.dnsm[7]";
connectAttr "joint43FK.tx" "_leftFootIndex.dnsm[8]";
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.sz" "_leftFootIndex.dnsm[9]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.sy" "_leftFootIndex.dnsm[10]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.sx" "_leftFootIndex.dnsm[11]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.rz" "_leftFootIndex.dnsm[12]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.ry" "_leftFootIndex.dnsm[13]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.rx" "_leftFootIndex.dnsm[14]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.tz" "_leftFootIndex.dnsm[15]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.ty" "_leftFootIndex.dnsm[16]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK.tx" "_leftFootIndex.dnsm[17]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.sz" "_leftFootIndex.dnsm[18]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.sy" "_leftFootIndex.dnsm[19]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.sx" "_leftFootIndex.dnsm[20]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.rz" "_leftFootIndex.dnsm[21]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.ry" "_leftFootIndex.dnsm[22]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.rx" "_leftFootIndex.dnsm[23]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.tz" "_leftFootIndex.dnsm[24]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.ty" "_leftFootIndex.dnsm[25]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint43FK|joint40FK|joint41FK.tx" "_leftFootIndex.dnsm[26]"
		;
connectAttr "LeftFootIndex1Eff.rr" "_leftFootIndex.dnsm[27]";
connectAttr "LeftFootIndex1Eff.rt" "_leftFootIndex.dnsm[28]";
connectAttr "LeftFootIndex1Eff.rz" "_leftFootIndex.dnsm[29]";
connectAttr "LeftFootIndex1Eff.ry" "_leftFootIndex.dnsm[30]";
connectAttr "LeftFootIndex1Eff.rx" "_leftFootIndex.dnsm[31]";
connectAttr "LeftFootIndex1Eff.tz" "_leftFootIndex.dnsm[32]";
connectAttr "LeftFootIndex1Eff.ty" "_leftFootIndex.dnsm[33]";
connectAttr "LeftFootIndex1Eff.tx" "_leftFootIndex.dnsm[34]";
connectAttr "joint44FK.sz" "_leftFootMiddle.dnsm[0]";
connectAttr "joint44FK.sy" "_leftFootMiddle.dnsm[1]";
connectAttr "joint44FK.sx" "_leftFootMiddle.dnsm[2]";
connectAttr "joint44FK.rz" "_leftFootMiddle.dnsm[3]";
connectAttr "joint44FK.ry" "_leftFootMiddle.dnsm[4]";
connectAttr "joint44FK.rx" "_leftFootMiddle.dnsm[5]";
connectAttr "joint44FK.tz" "_leftFootMiddle.dnsm[6]";
connectAttr "joint44FK.ty" "_leftFootMiddle.dnsm[7]";
connectAttr "joint44FK.tx" "_leftFootMiddle.dnsm[8]";
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.sz" "_leftFootMiddle.dnsm[9]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.sy" "_leftFootMiddle.dnsm[10]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.sx" "_leftFootMiddle.dnsm[11]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.rz" "_leftFootMiddle.dnsm[12]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.ry" "_leftFootMiddle.dnsm[13]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.rx" "_leftFootMiddle.dnsm[14]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.tz" "_leftFootMiddle.dnsm[15]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.ty" "_leftFootMiddle.dnsm[16]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK.tx" "_leftFootMiddle.dnsm[17]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.sz" "_leftFootMiddle.dnsm[18]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.sy" "_leftFootMiddle.dnsm[19]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.sx" "_leftFootMiddle.dnsm[20]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.rz" "_leftFootMiddle.dnsm[21]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.ry" "_leftFootMiddle.dnsm[22]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.rx" "_leftFootMiddle.dnsm[23]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.tz" "_leftFootMiddle.dnsm[24]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.ty" "_leftFootMiddle.dnsm[25]"
		;
connectAttr "|humanIK2|hipsFK|leftUpLegFK|leftLegFK|leftFootFK|leftToeBaseFK|joint44FK|joint40FK|joint41FK.tx" "_leftFootMiddle.dnsm[26]"
		;
connectAttr "LeftFootMiddle1Eff.rr" "_leftFootMiddle.dnsm[27]";
connectAttr "LeftFootMiddle1Eff.rt" "_leftFootMiddle.dnsm[28]";
connectAttr "LeftFootMiddle1Eff.rz" "_leftFootMiddle.dnsm[29]";
connectAttr "LeftFootMiddle1Eff.ry" "_leftFootMiddle.dnsm[30]";
connectAttr "LeftFootMiddle1Eff.rx" "_leftFootMiddle.dnsm[31]";
connectAttr "LeftFootMiddle1Eff.tz" "_leftFootMiddle.dnsm[32]";
connectAttr "LeftFootMiddle1Eff.ty" "_leftFootMiddle.dnsm[33]";
connectAttr "LeftFootMiddle1Eff.tx" "_leftFootMiddle.dnsm[34]";
connectAttr "joint59FK.sz" "_rightFootIndex.dnsm[0]";
connectAttr "joint59FK.sy" "_rightFootIndex.dnsm[1]";
connectAttr "joint59FK.sx" "_rightFootIndex.dnsm[2]";
connectAttr "joint59FK.rz" "_rightFootIndex.dnsm[3]";
connectAttr "joint59FK.ry" "_rightFootIndex.dnsm[4]";
connectAttr "joint59FK.rx" "_rightFootIndex.dnsm[5]";
connectAttr "joint59FK.tz" "_rightFootIndex.dnsm[6]";
connectAttr "joint59FK.ty" "_rightFootIndex.dnsm[7]";
connectAttr "joint59FK.tx" "_rightFootIndex.dnsm[8]";
connectAttr "joint60FK.sz" "_rightFootIndex.dnsm[9]";
connectAttr "joint60FK.sy" "_rightFootIndex.dnsm[10]";
connectAttr "joint60FK.sx" "_rightFootIndex.dnsm[11]";
connectAttr "joint60FK.rz" "_rightFootIndex.dnsm[12]";
connectAttr "joint60FK.ry" "_rightFootIndex.dnsm[13]";
connectAttr "joint60FK.rx" "_rightFootIndex.dnsm[14]";
connectAttr "joint60FK.tz" "_rightFootIndex.dnsm[15]";
connectAttr "joint60FK.ty" "_rightFootIndex.dnsm[16]";
connectAttr "joint60FK.tx" "_rightFootIndex.dnsm[17]";
connectAttr "joint61FK.sz" "_rightFootIndex.dnsm[18]";
connectAttr "joint61FK.sy" "_rightFootIndex.dnsm[19]";
connectAttr "joint61FK.sx" "_rightFootIndex.dnsm[20]";
connectAttr "joint61FK.rz" "_rightFootIndex.dnsm[21]";
connectAttr "joint61FK.ry" "_rightFootIndex.dnsm[22]";
connectAttr "joint61FK.rx" "_rightFootIndex.dnsm[23]";
connectAttr "joint61FK.tz" "_rightFootIndex.dnsm[24]";
connectAttr "joint61FK.ty" "_rightFootIndex.dnsm[25]";
connectAttr "joint61FK.tx" "_rightFootIndex.dnsm[26]";
connectAttr "RightFootIndex1Eff.rr" "_rightFootIndex.dnsm[27]";
connectAttr "RightFootIndex1Eff.rt" "_rightFootIndex.dnsm[28]";
connectAttr "RightFootIndex1Eff.rz" "_rightFootIndex.dnsm[29]";
connectAttr "RightFootIndex1Eff.ry" "_rightFootIndex.dnsm[30]";
connectAttr "RightFootIndex1Eff.rx" "_rightFootIndex.dnsm[31]";
connectAttr "RightFootIndex1Eff.tz" "_rightFootIndex.dnsm[32]";
connectAttr "RightFootIndex1Eff.ty" "_rightFootIndex.dnsm[33]";
connectAttr "RightFootIndex1Eff.tx" "_rightFootIndex.dnsm[34]";
connectAttr "joint62FK.sz" "_rightFootMiddle.dnsm[0]";
connectAttr "joint62FK.sy" "_rightFootMiddle.dnsm[1]";
connectAttr "joint62FK.sx" "_rightFootMiddle.dnsm[2]";
connectAttr "joint62FK.rz" "_rightFootMiddle.dnsm[3]";
connectAttr "joint62FK.ry" "_rightFootMiddle.dnsm[4]";
connectAttr "joint62FK.rx" "_rightFootMiddle.dnsm[5]";
connectAttr "joint62FK.tz" "_rightFootMiddle.dnsm[6]";
connectAttr "joint62FK.ty" "_rightFootMiddle.dnsm[7]";
connectAttr "joint62FK.tx" "_rightFootMiddle.dnsm[8]";
connectAttr "joint63FK.sz" "_rightFootMiddle.dnsm[9]";
connectAttr "joint63FK.sy" "_rightFootMiddle.dnsm[10]";
connectAttr "joint63FK.sx" "_rightFootMiddle.dnsm[11]";
connectAttr "joint63FK.rz" "_rightFootMiddle.dnsm[12]";
connectAttr "joint63FK.ry" "_rightFootMiddle.dnsm[13]";
connectAttr "joint63FK.rx" "_rightFootMiddle.dnsm[14]";
connectAttr "joint63FK.tz" "_rightFootMiddle.dnsm[15]";
connectAttr "joint63FK.ty" "_rightFootMiddle.dnsm[16]";
connectAttr "joint63FK.tx" "_rightFootMiddle.dnsm[17]";
connectAttr "joint64FK.sz" "_rightFootMiddle.dnsm[18]";
connectAttr "joint64FK.sy" "_rightFootMiddle.dnsm[19]";
connectAttr "joint64FK.sx" "_rightFootMiddle.dnsm[20]";
connectAttr "joint64FK.rz" "_rightFootMiddle.dnsm[21]";
connectAttr "joint64FK.ry" "_rightFootMiddle.dnsm[22]";
connectAttr "joint64FK.rx" "_rightFootMiddle.dnsm[23]";
connectAttr "joint64FK.tz" "_rightFootMiddle.dnsm[24]";
connectAttr "joint64FK.ty" "_rightFootMiddle.dnsm[25]";
connectAttr "joint64FK.tx" "_rightFootMiddle.dnsm[26]";
connectAttr "RightFootMiddle1Eff.rr" "_rightFootMiddle.dnsm[27]";
connectAttr "RightFootMiddle1Eff.rt" "_rightFootMiddle.dnsm[28]";
connectAttr "RightFootMiddle1Eff.rz" "_rightFootMiddle.dnsm[29]";
connectAttr "RightFootMiddle1Eff.ry" "_rightFootMiddle.dnsm[30]";
connectAttr "RightFootMiddle1Eff.rx" "_rightFootMiddle.dnsm[31]";
connectAttr "RightFootMiddle1Eff.tz" "_rightFootMiddle.dnsm[32]";
connectAttr "RightFootMiddle1Eff.ty" "_rightFootMiddle.dnsm[33]";
connectAttr "RightFootMiddle1Eff.tx" "_rightFootMiddle.dnsm[34]";
connectAttr "camel_group.msg" "hikStancePose.m[0]";
connectAttr "hips.msg" "hikStancePose.m[1]";
connectAttr "spine.msg" "hikStancePose.m[2]";
connectAttr "spine1.msg" "hikStancePose.m[3]";
connectAttr "spine2.msg" "hikStancePose.m[4]";
connectAttr "neck.msg" "hikStancePose.m[5]";
connectAttr "neck1.msg" "hikStancePose.m[6]";
connectAttr "neck2.msg" "hikStancePose.m[7]";
connectAttr "neck3.msg" "hikStancePose.m[8]";
connectAttr "neck4.msg" "hikStancePose.m[9]";
connectAttr "neck5.msg" "hikStancePose.m[10]";
connectAttr "neck6.msg" "hikStancePose.m[11]";
connectAttr "head.msg" "hikStancePose.m[12]";
connectAttr "manidlbe.msg" "hikStancePose.m[13]";
connectAttr "ramus.msg" "hikStancePose.m[14]";
connectAttr "lower_dent.msg" "hikStancePose.m[15]";
connectAttr "forehead.msg" "hikStancePose.m[16]";
connectAttr "maxilla.msg" "hikStancePose.m[17]";
connectAttr "upperdent.msg" "hikStancePose.m[18]";
connectAttr "rightCollar.msg" "hikStancePose.m[19]";
connectAttr "rightArm.msg" "hikStancePose.m[20]";
connectAttr "rightForeArm.msg" "hikStancePose.m[21]";
connectAttr "rightHand.msg" "hikStancePose.m[22]";
connectAttr "rightFingerBase.msg" "hikStancePose.m[23]";
connectAttr "joint49.msg" "hikStancePose.m[24]";
connectAttr "joint50.msg" "hikStancePose.m[25]";
connectAttr "joint51.msg" "hikStancePose.m[26]";
connectAttr "joint52.msg" "hikStancePose.m[27]";
connectAttr "joint53.msg" "hikStancePose.m[28]";
connectAttr "joint54.msg" "hikStancePose.m[29]";
connectAttr "leftCollar.msg" "hikStancePose.m[30]";
connectAttr "leftArm.msg" "hikStancePose.m[31]";
connectAttr "leftForeArm.msg" "hikStancePose.m[32]";
connectAttr "leftHand.msg" "hikStancePose.m[33]";
connectAttr "leftFingerBase.msg" "hikStancePose.m[34]";
connectAttr "joint12.msg" "hikStancePose.m[35]";
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40.msg" "hikStancePose.m[36]"
		;
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint12|joint40|joint41.msg" "hikStancePose.m[37]"
		;
connectAttr "joint42.msg" "hikStancePose.m[38]";
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40.msg" "hikStancePose.m[39]"
		;
connectAttr "|camel_group|hips|spine|spine1|spine2|leftCollar|leftArm|leftForeArm|leftHand|leftFingerBase|joint42|joint40|joint41.msg" "hikStancePose.m[40]"
		;
connectAttr "leftUpLeg.msg" "hikStancePose.m[41]";
connectAttr "leftLeg.msg" "hikStancePose.m[42]";
connectAttr "leftFoot.msg" "hikStancePose.m[43]";
connectAttr "leftToeBase.msg" "hikStancePose.m[44]";
connectAttr "joint43.msg" "hikStancePose.m[45]";
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40.msg" "hikStancePose.m[46]"
		;
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint43|joint40|joint41.msg" "hikStancePose.m[47]"
		;
connectAttr "joint44.msg" "hikStancePose.m[48]";
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40.msg" "hikStancePose.m[49]"
		;
connectAttr "|camel_group|hips|leftUpLeg|leftLeg|leftFoot|leftToeBase|joint44|joint40|joint41.msg" "hikStancePose.m[50]"
		;
connectAttr "joint7.msg" "hikStancePose.m[51]";
connectAttr "rightUpLeg.msg" "hikStancePose.m[52]";
connectAttr "rightLeg.msg" "hikStancePose.m[53]";
connectAttr "rightFoot.msg" "hikStancePose.m[54]";
connectAttr "rightToeBase.msg" "hikStancePose.m[55]";
connectAttr "joint59.msg" "hikStancePose.m[56]";
connectAttr "joint60.msg" "hikStancePose.m[57]";
connectAttr "joint61.msg" "hikStancePose.m[58]";
connectAttr "joint62.msg" "hikStancePose.m[59]";
connectAttr "joint63.msg" "hikStancePose.m[60]";
connectAttr "joint64.msg" "hikStancePose.m[61]";
connectAttr "joint65.msg" "hikStancePose.m[62]";
connectAttr "taile1.msg" "hikStancePose.m[63]";
connectAttr "tail2.msg" "hikStancePose.m[64]";
connectAttr "tail3.msg" "hikStancePose.m[65]";
connectAttr "tail4.msg" "hikStancePose.m[66]";
connectAttr "tail5.msg" "hikStancePose.m[67]";
connectAttr "tail6.msg" "hikStancePose.m[68]";
connectAttr "tail7.msg" "hikStancePose.m[69]";
connectAttr "hikStancePose.w" "hikStancePose.p[0]";
connectAttr "hikStancePose.m[0]" "hikStancePose.p[1]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[2]";
connectAttr "hikStancePose.m[2]" "hikStancePose.p[3]";
connectAttr "hikStancePose.m[3]" "hikStancePose.p[4]";
connectAttr "hikStancePose.m[4]" "hikStancePose.p[5]";
connectAttr "hikStancePose.m[5]" "hikStancePose.p[6]";
connectAttr "hikStancePose.m[6]" "hikStancePose.p[7]";
connectAttr "hikStancePose.m[7]" "hikStancePose.p[8]";
connectAttr "hikStancePose.m[8]" "hikStancePose.p[9]";
connectAttr "hikStancePose.m[9]" "hikStancePose.p[10]";
connectAttr "hikStancePose.m[10]" "hikStancePose.p[11]";
connectAttr "hikStancePose.m[11]" "hikStancePose.p[12]";
connectAttr "hikStancePose.m[12]" "hikStancePose.p[13]";
connectAttr "hikStancePose.m[13]" "hikStancePose.p[14]";
connectAttr "hikStancePose.m[14]" "hikStancePose.p[15]";
connectAttr "hikStancePose.m[12]" "hikStancePose.p[16]";
connectAttr "hikStancePose.m[16]" "hikStancePose.p[17]";
connectAttr "hikStancePose.m[17]" "hikStancePose.p[18]";
connectAttr "hikStancePose.m[4]" "hikStancePose.p[19]";
connectAttr "hikStancePose.m[19]" "hikStancePose.p[20]";
connectAttr "hikStancePose.m[20]" "hikStancePose.p[21]";
connectAttr "hikStancePose.m[21]" "hikStancePose.p[22]";
connectAttr "hikStancePose.m[22]" "hikStancePose.p[23]";
connectAttr "hikStancePose.m[23]" "hikStancePose.p[24]";
connectAttr "hikStancePose.m[24]" "hikStancePose.p[25]";
connectAttr "hikStancePose.m[25]" "hikStancePose.p[26]";
connectAttr "hikStancePose.m[23]" "hikStancePose.p[27]";
connectAttr "hikStancePose.m[27]" "hikStancePose.p[28]";
connectAttr "hikStancePose.m[28]" "hikStancePose.p[29]";
connectAttr "hikStancePose.m[4]" "hikStancePose.p[30]";
connectAttr "hikStancePose.m[30]" "hikStancePose.p[31]";
connectAttr "hikStancePose.m[31]" "hikStancePose.p[32]";
connectAttr "hikStancePose.m[32]" "hikStancePose.p[33]";
connectAttr "hikStancePose.m[33]" "hikStancePose.p[34]";
connectAttr "hikStancePose.m[34]" "hikStancePose.p[35]";
connectAttr "hikStancePose.m[35]" "hikStancePose.p[36]";
connectAttr "hikStancePose.m[36]" "hikStancePose.p[37]";
connectAttr "hikStancePose.m[34]" "hikStancePose.p[38]";
connectAttr "hikStancePose.m[38]" "hikStancePose.p[39]";
connectAttr "hikStancePose.m[39]" "hikStancePose.p[40]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[41]";
connectAttr "hikStancePose.m[41]" "hikStancePose.p[42]";
connectAttr "hikStancePose.m[42]" "hikStancePose.p[43]";
connectAttr "hikStancePose.m[43]" "hikStancePose.p[44]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[45]";
connectAttr "hikStancePose.m[45]" "hikStancePose.p[46]";
connectAttr "hikStancePose.m[46]" "hikStancePose.p[47]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[48]";
connectAttr "hikStancePose.m[48]" "hikStancePose.p[49]";
connectAttr "hikStancePose.m[49]" "hikStancePose.p[50]";
connectAttr "hikStancePose.m[43]" "hikStancePose.p[51]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[52]";
connectAttr "hikStancePose.m[52]" "hikStancePose.p[53]";
connectAttr "hikStancePose.m[53]" "hikStancePose.p[54]";
connectAttr "hikStancePose.m[54]" "hikStancePose.p[55]";
connectAttr "hikStancePose.m[55]" "hikStancePose.p[56]";
connectAttr "hikStancePose.m[56]" "hikStancePose.p[57]";
connectAttr "hikStancePose.m[57]" "hikStancePose.p[58]";
connectAttr "hikStancePose.m[55]" "hikStancePose.p[59]";
connectAttr "hikStancePose.m[59]" "hikStancePose.p[60]";
connectAttr "hikStancePose.m[60]" "hikStancePose.p[61]";
connectAttr "hikStancePose.m[54]" "hikStancePose.p[62]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[63]";
connectAttr "hikStancePose.m[63]" "hikStancePose.p[64]";
connectAttr "hikStancePose.m[64]" "hikStancePose.p[65]";
connectAttr "hikStancePose.m[65]" "hikStancePose.p[66]";
connectAttr "hikStancePose.m[66]" "hikStancePose.p[67]";
connectAttr "hikStancePose.m[67]" "hikStancePose.p[68]";
connectAttr "hikStancePose.m[68]" "hikStancePose.p[69]";
connectAttr "plasticSG.pa" ":renderPartition.st" -na;
connectAttr "CAMELUNASG.pa" ":renderPartition.st" -na;
connectAttr "CAMEYESG.pa" ":renderPartition.st" -na;
connectAttr "Material__1SG.pa" ":renderPartition.st" -na;
connectAttr "plastic.msg" ":defaultShaderList1.s" -na;
connectAttr "CAMELUNA.msg" ":defaultShaderList1.s" -na;
connectAttr "CAMEYE.msg" ":defaultShaderList1.s" -na;
connectAttr "Material__1.msg" ":defaultShaderList1.s" -na;
connectAttr "imagePlane1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "file1.msg" ":defaultTextureList1.tx" -na;
connectAttr "file2.msg" ":defaultTextureList1.tx" -na;
connectAttr "fbikCharacter.pa" ":characterPartition.st" -na;
// End of quadrupedExample.ma
