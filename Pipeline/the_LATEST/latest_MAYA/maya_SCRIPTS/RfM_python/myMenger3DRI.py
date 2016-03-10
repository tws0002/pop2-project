#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Project
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TECH312 - Menger Fractal

Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Initiializes, simulates, and controls the output paths to a Menger fractal.

The main hook that inputs into this function is renderman's Pre Shape MEL,
which calls a MEL script that runs create_menger. The function outputs a global
variable called "OUTPUT_PATH", which is then retrieved by the remainder of the
MEL script automatically by, again, using MEL's python command.

Requires
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 - A shape with init_attributes run on the object
 - init attributes needs maya.cmds as cmds and pymel.core as pymel.core as pm
   already loaded prior to execution
 - A pre-written simulation
 - In the Pre Shape MEL, specify a full path (including the intended filename)
    - If animation is enabled, a _#### padding automatically added to the name

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
myMenger3DRI

"""

# IMPORT STANDARD LIBRARIES
import os
import collections

# IMPORT THIRD-PARTY LIBRARIES
import maya.OpenMaya as OM
import pymel.core as pm
import maya.cmds as cmds
import maya.mel as mel

# IMPORT LOCAL LIBRARIES
from myMenger3d import Menger3D


OUTPUT_PATH = ""


def init_attributes(selection=None, depth=3, listOfHoles='10,11,12,13,14,15,16', 
                    allowRibWrite=1, animation=1):
    """
    Adds attributes to the selected object's shape node for making the menger

    Args:
        selection (pm.nodetypes.Mesh): The object to add attributes to. If a
                                       transform is passed, its shape is retrieved
        depth (int): The number of recursions the menger undergoes before
                     creating its planes and holes.
        .. note::
            Any value above in depth will cause noticeably slower render times

        listOfHoles (list): The indices (1-27) to create menger holes
        allowRibWrite (bool): Will create a .rib file at the specified user
                              location if enabled prior to reading it. If disabled,
                              the script will simply read any .rib simulations
        animation (bool): If enabled, the search path is modified to look for
                          a frame number suffix, with a padding of 4
        .. important::
            (The padding number of 4 is hard-coded and will need to be changed
            depending on need

    Returns:
        bool: The success/failure of the rib write
    """
    if selection is None:
        try:
            selection = pm.ls(sl=True)[0]
        except IndexError:
            raise IndexError("Please select valid mesh object")
    elif len(selection) > 1:
        selection = selection[-1]

    if isinstance(selection, pm.nodetypes.Transform):
        selection = selection.getShape()

    # add attributes
    try:
        pm.addAttr(selection, longName="renderStyle", at="enum", en="Menger:Holes:Both:")
        pm.addAttr(selection, longName="Allow_Rib_Writing",
                   shortName="allowRibWrite", attributeType="bool")
        pm.addAttr(selection, longName="Is_Animated",
                   shortName="animation", attributeType="bool")
        pm.addAttr(selection, longName="depth", attributeType="byte")
        pm.addAttr(selection, longName="holes",
                   dt="string")  # :AUTHORNOTE: :WARNING: is an 8-bit int enough?
    except RuntimeError:
        pass  # one or more of the attributes already exist
    # .addAttr(selection, longName="animation", attributeType="bool")

    # set default values
    pm.setAttr(selection + ".renderStyle", 0)
    pm.setAttr(selection + ".allowRibWrite", allowRibWrite)
    pm.setAttr(selection + ".depth", depth)
    pm.setAttr(selection + ".holes", listOfHoles, type="string")
    pm.setAttr(selection + ".animation", animation)

    # Create the rman Pre Shape MEL attr.
    # We must use MEL because rman tools don't exist in Python
    mel.eval('string $attr = `rmanGetAttrName "preShapeScript"`;')
    mel.eval('rmanAddAttr ' + selection.nodeName() +
             ' $attr "myMenger3DRI(some/path/here/mengerOutput.rib)";')
    return True
# end init_attributes


def create_menger(object):
    """
    Creates the menger

    .. important::
     This script communicates which rib file to render as the current shape by using the variable outputPath

    .. note::
     Currently, file frame padding has been hard-coded to 4. May need to add a variable for
     this in the future, if necessary

    .. note::
     This function does not expect arguments but the following attributes must be
     passed through the maya object's shape node..

    Args:
        object (<pm.nodetypes.Mesh>): The object to create a menger from
        rootDir (str): The output path of the menger
        depth (int): The number of recursions created before the menger is drawn

        .. note::
            freq will not have any effect if amp is 0

        animation (bool): Enables/Disables writing/reading .rib files with
                          frame numbers, which allows for deforming animation
        allowRibWrite (bool): Lets the user save by frame number
        holes (list): A list of integers to of which indices (1-27) to remove

        Returns:
            str: The resulting (read) file path of the .rib file
    """
    shapeNode = pm.PyNode(object)  # cast to PyMEL object
    # check to make sure the user wants to write the rib

    # attrs = get_attributes(object)
    depth = pm.getAttr(object + '.depth')
    holes = pm.getAttr(object + '.holes')
    renderStyle = pm.getAttr(object + '.renderStyle')
    if renderStyle == 0:
        renderStyle="menger"
    elif renderStyle == 1:
        renderStyle = "retained"
    elif renderStyle == 2:
        renderStyle = "both"

    enableWrite = pm.getAttr(object + '.allowRibWrite')
    animation = pm.getAttr(object + '.animation')

    global OUTPUT_PATH
    fullPath = cmds.file(q=True, sceneName=True)
    OUTPUT_PATH = fullPath
    if animation:
        OUTPUT_PATH = get_output_path(OUTPUT_PATH)

    writePath = os.path.join(*os_path_split_asunder(OUTPUT_PATH)[:-2])
    fileName = os_path_split_asunder(OUTPUT_PATH)[-1]
    writePath = os.path.join(writePath, "data", fileName)
    pathShapeName = shapeNode.dagPath().replace("|", "_")
    writePath = os.path.splitext(writePath)[0] + "_{}.rib".format(pathShapeName)
    OUTPUT_PATH = writePath
    
    if not enableWrite:
        return  OUTPUT_PATH    
    
    if isinstance(shapeNode, pm.nodetypes.Transform):
        transformNode = shapeNode
        shapeNode = shapeNode.getShape()
    else:
        transformNode = shapeNode.getParent()

    boundingBox = transformNode.getBoundingBoxInvisible()
    boundingBox = get_bounding_box_local()
    # bbMinX, bbMinY, bbMinZ, bbMaxX, bbMaxY, bbMaxZ = boundingBox

    holes = [int(x.strip()) for x in holes.split(',')]

    menger = Menger3D(boundingBox, depth, holes)
    menger.writeAsCubes(OUTPUT_PATH, cube_type=renderStyle)
    return OUTPUT_PATH
# end create_menger


def get_bounding_box_local():
    """
    Gets the local-space bounding box of the menger cube's proxy.
    To speed up the execution of my scripts, which would use thousands
    of calls to this expensive method, Maya's OpenMaya API 2.0 was used.

    .. note::
        Currently works using selections, instead of passing names of objects

    """
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


def get_attributes(object):
    """
    Gets a series of attributes from a list and returns theri values in a
    dictionary This function is close to useless - I made it while I was
    testing different parameters but its function has outlived its purpose

    Args:
        object (pm.nodetypes.Mesh): The shape object to get attribuets from.
                                    Transform objects will have their shapes
                                    retrieved automatically

    Returns:
        dict: The dictionary of attribute/value pairs
    """
    shapeNode = pm.PyNode(object)
    if isinstance(shapeNode, pm.nodetypes.Transform):
        transformNode = shapeNode
        shapeNode = shapeNode.getShape()

    attributeList = ["renderStyle", 'depth', 'holes', "allowRibWrite", "animation"]
    outputDict = collections.defaultdict()
    for attr in attributeList:
        outputDict[attr] = pm.getAttr(shapeNode.nodeName() + "." + attr)
    return outputDict
# end get_attributes


def get_output_path(path):
    """
    Gets the output path, depending on whether or not animation is enabled

    Args:
        path (str): The path to modify with a frame padding

    Returns:
        str: The output path, with a proper frame padding
    """
    # drive, splitPath = os.path.splitdrive(rootDir)
    # splitPath, fileName = os_path_split_asunder(splitPath)
    # fileName, fileExt = os.path.splitext(fileName)

    # outputPath = os.path.join(drive, splitPath, fileName)
    sceneName = os_path_split_asunder(path)[-1]
    currentSceneTime = int(pm.currentTime())
    rootDir, fileExt = os.path.splitext(path)
    rootDir = rootDir + "_{}".format(str(currentSceneTime).zfill(4))
    outputPath = ''.join([rootDir, fileExt])
    return outputPath
# end get_output_path


def simulate_ribs(masterGrp, start, end):
    """
    .. important::
     This script assumes that the menger object has "Allow Rib Writing" enabled

    Simulates the scene by moving along the time slider

    Args:
        masterGrp (pm.nodetypes.Transform): The top-most group that contains 
                                            the menger proxies meshes
        ribPath (str): The full path to the .rib file to write
        start (int): The first frame to simulate
        end (int): The end frame to simulate

    Returns:
        File(s): A file in {project_main_directory}/data/sceneName_full_dagPath_frameNumber####.rib

    """
    allCubes = [x for x in pm.listRelatives(masterGrp, ad=True) \
                if isinstance(x, pm.nodetypes.Mesh)]

    currentTime = pm.currentTime()  # save the initial time
    if end < start:
        start, end = end, start  # swap
    range = end - start

    for i in xrange(range+1):
        
        pm.currentTime(i+start, e=True)
        for cube in allCubes:
            enableWriteInit = pm.getAttr(cube + ".allowRibWrite")
            isAnimatedInit = pm.getAttr(cube + ".Is_Animated")
            pm.setAttr(cube + ".Is_Animated", False)
            pm.setAttr(cube + ".allowRibWrite", 1)
            create_menger(cube)
            pm.setAttr(cube + ".Is_Animated", isAnimatedInit)
            pm.setAttr(cube + ".allowRibWrite", enableWriteInit)

    pm.currentTime(currentTime, e=True)  # set back to beginning time
# end simualte_ribs
                        

def os_path_split_asunder(path, debug=False):
    """
    IMPORTANT: before running, you must use os.path.splitdrive(path)
    and separate the drive and path. Otherwise Windows paths will
    create errors. You'll have to manually add the drive letter back in

    This method is comparably safer for splitting and merging paths
    than other methods such as replace_sep_with_string

     >>> path = r'C:\some\path'
     >>> drive, path = os.splitdrive(path)
     >>> splitPath = os_path_split_asunder(path)
     ['some', 'path']

    Args:
        path (str): The string path to be processed
        debug (bool): Whether or not to send debug information to stdout
                      to catch in a logger
    Returns:
        list: A list which contains the entire path, separated by folders
    """
    parts = []
    while True:
        newpath, tail = os.path.split(path)
        if debug: print repr(path), (newpath, tail)
        if newpath == path:
            assert not tail
            if path: parts.append(path)
            break
        parts.append(tail)
        path = newpath
    parts.reverse()
    parts = [x for x in parts if x != '']
    return parts
# end os_path_split_asunder


def set_all_menger_attrs(grp, attr, value):
    """
    Quick way to set the common attributes of all the menger cubes

    Args:
        grp (str): The name of the master group which contains 
                   all menger groups and proxies
        attr (str): The attribute to change
        value (any): The value to change the attribute to                            
    """
    allCubes = [x for x in pm.listRelatives(grp, ad=True) \
                if isinstance(x, pm.nodetypes.Mesh)]    
    for cube in allCubes:
        pm.setAttr(cube + "." + attr, value)
# end set_all_menger_attrs


def test_menger():
    """
    Quick testing module
    """
    objectName = "pPlaneShape1"
    ribPath = r"H:/tech312/python/menger2d/myMenger.rib"
    create_menger(objectName, ribPath)
# end test_menger


if __name__ == "__main__":
    # create_menger("pPlaneShape1", "H:\tech312\python\menger2d\menger_test.rib")
    # init_attributes()
    # create_menger("pCubeShape1")
    # print test_menger()
    # simulate_ribs("pPlaneShape1", "H:/tech312/python/menger2d/myMenger.rib", 10,60)
    # print(__doc__)
    # simulate_ribs(pm.PyNode("master_menger_grp"), 1, 1)
    set_all_menger_attrs(pm.PyNode("master_menger_grp"), "Allow_Rib_Writing", 0)

