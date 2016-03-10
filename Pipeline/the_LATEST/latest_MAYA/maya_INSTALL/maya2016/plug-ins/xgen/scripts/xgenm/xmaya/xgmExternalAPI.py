# Copyright (C) 1997-2013 Autodesk, Inc., and/or its licensors.
# All rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its licensors,
# which is protected by U.S. and Canadian federal copyright law and by
# international treaties.
#
# The Data is provided for use exclusively by You. You have the right to use,
# modify, and incorporate this Data into other products for purposes authorized 
# by the Autodesk software license agreement, without fee.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. AUTODESK
# DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
# INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
# OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS
# LICENSORS BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK AND/OR ITS
# LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.
import maya
maya.utils.loadStringResourcesForModule(__name__)


##
# @file xgmExternalAPI.py
# @brief Contains the python procedures for external API.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Thomas V Thompson II
# @author Ying Liu
#
# @version Created 08/22/08
#

__all__ = [
    'createDescription','deletePalette','deleteDescription','setAttr',
    'addCustomAttr','remCustomAttr','setActive','initInterpolation',
    'addFXModule','removeFXModule','moveFXModule',
    'importPalette','exportPalette','applyDelta','importBindPalette',
    'importDescription','exportDescription','exportDescriptionAsPreset',
    'importBindDescription', 'importDescriptionAsPreset',
    'importFXModule','exportFXModule',
    'setMessageLevel',
    'guidePatch','guideDescription','guideIndex',
    'descriptionGuides','descriptionPatches','palettePatches',
    'geometryPatches','geometriesPatches','geometryDescriptionPatch',
    'geometryFacePatches',
    'modifyFaceBinding','fixPatchNames','nodeClass','renderable',
    'selectionToggle','toggleGuideDisplay','toggleGuideReference',
    'findSelectedPatches','bakedGroomManagerBake','setExportAsDelta',
    'forcePointsRedraw','selectionChangedCB',
    'getOptionVar','setOptionVarInt','setOptionVarFloat','setOptionVarString',
    'getOptionVarInt','getOptionVarFloat','getOptionVarString',
    'toQtWidget', 'igDescription', 'igGetAttrValues', 'igSetAttrValues', 'selectionNameSpaces', 'selectionCount'
    ,'createBindDescription'
    ,'mayaShapeAttrName'
    ,'createMayaAttr'
    ,'copyFileToNewDir'
    ,'buildFileName'
    ,'validateDescription' 
    ,'ADD_TO_NEW_PALETTE'
    ,'ADD_TO_EXISTING_PALETTE'
    ,'VALIDATE_DESC_NAME'
    ,'VALIDATE_PALETTE_NAME'
    ,'paletteRootPath'
    ,'paletteRootVar'
    ,'palettePath'
    ,'renamePalette'
    ,'encodeNameSpace'
    ,'decodeNameSpace'
    ,'descriptionFolderNames'
    ,'paletteFolderNames'
    ,'xgenProjectPath'
    ,'xgenProjectVar'
    ,'descriptionPath'
    ,'renameDescription'
    ,'buildPaletteName'
    ,'buildDescriptionName'
    ,'igCurrentDescription'
    ,'igGetDescriptionVisibility'
    ,'igSetDescriptionVisibility'
    ,'igMakeCurrentDescriptionVisible'
    ,'igSetCurrentDescription'
    ,'igActivateDescription'
    ,'igDescriptionTpu'
    ,'igSyncMaps'
    ,'igExportMaps'
    ,'getAttrValues'
    ,'getAttrValue'
    ,'setAttrValues'
    ,'setAttrValue'
    ,'hasAttr'
    ,'igForceExport'
    ,'setProjectPath'
    ,'undoable'
]

import string
import re
import os
import shiboken
from PySide import QtGui, QtCore
from contextlib import contextmanager

# Import the maya python commands
import maya.cmds as cmds
import maya.mel as mel
import maya.OpenMayaUI as mui

# Import the api into the base namespace and into this namespace. This lets
# us reference it within our wrappers but also reference members not wrapped.
import xgenm as xg
import xgenm.xgGlobal as xgg
import xgenm.XgExternalAPI as base
import xgenm.xgUtil as xgutil
from xgenm.XgExternalAPI import *

# For description/palette creation and validation
ADD_TO_NEW_PALETTE = 1
ADD_TO_EXISTING_PALETTE = 2
VALIDATE_DESC_NAME = 3
VALIDATE_PALETTE_NAME = 4

#store tags used for forcing the export of igroom maps
_igForceExportTags = set()

errWrapXgenDesc = maya.stringTable['y_xgmExternalAPI.kXgmExtAPIErrWrapXgenDesc' ]
errWrapXgenDeleteDesc = maya.stringTable['y_xgmExternalAPI.kXgmExtAPIErrWrapXgenDeleteDesc' ]

def mayaShapeAttrName( shapeAttrName, cpal="", cdesc="" ):
    if not xgg.Maya:
        return ""

    if len(cpal) == 0:
        cpal = xgg.DescriptionEditor.currentPalette()
    if len(cdesc) == 0:
        cdesc = xgg.DescriptionEditor.currentDescription()

    newName = encodeNameSpace(cpal) + "_" + encodeNameSpace(cdesc) + "_" + shapeAttrName

    # force it to be alphanumeric with '_' characters
    re.sub(r'\W+', '', newName )
    return newName

def createMayaAttr( defaultAttrValue, shapeAttrName, cpal="", cdesc="" ):

    if not xgg.Maya:
        return

    if len(cpal) == 0:
        cpal = xgg.DescriptionEditor.currentPalette()
    if len(cdesc) == 0:
        cdesc = xgg.DescriptionEditor.currentDescription()

    # for each shape, create a float attribute named palette_description_attr
    shapeAttrName = mayaShapeAttrName( shapeAttrName, cpal, cdesc )
    geoms = xg.boundGeometry(cpal,cdesc)
    for geom in geoms:
        shapeChildren = cmds.listRelatives( geom, shapes=True )
        shapeAttrName2 = shapeChildren[0] + "." + shapeAttrName

        if( not cmds.objExists( shapeAttrName2 ) ):

            if( len( defaultAttrValue ) == 3 ):
                cmds.addAttr( shapeChildren[0], longName=shapeAttrName, attributeType="float3" ) 
                cmds.addAttr( shapeChildren[0], longName=(shapeAttrName+"X"), attributeType="float", parent=shapeAttrName ) 
                cmds.addAttr( shapeChildren[0], longName=(shapeAttrName+"Y"), attributeType="float", parent=shapeAttrName ) 
                cmds.addAttr( shapeChildren[0], longName=(shapeAttrName+"Z"), attributeType="float", parent=shapeAttrName ) 

                try:
                    cmds.setAttr( (shapeAttrName2+"X"), float( defaultAttrValue[0] ) )
                    cmds.setAttr( (shapeAttrName2+"Y"), float( defaultAttrValue[1] ) )
                    cmds.setAttr( (shapeAttrName2+"Z"), float( defaultAttrValue[2] ) )
                except ValueError:
                    pass
            else:
                cmds.addAttr( shapeChildren[0], longName=shapeAttrName, attributeType="float" ) 

                try:
                    cmds.setAttr( shapeAttrName2, float( defaultAttrValue[0] ) )
                except ValueError:
                    pass

    return shapeAttrName

def _setupProject( palette, newDesc='' ):
    """ helper for setting up palette and description(s) at creation time """
    # set the palette project with the current project path
    base.setAttr( 'xgProjectPath', base.getProjectPath(), palette )

    # create the palette folder 
    palFolder = palettePath(palette)
    base.expandFilepath( palFolder, newDesc, True, True )            

    # store the unresolved version
    palFolder = palettePathVar(palette)
    base.setAttr( 'xgDataPath', palFolder, palette )

    # setup the description folder
    _setupDescriptionFolder( palette, newDesc )

def _setupDescriptionFolder( palette, newDesc='' ):
    """ create the description folders """
    descrs = None
    if len(newDesc):
        descrs = [newDesc]
    else:
        descrs = base.descriptions( palette )

    for desc in descrs:
        descFolderPath = descriptionPath( palette, desc )
        descFolderPath = base.expandFilepath( descFolderPath, desc, True, True )

        # put the new desc folder path in the tracker for future cleanup
        xgg.FolderTracker.desc().add( descFolderPath )            

def _createDescription( palette, description, primitive, generator, renderer, method, grooming ):
    """Internal function to create a new description with specified objects. The function supports
    the creation of igroom decriptions. The xgDataPath + xgProjectPath attributes are set on the 
    palette owner with the palette folder. """
    newDesc = base.createDescription( palette, description, primitive, generator, renderer, method )
    if newDesc == "":
        return newDesc

    # set the palette and description with current project
    _setupProject( palette, newDesc )

    # create the maya node wrapper for the xgen palette, description and groom description 
    wrapCmd = 'xgmWrapXGen -pal "'+palette+'" -d "'+newDesc+'"'

    if grooming:
        wrapCmd += ' -g'

    try:
        mel.eval( wrapCmd )
    except:
        XGError(errWrapXgenDesc + newDesc)
        XGError(errWrapXgenDeleteDesc)
        deleteDescription( palette, newDesc )
        return ""

    return newDesc


##
# Override any api methods that modify the underlying xgen data. We must
# do this to flag maya that the scene is dirty (modified) even though nothing
# that maya can track has been changed. If we didnt handle this then maya
# would not let us save our scene unless we make some maya visible change.


def createDescription( palette, description, primitive, generator, renderer, method ):
    """Create a new description with specified objects.

    This will create a new description and place it within the named
    palette. If the palette does not exist then it too will be created.
    """
    grooming = False
    return _createDescription( palette, description, primitive, generator, renderer, method, grooming )


def deletePalette( palette ):
    # This delete the maya palette and leaves deleting the c-side
    # version to the node desctructor.
    if cmds.objExists(palette):
        cmds.delete(palette)
        return True
    # Not found in maya so try the c-side to be safe
    return base.deletePalette( palette )


def deleteDescription( palette, description ):
    # This delete the maya description and leaves deleting the c-side
    # version to the node desctructor.
    if cmds.objExists(palette+"|"+description):
        cmds.delete(palette+"|"+description)
        return True
    # Not found in maya so try the c-side to be safe
    return base.deleteDescription(palette,description)


def setAttr( attrName, value, palette, description="", object="" ):
    cmds.file(modified=True)
    return base.setAttr( attrName, value, palette, description, object )


def addCustomAttr( attrName, palette, description="", object="" ):
    cmds.file(modified=True)
    return base.addCustomAttr( attrName, palette, description, object )


def remCustomAttr( attrName, palette, description="", object="" ):
    cmds.file(modified=True)
    return base.remCustomAttr( attrName, palette, description, object )


def setActive( palette, description, subtype, previewer=False ):
    # This uses the maya command to handle the extra work when the
    # change is to the primitive (push the current guides across,
    # delete the maya wrappers, and then wrap new guides).
    if description=="":
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPICouldNotSetActiveType' ]+" ["+palette+":]");
        return
    cmds.file(modified=True)
    cmd = 'xgmSetActive -d "'+description+'" -o "'+subtype+'" '

    if subtype == 'GLRenderer':
        # force previewer for GLRenderer
        previewer = True

    if previewer:
        cmd += '-p true'
    return mel.eval(cmd)

    
def initInterpolation( palette, description, fileName="" ):
    # This uses the maya command to get the result recorded as attributes
    # on the maya guides.
    if description=="":
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPICouldNotSetInitInterop' ]+" ["+palette+":]");
        return False
    
    cmds.file(modified=True)
    
    # The return value of the initInterpolation was being used. 
    # It's important to return True or False
    try:
        if fileName=="" :
            cmds.xgmInterpSetup( d=description )
        else:
            cmds.xgmInterpSetup( d=description, n=fileName )
        return True
    except Exception:
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPIExceptionXgmInterpSetup' ])
    return False

    
def addFXModule( palette, description, type, name="" ):
    cmds.file(modified=True)
    return base.addFXModule( palette, description, type, name )


def removeFXModule( palette, description, name ):
    cmds.file(modified=True)
    return base.removeFXModule( palette, description, name )


def moveFXModule( palette, description, name, dir ):
    cmds.file(modified=True)
    return base.moveFXModule( palette, description, name, dir )
	
def buildFileName( basePaletteName, baseSceneName, ns ):
    ''' build file name for palette'''
    # replace all namespace colon by "__" to make
    # name valid
    nsName = ns.replace(":", "__")
    baseFilename = baseSceneName + "__" + nsName + basePaletteName
    return baseFilename
	
def copyFileToNewDir( fileName, currentSceneName, sourceFileDir, currentSceneDir, basePaletteName, ns ):
    ''' copy XG file from the source directory to target directory
    and rename the new file following the naming rule
    for example, if the XG file is "//dir1/file1_collections.xgen"
    and the current scene is "//dir2/scene.ma"
    then the new file is "//dir2//scene_file1_collections"'''
    # build old file path
    oldPath = fileName;
    if sourceFileDir != "" :
        oldPath = sourceFileDir + "/" + fileName
			
    # build new file path
    newPath = oldPath;
    if currentSceneName != "" :
        newBaseName = buildFileName(basePaletteName, currentSceneName, ns) + ".xgen"
        if currentSceneDir != "" :
            newPath = currentSceneDir + "/" + newBaseName
        elif sourceFileDir != "" :
            newPath = sourceFileDir + "/" + newBaseName
		
    # The imported file and the current scene may be in different
    # directories. So we need to copy the xgen file to the new directory
    # to let the current scene can use it as well. 
    if not os.path.isfile(newPath) :
        success = cmds.sysFile(oldPath, copy=newPath)
        if not success:
            XGError( maya.stringTable[ 'y_xgmExternalAPI.kCannotCopyXgenFile'  ] % (oldPath, newPath) )

    return newPath

def setupImportedMap(fileName, palName, descNames, uniqDescNames, nameSpace):
    '''
    When import palette or description, set up attributes with map texture.
    The setup steps include:
      1, parses the imported file again;
      2, read the "MapTextures" section;
      3, for each map, create an attribute for bound geometry; then connect 
         a texture node to the attribute.
    '''

    # parse the file, get its path of pallete
    fp = open(fileName, 'r')
    for line in fp:
        #print line
        line = line.strip(' \t\r\n') 
        
        if cmp(line, "Description") == 0:
            line = fp.next()
            line = line.strip(' \t\r\n')

            preDescription = line.split('\t', 3)[3]
            curDescription = uniqDescNames[0]
            for i in range(len(descNames)):
                if descNames[i] == preDescription:
                    curDescription = uniqDescNames[i]

            line = fp.next()
            line = line.strip(' \t\r\n')
            while line and cmp(line, "endAttrs"):
                if line.startswith("xgDataPath"):
                    xgDataPath = line.split("\t")[2]
                elif line.startswith("xgProjectPath"):
                    xgProjectPath = line.split("\t")[2]
                    palPath = ""
                    if xgDataPath.startswith("${PROJECT}"):
                        palPath = xgDataPath.replace("${PROJECT}", xgProjectPath)
                        #copy the dir
                        projRoot = cmds.workspace(query=True, rootDirectory=True)
                        curPalDir = os.path.join(projRoot, "xgen", "collections", palName)

                        srcdir = os.path.join(palPath, preDescription)
                        dstdir = os.path.join(curPalDir, curDescription)
                        xgutil.copyFolder(srcdir, dstdir)
                    else:
                        msg = maya.stringTable['y_xgmExternalAPI.kPalPathError' ]
                        XGError( msg )
                line = fp.next()
                line = line.strip(' \t\r\n')

        elif cmp(line, "MapTextures") == 0:
            geoms = xg.boundGeometry( palName, curDescription )
            
            line = fp.next()
            line = line.strip(' \t\r\n') 
            while line and cmp(line, "endAttrs"):
                segments = line.split("\t")
                
                isColor = cmp(segments[1], "regionMap") == 0
                # create attribute for shape and assign texture
                if isColor:
                    shapeAttrName = createMayaAttr( [0.5, 0.5, 0.5], segments[1], palName, curDescription )
                else:
                    shapeAttrName = createMayaAttr( [0.5], segments[1], palName, curDescription )

                for geom in geoms:
                    texNode = cmds.shadingNode("file", asTexture=True)
                    place2dNode = cmds.shadingNode("place2dTexture", asUtility=True)
                    mel.eval("fileTexturePlacementConnect( \""+ texNode + "\", \"" + place2dNode + "\" )")
                    cmds.connectAttr (place2dNode + ".outUV", texNode + ".uv")
                    cmds.connectAttr (place2dNode + ".outUvFilterSize", texNode + ".uvFilterSize")
                    
                    cmds.setAttr(texNode+".ftn", segments[2], type="string")
                    if isColor:
                        ip = texNode + ".outColor"
                    else:
                        ip = texNode + ".outAlpha"
                    shapeChildren = cmds.listRelatives( geoms, shapes=True )
                    shapeAttrName2 = shapeChildren[0] + "." + shapeAttrName
                    cmds.connectAttr (ip, shapeAttrName2)
                        
                line = fp.next()
                line = line.strip(' \t\r\n')
    fp.close()

def importPalette( fileName, deltas, nameSpace="", wrapPatches=True, wrapGuides=True, validator = None, grooming = False, validatePath = True ):

    uniqPal = ''
    if validator is not None:
        # get all description names from the file, it's unlikely the palette will have no descriptions but we shouldn't bother
        descNames = base.getAttrFromFile( 'name', 'Description', fileName )

        # get the palette name from the file
        palNames = base.getAttrFromFile( 'name', 'Palette', fileName )
        if len(palNames) is not 1:
            return ""

        # build list of valid description names 
        palName = palNames[0]
        uniqDescNames = []

        for i,descName in enumerate(descNames):
            (result,uniqDesc,uniqPal) = validator(descName,palName,i)
            if result:
                # collect description names
                uniqDescNames.append( uniqDesc )
            else:
                # operation has been halted by the user
                return ""

    # import the palette
    palName = base.importPalette( fileName, deltas, nameSpace )
    if ( palName == "" ):
        return ""

    if validator:
        # rename palette if necessary
        base.setAttr( 'name', uniqPal, palName, '', palName )
        palName = uniqPal

        # rename all descriptions with unique name
        for i,descName in enumerate(descNames):
            # description should be in the collections namespace
            descBaseName = base.stripNameSpace(descName)
            if nameSpace != "" and descBaseName != "":
                descName = nameSpace + ":" + descBaseName

            base.setAttr( 'name', uniqDescNames[i], palName, descName )

    # update the palette with the current project
    base.setAttr( 'xgProjectPath', base.getProjectPath(), palName )

    # validate xgDataPath for the imported palette
    if validatePath:
        path = base.getAttr( 'xgDataPath', palName )
        dirs= path.split(';')
        for dir in dirs:
            if len(dir) == 0:
                continue;
            # create the directory if we can, otherwise log an error
            expandedPath = base.expandFilepath( dir, "", True, True )
            if not os.path.exists(expandedPath):
                  msg = maya.stringTable[ 'y_xgmExternalAPI.kxgDataPathBroken' ] % (palName,dir)
                  XGError( msg )

    # setup all imported descriptions
    _setupDescriptionFolder( palName )

    # dirty scene
    cmds.file(modified=True)
        
    # wrap into maya nodes
    wrapCmd = 'xgmWrapXGen -pal "' + palName + '"'
    if wrapPatches:
        wrapCmd += ' -wp'
    if wrapGuides:
        wrapCmd += ' -wlg'

    if grooming:
        # add implicit grooming to imported descriptions with valid igroom attributes
        wrapCmd += ' -gi'

    try:
        pal = mel.eval( wrapCmd )
    except:
        pal = ""

    if ( pal == ""):
        # any problems with wrapping should result in clean up
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPIErrWrapXgenCol' ]+palName)
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPIErrWrapXgenDeleteCol' ])
        deletePalette( palName )
        return ""

    if validator:
        # fix the data path of pallete
        dataPath = xg.paletteRootVar() + "/" + palName
        xg.setAttr( "xgDataPath", dataPath, palName )
        setupImportedMap(fileName, palName, descNames, uniqDescNames, nameSpace)
        
        if xgg.DescriptionEditor and xgg.DescriptionEditor.autoCreateMR and mel.eval('exists "xgmr"'):
            try:
                #set up geo shader when import palette
                for desc in uniqDescNames:
                    cmds.xgmr( sgs=True, description=desc, palette=palName )
                    cmds.xgmr( applyShader="hair", description=desc, palette=palName )
            except:
                pass

    return str(pal) 


def importBindPalette( filename, nameSpace, validator, binding ):
    """ import palette and bind to selected geometry with undo support """
    palName = ''
    with undoable('importPalette'):
        palName = importPalette( filename, [], nameSpace, binding, binding, validator, binding )
        if binding:
            # bind goomming descriptions to geometry
            descriptions = base.descriptions(palName)
            for desc in descriptions:
                igdesc = base.getAttr( 'groom', palName, desc )
                if igdesc:
                    # found one
                    igdesc = igActivateDescription( desc )
                    mel.eval( 'igBindFromXGen "%s" ;' % desc )
                    cmds.setAttr( igdesc + '.density', 1 )
                    igSetDescriptionVisibility( True )
                    igSyncMaps( desc )

    return palName


def exportPalette( palette, fileName ):
    cmd = 'xgmPushOver -palette "'+palette+'"'
    mel.eval(cmd)    
    return base.exportPalette(palette,fileName)


def applyDelta( palette, delta ):
    cmds.file(modified=True)
    return base.applyDelta( palette, delta )


def importDescription( palName, fileName, createPal=False, validator=None, grooming=False ):
    """ import description from file and validates new description/palette if a validator is used"""

    if validator:
        # get description name from the file
        descNames = base.getAttrFromFile( 'name', 'Description', fileName )
        if len(descNames) is not 1:
            return ""

        descName = descNames[0]

        # validate
        (result,uniqDesc,uniqPal) = validator(descName,palName,0)
        if result:
            descName = uniqDesc
            palName = uniqPal
        else:
            return ""
  
    # create new palette if requested
    newPalette = False
    if createPal:
        newPalette = base.createPalette( palName )

    # import description
    descName = base.importDescription(palName,fileName)
    if ( descName == "" ):
        if newPalette:
            base.deletePalette( palName )
        return ""

    if validator:
        # rename description with unique name
        base.setAttr( 'name', uniqDesc, palName, descName )
        descName = uniqDesc

    # dirty the scene
    cmds.file(modified=True)
          
    if newPalette:
        # setup new palette/description with the current project
        _setupProject( palName, descName )
    else:
        # setup description only
        _setupDescriptionFolder( palName, descName )

    # wrap into maya nodes with implicit grooming 
    wrapCmd = 'xgmWrapXGen -pal "' + palName + '" -d "' + descName + '"' 

    if grooming:
        # implicit grooming requested
        wrapCmd += ' -gi'

    try:
        pal = mel.eval( wrapCmd )
    except:
        pal = ""
    if ( pal == "" ):
        XGError(errWrapXgenDesc + descName)
        XGError(errWrapXgenDeleteDesc)
        deleteDescription( palName, descName )
        return ""

    return descName

def _importDescriptionAsPreset( palName, fileName, createPal=False, validator=None, grooming=False ):
    """ import description from file and validates new description/palette if a validator is used"""

    if validator:
        # get description name from the file
        descNames = base.getAttrFromFile( 'name', 'Description', fileName )
        if len(descNames) is not 1:
            return ""

        descName = descNames[0]

        # validate
        (result,uniqDesc,uniqPal) = validator(descName,palName,0)
        if result:
            descName = uniqDesc
            palName = uniqPal
        else:
            return ""
  
    # create new palette if requested
    newPalette = False
    if createPal:
        newPalette = base.createPalette( palName )

    # import description
    descName = base.importDescriptionAsPreset(palName,fileName)
    if ( descName == "" ):
        if newPalette:
            base.deletePalette( palName )
        return ""

    if validator:
        # rename description with unique name
        ns = xg.objNameSpace(palName)
        uniqDesc = ns + uniqDesc
        base.setAttr( 'name', uniqDesc, palName, descName )
        descName = uniqDesc

    # dirty the scene
    cmds.file(modified=True)
          
    if newPalette:
        # setup new palette/description with the current project
        _setupProject( palName, descName )
    else:
        # setup description only
        _setupDescriptionFolder( palName, descName )

    # wrap into maya nodes with implicit grooming 
    wrapCmd = 'xgmWrapXGen -pal "' + palName + '" -d "' + descName + '"' 

    if grooming:
        # implicit grooming requested
        wrapCmd += ' -gi'

    try:
        pal = mel.eval( wrapCmd )
    except:
        pal = ""
    if ( pal == "" ):
        XGError(errWrapXgenDesc + descName)
        XGError(errWrapXgenDeleteDesc)
        deleteDescription( palName, descName )
        return ""

    return descName

def _importBindDescription( palName, filename, validator, binding ):
    """ import description and bind to selected geometry with undo support """
    descName = ''
    with undoable('importDescription'):
        descName = importDescription( palName, filename, validator.action==ADD_TO_NEW_PALETTE, validator, binding )
        if len(descName) and binding:
            # get palette from new description as it might have been changed during the validation
            palName = base.palette( descName )
            grooming = len(base.getAttr( 'groom', palName, descName ))
            modifyFaceBinding( palName, descName, "Append", "", False, grooming )  
            
    return descName

def _importBindDescriptionAsPreset( palName, filename, validator, binding, guides, placeGuidesWithUVBasedMethod, rotateGuide ):
    """ import description and bind to selected geometry with undo support """
    descName = ''
    with undoable('importDescriptionAsPreset'):
        descName = _importDescriptionAsPreset( palName, filename, validator.action==ADD_TO_NEW_PALETTE if validator else None, validator, binding )
        if len(descName) and binding:
            # get palette from new description as it might have been changed during the validation
            palName = base.palette( descName )
            grooming = len(base.getAttr( 'groom', palName, descName ))
            modifyFaceBinding( palName, descName, "Append", "", False, grooming, guides, placeGuidesWithUVBasedMethod, rotateGuide )  

            palName = base.palette(descName)
            geoms = xg.boundGeometry(palName, descName)
            if len(geoms)==0:
                if validator.action == xg.ADD_TO_NEW_PALETTE:
                    xg.deletePalette(palName)
                else:
                    xg.deleteDescription(palName, descName)

                descName = ''
            
    return descName

def importBindDescription( palName, filename, validator, binding ):
    """ import description and bind to selected geometry with undo support """

    descName = _importBindDescription( palName, filename, validator, binding )
    
    if len(descName) and validator and binding:
        uniqDescNames = [descName]
        setupImportedMap(filename, palName, [], uniqDescNames, "")
                
        if xgg.DescriptionEditor and xgg.DescriptionEditor.autoCreateMR and mel.eval('exists "xgmr"'):
            try:
                #set up geo shader when import description
                cmds.xgmr( sgs=True, description=descName, palette=palName )
                cmds.xgmr( applyShader="hair", description=descName, palette=palName )
            except:
                pass
    return descName

def importDescriptionAsPreset( palName, filename, validator, guides=False, placeGuidesWithUVBasedMethod=False, rotateGuide=True ):
    """ import description preset and bind to selected geometry with undo support """
    
    descName = _importBindDescriptionAsPreset( palName, filename, validator, True, guides, placeGuidesWithUVBasedMethod, rotateGuide )
    
    if len(descName) and validator:
        uniqDescNames = [descName]
        setupImportedMap(filename, palName, [], uniqDescNames, "")
                
        if xgg.DescriptionEditor and xgg.DescriptionEditor.autoCreateMR and mel.eval('exists "xgmr"'):
            try:
                #set up geo shader when import description
                cmds.xgmr( sgs=True, description=descName, palette=palName )
            except:
                pass
    return descName
        
def exportDescription( palette, description,
                      fileName, guides=False ):
    cmd = 'xgmPushOver -palette "'+palette+'"'
    mel.eval(cmd)
    return base.exportDescription(palette,description,fileName,guides)
    
def exportDescriptionAsPreset( palette, description, fileName, activeModuleOnly=False, guides=False ):
    cmd = 'xgmPushOver -palette "'+palette+'"'
    mel.eval(cmd)
    if guides:
        # convert guide base position to surface UV spaces
        cmd = 'xgmBakeGuideToUVSpace -d '+ description + ' '
        mel.eval(cmd)

    return base.exportDescriptionAsPreset( palette, description, fileName, activeModuleOnly, guides )
    
def importFXModule( palette, description, fileName ):
    cmds.file(modified=True)
    return base.importFXModule( palette, description, fileName )


def exportFXModule( palette, description, name, fileName ):
    cmd = 'xgmPushOver -palette "'+palette+'"'
    mel.eval(cmd)    
    return base.exportFXModule(palette,description,name,fileName)
    

def setMessageLevel( type, level ):
    if ( type == "quitOnError" ):
        XGWarning(1, maya.stringTable['y_xgmExternalAPI.kXgmExtAPICannotModifyQuitOnError' ])
        return
    base.setMessageLevel(type,level)


##
# Note: If something can be done inside of XGen, in the c++ code, and then
# wrapped in python then it shoudl be done that way. This allows it to be
# used in c++, python, and wrapped within Maya as well. The functions that
# follow are Maya specific and don't lend themselves to this approach. These
# are things like getting Maya node names and dealing with selection.
#


def guidePatch( guide ):
    """Get the patch for a given named guide.
    """
    xform = guide
    if cmds.objectType(guide) != "transform":
        parents = cmds.listRelatives(guide,p=True,pa=True,type="transform")
        xform = parents[0]
    parents = cmds.listRelatives(xform,p=True,pa=True,type="transform")
    return parents[0]


def guideDescription( guide ):
    """Get the description for a given named guide.
    """
    patch = guidePatch(guide)
    descXform = cmds.listRelatives(patch,p=True,pa=True,type="transform");
    return descXform[0]


def guideIndex( guide ):
    """Get the index of a guide within its description.
    """
    xform = guide
    if cmds.objectType(guide) != "transform":
        parents = cmds.listRelatives(guide,p=True,pa=True,type="transform")
        xform = parents[0]
    descr = guideDescription( xform )
    guides = descriptionGuides( descr )
    index = 0
    for g in guides:
        if g == xform:
            return index
        index += 1
    return index


def descriptionGuides( descr ):
    """Get the guides for the given description.
    """
    result = []
    types = []
    for prim in xgg.PrimitiveTypes():
        types.append("xgm"+prim+"Guide")
    guides = cmds.listRelatives(descr,ad=True,type=types)
    if guides==None:
        return result
    guides = cmds.ls(guides,ni=True)
    for guide in guides:
        result += cmds.listRelatives(guide,p=True,type="transform")
    return result

def setProjectPath( path ):
    """ Override base API for Maya purposes """
    # set the XGen core with the new project
    base.setProjectPath( path )
    path = base.getProjectPath( )

    # updates all palettes with the new maya project path
    palettes = base.palettes()
    for pal in palettes:
        base.setAttr( 'xgProjectPath', path, pal )

    if len(palettes):
        # dirty scene 
        cmds.file(modified=True)

    # xgen root location for rendering
    os.environ['XGEN_ROOT'] = path + 'xgen'

    # add new project path to the description folder tracker
    xgg.FolderTracker.desc().addRoot( path + 'xgen/collections' )


def descriptionPatches( descr ):
    """Get the patches for the given description.
    """
    result = []
    types = []
    for geom in xgg.GeomTypes():
        types.append("xgm"+geom+"Patch")
    patches = cmds.listRelatives(descr,ad=True,type=types)
    if patches==None:
        return result
    patches = cmds.ls(patches,ni=True)
    for patch in patches:
        result += cmds.listRelatives(patch,p=True,type="transform")
    return result


def palettePatches( palette ):
    """Get a list of all patches contained within the given palette.
    """
    result = []
    descrs = descriptions(palette)
    for descr in descrs:
        result += descriptionPatches( descr )
    return result


def geometryPatches( geometry ):
    """Get the patches bound to the given piece of geometry.
    """
    patches = []
    descrs = descriptions()
    for descr in descrs:
        dpatches = descriptionPatches(descr)
        for patch in dpatches:
            cmd = 'xgmPatchInfo -p "'+patch+'" -g';
            pgeom = mel.eval(cmd)
            if pgeom == geometry:
                patches.append(patch)
    return patches


def geometriesPatches( geomList ):
    """Get the patches bound to any of the geometries in the list. This
    function is more efficient than calling geometryPatches for a number
    of geometries in sequence.
    """
    patches = []
    descrs = descriptions()
    for descr in descrs:
        dpatches = descriptionPatches(descr)
        for patch in dpatches:
            cmd = 'xgmPatchInfo -p "'+patch+'" -g';
            geom = mel.eval(cmd)
            for geometry in geomList:
                if geom == geometry:
                    patches.append(patch)
                    break
    return patches
    
            
def geometryDescriptionPatch( geometry, desc ):
    """Given a piece of geometry and a description return the single
    bound patch.
    """
    allPatches = descriptionPatches(desc)
    for patch in allPatches:
        cmd = 'xgmPatchInfo -p "'+patch+'" -g';
        geom = mel.eval(cmd)
        if geom == geometry:
            return patch
    return None


def geometryFacePatches( geometry, faceId ):
    """Given a piece of geometry and a (base) faceId, return all the patches
    related to that face.
    """
    patches = []
    pals = palettes()
    for pal in pals:
        descrs = descriptions(pal)
        for descr in descrs:
            dpatches = descriptionPatches(descr)
            for patch in dpatches:
                cmd = 'xgmPatchInfo -p "'+patch+'" -g';
                geom = mel.eval(cmd)
                if geom == geometry:
                    patchFaceIds = boundFaces(pal,descr,geom,true)
                    for j in range(len(patchFaceIds)):
                        if faceId == patchFaceIds[j]:
                            patches.append(patch)
                            break
                        break
    return patches


def modifyFaceBinding( palette, description, mode="Append",
                       mapName="", mapInvert=False, grooming=False, guides=False,
                       placeGuidesWithUVBasedMethod=False, rotateGuide=True ):
    """Modify the face bindings of the current description.

    When in 'append' mode the selected faces will be added to the patch
    that is bound to the associated geometry. If no patch exists for
    the geometry a new patch will be created. In 'replace' mode the selected
    faces will replace those in the patch for the associated geometry. And
    finally, in 'remove' mode the faces are removed from the patch for the
    associated geometry if a patch exists. If the resulting patch has no
    bound faces then the patch is removed.
    """
    if palette=="":
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPINoColSpecifiedForBinding' ])
        return
    if description=="":
        XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPINoDescSpecifiedForBinding' ])
        return
    geoms = cmds.ls(dag=True,type=['mesh','nurbsSurface'],sl=True)
    cmd = 'xgmBindPatches -d "'+description+'" '
    if mode == "Remove":
        cmd += '-u '
    elif mode == "Replace":
        cmd += '-r '
    elif mode == "Map":
        cmd += '-mr "'+mapName+'" '
        if mapInvert:
            cmd += '-mi '
    else:
        cmd += '-a '

    if grooming:
        cmd += '-g '

    if guides:
        cmd += '-gi'
        if placeGuidesWithUVBasedMethod:
            cmd += '-uvBasedGuideTransfer'
        else:
            if rotateGuide:
                cmd += '-rotateGuideToAlignWithNewNormal'

    for geom in geoms:
        cmd += '"' + geom + '" '

    try:
        mel.eval(cmd)
        mel.eval("refresh -force")
        cmds.file(modified=True)
    except:
        raise

def fixPatchNames( palette ):
    """Fix the names for all of the patches in a palette.

    If a description is renamed or the geometry a description is bound to
    is renamed then the patches need to have their names updated as well.
    """
    try:
        cmds.undoInfo( openChunk=True )
        descs = descriptions(palette)
        for desc in descs:
            patches = descriptionPatches(desc)
            for patch in patches:
                # Get the name of the geometry patch connected to
                pshape = cmds.listRelatives(patch,c=True,s=True,pa=True)
                conns = cmds.listConnections(pshape[0]+".geometry")
                if len(conns) < 1:
                    XGError(maya.stringTable['y_xgmExternalAPI.kXgmExtAPIErrFindingGeo' ]+patch)
                    continue
                geom = conns[0]
                # rename according to standard
                newName = geom + "_" + stripNameSpace(desc)
                cmds.rename(patch,newName)
                # update cached geometry name
                cmds.xgmPatchInfo( p=newName, r=geom )
    except:
        pass
    finally:    
        cmds.undoInfo( closeChunk=True )

def nodeClass( node ):
    """Given a Maya node return the general class of XGen object. If the
    node is not an XGen object return None.
    """
    if not cmds.objExists(node):
        return None
    type = cmds.nodeType(node)
    if type == "transform":
        children = cmds.listRelatives(node,c=True,s=True,pa=True)
        if children == None:
            return None
        node = children[0]
        type = cmds.nodeType(node)

    if re.match(r'^xgm.+Guide$',type):
        return "guide"
    elif re.match(r'^xgm.+Patch$',type):
        return "patch"
    elif type == "xgmDescription":
        return "description"
    elif type == "xgmPalette":
        return "palette"
    return None
    
    
def renderable( node ):
    """Return true if the object is one that can be rendered. This can be used
    to avoid things like assigning shaders to non-renderable objects.
    """
    nclass = nodeClass(node)
    if (nclass=="patch") or (nclass=="description") or (nclass=="palette"):
        return True
    return False
    

def selectionToggle( description ):
    """Given the current selection list, toggle between geometry and XGen
    patches bound to the current description.
    """
    sel = cmds.ls(sl=True)
    if sel:
        cmds.select(clear=True)
        for item in sel:
            type = nodeClass(item)
            if type == "patch":
                geom = mel.eval('xgmPatchInfo -p "'+item+'" -g');
                cmds.select(geom,add=True)
            elif type == "guide":
                patch = guidePatch(item)
                geom = mel.eval('xgmPatchInfo -p "'+patch+'" -g');
                cmds.select(geom,add=True)
            else:
                patch = geometryDescriptionPatch( item, description )
                if patch:
                    cmds.select(patch,add=True)


def toggleGuideDisplay( description ):
    """Toggle the display visibility of the given descriptions guides. All
    guides will be set to the same state with the first guides visibility
    detemining the result.
    """
    guides = descriptionGuides(description)
    if not guides:
        return
    state = cmds.getAttr(guides[0]+".visibility")
    if state:
        cmds.hide(guides)
    else:
        cmds.showHidden(guides)


def toggleGuideReference( description ):
    """Toggle the display reference of the given descriptions guides. All
    guides will be set to the same state with the first guides state
    detemining the result.
    """
    guides = descriptionGuides(description)
    if not guides:
        return
    state = 0
    if cmds.getAttr(guides[0]+".overrideDisplayType") != 2:
        state = 1
    for guide in guides:
        if cmds.connectionInfo(guide+".drawOverride",isDestination=True):
            sPlug = cmds.connectionInfo(guide+".drawOverride",
                                        sourceFromDestination=True)
            source = splug.rstrip(".drawInfo")
            if state:
                cmds.setAttr(source+".displayType",2)
            else:
                cmds.setAttr(source+".displayType",0)
        else:
            if state:
                cmds.setAttr(guide+".overrideEnabled",1)
                cmds.setAttr(guide+".overrideDisplayType",2)
            else:
                cmds.setAttr(guide+".overrideEnabled",0)
                cmds.setAttr(guide+".overrideDisplayType",0)


def findSelectedPatches():
    """This function will return all XGen patches that relate to the current
    selection list.  Guides, patches, descriptions, geometry, whatever...it
    will all be resolved into the related patches.
    """
    return mel.eval("py_xgmSelectedFindPatches()")
    

def bakedGroomManagerBake( pal, desc, pb=False ):
    """Method to bake the current groom up to the location of the baked groom
    manager. This will result in a XPD file for each descriptions bound
    geometry that contains the static groom.
    """
    # Set the baked groom manager to bake mode
    setAttr("active","true",pal,desc,"BakedGroomManager")
    setAttr("doBake","true",pal,desc,"BakedGroomManager")
    bgmOutDir = getAttr("bakeDir",pal,desc,"BakedGroomManager")
    # record the current render then switch to the file renderer
    origRenderer = getActive(pal,desc,"Renderer")
    setActive(pal,desc,"FileRenderer")
    # grab current values in case renderer already in use
    percent = getAttr("percent",pal,desc,"FileRenderer")
    inCam = getAttr("inCameraOnly",pal,desc,"FileRenderer")
    outDir = getAttr("outputDir",pal,desc,"FileRenderer")
    # override with bake requirements
    setAttr("precent","100",pal,desc,"FileRenderer")
    setAttr("inCameraOnly","false",pal,desc,"FileRenderer")
    setAttr("outputDir",bgmOutDir,pal,desc,"FileRenderer")
    # temporarily turn off lod so we dont bake it in
    lod = getAttr("lodFlag",pal,desc)
    setAttr("lodFlag","False",pal,desc)
    # render the xpd files
    cmd = 'xgmFileRender '
    if pb:
        cmd += '-pb '
    cmd += '-local {"'+desc+'"}'
    files = mel.eval(cmd)
    # retore everything
    setAttr("percent",percent,pal,desc,"FileRenderer")
    setAttr("inCameraOnly",inCam,pal,desc,"FileRenderer")
    setAttr("outputDir",outDir,pal,desc,"FileRenderer")
    setAttr("doBake","false",pal,desc,"BakedGroomManager")
    setAttr("lodFlag",lod,pal,desc)
    setActive(pal,desc,origRenderer)
    # display results
    print maya.stringTable['y_xgmExternalAPI.kXgmExtAPIFilesBaked' ]
    print files


def setExportAsDelta( value, pal=None ):
    """This function allows you to control whether or not a palette should
    export as a full palette or as a delta file. When the value passed in
    is set to true a delta file will be written for the palette only when
    something in that palette has changed. If no palette is passed in then
    all palettes in the scene will be set to the new value.
    """
    pals = []
    if pal==None:
        pals = cmds.ls(type='xgmPalette')
    else:
        pals.append(pal)
    if pals==None:
        return
    for p in pals:
        cmds.setAttr( p+'.xgExportAsDelta', value )


def forcePointsRedraw():
    """This function forces an point viewers to redraw their points. It can 
    be called by anything that modifies the points or if something has caused
    the point display to become out of sync.
    """
    visual = cmds.ls(type="xgmPointsViewer")
    if visual:
        for v in visual:
            val = cmds.getAttr(v+".generate")
            cmds.setAttr(v+".generate",not val)


def selectionChangedCB():
    """This function is called when the selection changes and that selection
    needs to be reflected on the blobby visualizer. Any guides in the current
    selection will be found and put into a string list for the visualizer to
    use in it's redraw event.
    """
    visual = cmds.ls(type="xgmConnectivity")
    if not visual:
        return
    descr = cmds.getAttr(str(visual[0])+".description")
    selection = cmds.ls(sl=True)
    guides = ""
    for sel in selection:
        type = cmds.objectType(sel)
        if type == "transform":
            obj = cmds.listRelatives(sel,s=True,pa=True)
            type = cmds.objectType(obj)
        else:
            obj = sel
        if type.endswith("Guide"):
            print "obj: ",obj,"desc",guideDescription(obj),"curr",descr
            if guideDescription(obj)==descr:
                id = guideIndex(obj)
                if guides:
                    guides += ","
                guides += str(id)
    cmds.setAttr(str(visual[0])+".guides",guides,type="string")

def getOptionVar( varName ):
    """ get option var or return None if doesn't exist"""
    if cmds.optionVar( ex=varName ):
        # option already exists
        return cmds.optionVar( q=varName )
    return None

def setOptionVarInt( varName, val ):
    """ create or update option var """
    cmds.optionVar( iv=(varName, val) )

def getOptionVarInt( varName, dval=0 ):
    """ create or update option var """
    val = getOptionVar( varName ) 
    if val == None:
        cmds.optionVar( iv=(varName, dval) )
        return cmds.optionVar( q=varName )
    return val

def setOptionVarFloat( varName, val ):
    """ create or update option var """
    cmds.optionVar( fv=(varName, val) )

def getOptionVarFloat( varName, dval=0.0 ):
    """ create or update option var """
    val = getOptionVar( varName ) 
    if val == None:
        cmds.optionVar( fv=(varName, float(dval)) )
        return cmds.optionVar( q=varName )
    return val

def setOptionVarString( varName, val ):
    """ create or update option var """
    cmds.optionVar( sv=(varName, val) )

def getOptionVarString( varName, dval='' ):
    """ create or update option var """
    val = getOptionVar( varName ) 
    if val == None:
        cmds.optionVar( sv=(varName, dval) )
        return str(cmds.optionVar( q=varName ))
    return str(val)

def toQtWidget(controlName):
    """ convert an existing Maya control to Qt """
    ptr = mui.MQtUtil.findControl(controlName)
    if ptr is not None:
        widget = shiboken.wrapInstance(long(ptr), QtGui.QWidget)
        return widget
    return None

def igDescription( xdescr ):
    """ return ig description associated to an xgen description """    
    try:
        transforms = cmds.listRelatives( xdescr, type='transform')
        for t in transforms:
            descrs = cmds.listRelatives(t, type='igmDescription')
            if len(descrs):
                return t
    except:
        pass
    return ''

def getAttrValues(obj, params):
    """ 
    Returns existing node attribute values as a dict {param:value} 
    obj: node object such as ig description
    params: array of tuples(2) -> (attrb name, default value) 
    """
    values = {}
    for p in params:
        attr = p[0]
        values[attr] = p[1]
        if cmds.attributeQuery( attr, exists=True, node=obj ):
            values[attr] = cmds.getAttr( '%s.%s' % (obj,attr) )
    return values

def setAttrValues(obj, params):            
    """ 
    Set node object attribute values. Creates new attributes as required.
    obj: node object such as ig description
    params: array of tuples(3) -> (attrb name, value, attr type) 
    """

    for p in params:
        if cmds.attributeQuery( p[0], exists=True, node=obj ) is not True:
            if p[2] == 'string':
                cmds.addAttr( obj, longName=p[0], shortName=p[0], dt='string' )
            elif p[2] == 'float':
                cmds.addAttr( obj, longName=p[0], shortName=p[0], at='float' )
            elif p[2] == 'bool':
                cmds.addAttr( obj, longName=p[0], shortName=p[0], at='bool' )
            elif p[2] == 'doubleArray':
                cmds.addAttr( obj, longName=p[0], shortName=p[0], dt='doubleArray' )

        if p[2] == 'string':
            cmds.setAttr( '%s.%s' % (obj,p[0]), p[1], type='string' )
        elif p[2] == 'float':
            cmds.setAttr( '%s.%s' % (obj,p[0]), p[1] )
        elif p[2] == 'bool':
            cmds.setAttr( '%s.%s' % (obj,p[0]), p[1] )
        elif p[2] == 'doubleArray':
            cmds.setAttr( '%s.%s' % (obj,p[0]), p[1], type='doubleArray' )

def hasAttr(obj, param):
    """ 
    Returns True if attribute param exists.
    """
    return cmds.attributeQuery( param, exists=True, node=obj ) is True

def getAttrValue(obj, param):
    """ 
    Returns existing node attribute value
    obj: node object such as ig description
    params: tuple(2) -> (attrb name, default value) 
    """
    attr,default = param
    values = getAttrValues(obj, [param])    
    return values[attr]

def setAttrValue(obj, param):            
    """ 
    Set a node object attribute value. Creates a new attribute as required.
    obj: node object such as ig description
    params: tuple(3) -> (attrb name, value, attr type) 
    """
    setAttrValues( obj, [param] )

def igGetAttrValues(igDescr, params):
    """ 
    Returns igDescription attribute values 
    igDescr: ig description
    params: array of tuples(2) -> (attrb name, default value) 
    """
    values = getAttrValues(igDescr, params)
    values['outDir'] = '${DESC}/groom'
    return values

def igSetAttrValues(igDescr, params):            
    """ 
    Set igDescription attribute values 
    igDescr: ig description
    params: array of tuples(3) -> (attrb name, value, attr type) 
    """
    setAttrValues( igDescr, params )

def selectionNameSpaces( ):
    """ Returns a list of namespaces from the selected objects. 
    """
    sel = cmds.ls(sl=True,o=True)
    nsSet = set()
    if sel:
        for item in sel:
            ns = base.objBaseNameSpace(str(item))
            if len(ns):
                nsSet.add(ns)
        return list(nsSet)
    return list()

def selectedDescriptions():
    return cmds.ls( sl=True, exactType="xgmDescription" )

def selectionCount():
    return len(cmds.ls(sl=True,o=True))

def encodeNameSpace( name ):
    """ Encode name containing one or multiple namespaces. 
        The namespace separator : will be replaced with '__ns__'. 
        e.g. NS:myname -> NS__ns__myname
    """
    ns = base.objBaseNameSpace(name)
    if ns != '':
        splitNS = string.split( ns, ':' )
        multiNS = ''
        for s in splitNS:
            multiNS += '%s__ns__' % s
        name = '%s%s' % ( multiNS, base.stripNameSpace(name) )
    return name

def decodeNameSpace( name ):
    """ Reverse function of encodeNameSpace. e.g. NS__ns__myname -> NS:myname """
    tokens = name.split( '__ns__' )
    n = len(tokens)
    if n < 1:
        return name
    ns = ''
    for i,s in enumerate(tokens):
        ns += s
        if i < n-1:
            ns += ':'        
    return ns

def xgenProjectPath():
    """ returns the resolved xgen project path """
    return base.getProjectPath() + 'xgen'

def xgenProjectVar():
    """ returns the unresolved xgen project path value"""
    return '${PROJECT}xgen'

def paletteRootPath():
    """ returns the resolved palette root path """
    return xgenProjectPath() + '/collections'

def paletteRootVar():
    """ returns the unresolved palette root path """
    return xgenProjectVar() + '/collections'

def palettePathVar( pal ):
    """ 
    Returns the folder path of a given palette as "${PROJECT}xgen/collections/<palette name>". 
    ${PROJECT} is a palette token which resolves to the palette's xgProjectPath attribute. This attribute 
    is set with the current Maya project (when in Maya) or could be set with an other path with xgGlobal.setProjectPath 
    (typically used when outside Maya).
    """
    return ("%s/%s") % (paletteRootVar(), encodeNameSpace( pal ))

def palettePath( pal ):
    """ 
    Returns the resolved data path of a palette.
    """    
    return ("%s/%s") % (paletteRootPath(), encodeNameSpace( pal ))
  
def renamePalette( oldName, newName ):
    """ 
        Rename palette oldName to newName. The new name is validated and a new name is generated
        if there is a clash with existing palettes or with the descriptions of oldName palette. 
        The oldName folder is also renamed. 
    """
    def renamePalettePath( oldName, newName ):
        oldPath = palettePath( oldName )
        newPath = palettePath( newName )
        try:
            import shutil
            shutil.move(oldPath, newPath)
        except:
            import sys
            print sys.exc_info()[1]
            raise

        #update the folder tracker with the new palette path
        allpaths = xgg.FolderTracker.desc().paths
        for descPath in allpaths:
            if descPath.startswith( oldPath ):                
                newDescPath = newPath
                newDescPath += '/'
                newDescPath += descPath.split('/')[-1]
                xgg.FolderTracker.desc().rename(descPath,newDescPath)

        XGWarning( 3, maya.stringTable[ 'y_xgmExternalAPI.kRenamePaletteFolder'  ] % (newPath,oldPath) )

    # build a valid unique name
    (palFolderNames,palPathMaps) = paletteFolderNames( )        
    (descFolderNames,descPathMaps) = descriptionFolderNames( )        
    palNames = list(base.palettes())+descFolderNames
    palInfo = (newName, palNames, palFolderNames, palPathMaps, None)
    descInfo = ("dummy", None, None, None, None)
    (result,dummy,validPalette) = validateDescription( VALIDATE_PALETTE_NAME, palInfo, descInfo )

    if not result:         
        XGError( maya.stringTable[ 'y_xgmExternalAPI.kCannotRenamePalette'  ] % (oldName,newName) )
        raise

    if not validPalette == newName :
        XGWarning( 3, maya.stringTable[ 'y_xgmExternalAPI.kPaletteClash'  ] % (newName,validPalette) )

    try:
        #rename palette path
        renamePalettePath( oldName, validPalette )

        # rename c-side palette
        base.setAttr( 'name', validPalette, oldName )
    except:
        XGError( maya.stringTable[ 'y_xgmExternalAPI.kCannotRenamePalette2'  ] % (oldName,newName) )
        raise
   
def descriptionPath( pal, desc ):
    """ Returns the resolved path of a description """
    return '%s/%s' % (palettePath(pal), base.stripNameSpace( desc ))

def renameDescription( palName, oldName, newName ):
    """ 
        Rename description oldName to newName. The new name is validated and a new name is generated
        if there is a clash with existing descriptions. The oldName folder is also renamed. 
    """
    def renameDescriptionPath( palName, oldName, newName ):
        oldPath = descriptionPath( palName, oldName )
        newPath = descriptionPath( palName, newName )
        try:
            import shutil
            shutil.move(oldPath, newPath)
        except:
            import sys
            print sys.exc_info()[1]
            raise

        #update the folder tracker
        xgg.FolderTracker.desc().rename(oldPath,newPath)
        XGWarning( 3, maya.stringTable[ 'y_xgmExternalAPI.kRenameDescriptionFolder'  ] % (newPath,oldPath) )

    # build a valid unique name
    (descFolderNames,descPathMaps) = descriptionFolderNames( )        
    loadedDescriptions = list(base.descriptions())
    loadedDescriptions.append(palName)

    palInfo = (palName, None, None, None, None)
    descInfo = (newName, loadedDescriptions, descFolderNames, descPathMaps, None)
    (result,validDesc,validPalette) = validateDescription( VALIDATE_DESC_NAME, palInfo, descInfo )

    cannotRenameDescriptionErr = maya.stringTable[ 'y_xgmExternalAPI.kCannotRenameDescription'  ] % (oldName,newName) 
    if not result:         
        XGError(cannotRenameDescriptionErr)
        raise

    if not validDesc == newName :
        XGWarning( 3, maya.stringTable[ 'y_xgmExternalAPI.kDescriptionClash'  ] % (newName,validDesc) )

    try:
        #rename description path
        renameDescriptionPath( palName, oldName, validDesc )

        # rename c-side description
        base.setAttr( 'name', validDesc, palName, oldName )
    except:
        XGError(cannotRenameDescriptionErr)
        raise

def _buildName( suggested, names, default ):
    """Makes a name unique within a given list of names"""
    name = suggested

    if not len(name):
        name = suggested = default
    
    #init suffix from the suggested name
    suffix = 0
    g = re.search('[0-9]+\Z',suggested)
    if g != None:
        suffix = int(g.group(0))
        suggested = g.string[:g.start()]

    while True:
        if name in names:
            # clash: increment suffix
            name = suggested            
            suffix += 1
            name += str(suffix)
            #print '%s : %s' % (name,str(names))
        else:
            break
    return name

def _folderNames( root ):
    """ 
    Get all first level folders from a root path. Also returns a dict of full paths with folder names as entry.
    ([a,b,c],dict({'a',path_for_a},etc...)
    """
    rootFolder = xgutil.fixFolderPath(base.fileCleanup( root ))

    folders = []
    folderMap = {}

    if not os.path.isdir(rootFolder):
        return (folders,folderMap)

    # get all first-level folders from root
    items = os.listdir( rootFolder )    
    folders = [ rootFolder + item for item in items ]

    for item in folders:
        if os.path.isdir(item):
            folderMap[os.path.basename(item)] = item
            
    folders = [ os.path.basename(item) for item in folders if os.path.isdir(item) ]
    return (folders,folderMap)

def descriptionFolderNames( ):
    """ get all description folder names under the palettes root """

    # get all palette folders
    allDescFolders = []
    allDescFolderMap = {}
    (palFolders,folderMap) = _folderNames( paletteRootPath() )
    for f in palFolders:
        path = folderMap[f]
        # get the description folders
        (subFolders,subFolderMap) = _folderNames( path )
        # copy all dicts and folder names
        allDescFolders += subFolders
        for sub in subFolders:
            allDescFolderMap[sub] = subFolderMap[sub]
    return (allDescFolders,allDescFolderMap)

def paletteFolderNames( ):
    return _folderNames( paletteRootPath() )

def buildPaletteName( suggested, loadedPals, palFolders ):
    """ create a unique palette name """

    # get list of unique names to validate agains
    names = list(loadedPals + palFolders)

    # names might contain folder names with a special namespace format, so we want to unformat them
    names = list(set([ decodeNameSpace(n) for n in names ]))
    return _buildName( suggested, names, 'collection' )

def buildDescriptionName( suggested, loadedDescriptions, descFolders ):
    """ create a unique description name """

    # get list of unique names to validate against
    names = list(set(loadedDescriptions + descFolders))
    return _buildName( suggested, names, 'description' )        

def createBindDescription( palette, description, primitive, generator, renderer, method, grooming=False ):
    """ Helper to create an xgen description with wrappers and to bind the selected geometry to the new description. """ 
    
    newDesc = _createDescription(palette, description, primitive, generator, renderer, method, grooming)
    if newDesc and xgg.Maya:
        try:
            # bind geometry to new description
            modifyFaceBinding( palette, newDesc, "Append", "", False, grooming )
        except:
            raise        
    return newDesc

def validateDescription( action, palInfo, descInfo, uiParent=None ):
    """
    Generates names for xgen object types: palette and description. Names are generated based on suggested names, 
    current loaded objects and existing objects on disk. Namespaces are also supported.

    action: ADD_TO_NEW_PALETTE      -> add to new palette
            ADD_TO_EXISTING_PALETTE -> add to existing palette
            VALIDATE_DESC_NAME      -> description name validation
            VALIDATE_PALETTE_NAME   -> palette name validation
    palInfo: tuple containing all the data required for generating a palette name
        1) palName: suggested name
        2) loadedPals: all palettes in xgen
        3) palFolders: palette folder names 
        4) palPathMap: dictionary mapping the palette folder names to full paths
        5) palCB: callback called by validateDescription when a name collision occurs between the generated palette  
        name and existing folder.
    descInfo: tuple containing all the data required for generating a description name
        1) descName: suggested name
        2) loadedDescs: all descriptions in xgen
        3) descFolders: description folder names 
        4) descPathMap: dictionary mapping the description folder names to full paths
        5) descCB: callback called by validateDescription when a name collision occurs between the generated description 
        name and existing folder.
    uiParent: optional parent widget for the callback

    """
    if not action in [ADD_TO_NEW_PALETTE,ADD_TO_EXISTING_PALETTE,VALIDATE_DESC_NAME,VALIDATE_PALETTE_NAME]:
        return (False, '','')

    ( palName, loadedPals, palFolders, palPathMap, palCB ) = palInfo
    ( descName, loadedDescs, descFolders, descPathMap, descCB ) = descInfo

    selNSpaces = selectionNameSpaces()
    selCount = selectionCount()
    selNS = selNSpaces[0] if len(selNSpaces) == 1 else ''
    palNS = base.objBaseNameSpace(palName)            
    validPalette = palName
    validDesc = descName

    if action == ADD_TO_NEW_PALETTE:
        #the namespace must be properly formatted    
        splitNS = string.split( palName, ':' )
        for s in splitNS:
            if len(s) == 0:
                title = maya.stringTable[ 'y_xgmExternalAPI.kCreateXgenDescription'  ]
                text = maya.stringTable[ 'y_xgmExternalAPI.kInvalidNamespace'  ]
                if uiParent:
                    mbox = QtGui.QMessageBox(QtGui.QMessageBox.NoIcon, title, text, QtGui.QMessageBox.Ok, uiParent )
                    mbox.exec_()
                else:
                    XGError(text)
                return (False, '','')

    if selCount and (len(selNS) and len(palNS)) and (selNS != palNS):            
        title = maya.stringTable[ 'y_xgmExternalAPI.kCreateXgenDescription2'  ]
        text = maya.stringTable[ 'y_xgmExternalAPI.kCollectionNamespace'  ] % (palNS,selNS)
        if uiParent:
            mbox = QtGui.QMessageBox(QtGui.QMessageBox.NoIcon, title, text, QtGui.QMessageBox.Ok, uiParent )
            mbox.exec_()
        else:
            XGError(text)        
        return (False, '','')

    if selCount and len(selNS)==0 and len(palNS):
        title = maya.stringTable[ 'y_xgmExternalAPI.kCreateXgenDescription3'  ]
        text = maya.stringTable[ 'y_xgmExternalAPI.kSelectedObjectsNotPartOfCollection'  ] % palNS
        if uiParent:
            mbox = QtGui.QMessageBox(QtGui.QMessageBox.NoIcon, title, text, QtGui.QMessageBox.Ok, uiParent )
            mbox.exec_()
        else:
            XGError(text)
        return (False, '','')

    if action == ADD_TO_NEW_PALETTE or action == VALIDATE_PALETTE_NAME:   
        suggested = palName
        if len(selNS) and len(palNS)==0:
            # set the suggested palette with the selected object namespace
            palName = '%s:%s' % (selNS,palName)
        validPalette = buildPaletteName( palName, loadedPals, palFolders )        
        if not validPalette == palName and palName not in loadedPals:
            encodedPalName = encodeNameSpace(palName)
            try:
                path = palPathMap[encodedPalName]
            except:
                raise

            if palCB:
                success,validPalette = palCB( uiParent, validPalette, palName, path )
                if not success:
                    return (False,'', '')

        if action == VALIDATE_PALETTE_NAME:
            return (True,'',validPalette)
    
    # check if the description name clashes with something
    validDesc = buildDescriptionName( descName, loadedDescs, descFolders )        
    if not validDesc == descName and descName not in loadedDescs:
        try:
            path = descPathMap[descName]
        except:
            raise

        if descCB:
            success,validDesc = descCB( uiParent, validDesc, descName, path )
            if not success:
                return (False,'','')

    return (True,validDesc,validPalette)

def igCurrentDescription( ):
    return mel.eval( 'igActiveDescription( );' )

def igGetDescriptionVisibility():
    return mel.eval( 'igGetDescriptionVisibility();' )   

def igSetDescriptionVisibility( flag ):
    return mel.eval( 'igSetDescriptionVisibility( %d );' % int(flag) )   

def igMakeCurrentDescriptionVisible( ):
    """ make current ig description visible and hides all others """
    return mel.eval( 'igSetAllDescriptionsVisibility(0);igSetDescriptionVisibility( 1 );' )

def igSetCurrentDescription( igdescr ):
    mel.eval( 'igSetCurrentDescription("%s");' % igdescr )

def igActivateDescription( xdesc ):
    """ Activate an igroom description for a given xgen description and return the igroom description name"""    
    try:
        igdesc = igDescription( xdesc )
        igSetCurrentDescription( igdesc )
    except:
        pass
    return igdesc

def igDescriptionTpu( igDesc ):
    """ Return the texel per unit value of a specific ig description used for exporting ptx files."""
    if len(igDesc):
        if not hasAttr( igDesc, 'igAutoExportTpu' ):
            setAttrValue( igDesc, ('igAutoExportTpu',5.0,'float') )
            return 5.0
        else:
            return getAttrValue( igDesc, ('igAutoExportTpu',5.0) )    
    return 5.0

def igForceExport( igDesc ):
    """ make an igroom description as dirty for exporting maps """
    _igForceExportTags.add( igDesc )

def igSyncRegion( xdesc, xpal, prim, pathExpr ):
    mel.eval( 'xgmSetAttr -a "regionMap" -v "%s" -p "%s" -d "%s" -o "%s";' % (pathExpr,xpal,xdesc,prim) )
    
    value = "map('%s')" % pathExpr
    previewer = base.getActive(xpal,xdesc,"Previewer")
    mel.eval( 'xgmSetAttr -a "color" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,previewer) )

def igSyncLength( xdesc, xpal, prim, pathExpr ):
    value = "map('%s')" % pathExpr
    mel.eval( 'xgmSetAttr -a "length" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

def igSyncWidth( xdesc, xpal, prim, pathExpr ):
    value = "map('%s')" % pathExpr
    mel.eval( 'xgmSetAttr -a "width" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

def igSyncOrient( xdesc, xpal, prim, pathExpr ):
    value = "map('%s',0)" % pathExpr
    mel.eval( 'xgmSetAttr -a "offU" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

    value = "map('%s',1)" % pathExpr
    mel.eval( 'xgmSetAttr -a "offV" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

def igSyncBend( xdesc, xpal, prim, pathExpr ):
    value = "map('%s',0)" % pathExpr
    mel.eval( 'xgmSetAttr -a "bendParam[0]" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

    value = "map('%s',1)" % pathExpr
    mel.eval( 'xgmSetAttr -a "bendU[0]" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

    value = "map('%s',2)" % pathExpr
    mel.eval( 'xgmSetAttr -a "bendV[0]" -v "%s" -p "%s" -d "%s" -o "%s";' % (value,xpal,xdesc,prim) )

def igExportMaps( xdescriptions ):
    """ Export all igroom maps from a list of xgen descriptions. """    
    import traceback
    def _hasPtxFile( dir ):
        if os.path.isdir(dir): 
            files = os.listdir( dir )
            ptxfiles = filter(lambda x: x.endswith('.ptx'), files)
            if len(ptxfiles):
                return True
        return False

    path = getOptionVarString( 'igAutoExportFolder' )
    instMeth = 0

    exportCount = 0
    try:
        cmds.waitCursor( state=True )
        for xdesc in xdescriptions:
            igdesc = igDescription( xdesc )
            if not igdesc:
                # no igroom description attached
                continue

            xpal = base.palette(xdesc)
            prim = base.getActive(xpal,xdesc,"Primitive")

            if not prim == 'SplinePrimitive':
                # only splines are valid for grooming
                continue

            fullPath = base.expandFilepath( path, xdesc )
            tpu = igDescriptionTpu( igdesc )
            forceExport = igdesc in _igForceExportTags
        
            # export ptex maps
            try:
                exportCount = exportCount + 1
                mel.eval( 'iGroom -xa "%s" -tpu %f -in %d -fx %d -ex -d "%s";' % (fullPath,tpu,instMeth,forceExport,igdesc) )
            except:
                print traceback.print_exc()

            try:
                # remove tag if one exists
                _igForceExportTags.remove(igdesc)
            except:
                pass
    finally:
        cmds.waitCursor( state=False )
    return exportCount

def igSyncMaps( xdesc ):
    """ Sync xgen to use igroom maps """
    xpal = base.palette(xdesc)
    prim = base.getActive(xpal,xdesc,"Primitive")

    if not prim == 'SplinePrimitive':
        # only spline primitives are supported
        return

    syncInfo = [('length',igSyncLength),('orient',igSyncOrient),('bend',igSyncBend),('width',igSyncWidth),('region',igSyncRegion)]
    path = getOptionVarString( 'igAutoExportFolder' ) 
    for info in syncInfo:
        mapName, sync = info
        ptxPath = path + '/' + mapName + '/'
        sync( xdesc, xpal, prim, ptxPath )

@contextmanager
def undoable( name ):
    try:
        cmds.undoInfo( ock=True, cn=name )
        yield name
    except Exception, e:
        import traceback
        print maya.stringTable['y_xgmExternalAPI.kXgmExtAPIErrRunningUndoable' ] % (name,e)
        traceback.print_exc()
    finally:
        cmds.undoInfo( cck=True )        
