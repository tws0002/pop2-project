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
# @file xgPointsBase.py
# @brief Contains the base dialog definition for using points
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
# @version Created 01/14/11
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds
from xgenm.ui.widgets import *


class PointsBaseUI(QtGui.QDialog):
    """A base dialog to control editing of points.

    This provides the basics for building a dialog that will allow editing
    points. A derived class can use this to flesh out a more complete 
    dialog but take advantage of this core functionality. Central things
    like making a points viewer, hooking up the length attribute, and such
    are all handled within this base class.
    """
    def __init__(self,title):
        QtGui.QDialog.__init__(self,xgg.DescriptionEditor)
        self.setWindowFlags(self.windowFlags() | QtCore.Qt.WindowStaysOnTopHint)
        self.setWindowTitle(title)
        self.setSizeGripEnabled(True)
        self.setLayout(QtGui.QVBoxLayout())

    def initDialog(self,object=""):
        self.manager = self.makeManager()
        cmds.setAttr(self.manager+".length",float(self.ptLength.value()))
        self.loadPoints(object)
        mel.eval("xgmPointsContextSelect")

    def pointDirUI(self,layout,attr,help,object="",mainlabel=""):
        self.pointDir = BrowseUI(attr,help,object,"","in",mainlabel)
        self.pointDir.optionButton.setToolTip(maya.stringTable[ 'y_xgPointsBase.kFileBrowserAnn'  ])
        if object:
            self.pointDir.refresh()
        layout.addWidget(self.pointDir)

    def ptLengthUI(self,layout,object=""):
        self.ptLength = FloatUI("ptLength",
             maya.stringTable[ 'y_xgPointsBase.kPtLengthAnn'  ],
             object,0.0,1000000,0.1,5.0)
        self.ptLength.label.setText(maya.stringTable[ 'y_xgPointsBase.kPtLength'  ])
        self.ptLength.refresh()
        layout.addWidget(self.ptLength)
        self.connect(self.ptLength.floatValue,
                     QtCore.SIGNAL("editingFinished()"),
                     self.changeLength)

    def makeManager(self):
        de = xgg.DescriptionEditor
        self.removeManager()
        parent = cmds.listRelatives(de.currentPalette(),parent=True)
        if parent:
            xform = cmds.createNode("transform",name="xgmPointsViewer#",
                                    parent=parent[0])
        else:
            xform = cmds.createNode("transform",name="xgmPointsViewer#")
        node = cmds.createNode("xgmPointsViewer",name=xform+"Shape",
                               parent=xform)
        return node

    def removeManager(self):
        visual = cmds.ls(type="xgmPointsViewer")
        if visual:
            for v in visual:
                p = cmds.listRelatives(v,parent=True)
                cmds.delete(p)

    def clearPoints(self):
        cmds.xgmPoints(clearPoints=True)

    def loadPoints(self,object=""):
        cmds.xgmPoints(loadPoints=self.pointDir.value(),module=object)
        
    def savePointsandClose(self,object=""):
        cmds.xgmPoints(savePoints=self.pointDir.value(),module=object)
        xg.ui.createDescriptionEditor(False).playblast()
        self.close()

    def savePoints(self,object=""):
        cmds.xgmPoints(savePoints=self.pointDir.value(),module=object)
        xg.ui.createDescriptionEditor(False).playblast()

    def guidePoints(self):
        cmds.xgmPoints(guidePoints=True)

    def generatePoints(self,density,mask,object=""):
        cmds.xgmPoints(generatePoints=[float(density),mask],module=object)

    def changeLength(self):
        if cmds.objExists(self.manager):
            cmds.setAttr(self.manager+".length",float(self.ptLength.value()))
        
    def closeEvent(self, event):
        self.removeManager()
        mel.eval('setToolTo "selectSuperContext"')
        self.accept()
