# Copyright (C) 1997-2013 Autodesk, Inc., and/or its licensors.
# All rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its licensors,
# which is protected by U.S. and Canadian federal copyright law and by
# international treaties.
#
# The Data is provided for use exclusively by You. You have the right to use,
# modify, and incorporate this Data into other products for purposes authorized 
# by the Autodesk software license agreement, without fee.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. AUTODESK
# DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
# INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
# OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS
# LICENSORS BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK AND/OR ITS
# LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.

##
# @file xgToolBarUI.py
# @brief Contains a simplified replacement for QToolBar 
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Thomas V Thompson II
#
# @version Created 06/04/09
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.util.xgUtil import *


class ToolBarUI(QtGui.QWidget):
    """A simplified replacement for QToolBar.

    This better allows control over the buttons so that menus can be
    added, icons sized, and the spcing controled.
    """
    def __init__(self,iconSize,spacing=0):
        QtGui.QWidget.__init__(self)
        layout = QtGui.QHBoxLayout()
        layout.setSpacing(spacing)
        layout.setContentsMargins(0,0,0,0)
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.setSizeConstraint( QtGui.QLayout.SetFixedSize )
        self.setLayout(layout)
        self.iconSize = iconSize
        self.setMinimumWidth(100)

    def addButton(self,icon,tip,callable):
        self.button = QtGui.QToolButton()
        self.button.setIcon(QtGui.QIcon(xg.iconDir()+icon))
        self.button.setIconSize(self.iconSize)
        self.button.setToolTip(tip)
        self.button.setAutoRaise(True)
        self.button.setPopupMode(QtGui.QToolButton.DelayedPopup)
        self.connect(self.button,
                     QtCore.SIGNAL("clicked()"),
                     callable)
        self.layout().addWidget(self.button)
        return self.button
