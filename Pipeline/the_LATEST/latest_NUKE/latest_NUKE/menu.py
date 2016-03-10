# IMPORT STANDARD LIBRARIES
import os

# IMPORT THIRD PARTY LIBRARIES
import nuke #, nodeIcon

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

# new tab override UI tool - includes subscripts and weighing!
def ttt():
    import tabtabtab
    m_edit = nuke.menu('Nuke').findItem('Edit')
    m_edit.addCommand('Tabtabtab', tabtabtab.main, 'Tab')

try:
    ttt()
except Exception:
    import traceback
    traceback.print_exc()

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

# reload read script to reload all read files
def reloadReads():
	[i.knob('reload').execute() for i in nuke.allNodes() if i.Class()=='Read']

# aligner tool for disorganized nodes
import align
nuke.menu('Nuke').addCommand('Scripts/align', 'align.aligner()')

# NODE DEFAULTS
nuke.knobDefault('Viewer.tile_color, [1,0,0]')

# TEXT DEFAULT
# nuke.knobDefault("Text.font", os.environ['DEVHOME'] + '/my.FONT/tahomabd.ttf')

# PROPERTIES PANEL DEFAULT
nuke.toNode('preferences')['maxPanels'].setValue(3)

# PROJECT SETTING DEFAULT
nuke.knobDefault('Root.onScriptSave', 'checkScriptName( nuke.root().name() )')
nuke.knobDefault("Root.format", "HD")  

# VIEWER DEFAULT
# nuke.knobDefault("Viewer.freezeGuiWhenPlayBack", "1")  

# STICKYNOTE DEFAULT
nuke.knobDefault("StickyNote.note_font_size", "40")  

# WRITE DEFAULT
	#Gets filename before the render and places it in pre-written folder
nuke.knobDefault('Write.beforeRender', 'nuke.thisNode()["file"].setValue(nuke.root().name().replace("scripts","renders").replace(".nk",".mov")')

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