MMtoKey 0.7

how to install
1. Extract files to your scripts folder.
2. Open editor with python code:
MMtoKey.ui()
3. Create hotkey(s) in "hotkey" tab. Maya 2016 not supported!
4. Create sets and connect them to your marking menus and commands.


version history:
0.1
-call marking menus via press one button
-mask. Makes unselectable components whick not nexessary

0.2
-mask removed
-PyQt removed. Now it uses PySide
-small fixes

0.3
-added ability to load marking menu from any directories
-small fixes

0.4
-no-click commands. Connect code and marking menu simultaneously
-hotkey editor
-Script recognized almost all DAG nodes and components.
-certain marking menus/commands for buttons
-marking menus be loaded from Maya's directory only
-MayaWindow: default preset for all unused combinations
-UI updated
-ablitiy to work with shift, ctrl and alt modifiers
-dockControl works with no-click commands only

0.4.1
-bug fixes
-working with custom panels

0.5
-new UI
-relationships by names
-relationships for non-dag nodes
-Python/mel switcher for marking menus

0.6
-relationship by tools (works with MMB)
-MayaWindow no-click command

0.6.1
-code optimiztions

0.7
-relationship by presets (MMB + LMB)
-new hotkey maker for presets
-errors checker

Menshikov Andrey, 2015

