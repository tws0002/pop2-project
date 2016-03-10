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
# @file xgExpressionUI.py
# @brief Contains the UI for editing an expression
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
# @version Created 06/30/09
#
import shiboken
import string
import os
import ctypes
import platform
import weakref
from PySide import QtGui, QtCore
from PySide.QtCore import Qt
import xgenm as xg
import xgenm.xgGlobal as xgg
import xgenm.xmaya.xgmExternalAPI as xgmExternalAPI
from xgenm.ui.util.xgUtil import *
from xgenm.ui.XgExprEditor import XgExprEditor
from xgenm.ui.widgets.xgFileBrowserUI import *
from xgenm.ui.dialogs.xgCreateMaps import createMap
from xgenm.ui.widgets.xgFloatUI import Slider
from xgenm.ui.widgets.xgFloatUI import _sliderNumSteps
from xgenm.ui.widgets.xgFloatUI import _sliderSingleSteps
from xgenm.ui.widgets.xgFloatUI import _sliderPageSteps
from xgenm.ui.xgSetMapAttr import getMapExprStrings

from sys import getrefcount


import maya.cmds as cmds
import maya.mel as mel
import maya.OpenMaya as om

_userExprMenu = None
_currentExpr = None

class MayaAttr():
    def __del__(self):
        try:
            self.removeNotif()
        except:
            pass 
        pass
    def __init__(self,parent, exprUI,object,attr, strLabel, patchFunc):
        self.parent = weakref.proxy(parent) if parent else None
        self.exprUI = weakref.proxy(exprUI) if exprUI else None
        self.object = object 
        self.attr = attr + '_' + strLabel; 
        self.strLabel = strLabel 
        self.initialize()
        self.patchFunc = patchFunc

    def initialize(self):
        self.desc = ''
        self.mayaAttrName = ''
        self.previousValue = ''        

    def getJobNumber(self,jobIn,jobType,attrName):
        jobNumber=-1
        if cmds.scriptJob( exists=jobIn ):
            return jobIn

        jobs = cmds.scriptJob( listJobs=True )
        try: 
            for job in jobs:
                if job.find( jobType )!=-1 and job.find( attrName ) !=-1:
                    jobComps = job.split(':')    
                    if len(jobComps) >1:
                        address = str("0x%0.16X" % id(self.exprUI))
                        pos = jobComps[1].find(" at ")
                        prevAddress = jobComps[1][pos+4:pos+22]
                        if( address == prevAddress ):
                            jobNumber = int(jobComps[0])
                            break
        except:                            
            print maya.stringTable['y_xgExpressionUI.kExprUIFailedToParseJobs' ]

        return jobNumber                      

    def enableNotif(self):
        attrFullName = self.desc+"."+self.mayaAttrName
        self.exprUI.jobNumAttributeChange[attrFullName] = self.getJobNumber( self.exprUI.jobNumAttributeChange[attrFullName], "attributeChange", attrFullName )
        if self.exprUI.jobNumAttributeChange[attrFullName] == -1:
            self.exprUI.jobNumAttributeChange[attrFullName] = cmds.scriptJob( attributeChange=[attrFullName,self.exprUI.refresh], killWithScene=True ) 

        self.exprUI.jobNumConnectionChange[attrFullName] = self.getJobNumber( self.exprUI.jobNumConnectionChange[attrFullName], "connectionChange", attrFullName )
        if self.exprUI.jobNumConnectionChange[attrFullName] == -1:
            self.exprUI.jobNumConnectionChange[attrFullName] = cmds.scriptJob( connectionChange=[attrFullName,self.exprUI.forceRefresh], killWithScene=True ) 

    def removeNotif(self):
        attrFullName = self.desc+"."+self.mayaAttrName
        jobNumAttrChange = self.exprUI.jobNumAttributeChange[attrFullName]
        if cmds.scriptJob(exists=jobNumAttrChange):
            cmds.scriptJob( kill=jobNumAttrChange, force=True)
        self.exprUI.jobNumAttributeChange[attrFullName] = -1

        jobNumConnectChange = self.exprUI.jobNumConnectionChange[attrFullName]
        if cmds.scriptJob(exists=jobNumConnectChange): 
            cmds.scriptJob( kill=jobNumConnectChange, force=True)
        self.exprUI.jobNumConnectionChange[attrFullName] = -1

    def isValid(self):
        return self.patchFunc != '' and cmds.attributeQuery( self.mayaAttrName, exists=True, node=self.desc )

    def hasAnimation(self):
        listConnect = None
        if self.isValid():
            listConnect = cmds.listConnections( self.desc+"."+self.mayaAttrName, s=True, d=False, t="animCurve")
        return listConnect is not None

    def hasExpression(self):
        listConnect = None
        if self.isValid():
            listConnect = cmds.listConnections( self.desc+"."+self.mayaAttrName, s=True, d=False, t="expression")
        return listConnect is not None

    def setAttr(self, val):
        if float(self.getAttr()) == val:
           return False
        
        self.removeNotif()
        cmds.setAttr( self.desc+"."+self.mayaAttrName, val )
        self.enableNotif()
        return True

    def getAttr(self):
        return cmds.getAttr(self.desc+"."+self.mayaAttrName)

    #*****Menu callbacks *******#
    def openExprEdit(self):
        if not self.isValid():        
            self.create()

        if self.isValid():        
            cmd = 'expressionEditor EE "'+self.desc+'" "'+self.mayaAttrName+'"';
            mel.eval(cmd)

    def deleteExpr(self):
        listConnect = cmds.listConnections( self.desc+"."+self.mayaAttrName, s=True, d=False, t="expression")
        if listConnect is not None:
            for inputNode in listConnect:
                cmds.delete(inputNode)
        self.destroy()

    def setKey(self):
        if not self.isValid():        
            self.create()
        
        if self.isValid():        
            cmds.select( self.desc+"."+self.mayaAttrName, r=True )
            cmds.setKeyframe( self.desc+"."+self.mayaAttrName )                        

    def breakConnection(self):        
        listConnect = cmds.listConnections( self.desc+"."+self.mayaAttrName, s=True, d=False, p=True, t="animCurveTU")
        if listConnect is not None:
            for inputPlug in listConnect:
                cmds.disconnectAttr( inputPlug, self.desc+"."+self.mayaAttrName )
        self.destroy()

    def destroy(self):
        self.parent.replaceByPatch( self.strLabel, 1 )
        self.patchFunc = ''
        self.removeNotif()
        self.exprUI.refresh()
        desc = currentDescription()
        if cmds.attributeQuery( self.mayaAttrName, exists=True, node=self.desc ): 
            cmds.deleteAttr( desc, at=self.mayaAttrName )

        patches = xg.descriptionPatches(self.desc)
        for patch in patches:
            cmd = 'xgmPatchInfo -p "'+patch+'" -g';
            geom = mel.eval(cmd)
            cmd = 'listRelatives -s "'+geom+'"';
            shapes = mel.eval(cmd)
            cmds.select( shapes[0] )
            if cmds.attributeQuery( self.mayaAttrName, exists=True, node=shapes[0] ): 
                exprList = cmds.listConnections( shapes[0]+"."+self.mayaAttrName, s=True, d=False, t="expression")
                if exprList:
                    cmds.delete( exprList )
                cmds.deleteAttr( shapes[0], at=self.mayaAttrName )



    def create(self):        
        #palette = currentPalette()
        desc = currentDescription()
        #self.desc = palette+"|"+desc
        self.desc = desc
        self.mayaAttrName = "xgen_" + xgmExternalAPI.encodeNameSpace(desc) + "_" + self.attr
        self.mayaAttrName = re.sub('[\[\]]', '_', self.mayaAttrName)
        # Save the original selection list so that we can restore later
        selOrig = cmds.ls( selection=True )
        
        try:
            val = 1 
            vec3 = 0 #TODO: support vector3
            attrCreated = False
            cmds.select( self.desc )
            if vec3 == 0: 
                if cmds.attributeQuery( self.mayaAttrName, exists=True, node=self.desc ) == 0: 
                    cmds.addAttr( longName=self.mayaAttrName, attributeType='double' )
                    cmds.setAttr( self.desc+"."+self.mayaAttrName, val, keyable=True )
                    attrCreated = True
            else:
                if cmds.attributeQuery( self.mayaAttrName, exists=True, node=self.desc ) == 0: 
                    cmds.addAttr( longName=self.mayaAttrName, attributeType='double3' )
                    cmds.addAttr( longName=self.mayaAttrName+"X", attributeType='double', parent=self.mayaAttrName )
                    cmds.addAttr( longName=self.mayaAttrName+"Y", attributeType='double', parent=self.mayaAttrName )
                    cmds.addAttr( longName=self.mayaAttrName+"Z", attributeType='double', parent=self.mayaAttrName )
                    attrCreated = True
                cmds.setAttr( self.desc+"."+self.mayaAttrName, 0, 0, 0, type="double3" )
                cmds.setAttr( self.desc+"."+self.mayaAttrName+"X", keyable=True )
                cmds.setAttr( self.desc+"."+self.mayaAttrName+"Y", keyable=True )
                cmds.setAttr( self.desc+"."+self.mayaAttrName+"Z", keyable=True )
            
            try:
                value = self.exprUI.jobNumAttributeChange[self.desc+"."+self.mayaAttrName]
                value = self.exprUI.jobNumConnectionChange[self.desc+"."+self.mayaAttrName]
            except:
                # Key is not present
                self.exprUI.jobNumAttributeChange[self.desc+"."+self.mayaAttrName] = -1
                self.exprUI.jobNumConnectionChange[self.desc+"."+self.mayaAttrName] = -1                                
                pass                

                
            patches = xg.descriptionPatches(self.desc)
            for patch in patches:
                cmd = 'xgmPatchInfo -p "'+patch+'" -g';
                geom = mel.eval(cmd)
                cmd = 'listRelatives -s "'+geom+'"';
                shapes = mel.eval(cmd)
                cmds.select( shapes[0] )
                if vec3  == 0: 
                    if cmds.attributeQuery( self.mayaAttrName, exists=True, node=shapes[0] ) == 0: 
                        cmds.addAttr( longName=self.mayaAttrName, attributeType='double' )              
                        cmds.setAttr( shapes[0]+"."+self.mayaAttrName, keyable=True )

                    exprList = cmds.listConnections( shapes[0]+"."+self.mayaAttrName, s=True, d=False, t="expression")
                    if exprList is None:
                        exp = shapes[0]+"."+self.mayaAttrName+" = "+self.desc+"."+self.mayaAttrName
                        cmds.expression( s=exp, o=shapes[0], ae=1, uc=all  )                
                else:
                    if cmds.attributeQuery( self.mayaAttrName, exists=True, node=shapes[0] ) == 0: 
                        cmds.addAttr( longName=self.mayaAttrName, attributeType='double3' )
                        cmds.addAttr( longName=self.mayaAttrName+"X", attributeType='double', parent=self.mayaAttrName )
                        cmds.addAttr( longName=self.mayaAttrName+"Y", attributeType='double', parent=self.mayaAttrName )
                        cmds.addAttr( longName=self.mayaAttrName+"Z", attributeType='double', parent=self.mayaAttrName )
                    cmds.setAttr( shapes[0]+"."+self.mayaAttrName, val, val, val, type="double3" )
                    cmds.setAttr( shapes[0]+"."+self.mayaAttrName+"X", keyable=True )
                    cmds.setAttr( shapes[0]+"."+self.mayaAttrName+"Y", keyable=True )
                    cmds.setAttr( shapes[0]+"."+self.mayaAttrName+"Z", keyable=True )
                    
            if not self.isValid():
                self.patchFunc = "patchAttr(\""+ self.mayaAttrName + "\")"
                self.parent.replaceByPatch(self.patchFunc, 0)       
                self.enableNotif()
        except:
            xg.XGError( maya.stringTable['y_xgExpressionUI.kExprUIErrCreatingAttrNamed' ] + self.mayaAttrName ) 

        if len(selOrig)!=0:        
            cmds.select( selOrig )
        else:
            cmds.select( clear=True )

    def getMenu(self, event):
        if event.button() == Qt.RightButton:            
            labelmenu = QtGui.QMenu( )
            labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kRefresh'  ], lambda: self.exprUI.refresh())
            if self.hasAnimation() == 0 and self.hasExpression() == 0:
                labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kCreateNewExpression'  ], lambda: self.openExprEdit())
                labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kSetKey'], lambda: self.setKey())
            else:
                if self.hasExpression():
                    labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kEditExpression'  ], lambda: self.openExprEdit()) 
                    labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kDeleteExpression'  ], lambda: self.deleteExpr()) 
                else:
                    labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kSetKey2'  ], lambda: self.setKey())
                    labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kBreakConnection'  ], lambda: self.breakConnection()) 

            labelmenu.exec_(event.globalPos())     

#/***********************************************************************************************************************/
#/***********************************************************************************************************************/
#/***********************************************************************************************************************/
#/***********************************************************************************************************************/

class SliderExpressionUI(QtGui.QWidget):

    def __init__(self,parent,object,attr,strLabel,v,minv,maxv,mode,pos,patchFunc):
        QtGui.QWidget.__init__(self)
        self.parent = parent
        self.object = object
        self.attr = attr
        self.var = strLabel
        self.modepatch = 0 

        self.mayaAttr = MayaAttr( self, parent, object, attr, strLabel, patchFunc )
        if patchFunc != '':
            self.mayaAttr.create()
            self.modepatch = 1
            v = self.mayaAttr.getAttr()
            self.mayaAttr.enableNotif()

        if object == "":
            self.label = QtGui.QLabel(strLabel)
        else:
            self.label = QtGui.QLabel(makeLabel(strLabel))
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label.setIndent(10)
        self.label.mouseReleaseEvent = self.labelmouseReleaseEvent

        self.edit = QtGui.QLineEdit()
        self.edit.setFixedWidth(62)
        self.edit.setFixedHeight(18)
        if self.modepatch:
             if self.mayaAttr.hasAnimation():
                 c = QtGui.QColor()
                 c.setRgb( 222, 114, 122 ) #isKeyed                
                 self.edit.setStyleSheet("QLineEdit { background-color : %s; color : black; }" % c.name() );
             else:
                 if self.mayaAttr.hasExpression():
                     c = QtGui.QColor()
                     c.setRgbF( 0.796, 0.647, 0.945 ) #expr                    
                     self.edit.setStyleSheet("QLineEdit { background-color : %s; color : black; }" % c.name() );

        self.mode = mode
        self.pos = pos
        
        self.slider = Slider(QtCore.Qt.Horizontal)
        self.slider.setFixedHeight(18);
        self.updateSlidersMinMax(minv, maxv)
        
        self.setEditValue( v )
        if self.modepatch == 0:
            self.replaceValue()
        self.setSliderValue( v )
        
        self.setLayout( self.BuildHorizontalLayout() )
        self.connectIt()

    def labelmouseReleaseEvent(self,event):
        self.mayaAttr.getMenu(event)
        QtGui.QLabel.mouseReleaseEvent(self.label,event)
    
    def BuildHorizontalLayout(self):
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.edit)
        layout.addWidget(self.slider)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        return layout
        
    def replaceValue(self):
        if self.object!="":
            de = xgg.DescriptionEditor
            with xg.undoable(self.attr):
                exprString = "(\\$%s+\\s*=\\s*)(-?[\\d.]*);" % self.var
                exprText = de.getAttr(self.object,self.attr)
                oldExprText = exprText
                varValue = self.edit.text() 
                if not self.mode:
                    # float formatting
                    varValue = str('%.4f' % float(varValue) )
                re = QtCore.QRegExp( exprString )
                pos = re.indexIn(exprText, 0)
                if pos >= 0:
                    # replace slider value in text
                    exprText = exprText[:pos+len(re.cap(1))] + str(varValue) + exprText[pos+len(re.cap(1))+len(re.cap(2)):]
            
                if oldExprText != exprText :
                    self.parent.setValue(exprText, False)
        
    def replaceByPatch(self, patchFunc, remove ):
        if self.object!="":
            de = xgg.DescriptionEditor
            exprString = "(\\$%s+\\s*=\\s*)(-?[\\d.]*);" % self.var
            if remove:
                exprString = "(\\$%s+\\s*=\\s*)(patchAttr[(]\\s*\"?(\\w+)\"?\\s*[)]);" % self.var
                patchFunc = self.edit.text()
            exprText = de.getAttr(self.object,self.attr)
            oldExprText = exprText
            re = QtCore.QRegExp( exprString )
            pos = re.indexIn(exprText, 0)
            if pos >= 0:
                # replace slider value in text
                exprText = exprText[:pos+len(re.cap(1))] + patchFunc + exprText[pos+len(re.cap(1))+len(re.cap(2)):]
            
            if oldExprText != exprText :
                self.parent.setValue(exprText, False)
                self.replacePatchValue()                

    def replacePatchValue(self):
        varValue = self.edit.text()
        if self.mayaAttr.setAttr(float(varValue)):
           xgg.DescriptionEditor.playblast()

    def updateSlidersMinMax(self, minv, maxv):
        
        if self.mode:
            self.minv = int(minv)
            self.maxv = int(maxv)
            self.slider.setMinimum( int(self.minv) )
            self.slider.setMaximum( int(self.maxv) )
            self.slider.setPageStep((int(self.maxv)-int(self.minv))/10)
            self.slider.setSingleStep(1)
        else:
            self.minv = float(minv)
            self.maxv = float(maxv)
            self.slider.setMinimum(int(self.minv*_sliderNumSteps))
            self.slider.setMaximum(int(self.maxv*_sliderNumSteps))
            self.slider.setPageStep(_sliderPageSteps)
            self.slider.setSingleStep(_sliderSingleSteps)
        
    def setSliderValue( self, v ):
        
        if self.mode:
            vv = int( v )
        else:
            vv = float( v )
        
        # Update slider min max
        newMin = self.minv
        if vv < self.minv:
            newMin = vv
            
        newMax = self.maxv
        if vv > self.maxv:
            newMax = vv
            
        if newMin!=self.minv or newMax!=self.maxv:
            self.updateSlidersMinMax(newMin,newMax)
        
        if self.mode:
            self.slider.setValue( min(max(0,int(v)-self.minv),self.maxv-self.minv) )
        else:
            self.slider.setValue( min(max(int(self.minv*_sliderNumSteps),int(float(v)*_sliderNumSteps)),int(self.maxv*_sliderNumSteps)) )
            
            
    
    def setEditValue( self, v ):
        if self.mode:
            self.edit.setText( str(int(v)) )
        else:
            self.edit.setText( str('%.4f' % float(v) ) )
        
    def editChanged(self ):
        if self.modepatch and self.mayaAttr.hasExpression():            
            val = self.mayaAttr.getAttr()
            self.setEditValue(float(val))
            return

        if self.modepatch == 0:
            self.replaceValue()
        else:
            self.replacePatchValue()
        self.setSliderValue( self.edit.text() )
        
    def sliderChanged(self, v ):
        if self.modepatch and self.mayaAttr.hasExpression():
            val = self.mayaAttr.getAttr()
            self.setSliderValue(float(val))
            return

        if self.mode:
            self.edit.setText( str( int(v) ) )
        else:
            self.edit.setText( str( float(v)/float(_sliderNumSteps)) )

        if self.modepatch == 0:
            self.replaceValue()
        else:
            self.replacePatchValue()
        
    def connectIt(self):
        if xgg.DescriptionEditor is None:
            return
        self.connect(self.edit,QtCore.SIGNAL("editingFinished()"), self.editChanged )
                     
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
        xgg.DescriptionEditor.playblast()
        
class Callable:
    def __init__(self, anycallable):
        self.__call__ = anycallable


class BakeArgumentsParser:
    def getBakeArguments(self, text, object):
        t = text
        t = t.replace('\\','/')
        tt = t.split('/')
        
        outdir = ""
        colormap = ""
        if len(tt) >= 2:
            outdir = t
            colormap = tt[-1]
            if colormap == "":
                colormap = tt[-2]
                
        elif len(tt) ==1:
            outdir = xg.getAttr("xgDataPath",de.currentPalette())
            colormap = t
        
        if outdir!="" and colormap!="":
            
            if isPathRelative(outdir):
                base = ""
                # the path is relative so either add palette dir or pwd
                if len(object):
                    de = xgg.DescriptionEditor
                    cpal = de.currentPalette()
                    pathStr = xg.getAttr("xgDataPath",cpal)
                    path = pathStr.split(";")
                    base = path[0];
                    if base.startswith('./'):
                        base = currentWorkDir()+base[2:]
                    elif base == '.':
                        base = currentWorkDir()
                else:
                    base = currentWorkDir()

                base = fixFolderPath(base)
                outdir = base + outdir

            # replace and xgen variables
            cdesc = xgg.DescriptionEditor.currentDescription()
            
            paintPrefix = ""
            if len(cdesc):
                if outdir.find( "${DESC}" )!=-1:
                    outdir = outdir.replace("${DESC}", xg.stripNameSpace(cdesc))
                    paintPrefix = cdesc + "_"
            if len(object):
                if outdir.find( "${FXMODULE}" )!=-1:
                    outdir = outdir.replace("${FXMODULE}",object)
                    paintPrefix = object + "_"

            # expand outdir fully
            outdir = xg.expandFilepath( str(outdir), xg.stripNameSpace(cdesc))

            colormap = paintPrefix + colormap
            return [True,outdir,colormap]
        return [False,"",""]

# ptexBaker is static class that wraps scriptJob handlers to export ptex on mouse up
# and also has hooks to start/end a paint session
# It's called from the Expression Editor Paint Button
# Only one paint session can be active at a time. 
class ptexBaker:
    g_Selection = []
    g_ColorMap = ""
    g_OutputDir = ""
    g_Tpu = 15.0
    g_StartJob = -1
    g_StopJob = -1
    g_OriginalMaterial = []
    g_LastContext = ""
    g_Mode = ""
    g_oldToolSolo = 0
    g_oldToolAttr = ""
    g_oldToolUpdate = 0
    g_ShapeAttr = ""
    g_prevSelection = []
    g_paint3dCtx = "art3dPaintContext"
    g_defaultPaint3dCtx = "art3dPaintContext"
    g_xgenAttr = ""

    def pushState():
        args = []
        args.append( ptexBaker.g_Selection )
        args.append( ptexBaker.g_ColorMap )
        args.append( ptexBaker.g_OutputDir )
        args.append( ptexBaker.g_Tpu )
        args.append( ptexBaker.g_OriginalMaterial )
        args.append( ptexBaker.g_LastContext )
        args.append( ptexBaker.g_Mode )
        args.append( ptexBaker.g_ShapeAttr )
        return args
    pushState = Callable(pushState)
        
    def popState( args ):
        ptexBaker.g_Selection = args[0]
        ptexBaker.g_ColorMap = args[1]
        ptexBaker.g_OutputDir = args[2]
        ptexBaker.g_Tpu = args[3]
        ptexBaker.g_OriginalMaterial = args[4]
        ptexBaker.g_LastContext = args[5]
        ptexBaker.g_Mode = args[6]
        ptexBaker.g_ShapeAttr = args[7]
    popState = Callable(popState)

    # Apply a material to the selection or reuse the existing material
    def ApplyPaintMaterial(): 
        
        oldsel = cmds.ls( selection=True )
        
        ptexBaker.g_OriginalMaterial = []
        for curSel in oldsel:
            try:
                shapes = cmds.listRelatives(curSel, s=True)
                shadingGroups = cmds.listConnections( shapes, t="shadingEngine" )
                ptexBaker.g_OriginalMaterial.append( [curSel,shadingGroups] )
            except:
                print maya.stringTable['y_xgExpressionUI.kExprUIErrQuerySelection' ]
            
        if cmds.objExists(ptexBaker.g_ColorMap):
            cmds.sets( e=True, forceElement=ptexBaker.g_ColorMap + "SG" )
            cmds.select( oldsel, r=True )
            return ptexBaker.g_ColorMap
        else:
            outName = cmds.shadingNode( "lambert", asShader=True, name=ptexBaker.g_ColorMap )
            cmds.sets( renderable=True, noSurfaceShader=True, empty=True, name= outName + "SG" )
            cmds.connectAttr( outName + ".outColor", outName + "SG.surfaceShader", f=True )
            cmds.select( oldsel, r=True )
            cmds.sets( e=True, forceElement=outName + "SG" )
            cmds.select( oldsel, r=True )
            return outName
    ApplyPaintMaterial = Callable(ApplyPaintMaterial)
            
    # Reset to original material
    def ResetPaintMaterial(): 
        oldsel = cmds.ls( selection=True )
        for s in ptexBaker.g_OriginalMaterial :
            cmds.select( s[0], r=True )
            cmds.sets( e=True, forceElement=s[1][0] )
        cmds.select( oldsel, r=True )
        ptexBaker.g_OriginalMaterial = []
    ResetPaintMaterial = Callable(ResetPaintMaterial)
    
    def getBoundGeoms():
        if xgg.Maya:
            de = xgg.DescriptionEditor
            cpal = de.currentPalette()
            cdesc = de.currentDescription()
            return xg.boundGeometry(cpal,cdesc)
        return []

    getBoundGeoms = Callable(getBoundGeoms)

    # Stop Painting callback 
    def stop():
        errDoPtexBake = maya.stringTable['y_xgExpressionUI.kExprUIErrDoPtexBake' ]
        if ptexBaker.g_Mode == "3dPaintTool":
            # Get the selected mesh and search for valid file textures for the meshes
            # This could be directly on a file node or on a TripleShadingSwitch node
            for curMesh in ptexBaker.g_Selection:
                try:
                    # get the shape node
                    curShape = cmds.listRelatives( curMesh, shapes=True )[0]

                    # get the file connected to the shape attribute
                    shapeAttr = curShape + "." + ptexBaker.g_ShapeAttr;
                    curFile = cmds.listConnections( shapeAttr, t="file", source=True, destination=False )

                    if curFile != "" and len(curFile) > 0 :
                        cmds.ptexBake( inMesh=curMesh, outPtex=ptexBaker.g_OutputDir, bakeTexture=curFile[0], tpu=ptexBaker.g_Tpu )
                except:
                    print errDoPtexBake
        elif ptexBaker.g_Mode == "ColorPerVertexTool":
            # keep the old selection
            oldsel = cmds.ls( selection=True )
            
            # Get the selected mesh and search for valid file textures for the meshes
            # This could be directly on a file node or on a TripleShadingSwitch node
            for curMesh in ptexBaker.g_Selection:
                try:
                    shapes = cmds.listRelatives(curMesh, s=True)
                    cmds.select( shapes, r=True )
                    currentColorSet = cmds.polyColorSet( query=True, currentColorSet=True )
                    if currentColorSet is not None and len(currentColorSet)==1:
                        if currentColorSet[0] == ptexBaker.g_ColorMap:
                            cmds.ptexBake( inMesh=curMesh, outPtex=ptexBaker.g_OutputDir, bakeColorSet=ptexBaker.g_ColorMap ) 
                except:
                    print errDoPtexBake
                    
            # Put back the old selection
            cmds.select( oldsel, r=True )
        xgg.DescriptionEditor.playblast()
    stop = Callable(stop)
    
    # Start Painting callback 
    def start():
        pass#xgg.DescriptionEditor.preview(True)
    start = Callable(start)
        
    # Start the callback jobs
    def startJobs():
        ptexBaker.killJobs()

        # these callbacks reset the tool and ptexBaker states when the tool is exited.
        if ptexBaker.g_Mode == "ColorPerVertexTool":
            ptexBaker.g_StartJob = cmds.scriptJob( runOnce=True, event=['ToolChanged', ptexBaker.stopVertexColorPaint] )
        elif ptexBaker.g_Mode == "3dPaintTool":
            ptexBaker.g_StartJob = cmds.scriptJob( runOnce=True, event=['ToolChanged', ptexBaker.resetPaintTool] )
    startJobs = Callable(startJobs)
    
    # Kill the callback jobs
    def killJobs():
        if ptexBaker.g_StartJob!=-1:
            try:
                cmds.scriptJob( kill=ptexBaker.g_StartJob )
            except:
                pass
            ptexBaker.g_StartJob = -1
        
        if ptexBaker.g_StopJob!=-1:
            try:
                cmds.scriptJob( kill=ptexBaker.g_StopJob )
            except:
                pass
            ptexBaker.g_StopJob = -1
    killJobs = Callable(killJobs)

    # Start a painting session, switching to Paint Material, switching to PaintTool and activating the scriptjob callbacks
    def start3dPaint( colormap, outDir, tpu, defaultValue, shapeAttr, xgenAttr, paint3dCtx="" ):
        # if we are already painting, stop it first.
        if ptexBaker.g_Mode == "ColorPerVertexTool" :
            ptexBaker.stopVertexColorPaint()
        elif ptexBaker.g_Mode == "3dPaintTool":
            ptexBaker.stop3dPaint()

        ptexBaker.g_Mode = "3dPaintTool" 
        ptexBaker.g_ColorMap = colormap
        ptexBaker.g_OutputDir = outDir
        ptexBaker.g_Tpu = tpu
        ptexBaker.g_Selection = ptexBaker.getBoundGeoms()
        ptexBaker.g_LastContext = cmds.currentCtx()
        ptexBaker.g_prevSelection = cmds.ls( selection=True )
        ptexBaker.g_xgenAttr = xgenAttr
        if paint3dCtx == "":
            paint3dCtx = ptexBaker.g_defaultPaint3dCtx

        ptexBaker.g_paint3dCtx = paint3dCtx
        ptexBaker.createUVs()

        ptexBaker.g_ShapeAttr = xgmExternalAPI.createMayaAttr( defaultValue, shapeAttr )
        ptexBaker.setupPaintTool( ptexBaker.g_ShapeAttr )
        ptexBaker.startJobs()

    start3dPaint = Callable(start3dPaint)
    
    # Stop the Painting Session, switching back to original material, to previous tool context and killing the scriptjob callbacks    
    def stop3dPaint():
        ptexBaker.g_Selection = []
        ptexBaker.g_prevSelection = []
        ptexBaker.killJobs()
        ptexBaker.g_Mode = ""
        ptexBaker.g_xgenAttr = ""
        ptexBaker.g_paint3dCtx = ptexBaker.g_defaultPaint3dCtx

        if( len(ptexBaker.g_prevSelection) > 0 ):
            cmds.select( ptexBaker.g_prevSelection, replace=True )
        else:
            cmds.select( clear=True )

    stop3dPaint = Callable(stop3dPaint)
    
    # Save a colormap without activating the paint tool or jobs
    def save3dPaint(colormap, outDir, tpu, attrName ):
        state = ptexBaker.pushState()
        ptexBaker.g_Mode = "3dPaintTool" 
        ptexBaker.g_ColorMap = colormap
        ptexBaker.g_OutputDir = outDir
        ptexBaker.g_Tpu = tpu
        ptexBaker.g_Selection = ptexBaker.getBoundGeoms()
        ptexBaker.g_ShapeAttr = xgmExternalAPI.mayaShapeAttrName( attrName )
        ptexBaker.stop()
        ptexBaker.popState(state)
    save3dPaint = Callable(save3dPaint)
    
    # Start a painting session, switching to Paint Material, switching to PaintTool and activating the scriptjob callbacks
    def startVertexColorPaint( colormap, outDir  ):

        # if we are already painting, stop it first.
        if ptexBaker.g_Mode == "ColorPerVertexTool" :
            ptexBaker.stopVertexColorPaint()
        elif ptexBaker.g_Mode == "3dPaintTool":
            ptexBaker.stop3dPaint()

        ptexBaker.g_Mode = "ColorPerVertexTool" 
        ptexBaker.g_ColorMap = colormap
        ptexBaker.g_OutputDir = outDir
        ptexBaker.g_Tpu = 1.0
        ptexBaker.g_Selection = ptexBaker.getBoundGeoms()
        ptexBaker.g_prevSelection = cmds.ls( selection=True )
        ptexBaker.g_LastContext = cmds.currentCtx()
        
        # Select all faces/geoms in this description
        if len(ptexBaker.g_Selection) > 0:
            cmds.select( ptexBaker.g_Selection, replace=True )

        # create the color set on the selected geoms
        allColorSets = cmds.polyColorSet( query=True, allColorSets=True )
        if (allColorSets is None) or (ptexBaker.g_ColorMap not in allColorSets):
            cmds.polyColorSet(create=True, colorSet=ptexBaker.g_ColorMap)
        cmds.polyColorSet(currentColorSet=True, colorSet=ptexBaker.g_ColorMap)
        
        cmds.PaintVertexColorTool()
        ptexBaker.startJobs()
    startVertexColorPaint = Callable(startVertexColorPaint)
    
    # Stop the Painting Session, switching back to original material, to previous tool context and killing the scriptjob callbacks    
    def stopVertexColorPaint():        
        # Select all faces/geoms in this description
        if len(ptexBaker.g_Selection) > 0 :
            try:
                cmds.select( ptexBaker.g_Selection, replace=True )

                # turn off displaying vertex colors for those objects
                mel.eval( "toggleShadeMode()" )
            except ValueError:
                pass

        # restore selection to whatever it was before activating the tool
        try:
            if len( ptexBaker.g_prevSelection ) > 0:
                cmds.select( ptexBaker.g_prevSelection, r=True )
            else:
                cmds.select( clear=True )
        except ValueError:
            pass

        ptexBaker.g_Mode = ""
        ptexBaker.g_Selection = []
        ptexBaker.g_prevSelection = []
        
        ptexBaker.killJobs()
    stopVertexColorPaint = Callable(stopVertexColorPaint)
    
    # Save a colormap without activating the paint tool or jobs
    def saveVertexColorPaint(colormap, outDir ):
        state = ptexBaker.pushState()
        ptexBaker.g_Mode = "ColorPerVertexTool"
        ptexBaker.g_ColorMap = colormap
        ptexBaker.g_OutputDir = outDir
        ptexBaker.g_Tpu = 1.0
        ptexBaker.g_Selection = cmds.ls( selection=True )
        ptexBaker.stop()
        ptexBaker.popState(state)
    saveVertexColorPaint = Callable(saveVertexColorPaint)

    def setupPaintTool( shapeAttrName ):
        if not xgg.Maya:
            return

        # Select all faces/geoms in this description
        if len(ptexBaker.g_Selection) > 0:
            cmds.select( ptexBaker.g_Selection, replace=True )

        try:
            # make sure the specified paint context exists. (It should be already!)
            # (See xgenInit3dPaintCtx for where xgen contexts get defined)
            if not cmds.art3dPaintCtx( ptexBaker.g_paint3dCtx, exists=True ):
                cmds.art3dPaintCtx( ptexBaker.g_paint3dCtx, i1="art3dPaint.png" )

            cmds.setToolTo( ptexBaker.g_paint3dCtx )

            # save these tool values, we'll restore them later.
            g_oldToolSolo = cmds.art3dPaintCtx( cmds.currentCtx(), query=True, soloAsDiffuse=True );
            g_oldToolAttr = cmds.art3dPaintCtx( cmds.currentCtx(), query=True, painttxtattr=True );
            g_oldToolUpdate = cmds.art3dPaintCtx( cmds.currentCtx(), query=True, saveonstroke=True );

            # configure the tool to paint on our attribute, in solo'ed mode. 
            # The order here is important. the shapeattr flag needs to come before
            # the attrname, otherwise the tool will look for the attr on the shader.
            cmds.art3dPaintCtx( cmds.currentCtx(), edit=True, shapeattr=1 )
            cmds.art3dPaintCtx( cmds.currentCtx(), edit=True, painttxtattr=shapeAttrName )
            cmds.art3dPaintCtx( cmds.currentCtx(), edit=True, soloAsDiffuse=True )
            cmds.art3dPaintCtx( cmds.currentCtx(), edit=True, saveonstroke=True )

            # TODO: Should be controlled by TPU setting eventually. 
            # Must take into account shell border bleed though.
            cmds.art3dPaintCtx( cmds.currentCtx(), edit=True, fty=1024, ftx=1024, fsy=1024, fsx=1024 )

            # call art3dPaintAssignFileTextures to assign new file textures if needed.
            maya.mel.eval( "art3dPaintAssignFileTextures " + shapeAttrName )

            # signal to the context that the texture connections have changed.
            cmds.art3dPaintCtx( cmds.currentCtx(), edit=True, assigntxt=1 )
            cmds.setToolTo( ptexBaker.g_paint3dCtx )

        except RuntimeError:
            xg.XGError( maya.stringTable['y_xgExpressionUI.kPaintError'] )

    setupPaintTool = Callable(setupPaintTool)

    def resetPaintTool():
        if( cmds.art3dPaintCtx( "art3dPaintContext", exists=True ) ):
            try:
                cmds.art3dPaintCtx( "art3dPaintContext", edit=True, shapeattr=0 )
                cmds.art3dPaintCtx( "art3dPaintContext", edit=True, painttxtattr=ptexBaker.g_oldToolAttr )
                cmds.art3dPaintCtx( "art3dPaintContext", edit=True, soloAsDiffuse=ptexBaker.g_oldToolSolo )
                cmds.art3dPaintCtx( "art3dPaintContext", edit=True, saveonstroke=ptexBaker.g_oldToolUpdate )
                ptexBaker.stop3dPaint() # make sure the tool properly stops when exiting the tool
            except RuntimeError:
                # Changing the shapeattr/painttxtattr settings here can cause MEL warnings because
                # sometimes the old attributes to paint aren't connected to any file textures.
                # These harmless warnings cause runtime errors in python, so be sure to catch them here.
                pass
    resetPaintTool = Callable(resetPaintTool)

    def createUVs():
        if not xgg.Maya:
            return

        cpal = xgg.DescriptionEditor.currentPalette()
        cdesc = xgg.DescriptionEditor.currentDescription()

        # for each shape, create uvs if needed.
        geoms = xg.boundGeometry(cpal,cdesc)
        for geom in geoms:
            try:
                selectionList = maya.OpenMaya.MSelectionList()
                selectionList.add(geom)
                dagPath = maya.OpenMaya.MDagPath()
                selectionList.getDagPath(0, dagPath)
                myMesh = maya.OpenMaya.MFnMesh(dagPath)
                if myMesh.numUVs() == 0:
                    cmds.createPtexUV( inMesh=geom )
            except RuntimeError:
                pass

    createUVs = Callable(createUVs)

class MapExpressionUI(QtGui.QWidget):

    def __init__(self,parent,object,attr,strLabel,file,mode,pos,defaultValue,paintOn=False,mapcolor="basedOnAttribute",customAttr="",isBrowseMode=False,paint3dCtx=""):
        QtGui.QWidget.__init__(self)
        self.parent = weakref.proxy(parent) if parent else None
        self.object = object
        self.attr = attr
        self.defaultValue = defaultValue
        self.var = strLabel
        self.paint3dCtx = paint3dCtx

        if object == "":
            self.label = QtGui.QLabel(strLabel)
        else:
            self.label = QtGui.QLabel(makeLabel(strLabel))
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label.setIndent(10)
        self.edit = QtGui.QLineEdit()
        self.edit.setFixedHeight(18)
        self.defaultColor = mapcolor
        self.customAttr = customAttr
        self.isBrowseMode = isBrowseMode

        self.tpu = 1.0
        paintIcon = ""
        if mode[ : len("3dpaint,") ] == "3dpaint,":
            self.prefix = maya.stringTable[ 'y_xgExpressionUI.kPaintableTextureMap'  ]
            self.tpu = float( mode[len("3dpaint,"):] )
            self.mode = "3dpaint"
            paintIcon = xg.iconDir()+"xg3dPaint.png"
        elif mode[ : len("vpaint") ] == "vpaint":
            self.prefix = maya.stringTable[ 'y_xgExpressionUI.kPaintableVertexColorMap'  ]
            self.mode = "vpaint"
            paintIcon = xg.iconDir()+"xgVPaint.png"
        else:
            self.prefix = maya.stringTable[ 'y_xgExpressionUI.kPtexMap'  ]
            self.mode = "file"
            
        self.edit.setToolTip( self.prefix % maya.stringTable[ 'y_xgExpressionUI.kPtexFilePath'  ])
        
        self.pos = pos
        
        self.optionButton = QtGui.QToolButton()
        self.optionButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgBrowse.png"))
        self.optionButton.setToolTip(self.prefix % maya.stringTable[ 'y_xgExpressionUI.kRaiseFileBrowser'  ])

        # arrow menu
        if self.isBrowseMode:
            self.optionButton.setAutoRaise(True)
            self.optionButton.setPopupMode(QtGui.QToolButton.MenuButtonPopup)
            # Warning: override the mousePressEvent for the toolButton
            self.optionButton.mousePressEvent = self.updateOwner
            self.menu = QtGui.QMenu()
            self.menu.addAction(maya.stringTable[ 'y_xgExpressionUI.kCreateMap'  ],lambda: self.parent.callCreateMap(self.parent.browseMode))
            self.optionButton.setMenu(self.menu)
            # dont need two browse buttons
            self.parent.optionButton.hide()
        
        self.paintButton = QtGui.QToolButton()
        self.paintButton.setIcon(QtGui.QIcon(paintIcon))
        self.paintButton.setFixedSize(24,24)
        self.paintButton.setToolTip(self.prefix % maya.stringTable[ 'y_xgExpressionUI.kStartPaintingOnSelectedMeshes'  ])
        
        self.saveButton = QtGui.QToolButton()
        self.saveButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgSave.png"))
        self.saveButton.setFixedSize(24,24)
        self.saveButton.setToolTip(self.prefix % maya.stringTable[ 'y_xgExpressionUI.kBakeThePtexMapsToDisk'  ])
        
        self.setEditValue( file )
        
        self.setLayout( self.BuildHorizontalLayout() )
        self.connectIt()

        if paintOn:
            self.paint()
        
    def BuildHorizontalLayout(self):
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.edit)
        if self.mode == "3dpaint" or self.mode == "vpaint":
            layout.addWidget(self.paintButton)
            layout.addWidget(self.saveButton)
        layout.addWidget(self.optionButton)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        return layout

    def updateOwner(self,event):
        global _currentExpr
        _currentExpr = self
        QtGui.QToolButton.mousePressEvent(self.optionButton,event)
        
    def replaceValue(self):
        de = xgg.DescriptionEditor
        if self.isBrowseMode:
            value = self.edit.text()
            self.parent.setValue(value, False)
            # Set the custom attr
            descPos = value.find("${DESC}")
            if descPos != -1:
                self.customAttr = value[descPos+len("${DESC}")+1:]
                if ptexBaker.g_Mode != "":
                    cmds.select( clear=True )
            return
                                
        if self.object!="":
            mapExpr = "map"
            if self.mode == "vpaint":
                mapExpr = "vmap"

            exprString = "(\\$"+self.var+"+\\s*=\\s*"+mapExpr+"\\([\"\'])([\\w${}\\-\\\\/]+)[\"\']\);"
            exprText = de.getAttr(self.object,self.attr)
            oldExprText = exprText
            varValue = self.edit.text().replace('\\','/')
            re = QtCore.QRegExp( exprString )
            pos = re.indexIn(exprText, 0)
            if pos >= 0:
                # replace slider value in text
                exprText = exprText[:pos+len(re.cap(1))] + str(varValue) + exprText[pos+len(re.cap(1))+len(re.cap(2)):]
            
            if oldExprText != exprText :

                # if a paintmap is being replaced, make sure the correct attr will be used to paint
                paintmapPos = exprText.find("paintmaps")
                if paintmapPos != -1:
                    self.customAttr = exprText[paintmapPos+len("paintmaps")+1:exprText.find("');")]
                    if ptexBaker.g_Mode != "":
                        cmds.select( clear=True )

                self.parent.setValue(exprText, False)
        
    def setEditValue( self, v ):
        self.edit.setText( str(v) )
        
    def editChanged(self ):
        self.replaceValue()
        
    def getBakeArguments(self):
        parser = BakeArgumentsParser()
        return parser.getBakeArguments( self.edit.text(), self.object )
        
    # Save Button Callback
    def save(self):
        args = self.getBakeArguments()
        if args[0]:
            if self.mode == "3dpaint":
                if self.customAttr == "":
                    ptexBaker.save3dPaint( args[2], args[1], self.tpu, self.attr )
                else:
                    ptexBaker.save3dPaint( args[2], args[1], self.tpu, self.customAttr )
            elif self.mode == "vpaint":
                ptexBaker.saveVertexColorPaint( args[2], args[1] )
                
    # Paint Button Callback
    def paint(self):
        if ptexBaker.g_Mode != "":
            cmds.select( clear=True )
        args = self.getBakeArguments()
        if args[0]:
            if self.mode == "3dpaint":
                if self.customAttr == "":
                    ptexBaker.start3dPaint( args[2], args[1], self.tpu, self.defaultValue, self.attr, self.attr, self.paint3dCtx )
                else:
                    ptexBaker.start3dPaint( args[2], args[1], self.tpu, self.defaultValue, self.customAttr, self.attr, self.paint3dCtx )
            elif self.mode == "vpaint":
                ptexBaker.startVertexColorPaint( args[2], args[1] )

    def fileBrowser(self):
        # Get setup with a full path given users input value
        base = ""
        startDir = str(self.edit.text())
        if isPathRelative(startDir):
            # the path is relative so either add palette dir or pwd
            if len(self.object):
                de = xgg.DescriptionEditor
                cpal = de.currentPalette()
                pathStr = xg.getAttr("xgDataPath",cpal)
                path = pathStr.split(";")
                base = path[0];
                if base.startswith('./'):
                    base = currentWorkDir()+base[2:]
                elif base == '.':
                    base = currentWorkDir()
            else:
                base = currentWorkDir()
            startDir = fixFolderPath(base) + startDir

        # replace and xgen variables
        cdesc = xgg.DescriptionEditor.currentDescription()

        # expand start dir fully
        startDir = xg.expandFilepath( startDir, cdesc )
        base = xg.expandFilepath( base, cdesc )
       
        # bring up the browswer dialog windowgetBakeArguments
        selectedFile = fileBrowserDlg(self,startDir)

        # remove relativity
        endValue = selectedFile[-1:]
        if endValue == '/':
            selectedFile = selectedFile[:-1]
        
        # set the result and attribute
        if len(selectedFile):
            # strip off the base to get back to relative
            if len(base)>1:  # avoid calling replace if the base is something weird like slash
                selectedFile = selectedFile.replace(base,'',1)
            # put back the variables
            if len(self.object):
                if len(cdesc):
                    selectedFile = selectedFile.replace(cdesc,"${DESC}")
                selectedFile = selectedFile.replace(self.object,"${FXMODULE}")

            # do not allow non-correct folders to be chosen by the user
            if selectedFile.find("${DESC}") == -1 and self.isBrowseMode:
                xg.XGError(maya.stringTable[ 'y_xgExpressionUI.kFolderInDescError'  ])
                return

            # set the value in ui and xgen
            self.setEditValue(selectedFile)
            self.replaceValue()
            
    def connectIt(self):
        if xgg.DescriptionEditor is None:
            return
        self.connect(self.optionButton, QtCore.SIGNAL("clicked()"), self.fileBrowser)
        self.connect(self.paintButton, QtCore.SIGNAL("clicked()"), self.paint)
        self.connect(self.saveButton, QtCore.SIGNAL("clicked()"), self.save)
        self.connect(self.edit,QtCore.SIGNAL("editingFinished()"), self.editChanged )

class QClickableFrame( QtGui.QFrame ):
    clicked = QtCore.Signal()
    
    def __init__(self):
        self.button = 0
        super( QClickableFrame, self ).__init__()
        
    def mousePressEvent(self,e):
        self.button = e.button()
        self.clicked.emit()

class ColorExpressionUI(QtGui.QWidget):

    def __init__(self,parent,object,attr,strLabel,mode,r,g,b,pos,printableName=""):
        QtGui.QWidget.__init__(self)
        self.setAttribute( QtCore.Qt.WidgetAttribute.WA_NativeWindow ) # This will allow the widget to return a valid WId() for itself.
        self.parent = weakref.proxy(parent) if parent else None
        self.object = object
        self.attr = attr
        self.var = strLabel
        self.mode = mode
        if printableName != "":
            self.label = QtGui.QLabel(printableName)
        elif object == "":
            self.label = QtGui.QLabel(strLabel)
        else:
            self.label = QtGui.QLabel(makeLabel(strLabel))
            
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label.setIndent(10)
        self.pos = pos
        self.r = float(r)
        self.g = float(g)
        self.b = float(b)
        
        self.color = QClickableFrame()
        self.color.setFixedWidth(58)
        self.color.setFixedHeight(13)
        self.updateColor(False, True)
        
        self.slider = Slider(QtCore.Qt.Horizontal)
        self.slider.setMinimum(int(0*_sliderNumSteps))
        self.slider.setMaximum(int(1*_sliderNumSteps))
        self.slider.setPageStep(_sliderPageSteps)
        self.slider.setSingleStep(_sliderSingleSteps)
        
        self.slider.setFixedHeight(18);
        self.updateColor(True, False)
        
        self.setLayout( self.BuildHorizontalLayout() )
        self.connectIt()
        
    def updateColor( self, bSlider, bColor ):
        c = QtGui.QColor.fromRgbF( max(0,min(float(self.r),1)),max(0,min(float(self.g),1)),max(0,min(float(self.b),1)) )
        
        if bColor:
            self.color.setStyleSheet( "QFrame { background-color: %s }" % c.name() )
        
        if bSlider:
            if self.mode == 'hsvhue':
                self.slider.setValue( c.hsvHueF()*_sliderNumSteps )
            elif self.mode == 'hsvsaturation':
                self.slider.setValue( c.hsvSaturationF()*_sliderNumSteps )
            elif self.mode == 'hslhue':
                self.slider.setValue( c.hslHueF()*_sliderNumSteps )
            elif self.mode == 'hslsaturation':
                self.slider.setValue( c.hslSaturationF()*_sliderNumSteps )
            elif self.mode == 'hsllightness':
                self.slider.setValue( c.lightnessF()*_sliderNumSteps )
            else:
                self.slider.setValue( c.valueF()*_sliderNumSteps )
        
    def BuildHorizontalLayout(self):
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.color)
        layout.addWidget(self.slider)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        return layout
        
        
    def replaceValue(self):
        if self.object!="":
            de = xgg.DescriptionEditor
            exprString = "(\\$%s+\\s*=\\s*)\[(-?[\\d.]*,-?[\\d.]*,-?[\\d.]*)\];" % self.var
            exprText = de.getAttr(self.object,self.attr)
            oldExprText = exprText
            re = QtCore.QRegExp( exprString )
            pos = re.indexIn(exprText, 0)
            if pos >= 0:
                varValue = "[" + str(self.r) + "," + str(self.g) + "," + str(self.b) + "]"
                lenCapXYZ = len(re.cap(2)) + 1 + len(re.cap(3)) + 1 + len(re.cap(4))
                # replace slider value in text
                exprText = exprText[:pos+len(re.cap(1))] + str(varValue) + exprText[pos+len(re.cap(1))+lenCapXYZ:]
                
            if oldExprText != exprText :
                self.parent.setValue(exprText, False)
        
    def colorChanged(self):
        pc = self.mapToGlobal( self.color.rect().center() )
        if xgg.Maya:
            if self.color.button==QtCore.Qt.MouseButton.LeftButton:
                cmds.colorEditor( rgbValue=[self.r,self.g,self.b], mini=True, pos=[pc.x()-424/2,pc.y()-178/2] )
            else:
                cmds.colorEditor( rgbValue=[self.r,self.g,self.b], pos=[pc.x(),pc.y()] )
            
            if cmds.colorEditor( query=True, result=True ):
                rgb = cmds.colorEditor( query=True, rgb=True )
                self.r = rgb[0]
                self.g = rgb[1]
                self.b = rgb[2]
                self.replaceValue()
                self.updateColor(True,True)
        
    def sliderChanged(self, v ):
        c = QtGui.QColor.fromRgbF( max(0,min(float(self.r),1)),max(0,min(float(self.g),1)),max(0,min(float(self.b),1)) )
        
        if self.mode == 'hsvhue':
            c.setHsvF( max(0,min(float(self.slider.value())/float(_sliderNumSteps),1)), c.hsvSaturationF(), c.valueF() )
        elif self.mode == 'hsvsaturation':
            c.setHsvF( c.hsvHueF(), max(0,min(float(self.slider.value())/float(_sliderNumSteps),1)), c.valueF() )
        elif self.mode == 'hslhue':
            c.setHslF( max(0,min(float(self.slider.value())/float(_sliderNumSteps),1)), c.hslSaturationF(), c.lightnessF() )
        elif self.mode == 'hslsaturation':
            c.setHslF( c.hslHueF(), max(0,min(float(self.slider.value())/float(_sliderNumSteps),1)), c.lightnessF() )
        elif self.mode == 'hsllightness':
            c.setHslF( c.hslHueF(), c.hslSaturationF(), max(0,min(float(self.slider.value())/float(_sliderNumSteps),1)) )
        else:
            c.setHsvF( c.hsvHueF(), c.hsvSaturationF(),max(0,min(float(self.slider.value())/float(_sliderNumSteps),1)) )
                
        
        self.r = c.redF()
        self.g = c.greenF()
        self.b = c.blueF()
        self.replaceValue()
        self.updateColor(False,True)
        return
        
    def connectIt(self):
        if xgg.DescriptionEditor is None:
            return
        self.connect(self.color, QtCore.SIGNAL("clicked()"),  self.colorChanged )
                     
        self.connect(self.slider, QtCore.SIGNAL("valueChanged(int)"), self.sliderChanged )
        self.connect(self.slider, QtCore.SIGNAL("sliderReleased()"), lambda : xgg.DescriptionEditor.playblast() )
        
class VectorExpressionUI(QtGui.QWidget):

    def __init__(self,parent,object,attr,strLabel,x,y,z,pos):
        QtGui.QWidget.__init__(self)
        self.parent = weakref.proxy(parent) if parent else None
        self.object = object
        self.attr = attr
        self.var = strLabel
        if object == "":
            self.label = QtGui.QLabel(strLabel)
        else:
            self.label = QtGui.QLabel(makeLabel(strLabel))
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        self.label.setIndent(10)
        self.pos = pos
        
        self.editX = QtGui.QLineEdit()
        self.editX.setFixedWidth(62)
        self.editX.setFixedHeight(18)
        self.editY = QtGui.QLineEdit()
        self.editY.setFixedWidth(62)
        self.editY.setFixedHeight(18)
        self.editZ = QtGui.QLineEdit()
        self.editZ.setFixedWidth(62)
        self.editZ.setFixedHeight(18)
        
        self.editX.setText( str(x) )
        self.editY.setText( str(y) )
        self.editZ.setText( str(z) )
        
        self.setLayout( self.BuildHorizontalLayout() )
        self.connectIt()
    
    def BuildHorizontalLayout(self):
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.editX)
        layout.addWidget(self.editY)
        layout.addWidget(self.editZ)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        return layout
    
    def replaceValue(self):
        if self.object!="":
            de = xgg.DescriptionEditor
            exprString = "(\\$%s+\\s*=\\s*)\[(-?[\\d.]*,-?[\\d.]*,-?[\\d.]*)\];" % self.var
            exprText = de.getAttr(self.object,self.attr)
            oldExprText = exprText
            re = QtCore.QRegExp( exprString )
            pos = re.indexIn(exprText, 0)
            if pos >= 0:
                varValue = "[" + self.editX.text() + "," + self.editY.text() + "," + self.editZ.text() + "]"
                lenCapXYZ = len(re.cap(2)) + 1 + len(re.cap(3)) + 1 + len(re.cap(4))
                # replace slider value in text
                exprText = exprText[:pos+len(re.cap(1))] + str(varValue) + exprText[pos+len(re.cap(1))+lenCapXYZ:]
            
            if oldExprText != exprText :
                self.parent.setValue(exprText, False)
        
    def editChanged(self):
        self.replaceValue()
        
    def connectIt(self):
        if xgg.DescriptionEditor is None:
            return
        
        self.connect(self.editX,QtCore.SIGNAL("editingFinished()"), self.editChanged )
        self.connect(self.editY,QtCore.SIGNAL("editingFinished()"), self.editChanged )
        self.connect(self.editZ,QtCore.SIGNAL("editingFinished()"), self.editChanged )


def loadFromRepo(filename):
    if not _currentExpr:
        xg.XGError(maya.stringTable['y_xgExpressionUI.kExprUICouldNotDetermineCurrentExpr' ])
        return
    _currentExpr.repoMan(filename)


class ExpressionUI(QtGui.QWidget):
    """A widget for editing an expression.

    This provides for the label, a text entry field, and a button
    to be bound to the expression edtior.
    """
    def __del__(self):
        om.MEventMessage.removeCallback( self.undoEventID )
        om.MEventMessage.removeCallback( self.redoEventID )
        QtGui.QWidget.__del__(self)

    def __init__(self,attr,help="",object="",mainlabel="",isColor=False,browseMode="",paint3dCtx=""):
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        self.paint3dCtx = paint3dCtx
        self.isColor = isColor
        if isColor:
            self.lastNumericValue = [1,1,1]
        else:
            self.lastNumericValue = [0.5]

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
        
        # Warning: override the mousePressEvent for the label
        self.label.mouseReleaseEvent = self.labelmouseReleaseEvent
        self.hasCustomUI = True

        self.textValue = None
        self.exprStr = ""
        self.numSliders = 0

        # expression editor button
        self.optionButton = QtGui.QToolButton()
        self.optionButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgExprEd.png"))
        self.optionButton.setAutoRaise(True)
        self.optionButton.setPopupMode(QtGui.QToolButton.MenuButtonPopup)
        self.optionButton.setToolTip(maya.stringTable[ 'y_xgExpressionUI.kOpenExpressionEditor'  ])
        # Warning: override the mousePressEvent for the toolButton
        self.optionButton.mousePressEvent = self.updateOwner

        # arrow menu 
        expressionUICreateMap = maya.stringTable[ 'y_xgExpressionUI.kExpressionUICreateMap'  ]
        self.menu = QtGui.QMenu()
        self.menu.addAction(expressionUICreateMap, self.callCreateMap)
        
        self.menu.addSeparator()
        self.menu.addAction(maya.stringTable['y_xgExpressionUI.kSaveExpression'],
                           lambda: self.repoMan("*save"))
        self.buildMenus()
        self.menu.addMenu(_userExprMenu)
        self.menu.addSeparator()
        self.menu.addAction(maya.stringTable['y_xgExpressionUI.kResetExpressionToSlider'], lambda: _currentExpr.resetToSlider())
        self.optionButton.setMenu(self.menu)
        
        # Vertical layout to hold the Expression text and slider box
        self.vlayout = QtGui.QVBoxLayout()
        self.vlayout.setSpacing( 0 )
        self.vlayout.setContentsMargins(0,0,0,0)
        
        
        # Build and set the layout
        self.browseMode = browseMode
        self.isBrowseMode = True if browseMode != "" else False
        # using the browse mode ui
        if self.isBrowseMode:
            self.optionButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgBrowse.png"))
            self.optionButton.setToolTip(maya.stringTable[ 'y_xgExpressionUI.kExpressionUIRaiseFileBrowser'  ])

            self.browseMenu = QtGui.QMenu()
            self.browseMenu.addAction(expressionUICreateMap, lambda: self.callCreateMap(browseMode))
            self.optionButton.setMenu(self.browseMenu)

        # Horizontal Expression layout
        self.exprBox = QtGui.QWidget()
        self.exprBox.setLayout( self.BuildHorizontalLayout() )
        self.exprBox.setToolTip(help)
        self.exprBoxWidget = None
        
        self.connectIt()
                 
        # Slider Box
        self.sliderBox = QtGui.QWidget()
        self.sliderboxLayout = QtGui.QVBoxLayout()
        self.sliderboxLayout.setSpacing(3)
        self.sliderboxLayout.setContentsMargins(1,1,1,1)
        self.sliderBox.setLayout( self.sliderboxLayout )
        self.sliderBoxWidgets = []
        self.sliderBoxLastValue = '' 

        # Set the layout
        self.vlayout.addWidget( self.exprBox )
        self.vlayout.addWidget( self.sliderBox )
        
        self.setLayout( self.vlayout )

        self.mayaAttr = None
        self.jobNumAttributeChange = {}
        self.jobNumConnectionChange = {}                
    
        #undo support
        self.undoing = False
        self.redoing = False
        self.undoEventID = om.MEventMessage.addEventCallback( "Undo", self.onUndoCB, self )
        self.redoEventID = om.MEventMessage.addEventCallback( "Redo", self.onRedoCB, self )    

    def onUndoCB(self,arg):
        self.undoing = True

    def onRedoCB(self,arg):
        self.redoing = True

    class SliderItem():
        def __init__(self,n="",v=0.0,vmin=0.0,vmax=1.0,mode=0,pos=-1,patchFunc=""):
            self.name = n
            self.value = v
            self.minValue = vmin
            self.maxValue = vmax
            self.mode = mode
            self.pos = pos
            self.patchFunc = patchFunc
            
    class VectorItem():
        def __init__(self,n="",x=0.0,y=0.0,z=0.0,mode="xyz",pos=-1):
            self.name = n
            self.x = x
            self.y = y
            self.z = z
            self.mode = mode
            self.pos = pos
            
    class MapItem():
        def __init__(self,n="",file="",mode="",pos=-1):
            self.name = n
            self.file = file
            self.mode = mode
            self.pos = pos

    def callCreateMap(self, defaultFolder=""):
        (startcolor,expr,newAttr,path) = createMap(self.attr,ptexBaker,defaultFolder,self.isBrowseMode)
        if expr != "":
            self.BuildSlidersLayout(str(expr),True,startcolor,newAttr) # Force to rebuild the slider layout first.
            
            self.setValue(expr)
            if ptexBaker.g_Mode != "":
                cmds.select( clear=True )
                
            if self.isBrowseMode:
                xgg.DescriptionEditor.setAttr(self.object,self.attr,str(path)) # CAUSES UI FREEZE PAINT ON PAINT
            else:
                xgg.DescriptionEditor.setAttr(self.object,self.attr,str(expr)) # CAUSES UI FREEZE PAINT ON PAINT

            # bake a ptx file out right away, so that xgen can find it immediately, and we avoid file not found errors.
            maps = self.parseMapString( str(expr) )
            if len(maps) :
                parser = BakeArgumentsParser()
                tpu = float(5.0)
                tokens = str(maps[0].mode).split(",")
                if len(tokens) > 1:
                    tpu = float( str(tokens[1]) )

                bakeArgs = parser.getBakeArguments( maps[0].file, self.object )
                ptexBaker.save3dPaint( bakeArgs[2], bakeArgs[1], tpu, self.attr )
            
            xgg.DescriptionEditor.playblast()
            self.buildMenus()

    def chooseStartColor(self, isVector, defaultValue, mapcolor):
        color = defaultValue
        if mapcolor == "white":
            if isVector:
                color = [1,1,1]
            else:
                color = [1]
        elif mapcolor == "black":
            if isVector:
                color = [0,0,0]
            else:
                color = [0]
        elif mapcolor == "grey":
            if isVector:
                color = [0.5,0.5,0.5]
            else:
                color = [0.5]
        elif mapcolor == "red":
            if isVector:
                color = [1,0,0]
            else:
                color = [0.5]
        elif mapcolor == "green":
            if isVector:
                color = [0,1,0]
            else:
                color = [0.5]
        elif mapcolor == "blue":
            if isVector:
                color = [0,0,1]
            else:
                color = [0.5]
        
        return color

    def parseSlidersString( self, exprText ):
        
        retSliders = []
    
        rangecomment = '\\s*#\\s*(-?[\\d.]*),(-?[\\d.]*)'
        re = QtCore.QRegExp( '\\$(\\w+)\\s*=\\s*(-?[\\d.]*);(%s)?' %  rangecomment )
        offset = 0
        while True:
            item = ExpressionUI.SliderItem()
            pos = re.indexIn(exprText, offset)
            if (pos < 0): 
                break
            offset = pos + 1
            item.name = re.cap(1)
            item.value = float(re.cap(2))
            item.pos = pos
            
            if len( re.cap(3) ) > 0 :
                rre = QtCore.QRegExp(rangecomment)
                rre.indexIn(re.cap(3), 0)
                ll = float( rre.cap(1) )
                ul = float( rre.cap(2) )
                if (abs(ll)>0.0001 or abs(ul)>0.0001) and ll<=ul :
                    item.minValue = ll;
                    item.maxValue = ul;
                    item.mode = (rre.cap(1).find('.') == -1 and rre.cap(2).find('.')==-1)
            
            retSliders.append( item )
        
        return retSliders
    
    def parseSlidersPatch( self, exprText ):
        retSliders = []
        rangecomment = '\\s*#\\s*(-?[\\d.]*),(-?[\\d.]*)'
        re = QtCore.QRegExp( '\\$(\\w+)\\s*=\\s*patchAttr[(]\\s*"?(\\w+)"?\\s*[)];(%s)?' %  rangecomment )
        offset = 0
        while True:
            item = ExpressionUI.SliderItem()
            pos = re.indexIn(exprText, offset)
            if (pos < 0): 
                break
            
            offset = pos + 1
            item.name = re.cap(1)
            item.pos = pos
            
            if len( re.cap(3) ) > 0 :
                rre = QtCore.QRegExp(rangecomment)
                rre.indexIn(re.cap(3), 0)
                ll = float( rre.cap(1) )
                ul = float( rre.cap(2) )
                if (abs(ll)>0.0001 or abs(ul)>0.0001) and ll<=ul :
                    item.minValue = ll;
                    item.maxValue = ul;
                    item.mode = (rre.cap(1).find('.') == -1 and rre.cap(2).find('.')==-1)
            item.patchFunc = re.cap(0)              
            retSliders.append( item )
        
        return retSliders
    
    def parseVectorString( self, exprText ):
        
        retSliders = []
    
        typecomment = '\\s*#\\s*(\\w+)'
        re = QtCore.QRegExp( '\\$(\\w+)\\s*=\\s*\[(-?[\\d.]*),(-?[\\d.]*),(-?[\\d.]*)\];(%s)?' %  typecomment )
        offset = 0
        while True:
            item = ExpressionUI.VectorItem()
            pos = re.indexIn(exprText, offset)
            if (pos < 0): 
                break
            offset = pos + 1
            item.name = re.cap(1)
            item.x = float(re.cap(2))
            item.y = float(re.cap(3))
            item.z = float(re.cap(4))
            item.pos = pos
             
            if len( re.cap(5) ) > 0 :
                rre = QtCore.QRegExp(typecomment)
                rre.indexIn(re.cap(5), 0)
                item.mode = rre.cap(1)
            
            retSliders.append( item )
        
        return retSliders
        
    def parseMapString( self, exprText ):
        
        # vmap and map expressions
        
        mapExprStrings = getMapExprStrings()
        exprStrings = [ [mapExprStrings[0],"3dpaint"], [mapExprStrings[1],"file"], [mapExprStrings[2],"vpaint"] ]
        
        retMaps = []
        for s in exprStrings:
            re = QtCore.QRegExp( s[0] )
            offset = 0
            while True:
                item = ExpressionUI.MapItem()
                pos = re.indexIn(exprText, offset)
                if (pos < 0): 
                    break
                offset = pos + 1
                item.name = re.cap(1)
                item.file = re.cap(2)
                item.mode = s[1]
                if s[1] == "3dpaint":
                    item.mode = item.mode + "," + re.cap(3)
                    
                item.pos = pos
                
                retMaps.append( item )
        
        return retMaps

    def BuildSlidersLayout(self, value, paintOn=False, mapcolor="basedOnAttribute", customAttr=""):

        # force slider rebuilt if undoing or redoing the current attribute
        rebuild = False
        if self.undoing:
            rebuild = cmds.undoInfo( redoName=True, query=True ) == self.attr
        elif self.redoing:
            rebuild = cmds.undoInfo( undoName=True, query=True ) == self.attr
        self.undoing = False;
        self.redoing = False;

        desc = currentDescription() 

        if self.sliderBoxLastValue != value or rebuild:
            # Clear the existing widgets
            for w in self.sliderBoxWidgets :
                self.sliderboxLayout.removeWidget( w )
                w.setParent(None)
                w.deleteLater()

            self.mayaAttr = None    
            self.sliderBoxWidgets = []
            
            if self.exprBoxWidget :
                self.exprBox.layout().removeWidget( self.exprBoxWidget )
                # hides before deleting to avoid the widget to popup 
                self.exprBoxWidget.hide()
                self.exprBoxWidget.setParent(None)
                self.exprBoxWidget.deleteLater()
                self.exprBoxWidget = None

            if self.textValue != None:
                self.exprBox.layout().removeWidget( self.textValue )
                # hides before deleting to avoid the widget to popup 
                self.textValue.hide()
                self.textValue.setParent(None)
                self.textValue.deleteLater()
                self.textValue = None

            # Parse to value string to detect sliders
            slidersFloat = self.parseSlidersString(value)
            slidersPatch = self.parseSlidersPatch(value)
            slidersVector = self.parseVectorString(value)
            slidersMaps = self.parseMapString(value)

            # check mapcolor to see what color the map should start as
            color = self.lastNumericValue
            isVector = False
            if len(self.lastNumericValue) == 3 or self.isColor:
                isVector = True
            color = self.chooseStartColor(isVector,color,mapcolor)

            unsortedwidgetList = []
            for s in slidersPatch :
                unsortedwidgetList.append( SliderExpressionUI( self, self.object, self.attr, s.name, s.value, s.minValue, s.maxValue, s.mode, s.pos, s.patchFunc ) )
            for s in slidersFloat :
                unsortedwidgetList.append( SliderExpressionUI( self, self.object, self.attr, s.name, s.value, s.minValue, s.maxValue, s.mode, s.pos, s.patchFunc ) )
            for s in slidersVector :
                if( s.mode.lower() == 'rgb' or s.mode.lower() == 'color' or s.mode.lower() == 'hsvhue' or s.mode.lower() == 'hsvsaturation' or s.mode.lower() == 'hslhue' or s.mode.lower() == 'hslsaturation' or s.mode.lower() == 'hsllightness' ) :
                    unsortedwidgetList.append( ColorExpressionUI( self, self.object, self.attr, s.name, s.mode, s.x, s.y, s.z, s.pos ) )
                else:
                    unsortedwidgetList.append( VectorExpressionUI( self, self.object, self.attr, s.name, s.x, s.y, s.z, s.pos ) )
            for s in slidersMaps :
                unsortedwidgetList.append( MapExpressionUI( self, self.object, self.attr, s.name, s.file, s.mode, s.pos, color, paintOn, mapcolor, parseFilePath(s.file), self.isBrowseMode, self.paint3dCtx ) )
            
            widgetList = sorted( unsortedwidgetList, cmp=lambda x,y: cmp( x.pos, y.pos ) )
            self.numSliders = len( widgetList )
            
            if self.numSliders == 0:
                self.textValue = QtGui.QLineEdit()
                self.textValue.setMinimumWidth(50)

                self.textValue.setText( self.exprStr )
                self.connect(self.textValue, QtCore.SIGNAL( "editingFinished()"), self.onEditingFinished )
                self.connect(self.textValue, QtCore.SIGNAL( "returnPressed()"), self.setFocus )
                self.exprBox.layout().insertWidget( 1, self.textValue )

            elif self.numSliders == 1:
                self.exprBoxWidget = widgetList[0]
                self.exprBoxWidget.label.setVisible( False )
                self.exprBox.layout().insertWidget( 1, self.exprBoxWidget )                
                if hasattr(self.exprBoxWidget, 'mayaAttr'):
                    self.mayaAttr = self.exprBoxWidget.mayaAttr
            else:
                self.exprBoxWidget = QtGui.QWidget()
                self.exprBoxWidget.setSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum )
                self.exprBox.layout().insertWidget( 1, self.exprBoxWidget )
                for w in widgetList :
                        self.sliderBoxWidgets.append( w )
                        self.sliderboxLayout.addWidget( w )
                if hasattr(widgetList[0], 'mayaAttr'):
                    self.mayaAttr = ""
                    
            # Update the last value
            self.sliderBoxLastValue = value

            if len(slidersMaps) == 0:
                self.optionButton.show()
        
        return True
        
    def BuildHorizontalLayout(self):
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.optionButton)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        return layout

    def cacheNumericValue(self):
        try:
            if self.object=="" or xgg.DescriptionEditor is None:
                return

            de = xgg.DescriptionEditor
            value = de.getAttr(self.object,self.attr)

            # Parse to value string to detect sliders
            slidersVector = self.parseVectorString(value)
            if( len( slidersVector ) > 0 ):
                self.lastNumericValue = []
                self.lastNumericValue.append( slidersVector[0].x )
                self.lastNumericValue.append( slidersVector[0].y )
                self.lastNumericValue.append( slidersVector[0].z )
                return

            slidersFloat = self.parseSlidersString(value)
            if( len( slidersFloat ) > 0 ):
                self.lastNumericValue = []
                self.lastNumericValue.append( slidersFloat[0].value )
                return

            # if its neither a slider nor a vector, strip out comments
            # and check if the expression is just a number.
            tokens = str(value).split( "#" )
            expr = value
            if len(tokens):
                expr = tokens[0] 

            self.lastNumericValue = []
            self.lastNumericValue.append( float(expr) )

        except:
            self.lastNumericValue = []
            self.lastNumericValue.append( 0.5 )

    def showEditor(self):
        cpal = currentPalette()
        cdesc = currentDescription()
        editor = XgExprEditor(self.attr,self.value(),cpal,cdesc)
        result = editor.exec_()
        if result == QtGui.QDialog.Accepted:
            val = editor.attributeValue()
            self.setValue(val)
            if xgg.Maya:
                mel.eval( 'XgExpressionEditor();' )             
            if self.object=="" or xgg.DescriptionEditor is None:
                return
        self.buildMenus()

    def updateOwner(self,event):
        global _currentExpr
        _currentExpr = self
        QtGui.QToolButton.mousePressEvent(self.optionButton,event)

    def labelmouseReleaseEvent(self,event):
        if event.button() == Qt.RightButton:
            if self.mayaAttr != None and self.mayaAttr != "":
                self.mayaAttr.getMenu(event)
            else:
                labelmenu = QtGui.QMenu( )
                labelmenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kExpressionUIRefresh'  ], lambda: self.refresh())
                if self.mayaAttr != "":
                    createMenu = QtGui.QMenu(maya.stringTable[ 'y_xgExpressionUI.kLinkToMayaAttribute'  ])
                    createMenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kFloat'  ], lambda: self.createMayaAttr(1))
                    createMenu.addAction(maya.stringTable[ 'y_xgExpressionUI.kVector'  ], lambda: self.createMayaAttr(3))
                    labelmenu.addMenu(createMenu)

                labelmenu.exec_(event.globalPos())                 
                
        QtGui.QLabel.mouseReleaseEvent(self.label,event)

    def createMayaAttr(self, count ):        
        desc = currentDescription()
        
        fixedAttr = re.sub('[\[\]]', '_', self.attr)
        mayaAttrName = "xgen_" + xgmExternalAPI.encodeNameSpace(desc) + "_" + fixedAttr

        patchFunc = ''
        varPreFix = "$"+fixedAttr
        endFunc = varPreFix + "0"
        if count == 3:
            endFunc = "["+varPreFix+"0,"+varPreFix+"1,"+varPreFix+"2]"
        for num in range(0,count):
            patchFunc = patchFunc + varPreFix + str(num) +"= patchAttr(\"" + mayaAttrName + "_" + fixedAttr + str(num) +"\");#0.0,1.0\\n"

        patchFunc = patchFunc + endFunc + "\\n"        
        self.setValue(patchFunc)

    def buildMenus(self):
        global _userExprMenu

        globalExprMenu = QtGui.QMenu(maya.stringTable['y_xgExpressionUI.kGlobalExpressionDirectory'])
        localExprMenu = QtGui.QMenu(maya.stringTable['y_xgExpressionUI.kLocalExpressionDirectory'])

        if not _userExprMenu:
            _userExprMenu = QtGui.QMenu(maya.stringTable['y_xgExpressionUI.kLoadExpressionMenu' ])
        _userExprMenu.clear()

        self.buildMenu(_userExprMenu,xg.userRepo()+"expressions/")
        self.buildMenu(_userExprMenu,xg.localRepo()+"expressions/")
        self.buildMenu(_userExprMenu,xg.globalRepo()+"expressions/")

        if not _userExprMenu.isEmpty():
            _userExprMenu.addSeparator()
        _userExprMenu.addAction(maya.stringTable['y_xgExpressionUI.kLoadExpressionDialog'], lambda: _currentExpr.repoMan("*loaddialog")) 

    def buildMenu(self,topmenu,startDir):
        # first verify that the directory exists
        try:
            buf = os.stat(startDir)
        except:
            return False
        subdirlist = [startDir]
        depths = [0]
        menus = []
        while subdirlist:
            dir = subdirlist.pop()
            depth = depths.pop()
            try:
                files = os.listdir(dir)
                files.sort()
                menu = None
                if depth:
                    menu = QtGui.QMenu(os.path.basename(dir))
                    menus[depth-1].addMenu(menu)
                else:
                    menu = topmenu
                if len(menus)>depth:
                    menus[depth] = menu
                else:
                    menus.append(menu)
                for item in files:
                    long = os.path.join(dir,item)
                    if os.path.isfile(long):
                        parts = os.path.splitext(item)
                        if parts[1] == ".se":
                            menu.addAction(parts[0],
                                           lambda x=long: loadFromRepo(x))
                    else:
                        subdirlist.insert(0,long)
                        depths.insert(0,depth+1)
            except:
                pass

    def repoMan(self,value):
        # if the value is "save" then we raise a browser in user repo
        if str(value)=="*save":
            startDir  = xg.userRepo() + "expressions/"
            try:
                buf = os.stat(startDir)
            except:
                # if the directory isn't there the browser will send us to
                # some unexpected location
                os.makedirs(startDir)
            result = fileBrowserDlg(self,startDir,"*.se","out")
            if len(result):
                if not result.endswith(".se"):
                    result += ".se"
                f = open(result,'w')
                f.write(self.value())
                self.buildMenus()
        else:
            if str(value)=="*loaddialog":
                value = fileBrowserDlg(self,xg.userRepo(),"*.se","in")
                if len(value) == 0:
                    return

            expr = ""

            try:
                filename = str(value)
                buf = os.stat(filename)
                
                f = open(filename,'r')

                # convert all newlines to unix-style newlines
                lines = f.read().splitlines()
                for line in lines:
                    expr += line
                    expr += '\n'

            except:
                xg.XGError(maya.stringTable['y_xgExpressionUI.kExprUIExprNotExist' ] % filename)
                self.buildMenus()
                return
            try:
                expr = xg.prepForAttribute(expr)
                self.setValue(expr)
            except:
                # some syntax error in the expression
                pass

    def fileBrowser(self):
        # Get setup with a full path given users input value                                                                                              
        base = ""
        startDir = str(self.textValue.text())
        if isPathRelative(startDir):
            # the path is relative so either add palette dir or pwd
            if len(self.object):
                de = xgg.DescriptionEditor
                cpal = de.currentPalette()
                pathStr = xg.getAttr("xgDataPath",cpal)
                path = pathStr.split(";")
                base = path[0];
                if base.startswith('./'):
                    base = currentWorkDir()+base[2:]
                elif base == '.':
                    base = currentWorkDir()
            else:
                base = currentWorkDir()
            startDir = fixFolderPath(base) + startDir

        # replace and xgen variables
        cdesc = xgg.DescriptionEditor.currentDescription()

        # expand start dir fully
        startDir = xg.expandFilepath( startDir, cdesc )
        base = xg.expandFilepath( base, cdesc )

        # bring up the browswer dialog window
        selectedFile = fileBrowserDlg(self,startDir)

        # remove relativity
        endValue = selectedFile[-1:]
        if endValue == '/':
            selectedFile = selectedFile[:-1]

        # set the result and attribute
        if len(selectedFile):
            # strip off the base to get back to relative
            if len(base)>1:  # avoid calling replace if the base is something weird like slash
                selectedFile = selectedFile.replace(base,'',1)
            # put back the variables
            if len(self.object):
                if len(cdesc):
                    selectedFile = selectedFile.replace(cdesc,"${DESC}")
                selectedFile = selectedFile.replace(self.object,"${FXMODULE}")

            # do not allow non-correct folders to be chosen by the user
            if selectedFile.find("${DESC}") == -1 and self.isBrowseMode:
                xg.XGError(maya.stringTable[ 'y_xgExpressionUI.kExpressionUIFolderInDescError'  ])
                return

            self.textValue.setText(selectedFile)
            if self.object=="" or xgg.DescriptionEditor is None:
                return
            de = xgg.DescriptionEditor
            if de.setAttr(self.object,self.attr,selectedFile):
                de.playblast()

    def resetToSlider(self):
        expr = "$a=0.000;#-1.0,1.0\\n$a"
        self.setValue(expr)
        if ptexBaker.g_Mode != "" and ptexBaker.g_xgenAttr == self.attr:
            cmds.setToolTo( "selectSuperContext" )

    def value(self):
        return self.exprStr

    def setValue(self, value, refreshSliderLayout=True):
        # Save the old value of the attribute first. We can use it as a good default
        # when the user switches from a constant float expression to a paint map expression.
        self.cacheNumericValue()
        self.exprStr = value

        if self.numSliders == 0:
            if self.textValue != None:
                self.textValue.setText( value )
            
        if refreshSliderLayout:
            self.refreshSliderLayout(value)
        else:
            self.sliderBoxLastValue = value
        
        if self.object!="" and xgg.DescriptionEditor.setAttrCmd( self.object, self.attr, self.exprStr ):
            xgg.DescriptionEditor.playblast()

    def onEditingFinished(self):
        self.setValue(self.textValue.text())
        
    def connectIt(self):
        if self.isBrowseMode:
            self.connect(self.optionButton,QtCore.SIGNAL("clicked()"),self.fileBrowser)
        else:
            self.connect(self.optionButton,QtCore.SIGNAL("clicked()"),self.showEditor)

        if xgg.DescriptionEditor is None:
            return

    def refreshSliderLayout(self, value):
        if self.isBrowseMode:
            # Paint mode always on when in browse mode, create paint settings with default values.
            # If you wish to choose new default values for Region Map, this is where it should be changed.
            expr = str("$a=map('"+value+"');#3dpaint,5.0\\n$a\\n")
            newAttr = value.split('/')[-1]
            self.BuildSlidersLayout(expr,False,"red",newAttr)
        else:
            self.BuildSlidersLayout(value)

    def forceRefresh(self):  
        self.sliderBoxLastValue = "patch"
        self.refresh()

    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        value = de.getAttr(self.object,self.attr)
        self.setValue(value)

    def cleanScriptJob(self):
        try:
            for w in self.sliderBoxWidgets :
                w.mayaAttr.removeNotif();
            
            if self.exprBoxWidget :
                self.exprBoxWidget.mayaAttr.removeNotif();
        except:
            pass            



        
        
