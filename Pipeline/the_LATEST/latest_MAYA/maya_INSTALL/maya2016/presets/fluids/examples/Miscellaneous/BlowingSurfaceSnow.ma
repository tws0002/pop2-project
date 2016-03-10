//Maya ASCII 5.0 scene
//Name: BlowingSurfaceSnow.ma
//Last modified: Mon, Apr 14, 2003 10:14:35 PM
requires maya "5.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200303260009";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 2 (Build 2195)\n";
createNode transform -n "directionalLight1";
	setAttr ".t" -type "double3" 0 10.206056077870215 0 ;
	setAttr ".r" -type "double3" -47.286961142061941 26.741240624619021 -28.049720294589402 ;
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
	setAttr ".dms" yes;
	setAttr ".fs" 2;
	setAttr ".dr" 1024;
createNode transform -n "ambientLight1";
	setAttr ".t" -type "double3" -10.038427835092003 9.0740018367911137 0 ;
createNode ambientLight -n "ambientLightShape1" -p "ambientLight1";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.68500006 0.88366002 1 ;
	setAttr ".in" 0.5;
	setAttr ".as" 0.36366000771522522;
createNode place3dTexture -n "place3dTexture1";
createNode transform -n "igloo";
	setAttr ".t" -type "double3" 16.38357535685715 0.24155973326511582 8.3202739359732334 ;
	setAttr ".r" -type "double3" 0 0 0.79209348170280147 ;
	setAttr ".s" -type "double3" 5.3634620027665658 5.3634620027665658 5.3634620027665658 ;
createNode nurbsSurface -n "iglooShape" -p "igloo";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
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
	setAttr ".nts" -type "string" "See the fluidShape for notes.";
createNode place3dTexture -n "place3dTexture2";
createNode transform -n "terrain";
	setAttr ".t" -type "double3" 0 0 -27.183803654439835 ;
	setAttr ".s" -type "double3" 149.24775164310813 149.24775164310813 149.24775164310813 ;
createNode nurbsSurface -n "terrainShape" -p "terrain";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 529 ".cp";
	setAttr ".cp[21:186]" -type "double3" 0 -0.0088174536477025178 0 
		0 -0.008817453647702516 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0086592613570741894 
		0 0 0.0086592613570741876 0 0 0.0086592613570741911 0 0 0.0086592613570741894 
		0 0 0.0086592613570741894 0 0 0.0086592613570741894 0 0 0.0086592613570741911 
		0 0 0.0086592613570741876 0 0 0.0117392658377155 0 0 0.0117392658377155 0 
		0 0.011739265837715498 0 0 0.011739265837715502 0 0 0.025525713713044018 
		0 0 0.013786447875328515 0 0 -0.0088174536477025178 0 0 -0.008817453647702516 
		0 0 0 0 0 0 0 0 0 0 0 0.0117392658377155 0 0 0.011739265837715502 0 0 0.011739265837715498 
		0 0 0.0117392658377155 0 0 0.020398527194789691 0 0 0.034184975070118202 
		0 0 0.034184975070118209 0 0 0.034184975070118202 0 0 0.034184975070118202 
		0 0 0.034184975070118202 0 0 0.034184975070118209 0 0 0.034184975070118202 
		0 0 0.025525713713044015 0 0 0.025525713713044015 0 0 0.025525713713044015 
		0 0 0.025525713713044018 0 0 0.025525713713044018 0 0 0.013786447875328515 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.013786447875328515 0 0 0.013786447875328515 
		0 0 0.013786447875328513 0 0 0.013786447875328513 0 0 0.013786447875328513 
		0 0 0.013786447875328513 0 0 0.013786447875328515 0 0 0.013786447875328515 
		0 0 0.022445709232402699 0 0 0.022445709232402702 0 0 0.022445709232402706 
		0 0 0.022445709232402695 0 0 0.013786447875328513 0 0 0.013786447875328513 
		0 0 0.013786447875328513 0 0 0.013786447875328515 0 0 0.013786447875328515 
		0 0 0.013786447875328515 0 0 0 0 0 -0.016988257401639943 0 0 0 0 0 0 0 0 
		0 0 0 0.013786447875328515 0 0 0.013786447875328515 0 0 0.013786447875328513 
		0 0 0.013786447875328513 0 0 0.013786447875328513 0 0 0.013786447875328513 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.041798806846751552 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.016694069883155253 0 0 0.016694069883155253 
		0 0 0 0 0 0 0 0 0.041798806846751545 0 0 0 0 0 0.013041702038400264 0 0 0.023478335796429963 
		0 0 0.023478335796429963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.016694069883155253 0 0 0 
		0 0 0.041798806846751545 0 0 0.031362173088721849 0 0 -0.010436633758029702 
		0 0 0.013041702038400264 0 0 0.023478335796429963 0 0 0.023478335796429963 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.010436633758029704 0 0 -0.010436633758029702 
		0 0 0.013041702038400264 0 0 0.023478335796429963 0 0 0.023478335796429963 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
	setAttr ".cp[200:352]" 0 -0.010436633758029704 0 0 0 0 0 0.05979890500457264 
		0 0 0.023478335796429963 0 0 0.023478335796429963 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.0065640414413920614 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.03632056920814266 0 0 0.036320569208142667 
		0 0 0.03632056920814266 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -0.0065640414413920614 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0.03632056920814266 0 0 0.041695920776535444 0 0 0.0053753515683927873 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.03632056920814266 0 0 
		0.029180528238221596 0 0 0.041695920776535451 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.023805176669828811 0 0 0.023805176669828811 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.023805176669828811 
		0 0 0.023805176669828811 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.024489271694409454 
		0.02229291076010614 0 0.024489271694409454 0.022292910760106137 0 0 0 0 0 
		0.030203751495966685 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0;
	setAttr ".cp[361:518]" 0.024489271694409454 0.02229291076010613 0 
		0.024489271694409454 0.02229291076010614 0 0.024489271694409454 0.022292910760106137 
		0 0.024489271694409454 0.022292910760106133 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0.024489271694409565 0.02229291076010614 0 0.024489271694409565 
		0.022292910760106137 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0071976257582053119 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0071976257582053111 
		0 0 0.0071976257582053119 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0.008453752581077615 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
	setAttr ".fbda" no;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
	setAttr ".nts" -type "string" "See the fluidShape for notes.";
createNode transform -n "fluid1";
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
	setAttr ".t" -type "double3" 0 0.87292149013771514 -27.234408531141614 ;
	setAttr ".s" -type "double3" 1.518398348421776 0.91756081888370111 1.518398348421776 ;
createNode fluidShape -n "fluid1Shape" -p "fluid1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".rt" 1;
	setAttr ".vf" 0;
	setAttr ".iss" yes;
	setAttr ".rw" 100;
	setAttr ".rh" 3;
	setAttr ".rd" 100;
	setAttr ".dw" 100;
	setAttr ".dh" 3;
	setAttr ".dd" 100;
	setAttr ".dmt" 0;
	setAttr ".vmt" 0;
	setAttr ".ss" yes;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0.38571429252624512;
	setAttr ".cl[0].clc" -type "float3" 0.725088 0.72799999 0.72752047 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 0.92857140302658081;
	setAttr ".cl[1].clc" -type "float3" 0.422685 0.465 0.46324393 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".coi" 2;
	setAttr ".cib" 0.22528000175952911;
	setAttr -s 5 ".opa[1:5]"  1 1 1 0.34999999 0.079999998 
		1 0 0 1 0.5642857 0.40000001 1 0.48571429 0.23999999 1;
	setAttr ".opi" 2;
	setAttr ".oib" -0.40540000796318054;
	setAttr ".t" -type "float3" 0.074380003 0.074380003 0.074380003 ;
	setAttr ".shp" 0.61159998178482056;
	setAttr -s 3 ".i";
	setAttr ".i[0].ip" 0.67857140302658081;
	setAttr ".i[0].ic" -type "float3" 0.28441599 0.34989363 0.352 ;
	setAttr ".i[0].ii" 1;
	setAttr ".i[1].ip" 0.49285712838172913;
	setAttr ".i[1].ic" -type "float3" 0.40229201 0.43935639 0.44600001 ;
	setAttr ".i[1].ii" 1;
	setAttr ".i[2].ip" 0.92142856121063232;
	setAttr ".i[2].ic" -type "float3" 0.052667998 0.081248 0.083999999 ;
	setAttr ".i[2].ii" 1;
	setAttr ".ili" 0;
	setAttr ".iib" 0.33327999711036682;
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0 0 0 ;
	setAttr ".env[0].envi" 1;
	setAttr ".dos" 2;
	setAttr ".edr" 0.206619992852211;
	setAttr ".rl" no;
	setAttr ".dl" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".tty" 3;
	setAttr ".ctx" yes;
	setAttr ".ctxg" 0.21488000452518463;
	setAttr ".itx" yes;
	setAttr ".itxg" 0.97519999742507935;
	setAttr ".otx" yes;
	setAttr ".otxg" 0.87603998184204102;
	setAttr ".ivt" yes;
	setAttr ".a" 0.89256000518798828;
	setAttr ".ra" 0.62809997797012329;
	setAttr ".tor" -type "float3" -0.011666667 -0.0099999998 0.0058333334 ;
	setAttr ".dm" 4;
	setAttr ".fq" 0.5785599946975708;
	setAttr ".fr" 2.5622000694274902;
	setAttr ".in" yes;
	setAttr ".nts" -type "string" (
		"Preset Goal:\r\n"
		+ "Snow blowing over a frozen tundra.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "A 3D fluid provides the blowing snow. It is not simulated. Three expressions provide the motion. Expression2  keeps changing the texture time using the current frame to change the composition of the texture. Expression3 uses time to keep moving the Z value of the texture origin. Likewise for the X origin of the texure. This all helps give the swimming effect of the snow while keeping moving in one basic direction. \r\n"
		+ "You don't have to use expressions to achieve this. You could just key it. Expressions allow you to launch and forget, and not worry about your animatio lasting longer than your keys.\r\n"
		+ " Colour, Incandescence and Opacity are all textured. Incandesence helps get the brightness of snow, which scatters light internally, much like a cloud. Inflection is turned on to give more rounded forms to the texture. A lot of the apparent colour of the blowing snow (fluid) is given by the incandescence ramp.\r\n"
		+ "An environment sphere with a blue grey ramp is used in the snow shaders to give blue-grey reflections. The igloo also has a bump map. A fractal is used for bump and displacement. A phong shader with a fractal bump is used to give the little flecks of light to the snow terrain shader.\r\n"
		+ "\r\n"
		+ "Finer Points: \r\n"
		+ "Try making the blowing snow layer deeper with the Y Size. You may also want to increase the Y Resolution if you make the size larger to maintain the same level of detail. Try fiddling with the expressions and seeing the results in a playblast. Slow it down and you might get a nice fog or swamp gas.  ;)  Render time: $$\r\n");
createNode transform -n "surfaceSnowCam";
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
	setAttr ".rp" -type "double3" 7.1054273576010019e-015 -2.2204460492503131e-016 
		3.5527136788005009e-015 ;
	setAttr ".rpt" -type "double3" 4.2702522393687063e-016 8.7937838041319341e-016 
		-1.1056242569069778e-015 ;
createNode camera -n "surfaceSnowCamShape" -p "surfaceSnowCam";
	setAttr -k off ".v";
	setAttr ".ovr" 1.05;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 12.124275236647126;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
createNode expression -n "expression2";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * .6";
createNode expression -n "expression3";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * -0.02";
createNode expression -n "expression4";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0]=time * 0.01";
	setAttr ".nts" -type "string" (
		"Preset Goal:\r\n"
		+ "Snow blowing over a frozen tundra.\r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "A 3D fluid provides the blowing snow. It is not simulated. Three expressions provide the motion. Expression2  keeps changing the texture time using the current frame to change the composition of the texture. Expression3 uses time to keep moving the Z value of the texture origin. Likewise for the X origin of the texure. This all helps give the swimming effect of the snow while keeping moving in one basic direction. \r\n"
		+ "You don't have to use expressions to achieve this. You could just key it. Expressions allow you to launch and forget, and not worry about your animatio lasting longer than your keys.\r\n"
		+ " Colour, Incandescence and Opacity are all textured. Incandesence helps get the brightness of snow, which scatters light internally, much like a cloud. Inflection is turned on to give more rounded forms to the texture. \r\n"
		+ "\r\n"
		+ "Finer Points: \r\n"
		+ "Try making the blowing snow layer deeper with the Y Size. You may also want to increase the Y Resolution if you make the size larger to maintain the same level of detail. Try fiddling with the expressions and seeing the results in a playblast. Slow it down and you might get a nice fog or swamp gas.  ;)  Render time: $$\r\n");
createNode animCurveTU -n "expression4_nodeState";
	setAttr ".tan" 9;
	setAttr ".ktv[0]"  14 0;
	setAttr ".kot[0]"  5;
createNode materialInfo -n "materialInfo6";
createNode shadingEngine -n "fluidShape2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode imagePlane -n "imagePlane1";
	setAttr ".t" 1;
	setAttr ".d" 1000;
	setAttr ".s" -type "double2" 1.4173200000000001 1.0632558580735099 ;
	setAttr ".c" -type "double3" 27.976835617067753 10.984164649598736 29.774343879499042 ;
	setAttr ".w" 10;
	setAttr ".h" 10;
createNode ramp -n "ramp3";
	setAttr ".in" 4;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0.43999999761581421;
	setAttr ".cel[0].ec" -type "float3" 0.64848 0.75515664 0.83999997 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.77100003 0.90187347 1 ;
createNode place2dTexture -n "place2dTexture8";
createNode animCurveTL -n "persp1_translateX";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 32.303169940253312 199 27.486465207620569;
createNode animCurveTL -n "persp1_translateY";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 20.314166405816117 199 5.6116221765529106;
createNode animCurveTL -n "persp1_translateZ";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 45.869407463399931 199 43.790405801472943;
createNode animCurveTA -n "persp1_rotateX";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -24.41780158480686 199 -10.617801584806871;
createNode animCurveTA -n "persp1_rotateY";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 11.416208853139256 199 7.4162088531392936;
createNode animCurveTA -n "persp1_rotateZ";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 199 0;
createNode animCurveTU -n "persp1_visibility";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 199 1;
createNode animCurveTU -n "persp1_scaleX";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 199 1;
createNode animCurveTU -n "persp1_scaleY";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 199 1;
createNode animCurveTU -n "persp1_scaleZ";
	setAttr ".tan" 3;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 199 1;
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".u" 20;
	setAttr ".v" 20;
createNode materialInfo -n "materialInfo2";
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "TerrainS";
	setAttr ".c" -type "float3" 0.61984003 0.61984003 0.61984003 ;
	setAttr ".ambc" -type "float3" 0.45736882 0.4876 0.48300484 ;
	setAttr ".tc" 0.2644599974155426;
	setAttr ".sc" -type "float3" 0.33884001 0.33884001 0.33884001 ;
	setAttr ".rfl" 0.61159998178482056;
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
createNode makeNurbSphere -n "makeNurbSphere2";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode materialInfo -n "materialInfo5";
createNode shadingEngine -n "blinn3SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode blinn -n "IglooS";
	setAttr ".dc" 0.7107200026512146;
	setAttr ".c" -type "float3" 0.52065998 0.50519156 0.49202371 ;
	setAttr ".ambc" -type "float3" 0.49612692 0.52891999 0.52565706 ;
	setAttr ".ic" -type "float3" 0.15889455 0.23088346 0.23965999 ;
	setAttr ".tc" 0.23139999806880951;
	setAttr ".tcf" 0;
	setAttr ".trsd" 1.0331200361251831;
	setAttr ".sc" -type "float3" 2 2 2 ;
	setAttr ".rfl" 0.057859998196363449;
	setAttr ".ec" 0.033059999346733093;
	setAttr ".sro" 0.30577999353408813;
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
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 14;
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
	setAttr ".top" 61;
	setAttr ".left" 184;
	setAttr ".bot" 37;
	setAttr ".rght" 202;
	setAttr ".an" yes;
	setAttr ".ef" 220;
	setAttr ".oft" -type "string" "";
	setAttr ".pff" yes;
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultRenderQuality;
	setAttr ".eaa" 0;
select -ne :defaultResolution;
	setAttr ".pa" 0.75;
	setAttr ".al" yes;
	setAttr ".dar" 1.3329999446868896;
	setAttr ".ldar" yes;
select -ne :defaultLightSet;
	setAttr -s 2 ".dsm";
select -ne :hardwareRenderGlobals;
	setAttr ".fn" -type "string" "default-%4n";
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "makeNurbSphere2.os" "iglooShape.cr";
connectAttr "makeNurbPlane1.os" "terrainShape.cr";
connectAttr ":time1.o" "fluid1Shape.cti";
connectAttr "expression2.out[0]" "fluid1Shape.tti";
connectAttr "expression3.out[0]" "fluid1Shape.torx";
connectAttr "expression4.out[0]" "fluid1Shape.torz";
connectAttr "persp1_translateX.o" "surfaceSnowCam.tx";
connectAttr "persp1_translateY.o" "surfaceSnowCam.ty";
connectAttr "persp1_translateZ.o" "surfaceSnowCam.tz";
connectAttr "persp1_rotateX.o" "surfaceSnowCam.rx";
connectAttr "persp1_rotateY.o" "surfaceSnowCam.ry";
connectAttr "persp1_rotateZ.o" "surfaceSnowCam.rz";
connectAttr "persp1_visibility.o" "surfaceSnowCam.v";
connectAttr "persp1_scaleX.o" "surfaceSnowCam.sx";
connectAttr "persp1_scaleY.o" "surfaceSnowCam.sy";
connectAttr "persp1_scaleZ.o" "surfaceSnowCam.sz";
connectAttr "imagePlane1.msg" "surfaceSnowCamShape.ip" -na;
connectAttr ":time1.o" "expression2.tim";
connectAttr ":time1.o" "expression3.tim";
connectAttr "expression4_nodeState.o" "expression4.nds";
connectAttr ":time1.o" "expression4.tim";
connectAttr "fluidShape2SG.msg" "materialInfo6.sg";
connectAttr "fluid1Shape.ocl" "fluidShape2SG.vs";
connectAttr "fluid1Shape.iog" "fluidShape2SG.dsm" -na;
connectAttr "ramp3.oc" "imagePlane1.stx";
connectAttr "place2dTexture8.o" "ramp3.uv";
connectAttr "place2dTexture8.ofs" "ramp3.fs";
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "TerrainS.oc" "blinn1SG.ss";
connectAttr "terrainShape.iog" "blinn1SG.dsm" -na;
connectAttr "displacementShader1.d" "blinn1SG.ds";
connectAttr "bump2d1.o" "TerrainS.n";
connectAttr "envSphere1.oc" "TerrainS.rc";
connectAttr "phong1.oc" "TerrainS.ic";
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
connectAttr "blinn3SG.msg" "materialInfo5.sg";
connectAttr "IglooS.oc" "blinn3SG.ss";
connectAttr "iglooShape.iog" "blinn3SG.dsm" -na;
connectAttr "envSphere2.oc" "IglooS.rc";
connectAttr "bump2d3.o" "IglooS.n";
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
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[6].llnk";
connectAttr "blinn3SG.msg" "lightLinker1.lnk[6].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[7].llnk";
connectAttr "fluidShape2SG.msg" "lightLinker1.lnk[7].olnk";
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn3SG.pa" ":renderPartition.st" -na;
connectAttr "fluidShape2SG.pa" ":renderPartition.st" -na;
connectAttr "TerrainS.msg" ":defaultShaderList1.s" -na;
connectAttr "displacementShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "phong1.msg" ":defaultShaderList1.s" -na;
connectAttr "IglooS.msg" ":defaultShaderList1.s" -na;
connectAttr "fluid1Shape.msg" ":defaultShaderList1.s" -na;
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
connectAttr "place2dTexture8.msg" ":defaultRenderUtilityList1.u" -na;
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
connectAttr "ramp3.msg" ":defaultTextureList1.tx" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
connectAttr "ambientLight1.iog" ":defaultLightSet.dsm" -na;
// End of BlowingSurfaceSnow.ma
