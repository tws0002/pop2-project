#!/usr/bin/python
# -*- coding: utf-8 -*-


"""
Creates a scene node which represents the metadata contained within the scene
Currently, the node is meant to replace a proper class structure, since 
om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck
has very limited support for native Python outside of maya's custom funcs

I hope to one day remove this module entirely and simply integrate it with
my network tools if time permits.
        
For now, the node being used is the "MakeGroup" node, which may change later
The self._sceneNodeName is the name of the node in all applications (Maya, Houdini, Nuke, etc)
and so is available to all projects

..Note::
 Right now, the script is running on a ghetto version of itself. Instead of 
 using the metadata info to drive scene saves/loads, the script currently just
 creates a maya object whenever the user should be locked from the scene,
 and checks for it before saving, and then deletes it afterwards

 I hope to later replace this with actual metadata in a way that makes sense

"""


# IMPORT STANDARD LIBRARIES
import json

# IMPORT THIRD PARTY LIBRARIES
try:
    import maya.OpenMaya as om
    import maya.cmds as cmds
    import pymel.core as pm
except ImportError as exc:
    print("{exc}: Could not import maya.OpenMaya as om. "
          "Are you in Maya environment?".format(exc=exc))

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts

    
GLOB_ERROR_MSG = consts.GLOB_ERROR_MSG
ALLOWSAVE = ''  # :::TO DO::: Ghetto. Remove with metadata update


class SceneMetadataGeneric(object):
    def __init__(self):
        super(SceneMetadataGeneric, self).__init__()    
        # save initial state of scene
        selection = pm.ls(sl=True)
        # create node
        self._sceneNodeName = consts.GLOB_SCENE_NODE
        self._sceneNodeNameHelper = consts.GLOB_SCENE_NODE + 'Helper'  # :::TO DO::: Ghetto - remove
        self._protectedCategories = ["allowSave"]
        self._sceneNodeType = pm.nodetypes.MakeGroup

        if not pm.objExists(self._sceneNodeName):
            self._sceneNode = pm.createNode("makeGroup")
            pm.rename(self._sceneNode, self._sceneNodeName)
        elif not pm.objExists(self._sceneNodeName) \
            and not isinstance(pm.PyNode(self._sceneNodeName), self._sceneNodeType):
            pm.delete("self._sceneNodeName")  # delete the node, it is invalid
            print("Detected scene node of invalid type" 
                  "and/or deprecated format. Replacing...")
            self._sceneNode = pm.createNode("makeGroup")
            pm.rename(self._sceneNode, self._sceneNodeName)
        elif pm.objExists(self._sceneNodeName) \
                and isinstance(pm.PyNode(self._sceneNodeName), self._sceneNodeType):
            # get existing scene node
            self._sceneNode = pm.PyNode(self._sceneNodeName)
        elif pm.objExists(self._sceneNodeName) \
                and not isinstance(pm.PyNode(self._sceneNodeName), self._sceneNodeType):
            print("Scene node exists but it is of the wrong type!")
    
        self.node_lock_state = False
        self._confH = consts.CONF_H
        with open(self._confH, "r") as f:
            self._confInfo = json.load(f)
        
        # defaults
        self.fCallbackFailureDefault = consts.GLOB_ERROR_MSG
        #                                "The file operation was cancelled by "\
        #                                "user supplied callback."
        # config file location
        self.init_attr("configFileLocation", self._confH, "string")
        
        # add relevant channels from config                
        searchKeys = [consts.ALL_KEY, consts.APP_KEY_MA]
        for key in searchKeys:
            self.init_config(key)

        self.node_lock_state = True

        # restore initial state of scene
        pm.select(selection)
    # end __init__
        
    def init_config(self, searchKey):
        """
        Very basic init method, gets info from a data file 
        and adds it to the scene description 
        """
        with open(self._confH, "r") as f:
            contents = json.load(f)

        if searchKey not in contents:
            print("cannot continue, config is missing required information")
            sys.exit()  # :::TO DO::: replace with a more elegant exit struct
        data = contents[searchKey]

        for key, item in data.iteritems():
            self.init_attr(key, item, "string")
    # end init_config
    
    def init_attr(self, key, item, dataType="string", lockState=True):
        """
        Safely handles the init of new args
        """
        try:
            pm.getAttr(self._sceneNode + "." + key)
            if not pm.getAttr(self._sceneNode + "." + key, l=True):
                pm.setAttr(self._sceneNode + "." + key, l=lockState)
        except pm.MayaAttributeError:
            pm.addAttr(self._sceneNode, ln=key, dt=dataType)
            pm.setAttr(self._sceneNode + "." + key, item)
            pm.setAttr(self._sceneNode + "." + key, l=lockState)    
    # end init_attr
    
    def check_protected_args(self):
        """
        Later implementation for restricting access to
        protected arguments from the config file
        """        
        pass
    # end check_protected_args
                
    def set_attr_lock(self, stringAttr, value=True):
        """
        Controls how and in what why attributes within
        the current node lock/unlock
        """
        # lock/unlock attr for editting
        if pm.getAttr(self._sceneNode + "." + stringAttr, l=True) is value:
            pass
        elif pm.getAttr(self._sceneNode + "." + stringAttr, l=True):
            # do something
            pm.setAttr(self._sceneNode + "." + stringAttr, l=False)
        return value
    # end set_attr_lock
    
    def get_json_from_node_str(self, stringAttr, afterSetLock=True):
        """
        Gets the entire json object from node's string attribute
        """      
        # unlcok node + attr
        self.node_lock_state = False
        self.set_attr_lock(stringAttr, False)

        # get current attr value
        reads = pm.getAttr(self._sceneNode + "." + stringAttr)  # note - unicode
        info = json.loads(reads)
        
        pm.setAttr(self._sceneNode + "." + stringAttr, l=afterSetLock)
        self.node_lock_state = afterSetLock
        return info
    # emd get_json_from_node_str
        
    def get_json_str_metadata(self, stringAttr, key, default="", afterSetLock=True):
        """
        Gets dict key from str (json) metadata
        """
        info = self.get_json_from_node_str(stringAttr, afterSetLock=False)
        info.setdefault(key, default)

        pm.setAttr(self._sceneNode + "." + stringAttr, l=afterSetLock)
        self.node_lock_state = afterSetLock
        return info[key]
    # end set_json_str_metadata
    
    def set_json_str_metadata(self, stringAttr, key, item, afterSetLock=True):
        """
        Gets entire json from a string attribute from the
        current node and then sets one of its keys.
        It then writes the changes back into the node string
        """
        if key is None or item is None:
            raise KeyError("Please supply both a key to query and "
                           "item to replace the key's contents with")
        
        # :::TO DO::: for this method and globally to all other methods,
        # make a method that runs before and after the oher methods
        # that way the node will auto lock/unlock every time
        #         
        info = self.get_json_from_node_str(stringAttr, afterSetLock)
        if pm.lockNode(self._sceneNode, q=True, l=True):
            pm.lockNode(self._sceneNode, l=False)
        if pm.getAttr(self._sceneNode + "." + stringAttr, l=True):
            pm.setAttr(self._sceneNode + "." + stringAttr, l=False)
            
        if key in info:
            info[key] = item
        else:
            raise KeyError("Key: {key} not detected in dict, {dict}".format(key=key, dict=info))

        pm.setAttr(self._sceneNode + "." + stringAttr, json.dumps(info))

        if pm.getAttr(self._sceneNode + "." + stringAttr, l=True) is not afterSetLock:
            pm.setAttr(self._sceneNode + "." + stringAttr, l=afterSetLock)
        pm.lockNode(self._sceneNode, l=afterSetLock)
        self.node_lock_state = afterSetLock
        return True
    # set_json_str_metadata
    
    def error_msg_handling(self, msg):
        global GLOB_ERROR_MSG 
        GLOB_ERROR_MSG = msg
        return GLOB_ERROR_MSG
    
    # def scene_lock(self, retCode, clientData):
    #     """
    #     Allows/Cancels render based on scene inforation
    #     """
    #     # allowSave = self.get_json_str_metadata("sceneDescription", "allowSave")
    #     allowSave = cmds.objExists()
    #     stringKey = "s_TfileIOStrings.rFileOpCancelledByUser"
    #     stringDefault = "File operation cancelled by user supplied callback."
    #     global GLOB_ERROR_MSG
    #     stringError = GLOB_ERROR_MSG
    
    #     message = stringError if not allowSave else stringDefault
    #     cmds.displayString(stringKey, replace=True, value=message)
    #     om.MScriptUtil.setBool(retCode, allowSave)
    # # end set_scene_lock

    def scene_lock(self, retCode, clientData):
        allowSave = cmds.objExists(self._sceneNodeNameHelper)

        string_key = "s_TfileIOStrings.rFileOpCancelledByUser"
        string_default = self.fCallbackFailureDefault
        global GLOB_ERROR_MSG
        string_error = GLOB_ERROR_MSG
        # string_error = "There is a pSphere1 node in your scene"

        message = string_error if allowSave else string_default
        cmds.displayString(string_key, replace=True, value=message)

        om.MScriptUtil.setBool(retCode, (not allowSave))
    # end scene_lock

    @property
    def node_lock_state(self):
        """
        Getter method for node_state_lock
        """
        return self._nodeLockState
    # end @property
                     
    @node_lock_state.setter        
    def node_lock_state(self, value):
        """
        lock/unlock attr for editting
                
        later iterations may include hiding/unhiding 
        from node editor, hypershade, outliner, etc
        """
        if pm.lockNode(self._sceneNode, q=True, l=True)[0] is value:
            # if it's unlocked and user specified unlock, do nothing
            pass
        else:
            # do something
            pm.lockNode(self._sceneNode, l=value)
        self._nodeLockState = value
    # end @node_lock_state.setter
    
    @node_lock_state.deleter
    def node_lock_state(self):
        """
        Deleter method for scene lock
        """
        del self._nodeLockState
    # end @node_lock_state.deleter
    # end node_lock_state
    
    @property
    def save_state(self):
        """
        Syntactic sugar but also useful, just in case I have to
        one day extend this module.

        Getter method which determines if a scene is savable or not
        """
        return self._sceneSaveState
    # end @save_state.property

    @save_state.setter
    def save_state(self, value):
        """
        Setter method which determines if a scene is savable or not
        """
        self._sceneSaveState = value
        self.set_json_str_metadata("sceneDescription", "allowSave", value)
        # :::TO DO::: Ghetto, remove with a metadata method
        global ALLOWSAVE        
        
        if not value and not pm.objExists(self._sceneNodeNameHelper):
            ALLOWSAVE = pm.createNode("makeGroup")
            pm.rename(ALLOWSAVE, self._sceneNodeNameHelper)
        elif not value and pm.objExists(self._sceneNodeNameHelper):
            pass                        
        elif value and not pm.objExists(self._sceneNodeNameHelper):
            pass
        elif value and pm.objExists(self._sceneNodeNameHelper):
            # if the user is allowed to save but the obj exists, remove it
            pm.delete(self._sceneNodeNameHelper)

        # CB_BSC is redundant on subsequent calls :TO DO: - find a way to check for 
        # it and not run it if it exists?
    # end @save_state.setter

    @save_state.deleter
    def save_state(self):
        del self._sceneSaveState
    # end @save_state.deleter
    # end save_state

    def __repr__(self):
        return '<{mod}.{cls}(ntp={ntp}, scn={scn}, cin={cin}) '\
               'object at {hex}>'.format(mod=self.__class__.__module__,
                                         cls=self.__class__.__name__,
                                         ntp=self._sceneNodeType,
                                         scn=self._sceneNode,
                                         cin=self._confInfo,
                                         hex=hex(id(self)))
    # end __repr__
# SceneMetadataGeneric


class SceneMetadataIOGeneric(SceneMetadataGeneric):
    def __init__(self):
        super(SceneMetadataIOGeneric, self).__init__()
    # end __init__
# end SceneMetadataIOGeneric




def main():
    networkManager = SceneMetadataGeneric()
    networkManager.save_state = False
    networkManager.error_msg_handling("ASDASDF")
    cb_id = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, 
                                              networkManager.scene_lock)
# end main


if __name__ == "__main__":
    print(__doc__)
    # main()