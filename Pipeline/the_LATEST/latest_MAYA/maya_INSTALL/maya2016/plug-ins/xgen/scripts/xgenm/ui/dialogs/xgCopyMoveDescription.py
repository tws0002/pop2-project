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
# @file xgCopyMoveDescription.py
# @brief Contains the Copy or Move description UI.
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
# @version Created 07/07/09
#

import string

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds
from xgenm.ui.widgets import *
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI


class CopyMoveDescriptionUI(QtGui.QDialog):
    """A dialog to allow copying a description.

    This provides combo boxes to pick the palette and description to
    copy, the palette to copy into, and a text field for the name of the
    new description. Buttons to copy or cancel are supplied.
    """
    def __init__(self,type,isMove):
        QtGui.QDialog.__init__(self)
        self.type = type
        if(isMove):
            self.setWindowTitle(maya.stringTable[ 'y_xgCopyMoveDescription.kMoveDescription'  ])
        else:
            self.setWindowTitle(maya.stringTable[ 'y_xgCopyMoveDescription.kDuplicateDescription'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        layout = QtGui.QVBoxLayout()

        # create a grid for the input widgets
        grid = QtGui.QWidget()
        gridLayout = QtGui.QGridLayout()
        gridLayout.setSpacing(10)
        gridLayout.setContentsMargins(0,0,0,0)
        grid.setLayout(gridLayout)
        layout.addWidget(grid)

        # row for labels
        if(isMove):
            label = QtGui.QLabel(maya.stringTable[ 'y_xgCopyMoveDescription.kMoveFrom'  ])
        else:
            label = QtGui.QLabel(maya.stringTable[ 'y_xgCopyMoveDescription.kFrom'  ])
        label.setAlignment(QtCore.Qt.AlignLeft)
        gridLayout.addWidget(label,0,0)
        gridLayout.setColumnMinimumWidth(0,220)
        gridLayout.setColumnStretch(0,50)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgCopyMoveDescription.kTo'  ])
        label.setAlignment(QtCore.Qt.AlignLeft)
        gridLayout.addWidget(label,0,1)
        gridLayout.setColumnMinimumWidth(1,220)
        gridLayout.setColumnStretch(1,50)
        
        # row for palettes
        self.fromPalette = _ComboBoxUI()
        palettes = xg.palettes()
        for pal in palettes:
            self.fromPalette.addItem(pal)
        self.connect(self.fromPalette, 
                     QtCore.SIGNAL("activated(const QString&)"), 
                     self.refresh)
        self.fromPalette.setMinimumWidth(220)
        gridLayout.addWidget(self.fromPalette,1,0)
        self.toPalette = _ComboBoxUI()
        self.toPalette.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kNewCollectionAnn'  ])
        self.toPalette.setMinimumWidth(220)
        gridLayout.addWidget(self.toPalette,1,1)

        # row for descriptions
        self.fromDescr = _ComboBoxUI()
        self.fromDescr.setMinimumWidth(220)
        gridLayout.addWidget(self.fromDescr,2,0)
        self.toDescr = QtGui.QLineEdit()
        self.toDescr.setMinimumWidth(220)
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_]*")
        self.toDescr.setValidator(QtGui.QRegExpValidator(rx,self))
        if(isMove):
            self.toDescr.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kNewNameMoveAnn'  ])
        else:
            self.toDescr.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kNewNameAnn'  ])
        
        gridLayout.addWidget(self.toDescr,2,1)
        fpal = str(self.fromPalette.currentText())
        descrs = xg.descriptions(fpal)
        if(isMove):
            descr = descrs[0]
        else:
            descr = descrs[0]+"_copy"
        self.toDescr.setText(descr)

        # row for description only check box
        self.descrOnly = QtGui.QCheckBox(maya.stringTable[ 'y_xgCopyMoveDescription.kDescriptionOnly'  ])
        self.descrOnly.setChecked(True)
        self.descrOnly.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kIncludePatchBindingsAnn'  ])
        gridLayout.addWidget(self.descrOnly,3,0,1,2)

        # create row of buttons
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(15)
        hbox.setContentsMargins(1,1,1,1)
        self.applyButton = QtGui.QPushButton(type)
        self.applyButton.setDefault(True)
        self.applyButton.setAutoRepeat(False)
        self.applyButton.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kApplyAnn'  ] % type)
        self.connect(self.applyButton, QtCore.SIGNAL("clicked()"),self.applyCB)
        hbox.addWidget(self.applyButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgCopyMoveDescription.kCancel'  ])
        self.cancelButton.setAutoRepeat(False)
        if(isMove):
            self.cancelButton.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kCancelAnn'  ])
        else:
            self.cancelButton.setToolTip(maya.stringTable[ 'y_xgCopyMoveDescription.kCancelDuplicationAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)
        self.refresh()

    def refresh(self):
        # put all palettes but the fromPalette into toPalette
        self.toPalette.clear()
        fpal = str(self.fromPalette.currentText())
        palettes = xg.palettes()
        for pal in palettes:
            if self.type == "Copy" or pal != fpal:
                self.toPalette.addItem(pal)
        # put all the descriptions for fromPalette into fromDescr
        self.fromDescr.clear()
        descrs = xg.descriptions(fpal)
        for descr in descrs:
            self.fromDescr.addItem(descr)
            
    def checkValid(self):
        if self.getToDescription() == "":
            tellem = QtGui.QMessageBox()
            tellem.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kYouMustSpecifyADestinationDescriptionName'  ])
            tellem.exec_()
            return False
        if ( self.type == "Copy" and
             self.getFromPalette() == self.getToPalette() and
             self.getFromDescription() == self.getToDescription() ):
            tellem = QtGui.QMessageBox()
            tellem.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kYouMustSpecifyADifferentName'  ])
            tellem.exec_()
            return False
        if ( cmds.objExists( self.getToDescription() ) and
             ( self.type == "Copy" or
               ( self.type == "Move" and
                 self.getToDescription() != self.getFromDescription() ) ) ):
            tellem = QtGui.QMessageBox()
            tellem.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kNameGivenForDescriptionAlreadyExitsInTheScene'  ])
            tellem.exec_()
            return False
        return True

    def applyCB(self):
        if self.checkValid():
            self.accept()
        
    def getFromPalette(self):
        return str(self.fromPalette.currentText())

    def getToPalette(self):
        return str(self.toPalette.currentText())

    def getFromDescription(self):
        return str(self.fromDescr.currentText())

    def getToDescription(self):
        return str(self.toDescr.text())

    def getDescriptionOnly(self):
        return not self.descrOnly.isChecked()


def copyDescription():
    """Function to copy a description using a dialog.
    """
    if len(xg.descriptions()) == 0:
        tellem = QtGui.QMessageBox()
        tellem.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kThereAreNoDescriptionsToCopy'  ])
        tellem.exec_()
        return
    dialog = CopyMoveDescriptionUI(maya.stringTable[ 'y_xgCopyMoveDescription.kDuplicate'  ],False)
    result = dialog.exec_()
    if result == QtGui.QDialog.Accepted:
        pal = dialog.getToPalette()
        desc = dialog.getFromDescription()
        name = dialog.getToDescription()
        deo = dialog.getDescriptionOnly()
        if xgg.Maya:
            cmd = 'xgmCopyDescription -deo '+\
                  xg.boolToString(deo)+' -n "'+name+'" -p "'+pal+'" "'+desc+'"'
            mel.eval(cmd)
            if (xgg.DescriptionEditor != 0 ):
                xgg.DescriptionEditor.refresh("Full")
        else:
            goPort = QtGui.QMessageBox()
            goPort.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kCopyDescriptionOnlyAvailableInMaya'  ])
            goPort.exec_()

                
def moveDescription():
    """Function to move a description using a dialog.
    """
    if len(xg.descriptions()) == 0 or len(xg.palettes()) < 2:
        tellem = QtGui.QMessageBox()
        tellem.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kThereAreNoDescriptionsThatCanBeMoved'  ])
        tellem.exec_()
        return
    dialog = CopyMoveDescriptionUI(maya.stringTable[ 'y_xgCopyMoveDescription.kMove'  ],True)
    result = dialog.exec_()

    if result == QtGui.QDialog.Accepted:
        pal = dialog.getToPalette()
        desc = dialog.getFromDescription()
        name = dialog.getToDescription()
        deo = dialog.getDescriptionOnly()
        if xgg.Maya:
            cmd = 'xgmMoveDescription -deo '+ xg.boolToString(deo)+' -n "'+name+'" -p "'+pal+'" "'+desc+'"'
            mel.eval(cmd)
            if (xgg.DescriptionEditor != 0 ):
                xgg.DescriptionEditor.refresh("Full")
        else:
            goPort = QtGui.QMessageBox()
            goPort.setText(maya.stringTable[ 'y_xgCopyMoveDescription.kMoveDescriptionOnlyAvailableInMaya'  ])
            goPort.exec_()


