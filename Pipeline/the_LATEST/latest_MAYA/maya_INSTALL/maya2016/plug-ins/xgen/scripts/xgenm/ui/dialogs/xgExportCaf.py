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
# @file xgExportCaf.py
# @brief Contains the Export to Caf UI.
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
# @version Created 01/26/10
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

ExportCafFileName = ""
ExportCafStartFrame = "1.0"
ExportCafEndFrame = "2.0"

class ExportCafUI(QtGui.QDialog):
    """Function to export geometry to Caf for XGen using a dialog.

    This provides a simple dialog to accept the file name and a check
    box for optionally animated results. The user can use a browser to
    search for the file.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgExportCaf.kXgenCafExport'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        global ExportCafFileName, ExportCafStartFrame, ExportCafEndFrame
        layout = QtGui.QVBoxLayout()
        self.fileName = BrowseUI(maya.stringTable[ 'y_xgExportCaf.kCafFile'  ],
                                 maya.stringTable[ 'y_xgExportCaf.kCafFileAnn'  ],"",
                                 "*.caf","out")
        self.fileName.setValue(ExportCafFileName)
        layout.addWidget(self.fileName)
        self.anim = CheckBoxUI(maya.stringTable[ 'y_xgExportCaf.kAnimated'  ],
                               maya.stringTable[ 'y_xgExportCaf.kAnimatedAnn'  ])
        self.anim.setValue(False)
        self.connect(self.anim.boxValue[0],
                     QtCore.SIGNAL("clicked(bool)"),
                     lambda x: self.animUpdate())
        layout.addWidget(self.anim)
        self.startFrame = FloatUI(maya.stringTable[ 'y_xgExportCaf.kFrameRange'  ],
                                  maya.stringTable[ 'y_xgExportCaf.kFrameRangeAnn'  ],-1000000,1000000,0.0,1000)
        self.startFrame.setValue(ExportCafStartFrame)
        layout.addWidget(self.startFrame)
        rbox = self.startFrame.layout()
        rbox.addSpacing(5)
        self.endFrame = QtGui.QLineEdit()
        self.endFrame.setValidator(QtGui.QDoubleValidator(-1000000.0,1000000.0,6,self.endFrame))
        self.endFrame.setText(ExportCafEndFrame)
        self.endFrame.setFixedWidth(70)
        self.endFrame.setToolTip(maya.stringTable[ 'y_xgExportCaf.kEndFrameAnn'  ])
        rbox.addWidget(self.endFrame)
        
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.exportButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportCaf.kExportFile'  ])
        self.exportButton.setFixedWidth(100)
        self.exportButton.setAutoRepeat(False)
        self.exportButton.setToolTip(maya.stringTable[ 'y_xgExportCaf.kExportFileAnn'  ])
        self.connect(self.exportButton, QtCore.SIGNAL("clicked()"),
                     self.accept)
        hbox.addWidget(self.exportButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportCaf.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgExportCaf.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)
        self.animUpdate()

    def animUpdate(self):
        value = self.anim.value()
        if value:
            self.startFrame.setEnabled(True)
            self.endFrame.setEnabled(True)
        else:
            self.startFrame.setEnabled(False)
            self.endFrame.setEnabled(False)
        
    def getFileName(self):
        return str(self.fileName.value())
    
    def getAnim(self):
        return self.anim.value()

    def getStartFrame(self):
        return str(self.startFrame.value())

    def getEndFrame(self):
        return str(self.endFrame.text())


def exportCaf():
    """Function to export geometry to Caf for XGen using a dialog.

    This provides a simple dialog to accept the file name and a check
    box for optionally animated results. The user can use a browser to
    search for the file.
    """
    dialog = ExportCafUI()
    result = dialog.exec_()
    if result == QtGui.QDialog.Accepted:
        global ExportCafFileName, ExportCafStartFrame, ExportCafEndFrame
        ExportCafFileName = dialog.getFileName()
        ExportCafStartFrame = dialog.getStartFrame()
        ExportCafEndFrame = dialog.getEndFrame()
        fileName = ExportCafFileName
        anim = dialog.getAnim()
        if len(fileName):
            if xgg.Maya:
                origSel = cmds.ls(sl=True)
                sel = cmds.ls(sl=True,ni=True,dag=True)
                cmds.select(sel,replace=True)
                cmd = 'cafExport -fn "'+fileName+'" '
                if anim:
                    cmd += '-fr "'+ExportCafStartFrame
                    cmd += '-'+ExportCafEndFrame+'" '
                else:
                    frame = cmds.currentTime(q=True)
                    cmd += '-fr "'+str(frame)+'" '
                cmd += '-attribute "uvSubdivisionMethod" '
                cmd += '-attribute "mdShapeType" '
                cmd += '-attribute "REGEXP{^xgen}" '
                cmd += '-attribute "PREFIX{(rman(fv|pp)?|ribUser)[CFNPVSI]}" '
                mel.eval(cmd)
                cmds.select(origSel,replace=True)
            else:
                goPort = QtGui.QMessageBox()
                goPort.setText(maya.stringTable[ 'y_xgExportCaf.kExportToCafOnlyAvailableInMaya'  ])
                goPort.exec_()
                
