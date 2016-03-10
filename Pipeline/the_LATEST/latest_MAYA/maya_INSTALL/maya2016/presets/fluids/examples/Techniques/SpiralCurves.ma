//Maya ASCII 5.0 scene
//Name: SpiralCurves.ma
//Last modified: Wed, Mar 19, 2003 02:50:51 PM
requires maya "5.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200303190009";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "fluid1";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode fluidShape -n "fluidShape1" -p "fluid1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 14;
	setAttr ".rh" 20;
	setAttr ".rd" 14;
	setAttr ".dw" 14;
	setAttr ".dh" 20;
	setAttr ".dd" 14;
	setAttr ".scd" 5;
	setAttr ".ssd" 3;
	setAttr ".bod" 4;
	setAttr ".vmt" 1;
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[0].cli" 1;
	setAttr -s 2 ".opa[0:1]"  0 0 1 1 1 1;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0;
	setAttr ".i[0].ic" -type "float3" 0 0 0 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.80000001192092896;
	setAttr ".i[1].ic" -type "float3" 0.89999998 0.2 0 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 1;
	setAttr ".i[2].ic" -type "float3" 1.5 1 0 ;
	setAttr ".i[2].ii" 1;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 2;
	setAttr ".nts" -type "string" (
		"Preset Goal:\r\n"
		+ "Make dynamic objects flow on a surface. \r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "To play this file you need to either load the initial state file spiralCurves.mcfi from the fluids initial state tab, or re-create the state from the instructions below.\r\n"
		+ "There are two nurbs surfaces inside the fluid that are initially hidden in the layer \"surface\". The vertical surface was used to create the curves in the layer \"curves\". The small horizontal surface is a particle emitter. The curves were created by duplicating the isoparms on the vertical nurb surface. The curves were used with the fluid to produce a surface of velocity using Fluid Effects> Add/Edit Contents> With Curve. The initial state of the fluid was saved (velocity only), and the fluid was then applied to the particles as a force (Window> Dynamic Relationships).\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "The particles have a lifespan of 4 seconds, or they would collect at the side of the fluid they are rushing to. The particles need a conserve value of zero for this to work well.The velocity created from the curves needs to have a radius (around the curve) larger than where you expect the particles to flow to make sure that they don't flow out of the surface of velocity.");
createNode transform -n "duplicatedCurve1";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode nurbsCurve -n "duplicatedCurveShape1" -p "duplicatedCurve1";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 5 0 no 3
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		8
		3.2831805016807798 -9.9139183413245764 -0.30534724506769145
		2.1691100931931113 -7.1623585230163682 0.62002402342225849
		0.044014538933144332 -5.5240580397092698 1.9996910389753848
		-3.4434844090115369 -2.2033568906116043 1.4977356609411976
		-3.7288056237804525 2.2394286015411007 -1.1066117495557584
		-0.3827793210893542 5.6931769756652848 -2.1575931115781213
		2.009679470975843 7.2590019570092199 -1.0682752937489808
		3.2977176132155299 10.137705721650033 -0.17993151251358475
		;
createNode transform -n "duplicatedCurve2";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode nurbsCurve -n "duplicatedCurveShape2" -p "duplicatedCurve2";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 5 0 no 3
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		8
		2.4073365081018427 -9.9365746726016422 -0.18320834704061573
		1.4429722331823944 -7.6025277663378992 0.37201441405335439
		-0.30721429258258554 -5.6632340022216718 1.1998146233852305
		-2.7977633605280721 -2.1217216605749893 0.89864139656471886
		-2.9689560893894216 2.1433646871326868 -0.66396704973345533
		-0.56329060859608415 5.7647053637952812 -1.2945558669468726
		1.3473138598520316 7.6605138267336113 -0.64096517624938776
		2.4160587750226927 10.143323373445748 -0.10795890750815001
		;
createNode transform -n "duplicatedCurve3";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode nurbsCurve -n "duplicatedCurveShape3" -p "duplicatedCurve3";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 5 0 no 3
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		8
		1.5314925145229024 -9.9592310038787168 -0.061069449013540007
		0.71683437317167631 -8.042697009659431 0.12400480468445026
		-0.65844312409831307 -5.802409964734073 0.39993820779507649
		-2.1520423120446077 -2.0400864305383735 0.29954713218823986
		-2.2091065549983897 2.0473007727242729 -0.22132234991115199
		-0.74380189610281311 5.8362337519252767 -0.43151862231562399
		0.68494824872822302 8.062025696457999 -0.21365505874979485
		1.534399936829856 10.148941025241461 -0.035986302502715242
		;
createNode transform -n "duplicatedCurve4";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode nurbsCurve -n "duplicatedCurveShape4" -p "duplicatedCurve4";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 5 0 no 3
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		8
		0.65564852094396253 -9.9818873351557844 0.061069449013535761
		-0.0093034868390410586 -8.4828662529809602 -0.12400480468445393
		-1.0096719556140412 -5.9415859272464751 -0.39993820779507783
		-1.5063212635611432 -1.9584512005017578 -0.29954713218823936
		-1.4492570206073596 1.9512368583158588 0.22132234991115132
		-0.92431318360954284 5.9077621400552722 0.43151862231562477
		0.022582637604412273 8.4635375661823904 0.21365505874979823
		0.65274109863701879 10.154558677037178 0.035986302502719558
		;
createNode transform -n "duplicatedCurve5";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode nurbsCurve -n "duplicatedCurveShape5" -p "duplicatedCurve5";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 5 0 no 3
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		8
		-0.22019547263497621 -10.004543666432856 0.18320834704061145
		-0.73544134684975893 -8.9230354963024929 -0.372014414053358
		-1.3609007871297703 -6.080761889758878 -1.1998146233852318
		-0.86060021507767925 -1.8768159704651428 -0.89864139656471831
		-0.68940748621633052 1.8551729439074449 0.66396704973345433
		-1.1048244711162711 5.9792905281852686 1.2945558669468731
		-0.63978297351939717 8.8650494359067817 0.64096517624939109
		-0.22891773955581846 10.160176328832893 0.10795890750815432
		;
createNode transform -n "duplicatedCurve6";
	setAttr ".t" -type "double3" -5.1891199124298737e-006 -0.03617584460521428 
		0.00016512047277217334 ;
createNode nurbsCurve -n "duplicatedCurveShape6" -p "duplicatedCurve6";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 5 0 no 3
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		8
		-1.0960394662139157 -10.02719999770992 0.30534724506768718
		-1.4615792068604758 -9.3632047396240239 -0.62002402342226204
		-1.7121296186454982 -6.21993785227128 -1.9996910389753859
		-0.21487916659421447 -1.7951807404285278 -1.4977356609411971
		0.070442048174699234 1.7591090294990313 1.1066117495557575
		-1.2853357586230021 6.050818916315265 2.1575931115781213
		-1.302148584643207 9.2665613056311713 1.0682752937489841
		-1.1105765777486554 10.165793980628612 0.1799315125135891
		;
createNode transform -n "loftedSurface1";
createNode nurbsSurface -n "loftedSurfaceShape1" -p "loftedSurface1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 1;
	setAttr ".cc" -type "nurbsSurface" 
		3 3 0 0 no 
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		6 0 0 0 1 1 1
		
		32
		3.2831805016807798 -9.5484078463169908 -0.22188223142793709
		3.2831805016807798 -9.5484078463169908 -0.28266745078685318
		3.2831805016807798 -9.5484078463169908 -0.34345267014576919
		3.2831805016807798 -9.5484078463169908 -0.40423788950468525
		2.9912325038211383 -9.5559599567426705 -0.18116926541891187
		2.9912325038211383 -9.5559599567426705 -0.24195448477782791
		2.9912325038211383 -9.5559599567426705 -0.30273970413674395
		2.9912325038211383 -9.5559599567426705 -0.36352492349566007
		2.4073365081018419 -9.571064177594053 -0.099743333400861348
		2.4073365081018419 -9.571064177594053 -0.16052855275977743
		2.4073365081018419 -9.571064177594053 -0.22131377211869349
		2.4073365081018419 -9.571064177594053 -0.28209899147760953
		1.5314925145229026 -9.5937205088711366 0.022395564626214327
		1.5314925145229026 -9.5937205088711366 -0.038389654732701707
		1.5314925145229026 -9.5937205088711366 -0.099174874091617751
		1.5314925145229026 -9.5937205088711366 -0.1599600934505338
		0.65564852094396242 -9.6163768401481953 0.14453446265329006
		0.65564852094396242 -9.6163768401481953 0.083749243294374012
		0.65564852094396242 -9.6163768401481953 0.022964023935457979
		0.65564852094396242 -9.6163768401481953 -0.037821195423458062
		-0.22019547263497596 -9.6390331714252735 0.26667336068036585
		-0.22019547263497596 -9.6390331714252735 0.20588814132144981
		-0.22019547263497596 -9.6390331714252735 0.14510292196253374
		-0.22019547263497596 -9.6390331714252735 0.084317702603617664
		-0.80409146835426915 -9.6541373922766454 0.34809929269841627
		-0.80409146835426915 -9.6541373922766454 0.28731407333950021
		-0.80409146835426915 -9.6541373922766454 0.22652885398058417
		-0.80409146835426915 -9.6541373922766454 0.16574363462166813
		-1.0960394662139157 -9.661689502702334 0.38881225870744157
		-1.0960394662139157 -9.661689502702334 0.32802703934852545
		-1.0960394662139157 -9.661689502702334 0.26724181998960944
		-1.0960394662139157 -9.661689502702334 0.20645660063069338
		
		;
createNode pointEmitter -n "emitter1" -p "loftedSurface1";
	setAttr ".emt" 2;
	setAttr ".rat" 500;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".d" -type "double3" 0 1 0 ;
	setAttr ".spd" -4;
createNode transform -n "particle2";
	setAttr ".t" -type "double3" -0.013977387146120179 4.4408920985006262e-016 
		0.05197530098859815 ;
createNode particle -n "particleShape2" -p "particle2";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" 
		-dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -is true -ci true -sn "colorAccum" -ln "colorAccum" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "useLighting" -ln "useLighting" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "lineWidth" -ln "lineWidth" -dv 1 -min 1 -max 
		20 -at "long";
	addAttr -is true -ci true -sn "multiCount" -ln "multiCount" -dv 10 -min 
		1 -max 60 -at "long";
	addAttr -is true -ci true -sn "multiRadius" -ln "multiRadius" -dv 0.3 -min 
		0 -max 10 -at "float";
	addAttr -is true -ci true -sn "tailFade" -ln "tailFade" -min -1 -max 1 -at "float";
	addAttr -is true -ci true -sn "tailSize" -ln "tailSize" -dv 1 -min -100 
		-max 100 -at "float";
	addAttr -is true -ci true -sn "normalDir" -ln "normalDir" -dv 2 -min 1 -max 
		3 -at "long";
	addAttr -is true -ci true -sn "radius" -ln "radius" -dv 0.5 -min 0 -max 
		10 -at "float";
	addAttr -is true -ci true -sn "threshold" -ln "threshold" -min 0 -max 10 
		-at "float";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "spiralCurvesCam_startup";
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 541;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr ".lfm" 1;
	setAttr ".irx" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 27;
	setAttr ".chw" 499;
	setAttr ".prt" 4;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 4;
	setAttr ".multiRadius" 0.30000001192092896;
	setAttr -k on ".radius" 0.23000000417232513;
createNode transform -n "spiralCuvesCam";
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
	setAttr ".t" -type "double3" 1.4583430609157462 -3.2768535702578894 21.507722800246118 ;
	setAttr ".r" -type "double3" 4.4616472703973784 4.999999999999897 9.9771996363888764e-017 ;
	setAttr ".rp" -type "double3" 0 1.1102230246251565e-016 -3.5527136788005009e-015 ;
	setAttr ".rpt" -type "double3" -1.5749517522815005e-015 -3.6021738565519379e-015 
		-6.266336229388186e-016 ;
createNode camera -n "spiralCuvesCamShape" -p "spiralCuvesCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".ovr" 1.3;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 21.968474105300949;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
createNode diskCache -n "initialState_fluidShape1";
	setAttr ".cn" -type "string" (
		"E:/maya/projects/5_Presets//data/spiralCurves.ma_fluidShape1.mcfi");
	setAttr ".ct" -type "string" "mcfi";
	setAttr ".hcn" -type "string" "hidden3_fluidShape1.mcfi";
createNode geoConnector -n "geoConnector1";
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "blinn1";
	setAttr ".c" -type "float3" 0 1 1 ;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode displayLayer -n "curves";
	setAttr ".v" no;
	setAttr ".do" 1;
createNode displayLayerManager -n "layerManager";
	setAttr ".cdl" 2;
	setAttr -s 3 ".dli[1:2]"  1 2;
	setAttr -s 2 ".dli";
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 27;
select -ne :renderPartition;
	setAttr -s 4 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :particleCloud1;
	setAttr ".t" -type "float3" 0 0 0 ;
	setAttr ".dc" 10;
	setAttr ".sc" -type "float3" 0 1 0 ;
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".mcfr" 33;
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 46;
	setAttr ".left" 4;
	setAttr ".bot" 31;
	setAttr ".rght" 17;
	setAttr ".oft" -type "string" "";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultResolution;
	setAttr ".w" 64;
	setAttr ".h" 64;
	setAttr ".dar" 1;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr ":time1.o" "fluidShape1.cti";
connectAttr "initialState_fluidShape1.dc" "fluidShape1.dcic";
connectAttr "particleShape2.fd" "fluidShape1.ind[0]";
connectAttr "curves.di" "duplicatedCurve1.do";
connectAttr "curves.di" "duplicatedCurveShape1.do";
connectAttr "curves.di" "duplicatedCurve2.do";
connectAttr "curves.di" "duplicatedCurveShape2.do";
connectAttr "curves.di" "duplicatedCurve3.do";
connectAttr "curves.di" "duplicatedCurveShape3.do";
connectAttr "curves.di" "duplicatedCurve4.do";
connectAttr "curves.di" "duplicatedCurveShape4.do";
connectAttr "curves.di" "duplicatedCurve5.do";
connectAttr "curves.di" "duplicatedCurveShape5.do";
connectAttr "curves.di" "duplicatedCurve6.do";
connectAttr "curves.di" "duplicatedCurveShape6.do";
connectAttr ":time1.o" "emitter1.ct";
connectAttr "geoConnector1.ocd" "emitter1.ocd";
connectAttr "geoConnector1.ocl" "emitter1.t";
connectAttr "geoConnector1.pos" "emitter1.opd";
connectAttr "geoConnector1.vel" "emitter1.ovd";
connectAttr "geoConnector1.swg" "emitter1.swge";
connectAttr "particleShape2.ifl" "emitter1.full[0]";
connectAttr "particleShape2.tss" "emitter1.dt[0]";
connectAttr "particleShape2.inh" "emitter1.inh[0]";
connectAttr "particleShape2.stt" "emitter1.stt[0]";
connectAttr "particleShape2.sd[0]" "emitter1.sd[0]";
connectAttr ":time1.o" "particleShape2.cti";
connectAttr "emitter1.ot[0]" "particleShape2.npt[0]";
connectAttr "fluidShape1.of[0]" "particleShape2.ifc[0]";
connectAttr ":time1.o" "geoConnector1.ct";
connectAttr "loftedSurfaceShape1.l" "geoConnector1.lge";
connectAttr "loftedSurfaceShape1.wm" "geoConnector1.wm";
connectAttr "loftedSurfaceShape1.msg" "geoConnector1.own";
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "particleShape2.iog" "blinn1SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "fluidShape1.ocl" "fluidShape1SG.vs";
connectAttr "fluidShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr "layerManager.dli[1]" "curves.id";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "loftedSurfaceShape1.iog" ":initialShadingGroup.dsm" -na;
// End of spiralCurves.ma
