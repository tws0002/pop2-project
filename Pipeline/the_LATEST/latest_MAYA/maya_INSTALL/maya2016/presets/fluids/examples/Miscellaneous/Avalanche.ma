//Maya ASCII 5.0 scene
//Name: Avanlanche.ma
//Last modified: Mon, Apr 14, 2003 09:41:40 PM
requires maya "5.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200303260009";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 2 (Build 2195)\n";
createNode transform -n "avalanche";
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
	setAttr ".t" -type "double3" 3.5485817355266063 2.6061461799637948 1.6418496110629659 ;
	setAttr ".s" -type "double3" 1.0430376816977034 1.0452966414764471 1.0451546041258477 ;
createNode fluidShape -n "avalancheShape" -p "avalanche";
	addAttr -ci true -sn "windSpeed" -ln "windSpeed" -dv 10 -min 0 -max 200 
		-at "double";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "cloudScaleU" -ln "cloudScaleU" -dv 0.5 -min 0 -max 
		100 -at "double";
	addAttr -ci true -sn "cloudScaleV" -ln "cloudScaleV" -dv 0.5 -min 0 -max 
		100 -at "double";
	addAttr -ci true -sn "emissionDensity" -ln "emissionDensity" -dv 0.5 -min 
		0 -max 20 -at "double";
	addAttr -ci true -sn "emissionThreshold" -ln "emissionThreshold" -dv 0.3 
		-min -2 -max 2 -at "double";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".vss" 3;
	setAttr ".iss" yes;
	setAttr ".rw" 70;
	setAttr ".rh" 12;
	setAttr ".rd" 45;
	setAttr ".dw" 35;
	setAttr ".dh" 6;
	setAttr ".dd" 22.5;
	setAttr ".ssd" 3;
	setAttr ".bod" 4;
	setAttr ".vdl" 0.63104000000000005;
	setAttr ".bndx" 0;
	setAttr ".bndy" 2;
	setAttr ".dsc" 1;
	setAttr ".dsb" -12.564000129699707;
	setAttr ".vsw" 0.49579998850822449;
	setAttr ".tst" 0.13223999738693237;
	setAttr ".tfr" 0.33055999875068665;
	setAttr ".tgr" 6;
	setAttr ".tmsc" 0.87379997968673706;
	setAttr ".tds" 0;
	setAttr ".tdf" 0;
	setAttr ".ttb" 0;
	setAttr ".buo" 1000;
	setAttr ".ss" yes;
	setAttr ".rin" 3;
	setAttr ".cl[5].clp" 0.02142857201397419;
	setAttr ".cl[5].clc" -type "float3" 0.57599998 0.56885183 0.55641598 ;
	setAttr ".cl[5].cli" 1;
	setAttr -s 5 ".opa[0:4]"  0.27142859 0 1 1 1 1 0.49285713 
		0.57999998 1 0.34285715 0.47999999 1 0.2857143 0.039999999 1;
	setAttr ".oib" 0.65759998559951782;
	setAttr ".t" -type "float3" 0.033059999 0.033059999 0.033059999 ;
	setAttr ".shp" 0.16527999937534332;
	setAttr -s 2 ".i";
	setAttr ".i[3].ip" 0.11428571492433548;
	setAttr ".i[3].ic" -type "float3" 0.46634799 0.54267901 0.54799998 ;
	setAttr ".i[3].ii" 1;
	setAttr ".i[4].ip" 0.98571425676345825;
	setAttr ".i[4].ic" -type "float3" 0.226735 0.28136986 0.331 ;
	setAttr ".i[4].ii" 1;
	setAttr ".ili" 0;
	setAttr ".iib" -0.15316000580787659;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 2;
	setAttr ".edr" 0.28099998831748962;
	setAttr ".rl" no;
	setAttr ".dl" -type "float3" 0.1 0.80000001 -0.40000001 ;
	setAttr ".itx" yes;
	setAttr ".itxg" 0.9917600154876709;
	setAttr ".otx" yes;
	setAttr ".otxg" 0.8099600076675415;
	setAttr ".ra" 0.61159998178482056;
	setAttr ".dm" 3;
	setAttr ".fq" 2.437999963760376;
	setAttr ".in" yes;
	setAttr ".ldns" no;
	setAttr ".lvel" no;
	setAttr ".ctmp" no;
	setAttr ".ltmp" no;
	setAttr ".ccol" no;
	setAttr ".lcol" no;
	setAttr ".crea" no;
	setAttr ".lrea" no;
	setAttr ".catc" no;
	setAttr ".lotc" no;
	setAttr -k on ".windSpeed" 8.264;
	setAttr ".nts" -type "string" (
		"Preset Goal:\r\n"
		+ "To create a rushing and colliding wave of snow as in an avalanche.\r\n"
		+ "\r\n"
		+ "Basic Constructon:\r\n"
		+ "There are three expressions on the fluid. One creates the density and velocity. The other two handle texturing. Expression3 changes the texture time so the texture keeps changing with each frame. Expression two keeps moving the orgin of u so that the texture moves down the slope with the fluid density. There is collision set between the density (snow), and the ground and igloo.  The camera is animated to give the impression of the ground shaking.\r\n"
		+ "Both snow shaders use a ramp of blues and greys as an image for an environment sphere that is used as the reflected colour for the snow. The igloo also has a grid used to bump the surface to give a brick like effect on the igloo.  The particleCloud shader is a re-used default particle shader. It could be used for particle snow. SnowGroundS shader also uses a fractal for displacement and bump, and a phong shader with a fractal for incandescence.\r\n"
		+ "Fluid density and velocity contents method are both dynamic. Both X and -Y boundaries are off to stop the snow from bouncing off ths sides of the container. The bouyancy is quite negative to help give a sense of weight to the onrushing snow. There is a bit of swirl in the velocity to agitate the snow more than just collision would do and help give a rolling effect. The colour of the fluid snow is largely from the incandescence ramp which adds to the basic grey colour of the snow. Self shadowing is on to help give form to the translucent volume of snow.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "Particles could be added to give smaller bits of snow. The fluid can also be used as a force to drive snow particles. A camera can be put inside the fluid for the effect of the snow rushing passed. Render time: $$.\r\n");
	setAttr -k on ".cloudScaleU" 65.290000000000006;
	setAttr -k on ".cloudScaleV" 76.034000000000006;
	setAttr -k on ".emissionDensity";
	setAttr -k on ".emissionThreshold";
createNode transform -n "snowGround";
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
	setAttr ".s" -type "double3" 34.217533119430691 34.217533119430691 34.217533119430691 ;
createNode nurbsSurface -n "snowGroundShape" -p "snowGround";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 81 ".cp[0:80]" -type "double3" -0.44192830788345083 
		-0.053950732015143998 0.22050308035130406 -0.44192830788345061 -0.053950732015143971 
		0.20071980922177274 -0.44192830788345061 -0.053950732015143964 0.15035025190845541 
		-0.44192830788345061 -0.053950732015143964 0.074795915938478563 -0.44192830788345061 
		-0.053950732015143971 -0.0007584200314983316 -0.44901417878194683 -0.038392592014448793 
		-0.055713856107898613 -0.44735199558332772 -0.03996968515942384 -0.13712162324460286 
		-0.45354795016443294 -0.040437676024115243 -0.18850010329662714 -0.35550711958766246 
		-0.050111558676778772 -0.21482360967641656 -0.41674352922679198 0.0099690258193495598 
		0.22590458787843215 -0.17548853970929129 0 0 -0.17548853970929129 0 0 -0.17548853970929129 
		0 0 -0.17548853970929129 0 0 -0.17548853970929129 0 0 -0.17548853970929129 
		0 0 0 -0.034572103193977834 0 -0.16170146898904164 -0.040275511174067261 
		-0.22742142794142794 -0.10797316153665659 0.0055316181912868105 0.22160213408514151 
		0 0 0 0 0 0 -0.0062612442794024448 0.085818079943659004 0.019501492553825439 
		0.013818982363094978 -0.090751306570965487 -0.0016729956470683707 -0.0057829068178615328 
		0.097844228343737766 0.002417559417950188 0 0 0 0 0 0 -0.11133191167572432 
		0.0099690258193495945 -0.22742142794142794 -0.035777575705747466 0.0099690258193495598 
		0.23319406010067101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.035777575705747466 
		0.0099690258193495945 -0.22742142794142794 0.039776760264229334 0.0099690258193495598 
		0.23319406010067101 0 0 0.044044296196699029 0 0 0 0 0 0 0 0.101859923593346 
		0 0 0 0 0 0 0 0 0 0 0.039776760264229334 0.0099690258193495945 -0.22742142794142794 
		0.11533109623420595 0.0099690258193495598 0.22590458787843215 0 0 0 0 0 0 
		0 -0.066618875832000865 0 0 0 0 0 0 0 0 0 0 0 0 0 0.11533109623420595 0.0099690258193495945 
		-0.22742142794142794 0.19088543220418241 0.0099690258193495598 0.22590458787843215 
		0 0 0 0 0 0 0 0 0 -0.084688780833817895 0.22236134314383246 0.12420337916552679 
		0 0 0 0 0 0 0 0 0 0.19088543220418241 0.0099690258193495945 -0.22742142794142794 
		0.24125498951750068 0.0099690258193495598 0.22590458787843215 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24125498951750068 0.0099690258193495945 -0.22742142794142794 
		0.26643976817415926 0.0099690258193495668 0.22080488493304784 0.26643976817415926 
		0.0099690258193495633 0.20071980922177274 0.26643976817415926 0.0099690258193495685 
		0.15035025190845541 0.26643976817415926 0.0099690258193495685 0.074795915938478563 
		0.26643976817415926 0.0099690258193495807 -0.0007584200314983316 0.26643976817415926 
		0.0099690258193495859 -0.076312756001475107 0.26643976817415926 0.0099690258193495876 
		-0.15186709197145176 0.26643976817415926 0.0099690258193495911 -0.20223664928476981 
		0.2637953734368963 0.0099690258193495945 -0.22742142794142794;
	setAttr ".fbda" no;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nu" 10;
	setAttr ".nv" 8;
	setAttr ".eta" yes;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode uniformField -n "uniformField1";
	setAttr ".t" -type "double3" 0 3.1943234803214651 22.727286933517707 ;
	setAttr ".s" -type "double3" 16.050148078145636 3.5734730952485187 8.6255897238506574 ;
	setAttr ".mag" 200;
	setAttr ".vol" 1;
	setAttr ".dx" 1;
createNode transform -n "directionalLight1";
	setAttr ".t" -type "double3" 0 10.206056077870215 0 ;
	setAttr ".r" -type "double3" -109.66160474708249 13.543183147879059 -14.155747855503533 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	addAttr -ci true -sn "milt" -ln "miExportMrLight" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mils" -ln "miLightShader" -bt "UNKN" -at "message";
	addAttr -ci true -sn "mipe" -ln "miPhotonEmitter" -bt "UNKN" -at "message";
	addAttr -ci true -sn "phot" -ln "emitPhotons" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "eng" -ln "energy" -bt "UNKN" -at "float3" -nc 3;
	addAttr -ci true -sn "engr" -ln "energyR" -bt "UNKN" -dv 8000 -at "float" 
		-p "energy";
	addAttr -ci true -sn "engg" -ln "energyG" -bt "UNKN" -dv 8000 -at "float" 
		-p "energy";
	addAttr -ci true -sn "engb" -ln "energyB" -bt "UNKN" -dv 8000 -at "float" 
		-p "energy";
	addAttr -ci true -sn "exp" -ln "exponent" -bt "UNKN" -dv 2 -at "float";
	addAttr -ci true -sn "cph" -ln "causticPhotons" -bt "UNKN" -dv 10000 -at "long";
	addAttr -ci true -sn "gph" -ln "globIllPhotons" -bt "UNKN" -dv 10000 -at "long";
	addAttr -ci true -sn "phy" -ln "physical" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "usm" -ln "shadowMap" -bt "UNKN" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "smr" -ln "smapResolution" -bt "UNKN" -dv 256 -at "long";
	addAttr -ci true -sn "smsa" -ln "smapSamples" -bt "UNKN" -dv 1 -at "short";
	addAttr -ci true -sn "smso" -ln "smapSoftness" -bt "UNKN" -at "float";
	addAttr -ci true -sn "smf" -ln "smapFilename" -bt "UNKN" -dt "string";
	setAttr -k off ".v";
	setAttr ".in" 0.80000001192092896;
createNode transform -n "ambientLight1";
	setAttr ".t" -type "double3" -10.038427835092003 9.0740018367911137 0 ;
createNode ambientLight -n "ambientLightShape1" -p "ambientLight1";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.68500006 0.88366002 1 ;
	setAttr ".in" 0.5;
	setAttr ".as" 0.36366000771522522;
createNode place3dTexture -n "place3dTexture1";
createNode transform -n "Igloo";
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
	setAttr ".t" -type "double3" 1.7760447652591038 0.24155973326511582 -5.8199150935082988 ;
	setAttr ".r" -type "double3" 0 0 13.483237869174532 ;
	setAttr ".s" -type "double3" 4.0537003528613331 4.0537003528613331 4.0537003528613331 ;
createNode nurbsSurface -n "IglooShape" -p "Igloo";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".sso" yes;
	setAttr ".ssa" 8;
	setAttr ".msa" 8;
	setAttr ".tw" yes;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode place3dTexture -n "place3dTexture2";
createNode transform -n "avalancheCam";
	setAttr ".rp" -type "double3" -8.8817841970012523e-016 0 1.7763568394002505e-015 ;
	setAttr ".rpt" -type "double3" 1.963261930063265e-015 9.1325260182444094e-016 
		-3.7833335708272578e-016 ;
createNode camera -n "avalancheCamShape" -p "avalancheCam";
	setAttr -k off ".v";
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 14.823787345505252;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode diskCache -n "cache_avalancheShape";
	setAttr ".cn" -type "string" "./Avalanche.ma_avalancheShape.mcfp";
	setAttr ".ct" -type "string" "mcfp";
	setAttr ".hcn" -type "string" "hidden1_avalancheShape.mcfp";
createNode animCurveTU -n "avalancheShape_emissionDensity";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1.2754716981132077 77 0.014150943396226278;
	setAttr -s 2 ".kix[0:1]"  0.63201397657394409 0.99341654777526855;
	setAttr -s 2 ".kiy[0:1]"  -0.77495694160461426 -0.1145578995347023;
	setAttr -s 2 ".kox[0:1]"  0.63201421499252319 0.99341654777526855;
	setAttr -s 2 ".koy[0:1]"  -0.77495682239532471 -0.11455795168876648;
createNode animCurveTU -n "avalanche_emissionThreshold";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -0.35 54 -0.018261687960655602;
	setAttr -s 2 ".kit[1]"  9;
	setAttr -s 2 ".kot[1]"  9;
	setAttr -s 2 ".kix[0:1]"  0.97270113229751587 0.98890423774719238;
	setAttr -s 2 ".kiy[0:1]"  0.23206153512001038 0.14855431020259857;
	setAttr -s 2 ".kox[0:1]"  0.97270113229751587 0.98890423774719238;
	setAttr -s 2 ".koy[0:1]"  0.23206149041652679 0.14855431020259857;
createNode geoConnector -n "geoConnector2";
	setAttr ".tf" 2000;
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".u" 6;
	setAttr ".v" 6;
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "snowGroundS";
	setAttr ".c" -type "float3" 0.54545999 0.54545999 0.54545999 ;
	setAttr ".ambc" -type "float3" 0.457744 0.48800001 0.48340109 ;
	setAttr ".tc" 0.2644599974155426;
	setAttr ".sc" -type "float3" 0.33884001 0.33884001 0.33884001 ;
	setAttr ".rfl" 0.63635998964309692;
	setAttr ".ec" 0.082639999687671661;
	setAttr ".sro" 0.23139999806880951;
createNode bump2d -n "bump2d1";
	setAttr ".bd" 0.61979997158050537;
	setAttr ".bf" 0.049639999866485596;
	setAttr ".bfo" 0.0010000000474974513;
	setAttr ".vc2" -type "float3" 0.001 0.001 0 ;
createNode fractal -n "fractal1";
	setAttr ".f" 0.42976000905036926;
	setAttr ".ail" yes;
	setAttr ".ra" 0.52065998315811157;
	setAttr ".lmx" 13.842800140380859;
createNode place2dTexture -n "place2dTexture1";
	setAttr ".re" -type "float2" 0.2 0.2 ;
createNode envSphere -n "envSphere1";
createNode ramp -n "ramp1";
	setAttr -s 4 ".cel";
	setAttr ".cel[0].ep" 0.035000000149011612;
	setAttr ".cel[0].ec" -type "float3" 0.43099999 0.43099999 0.43099999 ;
	setAttr ".cel[1].ep" 0.48500001430511475;
	setAttr ".cel[1].ec" -type "float3" 1 0.974953 0.96700001 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.77899998 0.85115647 1 ;
	setAttr ".cel[3].ep" 0.70499998331069946;
	setAttr ".cel[3].ec" -type "float3" 0.90147597 0.95576257 0.98199999 ;
createNode place2dTexture -n "place2dTexture2";
createNode phong -n "phong1";
	setAttr ".c" -type "float3" 0 0 0 ;
	setAttr ".sc" -type "float3" 0.27272001 0.27272001 0.27272001 ;
	setAttr ".cp" 96.760002136230469;
createNode bump2d -n "bump2d2";
	setAttr ".bd" 1.9420000314712524;
	setAttr ".bf" 0.0010000000474974513;
	setAttr ".vc2" -type "float3" 9.9999997e-006 9.9999997e-006 0 ;
createNode fractal -n "fractal2";
	setAttr ".f" 0.024819999933242798;
	setAttr ".ail" yes;
	setAttr ".a" 0.004999999888241291;
	setAttr ".ra" 0.9421200156211853;
	setAttr ".lmx" 5.1655998229980469;
	setAttr ".in" yes;
createNode place2dTexture -n "place2dTexture3";
	setAttr ".re" -type "float2" 3 3 ;
createNode displacementShader -n "displacementShader1";
createNode geoConnector -n "geoConnector3";
	setAttr ".tf" 835;
createNode makeNurbSphere -n "makeNurbSphere2";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode materialInfo -n "materialInfo5";
createNode shadingEngine -n "blinn3SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "iglooS";
	setAttr ".dc" 0.7107200026512146;
	setAttr ".c" -type "float3" 0.51200002 0.49678892 0.48384002 ;
	setAttr ".ambc" -type "float3" 0.65704501 0.78500003 0.77032787 ;
	setAttr ".ic" -type "float3" 0.088841997 0.12909283 0.134 ;
	setAttr ".tc" 0.23139999806880951;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1.0331200361251831;
	setAttr ".sc" -type "float3" 4 4 4 ;
	setAttr ".rfl" 0.082639999687671661;
	setAttr ".ec" 0.14047999680042267;
	setAttr ".sro" 0.21490000188350677;
createNode envSphere -n "envSphere2";
createNode ramp -n "ramp2";
	setAttr -s 6 ".cel";
	setAttr ".cel[0].ep" 0.13500000536441803;
	setAttr ".cel[0].ec" -type "float3" 0.79100001 0.93935513 1 ;
	setAttr ".cel[1].ep" 0.46000000834465027;
	setAttr ".cel[1].ec" -type "float3" 0.50400001 0.50353247 0.49291199 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.58873498 0.73500001 0.70004267 ;
	setAttr ".cel[3].ep" 0.68999999761581421;
	setAttr ".cel[3].ec" -type "float3" 0.90100002 0.90100002 0.90100002 ;
	setAttr ".cel[4].ep" 0;
	setAttr ".cel[4].ec" -type "float3" 0.93800002 1 0.99383098 ;
	setAttr ".cel[5].ep" 0.30500000715255737;
	setAttr ".cel[5].ec" -type "float3" 0.57906199 0.61751699 0.62553501 ;
createNode place2dTexture -n "place2dTexture4";
createNode bump2d -n "bump2d3";
	setAttr ".bd" 0.40000000596046448;
	setAttr ".bf" 0.019999999552965164;
	setAttr ".vc2" -type "float3" 9.9999997e-006 9.9999997e-006 0 ;
createNode grid -n "grid1";
	addAttr -ci true -sn "resolution" -ln "resolution" -dv 32 -at "long";
	setAttr ".f" 0.074400000274181366;
	setAttr ".fo" 0.024819999933242798;
	setAttr ".ail" yes;
	setAttr ".fc" -type "float3" 0.56198001 0.56198001 0.56198001 ;
	setAttr ".lc" -type "float3" 0.28926 0.28926 0.28926 ;
	setAttr ".uw" 0.061983998864889145;
	setAttr ".vw" 0.057847999036312103;
createNode place2dTexture -n "place2dTexture5";
	setAttr ".rf" 90;
	setAttr ".s" yes;
	setAttr ".re" -type "float2" 6 12 ;
	setAttr ".n" -type "float2" 0.0060000001 0.012 ;
createNode noise -n "noise2";
	setAttr ".a" 0.22315999865531921;
	setAttr ".ra" 0.85948002338409424;
	setAttr ".fq" 19.007999420166016;
	setAttr ".nty" 0;
	setAttr ".nw" 8;
createNode place2dTexture -n "place2dTexture7";
createNode expression -n "expression2";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * .I[0] * -.015";
createNode expression -n "expression3";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * .I[0] * 0.1";
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode expression -n "expression1";
	setAttr -k on ".nds";
	setAttr -s 7 ".in";
	setAttr -s 7 ".in";
	setAttr ".ixp" -type "string" (
		"//This expression creates density and velocity in the avalanche fluid.\r\n"
		+ "float $vel = .I[0];\r\n"
		+ "int $zres = .I[1];\r\n"
		+ "float $density = .I[2];\r\n"
		+ "float $emitThreshold = .I[3];\r\n"
		+ "// set the velocity at an extra column for stability of flow\r\n"
		+ "setFluidAttr -at velocity -xi 0 -vv $vel 0 0 avalancheShape;\r\n"
		+ "setFluidAttr -at velocity -xi 1 -vv $vel 0 0 avalancheShape;\r\n"
		+ "int $i,$j;\r\n"
		+ "float $uscale = .0001 * .I[4];\r\n"
		+ "float $vscale = .1 * .I[5];\r\n"
		+ "// We scale the rate at which we change the u value of the texture to\r\n"
		+ "// keep up with the wind.\r\n"
		+ "float $u = frame * $uscale * $vel;\r\n"
		+ "// if velocity > than a fixed amount we need to set the density of \r\n"
		+ "// more columns to avoid banding in the flow.\r\n"
		+ "int $ypos = .I[6] /3;\r\n"
		+ "int $numCol = 1 + $vel/15.0;\r\n"
		+ "for($j = 0; $j < $numCol; $j++ ){\r\n"
		+ "    for($i = 0; $i < $zres; $i++ ){\r\n"
		+ "        float $v = $vscale * (float)$i/(float)($zres);\r\n"
		+ "        float $nval = (noise($u,$v)* 0.5 + $emitThreshold) * $density;\r\n"
		+ "\t$nval += (noise($u * 3.0, $v * 3.0)* 0.5 + 0.4) * $density *.7;\r\n"
		+ "        if( $nval < 0 ) $nval =0.0;\r\n"
		+ "        setFluidAttr -at density -xi $j -zi $i -yi $ypos -fv $nval avalancheShape;\r\n"
		+ "    }\r\n"
		+ "    $u -= $uscale * 10; // the uvalue for each extra column we set must be offset to avoid banding\r\n"
		+ "}");
createNode imagePlane -n "imagePlane1";
	setAttr ".t" 1;
	setAttr ".s" -type "double2" 1.4173200000000001 1.0629899683204305 ;
	setAttr ".c" -type "double3" 3.3373323722691222 0.30728800209768359 2.2272669276415602 ;
	setAttr ".w" 10;
	setAttr ".h" 10;
createNode ramp -n "ramp5";
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0.019999999552965164;
	setAttr ".cel[0].ec" -type "float3" 0.391314 0.55452919 0.72600001 ;
	setAttr ".cel[1].ep" 1;
	setAttr ".cel[1].ec" -type "float3" 0.22347 0.2793254 0.382 ;
createNode place2dTexture -n "place2dTexture10";
createNode cameraView -n "AvalancheView";
	setAttr ".e" -type "double3" 21.696536016240497 11.18920050222534 10.518501630929002 ;
	setAttr ".coi" -type "double3" -4.8028845677419021 -5.3341495712169547 -1.9900209327968579 ;
	setAttr ".u" -type "double3" -0.5009963915217831 0.86199068017808178 -0.07729607343377938 ;
	setAttr ".fl" 34.999999999999993;
createNode animCurveTA -n "avalancheCam_rotateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 83 ".ktv[0:82]"  1 -12.790067360465377 11 -11.843845378387334 
		16 -11.68352813611377 21 -11.651641442401905 23 -11.288849781137982 27 -11.066912842128957 
		29 -10.808459703143672 33 -10.752697466296301 35 -10.448167703143671 37 -9.847681 
		39 -9.3200049870367963 42 -9.2290294653831388 44 -8.8869014062873397 46 -8.2864150000000034 
		50 -7.9431025106356881 56 -7.362252723735133 59 -7.3256357031436696 61 -7.0715265223611468 
		64 -6.9291457335377942 66 -6.352234123496423 73 -5.8804956984712122 78 -5.043785 
		80 -4.80359 84 -3.6171141075752962 86 -3.2499466844092599 93 -2.5439006723448054 
		98 -2.0147130157090336 100 -1.3808132968563294 102 -1.2006680000000001 107 
		0.046422278991510295 114 0.72089129685632958 117 0.840988 119 1.20128 121 
		1.321378 122 1.621621 130 2.16206 146 3.430951378162685 155 3.7233262968563294 
		157 4.0836180000000004 159 4.0836180000000004 161 4.503959 199 5.9451280203598866 
		209 -11.843845378387334 214 -11.68352813611377 219 -11.651641442401905 221 
		-11.288849781137982 225 -11.066912842128957 227 -10.808459703143672 231 -10.752697466296301 
		233 -10.448167703143671 235 -9.847681 237 -9.3200049870367963 240 -9.2290294653831388 
		242 -8.8869014062873397 244 -8.2864150000000034 248 -7.9431025106356881 254 
		-7.362252723735133 257 -7.3256357031436696 259 -7.0715265223611468 262 -6.9291457335377942 
		264 -6.352234123496423 271 -5.8804956984712122 276 -5.043785 278 -4.80359 
		282 -3.6171141075752962 284 -3.2499466844092599 291 -2.5439006723448054 296 
		-2.0147130157090336 298 -1.3808132968563294 300 -1.2006680000000001 305 0.046422278991510295 
		312 0.72089129685632958 315 0.840988 317 1.20128 319 1.321378 320 1.621621 
		328 2.16206 344 3.430951378162685 353 3.7233262968563294 355 4.0836180000000004 
		357 4.0836180000000004 359 4.503959 397 5.9451280203598866;
createNode animCurveTA -n "avalancheCam_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 55 ".ktv[0:54]"  1 426.50105486123897 11 427.21124002741703 
		15 428.18865938272495 22 428.97081561810813 27 429.5187024254023 34 429.96929397681919 
		38 429.9664177419649 42 430.16455531553106 50 430.97851893001422 55 431.50334807019277 
		61 431.60390136862537 64 431.89457197647414 67 431.81236469851387 74 432.07224623440118 
		79 432.54036000000002 84 432.81826261148422 86 433.0568293630659 92 433.15501383905303 
		98 433.60613498384907 106 433.97825641586888 126 436.05577711048591 129 436.731819 
		131 436.64167955524306 146 438.32418777781311 155 438.669805 157 438.940221555243 
		162 438.98529100000002 199 440.56272162543331 209 427.21124002741703 213 
		428.18865938272495 220 428.97081561810813 225 429.5187024254023 232 429.96929397681919 
		236 429.9664177419649 240 430.16455531553106 248 430.97851893001422 253 431.50334807019277 
		259 431.60390136862537 262 431.89457197647414 265 431.81236469851387 272 
		432.07224623440118 277 432.54036000000002 282 432.81826261148422 284 433.0568293630659 
		290 433.15501383905303 296 433.60613498384907 304 433.97825641586888 324 
		436.05577711048591 327 436.731819 329 436.64167955524306 344 438.32418777781311 
		353 438.669805 355 438.940221555243 360 438.98529100000002 397 440.56272162543331;
createNode animCurveTA -n "avalancheCam_rotateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 18.643456871664537 11 19.345938133277784 
		15 19.197261090440026 22 19.596270948521916 27 19.845169077082399 34 20.017569636307602 
		39 21.004949250792276 42 21.236855081805729 50 21.572528432853684 55 21.868530374575297 
		61 22.305972094330944 64 22.308109961651457 67 22.910280300644136 74 23.596743319514683 
		84 24.233929653362946 86 24.352077580505554 93 24.772229516289055 98 25.231765935409936 
		106 25.920001281225662 146 29.392540430168758 199 32.552585351052535 209 
		19.345938133277784 213 19.197261090440026 220 19.596270948521916 225 19.845169077082399 
		232 20.017569636307602 237 21.004949250792276 240 21.236855081805729 248 
		21.572528432853684 253 21.868530374575297 259 22.305972094330944 262 22.308109961651457 
		265 22.910280300644136 272 23.596743319514683 282 24.233929653362946 284 
		24.352077580505554 291 24.772229516289055 296 25.231765935409936 304 25.920001281225662 
		344 29.392540430168758 397 32.552585351052535;
createNode animCurveTU -n "avalancheCam_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 1 11 1 15 1 22 1 27 1 34 1 39 
		1 42 1 50 1 55 1 61 1 64 1 67 1 74 1 84 1 86 1 93 1 98 1 106 1 146 1 199 
		1 209 1 213 1 220 1 225 1 232 1 237 1 240 1 248 1 253 1 259 1 262 1 265 1 
		272 1 282 1 284 1 291 1 296 1 304 1 344 1 397 1;
	setAttr -s 41 ".kot[0:40]"  5 5 5 5 5 5 5 
		5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 
		5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 
		5 5 5 5;
createNode animCurveTL -n "avalancheCam_translateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 21.686703394674282 11 21.683767387683819 
		16 21.726793191615062 26 21.818166290064362 31 21.914118133401907 36 21.921978958669065 
		41 21.956875362115561 45 22.0089305427732 51 22.064714742163861 57 22.164284454776183 
		62 22.4199719944741 65 22.477190255345285 67 22.738073479587623 74 23.079840317209435 
		84 23.334361584668013 87 23.34768737927568 93 23.393993428994413 98 23.344081255761886 
		108 23.387754412280163 153 23.666675413892936 194 24.496465259546756 204 
		21.683767387683819 209 21.726793191615062 219 21.818166290064362 224 21.914118133401907 
		229 21.921978958669065 234 21.956875362115561 238 22.0089305427732 244 22.064714742163861 
		250 22.164284454776183 255 22.4199719944741 258 22.477190255345285 260 22.738073479587623 
		267 23.079840317209435 277 23.334361584668013 280 23.34768737927568 286 23.393993428994413 
		291 23.344081255761886 301 23.387754412280163 346 23.666675413892936 387 
		24.496465259546756;
createNode animCurveTL -n "avalancheCam_translateY";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 67 ".ktv[0:66]"  1 11.277739326186113 11 11.188534439627519 
		15 11.183969869063123 22 11.049994781960693 27 11.038703065381588 31 11.005520726359476 
		39 10.971825659168561 42 10.911999275633066 47 10.861902354339737 48 10.854103413049605 
		50 10.840635361792097 55 10.833538935563139 58 10.791135053989077 61 10.742509980222753 
		66 10.772538171622424 67 10.693472360642906 74 10.615221467025572 79 10.621483035762342 
		83 10.494440655490298 86 10.451154899630556 93 10.434410022200234 98 10.440757292490016 
		102 10.378511808241356 106 10.380715537676336 110 10.30540602341012 130 10.112414807259624 
		133 10.168167699113667 136 10.050828705069781 146 10.029557044173282 158 
		9.8772225338506079 161 9.9240550904530203 164 9.8236995108256053 167 9.8082600412514651 
		199 9.5114824877543427 209 11.188534439627519 213 11.183969869063123 220 
		11.049994781960693 225 11.038703065381588 229 11.005520726359476 237 10.971825659168561 
		240 10.911999275633066 245 10.861902354339737 246 10.854103413049605 248 
		10.840635361792097 253 10.833538935563139 256 10.791135053989077 259 10.742509980222753 
		264 10.772538171622424 265 10.693472360642906 272 10.615221467025572 277 
		10.621483035762342 281 10.494440655490298 284 10.451154899630556 291 10.434410022200234 
		296 10.440757292490016 300 10.378511808241356 304 10.380715537676336 308 
		10.30540602341012 328 10.112414807259624 331 10.168167699113667 334 10.050828705069781 
		344 10.029557044173282 356 9.8772225338506079 359 9.9240550904530203 362 
		9.8236995108256053 365 9.8082600412514651 397 9.5114824877543427;
	setAttr -s 67 ".kit[0:66]"  9 9 9 9 9 9 9 
		1 1 1 1 1 1 1 9 9 1 1 1 9 9 1 
		1 1 1 1 1 1 1 1 1 1 1 1 9 9 9 
		9 9 9 1 1 1 1 1 1 1 9 9 1 1 1 
		9 9 1 1 1 1 1 1 1 1 1 1 1 1 1;
	setAttr -s 67 ".kot[0:66]"  9 9 9 9 9 9 9 
		1 1 1 1 1 1 1 9 9 1 1 1 9 9 1 
		1 1 1 1 1 1 1 1 1 1 1 1 9 9 9 
		9 9 9 1 1 1 1 1 1 1 9 9 1 1 1 
		9 9 1 1 1 1 1 1 1 1 1 1 1 1 1;
	setAttr -s 67 ".kix[7:66]"  0.96139204502105713 0.20833343267440796 
		0.041666802018880844 0.98967206478118896 0.97784125804901123 0.12499992549419403 
		0.95417147874832153 0.98130041360855103 0.90434366464614868 0.95820850133895874 
		0.16666664183139801 0.94363117218017578 0.9897802472114563 0.99978387355804443 
		0.98548108339309692 0.16666732728481293 0.97784262895584106 0.16666683554649353 
		0.87500029802322388 0.083333313465118408 0.12499982118606567 0.97784215211868286 
		0.5000002384185791 0.12500026822090149 0.1250002533197403 0.1250002533197403 
		0.97784131765365601 0.32932561635971069 0.95722657442092896 0.96029192209243774 
		0.99304062128067017 0.99117308855056763 0.97981077432632446 0.96139204502105713 
		0.20833343267440796 0.041666802018880844 0.98967206478118896 0.97784125804901123 
		0.12499992549419403 0.95417147874832153 0.98130041360855103 0.90434366464614868 
		0.95820850133895874 0.16666664183139801 0.94363117218017578 0.9897802472114563 
		0.99978387355804443 0.98548108339309692 0.16666732728481293 0.97784262895584106 
		0.16666683554649353 0.87500029802322388 0.083333313465118408 0.12499982118606567 
		0.97784215211868286 0.5000002384185791 0.12500026822090149 0.1250002533197403 
		0.1250002533197403 0.97784131765365601;
	setAttr -s 67 ".kiy[7:66]"  -0.27518248558044434 -0.040797833353281021 
		-0.007440546527504921 -0.14334993064403534 -0.20934773981571198 -0.051780994981527328 
		-0.29926031827926636 -0.19248254597187042 -0.42680507898330688 -0.28607082366943359 
		-0.060443270951509476 -0.33099877834320068 -0.14260111749172211 -0.020790720358490944 
		-0.16978542506694794 -0.037423901259899139 -0.2093413919210434 -0.035681460052728653 
		-0.18732964992523193 -0.017842063680291176 -0.026761868968605995 -0.20934361219406128 
		-0.10704661905765533 -0.026761861518025398 -0.026760468259453773 -0.026762189343571663 
		-0.20934733748435974 0.94421643018722534 -0.28933930397033691 -0.27899709343910217 
		-0.11777212470769882 -0.1325741708278656 -0.19992724061012268 -0.27518248558044434 
		-0.040797833353281021 -0.007440546527504921 -0.14334993064403534 -0.20934773981571198 
		-0.051780994981527328 -0.29926031827926636 -0.19248254597187042 -0.42680507898330688 
		-0.28607082366943359 -0.060443270951509476 -0.33099877834320068 -0.14260111749172211 
		-0.020790720358490944 -0.16978542506694794 -0.037423901259899139 -0.2093413919210434 
		-0.035681460052728653 -0.18732964992523193 -0.017842063680291176 -0.026761868968605995 
		-0.20934361219406128 -0.10704661905765533 -0.026761861518025398 -0.026760468259453773 
		-0.026762189343571663 -0.20934733748435974;
	setAttr -s 67 ".kox[7:66]"  0.96139311790466309 0.98135799169540405 
		0.083333082497119904 0.98967152833938599 0.97784066200256348 0.12499983608722687 
		0.95417231321334839 0.98130041360855103 0.90434366464614868 0.95820868015289307 
		0.20833335816860199 0.94362938404083252 0.9897802472114563 0.99978387355804443 
		0.985481858253479 0.16666616499423981 0.97784161567687988 0.97784143686294556 
		0.97784370183944702 0.97784179449081421 0.41666620969772339 0.97784131765365601 
		0.97784274816513062 0.97784024477005005 0.97784256935119629 1.3333332538604736 
		0.97784125804901123 0.32932561635971069 0.95722657442092896 0.96029192209243774 
		0.99304062128067017 0.99117308855056763 0.97981077432632446 0.96139311790466309 
		0.98135799169540405 0.083333082497119904 0.98967152833938599 0.97784066200256348 
		0.12499983608722687 0.95417231321334839 0.98130041360855103 0.90434366464614868 
		0.95820868015289307 0.20833335816860199 0.94362938404083252 0.9897802472114563 
		0.99978387355804443 0.985481858253479 0.16666616499423981 0.97784161567687988 
		0.97784143686294556 0.97784370183944702 0.97784179449081421 0.41666620969772339 
		0.97784131765365601 0.97784274816513062 0.97784024477005005 0.97784256935119629 
		1.3333332538604736 0.97784125804901123;
	setAttr -s 67 ".koy[7:66]"  -0.27517852187156677 -0.19218878448009491 
		-0.014881154522299767 -0.14335379004478455 -0.20935040712356567 -0.051779452711343765 
		-0.29925784468650818 -0.19248254597187042 -0.42680507898330688 -0.28607019782066345 
		-0.075555458664894104 -0.33100390434265137 -0.14260111749172211 -0.020790720358490944 
		-0.16978086531162262 -0.037423320114612579 -0.20934593677520752 -0.2093469500541687 
		-0.20933623611927032 -0.20934531092643738 -0.089206837117671967 -0.20934759080410004 
		-0.2093406468629837 -0.20935255289077759 -0.20934154093265533 -0.28545838594436646 
		-0.20934769511222839 0.94421643018722534 -0.28933930397033691 -0.27899709343910217 
		-0.11777212470769882 -0.1325741708278656 -0.19992724061012268 -0.27517852187156677 
		-0.19218878448009491 -0.014881154522299767 -0.14335379004478455 -0.20935040712356567 
		-0.051779452711343765 -0.29925784468650818 -0.19248254597187042 -0.42680507898330688 
		-0.28607019782066345 -0.075555458664894104 -0.33100390434265137 -0.14260111749172211 
		-0.020790720358490944 -0.16978086531162262 -0.037423320114612579 -0.20934593677520752 
		-0.2093469500541687 -0.20933623611927032 -0.20934531092643738 -0.089206837117671967 
		-0.20934759080410004 -0.2093406468629837 -0.20935255289077759 -0.20934154093265533 
		-0.28545838594436646 -0.20934769511222839;
createNode animCurveTL -n "avalancheCam_translateZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 11.013924425408712 11 10.604583082986844 
		15 10.437688604293024 22 10.209779069743911 27 9.9853246968284672 34 9.6575770020923972 
		39 9.4546032111838816 42 9.3356249174190058 50 9.0081518420525573 55 8.8019228863514041 
		61 8.5578763647979166 64 8.4351621970451465 67 8.3122552791344262 74 8.0257326146026422 
		84 7.6188430910582587 86 7.53953906464585 93 7.2479840602650594 98 7.0433133881518346 
		106 6.7158403114502834 146 5.078474848312597 199 2.9089657612105384 209 10.604583082986844 
		213 10.437688604293024 220 10.209779069743911 225 9.9853246968284672 232 
		9.6575770020923972 237 9.4546032111838816 240 9.3356249174190058 248 9.0081518420525573 
		253 8.8019228863514041 259 8.5578763647979166 262 8.4351621970451465 265 
		8.3122552791344262 272 8.0257326146026422 282 7.6188430910582587 284 7.53953906464585 
		291 7.2479840602650594 296 7.0433133881518346 304 6.7158403114502834 344 
		5.078474848312597 397 2.9089657612105384;
createNode animCurveTU -n "avalancheCam_scaleX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 1 11 1 15 1 22 1 27 1 34 1 39 
		1 42 1 50 1 55 1 61 1 64 1 67 1 74 1 84 1 86 1 93 1 98 1 106 1 146 1 199 
		1 209 1 213 1 220 1 225 1 232 1 237 1 240 1 248 1 253 1 259 1 262 1 265 1 
		272 1 282 1 284 1 291 1 296 1 304 1 344 1 397 1;
createNode animCurveTU -n "avalancheCam_scaleY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 1 11 1 15 1 22 1 27 1 34 1 39 
		1 42 1 50 1 55 1 61 1 64 1 67 1 74 1 84 1 86 1 93 1 98 1 106 1 146 1 199 
		1 209 1 213 1 220 1 225 1 232 1 237 1 240 1 248 1 253 1 259 1 262 1 265 1 
		272 1 282 1 284 1 291 1 296 1 304 1 344 1 397 1;
createNode animCurveTU -n "avalancheCam_scaleZ";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 41 ".ktv[0:40]"  1 1 11 1 15 1 22 1 27 1 34 1 39 
		1 42 1 50 1 55 1 61 1 64 1 67 1 74 1 84 1 86 1 93 1 98 1 106 1 146 1 199 
		1 209 1 213 1 220 1 225 1 232 1 237 1 240 1 248 1 253 1 259 1 262 1 265 1 
		272 1 282 1 284 1 291 1 296 1 304 1 344 1 397 1;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 4;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 7 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 12 ".u";
select -ne :lightList1;
	setAttr -s 2 ".l";
select -ne :defaultTextureList1;
	setAttr -s 9 ".tx";
select -ne :particleCloud1;
	setAttr ".c" -type "float3" 1 0.96742201 0.96100003 ;
	setAttr ".t" -type "float3" 0.21488 0.21488 0.21488 ;
	setAttr ".n" 0;
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
	setAttr ".top" 392;
	setAttr ".left" 319;
	setAttr ".bot" 232;
	setAttr ".rght" 607;
	setAttr ".an" yes;
	setAttr ".ef" 150;
	setAttr ".ofc" 1;
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultRenderQuality;
	setAttr ".rfl" 10;
	setAttr ".rfr" 10;
	setAttr ".sl" 10;
	setAttr ".eaa" 0;
	setAttr ".ufil" yes;
	setAttr ".ss" 2;
select -ne :defaultResolution;
	setAttr ".w" 720;
	setAttr ".h" 486;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
select -ne :defaultLightSet;
	setAttr -s 2 ".dsm";
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "avalancheShape_emissionDensity.o" "avalancheShape.emissionDensity"
		;
connectAttr "avalanche_emissionThreshold.o" "avalancheShape.emissionThreshold"
		;
connectAttr ":time1.o" "avalancheShape.cti";
connectAttr "geoConnector2.res" "avalancheShape.crs" -na;
connectAttr "geoConnector3.res" "avalancheShape.crs" -na;
connectAttr "geoConnector2.fri" "avalancheShape.cfr" -na;
connectAttr "geoConnector3.fri" "avalancheShape.cfr" -na;
connectAttr "geoConnector2.swg" "avalancheShape.cge" -na;
connectAttr "geoConnector3.swg" "avalancheShape.cge" -na;
connectAttr "uniformField1.of[0]" "avalancheShape.ifc[0]";
connectAttr "expression2.out[0]" "avalancheShape.torx";
connectAttr "expression3.out[0]" "avalancheShape.tti";
connectAttr "cache_avalancheShape.dc" "avalancheShape.dc";
connectAttr "makeNurbPlane1.os" "snowGroundShape.cr";
connectAttr "avalancheShape.fd" "uniformField1.ind[0]";
connectAttr "makeNurbSphere2.os" "IglooShape.cr";
connectAttr "avalancheCam_rotateX.o" "avalancheCam.rx";
connectAttr "avalancheCam_rotateY.o" "avalancheCam.ry";
connectAttr "avalancheCam_rotateZ.o" "avalancheCam.rz";
connectAttr "avalancheCam_visibility.o" "avalancheCam.v";
connectAttr "avalancheCam_translateX.o" "avalancheCam.tx";
connectAttr "avalancheCam_translateY.o" "avalancheCam.ty";
connectAttr "avalancheCam_translateZ.o" "avalancheCam.tz";
connectAttr "avalancheCam_scaleX.o" "avalancheCam.sx";
connectAttr "avalancheCam_scaleY.o" "avalancheCam.sy";
connectAttr "avalancheCam_scaleZ.o" "avalancheCam.sz";
connectAttr "imagePlane1.msg" "avalancheCamShape.ip" -na;
connectAttr "AvalancheView.msg" "avalancheCamShape.b" -na;
connectAttr "snowGroundShape.msg" "geoConnector2.own";
connectAttr "snowGroundShape.wm" "geoConnector2.wm";
connectAttr "snowGroundShape.l" "geoConnector2.lge";
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "snowGroundS.oc" "blinn1SG.ss";
connectAttr "snowGroundShape.iog" "blinn1SG.dsm" -na;
connectAttr "displacementShader1.d" "blinn1SG.ds";
connectAttr "bump2d1.o" "snowGroundS.n";
connectAttr "envSphere1.oc" "snowGroundS.rc";
connectAttr "phong1.oc" "snowGroundS.ic";
connectAttr "fractal1.oa" "bump2d1.bv";
connectAttr "place2dTexture1.o" "fractal1.uv";
connectAttr "place2dTexture1.ofs" "fractal1.fs";
connectAttr "place3dTexture1.wim" "envSphere1.pm";
connectAttr "ramp1.oc" "envSphere1.so";
connectAttr "place2dTexture2.o" "ramp1.uv";
connectAttr "place2dTexture2.ofs" "ramp1.fs";
connectAttr "bump2d2.o" "phong1.n";
connectAttr "fractal2.oa" "bump2d2.bv";
connectAttr "place2dTexture3.o" "fractal2.uv";
connectAttr "place2dTexture3.ofs" "fractal2.fs";
connectAttr "fractal1.oa" "displacementShader1.d";
connectAttr "IglooShape.msg" "geoConnector3.own";
connectAttr "IglooShape.wm" "geoConnector3.wm";
connectAttr "IglooShape.l" "geoConnector3.lge";
connectAttr "blinn3SG.msg" "materialInfo5.sg";
connectAttr "iglooS.oc" "blinn3SG.ss";
connectAttr "IglooShape.iog" "blinn3SG.dsm" -na;
connectAttr "envSphere2.oc" "iglooS.rc";
connectAttr "bump2d3.o" "iglooS.n";
connectAttr "place3dTexture2.wim" "envSphere2.pm";
connectAttr "ramp2.oc" "envSphere2.so";
connectAttr "place2dTexture4.o" "ramp2.uv";
connectAttr "place2dTexture4.ofs" "ramp2.fs";
connectAttr "grid1.oa" "bump2d3.bv";
connectAttr "place2dTexture5.o" "grid1.uv";
connectAttr "place2dTexture5.ofs" "grid1.fs";
connectAttr "noise2.oa" "grid1.ao";
connectAttr "place2dTexture7.o" "noise2.uv";
connectAttr "place2dTexture7.ofs" "noise2.fs";
connectAttr ":time1.o" "expression2.tim";
connectAttr "avalancheShape.windSpeed" "expression2.in[0]";
connectAttr ":time1.o" "expression3.tim";
connectAttr "avalancheShape.windSpeed" "expression3.in[0]";
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "avalancheShape.ocl" "fluidShape1SG.vs";
connectAttr "avalancheShape.iog" "fluidShape1SG.dsm" -na;
connectAttr ":time1.o" "expression1.tim";
connectAttr "avalancheShape.windSpeed" "expression1.in[0]";
connectAttr "avalancheShape.rd" "expression1.in[1]";
connectAttr "avalancheShape.emissionDensity" "expression1.in[2]";
connectAttr "avalancheShape.emissionThreshold" "expression1.in[3]";
connectAttr "avalancheShape.cloudScaleU" "expression1.in[4]";
connectAttr "avalancheShape.cloudScaleV" "expression1.in[5]";
connectAttr "avalancheShape.rh" "expression1.in[6]";
connectAttr "ramp5.oc" "imagePlane1.stx";
connectAttr "place2dTexture10.o" "ramp5.uv";
connectAttr "place2dTexture10.ofs" "ramp5.fs";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[6].llnk";
connectAttr "blinn3SG.msg" "lightLinker1.lnk[6].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn3SG.pa" ":renderPartition.st" -na;
connectAttr "avalancheShape.msg" ":defaultShaderList1.s" -na;
connectAttr "snowGroundS.msg" ":defaultShaderList1.s" -na;
connectAttr "displacementShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "phong1.msg" ":defaultShaderList1.s" -na;
connectAttr "iglooS.msg" ":defaultShaderList1.s" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "bump2d1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "bump2d2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture4.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture5.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "bump2d3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture7.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture10.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "ambientLightShape1.ltd" ":lightList1.l" -na;
connectAttr "fractal1.msg" ":defaultTextureList1.tx" -na;
connectAttr "envSphere1.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "fractal2.msg" ":defaultTextureList1.tx" -na;
connectAttr "envSphere2.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp2.msg" ":defaultTextureList1.tx" -na;
connectAttr "grid1.msg" ":defaultTextureList1.tx" -na;
connectAttr "noise2.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp5.msg" ":defaultTextureList1.tx" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
connectAttr "ambientLight1.iog" ":defaultLightSet.dsm" -na;
// End of Avanlanche.ma
