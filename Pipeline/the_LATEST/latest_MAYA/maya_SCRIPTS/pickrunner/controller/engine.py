#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The internal methods that are actually run to initialize the environment for
pickrunner are determined here. This module is meant for strictly node-based
operations. Information about the nodes have been placed in the
:doc:`membership` module

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
engine.py
"""

# IMPORT STANDARD LIBRARIES
import operator
from collections import defaultdict

# IMPORT THIRD-PARTY LIBRARIES
import pymel.core as pm
import maya.mel as mel
import pickrunner.model.six.six as six
import pickrunner.model.header as header

# IMPORT LOCAL LIBRARIES
import pickrunner.model.membership as membership
import application as app


__author__ = header.__author__
__copyright__ = header.__author__
__license__ = header.__license__
__version__ = header.__version__
__email__ = header.__email__
__status__ = header.__status__


class PickNodeGeneric(object):
    """
    This class is used to give metadata objects upper-level functions and, to
    an extent, some data exchange between other classes of similar type.
    """
    def __init__(self, node=None, name=None):
        """
        The init statement creates a metadata node or acquires an existing one
        based on the name argument. This node is assigned as self.metadataNode
        within the current class instance, which is used in a number of
        operations within the class.

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

        retrievedNode = None
        try:
            retrievedNode = pm.getAttr(self.attrDefault + inputH)
        except pm.MayaAttributeError:
            # Attempt to create the missing attribute (assuming that it exists
            # in self.app.nodeAttributesAll)
            #
            allowedDirectionsDict = app.ApplicationMaya.allowedDirectionsDict
            attributeAddFunc = allowedDirectionsDict[inputH]["createFunction"]
            attributeAddFunc(self.metadataNode.nodeName)
        except:
            pass

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
            value (<MotorMaya> or str): The name of the metadata node the
                                        MotorMaya instance
        """
        if inputH.lower() not in self.app.nodeAttributesAll:
            raise ValueError("Input: {} not valid".format(inputH))

        if isinstance(value, six.string_types):
            self.metadataNode.safe_set_attr(self.attrDefault + inputH, value)
            return  # exit script early

        # if the input isn't a string, assume it's valid metadata class
        try:
            member = membership.MembershipMaya()
            if not member.is_valid_loaded_object(pm.PyNode(value.nodeName)):
                raise pm.MayaNodeError()
        except pm.MayaNodeError:
            membership.MetadataObjectMaya(app.ApplicationMaya.metadataNodeType,
                                          value.nodeName)
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

        Returns:
            <PickNodeGeneric>: The class representing the metadata connection,
                               which is retrieved by parsing the attribute-str
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
            master, which just to uses the name provided by the master metadata

        Args:
            value (str): The object name which will be
                         the current node's master reference
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
            <PickNodeGeneric>: The class representing the metadata connection,
                               which is retrieved by parsing the attribute-str
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
            <PickNodeGeneric>: The class representing the metadata connection,
                               which is retrieved by parsing the attribute-str
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
            <PickNodeGeneric>: The class representing the metadata connection,
                               which is retrieved by parsing the attribute-str
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
            <PickNodeGeneric>: The class representing the metadata connection,
                               which is retrieved by parsing the attribute-str
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
# end PickNodeGeneric


class MotorMaya(object):
    """
    The primary purpose of this node is to provide standard Maya objects a way
    to connect into and interface with pickrunner's nodetypes. While it is a
    wrapper for PickNodeGeneric, this class provides additional methods to
    help accessing nodes simpler, as well as provide information about the
    default implementation of the class like its nodetype, name, etc.
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
        if node is None:
            return

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
        try:
            pm.getAttr(self.objAttr)  # test if a metadata node exists
            self.pickNode = PickNodeGeneric(*self.pickNodeInfo)
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
        if nodeType is None:
            nodeType = self.pickNodeInfo[0]
        if name is None:
            name = self.pickNodeInfo[1]

        try:
            if not isinstance(pm.PyNode(name), self.metadataNodeType):
                raise pm.MayaNodeError
        except pm.MayaNodeError:
            return False

        return True
    # end has_metadata

    def walk(self, direction, steps):
        """
        Moves through the motor and returns a PickNode at a certain distance
        (steps) away from the current MotorMaya instance. If no PickNode exists
        at that given distance, the last known PickNode is returned

        Args:
            direction (str): The direction to walk in
            steps (int): The number of times to walk in a direction

        Returns:
            <PickNodeGeneric>: The node that is direction * steps away from the
                               given MotorMaya object. If there is no valid node
                               at this location, the last known node is used
        """
        direction = direction.lower()
        if direction not in self.allowedDirections:
            raise RuntimeError("Something went wrong. GUI got an "
                               "invalid direction")

        # Parse the direction
        walk = self.members
        for step in xrange(steps):
            temp = getattr(walk, direction)
            if temp is not None:
                walk = temp
            else:
                break
        return walk
    # end walk

    def get_pick_node(self):
        """
        Gets the PickNode for the current MotorMaya instance and creates within
        the PickNodeGeneric instantiation if it didn't already exist

        Returns:
            <PickNodeGeneric>: The PickNode for the current MotorMaya instance
        """
        obj = PickNodeGeneric(*self.pickNodeInfo)
        return obj
    # end get_pick_node

    def get_object_hierarchy(self, name="_PickRunner_MASTER"):
        """
        Given a node, the function will get every connected PickNodeGeneric
        object connected from Maya's outgoing connections. The default
        implementation of the current function is to return all nodes under
        PickRunner's master node but any node can be supplied

        Args:
            name (str): The name of the metadata node to retrieve it's outgoing
                        connections of

        Returns:
            list of tuples: Each tuple contains the key/item pair of a
                            dictionary (originally cast from a defaultdict
                            object)
        """
        # Make dictionary for every node, with its connections as its item
        finalDictH = defaultdict(dict)
        appl = app.ApplicationMaya()
        motor = PickNodeGeneric(pm.nodetypes.KeyingGroup, name)
        outgoingConnections = appl.get_outgoing_connections(motor.nodeName)
        for cnt in outgoingConnections:
            connection = PickNodeGeneric(appl.metadataNodeType, cnt.nodeName())
            for direction in appl.allowedDirections:
                connectedObj = getattr(connection, direction)

                try:
                    outputName = connectedObj.nodeName
                except AttributeError:
                    outputName = None
                except:
                    raise

                finalDictH[str(cnt.nodeName())].update({direction: outputName})

        if finalDictH is {}:
            return None

        # Get the number of items, sort it and return
        for key, items in finalDictH.iteritems():
            items["items"] = len([x for x in items if items[x] is not None])
            finalDictH[key] = items
        finalDictH = sorted(finalDictH.items(), key=operator.itemgetter(0))
        return finalDictH
    # get object_hierarchy

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
        Gets the master node connection for a given PickNodeGeneric

        Args:
            node (<PickNodeGeneric>): The node to query

        Returns:
            <PickNodeGeneric>: The master node connected to the current node
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
        pickNode = PickNodeGeneric(*self.pickNodeInfo)

        # force a connection between the picknode and master, if none exists
        if pickNode.master is None:
            pickNode.master = membership.MASTER_NODE_NAME + ".message"
        return pickNode
    # end members

    def __cmp__(self, other):
        """
        Comparison constructor - checks if both MotorMaya instances are the
        same by comparing their given nodeNames

        Args:
            other (<MotorMaya>): Another MotorMaya or class of similar type

        Returns:
            int: 0 Means that the two nodes are equal, -1 not equal
        """
        if self.nodeName == other.nodeName:
            return 0
        elif self.nodeName != other.nodeName:
            # :NOTE: -1 is actually reserve for < but because we're comparing
            # strings and not numbers, this < and > don't matter to us
            #
            return -1
    # end __cmp__

    def delete(self):
        """
        Deletes the Maya node metadata of the current class
        """
        if self.has_metadata():
            node = pm.PyNode(self.get_pick_node().nodeName)
            for attr in pm.listAttr(node, l=True):
                if pm.connectionInfo(node + "." + attr, isSource=True):
                    pm.setAttr(attr, l=False)
                else:
                    pm.setAttr(node + "." + attr, l=False)

            connections = pm.listConnections(node, s=False, d=True, p=True)
            for connection in connections:
                connect = pm.listConnections(connection, s=True, p=True)
                for c in pm.connectionInfo(connect, dfs=True):
                    pm.setAttr(c, l=False)


            pm.disconnectAttr(node)
            pm.delete(node)
    # end delete

    def disconnect(self, allowedNodeAttrs=True, *args, **kwargs):
        """
        Deletes a given connection from the current instance's message and
        another instance's given attribute

        Args:
            allowedNodeAttrs (bool): If True, the function will not allow the
                                     disconnection of attributes that are not
                                     also listed in
                                     :ref:`app_AppMaya_nodeAttributesAll`
        """
        src = PickNodeGeneric(*self.pickNodeInfo).nodeName + ".message"
        dest = ""
        for arg in args:
            dest += arg

        self.app = app.ApplicationMaya
        if allowedNodeAttrs and dest not in self.app.nodeAttributesAll:
            raise ValueError("Destination: {} not in allowed values, "
                             "{}".format(dest, self.app.nodeAttributesAll))
            return  # do nothing

        pm.setAttr(dest, l=False)
        pm.disconnectAttr(src, dest)
    # end disconnect
# end MotorMaya


if __name__ == "__main__":
    print(__doc__)
