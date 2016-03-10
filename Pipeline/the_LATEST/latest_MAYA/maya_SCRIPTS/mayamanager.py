#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Maya-specific handling for file/network checkout modules
"""

# IMPORT STANDARD LIBRARIES
import os
import functools
import time

# IMPORT THIRD PARTY LIBRARIES
# import maya.cmds as cmds
try:
    import maya.OpenMaya as om
    import pymel.core as pm
except:
    print("Not in a Maya environment")

# IMPORT LOCAL LIBRARIES
import fileio.controller.manager as manager
import fileio.controller.checkout as checkout
import fileio.controller.globerror as globerror
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
from network.controller.network import NetworkManager
import metadatamaya as metadatamaya


def checkout_before(retCode, clientData, filePath):
    """
    manager.checkout_nuke_write_render_before uses native Python to raise
    exceptions to allow/disallow file saving. The following hooks are then
    caught and dealt with in an application-specific way
    """
    metadataMaya = metadatamaya.SceneMetadataGeneric()
    filePath = filePath()  # run the passed func
    try:
        manager.checkout_nuke_write_render_before(checkout.FileCheckoutMaya,
                                                  filePath)
    except globerror.IOValidationError:
        LOGGER.info(['AIE1203'], {'f': filePath})
        metadataMaya.save_state = False
        msg = metadataMaya.error_msg_handling(manager.GLOB_ERROR_MSG)
        metadataMaya.scene_lock(retCode, clientData)
        raise RuntimeError(msg)
    except globerror.IOValidationPassedError:
        LOGGER.info(['AIE1204'], {'f': filePath})
        metadataMaya.save_state = True  # :::TO DO::: Ghetto - remove this later
        metadataMaya.error_msg_handling(metadataMaya.fCallbackFailureDefault)
        metadataMaya.scene_lock(retCode, clientData)
        pass  # do nothing, user is allowed to save
    del filePath  # previous definitions of this name were getting in the way of subsequent saves
# end checkout_before

def null_func(clientData):
    print "foo"

def checkout_after(clientData, filePath, forceUnlock=False):
    """
    In situations where the file to write out is not a scene file that is
    actively, being used, the file should be unlocked after successfully writing
    """
    # filePath = om.MFileIO.beforeSaveFilename
    # :::TO DO::: Ghetto. Once metadata method works, remove this
    metadataMaya = metadatamaya.SceneMetadataGeneric()
    filePath = filePath()  # run the passed func

    try:
        if pm.objExists(metadataMaya.ALLOWSAVE):
            LOGGER.critical("Maya Object: \"{obj}\" should not exist! "
                            "Contact admin".format(obj=metadataMaya.ALLOWSAVE))
            pm.delete(metadataMaya.ALLOWSAVE)
    except AttributeError:
        pass  # the metadata node that was being looked for doesn't exist

    # Unlock the file after saving if the saved version is not the current opened session
    # currentMayaSession = cmds.file(q=True, ns=True)  # the current maya file name  # :::TO DO::: CHANGE IMMEDIATELY
    # fileToSave = r"C:\Users\korinkite\Dropbox\Private\my_PROJECT\proj_POP2\Pipeline\the_LATEST_pre_maya_open_close_edits_0001\sys_PY\py_MODULES\fileio\test\test_nuke_project\output\s001_ckenne24_010_MODEL_someDescription.0001.ma"
    networkManager = NetworkManager()
    networkManager.file = filePath

    currentScene = os.path.normpath(om.MFileIO.currentFile())
    filePath = os.path.normpath(filePath)

    if forceUnlock or (networkManager.has_access and filePath != currentScene):
        LOGGER.info(["AIE1204"], {'f': filePath})
        # if the current scene is not what was just saved, unlock the file
        # otherwise, it's implied that the user is still working on the file
        # and, because of that, it shouldn't be unlocked yet
        #
        networkManager.locked = False
# end checkout_after


def close_script_job():
    """
    Closes the current application and unlocks the scene file if locked passes
    """
    tempFunc = functools.partial(checkout_after, clientData=None,
                                 forceUnlock=True,
                                 filePath=om.MFileIO.currentFile)
    pm.scriptJob(runOnce=True, e=["quitApplication", tempFunc])
    pm.inViewMessage(amg='Thanks for stopping by <hl>You da best!</hl>',
                     pos='midCenter', fade=True )
# end close_script_job


"""
- check the first frame
- check the last frame
- if either one fails, exit
- if both succeed, allow render
"""


# Wrap additional parameters as default args using functools.partial
# this will make the functions compatible with om.MSceneMessage,
# whose functions expect functions as inputs, not output parameters
checkout_before_compatible = functools.partial(checkout_before, filePath=om.MFileIO.beforeSaveFilename)
checkout_after_compatible = functools.partial(checkout_after, filePath=om.MFileIO.beforeSaveFilename)
# checkout_close_compatible = functools.partial(checkout_after, filePath=om.MFileIO.currentFile)


if __name__ == "__main__":
    print(__doc__)
