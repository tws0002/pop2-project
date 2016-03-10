# Copyright 2014 Autodesk, Inc. All rights reserved. 
#
# Use of this software is subject to the terms of the Autodesk 
# license agreement provided at the time of installation or download, 
# or which otherwise accompanies this software in either electronic 
# or hard copy form.

##
# @file xgmSetMapAttr.py
# @brief Set map texture info to attribute before export palette and description.
#
# @author Nian Wu
#
# @version Created 02/11/2014
#

import xgenm as xg
import xgenm.xmaya.xgmExternalAPI as xgmExternalAPI
import maya.cmds as cmds
import maya.OpenMaya as OpenMaya
import maya.OpenMayaRender as OpenMayaRender
from xgenm.ui.util.xgUtil import *
from PySide import QtCore

def getMapExprStrings():
    # the attribute value of mapped texture has format like: 
    #   $a=map('${DESC}/paintmaps/length');
    exprString0 = '\\$(\\w+)\\s*=\\s*map\\([\"\']([\\w${}\\-\\\\/]+)[\"\']\\);\\s*#3dpaint,(-?[\\d.]*)'
    exprString1 = '\\$(\\w+)\\s*=\\s*map\\([\"\']([\\w${}\\-\\\\/]+)[\"\']\\);\\s*#file'
    exprString2 = '\\$(\\w+)\\s*=\\s*vmap\\([\"\']([\\w${}\\-\\\\/]+)[\"\']\\);\\s*#vpaint'
    exprStrings = [ exprString0, exprString1, exprString2 ]
    
    return exprStrings

def getMapName(attrVal):
    """ Get map name if the type of the attribute may be mapped texture.
    """

    exprStrings = getMapExprStrings()

    retMaps = []
    for s in exprStrings:
        re = QtCore.QRegExp( s )
        offset = 0
        while True:
            pos = re.indexIn(attrVal, offset)
            if (pos < 0): 
                break
            offset = pos + 1
            file = re.cap(2)
            segs = file.split("/")
            
            return segs[-1]

    # some attribute value of mapped texture has format like:
    #   ${DESC}/Region/
    #   ${DESC}/groom/Region
    if attrVal.startswith("${DESC}"):
        segs = attrVal.split("/")
        if len(segs[-1]) == 0 and len(segs) > 1:
            return segs[-2]
        else:
            return segs[-1]

    return ""

def nameToNode( name ):
    """ Get Maya node from its name.
    """

    selectionList = OpenMaya.MSelectionList()
    selectionList.add( name )
    node = OpenMaya.MObject()
    selectionList.getDependNode( 0, node )
    return node
 
def getInputObj(attrName, nodeName):
    """ Get the source node from input plug.
    """

    nodeObject = nameToNode( nodeName )
    depNodeFn = OpenMaya.MFnDependencyNode( nodeObject )
    attrObject = depNodeFn.attribute( attrName )
    plug = OpenMaya.MPlug( nodeObject, attrObject )
    inPlugs = OpenMaya.MPlugArray()
    if plug.connectedTo (inPlugs, True, False):
        if inPlugs.length() > 0:
            return inPlugs[0].node()
    
    return OpenMaya.MObject.kNullObj

def setMapAttr():
    """ Set map texture info to attribute if the attribute type is map.
    
        This method will iterator all xgen attributes.
    """

    palettes = uiPalettes();
    if len(palettes) == 0:
        return

    for palette in palettes:
        descriptions = xg.descriptions(palette)
        for desc in descriptions:
            geoms = xg.boundGeometry( palette, desc )
            shapes = []
            for geom in geoms:
                shapeChildren = cmds.listRelatives( geom, shapes=True )
                # geom is transform node, get its shape child node
                shapes.append(shapeChildren[0])
            
            objs = xg.objects(palette, desc)
            objs += xg.fxModules(palette, desc) # add modifier objects
            for obj in objs:
                attrs = xg.attrs(palette, desc, obj)
                for attr in attrs:
                    attrVal = xg.getAttr(attr, palette, desc, obj)
                    name = getMapName(attrVal)
                    if len(name) > 0:
                        shapeAttrName = xgmExternalAPI.mayaShapeAttrName( name, palette, desc )
                        for shape in shapes:
                            # if an xgen attribute is mapped, xgen creates an attribute for each
                            # bound shapes, and connect a texture node to the shape attribute.
                            if cmds.attributeQuery(shapeAttrName, node=shape, exists=True):
                                inputObj = getInputObj(shapeAttrName, shape)
                                if not inputObj.hasFn(OpenMaya.MFn.kFileTexture):
                                    break;
        
                                # get the texture file path
                                texFilePath = str(OpenMayaRender.MRenderUtil.exactFileTextureName(inputObj))
                            
                                # set the map texture for attribute
                                xg.setTextureAttr( attr, texFilePath, palette, desc, obj )
