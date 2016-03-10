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
# @file xgFXModuleTab.py
# @brief Contains the FX Module Base UI.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
#

import os
import string
import traceback

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.widgets import *


class FXModuleTabUI(QtGui.QWidget):
    def __init__(self,selfName,printname=""):
        QtGui.QWidget.__init__(self)
        self.name = selfName
        # A single VBox layout provides control over the tab.
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        layout.setSpacing(0)
        layout.setContentsMargins(0,0,0,0)
        self.setLayout(layout)
        self.printableName = printname

    def baseTopUI(self):
        # Header for the derived class attributes
        self.maskExpr = ExpressionUI("mask",
             maya.stringTable[ 'y_xgFXModuleTab.kMaskAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgFXModuleTab.kMask'  ])
        self.layout().addWidget(self.maskExpr)

    def refresh(self):
        de = xgg.DescriptionEditor
        if self.name != "<None>":
            self.maskExpr.refresh()

    # virtual called when the active switch is toggled
    def activeUpdate(self ):
        pass
    
    def cleanScriptJob(self):        
        for i in range( self.layout().count() ):  
            try:
                self.layout().itemAt(i).widget().cleanScriptJob()
            except:
                pass            


class FXModuleTabBlankUI(FXModuleTabUI):
    """
    Convenience class that prints out a UI with no additional attributes, and a
    label saying there are no attributes.

    Example:
        class MyWonderfulFXModuleTabUI(FXModuleTabBlankUI):
            def __init__(self):
               MyWonderfulFXModuleTabUI.__init__("MyWonderful", "my wonderful")
    """
    def __init__(self, typename, printablename = None):
        FXModuleTabUI.__init__(self, typename)
        self.baseTopUI()
        self.layout().addSpacing(5)
        if printablename:
            labeltext = printablename
        else:
            labeltext = typename
        label = QtGui.QLabel(maya.stringTable[ 'y_xgFXModuleTab.kNoExtraAttributes'  ] % labeltext)
        label.setIndent(135)
        label.font().setItalic(True)
        self.layout().addWidget(label)
