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
# @file xgRampUI.py
# @brief Contains the UI for a ramp widget
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
import platform

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets.xgRampWidget import xgRampWidget
from maya import OpenMayaUI as omui
from shiboken import wrapInstance


class RampUI(QtGui.QWidget):
    """A widget for editing a ramp widget.
    This provides for the label and an editable ramp widget.
    """

    def __init__(self,attr,help="",object="",mainlabel=""):
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        # Widgets
        if mainlabel != "":
            label = QtGui.QLabel(mainlabel)
        elif object == "":
            label = QtGui.QLabel(attr)
        else:
            label = QtGui.QLabel(makeLabel(attr))
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTop)
        label.setIndent(10)

        self.rampValue = xgRampWidget(maya.stringTable[ 'y_xgRampUI.kSelPosition'  ],
                                      maya.stringTable[ 'y_xgRampUI.kSelValue'  ],
                                      maya.stringTable[ 'y_xgRampUI.kInterpolation'  ])
        self.popRamp = None

        self.button = QtGui.QPushButton(">")
        self.button.setFixedSize(20, 120)
        self.button.setToolTip(maya.stringTable[ 'y_xgRampUI.kPopRampWindow' ])


        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(label)
        layout.addWidget(self.rampValue)
        layout.addWidget(self.button)

        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()

        self.connect(self.button, QtCore.SIGNAL("clicked()"),self.setupSlot)

    def value(self):
        num = self.rampValue.numPoints()
        res = "rampUI("
        for index in range(num):
            if index > 0:
                res += ":"
            val = self.rampValue.getPoint(index)
            res += str(val[0])+","+str(val[1])+","+str(val[2])
        res += ")"
        return res

    def setValue(self,value):
        value = value.strip()
        if not value.startswith("rampUI("):
            print maya.stringTable['y_xgRampUI.kRampUIInvalidValue' ],self.attr,value
            return
        self.rampValue.clear()
        value = value.replace("rampUI(","")
        value = value.replace(")","")
        points = value.split(":")
        minx = 1.1
        for point in points:
            tok = point.split(",")
            x = float(tok[0])
            y = float(tok[1])
            interp = int(tok[2])
            select = False
            if x < minx:
                select = True
                minx = x
            self.rampValue.addPoint(x,y,interp,select)

    def _pointUpdated(self):
        de = xgg.DescriptionEditor
        de.setAttrCmd( self.object, self.attr, self.value() )
        xgg.DescriptionEditor.playblast()

    def connectIt(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        #update in viewport
        self.rampValue.pointAdded.connect(self._pointUpdated)
        self.rampValue.pointRemoved.connect(self._pointUpdated)
        self.rampValue.pointChanged.connect(self._pointUpdated)


    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        value = de.getAttr(self.object,self.attr)
        self.setValue(value)


    def setupSlot(self):

        if self.popRamp == None:
            self.popRamp = PopRampUI(self.rampValue.scene.curve, self.attr, self.object)
            self.popRamp.rampValue.scene.selectedItem = self.rampValue.scene.selectedItem
            
            tpos = self.popRamp.rampValue.scene.curve.cv[self.popRamp.rampValue.scene.selectedItem][0]
            tval = self.popRamp.rampValue.scene.curve.cv[self.popRamp.rampValue.scene.selectedItem][1]

            posStr = "%.3f" % tpos
            valStr = "%.3f" % tval

            self.popRamp.rampValue.selPosEdit.setText(str(posStr))
            self.popRamp.rampValue.selValEdit.setText(str(valStr))

        self.popRamp.rampValue.pointAdded.connect(self._pointUpdated)
        self.popRamp.rampValue.pointRemoved.connect(self._pointUpdated)
        self.popRamp.rampValue.pointChanged.connect(self._pointUpdated)

        self.popRamp.rampValue.pointAdded.connect(self.rampValue.onAddPoint)
        self.popRamp.rampValue.pointRemoved.connect(self.rampValue.onRemovePoint)
        self.popRamp.rampValue.pointMoving.connect(self.rampValue.onModifyPoint)

        self.rampValue.pointAdded.connect(self.popRamp.rampValue.onAddPoint)
        self.rampValue.pointRemoved.connect(self.popRamp.rampValue.onRemovePoint)
        self.rampValue.pointMoving.connect(self.popRamp.rampValue.onModifyPoint)

        self.popRamp.run()







class PopRampUI(QtGui.QWidget):

    def __init__(self,RampCurve,attr,object=""):

        # Initialize the object as a QWidget
        QtGui.QWidget.__init__(self)
        mayaMainWindowPtr = omui.MQtUtil.mainWindow()
        mayaMainWindow = wrapInstance(long(mayaMainWindowPtr), QtGui.QWidget)
        self.setParent(mayaMainWindow)


        self.attr = attr
        self.object = object

        # We have to set the size of the main window
        # ourselves, since we control the entire layout)
        self.resize(600, 200)
        self.setWindowTitle(attr)
        plat = platform.system()
        if plat == "Windows":
            self.setWindowFlags(QtCore.Qt.Window)
        elif plat == "Linux":
            self.setWindowFlags(QtCore.Qt.Window)
        else:
            self.setWindowFlags(QtCore.Qt.Window|QtCore.Qt.WindowStaysOnTopHint)

        self.rampValue = xgRampWidget(maya.stringTable[ 'y_xgRampUI.kSelPositionRamp'  ],
                                      maya.stringTable[ 'y_xgRampUI.kSelValueRamp'  ],
                                      maya.stringTable[ 'y_xgRampUI.kInterpolationRamp'  ], 
                                      RampCurve,None, 413)

        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.rampValue)

        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.setLayout(layout)

    def run(self):
        # Show the form
        self.setVisible(True)
        if self.isMinimized():
            self.showNormal() 

        self.show()
