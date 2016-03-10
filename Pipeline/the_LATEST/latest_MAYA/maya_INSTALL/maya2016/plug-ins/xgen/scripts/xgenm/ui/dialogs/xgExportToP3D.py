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
# @file xgExportToP3D.py
# @brief Contains the Export to Paint3d UI.
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
from xgenm.ui.widgets import *
from xgenm.ui.util.xgUtil import *


class ExportToPaint3DUI(QtGui.QDialog):
    """Function to export guides/curves to XPD for Paint3d using a dialog.

    This provides a simple dialog to accept the directory name and a check
    box for optionally including curves. The user can use a browser to
    search for the file.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgExportToP3D.kXgenExportXpd'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        layout = QtGui.QVBoxLayout()
        self.dirName = BrowseUI(maya.stringTable[ 'y_xgExportToP3D.kXpdDirectory'  ],
                                 maya.stringTable[ 'y_xgExportToP3D.kXpdDirectoryAnn'  ])
        self.dirName.setValue("p3dGeometry/XPD/")
        layout.addWidget(self.dirName)
        self.curves = CheckBoxUI(maya.stringTable[ 'y_xgExportToP3D.kIncludeCurve'  ],
                                 maya.stringTable[ 'y_xgExportToP3D.kIncludeCurveAnn'  ])
        layout.addWidget(self.curves)
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.exportButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportToP3D.kExportFile'  ])
        self.exportButton.setFixedWidth(100)
        self.exportButton.setAutoRepeat(False)
        self.exportButton.setToolTip(maya.stringTable[ 'y_xgExportToP3D.kExportFileAnn'  ])
        self.connect(self.exportButton, QtCore.SIGNAL("clicked()"),
                     self.accept)
        hbox.addWidget(self.exportButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportToP3D.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgExportToP3D.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)

    def getDirName(self):
        return str(self.dirName.value())
    
    def getCurves(self):
        return self.curves.value()


def exportToP3D():
    """Function to export guides/curves to XPD for Paint3d using a dialog.

    This provides a simple dialog to accept the directory name and a check
    box for optionally including curves. The user can use a browser to
    search for the file.
    """
    dialog = ExportToPaint3DUI()
    result = dialog.exec_()
    if result == QtGui.QDialog.Accepted:
        xpdDir = dialog.getDirName()
        curves = dialog.getCurves()
        if len(xpdDir):
            if xgg.Maya:
                cmd = 'xgmExportToP3D -dir "'+xpdDir+'"'
                if curves:
                    cmd += ' -curves'
                mel.eval(cmd)
            else:
                goPort = QtGui.QMessageBox()
                goPort.setText(maya.stringTable[ 'y_xgExportToP3D.kExportToPaint3dOnlyAvailableInMaya'  ])
                goPort.exec_()
                
