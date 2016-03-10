#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Determines how the metadata nodes in Maya are laid out and initialized. Most
other modules are wrappers to the following module (thus, most of its methods)
are fairly low-level and application-specific

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
membership.py
"""

# IMPORT STANDARD LIBRARIES
import inspect

# IMPORT THIRD-PARTY LIBRARIES
try:
    import pymel.core as pm
except ImportError:
    raise EnvironmentError("Not in a Maya environment")

# IMPORT LOCAL LIBRARIES
import pickrunner.controller.application as app
import six.six as six
import header

__author__ = header.__author__
__copyright__ = header.__author__
__license__ = header.__license__
__version__ = header.__version__
__email__ = header.__email__
__status__ = header.__status__


MASTER_NODE_NAME = app.ApplicationMaya.scriptPrefix + "MASTER"


class MasterMetadataObjectMaya(object):
    """
    In all implementations of metadata in Maya, one node is said to be the
    "master" which is always connected to every other node. This is done to
    aide in the process of importing/exporting metadata
    """
    def __init__(self, node, name=MASTER_NODE_NAME):
        """
        Args:
            node (<pymel.core.nodetypes.PyNode or str): The node to be cast to
                                                        metadata object
            name (str): The name that will be given to the metadata Maya node
        """
        super(MasterMetadataObjectMaya, self).__init__()
        self.node = node
        self.nodeName = name
        self.connector = self.nodeName + ".message"
        self.init()
    # end __init__

    def init(self):
        """
        Prepares the node to be used for metadata, whether that be
        locking/hiding information or initializing new attributes
        """
        self.init_current_metadata_node()
    # end init

    def init_current_metadata_node(self):
        """
        Creates the metadata node used by the current class instance
        """
        try:
            pm.PyNode(self.nodeName)  # find the node if it exists
        except pm.MayaNodeError:
            self.create_new_node()
        except:
            raise
    # end init_current_metadata_node

    def create_new_node(self):
        """
        Creates a metadata Maya node
        """
        self.app = app.ApplicationMaya()
        initialSelection = self.app.get_selection()
        pm.createNode(self.node, n=self.nodeName)  # create it if it does not
        self.remove_prexisting_attrs()
        self.app.select(initialSelection)
    # end create_new_node

    def remove_prexisting_attrs(self):
        """
        Since the class relies on a Maya nodes and there is no "empty" node,
        KeyingGroup was arbitrarily picked for creating metadata nodes. The
        problem is that Maya nodes typically come with their own attributes
        when they're created. To clean up our metadata node, the node
        attributes will be removed, locked, and hidden.
        """
        allAttrs = ["minimizeRotation", "category"]

        for attr in allAttrs:
            try:
                pm.setAttr(self.nodeName + "." + attr,
                           lock=True, keyable=False, channelBox=False)
            except pm.MayaAttributeError:
                pass
    # end remove_prexisting_attrs

    def safe_set_attr(self, attr, value, connectAttr=True):
        """
        Wrapper method that ensure that methods open/close properly.
        Currently, it unlocks the attribute, sets the string to the new node,
        connects up the node's message attribute, and then locks it all again

        Args:
            attr (str): The name of that object + the attribute name to set
            value (str): The name of the object to set attr to. After attr is
                         set as a string, value + ".message" will be used to
                         connect the node that value represents to the current
                         node's attr attribute
            connectAttr (bool): If not set, the method will simply set the
                                attribute's value and not do any
                                disconnect/connect
        """
        pm.setAttr(attr, lock=False)
        if connectAttr:
            pm.disconnectAttr(attr)  # remove existing connections
        _, attrWithoutNodeName = attr.split(".")

        if len(value.split(".")) > 1:
            nodeName, _ = value.split(".")
        else:
            nodeName = value

        pm.setAttr(attr, nodeName)
        if connectAttr:
            pm.connectAttr(value, attr)
        pm.setAttr(attr, lock=True)
    # end safe_set_attr
# end MasterMetadataObjectMaya

class MetadataObjectMaya(MasterMetadataObjectMaya):
    """
    Manages configuration of data nodes
    """
    def __init__(self, node, name):
        """
        Args:
            node (<pymel.core.nodetypes.PyNode or str): The node to be cast to
                                                        metadata object
            name (str): The name of the (acquired or newly created) object
        """
        self.attrsToCreate = app.ApplicationMaya.nodeAttributesAllWithPrefix
        self.node = node
        self.nodeName = name
        self.uuid = self.get_uuid_from_name()
        if self.uuid.strip() != "":
            if app.ApplicationMaya().ls(self.uuid) != []:
                self.linkedNodeName = app.ApplicationMaya().ls(self.uuid)[0]
        super(MetadataObjectMaya, self).__init__(node, name)
        self.init()
    # end __init__

    def create_new_node(self):
        """
        Creates a new metadata node and inits some default values into the
        node's attributes
        """
        super(MetadataObjectMaya, self).create_new_node()
        self.init_defaults()
    # end create_new_node

    def init_defaults(self):
        """
        Generic init statement
        """
        if len(self.attrsToCreate) == 0:
            return  # exit script early

        for attr in self.attrsToCreate:
            pm.addAttr(self.nodeName, ln=attr, dt="string")
            pm.setAttr(self.nodeName + "." + attr, lock=True)

        # Set any defaults in our metadata (the attributes were previously
        # created using the metadata nodetypes)
        UUID = self.get_uuid_from_name()
        if UUID is not None:
            UUID = UUID.replace("_", "-")

            nodeName = pm.ls(UUID)[0].nodeName()

        self.safe_set_attr(self.nodeName + "._PickRunner_UUID",
                           UUID + ".null",
                           connectAttr=False)

        self.safe_set_attr(self.nodeName + "._PickRunner_node",
                           nodeName + ".null",
                           connectAttr=False)
    # end init_defaults

    def get_uuid_from_name(self, formatted=True):
        """
        Takes the input name and gets its UUID and returns it

        .. note::
            This method assumes that there is a "_" after the specified
            nodeNamePrefix, which was defined previously in the MotorMaya class

        Args:
            formatted (bool): Replaces all unsupported Maya characters with
                              "_". It's used mainly to help Maya when using
                              UUID in it's object node's names

        Returns:
            str: The universally unique ID UUID of the given Maya node
        """
        nodeNamePrefix = app.ApplicationMaya.metadataAttrName
        uuid = self.nodeName[len(nodeNamePrefix + "_"):]
        if formatted:
            uuid = uuid.replace("_", "-")
        return uuid
    # end get_uuid_from_name

    def get_name_from_uuid(self, uuid=None):
        """
        Gets a node using the UUID. If no uuid is given, it defaults to the
        current metadata object's UUID from self.get_uuid_from_name

        Args:
            uuid (str): The UUID to look-up the Maya object's name of

        Returns:
            <pymel.core.PyNode>: The node corresponding to the given UUID
        """
        if uuid is None:
            uuid = self.uuid
        if uuid.strip() != "":
            try:
                return pm.ls(uuid)[0]
            except IndexError:
                # no valid object was found for the given UUID
                pass
            except:
                raise
    # end get_name_from_uuid
# end MetadataObjectMaya


class BaseMembership(object):
    """
    BaseMembership is not meant to be directly implemented in applications but
    used as a template for subclasses.
    """
    metadataAttrName = "attributeName"
    metadataNodeType = "someNodeName"

    def __init__(self):
        super(BaseMembership, self).__init__()
    # end __init__
# end BaseMembership


class MembershipMaya(BaseMembership):
    """
    Manages connections between objects and other method association in Maya
    """
    def __init__(self):
        super(MembershipMaya, self).__init__()
    # end __init__

    def is_valid_loaded_object(self, obj):
        """
        Makes sure that the object is OK to use in the application's scripts.
        It does this by checking if the passed obj inherits from PyMEL's
        "PyNode" class, which is the highest-level class that DAG and non-DAG
        nodes depend from

        Args:
            obj (<pymel.core.PyNode> or str): The object to check validity of

        Returns:
            bool: True/False
        """
        if isinstance(obj, six.string_types):
            try:
                obj = pm.PyNode(obj)
            except pm.MayaNodeError:
                return False

        inheritors = inspect.getmro(obj.__class__)
        if pm.nodetypes.DependNode in inheritors:
            return True
        return False
    # end is_valid_loaded_object

    def select(self, *args):
        """
        Selects one or more objects passed

        Args:
            args (<pymel.core.PyNode> or str): The object to select
        """
        app.ApplicationMaya().select(args)
    # end select
# end MembershipMaya


if __name__ == "__main__":
    print(__doc__)
