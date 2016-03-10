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
# @file xgCardPrimitiveTab.py
# @brief Contains the UI for Card Primitive tab
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
# @version Created 06/04/09
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.cmds as cmds
from xgenm.ui.widgets import *
from xgenm.ui.tabs.xgPrimitiveTab import *


class CardPrimitiveTabUI(PrimitiveTabUI):
    def __init__(self):
        PrimitiveTabUI.__init__(self,'Card',maya.stringTable[ 'y_xgCardPrimitiveTab.kCard'  ])
        # Widgets
        self.baseTopUI()
        self.lengthExpr = ExpressionUI("length","","CardPrimitive",maya.stringTable[ 'y_xgCardPrimitiveTab.kLength'  ])
        self.layout().addWidget(self.lengthExpr)
        self.widthExpr = ExpressionUI("width","","CardPrimitive",maya.stringTable[ 'y_xgCardPrimitiveTab.kWidth'  ])
        self.layout().addWidget(self.widthExpr)
        self.offUExpr = ExpressionUI("offU",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kTiltUAnn'  ],
             "CardPrimitive",maya.stringTable[ 'y_xgCardPrimitiveTab.kTiltU'  ])
        self.layout().addWidget(self.offUExpr)
        self.offVExpr = ExpressionUI("offV",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kTiltVAnn'  ],
             "CardPrimitive", maya.stringTable[ 'y_xgCardPrimitiveTab.kTiltV'  ])
        self.layout().addWidget(self.offVExpr)
        self.bendUExpr = ExpressionUI("bendU",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kBendUAnn'  ],
             "CardPrimitive", maya.stringTable[ 'y_xgCardPrimitiveTab.kBendU'  ])
        self.layout().addWidget(self.bendUExpr)
        self.bendVExpr = ExpressionUI("bendV",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kBendVAnn'  ],
             "CardPrimitive", maya.stringTable[ 'y_xgCardPrimitiveTab.kBendV'  ])
        self.layout().addWidget(self.bendVExpr)
        self.bendParamUExpr = ExpressionUI("bendParamU",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kBendParamUAnn'  ],
             "CardPrimitive",maya.stringTable[ 'y_xgCardPrimitiveTab.kBendParamU'  ])
        self.layout().addWidget(self.bendParamUExpr)
        self.bendParamVExpr = ExpressionUI("bendParamV",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kBendParamVAnn'  ],
             "CardPrimitive",maya.stringTable[ 'y_xgCardPrimitiveTab.kBendParamV'  ])
        self.layout().addWidget(self.bendParamVExpr)
        self.twistExpr = ExpressionUI("twist",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kTwistAnn'  ],
             "CardPrimitive", maya.stringTable[ 'y_xgCardPrimitiveTab.kTwist'  ])
        self.layout().addWidget(self.twistExpr)
        self.offNExpr = ExpressionUI("offN",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kTiltNAnn'  ],
             "CardPrimitive", maya.stringTable[ 'y_xgCardPrimitiveTab.kTiltN'  ])
        self.layout().addWidget(self.offNExpr)
        self.aboutNExpr = ExpressionUI("aboutN",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kAroundNAnn'  ],
             "CardPrimitive", maya.stringTable[ 'y_xgCardPrimitiveTab.kAroundN'  ])
        self.layout().addWidget(self.aboutNExpr)
        self.faceCameraBox = CheckBoxUI(maya.stringTable[ 'y_xgCardPrimitiveTab.kFaceCamera'  ],"faceCamera",
             maya.stringTable[ 'y_xgCardPrimitiveTab.kFaceCameraAnn'  ],
             "CardPrimitive")
        self.faceCameraBox.boxValue[0].connect(self.faceCameraBox.boxValue[0],
                                 QtCore.SIGNAL("clicked(bool)"),
                                 self.updateGuideDisplay)
        self.layout().addWidget(self.faceCameraBox)
        self.baseBottomUI()

    def setMethod(self,method):
        PrimitiveTabUI.setMethod(self,method)
        if method == 0:
            self.lengthExpr.setToolTip(maya.stringTable[ 'y_xgCardPrimitiveTab.kLengthAnn'  ])
            self.widthExpr.setToolTip(maya.stringTable[ 'y_xgCardPrimitiveTab.kWidthAnn'  ])
            self.offUExpr.setVisible(True)
            self.offVExpr.setVisible(True)
            self.bendUExpr.setVisible(True)
            self.bendVExpr.setVisible(True)
            self.bendParamUExpr.setVisible(True)
            self.bendParamVExpr.setVisible(True)
        else:
            self.lengthExpr.setToolTip(maya.stringTable[ 'y_xgCardPrimitiveTab.kLengthScaleAnn'  ])
            self.widthExpr.setToolTip(maya.stringTable[ 'y_xgCardPrimitiveTab.kWidthScaleAnn'  ])
            self.offUExpr.setVisible(False)
            self.offVExpr.setVisible(False)
            self.bendUExpr.setVisible(False)
            self.bendVExpr.setVisible(False)
            self.bendParamUExpr.setVisible(False)
            self.bendParamVExpr.setVisible(False)

    def updateGuideDisplay(self,val):
        if not xgg.Maya:
            return
        de = xgg.DescriptionEditor
        guides = xg.descriptionGuides(de.currentDescription())
        for guide in guides:
            cmds.setAttr(guide+".faceCamera",val)
        
    def refresh(self):
        PrimitiveTabUI.refresh(self)
        self.lengthExpr.refresh()
        self.widthExpr.refresh()
        self.offUExpr.refresh()
        self.offVExpr.refresh()
        self.bendUExpr.refresh()
        self.bendVExpr.refresh()
        self.bendParamUExpr.refresh()
        self.bendParamVExpr.refresh()
        self.twistExpr.refresh()
        self.offNExpr.refresh()
        self.aboutNExpr.refresh()
        self.faceCameraBox.refresh()
