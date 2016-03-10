#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Inits Nuke into the custom environment
"""

# IMPORT STANDARD LIBRARIES
import os

# IMPORT THIRD PARTY LIBRARIES
import nuke #, nodeIcon

# IMPORT LOCAL LIBRARIES
import fileio.controller.globerror as globerror
import fileio.controller.manager as manager
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
try:
    from constants.model import constants as consts
except globerror.ExitApplicationError:
    Logger.getTraceback()
    manager.exit_application(application="nuke")
    raise RuntimeError("Appliction must exit")
import fileio.controller.checkout as checkout
import network.controller.network as network
import fileio.controller.omnibus as omnibus
import nukemanager as nukemanager
import guimetadata

nuke.tprint('running menu.py')

# Make sure the plugin paths are in the GUI
if nuke.GUI:
    nuke.tprint('\n\n')
    for i in nuke.pluginPath():
        nuke.tprint(i)
    nuke.tprint('\n\n')
    for i in sys.path:
        nuke.tprint(i)
    nuke.tprint('\n\n')

###############################################################################
# ADD MENU ITEMS
###############################################################################

# PROJECT TOOLS
toolbar = nuke.toolbar("Nodes")
menu = toolbar.addMenu("POP2 TOOLS", icon="pop2_menu_icon.png")
# m.addCommand("Example 1", "nuke.createNode(\"Example 2\")", icon="ICON.png")
menu.addCommand("Finalize Shot", "nukemanager.finalize_shot(nuke.root().knob('name').value())")
# ADD NODE ICON TOOLS TO MENUBAR
# menubar = nuke.menu('Nuke') # Access the main menu bar
# editmenu = menubar.findItem("&Edit") # Access existing Edit menu
# nodesubmenu = editmenu.findItem('Node') # Access existing submenu
# nodesubmenu.addSeparator() # Add a seperator to any menu
# nodesubmenu.addCommand('Add Icons', 'nodeIcon.addIcons()') #Add to existing submenu
# nodesubmenu.addCommand('Remove Icons', 'nodeIcon.removeIcons()') #Add to existing submenu
# nodesubmenu.addCommand('Copy Icon', 'nodeIcon.copyIcon()') #Add to existing submenu
# nodesubmenu.addCommand('Cut Icon', 'nodeIcon.cutIcon()') #Add to existing submenu
# nodesubmenu.addCommand('Paste Icons', 'nodeIcon.pasteIcons()') #Add to existing submenu
# nodesubmenu.addCommand('ViewInput Icon', 'nodeIcon.setIcon(nuke.toNode(\"VIEWER_INPUT\"), \"fxphd_logo.png\")') #Add to existing submenu

################################################################################
# DEFAULT NODES ADD (Other than the template.py)
################################################################################
guimetadata.nuke_metadata_init()

################################################################################
# TOOLS ADD
################################################################################
# Automate reload read script to reload all read files
def reloadReads():
    [i.knob('reload').execute() for i in nuke.allNodes() if i.Class()=='Read']

# aligner tool for disorganized nodes
import align
nuke.menu('Nuke').addCommand('Scripts/align', 'align.aligner()')


# new tab override UI tool - includes subscripts and weighing!
def ttt():
    import tabtabtab
    m_edit = nuke.menu('Nuke').findItem('Edit')
    m_edit.addCommand('Tabtabtab', tabtabtab.main, 'Tab')

if consts.BLACKLIST is None or (consts.BLACKLIST is not None and \
        not 'tabtabtab' in omnibus.nested_dict_return(consts.BLACKLIST,
                                                      consts.BLACKLISTED_PLUGINS_NK)):
    try:
        ttt()
    except Exception:
        import traceback
        traceback.print_exc()

gizManager = globals().get('gizManager', None)
if gizManager is None:
    print 'Problem finding GizmoPathManager - check that init.py was setup correctly'
else:
    gizManager.addGizmoMenuItems()
    del gizManager

# Sylens
# Inject our own node bar
toolbar = nuke.menu("Nodes")
sy = toolbar.addMenu( "SyLens")
nodes = ('SyLens', 'SyCamera', 'SyUV', 'SyShader')
for nodename in nodes:
  sy.addCommand(nodename, 'nuke.createNode("%s")' % nodename)

################################################################################
# SETTING DEFAULTS
################################################################################
# nuke.Root()['project_directory'].setValue('[python {nuke.script_directory()}]')
# nuke.Root()['project_directory'].setValue('DERP1')
# nuke.Root()['Script_directory'].setValue('DERP2')


# NODE DEFAULTS
nuke.knobDefault('Viewer.tile_color, [1,0,0]')

# TEXT DEFAULT
# nuke.knobDefault("Text.font", os.environ['DEVHOME'] + '/my.FONT/tahomabd.ttf')

# PROPERTIES PANEL DEFAULT
nuke.toNode('preferences')['maxPanels'].setValue(3)

# PROJECT SETTING DEFAULT
# nuke.knobDefault('Root.onScriptLoad', 'manager.checkout_nuke_write_render_before(nuke.root().name())')
# nuke.knobDefault('Root.onScriptSave', 'manager.checkout_nuke_write_render_before(nuke.root().name())')
# nuke.knobDefault('Root.onScriptClose', 'manager.checkout_nuke_write_render_after(nuke.root().name())')
# nuke.knobDefault('Root.onScriptSave', 'checkScriptName( nuke.root().name() )')
nuke.knobDefault('Root.onScriptLoad', 'nukemanager.checkout_write_render_before(nuke.root().name())')
nuke.knobDefault('Root.onScriptSave', 'nukemanager.checkout_write_render_before(nuke.root().name())')
nuke.knobDefault('Root.onScriptClose', 'nukemanager.checkout_write_render_after(nuke.root().name())')
nuke.knobDefault("Root.format", "HD")

# VIEWER DEFAULT
# nuke.knobDefault("Viewer.freezeGuiWhenPlayBack", "1")

# STICKYNOTE DEFAULT
nuke.knobDefault("StickyNote.note_font_size", "40")

# WRITE DEFAULT
#Gets filename before the render and places it in pre-written folder
# nuke.knobDefault('Write.beforeRender', 'nuke.thisNode()["file"].setValue(nuke.root().name().replace("scripts","renders").replace(".nk",".mov")')
# nuke.knobDefault('Write.beforeRender', 'nukeio.write_render_check(thisNode=True, param="file")')



# nuke.knobDefault('Write.beforeRender', 'manager.checkout_nuke_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
# nuke.knobDefault('Write.afterRender', 'manager.checkout_nuke_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
# nuke.knobDefault('Write.beforeFrameRender', 'manager.checkout_nuke_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')
nuke.knobDefault('Write.beforeRender', 'nukemanager.checkout_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
nuke.knobDefault('Write.afterRender', 'nukemanager.checkout_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
nuke.knobDefault('Write.beforeFrameRender', 'nukemanager.checkout_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')
nuke.knobDefault('Write.afterFrameRender', 'nukemanager.checkout_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')
# nuke.knobDefault('Write.afterFrameRender', 'manager.checkout_nuke_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')


# nuke.knobDefault('Write.file', r'C:\Users\korinkite\Dropbox\Private\my_PROJECT\proj_POP2\Pipeline\the_LATEST\sys_PY\py_MODULES\fileio\test\test_nuke_project\output\s001_ckenne24_010_MODEL_someDescription.####.tiff')
# nuke.knobDefault('Write.afterFrameRender', 'manager.checkout_nuke_write_render_after(inputH=manager.nuke_get_path_from_write_node(nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value() - 1)))')

# WRITEGEO DEFAULT
nuke.knobDefault('WriteGeo.beforeRender', 'nukemanager.checkout_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
nuke.knobDefault('WriteGeo.afterRender', 'nukemanager.checkout_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
nuke.knobDefault('WriteGeo.beforeFrameRender', 'nukemanager.checkout_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')
nuke.knobDefault('WriteGeo.afterFrameRender', 'nukemanager.checkout_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')
# nuke.knobDefault('WriteGeo.beforeRender', 'manager.checkout_nuke_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
# nuke.knobDefault('WriteGeo.afterRender', 'manager.checkout_nuke_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode(), knob="file"))')
# nuke.knobDefault('WriteGeo.beforeFrameRender', 'manager.checkout_nuke_write_render_before(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')
# nuke.knobDefault('WriteGeo.afterFrameRender', 'manager.checkout_nuke_write_render_after(manager.nuke_get_path_from_write_node(inputH=nuke.thisNode()["file"].value(), knob=int(nuke.frame() - nuke.thisNode()["first"].value())))')

# I/O DEFAULT
nuke.knobDefault('Input.label','[value number]')

# EXPTOOL DEFAULT
nuke.knobDefault('EXPTool.mode', 'Stops')
nuke.knobDefault('EXPTool.label', '[value mode]')

# GRADE DEFAULT
nuke.knobDefault('Grade.disable', '1')

# ROTO DEFAULT
nuke.knobDefault("Roto.feather_type", "smooth")
nuke.knobDefault("RotoPaint.feather_type", "smooth")

# finally, UPDATE PLUGINS ON LOAD
nukescripts.update_plugin_menu("All plugins")


# temporary open, to save time
# file_h =r"C:/Users/korinkite/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST_pre_maya_open_close_edits_0001/sys_PY/py_MODULES/fileio/test/test_nuke_project/test_nuke_project_v0001.nknc"
# nuke.scriptOpen(file_h)

# DEFAULT SCENE OPEN
# print 'asdfsd'
# TEMPLATE_DIR = os.path.join(os.environ['PIPELINE_DIR'], 'latest_NUKE', 'nuke_TEMPLATES', 'template.nk')
# print TEMPLATE_DIR
# print TEMPLATE_DIR
# print TEMPLATE_DIR
# print 'asdfsd'
# nuke.scriptOpen(TEMPLATE_DIR)
