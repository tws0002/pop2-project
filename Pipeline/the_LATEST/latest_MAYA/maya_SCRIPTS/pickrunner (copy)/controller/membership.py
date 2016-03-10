#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Determines how and in what way pickwalk members are laid out
"""

# IMPORT STANDARD LIBRARIES
import inspect

# IMPORT THIRD-PARTY LIBRARIES
try:
    import pymel.core as pm
except ImportError:
    raise EnvironmentError("Not in a Maya environment")

# IMPORT LOCAL LIBRARIES
import application as app
from pysix import six


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
        self.app = app.ApplicationMaya()
        initialSelection = self.app.get_selection()
        pm.createNode(self.node, n=self.nodeName)  # create it if it does not
        self.remove_prexisting_attrs()      
        self.app.select(initialSelection)
    # end create_new_node

    def remove_prexisting_attrs(self):
        """
        Maya nodes typically come with their own attributes to start out. To
        clean up our metadata node, the node attributes will be removed, locked,
        and hidden.
        """
        allAttrs = ["minimizeRotation", "category"]

        for attr in allAttrs:
            try:
                pm.setAttr(self.nodeName + "." + attr,
                           lock=True, keyable=False, channelBox=False)
            except pm.MayaAttributeError:
                pass
    # end remove_prexisting_attrs  

    def safe_set_attr(self, attr, value):
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
        """
        pm.setAttr(attr, lock=False)
        pm.disconnectAttr(attr)  # remove existing connections
        _, attrWithoutNodeName = attr.split(".")
        nodeName, _ = value.split(".")
        pm.setAttr(attr, nodeName)
        pm.connectAttr(value, attr)
        pm.setAttr(attr, lock=True)
    # end safe_set_attr
# end MasterMetadataObjectMaya

class MetadataObjectMaya(MasterMetadataObjectMaya):
    """
    Manages configuration of data nodes (probably should be in the model folder)
    """
    def __init__(self, node, name):
        """
        Args:
            node (<pymel.core.nodetypes.PyNode or str): The node to be cast to
                                                        metadata object
            name (str): The name of the (acquired or newly created) object
        """
        self.attrsToCreate = app.ApplicationMaya().nodeAttributesAll
        self.node = node
        self.nodeName = name
        self.uuid = self.get_uuid_from_name()
        if self.uuid.strip() != "":
            self.linkedNodeName = app.ApplicationMaya().ls(self.uuid)[0]
        super(MetadataObjectMaya, self).__init__(node, name)
        self.init()
    # end __init__
    
    def create_new_node(self):    
        super(MetadataObjectMaya, self).create_new_node()
        self.init_defaults()
    # end create_new_node
    
    def init_defaults(self):
        """
        Generic init statement
        """
        if len(self.attrsToCreate) == 0:
            return  # exit script early
        scriptPrefix = app.ApplicationMaya.scriptPrefix
        attrsToCreate = [scriptPrefix + x for x in self.attrsToCreate]

        for attr in attrsToCreate:
            pm.addAttr(self.nodeName, ln=attr, dt="string")
            pm.setAttr(self.nodeName + "." + attr, lock=True)
    # end init_defaults

    def get_uuid_from_name(self):
        """
        Takes the input name and gets its UUID and returns it
        .. note::
            This method assumes that there is a "_" after the specified 
            nodeNamePrefix, which was defined previously in the MotorMaya class
        """
        nodeNamePrefix = app.ApplicationMaya.metadataAttrName
        uuid = self.nodeName[len(nodeNamePrefix + "_"):]
        uuid = uuid.replace("_", "-")
        return uuid
    # end get_uuid_from_name
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
    Manages connections between objects and other methods os association in Maya
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
            args (<pymel.core.PyNode> or str): The object to check validity of
        """
        app.ApplicationMaya().select(args)
    # end select
# end MembershipMaya


if __name__ == "__main__":
    print(__doc__)
    # MetadataObjectMaya(pm.nodetypes.KeyingGroup, "name")
