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
# @file xgMapBinding.py
# @brief Contains the dialog for chosing map directory for map binding.
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
# @version Created 03/10/11
#

import string

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI


class MapBindingsUI(QtGui.QDialog):
    modifyBindingBox = 0
    """Function to modify patch bindings via map using a dialog.

    This provides a simple dialog to accept the directory name and a check
    box for optionally inverting the map. The user can use a browser to
    search for the directory.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgMapBindings.kBindFacesBasedOnMap'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        self.de = xgg.DescriptionEditor
        layout = QtGui.QVBoxLayout()
        self.dirName = BrowseUI(maya.stringTable[ 'y_xgMapBindings.kMapDirectory'  ],
                                maya.stringTable[ 'y_xgMapBindings.kMapDirectoryAnn'  ])
        self.dirName.optionButton.setToolTip(maya.stringTable[ 'y_xgMapBindings.kBrowseUIAnn'  ])
        self.dirName.setValue("xgen/density/")
        layout.addWidget(self.dirName)

        comborow = QtGui.QWidget()
        combobox = QtGui.QHBoxLayout()
        combobox.setAlignment(QtCore.Qt.AlignRight)
        combobox.setContentsMargins(1,1,1,1)
        self.colourLabel = QtGui.QLabel(maya.stringTable[ 'y_xgMapBindings.kBindToFacesWhereMapIs'  ])
        combobox.addWidget(self.colourLabel)
        self.whiteOrBlackcb = _ComboBoxUI()
        self.whiteOrBlackcb.addItem(maya.stringTable[ 'y_xgMapBindings.kWhite'  ])
        self.whiteOrBlackcb.addItem(maya.stringTable[ 'y_xgMapBindings.kBlack'  ])
        self.whiteOrBlackcb.setCurrentIndex(MapBindingsUI.modifyBindingBox)
        self.connect(self.whiteOrBlackcb, QtCore.SIGNAL("activated(int)"),self.typeUIChangedSlot)
        combobox.addWidget(self.whiteOrBlackcb)
        comborow.setLayout(combobox)
        layout.addWidget(comborow)
        
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.bindButton = QtGui.QPushButton(maya.stringTable[ 'y_xgMapBindings.kBind'  ])
        self.bindButton.setToolTip(maya.stringTable[ 'y_xgMapBindings.kBindAnn'  ])
        self.bindButton.setAutoRepeat(False)
        self.connect(self.bindButton, QtCore.SIGNAL("clicked()"),
                     self.accept)
        hbox.addWidget(self.bindButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgMapBindings.kCancel'  ])
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgMapBindings.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)

    def getDirName(self):
        return str(self.dirName.value())
    
    def getInvert(self):
        return MapBindingsUI.modifyBindingBox

    def typeUIChangedSlot(self, pos):
        MapBindingsUI.modifyBindingBox = pos
        self.whiteOrBlackcb.setCurrentIndex(pos)

def mapBindings(cpal,cdesc):
    """Function to modify patch bindings via map using a dialog.

    This provides a simple dialog to accept the directory name and a check
    box for optionally inverting the map. The user can use a browser to
    search for the directory.
    """
    dialog = MapBindingsUI()
    result = dialog.exec_()
    if result == QtGui.QDialog.Accepted:
        mapDir = dialog.getDirName()
        invert = dialog.getInvert()
        if len(mapDir):
            if xgg.Maya:
                xg.modifyFaceBinding(cpal,cdesc,"Map",mapDir,invert)
            else:
                goPort = QtGui.QMessageBox()
                goPort.setText(maya.stringTable[ 'y_xgMapBindings.kMapBasedBindingOnlyAvailableInMaya'  ])
                goPort.exec_()
                
