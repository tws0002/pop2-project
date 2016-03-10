#!/usr/bin/python
# -*- coding: -*-

"""
Creates a basic city generator
"""

# IMPORT STANDARD LIBRARIES
import random

# IMPORT THIRD-PARTY LIBRARIES
import pymel.core as pm
import maya.OpenMaya as OM


MASTER_GRP = "master_menger_grp"


def round(num, divisor=90):
    return num - (num%divisor)
# end round

def random_rotation(step=90):
    """
    applies random rotation to a given object
    """
    rotX = round(random.random() * 360)
    rotY = round(random.random() * 360)
    rotZ = round(random.random() * 360)
    return [rotX, rotY, rotZ]
# end random_rotation

def random_position(object, ground, spacing=0):
    """
    Responsible for creating position data and making sure that 
    no two values are used more than once. Also has a spacing feature
    """
    bb = get_bounding_box_local()    
    stepX = bb[3] - bb[0] + spacing
    stepZ = bb[5] - bb[2] + spacing        
    translateX = (random.random() -0.5) * ground.scale.get().x
    translateX = round(translateX, stepX)
    translateZ = (random.random() -0.5) * ground.scale.get().z
    translateZ = round(translateZ, stepZ)
    return (translateX, translateZ)
# end random_position


def random_placement(duplicateObject, ground, numberOfCubes, 
                     minHeight, maxHeight, spacingX=0.5, spacingY=0):     
    # init data and LUTs
    global MASTER_GRP
    
    createdCubes = []
    existingTranslations = []
    tries = 0
    bb = get_bounding_box_local()

    for i in xrange(numberOfCubes):
        # init column
        column = []

        # init height information
        if maxHeight < minHeight:
            minHeight, maxHeight = maxHeight, minHeight

        maxHeightNumber = maxHeight - minHeight - 1 # -1 to accomodate the first cube
        randHeight = random.randint(minHeight, maxHeightNumber)
        columnTries = 0
        columnHeights = []
        for _ in xrange(randHeight):
            dup = pm.duplicate(duplicateObject)[0]
            column.append(dup)
            createdCubes.append(dup)
        
        # set attributes and transform
        while tries < 20:
            tries += 1
            translateX, translateZ = random_position(duplicateObject, 
                                                     ground, spacingX)
            translationList = [translateX, translateZ]
            if translationList not in existingTranslations:
                existingTranslations.append([translateX, translateZ])
                tries = 0  # reset the number of tries
                break

        # make the cube
        dup = pm.duplicate(duplicateObject)[0]
        dupShape = [x for x in pm.listRelatives(dup, ad=True) \
                    if isinstance(x, pm.nodetypes.Mesh)][0]
        createdCubes.append(dup)
        column.append(dup)
        dup.translate.set([translateX, 0, translateZ])
        randomize_menger_attrs(dupShape)
                   
        cubeHeight = bb[4] - bb[1]
        for index, cube in enumerate(column[:-1]):  # ignore the last cube, which will be the ground
            translateY = (cubeHeight * (index+1)) + spacingY  # stack on top of one another
            cubeShape = [x for x in pm.listRelatives(cube, ad=True) \
                         if isinstance(x, pm.nodetypes.Mesh)][0]
            randomize_menger_attrs(cubeShape)
                
            cube.translate.set([translateX, translateY, translateZ])
        
            rotateGrp = cube.getChildren()
            for child in rotateGrp:
                if rotateGrp == rotateGrp[0].nodeName():
                    rotateGrp = child
                    rotateGrp.rotate.set(random_rotation())
    masterGrp = pm.group(createdCubes)
    pm.rename(masterGrp, MASTER_GRP)
# end random_placement


def get_bounding_box_local():
    # Get the current selection.
    # The first object in the selection is used, and is assumed
    # to be a transform node with a single shape directly below it.
    selectionList = OM.MSelectionList()
    OM.MGlobal.getActiveSelectionList(selectionList)

    selectedPath = OM.MDagPath()
    selectionList.getDagPath(0, selectedPath)

    # Get the transformation matrix of the selected object.
    transform = OM.MFnTransform(selectedPath)
    m = transform.transformationMatrix()

    # Get the shape directly below the selected transform.
    selectedPath.extendToShape()

    fnMesh = OM.MFnMesh(selectedPath)
    bounds = fnMesh.boundingBox()


    center = bounds.center()
    min = bounds.min()
    max = bounds.max()
    return [min.x, min.y, min.z, max.x, max.y, max.z]
# end get_bounding_box_local


def randomize_menger_attrs(object):
    """
    Sets the menger attributes on the current object
    """
    renderStyle = random.randint(0,2)
    depth = random.randint(2,4)
    isAnimateable = 0
    allowRibWriting = 1
    randomHolesMinMax = (1,27)
    randomHolesNum = random.randint(*randomHolesMinMax)
    existingNums = []
    holes = []
    while len(holes) < randomHolesNum:
        randNum = random.randint(*randomHolesMinMax)
        if randNum not in holes:
            holes.append(randNum)
    holes = map(str, holes)
    holes = ",".join(holes)
    
    attrList = {"renderStyle": renderStyle, "depth": depth, "holes": holes, "Is_Animated": isAnimateable, "Allow_Rib_Writing": allowRibWriting}
    for attr, value in attrList.iteritems():
        pm.setAttr(object + "." + attr, value)
# end randomize_menger_attrs


def test_layout(numberOfCubes, maxHeight):
    try:
        pm.delete(MASTER_GRP)
    except pm.MayaObjectError:
        pass  # command wasn't run

    initialSelection = pm.ls(sl=True)
    grpTransform = pm.PyNode('cube_trans_grp')
    groundPlane = pm.PyNode('grnd')
    rotateGrp = grpTransform.getChildren()[0]
    minHeight = 1
    random_placement(grpTransform, groundPlane, numberOfCubes, minHeight, maxHeight, 0.1)
    pm.select(initialSelection)
# test_layout


if __name__ == "__main__":
    test_layout(100,5)