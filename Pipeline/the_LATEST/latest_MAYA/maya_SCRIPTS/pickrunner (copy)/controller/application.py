#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Anything that isn't directly related to the nodes from pickrunner
but is also specific per-application goes here
"""

# IMPORT THIRD-PARTY LIBRARIES
try:
    import pymel.core as pm
except ImportError:
    raise EnvironmentError("Not in a Maya environment")


class BaseApplication(object):
    """
    Any base-application information is defined here. The class isn't meant to
    be directly implemented but rather subclasses and customized on a
    per-application basis
    """
    def __init__(self):
        super(BaseApplication, self).__init__()
    # end __init__

    def get_selection(self):
        """
        Gets the current scene selection. The default behavior in the base
        class is to simply raise an exception, since the base class shouldn't
        be aware of any application-specific data
        """
        raise NotImplementedError("The BaseEngine class has no implementation "
                                  "for application-specific methods. Subclass "
                                  "the current class and overwrite it")
    # end get_selection
# end BaseApplication


class ApplicationMaya(object):
    """
    Maya-specific methods that don't specifically relate to the current
    application's drawing of the GUI or node creation are specified within the
    given class
    """
    scriptPrefix = "_PickRunner_"
    allowedDirections = ["up", "left", "down", "right"]
    allowedDirectionsWithPrefix = [scriptPrefix + x for x in allowedDirections]
    nodeAttributesAll = allowedDirections + ["master"]
    metadataNodeType = pm.nodetypes.KeyingGroup
    metadataAttrName = scriptPrefix + "metadata"

    def __init__(self):
        super(ApplicationMaya, self).__init__()
    # end __init__

    def get_selection(self):
        """
        Gets the current scene selection, returns a valid PyNode object

        Returns:
            <pymel.core.PyNode>: The returned node
        """
        return pm.ls(sl=True)
    # end get_selection

    def select(self, *args):
        """
        Selects one or more objects passed

        Args:
             args (<pymel.core.PyNode> or str): The object to check validity of
        """
        pm.select(cl=True)
        for arg in args:
            # :AUTHORNOTE: :CHECK: Does this method work
            pm.select(arg, tgl=True)
        return self.get_selection()
    # end select

    def ls(self, obj, *args, **kwargs):
        """
        Application-specific way of listing files
        """
        return pm.ls(obj)
    # end ls

    def get_outgoing_connections(self, node):
        """
        Manages and gets all of the outgoing connections of the given class
        (all connections that are relevent to pickrunner)

        Args:
            node (<engine.PickNodeGeneric>): The node whose connections to query

        Returns:
            dict: The dictionary keeps track of the connections and their depth
                  (aka how nested they are) in the relationship tree
        """
        outputListH = pm.listConnections(node + ".message", d=True)
        return outputListH
    # end get_outgoing_connections

    # def get_node_depth(self, node):
    #     """
    #     Given a valid PickNode, the function returns the node's depth in the
    #     connection tree
    #     """
    #     for direction in self.allowedDirections.pop("master"):
    #         connection = pm.listConnections(node + "." + direction, i=True)
    #         if connection is None:
    #             continue  # skip
    #         trace = connection
    #         depth = 1
    #         while trace != MASTER_NODE_NAME:
    #             connection = pm.listConnections(trace + "." + direction, i=True)
    #             trace = con


    # def get_connection_info(self, dictH=None):
    #     """


    #     """
    #     if dictH is None:
    #         self.get_outgoing_connections()
    # # end_connection_info

    def init_gui_selection(self, script, protected=False):
        """
        Creates an interactive method within the specified application. In the
        case of Maya, we init a scriptJob that forces portions of the GUI to
        update depending on whether or not selections contain metadata and the
        user is not in assign mode

        Args:
            script (str): The method to execute when objects are selected

        Returns:
            int: The unique ID value pointing to the Maya scriptJob
        """
        self.selScriptJ = pm.scriptJob(e=["SelectionChanged", script],
                                       protected=protected)
        return self.selScriptJ
    # end init_gui_selection

    def has_gui_selection(self, jobNum=None):
        """
        Checks if a scriptJob exists within the current environment. If no
        jobNum is specified, the script assumes that the user is referencing
        the current instance's self.selScriptJ

        Args:
            jobNum (int): The unique job number to check in Maya

        Returns:
            bool: True/False
        """
        if jobNum is None:
            jobNum = self.selScriptJ

        conds = pm.scriptJob(listConditions=True)
        if jobNum in conds:
            return True
        return False
    # end has_gui_selection

    def kill_gui_selection(self, job=None):
        """
        Removes the current scriptJob from the environment so that selecting
        objects no longer has any effect

        Args:
            job (int): The job to kill. If none specified, the script assumes
                       that it's meant to kill a scriptJob that was previously
                       made using init_gui_selection

        Returns:
            bool: The success of the action
        """
        if job is None:
            job = self.selScriptJ

        pm.scriptJob(kill=job, force=True)
        return True
    # end kill_gui_selection
# end ApplicationMaya


if __name__ == "__main__":
    print(__doc__)
