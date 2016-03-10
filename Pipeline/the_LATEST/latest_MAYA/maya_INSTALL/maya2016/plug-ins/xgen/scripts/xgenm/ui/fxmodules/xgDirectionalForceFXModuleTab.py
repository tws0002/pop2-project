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
# @file xgDirectionnalForceFXModuleTab.py
# @brief Contains the Directionnal Force FX Module UI.
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *


class DirectionalForceFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kDirectionalForceModifier'  ])
        # Widgets
        self.baseTopUI()

        self.center = ExpressionUI("center",
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kCenterAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kCenter'  ])
        self.layout().addWidget(self.center)
                        
        self.xVec = ExpressionUI("xVec",
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kXVecAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kXVec'  ])
        self.layout().addWidget(self.xVec)

        self.yVec = ExpressionUI("yVec",
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kYVecAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kYVec'  ])
        self.layout().addWidget(self.yVec)

        self.zVec = ExpressionUI("zVec",
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kZVecAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kZVec'  ])
        self.layout().addWidget(self.zVec)

        self.magnitude = ExpressionUI("magnitude",
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kMagnitudeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kMagnitude'  ])
        self.layout().addWidget(self.magnitude)

        self.range = ExpressionUI("range",
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kRangeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgDirectionalForceFXModuleTab.kRange'  ])
        self.layout().addWidget(self.range)

    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.center.refresh()
        self.xVec.refresh()
        self.yVec.refresh()
        self.zVec.refresh()
        self.magnitude.refresh()
        self.range.refresh()
