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
# @file xgAnimWiresFXModuleTab.py
# @brief Contains the AnimWires FX Module UI.
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
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *
from xgenm.ui.util.xgProgressBar import setProgressInfo
from xgenm.ui.dialogs.xgPointsBase import *

class AnimWiresFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kAnimWireModifier'  ])
        # Widgets
        self.baseTopUI()

        self.magnitude = ExpressionUI("magnitude",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMagnitudeAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMagnitude'  ])
        self.layout().addWidget(self.magnitude)

        self.magScale = RampUI("magnitudeScale",
                           maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMagnitudeScaleAnn'  ],
                           self.name,
                           maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMagnitudeScale'  ])
        self.layout().addWidget(self.magScale)        
        
        self.interpolation = ExpressionUI("interpolation",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kInterpolationAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kInterpolation'  ])
        self.layout().addWidget(self.interpolation)
        

        #***********************************#
        group = QtGui.QGroupBox(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMode'  ])
        group.setAlignment(QtCore.Qt.AlignLeft)
        groupFont = group.font()
        groupFont.setBold(True)
        group.setFont(groupFont)        
        layout = QtGui.QVBoxLayout()

        self.liveMode = CheckBoxUI(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kLiveMode'  ], "liveMode",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kLiveModeAnn'  ], 
             self.name)
        layout.addWidget(self.liveMode)
        self.connect(self.liveMode.boxValue[0], QtCore.SIGNAL("clicked(bool)"),
                     lambda x: self.liveModeUpdate())

        self.wiresFile = BrowseUI("wiresFile",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kWiresFileAnn'  ],
             self.name,"*.caf *.abc","in",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kWiresFile'  ])
        layout.addWidget(self.wiresFile)

        self.refWiresFrame = IntegerUI("refWiresFrame",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kRefWiresFrameAnn'  ],
             self.name,-1e7,1e7,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kRefWiresFrame'  ])
        layout.addWidget(self.refWiresFrame)

        group.setLayout(layout)
        self.layout().addWidget(group)
        self.layout().addSpacing(10)
        #***********************************#
        
        group = QtGui.QGroupBox(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kAnimWiresTabControlMap'  ])
        group.setAlignment(QtCore.Qt.AlignLeft)
        groupFont = group.font()
        groupFont.setBold(True)
        group.setFont(groupFont)        
        layout = QtGui.QVBoxLayout()

        self.useDir = RadioUI("useDir",
             [maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kRegion'  ],
              maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kClumping'  ],
              maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kDefault'  ]],
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kUseDirAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kUseDir'  ])
        layout.addWidget(self.useDir)

        buttonBox = QtGui.QWidget()
        buttonLayout = QtGui.QHBoxLayout()
        buttonLayout.setAlignment(QtCore.Qt.AlignRight)
        buttonLayout.setSpacing(3)
        buttonLayout.setContentsMargins(1,1,1,1)
        buttonBox.setLayout(buttonLayout)            
        self.setupMapButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kCreateMaps'  ])
        self.setupMapButton.setToolTip(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kCreateMapsAnn'  ])
        buttonLayout.addWidget(self.setupMapButton)
        self.previewGuidesButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPreviewWires'  ])
        self.previewGuidesButton.setToolTip(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPreviewWiresAnn'  ])
        buttonLayout.addWidget(self.previewGuidesButton)            
        self.exportGuidesButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kCreateHairSystem'  ])
        self.exportGuidesButton.setToolTip(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kCreateHairSystemAnn'  ])
        buttonLayout.addWidget(self.exportGuidesButton)                    
        layout.addWidget(buttonBox)

        group.setLayout(layout)
        self.layout().addWidget(group)
        self.layout().addSpacing(10)

        #***********************************#
        
        group = QtGui.QGroupBox(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kOptions'  ])
        group.setAlignment(QtCore.Qt.AlignLeft)
        groupFont = group.font()
        groupFont.setBold(True)
        group.setFont(groupFont)        
        layout = QtGui.QVBoxLayout()
        
        self.options = CheckBoxUI(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kOptions2'  ],
                                  ["affectCollision","animationOnly","colorPreview"],
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kOptionsAnn'  ],
             self.name,0,0,
             [maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kAffectCollision'  ],
              maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kAnimationOnly'  ],
              maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kColorPreview'  ]])
        layout.addWidget(self.options)

        group.setLayout(layout)
        self.layout().addWidget(group)
        self.layout().addSpacing(10)
        #***********************************#

            
        self.layout().addSpacing(10)
        buttonBox = QtGui.QWidget()
        buttonLayout = QtGui.QHBoxLayout()
        buttonLayout.setAlignment(QtCore.Qt.AlignRight)
        buttonLayout.setSpacing(3)
        buttonLayout.setContentsMargins(1,1,1,1)
        buttonBox.setLayout(buttonLayout)            

        attachButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kAttachHairSystem'  ])
        attachButton.setToolTip(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kAttachHairSystemAnn'  ])        
        buttonLayout.addWidget(attachButton)
        self.layout().addWidget(buttonBox)

        self.layout().addSpacing(10)
        buttonBox = QtGui.QWidget()
        buttonLayout = QtGui.QHBoxLayout()
        buttonLayout.setAlignment(QtCore.Qt.AlignRight)
        buttonLayout.setSpacing(3)
        buttonLayout.setContentsMargins(1,1,1,1)
        buttonBox.setLayout(buttonLayout)
        regionsButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPreviewRegions'  ])
        regionsButton.setToolTip(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPreviewRegionsAnn'  ])        
        buttonLayout.addWidget(regionsButton)            
        self.layout().addWidget(buttonBox)
            
        if ( xgg.Maya ):
            self.connect(self.useDir.buttons[0], QtCore.SIGNAL("clicked(bool)"),
                         lambda x: self.regionmapUpdate())
            self.connect(self.useDir.buttons[1], QtCore.SIGNAL("clicked(bool)"),
                         lambda x: self.controlmapUpdate())
            self.connect(self.useDir.buttons[2], QtCore.SIGNAL("clicked(bool)"),
                         lambda x: self.defaultUpdate())

            self.connect(self.setupMapButton, QtCore.SIGNAL("clicked()"),
                         self.setupMapSlot)
            self.connect(self.previewGuidesButton, QtCore.SIGNAL("clicked()"),
                         self.previewGuidesSlot)
            self.connect(self.exportGuidesButton, QtCore.SIGNAL("clicked()"),
                         self.createHairSystem)
            self.connect(attachButton, QtCore.SIGNAL("clicked()"),
                         self.attachSlot)
            self.connect(regionsButton, QtCore.SIGNAL("clicked()"),
                         self.regionsSlot)

        # Fix for the expanding ramp ui
        filler = QtGui.QWidget()
        self.layout().addWidget(filler)
        self.layout().setStretchFactor(filler,100)


    def defaultUpdate(self):
        de = xgg.DescriptionEditor
        de.setAttr(self.name,"controlMapDir","${DESC}/${FXMODULE}/Control/")
        de.setAttr(self.name,"pointDir","${DESC}/${FXMODULE}/Points/")
        print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlSetTo'  ] + "${DESC}/${FXMODULE}/Control/" 
        print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPointSetTo'  ] + "${DESC}/${FXMODULE}/Points/"
        self.setupMapButton.setEnabled(True)

    def controlmapUpdate(self):
        de = xgg.DescriptionEditor

        # TODO refactoring
        modules = xg.fxModules(de.currentPalette(),de.currentDescription())
        clumpMod = ""
        for mod in modules:
            if mod == self.name:
                break
            type = xg.fxModuleType(de.currentPalette(),
                                   de.currentDescription(),mod)
            if type == "ClumpingFXModule":
                clumpMod = mod
            break

        if clumpMod != "":
            pointDir = de.getAttr(clumpMod,"pointDir")
            pointDir = pointDir.replace("${FXMODULE}",clumpMod)
            controlMap = de.getAttr(clumpMod,"mapDir")
            controlMap = controlMap.replace("${FXMODULE}",clumpMod)
            de.setAttr(self.name,"pointDir",str(pointDir))
            de.setAttr(self.name,"controlMapDir",str(controlMap))
            print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlSetTo2'  ] + str(controlMap) 
            print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPointSetTo2'  ] + str(pointDir)
        else:
            xg.XGWarning(1, maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kNoClumpingModuleFoundWarning'  ])

        self.setupMapButton.setEnabled(False)

    def regionmapUpdate(self):
        de = xgg.DescriptionEditor
        prim = de.activePrimitive()
        controlMap = de.getAttr(prim,"regionMap")
        de.setAttr(self.name,"controlMapDir",str(controlMap))
        print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlSetTo3'  ] + str(controlMap)
        self.setupMapButton.setEnabled(False)

    def liveModeUpdate(self):
        value = self.liveMode.value()
        if value:
            self.wiresFile.setEnabled(False)
            self.exportGuidesButton.setEnabled(True)  
            if self.useDir.buttons[2].isChecked():
                self.setupMapButton.setEnabled(True)            
            self.previewGuidesButton.setEnabled(True)  
            self.useDir.setEnabled(True)
        else:
            self.wiresFile.setEnabled(True)
            self.exportGuidesButton.setEnabled(False)  
            self.setupMapButton.setEnabled(False)            
            self.previewGuidesButton.setEnabled(False)  
            self.useDir.setEnabled(False)

    def setupMapSlot(self):
        dialog = GenerateMapsUI(self.name)
        dialog.show() # Using show() to get a non modal dialog to allow the edit point context tool to interact with the viewport.

    def previewGuidesSlot(self):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        # Grab current generator type and switch to Point
        c_grtr = xg.getActive(pal,desc,"Generator")
        c_disp = de.getAttr(c_grtr,"displacement")
        c_vecd = de.getAttr(c_grtr,"vectorDisplacement")
        c_bump = de.getAttr(c_grtr,"bump")
        c_ofst = de.getAttr(c_grtr,"offset")
        percent = de.getAttr("GLRenderer","percent")
        xg.setActive(pal,desc,"PointGenerator")
        # Grab its attributes and replace them
        p_pdir = de.getAttr("PointGenerator","pointDir")
        p_cull = de.getAttr("PointGenerator","cullFlag")
        p_disp = de.getAttr("PointGenerator","displacement")
        p_vecd = de.getAttr("PointGenerator","vectorDisplacement")
        p_bump = de.getAttr("PointGenerator","bump")
        p_ofst = de.getAttr("PointGenerator","offset")
        val = de.getAttr(self.name,"pointDir").replace("${FXMODULE}",self.name)
        de.setAttr("PointGenerator","pointDir",val)
        de.setAttr("PointGenerator","cullFlag","False")
        de.setAttr("PointGenerator","displacement",c_disp)
        de.setAttr("PointGenerator","vectorDisplacement",c_vecd)
        de.setAttr("PointGenerator","bump",c_bump)
        de.setAttr("PointGenerator","offset",c_ofst)
        de.setAttr("GLRenderer","percent","100.0")
        de.setAttr(self.name,"previewWires","true")
        # Render out the clump guides
        setProgressInfo(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPreviewingAllProgress'  ]+self.name+".")
        cmd = 'xgmPreview -pb {"'+desc+'"}'
        mel.eval(cmd)
        # Restore everything
        de.setAttr(self.name,"previewWires","false")
        de.setAttr("PointGenerator","pointDir",p_pdir)
        de.setAttr("PointGenerator","cullFlag",p_cull)
        de.setAttr("PointGenerator","displacement",p_disp)
        de.setAttr("PointGenerator","vectorDisplacement",p_vecd)
        de.setAttr("PointGenerator","bump",p_bump)
        de.setAttr("PointGenerator","offset",p_ofst)
        de.setAttr("GLRenderer","percent",percent)
        xg.setActive(pal,desc,c_grtr)

    def createHairSystem(self):
        de = xgg.DescriptionEditor
        active = de.getAttr(self.name,"active") 
        if active == "true":
            value = de.getAttr(self.name,"exportDir")
            de.setAttr(self.name,"exportDir",str(value))
            de.setAttr(self.name,"exportCurves","true")
            #
            # Need to fill in the export faces to correct value
            #
            
            de.setAttr(self.name,"exportFaces","")
            setProgressInfo(maya.stringTable['y_xgAnimWiresFXModuleTab.kAnimWireExportClumpingGuidesProgress' ])
            cmd = 'xgmNullRender -percent 0 "'+de.currentDescription()+'"'
            mel.eval(cmd)
            value = de.getAttr(self.name,"_fullExportDir")
            cmd = 'source "'+ str(value) +'"'
            mel.eval(cmd)                
            de.setAttr(self.name,"exportCurves","false")
            de.setAttr(self.name,"exportFaces","")
        else:
            xg.XGWarning(1, maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kTheModuleHasToBeActiveWarning'  ])

    def attachSlot(self):
        de = xgg.DescriptionEditor
        cmd = 'xgmFindAttachment'
        cmd += ' -description "'+de.currentDescription()+'"'
        if de.getAttr(self.name,"liveMode") == "false":  
            cmd += ' -file "'+de.getAttr(self.name,"wiresFile")+'"'
            cmd += ' -frame '+de.getAttr(self.name,"refWiresFrame")
            cmd += ' -module "'+self.name+'"'
            mel.eval(cmd)
        else:
            sel = cmds.ls(sl=True,ni=True,dag=True,type='nurbsCurve')
            if not sel:                        
                mel.eval("xgmSelectCurvesFromHairSystem")
            
            sel = cmds.ls(sl=True,ni=True,dag=True,type='nurbsCurve')
            if sel:                        
                cmd += ' -frame '+de.getAttr(self.name,"refWiresFrame")
                cmd += ' -module "'+self.name+'"'
                mel.eval(cmd)
                print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kTheFollowingCurvesWereAttached'  ],sel            
            else:
                warn = QtGui.QMessageBox()
                warn.setText(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kNoCurvesSelected'  ])
                warn.exec_()            

    def regionsSlot(self):
        sel = cmds.ls(sl=True,ni=True,dag=True,type='nurbsCurve')
        if sel:
            origSel = cmds.ls(sl=True)
            cmds.select(sel,replace=True)
            de = xgg.DescriptionEditor
            mel.eval('xgmPreview -fx "'+self.name+'" {"'+
                     de.currentDescription()+'"}')
            cmds.select(origSel,replace=True)
        else:
            warn = QtGui.QMessageBox()
            warn.setText(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kNoWireSelected'  ])
            warn.exec_()

    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.magnitude.refresh()
        self.interpolation.refresh()
        self.liveMode.refresh()
        self.wiresFile.refresh()
        self.refWiresFrame.refresh()
        self.options.refresh()
        self.magScale.refresh()
        self.useDir.refresh()
        self.liveModeUpdate()

class GenerateMapsUI(PointsBaseUI):
    """A dialog to specify the options for generating clumping maps.

    This provides fields for editing radius, texel resolution, and
    control maps, and also provides buttons for generate and cancel.
    """
    def __init__(self,name):
        PointsBaseUI.__init__(self,maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kGenerateMaps'  ])
        self.name = name

        de = xgg.DescriptionEditor
        mapInitialized = xg.stringToBool(de.getAttr(self.name,"mapInitialized"))
        if mapInitialized:
            useControlMap = xg.stringToBool(de.getAttr(self.name,"useControlMaps"))
            controlMask = de.getAttr(self.name,"controlMask")
            controlMap = de.getAttr(self.name,"controlMapDir")
        else:
        # gather control map information
            useControlMap = False
            modules = xg.fxModules(de.currentPalette(),de.currentDescription())
            clumpMod = ""
            for mod in modules:
                if mod == self.name:
                    break
                type = xg.fxModuleType(de.currentPalette(),
                                       de.currentDescription(),mod)
                if type == "ClumpingFXModule":
                    clumpMod = mod
            if clumpMod == "":
                # No prior clumping module so (possibly) use region map
                prim = de.activePrimitive()
                controlMask = de.getAttr(prim,"regionMask")
                controlMap = de.getAttr(prim,"regionMap")
                if controlMask != "0.0" and controlMask != "0":
                    useControlMap = True
            else:
                useControlMap = True
                controlMask = de.getAttr(clumpMod,"mask")
                controlMap = de.getAttr(clumpMod,"mapDir")
                controlMap = controlMap.replace("${FXMODULE}",clumpMod)
        
        # build the point definition section
        group = QtGui.QGroupBox(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPoints'  ])
        group.setAlignment(QtCore.Qt.AlignLeft)
        groupFont = group.font()
        groupFont.setBold(True)
        group.setFont(groupFont)
        layout = QtGui.QVBoxLayout()

        self.pointDirUI(layout,
                        "pointDir",
                        maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPointDirAnn'  ],
                        self.name,
                        maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kPointDir'  ])

        self.ptDensity = FloatUI("Density",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kDensityAnn'  ],
             "",0.0,10000.0,0.01,100.0,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kDesnity'  ])
        value = de.getAttr(self.name,"ptDensity")
        self.ptDensity.setValue(value)
        layout.addWidget(self.ptDensity)

        self.ptMask = ExpressionUI("Mask",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMaskAnn'  ],
             "", maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMask'  ])
        self.ptMask.setMinimumWidth(50)
        value = de.getAttr(self.name,"ptMask")
        self.ptMask.setValue(value)
        self.ptMask.refresh()
        layout.addWidget(self.ptMask)

        self.ptLengthUI(layout,
                        self.name)

        layout.addSpacing(5)
        ptButtonBox = QtGui.QWidget()
        ptButtonLayout = QtGui.QHBoxLayout()
        ptButtonLayout.setAlignment(QtCore.Qt.AlignRight)
        ptButtonLayout.setSpacing(3)
        ptButtonLayout.setContentsMargins(1,1,1,1)
        ptButtonBox.setLayout(ptButtonLayout)
        ptLoadButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kLoad'  ])
        ptLoadButton.setAutoDefault(False)
        ptLoadButton.setDefault(False)
        ptButtonLayout.addWidget(ptLoadButton)
        ptGenButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kGenerate'  ])
        ptGenButton.setAutoDefault(False)
        ptGenButton.setDefault(False)
        ptButtonLayout.addWidget(ptGenButton)
        ptGuideButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kGuide'  ])
        ptGuideButton.setAutoDefault(False)
        ptGuideButton.setDefault(False)
        ptButtonLayout.addWidget(ptGuideButton)
        ptClrButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kClear'  ])
        ptClrButton.setAutoDefault(False)
        ptClrButton.setDefault(False)
        ptButtonLayout.addWidget(ptClrButton)
        ptSaveButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kSave'  ])
        ptSaveButton.setAutoDefault(False)
        ptSaveButton.setDefault(False)
        ptButtonLayout.addWidget(ptSaveButton)
        layout.addWidget(ptButtonBox)
        self.connect(ptLoadButton, QtCore.SIGNAL("clicked()"),
                     lambda: self.loadPoints(self.name))
        self.connect(ptGenButton, QtCore.SIGNAL("clicked()"),
                     lambda: self.generatePoints(self.ptDensity.value(),
                                                 self.ptMask.value(),
                                                 self.name))
        self.connect(ptGuideButton, QtCore.SIGNAL("clicked()"),
                     self.guidePoints)
        self.connect(ptClrButton, QtCore.SIGNAL("clicked()"),
                     self.clearPoints)
        self.connect(ptSaveButton, QtCore.SIGNAL("clicked()"),
                     lambda: self.savePoints(self.name))

        group.setLayout(layout)
        self.layout().addWidget(group)
        self.layout().addSpacing(5)

        # build the map definition section
        group = QtGui.QGroupBox(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMaps'  ])
        group.setAlignment(QtCore.Qt.AlignLeft)
        groupFont = group.font()
        groupFont.setBold(True)
        group.setFont(groupFont)
        layout = QtGui.QVBoxLayout()
        self.controlMapDir = BrowseUI("controlMapDir",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlMapDirAnn'  ],
             self.name,"","in",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlMapDir'  ])
        self.controlMapDir.refresh()
        layout.addWidget(self.controlMapDir)
        
        self.radius = ExpressionUI("radiusVariance",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kRadiusVarianceAnn'  ],
             self.name,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kRadiusVariance'  ])
        self.radius.refresh()
        layout.addWidget(self.radius)

        self.useCM = CheckBoxUI(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kUseControlMaps'  ],"useControlMaps",
                                maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kUseControlMapsAnn'  ], self.name)
        self.connect(self.useCM.boxValue[0], QtCore.SIGNAL("clicked(bool)"),
                     lambda x: self.controlmapUpdate())
        self.useCM.setValue(useControlMap)
        layout.addWidget(self.useCM)
        self.controlMask = ExpressionUI("controlMask",
                   maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlMaskAnn'  ],
                   self.name, 
                   maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlMask'  ])
        self.controlMask.setValue(controlMask)
        layout.addWidget(self.controlMask)
        self.controlMap = BrowseUI("controlMap",
                   maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlMapAnn'  ],
                   self.name,"","in",
                   maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kControlMap'  ])
        self.controlMap.setValue(controlMap)
        layout.addWidget(self.controlMap)
        
        self.tpu = FloatUI("texelsPerUnit",
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kTexelsPerUnitAnn'  ],
             self.name,0.0,10000,1.0,50.0,
             maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kTexelsPerUnit'  ])
        self.connect(self.tpu.floatValue,QtCore.SIGNAL("editingFinished()"),
                     self.tpuUpdate)
        self.tpu.refresh()
        layout.addWidget(self.tpu)
        self.mem = QtGui.QLabel(" 0 MB")
        self.mem.setToolTip(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kMemorySizeInMb'  ])
        self.tpu.layout().insertWidget(3,self.mem,100)
        mapButtonBox = QtGui.QWidget()
        mapButtonLayout = QtGui.QHBoxLayout()
        mapButtonLayout.setAlignment(QtCore.Qt.AlignRight)
        mapButtonLayout.setSpacing(3)
        mapButtonLayout.setContentsMargins(1,1,1,1)
        mapButtonBox.setLayout(mapButtonLayout)        
        mapSaveButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kCreate'  ])
        mapSaveButton.setAutoDefault(False)
        mapSaveButton.setDefault(False)
        mapButtonLayout.addWidget(mapSaveButton)        
        mapButtonBox.setLayout(mapButtonLayout)
        layout.addWidget(mapButtonBox)
        group.setLayout(layout)
        self.layout().addWidget(group)


        self.layout().addSpacing(10)
        mapButtonBox = QtGui.QWidget()
        mapButtonLayout = QtGui.QHBoxLayout()
        mapButtonLayout.setAlignment(QtCore.Qt.AlignRight)
        mapButtonLayout.setSpacing(3)
        mapButtonLayout.setContentsMargins(1,1,1,1)
        mapButtonBox.setLayout(mapButtonLayout)

        mapCancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kCancel'  ])
        mapCancelButton.setAutoDefault(False)
        mapCancelButton.setDefault(False)
        mapButtonLayout.addWidget(mapCancelButton)
        self.layout().addWidget(mapButtonBox)
        self.connect(mapSaveButton, QtCore.SIGNAL("clicked()"),
                     self.generateMaps)
        self.connect(mapCancelButton, QtCore.SIGNAL("clicked()"),
                     self.close)

        self.controlmapUpdate()
        self.tpuUpdate()
        self.initDialog(self.name)

    def tpuUpdate(self):
        de = xgg.DescriptionEditor
        tpu = self.tpu.value()
        cmd = 'xgmClumpMap -computeMemory -texelsPerUnit '+tpu
        cmd += ' -d "'+de.currentDescription()+'"'
        memUsed = mel.eval(cmd)
        if memUsed > 1024.0:
            memUsed = memUsed/1024.0
            if memUsed > 1024.0:
                memUsed = memUsed/1024.0
                self.mem.setText('{0:0.3f} TB'.format(memUsed))
            else:
                self.mem.setText('{0:0.3f} GB'.format(memUsed))
        else:
            self.mem.setText('{0:0.3f} MB'.format(memUsed))

    def controlmapUpdate(self):
        value = self.useCM.value()
        if value:
            self.controlMask.setEnabled(True)
            self.controlMap.setEnabled(True)
            self.tpu.setEnabled(False)
        else:
            self.controlMask.setEnabled(False)
            self.controlMap.setEnabled(False)
            self.tpu.setEnabled(True)
            
    def generateMaps(self):
        de = xgg.DescriptionEditor
        de.setAttr(self.name,"mapInitialized","True")

        # Save out the current points and what was use to define them. 
        self.savePoints(self.name)
        de.setAttr(self.name,"ptDensity",self.ptDensity.value())
        de.setAttr(self.name,"ptMask",self.ptMask.value())
        # Generate the clumping maps using the new points.
        setProgressInfo(maya.stringTable['y_xgAnimWiresFXModuleTab.kAnimWiresSavePointsProgress' ])
        cmd = 'xgmClumpMap -pb'
        cmd += ' -fxmodule "' + self.name + '"'
        cmd += ' -mapDir "' + de.getAttr(self.name,"controlMapDir") + '"'
        cmd += ' -pointDir "' + de.getAttr(self.name,"pointDir") + '"'
        cmd += ' -texelsPerUnit ' + de.getAttr(self.name,"texelsPerUnit")
        cmd += ' -radiusVariance "' + \
            de.getAttr(self.name,"radiusVariance") + '"'
        useCM = self.useCM.value()
        if useCM:
            cmask = self.controlMask.value()
            cmask = cmds.encodeString(cmask)
            cmd += ' -controlMask "' + cmask + '"'
            cmd += ' -controlMap "' + self.controlMap.value() + '"'
        cmd += ' -d "' + de.currentDescription() + '"'
        maps = mel.eval(cmd)
        print maya.stringTable[ 'y_xgAnimWiresFXModuleTab.kTheFollowingMapsWereGenerated'  ],maps
        self.close()
