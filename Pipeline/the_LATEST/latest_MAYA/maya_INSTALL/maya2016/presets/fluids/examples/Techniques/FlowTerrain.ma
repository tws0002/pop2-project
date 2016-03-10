//Maya ASCII 5.0 scene
//Name: FlowTerrain.ma
//Last modified: Wed, Mar 19, 2003 02:37:03 PM
requires maya "5.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200303190009";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "fluid1";
	setAttr ".t" -type "double3" -0.034704546406343795 -0.0099480010529675589 
		0.08301619126078208 ;
createNode fluidShape -n "fluidShape1" -p "fluid1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 20;
	setAttr ".rd" 20;
	setAttr ".dw" 10;
	setAttr ".dh" 5;
	setAttr ".dd" 10;
	setAttr ".scw" 10;
	setAttr ".ssw" 3;
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
		+ "Make dynamic objects (particles) flow over a surface. \r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "This fluid needs the initial state file: flowTerrain.mcfi as its initial state. If it is not applied, you can apply it by selecting the fluid, and using the initialState tab in the attribute editor. \r\n"
		+ "There are two nurbs surfaces inside the fluid. The templated vertical one is a surface emitter for particles. The horizontal terrain surface isoparms were duplicated to produce curves. The curves were used with the fluid to produce a surface of velocity using Fluid Effects> Add/Edit Contents> With Curve. The initial state of the fluid was saved (velocity), and then the fluid was applied to the particles as a force (Window> Dynamic Relationships). The particles must be set to a sw render type to show up in a render.\r\n"
		+ "\r\n"
		+ "Finer Points:\r\n"
		+ "The particles have a lifespan of 2.5 seconds, or they would collect at the side of the fluid they are rushing to. The particles need a conserve value of zero for this to work well. Display> Velocity Draw will show the velocity vectors. Once you have created them, you can use Fluid Effects> Add/Edit Contents> Paint Fluids Tool to modify it. The lower the number of curves, the resolution of the fluid, and the radius, the faster Contents from Curve will produce results.");
createNode transform -n "nurbsPlane1";
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
	setAttr ".t" -type "double3" 0 -1.5902639298166332 0 ;
	setAttr ".s" -type "double3" 9.0171768836612785 9.0171768836612785 9.0171768836612785 ;
createNode nurbsSurface -n "nurbsPlaneShape1" -p "nurbsPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 64 ".cp[0:63]" -type "double3" -0.030871111497869252 
		0.10756475266012544 0.0023551365040570538 -0.028626136229825572 0.1136498715786405 
		-0.0064262869584237881 -0.015563916267974154 0.046855753988039518 -0.021741998317440836 
		0.024456325884900154 0.17933252293778348 0.01278028063818179 0.059339947128511872 
		0.14859960339045059 0.0017728878074437238 0.00036258109881487366 0.10544678598258173 
		5.0536921111787869e-006 0 0.10652475070222765 0 0 0.10518761994027501 0 -0.030570303338202265 
		0.14443407028517061 0.001112237122123938 -0.028860812300341931 0.14372627885426409 
		-0.010948668448868659 -0.049533224938392573 0.11078067944397474 -0.048101676830874296 
		-0.034684258031267678 0.18493474384805131 -0.013029401382887662 0.013294752753480021 
		0.12640626311065445 -0.0077717581919155981 -0.0044096377213060922 0.018431244934527136 
		-0.00045972865763166393 -0.001977471157296018 0.014985385629214599 -0.0010844566526636568 
		0.00033752368148681766 0.014171509519395555 -0.0015747410406004025 -0.014957793036852518 
		0.17747489685340681 0.0023380603854451509 -0.015572925806622451 0.1760736933807964 
		-0.010012721846907768 -0.0092638684546256234 0.1254176055966523 -0.054552423370437697 
		-0.0040612253585448066 0.10627666339005545 -0.036115529000138022 0.024982980130419385 
		0.10987700314709256 -0.0043325690206395123 0.025646171293770337 0.10705078737926457 
		0.0015186174738147651 0.011981883226569623 0.055321874940569282 0.00027120075039266389 
		0 0 0 0.00192006195237307 0.17765930438189526 0.00059044631028815076 0.0011844865850289127 
		0.15999216867809518 -0.0037320266494489385 0.00048045329372403689 0.14684295619340773 
		-0.053564857241390318 0 0 0 0 -0.11276469425800668 0 -0.00431833406356813 
		-0.09452348930376378 -0.02208318801613296 -0.0029919541632469626 -0.083352522409769661 
		-0.025851886702063287 0 -0.086819147930625534 -0.0096988188015121324 0.012030251224707009 
		0.17358897521138253 0.00071059879230872536 0.0090381127054358218 0.13961959093430254 
		-0.0019989123644914564 0.010913722815604474 0.12448402198177427 -0.032655013451893922 
		0 0 0 0 -0.10964472248011718 0 0.0058449227502348211 -0.11393260068187186 
		-0.026682953403120435 0.0054734292014860519 -0.10613151670216253 -0.039022281135827008 
		0 -0.11316647027514423 -0.0031536796339364237 0.001522546048334128 0.031514222617479527 
		9.3749225574479844e-005 0.0020025959190752007 0.033192143879195925 0.00055925789471955589 
		0.0008120067708933254 0.018328151339192817 0.00014192385465844337 0.00041938694696841416 
		0.036689100315020429 -0.0047208525949832408 -0.024625609339998911 0.10448341052113685 
		-0.005048506715482487 -0.030507333970290818 0.10809517892120973 0.00053762041688076856 
		-0.0096038667278240397 0.034800481509401793 -0.00029145212689207778 0 -0.0017828410159368645 
		0 0.00010932805081909081 0.015165913484513831 2.469197806032053e-005 0.00024284883885938857 
		0.015163172941606564 3.3143805019619776e-005 0 0 0 0.0023121501944531331 
		0.014972547340719523 0.0003535653743211159 0.024317559399039235 0.087134165878713837 
		0.001666054334204678 0.027005631381081197 0.10482971633696811 -0.0034584491045248633 
		-0.018272661826914893 0.20900348822406062 -0.011768665986984117 -0.055056608064488477 
		0.18846254555919348 -0.012419709092191811 0 0.010998697579073805 0 0 0.01303163220269408 
		0 0 0 0 0 0.085130658510985266 0 0 0.09805625587652754 0 0 0.068639379113569265 
		0 0.0014364718936459298 0.12800011505774542 0.0076120672223388697 -0.023093167163032668 
		0.17571034366411495 0.019041100257976284;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "loftedSurface1";
	setAttr ".tmp" yes;
	setAttr ".t" -type "double3" 0 -0.44500203884954237 0 ;
	setAttr ".s" -type "double3" 0.9014075029682479 0.9014075029682479 0.9014075029682479 ;
	setAttr ".rp" -type "double3" -0.13918513648575825 0.76897496704224699 4.5192067830517617 ;
	setAttr ".sp" -type "double3" -0.15440867313333317 0.85308250098882765 5.0135002961151862 ;
	setAttr ".spt" -type "double3" 0.015223536647574929 -0.084107533946580645 
		-0.49429351306342434 ;
createNode nurbsSurface -n "loftedSurfaceShape1" -p "loftedSurface1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".cc" -type "nurbsSurface" 
		3 3 0 0 no 
		10 0 0 0 0.20000000000000001 0.40000000000000002 0.60000000000000009
		 0.80000000000000004 1 1 1
		6 0 0 0 1 1 1
		
		32
		-5.3105379077045178 1.4525939033112643 5.0252800307925218
		-5.3105379077045178 1.1411883435258339 5.0252800307925218
		-5.3105379077045178 0.82978278374040348 5.0252800307925218
		-5.3105379077045178 0.5183772239549731 5.0252800307925218
		-4.6406327161316288 1.8214139514140071 5.0128467600036952
		-4.6406327161316288 1.5100083916285769 5.0128467600036952
		-4.6406327161316288 1.1986028318431463 5.0128467600036952
		-4.6406327161316288 0.88719727205771592 5.0128467600036952
		-3.1506617388350251 2.1519359146405055 5.0251092108453799
		-3.1506617388350251 1.8405303548550751 5.0251092108453799
		-3.1506617388350251 1.5291247950696445 5.0251092108453799
		-3.1506617388350251 1.2177192352842141 5.0251092108453799
		-0.98113688559473256 2.1537806244943543 5.0076270563390386
		-0.98113688559473256 1.8423750647089239 5.0076270563390386
		-0.98113688559473256 1.5309695049234937 5.0076270563390386
		-0.98113688559473256 1.2195639451380633 5.0076270563390386
		1.1206880221073305 2.1130633262864071 5.0088289946186988
		1.1206880221073305 1.8016577665009768 5.0088289946186988
		1.1206880221073305 1.4902522067155461 5.0088289946186988
		1.1206880221073305 1.1788466469301158 5.0088289946186988
		3.0162630366140895 0.69182690366616617 5.0026583762962007
		3.0162630366140895 0.38042134388073578 5.0026583762962007
		3.0162630366140895 0.069015784095305358 5.0026583762962007
		3.0162630366140895 -0.24238977569012507 5.0026583762962007
		4.3359181432989189 0.52828755579597264 5.0019675661865852
		4.3359181432989189 0.21688199601054226 5.0019675661865852
		4.3359181432989189 -0.094523563774888131 5.0019675661865852
		4.3359181432989189 -0.40592912356031857 5.0019675661865852
		5.0017205614378515 0.48660105683959215 5.0017205614378515
		5.0017205614378515 0.17519549705416174 5.0017205614378515
		5.0017205614378515 -0.13621006273126862 5.0017205614378515
		5.0017205614378515 -0.44761562251669901 5.0017205614378515
		
		;
createNode pointEmitter -n "emitter3" -p "loftedSurface1";
	setAttr ".emt" 2;
	setAttr ".sro" no;
	setAttr -l on ".urpp";
	setAttr ".d" -type "double3" 0 0 -1 ;
	setAttr ".spd" 4;
createNode transform -n "particle3";
createNode particle -n "particleShape3" -p "particle3";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" 
		-dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -is true -ci true -sn "radius" -ln "radius" -dv 0.5 -min 0 -max 
		10 -at "float";
	addAttr -is true -ci true -sn "spriteTwist" -ln "spriteTwist" -min -180 
		-max 180 -at "float";
	addAttr -is true -ci true -sn "spriteScaleX" -ln "spriteScaleX" -dv 1 -at "double";
	addAttr -is true -ci true -sn "spriteScaleY" -ln "spriteScaleY" -dv 1 -at "double";
	addAttr -is true -ci true -sn "spriteNum" -ln "spriteNum" -dv 1 -at "long";
	addAttr -is true -ci true -sn "useLighting" -ln "useLighting" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "betterIllumination" -ln "betterIllumination" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "surfaceShading" -ln "surfaceShading" -min 
		0 -max 1 -at "float";
	addAttr -is true -ci true -sn "threshold" -ln "threshold" -min 0 -max 10 
		-at "float";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "FlowTerrain_startup";
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 62;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr ".lfm" 1;
	setAttr ".irx" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 16;
	setAttr ".chw" 499;
	setAttr ".prt" 4;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
	setAttr -k on ".lifespan" 2.5;
	setAttr -k on ".radius" 0.18600000441074371;
	setAttr ".spriteScaleX" 0.36;
	setAttr ".spriteScaleY" 0.3;
createNode transform -n "duplicatedCurve1";
createNode nurbsCurve -n "duplicatedCurveShape1" -p "duplicatedCurve1";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "duplicatedCurve2";
createNode nurbsCurve -n "duplicatedCurveShape2" -p "duplicatedCurve2";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "duplicatedCurve3";
createNode nurbsCurve -n "duplicatedCurveShape3" -p "duplicatedCurve3";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "duplicatedCurve4";
createNode nurbsCurve -n "duplicatedCurveShape4" -p "duplicatedCurve4";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "duplicatedCurve5";
createNode nurbsCurve -n "duplicatedCurveShape5" -p "duplicatedCurve5";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "duplicatedCurve6";
createNode nurbsCurve -n "duplicatedCurveShape6" -p "duplicatedCurve6";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "flowCamera";
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
	setAttr ".t" -type "double3" -7.3830745716830268 2.1021048682103398 -5.4243520053657122 ;
	setAttr ".r" -type "double3" 164.66164727039697 -51.400000000001512 179.99999999999994 ;
	setAttr ".rp" -type "double3" 8.8817841970012523e-016 0 1.7763568394002505e-015 ;
	setAttr ".rpt" -type "double3" -2.7765524267870623e-015 4.5191469897173699e-016 
		-2.1936352120925947e-015 ;
createNode camera -n "flowCameraShape" -p "flowCamera";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".ovr" 1.3;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 9.384146219861087;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
createNode diskCache -n "initialState_fluidShape1";
	setAttr ".cn" -type "string" (
		"E:/maya/projects/5_Presets//data/FlowTerrain.ma_fluidShape1.mcfi");
	setAttr ".ct" -type "string" "mcfi";
	setAttr ".hcn" -type "string" "hidden3_fluidShape1.mcfi";
createNode geoConnector -n "geoConnector2";
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "blinn2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "blinn2";
	setAttr ".c" -type "float3" 1 1 0 ;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "fluidShape1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".u" 5;
	setAttr ".v" 5;
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "blinn1";
	setAttr ".c" -type "float3" 0.22175999 0.63 0.22890422 ;
createNode curveFromSurfaceIso -n "curveFromSurfaceIso1";
	setAttr ".ihi" 1;
	setAttr ".max" 0;
	setAttr ".idr" 1;
createNode curveFromSurfaceIso -n "curveFromSurfaceIso2";
	setAttr ".ihi" 1;
	setAttr ".max" 0;
	setAttr ".iv" 0.20000000000000001;
	setAttr ".idr" 1;
createNode curveFromSurfaceIso -n "curveFromSurfaceIso3";
	setAttr ".ihi" 1;
	setAttr ".max" 0;
	setAttr ".iv" 0.40000000000000002;
	setAttr ".idr" 1;
createNode curveFromSurfaceIso -n "curveFromSurfaceIso4";
	setAttr ".ihi" 1;
	setAttr ".max" 0;
	setAttr ".iv" 0.6;
	setAttr ".idr" 1;
createNode curveFromSurfaceIso -n "curveFromSurfaceIso5";
	setAttr ".ihi" 1;
	setAttr ".max" 0;
	setAttr ".iv" 0.80000000000000004;
	setAttr ".idr" 1;
createNode curveFromSurfaceIso -n "curveFromSurfaceIso6";
	setAttr ".ihi" 1;
	setAttr ".max" 0;
	setAttr ".iv" 0.99616275397496501;
	setAttr ".idr" 1;
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 16;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".mcfr" 33;
	setAttr ".pfm" -type "string" "";
	setAttr ".top" 299;
	setAttr ".rght" 299;
	setAttr ".oft" -type "string" "";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultResolution;
	setAttr ".w" 300;
	setAttr ".h" 300;
	setAttr ".dar" 1;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr ":time1.o" "fluidShape1.cti";
connectAttr "initialState_fluidShape1.dc" "fluidShape1.dcic";
connectAttr "particleShape3.fd" "fluidShape1.ind[3]";
connectAttr "makeNurbPlane1.os" "nurbsPlaneShape1.cr";
connectAttr ":time1.o" "emitter3.ct";
connectAttr "geoConnector2.ocd" "emitter3.ocd";
connectAttr "geoConnector2.ocl" "emitter3.t";
connectAttr "geoConnector2.pos" "emitter3.opd";
connectAttr "geoConnector2.vel" "emitter3.ovd";
connectAttr "geoConnector2.swg" "emitter3.swge";
connectAttr "particleShape3.ifl" "emitter3.full[0]";
connectAttr "particleShape3.tss" "emitter3.dt[0]";
connectAttr "particleShape3.inh" "emitter3.inh[0]";
connectAttr "particleShape3.stt" "emitter3.stt[0]";
connectAttr "particleShape3.sd[0]" "emitter3.sd[0]";
connectAttr ":time1.o" "particleShape3.cti";
connectAttr "emitter3.ot[0]" "particleShape3.npt[0]";
connectAttr "fluidShape1.of[3]" "particleShape3.ifc[0]";
connectAttr "curveFromSurfaceIso1.oc" "duplicatedCurveShape1.cr";
connectAttr "curveFromSurfaceIso2.oc" "duplicatedCurveShape2.cr";
connectAttr "curveFromSurfaceIso3.oc" "duplicatedCurveShape3.cr";
connectAttr "curveFromSurfaceIso4.oc" "duplicatedCurveShape4.cr";
connectAttr "curveFromSurfaceIso5.oc" "duplicatedCurveShape5.cr";
connectAttr "curveFromSurfaceIso6.oc" "duplicatedCurveShape6.cr";
connectAttr ":time1.o" "geoConnector2.ct";
connectAttr "loftedSurfaceShape1.l" "geoConnector2.lge";
connectAttr "loftedSurfaceShape1.wm" "geoConnector2.wm";
connectAttr "loftedSurfaceShape1.msg" "geoConnector2.own";
connectAttr "blinn2SG.msg" "materialInfo3.sg";
connectAttr "blinn2.oc" "blinn2SG.ss";
connectAttr "particleShape3.iog" "blinn2SG.dsm" -na;
connectAttr "fluidShape1SG.msg" "materialInfo1.sg";
connectAttr "fluidShape1.ocl" "fluidShape1SG.vs";
connectAttr "fluidShape1.iog" "fluidShape1SG.dsm" -na;
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "nurbsPlaneShape1.iog" "blinn1SG.dsm" -na;
connectAttr "nurbsPlaneShape1.ws" "curveFromSurfaceIso1.is";
connectAttr "nurbsPlaneShape1.ws" "curveFromSurfaceIso2.is";
connectAttr "nurbsPlaneShape1.ws" "curveFromSurfaceIso3.is";
connectAttr "nurbsPlaneShape1.ws" "curveFromSurfaceIso4.is";
connectAttr "nurbsPlaneShape1.ws" "curveFromSurfaceIso5.is";
connectAttr "nurbsPlaneShape1.ws" "curveFromSurfaceIso6.is";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "fluidShape1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "blinn2SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr "fluidShape1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn2SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape1.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn2.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "loftedSurfaceShape1.iog" ":initialShadingGroup.dsm" -na;
// End of FlowTerrain.ma
