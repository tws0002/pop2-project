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
# @file xgTextUI.py
# @brief Contains the UI for text field
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


class TextUI(QtGui.QWidget):
    """A widget for editing a text value.

    This provides for the label and an text entry box.
    """
    def __init__(self,attr,help="",object="",width=0,mainlabel=""):
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        # Widgets
        if mainlabel != "":
            self.label = QtGui.QLabel(mainlabel)
        elif object == "":
            self.label = QtGui.QLabel(attr)
        else:
            self.label = QtGui.QLabel(makeLabel(attr))
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label.setIndent(10)
        self.textValue = QtGui.QLineEdit()
        if width:
            self.textValue.setFixedWidth(width)
        else:
            self.textValue.setMinimumWidth(50)
        filler = QtGui.QWidget()
        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.textValue)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()

    def value(self):
        return str(self.textValue.text())

    def setValue(self,value):
        self.textValue.setText(value)

    def connectIt(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        self.connect(self.textValue,QtCore.SIGNAL("editingFinished()"),
                     lambda : de.setAttrCmd( self.object, self.attr, self.value() ) )

    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        value = de.getAttr(self.object,self.attr)
        self.setValue(value)
        

