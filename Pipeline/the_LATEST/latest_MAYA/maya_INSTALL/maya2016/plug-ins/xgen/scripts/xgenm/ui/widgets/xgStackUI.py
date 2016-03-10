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
import maya
maya.utils.loadStringResourcesForModule(__name__)


##
# @file xgStackUI.py
# @brief Contains a simplified replacement for QStackWidget
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


class StackUI(QtGui.QWidget):
    """A simplified replacement for QStackWidget.

    This provides the core functionality of a QStackWidget but will
    allow space to be reclaimed as stack items are toggled.
    """
    def __init__(self, margin=3):
        QtGui.QWidget.__init__(self)
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        layout.setSpacing(0)
        layout.setContentsMargins(margin,margin,margin,margin)
        self.setLayout(layout)
        self.stack = []
        self.current = -1

    def widget(self):
        if self.current >= 0:
            return self.stack[self.current]
        return None

    def addWidget(self,widget):
        if self.current >= 0:
            self.stack[self.current].setVisible(False)
        self.current = len(self.stack)
        self.stack.append(widget)
        self.layout().addWidget(widget)

    def setCurrent(self,current):
        if (current >= len(self.stack)) or (current < 0 ):
            return
        if self.current >= 0:
            self.stack[self.current].setVisible(False)
        self.current = current
        self.stack[self.current].setVisible(True)

    def clear(self):
        self.current = -1
        for widget in self.stack:
            widget.widget().cleanScriptJob()
            self.layout().removeWidget(widget)
            destroyWidget(widget)
        self.stack = []

    def setCurrentByTypeName(self,typename):
        indexFound = -1
        for index,widget in enumerate(self.stack):
            if widget.type == typename:
                indexFound = index
                break

        if indexFound == -1:
            raise ValueError(maya.stringTable['y_xgStackUI.kXgStackUITypeNameNotFound' ] % typename)
        else:
            self.setCurrent( indexFound )
    
    def currentWidgetNum(self):
        return len(self.stack)

