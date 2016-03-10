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
# @file xgCoilFXModuleTab.py
# @brief Contains the Coil FX Module UI.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Arthur Shek
# @author Thomas V Thompson II
#
# @version Created 06/26/09
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *


class CoilFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgCoilFXModuleTab.kCoilModifier'  ])
        # Widgets
        self.baseTopUI()
        
        self.count = ExpressionUI("count",
             maya.stringTable[ 'y_xgCoilFXModuleTab.kCountAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgCoilFXModuleTab.kCount'  ])
        self.layout().addWidget(self.count)

        self.countScale = RampUI("countScale",
                           maya.stringTable[ 'y_xgCoilFXModuleTab.kCountScakeAnn'  ],
                           self.name,
                           maya.stringTable[ 'y_xgCoilFXModuleTab.kCountScale'  ])
        self.layout().addWidget(self.countScale)
        
        self.radius = ExpressionUI("radius",
             maya.stringTable[ 'y_xgCoilFXModuleTab.kRadiusAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgCoilFXModuleTab.kRadius'  ])
        self.layout().addWidget(self.radius)

        self.radiusScale = RampUI("radiusScale",
                           maya.stringTable[ 'y_xgCoilFXModuleTab.kRadiusScaleAnn'  ],
                           self.name,
                           maya.stringTable[ 'y_xgCoilFXModuleTab.kRadiusScale'  ])
        self.layout().addWidget(self.radiusScale)
        
        # Fix for the expanding ramp ui
        filler = QtGui.QWidget()
        self.layout().addWidget(filler)
        self.layout().setStretchFactor(filler,100)
        
        
    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.count.refresh()
        self.countScale.refresh()
        self.radius.refresh()
        self.radiusScale.refresh()
