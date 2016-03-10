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
# @file xgIntegerUI.py
# @brief Contains the UI for editing an integer value
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


class IntegerUI(QtGui.QWidget):
    """A widget for editing an integer value.

    This provides for the label and an integer entry box.
    """
    xgAttrChanged = QtCore.Signal()

    def __init__(self,attr,help="",object="",iMin=-1e7,iMax=1e8,mainlabel="",autoPlayblast=True):
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        self.iMin = iMin
        self.iMax = iMax
        self.autoPlayblast=autoPlayblast

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
        self.intValue = QtGui.QLineEdit()
        self.validate = QtGui.QIntValidator(self.iMin,self.iMax,
                                            self.intValue)
        self.validate.fixup = self.myFixup
        self.intValue.setValidator(self.validate)
        self.intValue.setFixedWidth(62)
        filler = QtGui.QWidget()
        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.intValue)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()

    def myFixup(self,value):
        if int(value)<=self.iMin:
            self.setValue(self.iMin)
        elif int(value)>=self.iMax:
            self.setValue(self.iMax)
        self.intValue.emit(QtCore.SIGNAL("editingFinished()"))

    def value(self):
        return str(self.intValue.text())

    def setValue(self,value):
        self.intValue.setText(str(value))

    def setAttrCmd(self):
        ret = xgg.DescriptionEditor.setAttrCmd( self.object, self.attr, self.value() )
        self.xgAttrChanged.emit()
        return ret

    def editChanged(self):
        if self.object!="" and self.setAttrCmd():
            if self.autoPlayblast:
                xgg.DescriptionEditor.playblast()
                
    def connectIt(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        self.connect(self.intValue,QtCore.SIGNAL("editingFinished()"), self.editChanged )

    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        value = de.getAttr(self.object,self.attr)
        self.setValue(value)
