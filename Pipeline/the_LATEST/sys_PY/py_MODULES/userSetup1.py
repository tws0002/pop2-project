# IMPORT STANDARD LIBRARIES
import sys

# IMPORT THIRD-PARTY LIBRARIES
import maya.OpenMaya as om
import maya.cmds as cmds
import maya.mel as mel

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from constants.model.constants import LOGGER
from fileio.controller import manager_0001 as manager
from maya_STARTUPCONFIG import change_ui_colors  # color/ui preferences
from fileio.controller import maya as maya

LOGGER.info(consts.LINE_SEP)
LOGGER.info('===== LOADING userSetup.py =====')
LOGGER.info(consts.LINE_SEP)

LOGGER.info("initializing bifrost config settings")
# Should been created in the userSetup to allow reloading a file using maya.exe <filename.ma> (which tries to use this scriptedPanelType while
# restoring config (and causes error on loading).
#
if mel.eval( "enableBifrostGraphEditing()" ):
    if cmds.scriptedPanelType("BifrostGraphEditor", q=True, ex=True)            == False: cmds.scriptedPanelType("BifrostGraphEditor")
    if cmds.scriptedPanelType("BifrostValueEditor", q=True, ex=True)            == False: cmds.scriptedPanelType("BifrostValueEditor")
    if cmds.scriptedPanelType("BifrostDictionaryEditor", q=True, ex=True)       == False: cmds.scriptedPanelType("BifrostDictionaryEditor")

LOGGER.info("initializing project defaults")
# PROJECT-SPECIFIC DEFAULTS
cmds.currentUnit(linear='cm')
cmds.setAttr('defaultResolution.width', 1920)
cmds.setAttr('defaultResolution.height', 1080)

LOGGER.info("initializing scene metadata")
sceneObj = maya.SceneMetadataGeneric()

LOGGER.info("initializing save/open/load/close command overrides")
# CB_BSC = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, manager.checkout_maya_save_check)
CB_BSC = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, manager.checkout_maya_save_check)
# CB_BOC = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeOpenCheck, manager.checkout_maya_open_check)
# CB_ME = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kMayaExiting, manager.checkout_maya_close_check)

LOGGER.info("loading project UI preferences")
change_ui_colors.main()

LOGGER.info(consts.LINE_SEP)
# mel.eval("ScriptEditor;")  # opens the script editor on startup
LOGGER.info("=== LOAD userSetup.py SUCCESSFUL ===")
LOGGER.info(consts.LINE_SEP)