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
# @file xgPolylineForceFXModuleTab.py
# @brief Contains the Polyline Force FX Module UI.
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *


class PolylineForceFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kPolylineForceModifier'  ])
        # Widgets
        self.baseTopUI()

        self.cvs1 = ExpressionUI("cvs1",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvsOneAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvs1'  ])
        self.layout().addWidget(self.cvs1)
                        
        self.cvs2 = ExpressionUI("cvs2",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvsTwoAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvs2'  ])
        self.layout().addWidget(self.cvs2)

        self.cvs3 = ExpressionUI("cvs3",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvsThreeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvs3'  ])
        self.layout().addWidget(self.cvs3)

        self.cvs4 = ExpressionUI("cvs4",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvsFourAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kCvs4'  ])
        self.layout().addWidget(self.cvs4)

        self.radii = ExpressionUI("radii",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kRadiiAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kRadii'  ])
        self.layout().addWidget(self.radii)

        self.magnitude = ExpressionUI("magnitude",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kMagnitudeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kMagnitude'  ])
        self.layout().addWidget(self.magnitude)

        self.falloff = ExpressionUI("falloff",
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kFalloffAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgPolylineForceFXModuleTab.kFalloff'  ])
        self.layout().addWidget(self.falloff)

    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.cvs1.refresh()
        self.cvs2.refresh()
        self.cvs3.refresh()
        self.cvs4.refresh()
        self.radii.refresh()
        self.magnitude.refresh()
        self.falloff.refresh()
