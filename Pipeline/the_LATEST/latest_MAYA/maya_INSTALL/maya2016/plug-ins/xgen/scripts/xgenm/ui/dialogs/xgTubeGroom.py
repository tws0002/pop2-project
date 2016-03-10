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
# @file xgTubeGroom.py
# @brief Contains the dialog definition for tube based grooming
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
# @version Created 12/06/11
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds
from xgenm.ui.widgets import *
from xgenm.ui.util.xgProgressBar import setProgressInfo


class TubeGroomUI(QtGui.QDialog):
    """A dialog to control attributes for tube based grooming.

    This provides the interface for building guides based on modeled
    tubes that represent volumes for the groom. The attributes control
    guide density per tube, whether the guides should all be the same 
    length or match the tube, and the texel resolution for the region
    map that will control interpolation based on the tubes.
    """
    def __init__(self,object):
        QtGui.QDialog.__init__(self,xgg.DescriptionEditor)
        self.setWindowTitle(maya.stringTable[ 'y_xgTubeGroom.kTubeBasedGrooming'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(600)
        layout = QtGui.QVBoxLayout()
        de = xgg.DescriptionEditor
        self.tubes = TextUI("tubes",maya.stringTable[ 'y_xgTubeGroom.kTubesAnn'  ],
                            object,0)
        self.tubes.label.setText(maya.stringTable[ 'y_xgTubeGroom.kTubes'  ])
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_: ]*")
        self.tubes.textValue.setValidator(QtGui.QRegExpValidator(rx,self))
        self.tubes.refresh()
        self.bindButton = QtGui.QToolButton()
        self.bindButton.setArrowType(QtCore.Qt.LeftArrow)
        self.bindButton.setFixedSize(12,20)
        self.tubes.layout().insertWidget(2,self.bindButton,100)
        self.connect(self.bindButton, QtCore.SIGNAL("clicked(bool)"),
                     self.bindTubes)
        layout.addWidget(self.tubes)

        self.spacing = FloatUI("guideSpacing",
                               maya.stringTable[ 'y_xgTubeGroom.kSpacingAnnxs'  ],
                               object,0.0,1000000,0.01,2.0)
        self.spacing.label.setText(maya.stringTable[ 'y_xgTubeGroom.kGuideSpacing'  ])
        self.spacing.refresh()
        self.count = QtGui.QLabel(maya.stringTable[ 'y_xgTubeGroom.kUnkownGuides'  ])
        self.count.setFixedWidth(85)
        self.count.setToolTip(maya.stringTable[ 'y_xgTubeGroom.kGuideNumberAnn'  ])
        self.spacing.layout().addWidget(self.count)
        self.test1Button = QtGui.QPushButton(maya.stringTable[ 'y_xgTubeGroom.kTest1'  ])
        self.test1Button.setFixedWidth(70)
        self.test1Button.setAutoRepeat(False)
        self.test1Button.setToolTip(maya.stringTable[ 'y_xgTubeGroom.kSpacingAnn2'  ])
        self.connect(self.test1Button, QtCore.SIGNAL("clicked()"),
                     self.testGuides)
        self.spacing.layout().addWidget(self.test1Button)
        layout.addWidget(self.spacing)
        self.guideMask = ExpressionUI("guideMask",
               maya.stringTable[ 'y_xgTubeGroom.kGuideMaskAnn'  ],
               object)
        self.guideMask.label.setText(maya.stringTable[ 'y_xgTubeGroom.kGuideMask'  ])
        self.guideMask.refresh()
        layout.addWidget(self.guideMask)
        self.cutParam = ExpressionUI("cutParam",
               maya.stringTable[ 'y_xgTubeGroom.kCutParamAnn' ],
               object)
        self.cutParam.label.setText(maya.stringTable[ 'y_xgTubeGroom.kCutParam'  ])
        self.cutParam.refresh()
        layout.addWidget(self.cutParam)        
        self.freq = FloatUI("CVFrequency",
                            maya.stringTable[ 'y_xgTubeGroom.kFloatUIAnn' ],
                               object,0.0001,100.0)
        self.freq.label.setText(maya.stringTable[ 'y_xgTubeGroom.kCvFrequency'  ])
        self.freq.refresh()
        layout.addWidget(self.freq)        

        self.tpu = FloatUI("texelsPerUnit",
             maya.stringTable[ 'y_xgTubeGroom.kTexelsPerUnitAnn'  ],
             object,0.0,10000,1.0,50.0)
        self.tpu.label.setText(maya.stringTable[ 'y_xgTubeGroom.kTexelsPerUnit'  ])
        self.connect(self.tpu.floatValue,QtCore.SIGNAL("editingFinished()"),
                     self.tpuUpdate)
        self.tpu.refresh()
        self.mem = QtGui.QLabel(maya.stringTable[ 'y_xgTubeGroom.kMb'  ])
        self.mem.setFixedWidth(85)
        self.mem.setToolTip(maya.stringTable[ 'y_xgTubeGroom.kMemorySizeInMb'  ])
        self.tpu.layout().addWidget(self.mem)
        self.test2Button = QtGui.QPushButton(maya.stringTable[ 'y_xgTubeGroom.kTest2'  ])
        self.test2Button.setFixedWidth(70)
        self.test2Button.setAutoRepeat(False)
        self.test2Button.setToolTip(maya.stringTable[ 'y_xgTubeGroom.kTestAnn'  ])
        self.connect(self.test2Button, QtCore.SIGNAL("clicked()"),
                     self.testMaps)
        self.tpu.layout().addWidget(self.test2Button)
        layout.addWidget(self.tpu)
        layout.addSpacing(20)

        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.generateButton = QtGui.QPushButton(maya.stringTable[ 'y_xgTubeGroom.kGenerate'  ])
        self.generateButton.setFixedWidth(100)
        self.generateButton.setAutoRepeat(False)
        self.generateButton.setToolTip(maya.stringTable[ 'y_xgTubeGroom.kGenerateAnn'  ])
        self.connect(self.generateButton, QtCore.SIGNAL("clicked()"),
                     self.generate)
        hbox.addWidget(self.generateButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgTubeGroom.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgTubeGroom.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.close)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)

        self.setLayout(layout)
        self.tpuUpdate()

    def testGuides(self):
        de = xgg.DescriptionEditor
        tubes = self.tubes.value()
        cmds.select(tubes.split(),r=True)
        dist = self.spacing.value()
        mask = self.guideMask.value()
        cmd = 'xgmPolyToGuide -createLocators'
        cmd += ' -d "'+de.currentDescription()+'"'
        cmd += ' -distance '+str(dist)
        cmd += ' -guideMask "'+str(mask)+'"'
        num = mel.eval(cmd)
        if num:
            self.count.setText(maya.stringTable['y_xgTubeGroom.kTubeGroomTestGuides' ].format(num))
            
    def testMaps(self):
        import tempfile
        
        de = xgg.DescriptionEditor
        tubes = self.tubes.value()
        tpu = self.tpu.value()
        cmds.select(tubes.split(),r=True)
        cmd = 'xgmPolyToGuide -testMap'
        cmd += ' -texelsPerUnit '+str(tpu)
        cmd += ' -regionMapDir ' +  tempfile.gettempdir() + '/xgenTubeGroom/'
        cmd += ' -d "'+de.currentDescription()+'"'
        print(mel.eval(cmd))

    def generate(self):
        de = xgg.DescriptionEditor
        tubes = self.tubes.value()
        cmds.select(tubes.split(),r=True)
        dist = self.spacing.value()
        mask = self.guideMask.value()
        tpu = self.tpu.value()
        cut = self.cutParam.value()
        freq = self.freq.value()
        cmd = 'xgmPolyToGuide -createAll'
        cmd += ' -d "'+de.currentDescription()+'"'
        cmd += ' -distance '+str(dist)
        cmd += ' -guideMask "'+str(mask)+'"'
        cmd += ' -cutParam "'+str(cut)+'"'
        cmd += ' -cvFrequency '+str(freq)
        cmd += ' -texelsPerUnit '+str(tpu)
        cmd += ' -regionMapDir "${DESC}/Region/"'
        setProgressInfo(maya.stringTable[ 'y_xgTubeGroom.kTubeGroomProgressGeneratingRegionMaps'  ])
        print(mel.eval(cmd))
        self.close()

    def tpuUpdate(self):
        de = xgg.DescriptionEditor
        tpu = self.tpu.value()
        cmd = 'xgmClumpMap -computeMemory'
        cmd += ' -texelsPerUnit '+tpu
        cmd += ' -d "'+de.currentDescription()+'"'
        memUsed = mel.eval(cmd)
        if memUsed > 1024.0:
            memUsed = memUsed/1024.0
            if memUsed > 1024.0:
                memUsed = memUsed/1024.0
                self.mem.setText(' {0:0.3f} TB'.format(memUsed))
            else:
                self.mem.setText(' {0:0.3f} GB'.format(memUsed))
        else:
            self.mem.setText(' {0:0.3f} MB'.format(memUsed))
        
    def bindTubes(self):
        selection = cmds.ls(sl=True)
        tubes = ""
        for item in selection:
            tube = str(item)
            tubes += tube + " "
        self.tubes.setValue(tubes)

    def closeEvent(self, event):
        mel.eval('xgmPolyToGuide -deleteLocators')
        mel.eval('xgmLoadPtexToolCleanUp()')
        self.accept()
