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
import sys
sys.path.append("/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATESTDEV/latest_MAYA/maya_SCRIPTS/pickrunner/controller")

# reload(application)
import application
from pysix import six

SCRIPT_PREFIX = "_PickRunner_"
MASTER_NODE_NAME = SCRIPT_PREFIX + "MASTER"


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
        self.application = application.ApplicationMaya()
        initialSelection = self.application.get_selection()
        pm.createNode(self.node, n=self.nodeName)  # create it if it does not
        self.remove_prexisting_attrs()      
        self.application.select(initialSelection)
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
        pm.disconnectAttr(attr)
        pm.setAttr(attr, value)
        attrWithoutNodeName = attr.split(".")[-1]
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
        self.attrsToCreate = application.ApplicationMaya().nodeAttributesAll
        self.node = node
        self.nodeName = name
        super(MetadataObjectMaya, self).__init__(node, name)                        
        self.init()
    # end __init__

    def init(self):
        """
        Prepares the node to be used for metadata, whether that be
        locking/hiding information or initializing new attributes
        """
        self.init_current_metadata_node()
        # Connect up the node to the master node
        masterNode = self.init_master_node()
        self.safe_set_attr("{}.{}".format(self.nodeName, SCRIPT_PREFIX + "master"), masterNode.nodeName + ".message")
    # end init
                
    def init_master_node(self):
        """
        Null
        """
        masterNode = MasterMetadataObjectMaya(self.node)
        return masterNode
    # end init_master_node
    
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

        attrsToCreate = [SCRIPT_PREFIX + x for x in self.attrsToCreate]

        for attr in attrsToCreate:
            pm.addAttr(self.nodeName, ln=attr, dt="string")
            pm.setAttr(self.nodeName + "." + attr, lock=True)
    # end init_defaults
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
# end MembershipMaya


if __name__ == "__main__":
    MetadataObjectMaya(pm.nodetypes.KeyingGroup, "name")
