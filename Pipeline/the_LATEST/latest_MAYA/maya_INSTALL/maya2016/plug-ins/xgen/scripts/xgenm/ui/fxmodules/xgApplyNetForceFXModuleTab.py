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
# @file xgApplyNetForceFXModuleTab.py
# @brief Contains the Apply Net Force FX Module UI.
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *


class ApplyNetForceFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgApplyNetForceFXModuleTab.kApplyNetForceModifier'  ])
        # Widgets
        self.baseTopUI()
        
        self.stiffness = ExpressionUI("stiffness",
             maya.stringTable[ 'y_xgApplyNetForceFXModuleTab.kStiffnessAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgApplyNetForceFXModuleTab.kStiffness'  ])
        self.layout().addWidget(self.stiffness)
        
        self.stiffnessScale = RampUI("stiffnessScale",
                           maya.stringTable[ 'y_xgApplyNetForceFXModuleTab.kStiffnessScaleAnn'  ],
                           self.name,
                           maya.stringTable[ 'y_xgApplyNetForceFXModuleTab.kStiffnessScale'  ])
        self.layout().addWidget(self.stiffnessScale)

        # Fix for the expanding ramp ui
        filler = QtGui.QWidget()
        self.layout().addWidget(filler)
        self.layout().setStretchFactor(filler,100)

                       
    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.stiffness.refresh()
        self.stiffnessScale.refresh()
