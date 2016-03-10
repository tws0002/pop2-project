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
# @file xgRendermanRendererTab.py
# @brief Contains the UI for RenderAPI Renderer tab
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

import re
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
import xgenm.xgCmds as xgcmds
from xgenm.ui.widgets import *
from xgenm.ui.util.xgUtil import *
from xgenm.ui.tabs.xgRendererTab import *
from xgenm.ui.util.xgProgressBar import setProgressInfo
from xgenm.ui.util.xgComboBox import _ComboBoxUI
import os
import traceback

k_RenderAPIRenderer = "Renderman"
k_RenderAPIRendererObj = k_RenderAPIRenderer + "Renderer"

class RendermanRendererTabUI(RendererTabUI):
    def __init__(self):
        RendererTabUI.__init__(self,k_RenderAPIRenderer)
        
        # Widgets
        self.checkFixedSize = 66
        self.checkStartSpacing = 112
        self.baseTopUI()
        self.rendererUI()
        self.primParamsUI()
        self.surfParamsUI()
        self.customParamsUI()


        try:
            xg.invokeCallbacks( "RenderAPIRendererTabUIInit", [str(id(self))] )
        except Exception:
            print traceback.print_exc()
        
    def primParamsUI(self):
        expand = ExpandUI(maya.stringTable[ 'y_xgRendermanRendererTab.kPrimitiveShaderParameters'  ])
        self.layout().addWidget( expand )

        self.prim1 = CheckBoxUI("",
                                ["length_XP","width_XP","T_XP","stray_XP"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions1Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kLength'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kWidth'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kT'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kStray'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.prim1)
        self.prim2 = CheckBoxUI("",
                                ["id_XP","descid_XP","ri_XP","rf_XP"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions2Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kId'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDescid'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kRi'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kRf'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.prim2)

    def surfParamsUI(self):
        expand = ExpandUI(maya.stringTable[ 'y_xgRendermanRendererTab.kSurfaceShaderParameters'  ])
        self.layout().addWidget( expand )

        self.surf1 = CheckBoxUI("",
                                ["u_XS","v_XS","faceid_XS","geomid_XS"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions3Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kU'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kV'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kFaceid'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kGeomid'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.surf1)
        self.surf2 = CheckBoxUI("",
                                ["P_XS","Pref_XS","Pg_XS","Prefg_XS"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions4Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kP'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kPref'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kPg'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kPrefg'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.surf2)
        self.surf3 = CheckBoxUI("",
                                ["N_XS","Nref_XS","Ng_XS","Nrefg_XS"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions5Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kN'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kNref'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kNg'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kNrefg'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.surf3)
        self.surf4 = CheckBoxUI("",
                                ["dPdu_XS","dPduref_XS",
                                 "dPdug_XS","dPdurefg_XS"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions6Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kDPdu'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDPduref'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDPdug'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDPdurefg'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.surf4)
        self.surf5 = CheckBoxUI("",
                                ["dPdv_XS","dPdvref_XS",
                                 "dPdvg_XS","dPdvrefg_XS"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions7Ann'  ],
                                k_RenderAPIRendererObj,self.checkFixedSize, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kDPdv'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDPdvref'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDPdvg'  ],
                                 maya.stringTable[ 'y_xgRendermanRendererTab.kDPdvrefg'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.surf5)
        self.surf6 = CheckBoxUI("",
                                ["geomName_XS"],
                                maya.stringTable[ 'y_xgRendermanRendererTab.kOptions8Ann'  ],
                                k_RenderAPIRendererObj,0, 0,
                                [maya.stringTable[ 'y_xgRendermanRendererTab.kGeomName'  ]],
                                 self.checkStartSpacing )
        expand.addWidget(self.surf6)

    def customParamsUI(self):
        expand = ExpandUI(maya.stringTable[ 'y_xgRendermanRendererTab.kCustomShaderParameters'  ])
        self.layout().addWidget( expand )

        # Empty layout for custom params
        box = QtGui.QWidget()
        self.customLayout = QtGui.QVBoxLayout()
        self.customLayout.setAlignment(QtCore.Qt.AlignTop)
        self.customLayout.setSpacing(0)
        self.customLayout.setContentsMargins(0,0,0,0)
        box.setLayout(self.customLayout)
        expand.addWidget(box)
        expand.addSpacing(5)
        # UI for adding/deleting attributes
        label = QtGui.QLabel(maya.stringTable[ 'y_xgRendermanRendererTab.kName'  ])
        label.setFixedWidth(50)
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        label.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kNameParameterAnn'  ])
        self.cattrName = QtGui.QLineEdit()
        self.cattrName.setFixedWidth(150)
        self.cattrName.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kNameCustomParamAnn'  ])
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_]*(\[[0-9]+\])?")
        self.cattrName.setValidator(QtGui.QRegExpValidator(rx,self))
        self.cattrType = _ComboBoxUI()
        self.cattrType.addItem('float')# Please keep this string unlocalized
        self.cattrType.addItem('color')# Please keep this string unlocalized
        self.cattrType.addItem('vector')# Please keep this string unlocalized
        self.cattrType.addItem('point')# Please keep this string unlocalized
        self.cattrType.addItem('normal')# Please keep this string unlocalized
        self.cattrType.setFixedWidth(70)
        self.cattrType.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kTypeAnn'  ])
        self.cattrAddButton = QtGui.QToolButton()
        self.cattrAddButton.setText("+")
        self.cattrAddButton.setFixedSize(20,25)
        self.cattrAddButton.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kAddParamAnn'  ])
        self.connect(self.cattrAddButton, 
                     QtCore.SIGNAL("clicked()"), 
                     self.addCustomAttr)
        self.cattrRemButton = QtGui.QToolButton()
        self.cattrRemButton.setText("-")
        self.cattrRemButton.setFixedSize(20,25)
        self.cattrRemButton.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kRemoveParamAnn'  ])
        self.connect(self.cattrRemButton, 
                     QtCore.SIGNAL("clicked()"), 
                     self.remCustomAttr)
        # Put it all on one row
        row = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignCenter)
        layout.addWidget(label)
        layout.addWidget(self.cattrName)
        layout.addSpacing(10)
        layout.addWidget(self.cattrType)
        layout.addSpacing(15)
        layout.addWidget(self.cattrAddButton)
        layout.addWidget(self.cattrRemButton)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        row.setLayout(layout)
        expand.addWidget(row)
        expand.addSpacing(10)

    def refreshCustomParams(self):
        while True:
            item = self.customLayout.takeAt(0)
            if not item:
                break
            else:
                destroyWidget(item.widget())
        de = xgg.DescriptionEditor
        params = xg.customAttrs(de.currentPalette(),
                                de.currentDescription(),
                                k_RenderAPIRendererObj)
        for param in params:
            # Hide parameters that starts with an underscore
            if not param.startswith("custom__"):
                isColor = True if param.find("custom_color") != -1 else False
                item = ExpressionUI(param,
                                    maya.stringTable[ 'y_xgRendermanRendererTab.kShaderAttrAnn'  ] % param,
                                    k_RenderAPIRendererObj,isColor=isColor)
                item.refresh()
                self.customLayout.addWidget(item)

    def addCustomAttr(self):
        if self.cattrName.text()=="":
            return
        attr = "custom_"+str(self.cattrType.currentText())+"_"+\
               str(self.cattrName.text()) 
        de = xgg.DescriptionEditor
        xg.addCustomAttr(attr,
                         de.currentPalette(),
                         de.currentDescription(),
                         k_RenderAPIRendererObj)
        self.cattrName.setText("")
        self.refreshCustomParams()
        
    def remCustomAttr(self):
        if self.cattrName.text()=="":
            return
        attr = "custom_"+str(self.cattrType.currentText())+"_"+\
               str(self.cattrName.text()) 
        de = xgg.DescriptionEditor
        xg.remCustomAttr(attr,
                         de.currentPalette(),
                         de.currentDescription(),
                         k_RenderAPIRendererObj)
        self.cattrName.setText("")
        self.refreshCustomParams()
        
    def rendererUI(self):
        # Horizontal layout
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgRendermanRendererTab.kRenderer'  ])
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        label.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kRendererAnn'  ])
        hbox.addWidget(label)
        self.renderer = _ComboBoxUI()
        self.renderer.addItem(maya.stringTable[ 'y_xgRendermanRendererTab.kNone'  ])
        self.renderer.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kRendererAnn2'  ])
        self.connect(self.renderer, QtCore.SIGNAL("activated(int)"),
                     lambda x: self.setRenderer(int(x)))
        hbox.addWidget(self.renderer)
        
        filler = QtGui.QWidget()
        hbox.addWidget(filler)
        row.setLayout(hbox)
        self.layout().addWidget(row)

        self.primBound = FloatUI("primitiveBound",
                  maya.stringTable[ 'y_xgRendermanRendererTab.kPrimitiveBoundAnn'  ],
                  k_RenderAPIRendererObj,0.0,1000000,0.0,10,maya.stringTable[ 'y_xgRendermanRendererTab.kPrimitiveBound'  ])
        self.layout().addWidget(self.primBound)
        if ( xgg.Maya ):
            self.pbButton = QtGui.QPushButton(maya.stringTable[ 'y_xgRendermanRendererTab.kAutoSet'  ])
            self.pbButton.setFixedWidth(80)
            self.pbButton.setAutoRepeat(False)
            self.pbButton.setToolTip(maya.stringTable[ 'y_xgRendermanRendererTab.kCalculateAnn'  ])
            self.connect(self.pbButton, QtCore.SIGNAL("clicked()"),
                         self.autoSetValues)
            hbox = self.primBound.layout()
            hbox.addWidget(self.pbButton)
            self.inCamBox = CheckBoxUI(maya.stringTable[ 'y_xgRendermanRendererTab.kInCameraOnly'  ],"inCameraOnly",
            						   maya.stringTable[ 'y_xgRendermanRendererTab.kGenerateOnVisiblePatchesOnly'  ],
            		                   k_RenderAPIRendererObj)
            self.layout().addWidget(self.inCamBox)
            self.connect(self.inCamBox.boxValue[0], QtCore.SIGNAL("clicked(bool)"),
                                lambda x: self.camOnlyUpdate())

            self.margin = FloatUI("inCameraMargin",
            					  maya.stringTable[ 'y_xgRendermanRendererTab.kFrustumAngleAnn'  ],
            					  k_RenderAPIRendererObj,0.0,90.0,-1000,1000,maya.stringTable[ 'y_xgRendermanRendererTab.kInCameraMargin'  ])
            self.layout().addWidget(self.margin)
       
    def autoSetValues(self):
        # The prim bounds calculation can only be done inside of maya
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        setProgressInfo(maya.stringTable[ 'y_xgRendermanRendererTab.kComputingPrimitiveBound'  ])
        value = xgcmds.autoSetPrimitiveBound(pal, desc)
        if value is None:
            return
        self.primBound.setValue(value)

    def setRenderer(self,method):
        de = xgg.DescriptionEditor
        
        # Don't put the translated version of None in the attributes
        # The other entries are renderer names and shouldn't be translated
        value = "None"
        if method!=0:
            value = str( self.renderer.itemText(method) )

        xg.setAttr( "renderer", value, de.currentPalette(), de.currentDescription(), k_RenderAPIRendererObj )
        try:
            xg.invokeCallbacks( "RenderAPIRendererTabUIRefresh", [str(id(self))] )
        except Exception:
            print traceback.print_exc()

    # Add a renderer entry to the combo box.
    def addRenderer(self,rendererName):
        for c in range(self.renderer.count()):
            if self.renderer.itemText(c)==rendererName:
                return False

        self.renderer.addItem( rendererName )
        i = self.renderer.count()-1

        return True

    def camOnlyUpdate(self):        
        self.margin.setEnabled(self.inCamBox.value())

    def refresh(self):
        RendererTabUI.refresh(self)
        de = xgg.DescriptionEditor

        # Update renderer string
        value = xg.getAttr('renderer',de.currentPalette(),
                           de.currentDescription(),k_RenderAPIRendererObj)
        methodId = 0
        for c in range(1,self.renderer.count()):
            if self.renderer.itemText(c)==value :
                methodId=c
                break
        self.renderer.setCurrentIndex(methodId)

        self.primBound.refresh()
        if ( xgg.Maya ):
            self.inCamBox.refresh()
            self.margin.refresh()
            self.camOnlyUpdate()
        self.prim1.refresh()
        self.prim2.refresh()
        self.surf1.refresh()
        self.surf2.refresh()
        self.surf3.refresh()
        self.surf4.refresh()
        self.surf5.refresh()
        self.surf6.refresh()
        self.refreshCustomParams()
        
        try:
            xg.invokeCallbacks( "RenderAPIRendererTabUIRefresh", [str(id(self))] )
        except Exception:
            print traceback.print_exc()

    def declareCustomAttr( self, attrName, defaultVal ):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        if not xg.attrExists( "custom__"+attrName, pal, desc,k_RenderAPIRendererObj):
            xg.addCustomAttr( "custom__"+attrName, pal, desc,k_RenderAPIRendererObj)
            xg.setAttr( "custom__"+attrName, defaultVal, pal, desc, k_RenderAPIRendererObj)

    def setCustomAttr( self, attrName, val ):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        xg.setAttr( "custom__"+attrName, val, pal, desc, k_RenderAPIRendererObj)

    def getCustomAttr( self, attrName ):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        return xg.getAttr( "custom__"+attrName, pal, desc, k_RenderAPIRendererObj)

