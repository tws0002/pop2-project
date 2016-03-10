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
# @file xgSphereForceFXModuleTab.py
# @brief Contains the Sphere Force FX Module UI.
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *


class SphereForceFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgSphereForceFXModuleTab.kSphereForceModifier'  ])
        # Widgets
        self.baseTopUI()
        
        self.center = ExpressionUI("center",
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kCenterAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kCenter'  ])
        self.layout().addWidget(self.center)

        self.radius = FloatUI("radius",
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kRadiusAnn'  ],
             self.name,0.0,1000000,0.1,5.0,
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kRadius'  ])
        self.layout().addWidget(self.radius)

        self.magnitude = ExpressionUI("magnitude",
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kMagnitudeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kMagnitude'  ])
        self.layout().addWidget(self.magnitude)

        self.falloff = FloatUI("falloff",
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kFalloffAnn'  ],
             self.name,-1000000.0,1000000.0,0.0,5.0,
             maya.stringTable[ 'y_xgSphereForceFXModuleTab.kFalloff'  ])
        self.layout().addWidget(self.falloff)

                        
    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.center.refresh()
        self.magnitude.refresh()
        self.radius.refresh()
        self.falloff.refresh()
