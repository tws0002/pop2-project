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
# @file xgLodTab.py
# @brief Contains the UI for LOD tab
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
# @version Created 07/20/09
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets import *


class LodTabUI(QtGui.QWidget):
    def __init__(self):
        QtGui.QWidget.__init__(self)
        # A single VBox layout provides control over the tab.
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,0)
        self.setLayout(layout)

        self.lodFlag = CheckBoxUI(maya.stringTable[ 'y_xgLodTab.kLodFlag'  ],"lodFlag",
             maya.stringTable[ 'y_xgLodTab.kLodFlagAnn'  ],
             "Description")
        self.connect(self.lodFlag.boxValue[0],
                     QtCore.SIGNAL("clicked(bool)"),
                     lambda x: self.lodUpdate())
        self.layout().addWidget(self.lodFlag)
     
        self.label0 = QtGui.QLabel(makeLabel(maya.stringTable[ 'y_xgLodTab.kAverageWidth'  ]))
        self.label0.setFixedWidth(labelWidth())
        self.label0.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label0.setIndent(10)
        self.label0.setToolTip(
            maya.stringTable[ 'y_xgLodTab.kAverageWidthAnn'  ])
        self.averageWidth = QtGui.QLineEdit()
        self.averageWidth.setValidator(QtGui.QDoubleValidator(0.0,1000000.0,6,self.averageWidth))
        self.averageWidth.setFixedWidth(70)
        row = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label0)
        layout.addWidget(self.averageWidth)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.averageWidth.setToolTip(
            maya.stringTable[ 'y_xgLodTab.kAverageWidthAnn2'  ])
        self.connectIt("averageWidth",self.averageWidth)
        row.setLayout(layout)
        self.layout().addWidget(row)

        pixelFadeSizeAnn = maya.stringTable[ 'y_xgLodTab.kPixelFadeSizeAnn'  ]
        self.label1 = QtGui.QLabel(makeLabel(maya.stringTable[ 'y_xgLodTab.kBeginSize'  ]))
        self.label1.setFixedWidth(labelWidth())
        self.label1.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label1.setIndent(10)
        self.label1.setToolTip(pixelFadeSizeAnn)
        self.pixelFadeSize = QtGui.QLineEdit()
        self.pixelFadeSize.setValidator(QtGui.QDoubleValidator(0.0,1000000.0,6,self.pixelFadeSize))
        self.pixelFadeSize.setFixedWidth(70)
        row = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label1)
        layout.addWidget(self.pixelFadeSize)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.pixelFadeSize.setToolTip(pixelFadeSizeAnn)
        self.connectIt("pixelFadeSize",self.pixelFadeSize)
        row.setLayout(layout)
        self.layout().addWidget(row)

        pixelCullSizeAnn = maya.stringTable[ 'y_xgLodTab.kPixelCullSizeAnn'  ]
        self.label2 = QtGui.QLabel(makeLabel(maya.stringTable[ 'y_xgLodTab.kEndSize'  ]))
        self.label2.setFixedWidth(labelWidth())
        self.label2.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label2.setIndent(10)
        self.label2.setToolTip(pixelCullSizeAnn)
        self.pixelCullSize = QtGui.QLineEdit()
        self.pixelCullSize.setValidator(QtGui.QDoubleValidator(0.0,1000000.0,6,self.pixelCullSize))
        self.pixelCullSize.setFixedWidth(70)
        row = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label2)
        layout.addWidget(self.pixelCullSize)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.pixelCullSize.setToolTip(pixelCullSizeAnn)
        self.connectIt("pixelCullSize",self.pixelCullSize)
        row.setLayout(layout)
        self.layout().addWidget(row)

        minDensityAnn = maya.stringTable[ 'y_xgLodTab.kMinDensityAnn'  ]
        self.label3 = QtGui.QLabel(makeLabel(maya.stringTable[ 'y_xgLodTab.kDensityScale'  ]))
        self.label3.setFixedWidth(labelWidth())
        self.label3.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label3.setIndent(10)
        self.label3.setToolTip(minDensityAnn)
        self.minDensity = QtGui.QLineEdit()
        self.minDensity.setValidator(QtGui.QDoubleValidator(0.0,1.0,6,self.minDensity))
        self.minDensity.setFixedWidth(70)
        row = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label3)
        layout.addWidget(self.minDensity)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.minDensity.setToolTip(minDensityAnn)
        self.connectIt("minDensity",self.minDensity)
        row.setLayout(layout)
        self.layout().addWidget(row)

        maxWidthRatioAnn = maya.stringTable[ 'y_xgLodTab.kMaxWidthRatioAnn'  ]
        self.label4 = QtGui.QLabel(makeLabel(maya.stringTable[ 'y_xgLodTab.kWidthScale'  ]))
        self.label4.setFixedWidth(labelWidth())
        self.label4.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label4.setIndent(10)
        self.label4.setToolTip(maxWidthRatioAnn)
        self.maxWidthRatio = QtGui.QLineEdit()
        self.maxWidthRatio.setValidator(QtGui.QDoubleValidator(1.0,1000000.0,6,self.maxWidthRatio))
        self.maxWidthRatio.setFixedWidth(70)
        row = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label4)
        layout.addWidget(self.maxWidthRatio)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.maxWidthRatio.setToolTip(maxWidthRatioAnn)
        self.connectIt("maxWidthRatio",self.maxWidthRatio)
        row.setLayout(layout)
        self.layout().addWidget(row)

        #self.cullFade = FloatUI("cullFade",
        #     "Transition range in percentage for primitives to fade. " + 
        #     "0: primitives will pop in and out; 1: primitives will be " +
        #     "faded in over the whole pixel area range. (float: [0,1])",
        #     "Description")
        #self.layout().addWidget(self.cullFade)
        #self.cullWidthRatio = FloatUI("cullWidthRatio",
        #     "Percentage of the original width at which the primitive " +
        #     "will be culled. (float: [0,1])",
        #     "Description")
        #self.layout().addWidget(self.cullWidthRatio)
        self.lodUpdate()

    def value(self,attrUI):
        return str(attrUI.text())

    def setValue(self,attrUI,value):
        attrUI.setText(value)

    def connectIt(self,attr,attrUI):
        de = xgg.DescriptionEditor
        self.connect(attrUI,QtCore.SIGNAL("editingFinished()"),
                     lambda: de.setAttrCmd("Description",attr,self.value(attrUI)))

    def refreshUI(self,attr,attrUI):
        de = xgg.DescriptionEditor
        value = de.getAttr("Description",attr)
        self.setValue(attrUI,value)

    def lodUpdate(self):
        value = self.lodFlag.value()
        if value:
            self.averageWidth.setEnabled(True)
            self.pixelFadeSize.setEnabled(True)
            self.pixelCullSize.setEnabled(True)
            self.minDensity.setEnabled(True)
            self.maxWidthRatio.setEnabled(True)
            self.label0.setEnabled(True)
            self.label1.setEnabled(True)
            self.label2.setEnabled(True)
            self.label3.setEnabled(True)
            self.label4.setEnabled(True)
        else:
            self.averageWidth.setEnabled(False)
            self.pixelFadeSize.setEnabled(False)
            self.pixelCullSize.setEnabled(False)
            self.minDensity.setEnabled(False)
            self.maxWidthRatio.setEnabled(False)
            self.label0.setEnabled(False)
            self.label1.setEnabled(False)
            self.label2.setEnabled(False)
            self.label3.setEnabled(False)
            self.label4.setEnabled(False)

    def autoSet(self):
        de = xgg.DescriptionEditor
        result = mel.eval('xgmGrabGoalLOD("'+de.currentDescription()+'")')
        de.setAttr("Description","pixelFadeSize",str(result))
        self.refreshUI("pixelFadeSize",pixelFadeSize)
            
    def refresh(self):
        self.lodFlag.refresh()
        self.refreshUI("averageWidth",self.averageWidth)
        self.refreshUI("pixelFadeSize",self.pixelFadeSize)
        self.refreshUI("pixelCullSize",self.pixelCullSize)
        self.refreshUI("minDensity",self.minDensity)
        self.refreshUI("maxWidthRatio",self.maxWidthRatio)
        self.lodUpdate()
