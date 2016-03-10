//Maya ASCII 5.0 scene
//Name: ShowDisplace.ma
//Last modified: Tue, Mar 25, 2003 08:45:58 PM
requires maya "5.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 5.0";
fileInfo "version" "5.0";
fileInfo "cutIdentifier" "200303250009";
fileInfo "osv" "Microsoft Windows 2000 Professional Service Pack 3 (Build 2195)\n";
createNode transform -n "pPlane1";
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
	setAttr ".s" -type "double3" 24 24 24 ;
createNode mesh -n "pPlaneShape1" -p "pPlane1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".ns" 1;
	setAttr ".nts" -type "string" "Please look at transform1 > heightField1 for notes.";
createNode transform -n "transform1";
	addAttr -ci true -h true -sn "dfm" -ln "miDeriveFromMaya" -dv 1 -min 0 
		-max 1 -at "bool";
	addAttr -ci true -sn "hde" -ln "miHide" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "vsb" -ln "miVisible" -dv 2 -at "short";
	addAttr -ci true -sn "trc" -ln "miTrace" -dv 2 -at "short";
	addAttr -ci true -sn "shd" -ln "miShadow" -dv 2 -at "short";
	addAttr -ci true -sn "cst" -ln "miCaustic" -dv 5 -at "short";
	addAttr -ci true -sn "glb" -ln "miGlobillum" -dv 5 -at "short";
	addAttr -ci true -sn "mieg" -ln "miExportGeoShader" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "migs" -ln "miGeoShader" -at "message";
	setAttr ".t" -type "double3" 0 10.736839368534051 0 ;
	setAttr ".s" -type "double3" 24 24 24 ;
createNode heightField -n "heightField1" -p "transform1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".res" 100;
	setAttr ".hc" 0.05000000074505806;
	setAttr ".nts" -type "string" (
		"Preset Goal: \r\n"
		+ "To visualize a terrain created by displacement by a painted displacement map. \r\n"
		+ "\r\n"
		+ "Basic Construction:\r\n"
		+ "You can use Texture> 3D Paint Tool to paint displacment on the poly surface or you can follow the instructions below to create your own setup for showing displacement interactively. You must do a File> Save to see the plane update if you paint displacment with 3D paint.\r\n"
		+ "\r\n"
		+ "Usually, the only way to see displacement in Maya is to render or convert the displacement to polies. This new method allows you to see the displacment of a terrain like object interactively with a height field. Maya usually uses height fields to show ocean previews and allows any 2D fluid to display as a height field. The latter case doesn't actaully use a height field node.\r\n"
		+ "\r\n"
		+ "First you need to have a displacement assigned to the shading group of the surface. The file node created when you assign a texture, will be the one to connect to the height field node. You can assign any file for displacment or you can paint it directly from Texture> 3D Paint Tool, and use displacment. Don't forget to Assign/Edit texture in the 3d paint tool if no texture exists initially.  \r\n"
		+ "\r\n"
		+ "There are two ways to make the height field node. Interactively you can create an ocean shader and then ask for Fluid Effects> Ocean> Add Preview Plane. The preview plane is a height field. Now delete the ocean shader in Hypershade, and keep the preview plane. The other way to create the height field is simpler but uses mel. Use the command...\r\n"
		+ "\r\n"
		+ "createNode heightField; \r\n"
		+ "\r\n"
		+ "...in the script editor. This leaves the new height field transform selected. Select its shape instead (press the down arrow on the keyboard or get it in the outliner or hypergraph). The attribute editor won't change when you do this. Now we'll connect the parameters between the two nodes to allow the height field to show the displaement. \r\n"
		+ "\r\n"
		+ "With the height field shape selected, open Windows> General Editors> Connection Editor. Load the selected height field on the right side of the editor. Now go and pick the file node for the map that is being used for displacement. Load it on the left side. Click on the parameter Out Alpha on the left side (file node) and the parameter Displacement on the right side (height field shape). The Out Alpha for the displacement map now drives the height field. You could also use the Out Colour R from the file node instead. You should see the height field approximating the displacement, but chances are the height field is the wrong size and scale for the surface. \r\n"
		+ "\r\n"
		+ "Scale up the height field to match the size of the surface and place it near the surface. Make sure you leave the y scale of the height field at 1.  This will give the correct size of the displacment. You can exagerate this with the Height Scale parameter of the height field. Take a look at the Attribute Editor for the height field shape to see the parameters. The resolution of the field controls the amount of detail you will see in the displacement, and also effects interactive performance. You probably have to turn it up to see a reasonable amount of detail.\r\n"
		+ "\r\n"
		+ "Finner Points:\r\n"
		+ "Upon saving the maya file, the 3D paint image will be saved and the displacement updated. \r\n"
		+ "If you are painting the displacement image outside of maya, reload the texture off the file node to see it update in maya.\r\n"
		+ "Render time: not applicable.\r\n");
createNode transform -n "directionalLight1";
	setAttr ".t" -type "double3" -2.4927137440454645 12.295935170804627 0.56932864582767273 ;
	setAttr ".r" -type "double3" -72.502756666422485 38.890318714050096 55.030721962660621 ;
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
createNode polyPlane -n "polyPlane1";
	setAttr ".sw" 3;
	setAttr ".sh" 3;
createNode materialInfo -n "materialInfo1";
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lambert -n "PaintedPlane";
createNode file -n "file1";
	setAttr ".ftn" -type "string" "E:/maya/projects/5_Presets//3dPaintTextures";
createNode place2dTexture -n "place2dTexture3";
createNode displacementShader -n "displacementShader1";
createNode displayLayer -n "HeightField";
	setAttr ".c" 19;
	setAttr ".do" 1;
createNode displayLayerManager -n "layerManager";
	setAttr -s 2 ".dli[1]"  1;
	setAttr -s 2 ".dli";
createNode lightLinker -n "lightLinker1";
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
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
select -ne :defaultRenderGlobals;
	addAttr -ci true -sn "currentRenderer" -ln "currentRenderer" -dt "string";
	setAttr ".pfm" -type "string" "";
	setAttr ".oft" -type "string" "";
	setAttr ".prm" -type "string" "";
	setAttr ".pom" -type "string" "";
	setAttr ".currentRenderer" -type "string" "mayaSoftware";
select -ne :defaultLightSet;
connectAttr "polyPlane1.out" "pPlaneShape1.i";
connectAttr "HeightField.di" "transform1.do";
connectAttr "HeightField.di" "heightField1.do";
connectAttr "file1.ocr" "heightField1.dis";
connectAttr "lambert2SG.msg" "materialInfo1.sg";
connectAttr "PaintedPlane.oc" "lambert2SG.ss";
connectAttr "pPlaneShape1.iog" "lambert2SG.dsm" -na;
connectAttr "displacementShader1.d" "lambert2SG.ds";
connectAttr "file1.oc" "PaintedPlane.c";
connectAttr "place2dTexture3.c" "file1.c";
connectAttr "place2dTexture3.tf" "file1.tf";
connectAttr "place2dTexture3.rf" "file1.rf";
connectAttr "place2dTexture3.mu" "file1.mu";
connectAttr "place2dTexture3.mv" "file1.mv";
connectAttr "place2dTexture3.s" "file1.s";
connectAttr "place2dTexture3.wu" "file1.wu";
connectAttr "place2dTexture3.wv" "file1.wv";
connectAttr "place2dTexture3.re" "file1.re";
connectAttr "place2dTexture3.of" "file1.of";
connectAttr "place2dTexture3.r" "file1.ro";
connectAttr "place2dTexture3.n" "file1.n";
connectAttr "place2dTexture3.vt1" "file1.vt1";
connectAttr "place2dTexture3.vt2" "file1.vt2";
connectAttr "place2dTexture3.vt3" "file1.vt3";
connectAttr "place2dTexture3.vc1" "file1.vc1";
connectAttr "place2dTexture3.o" "file1.uv";
connectAttr "place2dTexture3.ofs" "file1.fs";
connectAttr "file1.oa" "displacementShader1.d";
connectAttr "layerManager.dli[1]" "HeightField.id";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "lambert2SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "PaintedPlane.msg" ":defaultShaderList1.s" -na;
connectAttr "displacementShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "heightField1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "file1.msg" ":defaultTextureList1.tx" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of ShowDisplace.ma
