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

##
# @file xgFloatUI.py
# @brief Contains the UI for editing a float value
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
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets.xgFileBrowserUI import *

class Slider(QtGui.QSlider):
    def __init__(self,direction):
        QtGui.QSlider.__init__(self,direction)
    def wheelEvent( self, e ):
        e.ignore()

_sliderNumSteps = 200
_sliderSingleSteps = 1
_sliderPageSteps = 10

class FloatUI(QtGui.QWidget):
    """A widget for editing a float value.

    This provides for the label and a float entry box.
    """
    xgAttrChanged = QtCore.Signal()

    def __init__(self,attr,help="",object="",dMin=-1000000.0,dMax=1000000.0,uiMin=-1000,uiMax=1000,mainlabel="",autoPlayblast=True):
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        self.dMin = dMin
        self.dMax = dMax
        self.uiMinDefault = self.uiMin = max( uiMin, self.dMin )
        self.uiMaxDefault = self.uiMax = min( uiMax, self.dMax )
        self.autoPlayblast = autoPlayblast
        
        # Widgets
        if mainlabel != "":
            self.label = QtGui.QLabel(mainlabel)
        elif object == "":
            self.label = QtGui.QLabel(attr)
        else:
            self.label = QtGui.QLabel(makeLabel(attr))
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label.setIndent(10)
        self.floatValue = QtGui.QLineEdit()
        self.validate = QtGui.QDoubleValidator(self.dMin,self.dMax,
                                               6,self.floatValue)
        self.validate.fixup = self.myFixup

        self.slider = Slider(QtCore.Qt.Horizontal)
        self.slider.setFixedHeight(18);
        
        self.slider.setMinimum(int(self.uiMin*_sliderNumSteps))
        self.slider.setMaximum(int(self.uiMax*_sliderNumSteps))
        self.slider.setPageStep(_sliderPageSteps)
        self.slider.setSingleStep(_sliderSingleSteps)
        
        self.sliderChangedEnable = True
        
        self.floatValue.setValidator(self.validate)
        self.floatValue.setFixedWidth(62)
        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.floatValue)
        layout.addWidget(self.slider)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()

    def setFieldWidth(self, width):
        self.floatValue.setFixedWidth(width)

    def myFixup(self,value):
        if float(value)<=self.dMin:
            self.setValue(self.dMin)
        elif float(value)>=self.dMax:
            self.setValue(self.dMax)
        self.floatValue.emit(QtCore.SIGNAL("editingFinished()"))

    def value(self):
        return str(self.floatValue.text())

    def setValue(self,value):
        self.floatValue.setText(str(value))

    def setAttr(self, value):
        """ set the underlying attribute and properly update the widget"""
        self.setValue(value)
        self.editChanged()

    def updateSliderLimits(self):
        v = float( self.value() )
        if v > self.uiMax:
            self.uiMax = v
            self.slider.setMaximum(int(self.uiMax*_sliderNumSteps))
        elif v < self.uiMin:
            self.uiMin = v
            self.slider.setMinimum(int(self.uiMin*_sliderNumSteps))
            
    def setAttrCmd(self):
        ret = xgg.DescriptionEditor.setAttrCmd( self.object, self.attr, self.value() )
        self.xgAttrChanged.emit()
        return ret

    def editChanged(self):
        if self.sliderChangedEnable:
            self.updateSliderLimits()
            self.slider.setValue( int( (float( self.value() )) * float(_sliderNumSteps) ) ) 
        if self.object!="" and self.setAttrCmd():
            self.playblast()
            
            
    def sliderChanged(self,v):
        if self.sliderChangedEnable == False:
            return
        
        self.setValue( v/float(_sliderNumSteps) ) 
        if self.object!="" and self.setAttrCmd():
            self.playblast()
    
    def playblast(self):
        if self.autoPlayblast: 
            xgg.DescriptionEditor.playblast()

    def connectIt(self):
        if xgg.DescriptionEditor is None:
            return
            
        self.connect(self.floatValue,QtCore.SIGNAL("editingFinished()"), self.editChanged )
        self.connect(self.floatValue,QtCore.SIGNAL( "returnPressed()"), self.setFocus )
        self.connect(self.slider, QtCore.SIGNAL("valueChanged(int)"), self.sliderChanged )
        self.connect(self.slider, QtCore.SIGNAL("sliderReleased()"), self.onSliderReleased )
        self.connect(self.slider, QtCore.SIGNAL("sliderPressed()"), self.onSliderPressed )

    def onSliderPressed(self):
        try:
            import maya.cmds as cmds
            cmds.undoInfo( openChunk=True, cn=self.attr )
        except:
            pass

    def onSliderReleased(self):
        script = 'import maya.cmds as cmds;cmds.undoInfo( closeChunk=True );'
        executeDeferred( script )
        self.playblast()

    def refresh(self):
        if xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        
        if self.object!="":
            value = de.getAttr(self.object,self.attr)
            self.setValue(value)

        self.sliderChangedEnable = False
        self.uiMin = self.uiMinDefault
        self.uiMax = self.uiMaxDefault
        self.slider.setMaximum(int(self.uiMax*_sliderNumSteps))
        self.slider.setMinimum(int(self.uiMin*_sliderNumSteps))

        self.updateSliderLimits()
        self.slider.setValue( int( (float( self.value() )) * float(_sliderNumSteps) ) )
        self.sliderChangedEnable = True

