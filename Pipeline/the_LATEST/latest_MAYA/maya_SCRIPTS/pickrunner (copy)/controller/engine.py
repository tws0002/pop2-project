#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
The internal modules that are actually run to initialize the environment for
pickrunner are determined here. This module is meant for strictly node-based
operations. Connections between nodes are handled in the membership module
"""

# IMPORT THIRD-PARTY LIBRARIES
import pymel.core as pm
import maya.mel as mel
from pysix import six

# IMPORT LOCAL LIBRARIES
import application as app
import membership


class PickNodeGeneric(object):
    """
    This class is used to give metadata upper-level functions and exchange data
    between other classes of similar type. At present, classes are communicating
    directly but I may have another class handle the connections between
    PickNodeGeneric classes in the future
    """
    def __init__(self, node=None, name=None):
        """
        The init statement creates a metadata node or acquires an existing one
        based on the name of the node. This node is assigned as
        self.metadataNode, which is used in a number of operations in the class.

        Args:
            node (<pm.nodetypes.PyNode>): The node to get pickrunner
                                          information from
            name (str): The name of the node that will be referenced
        """
        super(PickNodeGeneric, self).__init__()
        self.node = node
        self.nodeName = name
        if self.node is None and name is None:
            return  # do nothing
        self.metadataNode = membership.MetadataObjectMaya(node, name)        
        self.allowedDirections = app.ApplicationMaya.allowedDirections
        scriptPrefix = app.ApplicationMaya.scriptPrefix
        self.attrDefault = self.metadataNode.nodeName + "." + scriptPrefix
        self.app = app.ApplicationMaya()
    # end __init__

    def get_attr(self, inputH):
        """
        Generic get attr statement. It gets a specified direction from the
        self.metadataNode node name, casts it into a PickNodeGeneric object
        and returns it

        Args:
            inputH (str): Gets an attribute if it is valid within the context
                          of the current class

        Returns:
            <PickNodeGeneric>: Gets back a wrapped class object, using a string
                               which represents the connected metadata's name
        """
        if inputH.lower() not in self.app.nodeAttributesAll:
            raise ValueError("Input: {} not valid".format(inputH))
        retrievedNode = pm.getAttr(self.attrDefault + inputH)
        if retrievedNode is None:
            return None

        return self.__class__(self.node, retrievedNode)
    # end get_attr

    def set_attr(self, inputH, value):
        """
        Generic set attr statement. Uses the self.metadataNode to set its
        attributes and automatically unlock/set/connect/lock the given
        direction's attributes

        Args:
            inputH (str): The specified user direction. Must fit within
                          self.allowedDirections
            value (str): The name of the metadata node
        """
        if inputH.lower() not in self.app.nodeAttributesAll:
            raise ValueError("Input: {} not valid".format(inputH))

        if isinstance(value, six.string_types):
            self.metadataNode.safe_set_attr(self.attrDefault + inputH, value)
            return  # exit script early 

        # if the input isn't a string, assume it's a valid class       
        try:
            member = membership.MembershipMaya()

            if not member.is_valid_loaded_object(pm.PyNode(value.nodeName)):
                # raise pm.MayaNodeError("Tried to set {val!r} for direction, "
                #                        "{d!r} but object is not "
                #                        "valid".format(val=value, d=direction))
                raise pm.MayaNodeError()
        except pm.MayaNodeError:
            raise pm.MayaNodeError("Value: {} is not a valid maya node!".format(value.nodeName))
        except:
            raise

        self.metadataNode.safe_set_attr(self.attrDefault + inputH,
                                        value.nodeName + ".message")
    # end set_attr

    @property
    def master(self):
        """
        Gets the master node of the current metadata node. If the returning
        value is None, init the master node and connect it (default behavior)
        """
        self._master = self.get_attr("master")
        return self._master
    # end master.property

    @master.setter
    def master(self, value):
        """
        Sets master node to the given node name, if it exists.

        .. note::
            Using this setter method will override the default behavior of
            master, which is just to use the name provided by the master metadata
        """
        self.set_attr("master", value)
        self._master = value
    # end master.setter
    # end master

    @property
    def up(self):
        """
        Gets the up direction of the given node

        Returns:
            <PickNodeGeneric>: The metadata node connected to the current
                               node's "up" direction
        """
        self._up = self.get_attr("up")
        return self._up
    # end up.property

    @up.setter
    def up(self, value):
        """
        Sets the up direction of the given node

        Args:
            value (str): The object to set as the current node's up direction
        """
        self.set_attr("up", value)
        self._up = value
    # end up.setter
    # end up

    @property
    def left(self):
        """
        Gets the left direction of the given node

        Returns:
            <PickNodeGeneric>: The metadata node connected to the current
                               node's "left" direction
        """
        self._left = self.get_attr("left")
        return self._left
    # end left.property

    @left.setter
    def left(self, value):
        """
        Sets the left direction of the given node

        Args:
            value (str): The object to set as the current node's left direction
        """
        self.set_attr("left", value)
        self._left = value
    # end left.setter
    # end left

    @property
    def down(self):
        """
        Gets the down direction of the given node

        Returns:
            <PickNodeGeneric>: The metadata node connected to the current
                               node's "down" direction
        """
        self._down = self.get_attr("down")
        return self._down
    # end down.property

    @down.setter
    def down(self, value):
        """
        Sets the down direction of the given node

        Args:
            value (str): The object to set as the current node's down direction
        """
        self.set_attr("down", value)
        self._down = value
    # end down.setter
    # end down

    @property
    def right(self):
        """
        Gets the right direction of the given node

        Returns:
            <PickNodeGeneric>: The metadata node connected to the current
                               node's "right" direction
        """
        self._right = self.get_attr("right")
        return self._right
    # end right.property

    @right.setter
    def right(self, value):
        """
        Sets the right direction of the given node

        Args:
            value (str): The object to set as the current node's right direction
        """
        self.set_attr("right", value)
        self._right = value
    # end right.setter
    # end right

    # def __add__(self, other):
    #     """
    #     Adds the direction from another pickNode to
    #     the current PickNode's respective attr
    #     """
    #     try:
    #         # other.
    #         pass
    #     except:
    #         pass
    #     self.metadataNode
    # # end __add__
# end PickNodeGeneric


class MotorMaya(object):
    """
    The primary purpose of this node is to provide standard Maya objects to
    connect into and interface with pickrunner's nodetypes. While it really is
    a wrapper for PickNodeGeneric, this class provides additional methods to
    help accessing nodes simpler, as well as provide information about the
    default implementation of the class like its nodetype, name, etc.

    When you're trying to interface between nodes, this is one of the highest
    level modules.
    """
    metadataAttrName = app.ApplicationMaya.metadataAttrName
    metadataNodeType = app.ApplicationMaya.metadataNodeType

    def __init__(self, node=None):
        """
        Args:
            node (<pymel.core.nodetypes.PyNode> or str): A string to a Maya
                                                         object name or PyNode
        """
        super(MotorMaya, self).__init__()
        self.currentNode = node
        if isinstance(self.currentNode, six.string_types):
            self.currentNode = pm.PyNode(self.currentNode)

        if isinstance(self.currentNode, pm.nodetypes.Mesh):
            self.currentNode = self.currentNode.getParent()

        self.objAttr = self.currentNode + "." + self.metadataAttrName

        self.allowedDirections = app.ApplicationMaya.allowedDirections
        self.nodeName = "{}_{}".format(self.metadataAttrName,
                                       self.get_unique_name(self.currentNode))
        self.pickNodeInfo = [self.metadataNodeType, self.nodeName]
    # end __init__

    def init_metadata_proxy(self):
        """
        A wrapper statement which handles the application-specific way in
        which metadata/picknodes are instantiated
        """
        initialSelection = app.ApplicationMaya().get_selection()

        # init a master metadata node
        metaMaster = membership.MasterMetadataObjectMaya(self.metadataNodeType)

        # init the actual node in question and connect it to the master node
        pickNode = None
        try:
            pm.getAttr(self.objAttr)  # test if a metadata node exists
        except pm.MayaAttributeError:
            pm.addAttr(self.currentNode, ln=self.metadataAttrName, dt="string")
            pm.setAttr(self.objAttr, self.nodeName)
            pm.setAttr(self.objAttr, lock=True)
            self.pickNode = PickNodeGeneric(*self.pickNodeInfo)
            self.pickNode.master = metaMaster
        except:
            raise

        # restore the original selection prior to running this method
        pm.select(initialSelection)
    # end init_metadata_proxy

    def has_metadata(self, nodeType=None, name=None):
        """
        Checks a specified object with a specific nodeType for existence. If
        the node fails to be called, then the function returns False.
        If nodeType and name are both set to their default values (NoneType),
        then the current class's self.pickNodeInfo is used instead

        Args:
            nodeType (str): The name of the class to use for checking
            name (str): The name of the metadata object to check
        Returns:
            bool: True/False
        """
        if nodeType is None and name is None:
            nodeType, name = self.pickNodeInfo

        try:
            if not isinstance(pm.PyNode(name), self.metadataNodeType):
                raise pm.MayaNodeError
        except pm.MayaNodeError:
            return False

        return True
    # end has_metadata

    def get_unique_name(self, node, nodeName=False):
        """
        Gets a unique name for the current node. Defaults to getting a node's
        UUID but it can also get the node's name, instead
        You can also just pass the input node thru and output a name, if needed

        Args:
            node (<pymel.core.nodetype.PyNode> or str): The name of the node to
                                                        get the UUID of
            nodeName (bool): When specified, the function returns the dag path
                             to the node, rather than the UUID (the default
                             implementation)

        Returns:
            str: The UUID of the passed object or its dag path
        """
        if nodeName:
            return node
        mel.eval('$SOMETHING = `ls -uuid "{}"`;'.format(node.nodeName()))
        UUID = mel.eval('$temp=$SOMETHING')[0]
        UUID = UUID.replace("-", "_")
        return UUID
    # end get_unique_name

    def get_master_node(self, node=None):
        """
        Gets the master node for a given PickNode
        """
        return node.master
    # end get_master_node

    @property
    def members(self):
        """
        An intermediary property which returns the current class's PickNode.
        The picknode is typically used to access connected directions, if not
        to simply be created if it hasn't been already

        Returns:
            <PickNodeGeneric>: The picknodw for the current Maya object
        """
        # pickNode = PickNodeGeneric(self.currentNode, self.nodeName)
        pickNode = PickNodeGeneric(self.metadataNodeType, self.nodeName)

        if pickNode.master is None:
            pickNode.master = membership.MASTER_NODE_NAME + ".message"
        return pickNode
    # end members

    def __cmp__(self, other):
        """
        Comparison constructor
        """
        if self.nodeName == other.nodeName:
            return 0
        elif self.nodeName != other.nodeName:
            # :NOTE: -1 is actually reserve for < but because we're comparing 
            # strings and not numbers, this < and > don't matter to us
            #
            return -1
# end MotorMaya


def test_get_left():
    motor = engine.MotorMaya("centerLoc1")
    print motor.members.left
# end test_get_left


def test_set_left():
    motor = engine.MotorMaya("centerLoc1")
    motor.members.left = "_PickRunner_metadata_57A839D5_4F86_5858_E26F_59A861938199"
# end test_set_left

def test_large_scene():
    # create a grid of locators
    locatorDictH = {}
    gridOfLocators = (10, 10)
    spacing = 4
    offsetX = -4.5 * 4
    offsetY = 5
    for x in xrange(gridOfLocators[0]):
        for y in xrange(gridOfLocators[1]):
            locator = pm.spaceLocator()
            xCoord = (spacing * x) + offsetX
            yCoord = (spacing * y) + offsetY
            locator.translate.set([xCoord, yCoord, 0])
            locator.rotate.set([-45, -45, -45])
            position = (x,y)
            locatorDictH.update({position: locator})    

    # set-up connections
    for position, locator in locatorDictH.iteritems():
        x, y = position
        otherPositions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        motor = engine.MotorMaya(locator)
        motor.init_metadata_proxy()
        for num, pos in enumerate(otherPositions):
            posX = pos[0]
            posY = pos[1]
            try:
                adjacentLoc = locatorDictH[x+posX, y+posY]
            except KeyError:
                # skip, the index locator doesn't exist at this position
                continue

            adjMotor = engine.MotorMaya(adjacentLoc)
            adjMotor.init_metadata_proxy()
            if num == 0:  # up
                motor.members.up = adjMotor
            elif num == 1:  # left
                motor.members.left = adjMotor
            elif num == 2:  # down
                motor.members.down = adjMotor
            elif num == 3:  # right
                motor.members.right = adjMotor
# test_large_scene


# ##############################################
# import sys
# sys.path.append("/home/ckenne24/mount/stuhome/test1/pyhk-master")
# sys.path.append("/home/ckenne24/mount/stuhome/test1/pyHook-1.5.1")
# import functools
# import pyhk


# def foo(direction):
#     print direction


# def main():
#     upArrow = functools.partial(foo, direction="up")
#     leftArrow = functools.partial(foo, direction="left")
#     downArrow = functools.partial(foo, direction="down")
#     rightArrow = functools.partial(foo, direction="right")        
    
#     hot = pyhk.pyhk()
#     hot.addHotkey(['Ctrl', 'Alt','7'],upArrow)
#     hot.addHotkey(['Ctrl', 'Alt','8'],leftArrow)
#     hot.addHotkey(['Ctrl', 'Alt','9'],downArrow)    
#     hot.addHotkey(['Ctrl', 'Alt','0'],rightArrow)    


# if __name__ == "__main__":
#     main()    
# ###############################################





# ###############################################
# try:
#     reload(pickrunner)
# except NameError:
#     pass
# except:
#     raise
    
# try:
#     reload(application)
#     reload(membership)
#     reload(engine)
#     reload(basegui)
# except NameError:
#     import pickrunner.controller.application as application
#     import pickrunner.controller.membership as membership
#     import pickrunner.controller.engine as engine
#     import pickrunner.view.basegui as basegui
# except:
#     raise    
    
# import pickrunner.pickrunner as pickrunner
# pickrunner.show_gui()
# ###############################################









if __name__ == "__main__":
    print(__doc__)