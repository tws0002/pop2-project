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
# @file xgCreateDescription.py
# @brief Contains the Create Description UI.
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
# @version Created 04/08/09
#

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.xgUtil import *


class _ProgressUI(QtGui.QProgressDialog):
    """A dialog for showing progress.

    This simplifies showing progress and handles the redrawing performance
    problem inherant in the QT dialog. This explicitly removes the cancel
    button and expects to be used as a visual update only.
    """
    def __init__(self):
        QtGui.QProgressDialog.__init__(self,
                                       maya.stringTable[ 'y_xgProgressBar.kPleaseWait'  ],
                                       maya.stringTable[ 'y_xgProgressBar.kAbort'  ],0,50)
        self.setWindowModality(QtCore.Qt.ApplicationModal)
        self.setWindowTitle(maya.stringTable[ 'y_xgProgressBar.kXgenProgress'  ])
        self.setMinimumDuration(2000)
        self.setMinimumWidth(450)
        self.setCancelButton(None)
        self.progress = 0

    def setRealMaximum(self,value):
        self.realMaximum = value
        self.progress = 0
        self.setValue(0)
        self.reset()
        self.update()

    def setRealValue(self,value):
        current = int(value*50/self.realMaximum)
        if current > self.progress:
            self.progress = current
            self.setValue(self.progress)
        self.update()

    def setInfo(self,text):
        self.setLabelText(text)


def setProgressMaximum(value):
    """Set the maximum value for the progress dialog."""
    if not xgg.Progress:
        xgg.Progress = _ProgressUI()
    xgg.Progress.setRealMaximum(value)


def setProgressValue(value):
    """Set the value for the progress dialog."""
    if not xgg.Progress:
        xgg.Progress = _ProgressUI()
    xgg.Progress.setRealValue(value)


def setProgressInfo(labelText):
    """Set the value of the label text for the progress dialog."""
    if not xgg.Progress:
        xgg.Progress = _ProgressUI()
    xgg.Progress.setInfo(labelText)

def isProgressVisible():
    """ Returns True if the progress bar dialog visible."""
    if not xgg.Progress:
        return False
    return not xgg.Progress.isHidden()
