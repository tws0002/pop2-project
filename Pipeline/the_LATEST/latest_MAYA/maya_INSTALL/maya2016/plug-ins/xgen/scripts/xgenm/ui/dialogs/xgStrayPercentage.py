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
# @file xgStrayPercentage.py
# @brief Contains the Stray Percentage UI.
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
# @version Created 06/30/09
#

import string

from PySide import QtGui, QtCore
import xgenm as xg
from xgenm.ui.widgets import *


class StrayPercentageUI(QtGui.QDialog):
    """A dialog to specify the stray percentage of a description.

    This provides an input field for editing the stray percentage expression
    of the current description.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgStrayPercentage.kStrayPercentage'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        layout = QtGui.QVBoxLayout()
        self.helpText = QtGui.QLabel(maya.stringTable[ 'y_xgStrayPercentage.kStrayPercentageHelp'  ])
        self.helpText.setAlignment(QtCore.Qt.AlignCenter)
        layout.addWidget(self.helpText)
        self.stray = ExpressionUI("strayPercentage",
                                  maya.stringTable[ 'y_xgStrayPercentage.kStrayPctgAnn'  ],
                                  "Description")
        self.stray.label.setText("")
        self.stray.refresh()
        layout.addWidget(self.stray)
        self.setLayout(layout)


def strayPercentage():
    """Function to set the stray percentage of a description.

    This provides an input field for editing the stray percentage expression
    of the current description.
    """
    dialog = StrayPercentageUI()
    dialog.exec_()