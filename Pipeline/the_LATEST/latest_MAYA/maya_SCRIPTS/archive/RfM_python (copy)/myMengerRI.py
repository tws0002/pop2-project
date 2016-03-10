#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
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
"""

# IMPORT STANDARD LIBRARIES
import os
import collections

# IMPORT THIRD-PARTY LIBRARIES
import pymel.core as pm
import maya.cmds as cmds
import maya.mel as mel

# IMPORT LOCAL LIBRARIES
from menger2d_rman import Menger2D_Rman


################################################################################
OUTPUT_PATH = ""


def init_attributes(selection=None, depth=3, freq=0.5, offset=0,
                    amp=3, maxAmp=10, holes=8, allowRibWrite=1, animation=1):
    """
    Adds attributes to the selected object's shape node for making the menger

    Args:
        selection (pm.nodetypes.Mesh): The object to add attributes to. If a
                                       transform is passed, its shape is retrieved
        depth (int): The number of recursions the menger undergoes before
                     creating its planes and holes.
        .. note::
            Any value above in depth will cause noticeably slower render times
        freq (float): The wavelength of sine wave used on the menger
        offset (float): A phase attribute which, if animated, causes the
                        menger to "move" from the center
        amp (float): The height of the menger's sine pattern (in both directions)
        maxAmp (float): A clamp value, to make sure amplitude does not exceed a
                        certain height
        holes (int): The number and likelihood of adding random holes to the menger
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
        pm.addAttr(selection, longName="Allow_Rib_Writing", shortName="allowRibWrite", attributeType="bool")
        pm.addAttr(selection, longName="Is_Animated", shortName="animation", attributeType="bool")
        pm.addAttr(selection, longName="seed", attributeType="byte")  # :AUTHORNOTE: :WARNING: is an 8-bit int enough?
        pm.addAttr(selection, longName="depth", attributeType="byte")
        pm.addAttr(selection, longName="offset", attributeType="float")
        pm.addAttr(selection, longName="frequency", shortName="freq", attributeType="float")
        pm.addAttr(selection, longName="amplitude", shortName="amp", attributeType="float")
        pm.addAttr(selection, longName="Maximum_Amplitude", shortName="maxAmp", attributeType="float")
        pm.addAttr(selection, longName="holes", attributeType="byte")  # :AUTHORNOTE: :WARNING: is an 8-bit int enough?
    except RuntimeError:
        pass  # one or more of the attributes already exist
    # .addAttr(selection, longName="animation", attributeType="bool")

    # set default values
    pm.setAttr(selection + ".allowRibWrite", allowRibWrite)
    pm.setAttr(selection + ".depth", depth)
    pm.setAttr(selection + ".freq", freq)
    pm.setAttr(selection + ".offset", offset)
    pm.setAttr(selection + ".amp", amp)
    pm.setAttr(selection + ".maxAmp", maxAmp)
    pm.setAttr(selection + ".holes", holes)
    pm.setAttr(selection + ".animation", animation)

    # Create the rman Pre Shape MEL attr. We must use MEL because rman tools don't exist in Python
    mel.eval('string $attr = `rmanGetAttrName "preShapeScript"`;')
    # mel.eval('rmanAddAttr ' + selection.nodeName() + ' $attr "myMengerRI(\"H:/tech312/python/menger2d/output/mengerOutput.rib\")";')
    mel.eval('rmanAddAttr ' + selection.nodeName() + ' $attr "myMengerRI(some/path/here/mengerOutput.rib)";')
    return True
# end init_attributes


def create_menger(object, rootDir):
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
        depth, freq, amp, maxAmp, holes, seed, animation=False
    """
    shapeNode = pm.PyNode(object)  # cast to PyMEL object
    # check to make sure the user wants to write the rib

    attrs = get_attributes(object)
    depth = attrs['depth']
    freq = attrs['frequency']
    offset = attrs['offset']
    amp = attrs['amplitude']
    maxAmp = attrs['maxAmp']
    holes = attrs['holes']
    seed = attrs['seed']
    enableWrite = attrs['allowRibWrite']
    animation = attrs['animation']

    global OUTPUT_PATH
    OUTPUT_PATH = rootDir
    if animation:
        OUTPUT_PATH = get_output_path(rootDir)
    if not enableWrite:
        return  # end script prematurely

    if isinstance(shapeNode, pm.nodetypes.Transform):
        transformNode = shapeNode
        shapeNode = shapeNode.getShape()
    else:
        transformNode = shapeNode.getParent()

    boundingBox = transformNode.getBoundingBoxInvisible()
    # bbMinX, bbMinY, bbMinZ, bbMaxX, bbMaxY, bbMaxZ = boundingBox

    menger = Menger2D_Rman(boundingBox, depth)
    menger.writePolygons(OUTPUT_PATH, freq, amp, maxAmp, offset)
    return OUTPUT_PATH
# end create_menger


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

    attributeList = ['depth', 'frequency', 'amplitude', 'offset',
                     'maxAmp', 'holes', 'seed', "allowRibWrite", "animation"]
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
    currentSceneTime = int(pm.currentTime())
    rootDir, fileExt = os.path.splitext(path)
    rootDir = rootDir + "_{}".format(str(currentSceneTime).zfill(4))
    outputPath = ''.join([rootDir, fileExt])
    return outputPath
# end get_output_path


def simulate_ribs(object, ribPath, start, end):
    """
    .. important::
     This script assumes that the menger object has "Allow Rib Writing" enabled

    Simulates the scene by moving along the time slider
    """
    currentTime = pm.currentTime()  # save the initial time
    if isinstance(object, pm.nodetypes.Transform):
        object = object.getShape()
    enableWriteInit = pm.getAttr(object + ".allowRibWrite")
    pm.setAttr(object + ".allowRibWrite", 1)
    if end < start:
        start, end = end, start  # swap
    range = end - start

    for i in xrange(range+1):
        pm.currentTime(i+start, e=True)
        create_menger(object, ribPath)

    pm.currentTime(currentTime, e=True)  # set back to beginning time
    pm.setAttr(object + ".allowRibWrite", enableWriteInit)
# end simulate_ribs


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
    # print test_menger()
    # simulate_ribs("pPlaneShape1", "H:/tech312/python/menger2d/myMenger.rib", 10,60)
    pass
