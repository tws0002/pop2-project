print("================ LOADING userSetup.py ==================\n");

# IMPORT THIRD-PARTY LIBRARIES
import maya.OpenMaya as om
import maya.cmds as mc
import maya.mel as mm

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from constants.model.constants import LOGGER
from fileio.controller import manager  # determines save permissions over the network

cb_id = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, manager.save_checkout_maya())

# def save_file_pop2():
#     # no install if in batch mode
#     if mc.about(batch=True):
#         return
#     # hijack save button
#     # mc.iconTextButton(u"saveSceneButton", edit=True, command='python("import yourstuff;yourstuff()")', sourceType="mel")
#     # hijack save menu item
#     mm.eval("buildFileMenu;") # new in Maya 2009, we have to explicitly create the file menu before modifying it
#     # mc.setParent(u"mainFileMenu", menu=True)
#     mc.setParent(u"gMainFileMenu", menu=True)
#     mc.menuItem(u"saveItem", edit=True, label="Save Scene", command='manager.save_checkout_maya()')
#     # hijack CTRL-S named command
#     mc.nameCommand(u"NameComSave_File", annotation="Your Custom Save", command='manager.save_checkout_maya()')

# LOGGER.trace(['MYA1702'])
# save_file_pop2()

print("loading color preferences")
from maya_STARTUPCONFIG import changeUIColors

print("\n============ LOADING userSetup.py SUCCESSFUL============\n");
