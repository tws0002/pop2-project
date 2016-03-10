//Maya ASCII 7.0ff10 (Candidate) scene
//Name: bipedExample.ma
//Last modified: Thu, Jun 30, 2005 11:10:35 AM
requires maya "7.0ff10 (Candidate)";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 7.0";
fileInfo "version" "7.0CG";
fileInfo "cutIdentifier" "200506241636-000000";
fileInfo "osv" "Microsoft Windows 2000 Service Pack 3 (Build 2195)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 25.732565541298911 22.030728802707589 28.844871400829916 ;
	setAttr ".r" -type "double3" -21.33835272960237 40.599999999999994 -1.0472391919522108e-015 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.821869662029954;
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
createNode transform -n "JackieSkeleton";
createNode joint -n "hips" -p "JackieSkeleton";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" -5.7220458984375e-006 10.402189254760742 -0.2471792995929718 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.509719131065202e-005 -5.6685618501350117e-006 0.00010442615341665039 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".pa" -type "double3" 2.509719131065202e-005 -5.6685618501350117e-006 0.00010442615341665039 ;
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 10.402306530000001 -0.24717675380000001 1;
	setAttr ".typ" 1;
	setAttr ".radi" 0.25;
	setAttr ".hni" 1;
createNode joint -n "spine" -p "hips";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" -2.1616560104305294e-006 0.69453248303827153 0.23151533145579695 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.4324729274621825e-005 0.00020633297145813259 -3.7216333280767795e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -90 3.3177811683348279 90 ;
	setAttr ".pa" -type "double3" 2.3008595831952151e-005 0.0002146199688653472 -3.5517926583348852e-005 ;
	setAttr ".bps" -type "matrix" 2.2204460492503131e-016 0.99832390412250005 -0.057873849514347611 0
		 -2.2204460492503136e-016 -0.057873849514347597 -0.99832390412250005 0 -1 2.2204460492503136e-016 2.2204460492503131e-016 0
		 -1.7763568394002505e-015 11.096842182675523 -0.01566486957483379 1;
	setAttr ".typ" 6;
	setAttr ".radi" 0.25;
	setAttr ".hni" 8;
createNode joint -n "spine1" -p "spine";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 1.0000712159633236 2.220446049250317e-016 2.220604180454723e-016 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.7252961945928247e-005 7.2317440787253817e-028 3.4473963738895843e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 4.5320554997426923 ;
	setAttr ".pa" -type "double3" 7.9414358233217293e-006 -7.0607408556016302e-006 3.3123848491569839e-005 ;
	setAttr ".bps" -type "matrix" 2.0380507262394247e-016 0.99062941840056773 -0.13657728727483548 0
		 -2.3889559544992879e-016 -0.13657728727483545 -0.99062941840056773 0 -1 2.2204460492503136e-016 2.2204460492503131e-016 0
		 -1.7763568394002509e-015 12.095237183396565 -0.073542840631126039 1;
	setAttr ".typ" 6;
	setAttr ".radi" 0.25;
	setAttr ".hni" 23;
createNode joint -n "xxy" -p "spine1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.99819715057481306 -6.6613381477509412e-016 2.2164429193667621e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 6.1864067998489682 ;
	setAttr ".bps" -type "matrix" 1.7687400156758241e-016 0.97014250014533177 -0.2425356250363333 0
		 -2.5946714767403092e-016 -0.24253562503633327 -0.97014250014533177 0 -1 2.2204460492503136e-016 2.2204460492503131e-016 0
		 -1.7945634885710146e-015 13.084080646119595 -0.20987389962210382 1;
	setAttr ".radi" 0.25;
createNode joint -n "xxx" -p "xxy";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.9559273568014075 -1.332267629550188e-015 7.8886090522101181e-031 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -15.323572409451559 ;
	setAttr ".bps" -type "matrix" 2.3915526151807667e-016 0.99974760221708014 0.022466238252069698 0
		 -2.035003047684373e-016 0.022466238252069726 -0.99974760221708014 0 -1 2.2204460492503136e-016 2.2204460492503131e-016 0
		 -1.6254847917656279e-015 14.011466402004231 -0.44172033859326187 1;
	setAttr ".radi" 0.25;
createNode joint -n "neck" -p "xxx";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 1.0319875409126442 2.4193258305604814e-006 -1.3708578827653639e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 6.4193421135517728e-006 8.4410626883119389e-005 -0.00042141862181141476 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 -17.147619881396871 ;
	setAttr ".pa" -type "double3" 1.0146677804973187e-005 -9.7130571553214479e-005 -0.00010588223593921095 ;
	setAttr ".bps" -type "matrix" 2.8852333591908803e-016 0.9486832980505141 0.31622776601683666 0
		 -1.2394312317651023e-016 0.31622776601683666 -0.9486832980505141 0 -1 2.2204460492503136e-016 2.2204460492503131e-016 0
		 -1.6078269856164801e-015 15.043183055425889 -0.41853569469614582 1;
	setAttr ".typ" 7;
	setAttr ".radi" 0.25;
	setAttr ".hni" 20;
createNode joint -n "head" -p "neck";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.76981107413577221 5.1629445494686619e-007 3.0905332544559977e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -9.2482683711740909e-005 -8.2646057395786577e-005 0.0004600103829294058 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 0 19.34432927212108 ;
	setAttr ".pa" -type "double3" 0 9.0793078802741442e-005 0.00010827170977159086 ;
	setAttr ".bps" -type "matrix" 2.3117925894015529e-016 0.99987404748359876 -0.0158710166267238 0
		 -2.1251767782588616e-016 -0.0158710166267238 -0.99987404748359876 0 -1 2.2204460492503136e-016 2.2204460492503131e-016 0
		 -1.556650265417132e-015 15.773499338185047 -0.17509693377642757 1;
	setAttr ".typ" 8;
	setAttr ".radi" 0.25;
	setAttr ".hni" 15;
createNode joint -n "joint44" -p "head";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 2.1912248385598798 -2.7755575615628933e-016 4.8654965357994392e-016 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 90.909380449199148 89.999999999999986 0 ;
	setAttr ".bps" -type "matrix" 1 -2.7967076743676129e-020 -2.2556867854167078e-016 0
		 1.2478408003968176e-017 1 1.5959455978986625e-016 0 2.0882186082719138e-016 -1.0408340855860843e-016 1 0
		 -1.5366341846475414e-015 17.964448186462509 -0.20987389962210132 1;
	setAttr ".radi" 0.25;
createNode transform -n "jointFlexor2" -p "head";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1.6523241108679088e-016 -1.872556203021291e-031 5.9164567891575885e-031 ;
	setAttr ".r" -type "double3" 90.909380449199148 89.999999999999986 0 ;
	setAttr ".s" -type "double3" 1 0.99999999999999989 0.99999999999999967 ;
createNode clusterFlexorShape -n "jointFlexor_Shape" -p "jointFlexor2";
	setAttr -k off ".v";
createNode transform -n "jointFlexor1" -p "neck";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 9.1593399531575415e-016 -8.8817841970012543e-016 -3.944304526105059e-031 ;
	setAttr ".r" -type "double3" 71.565051177078089 90 0 ;
	setAttr ".s" -type "double3" 1 1.0000000000000002 1.0000000000000004 ;
createNode clusterFlexorShape -n "jointFlexor_Shape" -p "jointFlexor1";
	setAttr -k off ".v";
createNode joint -n "leftShoulder" -p "xxx";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.54561011861420083 -0.42957082332397145 -0.83457044652331891 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -5.3558183875166439e-006 -4.4376722812587361e-005 1.6174495429592392e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 84.93638314696986 -178.71267105847497 ;
	setAttr ".pa" -type "double3" -1.3031413518154747e-006 7.3150442954262284e-006 1.5319891646868932e-005 ;
	setAttr ".bps" -type "matrix" 0.9960973129748617 -0.088261787225621724 -2.5326962749261384e-016 0
		 2.0882186082719138e-016 -3.8857805861880479e-016 1.0000000000000002 0 -0.088261787225621405 -0.99609731297486159 -3.3306690738754696e-016 0
		 0.83456902614244821 14.547287270746217 4.8893444848374656e-011 1;
	setAttr ".sd" 1;
	setAttr ".typ" 9;
	setAttr ".radi" 0.25;
	setAttr ".hni" 18;
createNode joint -n "leftArm" -p "leftShoulder";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 1.35926076244156 -3.6012685089080717e-006 7.5343028012320179e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.5420480388097753 14.994678614051692 5.9355486418791354 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.94771782386212688 -9.736468266255887 -5.5866655706126371 ;
	setAttr ".pa" -type "double3" 1.54303433819421 14.994576439753807 5.9395641069102103 ;
	setAttr ".bps" -type "matrix" 0.96215978067058017 -0.25503399680306987 -0.095949033004994216 0
		 0.09274620854011259 -0.024583688413812421 0.99538624817977417 0 -0.25621611436710123 -0.96661952325546607 8.3242387622070671e-015 0
		 2.1885179863453592 14.427317109715577 4.8892901879926676e-011 1;
	setAttr ".sd" 1;
	setAttr ".typ" 10;
	setAttr ".radi" 0.25;
	setAttr ".hni" 9;
createNode joint -n "leftForearm" -p "leftArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 2.5536523454482603 2.1562394805219043e-006 -3.1310236827675197e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.8196264552277176 13.135673197757983 5.4035767708185212 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -179.83469734692363 11.488601497550388 6.3358343567070525 ;
	setAttr ".pa" -type "double3" 0.82314206223754771 13.135851997095978 5.4196058627255175 ;
	setAttr ".bps" -type "matrix" 0.9981846356911761 -0.058531826156569183 0.014193604082536379 0
		 0.014169264850852514 -0.00083086126290045359 -0.9998992657278778 0 0.058537722911478074 0.9982851972238892 -1.7520707107365752e-015 0
		 4.645533622527207 13.776050521263533 -0.24501988033468874 1;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".radi" 0.25;
	setAttr ".hni" 10;
createNode joint -n "leftForeArmRoll" -p "leftForearm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" 1.3096332755534157 -1.4224732503009818e-016 -1.745348657267165e-015 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.00025428008133138977 0 -6.2061047199174066e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.0064747557664496854 -0.6690341827429056 1.3677513415890747 ;
	setAttr ".pa" -type "double3" -0.00026199037381864258 -1.4463488157450763e-027 -5.0020770376811292e-006 ;
	setAttr ".bps" -type "matrix" 0.99885391620800335 -0.04687443023414458 -0.0096768727469154284 0
		 -0.0096662348323692734 0.00045361914144536209 -0.99995317797076921 0 0.046876625092908943 0.99890068676515553 5.6228225471955523e-012 0
		 5.9527894365745349 13.69939529404998 -0.22643146412816814 1;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".radi" 0.25;
	setAttr ".hni" 46;
createNode joint -n "leftHand" -p "leftForeArmRoll";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 1.2304700725179309 3.8192137138959303e-007 -1.3949583256317455e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.00011244054245813733 0.00036936015733685356 0.0069224980251405164 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".pa" -type "double3" 0.00011240579481574973 0.00020110806360140889 0.0069263067506612529 ;
	setAttr ".bps" -type "matrix" 0.99885391620800335 -0.04687443023414458 -0.0096768727469154284 0
		 -0.0096662348323692734 0.00045361914144536209 -0.99995317797076921 0 0.046876625092908943 0.99890068676515553 5.6228225471955523e-012 0
		 7.1818508935898144 13.641717635099557 -0.23833858200064861 1;
	setAttr ".sd" 1;
	setAttr ".typ" 12;
	setAttr ".radi" 0.25;
	setAttr ".hni" 11;
createNode joint -n "joint13" -p "leftHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.51940462129296938 0.24488286600328671 0.008017347854876837 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 89.512418115039864 -2.6422377248322038 9.9048019709256963 ;
	setAttr ".bps" -type "matrix" 0.98341986288444017 -2.9837243786801082e-015 -0.18134324714295155 0
		 2.2967738821932926e-015 1.0000000000000002 -2.0718561415111747e-015 0 0.18134324714295152 1.5144135945277526e-015 0.98341986288444039 0
		 7.6986689645852531 13.625490457249171 -0.48823619451559197 1;
	setAttr ".sd" 1;
	setAttr ".radi" 0.12;
createNode joint -n "leftHandPinky1" -p "joint13";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.49509122699839037 -1.2047254798197571e-006 -2.0136335114884218e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 6.0197087933159187e-005 0.00014029152968679103 -0.00032315380343088211 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.79248627254340687 -5.2418400152391857 -8.609507213509362 ;
	setAttr ".pa" -type "double3" 6.9617142567152373e-005 0.00013843442993665051 -0.00043354234401065723 ;
	setAttr ".bps" -type "matrix" 0.98483936399181726 -0.14907335732736401 -0.088704911179380092 0
		 0.14847231940530492 0.98882613948820575 -0.013372966584156558 0 0.089707287901277438 -1.9628950457840143e-014 0.99596817343597799 0
		 8.1855590465472403 13.625490457249171 -0.57801903478252625 1;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 66;
createNode joint -n "leftHandPinky2" -p "leftHandPinky1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.35253371388551208 -7.7698379182811195e-006 1.1704975511062088e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -3.1279428991490901e-006 0.00010706392540216096 0.0026904227558156189 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 4.3900382238528959 -8.5204398444350709 -18.817902380977095 ;
	setAttr ".pa" -type "double3" -3.561605779848823e-006 8.9154089409654058e-005 0.0024066478769800971 ;
	setAttr ".bps" -type "matrix" 0.88783799346693493 -0.45498469823670301 0.068794052991985002 0
		 0.45362497381448602 0.8904992556821465 0.035149093321881472 0 -0.077253352603070702 2.4980018054066022e-016 0.9970114941722521 0
		 8.53274415713806 13.57293767357482 -0.60929014916298019 1;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 67;
createNode joint -n "leftHandPinky3" -p "leftHandPinky2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.22470667591721757 9.0161163737723093e-006 4.7055683314312091e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.6182010098419975e-006 -8.0913981406384358e-005 -0.0034822926735602433 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -1.7856481169582707 4.0556061010750124 3.2759726642277558 ;
	setAttr ".pa" -type "double3" 1.3490852559216421e-006 -8.136767282568809e-005 -0.0034867723822247826 ;
	setAttr ".bps" -type "matrix" 0.91548889197840366 -0.40234324732019 7.0776717819853729e-016 0
		 0.40234324732018978 0.91548889197840344 -1.182214048878194e-015 0 -1.7347234759768071e-016 1.3322676295501878e-015 1.0000000000000004 0
		 8.7322504893065638 13.470697930506896 -0.59383141762813962 1;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 68;
createNode joint -n "leftHandPinky4" -p "leftHandPinky3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.13102085387444143 -1.3684133433666812e-005 -1.1382413207361441e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -3.3083358142633614e-005 -1.474153660587204e-005 -2.5751164431600259e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -49.230376299544879 0 0 ;
	setAttr ".pa" -type "double3" -2.4433793164156602e-005 -1.3897357268013983e-005 
		2.4851586313519815e-006 ;
	setAttr ".bps" -type "matrix" 0.91548889197840366 -0.40234324732019 7.0776717819853729e-016 0
		 0.26273785696210289 0.59783180444332318 -0.75734137092529308 0 0.30471118650800622 0.69333761251780146 0.6530191788033477 0
		 8.8522033931535713 13.417980479446408 -0.59383141762813985 1;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 69;
createNode joint -n "joint18" -p "leftHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.54751461523414147 0.074435120713925731 0.025658877582129418 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 89.601150324163441 -2.6570699518893406 7.985562935148586 ;
	setAttr ".bps" -type "matrix" 0.98893635286829762 -4.4478309924045334e-015 -0.14834045293024611 0
		 3.8094527532450684e-015 1 -2.4196681984445245e-015 0 0.14834045293024614 1.7234477733829578e-015 0.98893635286829751 0
		 7.7292213054256802 13.641717635099553 -0.31806844676972934 1;
	setAttr ".sd" 1;
	setAttr ".radi" 0.12;
createNode joint -n "leftHandRing1" -p "joint18";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.5194774117922436 -2.4839132972687139e-008 8.7849545415963348e-008 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 4.3647307850345778e-005 0.00015952208400538473 -0.00028791795460975366 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.027359391595120977 -2.6748635949967352 -0.58623274726902608 ;
	setAttr ".pa" -type "double3" 6.5331355638996756e-005 0.00014666395987034732 -0.00091230348351187924 ;
	setAttr ".bps" -type "matrix" 0.99472992949478245 -0.010220365306295139 -0.10201917221930219 0
		 0.010167034277613732 0.99994777070255325 -0.0010427276691169895 0 0.10202450088730447 -1.4451175762896878e-013 0.99478188625381436 0
		 8.2429447513871921 13.641717635099555 -0.39512696366395661 1;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 62;
createNode joint -n "leftHandRing2" -p "leftHandRing1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.42939404929744313 -1.3800085449933164e-006 -7.2773378803625555e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -2.7683692893139878e-006 -2.8802128802586099e-005 0.0025661971273576328 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.0857111464440858 -4.1150562206136989 -14.208294560116016 ;
	setAttr ".pa" -type "double3" -3.004529855688735e-006 -2.234988282727786e-005 0.0029489796486449307 ;
	setAttr ".bps" -type "matrix" 0.96664715320386485 -0.25468434695296971 -0.027003048346510253 0
		 0.25458503356262296 0.96702424138029719 -0.0071117697360521918 0 0.027923858773145932 6.7438459330770861e-015 0.99961005302628769 0
		 8.6700818431951987 13.637329009619704 -0.43893400237701152 1;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 63;
createNode joint -n "leftHandRing3" -p "leftHandRing2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.21949137769180482 -3.3801237718789068e-006 1.5232805261611304e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0 -7.7589339232919294e-005 -0.0038008232771820235 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.68911954329902558 -3.2854667086624625 2.9020750681194447 ;
	setAttr ".pa" -type "double3" 0 -1.0503444540256557e-005 -0.0024491711817721667 ;
	setAttr ".bps" -type "matrix" 0.97828926128744476 -0.20506054803784005 0.030004881071037354 0
		 0.20496416622455649 0.97874928947019957 0.0062864079927682625 0 -0.030656350297102154 -4.6455894686658894e-015 0.99952998363553935 0
		 8.8822597663538403 13.581426092388334 -0.44486114000745436 1;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 64;
createNode joint -n "leftHandRing4" -p "leftHandRing3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.15831303615023079 2.1887805206066702e-006 -7.3333430306021796e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.1299600123008435e-029 -4.2954149355675231e-006 2.0501390287725984e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 20.342612032574973 -2.2467473586245186 11.833043495233818 ;
	setAttr ".pa" -type "double3" 0 -5.7136664948285675e-006 1.8774116980826644e-006 ;
	setAttr ".bps" -type "matrix" 0.99755978467250961 1.1102230246251565e-016 0.069817447705690802 0
		 -0.024270854563210181 0.93763065217695318 0.3467847829951492 0 -0.065462979025617013 -0.34763308257158321 0.93534263148798613 0
		 9.0371276641308569 13.54896402084333 -0.44011122294467692 1;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 65;
createNode joint -n "joint23" -p "leftHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.94248910686776444 -0.019580657008996027 0.044235322497082952 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0 3.8065078923218739e-006 0.00011242082543260361 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 89.949844774219642 -2.6863495738845837 0.51555048658039349 ;
	setAttr ".bps" -type "matrix" 0.99982600888614936 -4.7184478546569153e-016 -0.018653470315041488 0
		 9.7144514654701197e-017 1.0000000000000002 -9.40328544196678e-016 0 0.018653470315041495 9.1062140467057517e-016 0.99982600888614925 0
		 7.7475685713528808 13.641717635099557 -0.22082793735558598 1;
	setAttr ".sd" 1;
	setAttr ".typ" 13;
	setAttr ".radi" 0.12;
	setAttr ".hni" 21;
createNode joint -n "leftHandMiddle1" -p "joint23";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.11378290993487289 2.6710425384823822e-006 -4.1273421985676961e-008 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 7.8516116138390942e-005 0.00010688460073894832 -0.0021441330929233265 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -0.0035932063936265448 -0.057135031462199316 3.5985772135902039 ;
	setAttr ".pa" -type "double3" 8.625784153986737e-005 0.00010265560145078063 -0.0025212582621618592 ;
	setAttr ".bps" -type "matrix" 0.99787274430240547 0.062765704996420396 -0.017619661026503506 0
		 -0.062755922816286586 0.99802828931664189 0.0011080952910291905 0 0.017654470534765071 -1.5795114544460371e-012 0.99984414769009744 0
		 8.2392752982017505 13.641717635099557 -0.23000157031918483 1;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 58;
createNode joint -n "leftHandMiddle2" -p "leftHandMiddle1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.50586648604588791 -4.1715575349599021e-006 -6.0144826974362076e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -7.4053059366237108e-025 -8.8945795192510712e-005 0.0050869329673870504 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.049340569856368921 -3.8592399095262127 -4.331619126016224 ;
	setAttr ".pa" -type "double3" 0 -8.6583110753047237e-006 0.0083612444810795879 ;
	setAttr ".bps" -type "matrix" 0.99868351264941857 -0.012764666377439074 0.049682037543683125 0
		 0.012748900529869267 0.99991852832731987 0.00063422630567774255 0 -0.049686085552182048 -3.2682190287403046e-015 0.99876488369510752 0
		 8.7440608524664807 13.673468398276864 -0.23891468114218656 1;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 59;
createNode joint -n "leftHandMiddle3" -p "leftHandMiddle2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.21427539292749331 -1.052766005116279e-005 1.7263594446204067e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0 0.00021068508811028101 -9.380670659417464e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -0.54034726148455048 4.5418492631225833 -6.0604948505987029 ;
	setAttr ".pa" -type "double3" 0 8.5149893524672269e-005 -0.0058373275002685252 ;
	setAttr ".bps" -type "matrix" 0.99257599047691492 -0.11789180318488927 -0.029906953549087623 0
		 0.11783832522256554 0.99302644614421809 -0.0035505445956170514 0 0.030116975902516351 -6.5255960357557541e-015 0.99954638099614357 0
		 8.9580687350328461 13.670733058012901 -0.22826831768305658 1;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 60;
createNode joint -n "leftHandMiddle4" -p "leftHandMiddle3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.18001314702111687 1.0533130714751593e-005 -1.2079481691296134e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.0596210776134556e-005 -1.3571549172778295e-005 0 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -79.584001999628185 -0.59166441237289757 6.7704481187159002 ;
	setAttr ".pa" -type "double3" 8.388009009872914e-006 -1.1492151276652432e-005 0 ;
	setAttr ".bps" -type "matrix" 0.9998040846220001 1.5265566588595902e-016 -0.019793745809347379 0
		 -0.019467565232677224 0.18079376885290138 -0.98332834142410219 0 0.0035785859045877333 0.98352102831813604 0.18075834857333653 0
		 9.1367470333150056 13.649510796970333 -0.23365200983179288 1;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 61;
createNode joint -n "joint28" -p "leftHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.56509908721389202 -0.19178286279429754 0.026604941280610639 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 90.091609950545077 -2.6852563189849294 -2.5091087855195151 ;
	setAttr ".bps" -type "matrix" 0.99941941097579901 -2.5326962749261384e-015 0.034071116283264015 0
		 2.2412627309620348e-015 1.0000000000000002 -1.8492152253912764e-015 0 -0.034071116283264008 1.8669961410200386e-015 0.99941941097579901 0
		 7.7494032979456025 13.641717635099553 -0.052033090825376077 1;
	setAttr ".sd" 1;
	setAttr ".radi" 0.12;
createNode joint -n "leftHandIndex1" -p "joint28";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.48465064211162112 6.3483404733055693e-007 6.2469559772174253e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -3.7026529683185502e-025 0.00014064258130008111 -0.001655996647706159 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -0.10539734395803763 -2.9007468517675137 2.0817919723680425 ;
	setAttr ".pa" -type "double3" -1.5316036478532103e-005 0.00013688115221092913 -0.0019257220705732078 ;
	setAttr ".bps" -type "matrix" 0.99575586771338664 0.036279585501672387 0.08458157949688519 0
		 -0.036149408050727271 0.99934167914473948 -0.0030706060892269735 0 -0.084637297995287547 -2.3755645799708976e-014 0.99641182639913395 0
		 8.2337711184235953 13.641717635099553 -0.035520551490899777 1;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 54;
createNode joint -n "leftHandIndex2" -p "leftHandIndex1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.47721514466749426 -1.0736560356272573e-005 -4.0797708343864869e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0 8.1089765791958464e-006 0.0069303160265547659 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -0.40492095910751641 4.8382940473090672 -6.8688508834958713 ;
	setAttr ".pa" -type "double3" -1.1570790525960611e-026 -1.7755757880987097e-006 
		0.0064661531813637405 ;
	setAttr ".bps" -type "matrix" 0.99653273175825352 -0.083201649829998003 -1.4849232954361469e-015 0
		 0.083201649829997629 0.99653273175825341 5.1887313889942277e-014 0 -2.8449465006019636e-015 -5.1898155911667132e-014 1.0000000000000004 0
		 8.7089653059379941 13.659030963310629 0.0048434335489310962 1;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 55;
createNode joint -n "leftHandIndex3" -p "leftHandIndex2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.20989520494943742 1.2727225662367836e-005 3.5444237703186054e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0 -7.0363489153112401e-005 -0.0063125888581268648 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0.41111493055800724 -3.3412921981601773 -2.2458936116823875 ;
	setAttr ".pa" -type "double3" -1.2631138750036605e-006 -3.725043276702174e-005 -0.0045811612009560299 ;
	setAttr ".bps" -type "matrix" 0.99081952947772334 -0.12198234885084054 0.058283501733987268 0
		 0.12177185283748618 0.99253226978715026 0.0071630501669106969 0 -0.05872202195147385 6.4011296263544182e-016 0.99827437317499623 0
		 8.9181241375080376 13.641568054859606 0.004843433548930862 1;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 56;
createNode joint -n "leftHandIndex4" -p "leftHandIndex3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.15739647085895095 -1.9126782568879008e-007 4.9765115639477386e-008 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -2.8720011101351469e-005 2.2329515489413873e-005 3.7253118410725918e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 89.999999999998906 3.975693351829396e-016 7.0065234048421807 ;
	setAttr ".pa" -type "double3" -2.20497323064239e-005 1.8166919863089537e-005 3.8410513230446142e-006 ;
	setAttr ".bps" -type "matrix" 0.99827437317499612 1.3877787807814457e-016 0.058722021951473843 0
		 -0.058722021951473864 1.9657357984668521e-014 0.99827437317499623 0 -6.6613381477509392e-016 -1.0000000000000004 1.9774980264397612e-014 0
		 9.0740758978892142 13.622368431242229 0.014017066512530001 1;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 57;
createNode joint -n "leftHandThumb1" -p "leftHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.35899506616203369 -0.28916692105603059 -0.08163146346043415 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -1.2481910572374633 23.028318647778949 8.9767661353444463 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 91.568095016295814 16.813796147851111 -34.045130196552741 ;
	setAttr ".pa" -type "double3" -1.2481648162884245 23.028108816450931 8.9767899368046908 ;
	setAttr ".bps" -type "matrix" 0.78388580521375184 -0.32636700037847866 0.52821172407316264 0
		 0.27065466002576155 0.94524313330695742 0.18237728461183186 0 -0.55881043242832174 -1.2490009027033011e-016 0.82929542420615865 0
		 7.5394051717283901 13.543227903625887 0.04733902949369001 1;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 50;
createNode joint -n "leftHandThumb2" -p "leftHandThumb1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.43724018902847323 1.0052141674044002e-005 3.3898843408985968e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.8792363566618633e-005 -0.0032419676115680294 6.0477123883959423e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -1.3955609526603392 9.3658652142942707 10.534444109395576 ;
	setAttr ".pa" -type "double3" 1.7336361999913618e-005 -0.0019454347189441154 4.702537863549068e-006 ;
	setAttr ".bps" -type "matrix" 0.90016293608070697 -0.14607694519477676 0.41032696059255486 0
		 0.13291884155511918 0.98927323125745326 0.06058923565356171 0 -0.414776168633405 -5.2041704279304213e-016 0.90992347476795754 0
		 7.8821532349545613 13.400526432905728 0.2782955593801657 1;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 51;
createNode joint -n "leftHandThumb3" -p "leftHandThumb2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.33153808002783192 -1.4714828755257869e-005 -5.3688671663998377e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -2.9258552491798619e-006 0.0030531288458385021 -3.1181726293134153e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -0.91130821427620989 5.3260545579339578 -1.3243883470842395 ;
	setAttr ".pa" -type "double3" -2.3699505269293019e-006 0.0010810024379940822 1.9983599094871858e-005 ;
	setAttr ".bps" -type "matrix" 0.93147918360224269 -0.16817365202627765 0.32258976003562906 0
		 0.15891360127914511 0.9857573853459809 0.055034939487095737 0 -0.32725066515469903 -1.7295193055488767e-015 0.94493756521571715 0
		 8.1805975783988938 13.35209538086661 0.41433733075629009 1;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 52;
createNode joint -n "leftHandThumb4" -p "leftHandThumb3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.30662159272736944 -3.4863994935463438e-007 -9.0527680245422459e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.7570025918651543e-005 -6.6978021244415271e-006 -3.2967297929778366e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -31.828543416249218 -0.14438143233974798 9.6816482734114349 ;
	setAttr ".pa" -type "double3" 6.5076384955281061e-006 -7.7309346661370645e-006 -3.1261530470295096e-005 ;
	setAttr ".bps" -type "matrix" 0.94410991666974098 1.6653345369377348e-016 0.32963080142161361 0
		 0.17384040419892482 0.84963007049154748 -0.49790386339581943 0 -0.28006424104803107 0.52737912673571785 0.80214417505188096 0
		 8.4661989647816167 13.300531557415392 0.51324676890685683 1;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 53;
createNode joint -n "rightShoulder" -p "xxx";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.54562695574076792 -0.42956687065595212 0.83456645053820155 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.8147296969838974e-006 0.00039521162512470571 -1.270184601429823e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0 -84.93513786533579 -178.71267105847502 ;
	setAttr ".pa" -type "double3" 1.8601956378275333e-006 0.00042883401268170276 -1.2449225663108899e-005 ;
	setAttr ".bps" -type "matrix" -0.99609539443455397 -0.088283436647370053 7.4159428598008503e-017 0
		 2.0882186082719091e-016 -1.7069679003611782e-015 0.99999999999999956 0 -0.088283436647370248 0.99609539443455386 1.700029006457271e-015 0
		 -0.83456900000000167 14.547299998048764 4.8893666892979581e-011 1;
	setAttr ".sd" 2;
	setAttr ".typ" 9;
	setAttr ".radi" 0.25;
	setAttr ".hni" 19;
createNode joint -n "rightArm" -p "rightShoulder";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 1.3592707580146781 -2.5116748547659995e-006 -3.32932572266742e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.4787072948775308 14.317379720483792 5.6577913865724501 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 0 180.14759344021834 0 ;
	setAttr ".jo" -type "double3" 0.9478854839729145 -9.881389723651095 174.41084975506507 ;
	setAttr ".pa" -type "double3" 1.5424221072811681 14.994889456539441 5.9345678734211589 ;
	setAttr ".bps" -type "matrix" -0.96216601081166964 -0.25501015715872022 -0.095949921233123819 0
		 0.09274767564898144 0.024581620092134025 -0.99538616255971579 0 0.25619218625959167 -0.96662586542029327 1.6200546095271583e-014 0
		 -2.1885200000000005 14.427299998048765 4.8893715309433434e-011 1;
	setAttr ".sd" 2;
	setAttr ".typ" 10;
	setAttr ".radi" 0.25;
	setAttr ".hni" 12;
createNode joint -n "rightForeArm" -p "rightArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 2.5536229036882587 4.8400864538500343e-007 -4.1163906789876137e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.86094306117319863 -11.907444550080212 4.3976341072186802 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.041675130478854953 12.572818864413795 -5.6974465238687326 ;
	setAttr ".pa" -type "double3" -1.0177282215812578 -11.912781512942169 5.1468090887698708 ;
	setAttr ".bps" -type "matrix" -0.99920902197866623 -0.039631985434654404 0.0032613075513502204 0
		 -0.0032587452590164823 -0.00012925278074945798 -0.99999468192238661 0 0.03963219620175007 -0.99921433587805675 1.2490009027033011e-016 0
		 -4.6455300000000133 13.776099998048785 -0.24501999995102711 1;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".radi" 0.25;
	setAttr ".hni" 13;
createNode joint -n "rightForeArmRoll" -p "rightForeArm";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".t" -type "double3" 1.2543032433789303 4.0948013425301522e-006 1.3490259590362777e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 3.3738535365413244e-006 -5.2723126232653729e-006 3.5953419313256662e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 0 179.06230455355939 0 ;
	setAttr ".jo" -type "double3" 179.99933446849195 -0.52118864910324247 -179.90468125418019 ;
	setAttr ".pa" -type "double3" 7.0341954589650794e-006 -4.990189637021699e-006 3.6135040866418329e-006 ;
	setAttr ".bps" -type "matrix" -0.9988985586441298 -0.0468947381199789 0.0015978345779181016 0
		 -0.0015960766942689731 -7.4930130135295974e-005 -0.99999872346151586 0 0.046894797982994126 -0.99889983377820923 3.9404531070388882e-013 0
		 -5.8988344147388663 13.726389736013964 -0.24092935318741568 1;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".radi" 0.25;
	setAttr ".hni" 48;
createNode joint -n "rightHand" -p "rightForeArmRoll";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr -k off ".v";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 1.2303984224996578 -8.4818131864672353e-006 2.3665871252909199e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.00034956643681202616 -0.00080730348732503535 -0.014022328597479856 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 4.884090491761822 -1.5459990326857702 179.86790982048905 ;
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 4.8823083031528629 -1.5516303006738332 -180 ;
	setAttr ".pa" -type "double3" -2.5949516706628071e-005 0.00012493482057192694 -0.00021639210930408177 ;
	setAttr ".bps" -type "matrix" -0.99889855864412935 -0.046894738119988282 0.0015978345779110266 0
		 -0.001596076694261326 -7.4930130147315697e-005 -0.99999872346151586 0 0.046894797983003528 -0.99889983377820879 4.0639539732467155e-013 0
		 -7.1278944147388659 13.668689736013972 -0.23896335318737713 1;
	setAttr ".sd" 2;
	setAttr ".typ" 12;
	setAttr ".radi" 0.25;
	setAttr ".hni" 14;
createNode joint -n "joint57" -p "rightHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.51661115217065734 0.25072377922080691 -0.008053992186467053 ;
	setAttr ".jo" -type "double3" -89.51222776613632 2.6432626118671476 10.550832462020319 ;
	setAttr ".bps" -type "matrix" -0.98341979990383965 -1.0130785099704553e-015 -0.18134358868482764 0
		 1.1726730697603216e-015 1 -1.3412759943508268e-014 0 0.18134358868482767 -1.3445841662296232e-014 -0.98341979990383965 0
		 -7.6447144147388713 13.652489736013969 -0.48886135318736157 1;
	setAttr ".sd" 2;
	setAttr ".radi" 0.12;
createNode joint -n "rightHandPinky1" -p "joint57";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.49503055637126758 -8.7915853034803426e-006 2.2075487974948516e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 3.5817787564094661 0.23901645652804468 9.6556073045620838 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.79318820169042925 5.2418461143272079 -8.6170096058003249 ;
	setAttr ".pa" -type "double3" -1.904312639706532e-005 -4.6969483927552028e-006 -2.0009194692661644e-006 ;
	setAttr ".bps" -type "matrix" -0.98482013841329885 -0.14920227909945219 -0.088701605888167362 0
		 -0.14860074260189027 0.98880669491641759 -0.013384296269795596 0 0.08970570925965321 -2.2849436547199011e-014 -0.99596831562365606 0
		 -8.1316044147388702 13.652489736013967 -0.5786443531873513 1;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 90;
createNode joint -n "rightHandPinky2" -p "rightHandPinky1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.35254791392482943 -2.9079123480713065e-005 4.8065361799576323e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0038087150116967272 -0.16617004858652892 2.6276641959753535 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -4.3888576833706905 8.5211864765903282 -18.802078076362978 ;
	setAttr ".pa" -type "double3" -2.741205227481075e-006 2.0377321293005082e-006 -1.6272783280955677e-005 ;
	setAttr ".bps" -type "matrix" -0.88790339582560907 -0.45485577470366456 0.06880249922844886 0
		 -0.45349630265786534 0.89056511509194514 0.035140848836030296 0 -0.077257123665053912 -1.6459056340067946e-014 -0.99701120196465332 0
		 -8.4787944147388714 13.599889736013967 -0.60991535318734191 1;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 91;
createNode joint -n "rightHandPinky3" -p "rightHandPinky2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.22468527495099178 1.6466916791912922e-005 -1.8333106259760257e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.00038499255950451533 -0.0018561356222265252 0.69333185829626287 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 1.7879883723494419 -4.0548131825483855 3.2358187032372467 ;
	setAttr ".pa" -type "double3" 2.9597993074878899e-006 -1.3180116092939806e-006 3.3417606585771496e-005 ;
	setAttr ".bps" -type "matrix" -0.91526552414308437 -0.40285111432771881 5.134781488891349e-014 0
		 -0.40285111432771892 0.9152655241430846 9.6467972499070243e-015 0 -5.0862092315639984e-014 -1.1844691893969639e-014 -1.0000000000000002 0
		 -8.6782944147388719 13.497689736013966 -0.59445635318733347 1;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 92;
createNode joint -n "rightHandPinky4" -p "rightHandPinky3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.13105734172244482 2.3146857262901221e-005 3.2478133906721496e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -7.827134594695115e-006 -4.5422371189662693e-005 3.6544592068010648e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 130.76962370045476 0 -132.51871503111803 ;
	setAttr ".pa" -type "double3" -9.3511746196304609e-006 -3.2579774477462991e-005 
		2.980565036558759e-005 ;
	setAttr ".bps" -type "matrix" 0.915488891978401 -0.40234324732019494 -4.1812680637383232e-014 0
		 0.26273785696206553 0.59783180444330952 -0.75734137092531684 0 0.30471118650804491 0.69333761251781023 0.65301917880331983 0
		 -8.7982544147388726 13.444889736013964 -0.59445635318732692 1;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".radi" 0.12;
	setAttr ".hni" 93;
createNode joint -n "joint62" -p "rightHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.54664969767972749 0.080603558682474957 -0.025669274519964119 ;
	setAttr ".jo" -type "double3" -89.600990300921325 2.658100011113441 8.6316811493400998 ;
	setAttr ".bps" -type "matrix" -0.98893607046326193 -9.7491459349896559e-015 -0.14834233561826471 0
		 -7.53563877964325e-015 0.99999999999999989 -1.7395644386769549e-014 0 0.14834233561826476 -1.6027110194549721e-014 -0.98893607046326204 0
		 -7.6752744147388663 13.668689736013969 -0.31869335318736064 1;
	setAttr ".sd" 2;
	setAttr ".radi" 0.12;
createNode joint -n "rightHandRing1" -p "joint62";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.5194431909014835 -5.6637214507215816e-006 2.7038069735141335e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 3.6193760016923333 -0.58594886230167642 13.59700591790962 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.027431689654660231 2.6750166709276511 -0.58774816894958049 ;
	setAttr ".pa" -type "double3" -1.9669904354373829e-005 1.244320915517286e-006 4.6607715716092875e-006 ;
	setAttr ".bps" -type "matrix" -0.99472974019094695 -0.010246782920908561 -0.10201836804920325 0
		 -0.010193314858270901 0.99994750034177871 -0.0010454149551172597 0 0.10202372425985581 1.5704218319180707e-013 -0.99478196590416179 0
		 -8.1889944147388718 13.668689736013965 -0.39575235318734864 1;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 86;
createNode joint -n "rightHandRing2" -p "rightHandRing1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.42941127057045791 -1.1593685034227974e-007 -1.143296512839953e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0021001216947953401 0.068022223481194036 -3.5481146105178989 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -1.085678836617038 4.1149951070848596 -14.206569523705143 ;
	setAttr ".pa" -type "double3" 0 -3.8381177246485342e-006 -2.3675216459230703e-005 ;
	setAttr ".bps" -type "matrix" -0.9666480738726021 -0.25468080939567544 -0.027003455407627427 0
		 -0.2545814945814035 0.96702517305681523 -0.0071117713078609791 0 0.027924252811615952 -3.0084008201258783e-014 -0.99961004201884296 0
		 -8.6161344147388643 13.664289736013968 -0.43955935318733907 1;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 87;
createNode joint -n "rightHandRing3" -p "rightHandRing2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.21948666394098937 -1.1487552572742032e-005 1.6641726246005573e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0027680801640115596 -0.097869327376775603 3.2638654030625691 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.68988780299772001 3.2853356939830247 2.8885653397684958 ;
	setAttr ".bps" -type "matrix" -0.97824172889073191 -0.20528737772941541 0.030003539822022592 0
		 -0.20519088855300369 0.97870173829669893 0.0062933861989075439 0 -0.030656469328679898 -1.9753296220947902e-014 -0.99952997998474258 0
		 -8.8283044147388647 13.608389736013962 -0.44548635318733243 1;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 88;
createNode joint -n "rightHandRing4" -p "rightHandRing3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.15830468348609281 -1.5496446565066435e-005 -4.4727522032772526e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -8.9338242373974614e-006 -5.6468203925639572e-006 -2.2603992995187901e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 20.342612032575374 174.23973635733387 11.846322380634167 ;
	setAttr ".pa" -type "double3" 0 -8.8309634012635386e-006 -2.4442738956903342e-005 ;
	setAttr ".bps" -type "matrix" 0.99755978467251083 3.3306690738754696e-015 0.069817447705668792 0
		 -0.024270854563204214 0.93763065217695907 0.34678478299513377 0 -0.065462979025595752 -0.34763308257156744 0.93534263148799346 0
		 -8.9831744147388637 13.575889736013956 -0.44073635318732662 1;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".radi" 0.12;
	setAttr ".hni" 89;
createNode joint -n "joint67" -p "rightHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.96448561893799956 -0.0085098965736953858 -0.045277544769111167 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.8716635610793926e-006 -0.010368759755017904 0.00020576830301186969 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -89.949829082421047 2.6873918391664873 1.1614723058869465 ;
	setAttr ".bps" -type "matrix" -0.99982603520465341 4.40619762898109e-015 -0.018652059589840706 0
		 4.3368086899420177e-015 0.99999999999999989 -1.1197341881832856e-014 0 0.018652059589840723 -1.1133888949688142e-014 -0.99982603520465341 0
		 -7.693614414738863 13.668689736013967 -0.22145335318735984 1;
	setAttr ".sd" 2;
	setAttr ".typ" 13;
	setAttr ".radi" 0.12;
	setAttr ".hni" 22;
createNode joint -n "rightHandMiddle1" -p "joint67";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.091910343664276417 1.1333713463734796e-005 1.8124165930277769e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.9764945595209236 -0.55408382751060226 11.87082396244956 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0.0035825480543934195 0.057056148732065895 3.5928783105196134 ;
	setAttr ".pa" -type "double3" -1.949281261645889e-005 0 1.3077110055570201e-005 ;
	setAttr ".bps" -type "matrix" -0.99787898179688028 0.062666436314762985 -0.017619745958127434 0
		 0.06265666963383347 0.99803452733841214 0.0011063411719988653 0 0.017654445287740097 7.038744357702525e-013 -0.99984414813588918 0
		 -8.1853244147388615 13.66868973601397 -0.23062635318734903 1;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 82;
createNode joint -n "rightHandMiddle2" -p "rightHandMiddle1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.50584257870263305 -2.6147598178205556e-005 2.2951372422586047e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0039831489795956266 -0.10387263173479035 4.3836960581504041 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.048701118454908349 3.8591213642680633 -4.3164432210624692 ;
	setAttr ".pa" -type "double3" 0 0 -1.0920373065779263e-005 ;
	setAttr ".bps" -type "matrix" -0.99868571153682384 -0.012599651517019306 0.049679959277734165 0
		 -0.012584090849916171 0.9999206212403311 0.00062599986532681402 0 -0.049683903124339096 -4.5115820801466811e-014 -0.99876499226311033 0
		 -8.6901044147388582 13.700389736013975 -0.23953935318733682 1;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 83;
createNode joint -n "rightHandMiddle3" -p "rightHandMiddle2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.2142855858469995 -2.2677083122424335e-006 4.8046692217029729e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.00060901146885736863 0.026397717891266801 -2.8472195853960613 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0.53977817580535548 -4.541873489792172 -6.0628276830035661 ;
	setAttr ".pa" -type "double3" 0 0 2.8829288431674698e-005 ;
	setAttr ".bps" -type "matrix" -0.99259054254772561 -0.11776874581376977 -0.029908817333073177 0
		 -0.11771531858398675 0.9930410477464926 -0.0035470073609849117 0 0.030118409909588889 -2.7676862537906466e-014 -0.99954633778755719 0
		 -8.9041144147388618 13.697689736013967 -0.22889335318732978 1;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 84;
createNode joint -n "rightHandMiddle4" -p "rightHandMiddle3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.1800318685483159 -2.4961822189584204e-005 2.4471492928168637e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.2156048938991029e-005 -2.5458558709994969e-005 7.2699669147906205e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 100.41599800037305 -2.8600909399241807 -173.2366520105758 ;
	setAttr ".pa" -type "double3" -7.3464088176988748e-006 -2.6795675585048553e-005 
		5.2797864281755825e-006 ;
	setAttr ".bps" -type "matrix" 0.99980408462199932 2.5396351688300456e-015 -0.019793745809370041 0
		 -0.019467565232699945 0.18079376885288828 -0.98332834142410375 0 0.0035785859045893015 0.98352102831813859 0.18075834857332326 0
		 -9.0827944147388635 13.676489736013975 -0.23427735318732637 1;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".radi" 0.12;
	setAttr ".hni" 85;
createNode joint -n "joint72" -p "rightHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.5672325509944437 -0.18539919288553708 -0.026615611543158169 ;
	setAttr ".jo" -type "double3" -90.091644914012321 2.6862981101708767 -1.863095174789424 ;
	setAttr ".bps" -type "matrix" -0.99941941895979758 -2.5188184871183239e-015 0.034070882085152993 0
		 -3.3167912860676552e-015 0.99999999999999989 -1.5626023153365864e-014 0 -0.034070882085152979 -1.5598416655548952e-014 -0.99941941895979747 0
		 -7.6954544147388591 13.668689736013972 -0.052658053187359916 1;
	setAttr ".sd" 2;
	setAttr ".radi" 0.12;
createNode joint -n "rightHandIndex1" -p "joint72";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.48467908010338184 2.9861310674172969e-007 1.8948854264566606e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.6817428106674399 -0.280873652337433 11.918519598418518 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0.10531937736629303 2.9008087150975164 2.0802090512168663 ;
	setAttr ".pa" -type "double3" -2.1568462608391638e-005 -1.4253625728527985e-005 
		8.1985259379635058e-006 ;
	setAttr ".bps" -type "matrix" -0.99575679756106705 0.036252009928244643 0.084582456142455603 0
		 0.036121928982959704 0.99934267985319347 -0.0030683008958615138 0 -0.084638090464506405 -3.4583217845079012e-014 -0.99641175908482815 0
		 -8.1798244147388566 13.66868973601397 -0.036145553187349244 1;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 78;
createNode joint -n "rightHandIndex2" -p "rightHandIndex1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.47722162147329461 -3.6217215725997676e-005 -5.910887597160297e-007 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0095821588540945749 -0.16245879281743728 6.7465446679167576 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0.40577659338939503 -4.8382682606519865 -6.877369504970134 ;
	setAttr ".pa" -type "double3" -1.8079360196813923e-028 1.3096388197460349e-005 -1.1686679115648973e-005 ;
	setAttr ".bps" -type "matrix" -0.99651810264904406 -0.083376681948546069 2.6284530108000581e-014 0
		 -0.083376681948546333 0.99651810264904417 3.9692207853825323e-014 0 -2.9476421303797906e-014 3.7486073273251819e-014 -0.99999999999999978 0
		 -8.6550144147388561 13.685989736013967 0.004218456812662176 1;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 79;
createNode joint -n "rightHandIndex3" -p "rightHandIndex2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.20989227084485212 -1.0717257689307758e-005 1.199116097419517e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0052474891628273334 0.15070789827870246 -4.0743607338101464 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -0.41113014734756398 3.3413126786841483 -2.2360446966101764 ;
	setAttr ".pa" -type "double3" 0 2.7722105395705298e-006 3.5300369455499024e-006 ;
	setAttr ".bps" -type "matrix" -0.99081905179778484 -0.12198605831687495 0.058283858578943824 0
		 -0.12177555312895014 0.99253181388624112 0.0071633151421892473 0 -0.058722408454325498 -2.7587307438459163e-014 -0.99827435043945856 0
		 -8.864174414738855 13.668489736013965 0.004218456812667597 1;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 80;
createNode joint -n "rightHandIndex4" -p "rightHandIndex3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 6;
	setAttr ".t" -type "double3" 0.15739583219404443 -5.6907808043682451e-007 -1.9900144299089817e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.8627866845714945e-005 0 0 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" -90.000000000000668 6.7329435101205339 -172.99326245925181 ;
	setAttr ".pa" -type "double3" 7.9262103283755522e-006 -1.8313328448211479e-006 6.4524387120619029e-006 ;
	setAttr ".bps" -type "matrix" 0.99827437317499745 2.9559688030644793e-015 0.058722021951440259 0
		 -0.058722021951440301 3.9234240856167446e-014 0.99827437317499745 0 8.8817841970012523e-016 -0.99999999999999978 3.9288017283922727e-014 0
		 -9.0201244147388557 13.649289736013969 0.013392046812672646 1;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".radi" 0.12;
	setAttr ".hni" 81;
createNode joint -n "rightHandThumb1" -p "rightHand";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.36224314087338111 -0.28509819839084383 0.081629324771929745 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.3735929454507364 -23.419634653902381 10.25335557419074 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" -91.568687996311709 -16.812670717541256 -33.398821633975864 ;
	setAttr ".pa" -type "double3" 7.7771392573059179 -22.73846283109247 -2.7620696393233395 ;
	setAttr ".bps" -type "matrix" -0.7838883070159105 -0.32636283416826423 0.52821058546510324 0
		 -0.27065165692321058 0.94524457177688026 0.18237428582742346 0 -0.55880837746802792 -1.4575146645157133e-014 -0.82929680891195356 0
		 -7.4854544147388582 13.570189736013972 0.046714046812635662 1;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 74;
createNode joint -n "rightHandThumb2" -p "rightHandThumb1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 0.43724323942056076 -1.5024587739276285e-005 3.6462115025059916e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.0045704007417511029 -3.2917452511427028 -0.15751841860755242 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 1.394627708852952 -9.3655044926508939 10.53948389109452 ;
	setAttr ".pa" -type "double3" 2.3194395121074634e-005 -8.4337210048932765e-006 8.4348522114516938e-006 ;
	setAttr ".bps" -type "matrix" -0.90017250806642479 -0.14598696351164833 0.41033798533166599 0
		 -0.13283659410045282 0.98928651384957655 0.060552727297314535 0 -0.41478174379930643 -1.4183099139586375e-014 -0.90992093338421742 0
		 -7.8282044147388525 13.427489736013973 0.27767064681264653 1;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 75;
createNode joint -n "rightHandThumb3" -p "rightHandThumb2";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.33154395873269749 -1.4855127456137041e-005 6.6866031449563934e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.001376406862706692 1.8655676935521568 0.079045678119971152 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0.91199194708236608 -5.3262864015509344 -1.3363429762942365 ;
	setAttr ".pa" -type "double3" 1.2460637475823916e-005 3.615872039362689e-028 -2.6419740535573396e-005 ;
	setAttr ".bps" -type "matrix" -0.93146052553174996 -0.16828908654560307 0.32258343529351019 0
		 -0.15902267246440743 0.98573768485822144 0.055072736382273085 0 -0.32725078917917627 -1.964053919500941e-014 -0.94493752226356498 0
		 -8.1266444147388501 13.379089736013974 0.41371264681265468 1;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 76;
createNode joint -n "rightHandThumb4" -p "rightHandThumb3";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 5;
	setAttr ".t" -type "double3" 0.30662075008639539 -5.5637370997008162e-006 2.1611829411627426e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -4.0141878290501986e-005 7.7449630820541517e-006 -3.0346677780011505e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jot" -type "string" "___";
	setAttr ".jo" -type "double3" 148.17145658375097 38.348362447400937 -170.3116421883704 ;
	setAttr ".pa" -type "double3" -2.8165988577761185e-005 -6.4709180966283169e-006 
		-2.4688629062533358e-005 ;
	setAttr ".bps" -type "matrix" 0.94410991666974753 7.5495165674510645e-015 0.32963080142159334 0
		 0.17384040419891345 0.84963007049153816 -0.49790386339583859 0 -0.28006424104801453 0.52737912673573262 0.80214417505187618 0
		 -8.4122444147388489 13.327489736013989 0.51262164681266253 1;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".radi" 0.12;
	setAttr ".hni" 77;
createNode joint -n "leftUpLeg" -p "hips";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 1.0568754995580645 -1.2884028853974185 0.192120351181642 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.46400689665492162 -0.14462817801659855 -8.7715404978143212 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".pa" -type "double3" -0.45216775803243758 -0.14280273074958541 -8.7716138755291428 ;
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 1.0568754995580645 9.1139036446025816 -0.055056402618358008 1;
	setAttr ".sd" 1;
	setAttr ".typ" 2;
	setAttr ".radi" 0.25;
	setAttr ".hni" 2;
createNode joint -n "leftLeg" -p "leftUpLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 0.71681312103590122 -4.470095289303111 -0.12434304319800552 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.0087593235223751027 0.0043420456604426156 -1.0748681580307209 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 89.999999999999986 1.6192418019594619 -81.637177776434712 ;
	setAttr ".pa" -type "double3" -0.0085222691865498596 -0.004993622191196736 -57.777992564994094 ;
	setAttr ".bps" -type "matrix" 0.1453830068665265 -0.98897184191806875 -0.028257339004758519 0
		 0.0041097780202601353 -0.027956876296432398 0.99960068166862026 0 -0.98936691426339496 -0.14544108415756646 2.2204460492503131e-016 0
		 1.7736519938408319 4.6441280889159264 -0.17939074413184572 1;
	setAttr ".sd" 1;
	setAttr ".typ" 3;
	setAttr ".radi" 0.25;
	setAttr ".hni" 3;
createNode joint -n "leftFoot" -p "leftLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 3.9375901258791539 6.2545269273878157e-006 -2.1095652218416916e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 10.946751354988692 5.7012739966347699 1.1644165918791367 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -7.3835464229291743 -3.9377651840435193 63.698187218770435 ;
	setAttr ".pa" -type "double3" 7.7671655156291175 9.6009062598181387 -22.378587441767785 ;
	setAttr ".bps" -type "matrix" -4.0245584642661925e-016 -0.4721697221327551 0.88150765935474262 0
		 8.3266726846886741e-017 0.88150765935474262 0.47216972213275527 0 -1.0000000000000002 1.9428902930940239e-016 -2.1337098754514727e-016 0
		 2.3460976071061475 0.75005129995067676 -0.29065402107504223 1;
	setAttr ".sd" 1;
	setAttr ".typ" 4;
	setAttr ".radi" 0.25;
	setAttr ".hni" 4;
createNode joint -n "joint86" -p "leftFoot";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" 1.1523755361264256 -0.022985336213369255 6.5628779476911703e-005 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.0040396960282161045 0.00015535499542487511 -4.9162246308938321e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -91.137684811835072 86.439840042067956 -62.9820833879959 ;
	setAttr ".pa" -type "double3" 11.661782716526927 0 0 ;
	setAttr ".sd" 1;
	setAttr ".typ" 5;
	setAttr ".radi" 0.1;
	setAttr ".hni" 16;
createNode joint -n "leftFootIndex1" -p "joint86";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" -4.4408920985006262e-016 0 0.048721191665281216 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 1.2943371055101537e-005 -2.2275181293794799e-005 0 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 91.321979044254277 -86.936595598089539 -87.760630669660173 ;
	setAttr ".pa" -type "double3" 1.311119735248699e-005 -1.4530345813965733e-005 -11.727202764393356 ;
	setAttr ".bps" -type "matrix" -3.2916920809463963e-016 -0.053807189930123789 0.99855134385359667 0
		 2.4607252704255392e-016 0.99855134385359656 0.0538071899301239 0 -1.0000000000000002 1.9428902930940239e-016 -2.1337098754514727e-016 0
		 2.3460976071061475 0.18564981736277153 0.76304384757509347 1;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.1;
	setAttr ".hni" 102;
createNode joint -n "leftFootIndex2" -p "leftFootIndex1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 4;
	setAttr ".t" -type "double3" 0.81246231168211314 -0.00068437767011907125 -5.8791705470628841e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -6.6753763464861199e-006 -1.1221108631562755e-005 3.3583750654507977e-006 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 0 89.999999999999972 0 ;
	setAttr ".pa" -type "double3" -7.1480320004752643e-006 -1.8714084201720575e-005 
		4.884776025906072e-006 ;
	setAttr ".bps" -type "matrix" 1.0000000000000002 -2.1818422176972331e-016 6.568168648318092e-016 0
		 2.4607252704255392e-016 0.99855134385359656 0.0538071899301239 0 -7.7325841794470234e-016 -0.053807189930123789 0.99855134385359667 0
		 2.3460976071061466 0.14201112417002873 1.5728886989456456 1;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".radi" 0.25;
	setAttr ".hni" 103;
createNode joint -n "rightUpLeg" -p "hips";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 1;
	setAttr ".t" -type "double3" -1.1177471818345115 -1.2884407080441878 0.192120351181642 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.47110539470570534 -0.14942467112877575 -8.7785884333677817 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".ra" -type "double3" 179.99212598514788 -0.87068835621386731 0.51815656336427407 ;
	setAttr ".jo" -type "double3" 179.99999999999997 -0.8707239568221713 0.51809673395612987 ;
	setAttr ".pa" -type "double3" -0.46853475720724896 -0.14902310028004345 -8.778546711031769 ;
	setAttr ".bps" -type "matrix" 1 -2.4103982698697738e-014 3.9707820365108925e-015 0
		 2.4103982698697731e-014 1 1.5448932281017993e-015 0 -3.9707820365109304e-015 -1.5448932281017034e-015 1 0
		 -1.1177471818345115 9.1138658219558124 -0.055056402618358008 1;
	setAttr ".sd" 2;
	setAttr ".typ" 2;
	setAttr ".radi" 0.25;
	setAttr ".hni" 5;
createNode joint -n "rightLeg" -p "rightUpLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" -0.65592663536536011 -4.4700773375613929 -0.12434198967699187 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -0.011119082762940163 -0.0039789816242137002 -1.0127303044838574 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 90.000000000000014 1.6192304105499764 -98.362880132483241 ;
	setAttr ".pa" -type "double3" -0.01123728426101114 -0.0040409398677961027 -1.0051021909571545 ;
	setAttr ".bps" -type "matrix" -0.14538400723868602 -0.98897170053706707 -0.02825714026654956 0
		 -0.0041097773714138044 -0.02795667551768044 0.99960068728665674 0 -0.98936676726539541 0.14544208411192705 -3.9259119010778392e-015 0
		 -1.7736500000001074 4.6441310231961239 -0.17939104491287566 1;
	setAttr ".sd" 2;
	setAttr ".typ" 3;
	setAttr ".radi" 0.25;
	setAttr ".hni" 6;
createNode joint -n "rightFoot" -p "rightLeg";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 3;
	setAttr ".t" -type "double3" 3.9375476849242408 -8.3184451804226879e-007 2.1943973989024812e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" -9.5228127549581814 -4.9843719426254465 0.84646095350997652 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 7.3835953596722295 3.9377967284327395 63.698145096233304 ;
	setAttr ".pa" -type "double3" -9.5220803084314909 -4.985414198690882 0.83817333011639139 ;
	setAttr ".bps" -type "matrix" -1.5168422073941201e-014 -0.47217025227884546 0.8815073753877114 0
		 2.0733414984874798e-014 0.88150737538771129 0.4721702522788454 0 -0.99999999999999989 2.528532938583794e-014 -3.6897568334026687e-015 0
		 -2.3461000000002028 0.75005174497761162 -0.29065362635370851 1;
	setAttr ".sd" 2;
	setAttr ".typ" 4;
	setAttr ".radi" 0.25;
	setAttr ".hni" 7;
createNode joint -n "joint87" -p "rightFoot";
	setAttr ".uoc" yes;
	setAttr ".oc" 2;
	setAttr ".t" -type "double3" 1.1336943375364483 -0.041945038842382217 -0.0073759060872351512 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 0.0032936467252047668 9.112317791906517e-005 0.0001002245648325334 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 87.607980135365253 88.027728942934161 115.74576505160982 ;
	setAttr ".sd" 2;
	setAttr ".typ" 5;
	setAttr ".radi" 0.1;
	setAttr ".hni" 17;
createNode joint -n "rightFootIndex1" -p "joint87";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" -0.0069916194095918094 0.0081594010389421934 0.074146199603064789 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 2.1906353313592812e-005 3.5021228762352617e-005 0.077521778818628276 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 88.451335660129175 -86.953370045060367 -90.424077341898851 ;
	setAttr ".pa" -type "double3" 1.5918670617593862e-005 3.4906640548645288e-005 0.077519002605949655 ;
	setAttr ".bps" -type "matrix" -4.9449728618317806e-015 -0.053807189930122901 0.99855134385359656 0
		 2.5209180243395554e-014 0.99855134385359645 0.05380718993012279 0 -0.99999999999999989 2.528532938583794e-014 -3.6897568334026687e-015 0
		 -2.3461000000002201 0.18564961600739449 0.76304392653226394 1;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.1;
	setAttr ".hni" 126;
createNode joint -n "rightFootIndex2" -p "rightFootIndex1";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 
		-at "bool";
	setAttr ".uoc" yes;
	setAttr ".oc" 7;
	setAttr ".t" -type "double3" 0.80811751930268161 0.0013686866136231185 9.0457834180934782e-006 ;
	setAttr -k off -cb on ".tx";
	setAttr -k off -cb on ".ty";
	setAttr -k off -cb on ".tz";
	setAttr ".r" -type "double3" 5.678974227396737e-005 9.6295504278521862e-006 -1.0330295194817295e-005 ;
	setAttr -k off -cb on ".rx";
	setAttr -k off -cb on ".ry";
	setAttr -k off -cb on ".rz";
	setAttr -k off -cb on ".sx";
	setAttr -k off -cb on ".sy";
	setAttr -k off -cb on ".sz";
	setAttr ".jo" -type "double3" 0 89.999999999999943 0 ;
	setAttr ".pa" -type "double3" 5.4740718329698554e-005 1.0609418517385312e-005 -5.5062547527867143e-006 ;
	setAttr ".bps" -type "matrix" 0.99999999999999989 -2.5339093568873661e-014 4.6875100572976579e-015 0
		 2.5209180243395554e-014 0.99855134385359645 0.05380718993012279 0 -5.9441735839944215e-015 -0.053807189930122901 0.99855134385359656 0
		 -2.3461000000002246 0.1420107474086964 1.5728920330784395 1;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".radi" 0.25;
	setAttr ".hni" 127;
createNode transform -n "humanIK1";
createNode hikHandle -n "hikHandle1" -p "humanIK1";
	setAttr ".v" no;
	setAttr ".io" yes;
	setAttr -k off ".pvx";
	setAttr -k off ".pvy";
	setAttr -k off ".pvz";
	setAttr -k off ".off";
	setAttr -k off ".rol";
	setAttr -k off ".twi";
	setAttr -s 36 ".eff";
	setAttr -s 69 ".jt";
	setAttr -s 69 ".fj";
	setAttr -s 69 ".dm";
	setAttr ".dm[0]" -type "matrix" 1 1.8225802023152937e-006 9.8935068137961935e-008 0
		 -1.8225802023152937e-006 1 4.3802862137454213e-007 -8.711204466918445e-020 -9.8934272330097883e-008 -4.3802879190479871e-007 1 0
		 -5.7220458984375e-006 10.402189254760742 -0.2471792995929718 1;
	setAttr ".dm[1]" -type "matrix" 1.7873926481115632e-006 0.99832552671432495 -0.057872854173183441 0
		 -4.5766881839881535e-008 -0.057872869074344635 -0.99832552671432495 3.9831697939973765e-009
		 -1.0000030994415283 1.7778518213162897e-006 -3.4973322016185193e-009 5.9972409260922177e-009
		 -8.4040566434850916e-006 11.096714973449707 -0.015667378902435303 1;
	setAttr ".dm[2]" -type "matrix" 1.787159931154747e-006 0.99063020944595337 -0.13657690584659576 0
		 -4.8797892304719426e-007 -0.13657680153846741 -0.99062949419021606 -2.0496838004646634e-008
		 -1 1.8380512756266398e-006 2.7482238351694832e-007 2.2978785096938736e-008 -6.3467782638326753e-006 12.095110893249512 -0.073544315993785858 1;
	setAttr ".dm[3]" -type "matrix" 3.2836617265274981e-006 0.94868075847625732 0.31623518466949463 0
		 2.3788894054632692e-007 0.31623521447181702 -0.9486808180809021 8.6450686609396143e-009
		 -1 3.2002130865294021e-006 8.2115127497672802e-007 6.9327441565292247e-009 2.5245981305488385e-007 15.043065071105957 -0.41853752732276917 1;
	setAttr ".dm[4]" -type "matrix" 1.734629449856584e-006 0.9998740553855896 -0.015871204435825348 0
		 7.5086580864081043e-007 -0.015871215611696243 -0.9998740553855896 1.13830882497723e-008
		 -1 1.7425559235562105e-006 -8.0042497074828134e-007 -1.0252790616505081e-008 -1.2704319942713482e-006 15.773378372192383 -0.17509329319000244 1;
	setAttr ".dm[5]" -type "matrix" 0.99609863758087158 -0.088264517486095428 -1.9725807098858184e-010 0
		 -3.944617077422663e-008 -4.2014292489511718e-007 1 -3.7757073023669818e-009 -0.088264524936676025 -0.99609863758087158 -4.217726825572754e-007 -2.406425503309606e-009
		 0.83456850051879883 14.547159194946289 -5.8859586715698242e-007 1;
	setAttr ".dm[6]" -type "matrix" 0.99997192621231079 0.0026052603498101234 0.0072426679544150829 0
		 -0.0071753258816897869 -0.024990420788526535 0.99966347217559814 -1.8229830145433112e-010
		 0.0027853811625391245 -0.99968743324279785 -0.024971025064587593 1.2628267875847143e-010
		 2.1885225772857666 14.427184104919434 -4.6303122758217796e-007 1;
	setAttr ".dm[7]" -type "matrix" 0.99932610988616943 -0.02718234620988369 0.024538317695260048 0
		 0.025176547467708588 0.023390496149659157 -0.99940729141235352 5.4278751632219624e-011
		 0.026592349633574486 0.99935448169708252 0.02405916154384613 2.4360012271240628e-011
		 4.7420978546142578 14.433837890625 0.018495911732316017 1;
	setAttr ".dm[8]" -type "matrix" 0.99988710880279541 -0.01494548749178648 0.00095699611119925976 0
		 0.001314296037890017 0.023915303871035576 -0.99971276521682739 8.4407592026991551e-011
		 0.01491832360625267 0.99960225820541382 0.02393227256834507 6.2439198256214468e-010
		 6.0508527755737305 14.398238182067871 0.05063222348690033 1;
	setAttr ".dm[9]" -type "matrix" 0.99988597631454468 -0.014949006959795952 0.00083605560939759016 0
		 0.001193517935462296 0.023919060826301575 -0.99971246719360352 -3.0644743687080478e-011
		 0.014924745075404644 0.99960172176361084 0.023934230208396912 3.8881151076530784e-010
		 7.2811870574951172 14.379838943481445 0.051809277385473251 1;
	setAttr ".dm[10]" -type "matrix" 0.99000579118728638 -0.11563870310783386 -0.0807233527302742 0
		 0.11693554371595383 0.99307280778884888 0.011511131189763546 -2.7904756283447796e-010
		 0.078833088278770447 -0.020835530012845993 0.99667078256607056 -3.92125709680613e-009
		 8.2885265350341797 14.403511047363281 -0.27647244930267334 1;
	setAttr ".dm[11]" -type "matrix" 0.90114253759384155 -0.42808526754379272 0.068432480096817017 0
		 0.42448630928993225 0.90335875749588013 0.061256129294633865 6.5691923012423104e-009
		 -0.088042028248310089 -0.026151886209845543 0.99577242136001587 1.0058394117606895e-008
		 8.6375312805175781 14.362735748291016 -0.30492857098579407 1;
	setAttr ".dm[12]" -type "matrix" 0.92781680822372437 -0.37302842736244202 0.0012155445292592049 0
		 0.37287211418151855 0.92751312255859375 0.026108473539352417 -2.1438427422193485e-011
		 -0.010866662487387657 -0.023770695552229881 0.9996565580368042 1.2031981633242594e-008
		 8.8400278091430664 14.266550064086914 -0.28954616189002991 1;
	setAttr ".dm[13]" -type "matrix" 0.92781960964202881 -0.37302938103675842 0.0012157544260844588 0
		 0.25172314047813416 0.62368804216384888 -0.74003469944000244 -5.9484013270605374e-009
		 0.27529618144035339 0.68692415952682495 0.67256957292556763 -7.6419466310539974e-009
		 8.9615869522094727 14.217658996582031 -0.28939563035964966 1;
	setAttr ".dm[14]" -type "matrix" 0.99559754133224487 0.023735836148262024 -0.090667158365249634 0
		 -0.021780941635370255 0.9995080828666687 0.022490063682198524 -6.3771441460858114e-009
		 0.091156467795372009 -0.020416256040334702 0.99562573432922363 -1.3200045501093882e-009
		 8.3433876037597656 14.417198181152344 -0.092596098780632019 1;
	setAttr ".dm[15]" -type "matrix" 0.97453832626342773 -0.22316591441631317 -0.021725930273532867 0
		 0.22357213497161865 0.97451192140579224 0.018492693081498146 -6.1608573798110911e-010
		 0.017045242711901665 -0.022879157215356827 0.99959313869476318 -3.4065772425151408e-009
		 8.7708902359008789 14.42739200592041 -0.13152730464935303 1;
	setAttr ".dm[16]" -type "matrix" 0.98395568132400513 -0.17463251948356628 0.036559078842401505 0
		 0.1735243946313858 0.98432469367980957 0.031586777418851852 5.9161564536225342e-010
		 -0.041501998901367188 -0.024736048653721809 0.99883288145065308 -2.2866240012575645e-009
		 8.9847917556762695 14.378402709960938 -0.13629528880119324 1;
	setAttr ".dm[17]" -type "matrix" 0.99623483419418335 0.02993105910718441 0.081384360790252686 0
		 -0.057968132197856903 0.92788290977478027 0.36834296584129333 2.3209438815285921e-009
		 -0.064490161836147308 -0.37167319655418396 0.92612290382385254 -2.666145526575292e-009
		 9.1405601501464844 14.350759506225586 -0.13051021099090576 1;
	setAttr ".dm[18]" -type "matrix" 0.9994584321975708 0.032134752720594406 -0.0070286178961396217 0
		 -0.031962219625711441 0.99921375513076782 0.023415219038724899 -3.5558578304062394e-010
		 0.0077755386009812355 -0.023177901282906532 0.99970030784606934 -1.5237505701648502e-009
		 8.224207878112793 14.409499168395996 0.073230981826782227 1;
	setAttr ".dm[19]" -type "matrix" 0.99549102783203125 0.094727322459220886 -0.0045509324409067631 0
		 -0.094593994319438934 0.99523085355758667 0.023748714476823807 -7.5974906921238983e-011
		 0.006778886541724205 -0.023211162537336349 0.99970489740371704 1.9256038985560053e-009
		 8.3379240036010742 14.413156509399414 0.072432287037372589 1;
	setAttr ".dm[20]" -type "matrix" 0.99798351526260376 0.017770733684301376 0.060972373932600021 0
		 -0.019276132807135582 0.99952375888824463 0.024191131815314293 2.0327233229977537e-009
		 -0.060513261705636978 -0.025317586958408356 0.9978477954864502 3.4861533104724174e-010
		 8.8415145874023437 14.461073875427246 0.070128358900547028 1;
	setAttr ".dm[21]" -type "matrix" 0.99610596895217896 -0.085577256977558136 -0.02112533338367939 0
		 0.086020894348621368 0.99606919288635254 0.02106759324669838 1.3025138745348386e-009
		 0.019239392131567001 -0.022802781313657761 0.99955213069915771 -3.6747067611031525e-009
		 9.0553550720214844 14.464871406555176 0.083194196224212646 1;
	setAttr ".dm[22]" -type "matrix" 0.99945104122161865 0.032211080193519592 -0.0081716263666749001 0
		 -0.014559886418282986 0.20340745151042938 -0.97898745536804199 -8.9630064481482918e-010
		 -0.029871990904211998 0.97856622934341431 0.20376420021057129 9.9608421511021561e-010
		 9.2346706390380859 14.449474334716797 0.079391799867153168 1;
	setAttr ".dm[23]" -type "matrix" 0.99311149120330811 0.065771885216236115 0.096970334649085999 0
		 -0.068005956709384918 0.9974859356880188 0.019913000985980034 -1.4403924719630368e-009
		 -0.095416873693466187 -0.026370402425527573 0.99508804082870483 1.4494467848180648e-009
		 8.3303050994873047 14.408358573913574 0.26678246259689331 1;
	setAttr ".dm[24]" -type "matrix" 0.99862629175186157 -0.051459163427352905 0.0096314745023846626 0
		 0.051212586462497711 0.99838972091674805 0.02430211566388607 -4.2510647779714361e-010
		 -0.0108665581792593 -0.023775534704327583 0.99965596199035645 3.0250532634390481e-010
		 8.8042335510253906 14.439739227294922 0.31305521726608276 1;
	setAttr ".dm[25]" -type "matrix" 0.993519127368927 -0.091886520385742188 0.066918350756168365 0
		 0.089920707046985626 0.99544084072113037 0.031824655830860138 4.8560937493391521e-009
		 -0.069537542760372162 -0.025601068511605263 0.99725234508514404 5.4768958257511713e-009
		 9.0138368606567383 14.428945541381836 0.31508010625839233 1;
	setAttr ".dm[26]" -type "matrix" 0.99706447124481201 0.030226167291402817 0.070300459861755371 0
		 -0.069537460803985596 -0.02560051903128624 0.9972500205039978 1.8368068177565533e-010
		 0.031942833214998245 -0.99921286106109619 -0.023423558101058006 2.5594897312686271e-009
		 9.1702136993408203 14.414483070373535 0.32561284303665161 1;
	setAttr ".dm[27]" -type "matrix" 0.97266089916229248 -0.13439719378948212 0.18938750028610229 0
		 0.11681392043828964 0.98798537254333496 0.10117951035499573 -7.1059735873291174e-009
		 -0.2007104903459549 -0.076290324330329895 0.97667497396469116 4.6261812158832072e-009
		 7.6385784149169922 14.28596019744873 0.33924058079719543 1;
	setAttr ".dm[28]" -type "matrix" 0.99725508689880371 0.060265813022851944 0.043079327791929245 0
		 -0.062017355114221573 0.99725329875946045 0.040549430996179581 -6.0630406251149793e-010
		 -0.040517117828130722 -0.043109644204378128 0.99825000762939453 3.9441228061320999e-009
		 8.0638647079467773 14.227202415466309 0.42205148935317993 1;
	setAttr ".dm[29]" -type "matrix" 0.99786454439163208 0.041041787713766098 -0.050765283405780792 0
		 -0.039778053760528564 0.99887615442276001 0.02565833181142807 -1.359458212668585e-009
		 0.051761411130428314 -0.023584248498082161 0.99837791919708252 -3.0429394559661205e-009
		 8.3944931030273437 14.247171401977539 0.43633270263671875 1;
	setAttr ".dm[30]" -type "matrix" 0.97709310054779053 0.20838208496570587 -0.043210949748754501 0
		 -0.20189517736434937 0.84344190359115601 -0.49784129858016968 -2.8551322417413871e-010
		 -0.067295238375663757 0.4951610267162323 0.86619198322296143 7.980813787611396e-010
		 8.7004604339599609 14.259756088256836 0.42075785994529724 1;
	setAttr ".dm[31]" -type "matrix" -0.99609494209289551 -0.088288486003875732 -2.4979922130796695e-008 0
		 2.044809832568717e-008 -4.8124246632141876e-007 1 -1.7957820785952094e-009 -0.088288486003875732 0.99609494209289551 5.292939135870256e-007 7.3138672895822765e-010
		 -0.83456933498382568 14.547185897827148 -2.9802322387695313e-008 1;
	setAttr ".dm[32]" -type "matrix" -0.9999537467956543 -0.0091877952218055725 0.0025703948922455311 0
		 -0.0027983174659311771 0.024880308657884598 -0.99968814849853516 1.7305885890994688e-010
		 0.009120977483689785 -0.99964910745620728 -0.024904750287532806 -2.6290067345335899e-010
		 -2.1885232925415039 14.427175521850586 -2.0710649550892413e-006 1;
	setAttr ".dm[33]" -type "matrix" -0.99963396787643433 0.00124886236153543 0.027018630877137184 0
		 -0.026981474831700325 0.023692265152931213 -0.99935436248779297 -9.3359797670444777e-010
		 -0.0018881862051784992 -0.99971699714660645 -0.023649824783205986 6.4658756127045081e-010
		 -4.7420353889465332 14.40371036529541 0.0065611749887466431 1;
	setAttr ".dm[34]" -type "matrix" -0.99966472387313843 -0.0059791593812406063 0.025183700025081635 0
		 -0.025318630039691925 0.023678630590438843 -0.99939894676208496 -2.1164853203359257e-010
		 0.0053792465478181839 -0.99970108270645142 -0.0238221175968647 -4.3040920827408513e-010
		 -5.9958829879760742 14.405269622802734 0.040446020662784576 1;
	setAttr ".dm[35]" -type "matrix" -0.99965810775756836 -0.0059917503967881203 0.025428503751754761 0
		 -0.025563647970557213 0.023677684366703033 -0.99939179420471191 3.8044342676180065e-010
		 0.0053860186599195004 -0.99970018863677979 -0.023822778835892677 1.4758216870802698e-010
		 -7.2258715629577637 14.397890090942383 0.071439161896705627 1;
	setAttr ".dm[36]" -type "matrix" -0.99628543853759766 0.061540689319372177 -0.060233499854803085 0
		 0.063925348222255707 0.99721139669418335 -0.038497231900691986 5.2720444676523925e-010
		 0.057696372270584106 -0.042204666882753372 -0.99744093418121338 6.8882496928601711e-011
		 -8.2371683120727539 14.430827140808105 -0.2434118241071701 1;
	setAttr ".dm[37]" -type "matrix" -0.97253769636154175 -0.20939713716506958 0.10161421447992325 0
		 -0.20890392363071442 0.97781330347061157 0.015591912902891636 -4.0412264645794949e-009
		 -0.10262437164783478 -0.0060638701543211937 -0.99470168352127075 2.2027553392423016e-012
		 -8.5884065628051758 14.452503204345703 -0.26464802026748657 1;
	setAttr ".dm[38]" -type "matrix" -0.98937404155731201 -0.14195069670677185 0.031446769833564758 0
		 -0.14266422390937805 0.98953258991241455 -0.021733220666646957 -2.3280040117867884e-009
		 -0.028032546862959862 -0.025988604873418808 -0.99926871061325073 3.122829425605822e-011
		 -8.8069267272949219 14.405462265014648 -0.24181747436523438 1;
	setAttr ".dm[39]" -type "matrix" 0.77380341291427612 -0.63340723514556885 -0.00523410364985466 0
		 0.39200550317764282 0.48535242676734924 -0.78151637315750122 8.8559399813448181e-009
		 0.49755761027336121 0.60268712043762207 0.62386536598205566 -1.1688987555658059e-008
		 -8.9365997314453125 14.386873245239258 -0.23769910633563995 1;
	setAttr ".dm[40]" -type "matrix" -0.96032464504241943 0.26708105206489563 -0.080276593565940857 0
		 0.26969397068023682 0.96266138553619385 -0.023483643308281898 2.1210121159409567e-010
		 0.071007020771503448 -0.044201962649822235 -0.99649584293365479 7.9883148706993978e-011
		 -8.2894802093505859 14.44503116607666 -0.058838650584220886 1;
	setAttr ".dm[41]" -type "matrix" -0.99934428930282593 -0.036098551005125046 0.0022782993037253618 0
		 -0.036142084747552872 0.99906814098358154 -0.023469507694244385 -1.6426186799645137e-011
		 -0.0014289668761193752 -0.023536559194326401 -0.99972182512283325 -1.6136212103914221e-013
		 -8.7018518447875977 14.559724807739258 -0.093300081789493561 1;
	setAttr ".dm[42]" -type "matrix" -0.99579876661300659 0.07250000536441803 0.055926740169525146 0
		 0.071779295802116394 0.99731135368347168 -0.014793313108384609 -9.9633457040226858e-010
		 -0.056848879903554916 -0.010716780088841915 -0.99832528829574585 2.2592353335348925e-011
		 -8.9211978912353516 14.551784515380859 -0.092800267040729523 1;
	setAttr ".dm[43]" -type "matrix" 0.96071124076843262 -0.27322319149971008 0.048760350793600082 0
		 0.24371692538261414 0.91456198692321777 0.32276135683059692 -1.1296443780395293e-009
		 -0.13278059661388397 -0.29819747805595398 0.94522148370742798 8.9678984238616977e-009
		 -9.0788393020629883 14.563243865966797 -0.083941273391246796 1;
	setAttr ".dm[44]" -type "matrix" -0.99912506341934204 0.041375875473022461 0.0060959276743233204 0
		 0.041504129767417908 0.99888074398040771 0.022678926587104797 1.6928732027299276e-010
		 -0.0051507400348782539 0.022912070155143738 -0.99972319602966309 2.4080422985489625e-012
		 -8.1900520324707031 14.437174797058105 0.10554839670658112 1;
	setAttr ".dm[45]" -type "matrix" -0.95189964771270752 0.3063930869102478 0.0032151683699339628 0
		 0.30614003539085388 0.95144903659820557 -0.031975936144590378 3.7704717126274545e-010
		 -0.012856278568506241 -0.029453599825501442 -0.99948346614837646 2.2887247652647602e-012
		 -8.2818794250488281 14.440986633300781 0.10610754042863846 1;
	setAttr ".dm[46]" -type "matrix" -0.94861364364624023 0.30893445014953613 0.068494252860546112 0
		 0.30709448456764221 0.95099121332168579 -0.036206316202878952 1.6942888758642027e-010
		 -0.076322734355926514 -0.013311585411429405 -0.99699431657791138 4.1375174120172886e-011
		 -8.7633991241455078 14.595954895019531 0.10773122310638428 1;
	setAttr ".dm[47]" -type "matrix" -0.98770511150360107 0.1562461256980896 -0.004874243400990963 0
		 0.15631765127182007 0.98695671558380127 -0.038486704230308533 -3.5029767281313795e-011
		 -0.0012027316261082888 -0.038775455206632614 -0.99924647808074951 -4.4855361558317902e-014
		 -8.9666757583618164 14.66214656829834 0.12240500003099442 1;
	setAttr ".dm[48]" -type "matrix" 0.96116447448730469 -0.27298787236213684 -0.040498584508895874 0
		 0.00068227213341742754 0.14909699559211731 -0.98882228136062622 -6.6594596503932735e-009
		 0.27597478032112122 0.9503934383392334 0.14349301159381866 7.3807662204217195e-009
		 -9.1444988250732422 14.690251350402832 0.12152598798274994 1;
	setAttr ".dm[49]" -type "matrix" -0.95423418283462524 0.27934423089027405 0.10678686946630478 0
		 0.2773231565952301 0.96018868684768677 -0.033636588603258133 4.3406100935783343e-009
		 -0.11193164438009262 -0.0024827080778777599 -0.9937126636505127 -5.5861350267694121e-011
		 -8.2717580795288086 14.436145782470703 0.30034208297729492 1;
	setAttr ".dm[50]" -type "matrix" -0.96087616682052612 0.2762855589389801 0.019576303660869598 0
		 0.27563932538032532 0.96078008413314819 -0.030361926183104515 1.0227639846149827e-009
		 -0.027197141200304031 -0.023778103291988373 -0.999347984790802 -9.0858700771412337e-012
		 -8.7271451950073242 14.569425582885742 0.35130387544631958 1;
	setAttr ".dm[51]" -type "matrix" -0.98194676637649536 0.1699889600276947 0.082971476018428802 0
		 0.16918586194515228 0.98544257879257202 -0.016666434705257416 -3.547305116313737e-009
		 -0.084596790373325348 -0.0023279529996216297 -0.99641257524490356 2.6210977832619164e-013
		 -8.9288301467895508 14.627405166625977 0.35540115833282471 1;
	setAttr ".dm[52]" -type "matrix" 0.95731270313262939 -0.28666377067565918 0.037056282162666321 0
		 -0.027832483872771263 0.036186039447784424 0.99895650148391724 1.0641102443642581e-009
		 -0.28770619630813599 -0.95734727382659912 0.026662847027182579 4.4919836739154562e-009
		 -9.0833873748779297 14.654154777526855 0.36846351623535156 1;
	setAttr ".dm[53]" -type "matrix" -0.9745941162109375 -0.10446441918611526 0.19812506437301636 0
		 -0.084943622350692749 0.99087977409362793 0.10461129993200302 8.0243012234859634e-009
		 -0.20724613964557648 0.085124030709266663 -0.97457844018936157 9.8622510158463683e-010
		 -7.58026123046875 14.307365417480469 0.3636319637298584 1;
	setAttr ".dm[54]" -type "matrix" -0.99582302570343018 0.091166391968727112 -0.0050217295065522194 0
		 0.090873353183269501 0.9949575662612915 0.042400483042001724 -2.4521026875667928e-010
		 0.0088619217276573181 0.041767101734876633 -0.99908792972564697 3.3401228831386742e-012
		 -8.0063943862915039 14.261672019958496 0.45025634765625 1;
	setAttr ".dm[55]" -type "matrix" -0.99518531560897827 0.072226695716381073 -0.066253058612346649 0
		 0.070601522922515869 0.99715065956115723 0.026554228737950325 -1.3013977673281829e-009
		 0.067982286214828491 0.02174883708357811 -0.99745017290115356 5.8505327318880695e-012
		 -8.3365554809570312 14.291890144348145 0.44858282804489136 1;
	setAttr ".dm[56]" -type "matrix" 0.7178492546081543 -0.20093594491481781 0.666573166847229 0
		 0.54664385318756104 0.75559043884277344 -0.36092451214790344 1.6466401575598866e-008
		 -0.43113300204277039 0.62346667051315308 0.65223956108093262 -9.4565804076296445e-009
		 -8.6416997909545898 14.314023971557617 0.42826628684997559 1;
	setAttr ".dm[57]" -type "matrix" 0.98830276727676392 -0.15249288082122803 0.0025242697447538376 0
		 0.15250858664512634 0.98827052116394043 -0.0080978982150554657 -5.5456843978118897e-011
		 -0.001259787823073566 0.008388136513531208 0.99996554851531982 -1.0401764782841383e-008
		 1.0568721294403076 9.1137886047363281 -0.05505940318107605 1;
	setAttr ".dm[58]" -type "matrix" -0.0070042009465396404 -0.99922895431518555 -0.03863232210278511 0
		 -0.0014414818724617362 -0.038623109459877014 0.99925261735916138 -2.376025243222557e-008
		 -0.99997562170028687 0.0070546809583902359 -0.001169780152849853 -3.8160390403163547e-008
		 1.0837283134460449 4.5857820510864258 -0.14138928055763245 1;
	setAttr ".dm[59]" -type "matrix" 0.028205897659063339 -0.47094354033470154 0.88171190023422241 0
		 -0.055320929735898972 0.87997567653656006 0.47178590297698975 -9.2425224806902406e-008
		 -0.9980701208114624 -0.06208430603146553 -0.0012325308052822948 -1.1134670074852693e-008
		 1.056147575378418 0.65123128890991211 -0.29350513219833374 1;
	setAttr ".dm[60]" -type "matrix" 1 -1.0271975270370604e-006 1.8081009045545215e-007 0
		 1.0271945711792796e-006 1 1.664178489590995e-005 -1.2568592508714529e-017 -1.8082717190281983e-007 -1.664178489590995e-005 1 0
		 1.0898599624633789 0.088292539119720459 0.71171385049819946 1;
	setAttr ".dm[61]" -type "matrix" 0.0020875541958957911 -0.053416881710290909 0.99857085943222046 0
		 -0.062060646712779999 0.99664074182510376 0.053443372249603271 -3.7238088168578543e-009
		 -0.99807029962539673 -0.062083464115858078 -0.0012345436261966825 4.3029083768297838e-011
		 1.0898599624633789 0.088291727006435394 0.76043504476547241 1;
	setAttr ".dm[62]" -type "matrix" 0.9980694055557251 0.062083452939987183 0.0012347409501671791 0
		 -0.062060661613941193 0.99664008617401123 0.053443234413862228 4.0482808078001753e-012
		 0.0020873493049293756 -0.053416717797517776 0.9985695481300354 -9.633663866637221e-010
		 1.091604471206665 0.044209476560354233 1.571702241897583 1;
	setAttr ".dm[63]" -type "matrix" 0.98830330371856689 0.15247100591659546 -0.0026895422488451004 0
		 -0.15249116718769073 0.98824763298034668 -0.010565065778791904 5.1438516640578413e-011
		 0.0010470693232491612 0.010851639322936535 0.99994057416915894 2.0577992643211473e-009
		 -1.1177505254745483 9.1137466430664062 -0.055059626698493958 1;
	setAttr ".dm[64]" -type "matrix" 0.0070037199184298515 -0.99935901165008545 -0.035084925591945648 0
		 0.0015674055321142077 -0.035074725747108459 0.99938195943832397 -2.7350118614322128e-008
		 -0.9999733567237854 -0.0070544220507144928 0.0013206767616793513 3.0672168804812827e-008
		 -1.0844866037368774 4.594846248626709 -0.13040332496166229 1;
	setAttr ".dm[65]" -type "matrix" -0.014951813966035843 -0.47128567099571228 0.88185387849807739 0
		 0.031000057235360146 0.88130998611450195 0.47152060270309448 3.8793452006302687e-008
		 -0.99940717220306396 0.034387573599815369 0.0014326907694339752 1.2884832756299147e-008
		 -1.0569132566452026 0.65981388092041016 -0.268553227186203 1;
	setAttr ".dm[66]" -type "matrix" 1 1.6773190836261165e-008 1.0627228164139524e-007 0
		 -1.6773187283547486e-008 1 -2.907754037551058e-008 -3.1763735522036263e-022 -1.0627228164139524e-007 2.9077536822796901e-008 1 0
		 -1.0677891969680786 0.088293075561523438 0.71141660213470459 1;
	setAttr ".dm[67]" -type "matrix" -0.00034631084417924285 -0.051796860992908478 0.99865758419036865 0
		 0.034413747489452362 0.99806702136993408 0.051778167486190796 -1.9194468237060391e-008
		 -0.99940919876098633 0.034385483711957932 0.0014368828851729631 -1.3532929221682366e-009
		 -1.0747808218002319 0.096452482044696808 0.78556281328201294 1;
	setAttr ".dm[68]" -type "matrix" 0.99940526485443115 -0.034385498613119125 -0.0014370532007887959 0
		 0.034413773566484451 0.99806302785873413 0.051778949797153473 -3.6403730724332561e-011
		 -0.00034617626806721091 -0.051797758787870407 0.99865567684173584 2.6908952843740508e-009
		 -1.0750218629837036 0.055965080857276917 1.5926623344421387 1;
	setAttr -s 69 ".sm";
	setAttr ".sm[0]" -type "matrix" 0.99999999999833422 1.8225802023122571e-006 9.8935068137797173e-008 0
		 -1.8225802456484829e-006 0.99999999999824318 4.380286213737726e-007 0 -9.8934269795329991e-008 -4.3802880169014376e-007 0.99999999999989919 0
		 -5.7220458984375e-006 10.402189254760742 -0.2471792995929718 1;
	setAttr ".sm[1]" -type "matrix" 1.8163169687450813e-006 0.99832396534067003 -0.057872793462748116 0
		 -7.6418895881866443e-008 -0.057872793462704797 -0.99832396534232182 0 -0.99999999999834754 1.8176953335802088e-006 -2.8824521726050482e-008 0
		 -8.4040566434850832e-006 11.096714973449707 -0.015667378902435268 1;
	setAttr ".sm[2]" -type "matrix" 1.804599352810893e-006 0.99062948476071866 -0.13657680593518348 0
		 -4.8797951888096334e-007 -0.13657680593451721 -0.99062948476233392 0 -0.99999999999825262 1.8543360111740962e-006 2.3694048366962243e-007 0
		 -6.5876103241994331e-006 12.095110035393278 -0.073544293831920265 1;
	setAttr ".sm[3]" -type "matrix" 3.5855822391878322e-007 0.94868254404900176 0.31623002801218181 0
		 2.213078235232778e-007 0.31623002801211919 -0.94868254404906449 0 -0.99999999999991118 4.1014210733511743e-007 -9.6563991938999004e-008 0
		 3.9175115799535579e-007 15.04306615057321 -0.41853559296120357 1;
	setAttr ".sm[4]" -type "matrix" 1.6430966447362335e-006 0.99987405065201029 -0.015870816930499021 0
		 4.8454071659125968e-007 -0.015870816931314646 -0.99987405065322987 0 -0.99999999999853262 1.6351996408248076e-006 -5.1055697514779753e-007 0
		 -1.2704189138102648e-006 15.773371707252091 -0.17509541522394831 1;
	setAttr ".sm[5]" -type "matrix" 0.99609716363394363 -0.088263472628331285 -2.8286697363773261e-009 0
		 -3.3685691852917403e-008 -4.1220780082340536e-007 0.99999999999991429 0 -0.088263472628324888 -0.99609716363385847 -4.1357223732121917e-007 0
		 0.83456842326307101 14.547159238055494 -5.9058585860291557e-007 1;
	setAttr ".sm[6]" -type "matrix" 0.99997037879282824 0.00260488122867987 0.0072426604719386745 0
		 -0.0071753275937823302 -0.024990379698661105 0.9996619406561591 0 0.0027849974594631594 -0.99968429792425029 -0.024970948577288023 0
		 2.188517795705208 14.427185122126355 -4.6315163755041341e-007 1;
	setAttr ".sm[7]" -type "matrix" 0.9993292387607513 -0.027183435963703855 0.024538405960129139 0
		 0.025176634494754865 0.023390530424574348 -0.99940933563879319 0 0.026593413345683988 0.99935676507224602 0.024059228394969778 0
		 4.7420978543169561 14.433837886986753 0.018495919427816143 1;
	setAttr ".sm[8]" -type "matrix" 0.99988783708116979 -0.014946485222658606 0.000956993536243924 0
		 0.0013143163231408017 0.02391531537423441 -0.99971312398265189 0 0.014919310632274198 0.99960225103289946 0.023932277372158969 0
		 6.0508526786315002 14.39823755470481 0.05063223240223963 1;
	setAttr ".sm[9]" -type "matrix" 0.9998879362858355 -0.014947102667797559 0.00083605734903630026 0
		 0.0011934722914031628 0.023919083103863564 -0.99971318541237586 0 0.014922817895498524 0.99960215165099997 0.02393424159544227 0
		 7.2811869155254758 14.379836620253156 0.051809284334840104 1;
	setAttr ".sm[10]" -type "matrix" 0.99000577425722536 -0.11563870075634679 -0.080723341263449391 0
		 0.11693554555781452 0.9930727928037153 0.01151114147795539 0 0.078833020508207896 -0.020835524481358843 0.99667007369396743 0
		 8.2885265349483763 14.403511043090873 -0.27647246075689619 1;
	setAttr ".sm[11]" -type "matrix" 0.90114136474297357 -0.42809020609062376 0.068432566797235153 0
		 0.4244911967388994 0.90335754806491331 0.06125654451015819 0 -0.088042402513491796 -0.026151783943649684 0.99577337760969298 0
		 8.6375354292991489 14.362737906055244 -0.30492942867570344 1;
	setAttr ".sm[12]" -type "matrix" 0.927816919476109 -0.37303389427699052 0.0012155880907120248 0
		 0.3728775576238752 0.92751315575353011 0.026108866780877864 0 -0.010866966196542691 -0.023770982829304895 0.99965836635373151 0
		 8.8400259030701775 14.266547201460542 -0.28954953370018299 1;
	setAttr ".sm[13]" -type "matrix" 0.92781699716961774 -0.37303370060915031 0.0012157191272025338 0
		 0.25172604190617603 0.62368635126597871 -0.74003333375651381 0 0.27529914563870972 0.68692153369535103 0.67256909455923042 0
		 8.9615944990773304 14.217661468458413 -0.28939645984923984 1;
	setAttr ".sm[14]" -type "matrix" 0.99559855577111978 0.023726883540848211 -0.090667252874999688 0
		 -0.021772024518877078 0.99950998071881769 0.022489495143682845 0 0.091156429805085898 -0.020416499232418592 0.99562727557268227 0
		 8.3433872194461571 14.417198185924581 -0.092596090622621197 1;
	setAttr ".sm[15]" -type "matrix" 0.97453782368147635 -0.2231681434550484 -0.021725790227246092 0
		 0.22357435673925521 0.97451143867577927 0.018492238877185201 0 0.017045152472173183 -0.022878715805078654 0.99959293071745436 0
		 8.770886420713639 14.42738628104674 -0.13152742298196479 1;
	setAttr ".sm[16]" -type "matrix" 0.98395850658549422 -0.17461132840313645 0.036558737824708552 0
		 0.17350311760383758 0.98432668907644028 0.031585397790142342 0 -0.041500909626087171 -0.024735665851249013 0.99883222882278955 0
		 8.984796336842745 14.378401133739867 -0.13629620860774244 1;
	setAttr ".sm[17]" -type "matrix" 0.99623267994048503 0.029952346290317788 0.081383686143499612 0
		 -0.057987619064436002 0.92788049237695724 0.36834118409639316 0 -0.064481652071241305 -0.37167277115495045 0.92612173483196147 0
		 9.140561521881553 14.350766765770617 -0.13050835725134205 1;
	setAttr ".sm[18]" -type "matrix" 0.9994588323377076 0.032134735789496389 -0.007028599994651186 0
		 -0.031962222885231789 0.99921476285125688 0.023415251618151688 0 0.0077755238010257096 -0.023177930361571359 0.99970111772157833 0
		 8.2242047199004737 14.409499264158743 0.073230944058723393 1;
	setAttr ".sm[19]" -type "matrix" 0.99549346410140171 0.094720912688143089 -0.0045510032867325237 0
		 -0.094587581104945584 0.99523322979386997 0.02374884870425276 0 0.0067788223244168704 -0.023211355272524013 0.9997075975275499 0
		 8.3379278929870502 14.413155414889728 0.072431353992106554 1;
	setAttr ".sm[20]" -type "matrix" 0.99798036056275996 0.017821244973071956 0.060972150680723439 0
		 -0.019326509753179635 0.99952060587981273 0.024187691961252988 0 -0.060511866206417145 -0.025317220409475608 0.99784635711062919 0
		 8.8415098706979229 14.461070687982669 0.070129208064334161 1;
	setAttr ".sm[21]" -type "matrix" 0.99610327322506431 -0.08562711319719464 -0.021125022031404699 0
		 0.086070620476365226 0.9960663807138278 0.021062134328445323 0 0.019238434477004962 -0.022798304699490301 0.99955496094096885 0
		 9.0553569786390256 14.4648885724966 0.083194631691951584 1;
	setAttr ".sm[22]" -type "matrix" 0.9994492894492184 0.032161120358693993 -0.0081719126724269248 0
		 -0.01454986034662744 0.20340244371214083 -0.97898710280361789 0 -0.029823135035502477 0.97856686446517438 0.20375836765014377 0
		 9.2346702397704234 14.449474430889634 0.079391816568516071 1;
	setAttr ".sm[23]" -type "matrix" 0.99311186627251746 0.065769120034912421 0.0969703249378394 0
		 -0.068003204318038649 0.99748635515919681 0.019913198479885343 0 -0.095416902439745738 -0.026370326525348566 0.99508804666107298 0
		 8.3303055389677478 14.408359026647231 0.26678247213995582 1;
	setAttr ".sm[24]" -type "matrix" 0.99862808843641715 -0.051470153422574175 0.0096314221423182134 0
		 0.051223569630767338 0.99839147518413118 0.02430243185230542 0 -0.010866779656769923 -0.023775735242273791 0.99965825536209107 0
		 8.8042379572501268 14.439745337862545 0.31305860895816967 1;
	setAttr ".sm[25]" -type "matrix" 0.99352016632945761 -0.091867185849642902 0.066918601754321599 0
		 0.089901471494023277 0.99544212803682697 0.03182287153482944 0 -0.069537072989130269 -0.025600583852328759 0.99725082380839547 0
		 9.0138365760349419 14.42894244418177 0.31508011506373518 1;
	setAttr ".sm[26]" -type "matrix" 0.9970672036283097 0.030245537540009512 0.070300774588463885 0
		 -0.069537152131826235 -0.025600201341742571 0.997250828109286 0 0.031962101342330115 -0.99921461015648583 -0.023421932618904413 0
		 9.1702134078430007 14.414482848939366 0.32561288458971976 1;
	setAttr ".sm[27]" -type "matrix" 0.97266072244438195 -0.13439533143394658 0.18939116637988229 0
		 0.11681177838506396 0.98798666483718345 0.10117983264671887 0 -0.20071404396427092 -0.076290530163703685 0.97667478085739945 0
		 7.6385801782559071 14.285955948634461 0.33923799989089815 1;
	setAttr ".sm[28]" -type "matrix" 0.99725304476795318 0.060267568633911334 0.043060247003507801 0
		 -0.062018300125998488 0.99725097892389303 0.040548927048923197 0 -0.040498088233000246 -0.043108064283775456 0.99824926728907626 0
		 8.0638644677532323 14.227202158681697 0.4220530276404087 1;
	setAttr ".sm[29]" -type "matrix" 0.99786765295036861 0.041043740170389219 -0.050749961459572501 0
		 -0.039780431142846656 0.99887897338404918 0.025657627117827098 0 0.051746154382830763 -0.023584060804997208 0.9983817544319078 0
		 8.3945010489257594 14.24717386310774 0.43632863142063061 1;
	setAttr ".sm[30]" -type "matrix" 0.97709278391114085 0.20838380953073374 -0.043195827972560968 0
		 -0.20188886376120679 0.84344055898297055 -0.4978442629494722 0 -0.067309570775522146 0.49516079346809488 0.86619005437263097 0
		 8.7004580621102932 14.259758563480689 0.4207581385203496 1;
	setAttr ".sm[31]" -type "matrix" -0.99609494195385528 -0.088288541804388693 -1.8623607954838112e-008 0
		 2.6027177584992478e-008 -5.0458583752618913e-007 0.99999999999987244 0 -0.08828854180438675 0.99609494195372783 5.0491330203655815e-007 0
		 -0.83456941224081393 14.54718586415855 -2.8098199298526305e-008 1;
	setAttr ".sm[32]" -type "matrix" -0.9999705459863687 0.002644604993140745 0.0072050832162938059 0
		 -0.0071374643178286267 0.024744490777040797 -0.9996683283866189 0 -0.0028220139679293182 -0.99969031016641152 -0.024724886178698804 0
		 -2.1885238518496894 14.427175881906878 -2.0709456830813191e-006 1;
	setAttr ".sm[33]" -type "matrix" -0.99973531424253037 0.013081779036893948 0.018925340515264528 0
		 -0.018611446633265 0.023713829999916839 -0.99954553088938991 0 -0.013524626080079375 -0.9996331933884377 -0.023464082454447439 0
		 -4.7420717616028876 14.433929096585022 0.01839825494871836 1;
	setAttr ".sm[34]" -type "matrix" -0.99983678905832196 0.0058540865176686064 0.017091662194999496 0
		 -0.016948551044502921 0.023680671838551059 -0.99957589626739551 0 -0.0062563458213406318 -0.99970243345323473 -0.023577588609637028 0
		 -5.9960446322307908 14.450328595051749 0.042136944964937105 1;
	setAttr ".sm[35]" -type "matrix" -0.99983719918698721 0.0058508302253672531 0.017068769949660698 0
		 -0.016925745533960961 0.023680035091354794 -0.99957629777630885 0 -0.0062525402869645589 -0.99970246759910864 -0.023577150298832728 0
		 -7.226247837266536 14.457507440719439 0.063166475399890815 1;
	setAttr ".sm[36]" -type "matrix" -0.99260045165479271 -0.094890868546591595 -0.07576322617982037 0
		 -0.096039239609574278 0.99530934167828444 0.011652417052072317 0 0.074302138797721601 0.018842437061435159 -0.99705774894720656 0
		 -8.2344789514224903 14.502323152912336 -0.26012955227452622 1;
	setAttr ".sm[37]" -type "matrix" -0.90965734170496237 -0.4088770370869087 0.073096437842700424 0
		 -0.40494668308440124 0.91216970969734223 0.062965105968371488 0 -0.092421342455096825 0.027676510865673423 -0.99533527326479332 0
		 -8.584414812536961 14.468851138431999 -0.2868417039271971 1;
	setAttr ".sm[38]" -type "matrix" -0.93526936803077887 -0.35388652115120534 0.0059614906529162626 0
		 -0.35360465887093323 0.93498877378992351 0.027563347249317902 0 -0.015328223904874066 0.023671143493995773 -0.99960228216906821 0
		 -8.7888026327923328 14.376981944911247 -0.27041791343582372 1;
	setAttr ".sm[39]" -type "matrix" 0.89271103414080089 -0.44997149941454906 -0.024344593606878257 0
		 0.28249081911295248 0.60089632156430783 -0.74774497514017291 0 0.35109250439186929 0.66064306584199217 0.66353959408217622 0
		 -8.911395214811682 14.330613593813935 -0.26963954476707647 1;
	setAttr ".sm[40]" -type "matrix" -0.99531554913250952 0.044675013644172014 -0.085738560816845028 0
		 0.042942318765063547 0.9988364229949962 0.021948971676174538 0 0.086619368008144917 0.018164340187710938 -0.9960758715235577 0
		 -8.2881269456704683 14.517198564656221 -0.075993325263920955 1;
	setAttr ".sm[41]" -type "matrix" -0.97911522825794473 -0.20261093420972431 -0.016798188356350913 0
		 -0.20291779731469523 0.97900790122425896 0.019180637982724829 0 0.012559352146702396 0.022188706116736848 -0.99967490915523161 0
		 -8.7155206489296351 14.536381459346908 -0.11280043557291206 1;
	setAttr ".sm[42]" -type "matrix" -0.98718914493383148 -0.15406133155870122 0.041505400168777976 0
		 -0.15280029803728357 0.98773789320134309 0.032030036745059942 0 -0.045931046630005551 0.025277667070609067 -0.99862474358636855 0
		 -8.9304275121224634 14.491899724122206 -0.11648786851200206 1;
	setAttr ".sm[43]" -type "matrix" 0.99710463151909368 -0.054264966868713072 0.053269758530613449 0
		 0.030881454580930445 0.92913360967111225 0.36845226440136764 0 -0.069488772950299871 -0.36574041169970123 0.928119206612812 0
		 -9.08670838549466 14.467495135766692 -0.10991630619429703 1;
	setAttr ".sm[44]" -type "matrix" -0.99858194329444616 0.053195353873278985 -0.0020873074962761591 0
		 0.053134033320156912 0.99832648121310041 0.022825674399723724 0 0.0032980341750565544 0.022682399233026031 -0.99973728135726436 0
		 -8.190146268019193 14.508213802372373 0.089203284755481588 1;
	setAttr ".sm[45]" -type "matrix" -0.99329276000194489 0.1156260155459541 0.00034271954324362501 0
		 0.11560361257181456 0.99303257894240005 0.022849549653165213 0 0.0023016707115336541 0.022735911857092055 -0.99973885621394265 0
		 -8.2819242472841097 14.513112069876806 0.089010317143884382 1;
	setAttr ".sm[46]" -type "matrix" -0.99706435332079424 0.038966919352568644 0.065910959127876881 0
		 0.04060228080734779 0.99889530529443571 0.023656370262109132 0 -0.064916331768111596 0.026263058788098956 -0.9975450474103239 0
		 -8.7843789946594004 14.571582196407794 0.089179935859107204 1;
	setAttr ".sm[47]" -type "matrix" -0.99778600735403722 -0.064516206884351543 -0.016147525437186686 0
		 -0.06484982778022394 0.99767260826199367 0.021068140890603212 0 0.014750707283528022 0.022068660425285821 -0.99964763334970652 0
		 -8.9980412472618596 14.579921749968017 0.10330369533491751 1;
	setAttr ".sm[48]" -type "matrix" 0.99797203759452513 -0.052259225352613126 -0.036342613348186531 0
		 -0.024909101731516711 0.20479152338305329 -0.97848861444647262 0 0.058577716158620813 0.97740953817526954 0.20307448351195378 0
		 -9.1776648626530832 14.568289205250936 0.10039186766419496 1;
	setAttr ".sm[49]" -type "matrix" -0.99101022773703618 0.08672980260411739 0.10186594063198018 0
		 0.089120196744990332 0.99583685077710238 0.019145682711205807 0 -0.0997813562381345 0.028051880054548835 -0.99461388134928208 0
		 -8.2734498965639229 14.508208276146494 0.28332232333655605 1;
	setAttr ".sm[50]" -type "matrix" -0.99942324367200075 -0.030660053046790411 0.014599354619439925 0
		 -0.030302279046685837 0.99924954275910427 0.024127229022386315 0 -0.015328140549751859 0.023670919772790927 -0.99960228874507751 0
		 -8.7463850429187247 14.549566513363844 0.33192498991140351 1;
	setAttr ".sm[51]" -type "matrix" -0.99489049245647654 -0.070891095791767694 0.071884355440885006 0
		 -0.06875033117793268 0.99712589499577897 0.031833025175001105 0 -0.073934430292209946 0.02672830084966335 -0.996904859026706 0
		 -8.9561576332988739 14.543118963741939 0.3349890893195282 1;
	setAttr ".sm[52]" -type "matrix" 0.99764729011520503 -0.054053850056496752 0.042167117756099159 0
		 -0.043330424683414318 -0.02053256827776025 0.9988497824681517 0 -0.053125877146094388 -0.99832689783156192 -0.022826437380134512 0
		 -9.1127487957070095 14.531960373342798 0.34630335199632906 1;
	setAttr ".sm[53]" -type "matrix" -0.9818394713102967 -0.092928581160956203 0.165395076651418 0
		 -0.076687416192391528 0.99182187747731754 0.10202158377081115 0 -0.17352317647752932 0.087485096792432715 -0.9809363205959738 0
		 -7.5841151218360761 14.371266086307473 0.35240281638142046 1;
	setAttr ".sm[54]" -type "matrix" -0.99448608682427564 0.10309282984412477 0.019216959896650565 0
		 0.1038785476794237 0.99353710647592264 0.04575221729561732 0 -0.014376037178333662 0.047496173426730341 -0.99876796257432354 0
		 -8.0134168240251231 14.330614674032409 0.42471564334381079 1;
	setAttr ".sm[55]" -type "matrix" -0.99366984678280801 0.083957506454608116 -0.074641628496135065 0
		 0.081891519496340826 0.99617973839412932 0.030326685403866124 0 0.076902630834133415 0.024022196463460335 -0.99674917579492395 0
		 -8.3431339265600606 14.364796638388933 0.431082195718207 1;
	setAttr ".sm[56]" -type "matrix" 0.70965209202548374 -0.21128653996819308 0.672124918681136 0
		 0.55846080660308717 0.75030852901484446 -0.35377766856573906 0 -0.42955259954059555 0.62641448683427658 0.65045326881496024 0
		 -8.6478113692734286 14.390527891558358 0.40819354501552824 1;
	setAttr ".sm[57]" -type "matrix" 0.98830138592116545 -0.1524926943408392 0.0025196743788015569 0
		 0.15250830637989179 0.98826925593612158 -0.0080681011769608794 0 -0.0012597902368502636 0.0083579868470824541 0.99996427785417574 0
		 1.0568721067207663 9.1137882114517019 -0.055059408206639279 1;
	setAttr ".sm[58]" -type "matrix" -0.0070042068107996347 -0.99923107989864268 -0.038577066393700912 0
		 -0.0014384109611116662 -0.038567905116611595 0.99925494628189038 0 -0.99997443570366296 0.0070544779756208098 -0.0011671673543136565 0
		 1.0837287023625006 4.5857849122968979 -0.14152571569129996 1;
	setAttr ".sm[59]" -type "matrix" 0.028207978296129692 -0.47096870747920777 0.88169880715344628 0
		 -0.055319767847580872 0.87996251479153087 0.47181108067430388 0 -0.99807015447098479 -0.062084210046752103 -0.0012319160425778304 0
		 1.0561468914112684 0.65122079867995453 -0.29342582832023578 1;
	setAttr ".sm[60]" -type "matrix" 0.99999999999933675 -1.1356646611171417e-006 1.9400856373849584e-007 0
		 1.1356624025054413e-006 0.99999999993157418 1.1643103898950624e-005 0 -1.9402178625185784e-007 -1.1643103678793398e-005 0.99999999993220068 0
		 1.0898626331277113 0.088258573405622487 0.7117790871252615 1;
	setAttr ".sm[61]" -type "matrix" 0.0020877328206675831 -0.053411850866313761 0.99857038588108815 0
		 -0.062060494741380541 0.99664077451269661 0.05343839042474105 0 -0.99807020612987218 -0.062083337263445261 -0.00123404623445073 0
		 1.0898626236747382 0.088258006139736569 0.76050027878723936 1;
	setAttr ".sm[62]" -type "matrix" 0.99807020187253603 0.062083397776619503 0.0012344450680524751 0
		 -0.062060576770755507 0.99664077711221843 0.05343824667814321 0 0.0020873296330783 -0.053411732022684039 0.99857039308069862 0
		 1.0916023961499084 0.044185627620838261 1.5717727323394746 1;
	setAttr ".sm[63]" -type "matrix" 0.98830425356055596 0.15247132240534383 -0.0026829532380944956 0
		 -0.15249132880161642 0.98824881466960846 -0.010520215987861688 0 0.0010473941137017614 0.010806301313569102 0.99994106167188224 0
		 -1.1177505745992526 9.1137464253806844 -0.055059623369649834 1;
	setAttr ".sm[64]" -type "matrix" 0.0070035269854729909 -0.99936286466425428 -0.034997361897990693 0
		 0.0015651646846284719 -0.034987222132405765 0.9993865341032806 0 -0.99997425010310814 -0.0070540071954086347 0.0013191335085505737 0
		 -1.0844866062656919 4.5948500626073976 -0.13060821176669601 1;
	setAttr ".sm[65]" -type "matrix" -0.014952882763997703 -0.47133775409634393 0.88182602187759263 0
		 0.030999517142655312 0.88128214427485885 0.47157270077818231 0 -0.99940754511558905 0.034387552191471812 0.0014335342027437855 0
		 -1.0569123333863133 0.65980110681669313 -0.26841389854296638 1;
	setAttr ".sm[66]" -type "matrix" 0.999999999999994 1.6773219117457994e-008 1.0627225354060965e-007 0
		 -1.6773216001894631e-008 0.99999999999999944 -2.9070264084829489e-008 0 -1.0627225400898499e-007 2.9070262419494952e-008 0.99999999999999378 0
		 -1.0677903849269703 0.08822716565032418 0.71152381639879536 1;
	setAttr ".sm[67]" -type "matrix" -0.00034631139625114672 -0.051796860858203946 0.99865758159323692 0
		 0.034413696166694756 0.99806549254739263 0.051778085154600313 0 -0.99940761333129879 0.034385429928480898 0.0014368799776886968 0
		 -1.0747820123531053 0.096386568727443889 0.78567001502164857 1;
	setAttr ".sm[68]" -type "matrix" 0.9994076081974429 -0.034385571787489272 -0.0014370559882235109 0
		 0.034413846612197575 0.99806543650406188 0.051779065434871055 0 -0.00034617685943305946 -0.051797846565315143 0.9986575305142289 0
		 -1.0750144450858365 0.055895094434143366 1.5927691824619008 1;
	setAttr ".ltt" 0;
	setAttr ".lit" 0;
	setAttr ".lmt" 0;
	setAttr ".lrt" 0;
	setAttr ".lpt" 0;
	setAttr ".lxt" 0;
	setAttr ".rtt" 0;
	setAttr ".rit" 0;
	setAttr ".rmt" 0;
	setAttr ".rrt" 0;
	setAttr ".rpp" 0;
	setAttr ".rxt" 0;
	setAttr ".til" 0;
	setAttr ".tir" 0;
createNode hikEffector -n "HipsEff" -p "humanIK1";
	setAttr ".t" -type "double3" -0.030439198017120361 9.1137676239013672 -0.055059514939785004 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".s" -type "double3" 3.7299703073354293 3.7299703073354293 3.7299703073354293 ;
	setAttr ".radi" 0.10062489668414032;
createNode hikFloorContactMarker -n "hikFloorContactMarker1" -p "HipsEff";
	setAttr -k off ".v";
	setAttr ".msz" 0.080499917347312253;
	setAttr ".dhc" no;
	setAttr ".hfc" yes;
	setAttr ".dfc" no;
	setAttr ".fec" yes;
	setAttr ".fic" yes;
	setAttr ".tfc" yes;
	setAttr ".hh" 0.14474663138389587;
	setAttr ".hb" 0;
	setAttr ".hm" 1.0108942985534668;
	setAttr ".hf" 0.97509688138961792;
	setAttr ".his" 0.49649780988693237;
	setAttr ".hos" 0.29649779200553894;
	setAttr ".fh" 0.65122079849243164;
	setAttr ".fra" 0.39073246717453003;
	setAttr ".fma" 0.92878276109695435;
	setAttr ".ffm" 0.97509688138961792;
	setAttr ".fia" 1.6964977979660034;
	setAttr ".foa" 0.49649780988693237;
createNode hikEffector -n "LeftFootEff" -p "humanIK1";
	setAttr ".t" -type "double3" 1.056147575378418 0.65123128890991211 -0.29350513219833374 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.0016238772662993796 -0.0001346827275581807 3.4170027142597502e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 3.0940249211333852 3.0940249211333852 3.0940249211333852 ;
	setAttr ".pin" 3;
	setAttr ".ei" 1;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "LeftFootIndex1Eff" -p "LeftFootEff";
	setAttr ".t" -type "double3" 0.011461201830420709 -0.19620872275075382 0.60283615462806439 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.001910318333770175 0.00012287817807362584 3.8968874352816928e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 5.953330386223282 5.953330386223282 5.953330386223282 ;
	setAttr ".ei" 33;
	setAttr ".radi" 0.010062489668414033;
createNode hikEffector -n "RightFootEff" -p "humanIK1";
	setAttr ".t" -type "double3" -1.0569132566452026 0.65981388092041016 -0.268553227186203 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.0033843587298075643 6.7021283340927456e-005 1.7055679188249441e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 3.0940249211333852 3.0940249211333852 3.0940249211333852 ;
	setAttr ".pin" 3;
	setAttr ".ei" 2;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "RightFootIndex1Eff" -p "RightFootEff";
	setAttr ".t" -type "double3" -0.0058534762703918441 -0.19520163945755736 0.60154003809786372 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.003384305370952129 -6.7966670089683332e-005 -1.7095825904254948e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 5.953330386223282 5.953330386223282 5.953330386223282 ;
	setAttr ".ei" 39;
	setAttr ".radi" 0.010062489668414033;
createNode hikEffector -n "LeftHandEff" -p "humanIK1";
	setAttr ".t" -type "double3" 7.2811870574951172 14.379838943481445 0.051809277385473251 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0 0 -0.0001107237697481158 ;
	setAttr -av ".rz";
	setAttr ".s" -type "double3" 3.8622496542238491 3.8622496542238491 3.8622496542238491 ;
	setAttr ".ei" 3;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "LeftHandThumb1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 0.36747329551042385 -0.031090717389356648 0.09552686014388867 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 9.2839587090715476e-006 0.00088708082354289268 3.5752487952015546e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 20;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "LeftHandIndex1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 0.48910006965155994 0.0089708798050978089 0.070892249378996047 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.0001024527658794936 7.6315887990191815e-006 -0.00099320555471859293 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 21;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "LeftHandMiddle1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 0.50578901465702653 0.018030726277632692 0.007141569020924117 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.00031504231873948568 -7.3282886542555214e-006 0.0029644625968659258 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 22;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "LeftHandRing1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 0.48142230961436927 -0.0075282145461583738 -0.047205516136687331 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 7.1610590252024992e-005 -3.0575006587640621e-005 -0.0011110263178527409 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 23;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "LeftHandPinky1Eff" -p "LeftHandEff";
	setAttr ".t" -type "double3" 0.43508326974288702 -0.041990216597847407 -0.088343566131716261 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -1.7075446885367221e-005 9.3648720217458167e-006 0.00040100678341607022 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 24;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "RightHandEff" -p "humanIK1";
	setAttr ".t" -type "double3" -7.2258715629577637 14.397890090942383 0.071439161896705627 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.017121807709099556 0.47899595392825861 0.67846110430893869 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 3.8622496542238491 3.8622496542238491 3.8622496542238491 ;
	setAttr ".ei" 4;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "RightHandThumb1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -0.36757219596642066 -0.017345377933875472 0.089323835331498166 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.19292583936180116 0.019378801299115712 -0.016014609656094875 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 26;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "RightHandIndex1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -0.48074816628054884 0.072063148227087037 0.072866474280525756 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -2.7140298729283607 -0.025213922848368292 -14.370158556599279 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 27;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "RightHandMiddle1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -0.49592409732366982 0.081576703544446794 0.0087983293986026775 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -3.3531602831623712 -0.047034656835824508 -13.415442575360919 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 28;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "RightHandRing1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -0.47887018496235378 0.048477524345705625 -0.044249921518652854 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -2.6819857194576007 -0.063046198293304739 -13.591262907620957 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 29;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "RightHandPinky1Eff" -p "RightHandEff";
	setAttr ".t" -type "double3" -0.44225378252833258 0.0023675798384847901 -0.083741846541531731 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -3.0661397341948473 -0.10303245701160306 -13.196229527367001 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6332836187550606 2.6332836187550606 2.6332836187550606 ;
	setAttr ".ei" 30;
	setAttr ".radi" 0.012074987602096838;
createNode hikEffector -n "LeftLegEff" -p "humanIK1";
	setAttr ".t" -type "double3" 1.0837283134460449 4.5857820510864258 -0.14138928055763245 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.0031657922602121849 -0.00017416961539395572 -6.8350004078015829e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 5.0136443562911905 5.0136443562911905 5.0136443562911905 ;
	setAttr ".ei" 5;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "RightLegEff" -p "humanIK1";
	setAttr ".t" -type "double3" -1.0844866037368774 4.594846248626709 -0.13040332496166229 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.0050236041216841255 0.0001297729949626258 1.3666068123350437e-005 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 5.0136443562911905 5.0136443562911905 5.0136443562911905 ;
	setAttr ".ei" 6;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "LeftForeArmEff" -p "humanIK1";
	setAttr ".t" -type "double3" 4.7420978546142578 14.433837890625 0.018495911732316017 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0 0 5.6562504064149725e-005 ;
	setAttr -av ".rz";
	setAttr ".s" -type "double3" 3.9277992763925029 3.9277992763925029 3.9277992763925029 ;
	setAttr ".ei" 7;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "RightForeArmEff" -p "humanIK1";
	setAttr ".t" -type "double3" -4.7420353889465332 14.40371036529541 0.0065611749887466431 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.016960537437557478 0.4636535188010586 0.67792421815302695 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.6801769534142732 2.6801769534142732 2.6801769534142732 ;
	setAttr ".ei" 8;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "SpineEff" -p "humanIK1";
	setAttr ".t" -type "double3" -8.4040566434850916e-006 11.096714973449707 -0.015667378902435303 ;
	setAttr -av -k off ".tz";
	setAttr -av -k off ".ty";
	setAttr -av -k off ".tx";
	setAttr ".r" -type "double3" 1.7075472925031896e-006 -3.41509458500637e-006 1.7075471907254374e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 5.6556620598963798 5.6556620598963798 5.6556620598963798 ;
	setAttr ".ei" 9;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "LeftToeBaseEff" -p "humanIK1";
	setAttr ".t" -type "double3" 1.0898599624633789 0.088292539119720459 0.71171385049819946 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.00028640333052450221 0 6.2147631364797674e-006 ;
	setAttr -av ".rz";
	setAttr -av ".rx";
	setAttr ".ei" 11;
	setAttr ".radi" 0.020124979336828067;
createNode hikEffector -n "RightToeBaseEff" -p "humanIK1";
	setAttr ".t" -type "double3" -1.0677891969680786 0.088293075561523438 0.71141660213470459 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".ei" 12;
	setAttr ".radi" 0.020124979336828067;
createNode hikEffector -n "LeftArmEff" -p "humanIK1";
	setAttr ".t" -type "double3" 2.1885225772857666 14.427184104919434 -4.6303122758217796e-007 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0 0 2.1504425343405014e-005 ;
	setAttr -av ".rz";
	setAttr ".ei" 13;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "RightArmEff" -p "humanIK1";
	setAttr ".t" -type "double3" -2.1885232925415039 14.427175521850586 -2.0710649550892413e-006 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.0095772107523675095 -0.26557761517997797 0.67788776444286736 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".ei" 14;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "HeadEff" -p "humanIK1";
	setAttr ".t" -type "double3" -1.2704319942713482e-006 15.773378372192383 -0.17509329319000244 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -2.3905662095043832e-005 -1.3660379968469181e-005 -5.1226390277325549e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 3.9903790014274119 3.9903790014274119 3.9903790014274119 ;
	setAttr ".ei" 15;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "LeftUpLegEff" -p "humanIK1";
	setAttr ".t" -type "double3" 1.0568721294403076 9.1137886047363281 -0.05505940318107605 ;
	setAttr -av -k off ".tz";
	setAttr -av -k off ".ty";
	setAttr -av -k off ".tx";
	setAttr ".r" -type "double3" -0.0017267569905802232 -5.7853952629803025e-027 -3.4150974347833665e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 3.7094966429528049 3.7094966429528049 3.7094966429528049 ;
	setAttr ".ei" 16;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "RightUpLegEff" -p "humanIK1";
	setAttr ".t" -type "double3" -1.1177505254745483 9.1137466430664062 -0.055059626698493958 ;
	setAttr -av -k off ".tz";
	setAttr -av -k off ".ty";
	setAttr -av -k off ".tx";
	setAttr ".r" -type "double3" -0.002597819760352007 -1.8643006602680131e-005 -2.5608983575375828e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 3.7094966429528049 3.7094966429528049 3.7094966429528049 ;
	setAttr ".ei" 17;
	setAttr ".radi" 0.05031244834207016;
createNode hikEffector -n "LeftFingerBaseEff" -p "humanIK1";
	setAttr ".t" -type "double3" 8.224207878112793 14.409499168395996 0.073230981826782227 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0 0 1.7075472925031871e-006 ;
	setAttr -av ".rz";
	setAttr ".ei" 18;
	setAttr ".radi" 0.024149975204193676;
createNode hikEffector -n "RightFingerBaseEff" -p "humanIK1";
	setAttr ".t" -type "double3" -8.1900520324707031 14.437174797058105 0.10554839670658112 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0.016565165377107963 0.46864948130093614 0.6780156266180809 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".ei" 19;
	setAttr ".radi" 0.024149975204193676;
createNode hikEffector -n "NeckEff" -p "humanIK1";
	setAttr ".t" -type "double3" -4.1723251342773438e-007 14.547172546386719 -3.0919909477233887e-007 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" 0 0 1.7075472925031871e-006 ;
	setAttr -av ".rz";
	setAttr ".s" -type "double3" 6.1349647554102349 6.1349647554102349 6.1349647554102349 ;
	setAttr ".ei" 10;
	setAttr ".radi" 0.05031244834207016;
createNode joint -n "hipsFK" -p "humanIK1";
	setAttr ".v" no;
	setAttr ".r" -type "double3" 0 0 -7.8816689450411112e-010 ;
	setAttr -av ".rz";
	setAttr ".ra" -type "double3" 89.999990043999489 -89.999778744008623 161.56481257470173 ;
	setAttr ".jo" -type "double3" 89.999999999959499 -18.435197384544171 90.00022125600421 ;
	setAttr ".typ" 1;
	setAttr ".hni" 1;
createNode joint -n "spineFK" -p "hipsFK";
	setAttr ".r" -type "double3" -3.508188195897247e-006 1.5070459249252578e-006 1.7021610342623294e-006 ;
	setAttr ".ra" -type "double3" -112.18014064948841 -89.999884702924447 25.49786121091584 ;
	setAttr ".jo" -type "double3" 90.000043600009462 3.3177205588099539 89.999895757990217 ;
	setAttr ".typ" 6;
	setAttr ".hni" 8;
createNode joint -n "spine1FK" -p "spineFK";
	setAttr ".r" -type "double3" 3.3919425709686073e-006 3.9694875442620681e-007 -1.7033595652653875e-006 ;
	setAttr ".ra" -type "double3" -105.76518668866802 -89.999854232698809 22.43999531905634 ;
	setAttr ".jo" -type "double3" 90.000039874602564 6.6748086298727181 89.99986435077696 ;
	setAttr ".typ" 6;
	setAttr ".hni" 23;
createNode joint -n "neckFK" -p "spine1FK";
	setAttr ".r" -type "double3" -2.5336080279265039e-006 -0.00016973201471716281 0.0003124861434189345 ;
	setAttr ".ra" -type "double3" 94.829155972659734 -89.999865338292935 156.73554271560593 ;
	setAttr ".jo" -type "double3" 90.000011949728346 -18.435301311710678 90.000130404772463 ;
	setAttr ".typ" 7;
	setAttr ".hni" 20;
createNode joint -n "headFK" -p "neckFK";
	setAttr ".r" -type "double3" -0.00033638942419049597 -6.4886387704903272e-005 0.00015538701708369968 ;
	setAttr ".jo" -type "double3" -3.7829358353592995e-009 6.3611093633002823e-015 1.5902773406685918e-014 ;
	setAttr ".typ" 8;
	setAttr ".hni" 15;
createNode joint -n "leftShoulderFK" -p "spine1FK";
	setAttr ".r" -type "double3" -5.0357250135635765e-012 -5.3820368297970358e-005 
		-4.7684668866030882e-015 ;
	setAttr ".ra" -type "double3" -89.999999996499568 5.0637813770016251 -5.3716527391621547e-006 ;
	setAttr ".jo" -type "double3" 89.999999996513253 -5.3719617025121023e-006 -5.0637813770016251 ;
	setAttr ".sd" 1;
	setAttr ".typ" 9;
	setAttr ".hni" 18;
createNode joint -n "leftArmFK" -p "leftShoulderFK";
	setAttr ".r" -type "double3" 5.3607267065100465e-007 7.4009563122392347e-005 3.5054892983576429e-013 ;
	setAttr ".ra" -type "double3" -89.999999996489336 -0.14927062298717753 -0.41500266459611707 ;
	setAttr ".jo" -type "double3" 89.999999996489237 -0.41500266458697094 0.14927062301260713 ;
	setAttr ".sd" 1;
	setAttr ".typ" 10;
	setAttr ".hni" 9;
createNode joint -n "leftForearmFK" -p "leftArmFK";
	setAttr ".r" -type "double3" -1.9941885093131528e-006 3.608225747031865e-005 7.8313625526186434e-008 ;
	setAttr ".ra" -type "double3" -89.999999996510184 1.5581573285620911 -1.4060882303489102 ;
	setAttr ".jo" -type "double3" 89.999999996510425 -1.4060882304438052 -1.5581573284764618 ;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".hni" 10;
createNode joint -n "leftForeArmRollFK" -p "leftForearmFK";
	setAttr ".r" -type "double3" 3.4125813601097279e-006 -3.264425282990962e-009 -5.1038745122638717e-008 ;
	setAttr ".ra" -type "double3" -89.999999996467267 0.85685438367552269 -0.054808314738811557 ;
	setAttr ".jo" -type "double3" 89.99999999646765 -0.054808314791642089 -0.85685438367214373 ;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".hni" 46;
createNode joint -n "leftHandFK" -p "leftForeArmRollFK";
	setAttr ".r" -type "double3" 5.2119464251452501e-005 -0.00015997386255600521 -7.2763792955082828e-011 ;
	setAttr ".ra" -type "double3" -89.999999996500151 -1.3463134257794926 18.045602977502281 ;
	setAttr ".jo" -type "double3" 89.999999996320099 18.045602977584515 1.3463134246395587 ;
	setAttr ".sd" 1;
	setAttr ".typ" 12;
	setAttr ".hni" 11;
createNode joint -n "leftHandPinky1FK" -p "leftHandFK";
	setAttr ".r" -type "double3" -8.9377833958381385e-006 0.00011036244734450429 -8.6011672259913863e-012 ;
	setAttr ".ra" -type "double3" -89.999999996499653 6.6634029058895408 4.6300358745636805 ;
	setAttr ".jo" -type "double3" 89.999999996511917 4.6300358741575121 -6.663402906171104 ;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".hni" 66;
createNode joint -n "leftHandPinky2FK" -p "leftHandPinky1FK";
	setAttr ".r" -type "double3" -8.7288616435341215e-007 0.00028589060678307552 -1.2423602941626707e-006 ;
	setAttr ".ra" -type "double3" -89.999999996497749 25.409502575472914 -3.9246974184182197 ;
	setAttr ".jo" -type "double3" 89.999999996829104 -3.9246974199209888 -25.409502575255889 ;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".hni" 67;
createNode joint -n "leftHandPinky3FK" -p "leftHandPinky2FK";
	setAttr ".r" -type "double3" 5.9145634613434886e-009 5.0628362587164053e-006 1.2983533491104216e-014 ;
	setAttr ".ra" -type "double3" -89.999999996497849 21.906276768808908 -0.06693515153036135 ;
	setAttr ".jo" -type "double3" 89.999999996750716 -0.066935152836971684 -21.90627676880511 ;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".hni" 68;
createNode joint -n "leftHandPinky4FK" -p "leftHandPinky3FK";
	setAttr ".r" -type "double3" -1.0172618302700162e-005 0 -5.1226369918576682e-006 ;
	setAttr -av ".rz";
	setAttr -av ".rx";
	setAttr ".jo" -type "double3" -3.5003615436708141e-009 1.263525043408546e-014 1.5728836822606123e-014 ;
	setAttr ".sd" 1;
	setAttr ".typ" 22;
	setAttr ".hni" 69;
createNode joint -n "leftHandRing1FK" -p "leftHandFK";
	setAttr ".r" -type "double3" -2.2029064450084022e-005 0.00062441622375759907 8.2607173342491765e-007 ;
	setAttr ".ra" -type "double3" -89.999999996652249 -1.3652057725721654 5.2019681194558274 ;
	setAttr ".jo" -type "double3" 89.999999996639332 5.2019681195355867 1.3652057722674629 ;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".hni" 62;
createNode joint -n "leftHandRing2FK" -p "leftHandRing1FK";
	setAttr ".r" -type "double3" 1.0487754000753183e-006 -0.00038255810715178643 1.6631546008656868e-006 ;
	setAttr ".ra" -type "double3" -89.99999999650008 12.898278647685249 1.2448940334389218 ;
	setAttr ".jo" -type "double3" 89.999999996587576 1.2448940326576658 -12.89827864775939 ;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".hni" 63;
createNode joint -n "leftHandRing3FK" -p "leftHandRing2FK";
	setAttr ".r" -type "double3" 7.62698571571901e-007 -0.0013533329773090786 2.3196025312316377e-005 ;
	setAttr ".ra" -type "double3" -89.999999996483865 10.060193870170291 -2.0953023672061146 ;
	setAttr ".jo" -type "double3" 89.999999996535593 -2.0953023678203251 -10.060193870043621 ;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".hni" 64;
createNode joint -n "leftHandRing4FK" -p "leftHandRing3FK";
	setAttr ".jo" -type "double3" -3.5003609224687276e-009 1.5020666445183099e-014 
		9.1689427920876207e-015 ;
	setAttr ".sd" 1;
	setAttr ".typ" 21;
	setAttr ".hni" 65;
createNode joint -n "joint23FK" -p "leftHandFK";
	setAttr ".r" -type "double3" -7.900792831736051e-007 0.00011242854354699882 -7.6900352389575929e-013 ;
	setAttr ".ra" -type "double3" -89.999999996502524 -1.8414002356076391 0.40263319612057707 ;
	setAttr ".jo" -type "double3" 89.999999996504229 0.40263319623296157 1.8414002355830736 ;
	setAttr ".sd" 1;
	setAttr ".typ" 13;
	setAttr ".hni" 21;
createNode joint -n "leftHandMiddle1FK" -p "joint23FK";
	setAttr ".r" -type "double3" -7.8818637136236999e-006 0.00037691465332450165 3.5255325304765484e-006 ;
	setAttr ".ra" -type "double3" -89.999999996501728 -5.4352676239028632 0.26075055869218222 ;
	setAttr ".jo" -type "double3" 89.999999996517417 0.26075055902354161 5.4352676238870137 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".hni" 58;
createNode joint -n "leftHandMiddle2FK" -p "leftHandMiddle1FK";
	setAttr ".r" -type "double3" -5.3348474568650463e-007 -0.0032750537399674736 8.3268619308984244e-007 ;
	setAttr ".ra" -type "double3" -89.999999996501472 -1.0228122064838017 -3.4957003879673869 ;
	setAttr ".jo" -type "double3" 89.999999996495518 -3.4957003879049382 1.0228122066974834 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".hni" 59;
createNode joint -n "leftHandMiddle3FK" -p "leftHandMiddle2FK";
	setAttr ".t" -type "double3" 0.21384540972562149 0.0038077520529622433 0.013064905927848036 ;
	setAttr ".r" -type "double3" -8.3323475153098101e-007 0.0057453147644285557 -3.5526469793735601e-006 ;
	setAttr ".ra" -type "double3" -89.999999996497834 4.9131863999429335 1.2104646475552576 ;
	setAttr ".jo" -type "double3" 89.999999996509942 1.2104646472553082 -4.913186400016663 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".hni" 60;
createNode joint -n "leftHandMiddle4FK" -p "leftHandMiddle3FK";
	setAttr ".r" -type "double3" -1.6837908969719213e-006 0 1.6180044651811475e-006 ;
	setAttr -av ".rz";
	setAttr -av ".rx";
	setAttr ".jo" -type "double3" -3.5003857270680306e-009 1.8698182795625294e-014 8.9701581244961428e-015 ;
	setAttr ".sd" 1;
	setAttr ".typ" 20;
	setAttr ".hni" 61;
createNode joint -n "leftHandIndex1FK" -p "leftHandFK";
	setAttr ".r" -type "double3" 1.5194101091500192e-005 0.00026932153828438255 1.2837382113638236e-006 ;
	setAttr ".ra" -type "double3" -89.999999996500648 -3.7888969011419822 -5.5647347982279936 ;
	setAttr ".jo" -type "double3" 89.999999996491695 -5.5647347979967465 3.7888969014821794 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".hni" 54;
createNode joint -n "leftHandIndex2FK" -p "leftHandIndex1FK";
	setAttr ".r" -type "double3" 2.9135768280693371e-007 0.00046489858911639796 1.7118923763510475e-006 ;
	setAttr ".ra" -type "double3" -89.999999996500136 2.9504631700856732 -0.5518483716586049 ;
	setAttr ".jo" -type "double3" 89.999999996504627 -0.55184837183875068 -2.9504631700520072 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".hni" 55;
createNode joint -n "leftHandIndex3FK" -p "leftHandIndex2FK";
	setAttr ".r" -type "double3" 5.0240301162692483e-007 -0.0017315231444329897 -2.1945032036642264e-005 ;
	setAttr ".ra" -type "double3" -89.999999996498573 5.2829095784037303 -3.8370208533914507 ;
	setAttr ".jo" -type "double3" 89.999999996505593 -3.8370208537138399 -5.2829095781698907 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".hni" 56;
createNode joint -n "leftHandIndex4FK" -p "leftHandIndex3FK";
	setAttr ".r" -type "double3" -6.3310357431545884e-006 -2.2599200246016818e-029 
		3.6620504515274322e-006 ;
	setAttr ".jo" -type "double3" -3.5003621276007749e-009 1.4324920108612951e-014 9.0695504582918857e-015 ;
	setAttr ".sd" 1;
	setAttr ".typ" 19;
	setAttr ".hni" 57;
createNode joint -n "leftHandThumb1FK" -p "leftHandFK";
	setAttr ".r" -type "double3" -1.5610080848016946e-005 4.4784078564387917e-006 -0.00021067087049456558 ;
	setAttr ".ra" -type "double3" -89.999999996500151 7.8657256902853643 -10.918058114528257 ;
	setAttr ".jo" -type "double3" 89.999999996469171 -10.918058115007211 -7.8657256896166032 ;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".hni" 50;
createNode joint -n "leftHandThumb2FK" -p "leftHandThumb1FK";
	setAttr ".r" -type "double3" 4.5928001598403801e-007 2.9714675286794761e-006 0.0012972812617542146 ;
	setAttr ".ra" -type "double3" -89.999999996499241 -3.4566825912390913 -2.4677814806475085 ;
	setAttr ".jo" -type "double3" 89.999999996502382 -2.4677814804364329 3.4566825913896913 ;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".hni" 51;
createNode joint -n "leftHandThumb3FK" -p "leftHandThumb2FK";
	setAttr ".r" -type "double3" -5.3485679131564536e-007 -2.5799905518812778e-008 
		-0.0019728163031352674 ;
	setAttr ".ra" -type "double3" -89.999999996518341 -2.355376604839317 2.9108755125335 ;
	setAttr ".jo" -type "double3" 89.99999999651682 2.9108755126765877 2.3553766046624323 ;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".hni" 52;
createNode joint -n "leftHandThumb4FK" -p "leftHandThumb3FK";
	setAttr ".r" -type "double3" 8.9632441170458277e-006 2.3158303144260559e-006 -2.1153807675480201e-006 ;
	setAttr ".jo" -type "double3" -3.5004044299098416e-009 1.3877654606532154e-014 1.0063473796249223e-014 ;
	setAttr ".sd" 1;
	setAttr ".typ" 14;
	setAttr ".hni" 53;
createNode joint -n "rightShoulderFK" -p "spine1FK";
	setAttr ".r" -type "double3" 6.4119982378304497e-012 -4.3014970193289983e-006 0 ;
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".ra" -type "double3" 90.000000003500361 5.0652684646789732 -179.99991388968371 ;
	setAttr ".jo" -type "double3" 90.000000003486704 8.6110007295609457e-005 -174.93473153532102 ;
	setAttr ".sd" 2;
	setAttr ".typ" 9;
	setAttr ".hni" 19;
createNode joint -n "rightArmFK" -p "rightShoulderFK";
	setAttr ".r" -type "double3" -0.0085364086780832897 0.67796096153847407 -0.26554098274316074 ;
	setAttr ".ra" -type "double3" 90.000000003518778 -0.15152635110108903 179.58714732611082 ;
	setAttr ".jo" -type "double3" 90.000000003518863 -0.41285267387989766 179.84847364887355 ;
	setAttr ".sd" 2;
	setAttr ".typ" 10;
	setAttr ".hni" 12;
createNode joint -n "rightForeArmFK" -p "rightArmFK";
	setAttr ".r" -type "double3" 0.0021463496959194645 -0.00018707905644750139 0.72926496102632254 ;
	setAttr ".ra" -type "double3" 90.000000003483635 -0.74927337455023835 178.91556820760377 ;
	setAttr ".jo" -type "double3" 90.000000003483947 -1.084431792350683 179.25072662538383 ;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".hni" 13;
createNode joint -n "rightForeArmRollFK" -p "rightForeArmFK";
	setAttr ".r" -type "double3" 3.1470239318260763e-006 -5.3795453516002024e-008 -1.836711806339042e-008 ;
	setAttr ".ra" -type "double3" 90.00000000345571 -0.33434548705449829 179.02067765591423 ;
	setAttr ".jo" -type "double3" 90.000000003456137 -0.9793223440656188 179.66565451288648 ;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".hni" 48;
createNode joint -n "rightHandFK" -p "rightForeArmRollFK";
	setAttr ".r" -type "double3" 0.00033723308037481074 0.00066717513488570069 0.01533477371621083 ;
	setAttr ".ra" -type "double3" 90.000000003499451 -2.5451129403958732 -162.23764037116726 ;
	setAttr ".jo" -type "double3" 90.000000003670976 17.76235962898815 177.45488706072402 ;
	setAttr ".sd" 2;
	setAttr ".typ" 12;
	setAttr ".hni" 14;
createNode joint -n "rightHandPinky1FK" -p "rightHandFK";
	setAttr ".t" -type "double3" -1.0081717188510968 0.044812895258388608 -0.32330399123624165 ;
	setAttr ".r" -type "double3" 3.5315353442292605 -9.6520106178013698 0.35649821392229925 ;
	setAttr ".ra" -type "double3" 90.000000003500347 5.4638247444485257 -175.65458217251634 ;
	setAttr ".jo" -type "double3" 90.00000000349452 4.3454178271503556 -174.53617525528671 ;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".hni" 90;
createNode joint -n "rightHandPinky2FK" -p "rightHandPinky1FK";
	setAttr ".r" -type "double3" 2.0130947933771744e-006 -2.6330518687550204 -2.9849747942584624e-006 ;
	setAttr ".ra" -type "double3" 90.000000003529834 24.203186911343337 175.80814403738052 ;
	setAttr ".jo" -type "double3" 90.000000003228195 -4.191855964066642 -155.79681308889263 ;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".hni" 91;
createNode joint -n "rightHandPinky3FK" -p "rightHandPinky2FK";
	setAttr ".r" -type "double3" -0.00045946746005681098 -0.69308170112521938 0.017255835949232079 ;
	setAttr ".ra" -type "double3" 90.00000000350235 20.718186693769646 179.65974511121178 ;
	setAttr ".jo" -type "double3" 90.000000003275929 -0.34025489002727854 -159.28181330624983 ;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".hni" 92;
createNode joint -n "rightHandPinky4FK" -p "rightHandPinky3FK";
	setAttr ".r" -type "double3" -1.3547847825176383e-006 4.0103276582811071e-006 1.2351101562172417e-005 ;
	setAttr ".jo" -type "double3" -3.500302204700407e-009 2.3953552445074754e-014 1.3765838230140388e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 22;
	setAttr ".hni" 93;
createNode joint -n "rightHandRing1FK" -p "rightHandFK";
	setAttr ".t" -type "double3" -1.0618529594214472 0.059690378817688128 -0.13917759386546805 ;
	setAttr ".r" -type "double3" 3.7244227950428859 -13.606001515550206 -0.29739648940201885 ;
	setAttr ".ra" -type "double3" 90.000000003543008 -2.5699062340658729 -175.08276302061353 ;
	setAttr ".jo" -type "double3" 90.000000003552501 4.917236979545347 177.43009376623866 ;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".hni" 86;
createNode joint -n "rightHandRing2FK" -p "rightHandRing1FK";
	setAttr ".r" -type "double3" 1.817720514449617e-007 3.5485577685172314 -1.8625684436774679e-006 ;
	setAttr ".ra" -type "double3" 90.00000000349992 11.694034006977439 -179.03739857936969 ;
	setAttr ".jo" -type "double3" 90.000000003427786 0.9626014199209354 -168.30596599296499 ;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".hni" 87;
createNode joint -n "rightHandRing3FK" -p "rightHandRing2FK";
	setAttr ".r" -type "double3" -0.00019088314113630204 -3.2666832225605908 0.0067920627578305828 ;
	setAttr ".ra" -type "double3" 90.000000003509385 8.8755420266425524 177.62094744139506 ;
	setAttr ".jo" -type "double3" 90.000000003470362 -2.3790525591464124 -171.12445797350151 ;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".hni" 88;
createNode joint -n "rightHandRing4FK" -p "rightHandRing3FK";
	setAttr ".r" -type "double3" -1.5393462016131492e-006 0 0 ;
	setAttr -av ".rx";
	setAttr ".jo" -type "double3" -3.5003149269191328e-009 2.0176643760836827e-014 1.6747608244012424e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 21;
	setAttr ".hni" 89;
createNode joint -n "joint67FK" -p "rightHandFK";
	setAttr ".r" -type "double3" 1.7200102902286838e-006 -0.00044243610481610332 -0.010361362533115431 ;
	setAttr ".ra" -type "double3" 90.000000003495856 -3.0550251757515161 -179.87970425350829 ;
	setAttr ".jo" -type "double3" 90.000000003490868 0.12029574667800599 176.94497482425581 ;
	setAttr ".sd" 2;
	setAttr ".typ" 13;
	setAttr ".hni" 22;
createNode joint -n "rightHandMiddle1FK" -p "joint67FK";
	setAttr ".r" -type "double3" 3.0644673362111439 -11.8802495191077 -0.29076539978964655 ;
	setAttr ".ra" -type "double3" 90.000000003500489 -6.6375950756948514 179.98078773296911 ;
	setAttr ".jo" -type "double3" 90.000000003477027 -0.01921226662626745 173.362404924304 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".hni" 82;
createNode joint -n "rightHandMiddle2FK" -p "rightHandMiddle1FK";
	setAttr ".r" -type "double3" -4.9989165316400302e-007 -4.3831159213628164 -1.0106768206864269e-006 ;
	setAttr ".ra" -type "double3" 90.000000003501142 -2.2352043525720315 176.22093672172747 ;
	setAttr ".jo" -type "double3" 90.000000003506116 -3.7790632781359901 177.76479564719688 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".hni" 83;
createNode joint -n "rightHandMiddle3FK" -p "rightHandMiddle2FK";
	setAttr ".r" -type "double3" -0.00086058784808622777 2.8441444116395793 -0.033614282701682659 ;
	setAttr ".ra" -type "double3" 90.000000003500247 3.7053385489115516 -179.07321672105201 ;
	setAttr ".jo" -type "double3" 90.000000003493426 0.92678327872181065 -176.29466145103194 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".hni" 84;
createNode joint -n "rightHandMiddle4FK" -p "rightHandMiddle3FK";
	setAttr ".r" -type "double3" 8.7644321532722884e-006 0 -1.6717340005513173e-006 ;
	setAttr -av ".rx";
	setAttr -av ".rz";
	setAttr ".jo" -type "double3" -3.5002958435910442e-009 4.4825942542179078e-014 1.813910091715273e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 20;
	setAttr ".hni" 85;
createNode joint -n "rightHandIndex1FK" -p "rightHandFK";
	setAttr ".t" -type "double3" -1.0472406366088283 0.050703143908338077 0.22014055613497052 ;
	setAttr ".r" -type "double3" 1.7169772966679875 -11.921542771643045 -0.054081087422432159 ;
	setAttr ".ra" -type "double3" 90.000000003499323 -4.9978086168502145 174.15457131799204 ;
	setAttr ".jo" -type "double3" 90.000000003504226 -5.845428681703118 175.00219138279292 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".hni" 78;
createNode joint -n "rightHandIndex2FK" -p "rightHandIndex1FK";
	setAttr ".r" -type "double3" 4.1066764307591323e-009 -6.7487025087043762 -4.8351669382563274e-006 ;
	setAttr ".ra" -type "double3" 90.000000003499125 1.7604831868886512 179.16354834204802 ;
	setAttr ".jo" -type "double3" 90.000000003497846 -0.83645165805948618 -178.23951681316242 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".hni" 79;
createNode joint -n "rightHandIndex3FK" -p "rightHandIndex2FK";
	setAttr ".r" -type "double3" 0.00085178966036195147 4.0767482737742036 0.020756415376487435 ;
	setAttr ".ra" -type "double3" 90.000000003493469 4.0759723731550253 175.87777654471859 ;
	setAttr ".jo" -type "double3" 90.000000003493668 -4.1222234555297224 -175.92402762709611 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".hni" 80;
createNode joint -n "rightHandIndex4FK" -p "rightHandIndex3FK";
	setAttr ".r" -type "double3" 2.6829146080285946e-005 3.4672753118287402e-006 1.4667517128738246e-006 ;
	setAttr ".jo" -type "double3" -3.500384899122125e-009 2.2968947138410779e-014 1.806145065637476e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 19;
	setAttr ".hni" 81;
createNode joint -n "rightHandThumb1FK" -p "rightHandFK";
	setAttr ".r" -type "double3" -0.12156561195902292 0.02015030965339655 1.4319265297991473 ;
	setAttr ".ra" -type "double3" 90.000000003500446 5.4093194905011996 170.48048481493214 ;
	setAttr ".jo" -type "double3" 90.000000003533501 -9.5195151853978448 -174.59068051008319 ;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".hni" 74;
createNode joint -n "rightHandThumb2FK" -p "rightHandThumb1FK";
	setAttr ".r" -type "double3" -0.00018521715172836793 0.0065557194957162977 -3.29533408303891 ;
	setAttr ".ra" -type "double3" 90.000000003500261 -5.9187432416634698 178.89970098399934 ;
	setAttr ".jo" -type "double3" 90.000000003482242 -1.1002990156397248 174.08125675826966 ;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".hni" 75;
createNode joint -n "rightHandThumb3FK" -p "rightHandThumb2FK";
	setAttr ".r" -type "double3" -0.00035794243067868833 -0.022278095593500472 1.8668197276801906 ;
	setAttr ".ra" -type "double3" 90.000000003491849 -4.8274069574576135 -175.71895329130228 ;
	setAttr ".jo" -type "double3" 90.000000003489205 4.2810467089915649 175.17259304280284 ;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".hni" 76;
createNode joint -n "rightHandThumb4FK" -p "rightHandThumb3FK";
	setAttr ".r" -type "double3" 1.1947974506421242e-005 5.6424557733604211e-006 0 ;
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".jo" -type "double3" -3.5003467324659473e-009 2.6985018625844678e-014 1.9679682090986594e-014 ;
	setAttr ".sd" 2;
	setAttr ".typ" 14;
	setAttr ".hni" 77;
createNode joint -n "leftUpLegFK" -p "hipsFK";
	setAttr ".r" -type "double3" -1.0174643294617958e-005 -3.6098562441576189e-006 
		0.0017267275493995382 ;
	setAttr ".ra" -type "double3" -90.000000000643496 89.660169960852855 1.0939623940517782 ;
	setAttr ".jo" -type "double3" 90.000000000003823 1.0939623946930892 -89.660169960852798 ;
	setAttr ".sd" 1;
	setAttr ".typ" 2;
	setAttr ".hni" 2;
createNode joint -n "leftLegFK" -p "leftUpLegFK";
	setAttr ".r" -type "double3" 0.00013989645110757388 1.9865084257269253e-006 -0.0048936499850084237 ;
	setAttr ".ra" -type "double3" 89.999999994872965 89.598355643148437 -177.7891574601741 ;
	setAttr ".jo" -type "double3" 89.999999999964032 2.2108425449532727 -90.401644356852955 ;
	setAttr ".sd" 1;
	setAttr ".typ" 3;
	setAttr ".hni" 3;
createNode joint -n "leftFootFK" -p "leftLegFK";
	setAttr ".r" -type "double3" -0.00015044018968331834 0.0002891191217815478 0.0047787416882108091 ;
	setAttr ".ra" -type "double3" -90.000000000642686 86.572656295467496 -60.705364724423873 ;
	setAttr ".jo" -type "double3" 90.000000000078515 -60.70536472378236 -86.572656295535907 ;
	setAttr ".sd" 1;
	setAttr ".typ" 4;
	setAttr ".hni" 4;
createNode joint -n "joint86FK" -p "leftFootFK";
	setAttr ".r" -type "double3" 2.7960559167193046e-006 2.0995009105257338e-005 -0.001914960746372373 ;
	setAttr ".ra" -type "double3" -90.000852719889409 86.57266961810862 -90.00018595113319 ;
	setAttr ".jo" -type "double3" 94.38202342501269 -89.999332806038424 -90.954693043204031 ;
	setAttr ".sd" 1;
	setAttr ".typ" 5;
	setAttr ".hni" 16;
createNode joint -n "leftFootIndex1FK" -p "joint86FK";
	setAttr ".r" -type "double3" 6.8133346337696533e-007 -1.2532042814610182e-005 4.954374563625071e-007 ;
	setAttr ".ra" -type "double3" -90.000000000642487 87.739402913351228 -86.888046061401482 ;
	setAttr ".jo" -type "double3" 90.000000000467068 -86.888046060759493 -87.739402913817599 ;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".hni" 102;
createNode joint -n "leftFootIndex2FK" -p "leftFootIndex1FK";
	setAttr ".r" -type "double3" 0 1.2595020783003435e-005 0 ;
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".jo" -type "double3" 6.4250797598429764e-010 -1.9375293069306161e-014 1.7890620083234e-015 ;
	setAttr ".sd" 1;
	setAttr ".typ" 25;
	setAttr ".hni" 103;
createNode joint -n "rightUpLegFK" -p "hipsFK";
	setAttr ".r" -type "double3" -4.3698752232116679e-007 -2.5689735358215505e-006 
		0.0025978874942259931 ;
	setAttr ".ra" -type "double3" -90.000000000636035 89.578248665229196 0.95777695670182361 ;
	setAttr ".jo" -type "double3" 90.000000000004675 0.9577769573361532 -89.578248665229111 ;
	setAttr ".sd" 2;
	setAttr ".typ" 2;
	setAttr ".hni" 5;
createNode joint -n "rightLegFK" -p "rightUpLegFK";
	setAttr ".r" -type "double3" -9.5955385833921601e-005 1.2944133018815281e-005 -0.0076222763002541842 ;
	setAttr ".ra" -type "double3" -89.92526017713331 89.598496197825327 2.0803712934978296 ;
	setAttr ".jo" -type "double3" 89.999475939350361 2.0056333056207856 -89.598514880361549 ;
	setAttr ".sd" 2;
	setAttr ".typ" 3;
	setAttr ".hni" 6;
createNode joint -n "rightFootFK" -p "rightLegFK";
	setAttr ".r" -type "double3" 0.00010188919596863916 -0.00019841920444120268 0.0084052461337962067 ;
	setAttr ".ra" -type "double3" 89.999999999353463 88.909692756286901 120.25849236355317 ;
	setAttr ".jo" -type "double3" 89.999999999975572 -59.741507635800559 -91.090307243692024 ;
	setAttr ".sd" 2;
	setAttr ".typ" 4;
	setAttr ".hni" 7;
createNode joint -n "joint87FK" -p "rightFootFK";
	setAttr ".r" -type "double3" -0.0003247692296772504 0.0022294845734436371 0.0025263150071617993 ;
	setAttr ".ra" -type "double3" 89.999999999358536 -49.407396101191601 98.245825617898618 ;
	setAttr ".jo" -type "double3" 89.999999997089773 -81.754174382588474 130.59260390168859 ;
	setAttr ".sd" 2;
	setAttr ".typ" 5;
	setAttr ".hni" 17;
createNode joint -n "rightFootIndex1FK" -p "joint87FK";
	setAttr ".r" -type "double3" 1.9878466759146963e-016 -2.3605679276487037e-016 8.0905359709728212e-014 ;
	setAttr ".ra" -type "double3" 89.999999999356149 89.671109324422545 92.872119448929993 ;
	setAttr ".jo" -type "double3" 89.999999999926089 -87.127880550426141 -90.328890675503629 ;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".hni" 126;
createNode joint -n "rightFootIndex2FK" -p "rightFootIndex1FK";
	setAttr ".jo" -type "double3" 6.4262709769635182e-010 -1.4349768191758787e-015 
		-6.3611093629269144e-015 ;
	setAttr ".sd" 2;
	setAttr ".typ" 25;
	setAttr ".hni" 127;
createNode hikEffector -n "LeftFootEffPivot" -p "humanIK1";
	setAttr ".t" -type "double3" 1.0561470985412598 0.091285936534404755 0.69959455728530884 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.0016238772662993796 -0.0001346827275581807 3.4170027142597502e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.3507650080078615 2.3507650080078615 2.3507650080078615 ;
	setAttr ".ei" 1;
	setAttr ".po" -type "double3" -1.8824862869551933e-006 0.55997323577514602 -0.99308335677041526 ;
	setAttr -av ".rt" 1;
	setAttr -av ".rr" 1;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "RightFootEffPivot" -p "humanIK1";
	setAttr ".t" -type "double3" -1.0569120645523071 0.099932044744491577 0.72458153963088989 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.0033843587298075643 6.7021283340927456e-005 1.7055679188249441e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.3507650080078615 2.3507650080078615 2.3507650080078615 ;
	setAttr ".ei" 2;
	setAttr ".po" -type "double3" 0 0.55994047557115079 -0.99310179886358951 ;
	setAttr -av ".rt" 1;
	setAttr -av ".rr" 1;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "LeftFootEffPivot1" -p "humanIK1";
	setAttr ".t" -type "double3" 1.0561476945877075 0.070162288844585419 -0.61045539379119873 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.0016238772662993796 -0.0001346827275581807 3.4170027142597502e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.3507650080078615 2.3507650080078615 2.3507650080078615 ;
	setAttr ".ei" 1;
	setAttr ".po" -type "double3" 6.519476091776682e-007 0.58105974647616088 0.31696660865293363 ;
	setAttr -av ".rt" 1;
	setAttr -av ".rr" 1;
	setAttr ".radi" 0.10062489668414032;
createNode hikEffector -n "RightFootEffPivot1" -p "humanIK1";
	setAttr ".t" -type "double3" -1.0569136142730713 0.078724943101406097 -0.58546632528305054 ;
	setAttr -av ".tz";
	setAttr -av ".ty";
	setAttr -av ".tx";
	setAttr ".r" -type "double3" -0.0033843587298075643 6.7021283340927456e-005 1.7055679188249441e-006 ;
	setAttr -av ".rz";
	setAttr -av ".ry";
	setAttr -av ".rx";
	setAttr ".s" -type "double3" 2.3507650080078615 2.3507650080078615 2.3507650080078615 ;
	setAttr ".ei" 2;
	setAttr ".po" -type "double3" 0 0.58107020227536255 0.31694744044395856 ;
	setAttr -av ".rt" 1;
	setAttr -av ".rr" 1;
	setAttr ".radi" 0.10062489668414032;
createNode lightLinker -n "lightLinker1";
	setAttr -s 2 ".lnk";
createNode displayLayerManager -n "layerManager";
	setAttr ".cdl" 1;
	setAttr -s 2 ".dli[1]"  1;
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Top View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Top View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"top\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n"
		+ "                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 2048\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n"
		+ "                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -locators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n"
		+ "                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Top View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -wireframeOnShaded 0\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 2048\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n"
		+ "            -hairSystems 1\n            -follicles 1\n            -locators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Side View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Side View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"side\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n"
		+ "                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 2048\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n"
		+ "                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -locators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Side View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -wireframeOnShaded 0\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 2048\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n"
		+ "            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -locators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n"
		+ "            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Front View\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Front View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"front\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 2048\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n"
		+ "                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -locators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Front View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n"
		+ "            -activeOnly 0\n            -wireframeOnShaded 0\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 2048\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n"
		+ "            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -locators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Persp View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l \"Persp View\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -wireframeOnShaded 0\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 2048\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n"
		+ "                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -locators 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -shadows 0\n                $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l \"Persp View\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -wireframeOnShaded 0\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n"
		+ "            -xray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 2048\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n"
		+ "            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -locators 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -shadows 0\n            $editorName;\nmodelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" \"Outliner\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l \"Outliner\" -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n"
		+ "            outlinerEditor -e \n                -mainListConnection \"worldList\" \n                -selectionConnection \"modelList\" \n                -showShapes 0\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -autoExpand 0\n                -showDagOnly 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n"
		+ "                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l \"Outliner\" -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -mainListConnection \"worldList\" \n            -selectionConnection \"modelList\" \n            -showShapes 0\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -autoExpand 0\n            -showDagOnly 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n"
		+ "            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" \"Graph Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l \"Graph Editor\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n"
		+ "            outlinerEditor -e \n                -mainListConnection \"graphEditorList\" \n                -selectionConnection \"graphEditor1FromOutliner\" \n                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 1\n                -showDagOnly 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n"
		+ "                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -mainListConnection \"graphEditor1FromOutliner\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n"
		+ "                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Graph Editor\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"graphEditorList\" \n                -selectionConnection \"graphEditor1FromOutliner\" \n                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 1\n                -showDagOnly 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n"
		+ "                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -mainListConnection \"graphEditor1FromOutliner\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n"
		+ "                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" \"Dope Sheet\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l \"Dope Sheet\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"animationList\" \n                -selectionConnection \"dopeSheetPanel1OutlinerSelection\" \n                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 0\n                -showDagOnly 0\n"
		+ "                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n"
		+ "            dopeSheetEditor -e \n                -mainListConnection \"dopeSheetPanel1FromOutliner\" \n                -highlightConnection \"dopeSheetPanel1OutlinerSelection\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 0\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Dope Sheet\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -mainListConnection \"animationList\" \n                -selectionConnection \"dopeSheetPanel1OutlinerSelection\" \n"
		+ "                -highlightConnection \"keyframeList\" \n                -showShapes 1\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -autoExpand 0\n                -showDagOnly 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -editAttrName 0\n                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -mainListConnection \"dopeSheetPanel1FromOutliner\" \n                -highlightConnection \"dopeSheetPanel1OutlinerSelection\" \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 0\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" \"Trax Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l \"Trax Editor\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -mainListConnection \"lockedList1\" \n                -highlightConnection \"clipEditorPanel1HighlightConnection\" \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Trax Editor\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -mainListConnection \"lockedList1\" \n"
		+ "                -highlightConnection \"clipEditorPanel1HighlightConnection\" \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" \"Hypergraph\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l \"Hypergraph\" -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -orientation \"horiz\" \n                -zoom 1\n                -animateTransition 0\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showUnderworld 0\n"
		+ "                -showInvisible 0\n                -transitionFrames 1\n                -freeform 0\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Hypergraph\" -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -orientation \"horiz\" \n                -zoom 1\n                -animateTransition 0\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -freeform 0\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -updateSelection 1\n"
		+ "                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" \"Hypershade\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l \"Hypershade\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Hypershade\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" \"Visor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l \"Visor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Visor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" \"UV Texture Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l \"UV Texture Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"UV Texture Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"multiListerPanel\" \"Multilister\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"multiListerPanel\" -l \"Multilister\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Multilister\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" \"Render View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l \"Render View\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Render View\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" \"Blend Shape\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l \"Blend Shape\" -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l \"Blend Shape\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" \"Dynamic Relationships\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l \"Dynamic Relationships\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Dynamic Relationships\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"devicePanel\" \"Devices\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tdevicePanel -unParent -l \"Devices\" -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tdevicePanel -edit -l \"Devices\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" \"Relationship Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l \"Relationship Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Relationship Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" \"Reference Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l \"Reference Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Reference Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" \"Component Editor\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l \"Component Editor\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Component Editor\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" \"Paint Effects\"`;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l \"Paint Effects\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Paint Effects\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"webBrowserPanel\" \"Web Browser\"`;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"webBrowserPanel\" -l \"Web Browser\" -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l \"Web Browser\" -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl \"Current Layout\"`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label \"Current Layout\"\n\t\t\t\t-defaultImage \"\"\n\t\t\t\t-image \"\"\n"
		+ "\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"vertical2\\\" -ps 1 20 100 -ps 2 80 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t\"Outliner\"\n\t\t\t\t\t\"outlinerPanel\"\n\t\t\t\t\t\"$panelName = `outlinerPanel -unParent -l \\\"Outliner\\\" -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\noutlinerEditor -e \\n    -mainListConnection \\\"worldList\\\" \\n    -selectionConnection \\\"modelList\\\" \\n    -showShapes 0\\n    -showAttributes 0\\n    -showConnected 0\\n    -showAnimCurvesOnly 0\\n    -showMuteInfo 0\\n    -autoExpand 0\\n    -showDagOnly 1\\n    -ignoreDagHierarchy 0\\n    -expandConnections 0\\n    -showUnitlessCurves 1\\n    -showCompounds 1\\n    -showLeafs 1\\n    -showNumericAttrsOnly 0\\n    -highlightActive 1\\n    -autoSelectNewObjects 0\\n    -doNotSelectNewObjects 0\\n    -dropIsParent 1\\n    -transmitFilters 0\\n    -setFilter \\\"defaultSetFilter\\\" \\n    -showSetMembers 1\\n    -allowMultiSelection 1\\n    -alwaysToggleSelect 0\\n    -directSelect 0\\n    -displayMode \\\"DAG\\\" \\n    -expandObjects 0\\n    -setsIgnoreFilters 1\\n    -editAttrName 0\\n    -showAttrValues 0\\n    -highlightSecondary 0\\n    -showUVAttrsOnly 0\\n    -showTextureNodesOnly 0\\n    -sortOrder \\\"none\\\" \\n    -longNames 0\\n    -niceNames 1\\n    -showNamespace 1\\n    $editorName\"\n"
		+ "\t\t\t\t\t\"outlinerPanel -edit -l \\\"Outliner\\\" -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\noutlinerEditor -e \\n    -mainListConnection \\\"worldList\\\" \\n    -selectionConnection \\\"modelList\\\" \\n    -showShapes 0\\n    -showAttributes 0\\n    -showConnected 0\\n    -showAnimCurvesOnly 0\\n    -showMuteInfo 0\\n    -autoExpand 0\\n    -showDagOnly 1\\n    -ignoreDagHierarchy 0\\n    -expandConnections 0\\n    -showUnitlessCurves 1\\n    -showCompounds 1\\n    -showLeafs 1\\n    -showNumericAttrsOnly 0\\n    -highlightActive 1\\n    -autoSelectNewObjects 0\\n    -doNotSelectNewObjects 0\\n    -dropIsParent 1\\n    -transmitFilters 0\\n    -setFilter \\\"defaultSetFilter\\\" \\n    -showSetMembers 1\\n    -allowMultiSelection 1\\n    -alwaysToggleSelect 0\\n    -directSelect 0\\n    -displayMode \\\"DAG\\\" \\n    -expandObjects 0\\n    -setsIgnoreFilters 1\\n    -editAttrName 0\\n    -showAttrValues 0\\n    -highlightSecondary 0\\n    -showUVAttrsOnly 0\\n    -showTextureNodesOnly 0\\n    -sortOrder \\\"none\\\" \\n    -longNames 0\\n    -niceNames 1\\n    -showNamespace 1\\n    $editorName\"\n"
		+ "\t\t\t\t-ap false\n\t\t\t\t\t\"Persp View\"\n\t\t\t\t\t\"modelPanel\"\n\t\t\t\t\t\"$panelName = `modelPanel -unParent -l \\\"Persp View\\\" -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"wireframe\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 2048\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l \\\"Persp View\\\" -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"wireframe\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 2048\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout \"Current Layout\";\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 80 -ast 0 -aet 80 ";
	setAttr ".st" 6;
createNode character -n "fbikCharacter";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 19 ".dnsm";
	setAttr ".am" -type "characterMapping" 19 "_leftArm.message" 4 0 "_rightArm.message" 
		4 0 "_leftLeg.message" 4 0 "_rightLeg.message" 4 0 "_spine.message" 
		4 0 "_head.message" 4 0 "_hips.message" 4 0 "_leftFingerPinky.message" 
		4 0 "_leftFingerRing.message" 4 0 "_leftFingerMiddle.message" 
		4 0 "_leftFingerIndex.message" 4 0 "_leftThumb.message" 4 
		0 "_rightFingerPinky.message" 4 0 "_rightFingerRing.message" 4 
		0 "_rightFingerMiddle.message" 4 0 "_rightFingerIndex.message" 4 
		0 "_rightThumb.message" 4 0 "_leftFootIndex.message" 4 0 "_rightFootIndex.message" 
		4 0  ;
	setAttr ".aal" -type "attributeAlias" ;
createNode character -n "_leftArm";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 86 ".dnsm";
	setAttr -s 26 ".uv[1:26]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 
		0 0 0 0 0 0;
	setAttr -s 26 ".uv";
	setAttr -s 30 ".lv[1:30]"  0.07354370309626003 2.4520492026667124 0.83457501087339403 
		1.274415494941224e-007 -0.11997411592914406 1.3539493724421359 0.018496382579045456 
		0.0066527648615305043 2.5535800586117499 0.032136312976597435 -0.035600332279980648 
		1.3087548243145442 0.0011770519337237601 -0.018400934451581061 1.2303342368939756 
		0.021421659722070153 0.029662643906898857 0.94301780437499616 0 0 0 0 0 0 0 0 0 0 
		0 0;
	setAttr -s 30 ".lv";
	setAttr -s 30 ".av";
	setAttr -s 30 ".av";
	setAttr ".am" -type "characterMapping" 86 "leftShoulderFK.scaleZ" 0 1 "leftShoulderFK.scaleY" 
		0 2 "leftShoulderFK.scaleX" 0 3 "leftShoulderFK.rotateZ" 2 
		1 "leftShoulderFK.rotateY" 2 2 "leftShoulderFK.rotateX" 2 3 "leftShoulderFK.translateZ" 
		1 1 "leftShoulderFK.translateY" 1 2 "leftShoulderFK.translateX" 
		1 3 "leftArmFK.scaleZ" 0 4 "leftArmFK.scaleY" 0 5 "leftArmFK.scaleX" 
		0 6 "leftArmFK.rotateZ" 2 4 "leftArmFK.rotateY" 2 5 "leftArmFK.rotateX" 
		2 6 "leftArmFK.translateZ" 1 4 "leftArmFK.translateY" 1 
		5 "leftArmFK.translateX" 1 6 "leftForearmFK.scaleZ" 0 7 "leftForearmFK.scaleY" 
		0 8 "leftForearmFK.scaleX" 0 9 "leftForearmFK.rotateZ" 2 
		7 "leftForearmFK.rotateY" 2 8 "leftForearmFK.rotateX" 2 9 "leftForearmFK.translateZ" 
		1 7 "leftForearmFK.translateY" 1 8 "leftForearmFK.translateX" 
		1 9 "leftForeArmRollFK.scaleZ" 0 10 "leftForeArmRollFK.scaleY" 
		0 11 "leftForeArmRollFK.scaleX" 0 12 "leftForeArmRollFK.rotateZ" 
		2 10 "leftForeArmRollFK.rotateY" 2 11 "leftForeArmRollFK.rotateX" 
		2 12 "leftForeArmRollFK.translateZ" 1 10 "leftForeArmRollFK.translateY" 
		1 11 "leftForeArmRollFK.translateX" 1 12 "leftHandFK.scaleZ" 0 
		13 "leftHandFK.scaleY" 0 14 "leftHandFK.scaleX" 0 15 "leftHandFK.rotateZ" 
		2 13 "leftHandFK.rotateY" 2 14 "leftHandFK.rotateX" 2 15 "leftHandFK.translateZ" 
		1 13 "leftHandFK.translateY" 1 14 "leftHandFK.translateX" 1 
		15 "joint23FK.scaleZ" 0 16 "joint23FK.scaleY" 0 17 "joint23FK.scaleX" 
		0 18 "joint23FK.rotateZ" 2 16 "joint23FK.rotateY" 2 17 "joint23FK.rotateX" 
		2 18 "joint23FK.translateZ" 1 16 "joint23FK.translateY" 1 
		17 "joint23FK.translateX" 1 18 "LeftHandEff.reachRotation" 0 19 "LeftHandEff.reachTranslation" 
		0 20 "LeftHandEff.rotateZ" 2 19 "LeftHandEff.rotateY" 2 20 "LeftHandEff.rotateX" 
		2 21 "LeftHandEff.translateZ" 1 19 "LeftHandEff.translateY" 1 
		20 "LeftHandEff.translateX" 1 21 "LeftForeArmEff.reachRotation" 0 
		21 "LeftForeArmEff.reachTranslation" 0 22 "LeftForeArmEff.rotateZ" 2 
		22 "LeftForeArmEff.rotateY" 2 23 "LeftForeArmEff.rotateX" 2 24 "LeftForeArmEff.translateZ" 
		1 22 "LeftForeArmEff.translateY" 1 23 "LeftForeArmEff.translateX" 
		1 24 "LeftArmEff.reachRotation" 0 23 "LeftArmEff.reachTranslation" 
		0 24 "LeftArmEff.rotateZ" 2 25 "LeftArmEff.rotateY" 2 26 "LeftArmEff.rotateX" 
		2 27 "LeftArmEff.translateZ" 1 25 "LeftArmEff.translateY" 1 
		26 "LeftArmEff.translateX" 1 27 "LeftFingerBaseEff.reachRotation" 0 
		25 "LeftFingerBaseEff.reachTranslation" 0 26 "LeftFingerBaseEff.rotateZ" 
		2 28 "LeftFingerBaseEff.rotateY" 2 29 "LeftFingerBaseEff.rotateX" 
		2 30 "LeftFingerBaseEff.translateZ" 1 28 "LeftFingerBaseEff.translateY" 
		1 29 "LeftFingerBaseEff.translateX" 1 30  ;
	setAttr ".aal" -type "attributeAlias" {"leftForeArmRollFK_rotateZ","angularValues[10]"
		,"leftForeArmRollFK_rotateY","angularValues[11]","leftForeArmRollFK_rotateX","angularValues[12]"
		,"leftHandFK_rotateZ","angularValues[13]","leftHandFK_rotateY","angularValues[14]"
		,"leftHandFK_rotateX","angularValues[15]","joint23FK_rotateZ","angularValues[16]"
		,"joint23FK_rotateY","angularValues[17]","joint23FK_rotateX","angularValues[18]","LeftHandEff_rotateZ"
		,"angularValues[19]","leftShoulderFK_rotateZ","angularValues[1]","LeftHandEff_rotateY"
		,"angularValues[20]","LeftHandEff_rotateX","angularValues[21]","LeftForeArmEff_rotateZ"
		,"angularValues[22]","LeftForeArmEff_rotateY","angularValues[23]","LeftForeArmEff_rotateX"
		,"angularValues[24]","LeftArmEff_rotateZ","angularValues[25]","LeftArmEff_rotateY"
		,"angularValues[26]","LeftArmEff_rotateX","angularValues[27]","LeftFingerBaseEff_rotateZ"
		,"angularValues[28]","LeftFingerBaseEff_rotateY","angularValues[29]","leftShoulderFK_rotateY"
		,"angularValues[2]","LeftFingerBaseEff_rotateX","angularValues[30]","leftShoulderFK_rotateX"
		,"angularValues[3]","leftArmFK_rotateZ","angularValues[4]","leftArmFK_rotateY","angularValues[5]"
		,"leftArmFK_rotateX","angularValues[6]","leftForearmFK_rotateZ","angularValues[7]"
		,"leftForearmFK_rotateY","angularValues[8]","leftForearmFK_rotateX","angularValues[9]"
		,"leftForeArmRollFK_translateZ","linearValues[10]","leftForeArmRollFK_translateY"
		,"linearValues[11]","leftForeArmRollFK_translateX","linearValues[12]","leftHandFK_translateZ"
		,"linearValues[13]","leftHandFK_translateY","linearValues[14]","leftHandFK_translateX"
		,"linearValues[15]","joint23FK_translateZ","linearValues[16]","joint23FK_translateY"
		,"linearValues[17]","joint23FK_translateX","linearValues[18]","LeftHandEff_translateZ"
		,"linearValues[19]","leftShoulderFK_translateZ","linearValues[1]","LeftHandEff_translateY"
		,"linearValues[20]","LeftHandEff_translateX","linearValues[21]","LeftForeArmEff_translateZ"
		,"linearValues[22]","LeftForeArmEff_translateY","linearValues[23]","LeftForeArmEff_translateX"
		,"linearValues[24]","LeftArmEff_translateZ","linearValues[25]","LeftArmEff_translateY"
		,"linearValues[26]","LeftArmEff_translateX","linearValues[27]","LeftFingerBaseEff_translateZ"
		,"linearValues[28]","LeftFingerBaseEff_translateY","linearValues[29]","leftShoulderFK_translateY"
		,"linearValues[2]","LeftFingerBaseEff_translateX","linearValues[30]","leftShoulderFK_translateX"
		,"linearValues[3]","leftArmFK_translateZ","linearValues[4]","leftArmFK_translateY"
		,"linearValues[5]","leftArmFK_translateX","linearValues[6]","leftForearmFK_translateZ"
		,"linearValues[7]","leftForearmFK_translateY","linearValues[8]","leftForearmFK_translateX"
		,"linearValues[9]","leftForeArmRollFK_scaleZ","unitlessValues[10]","leftForeArmRollFK_scaleY"
		,"unitlessValues[11]","leftForeArmRollFK_scaleX","unitlessValues[12]","leftHandFK_scaleZ"
		,"unitlessValues[13]","leftHandFK_scaleY","unitlessValues[14]","leftHandFK_scaleX"
		,"unitlessValues[15]","joint23FK_scaleZ","unitlessValues[16]","joint23FK_scaleY","unitlessValues[17]"
		,"joint23FK_scaleX","unitlessValues[18]","LeftHandEff_reachRotation","unitlessValues[19]"
		,"leftShoulderFK_scaleZ","unitlessValues[1]","LeftHandEff_reachTranslation","unitlessValues[20]"
		,"LeftForeArmEff_reachRotation","unitlessValues[21]","LeftForeArmEff_reachTranslation"
		,"unitlessValues[22]","LeftArmEff_reachRotation","unitlessValues[23]","LeftArmEff_reachTranslation"
		,"unitlessValues[24]","LeftFingerBaseEff_reachRotation","unitlessValues[25]","LeftFingerBaseEff_reachTranslation"
		,"unitlessValues[26]","leftShoulderFK_scaleY","unitlessValues[2]","leftShoulderFK_scaleX"
		,"unitlessValues[3]","leftArmFK_scaleZ","unitlessValues[4]","leftArmFK_scaleY","unitlessValues[5]"
		,"leftArmFK_scaleX","unitlessValues[6]","leftForearmFK_scaleZ","unitlessValues[7]"
		,"leftForearmFK_scaleY","unitlessValues[8]","leftForearmFK_scaleX","unitlessValues[9]"
		} ;
createNode character -n "_rightArm";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 86 ".dnsm";
	setAttr -s 26 ".uv[1:26]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 
		0 0 0 0 0 0;
	setAttr -s 26 ".uv";
	setAttr -s 30 ".lv[1:30]"  0.073544265583918855 2.4520758287697664 
		-0.83456282463049181 -2.0428401509084101e-006 -0.12000998225167561 -1.3539544396088763 
		0.018400325893990845 0.0067532146792669114 -2.5535479097531986 0.023738690015218111 
		0.016399498468179056 -1.2539728706279032 0.021029530434516101 0.0071788456689747728 
		-1.2302032050357434 0.026036809352492932 0.050706361654526043 -0.96389843075265791 
		0 0 0 0 0 0 0 0 0 0 0 0;
	setAttr -s 30 ".lv";
	setAttr -s 30 ".av";
	setAttr -s 30 ".av";
	setAttr ".am" -type "characterMapping" 86 "rightShoulderFK.scaleZ" 0 1 "rightShoulderFK.scaleY" 
		0 2 "rightShoulderFK.scaleX" 0 3 "rightShoulderFK.rotateZ" 2 
		1 "rightShoulderFK.rotateY" 2 2 "rightShoulderFK.rotateX" 2 3 "rightShoulderFK.translateZ" 
		1 1 "rightShoulderFK.translateY" 1 2 "rightShoulderFK.translateX" 
		1 3 "rightArmFK.scaleZ" 0 4 "rightArmFK.scaleY" 0 5 "rightArmFK.scaleX" 
		0 6 "rightArmFK.rotateZ" 2 4 "rightArmFK.rotateY" 2 5 "rightArmFK.rotateX" 
		2 6 "rightArmFK.translateZ" 1 4 "rightArmFK.translateY" 1 
		5 "rightArmFK.translateX" 1 6 "rightForeArmFK.scaleZ" 0 7 "rightForeArmFK.scaleY" 
		0 8 "rightForeArmFK.scaleX" 0 9 "rightForeArmFK.rotateZ" 2 
		7 "rightForeArmFK.rotateY" 2 8 "rightForeArmFK.rotateX" 2 9 "rightForeArmFK.translateZ" 
		1 7 "rightForeArmFK.translateY" 1 8 "rightForeArmFK.translateX" 
		1 9 "rightForeArmRollFK.scaleZ" 0 10 "rightForeArmRollFK.scaleY" 
		0 11 "rightForeArmRollFK.scaleX" 0 12 "rightForeArmRollFK.rotateZ" 
		2 10 "rightForeArmRollFK.rotateY" 2 11 "rightForeArmRollFK.rotateX" 
		2 12 "rightForeArmRollFK.translateZ" 1 10 "rightForeArmRollFK.translateY" 
		1 11 "rightForeArmRollFK.translateX" 1 12 "rightHandFK.scaleZ" 
		0 13 "rightHandFK.scaleY" 0 14 "rightHandFK.scaleX" 0 15 "rightHandFK.rotateZ" 
		2 13 "rightHandFK.rotateY" 2 14 "rightHandFK.rotateX" 2 15 "rightHandFK.translateZ" 
		1 13 "rightHandFK.translateY" 1 14 "rightHandFK.translateX" 1 
		15 "joint67FK.scaleZ" 0 16 "joint67FK.scaleY" 0 17 "joint67FK.scaleX" 
		0 18 "joint67FK.rotateZ" 2 16 "joint67FK.rotateY" 2 17 "joint67FK.rotateX" 
		2 18 "joint67FK.translateZ" 1 16 "joint67FK.translateY" 1 
		17 "joint67FK.translateX" 1 18 "RightHandEff.reachRotation" 0 19 "RightHandEff.reachTranslation" 
		0 20 "RightHandEff.rotateZ" 2 19 "RightHandEff.rotateY" 2 
		20 "RightHandEff.rotateX" 2 21 "RightHandEff.translateZ" 1 19 "RightHandEff.translateY" 
		1 20 "RightHandEff.translateX" 1 21 "RightForeArmEff.reachRotation" 
		0 21 "RightForeArmEff.reachTranslation" 0 22 "RightForeArmEff.rotateZ" 
		2 22 "RightForeArmEff.rotateY" 2 23 "RightForeArmEff.rotateX" 2 
		24 "RightForeArmEff.translateZ" 1 22 "RightForeArmEff.translateY" 1 
		23 "RightForeArmEff.translateX" 1 24 "RightArmEff.reachRotation" 0 
		23 "RightArmEff.reachTranslation" 0 24 "RightArmEff.rotateZ" 2 
		25 "RightArmEff.rotateY" 2 26 "RightArmEff.rotateX" 2 27 "RightArmEff.translateZ" 
		1 25 "RightArmEff.translateY" 1 26 "RightArmEff.translateX" 1 
		27 "RightFingerBaseEff.reachRotation" 0 25 "RightFingerBaseEff.reachTranslation" 
		0 26 "RightFingerBaseEff.rotateZ" 2 28 "RightFingerBaseEff.rotateY" 
		2 29 "RightFingerBaseEff.rotateX" 2 30 "RightFingerBaseEff.translateZ" 
		1 28 "RightFingerBaseEff.translateY" 1 29 "RightFingerBaseEff.translateX" 
		1 30  ;
	setAttr ".aal" -type "attributeAlias" {"rightForeArmRollFK_rotateZ","angularValues[10]"
		,"rightForeArmRollFK_rotateY","angularValues[11]","rightForeArmRollFK_rotateX","angularValues[12]"
		,"rightHandFK_rotateZ","angularValues[13]","rightHandFK_rotateY","angularValues[14]"
		,"rightHandFK_rotateX","angularValues[15]","joint67FK_rotateZ","angularValues[16]"
		,"joint67FK_rotateY","angularValues[17]","joint67FK_rotateX","angularValues[18]","RightHandEff_rotateZ"
		,"angularValues[19]","rightShoulderFK_rotateZ","angularValues[1]","RightHandEff_rotateY"
		,"angularValues[20]","RightHandEff_rotateX","angularValues[21]","RightForeArmEff_rotateZ"
		,"angularValues[22]","RightForeArmEff_rotateY","angularValues[23]","RightForeArmEff_rotateX"
		,"angularValues[24]","RightArmEff_rotateZ","angularValues[25]","RightArmEff_rotateY"
		,"angularValues[26]","RightArmEff_rotateX","angularValues[27]","RightFingerBaseEff_rotateZ"
		,"angularValues[28]","RightFingerBaseEff_rotateY","angularValues[29]","rightShoulderFK_rotateY"
		,"angularValues[2]","RightFingerBaseEff_rotateX","angularValues[30]","rightShoulderFK_rotateX"
		,"angularValues[3]","rightArmFK_rotateZ","angularValues[4]","rightArmFK_rotateY","angularValues[5]"
		,"rightArmFK_rotateX","angularValues[6]","rightForeArmFK_rotateZ","angularValues[7]"
		,"rightForeArmFK_rotateY","angularValues[8]","rightForeArmFK_rotateX","angularValues[9]"
		,"rightForeArmRollFK_translateZ","linearValues[10]","rightForeArmRollFK_translateY"
		,"linearValues[11]","rightForeArmRollFK_translateX","linearValues[12]","rightHandFK_translateZ"
		,"linearValues[13]","rightHandFK_translateY","linearValues[14]","rightHandFK_translateX"
		,"linearValues[15]","joint67FK_translateZ","linearValues[16]","joint67FK_translateY"
		,"linearValues[17]","joint67FK_translateX","linearValues[18]","RightHandEff_translateZ"
		,"linearValues[19]","rightShoulderFK_translateZ","linearValues[1]","RightHandEff_translateY"
		,"linearValues[20]","RightHandEff_translateX","linearValues[21]","RightForeArmEff_translateZ"
		,"linearValues[22]","RightForeArmEff_translateY","linearValues[23]","RightForeArmEff_translateX"
		,"linearValues[24]","RightArmEff_translateZ","linearValues[25]","RightArmEff_translateY"
		,"linearValues[26]","RightArmEff_translateX","linearValues[27]","RightFingerBaseEff_translateZ"
		,"linearValues[28]","RightFingerBaseEff_translateY","linearValues[29]","rightShoulderFK_translateY"
		,"linearValues[2]","RightFingerBaseEff_translateX","linearValues[30]","rightShoulderFK_translateX"
		,"linearValues[3]","rightArmFK_translateZ","linearValues[4]","rightArmFK_translateY"
		,"linearValues[5]","rightArmFK_translateX","linearValues[6]","rightForeArmFK_translateZ"
		,"linearValues[7]","rightForeArmFK_translateY","linearValues[8]","rightForeArmFK_translateX"
		,"linearValues[9]","rightForeArmRollFK_scaleZ","unitlessValues[10]","rightForeArmRollFK_scaleY"
		,"unitlessValues[11]","rightForeArmRollFK_scaleX","unitlessValues[12]","rightHandFK_scaleZ"
		,"unitlessValues[13]","rightHandFK_scaleY","unitlessValues[14]","rightHandFK_scaleX"
		,"unitlessValues[15]","joint67FK_scaleZ","unitlessValues[16]","joint67FK_scaleY","unitlessValues[17]"
		,"joint67FK_scaleX","unitlessValues[18]","RightHandEff_reachRotation","unitlessValues[19]"
		,"rightShoulderFK_scaleZ","unitlessValues[1]","RightHandEff_reachTranslation","unitlessValues[20]"
		,"RightForeArmEff_reachRotation","unitlessValues[21]","RightForeArmEff_reachTranslation"
		,"unitlessValues[22]","RightArmEff_reachRotation","unitlessValues[23]","RightArmEff_reachTranslation"
		,"unitlessValues[24]","RightFingerBaseEff_reachRotation","unitlessValues[25]","RightFingerBaseEff_reachTranslation"
		,"unitlessValues[26]","rightShoulderFK_scaleY","unitlessValues[2]","rightShoulderFK_scaleX"
		,"unitlessValues[3]","rightArmFK_scaleZ","unitlessValues[4]","rightArmFK_scaleY","unitlessValues[5]"
		,"rightArmFK_scaleX","unitlessValues[6]","rightForeArmFK_scaleZ","unitlessValues[7]"
		,"rightForeArmFK_scaleY","unitlessValues[8]","rightForeArmFK_scaleX","unitlessValues[9]"
		} ;
createNode character -n "_leftLeg";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 84 ".dnsm";
	setAttr -s 24 ".uv[1:24]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 
		1 1 1 1;
	setAttr -s 24 ".uv";
	setAttr -s 30 ".lv[1:30]"  0.19211989137192209 -1.2884010433111879 
		1.0568778287666643 -0.08646630753549206 -4.5280032991538315 0.026856595641736338 
		-0.15190011267307738 -3.9345641136152403 -0.027581810951230089 1.005204915439182 
		-0.56296222528560724 0.033715741716443162 0 0 0 0 0 0 0 0 0 0 0 0 0.69959193468093872 
		0.091283738613128662 1.056146502494812 -0.61045730113983154 0.070153914391994476 
		1.056146502494812;
	setAttr -s 30 ".lv";
	setAttr -s 30 ".av[25:30]"  3.8576124349474997e-006 -0.00011078274547590739 
		-0.0018944378427228454 3.8576124349474997e-006 -0.00011078274547590739 -0.0018944378427228454;
	setAttr -s 30 ".av";
	setAttr ".am" -type "characterMapping" 84 "leftUpLegFK.scaleZ" 0 1 "leftUpLegFK.scaleY" 
		0 2 "leftUpLegFK.scaleX" 0 3 "leftUpLegFK.rotateZ" 2 1 "leftUpLegFK.rotateY" 
		2 2 "leftUpLegFK.rotateX" 2 3 "leftUpLegFK.translateZ" 1 
		1 "leftUpLegFK.translateY" 1 2 "leftUpLegFK.translateX" 1 3 "leftLegFK.scaleZ" 
		0 4 "leftLegFK.scaleY" 0 5 "leftLegFK.scaleX" 0 6 "leftLegFK.rotateZ" 
		2 4 "leftLegFK.rotateY" 2 5 "leftLegFK.rotateX" 2 6 "leftLegFK.translateZ" 
		1 4 "leftLegFK.translateY" 1 5 "leftLegFK.translateX" 1 
		6 "leftFootFK.scaleZ" 0 7 "leftFootFK.scaleY" 0 8 "leftFootFK.scaleX" 
		0 9 "leftFootFK.rotateZ" 2 7 "leftFootFK.rotateY" 2 8 "leftFootFK.rotateX" 
		2 9 "leftFootFK.translateZ" 1 7 "leftFootFK.translateY" 1 
		8 "leftFootFK.translateX" 1 9 "joint86FK.scaleZ" 0 10 "joint86FK.scaleY" 
		0 11 "joint86FK.scaleX" 0 12 "joint86FK.rotateZ" 2 10 "joint86FK.rotateY" 
		2 11 "joint86FK.rotateX" 2 12 "joint86FK.translateZ" 1 10 "joint86FK.translateY" 
		1 11 "joint86FK.translateX" 1 12 "LeftFootEff.reachRotation" 0 
		13 "LeftFootEff.reachTranslation" 0 14 "LeftFootEff.rotateZ" 2 
		13 "LeftFootEff.rotateY" 2 14 "LeftFootEff.rotateX" 2 15 "LeftFootEff.translateZ" 
		1 13 "LeftFootEff.translateY" 1 14 "LeftFootEff.translateX" 1 
		15 "LeftLegEff.reachRotation" 0 15 "LeftLegEff.reachTranslation" 0 
		16 "LeftLegEff.rotateZ" 2 16 "LeftLegEff.rotateY" 2 17 "LeftLegEff.rotateX" 
		2 18 "LeftLegEff.translateZ" 1 16 "LeftLegEff.translateY" 1 
		17 "LeftLegEff.translateX" 1 18 "LeftToeBaseEff.reachRotation" 0 
		17 "LeftToeBaseEff.reachTranslation" 0 18 "LeftToeBaseEff.rotateZ" 2 
		19 "LeftToeBaseEff.rotateY" 2 20 "LeftToeBaseEff.rotateX" 2 21 "LeftToeBaseEff.translateZ" 
		1 19 "LeftToeBaseEff.translateY" 1 20 "LeftToeBaseEff.translateX" 
		1 21 "LeftUpLegEff.reachRotation" 0 19 "LeftUpLegEff.reachTranslation" 
		0 20 "LeftUpLegEff.rotateZ" 2 22 "LeftUpLegEff.rotateY" 2 
		23 "LeftUpLegEff.rotateX" 2 24 "LeftUpLegEff.translateZ" 1 22 "LeftUpLegEff.translateY" 
		1 23 "LeftUpLegEff.translateX" 1 24 "LeftFootEffPivot.reachRotation" 
		0 21 "LeftFootEffPivot.reachTranslation" 0 22 "LeftFootEffPivot.translateZ" 
		1 25 "LeftFootEffPivot.translateY" 1 26 "LeftFootEffPivot.translateX" 
		1 27 "LeftFootEffPivot.rotateZ" 2 25 "LeftFootEffPivot.rotateY" 
		2 26 "LeftFootEffPivot.rotateX" 2 27 "LeftFootEffPivot1.reachRotation" 
		0 23 "LeftFootEffPivot1.reachTranslation" 0 24 "LeftFootEffPivot1.translateZ" 
		1 28 "LeftFootEffPivot1.translateY" 1 29 "LeftFootEffPivot1.translateX" 
		1 30 "LeftFootEffPivot1.rotateZ" 2 28 "LeftFootEffPivot1.rotateY" 
		2 29 "LeftFootEffPivot1.rotateX" 2 30  ;
	setAttr ".aal" -type "attributeAlias" {"joint86FK_rotateZ","angularValues[10]","joint86FK_rotateY"
		,"angularValues[11]","joint86FK_rotateX","angularValues[12]","LeftFootEff_rotateZ"
		,"angularValues[13]","LeftFootEff_rotateY","angularValues[14]","LeftFootEff_rotateX"
		,"angularValues[15]","LeftLegEff_rotateZ","angularValues[16]","LeftLegEff_rotateY"
		,"angularValues[17]","LeftLegEff_rotateX","angularValues[18]","LeftToeBaseEff_rotateZ"
		,"angularValues[19]","leftUpLegFK_rotateZ","angularValues[1]","LeftToeBaseEff_rotateY"
		,"angularValues[20]","LeftToeBaseEff_rotateX","angularValues[21]","LeftUpLegEff_rotateZ"
		,"angularValues[22]","LeftUpLegEff_rotateY","angularValues[23]","LeftUpLegEff_rotateX"
		,"angularValues[24]","LeftFootEffPivot_rotateZ","angularValues[25]","LeftFootEffPivot_rotateY"
		,"angularValues[26]","LeftFootEffPivot_rotateX","angularValues[27]","LeftFootEffPivot1_rotateZ"
		,"angularValues[28]","LeftFootEffPivot1_rotateY","angularValues[29]","leftUpLegFK_rotateY"
		,"angularValues[2]","LeftFootEffPivot1_rotateX","angularValues[30]","leftUpLegFK_rotateX"
		,"angularValues[3]","leftLegFK_rotateZ","angularValues[4]","leftLegFK_rotateY","angularValues[5]"
		,"leftLegFK_rotateX","angularValues[6]","leftFootFK_rotateZ","angularValues[7]","leftFootFK_rotateY"
		,"angularValues[8]","leftFootFK_rotateX","angularValues[9]","joint86FK_translateZ"
		,"linearValues[10]","joint86FK_translateY","linearValues[11]","joint86FK_translateX"
		,"linearValues[12]","LeftFootEff_translateZ","linearValues[13]","LeftFootEff_translateY"
		,"linearValues[14]","LeftFootEff_translateX","linearValues[15]","LeftLegEff_translateZ"
		,"linearValues[16]","LeftLegEff_translateY","linearValues[17]","LeftLegEff_translateX"
		,"linearValues[18]","LeftToeBaseEff_translateZ","linearValues[19]","leftUpLegFK_translateZ"
		,"linearValues[1]","LeftToeBaseEff_translateY","linearValues[20]","LeftToeBaseEff_translateX"
		,"linearValues[21]","LeftUpLegEff_translateZ","linearValues[22]","LeftUpLegEff_translateY"
		,"linearValues[23]","LeftUpLegEff_translateX","linearValues[24]","LeftFootEffPivot_translateZ"
		,"linearValues[25]","LeftFootEffPivot_translateY","linearValues[26]","LeftFootEffPivot_translateX"
		,"linearValues[27]","LeftFootEffPivot1_translateZ","linearValues[28]","LeftFootEffPivot1_translateY"
		,"linearValues[29]","leftUpLegFK_translateY","linearValues[2]","LeftFootEffPivot1_translateX"
		,"linearValues[30]","leftUpLegFK_translateX","linearValues[3]","leftLegFK_translateZ"
		,"linearValues[4]","leftLegFK_translateY","linearValues[5]","leftLegFK_translateX"
		,"linearValues[6]","leftFootFK_translateZ","linearValues[7]","leftFootFK_translateY"
		,"linearValues[8]","leftFootFK_translateX","linearValues[9]","joint86FK_scaleZ","unitlessValues[10]"
		,"joint86FK_scaleY","unitlessValues[11]","joint86FK_scaleX","unitlessValues[12]","LeftFootEff_reachRotation"
		,"unitlessValues[13]","LeftFootEff_reachTranslation","unitlessValues[14]","LeftLegEff_reachRotation"
		,"unitlessValues[15]","LeftLegEff_reachTranslation","unitlessValues[16]","LeftToeBaseEff_reachRotation"
		,"unitlessValues[17]","LeftToeBaseEff_reachTranslation","unitlessValues[18]","LeftUpLegEff_reachRotation"
		,"unitlessValues[19]","leftUpLegFK_scaleZ","unitlessValues[1]","LeftUpLegEff_reachTranslation"
		,"unitlessValues[20]","LeftFootEffPivot_reachRotation","unitlessValues[21]","LeftFootEffPivot_reachTranslation"
		,"unitlessValues[22]","LeftFootEffPivot1_reachRotation","unitlessValues[23]","LeftFootEffPivot1_reachTranslation"
		,"unitlessValues[24]","leftUpLegFK_scaleY","unitlessValues[2]","leftUpLegFK_scaleX"
		,"unitlessValues[3]","leftLegFK_scaleZ","unitlessValues[4]","leftLegFK_scaleY","unitlessValues[5]"
		,"leftLegFK_scaleX","unitlessValues[6]","leftFootFK_scaleZ","unitlessValues[7]","leftFootFK_scaleY"
		,"unitlessValues[8]","leftFootFK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightLeg";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 84 ".dnsm";
	setAttr -s 24 ".uv[1:24]"  1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 
		1 1 1 1;
	setAttr -s 24 ".uv";
	setAttr -s 30 ".lv[1:30]"  0.1921196762089111 -1.2884428293822072 -1.1177448525533544 
		-0.075548588447570203 -4.5188963627724412 0.033263968333561156 -0.13780568682031127 
		-3.9350489557891644 0.027574272879377495 0.97993771493536252 -0.57157394117734062 
		-0.010878051540656778 0 0 0 0 0 0 0 0 0 0 0 0 0.72468787431716919 0.099860586225986481 
		-1.0569123029708862 -0.58536124229431152 0.078729569911956787 -1.0569123029708862;
	setAttr -s 30 ".lv";
	setAttr -s 30 ".av[27:30]"  -4.3608867161913165e-006 0 0 -4.3608948584113012e-006;
	setAttr -s 30 ".av";
	setAttr ".am" -type "characterMapping" 84 "rightUpLegFK.scaleZ" 0 1 "rightUpLegFK.scaleY" 
		0 2 "rightUpLegFK.scaleX" 0 3 "rightUpLegFK.rotateZ" 2 1 "rightUpLegFK.rotateY" 
		2 2 "rightUpLegFK.rotateX" 2 3 "rightUpLegFK.translateZ" 1 
		1 "rightUpLegFK.translateY" 1 2 "rightUpLegFK.translateX" 1 3 "rightLegFK.scaleZ" 
		0 4 "rightLegFK.scaleY" 0 5 "rightLegFK.scaleX" 0 6 "rightLegFK.rotateZ" 
		2 4 "rightLegFK.rotateY" 2 5 "rightLegFK.rotateX" 2 6 "rightLegFK.translateZ" 
		1 4 "rightLegFK.translateY" 1 5 "rightLegFK.translateX" 1 
		6 "rightFootFK.scaleZ" 0 7 "rightFootFK.scaleY" 0 8 "rightFootFK.scaleX" 
		0 9 "rightFootFK.rotateZ" 2 7 "rightFootFK.rotateY" 2 8 "rightFootFK.rotateX" 
		2 9 "rightFootFK.translateZ" 1 7 "rightFootFK.translateY" 1 
		8 "rightFootFK.translateX" 1 9 "joint87FK.scaleZ" 0 10 "joint87FK.scaleY" 
		0 11 "joint87FK.scaleX" 0 12 "joint87FK.rotateZ" 2 10 "joint87FK.rotateY" 
		2 11 "joint87FK.rotateX" 2 12 "joint87FK.translateZ" 1 10 "joint87FK.translateY" 
		1 11 "joint87FK.translateX" 1 12 "RightFootEff.reachRotation" 0 
		13 "RightFootEff.reachTranslation" 0 14 "RightFootEff.rotateZ" 2 
		13 "RightFootEff.rotateY" 2 14 "RightFootEff.rotateX" 2 15 "RightFootEff.translateZ" 
		1 13 "RightFootEff.translateY" 1 14 "RightFootEff.translateX" 1 
		15 "RightLegEff.reachRotation" 0 15 "RightLegEff.reachTranslation" 0 
		16 "RightLegEff.rotateZ" 2 16 "RightLegEff.rotateY" 2 17 "RightLegEff.rotateX" 
		2 18 "RightLegEff.translateZ" 1 16 "RightLegEff.translateY" 1 
		17 "RightLegEff.translateX" 1 18 "RightToeBaseEff.reachRotation" 0 
		17 "RightToeBaseEff.reachTranslation" 0 18 "RightToeBaseEff.rotateZ" 
		2 19 "RightToeBaseEff.rotateY" 2 20 "RightToeBaseEff.rotateX" 2 
		21 "RightToeBaseEff.translateZ" 1 19 "RightToeBaseEff.translateY" 1 
		20 "RightToeBaseEff.translateX" 1 21 "RightUpLegEff.reachRotation" 0 
		19 "RightUpLegEff.reachTranslation" 0 20 "RightUpLegEff.rotateZ" 2 
		22 "RightUpLegEff.rotateY" 2 23 "RightUpLegEff.rotateX" 2 24 "RightUpLegEff.translateZ" 
		1 22 "RightUpLegEff.translateY" 1 23 "RightUpLegEff.translateX" 
		1 24 "RightFootEffPivot.reachRotation" 0 21 "RightFootEffPivot.reachTranslation" 
		0 22 "RightFootEffPivot.translateZ" 1 25 "RightFootEffPivot.translateY" 
		1 26 "RightFootEffPivot.translateX" 1 27 "RightFootEffPivot.rotateZ" 
		2 25 "RightFootEffPivot.rotateY" 2 26 "RightFootEffPivot.rotateX" 
		2 27 "RightFootEffPivot1.reachRotation" 0 23 "RightFootEffPivot1.reachTranslation" 
		0 24 "RightFootEffPivot1.translateZ" 1 28 "RightFootEffPivot1.translateY" 
		1 29 "RightFootEffPivot1.translateX" 1 30 "RightFootEffPivot1.rotateZ" 
		2 28 "RightFootEffPivot1.rotateY" 2 29 "RightFootEffPivot1.rotateX" 
		2 30  ;
	setAttr ".aal" -type "attributeAlias" {"joint87FK_rotateZ","angularValues[10]","joint87FK_rotateY"
		,"angularValues[11]","joint87FK_rotateX","angularValues[12]","RightFootEff_rotateZ"
		,"angularValues[13]","RightFootEff_rotateY","angularValues[14]","RightFootEff_rotateX"
		,"angularValues[15]","RightLegEff_rotateZ","angularValues[16]","RightLegEff_rotateY"
		,"angularValues[17]","RightLegEff_rotateX","angularValues[18]","RightToeBaseEff_rotateZ"
		,"angularValues[19]","rightUpLegFK_rotateZ","angularValues[1]","RightToeBaseEff_rotateY"
		,"angularValues[20]","RightToeBaseEff_rotateX","angularValues[21]","RightUpLegEff_rotateZ"
		,"angularValues[22]","RightUpLegEff_rotateY","angularValues[23]","RightUpLegEff_rotateX"
		,"angularValues[24]","RightFootEffPivot_rotateZ","angularValues[25]","RightFootEffPivot_rotateY"
		,"angularValues[26]","RightFootEffPivot_rotateX","angularValues[27]","RightFootEffPivot1_rotateZ"
		,"angularValues[28]","RightFootEffPivot1_rotateY","angularValues[29]","rightUpLegFK_rotateY"
		,"angularValues[2]","RightFootEffPivot1_rotateX","angularValues[30]","rightUpLegFK_rotateX"
		,"angularValues[3]","rightLegFK_rotateZ","angularValues[4]","rightLegFK_rotateY","angularValues[5]"
		,"rightLegFK_rotateX","angularValues[6]","rightFootFK_rotateZ","angularValues[7]"
		,"rightFootFK_rotateY","angularValues[8]","rightFootFK_rotateX","angularValues[9]"
		,"joint87FK_translateZ","linearValues[10]","joint87FK_translateY","linearValues[11]"
		,"joint87FK_translateX","linearValues[12]","RightFootEff_translateZ","linearValues[13]"
		,"RightFootEff_translateY","linearValues[14]","RightFootEff_translateX","linearValues[15]"
		,"RightLegEff_translateZ","linearValues[16]","RightLegEff_translateY","linearValues[17]"
		,"RightLegEff_translateX","linearValues[18]","RightToeBaseEff_translateZ","linearValues[19]"
		,"rightUpLegFK_translateZ","linearValues[1]","RightToeBaseEff_translateY","linearValues[20]"
		,"RightToeBaseEff_translateX","linearValues[21]","RightUpLegEff_translateZ","linearValues[22]"
		,"RightUpLegEff_translateY","linearValues[23]","RightUpLegEff_translateX","linearValues[24]"
		,"RightFootEffPivot_translateZ","linearValues[25]","RightFootEffPivot_translateY"
		,"linearValues[26]","RightFootEffPivot_translateX","linearValues[27]","RightFootEffPivot1_translateZ"
		,"linearValues[28]","RightFootEffPivot1_translateY","linearValues[29]","rightUpLegFK_translateY"
		,"linearValues[2]","RightFootEffPivot1_translateX","linearValues[30]","rightUpLegFK_translateX"
		,"linearValues[3]","rightLegFK_translateZ","linearValues[4]","rightLegFK_translateY"
		,"linearValues[5]","rightLegFK_translateX","linearValues[6]","rightFootFK_translateZ"
		,"linearValues[7]","rightFootFK_translateY","linearValues[8]","rightFootFK_translateX"
		,"linearValues[9]","joint87FK_scaleZ","unitlessValues[10]","joint87FK_scaleY","unitlessValues[11]"
		,"joint87FK_scaleX","unitlessValues[12]","RightFootEff_reachRotation","unitlessValues[13]"
		,"RightFootEff_reachTranslation","unitlessValues[14]","RightLegEff_reachRotation"
		,"unitlessValues[15]","RightLegEff_reachTranslation","unitlessValues[16]","RightToeBaseEff_reachRotation"
		,"unitlessValues[17]","RightToeBaseEff_reachTranslation","unitlessValues[18]","RightUpLegEff_reachRotation"
		,"unitlessValues[19]","rightUpLegFK_scaleZ","unitlessValues[1]","RightUpLegEff_reachTranslation"
		,"unitlessValues[20]","RightFootEffPivot_reachRotation","unitlessValues[21]","RightFootEffPivot_reachTranslation"
		,"unitlessValues[22]","RightFootEffPivot1_reachRotation","unitlessValues[23]","RightFootEffPivot1_reachTranslation"
		,"unitlessValues[24]","rightUpLegFK_scaleY","unitlessValues[2]","rightUpLegFK_scaleX"
		,"unitlessValues[3]","rightLegFK_scaleZ","unitlessValues[4]","rightLegFK_scaleY","unitlessValues[5]"
		,"rightLegFK_scaleX","unitlessValues[6]","rightFootFK_scaleZ","unitlessValues[7]"
		,"rightFootFK_scaleY","unitlessValues[8]","rightFootFK_scaleX","unitlessValues[9]"
		} ;
createNode character -n "_spine";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 34 ".dnsm";
	setAttr -s 10 ".uv[1:10]"  1 1 1 1 1 1 0 0 0 0;
	setAttr -s 10 ".uv";
	setAttr -s 12 ".lv[1:12]"  0.23151192069830409 0.69452571868637669 
		-2.6820107450475882e-006 -0.057876914979057476 0.99839506194069649 1.8164463192447763e-006 
		0 0 0 0 0 0;
	setAttr -s 12 ".lv";
	setAttr -s 12 ".av";
	setAttr -s 12 ".av";
	setAttr ".am" -type "characterMapping" 34 "spineFK.scaleZ" 0 1 "spineFK.scaleY" 
		0 2 "spineFK.scaleX" 0 3 "spineFK.rotateZ" 2 1 "spineFK.rotateY" 
		2 2 "spineFK.rotateX" 2 3 "spineFK.translateZ" 1 1 "spineFK.translateY" 
		1 2 "spineFK.translateX" 1 3 "spine1FK.scaleZ" 0 4 "spine1FK.scaleY" 
		0 5 "spine1FK.scaleX" 0 6 "spine1FK.rotateZ" 2 4 "spine1FK.rotateY" 
		2 5 "spine1FK.rotateX" 2 6 "spine1FK.translateZ" 1 4 "spine1FK.translateY" 
		1 5 "spine1FK.translateX" 1 6 "SpineEff.reachRotation" 0 
		7 "SpineEff.reachTranslation" 0 8 "SpineEff.rotateZ" 2 7 "SpineEff.rotateY" 
		2 8 "SpineEff.rotateX" 2 9 "SpineEff.translateZ" 1 7 "SpineEff.translateY" 
		1 8 "SpineEff.translateX" 1 9 "NeckEff.reachRotation" 0 
		9 "NeckEff.reachTranslation" 0 10 "NeckEff.rotateZ" 2 10 "NeckEff.rotateY" 
		2 11 "NeckEff.rotateX" 2 12 "NeckEff.translateZ" 1 10 "NeckEff.translateY" 
		1 11 "NeckEff.translateX" 1 12  ;
	setAttr ".aal" -type "attributeAlias" {"NeckEff_rotateZ","angularValues[10]","NeckEff_rotateY"
		,"angularValues[11]","NeckEff_rotateX","angularValues[12]","spineFK_rotateZ","angularValues[1]"
		,"spineFK_rotateY","angularValues[2]","spineFK_rotateX","angularValues[3]","spine1FK_rotateZ"
		,"angularValues[4]","spine1FK_rotateY","angularValues[5]","spine1FK_rotateX","angularValues[6]"
		,"SpineEff_rotateZ","angularValues[7]","SpineEff_rotateY","angularValues[8]","SpineEff_rotateX"
		,"angularValues[9]","NeckEff_translateZ","linearValues[10]","NeckEff_translateY","linearValues[11]"
		,"NeckEff_translateX","linearValues[12]","spineFK_translateZ","linearValues[1]","spineFK_translateY"
		,"linearValues[2]","spineFK_translateX","linearValues[3]","spine1FK_translateZ","linearValues[4]"
		,"spine1FK_translateY","linearValues[5]","spine1FK_translateX","linearValues[6]","SpineEff_translateZ"
		,"linearValues[7]","SpineEff_translateY","linearValues[8]","SpineEff_translateX","linearValues[9]"
		,"NeckEff_reachTranslation","unitlessValues[10]","spineFK_scaleZ","unitlessValues[1]"
		,"spineFK_scaleY","unitlessValues[2]","spineFK_scaleX","unitlessValues[3]","spine1FK_scaleZ"
		,"unitlessValues[4]","spine1FK_scaleY","unitlessValues[5]","spine1FK_scaleX","unitlessValues[6]"
		,"SpineEff_reachRotation","unitlessValues[7]","SpineEff_reachTranslation","unitlessValues[8]"
		,"NeckEff_reachRotation","unitlessValues[9]"} ;
createNode character -n "_head";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 26 ".dnsm";
	setAttr -s 8 ".uv[1:8]"  1 1 1 1 1 1 0 0;
	setAttr -s 8 ".uv";
	setAttr -s 9 ".lv[1:9]"  -0.34499129930938088 2.947956115158858 6.9793614800835162e-006 
		0.24344017768903906 0.73030555669495456 -1.6621700719960425e-006 0 0 0;
	setAttr -s 9 ".lv";
	setAttr -s 9 ".av";
	setAttr -s 9 ".av";
	setAttr ".am" -type "characterMapping" 26 "neckFK.scaleZ" 0 1 "neckFK.scaleY" 
		0 2 "neckFK.scaleX" 0 3 "neckFK.rotateZ" 2 1 "neckFK.rotateY" 
		2 2 "neckFK.rotateX" 2 3 "neckFK.translateZ" 1 1 "neckFK.translateY" 
		1 2 "neckFK.translateX" 1 3 "headFK.scaleZ" 0 4 "headFK.scaleY" 
		0 5 "headFK.scaleX" 0 6 "headFK.rotateZ" 2 4 "headFK.rotateY" 
		2 5 "headFK.rotateX" 2 6 "headFK.translateZ" 1 4 "headFK.translateY" 
		1 5 "headFK.translateX" 1 6 "HeadEff.reachRotation" 0 7 "HeadEff.reachTranslation" 
		0 8 "HeadEff.rotateZ" 2 7 "HeadEff.rotateY" 2 8 "HeadEff.rotateX" 
		2 9 "HeadEff.translateZ" 1 7 "HeadEff.translateY" 1 8 "HeadEff.translateX" 
		1 9  ;
	setAttr ".aal" -type "attributeAlias" {"neckFK_rotateZ","angularValues[1]","neckFK_rotateY"
		,"angularValues[2]","neckFK_rotateX","angularValues[3]","headFK_rotateZ","angularValues[4]"
		,"headFK_rotateY","angularValues[5]","headFK_rotateX","angularValues[6]","HeadEff_rotateZ"
		,"angularValues[7]","HeadEff_rotateY","angularValues[8]","HeadEff_rotateX","angularValues[9]"
		,"neckFK_translateZ","linearValues[1]","neckFK_translateY","linearValues[2]","neckFK_translateX"
		,"linearValues[3]","headFK_translateZ","linearValues[4]","headFK_translateY","linearValues[5]"
		,"headFK_translateX","linearValues[6]","HeadEff_translateZ","linearValues[7]","HeadEff_translateY"
		,"linearValues[8]","HeadEff_translateX","linearValues[9]","neckFK_scaleZ","unitlessValues[1]"
		,"neckFK_scaleY","unitlessValues[2]","neckFK_scaleX","unitlessValues[3]","headFK_scaleZ"
		,"unitlessValues[4]","headFK_scaleY","unitlessValues[5]","headFK_scaleX","unitlessValues[6]"
		,"HeadEff_reachRotation","unitlessValues[7]","HeadEff_reachTranslation","unitlessValues[8]"
		} ;
createNode character -n "_hips";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 17 ".dnsm";
	setAttr -s 5 ".uv[1:5]"  1 1 1 1 1;
	setAttr -s 5 ".uv";
	setAttr -s 6 ".lv[1:6]"  -0.2471792995929718 10.402189254760742 -5.7220458984375e-006 
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
createNode character -n "_leftFingerPinky";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  -0.32828174509318436 0.023674422817662733 
		1.0073396194229023 -0.028456967916316314 -0.040773137037364654 0.34900889435077065 
		0.015379894981396717 -0.096190704593764012 0.20249047377103394 0.00015307385392961939 
		-0.048885733002120825 0.12156859600715102 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "leftHandPinky1FK.scaleZ" 0 1 "leftHandPinky1FK.scaleY" 
		0 2 "leftHandPinky1FK.scaleX" 0 3 "leftHandPinky1FK.rotateZ" 
		2 1 "leftHandPinky1FK.rotateY" 2 2 "leftHandPinky1FK.rotateX" 
		2 3 "leftHandPinky1FK.translateZ" 1 1 "leftHandPinky1FK.translateY" 
		1 2 "leftHandPinky1FK.translateX" 1 3 "leftHandPinky2FK.scaleZ" 
		0 4 "leftHandPinky2FK.scaleY" 0 5 "leftHandPinky2FK.scaleX" 0 
		6 "leftHandPinky2FK.rotateZ" 2 4 "leftHandPinky2FK.rotateY" 2 
		5 "leftHandPinky2FK.rotateX" 2 6 "leftHandPinky2FK.translateZ" 1 
		4 "leftHandPinky2FK.translateY" 1 5 "leftHandPinky2FK.translateX" 
		1 6 "leftHandPinky3FK.scaleZ" 0 7 "leftHandPinky3FK.scaleY" 0 
		8 "leftHandPinky3FK.scaleX" 0 9 "leftHandPinky3FK.rotateZ" 2 
		7 "leftHandPinky3FK.rotateY" 2 8 "leftHandPinky3FK.rotateX" 2 
		9 "leftHandPinky3FK.translateZ" 1 7 "leftHandPinky3FK.translateY" 
		1 8 "leftHandPinky3FK.translateX" 1 9 "leftHandPinky4FK.scaleZ" 
		0 10 "leftHandPinky4FK.scaleY" 0 11 "leftHandPinky4FK.scaleX" 0 
		12 "leftHandPinky4FK.rotateZ" 2 10 "leftHandPinky4FK.rotateY" 2 
		11 "leftHandPinky4FK.rotateX" 2 12 "leftHandPinky4FK.translateZ" 1 
		10 "leftHandPinky4FK.translateY" 1 11 "leftHandPinky4FK.translateX" 
		1 12 "LeftHandPinky1Eff.reachRotation" 0 13 "LeftHandPinky1Eff.reachTranslation" 
		0 14 "LeftHandPinky1Eff.rotateZ" 2 13 "LeftHandPinky1Eff.rotateY" 
		2 14 "LeftHandPinky1Eff.rotateX" 2 15 "LeftHandPinky1Eff.translateZ" 
		1 13 "LeftHandPinky1Eff.translateY" 1 14 "LeftHandPinky1Eff.translateX" 
		1 15  ;
	setAttr ".aal" -type "attributeAlias" {"leftHandPinky4FK_rotateZ","angularValues[10]"
		,"leftHandPinky4FK_rotateY","angularValues[11]","leftHandPinky4FK_rotateX","angularValues[12]"
		,"LeftHandPinky1Eff_rotateZ","angularValues[13]","LeftHandPinky1Eff_rotateY","angularValues[14]"
		,"LeftHandPinky1Eff_rotateX","angularValues[15]","leftHandPinky1FK_rotateZ","angularValues[1]"
		,"leftHandPinky1FK_rotateY","angularValues[2]","leftHandPinky1FK_rotateX","angularValues[3]"
		,"leftHandPinky2FK_rotateZ","angularValues[4]","leftHandPinky2FK_rotateY","angularValues[5]"
		,"leftHandPinky2FK_rotateX","angularValues[6]","leftHandPinky3FK_rotateZ","angularValues[7]"
		,"leftHandPinky3FK_rotateY","angularValues[8]","leftHandPinky3FK_rotateX","angularValues[9]"
		,"leftHandPinky4FK_translateZ","linearValues[10]","leftHandPinky4FK_translateY","linearValues[11]"
		,"leftHandPinky4FK_translateX","linearValues[12]","LeftHandPinky1Eff_translateZ","linearValues[13]"
		,"LeftHandPinky1Eff_translateY","linearValues[14]","LeftHandPinky1Eff_translateX"
		,"linearValues[15]","leftHandPinky1FK_translateZ","linearValues[1]","leftHandPinky1FK_translateY"
		,"linearValues[2]","leftHandPinky1FK_translateX","linearValues[3]","leftHandPinky2FK_translateZ"
		,"linearValues[4]","leftHandPinky2FK_translateY","linearValues[5]","leftHandPinky2FK_translateX"
		,"linearValues[6]","leftHandPinky3FK_translateZ","linearValues[7]","leftHandPinky3FK_translateY"
		,"linearValues[8]","leftHandPinky3FK_translateX","linearValues[9]","leftHandPinky4FK_scaleZ"
		,"unitlessValues[10]","leftHandPinky4FK_scaleY","unitlessValues[11]","leftHandPinky4FK_scaleX"
		,"unitlessValues[12]","LeftHandPinky1Eff_reachRotation","unitlessValues[13]","LeftHandPinky1Eff_reachTranslation"
		,"unitlessValues[14]","leftHandPinky1FK_scaleZ","unitlessValues[1]","leftHandPinky1FK_scaleY"
		,"unitlessValues[2]","leftHandPinky1FK_scaleX","unitlessValues[3]","leftHandPinky2FK_scaleZ"
		,"unitlessValues[4]","leftHandPinky2FK_scaleY","unitlessValues[5]","leftHandPinky2FK_scaleX"
		,"unitlessValues[6]","leftHandPinky3FK_scaleZ","unitlessValues[7]","leftHandPinky3FK_scaleY"
		,"unitlessValues[8]","leftHandPinky3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFingerRing";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  -0.14440537495974479 0.037361565662604845 
		1.0622003039206795 -0.038931332359966569 0.010188095119777646 0.42749920126748181 
		-0.0047687856227853443 -0.048985147307158618 0.21390991612910601 0.0057878513580885598 
		-0.027634367968899155 0.15576518503880796 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "leftHandRing1FK.scaleZ" 0 1 "leftHandRing1FK.scaleY" 
		0 2 "leftHandRing1FK.scaleX" 0 3 "leftHandRing1FK.rotateZ" 2 
		1 "leftHandRing1FK.rotateY" 2 2 "leftHandRing1FK.rotateX" 2 3 "leftHandRing1FK.translateZ" 
		1 1 "leftHandRing1FK.translateY" 1 2 "leftHandRing1FK.translateX" 
		1 3 "leftHandRing2FK.scaleZ" 0 4 "leftHandRing2FK.scaleY" 0 
		5 "leftHandRing2FK.scaleX" 0 6 "leftHandRing2FK.rotateZ" 2 4 "leftHandRing2FK.rotateY" 
		2 5 "leftHandRing2FK.rotateX" 2 6 "leftHandRing2FK.translateZ" 
		1 4 "leftHandRing2FK.translateY" 1 5 "leftHandRing2FK.translateX" 
		1 6 "leftHandRing3FK.scaleZ" 0 7 "leftHandRing3FK.scaleY" 0 
		8 "leftHandRing3FK.scaleX" 0 9 "leftHandRing3FK.rotateZ" 2 7 "leftHandRing3FK.rotateY" 
		2 8 "leftHandRing3FK.rotateX" 2 9 "leftHandRing3FK.translateZ" 
		1 7 "leftHandRing3FK.translateY" 1 8 "leftHandRing3FK.translateX" 
		1 9 "leftHandRing4FK.scaleZ" 0 10 "leftHandRing4FK.scaleY" 0 
		11 "leftHandRing4FK.scaleX" 0 12 "leftHandRing4FK.rotateZ" 2 10 "leftHandRing4FK.rotateY" 
		2 11 "leftHandRing4FK.rotateX" 2 12 "leftHandRing4FK.translateZ" 
		1 10 "leftHandRing4FK.translateY" 1 11 "leftHandRing4FK.translateX" 
		1 12 "LeftHandRing1Eff.reachRotation" 0 13 "LeftHandRing1Eff.reachTranslation" 
		0 14 "LeftHandRing1Eff.rotateZ" 2 13 "LeftHandRing1Eff.rotateY" 
		2 14 "LeftHandRing1Eff.rotateX" 2 15 "LeftHandRing1Eff.translateZ" 
		1 13 "LeftHandRing1Eff.translateY" 1 14 "LeftHandRing1Eff.translateX" 
		1 15  ;
	setAttr ".aal" -type "attributeAlias" {"leftHandRing4FK_rotateZ","angularValues[10]"
		,"leftHandRing4FK_rotateY","angularValues[11]","leftHandRing4FK_rotateX","angularValues[12]"
		,"LeftHandRing1Eff_rotateZ","angularValues[13]","LeftHandRing1Eff_rotateY","angularValues[14]"
		,"LeftHandRing1Eff_rotateX","angularValues[15]","leftHandRing1FK_rotateZ","angularValues[1]"
		,"leftHandRing1FK_rotateY","angularValues[2]","leftHandRing1FK_rotateX","angularValues[3]"
		,"leftHandRing2FK_rotateZ","angularValues[4]","leftHandRing2FK_rotateY","angularValues[5]"
		,"leftHandRing2FK_rotateX","angularValues[6]","leftHandRing3FK_rotateZ","angularValues[7]"
		,"leftHandRing3FK_rotateY","angularValues[8]","leftHandRing3FK_rotateX","angularValues[9]"
		,"leftHandRing4FK_translateZ","linearValues[10]","leftHandRing4FK_translateY","linearValues[11]"
		,"leftHandRing4FK_translateX","linearValues[12]","LeftHandRing1Eff_translateZ","linearValues[13]"
		,"LeftHandRing1Eff_translateY","linearValues[14]","LeftHandRing1Eff_translateX","linearValues[15]"
		,"leftHandRing1FK_translateZ","linearValues[1]","leftHandRing1FK_translateY","linearValues[2]"
		,"leftHandRing1FK_translateX","linearValues[3]","leftHandRing2FK_translateZ","linearValues[4]"
		,"leftHandRing2FK_translateY","linearValues[5]","leftHandRing2FK_translateX","linearValues[6]"
		,"leftHandRing3FK_translateZ","linearValues[7]","leftHandRing3FK_translateY","linearValues[8]"
		,"leftHandRing3FK_translateX","linearValues[9]","leftHandRing4FK_scaleZ","unitlessValues[10]"
		,"leftHandRing4FK_scaleY","unitlessValues[11]","leftHandRing4FK_scaleX","unitlessValues[12]"
		,"LeftHandRing1Eff_reachRotation","unitlessValues[13]","LeftHandRing1Eff_reachTranslation"
		,"unitlessValues[14]","leftHandRing1FK_scaleZ","unitlessValues[1]","leftHandRing1FK_scaleY"
		,"unitlessValues[2]","leftHandRing1FK_scaleX","unitlessValues[3]","leftHandRing2FK_scaleZ"
		,"unitlessValues[4]","leftHandRing2FK_scaleY","unitlessValues[5]","leftHandRing2FK_scaleX"
		,"unitlessValues[6]","leftHandRing3FK_scaleZ","unitlessValues[7]","leftHandRing3FK_scaleY"
		,"unitlessValues[8]","leftHandRing3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFingerMiddle";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  -0.00079959006683974802 0.0036561507309358868 
		0.11372317308657645 -0.0023021459307001032 0.047915273092804418 0.50358197771087276 
		0.013065423627383981 0.003817884514729157 0.21384710794110443 -0.0038028151224940459 
		-0.01541414160720078 0.17931326113139437 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "leftHandMiddle1FK.scaleZ" 0 
		1 "leftHandMiddle1FK.scaleY" 0 2 "leftHandMiddle1FK.scaleX" 0 
		3 "leftHandMiddle1FK.rotateZ" 2 1 "leftHandMiddle1FK.rotateY" 2 
		2 "leftHandMiddle1FK.rotateX" 2 3 "leftHandMiddle1FK.translateZ" 1 
		1 "leftHandMiddle1FK.translateY" 1 2 "leftHandMiddle1FK.translateX" 
		1 3 "leftHandMiddle2FK.scaleZ" 0 4 "leftHandMiddle2FK.scaleY" 
		0 5 "leftHandMiddle2FK.scaleX" 0 6 "leftHandMiddle2FK.rotateZ" 
		2 4 "leftHandMiddle2FK.rotateY" 2 5 "leftHandMiddle2FK.rotateX" 
		2 6 "leftHandMiddle2FK.translateZ" 1 4 "leftHandMiddle2FK.translateY" 
		1 5 "leftHandMiddle2FK.translateX" 1 6 "leftHandMiddle3FK.scaleZ" 
		0 7 "leftHandMiddle3FK.scaleY" 0 8 "leftHandMiddle3FK.scaleX" 
		0 9 "leftHandMiddle3FK.rotateZ" 2 7 "leftHandMiddle3FK.rotateY" 
		2 8 "leftHandMiddle3FK.rotateX" 2 9 "leftHandMiddle3FK.translateZ" 
		1 7 "leftHandMiddle3FK.translateY" 1 8 "leftHandMiddle3FK.translateX" 
		1 9 "leftHandMiddle4FK.scaleZ" 0 10 "leftHandMiddle4FK.scaleY" 
		0 11 "leftHandMiddle4FK.scaleX" 0 12 "leftHandMiddle4FK.rotateZ" 
		2 10 "leftHandMiddle4FK.rotateY" 2 11 "leftHandMiddle4FK.rotateX" 
		2 12 "leftHandMiddle4FK.translateZ" 1 10 "leftHandMiddle4FK.translateY" 
		1 11 "leftHandMiddle4FK.translateX" 1 12 "LeftHandMiddle1Eff.reachRotation" 
		0 13 "LeftHandMiddle1Eff.reachTranslation" 0 14 "LeftHandMiddle1Eff.rotateZ" 
		2 13 "LeftHandMiddle1Eff.rotateY" 2 14 "LeftHandMiddle1Eff.rotateX" 
		2 15 "LeftHandMiddle1Eff.translateZ" 1 13 "LeftHandMiddle1Eff.translateY" 
		1 14 "LeftHandMiddle1Eff.translateX" 1 15  ;
	setAttr ".aal" -type "attributeAlias" {"leftHandMiddle4FK_rotateZ","angularValues[10]"
		,"leftHandMiddle4FK_rotateY","angularValues[11]","leftHandMiddle4FK_rotateX","angularValues[12]"
		,"LeftHandMiddle1Eff_rotateZ","angularValues[13]","LeftHandMiddle1Eff_rotateY","angularValues[14]"
		,"LeftHandMiddle1Eff_rotateX","angularValues[15]","leftHandMiddle1FK_rotateZ","angularValues[1]"
		,"leftHandMiddle1FK_rotateY","angularValues[2]","leftHandMiddle1FK_rotateX","angularValues[3]"
		,"leftHandMiddle2FK_rotateZ","angularValues[4]","leftHandMiddle2FK_rotateY","angularValues[5]"
		,"leftHandMiddle2FK_rotateX","angularValues[6]","leftHandMiddle3FK_rotateZ","angularValues[7]"
		,"leftHandMiddle3FK_rotateY","angularValues[8]","leftHandMiddle3FK_rotateX","angularValues[9]"
		,"leftHandMiddle4FK_translateZ","linearValues[10]","leftHandMiddle4FK_translateY"
		,"linearValues[11]","leftHandMiddle4FK_translateX","linearValues[12]","LeftHandMiddle1Eff_translateZ"
		,"linearValues[13]","LeftHandMiddle1Eff_translateY","linearValues[14]","LeftHandMiddle1Eff_translateX"
		,"linearValues[15]","leftHandMiddle1FK_translateZ","linearValues[1]","leftHandMiddle1FK_translateY"
		,"linearValues[2]","leftHandMiddle1FK_translateX","linearValues[3]","leftHandMiddle2FK_translateZ"
		,"linearValues[4]","leftHandMiddle2FK_translateY","linearValues[5]","leftHandMiddle2FK_translateX"
		,"linearValues[6]","leftHandMiddle3FK_translateZ","linearValues[7]","leftHandMiddle3FK_translateY"
		,"linearValues[8]","leftHandMiddle3FK_translateX","linearValues[9]","leftHandMiddle4FK_scaleZ"
		,"unitlessValues[10]","leftHandMiddle4FK_scaleY","unitlessValues[11]","leftHandMiddle4FK_scaleX"
		,"unitlessValues[12]","LeftHandMiddle1Eff_reachRotation","unitlessValues[13]","LeftHandMiddle1Eff_reachTranslation"
		,"unitlessValues[14]","leftHandMiddle1FK_scaleZ","unitlessValues[1]","leftHandMiddle1FK_scaleY"
		,"unitlessValues[2]","leftHandMiddle1FK_scaleX","unitlessValues[3]","leftHandMiddle2FK_scaleZ"
		,"unitlessValues[4]","leftHandMiddle2FK_scaleY","unitlessValues[5]","leftHandMiddle2FK_scaleX"
		,"unitlessValues[6]","leftHandMiddle3FK_scaleZ","unitlessValues[7]","leftHandMiddle3FK_scaleY"
		,"unitlessValues[8]","leftHandMiddle3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFingerIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  0.21497318780337166 0.028522406407208375 
		1.049118623442272 0.046276136816297012 0.031386311218140305 0.47393241828238086 0.0020215061062254023 
		-0.010802893680651461 0.2095986187848152 0.010532769526867918 -0.014459595241762426 
		0.15637683180805881 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "leftHandIndex1FK.scaleZ" 0 1 "leftHandIndex1FK.scaleY" 
		0 2 "leftHandIndex1FK.scaleX" 0 3 "leftHandIndex1FK.rotateZ" 
		2 1 "leftHandIndex1FK.rotateY" 2 2 "leftHandIndex1FK.rotateX" 
		2 3 "leftHandIndex1FK.translateZ" 1 1 "leftHandIndex1FK.translateY" 
		1 2 "leftHandIndex1FK.translateX" 1 3 "leftHandIndex2FK.scaleZ" 
		0 4 "leftHandIndex2FK.scaleY" 0 5 "leftHandIndex2FK.scaleX" 0 
		6 "leftHandIndex2FK.rotateZ" 2 4 "leftHandIndex2FK.rotateY" 2 
		5 "leftHandIndex2FK.rotateX" 2 6 "leftHandIndex2FK.translateZ" 1 
		4 "leftHandIndex2FK.translateY" 1 5 "leftHandIndex2FK.translateX" 
		1 6 "leftHandIndex3FK.scaleZ" 0 7 "leftHandIndex3FK.scaleY" 0 
		8 "leftHandIndex3FK.scaleX" 0 9 "leftHandIndex3FK.rotateZ" 2 
		7 "leftHandIndex3FK.rotateY" 2 8 "leftHandIndex3FK.rotateX" 2 
		9 "leftHandIndex3FK.translateZ" 1 7 "leftHandIndex3FK.translateY" 
		1 8 "leftHandIndex3FK.translateX" 1 9 "leftHandIndex4FK.scaleZ" 
		0 10 "leftHandIndex4FK.scaleY" 0 11 "leftHandIndex4FK.scaleX" 0 
		12 "leftHandIndex4FK.rotateZ" 2 10 "leftHandIndex4FK.rotateY" 2 
		11 "leftHandIndex4FK.rotateX" 2 12 "leftHandIndex4FK.translateZ" 1 
		10 "leftHandIndex4FK.translateY" 1 11 "leftHandIndex4FK.translateX" 
		1 12 "LeftHandIndex1Eff.reachRotation" 0 13 "LeftHandIndex1Eff.reachTranslation" 
		0 14 "LeftHandIndex1Eff.rotateZ" 2 13 "LeftHandIndex1Eff.rotateY" 
		2 14 "LeftHandIndex1Eff.rotateX" 2 15 "LeftHandIndex1Eff.translateZ" 
		1 13 "LeftHandIndex1Eff.translateY" 1 14 "LeftHandIndex1Eff.translateX" 
		1 15  ;
	setAttr ".aal" -type "attributeAlias" {"leftHandIndex4FK_rotateZ","angularValues[10]"
		,"leftHandIndex4FK_rotateY","angularValues[11]","leftHandIndex4FK_rotateX","angularValues[12]"
		,"LeftHandIndex1Eff_rotateZ","angularValues[13]","LeftHandIndex1Eff_rotateY","angularValues[14]"
		,"LeftHandIndex1Eff_rotateX","angularValues[15]","leftHandIndex1FK_rotateZ","angularValues[1]"
		,"leftHandIndex1FK_rotateY","angularValues[2]","leftHandIndex1FK_rotateX","angularValues[3]"
		,"leftHandIndex2FK_rotateZ","angularValues[4]","leftHandIndex2FK_rotateY","angularValues[5]"
		,"leftHandIndex2FK_rotateX","angularValues[6]","leftHandIndex3FK_rotateZ","angularValues[7]"
		,"leftHandIndex3FK_rotateY","angularValues[8]","leftHandIndex3FK_rotateX","angularValues[9]"
		,"leftHandIndex4FK_translateZ","linearValues[10]","leftHandIndex4FK_translateY","linearValues[11]"
		,"leftHandIndex4FK_translateX","linearValues[12]","LeftHandIndex1Eff_translateZ","linearValues[13]"
		,"LeftHandIndex1Eff_translateY","linearValues[14]","LeftHandIndex1Eff_translateX"
		,"linearValues[15]","leftHandIndex1FK_translateZ","linearValues[1]","leftHandIndex1FK_translateY"
		,"linearValues[2]","leftHandIndex1FK_translateX","linearValues[3]","leftHandIndex2FK_translateZ"
		,"linearValues[4]","leftHandIndex2FK_translateY","linearValues[5]","leftHandIndex2FK_translateX"
		,"linearValues[6]","leftHandIndex3FK_translateZ","linearValues[7]","leftHandIndex3FK_translateY"
		,"linearValues[8]","leftHandIndex3FK_translateX","linearValues[9]","leftHandIndex4FK_scaleZ"
		,"unitlessValues[10]","leftHandIndex4FK_scaleY","unitlessValues[11]","leftHandIndex4FK_scaleX"
		,"unitlessValues[12]","LeftHandIndex1Eff_reachRotation","unitlessValues[13]","LeftHandIndex1Eff_reachTranslation"
		,"unitlessValues[14]","leftHandIndex1FK_scaleZ","unitlessValues[1]","leftHandIndex1FK_scaleY"
		,"unitlessValues[2]","leftHandIndex1FK_scaleX","unitlessValues[3]","leftHandIndex2FK_scaleZ"
		,"unitlessValues[4]","leftHandIndex2FK_scaleY","unitlessValues[5]","leftHandIndex2FK_scaleX"
		,"unitlessValues[6]","leftHandIndex3FK_scaleZ","unitlessValues[7]","leftHandIndex3FK_scaleY"
		,"unitlessValues[8]","leftHandIndex3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftThumb";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  0.28742871556179289 -0.093880671601134891 
		0.35739326273043226 0.082815027753099679 -0.058753789947705234 0.42528428949732267 
		0.014275603779001967 0.019971704426914681 0.33063658117252726 -0.015570492901049946 
		0.012584700371998743 0.30595701318453383 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "leftHandThumb1FK.scaleZ" 0 1 "leftHandThumb1FK.scaleY" 
		0 2 "leftHandThumb1FK.scaleX" 0 3 "leftHandThumb1FK.rotateZ" 
		2 1 "leftHandThumb1FK.rotateY" 2 2 "leftHandThumb1FK.rotateX" 
		2 3 "leftHandThumb1FK.translateZ" 1 1 "leftHandThumb1FK.translateY" 
		1 2 "leftHandThumb1FK.translateX" 1 3 "leftHandThumb2FK.scaleZ" 
		0 4 "leftHandThumb2FK.scaleY" 0 5 "leftHandThumb2FK.scaleX" 0 
		6 "leftHandThumb2FK.rotateZ" 2 4 "leftHandThumb2FK.rotateY" 2 
		5 "leftHandThumb2FK.rotateX" 2 6 "leftHandThumb2FK.translateZ" 1 
		4 "leftHandThumb2FK.translateY" 1 5 "leftHandThumb2FK.translateX" 
		1 6 "leftHandThumb3FK.scaleZ" 0 7 "leftHandThumb3FK.scaleY" 0 
		8 "leftHandThumb3FK.scaleX" 0 9 "leftHandThumb3FK.rotateZ" 2 
		7 "leftHandThumb3FK.rotateY" 2 8 "leftHandThumb3FK.rotateX" 2 
		9 "leftHandThumb3FK.translateZ" 1 7 "leftHandThumb3FK.translateY" 
		1 8 "leftHandThumb3FK.translateX" 1 9 "leftHandThumb4FK.scaleZ" 
		0 10 "leftHandThumb4FK.scaleY" 0 11 "leftHandThumb4FK.scaleX" 0 
		12 "leftHandThumb4FK.rotateZ" 2 10 "leftHandThumb4FK.rotateY" 2 
		11 "leftHandThumb4FK.rotateX" 2 12 "leftHandThumb4FK.translateZ" 1 
		10 "leftHandThumb4FK.translateY" 1 11 "leftHandThumb4FK.translateX" 
		1 12 "LeftHandThumb1Eff.reachRotation" 0 13 "LeftHandThumb1Eff.reachTranslation" 
		0 14 "LeftHandThumb1Eff.rotateZ" 2 13 "LeftHandThumb1Eff.rotateY" 
		2 14 "LeftHandThumb1Eff.rotateX" 2 15 "LeftHandThumb1Eff.translateZ" 
		1 13 "LeftHandThumb1Eff.translateY" 1 14 "LeftHandThumb1Eff.translateX" 
		1 15  ;
	setAttr ".aal" -type "attributeAlias" {"leftHandThumb4FK_rotateZ","angularValues[10]"
		,"leftHandThumb4FK_rotateY","angularValues[11]","leftHandThumb4FK_rotateX","angularValues[12]"
		,"LeftHandThumb1Eff_rotateZ","angularValues[13]","LeftHandThumb1Eff_rotateY","angularValues[14]"
		,"LeftHandThumb1Eff_rotateX","angularValues[15]","leftHandThumb1FK_rotateZ","angularValues[1]"
		,"leftHandThumb1FK_rotateY","angularValues[2]","leftHandThumb1FK_rotateX","angularValues[3]"
		,"leftHandThumb2FK_rotateZ","angularValues[4]","leftHandThumb2FK_rotateY","angularValues[5]"
		,"leftHandThumb2FK_rotateX","angularValues[6]","leftHandThumb3FK_rotateZ","angularValues[7]"
		,"leftHandThumb3FK_rotateY","angularValues[8]","leftHandThumb3FK_rotateX","angularValues[9]"
		,"leftHandThumb4FK_translateZ","linearValues[10]","leftHandThumb4FK_translateY","linearValues[11]"
		,"leftHandThumb4FK_translateX","linearValues[12]","LeftHandThumb1Eff_translateZ","linearValues[13]"
		,"LeftHandThumb1Eff_translateY","linearValues[14]","LeftHandThumb1Eff_translateX"
		,"linearValues[15]","leftHandThumb1FK_translateZ","linearValues[1]","leftHandThumb1FK_translateY"
		,"linearValues[2]","leftHandThumb1FK_translateX","linearValues[3]","leftHandThumb2FK_translateZ"
		,"linearValues[4]","leftHandThumb2FK_translateY","linearValues[5]","leftHandThumb2FK_translateX"
		,"linearValues[6]","leftHandThumb3FK_translateZ","linearValues[7]","leftHandThumb3FK_translateY"
		,"linearValues[8]","leftHandThumb3FK_translateX","linearValues[9]","leftHandThumb4FK_scaleZ"
		,"unitlessValues[10]","leftHandThumb4FK_scaleY","unitlessValues[11]","leftHandThumb4FK_scaleX"
		,"unitlessValues[12]","LeftHandThumb1Eff_reachRotation","unitlessValues[13]","LeftHandThumb1Eff_reachTranslation"
		,"unitlessValues[14]","leftHandThumb1FK_scaleZ","unitlessValues[1]","leftHandThumb1FK_scaleY"
		,"unitlessValues[2]","leftHandThumb1FK_scaleX","unitlessValues[3]","leftHandThumb2FK_scaleZ"
		,"unitlessValues[4]","leftHandThumb2FK_scaleY","unitlessValues[5]","leftHandThumb2FK_scaleX"
		,"unitlessValues[6]","leftHandThumb3FK_scaleZ","unitlessValues[7]","leftHandThumb3FK_scaleY"
		,"unitlessValues[8]","leftHandThumb3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFingerPinky";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  -0.32329602767715304 0.04481571217314629 
		-1.0082311141559555 -0.026712151650626081 -0.033472014481965275 -0.34993586111447267 
		0.01642379049698629 -0.091869193519752784 -0.20438782025537006 0.00077836867157988284 
		-0.046368351097261153 -0.12259258201935108 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "rightHandPinky1FK.scaleZ" 0 
		1 "rightHandPinky1FK.scaleY" 0 2 "rightHandPinky1FK.scaleX" 0 
		3 "rightHandPinky1FK.rotateZ" 2 1 "rightHandPinky1FK.rotateY" 2 
		2 "rightHandPinky1FK.rotateX" 2 3 "rightHandPinky1FK.translateZ" 1 
		1 "rightHandPinky1FK.translateY" 1 2 "rightHandPinky1FK.translateX" 
		1 3 "rightHandPinky2FK.scaleZ" 0 4 "rightHandPinky2FK.scaleY" 
		0 5 "rightHandPinky2FK.scaleX" 0 6 "rightHandPinky2FK.rotateZ" 
		2 4 "rightHandPinky2FK.rotateY" 2 5 "rightHandPinky2FK.rotateX" 
		2 6 "rightHandPinky2FK.translateZ" 1 4 "rightHandPinky2FK.translateY" 
		1 5 "rightHandPinky2FK.translateX" 1 6 "rightHandPinky3FK.scaleZ" 
		0 7 "rightHandPinky3FK.scaleY" 0 8 "rightHandPinky3FK.scaleX" 
		0 9 "rightHandPinky3FK.rotateZ" 2 7 "rightHandPinky3FK.rotateY" 
		2 8 "rightHandPinky3FK.rotateX" 2 9 "rightHandPinky3FK.translateZ" 
		1 7 "rightHandPinky3FK.translateY" 1 8 "rightHandPinky3FK.translateX" 
		1 9 "rightHandPinky4FK.scaleZ" 0 10 "rightHandPinky4FK.scaleY" 
		0 11 "rightHandPinky4FK.scaleX" 0 12 "rightHandPinky4FK.rotateZ" 
		2 10 "rightHandPinky4FK.rotateY" 2 11 "rightHandPinky4FK.rotateX" 
		2 12 "rightHandPinky4FK.translateZ" 1 10 "rightHandPinky4FK.translateY" 
		1 11 "rightHandPinky4FK.translateX" 1 12 "RightHandPinky1Eff.reachRotation" 
		0 13 "RightHandPinky1Eff.reachTranslation" 0 14 "RightHandPinky1Eff.rotateZ" 
		2 13 "RightHandPinky1Eff.rotateY" 2 14 "RightHandPinky1Eff.rotateX" 
		2 15 "RightHandPinky1Eff.translateZ" 1 13 "RightHandPinky1Eff.translateY" 
		1 14 "RightHandPinky1Eff.translateX" 1 15  ;
	setAttr ".aal" -type "attributeAlias" {"rightHandPinky4FK_rotateZ","angularValues[10]"
		,"rightHandPinky4FK_rotateY","angularValues[11]","rightHandPinky4FK_rotateX","angularValues[12]"
		,"RightHandPinky1Eff_rotateZ","angularValues[13]","RightHandPinky1Eff_rotateY","angularValues[14]"
		,"RightHandPinky1Eff_rotateX","angularValues[15]","rightHandPinky1FK_rotateZ","angularValues[1]"
		,"rightHandPinky1FK_rotateY","angularValues[2]","rightHandPinky1FK_rotateX","angularValues[3]"
		,"rightHandPinky2FK_rotateZ","angularValues[4]","rightHandPinky2FK_rotateY","angularValues[5]"
		,"rightHandPinky2FK_rotateX","angularValues[6]","rightHandPinky3FK_rotateZ","angularValues[7]"
		,"rightHandPinky3FK_rotateY","angularValues[8]","rightHandPinky3FK_rotateX","angularValues[9]"
		,"rightHandPinky4FK_translateZ","linearValues[10]","rightHandPinky4FK_translateY"
		,"linearValues[11]","rightHandPinky4FK_translateX","linearValues[12]","RightHandPinky1Eff_translateZ"
		,"linearValues[13]","RightHandPinky1Eff_translateY","linearValues[14]","RightHandPinky1Eff_translateX"
		,"linearValues[15]","rightHandPinky1FK_translateZ","linearValues[1]","rightHandPinky1FK_translateY"
		,"linearValues[2]","rightHandPinky1FK_translateX","linearValues[3]","rightHandPinky2FK_translateZ"
		,"linearValues[4]","rightHandPinky2FK_translateY","linearValues[5]","rightHandPinky2FK_translateX"
		,"linearValues[6]","rightHandPinky3FK_translateZ","linearValues[7]","rightHandPinky3FK_translateY"
		,"linearValues[8]","rightHandPinky3FK_translateX","linearValues[9]","rightHandPinky4FK_scaleZ"
		,"unitlessValues[10]","rightHandPinky4FK_scaleY","unitlessValues[11]","rightHandPinky4FK_scaleX"
		,"unitlessValues[12]","RightHandPinky1Eff_reachRotation","unitlessValues[13]","RightHandPinky1Eff_reachTranslation"
		,"unitlessValues[14]","rightHandPinky1FK_scaleZ","unitlessValues[1]","rightHandPinky1FK_scaleY"
		,"unitlessValues[2]","rightHandPinky1FK_scaleX","unitlessValues[3]","rightHandPinky2FK_scaleZ"
		,"unitlessValues[4]","rightHandPinky2FK_scaleY","unitlessValues[5]","rightHandPinky2FK_scaleX"
		,"unitlessValues[6]","rightHandPinky3FK_scaleZ","unitlessValues[7]","rightHandPinky3FK_scaleY"
		,"unitlessValues[8]","rightHandPinky3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFingerRing";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  -0.13915980066745814 0.059691123928282901 
		-1.061879108403935 -0.036807110310162379 0.019182894688440776 -0.42739370325917042 
		-0.0036874329363724267 -0.044481735224933601 -0.21490686319282665 0.0065715623191960138 
		-0.024404588355113603 -0.15628087337219479 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "rightHandRing1FK.scaleZ" 0 1 "rightHandRing1FK.scaleY" 
		0 2 "rightHandRing1FK.scaleX" 0 3 "rightHandRing1FK.rotateZ" 
		2 1 "rightHandRing1FK.rotateY" 2 2 "rightHandRing1FK.rotateX" 
		2 3 "rightHandRing1FK.translateZ" 1 1 "rightHandRing1FK.translateY" 
		1 2 "rightHandRing1FK.translateX" 1 3 "rightHandRing2FK.scaleZ" 
		0 4 "rightHandRing2FK.scaleY" 0 5 "rightHandRing2FK.scaleX" 0 
		6 "rightHandRing2FK.rotateZ" 2 4 "rightHandRing2FK.rotateY" 2 
		5 "rightHandRing2FK.rotateX" 2 6 "rightHandRing2FK.translateZ" 1 
		4 "rightHandRing2FK.translateY" 1 5 "rightHandRing2FK.translateX" 
		1 6 "rightHandRing3FK.scaleZ" 0 7 "rightHandRing3FK.scaleY" 0 
		8 "rightHandRing3FK.scaleX" 0 9 "rightHandRing3FK.rotateZ" 2 
		7 "rightHandRing3FK.rotateY" 2 8 "rightHandRing3FK.rotateX" 2 
		9 "rightHandRing3FK.translateZ" 1 7 "rightHandRing3FK.translateY" 
		1 8 "rightHandRing3FK.translateX" 1 9 "rightHandRing4FK.scaleZ" 
		0 10 "rightHandRing4FK.scaleY" 0 11 "rightHandRing4FK.scaleX" 0 
		12 "rightHandRing4FK.rotateZ" 2 10 "rightHandRing4FK.rotateY" 2 
		11 "rightHandRing4FK.rotateX" 2 12 "rightHandRing4FK.translateZ" 1 
		10 "rightHandRing4FK.translateY" 1 11 "rightHandRing4FK.translateX" 
		1 12 "RightHandRing1Eff.reachRotation" 0 13 "RightHandRing1Eff.reachTranslation" 
		0 14 "RightHandRing1Eff.rotateZ" 2 13 "RightHandRing1Eff.rotateY" 
		2 14 "RightHandRing1Eff.rotateX" 2 15 "RightHandRing1Eff.translateZ" 
		1 13 "RightHandRing1Eff.translateY" 1 14 "RightHandRing1Eff.translateX" 
		1 15  ;
	setAttr ".aal" -type "attributeAlias" {"rightHandRing4FK_rotateZ","angularValues[10]"
		,"rightHandRing4FK_rotateY","angularValues[11]","rightHandRing4FK_rotateX","angularValues[12]"
		,"RightHandRing1Eff_rotateZ","angularValues[13]","RightHandRing1Eff_rotateY","angularValues[14]"
		,"RightHandRing1Eff_rotateX","angularValues[15]","rightHandRing1FK_rotateZ","angularValues[1]"
		,"rightHandRing1FK_rotateY","angularValues[2]","rightHandRing1FK_rotateX","angularValues[3]"
		,"rightHandRing2FK_rotateZ","angularValues[4]","rightHandRing2FK_rotateY","angularValues[5]"
		,"rightHandRing2FK_rotateX","angularValues[6]","rightHandRing3FK_rotateZ","angularValues[7]"
		,"rightHandRing3FK_rotateY","angularValues[8]","rightHandRing3FK_rotateX","angularValues[9]"
		,"rightHandRing4FK_translateZ","linearValues[10]","rightHandRing4FK_translateY","linearValues[11]"
		,"rightHandRing4FK_translateX","linearValues[12]","RightHandRing1Eff_translateZ","linearValues[13]"
		,"RightHandRing1Eff_translateY","linearValues[14]","RightHandRing1Eff_translateX"
		,"linearValues[15]","rightHandRing1FK_translateZ","linearValues[1]","rightHandRing1FK_translateY"
		,"linearValues[2]","rightHandRing1FK_translateX","linearValues[3]","rightHandRing2FK_translateZ"
		,"linearValues[4]","rightHandRing2FK_translateY","linearValues[5]","rightHandRing2FK_translateX"
		,"linearValues[6]","rightHandRing3FK_translateZ","linearValues[7]","rightHandRing3FK_translateY"
		,"linearValues[8]","rightHandRing3FK_translateX","linearValues[9]","rightHandRing4FK_scaleZ"
		,"unitlessValues[10]","rightHandRing4FK_scaleY","unitlessValues[11]","rightHandRing4FK_scaleX"
		,"unitlessValues[12]","RightHandRing1Eff_reachRotation","unitlessValues[13]","RightHandRing1Eff_reachTranslation"
		,"unitlessValues[14]","rightHandRing1FK_scaleZ","unitlessValues[1]","rightHandRing1FK_scaleY"
		,"unitlessValues[2]","rightHandRing1FK_scaleX","unitlessValues[3]","rightHandRing2FK_scaleZ"
		,"unitlessValues[4]","rightHandRing2FK_scaleY","unitlessValues[5]","rightHandRing2FK_scaleX"
		,"unitlessValues[6]","rightHandRing3FK_scaleZ","unitlessValues[7]","rightHandRing3FK_scaleY"
		,"unitlessValues[8]","rightHandRing3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFingerMiddle";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  -0.00019296761189595494 0.0048982675044240073 
		-0.091777979264918444 0.00016961871165111571 0.058470126530996216 -0.50245474737528895 
		0.014123759475301128 0.0083395535610799633 -0.21366225260245914 -0.0029118276700118933 
		-0.011632544717256074 -0.17962361539121999 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "rightHandMiddle1FK.scaleZ" 0 
		1 "rightHandMiddle1FK.scaleY" 0 2 "rightHandMiddle1FK.scaleX" 0 
		3 "rightHandMiddle1FK.rotateZ" 2 1 "rightHandMiddle1FK.rotateY" 2 
		2 "rightHandMiddle1FK.rotateX" 2 3 "rightHandMiddle1FK.translateZ" 
		1 1 "rightHandMiddle1FK.translateY" 1 2 "rightHandMiddle1FK.translateX" 
		1 3 "rightHandMiddle2FK.scaleZ" 0 4 "rightHandMiddle2FK.scaleY" 
		0 5 "rightHandMiddle2FK.scaleX" 0 6 "rightHandMiddle2FK.rotateZ" 
		2 4 "rightHandMiddle2FK.rotateY" 2 5 "rightHandMiddle2FK.rotateX" 
		2 6 "rightHandMiddle2FK.translateZ" 1 4 "rightHandMiddle2FK.translateY" 
		1 5 "rightHandMiddle2FK.translateX" 1 6 "rightHandMiddle3FK.scaleZ" 
		0 7 "rightHandMiddle3FK.scaleY" 0 8 "rightHandMiddle3FK.scaleX" 
		0 9 "rightHandMiddle3FK.rotateZ" 2 7 "rightHandMiddle3FK.rotateY" 
		2 8 "rightHandMiddle3FK.rotateX" 2 9 "rightHandMiddle3FK.translateZ" 
		1 7 "rightHandMiddle3FK.translateY" 1 8 "rightHandMiddle3FK.translateX" 
		1 9 "rightHandMiddle4FK.scaleZ" 0 10 "rightHandMiddle4FK.scaleY" 
		0 11 "rightHandMiddle4FK.scaleX" 0 12 "rightHandMiddle4FK.rotateZ" 
		2 10 "rightHandMiddle4FK.rotateY" 2 11 "rightHandMiddle4FK.rotateX" 
		2 12 "rightHandMiddle4FK.translateZ" 1 10 "rightHandMiddle4FK.translateY" 
		1 11 "rightHandMiddle4FK.translateX" 1 12 "RightHandMiddle1Eff.reachRotation" 
		0 13 "RightHandMiddle1Eff.reachTranslation" 0 14 "RightHandMiddle1Eff.rotateZ" 
		2 13 "RightHandMiddle1Eff.rotateY" 2 14 "RightHandMiddle1Eff.rotateX" 
		2 15 "RightHandMiddle1Eff.translateZ" 1 13 "RightHandMiddle1Eff.translateY" 
		1 14 "RightHandMiddle1Eff.translateX" 1 15  ;
	setAttr ".aal" -type "attributeAlias" {"rightHandMiddle4FK_rotateZ","angularValues[10]"
		,"rightHandMiddle4FK_rotateY","angularValues[11]","rightHandMiddle4FK_rotateX","angularValues[12]"
		,"RightHandMiddle1Eff_rotateZ","angularValues[13]","RightHandMiddle1Eff_rotateY","angularValues[14]"
		,"RightHandMiddle1Eff_rotateX","angularValues[15]","rightHandMiddle1FK_rotateZ","angularValues[1]"
		,"rightHandMiddle1FK_rotateY","angularValues[2]","rightHandMiddle1FK_rotateX","angularValues[3]"
		,"rightHandMiddle2FK_rotateZ","angularValues[4]","rightHandMiddle2FK_rotateY","angularValues[5]"
		,"rightHandMiddle2FK_rotateX","angularValues[6]","rightHandMiddle3FK_rotateZ","angularValues[7]"
		,"rightHandMiddle3FK_rotateY","angularValues[8]","rightHandMiddle3FK_rotateX","angularValues[9]"
		,"rightHandMiddle4FK_translateZ","linearValues[10]","rightHandMiddle4FK_translateY"
		,"linearValues[11]","rightHandMiddle4FK_translateX","linearValues[12]","RightHandMiddle1Eff_translateZ"
		,"linearValues[13]","RightHandMiddle1Eff_translateY","linearValues[14]","RightHandMiddle1Eff_translateX"
		,"linearValues[15]","rightHandMiddle1FK_translateZ","linearValues[1]","rightHandMiddle1FK_translateY"
		,"linearValues[2]","rightHandMiddle1FK_translateX","linearValues[3]","rightHandMiddle2FK_translateZ"
		,"linearValues[4]","rightHandMiddle2FK_translateY","linearValues[5]","rightHandMiddle2FK_translateX"
		,"linearValues[6]","rightHandMiddle3FK_translateZ","linearValues[7]","rightHandMiddle3FK_translateY"
		,"linearValues[8]","rightHandMiddle3FK_translateX","linearValues[9]","rightHandMiddle4FK_scaleZ"
		,"unitlessValues[10]","rightHandMiddle4FK_scaleY","unitlessValues[11]","rightHandMiddle4FK_scaleX"
		,"unitlessValues[12]","RightHandMiddle1Eff_reachRotation","unitlessValues[13]","RightHandMiddle1Eff_reachTranslation"
		,"unitlessValues[14]","rightHandMiddle1FK_scaleZ","unitlessValues[1]","rightHandMiddle1FK_scaleY"
		,"unitlessValues[2]","rightHandMiddle1FK_scaleX","unitlessValues[3]","rightHandMiddle2FK_scaleZ"
		,"unitlessValues[4]","rightHandMiddle2FK_scaleY","unitlessValues[5]","rightHandMiddle2FK_scaleX"
		,"unitlessValues[6]","rightHandMiddle3FK_scaleZ","unitlessValues[7]","rightHandMiddle3FK_scaleY"
		,"unitlessValues[8]","rightHandMiddle3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightFingerIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  0.22015584793356868 0.050700835440506291 
		-1.0472020592973876 0.048602666572321138 0.041358237220316021 -0.47293514635480149 
		0.0030640994085189611 -0.0064475496217141189 -0.20977259038014912 0.011314262677482357 
		-0.01115859039844945 -0.15659116240813362 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "rightHandIndex1FK.scaleZ" 0 
		1 "rightHandIndex1FK.scaleY" 0 2 "rightHandIndex1FK.scaleX" 0 
		3 "rightHandIndex1FK.rotateZ" 2 1 "rightHandIndex1FK.rotateY" 2 
		2 "rightHandIndex1FK.rotateX" 2 3 "rightHandIndex1FK.translateZ" 1 
		1 "rightHandIndex1FK.translateY" 1 2 "rightHandIndex1FK.translateX" 
		1 3 "rightHandIndex2FK.scaleZ" 0 4 "rightHandIndex2FK.scaleY" 
		0 5 "rightHandIndex2FK.scaleX" 0 6 "rightHandIndex2FK.rotateZ" 
		2 4 "rightHandIndex2FK.rotateY" 2 5 "rightHandIndex2FK.rotateX" 
		2 6 "rightHandIndex2FK.translateZ" 1 4 "rightHandIndex2FK.translateY" 
		1 5 "rightHandIndex2FK.translateX" 1 6 "rightHandIndex3FK.scaleZ" 
		0 7 "rightHandIndex3FK.scaleY" 0 8 "rightHandIndex3FK.scaleX" 
		0 9 "rightHandIndex3FK.rotateZ" 2 7 "rightHandIndex3FK.rotateY" 
		2 8 "rightHandIndex3FK.rotateX" 2 9 "rightHandIndex3FK.translateZ" 
		1 7 "rightHandIndex3FK.translateY" 1 8 "rightHandIndex3FK.translateX" 
		1 9 "rightHandIndex4FK.scaleZ" 0 10 "rightHandIndex4FK.scaleY" 
		0 11 "rightHandIndex4FK.scaleX" 0 12 "rightHandIndex4FK.rotateZ" 
		2 10 "rightHandIndex4FK.rotateY" 2 11 "rightHandIndex4FK.rotateX" 
		2 12 "rightHandIndex4FK.translateZ" 1 10 "rightHandIndex4FK.translateY" 
		1 11 "rightHandIndex4FK.translateX" 1 12 "RightHandIndex1Eff.reachRotation" 
		0 13 "RightHandIndex1Eff.reachTranslation" 0 14 "RightHandIndex1Eff.rotateZ" 
		2 13 "RightHandIndex1Eff.rotateY" 2 14 "RightHandIndex1Eff.rotateX" 
		2 15 "RightHandIndex1Eff.translateZ" 1 13 "RightHandIndex1Eff.translateY" 
		1 14 "RightHandIndex1Eff.translateX" 1 15  ;
	setAttr ".aal" -type "attributeAlias" {"rightHandIndex4FK_rotateZ","angularValues[10]"
		,"rightHandIndex4FK_rotateY","angularValues[11]","rightHandIndex4FK_rotateX","angularValues[12]"
		,"RightHandIndex1Eff_rotateZ","angularValues[13]","RightHandIndex1Eff_rotateY","angularValues[14]"
		,"RightHandIndex1Eff_rotateX","angularValues[15]","rightHandIndex1FK_rotateZ","angularValues[1]"
		,"rightHandIndex1FK_rotateY","angularValues[2]","rightHandIndex1FK_rotateX","angularValues[3]"
		,"rightHandIndex2FK_rotateZ","angularValues[4]","rightHandIndex2FK_rotateY","angularValues[5]"
		,"rightHandIndex2FK_rotateX","angularValues[6]","rightHandIndex3FK_rotateZ","angularValues[7]"
		,"rightHandIndex3FK_rotateY","angularValues[8]","rightHandIndex3FK_rotateX","angularValues[9]"
		,"rightHandIndex4FK_translateZ","linearValues[10]","rightHandIndex4FK_translateY"
		,"linearValues[11]","rightHandIndex4FK_translateX","linearValues[12]","RightHandIndex1Eff_translateZ"
		,"linearValues[13]","RightHandIndex1Eff_translateY","linearValues[14]","RightHandIndex1Eff_translateX"
		,"linearValues[15]","rightHandIndex1FK_translateZ","linearValues[1]","rightHandIndex1FK_translateY"
		,"linearValues[2]","rightHandIndex1FK_translateX","linearValues[3]","rightHandIndex2FK_translateZ"
		,"linearValues[4]","rightHandIndex2FK_translateY","linearValues[5]","rightHandIndex2FK_translateX"
		,"linearValues[6]","rightHandIndex3FK_translateZ","linearValues[7]","rightHandIndex3FK_translateY"
		,"linearValues[8]","rightHandIndex3FK_translateX","linearValues[9]","rightHandIndex4FK_scaleZ"
		,"unitlessValues[10]","rightHandIndex4FK_scaleY","unitlessValues[11]","rightHandIndex4FK_scaleX"
		,"unitlessValues[12]","RightHandIndex1Eff_reachRotation","unitlessValues[13]","RightHandIndex1Eff_reachTranslation"
		,"unitlessValues[14]","rightHandIndex1FK_scaleZ","unitlessValues[1]","rightHandIndex1FK_scaleY"
		,"unitlessValues[2]","rightHandIndex1FK_scaleX","unitlessValues[3]","rightHandIndex2FK_scaleZ"
		,"unitlessValues[4]","rightHandIndex2FK_scaleY","unitlessValues[5]","rightHandIndex2FK_scaleX"
		,"unitlessValues[6]","rightHandIndex3FK_scaleZ","unitlessValues[7]","rightHandIndex3FK_scaleY"
		,"unitlessValues[8]","rightHandIndex3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_rightThumb";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 44 ".dnsm";
	setAttr -s 14 ".uv[1:14]"  1 1 1 1 1 1 1 1 1 1 1 1 0 0;
	setAttr -s 14 ".uv";
	setAttr -s 15 ".lv[1:15]"  0.28923634098679896 -0.086241354394293285 
		-0.3578672845695417 0.072312826964874372 -0.040651412270652484 -0.4293017021890459 
		0.0063665523723080934 0.034181964356917421 -0.32971710253493719 -0.022888650704250869 
		0.025731253168027962 -0.30467744271336966 0 0 0;
	setAttr -s 15 ".lv";
	setAttr -s 15 ".av";
	setAttr -s 15 ".av";
	setAttr ".am" -type "characterMapping" 44 "rightHandThumb1FK.scaleZ" 0 
		1 "rightHandThumb1FK.scaleY" 0 2 "rightHandThumb1FK.scaleX" 0 
		3 "rightHandThumb1FK.rotateZ" 2 1 "rightHandThumb1FK.rotateY" 2 
		2 "rightHandThumb1FK.rotateX" 2 3 "rightHandThumb1FK.translateZ" 1 
		1 "rightHandThumb1FK.translateY" 1 2 "rightHandThumb1FK.translateX" 
		1 3 "rightHandThumb2FK.scaleZ" 0 4 "rightHandThumb2FK.scaleY" 
		0 5 "rightHandThumb2FK.scaleX" 0 6 "rightHandThumb2FK.rotateZ" 
		2 4 "rightHandThumb2FK.rotateY" 2 5 "rightHandThumb2FK.rotateX" 
		2 6 "rightHandThumb2FK.translateZ" 1 4 "rightHandThumb2FK.translateY" 
		1 5 "rightHandThumb2FK.translateX" 1 6 "rightHandThumb3FK.scaleZ" 
		0 7 "rightHandThumb3FK.scaleY" 0 8 "rightHandThumb3FK.scaleX" 
		0 9 "rightHandThumb3FK.rotateZ" 2 7 "rightHandThumb3FK.rotateY" 
		2 8 "rightHandThumb3FK.rotateX" 2 9 "rightHandThumb3FK.translateZ" 
		1 7 "rightHandThumb3FK.translateY" 1 8 "rightHandThumb3FK.translateX" 
		1 9 "rightHandThumb4FK.scaleZ" 0 10 "rightHandThumb4FK.scaleY" 
		0 11 "rightHandThumb4FK.scaleX" 0 12 "rightHandThumb4FK.rotateZ" 
		2 10 "rightHandThumb4FK.rotateY" 2 11 "rightHandThumb4FK.rotateX" 
		2 12 "rightHandThumb4FK.translateZ" 1 10 "rightHandThumb4FK.translateY" 
		1 11 "rightHandThumb4FK.translateX" 1 12 "RightHandThumb1Eff.reachRotation" 
		0 13 "RightHandThumb1Eff.reachTranslation" 0 14 "RightHandThumb1Eff.rotateZ" 
		2 13 "RightHandThumb1Eff.rotateY" 2 14 "RightHandThumb1Eff.rotateX" 
		2 15 "RightHandThumb1Eff.translateZ" 1 13 "RightHandThumb1Eff.translateY" 
		1 14 "RightHandThumb1Eff.translateX" 1 15  ;
	setAttr ".aal" -type "attributeAlias" {"rightHandThumb4FK_rotateZ","angularValues[10]"
		,"rightHandThumb4FK_rotateY","angularValues[11]","rightHandThumb4FK_rotateX","angularValues[12]"
		,"RightHandThumb1Eff_rotateZ","angularValues[13]","RightHandThumb1Eff_rotateY","angularValues[14]"
		,"RightHandThumb1Eff_rotateX","angularValues[15]","rightHandThumb1FK_rotateZ","angularValues[1]"
		,"rightHandThumb1FK_rotateY","angularValues[2]","rightHandThumb1FK_rotateX","angularValues[3]"
		,"rightHandThumb2FK_rotateZ","angularValues[4]","rightHandThumb2FK_rotateY","angularValues[5]"
		,"rightHandThumb2FK_rotateX","angularValues[6]","rightHandThumb3FK_rotateZ","angularValues[7]"
		,"rightHandThumb3FK_rotateY","angularValues[8]","rightHandThumb3FK_rotateX","angularValues[9]"
		,"rightHandThumb4FK_translateZ","linearValues[10]","rightHandThumb4FK_translateY"
		,"linearValues[11]","rightHandThumb4FK_translateX","linearValues[12]","RightHandThumb1Eff_translateZ"
		,"linearValues[13]","RightHandThumb1Eff_translateY","linearValues[14]","RightHandThumb1Eff_translateX"
		,"linearValues[15]","rightHandThumb1FK_translateZ","linearValues[1]","rightHandThumb1FK_translateY"
		,"linearValues[2]","rightHandThumb1FK_translateX","linearValues[3]","rightHandThumb2FK_translateZ"
		,"linearValues[4]","rightHandThumb2FK_translateY","linearValues[5]","rightHandThumb2FK_translateX"
		,"linearValues[6]","rightHandThumb3FK_translateZ","linearValues[7]","rightHandThumb3FK_translateY"
		,"linearValues[8]","rightHandThumb3FK_translateX","linearValues[9]","rightHandThumb4FK_scaleZ"
		,"unitlessValues[10]","rightHandThumb4FK_scaleY","unitlessValues[11]","rightHandThumb4FK_scaleX"
		,"unitlessValues[12]","RightHandThumb1Eff_reachRotation","unitlessValues[13]","RightHandThumb1Eff_reachTranslation"
		,"unitlessValues[14]","rightHandThumb1FK_scaleZ","unitlessValues[1]","rightHandThumb1FK_scaleY"
		,"unitlessValues[2]","rightHandThumb1FK_scaleX","unitlessValues[3]","rightHandThumb2FK_scaleZ"
		,"unitlessValues[4]","rightHandThumb2FK_scaleY","unitlessValues[5]","rightHandThumb2FK_scaleX"
		,"unitlessValues[6]","rightHandThumb3FK_scaleZ","unitlessValues[7]","rightHandThumb3FK_scaleY"
		,"unitlessValues[8]","rightHandThumb3FK_scaleX","unitlessValues[9]"} ;
createNode character -n "_leftFootIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 26 ".dnsm";
	setAttr -s 8 ".uv[1:8]"  1 1 1 1 1 1 0 0;
	setAttr -s 8 ".uv";
	setAttr -s 9 ".lv[1:9]"  0.048721191661977768 -5.672664321760693e-007 
		-9.4529730188703075e-009 0.81127245355174094 -0.044072378527966458 0.0017397724759110847 
		0 0 0;
	setAttr -s 9 ".lv";
	setAttr -s 9 ".av";
	setAttr -s 9 ".av";
	setAttr ".am" -type "characterMapping" 26 "leftFootIndex1FK.scaleZ" 0 1 "leftFootIndex1FK.scaleY" 
		0 2 "leftFootIndex1FK.scaleX" 0 3 "leftFootIndex1FK.rotateZ" 
		2 1 "leftFootIndex1FK.rotateY" 2 2 "leftFootIndex1FK.rotateX" 
		2 3 "leftFootIndex1FK.translateZ" 1 1 "leftFootIndex1FK.translateY" 
		1 2 "leftFootIndex1FK.translateX" 1 3 "leftFootIndex2FK.scaleZ" 
		0 4 "leftFootIndex2FK.scaleY" 0 5 "leftFootIndex2FK.scaleX" 0 
		6 "leftFootIndex2FK.rotateZ" 2 4 "leftFootIndex2FK.rotateY" 2 
		5 "leftFootIndex2FK.rotateX" 2 6 "leftFootIndex2FK.translateZ" 1 
		4 "leftFootIndex2FK.translateY" 1 5 "leftFootIndex2FK.translateX" 
		1 6 "LeftFootIndex1Eff.reachRotation" 0 7 "LeftFootIndex1Eff.reachTranslation" 
		0 8 "LeftFootIndex1Eff.rotateZ" 2 7 "LeftFootIndex1Eff.rotateY" 
		2 8 "LeftFootIndex1Eff.rotateX" 2 9 "LeftFootIndex1Eff.translateZ" 
		1 7 "LeftFootIndex1Eff.translateY" 1 8 "LeftFootIndex1Eff.translateX" 
		1 9  ;
	setAttr ".aal" -type "attributeAlias" {"leftFootIndex1FK_rotateZ","angularValues[1]"
		,"leftFootIndex1FK_rotateY","angularValues[2]","leftFootIndex1FK_rotateX","angularValues[3]"
		,"leftFootIndex2FK_rotateZ","angularValues[4]","leftFootIndex2FK_rotateY","angularValues[5]"
		,"leftFootIndex2FK_rotateX","angularValues[6]","LeftFootIndex1Eff_rotateZ","angularValues[7]"
		,"LeftFootIndex1Eff_rotateY","angularValues[8]","LeftFootIndex1Eff_rotateX","angularValues[9]"
		,"leftFootIndex1FK_translateZ","linearValues[1]","leftFootIndex1FK_translateY","linearValues[2]"
		,"leftFootIndex1FK_translateX","linearValues[3]","leftFootIndex2FK_translateZ","linearValues[4]"
		,"leftFootIndex2FK_translateY","linearValues[5]","leftFootIndex2FK_translateX","linearValues[6]"
		,"LeftFootIndex1Eff_translateZ","linearValues[7]","LeftFootIndex1Eff_translateY","linearValues[8]"
		,"LeftFootIndex1Eff_translateX","linearValues[9]","leftFootIndex1FK_scaleZ","unitlessValues[1]"
		,"leftFootIndex1FK_scaleY","unitlessValues[2]","leftFootIndex1FK_scaleX","unitlessValues[3]"
		,"leftFootIndex2FK_scaleZ","unitlessValues[4]","leftFootIndex2FK_scaleY","unitlessValues[5]"
		,"leftFootIndex2FK_scaleX","unitlessValues[6]","LeftFootIndex1Eff_reachRotation","unitlessValues[7]"
		,"LeftFootIndex1Eff_reachTranslation","unitlessValues[8]"} ;
createNode character -n "_rightFootIndex";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -bt "ATAL" -dt "attributeAlias";
	setAttr -s 26 ".dnsm";
	setAttr -s 8 ".uv[1:8]"  1 1 1 1 1 1 0 0;
	setAttr -s 8 ".uv";
	setAttr -s 9 ".lv[1:9]"  0.074146198622944734 0.0081594030762894582 
		-0.0069916274261346851 0.80709916743979848 -0.040491474302352504 -0.00023243273273125357 
		0 0 0;
	setAttr -s 9 ".lv";
	setAttr -s 9 ".av";
	setAttr -s 9 ".av";
	setAttr ".am" -type "characterMapping" 26 "rightFootIndex1FK.scaleZ" 0 
		1 "rightFootIndex1FK.scaleY" 0 2 "rightFootIndex1FK.scaleX" 0 
		3 "rightFootIndex1FK.rotateZ" 2 1 "rightFootIndex1FK.rotateY" 2 
		2 "rightFootIndex1FK.rotateX" 2 3 "rightFootIndex1FK.translateZ" 1 
		1 "rightFootIndex1FK.translateY" 1 2 "rightFootIndex1FK.translateX" 
		1 3 "rightFootIndex2FK.scaleZ" 0 4 "rightFootIndex2FK.scaleY" 
		0 5 "rightFootIndex2FK.scaleX" 0 6 "rightFootIndex2FK.rotateZ" 
		2 4 "rightFootIndex2FK.rotateY" 2 5 "rightFootIndex2FK.rotateX" 
		2 6 "rightFootIndex2FK.translateZ" 1 4 "rightFootIndex2FK.translateY" 
		1 5 "rightFootIndex2FK.translateX" 1 6 "RightFootIndex1Eff.reachRotation" 
		0 7 "RightFootIndex1Eff.reachTranslation" 0 8 "RightFootIndex1Eff.rotateZ" 
		2 7 "RightFootIndex1Eff.rotateY" 2 8 "RightFootIndex1Eff.rotateX" 
		2 9 "RightFootIndex1Eff.translateZ" 1 7 "RightFootIndex1Eff.translateY" 
		1 8 "RightFootIndex1Eff.translateX" 1 9  ;
	setAttr ".aal" -type "attributeAlias" {"rightFootIndex1FK_rotateZ","angularValues[1]"
		,"rightFootIndex1FK_rotateY","angularValues[2]","rightFootIndex1FK_rotateX","angularValues[3]"
		,"rightFootIndex2FK_rotateZ","angularValues[4]","rightFootIndex2FK_rotateY","angularValues[5]"
		,"rightFootIndex2FK_rotateX","angularValues[6]","RightFootIndex1Eff_rotateZ","angularValues[7]"
		,"RightFootIndex1Eff_rotateY","angularValues[8]","RightFootIndex1Eff_rotateX","angularValues[9]"
		,"rightFootIndex1FK_translateZ","linearValues[1]","rightFootIndex1FK_translateY","linearValues[2]"
		,"rightFootIndex1FK_translateX","linearValues[3]","rightFootIndex2FK_translateZ","linearValues[4]"
		,"rightFootIndex2FK_translateY","linearValues[5]","rightFootIndex2FK_translateX","linearValues[6]"
		,"RightFootIndex1Eff_translateZ","linearValues[7]","RightFootIndex1Eff_translateY"
		,"linearValues[8]","RightFootIndex1Eff_translateX","linearValues[9]","rightFootIndex1FK_scaleZ"
		,"unitlessValues[1]","rightFootIndex1FK_scaleY","unitlessValues[2]","rightFootIndex1FK_scaleX"
		,"unitlessValues[3]","rightFootIndex2FK_scaleZ","unitlessValues[4]","rightFootIndex2FK_scaleY"
		,"unitlessValues[5]","rightFootIndex2FK_scaleX","unitlessValues[6]","RightFootIndex1Eff_reachRotation"
		,"unitlessValues[7]","RightFootIndex1Eff_reachTranslation","unitlessValues[8]"} ;
createNode dagPose -n "hikStancePose";
	addAttr -ci true -sn "hikPose" -ln "hikPose" -bt "HIKP" -min 0 -max 1 -at "bool";
	setAttr -s 159 ".wm";
	setAttr ".wm[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[1]" -type "matrix" 0.99999999999833422 1.8225802023122571e-006 9.8935068137797173e-008 0
		 -1.8225802456484829e-006 0.99999999999824318 4.380286213737726e-007 0 -9.8934269795329991e-008 -4.3802880169014376e-007 0.99999999999989919 0
		 -5.7220458984375e-006 10.402189254760742 -0.2471792995929718 1;
	setAttr ".wm[2]" -type "matrix" 1.8163169687450813e-006 0.99832396534067003 -0.057872793462748116 0
		 -7.6418895881866443e-008 -0.057872793462704797 -0.99832396534232182 0 -0.99999999999834754 1.8176953335802088e-006 -2.8824521726050482e-008 0
		 -8.4040566434850849e-006 11.096714973449707 -0.015667378902435247 1;
	setAttr ".wm[3]" -type "matrix" 1.804599352810893e-006 0.99062948476071866 -0.13657680593518348 0
		 -4.8797951888096334e-007 -0.13657680593451721 -0.99062948476233392 0 -0.99999999999825262 1.8543360111740962e-006 2.3694048366962243e-007 0
		 -6.5876103241994339e-006 12.095110035393278 -0.073544293831920265 1;
	setAttr ".wm[4]" -type "matrix" 1.7415039958358785e-006 0.97014261798995294 -0.24253515365111028 0
		 -6.7960773060675099e-007 -0.24253515365027384 -0.97014261799148693 0 -0.99999999999825262 1.8543360111740962e-006 2.3694048366962243e-007 0
		 -4.7862643925160928e-006 13.083953564356822 -0.20987487235102897 1;
	setAttr ".wm[5]" -type "matrix" 1.8591912370460155e-006 0.99974759129905166 0.022466724022157769 0
		 -1.9521982251835162e-007 0.022466724022559087 -0.99974759130075219 0 -0.99999999999825262 1.8543360111740962e-006 2.3694048366962243e-007 0
		 -3.1215130809176112e-006 14.011339432892354 -0.44172086071215677 1;
	setAttr ".wm[6]" -type "matrix" 3.5855822391878322e-007 0.94868254404900176 0.31623002801218181 0
		 2.213078235232778e-007 0.31623002801211919 -0.94868254404906449 0 -0.99999999999991118 4.1014210733511743e-007 -9.6563991938999004e-008 0
		 3.9175115799535558e-007 15.04306615057321 -0.41853559296120363 1;
	setAttr ".wm[7]" -type "matrix" 1.6430966447362335e-006 0.99987405065201029 -0.015870816930499021 0
		 4.8454071659125968e-007 -0.015870816931314646 -0.99987405065322987 0 -0.99999999999853262 1.6351996408248076e-006 -5.1055697514779753e-007 0
		 -1.2704189138102648e-006 15.773371707252091 -0.17509541522394828 1;
	setAttr ".wm[8]" -type "matrix" 0.99999999999853262 -1.635199640602791e-006 5.1055697514427345e-007 0
		 1.6351995385877499e-006 0.99999999999864331 1.9972137796711587e-007 0 -5.1055730163662937e-007 -1.9972054303429854e-007 0.99999999999984979 0
		 2.3299752658036192e-006 17.964320562472256 -0.20987194349029414 1;
	setAttr ".wm[9]" -type "matrix" 0.99999999999853262 -1.635199640602791e-006 5.1055697514427345e-007 0
		 1.6351995385877496e-006 0.9999999999986432 1.9972137796711587e-007 0 -5.1055730163662927e-007 -1.9972054303082909e-007 0.99999999999984945 0
		 -1.2704189138102646e-006 15.773371707252091 -0.17509541522394828 1;
	setAttr ".wm[10]" -type "matrix" 0.9999999999999114 -4.1014210728245464e-007 9.656399178101165e-008 0
		 4.1014187687868712e-007 0.99999999999707367 2.3843533986100951e-006 0 -9.6564969545598444e-008 -2.3843533589751331e-006 0.99999999999715317 0
		 3.9175115799535568e-007 15.04306615057321 -0.41853559296120252 1;
	setAttr ".wm[11]" -type "matrix" 0.99609716363394363 -0.088263472628331285 -2.8286697363773261e-009 0
		 -3.3685691852917403e-008 -4.1220780082340536e-007 0.99999999999991429 0 -0.088263472628324888 -0.99609716363385847 -4.1357223732121917e-007 0
		 0.83456842326307101 14.547159238055494 -5.9058585860638502e-007 1;
	setAttr ".wm[12]" -type "matrix" 0.99997037879282824 0.00260488122867987 0.0072426604719386745 0
		 -0.0071753275937823302 -0.024990379698661105 0.9996619406561591 0 0.0027849974594631594 -0.99968429792425029 -0.024970948577288023 0
		 2.188517795705208 14.427185122126355 -4.6315163755041352e-007 1;
	setAttr ".wm[13]" -type "matrix" 0.9993292387607513 -0.027183435963703855 0.024538405960129139 0
		 0.025176634494754865 0.023390530424574348 -0.99940933563879319 0 0.026593413345683988 0.99935676507224602 0.024059228394969778 0
		 4.7420978543169561 14.433837886986753 0.018495919427816143 1;
	setAttr ".wm[14]" -type "matrix" 0.99988783708116979 -0.014946485222658606 0.000956993536243924 0
		 0.0013143163231408017 0.02391531537423441 -0.99971312398265189 0 0.014919310632274198 0.99960225103289946 0.023932277372158969 0
		 6.0508526786315002 14.39823755470481 0.050632232402239623 1;
	setAttr ".wm[15]" -type "matrix" 0.9998879362858355 -0.014947102667797559 0.00083605734903630026 0
		 0.0011934722914031628 0.023919083103863564 -0.99971318541237586 0 0.014922817895498524 0.99960215165099997 0.02393424159544227 0
		 7.2811869155254758 14.379836620253156 0.051809284334840111 1;
	setAttr ".wm[16]" -type "matrix" 0.98483034672686565 0.035482389972036628 -0.16985343142755041 0
		 -0.031962222885229527 0.99921476285125688 0.02341525161815091 0 0.17055088529256068 -0.017631157136692006 0.98519111741019294 0
		 7.8009452327446862 14.385944557841475 -0.19237720449894893 1;
	setAttr ".wm[17]" -type "matrix" 0.99000577425722536 -0.11563870075634679 -0.080723341263449391 0
		 0.11693554555781452 0.9930727928037153 0.01151114147795539 0 0.078833020508207896 -0.020835524481358843 0.99667007369396743 0
		 8.2885265349483763 14.403511043090873 -0.27647246075689619 1;
	setAttr ".wm[18]" -type "matrix" 0.90114136474297357 -0.42809020609062376 0.068432566797235153 0
		 0.4244911967388994 0.90335754806491331 0.06125654451015819 0 -0.088042402513491796 -0.026151783943649684 0.99577337760969298 0
		 8.6375354292991471 14.362737906055244 -0.3049294286757035 1;
	setAttr ".wm[19]" -type "matrix" 0.927816919476109 -0.37303389427699052 0.0012155880907120248 0
		 0.3728775576238752 0.92751315575353011 0.026108866780877864 0 -0.010866966196542691 -0.023770982829304895 0.99965836635373151 0
		 8.8400259030701793 14.266547201460542 -0.28954953370018299 1;
	setAttr ".wm[20]" -type "matrix" 0.92781699716961774 -0.37303370060915031 0.0012157191272025338 0
		 0.25172604190617603 0.62368635126597871 -0.74003333375651381 0 0.27529914563870972 0.68692153369535103 0.67256909455923042 0
		 8.9615944990773304 14.217661468458413 -0.28939645984923984 1;
	setAttr ".wm[21]" -type "matrix" 0.98998497805140262 0.034872658976563914 -0.13679781024734194 0
		 -0.031962222885228014 0.99921476285125677 0.023415251618150581 0 0.13750694360939938 -0.018808385257926257 0.99032221276874821 0
		 7.829111913249915 14.39908195216538 -0.021532607907743459 1;
	setAttr ".wm[22]" -type "matrix" 0.99559855577111978 0.023726883540848211 -0.090667252874999688 0
		 -0.021772024518877078 0.99950998071881769 0.022489495143682845 0 0.091156429805085898 -0.020416499232418592 0.99562727557268227 0
		 8.3433872194461571 14.417198185924581 -0.092596090622621197 1;
	setAttr ".wm[23]" -type "matrix" 0.97453782368147635 -0.2231681434550484 -0.021725790227246092 0
		 0.22357435673925521 0.97451143867577927 0.018492238877185201 0 0.017045152472173183 -0.022878715805078654 0.99959293071745436 0
		 8.770886420713639 14.42738628104674 -0.13152742298196479 1;
	setAttr ".wm[24]" -type "matrix" 0.98395850658549422 -0.17461132840313645 0.036558737824708552 0
		 0.17350311760383758 0.98432668907644028 0.031585397790142342 0 -0.041500909626087171 -0.024735665851249013 0.99883222882278955 0
		 8.984796336842745 14.378401133739867 -0.13629620860774244 1;
	setAttr ".wm[25]" -type "matrix" 0.99623267994048503 0.029952346290317788 0.081383686143499612 0
		 -0.057987619064436002 0.92788049237695724 0.36834118409639316 0 -0.064481652071241305 -0.37167277115495045 0.92612173483196147 0
		 9.140561521881553 14.350766765770617 -0.13050835725134202 1;
	setAttr ".wm[26]" -type "matrix" 0.9994588323377076 0.032134735789496389 -0.007028599994651186 0
		 -0.031962222885231789 0.99921476285125688 0.023415251618151688 0 0.0077755238010257096 -0.023177930361571359 0.99970111772157833 0
		 8.2242047199004737 14.409499264158743 0.073230944058723393 1;
	setAttr ".wm[27]" -type "matrix" 0.99549346410140171 0.094720912688143089 -0.0045510032867325237 0
		 -0.094587581104945584 0.99523322979386997 0.02374884870425276 0 0.0067788223244168704 -0.023211355272524013 0.9997075975275499 0
		 8.3379278929870502 14.413155414889728 0.072431353992106567 1;
	setAttr ".wm[28]" -type "matrix" 0.99798036056275996 0.017821244973071956 0.060972150680723439 0
		 -0.019326509753179635 0.99952060587981273 0.024187691961252988 0 -0.060511866206417145 -0.025317220409475608 0.99784635711062919 0
		 8.8415098706979212 14.461070687982669 0.070129208064334161 1;
	setAttr ".wm[29]" -type "matrix" 0.99610327322506431 -0.08562711319719464 -0.021125022031404699 0
		 0.086070620476365226 0.9960663807138278 0.021062134328445323 0 0.019238434477004962 -0.022798304699490301 0.99955496094096885 0
		 9.0553569786390256 14.4648885724966 0.083194631691951584 1;
	setAttr ".wm[30]" -type "matrix" 0.9994492894492184 0.032161120358693993 -0.0081719126724269248 0
		 -0.01454986034662744 0.20340244371214083 -0.97898710280361789 0 -0.029823135035502477 0.97856686446517438 0.20375836765014377 0
		 9.2346702397704234 14.449474430889634 0.079391816568516071 1;
	setAttr ".wm[31]" -type "matrix" 0.99847939187186985 0.0308684093667939 0.045673245016581217 0
		 -0.031962222885229589 0.99921476285125677 0.023415251618151132 0 -0.044914589115514894 -0.024839464633330109 0.99868197174141138 0
		 7.8463908087979242 14.393397112494666 0.2446463653434735 1;
	setAttr ".wm[32]" -type "matrix" 0.99311186627251746 0.065769120034912421 0.0969703249378394 0
		 -0.068003204318038649 0.99748635515919681 0.019913198479885343 0 -0.095416902439745738 -0.026370326525348566 0.99508804666107298 0
		 8.3303055389677461 14.408359026647231 0.26678247213995587 1;
	setAttr ".wm[33]" -type "matrix" 0.99862808843641715 -0.051470153422574175 0.0096314221423182134 0
		 0.051223569630767338 0.99839147518413118 0.02430243185230542 0 -0.010866779656769923 -0.023775735242273791 0.99965825536209107 0
		 8.8042379572501268 14.439745337862545 0.31305860895816967 1;
	setAttr ".wm[34]" -type "matrix" 0.99352016632945761 -0.091867185849642902 0.066918601754321599 0
		 0.089901471494023277 0.99544212803682697 0.03182287153482944 0 -0.069537072989130269 -0.025600583852328759 0.99725082380839547 0
		 9.0138365760349419 14.42894244418177 0.31508011506373523 1;
	setAttr ".wm[35]" -type "matrix" 0.9970672036283097 0.030245537540009512 0.070300774588463885 0
		 -0.069537152131826235 -0.025600201341742571 0.997250828109286 0 0.031962101342330115 -0.99921461015648583 -0.023421932618904413 0
		 9.1702134078430007 14.414482848939366 0.32561288458971976 1;
	setAttr ".wm[36]" -type "matrix" 0.97266072244438195 -0.13439533143394658 0.18939116637988229 0
		 0.11681177838506396 0.98798666483718345 0.10117983264671887 0 -0.20071404396427092 -0.076290530163703685 0.97667478085739945 0
		 7.638580178255908 14.285955948634461 0.33923799989089815 1;
	setAttr ".wm[37]" -type "matrix" 0.99725304476795318 0.060267568633911334 0.043060247003507801 0
		 -0.062018300125998488 0.99725097892389303 0.040548927048923197 0 -0.040498088233000246 -0.043108064283775456 0.99824926728907626 0
		 8.0638644677532323 14.227202158681697 0.4220530276404087 1;
	setAttr ".wm[38]" -type "matrix" 0.99786765295036861 0.041043740170389219 -0.050749961459572501 0
		 -0.039780431142846656 0.99887897338404918 0.025657627117827098 0 0.051746154382830763 -0.023584060804997208 0.9983817544319078 0
		 8.3945010489257594 14.24717386310774 0.43632863142063061 1;
	setAttr ".wm[39]" -type "matrix" 0.97709278391114085 0.20838380953073374 -0.043195827972560968 0
		 -0.20188886376120679 0.84344055898297055 -0.4978442629494722 0 -0.067309570775522146 0.49516079346809488 0.86619005437263097 0
		 8.7004580621102914 14.259758563480689 0.42075813852034954 1;
	setAttr ".wm[40]" -type "matrix" -0.99609494195385528 -0.088288541804388693 -1.8623607954838112e-008 0
		 2.6027177584992478e-008 -5.0458583752618913e-007 0.99999999999987244 0 -0.08828854180438675 0.99609494195372783 5.0491330203655815e-007 0
		 -0.83456941224081393 14.54718586415855 -2.8098199322812434e-008 1;
	setAttr ".wm[41]" -type "matrix" -0.9999705459863687 0.002644604993140745 0.0072050832162938059 0
		 -0.0071374643178286267 0.024744490777040797 -0.9996683283866189 0 -0.0028220139679293182 -0.99969031016641152 -0.024724886178698804 0
		 -2.1885238518496894 14.427175881906878 -2.0709456830813191e-006 1;
	setAttr ".wm[42]" -type "matrix" -0.99973531424253037 0.013081779036893948 0.018925340515264528 0
		 -0.018611446633265 0.023713829999916839 -0.99954553088938991 0 -0.013524626080079375 -0.9996331933884377 -0.023464082454447439 0
		 -4.7420717616028876 14.433929096585022 0.01839825494871836 1;
	setAttr ".wm[43]" -type "matrix" -0.99983678905832196 0.0058540865176686064 0.017091662194999496 0
		 -0.016948551044502921 0.023680671838551059 -0.99957589626739551 0 -0.0062563458213406318 -0.99970243345323473 -0.023577588609637028 0
		 -5.9960446322307908 14.450328595051749 0.042136944964937105 1;
	setAttr ".wm[44]" -type "matrix" -0.99983719918698721 0.0058508302253672531 0.017068769949660698 0
		 -0.016925745533960961 0.023680035091354794 -0.99957629777630885 0 -0.0062525402869645589 -0.99970246759910864 -0.023577150298832728 0
		 -7.226247837266536 14.457507440719439 0.063166475399890815 1;
	setAttr ".wm[45]" -type "matrix" -0.98469457387084303 0.056180726501321547 -0.1649858241155959 0
		 0.053134033320153727 0.99832648121310075 0.022825674399719345 0 0.16599208021002501 0.01370995545043519 -0.98603177759598415 0
		 -7.7469682136973965 14.474518788616342 -0.17844326450401193 1;
	setAttr ".wm[46]" -type "matrix" -0.99260045165479271 -0.094890868546591595 -0.07576322617982037 0
		 -0.096039239609574278 0.99530934167828444 0.011652417052072317 0 0.074302138797721601 0.018842437061435159 -0.99705774894720656 0
		 -8.2344789514224903 14.502323152912336 -0.26012955227452622 1;
	setAttr ".wm[47]" -type "matrix" -0.90965734170496237 -0.4088770370869087 0.073096437842700424 0
		 -0.40494668308440124 0.91216970969734223 0.062965105968371488 0 -0.092421342455096825 0.027676510865673423 -0.99533527326479332 0
		 -8.584414812536961 14.468851138431999 -0.2868417039271971 1;
	setAttr ".wm[48]" -type "matrix" -0.93526936803077887 -0.35388652115120534 0.0059614906529162626 0
		 -0.35360465887093323 0.93498877378992351 0.027563347249317902 0 -0.015328223904874066 0.023671143493995773 -0.99960228216906821 0
		 -8.7888026327923345 14.376981944911247 -0.27041791343582372 1;
	setAttr ".wm[49]" -type "matrix" 0.89271103414080089 -0.44997149941454906 -0.024344593606878257 0
		 0.28249081911295248 0.60089632156430783 -0.74774497514017291 0 0.35109250439186929 0.66064306584199217 0.66353959408217622 0
		 -8.911395214811682 14.330613593813935 -0.26963954476707647 1;
	setAttr ".wm[50]" -type "matrix" -0.98969655496386999 0.055690620314220576 -0.13190634519106564 0
		 0.053134033320144908 0.9983264812131013 0.022825674399715504 0 0.13295677341068762 0.01558177517760494 -0.99099934646120424 0
		 -7.7740123170813664 14.488276127470488 -0.0074670850993669297 1;
	setAttr ".wm[51]" -type "matrix" -0.99531554913250952 0.044675013644172014 -0.085738560816845028 0
		 0.042942318765063547 0.9988364229949962 0.021948971676174538 0 0.086619368008144917 0.018164340187710938 -0.9960758715235577 0
		 -8.2881269456704683 14.517198564656221 -0.075993325263920955 1;
	setAttr ".wm[52]" -type "matrix" -0.97911522825794473 -0.20261093420972431 -0.016798188356350913 0
		 -0.20291779731469523 0.97900790122425896 0.019180637982724829 0 0.012559352146702396 0.022188706116736848 -0.99967490915523161 0
		 -8.7155206489296351 14.536381459346908 -0.11280043557291203 1;
	setAttr ".wm[53]" -type "matrix" -0.98718914493383148 -0.15406133155870122 0.041505400168777976 0
		 -0.15280029803728357 0.98773789320134309 0.032030036745059942 0 -0.045931046630005551 0.025277667070609067 -0.99862474358636855 0
		 -8.9304275121224634 14.491899724122206 -0.11648786851200205 1;
	setAttr ".wm[54]" -type "matrix" 0.99710463151909368 -0.054264966868713072 0.053269758530613449 0
		 0.030881454580930445 0.92913360967111225 0.36845226440136764 0 -0.069488772950299871 -0.36574041169970123 0.928119206612812 0
		 -9.08670838549466 14.467495135766692 -0.10991630619429703 1;
	setAttr ".wm[55]" -type "matrix" -0.99858194329444616 0.053195353873278985 -0.0020873074962761591 0
		 0.053134033320156912 0.99832648121310041 0.022825674399723724 0 0.0032980341750565544 0.022682399233026031 -0.99973728135726436 0
		 -8.190146268019193 14.508213802372373 0.089203284755481574 1;
	setAttr ".wm[56]" -type "matrix" -0.99329276000194489 0.1156260155459541 0.00034271954324362501 0
		 0.11560361257181456 0.99303257894240005 0.022849549653165213 0 0.0023016707115336541 0.022735911857092055 -0.99973885621394265 0
		 -8.2819242472841097 14.513112069876806 0.089010317143884382 1;
	setAttr ".wm[57]" -type "matrix" -0.99706435332079424 0.038966919352568644 0.065910959127876881 0
		 0.04060228080734779 0.99889530529443571 0.023656370262109132 0 -0.064916331768111596 0.026263058788098956 -0.9975450474103239 0
		 -8.7843789946594004 14.571582196407794 0.089179935859107204 1;
	setAttr ".wm[58]" -type "matrix" -0.99778600735403722 -0.064516206884351543 -0.016147525437186686 0
		 -0.06484982778022394 0.99767260826199367 0.021068140890603212 0 0.014750707283528022 0.022068660425285821 -0.99964763334970652 0
		 -8.9980412472618596 14.579921749968017 0.10330369533491751 1;
	setAttr ".wm[59]" -type "matrix" 0.99797203759452513 -0.052259225352613126 -0.036342613348186531 0
		 -0.024909101731516711 0.20479152338305329 -0.97848861444647262 0 0.058577716158620813 0.97740953817526954 0.20307448351195378 0
		 -9.1776648626530815 14.568289205250936 0.10039186766419496 1;
	setAttr ".wm[60]" -type "matrix" -0.99736780414709703 0.051925912943178283 0.050607932340840309 0
		 0.053134033320149189 0.99832648121310108 0.022825674399717204 0 -0.049337995033552795 0.025454596317484771 -0.99845772357791041 0
		 -7.7900836075960926 14.483043655216525 0.25879659642966346 1;
	setAttr ".wm[61]" -type "matrix" -0.99101022773703618 0.08672980260411739 0.10186594063198018 0
		 0.089120196744990332 0.99583685077710238 0.019145682711205807 0 -0.0997813562381345 0.028051880054548835 -0.99461388134928208 0
		 -8.2734498965639229 14.508208276146494 0.28332232333655605 1;
	setAttr ".wm[62]" -type "matrix" -0.99942324367200075 -0.030660053046790411 0.014599354619439925 0
		 -0.030302279046685837 0.99924954275910427 0.024127229022386315 0 -0.015328140549751859 0.023670919772790927 -0.99960228874507751 0
		 -8.7463850429187247 14.549566513363844 0.33192498991140346 1;
	setAttr ".wm[63]" -type "matrix" -0.99489049245647654 -0.070891095791767694 0.071884355440885006 0
		 -0.06875033117793268 0.99712589499577897 0.031833025175001105 0 -0.073934430292209946 0.02672830084966335 -0.996904859026706 0
		 -8.9561576332988722 14.543118963741939 0.3349890893195282 1;
	setAttr ".wm[64]" -type "matrix" 0.99764729011520503 -0.054053850056496752 0.042167117756099159 0
		 -0.043330424683414318 -0.02053256827776025 0.9988497824681517 0 -0.053125877146094388 -0.99832689783156192 -0.022826437380134512 0
		 -9.1127487957070095 14.531960373342798 0.34630335199632906 1;
	setAttr ".wm[65]" -type "matrix" -0.9818394713102967 -0.092928581160956203 0.165395076651418 0
		 -0.076687416192391528 0.99182187747731754 0.10202158377081115 0 -0.17352317647752932 0.087485096792432715 -0.9809363205959738 0
		 -7.5841151218360769 14.371266086307473 0.35240281638142046 1;
	setAttr ".wm[66]" -type "matrix" -0.99448608682427564 0.10309282984412477 0.019216959896650565 0
		 0.1038785476794237 0.99353710647592264 0.04575221729561732 0 -0.014376037178333662 0.047496173426730341 -0.99876796257432354 0
		 -8.0134168240251231 14.330614674032409 0.42471564334381073 1;
	setAttr ".wm[67]" -type "matrix" -0.99366984678280801 0.083957506454608116 -0.074641628496135065 0
		 0.081891519496340826 0.99617973839412932 0.030326685403866124 0 0.076902630834133415 0.024022196463460335 -0.99674917579492395 0
		 -8.3431339265600606 14.364796638388933 0.431082195718207 1;
	setAttr ".wm[68]" -type "matrix" 0.70965209202548374 -0.21128653996819308 0.672124918681136 0
		 0.55846080660308717 0.75030852901484446 -0.35377766856573906 0 -0.42955259954059555 0.62641448683427658 0.65045326881496024 0
		 -8.6478113692734286 14.390527891558358 0.40819354501552829 1;
	setAttr ".wm[69]" -type "matrix" 0.98830138592116545 -0.1524926943408392 0.0025196743788015569 0
		 0.15250830637989179 0.98826925593612158 -0.0080681011769608794 0 -0.0012597902368502636 0.0083579868470824541 0.99996427785417574 0
		 1.0568721067207663 9.1137882114517019 -0.055059408206639265 1;
	setAttr ".wm[70]" -type "matrix" -0.0070042068107996347 -0.99923107989864268 -0.038577066393700912 0
		 -0.0014384109611116662 -0.038567905116611595 0.99925494628189038 0 -0.99997443570366296 0.0070544779756208098 -0.0011671673543136565 0
		 1.0837287023625004 4.5857849122968979 -0.14152571569129996 1;
	setAttr ".wm[71]" -type "matrix" 0.028207978296129692 -0.47096870747920777 0.88169880715344628 0
		 -0.055319767847580872 0.87996251479153087 0.47181108067430388 0 -0.99807015447098479 -0.062084210046752103 -0.0012319160425778304 0
		 1.0561468914112686 0.65122079867995453 -0.29342582832023578 1;
	setAttr ".wm[72]" -type "matrix" 0.99999999999933675 -1.1356646611171417e-006 1.9400856373849584e-007 0
		 1.1356624025054413e-006 0.99999999993157418 1.1643103898950624e-005 0 -1.9402178625185784e-007 -1.1643103678793398e-005 0.99999999993220068 0
		 1.0898626331277113 0.088258573405622487 0.71177908712526139 1;
	setAttr ".wm[73]" -type "matrix" 0.0020877328206675831 -0.053411850866313761 0.99857038588108815 0
		 -0.062060494741380541 0.99664077451269661 0.05343839042474105 0 -0.99807020612987218 -0.062083337263445261 -0.00123404623445073 0
		 1.0898626236747382 0.088258006139736569 0.76050027878723936 1;
	setAttr ".wm[74]" -type "matrix" 0.99807020187253603 0.062083397776619503 0.0012344450680524751 0
		 -0.062060576770755507 0.99664077711221843 0.05343824667814321 0 0.0020873296330783 -0.053411732022684039 0.99857039308069862 0
		 1.0916023961499084 0.044185627620838261 1.5717727323394746 1;
	setAttr ".wm[75]" -type "matrix" 0.98830425356055596 0.15247132240534383 -0.0026829532380944956 0
		 -0.15249132880161642 0.98824881466960846 -0.010520215987861688 0 0.0010473941137017614 0.010806301313569102 0.99994106167188224 0
		 -1.1177505745992526 9.1137464253806844 -0.055059623369649813 1;
	setAttr ".wm[76]" -type "matrix" 0.0070035269854729909 -0.99936286466425428 -0.034997361897990693 0
		 0.0015651646846284719 -0.034987222132405765 0.9993865341032806 0 -0.99997425010310814 -0.0070540071954086347 0.0013191335085505737 0
		 -1.0844866062656919 4.5948500626073976 -0.13060821176669601 1;
	setAttr ".wm[77]" -type "matrix" -0.014952882763997703 -0.47133775409634393 0.88182602187759263 0
		 0.030999517142655312 0.88128214427485885 0.47157270077818231 0 -0.99940754511558905 0.034387552191471812 0.0014335342027437855 0
		 -1.0569123333863133 0.65980110681669313 -0.26841389854296638 1;
	setAttr ".wm[78]" -type "matrix" 0.999999999999994 1.6773219117457994e-008 1.0627225354060965e-007 0
		 -1.6773216001894631e-008 0.99999999999999944 -2.9070264084829489e-008 0 -1.0627225400898499e-007 2.9070262419494952e-008 0.99999999999999378 0
		 -1.0677903849269703 0.08822716565032418 0.71152381639879536 1;
	setAttr ".wm[79]" -type "matrix" -0.00034631139625114672 -0.051796860858203946 0.99865758159323692 0
		 0.034413696166694756 0.99806549254739263 0.051778085154600313 0 -0.99940761333129879 0.034385429928480898 0.0014368799776886968 0
		 -1.0747820123531053 0.096386568727443889 0.78567001502164857 1;
	setAttr ".wm[80]" -type "matrix" 0.9994076081974429 -0.034385571787489272 -0.0014370559882235109 0
		 0.034413846612197575 0.99806543650406188 0.051779065434871055 0 -0.00034617685943305946 -0.051797846565315143 0.9986575305142289 0
		 -1.0750144450858365 0.055895094434143366 1.5927691824619008 1;
	setAttr ".wm[81]" -type "matrix" 0.99016423646156382 -1.7347234759768075e-018 -0.13990991684826476 0
		 -0.025968018372674304 0.98262438524274975 -0.18377970385247794 0 0.13747889603239039 0.18560527343345623 0.97295952414240083 0
		 -0.13721305152246274 9.7380903906067733 0.25597095598558789 1;
	setAttr ".wm[82]" -type "matrix" 0.99020717740092357 -0.0015041772518971956 -0.13959757617699103 0
		 -0.013931340706415036 0.99388603719359747 -0.10952836535678193 0 0.13890883186398811 0.11040055490078755 0.98413213234188235 0
		 -0.12342076784996429 10.463527885920938 0.35358109213092714 1;
	setAttr ".wm[83]" -type "matrix" 0.98459350111405175 -0.011678554867160545 -0.17446847543378294 0
		 -0.0076145623837178683 0.99395704032641374 -0.10950534427716584 0 0.17469303364381267 0.10914675140273702 0.97855471520735648 0
		 -0.14536951011467789 11.449428976620325 0.18726894865031765 1;
	setAttr ".wm[84]" -type "matrix" 0.97760978566818657 -0.020304596015618938 -0.20944409838055802 0
		 0.0254880765681436 0.99943127311831281 0.022079136440654228 0 0.20887667394579704 -0.026923107059756122 0.97757131780120776 0
		 -0.1767152066243215 12.41741680597047 -0.054422095776226226 1;
	setAttr ".wm[85]" -type "matrix" 0.96933583593802286 -0.015712569079886673 -0.24523693102639377 0
		 -0.010761383117137441 0.99428221568241315 -0.10624061469643958 0 0.24550403214558536 0.10562192362658872 0.96362429372119829 0
		 -0.20150524050860108 13.350517159143887 -0.26059264801148352 1;
	setAttr ".wm[86]" -type "matrix" 0.96933583593802286 -0.015712569079886673 -0.24523693102639377 0
		 -0.010761383117137441 0.99428221568241315 -0.10624061469643958 0 0.24550403214558536 0.10562192362658872 0.96362429372119829 0
		 -0.20691601512380095 14.378783485951429 -0.34786157336301815 1;
	setAttr ".wm[87]" -type "matrix" 0.96933583593802286 -0.015712569079886673 -0.24523693102639377 0
		 -0.010761383117137441 0.99428221568241315 -0.10624061469643958 0 0.24550403214558536 0.10562192362658872 0.96362429372119829 0
		 -0.15501003105294014 15.130636447935759 -0.19086732011054336 1;
	setAttr ".wm[88]" -type "matrix" 0.96933583593802286 -0.015712569079886673 -0.24523693102639377 0
		 -0.010761383117137441 0.99428221568241315 -0.10624061469643958 0 0.24550403214558536 0.10562192362658872 0.96362429372119829 0
		 -0.18712555634020717 17.305384713217386 -0.45714700167080069 1;
	setAttr ".wm[89]" -type "matrix" 0.96933583593802286 -0.015712569079886673 -0.24523693102639377 0
		 -0.010761383117137441 0.99428221568241315 -0.10624061469643958 0 0.24550403214558536 0.10562192362658872 0.96362429372119829 0
		 -0.15501003105294014 15.130636447935759 -0.19086732011054336 1;
	setAttr ".wm[90]" -type "matrix" 0.96933583593802286 -0.015712569079886673 -0.24523693102639377 0
		 -0.010761383117137441 0.99428221568241315 -0.10624061469643958 0 0.24550403214558536 0.10562192362658872 0.96362429372119829 0
		 -0.20691601512380095 14.378783485951429 -0.34786157336301815 1;
	setAttr ".wm[91]" -type "matrix" 0.96650264045504386 -0.10340837320318705 -0.23490286150853595 0
		 -0.074835928494857512 -0.98901502395104668 0.12747104065403678 0 -0.24550403214558536 -0.10562192362658859 -0.96362429372119829 0
		 0.71015037466184483 13.916816448122722 -0.096533283828337729 1;
	setAttr ".wm[92]" -type "matrix" 0.1701677294472615 -0.93221414352795073 -0.31940528245665101 0
		 -0.92825636161469904 -0.26043043674140431 0.26554870502512778 0 -0.33073111582765313 0.2513021651819396 -0.90965056521626175 0
		 2.023872666683026 13.776258234029575 -0.4158258679417508 1;
	setAttr ".wm[93]" -type "matrix" 0.061365040099272947 -0.93762193949970762 -0.34219794041230206 0
		 0.99522505701883723 0.031406544010623524 0.092415988200966775 0 -0.075904003421868801 -0.3462350755803284 0.93507211203330087 0
		 2.3809786133757544 11.46984811689593 -1.4521928212355579 1;
	setAttr ".wm[94]" -type "matrix" -0.09612850907178952 -0.71112941887652659 -0.69645836871414568 0
		 -0.23559850950560338 0.69607182687013625 -0.67821630336966199 0 0.96708461473770368 0.098888631530650709 -0.23445337807679861 0
		 2.3925411547976858 10.227252220730863 -1.8656672012234496 1;
	setAttr ".wm[95]" -type "matrix" 0.20370030882176282 -0.65334149401727948 -0.72914407107319201 0
		 0.72901454926743015 0.59833415129729495 -0.3324665853100901 0 0.65348601449635002 -0.46383309022385971 0.59817630617658291 0
		 2.4088145124452129 9.0704036092467959 -2.2845908516143263 1;
	setAttr ".wm[96]" -type "matrix" 0.030778428488846876 -0.80588898729973768 -0.59126612323788752 0
		 -0.65368375442543214 -0.46373422914145612 0.5980368834134322 0 -0.75614167821912071 0.36809442385287938 -0.54106954967766296 0
		 2.5257982814968534 8.6951938175186552 -2.7033335727676606 1;
	setAttr ".wm[97]" -type "matrix" -0.034602760756462 -0.84038090934987797 -0.54089053989536906 0
		 -0.73007130400332421 -0.34834171749874149 0.58792341246195756 0 -0.68249435163883732 0.41523243496901796 -0.60148440123646096 0
		 2.5410366472602219 8.2961990748990022 -2.9960687737430258 1;
	setAttr ".wm[98]" -type "matrix" -0.11884669769901279 -0.87504265889252186 -0.46922895004927567 0
		 0.1148847828936744 -0.48152301009733439 0.86887115121073988 0 -0.98624385884299071 0.049355200993498258 0.1577565055057274 0
		 2.492333897091541 8.0247040648849151 -3.2156039197810466 1;
	setAttr ".wm[99]" -type "matrix" -0.36812007349424247 -0.62855145503937038 -0.68513551933795147 0
		 0.92927688796303498 -0.27291943140628372 -0.2489165511945885 0 -0.030529935937221794 -0.72831178236299454 0.68456546121091177 0
		 2.3909872560975822 7.889616790397894 -3.3638435927754946 1;
	setAttr ".wm[100]" -type "matrix" -0.36812007349424247 -0.62855145503937038 -0.68513551933795147 0
		 0.92927688796303498 -0.27291943140628372 -0.2489165511945885 0 -0.030529935937221794 -0.72831178236299454 0.68456546121091177 0
		 2.3427539327149427 7.8072601688049215 -3.4536142014561886 1;
	setAttr ".wm[101]" -type "matrix" 0.0063302179531404268 -0.81955789213755725 -0.57296142084411772 0
		 0.73086345395157248 0.39485046078820019 -0.55671512041018234 0 0.68249435163863681 -0.41523243496912693 0.60148440123661273 0
		 2.4105989195338768 8.6161443270062037 -2.6002117309602037 1;
	setAttr ".wm[102]" -type "matrix" -0.024475300848948802 -0.83546953557277515 -0.54899145237258951 0
		 -0.73048095090117882 -0.35996205366605966 0.58036617776281785 0 -0.6824943516387979 0.4152324349690476 -0.60148440123648483 0
		 2.413887282198615 8.1904080262900649 -2.8978483934869006 1;
	setAttr ".wm[103]" -type "matrix" -0.10761335375287792 -0.87106684362842746 -0.47923054997074943 0
		 -0.6563836106963401 -0.29979096279448969 0.69230479865156846 0 -0.74671274376649921 0.38906031994789925 -0.53949248904757219 0
		 2.3989611435819418 7.8328014109876314 -3.1350806234864166 1;
	setAttr ".wm[104]" -type "matrix" -0.15243518595821728 -0.88571668558178041 -0.4384854238899048 0
		 0.39143319035579993 -0.46149509599954824 0.79611703527574873 0 -0.90749301461210352 -0.050281500080977523 0.41704699876613799 0
		 2.343421945611122 7.6732120135595343 -3.2751747343857565 1;
	setAttr ".wm[105]" -type "matrix" -0.15243518595821728 -0.88571668558178041 -0.4384854238899048 0
		 0.39143319035579993 -0.46149509599954824 0.79611703527574873 0 -0.90749301461210352 -0.050281500080977523 0.41704699876613799 0
		 2.3020084199048818 7.5508240833850637 -3.3666434612772846 1;
	setAttr ".wm[106]" -type "matrix" -0.08863883520736579 -0.86389560519784836 -0.49580998397866627 0
		 0.72549611775264933 0.28507263683058193 -0.6264095903291178 0 0.68249435163883598 -0.41523243496902174 0.6014844012364593 0
		 2.3383500704643625 8.5740506106630932 -2.5472913975269975 1;
	setAttr ".wm[107]" -type "matrix" -0.091619956658072377 -0.86505998866850597 -0.49323118265861676 0
		 -0.72512567429494024 -0.28151952144543102 0.62844213379072855 0 -0.68249435163983663 0.41523243496863321 -0.6014844012355921 0
		 2.2947581743302892 8.1491934089143747 -2.7911269271035257 1;
	setAttr ".wm[108]" -type "matrix" -0.12125486118687673 -0.8758686898073974 -0.46706669422430985 0
		 -0.97257881134286017 0.19891129215081943 -0.12051868561264861 0 0.19846338293362931 0.43964569379213181 -0.87597029034355689 0
		 2.2713113642036644 7.6997158803322883 -3.0220299558750447 1;
	setAttr ".wm[109]" -type "matrix" -0.087811359351749538 -0.8635699219910784 -0.49652407293214018 0
		 0.83703037524652379 0.20627233851858495 -0.50678582584434806 0 0.54006417774507243 -0.46010728335291262 0.70472120141382255 0
		 2.2398772794398618 7.512002477225602 -3.1204970953225342 1;
	setAttr ".wm[110]" -type "matrix" -0.087811359351749538 -0.8635699219910784 -0.49652407293214018 0
		 0.83703037524652379 0.20627233851858495 -0.50678582584434806 0 0.54006417774507243 -0.46010728335291262 0.70472120141382255 0
		 2.2110363351742559 7.3669796902105373 -3.2231708210860965 1;
	setAttr ".wm[111]" -type "matrix" -0.14335582965117502 -0.88301243051216693 -0.44692074651555319 0
		 0.71669419286481495 0.2187945897655672 -0.66217698646447132 0 0.68249435163880612 -0.41523243496903406 0.60148440123648483 0
		 2.2160030315310708 8.5270657681752855 -2.4409020508917321 1;
	setAttr ".wm[112]" -type "matrix" -0.16304328431375692 -0.88870421966592927 -0.42851102364834864 0
		 -0.71247340120268998 -0.194388361013862 0.67423647015050658 0 -0.68249435163879102 0.41523243496903822 -0.60148440123649904 0
		 2.15457134605448 8.1016793104719635 -2.6648604378568077 1;
	setAttr ".wm[113]" -type "matrix" -0.1021564331338736 -0.86906288900799877 -0.48403900474903427 0
		 0.72371646599381612 0.26890838569806486 -0.63554917744473727 0 0.68249435163874106 -0.41523243496905676 0.6014844012365429 0
		 2.0886313709177373 7.6706624075429852 -2.8588059651008941 1;
	setAttr ".wm[114]" -type "matrix" -0.14447824345524032 -0.88335405490200725 -0.44588300130894237 0
		 -0.71646876913735524 -0.21741122012874464 0.66287620579783457 0 -0.68249435163881811 0.41523243496903339 -0.60148440123647151 0
		 2.0553461143450837 7.4961413951149432 -2.9705506648020408 1;
	setAttr ".wm[115]" -type "matrix" -0.14447824345524032 -0.88335405490200725 -0.44588300130894237 0
		 -0.71646876913735524 -0.21741122012874464 0.66287620579783457 0 -0.68249435163881811 0.41523243496903339 -0.60148440123647151 0
		 2.0196718948624035 7.3661149473260998 -3.0517553789170733 1;
	setAttr ".wm[116]" -type "matrix" -0.52478196751331208 -0.85120059159149553 0.0078383319108864535 0
		 -0.50872914852018147 0.32099778476494945 0.7988460900711265 0 -0.68249435163874261 0.41523243496899837 -0.6014844012365812 0
		 2.098319765909396 8.7237414809927447 -2.3353389347120452 1;
	setAttr ".wm[117]" -type "matrix" -0.38286172862710371 -0.90411365361122331 -0.18972453216817037 0
		 0.89345160086333963 -0.41460183293829383 0.17277024349968878 0 -0.23486407487608787 -0.10336257290708342 0.96651696563207168 0
		 1.7987658549619876 8.4230199905060985 -2.4402908421925282 1;
	setAttr ".wm[118]" -type "matrix" -0.33500614026083908 -0.90913137840876324 -0.24748943973454152 0
		 0.92245003288690675 -0.36998168275393545 0.11045130716071146 0 -0.19198130850288159 -0.19129477572361558 0.9625744054182892 0
		 1.6367682558782499 8.147180457722321 -2.527418831607076 1;
	setAttr ".wm[119]" -type "matrix" -0.33500614026083908 -0.90913137840876324 -0.24748943973454152 0
		 0.92245003288690675 -0.36998168275393545 0.11045130716071146 0 -0.19198130850288159 -0.19129477572361558 0.9625744054182892 0
		 1.5008178296611938 7.8937882863924473 -2.6338140658426106 1;
	setAttr ".wm[120]" -type "matrix" 0.96650264045504386 -0.10340837320318705 -0.23490286150853595 0
		 -0.074835928494857512 -0.98901502395104668 0.12747104065403678 0 -0.24550403214558536 -0.10562192362658859 -0.96362429372119829 0
		 -0.90780506616826706 13.943055549192925 0.3127996510058435 1;
	setAttr ".wm[121]" -type "matrix" 0.53025545312033262 0.58775439781152372 -0.61104330639436988 0
		 0.76393691410310172 -0.64381222560168583 0.043660158456354903 0 -0.3677357008869015 -0.48994957497585112 -0.79039222432549394 0
		 -2.218946924598332 13.845015731929317 0.65758731276953286 1;
	setAttr ".wm[122]" -type "matrix" -0.12173372822621392 0.8875936611918982 -0.44425037087672564 0
		 -0.75899243755445545 0.20518201596298447 0.61792460710066521 0 0.63961815104583475 0.41240493806127942 0.64869930469777748 0
		 -2.5125551426752155 11.614957061373296 1.8665649472424088 1;
	setAttr ".wm[123]" -type "matrix" -0.22543888349049776 0.59668065058653341 -0.77016200310466432 0
		 -0.28644583026254167 -0.79616640541515626 -0.53298015086259309 0 -0.93119605676557771 0.10045524428291767 0.3504035498682887 0
		 -2.3113767082895929 10.503163003146218 2.4112676268535269 1;
	setAttr ".wm[124]" -type "matrix" -0.44978858632276741 0.8905445362824953 0.06797541107755134 0
		 -0.85465510204065254 -0.45126078762753957 0.2567651808669833 0 0.25933546647084027 0.057394515828330328 0.96408038325815082 0
		 -2.1063659343600585 9.4115383447324987 2.9406520112774941 1;
	setAttr ".wm[125]" -type "matrix" -0.1981966468481573 0.9794737511782281 0.036732273697630977 0
		 0.97187187385194784 0.20124609909579752 -0.12233179641543693 0 -0.12721301031596671 0.011453311816908073 -0.99180929197843992 0
		 -2.3418150389913759 8.8896002719822853 2.9849095546583033 1;
	setAttr ".wm[126]" -type "matrix" -0.11224950701202589 0.99354622133849257 0.016308103493685444 0
		 0.96678074540681713 0.11298896013768883 -0.22927818299533562 0 -0.2296411080059404 -0.0099700025580428883 -0.97322431153501121 0
		 -2.418410002806878 8.4010069337816056 3.0079881285531043 1;
	setAttr ".wm[127]" -type "matrix" 0.00037041451380841195 0.99994656357655698 -0.010331156010973213 0
		 0.76664568635353358 0.0063493676692744916 0.64203899969216827 0 0.6420702877322757 -0.0081581567547750616 -0.76660236765206835 0
		 -2.4532395319148494 8.0527449140013481 2.9657270232470054 1;
	setAttr ".wm[128]" -type "matrix" -0.11263775128933672 0.91124213616254102 -0.39616979474262143 0
		 -0.60543433109789013 0.25320660482023122 0.75454336257332555 0 0.78788451419769101 0.3248448622917417 0.52317665059722218 0
		 -2.4572555478108171 7.8525921149932998 2.86371330188283 1;
	setAttr ".wm[129]" -type "matrix" -0.11263775128933672 0.91124213616254102 -0.39616979474262143 0
		 -0.60543433109789013 0.25320660482023122 0.75454336257332555 0 0.78788451419769101 0.3248448622917417 0.52317665059722218 0
		 -2.4667280543511625 7.7321365432495153 2.8129297567552811 1;
	setAttr ".wm[130]" -type "matrix" -0.16620611066922653 0.9856609605603478 0.029120432748530149 0
		 -0.95897887895922329 -0.1684430760709521 0.22800535045008702 0 0.22964110800621121 0.0099700025580901977 0.97322431153494671 0
		 -2.1718415371950544 8.862675300142401 2.9617242920435007 1;
	setAttr ".wm[131]" -type "matrix" -0.12564537185886018 0.99188383189197049 0.019486009384948239 0
		 0.96513118385234442 0.12675591931067287 -0.22902998684774584 0 -0.22964110800599521 -0.0099700025580620431 -0.973224311534998 0
		 -2.2354624791629503 8.3475179986366559 2.9820136569778346 1;
	setAttr ".wm[132]" -type "matrix" -0.014770631245395752 0.99986807237208808 -0.0067576847764514447 0
		 0.99029058314695428 0.013694188163096782 -0.13833665508829987 0 -0.13822586365466513 -0.0087353913180263087 -0.99036220826293775 0
		 -2.2696532910974563 7.9195517806286597 2.9899444496358956 1;
	setAttr ".wm[133]" -type "matrix" 0.045876117892277399 0.99872519808806781 -0.021056127637435605 0
		 0.55328519049356018 -0.0078537845803119608 0.83295487035509364 0 0.83172764760325191 -0.049862779422292183 -0.55294016262218182 0
		 -2.2835658606612643 7.7067583013208463 2.9379692266810356 1;
	setAttr ".wm[134]" -type "matrix" 0.045876117892277399 0.99872519808806781 -0.021056127637435605 0
		 0.55328519049356018 -0.0078537845803119608 0.83295487035509364 0 0.83172764760325191 -0.049862779422292183 -0.55294016262218182 0
		 -2.2829828613698502 7.5517008356864901 2.9060259666270434 1;
	setAttr ".wm[135]" -type "matrix" -0.04025833375293969 0.99918903310392559 -0.00073667379454356308 0
		 -0.97244240347551503 -0.039011218563833494 0.2298562523598793 0 0.22964110800595056 0.009970002558047468 0.97322431153500877 0
		 -2.0768191350995906 8.8463204141615908 2.939470438342116 1;
	setAttr ".wm[136]" -type "matrix" -0.036261146727582724 0.99934093387780154 -0.0016814024635838267 0
		 0.97259965594915609 0.034904110434694165 -0.2298512830556883 0 -0.22964110800460835 -0.0099700025579992999 -0.97322431153532596 0
		 -2.0748720416171942 8.3545500256433058 2.9440488477324305 1;
	setAttr ".wm[137]" -type "matrix" 0.0036213410279573865 0.99993185681132646 -0.011098090962521826 0
		 0.3705991607937163 -0.011649877075710769 -0.92871984063177737 0 -0.92878584609594095 -0.00074973193476517153 -0.37061609516300492 0
		 -2.0651033361474029 7.8500343419774685 2.9794843849463226 1;
	setAttr ".wm[138]" -type "matrix" -0.041367364576182619 0.99914389152594318 -0.00047452546380782196 0
		 -0.91485409178421007 -0.03768659687439771 0.40202202820456867 0 0.40165997048960406 0.017064713370615308 0.9156298726362464 0
		 -2.0506323833797993 7.6362692670870382 2.9754854226949137 1;
	setAttr ".wm[139]" -type "matrix" -0.041367364576182619 0.99914389152594318 -0.00047452546380782196 0
		 -0.91485409178421007 -0.03768659687439771 0.40202202820456867 0 0.40165997048960406 0.017064713370615308 0.9156298726362464 0
		 -2.0567885820277119 7.4573141946278945 2.9569880413843288 1;
	setAttr ".wm[140]" -type "matrix" 0.033540662193175252 0.99927251666969708 -0.01815107182106826 0
		 -0.97269727330419886 0.036810820115867282 0.22913964744010096 0 0.22964110800599236 0.0099700025580502366 0.97322431153499878 0
		 -1.9125365433968995 8.847918587198782 2.9006900978526349 1;
	setAttr ".wm[141]" -type "matrix" 0.060321573885106013 0.99787935735536681 -0.024455999019957927 0
		 0.97140427692994802 -0.064322524927376529 -0.22855271503347196 0 -0.22964110800601045 -0.0099700025580487517 -0.97322431153499456 0
		 -1.885759139103071 8.3640094245558814 2.8993290373176199 1;
	setAttr ".wm[142]" -type "matrix" -0.022111903654291082 0.9997428776985422 -0.0050241623999710341 0
		 -0.97302416477214171 -0.020366087990343548 0.22980251789187497 0 0.22964110800607826 0.0099700025580502175 0.97322431153497857 0
		 -1.8320038353199795 7.8899361445258664 2.909277498507806 1;
	setAttr ".wm[143]" -type "matrix" 0.035064199602867156 0.99921363243671335 -0.018509961070710283 0
		 0.972643543863834 -0.038375979487451549 -0.22911093552770573 0 -0.22964110800597562 -0.0099700025580543167 -0.97322431153500277 0
		 -1.8313976289417528 7.6806554491816748 2.8932969268635214 1;
	setAttr ".wm[144]" -type "matrix" 0.035064199602867156 0.99921363243671335 -0.018509961070710283 0
		 0.972643543863834 -0.038375979487451549 -0.22911093552770573 0 -0.22964110800597562 -0.0099700025580543167 -0.97322431153500277 0
		 -1.8234322620928685 7.5247409534965986 2.8732864241282194 1;
	setAttr ".wm[145]" -type "matrix" 0.57965698020615652 0.80185768336152419 -0.14498979595947326 0
		 0.78183294047514806 -0.59743188288129057 -0.17836030529492808 0 -0.22964110800608745 -0.0099700025579807297 -0.97322431153497735 0
		 -1.8431082376987367 9.0589063671958918 2.7809364702742472 1;
	setAttr ".wm[146]" -type "matrix" 0.3685780317180436 0.92458064302153509 -0.096441013499124068 0
		 -0.21451082529292168 0.18553802128180885 0.95893730164749591 0 0.90450834178961725 -0.33275558178446285 0.266717795477319 0
		 -1.6435728160200662 8.7195254589372322 2.5907049844770649 1;
	setAttr ".wm[147]" -type "matrix" 0.29986266771998488 0.95058045486121678 -0.080493349686149712 0
		 -0.2932064423035286 0.17212616603765835 0.94042679946760555 0 0.90780634647460035 -0.25839772019315344 0.33033052462559231 0
		 -1.5157162156970352 8.4234502897354524 2.5138375446863819 1;
	setAttr ".wm[148]" -type "matrix" 0.29986266771998488 0.95058045486121678 -0.080493349686149712 0
		 -0.2932064423035286 0.17212616603765835 0.94042679946760555 0 0.90780634647460035 -0.25839772019315344 0.33033052462559231 0
		 -1.4250096900730289 8.1394236611297899 2.4423245337504538 1;
	setAttr ".wm[149]" -type "matrix" 0.98693969830916828 -0.082976914305368937 0.13807557203853038 0
		 0.13783330620093448 0.8786184573575091 -0.45719972232322104 0 -0.083378723923596798 0.47025996861637126 0.87858041767034734 0
		 0.86729900156022022 9.5219325230474983 0.40931503880804421 1;
	setAttr ".wm[150]" -type "matrix" 0.9899303174059062 -0.10181621664461142 0.098343401958745816 0
		 0.11384207286229868 0.98552594677109162 -0.12561286035816055 0 -0.084130548120507159 0.13554359545593153 0.98719298245268217 0
		 0.89119075816936399 4.7023984076600254 3.1395926958235152 1;
	setAttr ".wm[151]" -type "matrix" 0.99995757274685493 0.0083448256403103188 0.0039008449406991719 0
		 -0.0041861028376466436 0.78888428164339164 -0.61452751502192549 0 -0.0082054402228768312 0.61448511296940544 0.78888574374856446 0
		 1.0470850901621154 0.72061446531020079 3.2688429653327828 1;
	setAttr ".wm[152]" -type "matrix" 0.99995757313446099 0.0083447525939053437 0.003900901842613355 0
		 -0.0041860102469999617 0.78888428241607378 -0.61452751466072575 0 -0.0082054402228768312 0.61448511296940544 0.78888574374856446 0
		 1.0403242531235397 0.98594389871552679 4.4343397756229743 1;
	setAttr ".wm[153]" -type "matrix" 0.99995757313446099 0.0083447525939053437 0.003900901842613355 0
		 -0.0041860102469999617 0.78888428241607378 -0.61452751466072575 0 -0.0082054402228768312 0.61448511296940544 0.78888574374856446 0
		 1.0336694791265604 1.4843034553324641 5.0741416864880335 1;
	setAttr ".wm[154]" -type "matrix" 0.99290688061518539 0.094224287084962249 0.072510069303183072 0
		 -0.10921591175558409 0.96384582051191781 0.24304962230191687 0 -0.046987349855235089 -0.24924489564490299 0.96729993846197626 0
		 -1.0599116754678162 9.5218953575924683 0.68163643330555512 1;
	setAttr ".wm[155]" -type "matrix" 0.98887931406416807 0.077275408208635904 0.12706775162160105 0
		 -0.14094381789386803 0.75962354081150807 0.63490701401267191 0 -0.04746095672740256 -0.64575582655611852 0.76206749704691112 0
		 -1.2623838530159579 4.1326104792942031 -0.58211158272159924 1;
	setAttr ".wm[156]" -type "matrix" 0.99482473614785882 -0.010634395520514359 0.10104778067951856 0
		 -0.045998403810822111 0.83962112387311627 0.5412213181249439 0 -0.090597412740096361 -0.54306839162112774 0.83478669780180514 0
		 -1.2554140913167426 1.383234487836559 -3.4694145878298528 1;
	setAttr ".wm[157]" -type "matrix" 0.9945624625892403 -0.0026042237673850801 0.10410920241263569 0
		 -0.0062719422448883969 0.99637485043872875 0.084839967902385849 0 -0.10395273324402084 -0.085031614307682593 0.99094069137326635 0
		 -1.3301733755935465 0.3697473589332273 -2.840063187493203 1;
	setAttr ".wm[158]" -type "matrix" 0.9945624625892403 -0.0026042237673850801 0.10410920241263569 0
		 -0.0062719422448883969 0.99637485043872875 0.084839967902385849 0 -0.10395273324402084 -0.085031614307682593 0.99094069137326635 0
		 -1.4144814331673121 0.3007847640025676 -2.0363874951535825 1;
	setAttr -s 159 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 4.3802862137378874e-007 -9.8935068137797319e-008
		 1.8225802023132752e-006 0 -5.7220458984375e-006 10.402189254760742 -0.2471792995929718 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 2.8066595294803169e-007 3.6301168144176486e-006
		 -6.1979521898303044e-007 0 -1.3932772725156864e-006 0.69452582010148012 0.23151161646851023 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.51426497292600715 -0.48531591527726864 0.51426497292600715 0.48531591527726881 1
		 1 1 yes;
	setAttr ".xm[3]" -type "matrix" "xform" 1 1 1 2.6827891707607336e-007 1.2621774483536186e-029
		 5.7193184911653744e-007 0 1.0000712159633236 2.220446049250317e-016 2.220604180454723e-016 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.039539335559174542 0.99921801472128147 1
		 1 1 yes;
	setAttr ".xm[4]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.99819715057481306 -6.6613381477509412e-016
		 2.2164429193667621e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.053960363139938981 0.99854307829447497 1
		 1 1 yes;
	setAttr ".xm[5]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.9559273568014075 -1.332267629550188e-015
		 7.8886090522101181e-031 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.13332521293345459 0.99107234226177909 1
		 1 1 yes;
	setAttr ".xm[6]" -type "matrix" "xform" 1 1 1 1.40307604294316e-007 -1.4755456764590544e-006
		 -1.8984606707671259e-006 0 1.0319871978987856 1.0384447219435588e-007 -1.5946027041111585e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.1490833645604914 0.98882463076691396 1
		 1 1 yes;
	setAttr ".xm[7]" -type "matrix" "xform" 1 1 1 -3.9449817721963066e-007 1.2314736451416912e-006
		 2.1846321493596882e-006 0 0.76981122766778931 -2.9004939351951921e-006 1.9381915764490929e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16801048647395175 0.98578520806247949 1
		 1 1 yes;
	setAttr ".xm[8]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1912248385598798 -2.7755575615628933e-016
		 4.8654965357994392e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50395213478730405 0.49601637658782899 -0.50395213478730394 0.4960163765878291 1
		 1 1 yes;
	setAttr ".xm[9]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999967 1.5866680097866868
		 1.5707963267948963 0 0 1.6523241108679088e-016 -1.872556203021291e-031 5.9164567891575885e-031 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[10]" -type "matrix" "xform" 1 1.0000000000000002 1.0000000000000004 1.2490457723982562
		 1.5707963267948966 0 0 9.1593399531575415e-016 -8.8817841970012543e-016 -3.944304526105059e-031 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[11]" -type "matrix" "xform" 1 1 1 -4.9511415288805038e-008 1.6232992511951041e-007
		 2.7607279495529899e-007 0 0.54561011861420083 -0.42957082332397145 -0.83457044652331891 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67513819045534107 0.0075848649214652931 -0.73760573811300278 0.0082866588914360991 1
		 1 1 yes;
	setAttr ".xm[12]" -type "matrix" "xform" 1 1 1 0.026913764335589337 0.261705226665431
		 0.1035948665433247 0 1.3592544616909905 1.312797660596777e-007 1.6032117582664984e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0040950703885634107 -0.085162370925102482 -0.047855055204499758 0.99520876938876623 1
		 1 1 yes;
	setAttr ".xm[13]" -type "matrix" "xform" 1 1 1 0.014305171923890041 0.22926137591067869
		 0.094310192429049464 0 2.553655711169089 1.1011270987584809e-006 -8.2281121076277497e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.99346496288104769 -0.05484069828757844 0.1000153550685596 -0.0040980592478926546 1
		 1 1 yes;
	setAttr ".xm[14]" -type "matrix" "xform" 1 1 1 -4.4453090333773765e-006 0 -9.3696906262779529e-008 0 1.3096332755534157
		 -1.4224732503009818e-016 -1.745348657267165e-015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.3186782359443342e-005 -0.0058386499754808467 0.011935065416903175 0.99991172820707874 1
		 1 1 yes;
	setAttr ".xm[15]" -type "matrix" "xform" 1 1 1 1.9618512178560058e-006 3.5099978621547503e-006
		 0.00012088685780214879 0 1.2304723947407854 2.6995524712858376e-007 -9.7073039047601561e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[16]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.51940462129296938 0.24488286600328671
		 0.008017347854876837 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70269005227919401 0.0444557163970234 0.077458897856475653 0.70586861302253068 1
		 1 1 yes;
	setAttr ".xm[17]" -type "matrix" "xform" 1 1 1 1.2150483536271065e-006 2.4161366005159564e-006
		 -7.566741349799887e-006 0 0.49509203162904608 -6.0244826866062695e-007 -2.1942004961861272e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0034566604020950398 -0.046116198670580845 -0.074665800436087351 0.99613571663919287 1
		 1 1 yes;
	setAttr ".xm[18]" -type "matrix" "xform" 1 1 1 -6.216174751642227e-008 1.5560324018158709e-006
		 4.2003929389434143e-005 0 0.35253291479958715 -6.7197856512546394e-006 7.4670804439680438e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.025545828352142756 -0.079477334207609746 -0.16010180470931293 0.98356401730130183 1
		 1 1 yes;
	setAttr ".xm[19]" -type "matrix" "xform" 1 1 1 2.3545979605942976e-008 -1.4201337954937749e-006
		 -6.0855658337428665e-005 0 0.22470332612567498 2.9437111148666872e-006 2.7006941075713442e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.016577286950640948 0.034920573752879776 0.029114130526386429 0.99882837088752063 1
		 1 1 yes;
	setAttr ".xm[20]" -type "matrix" "xform" 1 1 1 -4.2645013946581601e-007 -2.4255464165280804e-007
		 4.3374200551448054e-008 0 0.13102962168351026 -7.9627404372395461e-006 -5.9983478139929991e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.41652180086800483 0 0 0.90912572804957736 1
		 1 1 yes;
	setAttr ".xm[21]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.54751461523414147 0.074435120713925731
		 0.025658877582129418 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70388761561844004 0.032640077774790416 0.065691818427133383 0.70651357728891484 1
		 1 1 yes;
	setAttr ".xm[22]" -type "matrix" "xform" 1 1 1 1.1402472606918574e-006 2.5597689937503963e-006
		 -1.5922699564696093e-005 0 0.51947791778283525 6.5692981382481364e-007 -5.7024383881554286e-008 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.00011928184887207558 -0.023341383643474233 -0.0051088570702179214 0.99971449182298278 1
		 1 1 yes;
	setAttr ".xm[23]" -type "matrix" "xform" 1 1 1 -5.2438938456238505e-008 -3.9007904277093771e-007
		 5.1469404443159577e-005 0 0.42938911607746455 3.3657280212873175e-008 1.9932448025450356e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0049556444787034653 -0.036796680241959978 -0.12325047340713666 0.99168077863589155 1
		 1 1 yes;
	setAttr ".xm[24]" -type "matrix" "xform" 1 1 1 0 -1.8331969002809901e-007 -4.2746101066884842e-005 0 0.21949883414583751
		 1.3322676295501878e-015 -1.3877787807814457e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.0067351835952315963 -0.02850524738348802 0.025484149987294383 0.99924603890782071 1
		 1 1 yes;
	setAttr ".xm[25]" -type "matrix" "xform" 1 1 1 0 -9.9722292695642059e-008 3.2767015547000205e-008 0 0.15830334908979801
		 7.3108779223840514e-006 2.5009531989805822e-007 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.17760653009176902 -0.00099493120652647399 0.10488358110630273 0.97849597086292261 1
		 1 1 yes;
	setAttr ".xm[26]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.94248666544950144 -0.019580546814903829
		 0.044236036817789579 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70667046791261989 -0.013403130605467616 0.019749435673847418 0.70714013155858724 1
		 1 1 yes;
	setAttr ".xm[27]" -type "matrix" "xform" 1 1 1 1.5054833405342213e-006 1.7916782409311897e-006
		 -4.4004257967834811e-005 0 0.1137847392193332 -2.8822240227917253e-007 1.6414871277887404e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.5686048317904069e-005 -0.00049933590116115617 0.031398329503765608 0.99950682605071717 1
		 1 1 yes;
	setAttr ".xm[28]" -type "matrix" "xform" 1 1 1 0 -1.5111603592595811e-007 0.00014593124575904354 0 0.50586162292317904
		 -4.024783057943182e-007 4.1551328933131515e-008 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.00084248391076661468 -0.033664061654494981 -0.037755584975296533 0.99871944858251138 1
		 1 1 yes;
	setAttr ".xm[29]" -type "matrix" "xform" 1 1 1 0 1.4861459997281304e-006 -0.00010188058439689594 0 0.21427988032169856
		 -8.4153272181253236e-007 3.3956282674552085e-007 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0026104458083248279 0.039817965939702049 -0.052634453016261171 0.99781628044284065 1
		 1 1 yes;
	setAttr ".xm[30]" -type "matrix" "xform" 1 1 1 1.4639837490923189e-007 -2.0057587791485468e-007
		 0 0 0.18001472934712762 3.9968028886505635e-015 -1.6653345369377348e-016 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63864290712065142 -0.041751317537302199 0.042072287522606583 0.76721704053742035 1
		 1 1 yes;
	setAttr ".xm[31]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.56509908721389202 -0.19178286279429754
		 0.026604941280610639 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70694550895530361 -0.032040861994800544 0.0011125633479871673 0.70654100569843348 1
		 1 1 yes;
	setAttr ".xm[32]" -type "matrix" "xform" 1 1 1 -2.6731526490594299e-007 2.3890267900042291e-006
		 -3.3610190609825082e-005 0 0.48465176381820596 1.4975491086088866e-006 4.5357222699937694e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.00045951618272613542 -0.025323603996224683 0.018136958744736208 0.99951465954882923 1
		 1 1 yes;
	setAttr ".xm[33]" -type "matrix" "xform" 1 1 1 -2.0194839173657907e-028 -3.0989643621015629e-008
		 0.00011285566295310332 0 0.47721957050136676 5.5511151231257827e-017 1.1102230246251565e-016 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.00099551003522854904 0.042344961450010828 -0.059703495843004745 0.99731710392617423 1
		 1 1 yes;
	setAttr ".xm[34]" -type "matrix" "xform" 1 1 1 -2.204549594643798e-008 -6.501426995773111e-007
		 -7.995634652130032e-005 0 0.2098865645898158 3.3306690738754696e-016 7.7755447683011329e-017 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0030140778544807565 -0.029218636983767421 -0.019484833091808696 0.99937857084634463 1
		 1 1 yes;
	setAttr ".xm[35]" -type "matrix" "xform" 1 1 1 -3.848404279304603e-007 3.1707256655686991e-007
		 6.7038992325212867e-008 0 0.15739673648073976 6.6613381477509392e-016 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70578542592403959 0.043208014918675465 0.043208014918676291 0.70578542592405313 1
		 1 1 yes;
	setAttr ".xm[36]" -type "matrix" "xform" 1 1 1 -0.02178458565178315 0.4019163193546032
		 0.15667454065713554 0 0.35899676284116427 -0.28916527743762577 -0.081630618452098236 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.7078003884474714 -0.11007353760441969 -0.30215343510226234 0.62897196128981769 1
		 1 1 yes;
	setAttr ".xm[37]" -type "matrix" "xform" 1 1 1 3.0257659721612156e-007 -3.3954241228185316e-005
		 8.2074768918631072e-008 0 0.43723799403967767 9.4638417629244742e-006 5.1772840963248967e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.019580580772277652 0.080176609916516234 0.092477750717201282 0.99228835410943039 1
		 1 1 yes;
	setAttr ".xm[38]" -type "matrix" "xform" 1 1 1 -4.1363439804290853e-008 1.8867051765082581e-005
		 3.4877960060407262e-007 0 0.33154669437810225 -9.856517878104043e-006 -4.7994192131639579e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0074065091927567536 0.046549099817814119 -0.011174898185199667 0.99882603419127958 1
		 1 1 yes;
	setAttr ".xm[39]" -type "matrix" "xform" 1 1 1 1.1357971827649573e-007 -1.3493026418066036e-007
		 -5.4561663591918079e-007 0 0.30661133173697996 -1.1207656636091912e-008 -9.9955192038869711e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.27311822996689178 -0.02434637575694764 0.080809196363228364 0.95827113085513682 1
		 1 1 yes;
	setAttr ".xm[40]" -type "matrix" "xform" 1 1 1 1.0097419587074891e-028 6.9795060722550211e-006
		 -2.1173912828815275e-007 0 0.54563364738741316 -0.42957046161955298 0.83456738902715644 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67513017475632409 -0.0075847748687983604 -0.73761307488549543 0.0082867413166769922 1
		 1 1 yes;
	setAttr ".xm[41]" -type "matrix" "xform" 1 1 1 0.026914791358929158 0.26171082646963617
		 0.103556802949889 0 1.3592626752653763 -2.0175317588713021e-006 -2.6731632339904721e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.99999917053359755 0 -0.0012879953869613283 0.086420992347316497 0.0040323548361830231 0.995100242870819 0.047860827767780091 1
		 1 1 yes;
	setAttr ".xm[42]" -type "matrix" "xform" 1 1 1 -0.017748335070776215 -0.2079172982374336
		 0.089760954866691584 0 2.5536231329827905 -1.2610805775192802e-006 7.8629496760851403e-008 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0050809299912013151 0.10938118474208339 -0.049360498240287355 0.99276053597446823 1
		 1 1 yes;
	setAttr ".xm[43]" -type "matrix" "xform" 1 1 1 2.4626578209890851e-007 -8.8400125441978616e-008
		 5.7881383628673015e-008 0 1.2543047592759959 -7.5743490295099303e-007 9.024587642764148e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.99996651996226082 0 0.008182845138795752 0.00083177786182117911 -0.99998931087671505 -2.0245335619084686e-006 0.0045482165518230411 1
		 1 1 yes;
	setAttr ".xm[44]" -type "matrix" "xform" 1 1 1 1.1456806060100633e-007 5.7258398965370369e-006
		 2.2411639557518015e-005 0 1.2304038776261452 -4.5002850580788678e-007 2.4041580599695744e-005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.013527827263193975 0.042589383668400434 0.99900090574764089 0.0005767180211685548 
		-0.013527827263189119 -0.04258938366839439 -0.99900090574764122 0.00057671802117197286 1
		 1 1 yes;
	setAttr ".xm[45]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.51661115217065734 0.25072377922080691
		 -0.008053992186467053 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70242752700602373 -0.048410059140130829 0.081443442764096943 0.70542115158888041 1
		 1 1 yes;
	setAttr ".xm[46]" -type "matrix" "xform" 1 1 1 -3.5144805252556172e-007 -8.8190977052167801e-008
		 0 0 0.49508832703449046 -1.0123219801816408e-005 3.5506516906647079e-006 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0034597389094055591 0.046116935660959396 -0.074730734965407691 0.99613080250710628 1
		 1 1 yes;
	setAttr ".xm[47]" -type "matrix" "xform" 1 1 1 -2.5243548967072765e-029 1.7477086860182776e-007
		 -2.5080176437219208e-006 0 0.35254648110588627 -1.8695814929303722e-005 1.8805473556149366e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.025545591470182066 0.079478560341638915 -0.15996647405124509 0.98358594356673845 1
		 1 1 yes;
	setAttr ".xm[48]" -type "matrix" "xform" 1 1 1 0 -2.255584510105793e-008 6.4907180328959353e-007 0 0.22468660547749758
		 1.7763568394002505e-015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.016585256890301155 -0.034918881304448084 0.02876474222349535 0.99883842066029094 1
		 1 1 yes;
	setAttr ".xm[49]" -type "matrix" "xform" 1 1 1 -5.0889274127996487e-008 -6.5434189255059519e-007
		 4.2791958776433603e-007 0 0.13107086140938481 1.6874855826021218e-005 3.4755562160482256e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.36601146921058864 -0.8321930027391351 -0.38127457784558189 0.16769050923353288 1
		 1 1 yes;
	setAttr ".xm[50]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.54664969767972749 0.080603558682474957
		 -0.025669274519964119 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.7036917356224055 -0.03660190276948453 0.069680745416446033 0.70613230746694222 1
		 1 1 yes;
	setAttr ".xm[51]" -type "matrix" "xform" 1 1 1 -2.7551154106658154e-007 7.8989468418960942e-008
		 4.8623212115378168e-006 0 0.51946723112882764 -7.1065079218501914e-006 5.0999518919070397e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.00011959705182491384 0.023342723908415471 -0.005122062636842009 0.99971439292001041 1
		 1 1 yes;
	setAttr ".xm[52]" -type "matrix" "xform" 1 1 1 0 -5.1878779863321712e-008 -3.6111389590726581e-006 0 0.42940438320293467
		 -5.8094965380006691e-007 -9.4533627309489887e-006 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 1 -0.0049559848796104158 0.036796042054037421 -0.12323556259977808 0.99168265368198649 1
		 1 1 yes;
	setAttr ".xm[53]" -type "matrix" "xform" 1 1 1 2.3805336460835364e-008 5.6215501797136815e-007
		 -2.3739414323955493e-005 0 0.21949301053145398 -1.027025453970154e-005 1.5106435546918817e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0067384936213587526 0.02850472869221652 0.025366529139275069 0.99924902419032868 1
		 1 1 yes;
	setAttr ".xm[54]" -type "matrix" "xform" 1 1 1 -1.4509049969477385e-007 -1.1052622728158212e-007
		 -4.224461270551031e-007 0 0.15831134045573389 -1.5085275414383759e-005 -1.2717116896210356e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.092618764455551061 0.97870824735026507 -0.17032347312472734 0.067393215845733184 1
		 1 1 yes;
	setAttr ".xm[55]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.96448259792696078 -0.008510349518768872
		 -0.045278334864067127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70673460862602877 0.0094260642474134522 0.023741483426339943 0.70701745681965622 1
		 1 1 yes;
	setAttr ".xm[56]" -type "matrix" "xform" 1 1 1 -4.4406428855321253e-007 4.9802155691598065e-008
		 -3.7582663117144163e-006 0 0.091908800742003943 9.1313375510892829e-006 1.3344623605768704e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.56394954348517e-005 0.00049864416139263257 0.031348621759177429 0.99950838666977004 1
		 1 1 yes;
	setAttr ".xm[57]" -type "matrix" "xform" 1 1 1 -1.6155871338931172e-027 -7.7503393372251121e-007
		 3.1552502306886046e-005 0 0.50584538868737661 -1.8967699029648344e-005 3.31184682744734e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.00084355980866263839 0.033662929802904737 -0.037623509085236755 0.99872447007572962 1
		 1 1 yes;
	setAttr ".xm[58]" -type "matrix" "xform" 1 1 1 3.2311742677870982e-027 1.0652674618205918e-006
		 -5.233697873329685e-005 0 0.21429089296469542 -1.0716994885598408e-005 1.0554577273280685e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0026046686311586584 -0.039817968530806026 -0.052654962660058015 0.99781521334897949 1
		 1 1 yes;
	setAttr ".xm[59]" -type "matrix" "xform" 1 1 1 1.6111336620383554e-007 -4.5318586090772261e-007
		 1.1826875149199659e-007 0 0.18002343650064556 -1.8257500848384289e-005 4.511588671818334e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.029365607429387573 -0.76773819959164946 -0.63755791307307064 0.05688255853938444 1
		 1 1 yes;
	setAttr ".xm[60]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.5672325509944437 -0.18539919288553708
		 -0.026615611543158169 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70711486584154049 0.028061362624406522 0.0051021143623090348 0.7065232443894508 1
		 1 1 yes;
	setAttr ".xm[61]" -type "matrix" "xform" 1 1 1 -4.2840394609894405e-007 -3.291339768684982e-007
		 1.4379991923912348e-006 0 0.48464186647014834 -8.7678298293925039e-007 9.7737518706120241e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.00045917612674566279 0.02532412491253629 0.018123168340218401 0.9995148966493751 1
		 1 1 yes;
	setAttr ".xm[62]" -type "matrix" "xform" 1 1 1 0 3.5076272329233408e-007 -3.6845211003581776e-006 0 0.47722151519170591
		 -3.148535338193259e-005 9.399779717478296e-006 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.00099982242127290202 -0.042345257263482157 -0.059777320410489207 0.99731266486842396 1
		 1 1 yes;
	setAttr ".xm[63]" -type "matrix" "xform" 1 1 1 0 1.8686489196175779e-007 -5.9686788704960063e-006 0 0.20989401879848349
		 -1.2195213392462989e-005 -7.6462302711632901e-008 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 1 -0.0030167183314540689 0.029218559012696221 -0.019398933810200275 0.99938023623981975 1
		 1 1 yes;
	setAttr ".xm[64]" -type "matrix" "xform" 1 1 1 3.637844192582124e-008 0 9.3006126477486991e-008 0 0.15739542186326125
		 -6.5795491055453681e-007 -1.5218613147460758e-008 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 1 -0.0016894912081311178 0.70710476283183354 -0.70203006723411265 0.084580049061593027 1
		 1 1 yes;
	setAttr ".xm[65]" -type "matrix" "xform" 1 1 1 0.0097496200128728422 -0.43362233287044749
		 0.17625433751640132 0 0.36224134852688733 -0.28509881860593106 0.081633905745682411 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70841225608467262 0.10608806914762814 -0.29859424841629434 0.63066541987511926 1
		 1 1 yes;
	setAttr ".xm[66]" -type "matrix" "xform" 1 1 1 3.4616422027797703e-007 -2.9376762978657813e-006
		 1.0369834601562038e-007 0 0.43724321993313964 -1.9452603237102295e-005 3.1238810400679995e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.019575740684063259 -0.08017337799972088 0.092520724478034458 0.99228470479940578 1
		 1 1 yes;
	setAttr ".xm[67]" -type "matrix" "xform" 1 1 1 2.2657484210566772e-007 5.0544979704815261e-006
		 -3.9895715220471125e-007 0 0.33154533227581168 1.8000917041405273e-006 4.8292879199635097e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0074075883393922388 -0.046551960359991651 -0.011278804543239405 0.99882472495914476 1
		 1 1 yes;
	setAttr ".xm[68]" -type "matrix" "xform" 1 1 1 -6.109001073895115e-007 0 -4.4629517148564446e-007 0 0.30661756583575556
		 -1.1682598363815799e-005 1.8680413658156425e-006 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.16644091874168426 -0.89747415742869741 -0.28473492614632828 -0.29285419435022386 1
		 1 1 yes;
	setAttr ".xm[69]" -type "matrix" "xform" 1 1 1 -0.0080686623169394633 -0.0025196460641610124
		 -0.15309228850888038 0 1.0568754995580645 -1.2884028853974185 0.192120351181642 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[70]" -type "matrix" "xform" 1 1 1 -0.00015532409640010549 7.5864363278197011e-005
		 -0.018674554999024193 0 0.71681196682657655 -4.4700929784983865 -0.12434204441748214 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54160407198500615 -0.45460425559959311 -0.46972701365524694 0.52854189298722909 1
		 1 1 yes;
	setAttr ".xm[71]" -type "matrix" "xform" 1 1 1 0.1910512238585845 0.099516647158339633
		 0.020239584586669322 0 3.9375917976181194 6.3050316160911078e-007 2.102811040405328e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.036570511502622971 -0.063080429268824068 0.52439880809200268 0.84834506375848284 1
		 1 1 yes;
	setAttr ".xm[72]" -type "matrix" "xform" 1 1 1 3.7158009270705235e-005 3.7795703266620339e-007
		 -1.0185833111898921e-006 0 1.1523766194007212 -0.022983985034138073 6.2061437869465053e-005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.19332032819988171 0.68062009619591413 0.1505058663255765 0.69045747121784573 1
		 1 1 yes;
	setAttr ".xm[73]" -type "matrix" "xform" 1 1 1 2.0046405969298157e-007 -1.9002356858124733e-007
		 -3.1554436208841047e-030 0 -4.4408920985006262e-016 0 0.048721191665281216 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.040864922456845809 -0.70636146748930284 0.0030641170051017852 0.70666409739418179 1
		 1 1 yes;
	setAttr ".xm[74]" -type "matrix" "xform" 1 1 1 -1.4385119637792943e-007 -3.950224143289386e-007
		 8.1887134953499755e-008 0 0.81247026648722365 -0.0006792064884760128 -1.402449740783851e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.70710678118654735 0 0.70710678118654768 1
		 1 1 yes;
	setAttr ".xm[75]" -type "matrix" "xform" 1 1 1 -0.0081775469830898118 -0.0026009495401317592
		 -0.15321474691961851 0 -1.1177471818345115 -1.2884407080441878 0.192120351181642 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.99996091101365703 0.0045211010010670584 0.0075983491799759151 3.4354246955698495e-005 
		0.99996091101365714 0.0045211010010550064 0.0075983491799778927 -3.4354246956370389e-005 1
		 1 1 yes;
	setAttr ".xm[76]" -type "matrix" "xform" 1 1 1 -0.00019246388584726049 -6.9863363787447952e-005
		 -0.017542491960787387 0 -0.65592448952050642 -4.4700716533903888 -0.12434185090584308 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.46972669401446021 -0.52854217705897977 -0.54160425652785016 0.45460403573980146 1
		 1 1 yes;
	setAttr ".xm[77]" -type "matrix" "xform" 1 1 1 -0.16619414972313692 -0.087012472616650516
		 0.014627506309855228 0 3.9375577497090073 -1.5574908032722767e-006 2.5167046420193628e-006 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.03657075158992748 0.063080872659216275 0.52439844928365509 0.84834524223431429 1
		 1 1 yes;
	setAttr ".xm[78]" -type "matrix" "xform" 1 1 1 -1.5775314146401682e-006 2.8104842886738568e-006
		 1.7342363985417758e-006 0 1.1337016128136526 -0.041943247998455897 -0.0073786477163273467 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15994622151053856 0.68825795181225047 0.18378177918605598 0.68333187810237206 1
		 1 1 yes;
	setAttr ".xm[79]" -type "matrix" "xform" 1 1 1 3.603813722750073e-007 6.1068282568515997e-007
		 0.0013530102706079789 0 -0.0069916194095918094 0.0081594010389421934 0.074146199603064789 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0066283942001120755 -0.70656766583153252 -0.030964866618407028 0.70693661316062251 1
		 1 1 yes;
	setAttr ".xm[80]" -type "matrix" "xform" 1 1 1 9.8181509208079569e-007 1.6842462670345183e-007
		 -1.5087474447667571e-007 0 0.80811311441581524 0.0013689073159718417 -3.1707563019622853e-007 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.70710678118654724 0 0.70710678118654791 1
		 1 1 yes;
	setAttr ".xm[81]" -type "matrix" "xform" 1 1 1 -0.1866878029416886 0.14037043613522485
		 0 0 -0.13721305152246274 9.7380903906067733 0.25597095598558789 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[82]" -type "matrix" "xform" 1 1 1 0.076061878457001644 -3.0615073704573665e-005
		 -0.0015365588199708585 0 -1.4988010832439613e-015 0.69453565267552142 0.23151188422517188 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[83]" -type "matrix" "xform" 1 1 1 0.00090854716449439662 0.036228543110265625
		 -0.0062187338945475738 0 0 0.99839500072104137 -0.057877971056292332 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[84]" -type "matrix" "xform" 1 1 1 0.13564807797628034 0.036395105874755029
		 -0.0046938443838825845 0 0 0.9888434627230307 -0.1363310589909778 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[85]" -type "matrix" "xform" 1 1 1 -0.13335996239229453 0.036850252823034939
		 0.0035906988403375095 0 0 0.92738575588463767 -0.23184643897115925 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[86]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 1.0317166534216575
		 0.023184643897115886 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[87]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0.73031628275915494
		 0.24343876091971728 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[88]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 2.1909488482774577
		 -0.034776965845674024 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[89]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[90]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[91]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.83456902614244988 0.53582086874198787
		 0.44172033864215532 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.99902385181107201 0.044174013996570879 -2.7047889107019663e-018 6.1170547827397186e-017 1
		 1 1 yes;
	setAttr ".xm[92]" -type "matrix" "xform" 1 1 1 -0.00052763365131497245 -0.37306582130489802
		 1.0286684836143296 0 1.3592537019895374 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.086442995181374244 0.99625679851335158 1 1 1 yes;
	setAttr ".xm[93]" -type "matrix" "xform" 1 1 1 0.076839442316872189 -0.093929521887347572
		 -0.35099992628861371 0 2.5418571195343049 -0.006032375056063799 0.24501988038357458 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.034956261742399186 0.0091101503537031527 0.021602341131483578 0.99911380922453896 
		-0.97077187319095881 0.10473160207468216 -0.022349300885391547 0.21478773358393075 1
		 1 1 yes;
	setAttr ".xm[94]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.307284791239784 -0.065729955176767163
		 0.04272427907392462 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.22409989583144074 0.97456617871150109 
		-0.81441294469351377 0.013004483096811806 -0.019507419132545303 0.57981195187216639 1
		 1 1 yes;
	setAttr ".xm[95]" -type "matrix" "xform" 1 1 1 1.0695781724430988 0.32232838480758869
		 -0.050425033763694831 0 1.1128676293715363 -0.52496285565207823 -0.00044339727633998529 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70040047352232249 0.12473473461879656 0.19155681742060909 0.6761556095818273 
		0.70040047352232193 -0.12473473461879622 -0.1915568174206089 0.67615560958182785 1
		 1 1 yes;
	setAttr ".xm[96]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.57429352821453694 -8.8817841970012523e-016
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.66935530239072027 0 0 0.74294244673556475 0.68383367793820438 -0.1063290797907166 -0.082096817945864278 0.71716507178719402 1
		 1 1 yes;
	setAttr ".xm[97]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.49509888943457359 -4.4408920985006262e-016
		 1.7763568394002505e-015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.64746121981572013 0.055869464551485795 -0.049677133210097167 0.75842254331045322 
		0.6885396271964509 -0.0312563843883778 0.082004414329674688 0.71986908271267303 1
		 1 1 yes;
	setAttr ".xm[98]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.34858895667837508 0.0010596661908348626
		 0.052552783674352455 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.34578308844610128 0.088145462652872306 0.2182550707325997 0.90831115662965123 
		-0.7045798973677132 -0.21776964310798963 -0.11730336252500936 0.66511914113656945 1
		 1 1 yes;
	setAttr ".xm[99]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.1998101875695184 -0.075396731140548567
		 0.069899469921770319 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.33536876566893958 0 0 0.94208693389394371 
		-0.39096156502921053 -0.036528186906496243 -0.20259167206762696 0.89709049746392788 1
		 1 1 yes;
	setAttr ".xm[100]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.13102606148260948
		 -3.4694469519536142e-018 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[101]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.52728301528726362
		 -0.16556458737019941 0.023069639961814659 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70483652908490768 0 0 0.70936976765826443 
		0.68086703470865517 -0.1180907818533255 -0.093800497028567825 0.71671201681394103 1
		 1 1 yes;
	setAttr ".xm[102]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.519470686330334 -2.2204460492503131e-016
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.72728277710409928 0.0051557760463958238 0.0021610512426274891 0.68631516809599613 
		0.68620827285171504 -0.012303916891170007 -0.020482535001583355 0.72701257599776803 1
		 1 1 yes;
	setAttr ".xm[103]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.42937322103465547
		 0.001946509011854225 0.0043886254798426449 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.76972815549142015 0.056966319541352409 0.11639103742837124 0.62508121991308951 
		-0.79310531375705418 -0.10778704600015442 -0.079815641637421303 0.59413414087636141 1
		 1 1 yes;
	setAttr ".xm[104]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.2121271698665943 -0.01268934683241052
		 0.054961645469704834 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24612227635743214 -0.0083838947881523761 0.10455269380541263 0.96354671376474987 
		-0.71915044960327446 -0.072895674886362255 -0.073772142975023006 0.68707097329107336 1
		 1 1 yes;
	setAttr ".xm[105]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.15482161384526361
		 -0.032549010579352902 0.0055895759787786027 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[106]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.50148092658209542
		 -0.26101540010281532 0.027036175636569126 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.7282124843233968 0 0 0.68535142640513025 
		0.6966995866934188 -0.1687323568521549 -0.13262500902113714 0.68450689159020139 1
		 1 1 yes;
	setAttr ".xm[107]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.49179229433794536
		 1.1102230246251565e-016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.7356843365976371 0 0 0.67732455801107239 
		0.6773231277459465 -0.0013919427629249118 -0.0015118756230140613 0.73568278309873048 1
		 1 1 yes;
	setAttr ".xm[108]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.50486179546997256
		 -0.0015706093498772389 -0.031750763177308627 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.9582449480520544 0 0 0.28594863093345213 
		-0.71796113780621951 -0.014715320833142431 0.014260727303340272 0.69578149989027172 1
		 1 1 yes;
	setAttr ".xm[109]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.21421454933437545
		 0.0051009394515002526 -0.0025116154134510182 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.6297650483423658 0 0 0.77678567435705048 
		-0.95728949220466786 0.0072482453272746435 -0.021950606049919087 0.28820558972415139 1
		 1 1 yes;
	setAttr ".xm[110]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.17874985588972053
		 -0.0020213469135811073 -0.021206271666157333 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[111]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.42968278283065153
		 -0.41369171018795114 0.032516807850246465 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70603545983934424 0 0 0.70817648185282578 
		0.66887009581691215 -0.19100995866019019 -0.16348355423182603 0.69957209643483975 1
		 1 1 yes;
	setAttr ".xm[112]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.48451976965278831
		 0.011200102029981063 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.69971527165018421 0 0 0.71442182120894715 
		0.71435404524039725 -0.009840562392459444 -0.0096379919862727287 0.69964889086666393 1
		 1 1 yes;
	setAttr ".xm[113]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.47690540690556738
		 -8.8817841970012523e-016 -0.017313328211077561 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70836205537911112 0 0 0.70584927463239711 
		-0.70521581295015634 0.029897419020658622 -0.030003852024974079 0.70772633861162526 1
		 1 1 yes;
	setAttr ".xm[114]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.20915883157004522
		 -1.8613953986512868e-015 -0.01746290845102294 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.72096313484372132 0 0 0.69297341810224888 
		0.69267440020930615 -0.020355183392401058 -0.021177344535227963 0.72065203939361455 1
		 1 1 yes;
	setAttr ".xm[115]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.1562213401163183 -1.7221620011693609e-016
		 0.019199623617376795 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[116]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.20024354094486352
		 -0.41690293609298523 -0.072466909117023803 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.86614663077636611 0.1075441558852442 -0.12998824553151744 0.47045438094816128 
		-0.34545885395049025 0.33812306401074493 -0.37850701143280074 0.78934366159956526 1
		 1 1 yes;
	setAttr ".xm[117]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.41235215348428422
		 -0.027979547161551821 0.14270147072016037 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.10494383075488879 -0.033773585340415684 0.065503923237450357 0.99174360263136818 
		-0.90060547232789079 0.074117752024628683 -0.11504946261569579 0.41252874227102293 1
		 1 1 yes;
	setAttr ".xm[118]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.32794328564462116
		 -0.045426562295176609 -0.017651779891603603 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.58045741328874345 -0.078418213787106533 0.031200256021499482 0.80990512970888962 
		-0.61169125909941946 0.092785135370422184 2.842836814008487e-005 0.78563650716313271 1
		 1 1 yes;
	setAttr ".xm[119]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.30224269846428747
		 -0.043408505886596969 -0.027840790032265972 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[120]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.83456900000000001
		 0.53583359604453307 0.44172033864215532 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.99902385181107201 0.044174013996570879 -2.7047889107019663e-018 6.1170547827397186e-017 1
		 1 1 yes;
	setAttr ".xm[121]" -type "matrix" "xform" 1 1 1 -0.17697806487599502 -0.40776282524291668
		 -1.0383995577897778 0 -1.3380755385325518 0.2390338126328988 -2.927319935288714e-017 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.086442995181374244 0.99625679851335158 1
		 1 1 yes;
	setAttr ".xm[122]" -type "matrix" "xform" 1 1 1 0.0037181402814836107 0.16842210469917748
		 -0.46579371821664894 0 -2.2051518408383819 1.264225034931318 0.24501999999999988 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.020959704557354953 -0.99911003193133674 -0.035024427647371743 -0.010635992995744539 
		-0.033940219739520966 -0.21329263623936873 0.96484152329508099 0.14978366978987082 1
		 1 1 yes;
	setAttr ".xm[123]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.2532959269244293
		 -0.044227867215052383 0.023516268042740273 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.18901643602377649 -0.68482393715756207 0.69293978411028712 -0.12297730524805756 
		-0.006332732584311291 -0.16103908272832931 -0.98666797180330301 0.022641195851597573 1
		 1 1 yes;
	setAttr ".xm[124]" -type "matrix" "xform" 1 1 1 1.4233931625304499 -0.31323678958634144
		 0.21098633663298241 0 -1.1052804492770898 0.52823902992619987 -0.11506647845685158 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70040047352232249 0.12473473461879656 0.19155681742060909 0.6761556095818273 
		0.70040047352232193 -0.12473473461879622 -0.1915568174206089 0.67615560958182785 1
		 1 1 yes;
	setAttr ".xm[125]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.35589835433784334
		 0.44812176047702179 -0.048348856972939558 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.65632275852153033 0.1458922075921453 -0.13144184069489304 0.72847713960378868 
		0.65439781748773229 -0.24508910513019552 -0.21478333982555853 0.68232173052538136 1
		 1 1 yes;
	setAttr ".xm[126]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.46253575628156796
		 -0.17559123777133206 -0.018741679966538527 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.75628705474648661 0.020766357721260814 -0.10254147744042058 0.64582032688218549 
		-0.719493647222612 -0.06147379720522058 0.1282390156697934 0.67978277318825708 1 1
		 1 yes;
	setAttr ".xm[127]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.34279401479564342
		 -0.06333273214763846 0.052599999999994651 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.30237682810487454 0.18948303530091631 0.48508509798151039 0.79834634142999317 
		-0.60448570632492171 -0.42243754577800119 -0.31472102988657813 0.59757361396990349 1
		 1 1 yes;
	setAttr ".xm[128]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.1990896714782302
		 -0.069846492593438114 0.077258273758128659 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.30944310385734186 0.12929491274386004 -0.36320331642091669 0.8692589613886873 
		-0.37482103814765572 0.11702325893034735 0.15892547914048555 0.90584625533873109 1
		 1 1 yes;
	setAttr ".xm[129]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.088578324023224297
		 -0.06308355259578402 -0.073161379874441046 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[130]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.45790440974189295
		 0.30905005580565748 -0.028166502186969922 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.6980644937484084 0.098097377071038355 0.097470484251583181 0.70255417718445212 
		0.66135380728729143 -0.21606889387004677 -0.18705505548465406 0.69349533589348078 1
		 1 1 yes;
	setAttr ".xm[131]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.49660541623315257
		 0.15241190389500403 -3.907985046680551e-014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.72440651413592227 0.068176522769285514 -0.06465377245114344 0.68294000741526828 
		0.68142570088586008 -0.079032766575866151 -0.083428664992549181 0.72280875329310978 1
		 1 1 yes;
	setAttr ".xm[132]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.42004231545825377
		 -0.089062259534905985 0.0044000000000004036 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.72555611502819461 0.093278601611007109 0.07159389797799115 0.67804257993064521 
		-0.74955966408868913 -0.13954159187626017 -0.030315340626920109 0.64635086000605324 1
		 1 1 yes;
	setAttr ".xm[133]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.21220867636123586
		 -0.0095014420808934297 0.055256207835824966 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.19810745653217973 -0.003196371703289614 0.10483958547095457 0.97455214339334528 
		-0.68424585380567615 -0.076459296192645826 -0.070071995276221044 0.72183897307742784 1
		 1 1 yes;
	setAttr ".xm[134]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.15416045097562936
		 -0.025066941230322826 0.0258792042448448 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[135]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.51672187085454979
		 0.22950497900524613 -0.025917007782060963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.7282124843233968 0 0 0.68535142640513025 
		0.6966995866934188 -0.1687323568521549 -0.13262500902113714 0.68450689159020139 1
		 1 1 yes;
	setAttr ".xm[136]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.49145333854620787
		 0.018343501868121975 3.5527136788005009e-015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.7356843365976371 0 0 0.67732455801107239 
		0.6773231277459465 -0.0013919427629249118 -0.0015118756230140613 0.73568278309873048 1
		 1 1 yes;
	setAttr ".xm[137]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.50459698033256295
		 -0.016253535254100754 -0.031700000000029149 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.95791808692773561 -0.0074680866332738245 0.025026370172113777 0.28585109272968245 
		-0.71808868416682736 0.0034613419052125461 -0.0044950433561614022 0.69592848437824106 1
		 1 1 yes;
	setAttr ".xm[138]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.21365372315480791
		 0.011567175381934192 -0.011798069832568814 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.6297650483423658 0 0 0.77678567435705048 
		-0.95728949220466786 0.0072482453272746435 -0.021950606049919087 0.28820558972415139 1
		 1 1 yes;
	setAttr ".xm[139]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.17853842431281919
		 0.0049398764463211009 -0.022463270478496611 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[140]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.59182717085413916
		 0.078421389866687008 -0.020608344384106303 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70429559157602339 -0.049685962075224285 -0.04953574706344397 0.70643133751420251 
		0.67869188882011733 -0.14145698210763641 -0.11615247579013559 0.71124949534646653 1
		 1 1 yes;
	setAttr ".xm[141]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.48263429021434323
		 -0.044171274212376821 -1.7763568394002505e-015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.69785492474624766 -0.052061555711997616 0.050989855735240001 0.71252237370931382 
		0.71315712050636082 0.041170619321802313 0.04244424945644925 0.69850582478875134 1
		 1 1 yes;
	setAttr ".xm[142]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.47006863504395113
		 0.080437974559275371 -0.017299999999998761 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.70833288501612757 -0.0064056878471105772 -0.006428491708600775 0.7058202077457737 
		-0.70491448270019053 0.036318910328128139 -0.03640255555327649 0.70742587087361364 1
		 1 1 yes;
	setAttr ".xm[143]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.2091599999999989
		 -1.6357231180139953e-015 -0.017500000000000071 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.71948465855991417 -0.044356723626598052 0.046148325003297748 0.6915523402212066 
		0.69260948191802452 0.025814970912838811 0.023203667471590663 0.72047712153119936 1
		 1 1 yes;
	setAttr ".xm[144]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.155142196743288 0.018315459130345935
		 0.019199999999999662 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[145]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.44330151768877002
		 -0.10687493945020998 -0.10594570403329051 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.84686363774442053 0.055723452025002715 -0.2234477770037091 0.47936204158527701 
		-0.30222925060937589 0.42199152417327557 -0.41384400146996447 0.74787283414317107 1
		 1 1 yes;
	setAttr ".xm[146]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.12889146458819667
		 0.3926900863784093 0.1426999999999552 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.37759593771475053 0.60917493407943213 0.2492029012625816 0.65132566471232312 
		-0.81267002905520758 -0.43077508867062025 0.38736467414673359 0.062839924247427209 1
		 1 1 yes;
	setAttr ".xm[147]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.21920706243557131
		 -0.15607088119624457 0.19366611263975742 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.55874149405216289 0.19076822914507369 -0.16035026486421086 0.79101404420603505 
		-0.57804463207039514 -0.16925446049035062 0.2000764868779116 0.77277857781987891 1
		 1 1 yes;
	setAttr ".xm[148]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.23703433926306694
		 -0.14273690430118968 0.13211286251396359 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[149]" -type "matrix" "xform" 1 1 1 -0.27523066624759496 -0.25745925078068049
		 -0.13748964658387333 0 0.97317755218018942 -0.26666870930448106 0.24717675384889515 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[150]" -type "matrix" "xform" 1 1 1 0.29721754878174084 0.044076104625726614
		 -0.00034649622012275624 0 0.80047444166064252 -5.4795207364920104 0.13034245823066326 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.026913343775936002 0 0 0.99963777035824242 1
		 1 1 yes;
	setAttr ".xm[151]" -type "matrix" "xform" 1 1 1 -0.52469409796180333 0.079227864531252565
		 0.12225818331047762 0 0.57244561326531684 -3.9226395517758235 -0.42522582843455226 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[152]" -type "matrix" "xform" 1 1 1 -1.1114392923361612e-023 1.1114392201452297e-023
		 -9.2594575196850162e-008 0 0 -0.50688733756369087 1.0825402805267139 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[153]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 -5.5511151231257827e-017
		 0.81101974010190558 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[154]" -type "matrix" "xform" 1 1 1 0.42338471339930528 -0.22647262811479571
		 0.054906318623880151 0 -0.97317799999999999 -0.26670653195125027 0.24717675384889515 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[155]" -type "matrix" "xform" 1 1 1 0.39294628087596933 -0.057277613938281229
		 0.00044563024117408035 0 -0.80047199999999996 -5.4794800000000006 0.13034200000000001 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.026913343775936002 0 0 0.99963777035824242 1
		 1 1 yes;
	setAttr ".xm[156]" -type "matrix" "xform" 1 1 1 -0.1279949173067986 -0.036665333020923251
		 -0.084292960707540263 0 -0.5724499999999999 -3.9226420000000002 -0.42522500000000002 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[157]" -type "matrix" "xform" 1 1 1 -0.48896104986372874 0.0017815379558018623
		 0.0084113852371059464 0 0 -0.50688799999999978 1.0825400000000001 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[158]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 -5.5511151231257827e-017
		 0.81102300000000005 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr -s 144 ".m";
	setAttr -s 159 ".p";
select -ne :time1;
	setAttr -k on ".o" 0;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr -k on ".cch";
	setAttr -k on ".nds";
	setAttr -k on ".mwc";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr -k on ".cch";
	setAttr -k on ".nds";
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
connectAttr "hips.s" "spine.is";
connectAttr "spine.s" "spine1.is";
connectAttr "spine1.s" "xxy.is";
connectAttr "xxy.s" "xxx.is";
connectAttr "xxx.s" "neck.is";
connectAttr "neck.s" "head.is";
connectAttr "head.s" "joint44.is";
connectAttr "xxx.s" "leftShoulder.is";
connectAttr "leftShoulder.s" "leftArm.is";
connectAttr "leftArm.s" "leftForearm.is";
connectAttr "leftForearm.s" "leftForeArmRoll.is";
connectAttr "leftForeArmRoll.s" "leftHand.is";
connectAttr "leftHand.s" "joint13.is";
connectAttr "joint13.s" "leftHandPinky1.is";
connectAttr "leftHandPinky1.s" "leftHandPinky2.is";
connectAttr "leftHandPinky2.s" "leftHandPinky3.is";
connectAttr "leftHandPinky3.s" "leftHandPinky4.is";
connectAttr "leftHand.s" "joint18.is";
connectAttr "joint18.s" "leftHandRing1.is";
connectAttr "leftHandRing1.s" "leftHandRing2.is";
connectAttr "leftHandRing2.s" "leftHandRing3.is";
connectAttr "leftHandRing3.s" "leftHandRing4.is";
connectAttr "leftHand.s" "joint23.is";
connectAttr "joint23.s" "leftHandMiddle1.is";
connectAttr "leftHandMiddle1.s" "leftHandMiddle2.is";
connectAttr "leftHandMiddle2.s" "leftHandMiddle3.is";
connectAttr "leftHandMiddle3.s" "leftHandMiddle4.is";
connectAttr "leftHand.s" "joint28.is";
connectAttr "joint28.s" "leftHandIndex1.is";
connectAttr "leftHandIndex1.s" "leftHandIndex2.is";
connectAttr "leftHandIndex2.s" "leftHandIndex3.is";
connectAttr "leftHandIndex3.s" "leftHandIndex4.is";
connectAttr "leftHand.s" "leftHandThumb1.is";
connectAttr "leftHandThumb1.s" "leftHandThumb2.is";
connectAttr "leftHandThumb2.s" "leftHandThumb3.is";
connectAttr "leftHandThumb3.s" "leftHandThumb4.is";
connectAttr "xxx.s" "rightShoulder.is";
connectAttr "rightShoulder.s" "rightArm.is";
connectAttr "rightArm.s" "rightForeArm.is";
connectAttr "rightForeArm.s" "rightForeArmRoll.is";
connectAttr "rightForeArmRoll.s" "rightHand.is";
connectAttr "rightHand.s" "joint57.is";
connectAttr "joint57.s" "rightHandPinky1.is";
connectAttr "rightHandPinky1.s" "rightHandPinky2.is";
connectAttr "rightHandPinky2.s" "rightHandPinky3.is";
connectAttr "rightHandPinky3.s" "rightHandPinky4.is";
connectAttr "rightHand.s" "joint62.is";
connectAttr "joint62.s" "rightHandRing1.is";
connectAttr "rightHandRing1.s" "rightHandRing2.is";
connectAttr "rightHandRing2.s" "rightHandRing3.is";
connectAttr "rightHandRing3.s" "rightHandRing4.is";
connectAttr "rightHand.s" "joint67.is";
connectAttr "joint67.s" "rightHandMiddle1.is";
connectAttr "rightHandMiddle1.s" "rightHandMiddle2.is";
connectAttr "rightHandMiddle2.s" "rightHandMiddle3.is";
connectAttr "rightHandMiddle3.s" "rightHandMiddle4.is";
connectAttr "rightHand.s" "joint72.is";
connectAttr "joint72.s" "rightHandIndex1.is";
connectAttr "rightHandIndex1.s" "rightHandIndex2.is";
connectAttr "rightHandIndex2.s" "rightHandIndex3.is";
connectAttr "rightHandIndex3.s" "rightHandIndex4.is";
connectAttr "rightHand.s" "rightHandThumb1.is";
connectAttr "rightHandThumb1.s" "rightHandThumb2.is";
connectAttr "rightHandThumb2.s" "rightHandThumb3.is";
connectAttr "rightHandThumb3.s" "rightHandThumb4.is";
connectAttr "hips.s" "leftUpLeg.is";
connectAttr "leftUpLeg.s" "leftLeg.is";
connectAttr "leftLeg.s" "leftFoot.is";
connectAttr "leftFoot.s" "joint86.is";
connectAttr "joint86.s" "leftFootIndex1.is";
connectAttr "leftFootIndex1.s" "leftFootIndex2.is";
connectAttr "hips.s" "rightUpLeg.is";
connectAttr "rightUpLeg.s" "rightLeg.is";
connectAttr "rightLeg.s" "rightFoot.is";
connectAttr "rightFoot.s" "joint87.is";
connectAttr "joint87.s" "rightFootIndex1.is";
connectAttr "rightFootIndex1.s" "rightFootIndex2.is";
connectAttr ":time1.o" "hikHandle1.tim";
connectAttr "hips.msg" "hikHandle1.jt[0]";
connectAttr "spine.msg" "hikHandle1.jt[1]";
connectAttr "spine1.msg" "hikHandle1.jt[2]";
connectAttr "neck.msg" "hikHandle1.jt[3]";
connectAttr "head.msg" "hikHandle1.jt[4]";
connectAttr "leftShoulder.msg" "hikHandle1.jt[5]";
connectAttr "leftArm.msg" "hikHandle1.jt[6]";
connectAttr "leftForearm.msg" "hikHandle1.jt[7]";
connectAttr "leftForeArmRoll.msg" "hikHandle1.jt[8]";
connectAttr "leftHand.msg" "hikHandle1.jt[9]";
connectAttr "leftHandPinky1.msg" "hikHandle1.jt[10]";
connectAttr "leftHandPinky2.msg" "hikHandle1.jt[11]";
connectAttr "leftHandPinky3.msg" "hikHandle1.jt[12]";
connectAttr "leftHandPinky4.msg" "hikHandle1.jt[13]";
connectAttr "leftHandRing1.msg" "hikHandle1.jt[14]";
connectAttr "leftHandRing2.msg" "hikHandle1.jt[15]";
connectAttr "leftHandRing3.msg" "hikHandle1.jt[16]";
connectAttr "leftHandRing4.msg" "hikHandle1.jt[17]";
connectAttr "joint23.msg" "hikHandle1.jt[18]";
connectAttr "leftHandMiddle1.msg" "hikHandle1.jt[19]";
connectAttr "leftHandMiddle2.msg" "hikHandle1.jt[20]";
connectAttr "leftHandMiddle3.msg" "hikHandle1.jt[21]";
connectAttr "leftHandMiddle4.msg" "hikHandle1.jt[22]";
connectAttr "leftHandIndex1.msg" "hikHandle1.jt[23]";
connectAttr "leftHandIndex2.msg" "hikHandle1.jt[24]";
connectAttr "leftHandIndex3.msg" "hikHandle1.jt[25]";
connectAttr "leftHandIndex4.msg" "hikHandle1.jt[26]";
connectAttr "leftHandThumb1.msg" "hikHandle1.jt[27]";
connectAttr "leftHandThumb2.msg" "hikHandle1.jt[28]";
connectAttr "leftHandThumb3.msg" "hikHandle1.jt[29]";
connectAttr "leftHandThumb4.msg" "hikHandle1.jt[30]";
connectAttr "rightShoulder.msg" "hikHandle1.jt[31]";
connectAttr "rightArm.msg" "hikHandle1.jt[32]";
connectAttr "rightForeArm.msg" "hikHandle1.jt[33]";
connectAttr "rightForeArmRoll.msg" "hikHandle1.jt[34]";
connectAttr "rightHand.msg" "hikHandle1.jt[35]";
connectAttr "rightHandPinky1.msg" "hikHandle1.jt[36]";
connectAttr "rightHandPinky2.msg" "hikHandle1.jt[37]";
connectAttr "rightHandPinky3.msg" "hikHandle1.jt[38]";
connectAttr "rightHandPinky4.msg" "hikHandle1.jt[39]";
connectAttr "rightHandRing1.msg" "hikHandle1.jt[40]";
connectAttr "rightHandRing2.msg" "hikHandle1.jt[41]";
connectAttr "rightHandRing3.msg" "hikHandle1.jt[42]";
connectAttr "rightHandRing4.msg" "hikHandle1.jt[43]";
connectAttr "joint67.msg" "hikHandle1.jt[44]";
connectAttr "rightHandMiddle1.msg" "hikHandle1.jt[45]";
connectAttr "rightHandMiddle2.msg" "hikHandle1.jt[46]";
connectAttr "rightHandMiddle3.msg" "hikHandle1.jt[47]";
connectAttr "rightHandMiddle4.msg" "hikHandle1.jt[48]";
connectAttr "rightHandIndex1.msg" "hikHandle1.jt[49]";
connectAttr "rightHandIndex2.msg" "hikHandle1.jt[50]";
connectAttr "rightHandIndex3.msg" "hikHandle1.jt[51]";
connectAttr "rightHandIndex4.msg" "hikHandle1.jt[52]";
connectAttr "rightHandThumb1.msg" "hikHandle1.jt[53]";
connectAttr "rightHandThumb2.msg" "hikHandle1.jt[54]";
connectAttr "rightHandThumb3.msg" "hikHandle1.jt[55]";
connectAttr "rightHandThumb4.msg" "hikHandle1.jt[56]";
connectAttr "leftUpLeg.msg" "hikHandle1.jt[57]";
connectAttr "leftLeg.msg" "hikHandle1.jt[58]";
connectAttr "leftFoot.msg" "hikHandle1.jt[59]";
connectAttr "joint86.msg" "hikHandle1.jt[60]";
connectAttr "leftFootIndex1.msg" "hikHandle1.jt[61]";
connectAttr "leftFootIndex2.msg" "hikHandle1.jt[62]";
connectAttr "rightUpLeg.msg" "hikHandle1.jt[63]";
connectAttr "rightLeg.msg" "hikHandle1.jt[64]";
connectAttr "rightFoot.msg" "hikHandle1.jt[65]";
connectAttr "joint87.msg" "hikHandle1.jt[66]";
connectAttr "rightFootIndex1.msg" "hikHandle1.jt[67]";
connectAttr "rightFootIndex2.msg" "hikHandle1.jt[68]";
connectAttr "hipsFK.msg" "hikHandle1.fj[0]";
connectAttr "spineFK.msg" "hikHandle1.fj[1]";
connectAttr "spine1FK.msg" "hikHandle1.fj[2]";
connectAttr "neckFK.msg" "hikHandle1.fj[3]";
connectAttr "headFK.msg" "hikHandle1.fj[4]";
connectAttr "leftShoulderFK.msg" "hikHandle1.fj[5]";
connectAttr "leftArmFK.msg" "hikHandle1.fj[6]";
connectAttr "leftForearmFK.msg" "hikHandle1.fj[7]";
connectAttr "leftForeArmRollFK.msg" "hikHandle1.fj[8]";
connectAttr "leftHandFK.msg" "hikHandle1.fj[9]";
connectAttr "leftHandPinky1FK.msg" "hikHandle1.fj[10]";
connectAttr "leftHandPinky2FK.msg" "hikHandle1.fj[11]";
connectAttr "leftHandPinky3FK.msg" "hikHandle1.fj[12]";
connectAttr "leftHandPinky4FK.msg" "hikHandle1.fj[13]";
connectAttr "leftHandRing1FK.msg" "hikHandle1.fj[14]";
connectAttr "leftHandRing2FK.msg" "hikHandle1.fj[15]";
connectAttr "leftHandRing3FK.msg" "hikHandle1.fj[16]";
connectAttr "leftHandRing4FK.msg" "hikHandle1.fj[17]";
connectAttr "joint23FK.msg" "hikHandle1.fj[18]";
connectAttr "leftHandMiddle1FK.msg" "hikHandle1.fj[19]";
connectAttr "leftHandMiddle2FK.msg" "hikHandle1.fj[20]";
connectAttr "leftHandMiddle3FK.msg" "hikHandle1.fj[21]";
connectAttr "leftHandMiddle4FK.msg" "hikHandle1.fj[22]";
connectAttr "leftHandIndex1FK.msg" "hikHandle1.fj[23]";
connectAttr "leftHandIndex2FK.msg" "hikHandle1.fj[24]";
connectAttr "leftHandIndex3FK.msg" "hikHandle1.fj[25]";
connectAttr "leftHandIndex4FK.msg" "hikHandle1.fj[26]";
connectAttr "leftHandThumb1FK.msg" "hikHandle1.fj[27]";
connectAttr "leftHandThumb2FK.msg" "hikHandle1.fj[28]";
connectAttr "leftHandThumb3FK.msg" "hikHandle1.fj[29]";
connectAttr "leftHandThumb4FK.msg" "hikHandle1.fj[30]";
connectAttr "rightShoulderFK.msg" "hikHandle1.fj[31]";
connectAttr "rightArmFK.msg" "hikHandle1.fj[32]";
connectAttr "rightForeArmFK.msg" "hikHandle1.fj[33]";
connectAttr "rightForeArmRollFK.msg" "hikHandle1.fj[34]";
connectAttr "rightHandFK.msg" "hikHandle1.fj[35]";
connectAttr "rightHandPinky1FK.msg" "hikHandle1.fj[36]";
connectAttr "rightHandPinky2FK.msg" "hikHandle1.fj[37]";
connectAttr "rightHandPinky3FK.msg" "hikHandle1.fj[38]";
connectAttr "rightHandPinky4FK.msg" "hikHandle1.fj[39]";
connectAttr "rightHandRing1FK.msg" "hikHandle1.fj[40]";
connectAttr "rightHandRing2FK.msg" "hikHandle1.fj[41]";
connectAttr "rightHandRing3FK.msg" "hikHandle1.fj[42]";
connectAttr "rightHandRing4FK.msg" "hikHandle1.fj[43]";
connectAttr "joint67FK.msg" "hikHandle1.fj[44]";
connectAttr "rightHandMiddle1FK.msg" "hikHandle1.fj[45]";
connectAttr "rightHandMiddle2FK.msg" "hikHandle1.fj[46]";
connectAttr "rightHandMiddle3FK.msg" "hikHandle1.fj[47]";
connectAttr "rightHandMiddle4FK.msg" "hikHandle1.fj[48]";
connectAttr "rightHandIndex1FK.msg" "hikHandle1.fj[49]";
connectAttr "rightHandIndex2FK.msg" "hikHandle1.fj[50]";
connectAttr "rightHandIndex3FK.msg" "hikHandle1.fj[51]";
connectAttr "rightHandIndex4FK.msg" "hikHandle1.fj[52]";
connectAttr "rightHandThumb1FK.msg" "hikHandle1.fj[53]";
connectAttr "rightHandThumb2FK.msg" "hikHandle1.fj[54]";
connectAttr "rightHandThumb3FK.msg" "hikHandle1.fj[55]";
connectAttr "rightHandThumb4FK.msg" "hikHandle1.fj[56]";
connectAttr "leftUpLegFK.msg" "hikHandle1.fj[57]";
connectAttr "leftLegFK.msg" "hikHandle1.fj[58]";
connectAttr "leftFootFK.msg" "hikHandle1.fj[59]";
connectAttr "joint86FK.msg" "hikHandle1.fj[60]";
connectAttr "leftFootIndex1FK.msg" "hikHandle1.fj[61]";
connectAttr "leftFootIndex2FK.msg" "hikHandle1.fj[62]";
connectAttr "rightUpLegFK.msg" "hikHandle1.fj[63]";
connectAttr "rightLegFK.msg" "hikHandle1.fj[64]";
connectAttr "rightFootFK.msg" "hikHandle1.fj[65]";
connectAttr "joint87FK.msg" "hikHandle1.fj[66]";
connectAttr "rightFootIndex1FK.msg" "hikHandle1.fj[67]";
connectAttr "rightFootIndex2FK.msg" "hikHandle1.fj[68]";
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
connectAttr "LeftHandThumb1Eff.ha" "hikHandle1.eff[19]";
connectAttr "LeftHandIndex1Eff.ha" "hikHandle1.eff[20]";
connectAttr "LeftHandMiddle1Eff.ha" "hikHandle1.eff[21]";
connectAttr "LeftHandRing1Eff.ha" "hikHandle1.eff[22]";
connectAttr "LeftHandPinky1Eff.ha" "hikHandle1.eff[23]";
connectAttr "RightHandThumb1Eff.ha" "hikHandle1.eff[24]";
connectAttr "RightHandIndex1Eff.ha" "hikHandle1.eff[25]";
connectAttr "RightHandMiddle1Eff.ha" "hikHandle1.eff[26]";
connectAttr "RightHandRing1Eff.ha" "hikHandle1.eff[27]";
connectAttr "RightHandPinky1Eff.ha" "hikHandle1.eff[28]";
connectAttr "LeftFootIndex1Eff.ha" "hikHandle1.eff[29]";
connectAttr "RightFootIndex1Eff.ha" "hikHandle1.eff[30]";
connectAttr "NeckEff.ha" "hikHandle1.eff[31]";
connectAttr "RightFootEffPivot.ha" "hikHandle1.eff[36]";
connectAttr "RightFootEffPivot1.ha" "hikHandle1.eff[37]";
connectAttr "LeftFootEffPivot1.ha" "hikHandle1.eff[38]";
connectAttr "LeftFootEffPivot.ha" "hikHandle1.eff[39]";
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
connectAttr "leftFootIndex1.msg" "LeftFootIndex1Eff.jt";
connectAttr "leftFootIndex1FK.msg" "LeftFootIndex1Eff.fj";
connectAttr "_leftFootIndex.uv[7]" "LeftFootIndex1Eff.rr";
connectAttr "_leftFootIndex.uv[8]" "LeftFootIndex1Eff.rt";
connectAttr "_leftFootIndex.av[7]" "LeftFootIndex1Eff.rz";
connectAttr "_leftFootIndex.av[8]" "LeftFootIndex1Eff.ry";
connectAttr "_leftFootIndex.av[9]" "LeftFootIndex1Eff.rx";
connectAttr "_leftFootIndex.lv[7]" "LeftFootIndex1Eff.tz";
connectAttr "_leftFootIndex.lv[8]" "LeftFootIndex1Eff.ty";
connectAttr "_leftFootIndex.lv[9]" "LeftFootIndex1Eff.tx";
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
connectAttr "rightFootIndex1.msg" "RightFootIndex1Eff.jt";
connectAttr "rightFootIndex1FK.msg" "RightFootIndex1Eff.fj";
connectAttr "_rightFootIndex.uv[7]" "RightFootIndex1Eff.rr";
connectAttr "_rightFootIndex.uv[8]" "RightFootIndex1Eff.rt";
connectAttr "_rightFootIndex.av[7]" "RightFootIndex1Eff.rz";
connectAttr "_rightFootIndex.av[8]" "RightFootIndex1Eff.ry";
connectAttr "_rightFootIndex.av[9]" "RightFootIndex1Eff.rx";
connectAttr "_rightFootIndex.lv[7]" "RightFootIndex1Eff.tz";
connectAttr "_rightFootIndex.lv[8]" "RightFootIndex1Eff.ty";
connectAttr "_rightFootIndex.lv[9]" "RightFootIndex1Eff.tx";
connectAttr "leftHand.msg" "LeftHandEff.jt";
connectAttr "leftHandFK.msg" "LeftHandEff.fj";
connectAttr "_leftArm.uv[19]" "LeftHandEff.rr";
connectAttr "_leftArm.uv[20]" "LeftHandEff.rt";
connectAttr "_leftArm.av[19]" "LeftHandEff.rz";
connectAttr "_leftArm.av[20]" "LeftHandEff.ry";
connectAttr "_leftArm.av[21]" "LeftHandEff.rx";
connectAttr "_leftArm.lv[19]" "LeftHandEff.tz";
connectAttr "_leftArm.lv[20]" "LeftHandEff.ty";
connectAttr "_leftArm.lv[21]" "LeftHandEff.tx";
connectAttr "leftHandThumb1.msg" "LeftHandThumb1Eff.jt";
connectAttr "leftHandThumb1FK.msg" "LeftHandThumb1Eff.fj";
connectAttr "_leftThumb.uv[13]" "LeftHandThumb1Eff.rr";
connectAttr "_leftThumb.uv[14]" "LeftHandThumb1Eff.rt";
connectAttr "_leftThumb.av[13]" "LeftHandThumb1Eff.rz";
connectAttr "_leftThumb.av[14]" "LeftHandThumb1Eff.ry";
connectAttr "_leftThumb.av[15]" "LeftHandThumb1Eff.rx";
connectAttr "_leftThumb.lv[13]" "LeftHandThumb1Eff.tz";
connectAttr "_leftThumb.lv[14]" "LeftHandThumb1Eff.ty";
connectAttr "_leftThumb.lv[15]" "LeftHandThumb1Eff.tx";
connectAttr "leftHandIndex1.msg" "LeftHandIndex1Eff.jt";
connectAttr "leftHandIndex1FK.msg" "LeftHandIndex1Eff.fj";
connectAttr "_leftFingerIndex.uv[13]" "LeftHandIndex1Eff.rr";
connectAttr "_leftFingerIndex.uv[14]" "LeftHandIndex1Eff.rt";
connectAttr "_leftFingerIndex.av[13]" "LeftHandIndex1Eff.rz";
connectAttr "_leftFingerIndex.av[14]" "LeftHandIndex1Eff.ry";
connectAttr "_leftFingerIndex.av[15]" "LeftHandIndex1Eff.rx";
connectAttr "_leftFingerIndex.lv[13]" "LeftHandIndex1Eff.tz";
connectAttr "_leftFingerIndex.lv[14]" "LeftHandIndex1Eff.ty";
connectAttr "_leftFingerIndex.lv[15]" "LeftHandIndex1Eff.tx";
connectAttr "leftHandMiddle1.msg" "LeftHandMiddle1Eff.jt";
connectAttr "leftHandMiddle1FK.msg" "LeftHandMiddle1Eff.fj";
connectAttr "_leftFingerMiddle.uv[13]" "LeftHandMiddle1Eff.rr";
connectAttr "_leftFingerMiddle.uv[14]" "LeftHandMiddle1Eff.rt";
connectAttr "_leftFingerMiddle.av[13]" "LeftHandMiddle1Eff.rz";
connectAttr "_leftFingerMiddle.av[14]" "LeftHandMiddle1Eff.ry";
connectAttr "_leftFingerMiddle.av[15]" "LeftHandMiddle1Eff.rx";
connectAttr "_leftFingerMiddle.lv[13]" "LeftHandMiddle1Eff.tz";
connectAttr "_leftFingerMiddle.lv[14]" "LeftHandMiddle1Eff.ty";
connectAttr "_leftFingerMiddle.lv[15]" "LeftHandMiddle1Eff.tx";
connectAttr "leftHandRing1.msg" "LeftHandRing1Eff.jt";
connectAttr "leftHandRing1FK.msg" "LeftHandRing1Eff.fj";
connectAttr "_leftFingerRing.uv[13]" "LeftHandRing1Eff.rr";
connectAttr "_leftFingerRing.uv[14]" "LeftHandRing1Eff.rt";
connectAttr "_leftFingerRing.av[13]" "LeftHandRing1Eff.rz";
connectAttr "_leftFingerRing.av[14]" "LeftHandRing1Eff.ry";
connectAttr "_leftFingerRing.av[15]" "LeftHandRing1Eff.rx";
connectAttr "_leftFingerRing.lv[13]" "LeftHandRing1Eff.tz";
connectAttr "_leftFingerRing.lv[14]" "LeftHandRing1Eff.ty";
connectAttr "_leftFingerRing.lv[15]" "LeftHandRing1Eff.tx";
connectAttr "leftHandPinky1.msg" "LeftHandPinky1Eff.jt";
connectAttr "leftHandPinky1FK.msg" "LeftHandPinky1Eff.fj";
connectAttr "_leftFingerPinky.uv[13]" "LeftHandPinky1Eff.rr";
connectAttr "_leftFingerPinky.uv[14]" "LeftHandPinky1Eff.rt";
connectAttr "_leftFingerPinky.av[13]" "LeftHandPinky1Eff.rz";
connectAttr "_leftFingerPinky.av[14]" "LeftHandPinky1Eff.ry";
connectAttr "_leftFingerPinky.av[15]" "LeftHandPinky1Eff.rx";
connectAttr "_leftFingerPinky.lv[13]" "LeftHandPinky1Eff.tz";
connectAttr "_leftFingerPinky.lv[14]" "LeftHandPinky1Eff.ty";
connectAttr "_leftFingerPinky.lv[15]" "LeftHandPinky1Eff.tx";
connectAttr "_rightArm.av[19]" "RightHandEff.rz";
connectAttr "_rightArm.av[20]" "RightHandEff.ry";
connectAttr "_rightArm.av[21]" "RightHandEff.rx";
connectAttr "rightHand.msg" "RightHandEff.jt";
connectAttr "rightHandFK.msg" "RightHandEff.fj";
connectAttr "_rightArm.uv[19]" "RightHandEff.rr";
connectAttr "_rightArm.uv[20]" "RightHandEff.rt";
connectAttr "_rightArm.lv[19]" "RightHandEff.tz";
connectAttr "_rightArm.lv[20]" "RightHandEff.ty";
connectAttr "_rightArm.lv[21]" "RightHandEff.tx";
connectAttr "rightHandThumb1.msg" "RightHandThumb1Eff.jt";
connectAttr "rightHandThumb1FK.msg" "RightHandThumb1Eff.fj";
connectAttr "_rightThumb.uv[13]" "RightHandThumb1Eff.rr";
connectAttr "_rightThumb.uv[14]" "RightHandThumb1Eff.rt";
connectAttr "_rightThumb.av[13]" "RightHandThumb1Eff.rz";
connectAttr "_rightThumb.av[14]" "RightHandThumb1Eff.ry";
connectAttr "_rightThumb.av[15]" "RightHandThumb1Eff.rx";
connectAttr "_rightThumb.lv[13]" "RightHandThumb1Eff.tz";
connectAttr "_rightThumb.lv[14]" "RightHandThumb1Eff.ty";
connectAttr "_rightThumb.lv[15]" "RightHandThumb1Eff.tx";
connectAttr "rightHandIndex1.msg" "RightHandIndex1Eff.jt";
connectAttr "rightHandIndex1FK.msg" "RightHandIndex1Eff.fj";
connectAttr "_rightFingerIndex.uv[13]" "RightHandIndex1Eff.rr";
connectAttr "_rightFingerIndex.uv[14]" "RightHandIndex1Eff.rt";
connectAttr "_rightFingerIndex.av[13]" "RightHandIndex1Eff.rz";
connectAttr "_rightFingerIndex.av[14]" "RightHandIndex1Eff.ry";
connectAttr "_rightFingerIndex.av[15]" "RightHandIndex1Eff.rx";
connectAttr "_rightFingerIndex.lv[13]" "RightHandIndex1Eff.tz";
connectAttr "_rightFingerIndex.lv[14]" "RightHandIndex1Eff.ty";
connectAttr "_rightFingerIndex.lv[15]" "RightHandIndex1Eff.tx";
connectAttr "rightHandMiddle1.msg" "RightHandMiddle1Eff.jt";
connectAttr "rightHandMiddle1FK.msg" "RightHandMiddle1Eff.fj";
connectAttr "_rightFingerMiddle.uv[13]" "RightHandMiddle1Eff.rr";
connectAttr "_rightFingerMiddle.uv[14]" "RightHandMiddle1Eff.rt";
connectAttr "_rightFingerMiddle.av[13]" "RightHandMiddle1Eff.rz";
connectAttr "_rightFingerMiddle.av[14]" "RightHandMiddle1Eff.ry";
connectAttr "_rightFingerMiddle.av[15]" "RightHandMiddle1Eff.rx";
connectAttr "_rightFingerMiddle.lv[13]" "RightHandMiddle1Eff.tz";
connectAttr "_rightFingerMiddle.lv[14]" "RightHandMiddle1Eff.ty";
connectAttr "_rightFingerMiddle.lv[15]" "RightHandMiddle1Eff.tx";
connectAttr "rightHandRing1.msg" "RightHandRing1Eff.jt";
connectAttr "rightHandRing1FK.msg" "RightHandRing1Eff.fj";
connectAttr "_rightFingerRing.uv[13]" "RightHandRing1Eff.rr";
connectAttr "_rightFingerRing.uv[14]" "RightHandRing1Eff.rt";
connectAttr "_rightFingerRing.av[13]" "RightHandRing1Eff.rz";
connectAttr "_rightFingerRing.av[14]" "RightHandRing1Eff.ry";
connectAttr "_rightFingerRing.av[15]" "RightHandRing1Eff.rx";
connectAttr "_rightFingerRing.lv[13]" "RightHandRing1Eff.tz";
connectAttr "_rightFingerRing.lv[14]" "RightHandRing1Eff.ty";
connectAttr "_rightFingerRing.lv[15]" "RightHandRing1Eff.tx";
connectAttr "rightHandPinky1.msg" "RightHandPinky1Eff.jt";
connectAttr "rightHandPinky1FK.msg" "RightHandPinky1Eff.fj";
connectAttr "_rightFingerPinky.uv[13]" "RightHandPinky1Eff.rr";
connectAttr "_rightFingerPinky.uv[14]" "RightHandPinky1Eff.rt";
connectAttr "_rightFingerPinky.av[13]" "RightHandPinky1Eff.rz";
connectAttr "_rightFingerPinky.av[14]" "RightHandPinky1Eff.ry";
connectAttr "_rightFingerPinky.av[15]" "RightHandPinky1Eff.rx";
connectAttr "_rightFingerPinky.lv[13]" "RightHandPinky1Eff.tz";
connectAttr "_rightFingerPinky.lv[14]" "RightHandPinky1Eff.ty";
connectAttr "_rightFingerPinky.lv[15]" "RightHandPinky1Eff.tx";
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
connectAttr "leftForearm.msg" "LeftForeArmEff.jt";
connectAttr "leftForearmFK.msg" "LeftForeArmEff.fj";
connectAttr "_leftArm.uv[21]" "LeftForeArmEff.rr";
connectAttr "_leftArm.uv[22]" "LeftForeArmEff.rt";
connectAttr "_leftArm.av[22]" "LeftForeArmEff.rz";
connectAttr "_leftArm.av[23]" "LeftForeArmEff.ry";
connectAttr "_leftArm.av[24]" "LeftForeArmEff.rx";
connectAttr "_leftArm.lv[22]" "LeftForeArmEff.tz";
connectAttr "_leftArm.lv[23]" "LeftForeArmEff.ty";
connectAttr "_leftArm.lv[24]" "LeftForeArmEff.tx";
connectAttr "rightForeArm.msg" "RightForeArmEff.jt";
connectAttr "rightForeArmFK.msg" "RightForeArmEff.fj";
connectAttr "_rightArm.uv[21]" "RightForeArmEff.rr";
connectAttr "_rightArm.uv[22]" "RightForeArmEff.rt";
connectAttr "_rightArm.av[22]" "RightForeArmEff.rz";
connectAttr "_rightArm.av[23]" "RightForeArmEff.ry";
connectAttr "_rightArm.av[24]" "RightForeArmEff.rx";
connectAttr "_rightArm.lv[22]" "RightForeArmEff.tz";
connectAttr "_rightArm.lv[23]" "RightForeArmEff.ty";
connectAttr "_rightArm.lv[24]" "RightForeArmEff.tx";
connectAttr "_spine.lv[7]" "SpineEff.tz" -l on;
connectAttr "_spine.lv[8]" "SpineEff.ty" -l on;
connectAttr "_spine.lv[9]" "SpineEff.tx" -l on;
connectAttr "spine.msg" "SpineEff.jt";
connectAttr "spineFK.msg" "SpineEff.fj";
connectAttr "_spine.uv[7]" "SpineEff.rr";
connectAttr "_spine.uv[8]" "SpineEff.rt";
connectAttr "_spine.av[7]" "SpineEff.rz";
connectAttr "_spine.av[8]" "SpineEff.ry";
connectAttr "_spine.av[9]" "SpineEff.rx";
connectAttr "joint86.msg" "LeftToeBaseEff.jt";
connectAttr "joint86FK.msg" "LeftToeBaseEff.fj";
connectAttr "_leftLeg.uv[17]" "LeftToeBaseEff.rr";
connectAttr "_leftLeg.uv[18]" "LeftToeBaseEff.rt";
connectAttr "_leftLeg.av[19]" "LeftToeBaseEff.rz";
connectAttr "_leftLeg.av[20]" "LeftToeBaseEff.ry";
connectAttr "_leftLeg.av[21]" "LeftToeBaseEff.rx";
connectAttr "_leftLeg.lv[19]" "LeftToeBaseEff.tz";
connectAttr "_leftLeg.lv[20]" "LeftToeBaseEff.ty";
connectAttr "_leftLeg.lv[21]" "LeftToeBaseEff.tx";
connectAttr "joint87.msg" "RightToeBaseEff.jt";
connectAttr "joint87FK.msg" "RightToeBaseEff.fj";
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
connectAttr "_leftArm.uv[23]" "LeftArmEff.rr";
connectAttr "_leftArm.uv[24]" "LeftArmEff.rt";
connectAttr "_leftArm.av[25]" "LeftArmEff.rz";
connectAttr "_leftArm.av[26]" "LeftArmEff.ry";
connectAttr "_leftArm.av[27]" "LeftArmEff.rx";
connectAttr "_leftArm.lv[25]" "LeftArmEff.tz";
connectAttr "_leftArm.lv[26]" "LeftArmEff.ty";
connectAttr "_leftArm.lv[27]" "LeftArmEff.tx";
connectAttr "rightArm.msg" "RightArmEff.jt";
connectAttr "rightArmFK.msg" "RightArmEff.fj";
connectAttr "_rightArm.uv[23]" "RightArmEff.rr";
connectAttr "_rightArm.uv[24]" "RightArmEff.rt";
connectAttr "_rightArm.av[25]" "RightArmEff.rz";
connectAttr "_rightArm.av[26]" "RightArmEff.ry";
connectAttr "_rightArm.av[27]" "RightArmEff.rx";
connectAttr "_rightArm.lv[25]" "RightArmEff.tz";
connectAttr "_rightArm.lv[26]" "RightArmEff.ty";
connectAttr "_rightArm.lv[27]" "RightArmEff.tx";
connectAttr "head.msg" "HeadEff.jt";
connectAttr "headFK.msg" "HeadEff.fj";
connectAttr "_head.uv[7]" "HeadEff.rr";
connectAttr "_head.uv[8]" "HeadEff.rt";
connectAttr "_head.av[7]" "HeadEff.rz";
connectAttr "_head.av[8]" "HeadEff.ry";
connectAttr "_head.av[9]" "HeadEff.rx";
connectAttr "_head.lv[7]" "HeadEff.tz";
connectAttr "_head.lv[8]" "HeadEff.ty";
connectAttr "_head.lv[9]" "HeadEff.tx";
connectAttr "_leftLeg.lv[22]" "LeftUpLegEff.tz" -l on;
connectAttr "_leftLeg.lv[23]" "LeftUpLegEff.ty" -l on;
connectAttr "_leftLeg.lv[24]" "LeftUpLegEff.tx" -l on;
connectAttr "leftUpLeg.msg" "LeftUpLegEff.jt";
connectAttr "leftUpLegFK.msg" "LeftUpLegEff.fj";
connectAttr "_leftLeg.uv[19]" "LeftUpLegEff.rr";
connectAttr "_leftLeg.uv[20]" "LeftUpLegEff.rt";
connectAttr "_leftLeg.av[22]" "LeftUpLegEff.rz";
connectAttr "_leftLeg.av[23]" "LeftUpLegEff.ry";
connectAttr "_leftLeg.av[24]" "LeftUpLegEff.rx";
connectAttr "_rightLeg.lv[22]" "RightUpLegEff.tz" -l on;
connectAttr "_rightLeg.lv[23]" "RightUpLegEff.ty" -l on;
connectAttr "_rightLeg.lv[24]" "RightUpLegEff.tx" -l on;
connectAttr "rightUpLeg.msg" "RightUpLegEff.jt";
connectAttr "rightUpLegFK.msg" "RightUpLegEff.fj";
connectAttr "_rightLeg.uv[19]" "RightUpLegEff.rr";
connectAttr "_rightLeg.uv[20]" "RightUpLegEff.rt";
connectAttr "_rightLeg.av[22]" "RightUpLegEff.rz";
connectAttr "_rightLeg.av[23]" "RightUpLegEff.ry";
connectAttr "_rightLeg.av[24]" "RightUpLegEff.rx";
connectAttr "joint23.msg" "LeftFingerBaseEff.jt";
connectAttr "joint23FK.msg" "LeftFingerBaseEff.fj";
connectAttr "_leftArm.uv[25]" "LeftFingerBaseEff.rr";
connectAttr "_leftArm.uv[26]" "LeftFingerBaseEff.rt";
connectAttr "_leftArm.av[28]" "LeftFingerBaseEff.rz";
connectAttr "_leftArm.av[29]" "LeftFingerBaseEff.ry";
connectAttr "_leftArm.av[30]" "LeftFingerBaseEff.rx";
connectAttr "_leftArm.lv[28]" "LeftFingerBaseEff.tz";
connectAttr "_leftArm.lv[29]" "LeftFingerBaseEff.ty";
connectAttr "_leftArm.lv[30]" "LeftFingerBaseEff.tx";
connectAttr "joint67.msg" "RightFingerBaseEff.jt";
connectAttr "joint67FK.msg" "RightFingerBaseEff.fj";
connectAttr "_rightArm.uv[25]" "RightFingerBaseEff.rr";
connectAttr "_rightArm.uv[26]" "RightFingerBaseEff.rt";
connectAttr "_rightArm.av[28]" "RightFingerBaseEff.rz";
connectAttr "_rightArm.av[29]" "RightFingerBaseEff.ry";
connectAttr "_rightArm.av[30]" "RightFingerBaseEff.rx";
connectAttr "_rightArm.lv[28]" "RightFingerBaseEff.tz";
connectAttr "_rightArm.lv[29]" "RightFingerBaseEff.ty";
connectAttr "_rightArm.lv[30]" "RightFingerBaseEff.tx";
connectAttr "spine1.msg" "NeckEff.jt";
connectAttr "spine1FK.msg" "NeckEff.fj";
connectAttr "_spine.uv[9]" "NeckEff.rr";
connectAttr "_spine.uv[10]" "NeckEff.rt";
connectAttr "_spine.av[10]" "NeckEff.rz";
connectAttr "_spine.av[11]" "NeckEff.ry";
connectAttr "_spine.av[12]" "NeckEff.rx";
connectAttr "_spine.lv[10]" "NeckEff.tz";
connectAttr "_spine.lv[11]" "NeckEff.ty";
connectAttr "_spine.lv[12]" "NeckEff.tx";
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
connectAttr "spine1FK.s" "neckFK.is";
connectAttr "_head.uv[1]" "neckFK.sz";
connectAttr "_head.uv[2]" "neckFK.sy";
connectAttr "_head.uv[3]" "neckFK.sx";
connectAttr "_head.av[1]" "neckFK.rz";
connectAttr "_head.av[2]" "neckFK.ry";
connectAttr "_head.av[3]" "neckFK.rx";
connectAttr "_head.lv[1]" "neckFK.tz";
connectAttr "_head.lv[2]" "neckFK.ty";
connectAttr "_head.lv[3]" "neckFK.tx";
connectAttr "neckFK.s" "headFK.is";
connectAttr "_head.uv[4]" "headFK.sz";
connectAttr "_head.uv[5]" "headFK.sy";
connectAttr "_head.uv[6]" "headFK.sx";
connectAttr "_head.av[4]" "headFK.rz";
connectAttr "_head.av[5]" "headFK.ry";
connectAttr "_head.av[6]" "headFK.rx";
connectAttr "_head.lv[4]" "headFK.tz";
connectAttr "_head.lv[5]" "headFK.ty";
connectAttr "_head.lv[6]" "headFK.tx";
connectAttr "spine1FK.s" "leftShoulderFK.is";
connectAttr "_leftArm.uv[1]" "leftShoulderFK.sz";
connectAttr "_leftArm.uv[2]" "leftShoulderFK.sy";
connectAttr "_leftArm.uv[3]" "leftShoulderFK.sx";
connectAttr "_leftArm.av[1]" "leftShoulderFK.rz";
connectAttr "_leftArm.av[2]" "leftShoulderFK.ry";
connectAttr "_leftArm.av[3]" "leftShoulderFK.rx";
connectAttr "_leftArm.lv[1]" "leftShoulderFK.tz";
connectAttr "_leftArm.lv[2]" "leftShoulderFK.ty";
connectAttr "_leftArm.lv[3]" "leftShoulderFK.tx";
connectAttr "leftShoulderFK.s" "leftArmFK.is";
connectAttr "_leftArm.uv[4]" "leftArmFK.sz";
connectAttr "_leftArm.uv[5]" "leftArmFK.sy";
connectAttr "_leftArm.uv[6]" "leftArmFK.sx";
connectAttr "_leftArm.av[4]" "leftArmFK.rz";
connectAttr "_leftArm.av[5]" "leftArmFK.ry";
connectAttr "_leftArm.av[6]" "leftArmFK.rx";
connectAttr "_leftArm.lv[4]" "leftArmFK.tz";
connectAttr "_leftArm.lv[5]" "leftArmFK.ty";
connectAttr "_leftArm.lv[6]" "leftArmFK.tx";
connectAttr "leftArmFK.s" "leftForearmFK.is";
connectAttr "_leftArm.uv[7]" "leftForearmFK.sz";
connectAttr "_leftArm.uv[8]" "leftForearmFK.sy";
connectAttr "_leftArm.uv[9]" "leftForearmFK.sx";
connectAttr "_leftArm.av[7]" "leftForearmFK.rz";
connectAttr "_leftArm.av[8]" "leftForearmFK.ry";
connectAttr "_leftArm.av[9]" "leftForearmFK.rx";
connectAttr "_leftArm.lv[7]" "leftForearmFK.tz";
connectAttr "_leftArm.lv[8]" "leftForearmFK.ty";
connectAttr "_leftArm.lv[9]" "leftForearmFK.tx";
connectAttr "leftForearmFK.s" "leftForeArmRollFK.is";
connectAttr "_leftArm.uv[10]" "leftForeArmRollFK.sz";
connectAttr "_leftArm.uv[11]" "leftForeArmRollFK.sy";
connectAttr "_leftArm.uv[12]" "leftForeArmRollFK.sx";
connectAttr "_leftArm.av[10]" "leftForeArmRollFK.rz";
connectAttr "_leftArm.av[11]" "leftForeArmRollFK.ry";
connectAttr "_leftArm.av[12]" "leftForeArmRollFK.rx";
connectAttr "_leftArm.lv[10]" "leftForeArmRollFK.tz";
connectAttr "_leftArm.lv[11]" "leftForeArmRollFK.ty";
connectAttr "_leftArm.lv[12]" "leftForeArmRollFK.tx";
connectAttr "leftForeArmRollFK.s" "leftHandFK.is";
connectAttr "_leftArm.uv[13]" "leftHandFK.sz";
connectAttr "_leftArm.uv[14]" "leftHandFK.sy";
connectAttr "_leftArm.uv[15]" "leftHandFK.sx";
connectAttr "_leftArm.av[13]" "leftHandFK.rz";
connectAttr "_leftArm.av[14]" "leftHandFK.ry";
connectAttr "_leftArm.av[15]" "leftHandFK.rx";
connectAttr "_leftArm.lv[13]" "leftHandFK.tz";
connectAttr "_leftArm.lv[14]" "leftHandFK.ty";
connectAttr "_leftArm.lv[15]" "leftHandFK.tx";
connectAttr "leftHandFK.s" "leftHandPinky1FK.is";
connectAttr "_leftFingerPinky.uv[1]" "leftHandPinky1FK.sz";
connectAttr "_leftFingerPinky.uv[2]" "leftHandPinky1FK.sy";
connectAttr "_leftFingerPinky.uv[3]" "leftHandPinky1FK.sx";
connectAttr "_leftFingerPinky.av[1]" "leftHandPinky1FK.rz";
connectAttr "_leftFingerPinky.av[2]" "leftHandPinky1FK.ry";
connectAttr "_leftFingerPinky.av[3]" "leftHandPinky1FK.rx";
connectAttr "_leftFingerPinky.lv[1]" "leftHandPinky1FK.tz";
connectAttr "_leftFingerPinky.lv[2]" "leftHandPinky1FK.ty";
connectAttr "_leftFingerPinky.lv[3]" "leftHandPinky1FK.tx";
connectAttr "leftHandPinky1FK.s" "leftHandPinky2FK.is";
connectAttr "_leftFingerPinky.uv[4]" "leftHandPinky2FK.sz";
connectAttr "_leftFingerPinky.uv[5]" "leftHandPinky2FK.sy";
connectAttr "_leftFingerPinky.uv[6]" "leftHandPinky2FK.sx";
connectAttr "_leftFingerPinky.av[4]" "leftHandPinky2FK.rz";
connectAttr "_leftFingerPinky.av[5]" "leftHandPinky2FK.ry";
connectAttr "_leftFingerPinky.av[6]" "leftHandPinky2FK.rx";
connectAttr "_leftFingerPinky.lv[4]" "leftHandPinky2FK.tz";
connectAttr "_leftFingerPinky.lv[5]" "leftHandPinky2FK.ty";
connectAttr "_leftFingerPinky.lv[6]" "leftHandPinky2FK.tx";
connectAttr "leftHandPinky2FK.s" "leftHandPinky3FK.is";
connectAttr "_leftFingerPinky.uv[7]" "leftHandPinky3FK.sz";
connectAttr "_leftFingerPinky.uv[8]" "leftHandPinky3FK.sy";
connectAttr "_leftFingerPinky.uv[9]" "leftHandPinky3FK.sx";
connectAttr "_leftFingerPinky.av[7]" "leftHandPinky3FK.rz";
connectAttr "_leftFingerPinky.av[8]" "leftHandPinky3FK.ry";
connectAttr "_leftFingerPinky.av[9]" "leftHandPinky3FK.rx";
connectAttr "_leftFingerPinky.lv[7]" "leftHandPinky3FK.tz";
connectAttr "_leftFingerPinky.lv[8]" "leftHandPinky3FK.ty";
connectAttr "_leftFingerPinky.lv[9]" "leftHandPinky3FK.tx";
connectAttr "leftHandPinky3FK.s" "leftHandPinky4FK.is";
connectAttr "_leftFingerPinky.uv[10]" "leftHandPinky4FK.sz";
connectAttr "_leftFingerPinky.uv[11]" "leftHandPinky4FK.sy";
connectAttr "_leftFingerPinky.uv[12]" "leftHandPinky4FK.sx";
connectAttr "_leftFingerPinky.av[10]" "leftHandPinky4FK.rz";
connectAttr "_leftFingerPinky.av[11]" "leftHandPinky4FK.ry";
connectAttr "_leftFingerPinky.av[12]" "leftHandPinky4FK.rx";
connectAttr "_leftFingerPinky.lv[10]" "leftHandPinky4FK.tz";
connectAttr "_leftFingerPinky.lv[11]" "leftHandPinky4FK.ty";
connectAttr "_leftFingerPinky.lv[12]" "leftHandPinky4FK.tx";
connectAttr "leftHandFK.s" "leftHandRing1FK.is";
connectAttr "_leftFingerRing.uv[1]" "leftHandRing1FK.sz";
connectAttr "_leftFingerRing.uv[2]" "leftHandRing1FK.sy";
connectAttr "_leftFingerRing.uv[3]" "leftHandRing1FK.sx";
connectAttr "_leftFingerRing.av[1]" "leftHandRing1FK.rz";
connectAttr "_leftFingerRing.av[2]" "leftHandRing1FK.ry";
connectAttr "_leftFingerRing.av[3]" "leftHandRing1FK.rx";
connectAttr "_leftFingerRing.lv[1]" "leftHandRing1FK.tz";
connectAttr "_leftFingerRing.lv[2]" "leftHandRing1FK.ty";
connectAttr "_leftFingerRing.lv[3]" "leftHandRing1FK.tx";
connectAttr "leftHandRing1FK.s" "leftHandRing2FK.is";
connectAttr "_leftFingerRing.uv[4]" "leftHandRing2FK.sz";
connectAttr "_leftFingerRing.uv[5]" "leftHandRing2FK.sy";
connectAttr "_leftFingerRing.uv[6]" "leftHandRing2FK.sx";
connectAttr "_leftFingerRing.av[4]" "leftHandRing2FK.rz";
connectAttr "_leftFingerRing.av[5]" "leftHandRing2FK.ry";
connectAttr "_leftFingerRing.av[6]" "leftHandRing2FK.rx";
connectAttr "_leftFingerRing.lv[4]" "leftHandRing2FK.tz";
connectAttr "_leftFingerRing.lv[5]" "leftHandRing2FK.ty";
connectAttr "_leftFingerRing.lv[6]" "leftHandRing2FK.tx";
connectAttr "leftHandRing2FK.s" "leftHandRing3FK.is";
connectAttr "_leftFingerRing.uv[7]" "leftHandRing3FK.sz";
connectAttr "_leftFingerRing.uv[8]" "leftHandRing3FK.sy";
connectAttr "_leftFingerRing.uv[9]" "leftHandRing3FK.sx";
connectAttr "_leftFingerRing.av[7]" "leftHandRing3FK.rz";
connectAttr "_leftFingerRing.av[8]" "leftHandRing3FK.ry";
connectAttr "_leftFingerRing.av[9]" "leftHandRing3FK.rx";
connectAttr "_leftFingerRing.lv[7]" "leftHandRing3FK.tz";
connectAttr "_leftFingerRing.lv[8]" "leftHandRing3FK.ty";
connectAttr "_leftFingerRing.lv[9]" "leftHandRing3FK.tx";
connectAttr "leftHandRing3FK.s" "leftHandRing4FK.is";
connectAttr "_leftFingerRing.uv[10]" "leftHandRing4FK.sz";
connectAttr "_leftFingerRing.uv[11]" "leftHandRing4FK.sy";
connectAttr "_leftFingerRing.uv[12]" "leftHandRing4FK.sx";
connectAttr "_leftFingerRing.av[10]" "leftHandRing4FK.rz";
connectAttr "_leftFingerRing.av[11]" "leftHandRing4FK.ry";
connectAttr "_leftFingerRing.av[12]" "leftHandRing4FK.rx";
connectAttr "_leftFingerRing.lv[10]" "leftHandRing4FK.tz";
connectAttr "_leftFingerRing.lv[11]" "leftHandRing4FK.ty";
connectAttr "_leftFingerRing.lv[12]" "leftHandRing4FK.tx";
connectAttr "leftHandFK.s" "joint23FK.is";
connectAttr "_leftArm.uv[16]" "joint23FK.sz";
connectAttr "_leftArm.uv[17]" "joint23FK.sy";
connectAttr "_leftArm.uv[18]" "joint23FK.sx";
connectAttr "_leftArm.av[16]" "joint23FK.rz";
connectAttr "_leftArm.av[17]" "joint23FK.ry";
connectAttr "_leftArm.av[18]" "joint23FK.rx";
connectAttr "_leftArm.lv[16]" "joint23FK.tz";
connectAttr "_leftArm.lv[17]" "joint23FK.ty";
connectAttr "_leftArm.lv[18]" "joint23FK.tx";
connectAttr "joint23FK.s" "leftHandMiddle1FK.is";
connectAttr "_leftFingerMiddle.uv[1]" "leftHandMiddle1FK.sz";
connectAttr "_leftFingerMiddle.uv[2]" "leftHandMiddle1FK.sy";
connectAttr "_leftFingerMiddle.uv[3]" "leftHandMiddle1FK.sx";
connectAttr "_leftFingerMiddle.av[1]" "leftHandMiddle1FK.rz";
connectAttr "_leftFingerMiddle.av[2]" "leftHandMiddle1FK.ry";
connectAttr "_leftFingerMiddle.av[3]" "leftHandMiddle1FK.rx";
connectAttr "_leftFingerMiddle.lv[1]" "leftHandMiddle1FK.tz";
connectAttr "_leftFingerMiddle.lv[2]" "leftHandMiddle1FK.ty";
connectAttr "_leftFingerMiddle.lv[3]" "leftHandMiddle1FK.tx";
connectAttr "leftHandMiddle1FK.s" "leftHandMiddle2FK.is";
connectAttr "_leftFingerMiddle.uv[4]" "leftHandMiddle2FK.sz";
connectAttr "_leftFingerMiddle.uv[5]" "leftHandMiddle2FK.sy";
connectAttr "_leftFingerMiddle.uv[6]" "leftHandMiddle2FK.sx";
connectAttr "_leftFingerMiddle.av[4]" "leftHandMiddle2FK.rz";
connectAttr "_leftFingerMiddle.av[5]" "leftHandMiddle2FK.ry";
connectAttr "_leftFingerMiddle.av[6]" "leftHandMiddle2FK.rx";
connectAttr "_leftFingerMiddle.lv[4]" "leftHandMiddle2FK.tz";
connectAttr "_leftFingerMiddle.lv[5]" "leftHandMiddle2FK.ty";
connectAttr "_leftFingerMiddle.lv[6]" "leftHandMiddle2FK.tx";
connectAttr "leftHandMiddle2FK.s" "leftHandMiddle3FK.is";
connectAttr "_leftFingerMiddle.uv[7]" "leftHandMiddle3FK.sz";
connectAttr "_leftFingerMiddle.uv[8]" "leftHandMiddle3FK.sy";
connectAttr "_leftFingerMiddle.uv[9]" "leftHandMiddle3FK.sx";
connectAttr "_leftFingerMiddle.av[7]" "leftHandMiddle3FK.rz";
connectAttr "_leftFingerMiddle.av[8]" "leftHandMiddle3FK.ry";
connectAttr "_leftFingerMiddle.av[9]" "leftHandMiddle3FK.rx";
connectAttr "_leftFingerMiddle.lv[7]" "leftHandMiddle3FK.tz";
connectAttr "_leftFingerMiddle.lv[8]" "leftHandMiddle3FK.ty";
connectAttr "_leftFingerMiddle.lv[9]" "leftHandMiddle3FK.tx";
connectAttr "_leftFingerMiddle.av[10]" "leftHandMiddle4FK.rz";
connectAttr "_leftFingerMiddle.av[11]" "leftHandMiddle4FK.ry";
connectAttr "_leftFingerMiddle.av[12]" "leftHandMiddle4FK.rx";
connectAttr "leftHandMiddle3FK.s" "leftHandMiddle4FK.is";
connectAttr "_leftFingerMiddle.uv[10]" "leftHandMiddle4FK.sz";
connectAttr "_leftFingerMiddle.uv[11]" "leftHandMiddle4FK.sy";
connectAttr "_leftFingerMiddle.uv[12]" "leftHandMiddle4FK.sx";
connectAttr "_leftFingerMiddle.lv[10]" "leftHandMiddle4FK.tz";
connectAttr "_leftFingerMiddle.lv[11]" "leftHandMiddle4FK.ty";
connectAttr "_leftFingerMiddle.lv[12]" "leftHandMiddle4FK.tx";
connectAttr "leftHandFK.s" "leftHandIndex1FK.is";
connectAttr "_leftFingerIndex.uv[1]" "leftHandIndex1FK.sz";
connectAttr "_leftFingerIndex.uv[2]" "leftHandIndex1FK.sy";
connectAttr "_leftFingerIndex.uv[3]" "leftHandIndex1FK.sx";
connectAttr "_leftFingerIndex.av[1]" "leftHandIndex1FK.rz";
connectAttr "_leftFingerIndex.av[2]" "leftHandIndex1FK.ry";
connectAttr "_leftFingerIndex.av[3]" "leftHandIndex1FK.rx";
connectAttr "_leftFingerIndex.lv[1]" "leftHandIndex1FK.tz";
connectAttr "_leftFingerIndex.lv[2]" "leftHandIndex1FK.ty";
connectAttr "_leftFingerIndex.lv[3]" "leftHandIndex1FK.tx";
connectAttr "leftHandIndex1FK.s" "leftHandIndex2FK.is";
connectAttr "_leftFingerIndex.uv[4]" "leftHandIndex2FK.sz";
connectAttr "_leftFingerIndex.uv[5]" "leftHandIndex2FK.sy";
connectAttr "_leftFingerIndex.uv[6]" "leftHandIndex2FK.sx";
connectAttr "_leftFingerIndex.av[4]" "leftHandIndex2FK.rz";
connectAttr "_leftFingerIndex.av[5]" "leftHandIndex2FK.ry";
connectAttr "_leftFingerIndex.av[6]" "leftHandIndex2FK.rx";
connectAttr "_leftFingerIndex.lv[4]" "leftHandIndex2FK.tz";
connectAttr "_leftFingerIndex.lv[5]" "leftHandIndex2FK.ty";
connectAttr "_leftFingerIndex.lv[6]" "leftHandIndex2FK.tx";
connectAttr "leftHandIndex2FK.s" "leftHandIndex3FK.is";
connectAttr "_leftFingerIndex.uv[7]" "leftHandIndex3FK.sz";
connectAttr "_leftFingerIndex.uv[8]" "leftHandIndex3FK.sy";
connectAttr "_leftFingerIndex.uv[9]" "leftHandIndex3FK.sx";
connectAttr "_leftFingerIndex.av[7]" "leftHandIndex3FK.rz";
connectAttr "_leftFingerIndex.av[8]" "leftHandIndex3FK.ry";
connectAttr "_leftFingerIndex.av[9]" "leftHandIndex3FK.rx";
connectAttr "_leftFingerIndex.lv[7]" "leftHandIndex3FK.tz";
connectAttr "_leftFingerIndex.lv[8]" "leftHandIndex3FK.ty";
connectAttr "_leftFingerIndex.lv[9]" "leftHandIndex3FK.tx";
connectAttr "leftHandIndex3FK.s" "leftHandIndex4FK.is";
connectAttr "_leftFingerIndex.uv[10]" "leftHandIndex4FK.sz";
connectAttr "_leftFingerIndex.uv[11]" "leftHandIndex4FK.sy";
connectAttr "_leftFingerIndex.uv[12]" "leftHandIndex4FK.sx";
connectAttr "_leftFingerIndex.av[10]" "leftHandIndex4FK.rz";
connectAttr "_leftFingerIndex.av[11]" "leftHandIndex4FK.ry";
connectAttr "_leftFingerIndex.av[12]" "leftHandIndex4FK.rx";
connectAttr "_leftFingerIndex.lv[10]" "leftHandIndex4FK.tz";
connectAttr "_leftFingerIndex.lv[11]" "leftHandIndex4FK.ty";
connectAttr "_leftFingerIndex.lv[12]" "leftHandIndex4FK.tx";
connectAttr "leftHandFK.s" "leftHandThumb1FK.is";
connectAttr "_leftThumb.uv[1]" "leftHandThumb1FK.sz";
connectAttr "_leftThumb.uv[2]" "leftHandThumb1FK.sy";
connectAttr "_leftThumb.uv[3]" "leftHandThumb1FK.sx";
connectAttr "_leftThumb.av[1]" "leftHandThumb1FK.rz";
connectAttr "_leftThumb.av[2]" "leftHandThumb1FK.ry";
connectAttr "_leftThumb.av[3]" "leftHandThumb1FK.rx";
connectAttr "_leftThumb.lv[1]" "leftHandThumb1FK.tz";
connectAttr "_leftThumb.lv[2]" "leftHandThumb1FK.ty";
connectAttr "_leftThumb.lv[3]" "leftHandThumb1FK.tx";
connectAttr "leftHandThumb1FK.s" "leftHandThumb2FK.is";
connectAttr "_leftThumb.uv[4]" "leftHandThumb2FK.sz";
connectAttr "_leftThumb.uv[5]" "leftHandThumb2FK.sy";
connectAttr "_leftThumb.uv[6]" "leftHandThumb2FK.sx";
connectAttr "_leftThumb.av[4]" "leftHandThumb2FK.rz";
connectAttr "_leftThumb.av[5]" "leftHandThumb2FK.ry";
connectAttr "_leftThumb.av[6]" "leftHandThumb2FK.rx";
connectAttr "_leftThumb.lv[4]" "leftHandThumb2FK.tz";
connectAttr "_leftThumb.lv[5]" "leftHandThumb2FK.ty";
connectAttr "_leftThumb.lv[6]" "leftHandThumb2FK.tx";
connectAttr "leftHandThumb2FK.s" "leftHandThumb3FK.is";
connectAttr "_leftThumb.uv[7]" "leftHandThumb3FK.sz";
connectAttr "_leftThumb.uv[8]" "leftHandThumb3FK.sy";
connectAttr "_leftThumb.uv[9]" "leftHandThumb3FK.sx";
connectAttr "_leftThumb.av[7]" "leftHandThumb3FK.rz";
connectAttr "_leftThumb.av[8]" "leftHandThumb3FK.ry";
connectAttr "_leftThumb.av[9]" "leftHandThumb3FK.rx";
connectAttr "_leftThumb.lv[7]" "leftHandThumb3FK.tz";
connectAttr "_leftThumb.lv[8]" "leftHandThumb3FK.ty";
connectAttr "_leftThumb.lv[9]" "leftHandThumb3FK.tx";
connectAttr "leftHandThumb3FK.s" "leftHandThumb4FK.is";
connectAttr "_leftThumb.uv[10]" "leftHandThumb4FK.sz";
connectAttr "_leftThumb.uv[11]" "leftHandThumb4FK.sy";
connectAttr "_leftThumb.uv[12]" "leftHandThumb4FK.sx";
connectAttr "_leftThumb.av[10]" "leftHandThumb4FK.rz";
connectAttr "_leftThumb.av[11]" "leftHandThumb4FK.ry";
connectAttr "_leftThumb.av[12]" "leftHandThumb4FK.rx";
connectAttr "_leftThumb.lv[10]" "leftHandThumb4FK.tz";
connectAttr "_leftThumb.lv[11]" "leftHandThumb4FK.ty";
connectAttr "_leftThumb.lv[12]" "leftHandThumb4FK.tx";
connectAttr "spine1FK.s" "rightShoulderFK.is";
connectAttr "_rightArm.uv[1]" "rightShoulderFK.sz";
connectAttr "_rightArm.uv[2]" "rightShoulderFK.sy";
connectAttr "_rightArm.uv[3]" "rightShoulderFK.sx";
connectAttr "_rightArm.av[1]" "rightShoulderFK.rz";
connectAttr "_rightArm.av[2]" "rightShoulderFK.ry";
connectAttr "_rightArm.av[3]" "rightShoulderFK.rx";
connectAttr "_rightArm.lv[1]" "rightShoulderFK.tz";
connectAttr "_rightArm.lv[2]" "rightShoulderFK.ty";
connectAttr "_rightArm.lv[3]" "rightShoulderFK.tx";
connectAttr "rightShoulderFK.s" "rightArmFK.is";
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
connectAttr "rightForeArmFK.s" "rightForeArmRollFK.is";
connectAttr "_rightArm.uv[10]" "rightForeArmRollFK.sz";
connectAttr "_rightArm.uv[11]" "rightForeArmRollFK.sy";
connectAttr "_rightArm.uv[12]" "rightForeArmRollFK.sx";
connectAttr "_rightArm.av[10]" "rightForeArmRollFK.rz";
connectAttr "_rightArm.av[11]" "rightForeArmRollFK.ry";
connectAttr "_rightArm.av[12]" "rightForeArmRollFK.rx";
connectAttr "_rightArm.lv[10]" "rightForeArmRollFK.tz";
connectAttr "_rightArm.lv[11]" "rightForeArmRollFK.ty";
connectAttr "_rightArm.lv[12]" "rightForeArmRollFK.tx";
connectAttr "rightForeArmRollFK.s" "rightHandFK.is";
connectAttr "_rightArm.uv[13]" "rightHandFK.sz";
connectAttr "_rightArm.uv[14]" "rightHandFK.sy";
connectAttr "_rightArm.uv[15]" "rightHandFK.sx";
connectAttr "_rightArm.av[13]" "rightHandFK.rz";
connectAttr "_rightArm.av[14]" "rightHandFK.ry";
connectAttr "_rightArm.av[15]" "rightHandFK.rx";
connectAttr "_rightArm.lv[13]" "rightHandFK.tz";
connectAttr "_rightArm.lv[14]" "rightHandFK.ty";
connectAttr "_rightArm.lv[15]" "rightHandFK.tx";
connectAttr "rightHandFK.s" "rightHandPinky1FK.is";
connectAttr "_rightFingerPinky.uv[1]" "rightHandPinky1FK.sz";
connectAttr "_rightFingerPinky.uv[2]" "rightHandPinky1FK.sy";
connectAttr "_rightFingerPinky.uv[3]" "rightHandPinky1FK.sx";
connectAttr "_rightFingerPinky.av[1]" "rightHandPinky1FK.rz";
connectAttr "_rightFingerPinky.av[2]" "rightHandPinky1FK.ry";
connectAttr "_rightFingerPinky.av[3]" "rightHandPinky1FK.rx";
connectAttr "_rightFingerPinky.lv[1]" "rightHandPinky1FK.tz";
connectAttr "_rightFingerPinky.lv[2]" "rightHandPinky1FK.ty";
connectAttr "_rightFingerPinky.lv[3]" "rightHandPinky1FK.tx";
connectAttr "rightHandPinky1FK.s" "rightHandPinky2FK.is";
connectAttr "_rightFingerPinky.uv[4]" "rightHandPinky2FK.sz";
connectAttr "_rightFingerPinky.uv[5]" "rightHandPinky2FK.sy";
connectAttr "_rightFingerPinky.uv[6]" "rightHandPinky2FK.sx";
connectAttr "_rightFingerPinky.av[4]" "rightHandPinky2FK.rz";
connectAttr "_rightFingerPinky.av[5]" "rightHandPinky2FK.ry";
connectAttr "_rightFingerPinky.av[6]" "rightHandPinky2FK.rx";
connectAttr "_rightFingerPinky.lv[4]" "rightHandPinky2FK.tz";
connectAttr "_rightFingerPinky.lv[5]" "rightHandPinky2FK.ty";
connectAttr "_rightFingerPinky.lv[6]" "rightHandPinky2FK.tx";
connectAttr "rightHandPinky2FK.s" "rightHandPinky3FK.is";
connectAttr "_rightFingerPinky.uv[7]" "rightHandPinky3FK.sz";
connectAttr "_rightFingerPinky.uv[8]" "rightHandPinky3FK.sy";
connectAttr "_rightFingerPinky.uv[9]" "rightHandPinky3FK.sx";
connectAttr "_rightFingerPinky.av[7]" "rightHandPinky3FK.rz";
connectAttr "_rightFingerPinky.av[8]" "rightHandPinky3FK.ry";
connectAttr "_rightFingerPinky.av[9]" "rightHandPinky3FK.rx";
connectAttr "_rightFingerPinky.lv[7]" "rightHandPinky3FK.tz";
connectAttr "_rightFingerPinky.lv[8]" "rightHandPinky3FK.ty";
connectAttr "_rightFingerPinky.lv[9]" "rightHandPinky3FK.tx";
connectAttr "rightHandPinky3FK.s" "rightHandPinky4FK.is";
connectAttr "_rightFingerPinky.uv[10]" "rightHandPinky4FK.sz";
connectAttr "_rightFingerPinky.uv[11]" "rightHandPinky4FK.sy";
connectAttr "_rightFingerPinky.uv[12]" "rightHandPinky4FK.sx";
connectAttr "_rightFingerPinky.av[10]" "rightHandPinky4FK.rz";
connectAttr "_rightFingerPinky.av[11]" "rightHandPinky4FK.ry";
connectAttr "_rightFingerPinky.av[12]" "rightHandPinky4FK.rx";
connectAttr "_rightFingerPinky.lv[10]" "rightHandPinky4FK.tz";
connectAttr "_rightFingerPinky.lv[11]" "rightHandPinky4FK.ty";
connectAttr "_rightFingerPinky.lv[12]" "rightHandPinky4FK.tx";
connectAttr "rightHandFK.s" "rightHandRing1FK.is";
connectAttr "_rightFingerRing.uv[1]" "rightHandRing1FK.sz";
connectAttr "_rightFingerRing.uv[2]" "rightHandRing1FK.sy";
connectAttr "_rightFingerRing.uv[3]" "rightHandRing1FK.sx";
connectAttr "_rightFingerRing.av[1]" "rightHandRing1FK.rz";
connectAttr "_rightFingerRing.av[2]" "rightHandRing1FK.ry";
connectAttr "_rightFingerRing.av[3]" "rightHandRing1FK.rx";
connectAttr "_rightFingerRing.lv[1]" "rightHandRing1FK.tz";
connectAttr "_rightFingerRing.lv[2]" "rightHandRing1FK.ty";
connectAttr "_rightFingerRing.lv[3]" "rightHandRing1FK.tx";
connectAttr "rightHandRing1FK.s" "rightHandRing2FK.is";
connectAttr "_rightFingerRing.uv[4]" "rightHandRing2FK.sz";
connectAttr "_rightFingerRing.uv[5]" "rightHandRing2FK.sy";
connectAttr "_rightFingerRing.uv[6]" "rightHandRing2FK.sx";
connectAttr "_rightFingerRing.av[4]" "rightHandRing2FK.rz";
connectAttr "_rightFingerRing.av[5]" "rightHandRing2FK.ry";
connectAttr "_rightFingerRing.av[6]" "rightHandRing2FK.rx";
connectAttr "_rightFingerRing.lv[4]" "rightHandRing2FK.tz";
connectAttr "_rightFingerRing.lv[5]" "rightHandRing2FK.ty";
connectAttr "_rightFingerRing.lv[6]" "rightHandRing2FK.tx";
connectAttr "rightHandRing2FK.s" "rightHandRing3FK.is";
connectAttr "_rightFingerRing.uv[7]" "rightHandRing3FK.sz";
connectAttr "_rightFingerRing.uv[8]" "rightHandRing3FK.sy";
connectAttr "_rightFingerRing.uv[9]" "rightHandRing3FK.sx";
connectAttr "_rightFingerRing.av[7]" "rightHandRing3FK.rz";
connectAttr "_rightFingerRing.av[8]" "rightHandRing3FK.ry";
connectAttr "_rightFingerRing.av[9]" "rightHandRing3FK.rx";
connectAttr "_rightFingerRing.lv[7]" "rightHandRing3FK.tz";
connectAttr "_rightFingerRing.lv[8]" "rightHandRing3FK.ty";
connectAttr "_rightFingerRing.lv[9]" "rightHandRing3FK.tx";
connectAttr "_rightFingerRing.av[11]" "rightHandRing4FK.ry";
connectAttr "_rightFingerRing.av[12]" "rightHandRing4FK.rx";
connectAttr "_rightFingerRing.av[10]" "rightHandRing4FK.rz";
connectAttr "rightHandRing3FK.s" "rightHandRing4FK.is";
connectAttr "_rightFingerRing.uv[10]" "rightHandRing4FK.sz";
connectAttr "_rightFingerRing.uv[11]" "rightHandRing4FK.sy";
connectAttr "_rightFingerRing.uv[12]" "rightHandRing4FK.sx";
connectAttr "_rightFingerRing.lv[10]" "rightHandRing4FK.tz";
connectAttr "_rightFingerRing.lv[11]" "rightHandRing4FK.ty";
connectAttr "_rightFingerRing.lv[12]" "rightHandRing4FK.tx";
connectAttr "rightHandFK.s" "joint67FK.is";
connectAttr "_rightArm.uv[16]" "joint67FK.sz";
connectAttr "_rightArm.uv[17]" "joint67FK.sy";
connectAttr "_rightArm.uv[18]" "joint67FK.sx";
connectAttr "_rightArm.av[16]" "joint67FK.rz";
connectAttr "_rightArm.av[17]" "joint67FK.ry";
connectAttr "_rightArm.av[18]" "joint67FK.rx";
connectAttr "_rightArm.lv[16]" "joint67FK.tz";
connectAttr "_rightArm.lv[17]" "joint67FK.ty";
connectAttr "_rightArm.lv[18]" "joint67FK.tx";
connectAttr "joint67FK.s" "rightHandMiddle1FK.is";
connectAttr "_rightFingerMiddle.uv[1]" "rightHandMiddle1FK.sz";
connectAttr "_rightFingerMiddle.uv[2]" "rightHandMiddle1FK.sy";
connectAttr "_rightFingerMiddle.uv[3]" "rightHandMiddle1FK.sx";
connectAttr "_rightFingerMiddle.av[1]" "rightHandMiddle1FK.rz";
connectAttr "_rightFingerMiddle.av[2]" "rightHandMiddle1FK.ry";
connectAttr "_rightFingerMiddle.av[3]" "rightHandMiddle1FK.rx";
connectAttr "_rightFingerMiddle.lv[1]" "rightHandMiddle1FK.tz";
connectAttr "_rightFingerMiddle.lv[2]" "rightHandMiddle1FK.ty";
connectAttr "_rightFingerMiddle.lv[3]" "rightHandMiddle1FK.tx";
connectAttr "rightHandMiddle1FK.s" "rightHandMiddle2FK.is";
connectAttr "_rightFingerMiddle.uv[4]" "rightHandMiddle2FK.sz";
connectAttr "_rightFingerMiddle.uv[5]" "rightHandMiddle2FK.sy";
connectAttr "_rightFingerMiddle.uv[6]" "rightHandMiddle2FK.sx";
connectAttr "_rightFingerMiddle.av[4]" "rightHandMiddle2FK.rz";
connectAttr "_rightFingerMiddle.av[5]" "rightHandMiddle2FK.ry";
connectAttr "_rightFingerMiddle.av[6]" "rightHandMiddle2FK.rx";
connectAttr "_rightFingerMiddle.lv[4]" "rightHandMiddle2FK.tz";
connectAttr "_rightFingerMiddle.lv[5]" "rightHandMiddle2FK.ty";
connectAttr "_rightFingerMiddle.lv[6]" "rightHandMiddle2FK.tx";
connectAttr "rightHandMiddle2FK.s" "rightHandMiddle3FK.is";
connectAttr "_rightFingerMiddle.uv[7]" "rightHandMiddle3FK.sz";
connectAttr "_rightFingerMiddle.uv[8]" "rightHandMiddle3FK.sy";
connectAttr "_rightFingerMiddle.uv[9]" "rightHandMiddle3FK.sx";
connectAttr "_rightFingerMiddle.av[7]" "rightHandMiddle3FK.rz";
connectAttr "_rightFingerMiddle.av[8]" "rightHandMiddle3FK.ry";
connectAttr "_rightFingerMiddle.av[9]" "rightHandMiddle3FK.rx";
connectAttr "_rightFingerMiddle.lv[7]" "rightHandMiddle3FK.tz";
connectAttr "_rightFingerMiddle.lv[8]" "rightHandMiddle3FK.ty";
connectAttr "_rightFingerMiddle.lv[9]" "rightHandMiddle3FK.tx";
connectAttr "_rightFingerMiddle.av[11]" "rightHandMiddle4FK.ry";
connectAttr "_rightFingerMiddle.av[12]" "rightHandMiddle4FK.rx";
connectAttr "_rightFingerMiddle.av[10]" "rightHandMiddle4FK.rz";
connectAttr "rightHandMiddle3FK.s" "rightHandMiddle4FK.is";
connectAttr "_rightFingerMiddle.uv[10]" "rightHandMiddle4FK.sz";
connectAttr "_rightFingerMiddle.uv[11]" "rightHandMiddle4FK.sy";
connectAttr "_rightFingerMiddle.uv[12]" "rightHandMiddle4FK.sx";
connectAttr "_rightFingerMiddle.lv[10]" "rightHandMiddle4FK.tz";
connectAttr "_rightFingerMiddle.lv[11]" "rightHandMiddle4FK.ty";
connectAttr "_rightFingerMiddle.lv[12]" "rightHandMiddle4FK.tx";
connectAttr "rightHandFK.s" "rightHandIndex1FK.is";
connectAttr "_rightFingerIndex.uv[1]" "rightHandIndex1FK.sz";
connectAttr "_rightFingerIndex.uv[2]" "rightHandIndex1FK.sy";
connectAttr "_rightFingerIndex.uv[3]" "rightHandIndex1FK.sx";
connectAttr "_rightFingerIndex.av[1]" "rightHandIndex1FK.rz";
connectAttr "_rightFingerIndex.av[2]" "rightHandIndex1FK.ry";
connectAttr "_rightFingerIndex.av[3]" "rightHandIndex1FK.rx";
connectAttr "_rightFingerIndex.lv[1]" "rightHandIndex1FK.tz";
connectAttr "_rightFingerIndex.lv[2]" "rightHandIndex1FK.ty";
connectAttr "_rightFingerIndex.lv[3]" "rightHandIndex1FK.tx";
connectAttr "rightHandIndex1FK.s" "rightHandIndex2FK.is";
connectAttr "_rightFingerIndex.uv[4]" "rightHandIndex2FK.sz";
connectAttr "_rightFingerIndex.uv[5]" "rightHandIndex2FK.sy";
connectAttr "_rightFingerIndex.uv[6]" "rightHandIndex2FK.sx";
connectAttr "_rightFingerIndex.av[4]" "rightHandIndex2FK.rz";
connectAttr "_rightFingerIndex.av[5]" "rightHandIndex2FK.ry";
connectAttr "_rightFingerIndex.av[6]" "rightHandIndex2FK.rx";
connectAttr "_rightFingerIndex.lv[4]" "rightHandIndex2FK.tz";
connectAttr "_rightFingerIndex.lv[5]" "rightHandIndex2FK.ty";
connectAttr "_rightFingerIndex.lv[6]" "rightHandIndex2FK.tx";
connectAttr "rightHandIndex2FK.s" "rightHandIndex3FK.is";
connectAttr "_rightFingerIndex.uv[7]" "rightHandIndex3FK.sz";
connectAttr "_rightFingerIndex.uv[8]" "rightHandIndex3FK.sy";
connectAttr "_rightFingerIndex.uv[9]" "rightHandIndex3FK.sx";
connectAttr "_rightFingerIndex.av[7]" "rightHandIndex3FK.rz";
connectAttr "_rightFingerIndex.av[8]" "rightHandIndex3FK.ry";
connectAttr "_rightFingerIndex.av[9]" "rightHandIndex3FK.rx";
connectAttr "_rightFingerIndex.lv[7]" "rightHandIndex3FK.tz";
connectAttr "_rightFingerIndex.lv[8]" "rightHandIndex3FK.ty";
connectAttr "_rightFingerIndex.lv[9]" "rightHandIndex3FK.tx";
connectAttr "rightHandIndex3FK.s" "rightHandIndex4FK.is";
connectAttr "_rightFingerIndex.uv[10]" "rightHandIndex4FK.sz";
connectAttr "_rightFingerIndex.uv[11]" "rightHandIndex4FK.sy";
connectAttr "_rightFingerIndex.uv[12]" "rightHandIndex4FK.sx";
connectAttr "_rightFingerIndex.av[10]" "rightHandIndex4FK.rz";
connectAttr "_rightFingerIndex.av[11]" "rightHandIndex4FK.ry";
connectAttr "_rightFingerIndex.av[12]" "rightHandIndex4FK.rx";
connectAttr "_rightFingerIndex.lv[10]" "rightHandIndex4FK.tz";
connectAttr "_rightFingerIndex.lv[11]" "rightHandIndex4FK.ty";
connectAttr "_rightFingerIndex.lv[12]" "rightHandIndex4FK.tx";
connectAttr "rightHandFK.s" "rightHandThumb1FK.is";
connectAttr "_rightThumb.uv[1]" "rightHandThumb1FK.sz";
connectAttr "_rightThumb.uv[2]" "rightHandThumb1FK.sy";
connectAttr "_rightThumb.uv[3]" "rightHandThumb1FK.sx";
connectAttr "_rightThumb.av[1]" "rightHandThumb1FK.rz";
connectAttr "_rightThumb.av[2]" "rightHandThumb1FK.ry";
connectAttr "_rightThumb.av[3]" "rightHandThumb1FK.rx";
connectAttr "_rightThumb.lv[1]" "rightHandThumb1FK.tz";
connectAttr "_rightThumb.lv[2]" "rightHandThumb1FK.ty";
connectAttr "_rightThumb.lv[3]" "rightHandThumb1FK.tx";
connectAttr "rightHandThumb1FK.s" "rightHandThumb2FK.is";
connectAttr "_rightThumb.uv[4]" "rightHandThumb2FK.sz";
connectAttr "_rightThumb.uv[5]" "rightHandThumb2FK.sy";
connectAttr "_rightThumb.uv[6]" "rightHandThumb2FK.sx";
connectAttr "_rightThumb.av[4]" "rightHandThumb2FK.rz";
connectAttr "_rightThumb.av[5]" "rightHandThumb2FK.ry";
connectAttr "_rightThumb.av[6]" "rightHandThumb2FK.rx";
connectAttr "_rightThumb.lv[4]" "rightHandThumb2FK.tz";
connectAttr "_rightThumb.lv[5]" "rightHandThumb2FK.ty";
connectAttr "_rightThumb.lv[6]" "rightHandThumb2FK.tx";
connectAttr "rightHandThumb2FK.s" "rightHandThumb3FK.is";
connectAttr "_rightThumb.uv[7]" "rightHandThumb3FK.sz";
connectAttr "_rightThumb.uv[8]" "rightHandThumb3FK.sy";
connectAttr "_rightThumb.uv[9]" "rightHandThumb3FK.sx";
connectAttr "_rightThumb.av[7]" "rightHandThumb3FK.rz";
connectAttr "_rightThumb.av[8]" "rightHandThumb3FK.ry";
connectAttr "_rightThumb.av[9]" "rightHandThumb3FK.rx";
connectAttr "_rightThumb.lv[7]" "rightHandThumb3FK.tz";
connectAttr "_rightThumb.lv[8]" "rightHandThumb3FK.ty";
connectAttr "_rightThumb.lv[9]" "rightHandThumb3FK.tx";
connectAttr "rightHandThumb3FK.s" "rightHandThumb4FK.is";
connectAttr "_rightThumb.uv[10]" "rightHandThumb4FK.sz";
connectAttr "_rightThumb.uv[11]" "rightHandThumb4FK.sy";
connectAttr "_rightThumb.uv[12]" "rightHandThumb4FK.sx";
connectAttr "_rightThumb.av[10]" "rightHandThumb4FK.rz";
connectAttr "_rightThumb.av[11]" "rightHandThumb4FK.ry";
connectAttr "_rightThumb.av[12]" "rightHandThumb4FK.rx";
connectAttr "_rightThumb.lv[10]" "rightHandThumb4FK.tz";
connectAttr "_rightThumb.lv[11]" "rightHandThumb4FK.ty";
connectAttr "_rightThumb.lv[12]" "rightHandThumb4FK.tx";
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
connectAttr "leftFootFK.s" "joint86FK.is";
connectAttr "_leftLeg.uv[10]" "joint86FK.sz";
connectAttr "_leftLeg.uv[11]" "joint86FK.sy";
connectAttr "_leftLeg.uv[12]" "joint86FK.sx";
connectAttr "_leftLeg.av[10]" "joint86FK.rz";
connectAttr "_leftLeg.av[11]" "joint86FK.ry";
connectAttr "_leftLeg.av[12]" "joint86FK.rx";
connectAttr "_leftLeg.lv[10]" "joint86FK.tz";
connectAttr "_leftLeg.lv[11]" "joint86FK.ty";
connectAttr "_leftLeg.lv[12]" "joint86FK.tx";
connectAttr "joint86FK.s" "leftFootIndex1FK.is";
connectAttr "_leftFootIndex.uv[1]" "leftFootIndex1FK.sz";
connectAttr "_leftFootIndex.uv[2]" "leftFootIndex1FK.sy";
connectAttr "_leftFootIndex.uv[3]" "leftFootIndex1FK.sx";
connectAttr "_leftFootIndex.av[1]" "leftFootIndex1FK.rz";
connectAttr "_leftFootIndex.av[2]" "leftFootIndex1FK.ry";
connectAttr "_leftFootIndex.av[3]" "leftFootIndex1FK.rx";
connectAttr "_leftFootIndex.lv[1]" "leftFootIndex1FK.tz";
connectAttr "_leftFootIndex.lv[2]" "leftFootIndex1FK.ty";
connectAttr "_leftFootIndex.lv[3]" "leftFootIndex1FK.tx";
connectAttr "_leftFootIndex.av[5]" "leftFootIndex2FK.ry";
connectAttr "_leftFootIndex.av[6]" "leftFootIndex2FK.rx";
connectAttr "_leftFootIndex.av[4]" "leftFootIndex2FK.rz";
connectAttr "leftFootIndex1FK.s" "leftFootIndex2FK.is";
connectAttr "_leftFootIndex.uv[4]" "leftFootIndex2FK.sz";
connectAttr "_leftFootIndex.uv[5]" "leftFootIndex2FK.sy";
connectAttr "_leftFootIndex.uv[6]" "leftFootIndex2FK.sx";
connectAttr "_leftFootIndex.lv[4]" "leftFootIndex2FK.tz";
connectAttr "_leftFootIndex.lv[5]" "leftFootIndex2FK.ty";
connectAttr "_leftFootIndex.lv[6]" "leftFootIndex2FK.tx";
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
connectAttr "rightFootFK.s" "joint87FK.is";
connectAttr "_rightLeg.uv[10]" "joint87FK.sz";
connectAttr "_rightLeg.uv[11]" "joint87FK.sy";
connectAttr "_rightLeg.uv[12]" "joint87FK.sx";
connectAttr "_rightLeg.av[10]" "joint87FK.rz";
connectAttr "_rightLeg.av[11]" "joint87FK.ry";
connectAttr "_rightLeg.av[12]" "joint87FK.rx";
connectAttr "_rightLeg.lv[10]" "joint87FK.tz";
connectAttr "_rightLeg.lv[11]" "joint87FK.ty";
connectAttr "_rightLeg.lv[12]" "joint87FK.tx";
connectAttr "_rightFootIndex.av[2]" "rightFootIndex1FK.ry";
connectAttr "_rightFootIndex.av[3]" "rightFootIndex1FK.rx";
connectAttr "_rightFootIndex.av[1]" "rightFootIndex1FK.rz";
connectAttr "joint87FK.s" "rightFootIndex1FK.is";
connectAttr "_rightFootIndex.uv[1]" "rightFootIndex1FK.sz";
connectAttr "_rightFootIndex.uv[2]" "rightFootIndex1FK.sy";
connectAttr "_rightFootIndex.uv[3]" "rightFootIndex1FK.sx";
connectAttr "_rightFootIndex.lv[1]" "rightFootIndex1FK.tz";
connectAttr "_rightFootIndex.lv[2]" "rightFootIndex1FK.ty";
connectAttr "_rightFootIndex.lv[3]" "rightFootIndex1FK.tx";
connectAttr "_rightFootIndex.av[4]" "rightFootIndex2FK.rz";
connectAttr "_rightFootIndex.av[5]" "rightFootIndex2FK.ry";
connectAttr "_rightFootIndex.av[6]" "rightFootIndex2FK.rx";
connectAttr "rightFootIndex1FK.s" "rightFootIndex2FK.is";
connectAttr "_rightFootIndex.uv[4]" "rightFootIndex2FK.sz";
connectAttr "_rightFootIndex.uv[5]" "rightFootIndex2FK.sy";
connectAttr "_rightFootIndex.uv[6]" "rightFootIndex2FK.sx";
connectAttr "_rightFootIndex.lv[4]" "rightFootIndex2FK.tz";
connectAttr "_rightFootIndex.lv[5]" "rightFootIndex2FK.ty";
connectAttr "_rightFootIndex.lv[6]" "rightFootIndex2FK.tx";
connectAttr "_leftLeg.uv[22]" "LeftFootEffPivot.rt";
connectAttr "_leftLeg.uv[21]" "LeftFootEffPivot.rr";
connectAttr "leftFoot.msg" "LeftFootEffPivot.jt";
connectAttr "leftFootFK.msg" "LeftFootEffPivot.fj";
connectAttr "_leftLeg.lv[25]" "LeftFootEffPivot.tz";
connectAttr "_leftLeg.lv[26]" "LeftFootEffPivot.ty";
connectAttr "_leftLeg.lv[27]" "LeftFootEffPivot.tx";
connectAttr "_leftLeg.av[25]" "LeftFootEffPivot.rz";
connectAttr "_leftLeg.av[26]" "LeftFootEffPivot.ry";
connectAttr "_leftLeg.av[27]" "LeftFootEffPivot.rx";
connectAttr "_rightLeg.uv[22]" "RightFootEffPivot.rt";
connectAttr "_rightLeg.uv[21]" "RightFootEffPivot.rr";
connectAttr "rightFoot.msg" "RightFootEffPivot.jt";
connectAttr "rightFootFK.msg" "RightFootEffPivot.fj";
connectAttr "_rightLeg.lv[25]" "RightFootEffPivot.tz";
connectAttr "_rightLeg.lv[26]" "RightFootEffPivot.ty";
connectAttr "_rightLeg.lv[27]" "RightFootEffPivot.tx";
connectAttr "_rightLeg.av[25]" "RightFootEffPivot.rz";
connectAttr "_rightLeg.av[26]" "RightFootEffPivot.ry";
connectAttr "_rightLeg.av[27]" "RightFootEffPivot.rx";
connectAttr "_leftLeg.uv[24]" "LeftFootEffPivot1.rt";
connectAttr "_leftLeg.uv[23]" "LeftFootEffPivot1.rr";
connectAttr "leftFoot.msg" "LeftFootEffPivot1.jt";
connectAttr "leftFootFK.msg" "LeftFootEffPivot1.fj";
connectAttr "_leftLeg.lv[28]" "LeftFootEffPivot1.tz";
connectAttr "_leftLeg.lv[29]" "LeftFootEffPivot1.ty";
connectAttr "_leftLeg.lv[30]" "LeftFootEffPivot1.tx";
connectAttr "_leftLeg.av[28]" "LeftFootEffPivot1.rz";
connectAttr "_leftLeg.av[29]" "LeftFootEffPivot1.ry";
connectAttr "_leftLeg.av[30]" "LeftFootEffPivot1.rx";
connectAttr "_rightLeg.uv[24]" "RightFootEffPivot1.rt";
connectAttr "_rightLeg.uv[23]" "RightFootEffPivot1.rr";
connectAttr "rightFoot.msg" "RightFootEffPivot1.jt";
connectAttr "rightFootFK.msg" "RightFootEffPivot1.fj";
connectAttr "_rightLeg.lv[28]" "RightFootEffPivot1.tz";
connectAttr "_rightLeg.lv[29]" "RightFootEffPivot1.ty";
connectAttr "_rightLeg.lv[30]" "RightFootEffPivot1.tx";
connectAttr "_rightLeg.av[28]" "RightFootEffPivot1.rz";
connectAttr "_rightLeg.av[29]" "RightFootEffPivot1.ry";
connectAttr "_rightLeg.av[30]" "RightFootEffPivot1.rx";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "_leftArm.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightArm.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftLeg.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightLeg.msg" "fbikCharacter.dnsm" -na;
connectAttr "_spine.msg" "fbikCharacter.dnsm" -na;
connectAttr "_head.msg" "fbikCharacter.dnsm" -na;
connectAttr "_hips.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftFingerPinky.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftFingerRing.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftFingerMiddle.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftFingerIndex.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftThumb.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightFingerPinky.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightFingerRing.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightFingerMiddle.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightFingerIndex.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightThumb.msg" "fbikCharacter.dnsm" -na;
connectAttr "_leftFootIndex.msg" "fbikCharacter.dnsm" -na;
connectAttr "_rightFootIndex.msg" "fbikCharacter.dnsm" -na;
connectAttr "leftShoulderFK.sz" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.sy" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.sx" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.rz" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.ry" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.rx" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.tz" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.ty" "_leftArm.dnsm" -na;
connectAttr "leftShoulderFK.tx" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.sz" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.sy" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.sx" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.rz" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.ry" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.rx" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.tz" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.ty" "_leftArm.dnsm" -na;
connectAttr "leftArmFK.tx" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.sz" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.sy" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.sx" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.rz" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.ry" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.rx" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.tz" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.ty" "_leftArm.dnsm" -na;
connectAttr "leftForearmFK.tx" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.sz" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.sy" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.sx" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.rz" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.ry" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.rx" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.tz" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.ty" "_leftArm.dnsm" -na;
connectAttr "leftForeArmRollFK.tx" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.sz" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.sy" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.sx" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.rz" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.ry" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.rx" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.tz" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.ty" "_leftArm.dnsm" -na;
connectAttr "leftHandFK.tx" "_leftArm.dnsm" -na;
connectAttr "joint23FK.sz" "_leftArm.dnsm" -na;
connectAttr "joint23FK.sy" "_leftArm.dnsm" -na;
connectAttr "joint23FK.sx" "_leftArm.dnsm" -na;
connectAttr "joint23FK.rz" "_leftArm.dnsm" -na;
connectAttr "joint23FK.ry" "_leftArm.dnsm" -na;
connectAttr "joint23FK.rx" "_leftArm.dnsm" -na;
connectAttr "joint23FK.tz" "_leftArm.dnsm" -na;
connectAttr "joint23FK.ty" "_leftArm.dnsm" -na;
connectAttr "joint23FK.tx" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.rr" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.rt" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.rz" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.ry" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.rx" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.tz" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.ty" "_leftArm.dnsm" -na;
connectAttr "LeftHandEff.tx" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.rr" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.rt" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.rz" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.ry" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.rx" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.tz" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.ty" "_leftArm.dnsm" -na;
connectAttr "LeftForeArmEff.tx" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.rr" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.rt" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.rz" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.ry" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.rx" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.tz" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.ty" "_leftArm.dnsm" -na;
connectAttr "LeftArmEff.tx" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.rr" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.rt" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.rz" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.ry" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.rx" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.tz" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.ty" "_leftArm.dnsm" -na;
connectAttr "LeftFingerBaseEff.tx" "_leftArm.dnsm" -na;
connectAttr "rightShoulderFK.sz" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.sy" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.sx" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.rz" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.ry" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.rx" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.tz" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.ty" "_rightArm.dnsm" -na;
connectAttr "rightShoulderFK.tx" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.sz" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.sy" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.sx" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.rz" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.ry" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.rx" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.tz" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.ty" "_rightArm.dnsm" -na;
connectAttr "rightArmFK.tx" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.sz" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.sy" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.sx" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.rz" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.ry" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.rx" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.tz" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.ty" "_rightArm.dnsm" -na;
connectAttr "rightForeArmFK.tx" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.sz" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.sy" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.sx" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.rz" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.ry" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.rx" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.tz" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.ty" "_rightArm.dnsm" -na;
connectAttr "rightForeArmRollFK.tx" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.sz" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.sy" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.sx" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.rz" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.ry" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.rx" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.tz" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.ty" "_rightArm.dnsm" -na;
connectAttr "rightHandFK.tx" "_rightArm.dnsm" -na;
connectAttr "joint67FK.sz" "_rightArm.dnsm" -na;
connectAttr "joint67FK.sy" "_rightArm.dnsm" -na;
connectAttr "joint67FK.sx" "_rightArm.dnsm" -na;
connectAttr "joint67FK.rz" "_rightArm.dnsm" -na;
connectAttr "joint67FK.ry" "_rightArm.dnsm" -na;
connectAttr "joint67FK.rx" "_rightArm.dnsm" -na;
connectAttr "joint67FK.tz" "_rightArm.dnsm" -na;
connectAttr "joint67FK.ty" "_rightArm.dnsm" -na;
connectAttr "joint67FK.tx" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.rr" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.rt" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.rz" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.ry" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.rx" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.tz" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.ty" "_rightArm.dnsm" -na;
connectAttr "RightHandEff.tx" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.rr" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.rt" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.rz" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.ry" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.rx" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.tz" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.ty" "_rightArm.dnsm" -na;
connectAttr "RightForeArmEff.tx" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.rr" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.rt" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.rz" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.ry" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.rx" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.tz" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.ty" "_rightArm.dnsm" -na;
connectAttr "RightArmEff.tx" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.rr" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.rt" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.rz" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.ry" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.rx" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.tz" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.ty" "_rightArm.dnsm" -na;
connectAttr "RightFingerBaseEff.tx" "_rightArm.dnsm" -na;
connectAttr "leftUpLegFK.sz" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.sy" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.sx" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.rz" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.ry" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.rx" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.tz" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.ty" "_leftLeg.dnsm" -na;
connectAttr "leftUpLegFK.tx" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.sz" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.sy" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.sx" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.rz" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.ry" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.rx" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.tz" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.ty" "_leftLeg.dnsm" -na;
connectAttr "leftLegFK.tx" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.sz" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.sy" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.sx" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.rz" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.ry" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.rx" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.tz" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.ty" "_leftLeg.dnsm" -na;
connectAttr "leftFootFK.tx" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.sz" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.sy" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.sx" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.rz" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.ry" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.rx" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.tz" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.ty" "_leftLeg.dnsm" -na;
connectAttr "joint86FK.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.rr" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.rt" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.rz" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.ry" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.rx" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.tz" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.ty" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEff.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.rr" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.rt" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.rz" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.ry" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.rx" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.tz" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.ty" "_leftLeg.dnsm" -na;
connectAttr "LeftLegEff.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.rr" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.rt" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.rz" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.ry" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.rx" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.tz" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.ty" "_leftLeg.dnsm" -na;
connectAttr "LeftToeBaseEff.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.rr" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.rt" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.rz" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.ry" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.rx" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.tz" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.ty" "_leftLeg.dnsm" -na;
connectAttr "LeftUpLegEff.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.rr" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.rt" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.tz" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.ty" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.rz" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.ry" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot.rx" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.rr" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.rt" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.tz" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.ty" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.tx" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.rz" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.ry" "_leftLeg.dnsm" -na;
connectAttr "LeftFootEffPivot1.rx" "_leftLeg.dnsm" -na;
connectAttr "rightUpLegFK.sz" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.sy" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.sx" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.rz" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.ry" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.rx" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.tz" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.ty" "_rightLeg.dnsm" -na;
connectAttr "rightUpLegFK.tx" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.sz" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.sy" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.sx" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.rz" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.ry" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.rx" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.tz" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.ty" "_rightLeg.dnsm" -na;
connectAttr "rightLegFK.tx" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.sz" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.sy" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.sx" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.rz" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.ry" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.rx" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.tz" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.ty" "_rightLeg.dnsm" -na;
connectAttr "rightFootFK.tx" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.sz" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.sy" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.sx" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.rz" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.ry" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.rx" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.tz" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.ty" "_rightLeg.dnsm" -na;
connectAttr "joint87FK.tx" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.rr" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.rt" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.rz" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.ry" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.rx" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.tz" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.ty" "_rightLeg.dnsm" -na;
connectAttr "RightFootEff.tx" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.rr" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.rt" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.rz" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.ry" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.rx" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.tz" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.ty" "_rightLeg.dnsm" -na;
connectAttr "RightLegEff.tx" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.rr" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.rt" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.rz" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.ry" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.rx" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.tz" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.ty" "_rightLeg.dnsm" -na;
connectAttr "RightToeBaseEff.tx" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.rr" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.rt" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.rz" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.ry" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.rx" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.tz" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.ty" "_rightLeg.dnsm" -na;
connectAttr "RightUpLegEff.tx" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.rr" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.rt" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.tz" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.ty" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.tx" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.rz" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.ry" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot.rx" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.rr" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.rt" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.tz" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.ty" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.tx" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.rz" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.ry" "_rightLeg.dnsm" -na;
connectAttr "RightFootEffPivot1.rx" "_rightLeg.dnsm" -na;
connectAttr "spineFK.sz" "_spine.dnsm" -na;
connectAttr "spineFK.sy" "_spine.dnsm" -na;
connectAttr "spineFK.sx" "_spine.dnsm" -na;
connectAttr "spineFK.rz" "_spine.dnsm" -na;
connectAttr "spineFK.ry" "_spine.dnsm" -na;
connectAttr "spineFK.rx" "_spine.dnsm" -na;
connectAttr "spineFK.tz" "_spine.dnsm" -na;
connectAttr "spineFK.ty" "_spine.dnsm" -na;
connectAttr "spineFK.tx" "_spine.dnsm" -na;
connectAttr "spine1FK.sz" "_spine.dnsm" -na;
connectAttr "spine1FK.sy" "_spine.dnsm" -na;
connectAttr "spine1FK.sx" "_spine.dnsm" -na;
connectAttr "spine1FK.rz" "_spine.dnsm" -na;
connectAttr "spine1FK.ry" "_spine.dnsm" -na;
connectAttr "spine1FK.rx" "_spine.dnsm" -na;
connectAttr "spine1FK.tz" "_spine.dnsm" -na;
connectAttr "spine1FK.ty" "_spine.dnsm" -na;
connectAttr "spine1FK.tx" "_spine.dnsm" -na;
connectAttr "SpineEff.rr" "_spine.dnsm" -na;
connectAttr "SpineEff.rt" "_spine.dnsm" -na;
connectAttr "SpineEff.rz" "_spine.dnsm" -na;
connectAttr "SpineEff.ry" "_spine.dnsm" -na;
connectAttr "SpineEff.rx" "_spine.dnsm" -na;
connectAttr "SpineEff.tz" "_spine.dnsm" -na;
connectAttr "SpineEff.ty" "_spine.dnsm" -na;
connectAttr "SpineEff.tx" "_spine.dnsm" -na;
connectAttr "NeckEff.rr" "_spine.dnsm" -na;
connectAttr "NeckEff.rt" "_spine.dnsm" -na;
connectAttr "NeckEff.rz" "_spine.dnsm" -na;
connectAttr "NeckEff.ry" "_spine.dnsm" -na;
connectAttr "NeckEff.rx" "_spine.dnsm" -na;
connectAttr "NeckEff.tz" "_spine.dnsm" -na;
connectAttr "NeckEff.ty" "_spine.dnsm" -na;
connectAttr "NeckEff.tx" "_spine.dnsm" -na;
connectAttr "neckFK.sz" "_head.dnsm" -na;
connectAttr "neckFK.sy" "_head.dnsm" -na;
connectAttr "neckFK.sx" "_head.dnsm" -na;
connectAttr "neckFK.rz" "_head.dnsm" -na;
connectAttr "neckFK.ry" "_head.dnsm" -na;
connectAttr "neckFK.rx" "_head.dnsm" -na;
connectAttr "neckFK.tz" "_head.dnsm" -na;
connectAttr "neckFK.ty" "_head.dnsm" -na;
connectAttr "neckFK.tx" "_head.dnsm" -na;
connectAttr "headFK.sz" "_head.dnsm" -na;
connectAttr "headFK.sy" "_head.dnsm" -na;
connectAttr "headFK.sx" "_head.dnsm" -na;
connectAttr "headFK.rz" "_head.dnsm" -na;
connectAttr "headFK.ry" "_head.dnsm" -na;
connectAttr "headFK.rx" "_head.dnsm" -na;
connectAttr "headFK.tz" "_head.dnsm" -na;
connectAttr "headFK.ty" "_head.dnsm" -na;
connectAttr "headFK.tx" "_head.dnsm" -na;
connectAttr "HeadEff.rr" "_head.dnsm" -na;
connectAttr "HeadEff.rt" "_head.dnsm" -na;
connectAttr "HeadEff.rz" "_head.dnsm" -na;
connectAttr "HeadEff.ry" "_head.dnsm" -na;
connectAttr "HeadEff.rx" "_head.dnsm" -na;
connectAttr "HeadEff.tz" "_head.dnsm" -na;
connectAttr "HeadEff.ty" "_head.dnsm" -na;
connectAttr "HeadEff.tx" "_head.dnsm" -na;
connectAttr "hipsFK.sz" "_hips.dnsm" -na;
connectAttr "hipsFK.sy" "_hips.dnsm" -na;
connectAttr "hipsFK.sx" "_hips.dnsm" -na;
connectAttr "hipsFK.rz" "_hips.dnsm" -na;
connectAttr "hipsFK.ry" "_hips.dnsm" -na;
connectAttr "hipsFK.rx" "_hips.dnsm" -na;
connectAttr "hipsFK.tz" "_hips.dnsm" -na;
connectAttr "hipsFK.ty" "_hips.dnsm" -na;
connectAttr "hipsFK.tx" "_hips.dnsm" -na;
connectAttr "HipsEff.rr" "_hips.dnsm" -na;
connectAttr "HipsEff.rt" "_hips.dnsm" -na;
connectAttr "HipsEff.rz" "_hips.dnsm" -na;
connectAttr "HipsEff.ry" "_hips.dnsm" -na;
connectAttr "HipsEff.rx" "_hips.dnsm" -na;
connectAttr "HipsEff.tz" "_hips.dnsm" -na;
connectAttr "HipsEff.ty" "_hips.dnsm" -na;
connectAttr "HipsEff.tx" "_hips.dnsm" -na;
connectAttr "leftHandPinky1FK.sz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.sy" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.sx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.rz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.ry" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.rx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.tz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.ty" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky1FK.tx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.sz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.sy" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.sx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.rz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.ry" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.rx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.tz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.ty" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky2FK.tx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.sz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.sy" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.sx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.rz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.ry" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.rx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.tz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.ty" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky3FK.tx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.sz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.sy" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.sx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.rz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.ry" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.rx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.tz" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.ty" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandPinky4FK.tx" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.rr" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.rt" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.rz" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.ry" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.rx" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.tz" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.ty" "_leftFingerPinky.dnsm" -na;
connectAttr "LeftHandPinky1Eff.tx" "_leftFingerPinky.dnsm" -na;
connectAttr "leftHandRing1FK.sz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.sy" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.sx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.rz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.ry" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.rx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.tz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.ty" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing1FK.tx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.sz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.sy" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.sx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.rz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.ry" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.rx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.tz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.ty" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing2FK.tx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.sz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.sy" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.sx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.rz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.ry" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.rx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.tz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.ty" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing3FK.tx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.sz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.sy" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.sx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.rz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.ry" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.rx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.tz" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.ty" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandRing4FK.tx" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.rr" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.rt" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.rz" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.ry" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.rx" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.tz" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.ty" "_leftFingerRing.dnsm" -na;
connectAttr "LeftHandRing1Eff.tx" "_leftFingerRing.dnsm" -na;
connectAttr "leftHandMiddle1FK.sz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.sy" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.sx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.rz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.ry" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.rx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.tz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.ty" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle1FK.tx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.sz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.sy" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.sx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.rz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.ry" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.rx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.tz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.ty" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle2FK.tx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.sz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.sy" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.sx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.rz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.ry" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.rx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.tz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.ty" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle3FK.tx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.sz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.sy" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.sx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.rz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.ry" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.rx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.tz" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.ty" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandMiddle4FK.tx" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.rr" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.rt" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.rz" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.ry" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.rx" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.tz" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.ty" "_leftFingerMiddle.dnsm" -na;
connectAttr "LeftHandMiddle1Eff.tx" "_leftFingerMiddle.dnsm" -na;
connectAttr "leftHandIndex1FK.sz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.sy" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.sx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.rz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.ry" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.rx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.tz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.ty" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex1FK.tx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.sz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.sy" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.sx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.rz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.ry" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.rx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.tz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.ty" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex2FK.tx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.sz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.sy" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.sx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.rz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.ry" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.rx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.tz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.ty" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex3FK.tx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.sz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.sy" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.sx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.rz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.ry" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.rx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.tz" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.ty" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandIndex4FK.tx" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.rr" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.rt" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.rz" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.ry" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.rx" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.tz" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.ty" "_leftFingerIndex.dnsm" -na;
connectAttr "LeftHandIndex1Eff.tx" "_leftFingerIndex.dnsm" -na;
connectAttr "leftHandThumb1FK.sz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.sy" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.sx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.rz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.ry" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.rx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.tz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.ty" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb1FK.tx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.sz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.sy" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.sx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.rz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.ry" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.rx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.tz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.ty" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb2FK.tx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.sz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.sy" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.sx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.rz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.ry" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.rx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.tz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.ty" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb3FK.tx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.sz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.sy" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.sx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.rz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.ry" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.rx" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.tz" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.ty" "_leftThumb.dnsm" -na;
connectAttr "leftHandThumb4FK.tx" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.rr" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.rt" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.rz" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.ry" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.rx" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.tz" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.ty" "_leftThumb.dnsm" -na;
connectAttr "LeftHandThumb1Eff.tx" "_leftThumb.dnsm" -na;
connectAttr "rightHandPinky1FK.sz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.sy" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.sx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.rz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.ry" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.rx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.tz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.ty" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky1FK.tx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.sz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.sy" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.sx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.rz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.ry" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.rx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.tz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.ty" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky2FK.tx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.sz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.sy" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.sx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.rz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.ry" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.rx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.tz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.ty" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky3FK.tx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.sz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.sy" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.sx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.rz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.ry" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.rx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.tz" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.ty" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandPinky4FK.tx" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.rr" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.rt" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.rz" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.ry" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.rx" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.tz" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.ty" "_rightFingerPinky.dnsm" -na;
connectAttr "RightHandPinky1Eff.tx" "_rightFingerPinky.dnsm" -na;
connectAttr "rightHandRing1FK.sz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.sy" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.sx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.rz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.ry" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.rx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.tz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.ty" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing1FK.tx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.sz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.sy" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.sx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.rz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.ry" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.rx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.tz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.ty" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing2FK.tx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.sz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.sy" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.sx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.rz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.ry" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.rx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.tz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.ty" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing3FK.tx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.sz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.sy" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.sx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.rz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.ry" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.rx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.tz" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.ty" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandRing4FK.tx" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.rr" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.rt" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.rz" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.ry" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.rx" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.tz" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.ty" "_rightFingerRing.dnsm" -na;
connectAttr "RightHandRing1Eff.tx" "_rightFingerRing.dnsm" -na;
connectAttr "rightHandMiddle1FK.sz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.sy" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.sx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.rz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.ry" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.rx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.tz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.ty" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle1FK.tx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.sz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.sy" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.sx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.rz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.ry" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.rx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.tz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.ty" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle2FK.tx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.sz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.sy" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.sx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.rz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.ry" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.rx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.tz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.ty" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle3FK.tx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.sz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.sy" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.sx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.rz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.ry" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.rx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.tz" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.ty" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandMiddle4FK.tx" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.rr" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.rt" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.rz" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.ry" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.rx" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.tz" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.ty" "_rightFingerMiddle.dnsm" -na;
connectAttr "RightHandMiddle1Eff.tx" "_rightFingerMiddle.dnsm" -na;
connectAttr "rightHandIndex1FK.sz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.sy" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.sx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.rz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.ry" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.rx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.tz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.ty" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex1FK.tx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.sz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.sy" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.sx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.rz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.ry" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.rx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.tz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.ty" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex2FK.tx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.sz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.sy" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.sx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.rz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.ry" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.rx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.tz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.ty" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex3FK.tx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.sz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.sy" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.sx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.rz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.ry" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.rx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.tz" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.ty" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandIndex4FK.tx" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.rr" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.rt" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.rz" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.ry" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.rx" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.tz" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.ty" "_rightFingerIndex.dnsm" -na;
connectAttr "RightHandIndex1Eff.tx" "_rightFingerIndex.dnsm" -na;
connectAttr "rightHandThumb1FK.sz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.sy" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.sx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.rz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.ry" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.rx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.tz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.ty" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb1FK.tx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.sz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.sy" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.sx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.rz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.ry" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.rx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.tz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.ty" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb2FK.tx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.sz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.sy" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.sx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.rz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.ry" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.rx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.tz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.ty" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb3FK.tx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.sz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.sy" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.sx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.rz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.ry" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.rx" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.tz" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.ty" "_rightThumb.dnsm" -na;
connectAttr "rightHandThumb4FK.tx" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.rr" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.rt" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.rz" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.ry" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.rx" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.tz" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.ty" "_rightThumb.dnsm" -na;
connectAttr "RightHandThumb1Eff.tx" "_rightThumb.dnsm" -na;
connectAttr "leftFootIndex1FK.sz" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.sy" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.sx" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.rz" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.ry" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.rx" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.tz" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.ty" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex1FK.tx" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.sz" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.sy" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.sx" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.rz" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.ry" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.rx" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.tz" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.ty" "_leftFootIndex.dnsm" -na;
connectAttr "leftFootIndex2FK.tx" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.rr" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.rt" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.rz" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.ry" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.rx" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.tz" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.ty" "_leftFootIndex.dnsm" -na;
connectAttr "LeftFootIndex1Eff.tx" "_leftFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.sz" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.sy" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.sx" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.rz" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.ry" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.rx" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.tz" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.ty" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex1FK.tx" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.sz" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.sy" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.sx" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.rz" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.ry" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.rx" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.tz" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.ty" "_rightFootIndex.dnsm" -na;
connectAttr "rightFootIndex2FK.tx" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.rr" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.rt" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.rz" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.ry" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.rx" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.tz" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.ty" "_rightFootIndex.dnsm" -na;
connectAttr "RightFootIndex1Eff.tx" "_rightFootIndex.dnsm" -na;
connectAttr "JackieSkeleton.msg" "hikStancePose.m[0]";
connectAttr "hips.msg" "hikStancePose.m[1]";
connectAttr "spine.msg" "hikStancePose.m[2]";
connectAttr "spine1.msg" "hikStancePose.m[3]";
connectAttr "xxy.msg" "hikStancePose.m[4]";
connectAttr "xxx.msg" "hikStancePose.m[5]";
connectAttr "neck.msg" "hikStancePose.m[6]";
connectAttr "head.msg" "hikStancePose.m[7]";
connectAttr "joint44.msg" "hikStancePose.m[8]";
connectAttr "jointFlexor2.msg" "hikStancePose.m[9]";
connectAttr "jointFlexor1.msg" "hikStancePose.m[10]";
connectAttr "leftShoulder.msg" "hikStancePose.m[11]";
connectAttr "leftArm.msg" "hikStancePose.m[12]";
connectAttr "leftForearm.msg" "hikStancePose.m[13]";
connectAttr "leftForeArmRoll.msg" "hikStancePose.m[14]";
connectAttr "leftHand.msg" "hikStancePose.m[15]";
connectAttr "joint13.msg" "hikStancePose.m[16]";
connectAttr "leftHandPinky1.msg" "hikStancePose.m[17]";
connectAttr "leftHandPinky2.msg" "hikStancePose.m[18]";
connectAttr "leftHandPinky3.msg" "hikStancePose.m[19]";
connectAttr "leftHandPinky4.msg" "hikStancePose.m[20]";
connectAttr "joint18.msg" "hikStancePose.m[21]";
connectAttr "leftHandRing1.msg" "hikStancePose.m[22]";
connectAttr "leftHandRing2.msg" "hikStancePose.m[23]";
connectAttr "leftHandRing3.msg" "hikStancePose.m[24]";
connectAttr "leftHandRing4.msg" "hikStancePose.m[25]";
connectAttr "joint23.msg" "hikStancePose.m[26]";
connectAttr "leftHandMiddle1.msg" "hikStancePose.m[27]";
connectAttr "leftHandMiddle2.msg" "hikStancePose.m[28]";
connectAttr "leftHandMiddle3.msg" "hikStancePose.m[29]";
connectAttr "leftHandMiddle4.msg" "hikStancePose.m[30]";
connectAttr "joint28.msg" "hikStancePose.m[31]";
connectAttr "leftHandIndex1.msg" "hikStancePose.m[32]";
connectAttr "leftHandIndex2.msg" "hikStancePose.m[33]";
connectAttr "leftHandIndex3.msg" "hikStancePose.m[34]";
connectAttr "leftHandIndex4.msg" "hikStancePose.m[35]";
connectAttr "leftHandThumb1.msg" "hikStancePose.m[36]";
connectAttr "leftHandThumb2.msg" "hikStancePose.m[37]";
connectAttr "leftHandThumb3.msg" "hikStancePose.m[38]";
connectAttr "leftHandThumb4.msg" "hikStancePose.m[39]";
connectAttr "rightShoulder.msg" "hikStancePose.m[40]";
connectAttr "rightArm.msg" "hikStancePose.m[41]";
connectAttr "rightForeArm.msg" "hikStancePose.m[42]";
connectAttr "rightForeArmRoll.msg" "hikStancePose.m[43]";
connectAttr "rightHand.msg" "hikStancePose.m[44]";
connectAttr "joint57.msg" "hikStancePose.m[45]";
connectAttr "rightHandPinky1.msg" "hikStancePose.m[46]";
connectAttr "rightHandPinky2.msg" "hikStancePose.m[47]";
connectAttr "rightHandPinky3.msg" "hikStancePose.m[48]";
connectAttr "rightHandPinky4.msg" "hikStancePose.m[49]";
connectAttr "joint62.msg" "hikStancePose.m[50]";
connectAttr "rightHandRing1.msg" "hikStancePose.m[51]";
connectAttr "rightHandRing2.msg" "hikStancePose.m[52]";
connectAttr "rightHandRing3.msg" "hikStancePose.m[53]";
connectAttr "rightHandRing4.msg" "hikStancePose.m[54]";
connectAttr "joint67.msg" "hikStancePose.m[55]";
connectAttr "rightHandMiddle1.msg" "hikStancePose.m[56]";
connectAttr "rightHandMiddle2.msg" "hikStancePose.m[57]";
connectAttr "rightHandMiddle3.msg" "hikStancePose.m[58]";
connectAttr "rightHandMiddle4.msg" "hikStancePose.m[59]";
connectAttr "joint72.msg" "hikStancePose.m[60]";
connectAttr "rightHandIndex1.msg" "hikStancePose.m[61]";
connectAttr "rightHandIndex2.msg" "hikStancePose.m[62]";
connectAttr "rightHandIndex3.msg" "hikStancePose.m[63]";
connectAttr "rightHandIndex4.msg" "hikStancePose.m[64]";
connectAttr "rightHandThumb1.msg" "hikStancePose.m[65]";
connectAttr "rightHandThumb2.msg" "hikStancePose.m[66]";
connectAttr "rightHandThumb3.msg" "hikStancePose.m[67]";
connectAttr "rightHandThumb4.msg" "hikStancePose.m[68]";
connectAttr "leftUpLeg.msg" "hikStancePose.m[69]";
connectAttr "leftLeg.msg" "hikStancePose.m[70]";
connectAttr "leftFoot.msg" "hikStancePose.m[71]";
connectAttr "joint86.msg" "hikStancePose.m[72]";
connectAttr "leftFootIndex1.msg" "hikStancePose.m[73]";
connectAttr "leftFootIndex2.msg" "hikStancePose.m[74]";
connectAttr "rightUpLeg.msg" "hikStancePose.m[75]";
connectAttr "rightLeg.msg" "hikStancePose.m[76]";
connectAttr "rightFoot.msg" "hikStancePose.m[77]";
connectAttr "joint87.msg" "hikStancePose.m[78]";
connectAttr "rightFootIndex1.msg" "hikStancePose.m[79]";
connectAttr "rightFootIndex2.msg" "hikStancePose.m[80]";
connectAttr "hikStancePose.w" "hikStancePose.p[0]";
connectAttr "hikStancePose.m[0]" "hikStancePose.p[1]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[2]";
connectAttr "hikStancePose.m[2]" "hikStancePose.p[3]";
connectAttr "hikStancePose.m[3]" "hikStancePose.p[4]";
connectAttr "hikStancePose.m[4]" "hikStancePose.p[5]";
connectAttr "hikStancePose.m[5]" "hikStancePose.p[6]";
connectAttr "hikStancePose.m[6]" "hikStancePose.p[7]";
connectAttr "hikStancePose.m[7]" "hikStancePose.p[8]";
connectAttr "hikStancePose.m[7]" "hikStancePose.p[9]";
connectAttr "hikStancePose.m[6]" "hikStancePose.p[10]";
connectAttr "hikStancePose.m[5]" "hikStancePose.p[11]";
connectAttr "hikStancePose.m[11]" "hikStancePose.p[12]";
connectAttr "hikStancePose.m[12]" "hikStancePose.p[13]";
connectAttr "hikStancePose.m[13]" "hikStancePose.p[14]";
connectAttr "hikStancePose.m[14]" "hikStancePose.p[15]";
connectAttr "hikStancePose.m[15]" "hikStancePose.p[16]";
connectAttr "hikStancePose.m[16]" "hikStancePose.p[17]";
connectAttr "hikStancePose.m[17]" "hikStancePose.p[18]";
connectAttr "hikStancePose.m[18]" "hikStancePose.p[19]";
connectAttr "hikStancePose.m[19]" "hikStancePose.p[20]";
connectAttr "hikStancePose.m[15]" "hikStancePose.p[21]";
connectAttr "hikStancePose.m[21]" "hikStancePose.p[22]";
connectAttr "hikStancePose.m[22]" "hikStancePose.p[23]";
connectAttr "hikStancePose.m[23]" "hikStancePose.p[24]";
connectAttr "hikStancePose.m[24]" "hikStancePose.p[25]";
connectAttr "hikStancePose.m[15]" "hikStancePose.p[26]";
connectAttr "hikStancePose.m[26]" "hikStancePose.p[27]";
connectAttr "hikStancePose.m[27]" "hikStancePose.p[28]";
connectAttr "hikStancePose.m[28]" "hikStancePose.p[29]";
connectAttr "hikStancePose.m[29]" "hikStancePose.p[30]";
connectAttr "hikStancePose.m[15]" "hikStancePose.p[31]";
connectAttr "hikStancePose.m[31]" "hikStancePose.p[32]";
connectAttr "hikStancePose.m[32]" "hikStancePose.p[33]";
connectAttr "hikStancePose.m[33]" "hikStancePose.p[34]";
connectAttr "hikStancePose.m[34]" "hikStancePose.p[35]";
connectAttr "hikStancePose.m[15]" "hikStancePose.p[36]";
connectAttr "hikStancePose.m[36]" "hikStancePose.p[37]";
connectAttr "hikStancePose.m[37]" "hikStancePose.p[38]";
connectAttr "hikStancePose.m[38]" "hikStancePose.p[39]";
connectAttr "hikStancePose.m[5]" "hikStancePose.p[40]";
connectAttr "hikStancePose.m[40]" "hikStancePose.p[41]";
connectAttr "hikStancePose.m[41]" "hikStancePose.p[42]";
connectAttr "hikStancePose.m[42]" "hikStancePose.p[43]";
connectAttr "hikStancePose.m[43]" "hikStancePose.p[44]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[45]";
connectAttr "hikStancePose.m[45]" "hikStancePose.p[46]";
connectAttr "hikStancePose.m[46]" "hikStancePose.p[47]";
connectAttr "hikStancePose.m[47]" "hikStancePose.p[48]";
connectAttr "hikStancePose.m[48]" "hikStancePose.p[49]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[50]";
connectAttr "hikStancePose.m[50]" "hikStancePose.p[51]";
connectAttr "hikStancePose.m[51]" "hikStancePose.p[52]";
connectAttr "hikStancePose.m[52]" "hikStancePose.p[53]";
connectAttr "hikStancePose.m[53]" "hikStancePose.p[54]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[55]";
connectAttr "hikStancePose.m[55]" "hikStancePose.p[56]";
connectAttr "hikStancePose.m[56]" "hikStancePose.p[57]";
connectAttr "hikStancePose.m[57]" "hikStancePose.p[58]";
connectAttr "hikStancePose.m[58]" "hikStancePose.p[59]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[60]";
connectAttr "hikStancePose.m[60]" "hikStancePose.p[61]";
connectAttr "hikStancePose.m[61]" "hikStancePose.p[62]";
connectAttr "hikStancePose.m[62]" "hikStancePose.p[63]";
connectAttr "hikStancePose.m[63]" "hikStancePose.p[64]";
connectAttr "hikStancePose.m[44]" "hikStancePose.p[65]";
connectAttr "hikStancePose.m[65]" "hikStancePose.p[66]";
connectAttr "hikStancePose.m[66]" "hikStancePose.p[67]";
connectAttr "hikStancePose.m[67]" "hikStancePose.p[68]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[69]";
connectAttr "hikStancePose.m[69]" "hikStancePose.p[70]";
connectAttr "hikStancePose.m[70]" "hikStancePose.p[71]";
connectAttr "hikStancePose.m[71]" "hikStancePose.p[72]";
connectAttr "hikStancePose.m[72]" "hikStancePose.p[73]";
connectAttr "hikStancePose.m[73]" "hikStancePose.p[74]";
connectAttr "hikStancePose.m[1]" "hikStancePose.p[75]";
connectAttr "hikStancePose.m[75]" "hikStancePose.p[76]";
connectAttr "hikStancePose.m[76]" "hikStancePose.p[77]";
connectAttr "hikStancePose.m[77]" "hikStancePose.p[78]";
connectAttr "hikStancePose.m[78]" "hikStancePose.p[79]";
connectAttr "hikStancePose.m[79]" "hikStancePose.p[80]";
connectAttr "hikStancePose.m[0]" "hikStancePose.p[81]";
connectAttr "hikStancePose.m[81]" "hikStancePose.p[82]";
connectAttr "hikStancePose.m[82]" "hikStancePose.p[83]";
connectAttr "hikStancePose.m[83]" "hikStancePose.p[84]";
connectAttr "hikStancePose.m[84]" "hikStancePose.p[85]";
connectAttr "hikStancePose.m[85]" "hikStancePose.p[86]";
connectAttr "hikStancePose.m[86]" "hikStancePose.p[87]";
connectAttr "hikStancePose.m[87]" "hikStancePose.p[88]";
connectAttr "hikStancePose.m[87]" "hikStancePose.p[89]";
connectAttr "hikStancePose.m[86]" "hikStancePose.p[90]";
connectAttr "hikStancePose.m[85]" "hikStancePose.p[91]";
connectAttr "hikStancePose.m[91]" "hikStancePose.p[92]";
connectAttr "hikStancePose.m[92]" "hikStancePose.p[93]";
connectAttr "hikStancePose.m[93]" "hikStancePose.p[94]";
connectAttr "hikStancePose.m[94]" "hikStancePose.p[95]";
connectAttr "hikStancePose.m[95]" "hikStancePose.p[96]";
connectAttr "hikStancePose.m[96]" "hikStancePose.p[97]";
connectAttr "hikStancePose.m[97]" "hikStancePose.p[98]";
connectAttr "hikStancePose.m[98]" "hikStancePose.p[99]";
connectAttr "hikStancePose.m[99]" "hikStancePose.p[100]";
connectAttr "hikStancePose.m[95]" "hikStancePose.p[101]";
connectAttr "hikStancePose.m[101]" "hikStancePose.p[102]";
connectAttr "hikStancePose.m[102]" "hikStancePose.p[103]";
connectAttr "hikStancePose.m[103]" "hikStancePose.p[104]";
connectAttr "hikStancePose.m[104]" "hikStancePose.p[105]";
connectAttr "hikStancePose.m[95]" "hikStancePose.p[106]";
connectAttr "hikStancePose.m[106]" "hikStancePose.p[107]";
connectAttr "hikStancePose.m[107]" "hikStancePose.p[108]";
connectAttr "hikStancePose.m[108]" "hikStancePose.p[109]";
connectAttr "hikStancePose.m[109]" "hikStancePose.p[110]";
connectAttr "hikStancePose.m[95]" "hikStancePose.p[111]";
connectAttr "hikStancePose.m[111]" "hikStancePose.p[112]";
connectAttr "hikStancePose.m[112]" "hikStancePose.p[113]";
connectAttr "hikStancePose.m[113]" "hikStancePose.p[114]";
connectAttr "hikStancePose.m[114]" "hikStancePose.p[115]";
connectAttr "hikStancePose.m[95]" "hikStancePose.p[116]";
connectAttr "hikStancePose.m[116]" "hikStancePose.p[117]";
connectAttr "hikStancePose.m[117]" "hikStancePose.p[118]";
connectAttr "hikStancePose.m[118]" "hikStancePose.p[119]";
connectAttr "hikStancePose.m[85]" "hikStancePose.p[120]";
connectAttr "hikStancePose.m[120]" "hikStancePose.p[121]";
connectAttr "hikStancePose.m[121]" "hikStancePose.p[122]";
connectAttr "hikStancePose.m[122]" "hikStancePose.p[123]";
connectAttr "hikStancePose.m[123]" "hikStancePose.p[124]";
connectAttr "hikStancePose.m[124]" "hikStancePose.p[125]";
connectAttr "hikStancePose.m[125]" "hikStancePose.p[126]";
connectAttr "hikStancePose.m[126]" "hikStancePose.p[127]";
connectAttr "hikStancePose.m[127]" "hikStancePose.p[128]";
connectAttr "hikStancePose.m[128]" "hikStancePose.p[129]";
connectAttr "hikStancePose.m[124]" "hikStancePose.p[130]";
connectAttr "hikStancePose.m[130]" "hikStancePose.p[131]";
connectAttr "hikStancePose.m[131]" "hikStancePose.p[132]";
connectAttr "hikStancePose.m[132]" "hikStancePose.p[133]";
connectAttr "hikStancePose.m[133]" "hikStancePose.p[134]";
connectAttr "hikStancePose.m[124]" "hikStancePose.p[135]";
connectAttr "hikStancePose.m[135]" "hikStancePose.p[136]";
connectAttr "hikStancePose.m[136]" "hikStancePose.p[137]";
connectAttr "hikStancePose.m[137]" "hikStancePose.p[138]";
connectAttr "hikStancePose.m[138]" "hikStancePose.p[139]";
connectAttr "hikStancePose.m[124]" "hikStancePose.p[140]";
connectAttr "hikStancePose.m[140]" "hikStancePose.p[141]";
connectAttr "hikStancePose.m[141]" "hikStancePose.p[142]";
connectAttr "hikStancePose.m[142]" "hikStancePose.p[143]";
connectAttr "hikStancePose.m[143]" "hikStancePose.p[144]";
connectAttr "hikStancePose.m[124]" "hikStancePose.p[145]";
connectAttr "hikStancePose.m[145]" "hikStancePose.p[146]";
connectAttr "hikStancePose.m[146]" "hikStancePose.p[147]";
connectAttr "hikStancePose.m[147]" "hikStancePose.p[148]";
connectAttr "hikStancePose.m[81]" "hikStancePose.p[149]";
connectAttr "hikStancePose.m[149]" "hikStancePose.p[150]";
connectAttr "hikStancePose.m[150]" "hikStancePose.p[151]";
connectAttr "hikStancePose.m[151]" "hikStancePose.p[152]";
connectAttr "hikStancePose.m[152]" "hikStancePose.p[153]";
connectAttr "hikStancePose.m[81]" "hikStancePose.p[154]";
connectAttr "hikStancePose.m[154]" "hikStancePose.p[155]";
connectAttr "hikStancePose.m[155]" "hikStancePose.p[156]";
connectAttr "hikStancePose.m[156]" "hikStancePose.p[157]";
connectAttr "hikStancePose.m[157]" "hikStancePose.p[158]";
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "fbikCharacter.pa" ":characterPartition.st" -na;
// End of bipedExample.ma
