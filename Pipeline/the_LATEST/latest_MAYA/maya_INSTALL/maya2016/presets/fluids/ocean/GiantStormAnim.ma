//Maya ASCII 5.0ff03 scene
//Name: GiantStormAnim.ma
//Last modified: Mon, Jan 13, 2003 02:49:49 PM
requires maya "5.0ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0 Beta";
fileInfo "version" "5.0Beta2";
fileInfo "cutIdentifier" "200301100011";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" 37.787971250901521 77.648461073589417 138.5591774048892 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.829 0.92208099 1 ;
createNode transform -n "fluid1";
	setAttr ".t" -type "double3" 0 6.5585462355014172 0 ;
	setAttr ".s" -type "double3" 23.529582149213734 23.529582149213734 23.529582149213734 ;
createNode fluidShape -n "fluidShape1" -p "fluid1";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 30;
	setAttr ".rh" 3;
	setAttr ".rd" 30;
	setAttr ".dw" 20;
	setAttr ".dh" 2;
	setAttr ".dd" 20;
	setAttr ".wdp" 0;
	setAttr ".ots" 1;
	setAttr ".dmt" 0;
	setAttr ".vmt" 0;
	setAttr -s 5 ".cl";
	setAttr ".cl[0].clp" 0.44285714626312256;
	setAttr ".cl[0].clc" -type "float3" 0.046746004 0.097758584 0.147 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.67142856121063232;
	setAttr ".cl[1].clc" -type "float3" 0.072929993 0.18983126 0.221 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".cl[2].clp" 0.93571430444717407;
	setAttr ".cl[2].clc" -type "float3" 0.32096797 0.40231174 0.42399999 ;
	setAttr ".cl[2].cli" 1;
	setAttr ".cl[3].clp" 0;
	setAttr ".cl[3].clc" -type "float3" 0.61426198 0.66695166 0.68099999 ;
	setAttr ".cl[3].cli" 1;
	setAttr ".cl[4].clp" 0.20714299380779266;
	setAttr ".cl[4].clc" -type "float3" 0.25833499 0.31348842 0.42699999 ;
	setAttr ".cl[4].cli" 1;
	setAttr -s 5 ".opa";
	setAttr ".opa[1:3]" 0.64999997615814209 0.74000000953674316 1 
		0.25714287161827087 0 1 1 0.89999997615814209 1;
	setAttr ".opa[5:6]" 0.75714302062988281 0.86000001430511475 1 
		0.55000001192092896 0.14000000059604645 1;
	setAttr ".opi" 2;
	setAttr ".oib" 0.34784001111984253;
	setAttr ".t" -type "float3" 0.54509807 0.54509807 0.54509807 ;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0.54285717010498047;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.02857142873108387;
	setAttr ".i[1].ic" -type "float3" 0.109248 0.13986623 0.192 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 0.27142858505249023;
	setAttr ".i[2].ic" -type "float3" 0.052431997 0.086763956 0.113 ;
	setAttr ".i[2].ii" 1;
	setAttr ".ili" 4;
	setAttr ".iib" -0.58696001768112183;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 1;
	setAttr ".edr" 0.077679999172687531;
	setAttr ".ctl" 0.019999999552965164;
	setAttr ".rl" no;
	setAttr ".ctx" yes;
	setAttr ".ctxg" 0.95143997669219971;
	setAttr ".itx" yes;
	setAttr ".itxg" 0.44659999012947083;
	setAttr ".otx" yes;
	setAttr ".ra" 0.77670001983642578;
	setAttr ".fq" 6.6989998817443848;
	setAttr ".fr" 3.0097999572753906;
createNode transform -n "oceanPlane1";
	setAttr ".s" -type "double3" 756.82234018329189 756.82234018329189 756.82234018329189 ;
createNode nurbsSurface -n "oceanPlaneShape1" -p "oceanPlane1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".ovs" no;
	setAttr ".ovt" no;
	setAttr ".ovp" no;
	setAttr ".ove" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 121 ".cp[0:120]" -type "double3" 0.14677356245004036 
		4.1577566360353477e-017 -0.14677356245004036 0.13166760969656849 3.4190198363577702e-017 
		-0.12069530888852098 0.098944563191612989 2.1021535180232667e-017 -0.074208422393709728 
		0.053414235837186408 7.5655107705930314e-018 -0.026707117918593204 0.010632473589959279 
		7.529836587766168e-019 -0.0026581183974898198 0 0 0 0.010632473589959279 
		-7.529836587766168e-019 0.0026581183974898198 0.053414235837186408 -7.5655107705930314e-018 
		0.026707117918593204 0.098944563191612989 -2.1021535180232667e-017 0.074208422393709728 
		0.13166760969656849 -3.4190198363577702e-017 0.12069530888852098 0.14677356245004036 
		-4.1577566360353477e-017 0.14677356245004036 0.12069530888852098 3.7298398214811989e-017 
		-0.13166760969656849 0.22334387636476571 6.3268170954803047e-017 -0.22334387636476571 
		0.20528885641474087 4.7580218233829302e-017 -0.16796360979387873 0.18328848333292425 
		2.8320764504006899e-017 -0.099975536363413248 0.16953425189925797 1.3097766799348588e-017 
		-0.046236614154343061 0.16847234378759496 0 0 0.16953425189925797 -1.3097766799348588e-017 
		0.046236614154343061 0.18328848333292425 -2.8320764504006899e-017 0.099975536363413248 
		0.20528885641474087 -4.7580218233829302e-017 0.16796360979387873 0.22334387636476571 
		-6.3268170954803047e-017 0.22334387636476571 0.12069530888852098 -3.7298398214811989e-017 
		0.13166760969656849 0.074208422393709728 2.802871357364368e-017 -0.098944563191612989 
		0.16796360979387873 5.8153600063569208e-017 -0.20528885641474087 0.25261524985034939 
		7.1560076208310855e-017 -0.25261524985034939 0.2328661834254368 4.3977080671454716e-017 
		-0.15524412228362444 0.21975098660657011 2.0750129373600711e-017 -0.073250328868856712 
		0.21711251513877425 0 0 0.21975098660657011 -2.0750129373600717e-017 0.07325032886885674 
		0.2328661834254368 -4.3977080671454716e-017 0.15524412228362444 0.25261524985034939 
		-7.1560076208310855e-017 0.25261524985034939 0.16796360979387873 -5.8153600063569208e-017 
		0.20528885641474087 0.074208422393709728 -2.802871357364368e-017 0.098944563191612989 
		0.026707117918593204 1.5131021541186063e-017 -0.053414235837186408 0.099975536363413248 
		5.1921401590679278e-017 -0.18328848333292425 0.15524412228362444 6.596562100718207e-017 
		-0.2328661834254368 0.19453643315744718 5.5107686453160644e-017 -0.19453643315744718 
		0.18854460657107269 2.6705170061753666e-017 -0.094272303285536346 0.18509276456554621 
		0 0 0.18854460657107269 -2.6705170061753672e-017 0.094272303285536374 0.19453643315744718 
		-5.5107686453160644e-017 0.19453643315744718 0.15524412228362444 -6.596562100718207e-017 
		0.2328661834254368 0.099975536363413248 -5.1921401590679278e-017 0.18328848333292425 
		0.026707117918593204 -1.5131021541186063e-017 0.053414235837186408 0.0026581183974898198 
		3.0119346351064672e-018 -0.010632473589959279 0.046236614154343061 4.8025144930944805e-017 
		-0.16953425189925797 0.073250328868856712 6.225038812080218e-017 -0.21975098660657011 
		0.094272303285536346 5.3410340123507332e-017 -0.18854460657107269 0.10796038170857056 
		3.0582687098741499e-017 -0.10796038170857056 0.10450853970304411 4.6659014702819536e-034 
		-1.0506676061454628e-018 0.10796038170857056 -3.0582687098741499e-017 0.10796038170857059 
		0.094272303285536346 -5.3410340123507332e-017 0.18854460657107269 0.073250328868856712 
		-6.225038812080218e-017 0.21975098660657011 0.046236614154343061 -4.8025144930944805e-017 
		0.16953425189925797 0.0026581183974898198 -3.0119346351064672e-018 0.010632473589959279 
		0 0 0 0 4.7724330845327099e-017 -0.16847234378759496 0 6.1502969984245581e-017 
		-0.21711251513877425 0 5.2432512865965072e-017 -0.18509276456554621 1.0506676061454628e-018 
		2.9604859841199233e-017 -0.10450853970304411 1.0506676061454628e-018 4.6659014702819536e-034 
		-1.0506676061454628e-018 1.0506676061454628e-018 -2.9604859841199233e-017 
		0.10450853970304413 0 -5.2432512865965072e-017 0.18509276456554621 0 -6.1502969984245581e-017 
		0.21711251513877425 0 -4.7724330845327099e-017 0.16847234378759496 0 0 0 
		-0.0026581183974898198 3.0119346351064672e-018 -0.010632473589959279 -0.046236614154343061 
		4.8025144930944805e-017 -0.16953425189925797 -0.07325032886885674 6.225038812080218e-017 
		-0.21975098660657011 -0.094272303285536374 5.3410340123507332e-017 -0.18854460657107269 
		-0.10796038170857059 3.0582687098741499e-017 -0.10796038170857056 -0.10450853970304413 
		4.6659014702819536e-034 -1.0506676061454628e-018 -0.10796038170857059 -3.0582687098741499e-017 
		0.10796038170857059 -0.094272303285536374 -5.3410340123507332e-017 0.18854460657107269 
		-0.07325032886885674 -6.225038812080218e-017 0.21975098660657011 -0.046236614154343061 
		-4.8025144930944805e-017 0.16953425189925797 -0.0026581183974898198 -3.0119346351064672e-018 
		0.010632473589959279 -0.026707117918593204 1.5131021541186063e-017 -0.053414235837186408 
		-0.099975536363413248 5.1921401590679278e-017 -0.18328848333292425 -0.15524412228362444 
		6.596562100718207e-017 -0.2328661834254368 -0.19453643315744718 5.5107686453160644e-017 
		-0.19453643315744718 -0.18854460657107269 2.6705170061753666e-017 -0.094272303285536346 
		-0.18509276456554621 0 0 -0.18854460657107269 -2.6705170061753672e-017 0.094272303285536374 
		-0.19453643315744718 -5.5107686453160644e-017 0.19453643315744718 -0.15524412228362444 
		-6.596562100718207e-017 0.2328661834254368 -0.099975536363413248 -5.1921401590679278e-017 
		0.18328848333292425 -0.026707117918593204 -1.5131021541186063e-017 0.053414235837186408 
		-0.074208422393709728 2.802871357364368e-017 -0.098944563191612989 -0.16796360979387873 
		5.8153600063569208e-017 -0.20528885641474087 -0.25261524985034939 7.1560076208310855e-017 
		-0.25261524985034939 -0.2328661834254368 4.3977080671454716e-017 -0.15524412228362444 
		-0.21975098660657011 2.0750129373600711e-017 -0.073250328868856712 -0.21711251513877425 
		0 0 -0.21975098660657011 -2.0750129373600717e-017 0.07325032886885674 -0.2328661834254368 
		-4.3977080671454716e-017 0.15524412228362444 -0.25261524985034939 -7.1560076208310855e-017 
		0.25261524985034939 -0.16796360979387873 -5.8153600063569208e-017 0.20528885641474087 
		-0.074208422393709728 -2.802871357364368e-017 0.098944563191612989 -0.12069530888852098 
		3.7298398214811989e-017 -0.13166760969656849 -0.22334387636476571 6.3268170954803047e-017 
		-0.22334387636476571 -0.20528885641474087 4.7580218233829302e-017 -0.16796360979387873 
		-0.18328848333292425 2.8320764504006899e-017 -0.099975536363413248 -0.16953425189925797 
		1.3097766799348588e-017 -0.046236614154343061 -0.16847234378759496 0 0 -0.16953425189925797 
		-1.3097766799348588e-017 0.046236614154343061 -0.18328848333292425 -2.8320764504006899e-017 
		0.099975536363413248 -0.20528885641474087 -4.7580218233829302e-017 0.16796360979387873 
		-0.22334387636476571 -6.3268170954803047e-017 0.22334387636476571 -0.12069530888852098 
		-3.7298398214811989e-017 0.13166760969656849 -0.14677356245004036 4.1577566360353477e-017 
		-0.14677356245004036 -0.13166760969656849 3.4190198363577702e-017 -0.12069530888852098 
		-0.098944563191612989 2.1021535180232667e-017 -0.074208422393709728 -0.053414235837186408 
		7.5655107705930314e-018 -0.026707117918593204 -0.010632473589959279 7.529836587766168e-019 
		-0.0026581183974898198 0 0 0 -0.010632473589959279 -7.529836587766168e-019 
		0.0026581183974898198 -0.053414235837186408 -7.5655107705930314e-018 0.026707117918593204 
		-0.098944563191612989 -2.1021535180232667e-017 0.074208422393709728 -0.13166760969656849 
		-3.4190198363577702e-017 0.12069530888852098 -0.14677356245004036 -4.1577566360353477e-017 
		0.14677356245004036;
	setAttr ".fbda" no;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 1;
	setAttr ".ucr" no;
	setAttr ".nu" 10;
	setAttr ".nv" 10;
	setAttr ".eta" yes;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
	setAttr ".nts" -type "string" (
		"This node is used to render the ocean surface. It is designed to concentrate more triangles in the center so that one can can have the ocean extend to the horizon, and yet still see reasonable resolution in the local displacement. The draw overrides have been set to disable interactive shading of this surface, which would slow down playback.For best resolution you may wish to translate this surface so that the center is just in front of the view. Scale it as small as is acceptable, based on the horizon.\n"
		+ "The heightfield node oceanPreviewPlane1 has been set up to allow one to interactively preview the ocean at a defined location.");
createNode transform -n "transform1";
	setAttr -l on ".ty";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr ".s" -type "double3" 330.23222865380706 1 330.23222865380706 ;
	setAttr -l on ".sy";
createNode heightField -n "oceanPreviewPlane1" -p "transform1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".res" 33;
	setAttr ".cl" -type "float3" 0.2 0.5 0.5 ;
	setAttr ".nts" -type "string" (
		"This node is used to preview the ocean's surface. It does not appear in renders. (oceanPlane1 is the node that renders) Translate and scale it to preview different parts of the ocean.\n"
		+ "One may increase the resolution to better judge the fine details on the surface, or lower it to provide faster playback performance.\n");
createNode transform -n "GiantStormCam";
createNode camera -n "GiantStormCamShape" -p "GiantStormCam";
	setAttr -k off ".v" no;
	setAttr ".cap" -type "double2" 1.41732 0.94488000000000005 ;
	setAttr ".coi" 156.32904439999999;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp2_depth";
	setAttr ".man" -type "string" "persp2_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * .15";
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".u" 8;
	setAttr ".v" 8;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "oceanShader1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode oceanShader -n "oceanShader1";
	setAttr ".dc" 0.3495199978351593;
	setAttr ".wc" -type "float3" 0.12549019 0.32941177 0.42745098 ;
	setAttr ".tc" 0.30098000168800354;
	setAttr ".trsd" 20;
	setAttr ".ec" 0.30000001192092896;
	setAttr ".spl" 0.44659999012947083;
	setAttr ".sc" -type "float3" 0.26623002 0.29458088 0.39500001 ;
	setAttr ".rfl" 0.97087997198104858;
	setAttr -s 6 ".env";
	setAttr ".env[0].envp" 0.38571429252624512;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".env[1].envp" 0.59285712242126465;
	setAttr ".env[1].envc" -type "float3" 0.091605991 0.30649766 0.56199998 ;
	setAttr ".env[1].envi" 1;
	setAttr ".env[2].envp" 0.72142857313156128;
	setAttr ".env[2].envc" -type "float3" 0.16759601 0.31773332 0.58600003 ;
	setAttr ".env[2].envi" 1;
	setAttr ".env[3].envp" 0.97857099771499634;
	setAttr ".env[3].envc" -type "float3" 0.31733999 0.44093961 0.51599997 ;
	setAttr ".env[3].envi" 1;
	setAttr ".env[4].envp" 0.035714298486709595;
	setAttr ".env[4].envc" -type "float3" 0.0086399987 0.021141784 0.045000002 ;
	setAttr ".env[4].envi" 1;
	setAttr ".env[5].envp" 0.85000002384185791;
	setAttr ".env[5].envc" -type "float3" 0.26712 0.44868097 0.63 ;
	setAttr ".env[5].envi" 1;
	setAttr ".wi" -type "float2" -0.5 -0.5 ;
	setAttr ".nf" 20;
	setAttr ".wlm" 0.20000000298023224;
	setAttr ".wlx" 100;
	setAttr -s 4 ".wh";
	setAttr ".wh[0:2]" 0.014285714365541935 0.14000000059604645 1 
		0.99285715818405151 0.2800000011920929 1 0.73571425676345825 0.18000000715255737 
		1;
	setAttr ".wh[4].whp" 0.19285714626312256;
	setAttr ".wh[4].whfv" 0.18000000715255737;
	setAttr ".wh[4].whi" 1;
	setAttr -s 4 ".wtb[3:6]"  0.15000001 0.98000002 0 0.34285715 
		0 0 0.80000001 1 0 0.1 0 0;
	setAttr -s 5 ".wp[0:4]"  0 0.56 1 1 0.44 1 0.34285715 
		0.51999998 1 0.085714288 0.80000001 1 0.64999998 0.31999999 1;
	setAttr ".tsh" 1;
	setAttr ".fc" -type "float3" 1.4988532 1.5 1.4505 ;
	setAttr ".fme" 0.14000000059604645;
	setAttr ".fmt" 0.67500001192092896;
	setAttr ".d" -2.2114431858062744;
	setAttr ".bbl" 0.05000000074505806;
	setAttr ".wvs" 2;
createNode animCurveTL -n "GiantStormCam_translateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 25.939374792380079 27 26.007275672775126 
		46 26.415248928007649 68 26.999748315658355 89 25.69300544561424 105 25.035977464940839 
		136 26.21722168050098 202 25.913539332751707 242 23.487868420441487;
createNode animCurveTL -n "GiantStormCam_translateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 4.6163704089819388 27 4.2081923131887109 
		46 2.6473839258947844 68 0.47199521087833185 89 6.5322124462245768 105 9.5512799383778137 
		136 5.2333883494025866 202 6.335276370147457 242 4.3421115759897395;
createNode animCurveTL -n "GiantStormCam_translateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 -5.4235028702082007 27 -5.4052436042142231 
		46 -5.3690531887103088 68 -4.8156401244810221 89 -4.9442300564830388 105 
		-5.034821765057627 136 -4.8657614893635976 202 -5.1639777275935907 242 -5.3078409412786449;
createNode animCurveTA -n "GiantStormCam_rotateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 -190.57740910196796 27 -215.84968856055741 
		46 -179.71367580886468 68 -168.8410499239383 89 -148.24908009828107 105 -153.08242813479839 
		136 -224.80871256610942 202 -168.62332769558401 242 -172.223327695584;
createNode animCurveTA -n "GiantStormCam_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 83.219451130285719 27 76.731583027882976 
		46 79.346735163657655 68 80.740939570060206 89 80.62976746741505 105 79.441441565611001 
		136 77.269503244630442 202 80.965326648846087 242 80.965326648846016;
createNode animCurveTA -n "GiantStormCam_rotateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 179.99999886681434 27 159.33892402526899 
		46 193.17591656514239 68 202.90990239921686 89 218.61838893892332 105 222.55476394961926 
		136 147.31426947006233 202 198.27980502278291 242 198.27980502278271;
createNode animCurveTU -n "GiantStormCam_scaleX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 1 27 1 46 1 68 1 89 1 105 1 136 
		1 202 1 242 1;
createNode animCurveTU -n "GiantStormCam_scaleY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 1 27 1 46 1 68 1 89 1 105 1 136 
		1 202 1 242 1;
createNode animCurveTU -n "GiantStormCam_scaleZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 1 27 1 46 1 68 1 89 1 105 1 136 
		1 202 1 242 1;
createNode animCurveTU -n "GiantStormCam_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 9 ".ktv[0:8]"  0 1 27 1 46 1 68 1 89 1 105 1 136 
		1 202 1 242 1;
	setAttr -s 9 ".kot[0:8]"  5 5 5 5 5 5 5 
		5 5;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 67;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".pfm" -type "string" "";
	setAttr ".oft" -type "string" "";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultLightSet;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr ":time1.o" "fluidShape1.cti";
connectAttr "expression1.out[0]" "fluidShape1.torz";
connectAttr "makeNurbPlane1.os" "oceanPlaneShape1.cr";
connectAttr "oceanShader1.d" "oceanPreviewPlane1.dis";
connectAttr "GiantStormCam_translateX.o" "GiantStormCam.tx";
connectAttr "GiantStormCam_translateY.o" "GiantStormCam.ty";
connectAttr "GiantStormCam_translateZ.o" "GiantStormCam.tz";
connectAttr "GiantStormCam_rotateX.o" "GiantStormCam.rx";
connectAttr "GiantStormCam_rotateY.o" "GiantStormCam.ry";
connectAttr "GiantStormCam_rotateZ.o" "GiantStormCam.rz";
connectAttr "GiantStormCam_scaleX.o" "GiantStormCam.sx";
connectAttr "GiantStormCam_scaleY.o" "GiantStormCam.sy";
connectAttr "GiantStormCam_scaleZ.o" "GiantStormCam.sz";
connectAttr "GiantStormCam_visibility.o" "GiantStormCam.v";
connectAttr ":time1.o" "expression1.tim";
connectAttr "fluidShape1SG.msg" "materialInfo2.sg";
connectAttr "fluidShape1.ocl" "fluidShape1SG.vs";
connectAttr "fluidShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr "oceanShader1SG.msg" "materialInfo1.sg";
connectAttr "oceanShader1.oc" "oceanShader1SG.ss";
connectAttr "oceanShader1.d" "oceanShader1SG.ds";
connectAttr "oceanPlaneShape1.iog" "oceanShader1SG.dsm" -na;
connectAttr ":time1.o" "oceanShader1.ti";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "oceanShader1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "oceanShader1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "oceanShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "fluidShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "oceanPreviewPlane1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of GiantStormAnim.ma
