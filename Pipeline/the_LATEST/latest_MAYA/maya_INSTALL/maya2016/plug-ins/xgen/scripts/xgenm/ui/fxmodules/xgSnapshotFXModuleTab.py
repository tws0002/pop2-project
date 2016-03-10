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
# @file xgSnapshotFXModuleTab.py
# @brief Contains the Snapshot FX Module UI.
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
# @version Created 04/29/10
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *


class SnapshotFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgSnapshotFXModuleTab.kSnapshotModifier'  ])
        # Widgets
        self.baseTopUI()
        
        self.snapshotDir = BrowseUI("snapshotDir",
             maya.stringTable[ 'y_xgSnapshotFXModuleTab.kSnapshotDirAnn'  ],
             self.name,"","in",
             maya.stringTable[ 'y_xgSnapshotFXModuleTab.kSnapshotDir'  ])
        self.layout().addWidget(self.snapshotDir)

        self.magnitude = ExpressionUI("magnitude",
             maya.stringTable[ 'y_xgSnapshotFXModuleTab.kMagnitudeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgSnapshotFXModuleTab.kMagnitude'  ])
        self.layout().addWidget(self.magnitude)

        if ( xgg.Maya ):
            self.layout().addSpacing(10)
            buttonBox = QtGui.QWidget()
            buttonLayout = QtGui.QHBoxLayout()
            buttonLayout.setAlignment(QtCore.Qt.AlignRight)
            buttonLayout.setSpacing(3)
            buttonLayout.setContentsMargins(1,1,1,1)
            buttonBox.setLayout(buttonLayout)
            self.snapButton = QtGui.QPushButton(maya.stringTable[ 'y_xgSnapshotFXModuleTab.kSnapshot'  ])
            buttonLayout.addWidget(self.snapButton)
            self.layout().addWidget(buttonBox)
            self.connect(self.snapButton, QtCore.SIGNAL("clicked()"),
                         self.snapSlot)
        self.activeUpdate()

    def activeUpdate(self):
        isActive = xg.stringToBool( xgg.DescriptionEditor.getAttr(self.name,"active") )
        if isActive:
            if ( xgg.Maya ):
                self.snapButton.setEnabled(True)
        else:
            if ( xgg.Maya ):
                self.snapButton.setEnabled(False)
                
    def snapSlot(self):
        # Note: There are some assumptions here. First, it is assumed
        # that the Snapshot fx module is last. There is no attempt made
        # here to turn off modules that follow the snapshot. Second,
        # it is assumed the module is active in order for this method
        # to have been called in the first place.
        de = xgg.DescriptionEditor
        desc = de.currentDescription()
        pal = de.currentPalette()
        # Turn off snapshot module during the baking process
        xg.setAttr("active","false",pal,desc,self.name)
        snapDir = xg.getAttr("snapshotDir",pal,desc,self.name)
        snapDir = snapDir.replace("${FXMODULE}",self.name)
        # record the current render then switch to the file renderer
        origRenderer = xg.getActive(pal,desc,"Renderer")
        xg.setActive(pal,desc,"FileRenderer")
        # grab current values in case renderer already in use
        percent = xg.getAttr("percent",pal,desc,"FileRenderer")
        inCam = xg.getAttr("inCameraOnly",pal,desc,"FileRenderer")
        outDir = xg.getAttr("outputDir",pal,desc,"FileRenderer")
        # override with bake requirements
        xg.setAttr("precent","100",pal,desc,"FileRenderer")
        xg.setAttr("inCameraOnly","false",pal,desc,"FileRenderer")
        xg.setAttr("outputDir",snapDir,pal,desc,"FileRenderer")
        # temporarily turn off lod so we dont bake it in
        lod = xg.getAttr("lodFlag",pal,desc)
        xg.setAttr("lodFlag","False",pal,desc)
        # render the xpd files
        cmd = 'xgmFileRender -pb '
        cmd += '{"'+desc+'"}'
        files = mel.eval(cmd)
        # retore everything
        xg.setAttr("percent",percent,pal,desc,"FileRenderer")
        xg.setAttr("inCameraOnly",inCam,pal,desc,"FileRenderer")
        xg.setAttr("outputDir",outDir,pal,desc,"FileRenderer")
        xg.setAttr("lodFlag",lod,pal,desc)
        xg.setActive(pal,desc,origRenderer)
        xg.setAttr("active","true",pal,desc,self.name)
        # display results
        print maya.stringTable[ 'y_xgSnapshotFXModuleTab.kTheFollowingFiles'  ]
        print files

    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.snapshotDir.refresh()
        self.magnitude.refresh()
        self.activeUpdate()
