# This command should be called before doing a mentalray render.
# It creates the necessary geoshader shadow objects under the xgmr namespace.

import sys
import os.path
import maya.api.OpenMaya as om
import maya.OpenMayaAnim as oma
import maya.cmds as cmds
from xgenm import XgExternalAPI as xgapi
import xgenm as xg
import xgenm.xmaya.xgmExternalAPI as xgmExternalAPI

# using the Maya Python API 2.0.
def maya_useNewAPI():
    pass

# checks if a mental shader node is registered.
def isShaderRegistered( shaderName ):   
    findIndex = -1
    try:
        dn = cmds.pluginInfo( "Mayatomr", query=True, dependNode=True )
        if dn:
            findIndex = dn.index( shaderName )
    except:
        pass

    return findIndex!=-1

def getRulePath( ruleName ):
    projPath = cmds.workspace( q=True, fullName=True )
    listRules = cmds.workspace( q=True, fr=True )
    listRulesNames = listRules[::2]
    listRulesValues = listRules[1::2]
    try:
        return projPath + "/" +listRulesValues[ listRulesNames.index( ruleName ) ][0:-1]
    except:
        return ""

# Main Update function
def updateXgenMentalray( in_desc, in_pal, in_updateExisting ):

    # Before doing anything, make sure the xgen geoshader is registered.
    if not isShaderRegistered( "xgen_geo" ):
        #xgapi.XGError( "Couldn't update the xgen mental ray geoshaders. The 'xgen_geo' shader node isn't registered. Make sure Mayatomr plugin is loaded and that xgenMR.so/xgenMR.mi registers without errors." )
        return False

    currentSel=cmds.ls(selection=True)

    xgenNS = "xgmr"

    # Get strings based on the current scene name.
    strCurrentScene = cmds.file( q=True, sn=True )
    if len(strCurrentScene)>0:
        strScenePath = os.path.dirname( strCurrentScene )
    else:
        strScenePath = getRulePath( 'scene' )
        strCurrentScene = strScenePath + "/untitled.tmp" 
    strScenePath = strScenePath.replace( "\\", "/" )

    # Replace with XGEN_ROOT environment variable if the base path matches
    xgdatapath = "${XGEN_ROOT}"
    strXGenDataPath = os.path.expandvars(xgdatapath)
    strXGenDataPath = strXGenDataPath.replace( "\\", "/" )
    strXGenDataPathDotDot = ""
    rIndex = strXGenDataPath.rfind('/')
    if rIndex>1:
        strXGenDataPathDotDot = strXGenDataPath[0:rIndex]

    if strScenePath.startswith( strXGenDataPath ):
        strScenePath = xgdatapath + strScenePath[ len(strXGenDataPath): ]
    elif strScenePath.startswith( strXGenDataPathDotDot ):
        strScenePath = xgdatapath + "/.." + strScenePath[ len(strXGenDataPathDotDot): ]

    strSceneFile = os.path.basename( strCurrentScene )
    strSceneName = os.path.splitext( strSceneFile )[0];
    #print strCurrentScene
    #print strScenePath
    #print strSceneFile
    #print strSceneName

    # Get current units
    def getCurrentUnits():
    #{
        strCurrentUnits = cmds.currentUnit( q=True, linear=True );

        it = ["",1.0]
        if strCurrentUnits   == "in" : it = [ "2.54", 2.54 ]
        elif strCurrentUnits == "ft" : it = [ "30.48", 30.48 ]
        elif strCurrentUnits == "yd" : it = [ "91.44", 91.44 ]
        elif strCurrentUnits == "mi" : it = [ "160934.4", 160934.4 ]
        elif strCurrentUnits == "mm" : it = [ "0.1", 0.1 ]
        elif strCurrentUnits == "km" : it = [ "100000.0", 100000. ]
        elif strCurrentUnits == "m":  it = [ "100.0", 100. ]
        elif strCurrentUnits == "dm" : it = [ "10.0", 10. ]

        return it;
    #}
    unitsConv = getCurrentUnits()
    #print unitsConv

    # Gather all the descriptions from the scene
    descriptions = cmds.ls( exactType="xgmDescription" )
    for d in range( len(descriptions) ):
        descShape = descriptions[d]
        descriptions[d]=descShape[0:len(descShape)-len("Shape")]

    # Holds Description Information
    class DescInfo:
        strScene = ""
        strPalette = ""
        strDescription = ""
        strFramePerSecond = "0"
        vecPatches = []
        fFrame = 1.0
        bCameraOrtho = False
        fCameraPos = [0,0,0]
        fCameraFOV = 45.0
        fCameraInvMat = [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]
        fCamRatio = 1.0
        fBoundingBox = [0,0,0,0,0,0]

        def setBoundingBox( self, xmin, ymin, zmin, xmax, ymax, zmax ):
            self.fBoundingBox[0] = xmin
            self.fBoundingBox[1] = ymin
            self.fBoundingBox[2] = zmin
            self.fBoundingBox[3] = xmax
            self.fBoundingBox[4] = ymax
            self.fBoundingBox[5] = zmax

        def setCameraPos( self, x, y, z ):
            self.fCameraPos[0] = x
            self.fCameraPos[1] = y
            self.fCameraPos[2] = z

        def setCameraInvMat( self, m00, m01, m02, m03, m10, m11, m12, m13, m20, m21, m22, m23, m30, m31, m32, m33 ):
            self.fCameraInvMat[ 0] = m00
            self.fCameraInvMat[ 1] = m01
            self.fCameraInvMat[ 2] = m02
            self.fCameraInvMat[ 3] = m03
            self.fCameraInvMat[ 4] = m10
            self.fCameraInvMat[ 5] = m11
            self.fCameraInvMat[ 6] = m12
            self.fCameraInvMat[ 7] = m13
            self.fCameraInvMat[ 8] = m20
            self.fCameraInvMat[ 9] = m21
            self.fCameraInvMat[10] = m22
            self.fCameraInvMat[11] = m23
            self.fCameraInvMat[12] = m30
            self.fCameraInvMat[13] = m31
            self.fCameraInvMat[14] = m32
            self.fCameraInvMat[15] = m33

    # Create a geometry shader node and set it's value to match the description.
    def createDescriptionGeoShader( in_name ):
    #{
        #print "createDescriptionGeoShader " + in_name
        # Gather info from the description
        info = DescInfo()
        info.strDescription = in_name
        info.strPalette = cmds.listRelatives ( info.strDescription, parent=True )[0]
        info.vecPatches = cmds.listRelatives ( info.strDescription, fullPath=True, children=True )[1:]
        info.strScene = strScenePath + '/' + strSceneName
        info.fFrame = cmds.currentTime(q=1)
        mTime = om.MTime(1.0, oma.MAnimControl.currentTime().unit())
        fps = 1/mTime.asUnits(om.MTime.kSeconds)
        info.strFramePerSecond = str(fps)

        # Hardcoded values for now. The camera is only used to perform camera geometry culling at render time.
        # It won't be usefull when doing raytracing and since our geoshader uses assemblies, geometry will only expand as needed.
        s = 10000.0 * unitsConv[1]
        info.setBoundingBox( -s,-s,-s, s, s, s )
        info.bCameraOrtho = False
        info.setCameraPos( -48.4233, 29.8617, -21.2033 )
        info.fCameraFOV = 54.432224
        info.setCameraInvMat( -0.397148,0.446873,0.80161,0,5.55112e-17,0.873446,-0.48692,0,0.917755,0.193379,0.346887,0,0.228188,-0.343197,60.712,1 )
        info.fCamRatio = 1.0

        # The geom cache file should contain all the patches the palette uses.
        # Xgen gives an error if a patch used in the palette isn't found: Caf error. No geometry named 'pPlane1' found in caf file(frame):
        strGeomFile = info.strScene + "__" + xgmExternalAPI.encodeNameSpace(str(info.strPalette)) + ".abc";

        # Create a geoshader and dummy shape for the descripion, with a list of patches
        strPatches = ""
        for (index, i) in enumerate(info.vecPatches):
            patchShapes = cmds.listRelatives ( i, shapes=True, typ=["xgmSubdPatch","xgmNurbsPatch"] )
            if patchShapes and len(patchShapes):
                # strip namespace from description name
                baseDesc = xg.stripNameSpace(str(info.strDescription))
                shapeName = i.split('|')[-1]
                strPatch = shapeName[0:len(shapeName)- (len(baseDesc) + 1)]
                if len(strPatches) == 0:
                    strPatches =  xg.stripNameSpace(str(strPatch))
                else:
                    strPatches = strPatches + " " +  xg.stripNameSpace(str(strPatch))

        def getSGsFromObj( obj ):
            '''Lists the shading groups applied to the object'''
            shadingEngines = []
            if cmds.objExists(obj) :
                shapes = cmds.listRelatives( obj, shapes=True )
                if shapes:
                    for shape in shapes:
                        if cmds.objExists(shape) :
                            dest = cmds.listConnections( shape, destination=True, source=False, plugs=False, type="shadingEngine" )
                            if dest and len(dest):
                                select = cmds.ls( sl=True )
                                cmds.select( dest, r=True, ne=True )
                                shapeSGs = cmds.ls( sl=True )
                                shadingEngines = shadingEngines + shapeSGs
                                if select == []:
                                    cmds.select( cl=True )
                                else:
                                    cmds.select( select, r=True )
            return shadingEngines


        # Build the data argument
        strData =  "-debug 1 -warning 1 -stats 1 "
        strData += " -shutter 0.0"
        strData += " -file \"" + info.strScene + "__" + info.strPalette.replace( ":", "__" ) + ".xgen\""
        strData += " -palette " +  xg.stripNameSpace(str(info.strPalette))
        nsIndex = info.strPalette.rfind(":")
        if nsIndex > 0:
            strData += " -nameSpace " + info.strPalette[0:nsIndex]
        strData += " -geom \"" + strGeomFile + "\""
        strData += " -patch ${PATCH} " # We'll replace that string in the data string using the patch list in the mental ray geoshader.
        strData += " -description " + xg.stripNameSpace(str(info.strDescription))
        strData += " -fps " + info.strFramePerSecond
        strData += unitsConv[0]

        # Create,Replace or Update the geoshader
        # If it exists, keep it's shading group
        nExistsName = ""
        objs = cmds.listRelatives ( info.strPalette + "|" + info.strDescription, fullPath=True, children=True, typ=["transform"] )
        n = xgenNS + ":geoshader"
        # search the geoshader node which may have extra namespace
        for obj in objs:
            if obj.endswith(n):
                nExistsName = obj
                break
        sg = []
        
        nExists = cmds.objExists( nExistsName )

        if in_updateExisting:
            if nExists:
                cnx = cmds.listConnections(nExistsName + ".miGeoShader")
                if cnx and len(cnx)==1:# Please keep this strings unlocalized
                    # Update the data string
                    # This is done before saving to keep the connection to the .xgen file
                    dataAttr = cnx[0] + ".data"
                    cmds.setAttr( dataAttr, strData, typ="string" )
                    
                    # Update the bound patches after modify binding
                    patchesAttr = cnx[0] + ".patches"
                    cmds.setAttr( patchesAttr, strPatches, type="string" )
                return True
            else:
                return False

        # A geoshader object already exists.
        elif nExists:
            sg = getSGsFromObj( nExistsName ) 
            cmds.delete( nExistsName, hi="both" )
       
        n = cmds.polyCube( name=n, w=0.001, h=0.001, d=0.001, sx=1, sy=1, sz=1, ax=(0,1,0), cuv=4, ch=0 )[0]

        # Nest it under description. That way when the description is deleted it will be deleted as well.
        # If a description is renamed, the script would need to be re-executed. Same if new patches are added/removed.
        n = cmds.parent( n, info.strPalette + "|" + info.strDescription )[0]

        # Force some flags
        # cmds.setAttr( n + ".visibility", 0 )
        cmds.setAttr( n + ".miExportGeoShader", 1 )
        cmds.setAttr( n + ".miDeriveFromMaya", 0 )
        cmds.setAttr( n + ".miVisible", 1 )
        cmds.setAttr( n + ".miTrace", 1 )
        cmds.setAttr( n + ".miShadow", 1 )
        cmds.setAttr( n + ".miCaustic", 4 )
        cmds.setAttr( n + ".miGlobillum", 4 )

        if len(sg)==0:
            sg = getSGsFromObj(info.strDescription)
        if len(sg)==1 :
            cmds.sets( n, forceElement=sg[0] )

        # Create an xgen_geo geometry shader and connect it to the instance
        shaderName = xgenNS + ":xgen_geo1"
        shaderName = cmds.shadingNode( "xgen_geo", asUtility=True, name=shaderName )
        cmds.connectAttr( shaderName + ".outValue", n + ".miGeoShader", force=True )

        # Create an expression to link the frame from the geoshader to the maya time.
        cmds.expression( s= shaderName + ".frame = frame ;", o=shaderName, ae=1, uc=all )

        # Set data string on the geoshader
        cmds.setAttr( shaderName + ".data", strData, type="string" )
        cmds.setAttr( shaderName + ".patches", strPatches, type="string" )

        def buildFloatArrayString( a, startQuote=True, endQuote=True ):
            r = ""
            if startQuote : r += "\""
            sa = len(a)
            for i in range(sa):
                r += str(a[i])
                if i!=sa-1 : r += ","
            if endQuote : r += "\""
            return r
        def buildFloatString( f ):
            r = "\""
            r += str(f)
            r += "\""
            return r

        # Build the user argument
        strUser =  "irRenderCam \"false," + buildFloatArrayString(info.fCameraPos, False)
        strUser +=  " irRenderCamFOV " + buildFloatString(info.fCameraFOV)
        strUser +=  " irRenderCamRatio " + buildFloatString(info.fCamRatio)
        strUser +=  " irRenderCamXform " + buildFloatArrayString(info.fCameraInvMat)
        cmds.setAttr( shaderName + ".user", strUser, type="string" )

    #}
    # Create all our descriptions geoshader
    for i in descriptions:
        if in_desc=="" or in_desc==i:
            createDescriptionGeoShader( i )

    # Add a callback to push live data to xgen at render time
    def addPushDataCallBack( name ):
    #{# Please keep this strings unlocalized
        value = cmds.getAttr( "defaultRenderGlobals.preMel" )
        
        if str(value) == "None":
            value = ""
            
        if value.find("XgPreRendering;") == -1:
            if len(value) != 0:
                value = value + "; "
            value = value + "XgPreRendering;"            
            cmds.setAttr( "defaultRenderGlobals.preMel", str(value), type= 'string' )
    #}
    for i in descriptions:
        addPushDataCallBack( i );

    # Restore original selection
    if len(currentSel):
        cmds.select( currentSel, replace=True )
    else:
        cmds.select( clear=True )

    return True
#}

def xgmrSyntaxCreator():
    syntax = om.MSyntax()
    syntax.addFlag( xgmrCmd.kSetupGeoShaderShort, xgmrCmd.kSetupGeoShaderLong )
    syntax.addFlag( xgmrCmd.kUpdateGeoShaderShort, xgmrCmd.kUpdateGeoShaderLong )
    syntax.addFlag( xgmrCmd.kDescriptionShort, xgmrCmd.kDescriptionLong, [om.MSyntax.kString] )
    syntax.addFlag( xgmrCmd.kPaletteShort, xgmrCmd.kPaletteLong, [om.MSyntax.kString] )
    syntax.addFlag( xgmrCmd.kApplyShaderShort, xgmrCmd.kApplyShaderLong, [om.MSyntax.kString] )
    return syntax

def xgmrDefaultHairShader( desc, pal ):
    if not isShaderRegistered( "xgen_hair_physical" ):
        return None

    sel=cmds.ls(selection=True) 

    # create xgen_hair_physical shader node only for spline primitive
    primType = xgapi.getActive( str(pal), str(desc), 'Primitive' )
    if 'SplinePrimitive' == primType:
        xgen_hairSG = cmds.createNode( "shadingEngine", n="xgen_hair_physicalSG" )
        cmds.setAttr( ".ihi", 0 )
        cmds.setAttr( ".dsm", s=3 )
        cmds.setAttr( ".ro", True )

        xgen_hair_physical = cmds.createNode( "xgen_hair_physical", n="xgen_hair_physical" )

        cmds.connectAttr( xgen_hair_physical+".outValue", xgen_hairSG+".ss")
        cmds.connectAttr( xgen_hair_physical+".outValue", xgen_hairSG+".miMaterialShader")


        cmds.relationship( "link", ":lightLinker1", xgen_hairSG+".message", ":defaultLightSet.message" )
        cmds.relationship( "shadowLink", ":lightLinker1", xgen_hairSG+".message", ":defaultLightSet.message" )

        cmds.connectAttr( xgen_hairSG+".pa", ":renderPartition.st", na=True )
        cmds.connectAttr( xgen_hair_physical+".msg", ":defaultShaderList1.s", na=True )
    else:
        xgen_hairSG = "initialShadingGroup"    

    # Apply the shading group on selection
    try:
        cmds.select( clear=True )
        shapes = cmds.listRelatives(str(desc), shapes=True, fullPath=True)
        xgenMRMesh = cmds.listRelatives(str(desc), allDescendents=True, type="mesh", fullPath=True)
        cmds.select( str(shapes[0]), replace=True )  # xgmDescription node
        cmds.select(xgenMRMesh, add=True)            # mesh for mental ray rendering
        cmds.sets( e=True, forceElement=xgen_hairSG )
    except Exception as e:
        print str(e)
        
    # Restore original selection
    if len(sel):
        cmds.select( sel, replace=True )
    else:
        cmds.select( clear=True )

    # Pop the attribute editor on the new shading group
    #mel.eval( "showShadingGroupAE \""+xgen_hairSG+"\";")

    return xgen_hairSG;

# command
class xgmrCmd(om.MPxCommand):
    kPluginCmdName = "xgmr"

    kSetupGeoShaderShort = "-sgs"
    kSetupGeoShaderLong = "-setupGeometryShader"
    kUpdateGeoShaderShort = "-ugs"
    kUpdateGeoShaderLong = "-updateGeometryShader"

    kDescriptionShort = "-dsc"
    kDescriptionLong = "-description"
    kPaletteShort = "-pal"
    kPaletteLong = "-palette"

    kApplyShaderShort = "-as"
    kApplyShaderLong = "-applyShader"

    def __init__(self):
        om.MPxCommand.__init__(self)
        self.desc = ""
        self.pal = ""

    @staticmethod
    def creator():
        return xgmrCmd()

    def doIt(self, args):
        argData = om.MArgParser( self.syntax(), args )

        if argData.isFlagSet( xgmrCmd.kDescriptionShort ):
            self.desc = argData.flagArgumentString( xgmrCmd.kDescriptionShort, 0 )
        if argData.isFlagSet( xgmrCmd.kPaletteShort ):
            self.pal = argData.flagArgumentString( xgmrCmd.kPaletteShort, 0 )

        if argData.isFlagSet( xgmrCmd.kSetupGeoShaderShort ):
            updateXgenMentalray( self.desc, self.pal, False )
        elif argData.isFlagSet( xgmrCmd.kApplyShaderShort ):
            presetName = argData.flagArgumentString( xgmrCmd.kApplyShaderShort, 0 )
            if presetName=="hair":
                xgmrDefaultHairShader( self.desc, self.pal )
        elif argData.isFlagSet( xgmrCmd.kUpdateGeoShaderShort ):
            updateXgenMentalray( self.desc, self.pal, True )
 
        


# Initialize the plug-in
def initializePlugin(plugin):
    
    # Install XGen UI callbacks to extend the Render UI.
    xg.registerCallback( "RenderAPIRendererTabUIInit", "xgenm.ui.tabs.xgenMRUI.xgmrUI" )
    xg.registerCallback( "RenderAPIRendererTabUIRefresh", "xgenm.ui.tabs.xgenMRUI.xgmrRefresh" )
    xg.registerCallback( "PostDescriptionCreate", "xgenm.ui.tabs.xgenMRUI.xgmrOnCreateDescription" )
    xg.registerCallback( "ArchiveExport", "xgenm.xmaya.xgenMRExport.xgmrArchiveExport" )
    xg.registerCallback( "ArchiveExportInfo", "xgenm.xmaya.xgenMRExport.xgmrArchiveExportInfo" )
    xg.registerCallback( "ArchiveExportInit", "xgenm.xmaya.xgenMRExport.xgmrArchiveExportInit" )

    pluginFn = om.MFnPlugin(plugin,"Autodesk","1.0","Any")
    try:
        pluginFn.registerCommand(
            xgmrCmd.kPluginCmdName, xgmrCmd.creator, xgmrSyntaxCreator
        )
    except:
        sys.stderr.write(
            "Failed to register command: %s\n" % xgmrCmd.kPluginCmdName
        )
        raise


# Uninitialize the plug-in
def uninitializePlugin(plugin):
    xg.deregisterCallback( "RenderAPIRendererTabUIInit", "xgenm.ui.tabs.xgenMRUI.xgmrUI" )
    xg.deregisterCallback( "RenderAPIRendererTabUIRefresh", "xgenm.ui.tabs.xgenMRUI.xgmrRefresh" )
    xg.deregisterCallback( "PostDescriptionCreate", "xgenm.ui.tabs.xgenMRUI.xgmrOnCreateDescription" )
    xg.deregisterCallback( "ArchiveExport", "xgenm.xmaya.xgenMRExport.xgmrArchiveExport" )
    xg.deregisterCallback( "ArchiveExportInfo", "xgenm.xmaya.xgenMRExport.xgmrArchiveExportInfo" )
    xg.deregisterCallback( "ArchiveExportInit", "xgenm.xmaya.xgenMRExport.xgmrArchiveExportInit" )

    pluginFn = om.MFnPlugin(plugin)
    try:
        pluginFn.deregisterCommand(xgmrCmd.kPluginCmdName)
    except:
        sys.stderr.write(
            "Failed to unregister command: %s\n" % xgmrCmd.kPluginCmdName
        )
        raise
#-
# ==========================================================================
# Copyright (C) 2012 Autodesk, Inc. and/or its licensors.  All
# rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its
# licensors, which is protected by U.S. and Canadian federal copyright
# law and by international treaties.
#
# The Data is provided for use exclusively by You. You have the right
# to use, modify, and incorporate this Data into other products for
# purposes authorized by the Autodesk software license agreement,
# without fee.
#
# The copyright notices in the Software and this entire statement,
# including the above license grant, this restriction and the
# following disclaimer, must be included in all copies of the
# Software, in whole or in part, and all derivative works of
# the Software, unless such copies or derivative works are solely
# in the form of machine-executable object code generated by a
# source language processor.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
# AUTODESK DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED
# WARRANTIES INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF
# NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR
# PURPOSE, OR ARISING FROM A COURSE OF DEALING, USAGE, OR
# TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS LICENSORS
# BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK
# AND/OR ITS LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY
# OR PROBABILITY OF SUCH DAMAGES.
#
# ==========================================================================






