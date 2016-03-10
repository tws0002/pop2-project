#!/usr/bin/python
# -*- coding: utf-8 -*-

# IMPORT THIRD PARTY LIBRARIES
import hou

# IMPORT LOCAL LIBRARIES
import fileio.controller.manager as manager
import fileio.controller.checkout as checkout
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
from network.controller.network import NetworkManager

def checkout_write_render_before(filePath):
    """
    In houdini, when rendering out, the Pre/Post-Render/Frame Scripts
    only allow the user to write one line. This script encapsulates everything
    that I need the script to do while still writing concisely

    Pre-Render Script - houmanager.checkout_nuke_render_before(hou.pwd().parm("sopoutput").eval())
    """
    thisNode = hou.pwd()
    try:
        manager.checkout_nuke_write_render_before(checkout.FileCheckoutHoudini,
                                                  filePath)
    except checkout.IOValidationError:
        # hou.ui.displayMessage('DEEEEEEEEEEEEEEEEEEEEERP')
        hou.ui.displayMessage(manager.ERROR_MSG)
        raise RuntimeError(manager.ERROR_MSG)
    except checkout.IOValidationPassedError:
        pass  # do nothing, user is allowed to save
# end checkout_write_render_before


def checkout_write_render_after(filePath):
    """
    In situations where the file to write out is not a scene file that is 
    actively, being used, the file should be unlocked after successfully writing
    """
    # Unlock the file after saving if the saved version is not the current opened session
    # currentMayaSession = cmds.file(q=True, ns=True)  # the current maya file name  # :::TO DO::: CHANGE IMMEDIATELY
    LOGGER.info(['AIE1601'], {'file': filePath})
    # fileToSave = r"C:\Users\korinkite\Dropbox\Private\my_PROJECT\proj_POP2\Pipeline\the_LATEST_pre_maya_open_close_edits_0001\sys_PY\py_MODULES\fileio\test\test_nuke_project\output\s001_ckenne24_010_MODEL_someDescription.0001.ma"
    LOGGER.info(["AIE1204"], {'f': filePath})
    networkManager = NetworkManager()
    networkManager.file = filePath
    if networkManager.has_access():
        networkManager.locked = False
    # if savedMayaSession != currentMayaSession:
    #   LOGGER.debug(['AIE1205'], {"f": fileToSave})
    #   LOGGER.info(['AIE1204'], {"f": fileToSave})
    #   networkManager.locked = False
# end checkout_write_render_after


if __name__ == "__main__":
    print(__doc__)
