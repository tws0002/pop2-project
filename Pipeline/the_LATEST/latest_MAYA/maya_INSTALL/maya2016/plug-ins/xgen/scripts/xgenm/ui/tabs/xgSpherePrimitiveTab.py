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
# @file xgSpherePrimitiveTab.py
# @brief Contains the UI for Sphere Primitive tab
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
from xgenm.ui.widgets import *
from xgenm.ui.tabs.xgPrimitiveTab import *


class SpherePrimitiveTabUI(PrimitiveTabUI):
    def __init__(self):
        PrimitiveTabUI.__init__(self,'Sphere',maya.stringTable[ 'y_xgSpherePrimitiveTab.kSphere'  ])
        # Widgets
        self.baseTopUI()
        self.lengthExpr = ExpressionUI("length","","SpherePrimitive",maya.stringTable[ 'y_xgSpherePrimitiveTab.kLength'  ])
        self.layout().addWidget(self.lengthExpr)
        self.widthExpr = ExpressionUI("width","","SpherePrimitive",maya.stringTable[ 'y_xgSpherePrimitiveTab.kWidth'  ])
        self.layout().addWidget(self.widthExpr)
        self.depthExpr = ExpressionUI("depth","","SpherePrimitive",maya.stringTable[ 'y_xgSpherePrimitiveTab.kDepth'  ])
        self.layout().addWidget(self.depthExpr)
        self.offUExpr = ExpressionUI("offU",
             maya.stringTable[ 'y_xgSpherePrimitiveTab.kTiltUAnn'  ],
             "SpherePrimitive",maya.stringTable[ 'y_xgSpherePrimitiveTab.kTiltU'  ])
        self.layout().addWidget(self.offUExpr)
        self.offVExpr = ExpressionUI("offV",
             maya.stringTable[ 'y_xgSpherePrimitiveTab.kTiltVAnn'  ],
             "SpherePrimitive", maya.stringTable[ 'y_xgSpherePrimitiveTab.kTiltV'  ])
        self.layout().addWidget(self.offVExpr)
        self.twistExpr = ExpressionUI("twist",
             maya.stringTable[ 'y_xgSpherePrimitiveTab.kTwistAnn'  ],
             "SpherePrimitive", maya.stringTable[ 'y_xgSpherePrimitiveTab.kTwist'  ])
        self.layout().addWidget(self.twistExpr)
        self.offNExpr = ExpressionUI("offN",
             maya.stringTable[ 'y_xgSpherePrimitiveTab.kTiltNAnn'  ],
             "SpherePrimitive", maya.stringTable[ 'y_xgSpherePrimitiveTab.kTiltN'  ])
        self.layout().addWidget(self.offNExpr)
        self.aboutNExpr = ExpressionUI("aboutN",
             maya.stringTable[ 'y_xgSpherePrimitiveTab.kAboutNAnn'  ],
             "SpherePrimitive", maya.stringTable[ 'y_xgSpherePrimitiveTab.kAroundN'  ])
        self.layout().addWidget(self.aboutNExpr)
        self.baseBottomUI()

    def setMethod(self,method):
        PrimitiveTabUI.setMethod(self,method)
        if method == 0:
            self.lengthExpr.setToolTip(maya.stringTable[ 'y_xgSpherePrimitiveTab.kLengthAnn'  ])
            self.widthExpr.setToolTip(maya.stringTable[ 'y_xgSpherePrimitiveTab.kWidthAnn'  ])
            self.depthExpr.setToolTip(maya.stringTable[ 'y_xgSpherePrimitiveTab.kDepthAnn'  ])
            self.offUExpr.setVisible(True)
            self.offVExpr.setVisible(True)
        else:
            self.lengthExpr.setToolTip(maya.stringTable[ 'y_xgSpherePrimitiveTab.kLengthScaleAnn'  ])
            self.widthExpr.setToolTip(maya.stringTable[ 'y_xgSpherePrimitiveTab.kWidthScaleAnn'  ])
            self.depthExpr.setToolTip(maya.stringTable[ 'y_xgSpherePrimitiveTab.kDepthScaleAnn'  ])
            self.offUExpr.setVisible(False)
            self.offVExpr.setVisible(False)

    def refresh(self):
        PrimitiveTabUI.refresh(self)
        self.lengthExpr.refresh()
        self.widthExpr.refresh()
        self.depthExpr.refresh()
        self.offUExpr.refresh()
        self.offVExpr.refresh()
        self.twistExpr.refresh()
        self.offNExpr.refresh()
        self.aboutNExpr.refresh()
