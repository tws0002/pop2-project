//Maya ASCII 2012 scene
//Name: LargeTankFill.ma
//Last modified: Thu, Sep 06, 2012 04:57:36 PM
//Codeset: 1252
requires maya "2012";
requires "stereoCamera" "10.0";
currentUnit -linear centimeter -angle degree -time film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2012";
fileInfo "version" "2012 Service Pack 2P15 (Subscription Advantage Pack) x64";
fileInfo "cutIdentifier" "201209040117-843677";
fileInfo "osv" "Microsoft Windows 7 Enterprise Edition, 64-bit Windows 7  (Build 7600)\n";
createNode transform -shared -name "persp";
	setAttr ".visibility" no;
	setAttr ".translate" -type "double3" 11.433493988039521 -1.5088647455965276 -0.12786354552075616 ;
	setAttr ".rotate" -type "double3" -1.5383527297681483 91.799999999976947 -360.00000000007822 ;
	setAttr ".rotatePivot" -type "double3" -6.591949208711867e-017 0 -1.7763568394002505e-015 ;
	setAttr ".rotatePivotTranslate" -type "double3" -2.3445189105440086e-015 -1.0810886932941623e-015 
		1.122696304777737e-015 ;
createNode camera -shared -name "perspShape" -parent "persp";
	setAttr -keyable off ".visibility" no;
	setAttr ".focalLength" 26.560902866668943;
	setAttr ".shutterAngle" 250.00000000000003;
	setAttr ".centerOfInterest" 13.882283966005703;
	setAttr ".imageName" -type "string" "persp";
	setAttr ".depthName" -type "string" "persp_depth";
	setAttr ".maskName" -type "string" "persp_mask";
	setAttr ".tumblePivot" -type "double3" 0.057101341012993245 -2.7787585731616815 
		-0.048658229969960054 ;
	setAttr ".homeCommand" -type "string" "viewSet -p %camera";
createNode transform -shared -name "top";
	setAttr ".visibility" no;
	setAttr ".translate" -type "double3" 0 100.1 0 ;
	setAttr ".rotate" -type "double3" -89.999999999999986 0 0 ;
createNode camera -shared -name "topShape" -parent "top";
	setAttr -keyable off ".visibility" no;
	setAttr ".renderable" no;
	setAttr ".centerOfInterest" 100.1;
	setAttr ".orthographicWidth" 30;
	setAttr ".imageName" -type "string" "top";
	setAttr ".depthName" -type "string" "top_depth";
	setAttr ".maskName" -type "string" "top_mask";
	setAttr ".homeCommand" -type "string" "viewSet -t %camera";
	setAttr ".orthographic" yes;
createNode transform -shared -name "front";
	setAttr ".visibility" no;
	setAttr ".translate" -type "double3" 0.038881076135336867 -3.9192124744419798 100.1 ;
createNode camera -shared -name "frontShape" -parent "front";
	setAttr -keyable off ".visibility" no;
	setAttr ".renderable" no;
	setAttr ".centerOfInterest" 100.1;
	setAttr ".orthographicWidth" 11.182197496522949;
	setAttr ".imageName" -type "string" "front";
	setAttr ".depthName" -type "string" "front_depth";
	setAttr ".maskName" -type "string" "front_mask";
	setAttr ".homeCommand" -type "string" "viewSet -f %camera";
	setAttr ".orthographic" yes;
createNode transform -shared -name "side";
	setAttr ".visibility" no;
	setAttr ".translate" -type "double3" 100.1 0 0 ;
	setAttr ".rotate" -type "double3" 0 89.999999999999986 0 ;
createNode camera -shared -name "sideShape" -parent "side";
	setAttr -keyable off ".visibility" no;
	setAttr ".renderable" no;
	setAttr ".centerOfInterest" 100.1;
	setAttr ".orthographicWidth" 30;
	setAttr ".imageName" -type "string" "side";
	setAttr ".depthName" -type "string" "side_depth";
	setAttr ".maskName" -type "string" "side_mask";
	setAttr ".homeCommand" -type "string" "viewSet -s %camera";
	setAttr ".orthographic" yes;
createNode transform -name "fluid1";
	setAttr ".translate" -type "double3" 0 -2.0606768976475505 0 ;
	setAttr ".scale" -type "double3" 1.0187082426694589 1.0187082426694589 1.0187082426694589 ;
createNode fluidShape -name "fluidShape1" -parent "fluid1";
	addAttr -cachedInternally true -shortName "nts" -longName "notes" -dataType "string";
	setAttr -keyable off ".visibility";
	setAttr ".renderType" 1;
	setAttr ".visibleFraction" 0;
	setAttr ".castsShadows" no;
	setAttr ".receiveShadows" no;
	setAttr ".ignoreSelfShadowing" yes;
	setAttr ".primaryVisibility" no;
	setAttr ".smoothShading" no;
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr ".squareVoxels" yes;
	setAttr ".dimensionsW" 1;
	setAttr ".dimensionsH" 1;
	setAttr ".dimensionsD" 1;
	setAttr ".autoResize" yes;
	setAttr ".autoResizeThreshold" 0.20000000298023224;
	setAttr ".autoResizeMargin" 2;
	setAttr ".subVolumeCenterW" 50;
	setAttr ".subVolumeSizeW" 3;
	setAttr ".boundaryDraw" 4;
	setAttr ".velocityDrawLength" 2.1081081072019563;
	setAttr ".velocityDrawSkip" 5;
	setAttr ".shadedDisplay" 0;
	setAttr ".wireframeDisplay" 0;
	setAttr ".solverQuality" 100;
	setAttr ".substeps" 10;
	setAttr ".emitInSubsteps" yes;
	setAttr ".highDetailSolve" 3;
	setAttr ".enableLiquidSimulation" yes;
	setAttr ".liquidMinDensity" 0.44324323534965515;
	setAttr ".liquidMistFall" 0.16216215491294861;
	setAttr ".massRange" 100;
	setAttr ".forwardAdvection" yes;
	setAttr ".boundaryX" 0;
	setAttr ".boundaryY" 0;
	setAttr ".boundaryZ" 0;
	setAttr ".densityBuoyancy" -1.2000000476837158;
	setAttr ".densityTension" 0.079999998211860657;
	setAttr ".tensionForce" 0.029999999329447746;
	setAttr ".densityPressure" 0.81081080436706543;
	setAttr ".gravity" 4.6666665077209473;
	setAttr ".viscosity" 0.019999999552965164;
	setAttr ".turbulenceSpeed" 0.0099999997764825821;
	setAttr ".temperatureMethod" 2;
	setAttr ".temperatureScale" 5;
	setAttr ".temperatureDissipation" 1;
	setAttr ".temperatureDiffusion" 0;
	setAttr ".temperatureTurbulence" 0;
	setAttr ".temperatureNoise" 0.93725490570068359;
	setAttr ".buoyancy" 0;
	setAttr ".temperatureTension" 0.019607841968536377;
	setAttr ".renderInterpolator" 3;
	setAttr -size 2 ".color";
	setAttr ".color[1].color_Position" 0;
	setAttr ".color[1].color_Color" -type "float3" 1 1 1 ;
	setAttr ".color[1].color_Interp" 1;
	setAttr ".color[2].color_Position" 1;
	setAttr ".color[2].color_Color" -type "float3" 0 0 0 ;
	setAttr ".color[2].color_Interp" 1;
	setAttr ".colorInput" 6;
	setAttr ".colorInputBias" 0.058823529630899429;
	setAttr -size 2 ".opacity[1:2]"  1 1 1 0 0 1;
	setAttr ".transparency" -type "float3" 0 0 0 ;
	setAttr ".incandescence[0].incandescence_Position" 0;
	setAttr ".incandescence[0].incandescence_Color" -type "float3" 0 0 0 ;
	setAttr ".incandescence[0].incandescence_Interp" 1;
	setAttr ".incandescenceInput" 0;
	setAttr ".environment[0].environment_Position" 0;
	setAttr ".environment[0].environment_Color" -type "float3" 0 0 0 ;
	setAttr ".environment[0].environment_Interp" 1;
	setAttr ".dropoffShape" 2;
	setAttr ".edgeDropoff" 0.0010000000474974513;
	setAttr ".surfaceRender" yes;
	setAttr ".surfaceThreshold" 0.20928572118282318;
	setAttr ".meshResolution" 0.97000002861022949;
	setAttr ".colorPerVertex" yes;
	setAttr ".useGradientNormals" yes;
	setAttr ".colorTexGain" 0.49729728698730469;
	setAttr ".amplitude" 0.89189189672470093;
	setAttr ".frequency" 22.270269393920898;
	setAttr ".cacheColor" no;
	setAttr ".cacheReaction" no;
	setAttr ".cacheTextureCoordinates" no;
	setAttr ".cacheFalloff" no;
	setAttr ".coordinateSpeed" 0.62162160873413086;
	setAttr ".notes" -type "string" (
		"This fluid uses the liquidAndAir method for water, combined with a temperature grid that is used for foam. The temperature is mapped to fluid color which is then applied to the render of a mesh using color per vertex to map the vertex colors to the transparency of the shader, which is white with a blue/green transparency color. A more sophisticated shading might attempt to layer a foam shader on the water material. The emitter emits density and temperature which are water and foam respectively. The temperature has a high dissipation rate so that the foam disappears over time and one is left with clear water.\n\nThe simulation here was designed for a baseResolution of 20, but it has been lowered to allow faster previewing.\n\nThe fluid uses auto resize and collides with a glass box, in addition to a pipe and a \"grill\". The grill helps add streaky detail to the flow as it comes out of the pipe, much like an aerator in a faucet. Note that for low resolution fluids this grill will block the flow, in which case you may wish to delete or modify it. There is also turbulence on the emitter which also helps add detail without the grill. \n"
		+ "To render, first cache the fluid simulation(density, velocity and temperature). Velocity is needed in the cache if you wish to render with motion blur. When caching you can temporarily make the meshResolution very low so it does not slow down the caching process, then restore it before rendering.\n");
createNode fluidEmitter -name "fluidEmitter2" -parent "fluid1";
	addAttr -cachedInternally true -shortName "nts" -longName "notes" -dataType "string";
	setAttr ".translate" -type "double3" -0.022707857265788833 -0.12151774265195847 
		4.7037741186822268 ;
	setAttr ".rotate" -type "double3" 90 0 0 ;
	setAttr ".scale" -type "double3" 1 0.2 1 ;
	setAttr ".emitterType" 4;
	setAttr -keyable off ".rate";
	setAttr -keyable off ".scaleRateByObjectSize";
	setAttr -lock on -keyable off ".useRatePP";
	setAttr -keyable off ".needParentUV";
	setAttr ".maxDistance" 1;
	setAttr -keyable off ".directionX";
	setAttr -keyable off ".directionY";
	setAttr -keyable off ".directionZ";
	setAttr -keyable off ".spread";
	setAttr -keyable off ".speed";
	setAttr -keyable off ".speedRandom";
	setAttr -keyable off ".tangentSpeed";
	setAttr -keyable off ".normalSpeed";
	setAttr ".volumeShape" 2;
	setAttr -keyable off ".awayFromCenter";
	setAttr -keyable off ".awayFromAxis";
	setAttr -keyable off ".alongAxis";
	setAttr -keyable off ".aroundAxis";
	setAttr -keyable off ".randomDirection";
	setAttr -keyable off ".directionalSpeed";
	setAttr -keyable off ".scaleSpeedBySize";
	setAttr -keyable off ".displaySpeed";
	setAttr ".fluidDropoff" 0;
	setAttr ".fluidJitter" no;
	setAttr ".turbulence" 30;
	setAttr ".turbulenceSpeed" 0.12014134250607592;
	setAttr ".turbulenceFrequency" -type "double3" 4 4 4 ;
	setAttr ".detailTurbulence" 0.85865724339831107;
	setAttr ".densityMethod" 2;
	setAttr ".fluidDensityEmission" 1.1632128931381558;
	setAttr ".heatMethod" 2;
	setAttr ".fluidHeatEmission" 1;
	setAttr ".fluidFuelEmission" 1;
	setAttr ".speedMethod" 2;
	setAttr ".motionStreak" yes;
	setAttr ".notes" -type "string" "The amount of flow coming out of this emitter is determined mainly by the along axis emission speed.  Both density and speed use the Replace method, so that the density will not add new density unless the old is pushed out. The density is set to a little larger than 1 so the density is under pressure when it is emitted. If one used higher values the fluid would explode outward when exiting the tube instead flowing in a linear stream.";
createNode transform -name "pPipe1" -parent "fluidEmitter2";
	setAttr ".translate" -type "double3" -6.8114633938018474e-018 21.135555260757631 
		1.3499887976575494e-015 ;
createNode mesh -name "pPipeShape1" -parent "pPipe1";
	setAttr -keyable off ".visibility";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
createNode transform -name "grill1" -parent "fluidEmitter2";
	setAttr ".translate" -type "double3" -6.8114633938018474e-018 -1.7558397724320773 
		-7.7974949716267535e-017 ;
	setAttr ".scale" -type "double3" 2.2353956142922544 2.2353956142922544 2.2353956142922544 ;
createNode mesh -name "grillShape1" -parent "grill1";
	setAttr -keyable off ".visibility";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
createNode transform -name "pSolid1";
	setAttr ".translate" -type "double3" -1.4072220689700394 -4.4602610176131394 0 ;
	setAttr ".scale" -type "double3" 1.1313186721656523 1.1313186721656523 1.1313186721656523 ;
createNode transform -name "transform6" -parent "pSolid1";
	setAttr ".visibility" no;
createNode mesh -name "pSolidShape1" -parent "transform6";
	setAttr -keyable off ".visibility";
	setAttr ".intermediateObject" yes;
	setAttr -size 2 ".instObjGroups[0].objectGroups";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr -size 8 ".pnts";
	setAttr ".pnts[1]" -type "float3" -0.025908969 8.8817842e-015 0.0057913405 ;
	setAttr ".pnts[19]" -type "float3" -0.015814891 0.043166719 -0.01875679 ;
	setAttr ".pnts[28]" -type "float3" 0.016903164 1.7763568e-015 -0.025249645 ;
	setAttr ".pnts[30]" -type "float3" 0.056879707 -0.022470323 -0.031308424 ;
	setAttr ".pnts[33]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[35]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[62]" -type "float3" -0.026634788 -0.022129519 0.030549075 ;
	setAttr ".pnts[91]" -type "float3" -0.035124771 0.020415056 0.058315698 ;
createNode transform -name "pSolid2";
	setAttr ".translate" -type "double3" -1.4072220689700394 -4.6504102256383169 2.2306579782931033 ;
	setAttr ".rotate" -type "double3" 0 -65.727098701623547 0 ;
	setAttr ".scale" -type "double3" 0.92760132198019563 0.7334021231689799 0.7334021231689799 ;
createNode transform -name "transform5" -parent "pSolid2";
	setAttr ".visibility" no;
createNode mesh -name "pSolidShape2" -parent "transform5";
	setAttr -keyable off ".visibility";
	setAttr ".intermediateObject" yes;
	setAttr ".instObjGroups[0].objectGroups[0].objectGrpCompList" -type "componentList" 
		1 "f[0:179]";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr -size 124 ".uvSet[0].uvSetPoints[0:123]" -type "float2" 0.18181819
		 0.25 0.36363637 0.25 0.54545456 0.25 0.72727275 0.25 0.90909094 0.25 0.090909094
		 0.41666669 0.27272728 0.41666669 0.45454547 0.41666669 0.63636363 0.41666669 0.81818181
		 0.41666669 1 0.41666669 0 0.58333337 0.18181819 0.58333337 0.36363637 0.58333337
		 0.54545456 0.58333337 0.72727275 0.58333337 0.90909094 0.58333337 0.090909094 0.75
		 0.27272728 0.75 0.45454547 0.75 0.63636363 0.75 0.81818181 0.75 0.84848481 0.3611111
		 0.78787875 0.3611111 0.87878788 0.30555555 0.75757575 0.30555555 0.33333331 0.6388889
		 0.39393938 0.6388889 0.30303031 0.69444442 0.42424244 0.69444442 0.48484847 0.58333337
		 0.42424244 0.58333337 0.57575756 0.30555555 0.69696969 0.30555555 0.60606062 0.3611111
		 0.66666669 0.3611111 0.5151515 0.41666666 0.57575756 0.41666669 0.5151515 0.52777779
		 0.4848485 0.47222224 0.12121212 0.3611111 0.96969694 0.3611111 0.15151516 0.30555555
		 0.93939394 0.30555555 0.30303031 0.58333337 0.24242425 0.58333337 0.24242423 0.47222221
		 0.21212122 0.52777779 0.15151516 0.41666666 0.21212122 0.41666669 0.39393938 0.30555555
		 0.5151515 0.30555555 0.42424244 0.3611111 0.4848485 0.3611111 0.30303031 0.3611111
		 0.24242423 0.3611111 0.33333334 0.30555555 0.21212122 0.30555555 0.33333331 0.41666666
		 0.39393941 0.41666669 0.33333331 0.52777779 0.30303031 0.47222224 0.42424241 0.47222221
		 0.39393938 0.52777779 0.87878788 0.41666666 0.93939394 0.41666669 0.15151516 0.6388889
		 0.21212122 0.6388889 0.12121212 0.69444442 0.24242425 0.69444442 0.12121212 0.47222221
		 0.15151516 0.52777779 0.030303031 0.52777779 0.93939388 0.52777779 0.060606062 0.47222224
		 0.969697 0.47222224 0.12121212 0.58333337 0.060606059 0.58333337 0.60606056 0.69444442
		 0.48484847 0.69444442 0.57575756 0.6388889 0.5151515 0.6388889 0.69696963 0.41666666
		 0.75757575 0.41666669 0.66666663 0.47222221 0.69696969 0.52777779 0.57575756 0.52777779
		 0.60606062 0.47222224 0.66666663 0.58333337 0.60606062 0.58333337 0.84848481 0.47222221
		 0.87878788 0.52777779 0.75757575 0.52777779 0.78787881 0.47222224 0.78787875 0.58333337
		 0.84848487 0.58333337 0.78787875 0.69444442 0.66666663 0.69444442 0.75757575 0.6388889
		 0.69696969 0.6388889 0.87878788 0.6388889 0.030303031 0.6388889 0.84848487 0.69444442
		 0.060606062 0.69444442 0.45454544 0.6388889 0.72727275 0.3611111 0.90909088 0.3611111
		 0.27272728 0.6388889 0.45454544 0.52777779 0.5454545 0.3611111 0.5454545 0.47222221
		 0.18181819 0.3611111 0.27272725 0.52777779 0.18181819 0.47222221 0.36363637 0.3611111
		 0.36363634 0.47222221 0.90909088 0.47222221 0.090909094 0.6388889 0.090909094 0.52777779
		 0.63636363 0.6388889 0.72727275 0.47222221 0.63636363 0.52777779 0.81818187 0.52777779
		 0.81818181 0.6388889;
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr -size 8 ".pnts";
	setAttr ".pnts[1]" -type "float3" -0.025908969 8.8817842e-015 0.0057913405 ;
	setAttr ".pnts[19]" -type "float3" -0.015814891 0.043166719 -0.01875679 ;
	setAttr ".pnts[28]" -type "float3" 0.016903164 1.7763568e-015 -0.025249645 ;
	setAttr ".pnts[30]" -type "float3" 0.056879707 -0.022470323 -0.031308424 ;
	setAttr ".pnts[33]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[35]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[62]" -type "float3" -0.026634788 -0.022129519 0.030549075 ;
	setAttr ".pnts[91]" -type "float3" -0.035124771 0.020415056 0.058315698 ;
	setAttr -size 92 ".vrts[0:91]"  0.90142953 -0.02253205 -0.42723766 0.86279839 0.041527987 0.5271647
		 -0.75498474 -0.0082708634 0.4725455 -0.69922256 0.0021455344 -0.43880621 0.01012369 -0.45521826 0.76631624
		 0.0084654447 0.23842825 0.76457042 0.013062222 0.23581591 -0.758636 0.014720455 -0.45783061 -0.75689018
		 -0.46225139 -0.49883354 0.003321924 0.61035442 -0.50782865 0.043731689 0.48543727 0.39996892 0.0043583494
		 -0.37470222 0.49594653 0.0033545829 0.20146541 0.4423452 0.0010297331 -0.10936457 0.48451048 0.00035382912
		 -0.10908622 -0.49600813 0.013096313 0.23507354 -0.5114041 0.025274994 -0.145511 -0.49326798 -0.54117459
		 -0.31614 -0.50040531 -0.25620905 -0.26336446 0.43401659 -0.25712079 -0.12475464 0.34308293 -0.53869444
		 -0.50198561 0.082347535 -0.58647907 -0.23912993 0.1688672 -0.70678151 -0.24651626 -0.32608059 -0.69915622
		 -0.50447899 -0.15410741 -0.57745731 -0.1309783 0.33976367 0.54037851 -0.26828372 0.4302803 0.26150605
		 -0.31927964 -0.49947301 0.26582137 -0.15092295 -0.49149916 0.54940236 -0.54400551 -0.16233967 0.59738642
		 -0.26463693 -0.32686532 0.70474386 -0.25758249 0.16323021 0.71248913 -0.54196316 0.07320191 0.60705847
		 -0.51674235 0.36058858 -0.15168031 -0.63923788 0.18025385 -0.31535363 -0.67420024 0.17350301 0.3425054
		 -0.52755922 0.35542795 0.16773893 -0.78457367 0.0086128302 0.18515497 -0.75988376 0.012191981 -0.15050197
		 -0.60526276 -0.36453271 0.16902554 -0.71827912 -0.1831643 0.34549695 -0.68071109 -0.17624255 -0.31988633
		 -0.59154236 -0.36207366 -0.1550774 0.34512445 0.36754245 0.25875443 0.18017395 0.31995046 0.54064745
		 0.21407214 -0.48196855 0.55855244 0.42885369 -0.49523523 0.29273719 0.0077788136 0.025507206 0.81658834
		 0.0078540081 -0.23273827 0.82078195 0.61010683 0.10135313 0.6429556 0.29201278 0.17067315 0.72535408
		 0.30047348 -0.29953384 0.70965618 0.60724771 -0.12358893 0.62699735 0.42508 -0.49352708 -0.22378445
		 0.21769077 -0.48386663 -0.5165062 0.18609469 0.31534249 -0.53701621 0.35265455 0.36537492 -0.25013685
		 0.3015621 0.14261582 -0.68233234 0.62725186 0.050849993 -0.56806773 0.017593473 -0.23975831 -0.81129879
		 0.017597182 0.019535109 -0.80870742 0.63215363 -0.16777276 -0.55440503 0.3148852 -0.32237241 -0.67114133
		 0.65253639 0.30780512 0.18790174 0.80073011 0.17981395 0.38673237 0.82749736 0.13736463 -0.31149963
		 0.66387451 0.29178286 -0.14835493 0.94984603 0.0044800956 -0.1238998 0.93496466 0.028979477 0.22878379
		 0.75868338 -0.37122011 -0.11905935 0.87086862 -0.19057265 -0.29597917 0.83993709 -0.14847136 0.39674973
		 0.74224257 -0.35283893 0.21525948 0.055180568 -0.50481558 -0.24524413 0.04065451 0.41220278 -0.27336892
		 0.037994199 0.40822685 0.27385715 0.051716939 -0.50617158 0.2812039 -0.43796179 -0.3514761 -0.44809267
		 -0.40031788 0.2811594 -0.44749305 -0.26110443 -0.079931341 -0.73645598 -0.41995627 0.27391541 0.45865941
		 -0.45793697 -0.35482156 0.45957541 -0.28312209 -0.082850605 0.74360394 -0.68241006 0.19543034 0.013783148
		 -0.7316919 -0.1803212 0.012789934 0.49745864 0.25814146 0.48097277 0.53816962 -0.32912272 0.48640364
		 0.31560045 -0.062740676 0.75263095 0.55132532 -0.35330692 -0.41566566 0.50818259 0.22905955 -0.43839738
		 0.33092794 -0.089028113 -0.70798814 0.84871238 0.17121209 0.038457088 0.898817 -0.17198497 0.054271352;
	setAttr -size 270 ".edge";
	setAttr ".edge[0:165]"  1 70 1 9 68 1 0 66 1 0 64 1 10 62 1 0 60 1 7 58 1
		 6 56 1 6 54 1 9 52 1 4 50 1 1 48 1 5 46 1 4 44 1 10 42 1 3 40 1 8 38 1 2 36 1 2 34 1
		 11 32 1 5 30 1 2 28 1 8 26 1 5 24 1 7 22 1 3 20 1 11 18 1 7 16 1 8 14 1 10 12 1 12 13 1
		 13 11 1 14 15 1 15 9 1 16 17 1 17 8 1 18 19 1 19 6 1 20 21 1 21 6 1 22 23 1 23 3 1
		 24 25 1 25 11 1 26 27 1 27 4 1 28 29 1 29 4 1 30 31 1 31 2 1 32 33 1 33 3 1 34 35 1
		 35 11 1 36 37 1 37 3 1 38 39 1 39 2 1 40 41 1 41 8 1 42 43 1 43 5 1 44 45 1 45 9 1
		 46 47 1 47 4 1 48 49 1 49 5 1 50 51 1 51 1 1 52 53 1 53 7 1 54 55 1 55 10 1 56 57 1
		 57 0 1 58 59 1 59 6 1 60 61 1 61 7 1 62 63 1 63 1 1 64 65 1 65 10 1 66 67 1 67 1 1
		 68 69 1 69 0 1 70 71 1 71 9 1 52 72 1 72 17 1 52 15 1 72 15 1 72 14 1 17 14 1 53 16 1
		 53 72 1 16 72 1 18 73 1 73 55 1 18 13 1 73 13 1 73 12 1 55 12 1 19 54 1 19 73 1 54 73 1
		 42 74 1 74 25 1 42 12 1 74 12 1 74 13 1 25 13 1 43 24 1 43 74 1 24 74 1 26 75 1 75 45 1
		 26 14 1 75 14 1 75 15 1 45 15 1 27 44 1 27 75 1 44 75 1 22 76 1 76 41 1 22 16 1 76 16 1
		 76 17 1 41 17 1 23 40 1 23 76 1 40 76 1 32 77 1 77 21 1 32 18 1 77 18 1 77 19 1 21 19 1
		 33 20 1 33 77 1 20 77 1 58 78 1 78 20 1 58 22 1 78 22 1 78 23 1 20 23 1 59 21 1 59 78 1
		 21 78 1 25 79 1 79 31 1 25 35 1 79 35 1 79 34 1 31 34 1 24 30 1 24 79 1 30 79 1 38 80 1
		 80 29 1 38 26 1 80 26 1;
	setAttr ".edge[166:269]" 80 27 1 29 27 1 39 28 1 39 80 1 28 80 1 46 81 1 81 28 1
		 46 30 1 81 30 1 81 31 1 28 31 1 47 29 1 47 81 1 29 81 1 35 82 1 82 37 1 35 32 1 82 32 1
		 82 33 1 37 33 1 34 36 1 34 82 1 36 82 1 41 83 1 83 36 1 41 38 1 83 38 1 83 39 1 36 39 1
		 40 37 1 40 83 1 37 83 1 62 84 1 84 49 1 62 42 1 84 42 1 84 43 1 49 43 1 63 48 1 63 84 1
		 48 84 1 70 85 1 85 44 1 70 51 1 85 51 1 85 50 1 44 50 1 71 45 1 71 85 1 45 85 1 51 86 1
		 86 46 1 51 48 1 86 48 1 86 49 1 46 49 1 50 47 1 50 86 1 47 86 1 68 87 1 87 61 1 68 52 1
		 87 52 1 87 53 1 61 53 1 69 60 1 69 87 1 60 87 1 56 88 1 88 65 1 56 54 1 88 54 1 88 55 1
		 65 55 1 57 64 1 57 88 1 64 88 1 61 89 1 89 56 1 61 58 1 89 58 1 89 59 1 56 59 1 60 57 1
		 60 89 1 57 89 1 65 90 1 90 67 1 65 62 1 90 62 1 90 63 1 67 63 1 64 66 1 64 90 1 66 90 1
		 71 91 1 91 66 1 71 68 1 91 68 1 91 69 1 66 69 1 70 67 1 70 91 1 67 91 1;
	setAttr -size 180 ".face[0:179]" -type "polyFaces" 
		f 3 0 267 85
		mu 0 3 16 100 95
		f 3 3 258 -3
		mu 0 3 15 92 94
		f 3 5 249 75
		mu 0 3 15 88 85
		f 3 -76 240 -4
		mu 0 3 15 85 92
		f 3 -88 231 -6
		mu 0 3 15 99 88
		f 3 10 222 65
		mu 0 3 12 76 71
		f 3 -90 213 63
		mu 0 3 17 103 68
		f 3 -82 204 -12
		mu 0 3 16 91 73
		f 3 15 195 55
		mu 0 3 7 62 59
		f 3 18 186 -18
		mu 0 3 6 54 58
		f 3 -66 177 47
		mu 0 3 12 71 47
		f 3 -58 168 -22
		mu 0 3 6 61 46
		f 3 23 159 -21
		mu 0 3 5 40 48
		f 3 -78 150 39
		mu 0 3 8 87 37
		f 3 -52 141 -26
		mu 0 3 7 53 36
		f 3 -42 132 -16
		mu 0 3 7 39 62
		f 3 -46 123 -14
		mu 0 3 12 45 67
		f 3 -62 114 -24
		mu 0 3 10 65 41
		f 3 -38 105 -9
		mu 0 3 8 35 82
		f 3 -72 96 -28
		mu 0 3 14 81 30
		f 3 95 -29 -36
		mu 0 3 31 27 13
		f 3 -93 -10 -34
		mu 0 3 29 79 19
		f 3 -94 -91 92
		mu 0 3 29 104 79
		f 3 -95 93 -33
		mu 0 3 27 104 29
		f 3 -92 94 -96
		mu 0 3 31 104 27
		f 3 98 91 -35
		mu 0 3 30 104 31
		f 3 -98 -71 90
		mu 0 3 104 81 79
		f 3 -97 97 -99
		mu 0 3 30 81 104
		f 3 104 -30 -74
		mu 0 3 83 23 9
		f 3 -102 -27 -32
		mu 0 3 25 33 3
		f 3 -103 -100 101
		mu 0 3 25 105 33
		f 3 -104 102 -31
		mu 0 3 23 105 25
		f 3 -101 103 -105
		mu 0 3 83 105 23
		f 3 107 100 -73
		mu 0 3 82 105 83
		f 3 -107 -37 99
		mu 0 3 105 35 33
		f 3 -106 106 -108
		mu 0 3 82 35 105
		f 3 113 31 -44
		mu 0 3 43 24 4
		f 3 -111 -15 29
		mu 0 3 22 64 9
		f 3 -112 -109 110
		mu 0 3 22 106 64
		f 3 -113 111 30
		mu 0 3 24 106 22
		f 3 -110 112 -114
		mu 0 3 43 106 24
		f 3 116 109 -43
		mu 0 3 41 106 43
		f 3 -116 -61 108
		mu 0 3 106 65 64
		f 3 -115 115 -117
		mu 0 3 41 65 106
		f 3 122 33 -64
		mu 0 3 69 28 18
		f 3 -120 -23 28
		mu 0 3 26 44 13
		f 3 -121 -118 119
		mu 0 3 26 107 44
		f 3 -122 120 32
		mu 0 3 28 107 26
		f 3 -119 121 -123
		mu 0 3 69 107 28
		f 3 125 118 -63
		mu 0 3 67 107 69
		f 3 -125 -45 117
		mu 0 3 107 45 44
		f 3 -124 124 -126
		mu 0 3 67 45 107
		f 3 131 35 -60
		mu 0 3 63 31 13
		f 3 -129 -25 27
		mu 0 3 30 38 14
		f 3 -130 -127 128
		mu 0 3 30 108 38
		f 3 -131 129 34
		mu 0 3 31 108 30
		f 3 -128 130 -132
		mu 0 3 63 108 31
		f 3 134 127 -59
		mu 0 3 62 108 63
		f 3 -134 -41 126
		mu 0 3 108 39 38
		f 3 -133 133 -135
		mu 0 3 62 39 108
		f 3 140 37 -40
		mu 0 3 37 34 8
		f 3 -138 -20 26
		mu 0 3 32 51 2
		f 3 -139 -136 137
		mu 0 3 32 109 51
		f 3 -140 138 36
		mu 0 3 34 109 32
		f 3 -137 139 -141
		mu 0 3 37 109 34
		f 3 143 136 -39
		mu 0 3 36 109 37
		f 3 -143 -51 135
		mu 0 3 109 53 51
		f 3 -142 142 -144
		mu 0 3 36 53 109
		f 3 149 41 25
		mu 0 3 36 39 7
		f 3 -147 -7 24
		mu 0 3 38 86 14
		f 3 -148 -145 146
		mu 0 3 38 110 86
		f 3 -149 147 40
		mu 0 3 39 110 38
		f 3 -146 148 -150
		mu 0 3 36 110 39
		f 3 152 145 38
		mu 0 3 37 110 36
		f 3 -152 -77 144
		mu 0 3 110 87 86
		f 3 -151 151 -153
		mu 0 3 37 87 110
		f 3 158 -19 -50
		mu 0 3 49 55 6
		f 3 -156 43 -54
		mu 0 3 57 42 0
		f 3 -157 -154 155
		mu 0 3 57 111 42
		f 3 -158 156 -53
		mu 0 3 55 111 57
		f 3 -155 157 -159
		mu 0 3 49 111 55
		f 3 161 154 -49
		mu 0 3 48 111 49
		f 3 -161 42 153
		mu 0 3 111 40 42
		f 3 -160 160 -162
		mu 0 3 48 40 111
		f 3 167 45 -48
		mu 0 3 47 45 12
		f 3 -165 -17 22
		mu 0 3 44 60 13
		f 3 -166 -163 164
		mu 0 3 44 112 60
		f 3 -167 165 44
		mu 0 3 45 112 44
		f 3 -164 166 -168
		mu 0 3 47 112 45
		f 3 170 163 -47
		mu 0 3 46 112 47
		f 3 -170 -57 162
		mu 0 3 112 61 60
		f 3 -169 169 -171
		mu 0 3 46 61 112
		f 3 176 49 21
		mu 0 3 46 49 6
		f 3 -174 -13 20
		mu 0 3 48 70 5
		f 3 -175 -172 173
		mu 0 3 48 113 70
		f 3 -176 174 48
		mu 0 3 49 113 48
		f 3 -173 175 -177
		mu 0 3 46 113 49
		f 3 179 172 46
		mu 0 3 47 113 46
		f 3 -179 -65 171
		mu 0 3 113 71 70
		f 3 -178 178 -180
		mu 0 3 47 71 113
		f 3 185 51 -56
		mu 0 3 59 52 7
		f 3 -183 53 19
		mu 0 3 50 56 1
		f 3 -184 -181 182
		mu 0 3 50 114 56
		f 3 -185 183 50
		mu 0 3 52 114 50
		f 3 -182 184 -186
		mu 0 3 59 114 52
		f 3 188 181 -55
		mu 0 3 58 114 59
		f 3 -188 52 180
		mu 0 3 114 54 56
		f 3 -187 187 -189
		mu 0 3 58 54 114
		f 3 194 57 17
		mu 0 3 58 61 6
		f 3 -192 59 16
		mu 0 3 60 63 13
		f 3 -193 -190 191
		mu 0 3 60 115 63
		f 3 -194 192 56
		mu 0 3 61 115 60
		f 3 -191 193 -195
		mu 0 3 58 115 61
		f 3 197 190 54
		mu 0 3 59 115 58
		f 3 -197 58 189
		mu 0 3 115 62 63
		f 3 -196 196 -198
		mu 0 3 59 62 115
		f 3 203 61 -68
		mu 0 3 75 65 10
		f 3 -201 -5 14
		mu 0 3 64 90 9
		f 3 -202 -199 200
		mu 0 3 64 116 90
		f 3 -203 201 60
		mu 0 3 65 116 64
		f 3 -200 202 -204
		mu 0 3 75 116 65
		f 3 206 199 -67
		mu 0 3 73 116 75
		f 3 -206 -81 198
		mu 0 3 116 91 90
		f 3 -205 205 -207
		mu 0 3 73 91 116
		f 3 212 -11 13
		mu 0 3 66 76 12
		f 3 -210 -1 -70
		mu 0 3 77 101 11
		f 3 -211 -208 209
		mu 0 3 77 117 101
		f 3 -212 210 -69
		mu 0 3 76 117 77
		f 3 -209 211 -213
		mu 0 3 66 117 76
		f 3 215 208 62
		mu 0 3 68 117 66
		f 3 -215 -89 207
		mu 0 3 117 103 101
		f 3 -214 214 -216
		mu 0 3 68 103 117
		f 3 221 67 12
		mu 0 3 70 74 5
		f 3 -219 69 11
		mu 0 3 72 77 11
		f 3 -220 -217 218
		mu 0 3 72 118 77
		f 3 -221 219 66
		mu 0 3 74 118 72
		f 3 -218 220 -222
		mu 0 3 70 118 74
		f 3 224 217 64
		mu 0 3 71 118 70
		f 3 -224 68 216
		mu 0 3 118 76 77
		f 3 -223 223 -225
		mu 0 3 71 76 118
		f 3 230 71 -80
		mu 0 3 89 80 14
		f 3 -228 -2 9
		mu 0 3 78 97 20
		f 3 -229 -226 227
		mu 0 3 78 119 97
		f 3 -230 228 70
		mu 0 3 80 119 78
		f 3 -227 229 -231
		mu 0 3 89 119 80
		f 3 233 226 -79
		mu 0 3 88 119 89
		f 3 -233 -87 225
		mu 0 3 119 99 97
		f 3 -232 232 -234
		mu 0 3 88 99 119
		f 3 239 73 -84
		mu 0 3 93 83 9
		f 3 -237 -8 8
		mu 0 3 82 84 8
		f 3 -238 -235 236
		mu 0 3 82 120 84
		f 3 -239 237 72
		mu 0 3 83 120 82
		f 3 -236 238 -240
		mu 0 3 93 120 83
		f 3 242 235 -83
		mu 0 3 92 120 93
		f 3 -242 -75 234
		mu 0 3 120 85 84
		f 3 -241 241 -243
		mu 0 3 92 85 120
		f 3 248 77 7
		mu 0 3 84 87 8
		f 3 -246 79 6
		mu 0 3 86 89 14
		f 3 -247 -244 245
		mu 0 3 86 121 89
		f 3 -248 246 76
		mu 0 3 87 121 86
		f 3 -245 247 -249
		mu 0 3 84 121 87
		f 3 251 244 74
		mu 0 3 85 121 84
		f 3 -251 78 243
		mu 0 3 121 88 89
		f 3 -250 250 -252
		mu 0 3 85 88 121
		f 3 257 81 -86
		mu 0 3 95 91 16
		f 3 -255 83 4
		mu 0 3 90 93 9
		f 3 -256 -253 254
		mu 0 3 90 122 93
		f 3 -257 255 80
		mu 0 3 91 122 90
		f 3 -254 256 -258
		mu 0 3 95 122 91
		f 3 260 253 -85
		mu 0 3 94 122 95
		f 3 -260 82 252
		mu 0 3 122 92 93
		f 3 -259 259 -261
		mu 0 3 94 92 122
		f 3 266 87 2
		mu 0 3 94 98 15
		f 3 -264 89 1
		mu 0 3 96 102 21
		f 3 -265 -262 263
		mu 0 3 96 123 102
		f 3 -266 264 86
		mu 0 3 98 123 96
		f 3 -263 265 -267
		mu 0 3 94 123 98
		f 3 269 262 84
		mu 0 3 95 123 94
		f 3 -269 88 261
		mu 0 3 123 100 102
		f 3 -268 268 -270
		mu 0 3 95 100 123;
	setAttr ".creaseData" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".creaseVertexData" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".holeFaceData" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -name "pSolid3";
	setAttr ".translate" -type "double3" -1.7113896874372976 -4.8724038347892167 -1.1180070558894328 ;
	setAttr ".rotate" -type "double3" 0 31.906525244719116 0 ;
	setAttr ".scale" -type "double3" 0.25853219993940918 0.2747615550459645 0.42082290120979043 ;
createNode transform -name "transform4" -parent "pSolid3";
	setAttr ".visibility" no;
createNode mesh -name "pSolidShape3" -parent "transform4";
	setAttr -keyable off ".visibility";
	setAttr ".intermediateObject" yes;
	setAttr ".instObjGroups[0].objectGroups[0].objectGrpCompList" -type "componentList" 
		1 "f[0:179]";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr -size 124 ".uvSet[0].uvSetPoints[0:123]" -type "float2" 0.18181819
		 0.25 0.36363637 0.25 0.54545456 0.25 0.72727275 0.25 0.90909094 0.25 0.090909094
		 0.41666669 0.27272728 0.41666669 0.45454547 0.41666669 0.63636363 0.41666669 0.81818181
		 0.41666669 1 0.41666669 0 0.58333337 0.18181819 0.58333337 0.36363637 0.58333337
		 0.54545456 0.58333337 0.72727275 0.58333337 0.90909094 0.58333337 0.090909094 0.75
		 0.27272728 0.75 0.45454547 0.75 0.63636363 0.75 0.81818181 0.75 0.84848481 0.3611111
		 0.78787875 0.3611111 0.87878788 0.30555555 0.75757575 0.30555555 0.33333331 0.6388889
		 0.39393938 0.6388889 0.30303031 0.69444442 0.42424244 0.69444442 0.48484847 0.58333337
		 0.42424244 0.58333337 0.57575756 0.30555555 0.69696969 0.30555555 0.60606062 0.3611111
		 0.66666669 0.3611111 0.5151515 0.41666666 0.57575756 0.41666669 0.5151515 0.52777779
		 0.4848485 0.47222224 0.12121212 0.3611111 0.96969694 0.3611111 0.15151516 0.30555555
		 0.93939394 0.30555555 0.30303031 0.58333337 0.24242425 0.58333337 0.24242423 0.47222221
		 0.21212122 0.52777779 0.15151516 0.41666666 0.21212122 0.41666669 0.39393938 0.30555555
		 0.5151515 0.30555555 0.42424244 0.3611111 0.4848485 0.3611111 0.30303031 0.3611111
		 0.24242423 0.3611111 0.33333334 0.30555555 0.21212122 0.30555555 0.33333331 0.41666666
		 0.39393941 0.41666669 0.33333331 0.52777779 0.30303031 0.47222224 0.42424241 0.47222221
		 0.39393938 0.52777779 0.87878788 0.41666666 0.93939394 0.41666669 0.15151516 0.6388889
		 0.21212122 0.6388889 0.12121212 0.69444442 0.24242425 0.69444442 0.12121212 0.47222221
		 0.15151516 0.52777779 0.030303031 0.52777779 0.93939388 0.52777779 0.060606062 0.47222224
		 0.969697 0.47222224 0.12121212 0.58333337 0.060606059 0.58333337 0.60606056 0.69444442
		 0.48484847 0.69444442 0.57575756 0.6388889 0.5151515 0.6388889 0.69696963 0.41666666
		 0.75757575 0.41666669 0.66666663 0.47222221 0.69696969 0.52777779 0.57575756 0.52777779
		 0.60606062 0.47222224 0.66666663 0.58333337 0.60606062 0.58333337 0.84848481 0.47222221
		 0.87878788 0.52777779 0.75757575 0.52777779 0.78787881 0.47222224 0.78787875 0.58333337
		 0.84848487 0.58333337 0.78787875 0.69444442 0.66666663 0.69444442 0.75757575 0.6388889
		 0.69696969 0.6388889 0.87878788 0.6388889 0.030303031 0.6388889 0.84848487 0.69444442
		 0.060606062 0.69444442 0.45454544 0.6388889 0.72727275 0.3611111 0.90909088 0.3611111
		 0.27272728 0.6388889 0.45454544 0.52777779 0.5454545 0.3611111 0.5454545 0.47222221
		 0.18181819 0.3611111 0.27272725 0.52777779 0.18181819 0.47222221 0.36363637 0.3611111
		 0.36363634 0.47222221 0.90909088 0.47222221 0.090909094 0.6388889 0.090909094 0.52777779
		 0.63636363 0.6388889 0.72727275 0.47222221 0.63636363 0.52777779 0.81818187 0.52777779
		 0.81818181 0.6388889;
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr -size 8 ".pnts";
	setAttr ".pnts[1]" -type "float3" -0.025908969 8.8817842e-015 0.0057913405 ;
	setAttr ".pnts[19]" -type "float3" -0.015814891 0.043166719 -0.01875679 ;
	setAttr ".pnts[28]" -type "float3" 0.016903164 1.7763568e-015 -0.025249645 ;
	setAttr ".pnts[30]" -type "float3" 0.056879707 -0.022470323 -0.031308424 ;
	setAttr ".pnts[33]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[35]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[62]" -type "float3" -0.026634788 -0.022129519 0.030549075 ;
	setAttr ".pnts[91]" -type "float3" -0.035124771 0.020415056 0.058315698 ;
	setAttr -size 92 ".vrts[0:91]"  0.90142953 -0.02253205 -0.42723766 0.86279839 0.041527987 0.5271647
		 -0.75498474 -0.0082708634 0.4725455 -0.69922256 0.0021455344 -0.43880621 0.01012369 -0.45521826 0.76631624
		 0.0084654447 0.23842825 0.76457042 0.013062222 0.23581591 -0.758636 0.014720455 -0.45783061 -0.75689018
		 -0.46225139 -0.49883354 0.003321924 0.61035442 -0.50782865 0.043731689 0.48543727 0.39996892 0.0043583494
		 -0.37470222 0.49594653 0.0033545829 0.20146541 0.4423452 0.0010297331 -0.10936457 0.48451048 0.00035382912
		 -0.10908622 -0.49600813 0.013096313 0.23507354 -0.5114041 0.025274994 -0.145511 -0.49326798 -0.54117459
		 -0.31614 -0.50040531 -0.25620905 -0.26336446 0.43401659 -0.25712079 -0.12475464 0.34308293 -0.53869444
		 -0.50198561 0.082347535 -0.58647907 -0.23912993 0.1688672 -0.70678151 -0.24651626 -0.32608059 -0.69915622
		 -0.50447899 -0.15410741 -0.57745731 -0.1309783 0.33976367 0.54037851 -0.26828372 0.4302803 0.26150605
		 -0.31927964 -0.49947301 0.26582137 -0.15092295 -0.49149916 0.54940236 -0.54400551 -0.16233967 0.59738642
		 -0.26463693 -0.32686532 0.70474386 -0.25758249 0.16323021 0.71248913 -0.54196316 0.07320191 0.60705847
		 -0.51674235 0.36058858 -0.15168031 -0.63923788 0.18025385 -0.31535363 -0.67420024 0.17350301 0.3425054
		 -0.52755922 0.35542795 0.16773893 -0.78457367 0.0086128302 0.18515497 -0.75988376 0.012191981 -0.15050197
		 -0.60526276 -0.36453271 0.16902554 -0.71827912 -0.1831643 0.34549695 -0.68071109 -0.17624255 -0.31988633
		 -0.59154236 -0.36207366 -0.1550774 0.34512445 0.36754245 0.25875443 0.18017395 0.31995046 0.54064745
		 0.21407214 -0.48196855 0.55855244 0.42885369 -0.49523523 0.29273719 0.0077788136 0.025507206 0.81658834
		 0.0078540081 -0.23273827 0.82078195 0.61010683 0.10135313 0.6429556 0.29201278 0.17067315 0.72535408
		 0.30047348 -0.29953384 0.70965618 0.60724771 -0.12358893 0.62699735 0.42508 -0.49352708 -0.22378445
		 0.21769077 -0.48386663 -0.5165062 0.18609469 0.31534249 -0.53701621 0.35265455 0.36537492 -0.25013685
		 0.3015621 0.14261582 -0.68233234 0.62725186 0.050849993 -0.56806773 0.017593473 -0.23975831 -0.81129879
		 0.017597182 0.019535109 -0.80870742 0.63215363 -0.16777276 -0.55440503 0.3148852 -0.32237241 -0.67114133
		 0.65253639 0.30780512 0.18790174 0.80073011 0.17981395 0.38673237 0.82749736 0.13736463 -0.31149963
		 0.66387451 0.29178286 -0.14835493 0.94984603 0.0044800956 -0.1238998 0.93496466 0.028979477 0.22878379
		 0.75868338 -0.37122011 -0.11905935 0.87086862 -0.19057265 -0.29597917 0.83993709 -0.14847136 0.39674973
		 0.74224257 -0.35283893 0.21525948 0.055180568 -0.50481558 -0.24524413 0.04065451 0.41220278 -0.27336892
		 0.037994199 0.40822685 0.27385715 0.051716939 -0.50617158 0.2812039 -0.43796179 -0.3514761 -0.44809267
		 -0.40031788 0.2811594 -0.44749305 -0.26110443 -0.079931341 -0.73645598 -0.41995627 0.27391541 0.45865941
		 -0.45793697 -0.35482156 0.45957541 -0.28312209 -0.082850605 0.74360394 -0.68241006 0.19543034 0.013783148
		 -0.7316919 -0.1803212 0.012789934 0.49745864 0.25814146 0.48097277 0.53816962 -0.32912272 0.48640364
		 0.31560045 -0.062740676 0.75263095 0.55132532 -0.35330692 -0.41566566 0.50818259 0.22905955 -0.43839738
		 0.33092794 -0.089028113 -0.70798814 0.84871238 0.17121209 0.038457088 0.898817 -0.17198497 0.054271352;
	setAttr -size 270 ".edge";
	setAttr ".edge[0:165]"  1 70 1 9 68 1 0 66 1 0 64 1 10 62 1 0 60 1 7 58 1
		 6 56 1 6 54 1 9 52 1 4 50 1 1 48 1 5 46 1 4 44 1 10 42 1 3 40 1 8 38 1 2 36 1 2 34 1
		 11 32 1 5 30 1 2 28 1 8 26 1 5 24 1 7 22 1 3 20 1 11 18 1 7 16 1 8 14 1 10 12 1 12 13 1
		 13 11 1 14 15 1 15 9 1 16 17 1 17 8 1 18 19 1 19 6 1 20 21 1 21 6 1 22 23 1 23 3 1
		 24 25 1 25 11 1 26 27 1 27 4 1 28 29 1 29 4 1 30 31 1 31 2 1 32 33 1 33 3 1 34 35 1
		 35 11 1 36 37 1 37 3 1 38 39 1 39 2 1 40 41 1 41 8 1 42 43 1 43 5 1 44 45 1 45 9 1
		 46 47 1 47 4 1 48 49 1 49 5 1 50 51 1 51 1 1 52 53 1 53 7 1 54 55 1 55 10 1 56 57 1
		 57 0 1 58 59 1 59 6 1 60 61 1 61 7 1 62 63 1 63 1 1 64 65 1 65 10 1 66 67 1 67 1 1
		 68 69 1 69 0 1 70 71 1 71 9 1 52 72 1 72 17 1 52 15 1 72 15 1 72 14 1 17 14 1 53 16 1
		 53 72 1 16 72 1 18 73 1 73 55 1 18 13 1 73 13 1 73 12 1 55 12 1 19 54 1 19 73 1 54 73 1
		 42 74 1 74 25 1 42 12 1 74 12 1 74 13 1 25 13 1 43 24 1 43 74 1 24 74 1 26 75 1 75 45 1
		 26 14 1 75 14 1 75 15 1 45 15 1 27 44 1 27 75 1 44 75 1 22 76 1 76 41 1 22 16 1 76 16 1
		 76 17 1 41 17 1 23 40 1 23 76 1 40 76 1 32 77 1 77 21 1 32 18 1 77 18 1 77 19 1 21 19 1
		 33 20 1 33 77 1 20 77 1 58 78 1 78 20 1 58 22 1 78 22 1 78 23 1 20 23 1 59 21 1 59 78 1
		 21 78 1 25 79 1 79 31 1 25 35 1 79 35 1 79 34 1 31 34 1 24 30 1 24 79 1 30 79 1 38 80 1
		 80 29 1 38 26 1 80 26 1;
	setAttr ".edge[166:269]" 80 27 1 29 27 1 39 28 1 39 80 1 28 80 1 46 81 1 81 28 1
		 46 30 1 81 30 1 81 31 1 28 31 1 47 29 1 47 81 1 29 81 1 35 82 1 82 37 1 35 32 1 82 32 1
		 82 33 1 37 33 1 34 36 1 34 82 1 36 82 1 41 83 1 83 36 1 41 38 1 83 38 1 83 39 1 36 39 1
		 40 37 1 40 83 1 37 83 1 62 84 1 84 49 1 62 42 1 84 42 1 84 43 1 49 43 1 63 48 1 63 84 1
		 48 84 1 70 85 1 85 44 1 70 51 1 85 51 1 85 50 1 44 50 1 71 45 1 71 85 1 45 85 1 51 86 1
		 86 46 1 51 48 1 86 48 1 86 49 1 46 49 1 50 47 1 50 86 1 47 86 1 68 87 1 87 61 1 68 52 1
		 87 52 1 87 53 1 61 53 1 69 60 1 69 87 1 60 87 1 56 88 1 88 65 1 56 54 1 88 54 1 88 55 1
		 65 55 1 57 64 1 57 88 1 64 88 1 61 89 1 89 56 1 61 58 1 89 58 1 89 59 1 56 59 1 60 57 1
		 60 89 1 57 89 1 65 90 1 90 67 1 65 62 1 90 62 1 90 63 1 67 63 1 64 66 1 64 90 1 66 90 1
		 71 91 1 91 66 1 71 68 1 91 68 1 91 69 1 66 69 1 70 67 1 70 91 1 67 91 1;
	setAttr -size 180 ".face[0:179]" -type "polyFaces" 
		f 3 0 267 85
		mu 0 3 16 100 95
		f 3 3 258 -3
		mu 0 3 15 92 94
		f 3 5 249 75
		mu 0 3 15 88 85
		f 3 -76 240 -4
		mu 0 3 15 85 92
		f 3 -88 231 -6
		mu 0 3 15 99 88
		f 3 10 222 65
		mu 0 3 12 76 71
		f 3 -90 213 63
		mu 0 3 17 103 68
		f 3 -82 204 -12
		mu 0 3 16 91 73
		f 3 15 195 55
		mu 0 3 7 62 59
		f 3 18 186 -18
		mu 0 3 6 54 58
		f 3 -66 177 47
		mu 0 3 12 71 47
		f 3 -58 168 -22
		mu 0 3 6 61 46
		f 3 23 159 -21
		mu 0 3 5 40 48
		f 3 -78 150 39
		mu 0 3 8 87 37
		f 3 -52 141 -26
		mu 0 3 7 53 36
		f 3 -42 132 -16
		mu 0 3 7 39 62
		f 3 -46 123 -14
		mu 0 3 12 45 67
		f 3 -62 114 -24
		mu 0 3 10 65 41
		f 3 -38 105 -9
		mu 0 3 8 35 82
		f 3 -72 96 -28
		mu 0 3 14 81 30
		f 3 95 -29 -36
		mu 0 3 31 27 13
		f 3 -93 -10 -34
		mu 0 3 29 79 19
		f 3 -94 -91 92
		mu 0 3 29 104 79
		f 3 -95 93 -33
		mu 0 3 27 104 29
		f 3 -92 94 -96
		mu 0 3 31 104 27
		f 3 98 91 -35
		mu 0 3 30 104 31
		f 3 -98 -71 90
		mu 0 3 104 81 79
		f 3 -97 97 -99
		mu 0 3 30 81 104
		f 3 104 -30 -74
		mu 0 3 83 23 9
		f 3 -102 -27 -32
		mu 0 3 25 33 3
		f 3 -103 -100 101
		mu 0 3 25 105 33
		f 3 -104 102 -31
		mu 0 3 23 105 25
		f 3 -101 103 -105
		mu 0 3 83 105 23
		f 3 107 100 -73
		mu 0 3 82 105 83
		f 3 -107 -37 99
		mu 0 3 105 35 33
		f 3 -106 106 -108
		mu 0 3 82 35 105
		f 3 113 31 -44
		mu 0 3 43 24 4
		f 3 -111 -15 29
		mu 0 3 22 64 9
		f 3 -112 -109 110
		mu 0 3 22 106 64
		f 3 -113 111 30
		mu 0 3 24 106 22
		f 3 -110 112 -114
		mu 0 3 43 106 24
		f 3 116 109 -43
		mu 0 3 41 106 43
		f 3 -116 -61 108
		mu 0 3 106 65 64
		f 3 -115 115 -117
		mu 0 3 41 65 106
		f 3 122 33 -64
		mu 0 3 69 28 18
		f 3 -120 -23 28
		mu 0 3 26 44 13
		f 3 -121 -118 119
		mu 0 3 26 107 44
		f 3 -122 120 32
		mu 0 3 28 107 26
		f 3 -119 121 -123
		mu 0 3 69 107 28
		f 3 125 118 -63
		mu 0 3 67 107 69
		f 3 -125 -45 117
		mu 0 3 107 45 44
		f 3 -124 124 -126
		mu 0 3 67 45 107
		f 3 131 35 -60
		mu 0 3 63 31 13
		f 3 -129 -25 27
		mu 0 3 30 38 14
		f 3 -130 -127 128
		mu 0 3 30 108 38
		f 3 -131 129 34
		mu 0 3 31 108 30
		f 3 -128 130 -132
		mu 0 3 63 108 31
		f 3 134 127 -59
		mu 0 3 62 108 63
		f 3 -134 -41 126
		mu 0 3 108 39 38
		f 3 -133 133 -135
		mu 0 3 62 39 108
		f 3 140 37 -40
		mu 0 3 37 34 8
		f 3 -138 -20 26
		mu 0 3 32 51 2
		f 3 -139 -136 137
		mu 0 3 32 109 51
		f 3 -140 138 36
		mu 0 3 34 109 32
		f 3 -137 139 -141
		mu 0 3 37 109 34
		f 3 143 136 -39
		mu 0 3 36 109 37
		f 3 -143 -51 135
		mu 0 3 109 53 51
		f 3 -142 142 -144
		mu 0 3 36 53 109
		f 3 149 41 25
		mu 0 3 36 39 7
		f 3 -147 -7 24
		mu 0 3 38 86 14
		f 3 -148 -145 146
		mu 0 3 38 110 86
		f 3 -149 147 40
		mu 0 3 39 110 38
		f 3 -146 148 -150
		mu 0 3 36 110 39
		f 3 152 145 38
		mu 0 3 37 110 36
		f 3 -152 -77 144
		mu 0 3 110 87 86
		f 3 -151 151 -153
		mu 0 3 37 87 110
		f 3 158 -19 -50
		mu 0 3 49 55 6
		f 3 -156 43 -54
		mu 0 3 57 42 0
		f 3 -157 -154 155
		mu 0 3 57 111 42
		f 3 -158 156 -53
		mu 0 3 55 111 57
		f 3 -155 157 -159
		mu 0 3 49 111 55
		f 3 161 154 -49
		mu 0 3 48 111 49
		f 3 -161 42 153
		mu 0 3 111 40 42
		f 3 -160 160 -162
		mu 0 3 48 40 111
		f 3 167 45 -48
		mu 0 3 47 45 12
		f 3 -165 -17 22
		mu 0 3 44 60 13
		f 3 -166 -163 164
		mu 0 3 44 112 60
		f 3 -167 165 44
		mu 0 3 45 112 44
		f 3 -164 166 -168
		mu 0 3 47 112 45
		f 3 170 163 -47
		mu 0 3 46 112 47
		f 3 -170 -57 162
		mu 0 3 112 61 60
		f 3 -169 169 -171
		mu 0 3 46 61 112
		f 3 176 49 21
		mu 0 3 46 49 6
		f 3 -174 -13 20
		mu 0 3 48 70 5
		f 3 -175 -172 173
		mu 0 3 48 113 70
		f 3 -176 174 48
		mu 0 3 49 113 48
		f 3 -173 175 -177
		mu 0 3 46 113 49
		f 3 179 172 46
		mu 0 3 47 113 46
		f 3 -179 -65 171
		mu 0 3 113 71 70
		f 3 -178 178 -180
		mu 0 3 47 71 113
		f 3 185 51 -56
		mu 0 3 59 52 7
		f 3 -183 53 19
		mu 0 3 50 56 1
		f 3 -184 -181 182
		mu 0 3 50 114 56
		f 3 -185 183 50
		mu 0 3 52 114 50
		f 3 -182 184 -186
		mu 0 3 59 114 52
		f 3 188 181 -55
		mu 0 3 58 114 59
		f 3 -188 52 180
		mu 0 3 114 54 56
		f 3 -187 187 -189
		mu 0 3 58 54 114
		f 3 194 57 17
		mu 0 3 58 61 6
		f 3 -192 59 16
		mu 0 3 60 63 13
		f 3 -193 -190 191
		mu 0 3 60 115 63
		f 3 -194 192 56
		mu 0 3 61 115 60
		f 3 -191 193 -195
		mu 0 3 58 115 61
		f 3 197 190 54
		mu 0 3 59 115 58
		f 3 -197 58 189
		mu 0 3 115 62 63
		f 3 -196 196 -198
		mu 0 3 59 62 115
		f 3 203 61 -68
		mu 0 3 75 65 10
		f 3 -201 -5 14
		mu 0 3 64 90 9
		f 3 -202 -199 200
		mu 0 3 64 116 90
		f 3 -203 201 60
		mu 0 3 65 116 64
		f 3 -200 202 -204
		mu 0 3 75 116 65
		f 3 206 199 -67
		mu 0 3 73 116 75
		f 3 -206 -81 198
		mu 0 3 116 91 90
		f 3 -205 205 -207
		mu 0 3 73 91 116
		f 3 212 -11 13
		mu 0 3 66 76 12
		f 3 -210 -1 -70
		mu 0 3 77 101 11
		f 3 -211 -208 209
		mu 0 3 77 117 101
		f 3 -212 210 -69
		mu 0 3 76 117 77
		f 3 -209 211 -213
		mu 0 3 66 117 76
		f 3 215 208 62
		mu 0 3 68 117 66
		f 3 -215 -89 207
		mu 0 3 117 103 101
		f 3 -214 214 -216
		mu 0 3 68 103 117
		f 3 221 67 12
		mu 0 3 70 74 5
		f 3 -219 69 11
		mu 0 3 72 77 11
		f 3 -220 -217 218
		mu 0 3 72 118 77
		f 3 -221 219 66
		mu 0 3 74 118 72
		f 3 -218 220 -222
		mu 0 3 70 118 74
		f 3 224 217 64
		mu 0 3 71 118 70
		f 3 -224 68 216
		mu 0 3 118 76 77
		f 3 -223 223 -225
		mu 0 3 71 76 118
		f 3 230 71 -80
		mu 0 3 89 80 14
		f 3 -228 -2 9
		mu 0 3 78 97 20
		f 3 -229 -226 227
		mu 0 3 78 119 97
		f 3 -230 228 70
		mu 0 3 80 119 78
		f 3 -227 229 -231
		mu 0 3 89 119 80
		f 3 233 226 -79
		mu 0 3 88 119 89
		f 3 -233 -87 225
		mu 0 3 119 99 97
		f 3 -232 232 -234
		mu 0 3 88 99 119
		f 3 239 73 -84
		mu 0 3 93 83 9
		f 3 -237 -8 8
		mu 0 3 82 84 8
		f 3 -238 -235 236
		mu 0 3 82 120 84
		f 3 -239 237 72
		mu 0 3 83 120 82
		f 3 -236 238 -240
		mu 0 3 93 120 83
		f 3 242 235 -83
		mu 0 3 92 120 93
		f 3 -242 -75 234
		mu 0 3 120 85 84
		f 3 -241 241 -243
		mu 0 3 92 85 120
		f 3 248 77 7
		mu 0 3 84 87 8
		f 3 -246 79 6
		mu 0 3 86 89 14
		f 3 -247 -244 245
		mu 0 3 86 121 89
		f 3 -248 246 76
		mu 0 3 87 121 86
		f 3 -245 247 -249
		mu 0 3 84 121 87
		f 3 251 244 74
		mu 0 3 85 121 84
		f 3 -251 78 243
		mu 0 3 121 88 89
		f 3 -250 250 -252
		mu 0 3 85 88 121
		f 3 257 81 -86
		mu 0 3 95 91 16
		f 3 -255 83 4
		mu 0 3 90 93 9
		f 3 -256 -253 254
		mu 0 3 90 122 93
		f 3 -257 255 80
		mu 0 3 91 122 90
		f 3 -254 256 -258
		mu 0 3 95 122 91
		f 3 260 253 -85
		mu 0 3 94 122 95
		f 3 -260 82 252
		mu 0 3 122 92 93
		f 3 -259 259 -261
		mu 0 3 94 92 122
		f 3 266 87 2
		mu 0 3 94 98 15
		f 3 -264 89 1
		mu 0 3 96 102 21
		f 3 -265 -262 263
		mu 0 3 96 123 102
		f 3 -266 264 86
		mu 0 3 98 123 96
		f 3 -263 265 -267
		mu 0 3 94 123 98
		f 3 269 262 84
		mu 0 3 95 123 94
		f 3 -269 88 261
		mu 0 3 123 100 102
		f 3 -268 268 -270
		mu 0 3 95 100 123;
	setAttr ".creaseData" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".creaseVertexData" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".holeFaceData" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -name "pSolid4";
	setAttr ".translate" -type "double3" 1.844371403906921 -4.7603900485960766 -1.9025932172886995 ;
	setAttr ".rotate" -type "double3" 0 -180.81941604308892 0 ;
	setAttr ".scale" -type "double3" 0.63305699340922716 0.50052251118202984 0.50052251118202984 ;
createNode transform -name "transform3" -parent "pSolid4";
	setAttr ".visibility" no;
createNode mesh -name "pSolidShape4" -parent "transform3";
	setAttr -keyable off ".visibility";
	setAttr ".intermediateObject" yes;
	setAttr ".instObjGroups[0].objectGroups[0].objectGrpCompList" -type "componentList" 
		1 "f[0:179]";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr -size 124 ".uvSet[0].uvSetPoints[0:123]" -type "float2" 0.18181819
		 0.25 0.36363637 0.25 0.54545456 0.25 0.72727275 0.25 0.90909094 0.25 0.090909094
		 0.41666669 0.27272728 0.41666669 0.45454547 0.41666669 0.63636363 0.41666669 0.81818181
		 0.41666669 1 0.41666669 0 0.58333337 0.18181819 0.58333337 0.36363637 0.58333337
		 0.54545456 0.58333337 0.72727275 0.58333337 0.90909094 0.58333337 0.090909094 0.75
		 0.27272728 0.75 0.45454547 0.75 0.63636363 0.75 0.81818181 0.75 0.84848481 0.3611111
		 0.78787875 0.3611111 0.87878788 0.30555555 0.75757575 0.30555555 0.33333331 0.6388889
		 0.39393938 0.6388889 0.30303031 0.69444442 0.42424244 0.69444442 0.48484847 0.58333337
		 0.42424244 0.58333337 0.57575756 0.30555555 0.69696969 0.30555555 0.60606062 0.3611111
		 0.66666669 0.3611111 0.5151515 0.41666666 0.57575756 0.41666669 0.5151515 0.52777779
		 0.4848485 0.47222224 0.12121212 0.3611111 0.96969694 0.3611111 0.15151516 0.30555555
		 0.93939394 0.30555555 0.30303031 0.58333337 0.24242425 0.58333337 0.24242423 0.47222221
		 0.21212122 0.52777779 0.15151516 0.41666666 0.21212122 0.41666669 0.39393938 0.30555555
		 0.5151515 0.30555555 0.42424244 0.3611111 0.4848485 0.3611111 0.30303031 0.3611111
		 0.24242423 0.3611111 0.33333334 0.30555555 0.21212122 0.30555555 0.33333331 0.41666666
		 0.39393941 0.41666669 0.33333331 0.52777779 0.30303031 0.47222224 0.42424241 0.47222221
		 0.39393938 0.52777779 0.87878788 0.41666666 0.93939394 0.41666669 0.15151516 0.6388889
		 0.21212122 0.6388889 0.12121212 0.69444442 0.24242425 0.69444442 0.12121212 0.47222221
		 0.15151516 0.52777779 0.030303031 0.52777779 0.93939388 0.52777779 0.060606062 0.47222224
		 0.969697 0.47222224 0.12121212 0.58333337 0.060606059 0.58333337 0.60606056 0.69444442
		 0.48484847 0.69444442 0.57575756 0.6388889 0.5151515 0.6388889 0.69696963 0.41666666
		 0.75757575 0.41666669 0.66666663 0.47222221 0.69696969 0.52777779 0.57575756 0.52777779
		 0.60606062 0.47222224 0.66666663 0.58333337 0.60606062 0.58333337 0.84848481 0.47222221
		 0.87878788 0.52777779 0.75757575 0.52777779 0.78787881 0.47222224 0.78787875 0.58333337
		 0.84848487 0.58333337 0.78787875 0.69444442 0.66666663 0.69444442 0.75757575 0.6388889
		 0.69696969 0.6388889 0.87878788 0.6388889 0.030303031 0.6388889 0.84848487 0.69444442
		 0.060606062 0.69444442 0.45454544 0.6388889 0.72727275 0.3611111 0.90909088 0.3611111
		 0.27272728 0.6388889 0.45454544 0.52777779 0.5454545 0.3611111 0.5454545 0.47222221
		 0.18181819 0.3611111 0.27272725 0.52777779 0.18181819 0.47222221 0.36363637 0.3611111
		 0.36363634 0.47222221 0.90909088 0.47222221 0.090909094 0.6388889 0.090909094 0.52777779
		 0.63636363 0.6388889 0.72727275 0.47222221 0.63636363 0.52777779 0.81818187 0.52777779
		 0.81818181 0.6388889;
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr -size 8 ".pnts";
	setAttr ".pnts[1]" -type "float3" -0.025908969 8.8817842e-015 0.0057913405 ;
	setAttr ".pnts[19]" -type "float3" -0.015814891 0.043166719 -0.01875679 ;
	setAttr ".pnts[28]" -type "float3" 0.016903164 1.7763568e-015 -0.025249645 ;
	setAttr ".pnts[30]" -type "float3" 0.056879707 -0.022470323 -0.031308424 ;
	setAttr ".pnts[33]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[35]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[62]" -type "float3" -0.026634788 -0.022129519 0.030549075 ;
	setAttr ".pnts[91]" -type "float3" -0.035124771 0.020415056 0.058315698 ;
	setAttr -size 92 ".vrts[0:91]"  0.90142953 -0.02253205 -0.42723766 0.86279839 0.041527987 0.5271647
		 -0.75498474 -0.0082708634 0.4725455 -0.69922256 0.0021455344 -0.43880621 0.01012369 -0.45521826 0.76631624
		 0.0084654447 0.23842825 0.76457042 0.013062222 0.23581591 -0.758636 0.014720455 -0.45783061 -0.75689018
		 -0.46225139 -0.49883354 0.003321924 0.61035442 -0.50782865 0.043731689 0.48543727 0.39996892 0.0043583494
		 -0.37470222 0.49594653 0.0033545829 0.20146541 0.4423452 0.0010297331 -0.10936457 0.48451048 0.00035382912
		 -0.10908622 -0.49600813 0.013096313 0.23507354 -0.5114041 0.025274994 -0.145511 -0.49326798 -0.54117459
		 -0.31614 -0.50040531 -0.25620905 -0.26336446 0.43401659 -0.25712079 -0.12475464 0.34308293 -0.53869444
		 -0.50198561 0.082347535 -0.58647907 -0.23912993 0.1688672 -0.70678151 -0.24651626 -0.32608059 -0.69915622
		 -0.50447899 -0.15410741 -0.57745731 -0.1309783 0.33976367 0.54037851 -0.26828372 0.4302803 0.26150605
		 -0.31927964 -0.49947301 0.26582137 -0.15092295 -0.49149916 0.54940236 -0.54400551 -0.16233967 0.59738642
		 -0.26463693 -0.32686532 0.70474386 -0.25758249 0.16323021 0.71248913 -0.54196316 0.07320191 0.60705847
		 -0.51674235 0.36058858 -0.15168031 -0.63923788 0.18025385 -0.31535363 -0.67420024 0.17350301 0.3425054
		 -0.52755922 0.35542795 0.16773893 -0.78457367 0.0086128302 0.18515497 -0.75988376 0.012191981 -0.15050197
		 -0.60526276 -0.36453271 0.16902554 -0.71827912 -0.1831643 0.34549695 -0.68071109 -0.17624255 -0.31988633
		 -0.59154236 -0.36207366 -0.1550774 0.34512445 0.36754245 0.25875443 0.18017395 0.31995046 0.54064745
		 0.21407214 -0.48196855 0.55855244 0.42885369 -0.49523523 0.29273719 0.0077788136 0.025507206 0.81658834
		 0.0078540081 -0.23273827 0.82078195 0.61010683 0.10135313 0.6429556 0.29201278 0.17067315 0.72535408
		 0.30047348 -0.29953384 0.70965618 0.60724771 -0.12358893 0.62699735 0.42508 -0.49352708 -0.22378445
		 0.21769077 -0.48386663 -0.5165062 0.18609469 0.31534249 -0.53701621 0.35265455 0.36537492 -0.25013685
		 0.3015621 0.14261582 -0.68233234 0.62725186 0.050849993 -0.56806773 0.017593473 -0.23975831 -0.81129879
		 0.017597182 0.019535109 -0.80870742 0.63215363 -0.16777276 -0.55440503 0.3148852 -0.32237241 -0.67114133
		 0.65253639 0.30780512 0.18790174 0.80073011 0.17981395 0.38673237 0.82749736 0.13736463 -0.31149963
		 0.66387451 0.29178286 -0.14835493 0.94984603 0.0044800956 -0.1238998 0.93496466 0.028979477 0.22878379
		 0.75868338 -0.37122011 -0.11905935 0.87086862 -0.19057265 -0.29597917 0.83993709 -0.14847136 0.39674973
		 0.74224257 -0.35283893 0.21525948 0.055180568 -0.50481558 -0.24524413 0.04065451 0.41220278 -0.27336892
		 0.037994199 0.40822685 0.27385715 0.051716939 -0.50617158 0.2812039 -0.43796179 -0.3514761 -0.44809267
		 -0.40031788 0.2811594 -0.44749305 -0.26110443 -0.079931341 -0.73645598 -0.41995627 0.27391541 0.45865941
		 -0.45793697 -0.35482156 0.45957541 -0.28312209 -0.082850605 0.74360394 -0.68241006 0.19543034 0.013783148
		 -0.7316919 -0.1803212 0.012789934 0.49745864 0.25814146 0.48097277 0.53816962 -0.32912272 0.48640364
		 0.31560045 -0.062740676 0.75263095 0.55132532 -0.35330692 -0.41566566 0.50818259 0.22905955 -0.43839738
		 0.33092794 -0.089028113 -0.70798814 0.84871238 0.17121209 0.038457088 0.898817 -0.17198497 0.054271352;
	setAttr -size 270 ".edge";
	setAttr ".edge[0:165]"  1 70 1 9 68 1 0 66 1 0 64 1 10 62 1 0 60 1 7 58 1
		 6 56 1 6 54 1 9 52 1 4 50 1 1 48 1 5 46 1 4 44 1 10 42 1 3 40 1 8 38 1 2 36 1 2 34 1
		 11 32 1 5 30 1 2 28 1 8 26 1 5 24 1 7 22 1 3 20 1 11 18 1 7 16 1 8 14 1 10 12 1 12 13 1
		 13 11 1 14 15 1 15 9 1 16 17 1 17 8 1 18 19 1 19 6 1 20 21 1 21 6 1 22 23 1 23 3 1
		 24 25 1 25 11 1 26 27 1 27 4 1 28 29 1 29 4 1 30 31 1 31 2 1 32 33 1 33 3 1 34 35 1
		 35 11 1 36 37 1 37 3 1 38 39 1 39 2 1 40 41 1 41 8 1 42 43 1 43 5 1 44 45 1 45 9 1
		 46 47 1 47 4 1 48 49 1 49 5 1 50 51 1 51 1 1 52 53 1 53 7 1 54 55 1 55 10 1 56 57 1
		 57 0 1 58 59 1 59 6 1 60 61 1 61 7 1 62 63 1 63 1 1 64 65 1 65 10 1 66 67 1 67 1 1
		 68 69 1 69 0 1 70 71 1 71 9 1 52 72 1 72 17 1 52 15 1 72 15 1 72 14 1 17 14 1 53 16 1
		 53 72 1 16 72 1 18 73 1 73 55 1 18 13 1 73 13 1 73 12 1 55 12 1 19 54 1 19 73 1 54 73 1
		 42 74 1 74 25 1 42 12 1 74 12 1 74 13 1 25 13 1 43 24 1 43 74 1 24 74 1 26 75 1 75 45 1
		 26 14 1 75 14 1 75 15 1 45 15 1 27 44 1 27 75 1 44 75 1 22 76 1 76 41 1 22 16 1 76 16 1
		 76 17 1 41 17 1 23 40 1 23 76 1 40 76 1 32 77 1 77 21 1 32 18 1 77 18 1 77 19 1 21 19 1
		 33 20 1 33 77 1 20 77 1 58 78 1 78 20 1 58 22 1 78 22 1 78 23 1 20 23 1 59 21 1 59 78 1
		 21 78 1 25 79 1 79 31 1 25 35 1 79 35 1 79 34 1 31 34 1 24 30 1 24 79 1 30 79 1 38 80 1
		 80 29 1 38 26 1 80 26 1;
	setAttr ".edge[166:269]" 80 27 1 29 27 1 39 28 1 39 80 1 28 80 1 46 81 1 81 28 1
		 46 30 1 81 30 1 81 31 1 28 31 1 47 29 1 47 81 1 29 81 1 35 82 1 82 37 1 35 32 1 82 32 1
		 82 33 1 37 33 1 34 36 1 34 82 1 36 82 1 41 83 1 83 36 1 41 38 1 83 38 1 83 39 1 36 39 1
		 40 37 1 40 83 1 37 83 1 62 84 1 84 49 1 62 42 1 84 42 1 84 43 1 49 43 1 63 48 1 63 84 1
		 48 84 1 70 85 1 85 44 1 70 51 1 85 51 1 85 50 1 44 50 1 71 45 1 71 85 1 45 85 1 51 86 1
		 86 46 1 51 48 1 86 48 1 86 49 1 46 49 1 50 47 1 50 86 1 47 86 1 68 87 1 87 61 1 68 52 1
		 87 52 1 87 53 1 61 53 1 69 60 1 69 87 1 60 87 1 56 88 1 88 65 1 56 54 1 88 54 1 88 55 1
		 65 55 1 57 64 1 57 88 1 64 88 1 61 89 1 89 56 1 61 58 1 89 58 1 89 59 1 56 59 1 60 57 1
		 60 89 1 57 89 1 65 90 1 90 67 1 65 62 1 90 62 1 90 63 1 67 63 1 64 66 1 64 90 1 66 90 1
		 71 91 1 91 66 1 71 68 1 91 68 1 91 69 1 66 69 1 70 67 1 70 91 1 67 91 1;
	setAttr -size 180 ".face[0:179]" -type "polyFaces" 
		f 3 0 267 85
		mu 0 3 16 100 95
		f 3 3 258 -3
		mu 0 3 15 92 94
		f 3 5 249 75
		mu 0 3 15 88 85
		f 3 -76 240 -4
		mu 0 3 15 85 92
		f 3 -88 231 -6
		mu 0 3 15 99 88
		f 3 10 222 65
		mu 0 3 12 76 71
		f 3 -90 213 63
		mu 0 3 17 103 68
		f 3 -82 204 -12
		mu 0 3 16 91 73
		f 3 15 195 55
		mu 0 3 7 62 59
		f 3 18 186 -18
		mu 0 3 6 54 58
		f 3 -66 177 47
		mu 0 3 12 71 47
		f 3 -58 168 -22
		mu 0 3 6 61 46
		f 3 23 159 -21
		mu 0 3 5 40 48
		f 3 -78 150 39
		mu 0 3 8 87 37
		f 3 -52 141 -26
		mu 0 3 7 53 36
		f 3 -42 132 -16
		mu 0 3 7 39 62
		f 3 -46 123 -14
		mu 0 3 12 45 67
		f 3 -62 114 -24
		mu 0 3 10 65 41
		f 3 -38 105 -9
		mu 0 3 8 35 82
		f 3 -72 96 -28
		mu 0 3 14 81 30
		f 3 95 -29 -36
		mu 0 3 31 27 13
		f 3 -93 -10 -34
		mu 0 3 29 79 19
		f 3 -94 -91 92
		mu 0 3 29 104 79
		f 3 -95 93 -33
		mu 0 3 27 104 29
		f 3 -92 94 -96
		mu 0 3 31 104 27
		f 3 98 91 -35
		mu 0 3 30 104 31
		f 3 -98 -71 90
		mu 0 3 104 81 79
		f 3 -97 97 -99
		mu 0 3 30 81 104
		f 3 104 -30 -74
		mu 0 3 83 23 9
		f 3 -102 -27 -32
		mu 0 3 25 33 3
		f 3 -103 -100 101
		mu 0 3 25 105 33
		f 3 -104 102 -31
		mu 0 3 23 105 25
		f 3 -101 103 -105
		mu 0 3 83 105 23
		f 3 107 100 -73
		mu 0 3 82 105 83
		f 3 -107 -37 99
		mu 0 3 105 35 33
		f 3 -106 106 -108
		mu 0 3 82 35 105
		f 3 113 31 -44
		mu 0 3 43 24 4
		f 3 -111 -15 29
		mu 0 3 22 64 9
		f 3 -112 -109 110
		mu 0 3 22 106 64
		f 3 -113 111 30
		mu 0 3 24 106 22
		f 3 -110 112 -114
		mu 0 3 43 106 24
		f 3 116 109 -43
		mu 0 3 41 106 43
		f 3 -116 -61 108
		mu 0 3 106 65 64
		f 3 -115 115 -117
		mu 0 3 41 65 106
		f 3 122 33 -64
		mu 0 3 69 28 18
		f 3 -120 -23 28
		mu 0 3 26 44 13
		f 3 -121 -118 119
		mu 0 3 26 107 44
		f 3 -122 120 32
		mu 0 3 28 107 26
		f 3 -119 121 -123
		mu 0 3 69 107 28
		f 3 125 118 -63
		mu 0 3 67 107 69
		f 3 -125 -45 117
		mu 0 3 107 45 44
		f 3 -124 124 -126
		mu 0 3 67 45 107
		f 3 131 35 -60
		mu 0 3 63 31 13
		f 3 -129 -25 27
		mu 0 3 30 38 14
		f 3 -130 -127 128
		mu 0 3 30 108 38
		f 3 -131 129 34
		mu 0 3 31 108 30
		f 3 -128 130 -132
		mu 0 3 63 108 31
		f 3 134 127 -59
		mu 0 3 62 108 63
		f 3 -134 -41 126
		mu 0 3 108 39 38
		f 3 -133 133 -135
		mu 0 3 62 39 108
		f 3 140 37 -40
		mu 0 3 37 34 8
		f 3 -138 -20 26
		mu 0 3 32 51 2
		f 3 -139 -136 137
		mu 0 3 32 109 51
		f 3 -140 138 36
		mu 0 3 34 109 32
		f 3 -137 139 -141
		mu 0 3 37 109 34
		f 3 143 136 -39
		mu 0 3 36 109 37
		f 3 -143 -51 135
		mu 0 3 109 53 51
		f 3 -142 142 -144
		mu 0 3 36 53 109
		f 3 149 41 25
		mu 0 3 36 39 7
		f 3 -147 -7 24
		mu 0 3 38 86 14
		f 3 -148 -145 146
		mu 0 3 38 110 86
		f 3 -149 147 40
		mu 0 3 39 110 38
		f 3 -146 148 -150
		mu 0 3 36 110 39
		f 3 152 145 38
		mu 0 3 37 110 36
		f 3 -152 -77 144
		mu 0 3 110 87 86
		f 3 -151 151 -153
		mu 0 3 37 87 110
		f 3 158 -19 -50
		mu 0 3 49 55 6
		f 3 -156 43 -54
		mu 0 3 57 42 0
		f 3 -157 -154 155
		mu 0 3 57 111 42
		f 3 -158 156 -53
		mu 0 3 55 111 57
		f 3 -155 157 -159
		mu 0 3 49 111 55
		f 3 161 154 -49
		mu 0 3 48 111 49
		f 3 -161 42 153
		mu 0 3 111 40 42
		f 3 -160 160 -162
		mu 0 3 48 40 111
		f 3 167 45 -48
		mu 0 3 47 45 12
		f 3 -165 -17 22
		mu 0 3 44 60 13
		f 3 -166 -163 164
		mu 0 3 44 112 60
		f 3 -167 165 44
		mu 0 3 45 112 44
		f 3 -164 166 -168
		mu 0 3 47 112 45
		f 3 170 163 -47
		mu 0 3 46 112 47
		f 3 -170 -57 162
		mu 0 3 112 61 60
		f 3 -169 169 -171
		mu 0 3 46 61 112
		f 3 176 49 21
		mu 0 3 46 49 6
		f 3 -174 -13 20
		mu 0 3 48 70 5
		f 3 -175 -172 173
		mu 0 3 48 113 70
		f 3 -176 174 48
		mu 0 3 49 113 48
		f 3 -173 175 -177
		mu 0 3 46 113 49
		f 3 179 172 46
		mu 0 3 47 113 46
		f 3 -179 -65 171
		mu 0 3 113 71 70
		f 3 -178 178 -180
		mu 0 3 47 71 113
		f 3 185 51 -56
		mu 0 3 59 52 7
		f 3 -183 53 19
		mu 0 3 50 56 1
		f 3 -184 -181 182
		mu 0 3 50 114 56
		f 3 -185 183 50
		mu 0 3 52 114 50
		f 3 -182 184 -186
		mu 0 3 59 114 52
		f 3 188 181 -55
		mu 0 3 58 114 59
		f 3 -188 52 180
		mu 0 3 114 54 56
		f 3 -187 187 -189
		mu 0 3 58 54 114
		f 3 194 57 17
		mu 0 3 58 61 6
		f 3 -192 59 16
		mu 0 3 60 63 13
		f 3 -193 -190 191
		mu 0 3 60 115 63
		f 3 -194 192 56
		mu 0 3 61 115 60
		f 3 -191 193 -195
		mu 0 3 58 115 61
		f 3 197 190 54
		mu 0 3 59 115 58
		f 3 -197 58 189
		mu 0 3 115 62 63
		f 3 -196 196 -198
		mu 0 3 59 62 115
		f 3 203 61 -68
		mu 0 3 75 65 10
		f 3 -201 -5 14
		mu 0 3 64 90 9
		f 3 -202 -199 200
		mu 0 3 64 116 90
		f 3 -203 201 60
		mu 0 3 65 116 64
		f 3 -200 202 -204
		mu 0 3 75 116 65
		f 3 206 199 -67
		mu 0 3 73 116 75
		f 3 -206 -81 198
		mu 0 3 116 91 90
		f 3 -205 205 -207
		mu 0 3 73 91 116
		f 3 212 -11 13
		mu 0 3 66 76 12
		f 3 -210 -1 -70
		mu 0 3 77 101 11
		f 3 -211 -208 209
		mu 0 3 77 117 101
		f 3 -212 210 -69
		mu 0 3 76 117 77
		f 3 -209 211 -213
		mu 0 3 66 117 76
		f 3 215 208 62
		mu 0 3 68 117 66
		f 3 -215 -89 207
		mu 0 3 117 103 101
		f 3 -214 214 -216
		mu 0 3 68 103 117
		f 3 221 67 12
		mu 0 3 70 74 5
		f 3 -219 69 11
		mu 0 3 72 77 11
		f 3 -220 -217 218
		mu 0 3 72 118 77
		f 3 -221 219 66
		mu 0 3 74 118 72
		f 3 -218 220 -222
		mu 0 3 70 118 74
		f 3 224 217 64
		mu 0 3 71 118 70
		f 3 -224 68 216
		mu 0 3 118 76 77
		f 3 -223 223 -225
		mu 0 3 71 76 118
		f 3 230 71 -80
		mu 0 3 89 80 14
		f 3 -228 -2 9
		mu 0 3 78 97 20
		f 3 -229 -226 227
		mu 0 3 78 119 97
		f 3 -230 228 70
		mu 0 3 80 119 78
		f 3 -227 229 -231
		mu 0 3 89 119 80
		f 3 233 226 -79
		mu 0 3 88 119 89
		f 3 -233 -87 225
		mu 0 3 119 99 97
		f 3 -232 232 -234
		mu 0 3 88 99 119
		f 3 239 73 -84
		mu 0 3 93 83 9
		f 3 -237 -8 8
		mu 0 3 82 84 8
		f 3 -238 -235 236
		mu 0 3 82 120 84
		f 3 -239 237 72
		mu 0 3 83 120 82
		f 3 -236 238 -240
		mu 0 3 93 120 83
		f 3 242 235 -83
		mu 0 3 92 120 93
		f 3 -242 -75 234
		mu 0 3 120 85 84
		f 3 -241 241 -243
		mu 0 3 92 85 120
		f 3 248 77 7
		mu 0 3 84 87 8
		f 3 -246 79 6
		mu 0 3 86 89 14
		f 3 -247 -244 245
		mu 0 3 86 121 89
		f 3 -248 246 76
		mu 0 3 87 121 86
		f 3 -245 247 -249
		mu 0 3 84 121 87
		f 3 251 244 74
		mu 0 3 85 121 84
		f 3 -251 78 243
		mu 0 3 121 88 89
		f 3 -250 250 -252
		mu 0 3 85 88 121
		f 3 257 81 -86
		mu 0 3 95 91 16
		f 3 -255 83 4
		mu 0 3 90 93 9
		f 3 -256 -253 254
		mu 0 3 90 122 93
		f 3 -257 255 80
		mu 0 3 91 122 90
		f 3 -254 256 -258
		mu 0 3 95 122 91
		f 3 260 253 -85
		mu 0 3 94 122 95
		f 3 -260 82 252
		mu 0 3 122 92 93
		f 3 -259 259 -261
		mu 0 3 94 92 122
		f 3 266 87 2
		mu 0 3 94 98 15
		f 3 -264 89 1
		mu 0 3 96 102 21
		f 3 -265 -262 263
		mu 0 3 96 123 102
		f 3 -266 264 86
		mu 0 3 98 123 96
		f 3 -263 265 -267
		mu 0 3 94 123 98
		f 3 269 262 84
		mu 0 3 95 123 94
		f 3 -269 88 261
		mu 0 3 123 100 102
		f 3 -268 268 -270
		mu 0 3 95 100 123;
	setAttr ".creaseData" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".creaseVertexData" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".holeFaceData" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -name "pSolid5";
	setAttr ".translate" -type "double3" -1.8603729342825344 -4.0808461872873467 -3.8938213014577969 ;
	setAttr ".rotate" -type "double3" 0 104.05496459054207 0 ;
	setAttr ".scale" -type "double3" 1.1313186721656523 1.8442045288300353 1.1313186721656523 ;
createNode transform -name "transform2" -parent "pSolid5";
	setAttr ".visibility" no;
createNode mesh -name "pSolidShape5" -parent "transform2";
	setAttr -keyable off ".visibility";
	setAttr ".intermediateObject" yes;
	setAttr ".instObjGroups[0].objectGroups[0].objectGrpCompList" -type "componentList" 
		1 "f[0:179]";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr -size 124 ".uvSet[0].uvSetPoints[0:123]" -type "float2" 0.18181819
		 0.25 0.36363637 0.25 0.54545456 0.25 0.72727275 0.25 0.90909094 0.25 0.090909094
		 0.41666669 0.27272728 0.41666669 0.45454547 0.41666669 0.63636363 0.41666669 0.81818181
		 0.41666669 1 0.41666669 0 0.58333337 0.18181819 0.58333337 0.36363637 0.58333337
		 0.54545456 0.58333337 0.72727275 0.58333337 0.90909094 0.58333337 0.090909094 0.75
		 0.27272728 0.75 0.45454547 0.75 0.63636363 0.75 0.81818181 0.75 0.84848481 0.3611111
		 0.78787875 0.3611111 0.87878788 0.30555555 0.75757575 0.30555555 0.33333331 0.6388889
		 0.39393938 0.6388889 0.30303031 0.69444442 0.42424244 0.69444442 0.48484847 0.58333337
		 0.42424244 0.58333337 0.57575756 0.30555555 0.69696969 0.30555555 0.60606062 0.3611111
		 0.66666669 0.3611111 0.5151515 0.41666666 0.57575756 0.41666669 0.5151515 0.52777779
		 0.4848485 0.47222224 0.12121212 0.3611111 0.96969694 0.3611111 0.15151516 0.30555555
		 0.93939394 0.30555555 0.30303031 0.58333337 0.24242425 0.58333337 0.24242423 0.47222221
		 0.21212122 0.52777779 0.15151516 0.41666666 0.21212122 0.41666669 0.39393938 0.30555555
		 0.5151515 0.30555555 0.42424244 0.3611111 0.4848485 0.3611111 0.30303031 0.3611111
		 0.24242423 0.3611111 0.33333334 0.30555555 0.21212122 0.30555555 0.33333331 0.41666666
		 0.39393941 0.41666669 0.33333331 0.52777779 0.30303031 0.47222224 0.42424241 0.47222221
		 0.39393938 0.52777779 0.87878788 0.41666666 0.93939394 0.41666669 0.15151516 0.6388889
		 0.21212122 0.6388889 0.12121212 0.69444442 0.24242425 0.69444442 0.12121212 0.47222221
		 0.15151516 0.52777779 0.030303031 0.52777779 0.93939388 0.52777779 0.060606062 0.47222224
		 0.969697 0.47222224 0.12121212 0.58333337 0.060606059 0.58333337 0.60606056 0.69444442
		 0.48484847 0.69444442 0.57575756 0.6388889 0.5151515 0.6388889 0.69696963 0.41666666
		 0.75757575 0.41666669 0.66666663 0.47222221 0.69696969 0.52777779 0.57575756 0.52777779
		 0.60606062 0.47222224 0.66666663 0.58333337 0.60606062 0.58333337 0.84848481 0.47222221
		 0.87878788 0.52777779 0.75757575 0.52777779 0.78787881 0.47222224 0.78787875 0.58333337
		 0.84848487 0.58333337 0.78787875 0.69444442 0.66666663 0.69444442 0.75757575 0.6388889
		 0.69696969 0.6388889 0.87878788 0.6388889 0.030303031 0.6388889 0.84848487 0.69444442
		 0.060606062 0.69444442 0.45454544 0.6388889 0.72727275 0.3611111 0.90909088 0.3611111
		 0.27272728 0.6388889 0.45454544 0.52777779 0.5454545 0.3611111 0.5454545 0.47222221
		 0.18181819 0.3611111 0.27272725 0.52777779 0.18181819 0.47222221 0.36363637 0.3611111
		 0.36363634 0.47222221 0.90909088 0.47222221 0.090909094 0.6388889 0.090909094 0.52777779
		 0.63636363 0.6388889 0.72727275 0.47222221 0.63636363 0.52777779 0.81818187 0.52777779
		 0.81818181 0.6388889;
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr -size 8 ".pnts";
	setAttr ".pnts[1]" -type "float3" -0.025908969 8.8817842e-015 0.0057913405 ;
	setAttr ".pnts[19]" -type "float3" -0.015814891 0.043166719 -0.01875679 ;
	setAttr ".pnts[28]" -type "float3" 0.016903164 1.7763568e-015 -0.025249645 ;
	setAttr ".pnts[30]" -type "float3" 0.056879707 -0.022470323 -0.031308424 ;
	setAttr ".pnts[33]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[35]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[62]" -type "float3" -0.026634788 -0.022129519 0.030549075 ;
	setAttr ".pnts[91]" -type "float3" -0.035124771 0.020415056 0.058315698 ;
	setAttr -size 92 ".vrts[0:91]"  0.90142953 -0.02253205 -0.42723766 0.86279839 0.041527987 0.5271647
		 -0.75498474 -0.0082708634 0.4725455 -0.69922256 0.0021455344 -0.43880621 0.01012369 -0.45521826 0.76631624
		 0.0084654447 0.23842825 0.76457042 0.013062222 0.23581591 -0.758636 0.014720455 -0.45783061 -0.75689018
		 -0.46225139 -0.49883354 0.003321924 0.61035442 -0.50782865 0.043731689 0.48543727 0.39996892 0.0043583494
		 -0.37470222 0.49594653 0.0033545829 0.20146541 0.4423452 0.0010297331 -0.10936457 0.48451048 0.00035382912
		 -0.10908622 -0.49600813 0.013096313 0.23507354 -0.5114041 0.025274994 -0.145511 -0.49326798 -0.54117459
		 -0.31614 -0.50040531 -0.25620905 -0.26336446 0.43401659 -0.25712079 -0.12475464 0.34308293 -0.53869444
		 -0.50198561 0.082347535 -0.58647907 -0.23912993 0.1688672 -0.70678151 -0.24651626 -0.32608059 -0.69915622
		 -0.50447899 -0.15410741 -0.57745731 -0.1309783 0.33976367 0.54037851 -0.26828372 0.4302803 0.26150605
		 -0.31927964 -0.49947301 0.26582137 -0.15092295 -0.49149916 0.54940236 -0.54400551 -0.16233967 0.59738642
		 -0.26463693 -0.32686532 0.70474386 -0.25758249 0.16323021 0.71248913 -0.54196316 0.07320191 0.60705847
		 -0.51674235 0.36058858 -0.15168031 -0.63923788 0.18025385 -0.31535363 -0.67420024 0.17350301 0.3425054
		 -0.52755922 0.35542795 0.16773893 -0.78457367 0.0086128302 0.18515497 -0.75988376 0.012191981 -0.15050197
		 -0.60526276 -0.36453271 0.16902554 -0.71827912 -0.1831643 0.34549695 -0.68071109 -0.17624255 -0.31988633
		 -0.59154236 -0.36207366 -0.1550774 0.34512445 0.36754245 0.25875443 0.18017395 0.31995046 0.54064745
		 0.21407214 -0.48196855 0.55855244 0.42885369 -0.49523523 0.29273719 0.0077788136 0.025507206 0.81658834
		 0.0078540081 -0.23273827 0.82078195 0.61010683 0.10135313 0.6429556 0.29201278 0.17067315 0.72535408
		 0.30047348 -0.29953384 0.70965618 0.60724771 -0.12358893 0.62699735 0.42508 -0.49352708 -0.22378445
		 0.21769077 -0.48386663 -0.5165062 0.18609469 0.31534249 -0.53701621 0.35265455 0.36537492 -0.25013685
		 0.3015621 0.14261582 -0.68233234 0.62725186 0.050849993 -0.56806773 0.017593473 -0.23975831 -0.81129879
		 0.017597182 0.019535109 -0.80870742 0.63215363 -0.16777276 -0.55440503 0.3148852 -0.32237241 -0.67114133
		 0.65253639 0.30780512 0.18790174 0.80073011 0.17981395 0.38673237 0.82749736 0.13736463 -0.31149963
		 0.66387451 0.29178286 -0.14835493 0.94984603 0.0044800956 -0.1238998 0.93496466 0.028979477 0.22878379
		 0.75868338 -0.37122011 -0.11905935 0.87086862 -0.19057265 -0.29597917 0.83993709 -0.14847136 0.39674973
		 0.74224257 -0.35283893 0.21525948 0.055180568 -0.50481558 -0.24524413 0.04065451 0.41220278 -0.27336892
		 0.037994199 0.40822685 0.27385715 0.051716939 -0.50617158 0.2812039 -0.43796179 -0.3514761 -0.44809267
		 -0.40031788 0.2811594 -0.44749305 -0.26110443 -0.079931341 -0.73645598 -0.41995627 0.27391541 0.45865941
		 -0.45793697 -0.35482156 0.45957541 -0.28312209 -0.082850605 0.74360394 -0.68241006 0.19543034 0.013783148
		 -0.7316919 -0.1803212 0.012789934 0.49745864 0.25814146 0.48097277 0.53816962 -0.32912272 0.48640364
		 0.31560045 -0.062740676 0.75263095 0.55132532 -0.35330692 -0.41566566 0.50818259 0.22905955 -0.43839738
		 0.33092794 -0.089028113 -0.70798814 0.84871238 0.17121209 0.038457088 0.898817 -0.17198497 0.054271352;
	setAttr -size 270 ".edge";
	setAttr ".edge[0:165]"  1 70 1 9 68 1 0 66 1 0 64 1 10 62 1 0 60 1 7 58 1
		 6 56 1 6 54 1 9 52 1 4 50 1 1 48 1 5 46 1 4 44 1 10 42 1 3 40 1 8 38 1 2 36 1 2 34 1
		 11 32 1 5 30 1 2 28 1 8 26 1 5 24 1 7 22 1 3 20 1 11 18 1 7 16 1 8 14 1 10 12 1 12 13 1
		 13 11 1 14 15 1 15 9 1 16 17 1 17 8 1 18 19 1 19 6 1 20 21 1 21 6 1 22 23 1 23 3 1
		 24 25 1 25 11 1 26 27 1 27 4 1 28 29 1 29 4 1 30 31 1 31 2 1 32 33 1 33 3 1 34 35 1
		 35 11 1 36 37 1 37 3 1 38 39 1 39 2 1 40 41 1 41 8 1 42 43 1 43 5 1 44 45 1 45 9 1
		 46 47 1 47 4 1 48 49 1 49 5 1 50 51 1 51 1 1 52 53 1 53 7 1 54 55 1 55 10 1 56 57 1
		 57 0 1 58 59 1 59 6 1 60 61 1 61 7 1 62 63 1 63 1 1 64 65 1 65 10 1 66 67 1 67 1 1
		 68 69 1 69 0 1 70 71 1 71 9 1 52 72 1 72 17 1 52 15 1 72 15 1 72 14 1 17 14 1 53 16 1
		 53 72 1 16 72 1 18 73 1 73 55 1 18 13 1 73 13 1 73 12 1 55 12 1 19 54 1 19 73 1 54 73 1
		 42 74 1 74 25 1 42 12 1 74 12 1 74 13 1 25 13 1 43 24 1 43 74 1 24 74 1 26 75 1 75 45 1
		 26 14 1 75 14 1 75 15 1 45 15 1 27 44 1 27 75 1 44 75 1 22 76 1 76 41 1 22 16 1 76 16 1
		 76 17 1 41 17 1 23 40 1 23 76 1 40 76 1 32 77 1 77 21 1 32 18 1 77 18 1 77 19 1 21 19 1
		 33 20 1 33 77 1 20 77 1 58 78 1 78 20 1 58 22 1 78 22 1 78 23 1 20 23 1 59 21 1 59 78 1
		 21 78 1 25 79 1 79 31 1 25 35 1 79 35 1 79 34 1 31 34 1 24 30 1 24 79 1 30 79 1 38 80 1
		 80 29 1 38 26 1 80 26 1;
	setAttr ".edge[166:269]" 80 27 1 29 27 1 39 28 1 39 80 1 28 80 1 46 81 1 81 28 1
		 46 30 1 81 30 1 81 31 1 28 31 1 47 29 1 47 81 1 29 81 1 35 82 1 82 37 1 35 32 1 82 32 1
		 82 33 1 37 33 1 34 36 1 34 82 1 36 82 1 41 83 1 83 36 1 41 38 1 83 38 1 83 39 1 36 39 1
		 40 37 1 40 83 1 37 83 1 62 84 1 84 49 1 62 42 1 84 42 1 84 43 1 49 43 1 63 48 1 63 84 1
		 48 84 1 70 85 1 85 44 1 70 51 1 85 51 1 85 50 1 44 50 1 71 45 1 71 85 1 45 85 1 51 86 1
		 86 46 1 51 48 1 86 48 1 86 49 1 46 49 1 50 47 1 50 86 1 47 86 1 68 87 1 87 61 1 68 52 1
		 87 52 1 87 53 1 61 53 1 69 60 1 69 87 1 60 87 1 56 88 1 88 65 1 56 54 1 88 54 1 88 55 1
		 65 55 1 57 64 1 57 88 1 64 88 1 61 89 1 89 56 1 61 58 1 89 58 1 89 59 1 56 59 1 60 57 1
		 60 89 1 57 89 1 65 90 1 90 67 1 65 62 1 90 62 1 90 63 1 67 63 1 64 66 1 64 90 1 66 90 1
		 71 91 1 91 66 1 71 68 1 91 68 1 91 69 1 66 69 1 70 67 1 70 91 1 67 91 1;
	setAttr -size 180 ".face[0:179]" -type "polyFaces" 
		f 3 0 267 85
		mu 0 3 16 100 95
		f 3 3 258 -3
		mu 0 3 15 92 94
		f 3 5 249 75
		mu 0 3 15 88 85
		f 3 -76 240 -4
		mu 0 3 15 85 92
		f 3 -88 231 -6
		mu 0 3 15 99 88
		f 3 10 222 65
		mu 0 3 12 76 71
		f 3 -90 213 63
		mu 0 3 17 103 68
		f 3 -82 204 -12
		mu 0 3 16 91 73
		f 3 15 195 55
		mu 0 3 7 62 59
		f 3 18 186 -18
		mu 0 3 6 54 58
		f 3 -66 177 47
		mu 0 3 12 71 47
		f 3 -58 168 -22
		mu 0 3 6 61 46
		f 3 23 159 -21
		mu 0 3 5 40 48
		f 3 -78 150 39
		mu 0 3 8 87 37
		f 3 -52 141 -26
		mu 0 3 7 53 36
		f 3 -42 132 -16
		mu 0 3 7 39 62
		f 3 -46 123 -14
		mu 0 3 12 45 67
		f 3 -62 114 -24
		mu 0 3 10 65 41
		f 3 -38 105 -9
		mu 0 3 8 35 82
		f 3 -72 96 -28
		mu 0 3 14 81 30
		f 3 95 -29 -36
		mu 0 3 31 27 13
		f 3 -93 -10 -34
		mu 0 3 29 79 19
		f 3 -94 -91 92
		mu 0 3 29 104 79
		f 3 -95 93 -33
		mu 0 3 27 104 29
		f 3 -92 94 -96
		mu 0 3 31 104 27
		f 3 98 91 -35
		mu 0 3 30 104 31
		f 3 -98 -71 90
		mu 0 3 104 81 79
		f 3 -97 97 -99
		mu 0 3 30 81 104
		f 3 104 -30 -74
		mu 0 3 83 23 9
		f 3 -102 -27 -32
		mu 0 3 25 33 3
		f 3 -103 -100 101
		mu 0 3 25 105 33
		f 3 -104 102 -31
		mu 0 3 23 105 25
		f 3 -101 103 -105
		mu 0 3 83 105 23
		f 3 107 100 -73
		mu 0 3 82 105 83
		f 3 -107 -37 99
		mu 0 3 105 35 33
		f 3 -106 106 -108
		mu 0 3 82 35 105
		f 3 113 31 -44
		mu 0 3 43 24 4
		f 3 -111 -15 29
		mu 0 3 22 64 9
		f 3 -112 -109 110
		mu 0 3 22 106 64
		f 3 -113 111 30
		mu 0 3 24 106 22
		f 3 -110 112 -114
		mu 0 3 43 106 24
		f 3 116 109 -43
		mu 0 3 41 106 43
		f 3 -116 -61 108
		mu 0 3 106 65 64
		f 3 -115 115 -117
		mu 0 3 41 65 106
		f 3 122 33 -64
		mu 0 3 69 28 18
		f 3 -120 -23 28
		mu 0 3 26 44 13
		f 3 -121 -118 119
		mu 0 3 26 107 44
		f 3 -122 120 32
		mu 0 3 28 107 26
		f 3 -119 121 -123
		mu 0 3 69 107 28
		f 3 125 118 -63
		mu 0 3 67 107 69
		f 3 -125 -45 117
		mu 0 3 107 45 44
		f 3 -124 124 -126
		mu 0 3 67 45 107
		f 3 131 35 -60
		mu 0 3 63 31 13
		f 3 -129 -25 27
		mu 0 3 30 38 14
		f 3 -130 -127 128
		mu 0 3 30 108 38
		f 3 -131 129 34
		mu 0 3 31 108 30
		f 3 -128 130 -132
		mu 0 3 63 108 31
		f 3 134 127 -59
		mu 0 3 62 108 63
		f 3 -134 -41 126
		mu 0 3 108 39 38
		f 3 -133 133 -135
		mu 0 3 62 39 108
		f 3 140 37 -40
		mu 0 3 37 34 8
		f 3 -138 -20 26
		mu 0 3 32 51 2
		f 3 -139 -136 137
		mu 0 3 32 109 51
		f 3 -140 138 36
		mu 0 3 34 109 32
		f 3 -137 139 -141
		mu 0 3 37 109 34
		f 3 143 136 -39
		mu 0 3 36 109 37
		f 3 -143 -51 135
		mu 0 3 109 53 51
		f 3 -142 142 -144
		mu 0 3 36 53 109
		f 3 149 41 25
		mu 0 3 36 39 7
		f 3 -147 -7 24
		mu 0 3 38 86 14
		f 3 -148 -145 146
		mu 0 3 38 110 86
		f 3 -149 147 40
		mu 0 3 39 110 38
		f 3 -146 148 -150
		mu 0 3 36 110 39
		f 3 152 145 38
		mu 0 3 37 110 36
		f 3 -152 -77 144
		mu 0 3 110 87 86
		f 3 -151 151 -153
		mu 0 3 37 87 110
		f 3 158 -19 -50
		mu 0 3 49 55 6
		f 3 -156 43 -54
		mu 0 3 57 42 0
		f 3 -157 -154 155
		mu 0 3 57 111 42
		f 3 -158 156 -53
		mu 0 3 55 111 57
		f 3 -155 157 -159
		mu 0 3 49 111 55
		f 3 161 154 -49
		mu 0 3 48 111 49
		f 3 -161 42 153
		mu 0 3 111 40 42
		f 3 -160 160 -162
		mu 0 3 48 40 111
		f 3 167 45 -48
		mu 0 3 47 45 12
		f 3 -165 -17 22
		mu 0 3 44 60 13
		f 3 -166 -163 164
		mu 0 3 44 112 60
		f 3 -167 165 44
		mu 0 3 45 112 44
		f 3 -164 166 -168
		mu 0 3 47 112 45
		f 3 170 163 -47
		mu 0 3 46 112 47
		f 3 -170 -57 162
		mu 0 3 112 61 60
		f 3 -169 169 -171
		mu 0 3 46 61 112
		f 3 176 49 21
		mu 0 3 46 49 6
		f 3 -174 -13 20
		mu 0 3 48 70 5
		f 3 -175 -172 173
		mu 0 3 48 113 70
		f 3 -176 174 48
		mu 0 3 49 113 48
		f 3 -173 175 -177
		mu 0 3 46 113 49
		f 3 179 172 46
		mu 0 3 47 113 46
		f 3 -179 -65 171
		mu 0 3 113 71 70
		f 3 -178 178 -180
		mu 0 3 47 71 113
		f 3 185 51 -56
		mu 0 3 59 52 7
		f 3 -183 53 19
		mu 0 3 50 56 1
		f 3 -184 -181 182
		mu 0 3 50 114 56
		f 3 -185 183 50
		mu 0 3 52 114 50
		f 3 -182 184 -186
		mu 0 3 59 114 52
		f 3 188 181 -55
		mu 0 3 58 114 59
		f 3 -188 52 180
		mu 0 3 114 54 56
		f 3 -187 187 -189
		mu 0 3 58 54 114
		f 3 194 57 17
		mu 0 3 58 61 6
		f 3 -192 59 16
		mu 0 3 60 63 13
		f 3 -193 -190 191
		mu 0 3 60 115 63
		f 3 -194 192 56
		mu 0 3 61 115 60
		f 3 -191 193 -195
		mu 0 3 58 115 61
		f 3 197 190 54
		mu 0 3 59 115 58
		f 3 -197 58 189
		mu 0 3 115 62 63
		f 3 -196 196 -198
		mu 0 3 59 62 115
		f 3 203 61 -68
		mu 0 3 75 65 10
		f 3 -201 -5 14
		mu 0 3 64 90 9
		f 3 -202 -199 200
		mu 0 3 64 116 90
		f 3 -203 201 60
		mu 0 3 65 116 64
		f 3 -200 202 -204
		mu 0 3 75 116 65
		f 3 206 199 -67
		mu 0 3 73 116 75
		f 3 -206 -81 198
		mu 0 3 116 91 90
		f 3 -205 205 -207
		mu 0 3 73 91 116
		f 3 212 -11 13
		mu 0 3 66 76 12
		f 3 -210 -1 -70
		mu 0 3 77 101 11
		f 3 -211 -208 209
		mu 0 3 77 117 101
		f 3 -212 210 -69
		mu 0 3 76 117 77
		f 3 -209 211 -213
		mu 0 3 66 117 76
		f 3 215 208 62
		mu 0 3 68 117 66
		f 3 -215 -89 207
		mu 0 3 117 103 101
		f 3 -214 214 -216
		mu 0 3 68 103 117
		f 3 221 67 12
		mu 0 3 70 74 5
		f 3 -219 69 11
		mu 0 3 72 77 11
		f 3 -220 -217 218
		mu 0 3 72 118 77
		f 3 -221 219 66
		mu 0 3 74 118 72
		f 3 -218 220 -222
		mu 0 3 70 118 74
		f 3 224 217 64
		mu 0 3 71 118 70
		f 3 -224 68 216
		mu 0 3 118 76 77
		f 3 -223 223 -225
		mu 0 3 71 76 118
		f 3 230 71 -80
		mu 0 3 89 80 14
		f 3 -228 -2 9
		mu 0 3 78 97 20
		f 3 -229 -226 227
		mu 0 3 78 119 97
		f 3 -230 228 70
		mu 0 3 80 119 78
		f 3 -227 229 -231
		mu 0 3 89 119 80
		f 3 233 226 -79
		mu 0 3 88 119 89
		f 3 -233 -87 225
		mu 0 3 119 99 97
		f 3 -232 232 -234
		mu 0 3 88 99 119
		f 3 239 73 -84
		mu 0 3 93 83 9
		f 3 -237 -8 8
		mu 0 3 82 84 8
		f 3 -238 -235 236
		mu 0 3 82 120 84
		f 3 -239 237 72
		mu 0 3 83 120 82
		f 3 -236 238 -240
		mu 0 3 93 120 83
		f 3 242 235 -83
		mu 0 3 92 120 93
		f 3 -242 -75 234
		mu 0 3 120 85 84
		f 3 -241 241 -243
		mu 0 3 92 85 120
		f 3 248 77 7
		mu 0 3 84 87 8
		f 3 -246 79 6
		mu 0 3 86 89 14
		f 3 -247 -244 245
		mu 0 3 86 121 89
		f 3 -248 246 76
		mu 0 3 87 121 86
		f 3 -245 247 -249
		mu 0 3 84 121 87
		f 3 251 244 74
		mu 0 3 85 121 84
		f 3 -251 78 243
		mu 0 3 121 88 89
		f 3 -250 250 -252
		mu 0 3 85 88 121
		f 3 257 81 -86
		mu 0 3 95 91 16
		f 3 -255 83 4
		mu 0 3 90 93 9
		f 3 -256 -253 254
		mu 0 3 90 122 93
		f 3 -257 255 80
		mu 0 3 91 122 90
		f 3 -254 256 -258
		mu 0 3 95 122 91
		f 3 260 253 -85
		mu 0 3 94 122 95
		f 3 -260 82 252
		mu 0 3 122 92 93
		f 3 -259 259 -261
		mu 0 3 94 92 122
		f 3 266 87 2
		mu 0 3 94 98 15
		f 3 -264 89 1
		mu 0 3 96 102 21
		f 3 -265 -262 263
		mu 0 3 96 123 102
		f 3 -266 264 86
		mu 0 3 98 123 96
		f 3 -263 265 -267
		mu 0 3 94 123 98
		f 3 269 262 84
		mu 0 3 95 123 94
		f 3 -269 88 261
		mu 0 3 123 100 102
		f 3 -268 268 -270
		mu 0 3 95 100 123;
	setAttr ".creaseData" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".creaseVertexData" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".holeFaceData" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -name "pSolid6";
	setAttr ".translate" -type "double3" -1.0081683913822037 -4.7831070576748891 -3.0123516819468379 ;
	setAttr ".rotate" -type "double3" 0 31.906525244719116 0 ;
	setAttr ".scale" -type "double3" 0.30595864814105495 0.47030333100089705 0.49802077261988903 ;
createNode transform -name "transform1" -parent "pSolid6";
	setAttr ".visibility" no;
createNode mesh -name "pSolidShape6" -parent "transform1";
	setAttr -keyable off ".visibility";
	setAttr ".intermediateObject" yes;
	setAttr ".instObjGroups[0].objectGroups[0].objectGrpCompList" -type "componentList" 
		1 "f[0:179]";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr -size 124 ".uvSet[0].uvSetPoints[0:123]" -type "float2" 0.18181819
		 0.25 0.36363637 0.25 0.54545456 0.25 0.72727275 0.25 0.90909094 0.25 0.090909094
		 0.41666669 0.27272728 0.41666669 0.45454547 0.41666669 0.63636363 0.41666669 0.81818181
		 0.41666669 1 0.41666669 0 0.58333337 0.18181819 0.58333337 0.36363637 0.58333337
		 0.54545456 0.58333337 0.72727275 0.58333337 0.90909094 0.58333337 0.090909094 0.75
		 0.27272728 0.75 0.45454547 0.75 0.63636363 0.75 0.81818181 0.75 0.84848481 0.3611111
		 0.78787875 0.3611111 0.87878788 0.30555555 0.75757575 0.30555555 0.33333331 0.6388889
		 0.39393938 0.6388889 0.30303031 0.69444442 0.42424244 0.69444442 0.48484847 0.58333337
		 0.42424244 0.58333337 0.57575756 0.30555555 0.69696969 0.30555555 0.60606062 0.3611111
		 0.66666669 0.3611111 0.5151515 0.41666666 0.57575756 0.41666669 0.5151515 0.52777779
		 0.4848485 0.47222224 0.12121212 0.3611111 0.96969694 0.3611111 0.15151516 0.30555555
		 0.93939394 0.30555555 0.30303031 0.58333337 0.24242425 0.58333337 0.24242423 0.47222221
		 0.21212122 0.52777779 0.15151516 0.41666666 0.21212122 0.41666669 0.39393938 0.30555555
		 0.5151515 0.30555555 0.42424244 0.3611111 0.4848485 0.3611111 0.30303031 0.3611111
		 0.24242423 0.3611111 0.33333334 0.30555555 0.21212122 0.30555555 0.33333331 0.41666666
		 0.39393941 0.41666669 0.33333331 0.52777779 0.30303031 0.47222224 0.42424241 0.47222221
		 0.39393938 0.52777779 0.87878788 0.41666666 0.93939394 0.41666669 0.15151516 0.6388889
		 0.21212122 0.6388889 0.12121212 0.69444442 0.24242425 0.69444442 0.12121212 0.47222221
		 0.15151516 0.52777779 0.030303031 0.52777779 0.93939388 0.52777779 0.060606062 0.47222224
		 0.969697 0.47222224 0.12121212 0.58333337 0.060606059 0.58333337 0.60606056 0.69444442
		 0.48484847 0.69444442 0.57575756 0.6388889 0.5151515 0.6388889 0.69696963 0.41666666
		 0.75757575 0.41666669 0.66666663 0.47222221 0.69696969 0.52777779 0.57575756 0.52777779
		 0.60606062 0.47222224 0.66666663 0.58333337 0.60606062 0.58333337 0.84848481 0.47222221
		 0.87878788 0.52777779 0.75757575 0.52777779 0.78787881 0.47222224 0.78787875 0.58333337
		 0.84848487 0.58333337 0.78787875 0.69444442 0.66666663 0.69444442 0.75757575 0.6388889
		 0.69696969 0.6388889 0.87878788 0.6388889 0.030303031 0.6388889 0.84848487 0.69444442
		 0.060606062 0.69444442 0.45454544 0.6388889 0.72727275 0.3611111 0.90909088 0.3611111
		 0.27272728 0.6388889 0.45454544 0.52777779 0.5454545 0.3611111 0.5454545 0.47222221
		 0.18181819 0.3611111 0.27272725 0.52777779 0.18181819 0.47222221 0.36363637 0.3611111
		 0.36363634 0.47222221 0.90909088 0.47222221 0.090909094 0.6388889 0.090909094 0.52777779
		 0.63636363 0.6388889 0.72727275 0.47222221 0.63636363 0.52777779 0.81818187 0.52777779
		 0.81818181 0.6388889;
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr -size 8 ".pnts";
	setAttr ".pnts[1]" -type "float3" -0.025908969 8.8817842e-015 0.0057913405 ;
	setAttr ".pnts[19]" -type "float3" -0.015814891 0.043166719 -0.01875679 ;
	setAttr ".pnts[28]" -type "float3" 0.016903164 1.7763568e-015 -0.025249645 ;
	setAttr ".pnts[30]" -type "float3" 0.056879707 -0.022470323 -0.031308424 ;
	setAttr ".pnts[33]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[35]" -type "float3" -0.045047119 0.015981939 0.02567805 ;
	setAttr ".pnts[62]" -type "float3" -0.026634788 -0.022129519 0.030549075 ;
	setAttr ".pnts[91]" -type "float3" -0.035124771 0.020415056 0.058315698 ;
	setAttr -size 92 ".vrts[0:91]"  0.90142953 -0.02253205 -0.42723766 0.86279839 0.041527987 0.5271647
		 -0.75498474 -0.0082708634 0.4725455 -0.69922256 0.0021455344 -0.43880621 0.01012369 -0.45521826 0.76631624
		 0.0084654447 0.23842825 0.76457042 0.013062222 0.23581591 -0.758636 0.014720455 -0.45783061 -0.75689018
		 -0.46225139 -0.49883354 0.003321924 0.61035442 -0.50782865 0.043731689 0.48543727 0.39996892 0.0043583494
		 -0.37470222 0.49594653 0.0033545829 0.20146541 0.4423452 0.0010297331 -0.10936457 0.48451048 0.00035382912
		 -0.10908622 -0.49600813 0.013096313 0.23507354 -0.5114041 0.025274994 -0.145511 -0.49326798 -0.54117459
		 -0.31614 -0.50040531 -0.25620905 -0.26336446 0.43401659 -0.25712079 -0.12475464 0.34308293 -0.53869444
		 -0.50198561 0.082347535 -0.58647907 -0.23912993 0.1688672 -0.70678151 -0.24651626 -0.32608059 -0.69915622
		 -0.50447899 -0.15410741 -0.57745731 -0.1309783 0.33976367 0.54037851 -0.26828372 0.4302803 0.26150605
		 -0.31927964 -0.49947301 0.26582137 -0.15092295 -0.49149916 0.54940236 -0.54400551 -0.16233967 0.59738642
		 -0.26463693 -0.32686532 0.70474386 -0.25758249 0.16323021 0.71248913 -0.54196316 0.07320191 0.60705847
		 -0.51674235 0.36058858 -0.15168031 -0.63923788 0.18025385 -0.31535363 -0.67420024 0.17350301 0.3425054
		 -0.52755922 0.35542795 0.16773893 -0.78457367 0.0086128302 0.18515497 -0.75988376 0.012191981 -0.15050197
		 -0.60526276 -0.36453271 0.16902554 -0.71827912 -0.1831643 0.34549695 -0.68071109 -0.17624255 -0.31988633
		 -0.59154236 -0.36207366 -0.1550774 0.34512445 0.36754245 0.25875443 0.18017395 0.31995046 0.54064745
		 0.21407214 -0.48196855 0.55855244 0.42885369 -0.49523523 0.29273719 0.0077788136 0.025507206 0.81658834
		 0.0078540081 -0.23273827 0.82078195 0.61010683 0.10135313 0.6429556 0.29201278 0.17067315 0.72535408
		 0.30047348 -0.29953384 0.70965618 0.60724771 -0.12358893 0.62699735 0.42508 -0.49352708 -0.22378445
		 0.21769077 -0.48386663 -0.5165062 0.18609469 0.31534249 -0.53701621 0.35265455 0.36537492 -0.25013685
		 0.3015621 0.14261582 -0.68233234 0.62725186 0.050849993 -0.56806773 0.017593473 -0.23975831 -0.81129879
		 0.017597182 0.019535109 -0.80870742 0.63215363 -0.16777276 -0.55440503 0.3148852 -0.32237241 -0.67114133
		 0.65253639 0.30780512 0.18790174 0.80073011 0.17981395 0.38673237 0.82749736 0.13736463 -0.31149963
		 0.66387451 0.29178286 -0.14835493 0.94984603 0.0044800956 -0.1238998 0.93496466 0.028979477 0.22878379
		 0.75868338 -0.37122011 -0.11905935 0.87086862 -0.19057265 -0.29597917 0.83993709 -0.14847136 0.39674973
		 0.74224257 -0.35283893 0.21525948 0.055180568 -0.50481558 -0.24524413 0.04065451 0.41220278 -0.27336892
		 0.037994199 0.40822685 0.27385715 0.051716939 -0.50617158 0.2812039 -0.43796179 -0.3514761 -0.44809267
		 -0.40031788 0.2811594 -0.44749305 -0.26110443 -0.079931341 -0.73645598 -0.41995627 0.27391541 0.45865941
		 -0.45793697 -0.35482156 0.45957541 -0.28312209 -0.082850605 0.74360394 -0.68241006 0.19543034 0.013783148
		 -0.7316919 -0.1803212 0.012789934 0.49745864 0.25814146 0.48097277 0.53816962 -0.32912272 0.48640364
		 0.31560045 -0.062740676 0.75263095 0.55132532 -0.35330692 -0.41566566 0.50818259 0.22905955 -0.43839738
		 0.33092794 -0.089028113 -0.70798814 0.84871238 0.17121209 0.038457088 0.898817 -0.17198497 0.054271352;
	setAttr -size 270 ".edge";
	setAttr ".edge[0:165]"  1 70 1 9 68 1 0 66 1 0 64 1 10 62 1 0 60 1 7 58 1
		 6 56 1 6 54 1 9 52 1 4 50 1 1 48 1 5 46 1 4 44 1 10 42 1 3 40 1 8 38 1 2 36 1 2 34 1
		 11 32 1 5 30 1 2 28 1 8 26 1 5 24 1 7 22 1 3 20 1 11 18 1 7 16 1 8 14 1 10 12 1 12 13 1
		 13 11 1 14 15 1 15 9 1 16 17 1 17 8 1 18 19 1 19 6 1 20 21 1 21 6 1 22 23 1 23 3 1
		 24 25 1 25 11 1 26 27 1 27 4 1 28 29 1 29 4 1 30 31 1 31 2 1 32 33 1 33 3 1 34 35 1
		 35 11 1 36 37 1 37 3 1 38 39 1 39 2 1 40 41 1 41 8 1 42 43 1 43 5 1 44 45 1 45 9 1
		 46 47 1 47 4 1 48 49 1 49 5 1 50 51 1 51 1 1 52 53 1 53 7 1 54 55 1 55 10 1 56 57 1
		 57 0 1 58 59 1 59 6 1 60 61 1 61 7 1 62 63 1 63 1 1 64 65 1 65 10 1 66 67 1 67 1 1
		 68 69 1 69 0 1 70 71 1 71 9 1 52 72 1 72 17 1 52 15 1 72 15 1 72 14 1 17 14 1 53 16 1
		 53 72 1 16 72 1 18 73 1 73 55 1 18 13 1 73 13 1 73 12 1 55 12 1 19 54 1 19 73 1 54 73 1
		 42 74 1 74 25 1 42 12 1 74 12 1 74 13 1 25 13 1 43 24 1 43 74 1 24 74 1 26 75 1 75 45 1
		 26 14 1 75 14 1 75 15 1 45 15 1 27 44 1 27 75 1 44 75 1 22 76 1 76 41 1 22 16 1 76 16 1
		 76 17 1 41 17 1 23 40 1 23 76 1 40 76 1 32 77 1 77 21 1 32 18 1 77 18 1 77 19 1 21 19 1
		 33 20 1 33 77 1 20 77 1 58 78 1 78 20 1 58 22 1 78 22 1 78 23 1 20 23 1 59 21 1 59 78 1
		 21 78 1 25 79 1 79 31 1 25 35 1 79 35 1 79 34 1 31 34 1 24 30 1 24 79 1 30 79 1 38 80 1
		 80 29 1 38 26 1 80 26 1;
	setAttr ".edge[166:269]" 80 27 1 29 27 1 39 28 1 39 80 1 28 80 1 46 81 1 81 28 1
		 46 30 1 81 30 1 81 31 1 28 31 1 47 29 1 47 81 1 29 81 1 35 82 1 82 37 1 35 32 1 82 32 1
		 82 33 1 37 33 1 34 36 1 34 82 1 36 82 1 41 83 1 83 36 1 41 38 1 83 38 1 83 39 1 36 39 1
		 40 37 1 40 83 1 37 83 1 62 84 1 84 49 1 62 42 1 84 42 1 84 43 1 49 43 1 63 48 1 63 84 1
		 48 84 1 70 85 1 85 44 1 70 51 1 85 51 1 85 50 1 44 50 1 71 45 1 71 85 1 45 85 1 51 86 1
		 86 46 1 51 48 1 86 48 1 86 49 1 46 49 1 50 47 1 50 86 1 47 86 1 68 87 1 87 61 1 68 52 1
		 87 52 1 87 53 1 61 53 1 69 60 1 69 87 1 60 87 1 56 88 1 88 65 1 56 54 1 88 54 1 88 55 1
		 65 55 1 57 64 1 57 88 1 64 88 1 61 89 1 89 56 1 61 58 1 89 58 1 89 59 1 56 59 1 60 57 1
		 60 89 1 57 89 1 65 90 1 90 67 1 65 62 1 90 62 1 90 63 1 67 63 1 64 66 1 64 90 1 66 90 1
		 71 91 1 91 66 1 71 68 1 91 68 1 91 69 1 66 69 1 70 67 1 70 91 1 67 91 1;
	setAttr -size 180 ".face[0:179]" -type "polyFaces" 
		f 3 0 267 85
		mu 0 3 16 100 95
		f 3 3 258 -3
		mu 0 3 15 92 94
		f 3 5 249 75
		mu 0 3 15 88 85
		f 3 -76 240 -4
		mu 0 3 15 85 92
		f 3 -88 231 -6
		mu 0 3 15 99 88
		f 3 10 222 65
		mu 0 3 12 76 71
		f 3 -90 213 63
		mu 0 3 17 103 68
		f 3 -82 204 -12
		mu 0 3 16 91 73
		f 3 15 195 55
		mu 0 3 7 62 59
		f 3 18 186 -18
		mu 0 3 6 54 58
		f 3 -66 177 47
		mu 0 3 12 71 47
		f 3 -58 168 -22
		mu 0 3 6 61 46
		f 3 23 159 -21
		mu 0 3 5 40 48
		f 3 -78 150 39
		mu 0 3 8 87 37
		f 3 -52 141 -26
		mu 0 3 7 53 36
		f 3 -42 132 -16
		mu 0 3 7 39 62
		f 3 -46 123 -14
		mu 0 3 12 45 67
		f 3 -62 114 -24
		mu 0 3 10 65 41
		f 3 -38 105 -9
		mu 0 3 8 35 82
		f 3 -72 96 -28
		mu 0 3 14 81 30
		f 3 95 -29 -36
		mu 0 3 31 27 13
		f 3 -93 -10 -34
		mu 0 3 29 79 19
		f 3 -94 -91 92
		mu 0 3 29 104 79
		f 3 -95 93 -33
		mu 0 3 27 104 29
		f 3 -92 94 -96
		mu 0 3 31 104 27
		f 3 98 91 -35
		mu 0 3 30 104 31
		f 3 -98 -71 90
		mu 0 3 104 81 79
		f 3 -97 97 -99
		mu 0 3 30 81 104
		f 3 104 -30 -74
		mu 0 3 83 23 9
		f 3 -102 -27 -32
		mu 0 3 25 33 3
		f 3 -103 -100 101
		mu 0 3 25 105 33
		f 3 -104 102 -31
		mu 0 3 23 105 25
		f 3 -101 103 -105
		mu 0 3 83 105 23
		f 3 107 100 -73
		mu 0 3 82 105 83
		f 3 -107 -37 99
		mu 0 3 105 35 33
		f 3 -106 106 -108
		mu 0 3 82 35 105
		f 3 113 31 -44
		mu 0 3 43 24 4
		f 3 -111 -15 29
		mu 0 3 22 64 9
		f 3 -112 -109 110
		mu 0 3 22 106 64
		f 3 -113 111 30
		mu 0 3 24 106 22
		f 3 -110 112 -114
		mu 0 3 43 106 24
		f 3 116 109 -43
		mu 0 3 41 106 43
		f 3 -116 -61 108
		mu 0 3 106 65 64
		f 3 -115 115 -117
		mu 0 3 41 65 106
		f 3 122 33 -64
		mu 0 3 69 28 18
		f 3 -120 -23 28
		mu 0 3 26 44 13
		f 3 -121 -118 119
		mu 0 3 26 107 44
		f 3 -122 120 32
		mu 0 3 28 107 26
		f 3 -119 121 -123
		mu 0 3 69 107 28
		f 3 125 118 -63
		mu 0 3 67 107 69
		f 3 -125 -45 117
		mu 0 3 107 45 44
		f 3 -124 124 -126
		mu 0 3 67 45 107
		f 3 131 35 -60
		mu 0 3 63 31 13
		f 3 -129 -25 27
		mu 0 3 30 38 14
		f 3 -130 -127 128
		mu 0 3 30 108 38
		f 3 -131 129 34
		mu 0 3 31 108 30
		f 3 -128 130 -132
		mu 0 3 63 108 31
		f 3 134 127 -59
		mu 0 3 62 108 63
		f 3 -134 -41 126
		mu 0 3 108 39 38
		f 3 -133 133 -135
		mu 0 3 62 39 108
		f 3 140 37 -40
		mu 0 3 37 34 8
		f 3 -138 -20 26
		mu 0 3 32 51 2
		f 3 -139 -136 137
		mu 0 3 32 109 51
		f 3 -140 138 36
		mu 0 3 34 109 32
		f 3 -137 139 -141
		mu 0 3 37 109 34
		f 3 143 136 -39
		mu 0 3 36 109 37
		f 3 -143 -51 135
		mu 0 3 109 53 51
		f 3 -142 142 -144
		mu 0 3 36 53 109
		f 3 149 41 25
		mu 0 3 36 39 7
		f 3 -147 -7 24
		mu 0 3 38 86 14
		f 3 -148 -145 146
		mu 0 3 38 110 86
		f 3 -149 147 40
		mu 0 3 39 110 38
		f 3 -146 148 -150
		mu 0 3 36 110 39
		f 3 152 145 38
		mu 0 3 37 110 36
		f 3 -152 -77 144
		mu 0 3 110 87 86
		f 3 -151 151 -153
		mu 0 3 37 87 110
		f 3 158 -19 -50
		mu 0 3 49 55 6
		f 3 -156 43 -54
		mu 0 3 57 42 0
		f 3 -157 -154 155
		mu 0 3 57 111 42
		f 3 -158 156 -53
		mu 0 3 55 111 57
		f 3 -155 157 -159
		mu 0 3 49 111 55
		f 3 161 154 -49
		mu 0 3 48 111 49
		f 3 -161 42 153
		mu 0 3 111 40 42
		f 3 -160 160 -162
		mu 0 3 48 40 111
		f 3 167 45 -48
		mu 0 3 47 45 12
		f 3 -165 -17 22
		mu 0 3 44 60 13
		f 3 -166 -163 164
		mu 0 3 44 112 60
		f 3 -167 165 44
		mu 0 3 45 112 44
		f 3 -164 166 -168
		mu 0 3 47 112 45
		f 3 170 163 -47
		mu 0 3 46 112 47
		f 3 -170 -57 162
		mu 0 3 112 61 60
		f 3 -169 169 -171
		mu 0 3 46 61 112
		f 3 176 49 21
		mu 0 3 46 49 6
		f 3 -174 -13 20
		mu 0 3 48 70 5
		f 3 -175 -172 173
		mu 0 3 48 113 70
		f 3 -176 174 48
		mu 0 3 49 113 48
		f 3 -173 175 -177
		mu 0 3 46 113 49
		f 3 179 172 46
		mu 0 3 47 113 46
		f 3 -179 -65 171
		mu 0 3 113 71 70
		f 3 -178 178 -180
		mu 0 3 47 71 113
		f 3 185 51 -56
		mu 0 3 59 52 7
		f 3 -183 53 19
		mu 0 3 50 56 1
		f 3 -184 -181 182
		mu 0 3 50 114 56
		f 3 -185 183 50
		mu 0 3 52 114 50
		f 3 -182 184 -186
		mu 0 3 59 114 52
		f 3 188 181 -55
		mu 0 3 58 114 59
		f 3 -188 52 180
		mu 0 3 114 54 56
		f 3 -187 187 -189
		mu 0 3 58 54 114
		f 3 194 57 17
		mu 0 3 58 61 6
		f 3 -192 59 16
		mu 0 3 60 63 13
		f 3 -193 -190 191
		mu 0 3 60 115 63
		f 3 -194 192 56
		mu 0 3 61 115 60
		f 3 -191 193 -195
		mu 0 3 58 115 61
		f 3 197 190 54
		mu 0 3 59 115 58
		f 3 -197 58 189
		mu 0 3 115 62 63
		f 3 -196 196 -198
		mu 0 3 59 62 115
		f 3 203 61 -68
		mu 0 3 75 65 10
		f 3 -201 -5 14
		mu 0 3 64 90 9
		f 3 -202 -199 200
		mu 0 3 64 116 90
		f 3 -203 201 60
		mu 0 3 65 116 64
		f 3 -200 202 -204
		mu 0 3 75 116 65
		f 3 206 199 -67
		mu 0 3 73 116 75
		f 3 -206 -81 198
		mu 0 3 116 91 90
		f 3 -205 205 -207
		mu 0 3 73 91 116
		f 3 212 -11 13
		mu 0 3 66 76 12
		f 3 -210 -1 -70
		mu 0 3 77 101 11
		f 3 -211 -208 209
		mu 0 3 77 117 101
		f 3 -212 210 -69
		mu 0 3 76 117 77
		f 3 -209 211 -213
		mu 0 3 66 117 76
		f 3 215 208 62
		mu 0 3 68 117 66
		f 3 -215 -89 207
		mu 0 3 117 103 101
		f 3 -214 214 -216
		mu 0 3 68 103 117
		f 3 221 67 12
		mu 0 3 70 74 5
		f 3 -219 69 11
		mu 0 3 72 77 11
		f 3 -220 -217 218
		mu 0 3 72 118 77
		f 3 -221 219 66
		mu 0 3 74 118 72
		f 3 -218 220 -222
		mu 0 3 70 118 74
		f 3 224 217 64
		mu 0 3 71 118 70
		f 3 -224 68 216
		mu 0 3 118 76 77
		f 3 -223 223 -225
		mu 0 3 71 76 118
		f 3 230 71 -80
		mu 0 3 89 80 14
		f 3 -228 -2 9
		mu 0 3 78 97 20
		f 3 -229 -226 227
		mu 0 3 78 119 97
		f 3 -230 228 70
		mu 0 3 80 119 78
		f 3 -227 229 -231
		mu 0 3 89 119 80
		f 3 233 226 -79
		mu 0 3 88 119 89
		f 3 -233 -87 225
		mu 0 3 119 99 97
		f 3 -232 232 -234
		mu 0 3 88 99 119
		f 3 239 73 -84
		mu 0 3 93 83 9
		f 3 -237 -8 8
		mu 0 3 82 84 8
		f 3 -238 -235 236
		mu 0 3 82 120 84
		f 3 -239 237 72
		mu 0 3 83 120 82
		f 3 -236 238 -240
		mu 0 3 93 120 83
		f 3 242 235 -83
		mu 0 3 92 120 93
		f 3 -242 -75 234
		mu 0 3 120 85 84
		f 3 -241 241 -243
		mu 0 3 92 85 120
		f 3 248 77 7
		mu 0 3 84 87 8
		f 3 -246 79 6
		mu 0 3 86 89 14
		f 3 -247 -244 245
		mu 0 3 86 121 89
		f 3 -248 246 76
		mu 0 3 87 121 86
		f 3 -245 247 -249
		mu 0 3 84 121 87
		f 3 251 244 74
		mu 0 3 85 121 84
		f 3 -251 78 243
		mu 0 3 121 88 89
		f 3 -250 250 -252
		mu 0 3 85 88 121
		f 3 257 81 -86
		mu 0 3 95 91 16
		f 3 -255 83 4
		mu 0 3 90 93 9
		f 3 -256 -253 254
		mu 0 3 90 122 93
		f 3 -257 255 80
		mu 0 3 91 122 90
		f 3 -254 256 -258
		mu 0 3 95 122 91
		f 3 260 253 -85
		mu 0 3 94 122 95
		f 3 -260 82 252
		mu 0 3 122 92 93
		f 3 -259 259 -261
		mu 0 3 94 92 122
		f 3 266 87 2
		mu 0 3 94 98 15
		f 3 -264 89 1
		mu 0 3 96 102 21
		f 3 -265 -262 263
		mu 0 3 96 123 102
		f 3 -266 264 86
		mu 0 3 98 123 96
		f 3 -263 265 -267
		mu 0 3 94 123 98
		f 3 269 262 84
		mu 0 3 95 123 94
		f 3 -269 88 261
		mu 0 3 123 100 102
		f 3 -268 268 -270
		mu 0 3 95 100 123;
	setAttr ".creaseData" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".creaseVertexData" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".holeFaceData" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -name "polySurface2";
createNode mesh -name "polySurfaceShape2" -parent "polySurface2";
	setAttr -keyable off ".visibility";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".currentColorSet" -type "string" "colorPV";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
	setAttr ".motionVectorColorSet" -type "string" "velocityPV";
createNode transform -name "directionalLight1";
	setAttr ".rotate" -type "double3" -87.081113078068284 -47.564411299403375 19.827642768665427 ;
createNode directionalLight -name "directionalLightShape1" -parent "directionalLight1";
	setAttr -keyable off ".visibility";
	setAttr ".color" -type "float3" 1 0.87099999 0.81199998 ;
	setAttr ".intensity" 1.7999999523162842;
	setAttr ".useRayTraceShadows" yes;
	setAttr ".rayDepthLimit" 3;
createNode transform -name "pointLight1";
	setAttr ".translate" -type "double3" 8.3514061401566391 2.9570261658018939 -0.12371398017010016 ;
createNode pointLight -name "pointLightShape1" -parent "pointLight1";
	setAttr -keyable off ".visibility";
	setAttr ".color" -type "float3" 0.55900002 0.71200001 0.85299999 ;
	setAttr ".useRayTraceShadows" yes;
	setAttr ".rayDepthLimit" 3;
	setAttr ".useOnlySingleDmap" no;
createNode transform -name "pSphere1";
	setAttr ".scale" -type "double3" 24.326140366172577 24.326140366172577 24.326140366172577 ;
createNode mesh -name "pSphereShape1" -parent "pSphere1";
	setAttr -keyable off ".visibility";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".castsShadows" no;
	setAttr ".receiveShadows" no;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".doubleSided" no;
	setAttr ".opposite" yes;
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
createNode transform -name "pPlane1";
	setAttr ".translate" -type "double3" 0 -5.1196140516338051 0 ;
	setAttr ".scale" -type "double3" 79.695113955163478 79.695113955163478 79.695113955163478 ;
createNode mesh -name "pPlaneShape1" -parent "pPlane1";
	setAttr -keyable off ".visibility";
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
createNode place3dTexture -name "place3dTexture1";
createNode place3dTexture -name "place3dTexture2";
createNode transform -name "pCube1";
	setAttr ".translate" -type "double3" 0 -1.5727951094545625 0 ;
	setAttr ".scale" -type "double3" 1.0215961884195324 1.0088829901035319 1.0106293880599515 ;
createNode mesh -name "pCubeShape1" -parent "pCube1";
	setAttr -keyable off ".visibility";
	setAttr ".overrideShading" no;
	setAttr ".overrideEnabled" yes;
	setAttr ".visibleInReflections" yes;
	setAttr ".visibleInRefractions" yes;
	setAttr ".uvSet[0].uvSetName" -type "string" "map1";
	setAttr ".currentUVSet" -type "string" "map1";
	setAttr ".displayColorChannel" -type "string" "Ambient+Diffuse";
	setAttr ".collisionOffsetVelocityMultiplier[0]"  0 1 1;
	setAttr ".collisionDepthVelocityMultiplier[0]"  0 1 1;
createNode transform -name "LargeTankFillCam";
	setAttr ".translate" -type "double3" 9.7894294091572966 -1.5941611523863974 -2.0751796274572278 ;
	setAttr ".rotate" -type "double3" -8.1383527294063764 -623.39999999994143 0 ;
createNode camera -name "LargeTankFillCamShape" -parent "LargeTankFillCam";
	setAttr -keyable off ".visibility";
	setAttr ".renderable" no;
	setAttr ".focalLength" 34.999999999999993;
	setAttr ".centerOfInterest" 11.967633705811476;
	setAttr ".imageName" -type "string" "LargeTankFillCam";
	setAttr ".depthName" -type "string" "LargeTankFillCam_depth";
	setAttr ".maskName" -type "string" "LargeTankFillCam_mask";
	setAttr ".homeCommand" -type "string" "viewSet -p %camera";
createNode place3dTexture -name "place3dTexture3";
createNode lightLinker -shared -name "lightLinker1";
	setAttr -size 9 ".link";
	setAttr -size 9 ".shadowLink";
createNode displayLayerManager -name "layerManager";
createNode displayLayer -name "defaultLayer";
createNode renderLayerManager -name "renderLayerManager";
createNode renderLayer -name "defaultRenderLayer";
	setAttr ".global" yes;
createNode shadingEngine -name "fluidShape1SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo1";
createNode animCurveTU -name "fluidEmitter1_fluidDensityEmission";
	setAttr ".tangentType" 10;
	setAttr ".weightedTangents" no;
	setAttr ".keyTimeValue[0]"  2 1;
createNode animCurveTU -name "fluidEmitter2_rate";
	setAttr ".tangentType" 10;
	setAttr ".weightedTangents" no;
	setAttr -size 2 ".keyTimeValue[0:1]"  1 500 2 0;
createNode script -name "sceneConfigurationScriptNode";
	setAttr ".before" -type "string" "playbackOptions -min 1 -max 300 -ast 1 -aet 3000 ";
	setAttr ".scriptType" 6;
createNode polyPlatonicSolid -name "polyPlatonicSolid1";
	setAttr ".sideLength" 1.0514999628067017;
	setAttr ".solidType" 1;
	setAttr ".createUVs" 4;
createNode polySmoothFace -name "polySmoothFace1";
	setAttr ".inputComponents" -type "componentList" 1 "f[*]";
	setAttr ".method" 1;
	setAttr ".smoothUVs" yes;
	setAttr ".divisionsPerEdge" 2;
	setAttr ".pushStrength" 0.53293412923812866;
	setAttr ".roundness" -2;
	setAttr ".maya65Above" yes;
	setAttr ".maya2008Above" yes;
createNode polyTweak -name "polyTweak1";
	setAttr ".useOldPolyArchitecture" yes;
	setAttr -size 9 ".tweak";
	setAttr ".tweak[0]" -type "float3" 0.15927367 -0.013667828 0.048621919 ;
	setAttr ".tweak[1]" -type "float3" 0.10935497 0.06910982 0.064727254 ;
	setAttr ".tweak[3]" -type "float3" 0.072055198 0.013459952 0.039524235 ;
	setAttr ".tweak[5]" -type "float3" 0 -0.2573739 0 ;
	setAttr ".tweak[6]" -type "float3" 0 -0.2573739 0 ;
	setAttr ".tweak[8]" -type "float3" 0 0.30994126 0 ;
	setAttr ".tweak[9]" -type "float3" 0.15927367 0.29627344 0.048621919 ;
	setAttr ".tweak[10]" -type "float3" 0 -0.41155761 0 ;
	setAttr ".tweak[11]" -type "float3" 0.11527282 -0.28549197 0.0022980922 ;
createNode groupId -name "groupId1";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupParts -name "groupParts1";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".inputComponents" -type "componentList" 1 "f[0:179]";
createNode groupId -name "groupId2";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId3";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId4";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId5";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId6";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId7";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId8";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId9";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId10";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId11";
	setAttr ".isHistoricallyInteresting" 0;
createNode groupId -name "groupId12";
	setAttr ".isHistoricallyInteresting" 0;
createNode materialInfo -name "materialInfo2";
createNode materialInfo -name "materialInfo3";
createNode polySphere -name "polySphere1";
createNode lambert -name "lambert2";
	setAttr ".color" -type "float3" 0 0 0 ;
createNode shadingEngine -name "lambert2SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo4";
createNode ramp -name "ramp1";
	setAttr ".colorGain" -type "float3" 1.3 1.3 1.3 ;
	setAttr -size 6 ".colorEntryList";
	setAttr ".colorEntryList[2].position" 0.99000000953674316;
	setAttr ".colorEntryList[2].color" -type "float3" 0.071000002 0.12899999 0.176 ;
	setAttr ".colorEntryList[3].position" 0.63999998569488525;
	setAttr ".colorEntryList[3].color" -type "float3" 0.16074701 0.27644199 0.33198899 ;
	setAttr ".colorEntryList[4].position" 0.34999999403953552;
	setAttr ".colorEntryList[4].color" -type "float3" 0 0 0 ;
	setAttr ".colorEntryList[5].position" 0.56000000238418579;
	setAttr ".colorEntryList[5].color" -type "float3" 0.242448 0.41066501 0.473993 ;
	setAttr ".colorEntryList[6].position" 0.43999999761581421;
	setAttr ".colorEntryList[6].color" -type "float3" 0.741 0.89399999 0.91799998 ;
	setAttr ".colorEntryList[7].position" 0.51499998569488525;
	setAttr ".colorEntryList[7].color" -type "float3" 0.36500001 0.61199999 0.68699998 ;
	setAttr ".satNoise" 0.073170728981494904;
	setAttr ".valNoise" 0.040650408715009689;
	setAttr ".valNoiseFreq" 1;
createNode place2dTexture -name "place2dTexture1";
createNode polyPlane -name "polyPlane1";
	setAttr ".createUVs" 2;
createNode blinn -name "blinn1";
	addAttr -cachedInternally true -shortName "mircl" -longName "miReflectionBlurLimit" 
		-defaultValue 1 -minValue 0 -softMaxValue 10 -attributeType "short";
	addAttr -cachedInternally true -shortName "mirfl" -longName "miRefractionBlurLimit" 
		-defaultValue 1 -minValue 0 -softMaxValue 10 -attributeType "short";
	addAttr -cachedInternally true -shortName "miibr" -longName "miScatterRadius" -minValue 
		0 -softMaxValue 10 -attributeType "float";
	addAttr -cachedInternally true -usedAsColor -shortName "miibc" -longName "miScatterColor" 
		-attributeType "float3" -numberOfChildren 3;
	addAttr -cachedInternally true -shortName "miibcr" -longName "miScatterColorR" -defaultValue 
		0.5 -attributeType "float" -parent "miScatterColor";
	addAttr -cachedInternally true -shortName "miibcg" -longName "miScatterColorG" -defaultValue 
		0.5 -attributeType "float" -parent "miScatterColor";
	addAttr -cachedInternally true -shortName "miibcb" -longName "miScatterColorB" -defaultValue 
		0.5 -attributeType "float" -parent "miScatterColor";
	addAttr -cachedInternally true -shortName "miiba" -longName "miScatterAccuracy" 
		-defaultValue 97 -minValue 0 -softMaxValue 256 -attributeType "short";
	addAttr -cachedInternally true -shortName "miibf" -longName "miScatterFalloff" -minValue 
		0 -maxValue 3 -enumName "None:Linear:Quadratic:Exponential" -attributeType "enum";
	addAttr -cachedInternally true -shortName "miibl" -longName "miScatterLimit" -defaultValue 
		1 -minValue 0 -softMaxValue 10 -attributeType "short";
	addAttr -cachedInternally true -shortName "miibx" -longName "miScatterCache" -attributeType "short";
	setAttr ".diffuse" 0.29268291592597961;
	setAttr ".reflectionLimit" 5;
	setAttr ".specularColor" -type "float3" 1 1 1 ;
	setAttr ".reflectivity" 1;
	setAttr ".eccentricity" 0.073163412511348724;
	setAttr ".specularRollOff" 0.15447154641151428;
createNode shadingEngine -name "blinn1SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo5";
createNode noise -name "noise1";
	setAttr ".colorGain" -type "float3" 0.74699998 0.88800001 0.85299999 ;
	setAttr ".defaultColor" -type "float3" 0.39399999 0.51800001 0.359 ;
	setAttr ".amplitude" 0.5203251838684082;
	setAttr ".ratio" 0.5899280309677124;
	setAttr ".depthMax" 6;
	setAttr ".frequency" 4.3165469169616699;
	setAttr ".noiseType" 0;
createNode place2dTexture -name "place2dTexture2";
createNode blinn -name "blinn2";
	addAttr -cachedInternally true -shortName "mircl" -longName "miReflectionBlurLimit" 
		-defaultValue 1 -minValue 0 -softMaxValue 10 -attributeType "short";
	addAttr -cachedInternally true -shortName "mirfl" -longName "miRefractionBlurLimit" 
		-defaultValue 1 -minValue 0 -softMaxValue 10 -attributeType "short";
	addAttr -cachedInternally true -shortName "miibr" -longName "miScatterRadius" -minValue 
		0 -softMaxValue 10 -attributeType "float";
	addAttr -cachedInternally true -usedAsColor -shortName "miibc" -longName "miScatterColor" 
		-attributeType "float3" -numberOfChildren 3;
	addAttr -cachedInternally true -shortName "miibcr" -longName "miScatterColorR" -defaultValue 
		0.5 -attributeType "float" -parent "miScatterColor";
	addAttr -cachedInternally true -shortName "miibcg" -longName "miScatterColorG" -defaultValue 
		0.5 -attributeType "float" -parent "miScatterColor";
	addAttr -cachedInternally true -shortName "miibcb" -longName "miScatterColorB" -defaultValue 
		0.5 -attributeType "float" -parent "miScatterColor";
	addAttr -cachedInternally true -shortName "miiba" -longName "miScatterAccuracy" 
		-defaultValue 97 -minValue 0 -softMaxValue 256 -attributeType "short";
	addAttr -cachedInternally true -shortName "miibf" -longName "miScatterFalloff" -minValue 
		0 -maxValue 3 -enumName "None:Linear:Quadratic:Exponential" -attributeType "enum";
	addAttr -cachedInternally true -shortName "miibl" -longName "miScatterLimit" -defaultValue 
		1 -minValue 0 -softMaxValue 10 -attributeType "short";
	addAttr -cachedInternally true -shortName "miibx" -longName "miScatterCache" -attributeType "short";
	setAttr ".diffuse" 0.52845525741577148;
	setAttr ".reflectionLimit" 3;
	setAttr ".specularColor" -type "float3" 0.47966737 0.47966737 0.47966737 ;
	setAttr ".reflectivity" 1;
	setAttr ".eccentricity" 0.10568048804998398;
	setAttr ".specularRollOff" 0.048780489712953568;
createNode shadingEngine -name "blinn2SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo6";
createNode solidFractal -name "solidFractal1";
	setAttr ".alphaIsLuminance" yes;
createNode bump3d -name "bump3d1";
	setAttr ".bumpDepth" 0.82733809947967529;
createNode volumeNoise -name "volumeNoise1";
	setAttr ".amplitude" 0.22900763154029846;
	setAttr ".noiseType" 0;
createNode polyCube -name "polyCube1";
	setAttr ".width" 5.05;
	setAttr ".height" 6.9399999963119621;
	setAttr ".depth" 10.900000034114345;
	setAttr ".createUVs" 4;
createNode materialInfo -name "materialInfo7";
createNode materialInfo -name "materialInfo8";
createNode fractal -name "fractal1";
	setAttr ".alphaIsLuminance" yes;
	setAttr ".amplitude" 0.14634145796298981;
	setAttr ".levelMax" 6;
createNode place2dTexture -name "place2dTexture3";
createNode bump2d -name "bump2d1";
	setAttr ".bumpDepth" 0.17985610663890839;
	setAttr ".vertexCameraOne" -type "float3" 0 0.00065000006 0 ;
	setAttr ".vertexCameraTwo" -type "float3" 9.9999997e-006 9.9999997e-006 0 ;
createNode materialInfo -name "materialInfo9";
createNode materialInfo -name "materialInfo10";
createNode polyPipe -name "polyPipe1";
	setAttr ".radius" 1.23;
	setAttr ".height" 100;
	setAttr ".thickness" 0.2;
	setAttr ".subdivisionsAxis" 29;
	setAttr ".subdivisionsCaps" 5;
	setAttr ".roundCap" yes;
createNode blinn -name "blinn3";
	setAttr ".color" -type "float3" 0.69454491 0.69454491 0.69454491 ;
	setAttr ".specularColor" -type "float3" 0.85455102 0.85455102 0.85455102 ;
	setAttr ".reflectivity" 0.80727273225784302;
	setAttr ".eccentricity" 0.06181199848651886;
	setAttr ".specularRollOff" 0.065454542636871338;
createNode shadingEngine -name "blinn3SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo11";
createNode geoConnector -name "geoConnector1";
createNode geoConnector -name "geoConnector2";
createNode animCurveTU -name "fluidEmitter2_alongAxis";
	setAttr ".tangentType" 10;
	setAttr ".weightedTangents" no;
	setAttr -size 4 ".keyTimeValue[0:3]"  1 0 29 -12 210 -12 280 0;
createNode animCurveTU -name "fluidEmitter2_rate1";
	setAttr ".tangentType" 10;
	setAttr ".weightedTangents" no;
	setAttr -size 2 ".keyTimeValue[0:1]"  210 81.881533063727488 279 0;
createNode polyExtrudeFace -name "polyExtrudeFace1";
	setAttr ".inputComponents" -type "componentList" 1 "f[0:5]";
	setAttr ".inputMatrix" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -1.5727951094545625 0 1;
	setAttr ".worldSpace" yes;
	setAttr ".pivot" -type "float3" 0 0.12121575 0 ;
	setAttr ".randomSeed" 63457;
	setAttr ".localTranslate" -type "double3" 0 0 -0.18223740854939852 ;
	setAttr ".taperCurve[0]"  0 1 1;
	setAttr ".compBoundingBoxMin" -type "double3" -2.5250000953674316 -5.0427951380647915 
		-5.0250000953674316 ;
	setAttr ".compBoundingBoxMax" -type "double3" 2.5250000953674316 5.2852266266904575 
		5.0250000953674316 ;
createNode polyTweak -name "polyTweak2";
	setAttr ".useOldPolyArchitecture" yes;
	setAttr -size 8 ".tweak";
	setAttr ".tweak[2]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[3]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[4]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[5]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[10]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[11]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[12]" -type "float3" 0 3.3880217 0 ;
	setAttr ".tweak[13]" -type "float3" 0 3.3880217 0 ;
createNode polyPlane -name "polyPlane3";
	setAttr ".subdivisionsWidth" 20;
	setAttr ".subdivisionsHeight" 20;
	setAttr ".createUVs" 2;
createNode deleteComponent -name "deleteComponent3";
	setAttr ".deleteComponents" -type "componentList" 14 "f[0:6]" "f[13:23]" "f[35:42]" "f[56:61]" "f[77:81]" "f[98:100]" "f[119:120]" "f[139:140]" "f[299:300]" "f[319:321]" "f[338:342]" "f[358:364]" "f[377:386]" "f[394:399]";
createNode deleteComponent -name "deleteComponent4";
	setAttr ".deleteComponents" -type "componentList" 12 "f[6]" "f[17]" "f[30]" "f[196]" "f[216]" "f[235:236]" "f[255]" "f[272]" "f[288]" "f[302:303]" "f[314:315]" "f[322]";
createNode deleteComponent -name "deleteComponent5";
	setAttr ".deleteComponents" -type "componentList" 77 "f[0]" "f[2]" "f[4]" "f[7]" "f[9]" "f[11]" "f[13]" "f[22]" "f[24]" "f[26]" "f[29:30]" "f[32]" "f[34:35]" "f[37:38]" "f[40]" "f[47]" "f[57]" "f[59:60]" "f[62]" "f[68:69]" "f[71:72]" "f[76]" "f[80]" "f[82:83]" "f[87]" "f[89:90]" "f[92:93]" "f[95:96]" "f[100]" "f[110]" "f[114]" "f[118]" "f[122:124]" "f[127:128]" "f[131]" "f[133]" "f[136]" "f[138:139]" "f[141:142]" "f[144:145]" "f[148]" "f[151:152]" "f[154]" "f[156]" "f[161:165]" "f[173]" "f[178:179]" "f[181:185]" "f[187:188]" "f[191]" "f[194:195]" "f[197]" "f[201:203]" "f[207]" "f[209:210]" "f[213]" "f[234:235]" "f[237:238]" "f[240]" "f[242:243]" "f[246]" "f[249]" "f[252]" "f[254]" "f[256:257]" "f[259]" "f[263]" "f[265:266]" "f[277]" "f[282]" "f[284]" "f[288:289]" "f[293]" "f[295]" "f[297:298]" "f[300]" "f[305]";
createNode deleteComponent -name "deleteComponent6";
	setAttr ".deleteComponents" -type "componentList" 1 "f[89]";
createNode deleteComponent -name "deleteComponent7";
	setAttr ".deleteComponents" -type "componentList" 1 "f[79]";
createNode deleteComponent -name "deleteComponent8";
	setAttr ".deleteComponents" -type "componentList" 1 "f[79]";
createNode deleteComponent -name "deleteComponent9";
	setAttr ".deleteComponents" -type "componentList" 4 "f[43]" "f[51]" "f[63:65]" "f[176]";
createNode geoConnector -name "geoConnector3";
createNode deleteComponent -name "deleteComponent10";
	setAttr ".deleteComponents" -type "componentList" 1 "f[173]";
createNode deleteComponent -name "deleteComponent11";
	setAttr ".deleteComponents" -type "componentList" 1 "f[84]";
createNode deleteComponent -name "deleteComponent12";
	setAttr ".deleteComponents" -type "componentList" 1 "f[142]";
createNode solidFractal -name "solidFractal2";
	setAttr ".alphaGain" 0;
	setAttr ".ratio" 0.81818181276321411;
createNode phong -name "phong1";
	setAttr ".transparency" -type "float3" 0.91056687 0.91056687 0.91056687 ;
createNode shadingEngine -name "phong1SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo12";
createNode blinn -name "blinn4";
	setAttr ".color" -type "float3" 0.39023456 0.55995327 0.68627453 ;
	setAttr ".transparency" -type "float3" 0.73983365 0.73983365 0.73983365 ;
createNode shadingEngine -name "blinn4SG";
	setAttr ".isHistoricallyInteresting" 0;
	setAttr ".renderableOnlySet" yes;
createNode materialInfo -name "materialInfo13";
select -noExpand :time1;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting" 0;
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr ".outTime" 1;
	setAttr ".unwarpedTime" 1;
select -noExpand :renderPartition;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr -size 9 ".sets";
	setAttr -channelBox on ".annotation";
	setAttr -channelBox on ".partitionType";
select -noExpand :initialShadingGroup;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -alteredValue -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr -size 13 ".dagSetMembers";
	setAttr -keyable on ".memberWireframeColor";
	setAttr -channelBox on ".annotation";
	setAttr -channelBox on ".isLayer";
	setAttr -channelBox on ".verticesOnlySet";
	setAttr -channelBox on ".edgesOnlySet";
	setAttr -channelBox on ".facetsOnlySet";
	setAttr -channelBox on ".editPointsOnlySet";
	setAttr ".renderableOnlySet" yes;
	setAttr -size 12 ".groupNodes";
select -noExpand :initialParticleSE;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr -keyable on ".memberWireframeColor";
	setAttr -channelBox on ".annotation";
	setAttr -channelBox on ".isLayer";
	setAttr -channelBox on ".verticesOnlySet";
	setAttr -channelBox on ".edgesOnlySet";
	setAttr -channelBox on ".facetsOnlySet";
	setAttr -channelBox on ".editPointsOnlySet";
	setAttr ".renderableOnlySet" yes;
select -noExpand :defaultShaderList1;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr -size 9 ".shaders";
select -noExpand :defaultTextureList1;
	setAttr -size 6 ".textures";
select -noExpand :lightList1;
	setAttr -size 2 ".lights";
select -noExpand :postProcessList1;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr -size 2 ".postProcesses";
select -noExpand :defaultRenderUtilityList1;
	setAttr -size 8 ".utilities";
select -noExpand :defaultRenderingList1;
select -noExpand :renderGlobalsList1;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
select -noExpand :defaultRenderGlobals;
	setAttr ".animation" yes;
	setAttr ".endFrame" 300;
	setAttr ".outFormatControl" 1;
	setAttr -keyable on ".motionBlurByFrame";
select -noExpand :defaultResolution;
	setAttr ".pixelAspect" 1;
select -noExpand :defaultLightSet;
	setAttr -keyable on ".caching";
	setAttr -keyable on ".nodeState";
	setAttr -size 2 ".dagSetMembers";
	setAttr -keyable on ".memberWireframeColor";
	setAttr ".renderableOnlySet" yes;
select -noExpand :hardwareRenderGlobals;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr ".colorTextureResolution" 256;
	setAttr ".bumpTextureResolution" 512;
	setAttr -keyable off -channelBox on ".enableHighQualityLighting";
	setAttr -keyable off -channelBox on ".enableAcceleratedMultiSampling";
	setAttr -keyable off ".enableEdgeAntiAliasing";
	setAttr -keyable off ".enableGeometryMask";
	setAttr -keyable off ".numberOfSamples";
	setAttr -keyable off ".enableMotionBlur";
	setAttr -keyable off ".motionBlurByFrame";
	setAttr -keyable off ".numberOfExposures";
	setAttr -keyable off ".transparencySorting";
	setAttr -keyable off -channelBox on ".transparentShadowCasting";
	setAttr -keyable off ".culling";
	setAttr -keyable off -channelBox on ".textureCompression";
	setAttr -keyable off -channelBox on ".lightIntensityThreshold";
	setAttr -keyable off -channelBox on ".smallObjectCulling";
	setAttr -keyable off -channelBox on ".cullingThreshold";
	setAttr -keyable off -channelBox on ".maximumGeometryCacheSize";
	setAttr -keyable off ".writeAlphaAsColor";
	setAttr -keyable off ".writeZDepthAsColor";
	setAttr -keyable on ".hardwareCodec";
	setAttr -keyable on ".hardwareDepth";
	setAttr -keyable on ".hardwareQual";
select -noExpand :defaultHardwareRenderGlobals;
	setAttr -keyable on ".caching";
	setAttr -channelBox on ".isHistoricallyInteresting";
	setAttr -keyable on ".nodeState";
	setAttr -channelBox on ".binMembership";
	setAttr -keyable on ".cameraIcons";
	setAttr -keyable on ".collisionIcons";
	setAttr -channelBox on ".backgroundColor";
	setAttr -alteredValue -keyable on ".backgroundColorB";
	setAttr -alteredValue -keyable on ".backgroundColorG";
	setAttr -alteredValue -keyable on ".backgroundColorR";
	setAttr -keyable on ".emitterIcons";
	setAttr -keyable on ".extension";
	setAttr -keyable on ".edgeSmoothing";
	setAttr -alteredValue -keyable on ".endFrame";
	setAttr -channelBox on ".byFrame";
	setAttr -keyable on ".fieldIcons";
	setAttr -channelBox on ".startFrame";
	setAttr -keyable on ".grid";
	setAttr -keyable on ".lightIcons";
	setAttr -keyable on ".lineSmoothing";
	setAttr -keyable on ".transformIcons";
	setAttr -keyable on ".texturing";
	setAttr -keyable on ".multiPassRendering";
	setAttr -keyable on ".writeZDepth";
	setAttr ".filename" -type "string" "im";
	setAttr -keyable on ".imageFormat";
	setAttr ".resolution" -type "string" "ntsc_4d 646 485 1.333";
	setAttr -keyable on ".alphaSource";
	setAttr -keyable on ".drawStyle";
	setAttr -keyable on ".lightingMode";
	setAttr -keyable on ".fullImageResolution";
	setAttr -keyable on ".antiAliasPolygons";
	setAttr -keyable on ".geometryMask";
	setAttr -channelBox on ".displayShadows";
connectAttr ":time1.outTime" "fluidShape1.currentTime";
connectAttr "fluidEmitter2.emissionFunction" "fluidShape1.emissionList[1].emissionFunction_Raw"
		;
connectAttr "fluidEmitter2.emitFluidColor" "fluidShape1.fluidColorEmission[1]";
connectAttr "geoConnector1.resilience" "fluidShape1.collisionResilience" -nextAvailable
		;
connectAttr "geoConnector2.resilience" "fluidShape1.collisionResilience" -nextAvailable
		;
connectAttr "geoConnector3.resilience" "fluidShape1.collisionResilience" -nextAvailable
		;
connectAttr "geoConnector1.friction" "fluidShape1.collisionFriction" -nextAvailable
		;
connectAttr "geoConnector2.friction" "fluidShape1.collisionFriction" -nextAvailable
		;
connectAttr "geoConnector3.friction" "fluidShape1.collisionFriction" -nextAvailable
		;
connectAttr "geoConnector1.sweptGeometry" "fluidShape1.collisionGeometry" -nextAvailable
		;
connectAttr "geoConnector2.sweptGeometry" "fluidShape1.collisionGeometry" -nextAvailable
		;
connectAttr "geoConnector3.sweptGeometry" "fluidShape1.collisionGeometry" -nextAvailable
		;
connectAttr "fluidEmitter2_rate1.output" "fluidEmitter2.rate";
connectAttr "fluidEmitter2_alongAxis.output" "fluidEmitter2.alongAxis";
connectAttr ":time1.outTime" "fluidEmitter2.currentTime";
connectAttr "fluidShape1.isFull" "fluidEmitter2.isFull[0]";
connectAttr "fluidShape1.overrideTimeStep" "fluidEmitter2.deltaTime[0]";
connectAttr "fluidShape1.inheritFactor" "fluidEmitter2.inheritFactor[0]";
connectAttr "fluidShape1.startTime" "fluidEmitter2.startTime[0]";
connectAttr "fluidShape1.seed[1]" "fluidEmitter2.seed[0]";
connectAttr "polyPipe1.output" "pPipeShape1.inMesh";
connectAttr "deleteComponent12.outputGeometry" "grillShape1.inMesh";
connectAttr "groupId1.groupId" "pSolidShape1.instObjGroups.objectGroups[0].objectGroupId"
		;
connectAttr ":initialShadingGroup.memberWireframeColor" "pSolidShape1.instObjGroups.objectGroups[0].objectGrpColor"
		;
connectAttr "groupParts1.outputGeometry" "pSolidShape1.inMesh";
connectAttr "groupId2.groupId" "pSolidShape1.compInstObjGroups.compObjectGroups[0].compObjectGroupId"
		;
connectAttr "groupId3.groupId" "pSolidShape2.instObjGroups.objectGroups[0].objectGroupId"
		;
connectAttr ":initialShadingGroup.memberWireframeColor" "pSolidShape2.instObjGroups.objectGroups[0].objectGrpColor"
		;
connectAttr "groupId4.groupId" "pSolidShape2.compInstObjGroups.compObjectGroups[0].compObjectGroupId"
		;
connectAttr "groupId5.groupId" "pSolidShape3.instObjGroups.objectGroups[0].objectGroupId"
		;
connectAttr ":initialShadingGroup.memberWireframeColor" "pSolidShape3.instObjGroups.objectGroups[0].objectGrpColor"
		;
connectAttr "groupId6.groupId" "pSolidShape3.compInstObjGroups.compObjectGroups[0].compObjectGroupId"
		;
connectAttr "groupId7.groupId" "pSolidShape4.instObjGroups.objectGroups[0].objectGroupId"
		;
connectAttr ":initialShadingGroup.memberWireframeColor" "pSolidShape4.instObjGroups.objectGroups[0].objectGrpColor"
		;
connectAttr "groupId8.groupId" "pSolidShape4.compInstObjGroups.compObjectGroups[0].compObjectGroupId"
		;
connectAttr "groupId9.groupId" "pSolidShape5.instObjGroups.objectGroups[0].objectGroupId"
		;
connectAttr ":initialShadingGroup.memberWireframeColor" "pSolidShape5.instObjGroups.objectGroups[0].objectGrpColor"
		;
connectAttr "groupId10.groupId" "pSolidShape5.compInstObjGroups.compObjectGroups[0].compObjectGroupId"
		;
connectAttr "groupId11.groupId" "pSolidShape6.instObjGroups.objectGroups[0].objectGroupId"
		;
connectAttr ":initialShadingGroup.memberWireframeColor" "pSolidShape6.instObjGroups.objectGroups[0].objectGrpColor"
		;
connectAttr "groupId12.groupId" "pSolidShape6.compInstObjGroups.compObjectGroups[0].compObjectGroupId"
		;
connectAttr "fluidShape1.outMesh" "polySurfaceShape2.inMesh";
connectAttr "polySphere1.output" "pSphereShape1.inMesh";
connectAttr "polyPlane1.output" "pPlaneShape1.inMesh";
connectAttr "polyExtrudeFace1.output" "pCubeShape1.inMesh";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "fluidShape1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn3SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "phong1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "blinn4SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "fluidShape1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn3SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "phong1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "blinn4SG.message" ":defaultLightSet.message";
connectAttr "layerManager.displayLayerId[0]" "defaultLayer.identification";
connectAttr "renderLayerManager.renderLayerId[0]" "defaultRenderLayer.identification"
		;
connectAttr "fluidShape1.outColor" "fluidShape1SG.volumeShader";
connectAttr "fluidShape1.instObjGroups" "fluidShape1SG.dagSetMembers" -nextAvailable
		;
connectAttr "fluidShape1SG.message" "materialInfo1.shadingGroup";
connectAttr "polyTweak1.output" "polySmoothFace1.inputPolymesh";
connectAttr "polyPlatonicSolid1.output" "polyTweak1.inputPolymesh";
connectAttr "polySmoothFace1.output" "groupParts1.inputGeometry";
connectAttr "groupId1.groupId" "groupParts1.groupId";
connectAttr "ramp1.outColor" "lambert2.incandescence";
connectAttr "lambert2.outColor" "lambert2SG.surfaceShader";
connectAttr "pSphereShape1.instObjGroups" "lambert2SG.dagSetMembers" -nextAvailable
		;
connectAttr "lambert2SG.message" "materialInfo4.shadingGroup";
connectAttr "lambert2.message" "materialInfo4.material";
connectAttr "place2dTexture1.outUV" "ramp1.uvCoord";
connectAttr "place2dTexture1.outUvFilterSize" "ramp1.uvFilterSize";
connectAttr "noise1.outColor" "blinn1.color";
connectAttr "blinn1.outColor" "blinn1SG.surfaceShader";
connectAttr "pPlaneShape1.instObjGroups" "blinn1SG.dagSetMembers" -nextAvailable
		;
connectAttr "blinn1SG.message" "materialInfo5.shadingGroup";
connectAttr "blinn1.message" "materialInfo5.material";
connectAttr "noise1.message" "materialInfo5.texture" -nextAvailable;
connectAttr "place2dTexture2.outUV" "noise1.uvCoord";
connectAttr "place2dTexture2.outUvFilterSize" "noise1.uvFilterSize";
connectAttr "bump3d1.outNormal" "blinn2.normalCamera";
connectAttr "volumeNoise1.outColor" "blinn2.color";
connectAttr "blinn2.outColor" "blinn2SG.surfaceShader";
connectAttr "blinn2SG.message" "materialInfo6.shadingGroup";
connectAttr "blinn2.message" "materialInfo6.material";
connectAttr "volumeNoise1.message" "materialInfo6.texture" -nextAvailable;
connectAttr "place3dTexture1.worldInverseMatrix" "solidFractal1.placementMatrix"
		;
connectAttr "solidFractal1.outAlpha" "bump3d1.bumpValue";
connectAttr "place3dTexture2.worldInverseMatrix" "volumeNoise1.placementMatrix";
connectAttr "place2dTexture3.outUV" "fractal1.uvCoord";
connectAttr "place2dTexture3.outUvFilterSize" "fractal1.uvFilterSize";
connectAttr "fractal1.outAlpha" "bump2d1.bumpValue";
connectAttr "blinn3.outColor" "blinn3SG.surfaceShader";
connectAttr "pPipeShape1.instObjGroups" "blinn3SG.dagSetMembers" -nextAvailable;
connectAttr "blinn3SG.message" "materialInfo11.shadingGroup";
connectAttr "blinn3.message" "materialInfo11.material";
connectAttr "pCubeShape1.message" "geoConnector1.owner";
connectAttr "pCubeShape1.worldMatrix" "geoConnector1.worldMatrix";
connectAttr "pCubeShape1.outMesh" "geoConnector1.localGeometry";
connectAttr ":time1.outTime" "geoConnector1.currentTime";
connectAttr "pPipeShape1.message" "geoConnector2.owner";
connectAttr "pPipeShape1.worldMatrix" "geoConnector2.worldMatrix";
connectAttr "pPipeShape1.outMesh" "geoConnector2.localGeometry";
connectAttr ":time1.outTime" "geoConnector2.currentTime";
connectAttr "polyTweak2.output" "polyExtrudeFace1.inputPolymesh";
connectAttr "pCubeShape1.worldMatrix" "polyExtrudeFace1.manipMatrix";
connectAttr "polyCube1.output" "polyTweak2.inputPolymesh";
connectAttr "polyPlane3.output" "deleteComponent3.inputGeometry";
connectAttr "deleteComponent3.outputGeometry" "deleteComponent4.inputGeometry";
connectAttr "deleteComponent4.outputGeometry" "deleteComponent5.inputGeometry";
connectAttr "deleteComponent5.outputGeometry" "deleteComponent6.inputGeometry";
connectAttr "deleteComponent6.outputGeometry" "deleteComponent7.inputGeometry";
connectAttr "deleteComponent7.outputGeometry" "deleteComponent8.inputGeometry";
connectAttr "deleteComponent8.outputGeometry" "deleteComponent9.inputGeometry";
connectAttr "grillShape1.message" "geoConnector3.owner";
connectAttr "grillShape1.worldMatrix" "geoConnector3.worldMatrix";
connectAttr "grillShape1.outMesh" "geoConnector3.localGeometry";
connectAttr ":time1.outTime" "geoConnector3.currentTime";
connectAttr "deleteComponent9.outputGeometry" "deleteComponent10.inputGeometry";
connectAttr "deleteComponent10.outputGeometry" "deleteComponent11.inputGeometry"
		;
connectAttr "deleteComponent11.outputGeometry" "deleteComponent12.inputGeometry"
		;
connectAttr "place3dTexture3.worldInverseMatrix" "solidFractal2.placementMatrix"
		;
connectAttr "phong1.outColor" "phong1SG.surfaceShader";
connectAttr "pCubeShape1.instObjGroups" "phong1SG.dagSetMembers" -nextAvailable;
connectAttr "phong1SG.message" "materialInfo12.shadingGroup";
connectAttr "phong1.message" "materialInfo12.material";
connectAttr "blinn4.outColor" "blinn4SG.surfaceShader";
connectAttr "polySurfaceShape2.instObjGroups" "blinn4SG.dagSetMembers" -nextAvailable
		;
connectAttr "blinn4SG.message" "materialInfo13.shadingGroup";
connectAttr "blinn4.message" "materialInfo13.material";
connectAttr "fluidShape1SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "lambert2SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "blinn1SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "blinn2SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "blinn3SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "phong1SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "blinn4SG.partition" ":renderPartition.sets" -nextAvailable;
connectAttr "pSolidShape1.instObjGroups.objectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape1.compInstObjGroups.compObjectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape2.instObjGroups.objectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape2.compInstObjGroups.compObjectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape3.instObjGroups.objectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape3.compInstObjGroups.compObjectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape4.instObjGroups.objectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape4.compInstObjGroups.compObjectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape5.instObjGroups.objectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape5.compInstObjGroups.compObjectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape6.instObjGroups.objectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "pSolidShape6.compInstObjGroups.compObjectGroups[0]" ":initialShadingGroup.dagSetMembers"
		 -nextAvailable;
connectAttr "grillShape1.instObjGroups" ":initialShadingGroup.dagSetMembers" -nextAvailable
		;
connectAttr "groupId1.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId2.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId3.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId4.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId5.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId6.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId7.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId8.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId9.message" ":initialShadingGroup.groupNodes" -nextAvailable;
connectAttr "groupId10.message" ":initialShadingGroup.groupNodes" -nextAvailable
		;
connectAttr "groupId11.message" ":initialShadingGroup.groupNodes" -nextAvailable
		;
connectAttr "groupId12.message" ":initialShadingGroup.groupNodes" -nextAvailable
		;
connectAttr "fluidShape1.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "lambert2.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "blinn1.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "blinn2.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "blinn3.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "phong1.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "blinn4.message" ":defaultShaderList1.shaders" -nextAvailable;
connectAttr "ramp1.message" ":defaultTextureList1.textures" -nextAvailable;
connectAttr "noise1.message" ":defaultTextureList1.textures" -nextAvailable;
connectAttr "solidFractal1.message" ":defaultTextureList1.textures" -nextAvailable
		;
connectAttr "volumeNoise1.message" ":defaultTextureList1.textures" -nextAvailable
		;
connectAttr "fractal1.message" ":defaultTextureList1.textures" -nextAvailable;
connectAttr "solidFractal2.message" ":defaultTextureList1.textures" -nextAvailable
		;
connectAttr "directionalLightShape1.lightData" ":lightList1.lights" -nextAvailable
		;
connectAttr "pointLightShape1.lightData" ":lightList1.lights" -nextAvailable;
connectAttr "place2dTexture1.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "place2dTexture2.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "place3dTexture1.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "bump3d1.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "place3dTexture2.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "place2dTexture3.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "bump2d1.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "place3dTexture3.message" ":defaultRenderUtilityList1.utilities" -nextAvailable
		;
connectAttr "defaultRenderLayer.message" ":defaultRenderingList1.rendering" -nextAvailable
		;
connectAttr "directionalLight1.instObjGroups" ":defaultLightSet.dagSetMembers" -nextAvailable
		;
connectAttr "pointLight1.instObjGroups" ":defaultLightSet.dagSetMembers" -nextAvailable
		;
// End of LargeTankFill.ma
