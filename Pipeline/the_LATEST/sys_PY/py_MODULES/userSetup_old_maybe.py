# IMPORT STANDARD LIBRARIES
import os
import sys

# IMPORT THIRD-PARTY LIBRARIES
import maya.OpenMaya as om
import maya.cmds as cmds
import maya.mel as mel

# IMPORT LOCAL LIBRARIES
import fileio.controller.globerror as globerror
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()

try:
	from constants.model import constants as consts
except globerror.ExitApplicationError:
	LOGGER.critical(["AIE9400"], {'app': os.environ.get('APP_EXECUTABLE', '')})
	LOGGER.getTraceback()
	globerror.exit_application("maya")

from fileio.controller import manager as manager
from fileio.controller import checkout as checkout
from maya_STARTUPCONFIG import change_ui_colors  # color/ui preferences
import mayamanager

LOGGER.info(consts.LINE_SEP)
LOGGER.info('===== LOADING userSetup.py =====')
LOGGER.info(consts.LINE_SEP)

if not consts.CREWMEMBER_PREFERENCES['CHANGELOG_HIDE_ON_STARTUP']:
    LOGGER.info("getting changelog")


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
cmds.setAttr('defaultResolution.width',1280)
cmds.setAttr('defaultResolution.height',720)

LOGGER.info("initializing save/open/load/close command overrides")
# def foo():
# 	print om.MFileIO.beforeOpenFilename()
# 	print om.MFileIO.beforeOpenFilename()
# 	print om.MFileIO.beforeOpenFilename()

# CB_BSC = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, mayamanager.checkout_write_render_before)
CB_BSC = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, mayamanager.checkout_before_compatible)
CB_AS = om.MSceneMessage.addCallback(om.MSceneMessage.kAfterSave, mayamanager.checkout_after_compatible)
mayamanager.close_script_job()

LOGGER.info("loading project UI preferences")
change_ui_colors.main()

LOGGER.info("Loading Malcolm Kesson's (http://www.fundza.com) MEL/PY scripts")

# source python scripts from RfM first (give it priority)
# :AUTHORNOTE: This should be replaced by a variable which points directly to the maya folder, instead of just
# presuming that we have a specific path
#
# rfmDir = os.path.join(consts.DEV_DIR, "latest_MAYA", "maya_DEFAULTPROJECT", "projects", "RfM_python")
rfmDir = os.path.join(consts.DEV_DIR, "latest_MAYA", "maya_SCRIPTS", "RfM_python")
LOGGER.debug('rfmDir set to: ' + rfmDir)
# maybe redundant but just in case it didn't get imported the first time
#
rfmDir = os.path.join(consts.DEV_DIR, "latest_MAYA", "maya_SCRIPTS", "RfM_python")
# scriptDir = os.path.join(consts.DEV_DIR, "latest_MAYA", "maya_DEFAULTPROJECT", "scripts")
scriptDir = os.path.join(consts.DEV_DIR, "latest_MAYA", "maya_SCRIPTS", "RfM_mel")
LOGGER.debug('scriptDir set to: ' + scriptDir)
rmanBinDir = os.path.join(os.environ['RMANTREE'], "bin")
sys.path.append(rfmDir)
# sys.path.append(scriptDir)
sys.path.append(rmanBinDir)
appendedPaths = [rfmDir, rmanBinDir, scriptDir]
LOGGER.debug('sys.path appended folders: {}'.format(appendedPaths))


LOGGER.info(consts.LINE_SEP)
LOGGER.info("=== LOAD userSetup.py SUCCESSFUL ===")
LOGGER.info(consts.LINE_SEP)
