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
# @file xgWindFXModuleTab.py
# @brief Contains the Wind FX Module UI.
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


class WindFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgWindFXModuleTab.kWindModifier'  ])
        # Widgets
        self.baseTopUI()
        
        self.stiffness = ExpressionUI("stiffness",
             maya.stringTable[ 'y_xgWindFXModuleTab.kStiffnessAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kStiffness'  ])
        self.layout().addWidget(self.stiffness)
        
        self.direction = ExpressionUI("direction",
             maya.stringTable[ 'y_xgWindFXModuleTab.kDirectionAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kDirection'  ])
        self.layout().addWidget(self.direction)
        
        self.constStrength = ExpressionUI("constStrength",
             maya.stringTable[ 'y_xgWindFXModuleTab.kConstStrengthAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kConstStrength'  ])
        self.layout().addWidget(self.constStrength)
        
        self.gustStrength = ExpressionUI("gustStrength",
             maya.stringTable[ 'y_xgWindFXModuleTab.kGustStrengthAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kGustStrength'  ])
        self.layout().addWidget(self.gustStrength)
        
        self.shearStrength = ExpressionUI("shearStrength",
             maya.stringTable[ 'y_xgWindFXModuleTab.kShearStrengthAnn' ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kShearStrength'  ])
        self.layout().addWidget(self.shearStrength)
        
        self.shearFreq = ExpressionUI("shearFreq",
             maya.stringTable[ 'y_xgWindFXModuleTab.kShearFreqAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kShearFreq'  ])
        self.layout().addWidget(self.shearFreq)
        
        self.seed = ExpressionUI("seed",
             maya.stringTable[ 'y_xgWindFXModuleTab.kSeedAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kSeed'  ])
        self.layout().addWidget(self.seed)
        
        self.prefNoise = CheckBoxUI(maya.stringTable[ 'y_xgWindFXModuleTab.kPrefNoise'  ], "prefNoise",
             maya.stringTable[ 'y_xgWindFXModuleTab.kPrefNoiseAnn'  ],
             self.name)
        self.layout().addWidget(self.prefNoise)

        self.lowS = ExpressionUI("lowS",
             maya.stringTable[ 'y_xgWindFXModuleTab.kLowSAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kLowS'  ])
        self.layout().addWidget(self.lowS)
        
        self.loBias = ExpressionUI("loBias",
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoBiasAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoBias'  ])
        self.layout().addWidget(self.loBias)
        
        self.hiS = ExpressionUI("hiS",
             maya.stringTable[ 'y_xgWindFXModuleTab.kHisAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kHiS'  ])
        self.layout().addWidget(self.hiS)
        
        self.hiBias = ExpressionUI("hiBias",
             maya.stringTable[ 'y_xgWindFXModuleTab.kHiBiasAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kHiBias'  ])
        self.layout().addWidget(self.hiBias)
        
        self.hiFreq = ExpressionUI("hiFreq",
             maya.stringTable[ 'y_xgWindFXModuleTab.kHiFreqAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kHiFreq'  ])
        self.layout().addWidget(self.hiFreq)
        
        self.rigidBody = CheckBoxUI(maya.stringTable[ 'y_xgWindFXModuleTab.kRigidBody'  ], "rigidBody",
             maya.stringTable[ 'y_xgWindFXModuleTab.kRigidBodyAnn'  ],
             self.name)
        self.layout().addWidget(self.rigidBody)

        self.clumpType = RadioUI("clumpType",
             [maya.stringTable[ 'y_xgWindFXModuleTab.kNone'  ],
              maya.stringTable[ 'y_xgWindFXModuleTab.kClump'  ]],
             maya.stringTable[ 'y_xgWindFXModuleTab.kClumpTypeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgWindFXModuleTab.kClumpType'  ])
        self.layout().addWidget(self.clumpType)

        self.loopableWind = ExpandUI(maya.stringTable[ 'y_xgWindFXModuleTab.kLoopableWind'  ], False)
        self.layout().addWidget(self.loopableWind)

        self.loopableNoise = CheckBoxUI(maya.stringTable[ 'y_xgWindFXModuleTab.kLoopable'  ], "loopableNoise",
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopableAnn'  ],
             self.name)
        self.connect(self.loopableNoise.boxValue[0],
                     QtCore.SIGNAL("clicked(bool)"),
                     lambda x: self.loopableUpdate())
        self.loopableWind.addWidget(self.loopableNoise)

        self.loopStartFrame = IntegerUI("loopStartFrame",
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopStartFrameAnn'  ],
             self.name,-1e7,1e7,
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopStartFrame'  ])
        self.loopableWind.addWidget(self.loopStartFrame)

        self.loopEndFrame = IntegerUI("loopEndFrame",
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopEndFrameAnn'  ],
             self.name,-1e7,1e7,
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopEndFrame'  ])
        self.loopableWind.addWidget(self.loopEndFrame)

        self.loopNoiseSpan = IntegerUI("loopNoiseSpan",
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopNoiseSpanAnn'  ],
             self.name,-1e7,1e7,
             maya.stringTable[ 'y_xgWindFXModuleTab.kLoopNoiseSpan'  ])
        self.loopableWind.addWidget(self.loopNoiseSpan)
        self.loopableUpdate()

        # Fix for the expanding ramp ui
        filler = QtGui.QWidget()
        self.layout().addWidget(filler)
        self.layout().setStretchFactor(filler,100)

    def loopableUpdate(self):
        value = self.loopableNoise.value()
        if value:
            self.loopStartFrame.setEnabled(True)
            self.loopEndFrame.setEnabled(True)
            self.loopNoiseSpan.setEnabled(True)
        else:
            self.loopStartFrame.setEnabled(False)
            self.loopEndFrame.setEnabled(False)
            self.loopNoiseSpan.setEnabled(False)
            
        
    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.stiffness.refresh()
        self.direction.refresh()
        self.constStrength.refresh()
        self.gustStrength.refresh()
        self.shearStrength.refresh()
        self.shearFreq.refresh()
        self.seed.refresh()
        self.prefNoise.refresh()
        self.lowS.refresh()
        self.loBias.refresh()
        self.hiS.refresh()
        self.hiBias.refresh()
        self.hiFreq.refresh()
        self.rigidBody.refresh()
        self.clumpType.refresh()
        self.loopableNoise.refresh()
        self.loopStartFrame.refresh()
        self.loopEndFrame.refresh()
        self.loopNoiseSpan.refresh()
        self.loopableUpdate()


xg.registerCallback("PostFXModuleUserAdd",
                    "xgenm.ui.fxmodules.xgWindFXModuleTab.PostFXModuleUserAdd")
def PostFXModuleUserAdd(argsStr):
    args = argsStr.split(",")
    if args[3] != 'WindFXModule':
        return
    # The loop noise type is periodic by default for existing scenes.
    # We switch to looping noise if the user adds a new Wind modifier.
    # This is for backward compatibility to keep the old behavior.
    xg.setAttr("loopNoiseType", "1", args[1], args[2], args[0])
