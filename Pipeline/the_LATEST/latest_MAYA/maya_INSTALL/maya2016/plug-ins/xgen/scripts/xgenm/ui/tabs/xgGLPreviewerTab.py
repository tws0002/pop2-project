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
# @file xgGLPreviewerTab.py
# @brief Contains the UI for Previewer tab
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
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.tabs.xgPreviewerTab import *


class GLPreviewerTabUI(PreviewerTabUI):
    def __init__(self):
        PreviewerTabUI.__init__(self,'GL')
        # Widgets
        self.baseTopUI()

        self.previewLimit = IntegerUI( "primNumLimit",
                                    maya.stringTable[ 'y_xgGLPreviewerTab.kMaxPrimCountAnn'  ],
                                    "GLRenderer", mainlabel=maya.stringTable[ 'y_xgGLPreviewerTab.kMaxPrimCount'  ])
        self.layout().addWidget(self.previewLimit)

        self.inCamBox = CheckBoxUI(maya.stringTable[ 'y_xgGLPreviewerTab.kInCameraOnly'  ],"inCameraOnly",
             maya.stringTable[ 'y_xgGLPreviewerTab.kInCameraOnlyAnn'  ],
             "GLRenderer")
        self.layout().addWidget(self.inCamBox)
        self.connect(self.inCamBox.boxValue[0], QtCore.SIGNAL("clicked(bool)"),
                                lambda x: self.camOnlyUpdate())

        self.margin = FloatUI("inCameraMargin",
                              maya.stringTable[ 'y_xgGLPreviewerTab.kInCameraMarginAnn'  ],
                              "GLRenderer", 0.0, 90.0,-1000,1000,maya.stringTable[ 'y_xgGLPreviewerTab.kInCameraMargin'  ])
        self.layout().addWidget(self.margin)

        self.draw = CheckBoxUI(maya.stringTable[ 'y_xgGLPreviewerTab.kDraw'  ],["patchNames","faceIds","primIDs"],
                               maya.stringTable[ 'y_xgGLPreviewerTab.kDrawAnn'  ],
                               "GLRenderer",64,0,
                               [maya.stringTable[ 'y_xgGLPreviewerTab.kPatchNames'  ],
                                maya.stringTable[ 'y_xgGLPreviewerTab.kFaceIds'  ],
                                maya.stringTable[ 'y_xgGLPreviewerTab.kPrimIds'  ]])
        self.connect(self.draw.boxValue[2], QtCore.SIGNAL("clicked(bool)"),
                                lambda x: self.primIDsUpdate())


        self.draw.boxValue[0].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kPatchNamesAnn'  ])
        self.draw.boxValue[1].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kFaceIdsAnn'  ])
        self.draw.boxValue[2].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kPrimIdsAnn'  ])
        self.connect(self.draw.boxValue[0],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)
        self.connect(self.draw.boxValue[1],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)
        self.connect(self.draw.boxValue[2],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)
        self.layout().addWidget(self.draw)
        
        self.draw2 = CheckBoxUI("    ",["vertices","poly"],
                               maya.stringTable[ 'y_xgGLPreviewerTab.kDisplayAnn'  ],
                               "GLRenderer", 64,0,
                                [maya.stringTable[ 'y_xgGLPreviewerTab.kVertices'  ],
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kPoly'  ]])
        self.draw2.boxValue[0].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kVerticesAnn'  ])
        self.draw2.boxValue[1].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kPolyAnn'  ])
        self.connect(self.draw2.boxValue[0],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)
        self.connect(self.draw2.boxValue[1],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)
        self.layout().addWidget(self.draw2)
        
        self.draw3 = CheckBoxUI("    ",["culled", "unitCube"],
                               maya.stringTable[ 'y_xgGLPreviewerTab.kDisplayAnn2'  ],
                               "GLRenderer", 64,0,
                                [maya.stringTable[ 'y_xgGLPreviewerTab.kCulled'  ],
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kBoundingBox'  ]])

        self.draw3.boxValue[0].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kCulledAnn'  ])
        self.draw3.boxValue[1].setToolTip(maya.stringTable[ 'y_xgGLPreviewerTab.kUnitCubeAnn'  ])

        self.connect(self.draw3.boxValue[0],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)

        self.connect(self.draw3.boxValue[0],QtCore.SIGNAL("clicked(bool)"),
                     self.generatorRefresh)

        self.connect(self.draw3.boxValue[1],QtCore.SIGNAL("clicked(bool)"),
                     self.mayaRefresh)

        self.layout().addWidget(self.draw3)
        
        self.idloc = FloatUI("primIDsAt",
                             maya.stringTable[ 'y_xgGLPreviewerTab.kPrimIDsAnn'  ],
                             "GLRenderer",0.0,1.0,-1000,1000,maya.stringTable[ 'y_xgGLPreviewerTab.kPrimIdsAt'  ])
        self.connect(self.idloc.floatValue,QtCore.SIGNAL("editingFinished()"),
                     self.mayaRefresh)
        self.layout().addWidget(self.idloc)

        self.color = ExpressionUI("color",
                                  maya.stringTable[ 'y_xgGLPreviewerTab.kColorAnn'  ],
                                  "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kColor'  ],True)
        self.layout().addWidget(self.color)

        self.guideColor = ExpressionUI("guideColor",
                                  maya.stringTable[ 'y_xgGLPreviewerTab.kColorForTheGuides'  ],
                                  "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kGuideColor'  ])
        self.layout().addWidget(self.guideColor)

        self.splineRes = IntegerUI( "splineSegments",
                                    maya.stringTable[ 'y_xgGLPreviewerTab.kSplineSegmentAnn'  ],
                                    "GLRenderer",1,99,maya.stringTable[ 'y_xgGLPreviewerTab.kSplineSegments'  ])
        self.layout().addWidget(self.splineRes)
        
        # Not needed for now, we'll do it properly with viewport 2.0 support.
        #self.customHWUI()
        
    def customHWUI(self):
        self.layout().addSpacing(20)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgGLPreviewerTab.kCustomHardwareShaderParameters'  ])
        label.setIndent(labelWidth()+5)
        label.font().setBold(True)
        self.layout().addWidget(label)
        temp = TextUI("TEXCOORD0",maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn0'  ],
                      "",300,maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord0'  ])
        temp.setValue(maya.stringTable[ 'y_xgGLPreviewerTab.kTex1Value'  ])
        temp.textValue.setReadOnly(True)
        self.layout().addWidget(temp)
        temp = TextUI("TEXCOORD1",maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn1'  ],
                      "",300,maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord1'  ])
        temp.setValue(maya.stringTable[ 'y_xgGLPreviewerTab.kTex2Value'  ])
        temp.textValue.setReadOnly(True)
        self.layout().addWidget(temp)
        temp = TextUI("TEXCOORD2",maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn2'  ],
                      "",300,maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord2'  ])
        temp.setValue(maya.stringTable[ 'y_xgGLPreviewerTab.kTex3Value'  ])
        temp.textValue.setReadOnly(True)
        self.layout().addWidget(temp)
        self.tex3 = ExpressionUI("TEXCOORD3",
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn3'  ],
                                 "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord3'  ])
        self.layout().addWidget(self.tex3)
        self.tex4 = ExpressionUI("TEXCOORD4",
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn4'  ],
                                 "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord4'  ])
        self.layout().addWidget(self.tex4)
        self.tex5 = ExpressionUI("TEXCOORD5",
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn5'  ],
                                 "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord5'  ])
        self.layout().addWidget(self.tex5)
        self.tex6 = ExpressionUI("TEXCOORD6",
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn6'  ],
                                 "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord6'  ])
        self.layout().addWidget(self.tex6)
        self.tex7 = ExpressionUI("TEXCOORD7",
                                 maya.stringTable[ 'y_xgGLPreviewerTab.kTexAnn7'  ],
                                 "GLRenderer",maya.stringTable[ 'y_xgGLPreviewerTab.kTexcoord7'  ])
        self.layout().addWidget(self.tex7)

    def camOnlyUpdate(self):        
        self.margin.setEnabled(self.inCamBox.value())

    def primIDsUpdate(self):        
        self.idloc.setEnabled(self.draw.value(2))        

    def mayaRefresh(self):
        if ( xgg.Maya ):
            mel.eval("refresh -force")

    def generatorRefresh(self):
        xgg.DescriptionEditor.generatorTab.widget().refresh()
        
    def refresh(self):
        PreviewerTabUI.refresh(self)
        self.previewLimit.refresh()
        self.inCamBox.refresh()
        self.margin.refresh()
        self.draw.refresh()
        self.draw2.refresh()
        self.draw3.refresh()
        self.idloc.refresh()
        self.color.refresh()
        self.guideColor.refresh()
        self.splineRes.refresh()
        #self.tex3.refresh()
        #self.tex4.refresh()
        #self.tex5.refresh()
        #self.tex6.refresh()
        #self.tex7.refresh()
        self.camOnlyUpdate()
        self.primIDsUpdate()

        c_prim = xg.getActive(xgg.DescriptionEditor.currentPalette(),xgg.DescriptionEditor.currentDescription(),"Primitive")
        c_method = xgg.DescriptionEditor.getAttr(c_prim,"iMethod")
        self.guideColor.setVisible( c_method=="1" )
        self.splineRes.setVisible( c_prim=="SplinePrimitive" )
