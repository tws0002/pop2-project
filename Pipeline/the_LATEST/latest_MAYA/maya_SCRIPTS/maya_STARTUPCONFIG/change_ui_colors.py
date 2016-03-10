#!/usr/bin/python

"""
..Project::
 Portal Origins: Part Two
..Description::
 Changes the UI colors/fonts/styles for the active Maya GUI session
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os
import inspect

# IMPORT THIRD PARTY LIBRARIES
from maya import cmds
from maya import mel
from maya import OpenMayaUI as omui 

from PySide.QtCore import * 
from PySide.QtGui import * 
from shiboken import wrapInstance 

# IMPORT LOCAL LIBRARIES
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()

MAYAMENUS = [ '$gMainFileMenu', '$gMainEditMenu', 
              '$gMainSelectMenu', '$gMainModifyMenu', 
              '$gMainDisplayMenu', '$gMainWindowMenu', 
              '$gMainOptionsMenu', '$gMainCreateMenu',
            ] 

def change_maya_ui_text(color='green'):
    omui.MQtUtil.mainWindow()    
    ptr = omui.MQtUtil.mainWindow()

    try:
        widget = wrapInstance(long(ptr), QWidget)
        widget.setStyleSheet( 'color:%s;'%color )
    except TypeError as exc:
        lineNum = inspect.currentframe().f_back.f_lineno - 2
        LOGGER.debug(["AIE7800"], {'num': lineNum, 
                                   'exc': exc,
                                   'script': os.path.realpath(__file__)})

# end change_maya_ui_text

def change_maya_menu_colors( menu, fontStyle='italic', 
                             fontWeight='bold'
                           ):
    try:
        widgetStr = mel.eval( 'string $tempString = {0}'.format(menu))
        ptr = omui.MQtUtil.findControl( widgetStr )    
        widget = wrapInstance(long(ptr), QWidget)
        widget.setStyleSheet(
                                'font-style:%s;'%fontStyle + 
                                'font-weight:%s;'%fontWeight
                            )
    except RuntimeError as exc:
        lineNum = inspect.currentframe().f_back.f_lineno - 2
        LOGGER.debug(["AIE7800"], {'num': lineNum, 
                                   'exc': exc,
                                   'script': os.path.realpath(__file__)})
# end change_maya_menu_colors

def main():
    change_maya_ui_text( color='rgb(68,210,68)' )
    for menu in MAYAMENUS:
        change_maya_menu_colors( menu=menu, fontStyle='italic', 
                                 fontWeight='bold' 
                                )
# end main