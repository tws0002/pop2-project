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
# @file xgCheckBoxUI.py
# @brief Contains the UI for check box
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
# @version Created 06/30/09
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.util.xgUtil import *

class CheckBoxUI(QtGui.QWidget):
    """A widget for controlling a boolean value with a check box.

    This provides for the label and a single check box.
    """
    def __init__(self,mainLabel,attrs,help="",object="",fixed=0, removeSuffix=0, attrlabels=[], startSpacing=0 ):
        """This init takes a list of attributes. A row of checkboxes will be
        built with the user provided label at the head and the attribute names
        to the right of each check box."""
        QtGui.QWidget.__init__(self)
        if isinstance(attrs,list):
            self.attrs = attrs
        else:
            self.attrs = [attrs]
        self.object = object
        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        if startSpacing:
            layout.addSpacing( startSpacing )

        count = len(self.attrs)

        # Widgets
        checkboxSingleLabel = ""
        if mainLabel != "":
            leftLabel = mainLabel
            if count == 1:
                # we'll put the label on the right of the checkbox
                checkboxSingleLabel = mainLabel 
                leftLabel = ""
            label = QtGui.QLabel(leftLabel)
            label.setFixedWidth(labelWidth())
            label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
            label.setIndent(10)
            layout.addWidget(label)
        else:
            layout.addSpacing(20)

        # Check boxes
        self.boxValue = []
        multi = count>1 or mainLabel==""
        for attr in self.attrs:
            newBox = QtGui.QCheckBox(checkboxSingleLabel) 
            self.boxValue.append( newBox )
            layout.addWidget(self.boxValue[len(self.boxValue)-1])
            if multi:
                if len(attrlabels) > 0:
                    attrLabel = attrlabels.pop(0)
                else:
                    attrLabel = makeLabel(attr)
                if removeSuffix > 0:
                    attrLabel = attrLabel[0:-removeSuffix]
                
                if fixed > 0 and attr!=self.attrs[-1]:
                    newBox.setFixedWidth(fixed)
                if count >1 and attr!=self.attrs[-1]:
                    layout.addSpacing(10)
                newBox.setText(attrLabel)
        # Finish up
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()

    def value(self,index=0):
        return self.boxValue[index].isChecked()

    def setValue(self,value,index=0):
        self.boxValue[index].setChecked(value)

    def checkChanged(self,x,y):
        if self.object!="":
            xgg.DescriptionEditor.setAttrCmd( self.object, y, xg.boolToString(x) )
            xgg.DescriptionEditor.playblast()
                
    def connectIt(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        
        de = xgg.DescriptionEditor
        for index in range(len(self.attrs)):
            box = self.boxValue[index]
            box.connect(box, QtCore.SIGNAL("clicked(bool)"), 
                lambda x,y=self.attrs[index]: self.checkChanged(x,y) )

    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        for index in range(len(self.attrs)):
            value = de.getAttr(self.object,self.attrs[index])
            self.setValue(xg.stringToBool(value),index)
            
