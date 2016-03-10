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


#
# @file xgBrush.py
# @brief Brush implementations
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm as xgen
import maya.cmds as cmds
import maya.mel as mel
from xgenm.ui.widgets import ExpandUI
from xgenm.ui.util.xgUtil import labelWidth

# List of brushes, mapped to their localized counterparts.  
_locNames = {"Pose"     :maya.stringTable[ 'y_xgBrush.kPose'  ],
             "Orient"   :maya.stringTable[ 'y_xgBrush.kOrient'  ],
             "Bend"     :maya.stringTable[ 'y_xgBrush.kBend'  ],
             "Twist"    :maya.stringTable[ 'y_xgBrush.kTwist'  ],
             "Elevation":maya.stringTable[ 'y_xgBrush.kElevation'  ],
             "Noise"    :maya.stringTable[ 'y_xgBrush.kNoise'  ],
             "Length"   :maya.stringTable[ 'y_xgBrush.kLength'  ],
             "Width"    :maya.stringTable[ 'y_xgBrush.kWidth'  ],
             "Attract"  :maya.stringTable[ 'y_xgBrush.kAttract'  ],
             "Repel"    :maya.stringTable[ 'y_xgBrush.kRepel'  ],
             "Part"     :maya.stringTable[ 'y_xgBrush.kPart'  ],
             "Smooth"   :maya.stringTable[ 'y_xgBrush.kSmooth'  ],
             "Mask"     :maya.stringTable[ 'y_xgBrush.kMask'  ],
             "Eraser"   :maya.stringTable[ 'y_xgBrush.kEraser'  ],
             "Region"   :maya.stringTable[ 'y_xgBrush.kRegion'  ]}

# variable indices required by igroom for passing the UI data to the maya tool
_igBrushVarIndices = {
    "igBrushSpacing":-1,
    "igBrushFalloff":-1,
    "igBrushMaskUse":-1,
    "igBrushPoseOrientMag":0,
    "igBrushPoseBendMag":0,
    "igBrushOrientMag":0,
    "igBrushBendMag":0,
    "igBrushTwistMag":0,
    "igBrushElevDegrees":0,
    "igBrushElevGoalAngle":1,
    "igBrushElevGoalAngleField":0,
    "igBrushNoiseMidMag":0,
    "igBrushNoiseTipMag":1,
    "igBrushNoiseWidthMag":2,
    "igBrushNoiseOffNDegrees":3,
    "igBrushNoiseAboutNDegrees":4,
    "igBrushNoiseTwistDegrees":5,
    "igBrushLengthIncr":0,
    "igBrushLengthGoal":1,
    "igBrushWidthIncr":0,
    "igBrushWidthGoal":1,
    "igBrushAttractStyle":0,
    "igBrushAttractMag":1,
    "igBrushRepelMag":0,
    "igBrushPartMag":0,
    "igBrushSmoothLengthMag":0,
    "igBrushSmoothOrientMag":1,
    "igBrushSmoothBendMag":2,
    "igBrushMaskMag":0,
    "igBrushEraserLengthMag":0,
    "igBrushEraserOrientMag":1,
    "igBrushEraserBendMag":2,
    "igBrushRegionColor":-1
}

def _setSetting( setting, val, type='float' ):
    """ set a brush setting in the scene as an attribute on the grooming description """
    igDesc = xg.igCurrentDescription( )
    if len(igDesc):
        xg.setAttrValue( igDesc, (setting,val,type) )

def _getSetting( setting, defval ):
    """ get a brush setting from a grooming description """
    igDesc = xg.igCurrentDescription( )
    if len(igDesc):
        return xg.getAttrValue( igDesc, (setting,defval) )
    return defval

def _updateFromRadio( attr ):
    """ update UI attribute from a radio widget value"""
    # save new setting
    widget = '%sField' % attr
    val = cmds.radioButtonGrp( widget, query=True, select=True )
    _setSetting( attr, val )

    # update igroom brush variables
    var = attr.split('igBrush')
    mel.eval('igBrushUpdateRadio \"%s\" \"%d\"' % (var[1],_igBrushVarIndices[attr]))

def _updateRadio( attr, defval ):
    """ update radio widget with a UI attribute """
    val = _getSetting( attr, defval )
    widget = '%sField' % attr
    cmds.radioButtonGrp( widget, edit=True, select=val )

    # update igroom brush variables
    var = attr.split('igBrush')
    mel.eval('igBrushUpdateRadio \"%s\" \"%d\"' % (var[1],_igBrushVarIndices[attr]))
    
def _updateFromSlider( attr ):
    """ update UI attribute from a float slider value"""
    # save new setting
    widget = '%sField' % attr
    val = cmds.floatSliderGrp( widget, q=True, v=True )
    _setSetting( attr, val )

    # update igroom brush variables
    var = attr.split('igBrush')
    mel.eval('igBrushUpdateFSlider \"%s\" \"%d\"' % (var[1],_igBrushVarIndices[attr]))

def _updateSlider( attr, defval ):
    """ update float slider with a UI attribute """
    val = _getSetting( attr, defval )
    widget = '%sField' % attr
    cmds.floatSliderGrp( widget, edit=True, value=val )

    # update igroom brush variables
    var = attr.split('igBrush')
    mel.eval('igBrushUpdateFSlider \"%s\" \"%d\"' % (var[1],_igBrushVarIndices[attr]))

def _updateFromColorSlider( attr ):
    """ update UI attribute from a color slider value"""
    # save new setting
    widget = '%sField' % attr
    val = cmds.colorSliderGrp( widget, q=True, rgb=True )
    _setSetting( attr, val, type='doubleArray' )

    # update igroom brush variables
    var = attr.split('igBrush')
    mel.eval('igBrushUpdateColorSlider \"%s\"' % var[1])

def _updateColorSlider( attr, defval ):
    """ update color slider with a UI attribute """
    val = _getSetting( attr, defval )
    widget = '%sField' % attr
    cmds.colorSliderGrp( widget, edit=True, rgb=val )

    # update igroom brush variables
    var = attr.split('igBrush')
    mel.eval('igBrushUpdateColorSlider \"%s\"' % var[1])

def _createWidget( func, name, **kwargs ):
    ctrl = func( name, **kwargs )
    w = xg.toQtWidget(ctrl)
    return w

class BaseBrush(QtGui.QWidget):    
    def __init__(self):
        QtGui.QWidget.__init__(self)
        mainLayout = QtGui.QVBoxLayout(self)
        mainLayout.setSpacing(0)
        mainLayout.setContentsMargins(0,0,0,0)        
        mainLayout.insertSpacing( 0, 5 )
        self.setLayout(mainLayout)
        self._labelName = ""

        # width controls for the ui spacings.
        self._mainColumnWidth=labelWidth()
        self._radioWidth=80
        self._columnWidth = [1,self._mainColumnWidth]
        self._spacing = "   "
        self._refreshInfo = []    

    def invoke(self):
        """ init the brush data and invoke the tool """
        brushName = self.objectName()
        cmd = '$igActiveBrush="%s";ig%sBrushInit();' % (brushName,brushName)
        mel.eval( cmd )
        if cmds.currentCtx() == 'igBrushContextInstance':
            return
        mel.eval( 'igBrushContextSelect' )

    def abort(self):
        """invoke select tool to abort current tool"""
        cmd = "global string $gSelect; setToolTo $gSelect;"
        mel.eval( cmd )

    def refresh( self):
        """ refresh all widgets of this brush with the settings set on the current description """
        for info in self._refreshInfo:
            (attr, defval, func ) = info
            func( attr, defval )

    def setName(self, name):
        self._labelName = _locNames[name]
        self.setObjectName( name )

    def buildUI(self):
        self.brushWidget = ExpandUI(self._labelName) 
        self.layout().addWidget(self.brushWidget)

        # brush widgets
        sp = self._addSetting( 'igBrushSpacing', 0.1 )
        w = _createWidget( cmds.floatSliderGrp, 'igBrushSpacingField', l=maya.stringTable[ 'y_xgBrush.kSpacing'  ]+self._spacing, f=True, cw=self._columnWidth, 
                            min=0.001, max=1.0, pre=3, step=0.02, v=sp,
                            ann=maya.stringTable[ 'y_xgBrush.kSpacingAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushSpacing")' )
        self.brushWidget.addWidget(w)

        fo = self._addSetting( 'igBrushFalloff', 1, _updateRadio )
        w = _createWidget( cmds.radioButtonGrp, 'igBrushFalloffField', l=maya.stringTable[ 'y_xgBrush.kFalloff'  ]+self._spacing, nrb=4, sl=fo, 
                            cw5=[self._mainColumnWidth,self._radioWidth,self._radioWidth,self._radioWidth,self._radioWidth],
                            ann=maya.stringTable[ 'y_xgBrush.kFalloffAnn'  ],
                            la4=[maya.stringTable[ 'y_xgBrush.kGauss'  ],
                                 maya.stringTable[ 'y_xgBrush.kSmooth2'  ],
                                 maya.stringTable[ 'y_xgBrush.kLinear'  ],
                                 maya.stringTable[ 'y_xgBrush.kImpulse'  ]],
                            onc='xgen.ui.brushes.xgBrush._updateFromRadio("igBrushFalloff")' )
        self.brushWidget.addWidget(w)     

        mm = self._addSetting( 'igBrushMaskUse', 1, _updateRadio )
        w = _createWidget( cmds.radioButtonGrp, 'igBrushMaskUseField', l=maya.stringTable[ 'y_xgBrush.kMask1'  ]+self._spacing, nrb=2, sl=mm, 
                            cw=self._columnWidth, 
                            ann=maya.stringTable[ 'y_xgBrush.kMaskAnn'  ],
                            la2=[maya.stringTable[ 'y_xgBrush.kApplyWithin'  ],
                                 maya.stringTable[ 'y_xgBrush.kApplyOutside'  ]],
                            onc='xgen.ui.brushes.xgBrush._updateFromRadio("igBrushMaskUse")' )
        self.brushWidget.addWidget(w)        

    def _addSetting( self, attr, defval, func=_updateSlider ):
        """ store setting info of a brush widget and return the current value"""
        # keep info for refresh
        self._refreshInfo.append( (attr, defval, func) )
        # return setting value
        return _getSetting( attr, defval )

class Pose(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)        
        self.setName('Pose')

    def uiInfo(self):
        return (_locNames['Pose'],'iGroom_pose.png' )

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushPoseOrientMag', 0.5 )
        igBrushMagnitude1 = self._addSetting( 'igBrushPoseBendMag', 0.5 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushPoseOrientMagField', l=maya.stringTable[ 'y_xgBrush.kOrientation1'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kOrientationAnn1'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushPoseOrientMag")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushPoseBendMagField', l=maya.stringTable[ 'y_xgBrush.kBend1'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kBendAnn1'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushPoseBendMag")' )
        self.brushWidget.addWidget(w)     

class Orient(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Orient')

    def uiInfo(self):
        return (_locNames['Orient'],'iGroom_orient.png')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushOrientMag', 0.8 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushOrientMagField', l=maya.stringTable[ 'y_xgBrush.kMagnitude1'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kMagnitudeAnn1'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushOrientMag")' )
        self.brushWidget.addWidget(w)     

class Bend(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Bend')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushBendMag', 0.8 )
        w = _createWidget( cmds.floatSliderGrp, 'igBrushBendMagField', l=maya.stringTable[ 'y_xgBrush.kMagnitude2'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kMagnitudeAnn2'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushBendMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (maya.stringTable[ 'y_xgBrush.kBend3'  ],'iGroom_bend.png')

class Twist(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Twist')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushTwistMag', 1.0 )
        w = _createWidget( cmds.floatSliderGrp, 'igBrushTwistMagField', l=maya.stringTable[ 'y_xgBrush.kDegrees1'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=10.0, fmx=30.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kDegreesAnn1'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushTwistMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (maya.stringTable[ 'y_xgBrush.kTwist2'  ],'iGroom_twist.png')

class Elevation(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Elevation')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushElevDegrees', 1.0 )
        igBrushMagnitude1 = self._addSetting( 'igBrushElevGoalAngle', 30.0 )
        w = _createWidget( cmds.floatSliderGrp, 'igBrushElevDegreesField', l=maya.stringTable[ 'y_xgBrush.kDegrees2'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=-10.0, max=10.0, fmn=-90.0, fmx=90.0, pre=2, step=0.5, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kDegreesAnn2'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushElevDegrees")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushElevGoalAngleField', l=maya.stringTable[ 'y_xgBrush.kGoalAngle'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=90.0, pre=2, step=0.5, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kGoalAngleAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushElevGoalAngle")' )
        self.brushWidget.addWidget(w)     
        
    def uiInfo(self):
        return (_locNames['Elevation'],'iGroom_angle.png')

class Noise(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Noise')

    def buildUI(self):
        BaseBrush.buildUI(self)
   
        igBrushMagnitude0 = self._addSetting( 'igBrushNoiseMidMag', 0.075 )
        igBrushMagnitude1 = self._addSetting( 'igBrushNoiseTipMag', 0.15 )
        igBrushMagnitude2 = self._addSetting( 'igBrushNoiseWidthMag', 0.02 )
        igBrushMagnitude3 = self._addSetting( 'igBrushNoiseOffNDegrees', 2.0 )
        igBrushMagnitude4 = self._addSetting( 'igBrushNoiseAboutNDegrees', 1.5 )
        igBrushMagnitude5 = self._addSetting( 'igBrushNoiseTwistDegrees', 1.0 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushNoiseMidMagField', l=maya.stringTable[ 'y_xgBrush.kMiddle'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kMiddleAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushNoiseMidMag")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushNoiseTipMagField', l=maya.stringTable[ 'y_xgBrush.kTip'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kTipAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushNoiseTipMag")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushNoiseWidthMagField', l=_locNames['Width']+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude2,
                            ann=maya.stringTable[ 'y_xgBrush.kWidthAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushNoiseWidthMag")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushNoiseOffNDegreesField', l=maya.stringTable[ 'y_xgBrush.kOff'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=10.0, pre=3, fmx=90.0, step=0.02, v=igBrushMagnitude3,
                            ann=maya.stringTable[ 'y_xgBrush.kOffAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushNoiseOffNDegrees")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushNoiseAboutNDegreesField', l=maya.stringTable[ 'y_xgBrush.kAround'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=10.0, pre=3, fmx=90.0, step=0.02, v=igBrushMagnitude4,
                            ann=maya.stringTable[ 'y_xgBrush.kAboutAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushNoiseAboutNDegrees")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushNoiseTwistDegreesField', l=maya.stringTable[ 'y_xgBrush.kTwist3'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=10.0, pre=3, fmx=90.0, step=0.02, v=igBrushMagnitude5,
                            ann=maya.stringTable[ 'y_xgBrush.kTwistAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushNoiseTwistDegrees")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (_locNames['Noise'],'iGroom_noise.png')

class Length(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Length')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushLengthIncr', 0.1 )
        igBrushMagnitude1 = self._addSetting( 'igBrushLengthGoal', 5.0 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushLengthIncrField', l=maya.stringTable[ 'y_xgBrush.kIncrement1'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=-1.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kIncrementAnn1'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushLengthIncr")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushLengthGoalField', l=maya.stringTable[ 'y_xgBrush.kGoalLength'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, fmx=10.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kGoalLengthAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushLengthGoal")' )
        self.brushWidget.addWidget(w)     
            
    def uiInfo(self):
        return (maya.stringTable[ 'y_xgBrush.kLength2'  ],'iGroom_length.png')

class Width(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Width')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushWidthIncr', 0.02 )
        igBrushMagnitude1 = self._addSetting( 'igBrushWidthGoal', 0.1 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushWidthIncrField', l=maya.stringTable[ 'y_xgBrush.kIncrement2'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=-1.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kIncrementAnn2'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushWidthIncr")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushWidthGoalField', l=maya.stringTable[ 'y_xgBrush.kGoalWidth'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, fmx=10.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kGoalWidthAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushWidthGoal")' )
        self.brushWidget.addWidget(w)                 

    def uiInfo(self):
        return (_locNames['Width'],'iGroom_width.png')

class Attract(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Attract')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushAttractStyle', 1.0, _updateRadio )
        igBrushMagnitude1 = self._addSetting( 'igBrushAttractMag', 0.9 )

        w = _createWidget( cmds.radioButtonGrp, 'igBrushAttractStyleField', l=maya.stringTable[ 'y_xgBrush.kStyle'  ]+self._spacing, nrb=2, sl=igBrushMagnitude0, 
                            cw=self._columnWidth,la2=[maya.stringTable[ 'y_xgBrush.kLock'  ],
                                          maya.stringTable[ 'y_xgBrush.kFloat'  ]],
                            ann=(maya.stringTable[ 'y_xgBrush.kStyleAnn'  ]),
                            onc='xgen.ui.brushes.xgBrush._updateFromRadio("igBrushAttractStyle")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushAttractMagField', l=maya.stringTable[ 'y_xgBrush.kMagnitude3'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kMagnitudeAnn3'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushAttractMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (_locNames['Attract'],'iGroom_attract.png')

class Repel(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Repel')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushRepelMag', 0.3 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushRepelMagField', l=maya.stringTable[ 'y_xgBrush.kMagnitude4'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kMagnitudeAnn4'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushRepelMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (_locNames['Repel'],'iGroom_repel.png')

class Part(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Part')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushPartMag', 0.3 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushPartMagField', l=maya.stringTable[ 'y_xgBrush.kMagnitude5'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kMagnitudeAnn5'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushPartMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (_locNames['Part'],'iGroom_part.png')

class Smooth(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Smooth')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushSmoothLengthMag', 0.2 )
        igBrushMagnitude1 = self._addSetting( 'igBrushSmoothOrientMag', 0.2 )
        igBrushMagnitude2 = self._addSetting( 'igBrushSmoothBendMag', 0.2 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushSmoothLengthMagField', l=maya.stringTable[ 'y_xgBrush.kLength3'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kLengthAnn3'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushSmoothLengthMag")' )
        self.brushWidget.addWidget(w)     

        w = _createWidget( cmds.floatSliderGrp, 'igBrushSmoothOrientMagField', l=maya.stringTable[ 'y_xgBrush.kOrientation2'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kOrientationAnn2'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushSmoothOrientMag")' )
        self.brushWidget.addWidget(w)     
        
        w = _createWidget( cmds.floatSliderGrp, 'igBrushSmoothBendMagField', l=maya.stringTable[ 'y_xgBrush.kBend4'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude2,
                            ann=maya.stringTable[ 'y_xgBrush.kBendAnn4'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushSmoothBendMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (maya.stringTable[ 'y_xgBrush.kSmooth3'  ],'iGroom_smooth.png')

class Mask(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Mask')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushMaskMag', 0.2 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushMaskMagField', l=maya.stringTable[ 'y_xgBrush.kMagnitude6'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=-0.25, max=1.0, fmn=-1.0, pre=3, step=0.01, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kMagnitudeAnn6'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushMaskMag")' )
        self.brushWidget.addWidget(w)                 

    def uiInfo(self):
        return (maya.stringTable[ 'y_xgBrush.kMask3'  ],'iGroom_mask.png')

class Eraser(BaseBrush):    
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Eraser')

    def buildUI(self):
        BaseBrush.buildUI(self)

        igBrushMagnitude0 = self._addSetting( 'igBrushEraserLengthMag', 0.01 )
        igBrushMagnitude1 = self._addSetting( 'igBrushEraserOrientMag', 0.01 )
        igBrushMagnitude2 = self._addSetting( 'igBrushEraserBendMag', 0.01 )

        w = _createWidget( cmds.floatSliderGrp, 'igBrushEraserLengthMagField', l=maya.stringTable[ 'y_xgBrush.kLength4'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude0,
                            ann=maya.stringTable[ 'y_xgBrush.kLengthAnn4'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushEraserLengthMag")' )
        self.brushWidget.addWidget(w)

        w = _createWidget( cmds.floatSliderGrp, 'igBrushEraserOrientMagField', l=maya.stringTable[ 'y_xgBrush.kOrientation3'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude1,
                            ann=maya.stringTable[ 'y_xgBrush.kOrientationAnn3'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushEraserOrientMag")' )
        self.brushWidget.addWidget(w)     
        
        w = _createWidget( cmds.floatSliderGrp, 'igBrushEraserBendMagField', l=maya.stringTable[ 'y_xgBrush.kBend5'  ]+self._spacing, f=True, cw=self._columnWidth,
                            min=0.0, max=1.0, pre=3, step=0.02, v=igBrushMagnitude2,
                            ann=maya.stringTable[ 'y_xgBrush.kBendAnn5'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromSlider("igBrushEraserBendMag")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (_locNames['Eraser'],'iGroom_erase.png')

class Region(BaseBrush):
    def __init__(self):
        BaseBrush.__init__(self)
        self.setName('Region')

    def buildUI(self):
        BaseBrush.buildUI(self)

        rgb = self._addSetting( 'igBrushRegionColor', [1.0,0.0,0.0], _updateColorSlider )

        igBrushMagnitude0 = rgb[0]
        igBrushMagnitude1 = rgb[1]
        igBrushMagnitude2 = rgb[2]

        w = _createWidget( cmds.colorSliderGrp, 'igBrushRegionColorField', l=maya.stringTable[ 'y_xgBrush.kColor'  ]+self._spacing, 
                            rgb=[igBrushMagnitude0,igBrushMagnitude1,igBrushMagnitude2],
                            cw=self._columnWidth,
                            ann=maya.stringTable[ 'y_xgBrush.kColorAnn'  ],
                            cc='xgen.ui.brushes.xgBrush._updateFromColorSlider("igBrushRegionColor")' )
        self.brushWidget.addWidget(w)     

    def uiInfo(self):
        return (_locNames['Region'],'iGroom_region.png')

def brushList():
    """ returns all brush classes """
    return [[Length,Width,Pose,Orient,Bend,Elevation,Attract],[Repel,Part,Noise,Twist,Smooth,Region,Mask,Eraser]]
