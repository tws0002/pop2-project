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
# @file xgDescriptionEditor.py
# @brief Contains the XGen Description Editor base UI.
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
# @version Created 03/02/09
#


import os
import sys
import inspect
import traceback

from PySide import QtGui, QtCore

import xgenm as xg
import xgenm.xgGlobal as xgg
import xgenm.xgUtil as xgu
if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds
    import maya.OpenMayaUI as mui
    from xgenm.xmaya.xgmArchiveExport import xgmArchiveExport
    from xgenm.xmaya.xgmArchiveExportBatchUI import xgmArchiveExportBatchUI

from xgenm.ui.widgets import *
from xgenm.ui.tabs import *
from xgenm.ui.fxmodules import *
from xgenm.ui.XgMessageUI import XgMessageUI
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgProgressBar import setProgressInfo
from xgenm.ui.util.xgProgressBar import isProgressVisible
from xgenm.ui.util.xgComboBox import _ComboBoxUI
from xgenm.ui.dialogs.xgImportFile import importFile
from xgenm.ui.dialogs.xgExportFile import exportFile
from xgenm.ui.dialogs.xgImportPreset import importPreset
from xgenm.ui.dialogs.xgExportPreset import exportPreset
from xgenm.ui.dialogs.igExport import igExportFile
from xgenm.ui.dialogs.igImport import igImportFile
from xgenm.ui.dialogs.xgCreateDescription import createDescription
from xgenm.ui.dialogs.xgCopyMoveDescription import copyDescription
from xgenm.ui.dialogs.xgCopyMoveDescription import moveDescription
from xgenm.ui.dialogs.xgStrayPercentage import strayPercentage
from xgenm.ui.dialogs.xgExportToP3D import exportToP3D
from xgenm.ui.dialogs.xgExportCaf import exportCaf
from xgenm.ui.dialogs.xgMapBindings import mapBindings
from xgenm import XgExternalAPI as xgapi
import xgenm.xmaya.xgmExternalAPI as xgmExternalAPI
from contextlib import contextmanager

###########################################################################

def _isUI(name, cls, xgenmodules):
    """
    Return true if the name is an XGen UI class that corresponds to one of the
    XGen modules.
    """
    if not inspect.isclass(cls): return False
    if not name.endswith("TabUI"): return False
    xgenname = name[:-5] # strip off TabUI
    if not xgenname in xgenmodules: return False
    return True

###########################################################################

def _importUI(basepath):
    """
    Import custom UI for the custom FX modules.

    We read through basepath/plugins/*.py and return a dictionary of all the UI
    classes we found.

    We generate a warning if the directory has the same UI class twice, and we
    use the most recent one (in alphabetical order).

    This gets invoked with the GlobalRepo, LocalRepo, and UserRepo as basepath.
    """
    classes = dict()

    # Look up ~/xgen/plugins if it exists.
    uipath = os.path.join(basepath, "plugins")
    if not os.path.isdir(uipath): return classes

    # Add ~/xgen/plugins to the python path if it isn't yet there.
    # Remove it in the finally block.
    sys.path.insert(0, uipath)
    try:
        # List ~/xgen/plugins and import all the python files.
        # Sort so that duplicate class names at least get a consistent result.
        files = sorted([ x for x in os.listdir(uipath) if x.endswith(".py") ])

        xgenmodules = set(xgapi.availableModules())

        for filename in files:
            # Strip off the '.py' and import.
            pyname = filename[:-3]

            # equivalent to "import pyname", but catch errors and go on to the
            # next file.
            try:
                pymodule = __import__(pyname)
                print maya.stringTable[ 'y_xgDescriptionEditor.kLoadedPathPython'  ] % (uipath,pyname)
            except Exception as e:
                print maya.stringTable[ 'y_xgDescriptionEditor.kFailedToLoadPathPython'  ] % (uipath,pyname,e)
                traceback.print_exc()
                continue

            for name in dir(pymodule):
                cls = getattr(pymodule, name)
                if not _isUI(name, cls, xgenmodules): continue
                if name in classes:
                    print maya.stringTable[ 'y_xgDescriptionEditor.kWarningDefinedTwiceInDirectory'  ] % (name, uipath)
                classes[name] = cls

    finally:
        sys.path.pop(0)

    return classes
# end _importUI

class PaletteExpressionUI(ExpressionUI):
    """
    Specialized widget for palette expressions which provides a remove expression button.
    """
    def __init__(self,attr):
        # if its a color expr, allow color to be painted                                                                                                                           
        isColor = True if attr.find("custom_color") != -1 else False
        ExpressionUI.__init__(self,attr, maya.stringTable[ 'y_xgDescriptionEditor.kGlobalExpression'  ] % attr, "Palette","",isColor)
        
    def BuildHorizontalLayout(self):
        removeButton = QtGui.QToolButton()
        removeButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgDelete.png"))
        removeButton.setFixedSize(24,24)
        removeButton.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kRemoveAnn'  ])
        self.connect(removeButton, QtCore.SIGNAL("clicked()"), self.remPalExpr)

        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.optionButton)
        layout.addWidget(removeButton)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        return layout

    def remPalExpr(self):
        if self.attr=="":
            return
        de = xgg.DescriptionEditor

        key = de.currentPalette() + " " + self.attr
        if de.palExprExpandState.has_key(key):
            del de.palExprExpandState[key]

        xg.remCustomAttr(self.attr,de.currentPalette())
        de.refreshPalExprs()

class PaletteExpressionExpandUI(ExpandUI):
    def __init__(self, palette, text, expanded=True):
        ExpandUI.__init__(self, text, expanded)
        self.palette = palette

###########################################################################
ExportStartFrame = "1.0"
ExportEndFrame = "2.0"
Anim = False

class ExportUI(QtGui.QDialog):
    """Function to export geometry for XGen using a dialog.

    This provides a simple dialog to accept the file name and a check
    box for optionally animated results. The user can use a browser to
    search for the file.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgDescriptionEditor.kXgenExport'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        layout = QtGui.QVBoxLayout()
        self.anim = CheckBoxUI(maya.stringTable[ 'y_xgDescriptionEditor.kAnimatedXGenExport'  ],
                               maya.stringTable[ 'y_xgDescriptionEditor.kSetToTrueIfTheGeometryIsAnimated'  ])
        self.anim.setValue(Anim)
        self.connect(self.anim.boxValue[0],
                     QtCore.SIGNAL("clicked(bool)"),
                     lambda x: self.animUpdate())
        layout.addWidget(self.anim)

        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kFrameRange'  ])
        label.setFixedWidth(int(labelWidth()))
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        self.startFrame = QtGui.QLineEdit()
        self.startFrame.setValidator(QtGui.QDoubleValidator(-100000.0,100000.0,6,self.startFrame))
        self.startFrame.setText(ExportStartFrame)
        self.startFrame.setFixedWidth(70)
        self.startFrame.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kFirstFrameAnn' ])
        self.endFrame = QtGui.QLineEdit()
        self.endFrame.setValidator(QtGui.QDoubleValidator(-100000.0,100000.0,6,self.endFrame))
        self.endFrame.setText(ExportEndFrame)
        self.endFrame.setFixedWidth(70)
        self.endFrame.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kLastFrameAnn' ])
        
        row = QtGui.QWidget()
        boxlayout = QtGui.QHBoxLayout()
        boxlayout.setAlignment(QtCore.Qt.AlignLeft)
        boxlayout.addWidget(label)
        boxlayout.addWidget(self.startFrame)
        boxlayout.addSpacing(5)
        boxlayout.addWidget(self.endFrame)
        row.setLayout(boxlayout)
        layout.addWidget(row)        

        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.exportButton = QtGui.QPushButton(maya.stringTable[ 'y_xgDescriptionEditor.kExportFileButton'  ])
        self.exportButton.setFixedWidth(100)
        self.exportButton.setAutoRepeat(False)
        self.exportButton.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kExportFileAnn'])
        self.connect(self.exportButton, QtCore.SIGNAL("clicked()"),
                     self.accept)
        hbox.addWidget(self.exportButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgDescriptionEditor.kCancelButton'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kCancelExportAnn' ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)
        self.animUpdate()

    def animUpdate(self):
        value = self.anim.value()
        if value:
            self.startFrame.setEnabled(True)
            self.endFrame.setEnabled(True)
        else:
            self.startFrame.setEnabled(False)
            self.endFrame.setEnabled(False)
            
    def getAnim(self):
        return self.anim.value()

    def getStartFrame(self):
        return str(self.startFrame.text())

    def getEndFrame(self):
        return str(self.endFrame.text())


class DescriptionEditorUI(QtGui.QWidget):
    xgCurrentDescriptionChanged = QtCore.Signal( str, str )
    xgDescriptionEditorEnableUI = QtCore.Signal( int )

    # Enum for Preview/Clear Modes
    class PreviewMode:
        Description = 0
        Collection = 1
        All = 2

    class Previewer(object):
        """ Handler for managing calls to preview. The previewer collects and executes 
            calls on idle with lowest priority to make sure preview is always the last 
            process to run. The previewer collects calls in a set to make sure duplicates 
            are not run. 
        """
        def __init__(self):
            self._stack = set()
            self._tracking = True
            self._idle = True

        def add( self, item ):      
            if cmds.about(batch=True):
                # no need to record preview calls in batch
                return

            if not self._idle:
                # immediate eval if not idle
                mel.eval(item) 
                return

            if not self._tracking:
                return

            if not len(self._stack):
                import maya.cmds
                script = 'xgg.DescriptionEditor.previewer.execute()'
                maya.cmds.evalDeferred( script, lowestPriority=True)
            self._stack.add(item)

        def execute(self ):
            # Delay the preview calls if there is some work in progress.
            # This method can be called from progress dialog's idle event.
            if isProgressVisible():
                import maya.cmds
                script = 'xgg.DescriptionEditor.previewer.execute()'
                maya.cmds.evalDeferred( script, lowestPriority=True)
                return

            import maya.mel as mel
            for item in self._stack:                
                mel.eval(item) 
            self._stack.clear()

        @property
        def tracking(self):
            return self._tracking

        @tracking.setter
        def tracking(self,val):
            self._tracking = val

        @property
        def idle(self):
            return self._idle

        @idle.setter
        def idle(self,val):
            self._idle = val

    def __init__(self,parent = None,fl = 0 ):
        QtGui.QWidget.__init__(self, parent, fl)
        self.arcExport=None
        self.arcBatchExport=None

        if xgg.Maya and cmds.about(batch=True):
            print '============================================='
            xg.XGError( maya.stringTable['y_xgDescriptionEditor.kCreatingDEUIInBatch' ] )
            print xgu.callStack()
            print '============================================='

        # Global holder of the editor. Dont reference values through
        # this inside of other constructors since we aren't ready until
        # we finish the full setup. We do this here though to allow
        # widgets to connect.
        xgg.DescriptionEditor = self
        self.setWindowTitle(maya.stringTable[ 'y_xgDescriptionEditor.kXgenDescriptionEditor'  ])
        self.setWindowIcon(QtGui.QIcon(xg.iconDir()+"xgDEditor.png"))
        self.setGeometry(0,0,360,750)
        self.keyPressEvent = self.deKeyPressEvent

        self.optionVars = {}
        # message level options
        self.optionVars['debug'] = 'xgenDebugMsgLevelVar'
        self.optionVars['warning'] = 'xgenWarningMsgLevelVar'
        self.optionVars['stats'] = 'xgenStatsMsgLevelVar'

        # undo support
        self._undoRequired = True 
        self._tempUndoRequired = None

        # Preview and Clear Options
        self.previewSel = False
        self.previewMode = self.PreviewMode.Description
        self.clearSel = False
        self.clearCache = False
        self.clearMode = self.PreviewMode.Description
        self.autoCreateMR = True
        xgg.PlayblastWarning = True
        self._previewer = None

        # build welcome screen and main ui
        # which one will be shown will depend on EnableUI()
        self.welcomeUI = QtGui.QWidget()
        self.welcomeUI.setVisible(False)
        self.welcomeUI.setLayout(self.buildWelcomeUI())
        
        self.mainUI = QtGui.QWidget()
        self.mainUI.setVisible(False)
        self.mainUI.setLayout(self.buildMainUI())
        
        layout = QtGui.QVBoxLayout()
        layout.setContentsMargins(0,0,0,0)
        self.setLayout(layout)
        layout.addWidget(self.welcomeUI)
        layout.addWidget(self.mainUI)

        xg.registerCallback( "PostPaletteDelete", "xgenm.ui.xgDescriptionEditor.postPaletteDeleteCB" )

    def __del__(self):
        xg.deregisterCallback( "PostPaletteDelete", "xgenm.ui.xgDescriptionEditor.postPaletteDeleteCB" )
        QtGui.QWidget.__del__(self)

    @property
    def previewer(self):
        if self._previewer:
            return self._previewer
        self._previewer = DescriptionEditorUI.Previewer()
        return self._previewer

    @contextmanager
    def setAttrGuard( self ):
        """ Context manager to make sure attributes are not set through the undo command """
        try:
            # save undo initial value
            if self._tempUndoRequired == None:
                self._tempUndoRequired = self._undoRequired

            # prevent setAttrCmd to be called
            self._undoRequired = False
            yield

        except Exception:
            import traceback
            print traceback.print_exc()

        finally:
            # restore undo value
            if self._tempUndoRequired:
                self._undoRequired = self._tempUndoRequired
            self._tempUndoRequired = None

    def saveGlobals(self):
        '''Saving the per Scene flags of the UI inside a single script node'''
        if not xg.descriptions():
            return

        try:
            cmds.delete( "xgenGlobals")
        except:
            pass

        select = cmds.ls( sl=True )
        try:
            #These are created on file import (ex.: file -f -i "scenes/impSaveimpSave.ma;")
            cmds.select( "*_xgenGlobals*")
            selectXgenGlobals = cmds.ls( sl=True )
            for item in selectXgenGlobals:
                if cmds.nodeType(item, api=True) == "kScript":
                    cmds.delete( item )
        except:
            pass            
        if select == []:
            cmds.select( cl=True )
        else:
            cmds.select( select, r=True )

        kOnDemand = 0
        kIgnoreReferenceEdits=1
        cmds.scriptNode( name="xgenGlobals", st=0, sourceType="Python", scriptType=kOnDemand, ignoreReferenceEdits=kIgnoreReferenceEdits, \
            afterScript="import maya.cmds as cmds\nif cmds.about(batch=True):\n\txgg.Playblast=False\nelse:\n\txgui.createDescriptionEditor(False).setGlobals( previewSel=%d, previewMode=%d, clearSel=%d, clearMode=%d, playblast=%d, clearCache=%d, autoCreateMR=%d )"%(self.previewSel,self.previewMode,self.clearSel,self.clearMode,xgg.Playblast, self.clearCache, self.autoCreateMR ) )


        # Update the geometry shaders before saving
        try:
            if mel.eval('exists "xgmr"'):
                cmds.xgmr( ugs=True, description="", palette="" )
        except:
            pass

    def setGlobals(self, previewSel=False, previewMode=0, clearSel=False, clearMode=0, playblast=False, clearCache=False, autoCreateMR=True ):
        '''setGlobals is a method called by the script node. Please keep the arguments with the same names and always add '''
        self.previewSel = previewSel
        self.previewMode = previewMode
        self.clearSel = clearSel
        self.clearCache = clearCache
        self.clearMode = clearMode
        xgg.Playblast = playblast
        xgg.PlayblastWarning = True
        self.autoCreateMR = autoCreateMR
        self.updatePreviewControls()
        self.updateClearControls()
        self.updateMentalrayControls()

    
    def loadGlobals(self):
        '''Set default Globals and  try to execute the xgenGlobals script. This is run on scene load and new scene.'''
        # Preview and Clear Options
        self.previewSel = False
        self.previewMode = self.PreviewMode.Description
        self.clearSel = False
        self.clearCache = False
        self.clearMode = self.PreviewMode.Description
        self.autoCreateMR = True
        xgg.PlayblastWarning = True
        xgg.Playblast = True

        try:
            cmds.scriptNode( "xgenGlobals", executeAfter=True )
        except:
            pass

    def buildMainUI(self):

        # Create the main layout with a splitter in it
        mainUILayout = QtGui.QVBoxLayout()
        mainUILayout.setAlignment(QtCore.Qt.AlignTop)
        mainUILayout.setSpacing(0)
        mainUILayout.setContentsMargins(3,3,3,3)

        # Top Menu Bar
        mainUILayout.addWidget(self.createMenuBar())

        self.splitter = QtGui.QSplitter()
        self.splitter.setOrientation(QtCore.Qt.Vertical)
        self.splitter.setOpaqueResize(False)
        mainUILayout.addWidget(self.splitter)
       
        # middle section, top is a compound layout for showing the big preview button + 2 lines on the right
        # bottom is the tab bar.
        middleWidget = QtGui.QWidget()
        middleUILayout = QtGui.QVBoxLayout(middleWidget)
        middleUILayout.setAlignment(QtCore.Qt.AlignTop)
        middleUILayout.setSpacing(0)
        middleUILayout.setContentsMargins(0,0,0,0)
        self.splitter.addWidget(middleWidget)

        bottomWidget = QtGui.QWidget()
        bottomUILayout = QtGui.QVBoxLayout(bottomWidget)
        bottomUILayout.setAlignment(QtCore.Qt.AlignTop)
        bottomUILayout.setSpacing(0)
        bottomUILayout.setContentsMargins(3,3,3,3)
        self.splitter.addWidget(bottomWidget)        
        self.splitter.setCollapsible(0,False)
        self.splitter.setCollapsible(1,False)
        
        # middleH is a compound layout
        # with big preview button on the left side
        # and 2 horizontal lines on the right.
        # First line is current Palette/Description  
        # Second is the tool bar.
        middleHWidget = QtGui.QWidget()
        middleHUILayout = QtGui.QHBoxLayout(middleHWidget)
        middleHUILayout.setAlignment(QtCore.Qt.AlignTop)
        middleHUILayout.setSpacing(0)
        middleHUILayout.setContentsMargins(0,0,0,0)
        middleUILayout.addWidget(middleHWidget)
        middleUILayout.addSpacing( 2 )
        
        (middleRVWidget1,middleRVWidget2) = self.createEmptyFrame()
        middleRVUILayout = QtGui.QVBoxLayout(middleRVWidget2)
        middleRVUILayout.setAlignment(QtCore.Qt.AlignTop)
        middleRVUILayout.setSpacing(2)
        middleRVUILayout.setContentsMargins(0,0,0,0)
        middleHUILayout.addWidget(middleRVWidget1)
        
        self.createTopBar(middleRVUILayout)
        if ( xgg.Maya ):
            self.createShelfBar(middleRVUILayout)
        
        self.createTabBar(middleUILayout)


        self.messageUI = XgMessageUI()
        self.messageUI.setMinimumHeight(35)
        logExpand = ExpandUI(maya.stringTable[ 'y_xgDescriptionEditor.kMainLog'  ],False)

        logExpand.addWidget(self.messageUI)        
        bottomUILayout.addWidget(logExpand)

        self.splitter.setStretchFactor(0,100)
        self.splitter.setStretchFactor(1,0)
        self.splitter.setSizes([100,0])

        return mainUILayout 

    def buildWelcomeUI(self):

        def addIconButtonLine( layout, icon, title):
            layout.addSpacing(20)
            row = QtGui.QWidget()
            hbox = QtGui.QHBoxLayout()
            hbox.setContentsMargins(0,0,0,0)
            hbox.setAlignment(QtCore.Qt.AlignRight)
            row.setLayout(hbox)
            layout.addWidget(row)

            thumbWidget = QtGui.QLabel()
            pixmap = QtGui.QPixmap()
            if icon!="":
                pixmap.load( xg.iconDir()+icon )
                pixmap = pixmap.scaled(QtCore.QSize(24,24))
            thumbWidget.setPixmap( pixmap )
            hbox.addWidget(thumbWidget)
            

            execButton = QtGui.QPushButton(title)
            execButton.setFixedWidth(200)
            execButton.setAutoRepeat(False)
            hbox.addWidget(execButton)

            return execButton

        welcomeUILayout = QtGui.QVBoxLayout()
        welcomeUILayout.setAlignment(QtCore.Qt.AlignTop)
        welcomeUILayout.setSpacing(0)
        welcomeUILayout.setContentsMargins(15,15,15,15)
   
        frame = QtGui.QFrame()
        frame.setFrameShadow(QtGui.QFrame.Plain)
        frame.setFrameShape(QtGui.QFrame.StyledPanel)
        frame.setFixedSize(400,100)

        imagePath = "background-image: url(%s);" % (xg.iconDir()+"xgSplash_Scaled.png")
        frame.setStyleSheet(imagePath)

        welcomeUILayout.addWidget(frame)

        welcomeUILayout.addSpacing(10)        
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kGettingStartedWithXgen'  ] % ("<b>","</b>"))
        #label.setStyleSheet('font-size: 15pt;')
        welcomeUILayout.addWidget(label)

        welcomeUILayout.addSpacing(10)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kUseXgenToCreateArbitraryPrimitivesOnASurface'  ])
        #label.setStyleSheet('font-size: 11pt;')
        welcomeUILayout.addWidget(label)
        welcomeUILayout.addSpacing(5)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kHairFurFeathersScalesRocksAndMore'  ])
        #label.setStyleSheet('font-size: 11pt;')
        welcomeUILayout.addWidget(label)

        welcomeUILayout.addSpacing(15)        
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.ktoStart'  ] % ("<b>","</b>"))
        #label.setStyleSheet('font-size: 11pt;')
        welcomeUILayout.addWidget(label)

        welcomeUILayout.addSpacing(5)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kSelectTheGeometryOrFacesToCreatePrimitiveOn'  ])
        #label.setStyleSheet('font-size: 11pt;')
        label.setWordWrap( True ) 
        welcomeUILayout.addWidget(label)

        welcomeUILayout.addSpacing(5)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kCreateANewXgenDescription'  ])
        #label.setStyleSheet('font-size: 11pt;')
        label.setWordWrap( True ) 
        welcomeUILayout.addWidget(label)
        self.connect(addIconButtonLine(welcomeUILayout, "xgCreateDescription.png", maya.stringTable[ 'y_xgDescriptionEditor.kCreateNewDescription'  ] ), QtCore.SIGNAL("clicked()"), self.createDescription)
        self.connect(addIconButtonLine(welcomeUILayout, "xgImportDescription.png", maya.stringTable[ 'y_xgDescriptionEditor.kImportDescription'  ] ), QtCore.SIGNAL("clicked()"), DescriptionEditorUI.importFileCB )
        self.connect(addIconButtonLine(welcomeUILayout, "xgImportPreset.png", maya.stringTable[ 'y_xgDescriptionEditor.kWelcomeUIImportPreset'  ] ), QtCore.SIGNAL("clicked()"), self.openLibraryWindow )

        # palettes
        self.palettes = _ComboBoxUI()
        self.connect(self.palettes, 
                    QtCore.SIGNAL("activated(const QString&)"), 
                    lambda x: self.refresh('Palette') )

        self.palettes.setMinimumWidth(50)

        return welcomeUILayout

    @staticmethod
    def importFileCB():
        importFile('description')

    def deKeyPressEvent(self,event):
        QtGui.QWidget.keyPressEvent(self,event)
        # This prevents the focus from going back to the Maya panel under the description editor
        # The behavior is the same as the attribute editor.
        event.accept()

    def createMenuBar(self):
        menubar = QtGui.QMenuBar(self)
        menubar.setNativeMenuBar(False)  #For the mac standalone xgen editor
        
        self.fileMenu = menubar.addMenu(maya.stringTable[ 'y_xgDescriptionEditor.kFileMenuName'  ])
        if ( xgg.Maya ):
            self.fileMenu.aboutToShow.connect( self.onFileMenuShow )
            self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kImportMenuBar'  ],importFile)
            self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kImportPresetMenuBar'  ],importPreset)
            self.importGrooming = self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kImportGroomingMenuBar'  ],igImportFile)
            self.fileMenu.addSeparator()
            self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kExportMenuBar'  ],exportFile)
            self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kExportPresetMenuBar'  ],exportPreset)        
            self.exportGrooming = self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kExportGroomingMenuBar'  ],igExportFile)
            self.fileMenu.addSeparator()
        self.fileMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kExportPatchesForBatchRender'  ], self.exportPatches)
        self.fileMenu.addSeparator()    
        if ( xgg.Maya ):
            self.fileMenu.addAction(maya.stringTable['y_xgDescriptionEditor.kExportSelectionAsArchives' ], lambda: mel.eval('XgExportArchive();') )
            self.fileMenu.addAction(maya.stringTable['y_xgDescriptionEditor.kBatchConvertScenesToArchives'], lambda: mel.eval('XgBatchExportArchive();') )
        else:
            self.fileMenu.addAction(maya.stringTable['y_xgDescriptionEditor.kExportSelectionAsArchives2'], self.exportArchives)
            self.fileMenu.addAction(maya.stringTable['y_xgDescriptionEditor.kBatchConvertScenesToArchives2'], self.batchExportArchives)
            
        self.palMenu = menubar.addMenu(maya.stringTable[ 'y_xgDescriptionEditor.kCollectionMenuName'  ])
        self.palMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kEditFilePathPalMenu'  ], 
                   self.editPath)
        if ( xgg.Maya ):
            self.palMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kFixPatchNamesPalMenu'  ], 
                               lambda: xg.fixPatchNames(self.currentPalette()))
        self.palMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kDeleteCollectionPalMenu'  ], 
                   self.deletePalette)

        self.descMenu = menubar.addMenu(maya.stringTable[ 'y_xgDescriptionEditor.kDescriptionFileMenu'  ])
        self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kCreateDescriptionDescMenu'  ], self.createDescription)
        if ( xgg.Maya ):
            self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kDuplicateDescriptionDescMenu'  ], copyDescription)
            self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kMoveDescriptionToCollectionDescMenu'  ], moveDescription)
            self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kSelectDescriptionDescMenu'  ], 
                                    lambda: cmds.select( self.currentDescription(), replace=True )  )
            self.descMenu.addSeparator()
            self.bindMenu1 = QtGui.QMenu(maya.stringTable[ 'y_xgDescriptionEditor.kBindPatches'  ])
            self.addBindActions( self.bindMenu1, None ) 
            self.descMenu.addMenu(self.bindMenu1)
            self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kHideShowPatchesBasedOnGeometryVisibilityDescMenu'  ],
                 lambda: mel.eval("xgmSyncPatchVisibility"))

        self.descMenu.addSeparator()
        self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kSetStrayPercentageDescMenu'  ],strayPercentage)
        self.descMenu.addSeparator()
        self.descMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kDeleteDescriptionDescMenu'  ],self.deleteDescription)

        if ( xgg.Maya ):
            self.guidesMenu = menubar.addMenu(maya.stringTable[ 'y_xgDescriptionEditor.kGuidesFileMenu'  ])

            self.guidesMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kBakeGuideVerticesGuidesMenu'  ], 
                lambda: mel.eval("xgmBakeGuideVertices"))
            self.displayGuideRange = self.guidesMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kDisplayGuideRangeOfInfluenceGuidesMenu'  ], 
                 self.toggleVisualizer)
            self.displayGuideRange.setCheckable(True)

            self.mrMenu = QtGui.QMenu(maya.stringTable[ 'y_xgDescriptionEditor.kMentalrayFileMenu'  ])
            self.mrMenu.setVisible( False )
            self.mrMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kSetupMentalrayGeometryShadersMentalrayMenu'  ], 
                 lambda: mel.eval("xgmr -setupGeometryShader -description \"%s\" -palette \"%s\"" % (self.currentDescription(), self.currentPalette() )))
            self.mrAutoGeo = self.mrMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kAutoSetupMentalrayGeometryShadersMentalrayMenu'  ], 
                 self.onAutoCreateMR )
            self.mrAutoGeo.setCheckable( True )
            self.updateMentalrayControls()
            self.mrMenu.addSeparator()
            self.mrMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kApplyHairShaderMentalrayMenu'  ], 
                 lambda: mel.eval("xgmr -applyShader \"hair\" -description \"%s\" -palette \"%s\"" % (self.currentDescription(), self.currentPalette )))

        self.logMenu = menubar.addMenu(maya.stringTable[ 'y_xgDescriptionEditor.kLogFileMenu'  ])
        self.logMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kClearLogMenu'  ],
                               lambda: self.messageUI.clearLog())

        self.logMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kSaveLog'  ], lambda: self.messageUI.saveLog())
        val = self.getMessageLevel("warning")
        self.logWarnMenu = QtGui.QMenu(maya.stringTable['y_xgDescriptionEditor.kWarningLevelLogWarnMenu' ] % str(val))
        self.logWarnMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.k0LogWarnMenu'  ],
                                   lambda: self.setMessageLevel("warning",0))
        self.logWarnMenu.addAction("1",
                                   lambda: self.setMessageLevel("warning",1))
        self.logWarnMenu.addAction("2",
                                   lambda: self.setMessageLevel("warning",2))
        self.logWarnMenu.addAction("3",
                                   lambda: self.setMessageLevel("warning",3))
        self.logWarnMenu.addAction("4",
                                   lambda: self.setMessageLevel("warning",4))
        self.logWarnMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.k5LogWarnMenu'  ],
                                   lambda: self.setMessageLevel("warning",5))
        self.logMenu.addMenu(self.logWarnMenu)
        val = self.getMessageLevel("stats")
        self.logStatsMenu = QtGui.QMenu(maya.stringTable['y_xgDescriptionEditor.kStatisticsLevelLogStatsMenu' ] % str(val))
        self.logStatsMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.k0LogStatsMenu'  ],
                                   lambda: self.setMessageLevel("stats",0))
        self.logStatsMenu.addAction("1",
                                   lambda: self.setMessageLevel("stats",1))
        self.logStatsMenu.addAction("2",
                                   lambda: self.setMessageLevel("stats",2))
        self.logStatsMenu.addAction("3",
                                   lambda: self.setMessageLevel("stats",3))
        self.logStatsMenu.addAction("4",
                                   lambda: self.setMessageLevel("stats",4))
        self.logStatsMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.k5LogStatsMenu'  ],
                                   lambda: self.setMessageLevel("stats",5))
        self.logMenu.addMenu(self.logStatsMenu)
        val = self.getMessageLevel("debug")
        self.logDebugMenu = QtGui.QMenu(maya.stringTable['y_xgDescriptionEditor.kDebugLevelLogDebugMenu'] % str(val))
        self.logDebugMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.k0LogDebugMenu'  ],
                                   lambda: self.setMessageLevel("debug",0))
        self.logDebugMenu.addAction("1",
                                   lambda: self.setMessageLevel("debug",1))
        self.logDebugMenu.addAction("2",
                                   lambda: self.setMessageLevel("debug",2))
        self.logDebugMenu.addAction("3",
                                   lambda: self.setMessageLevel("debug",3))
        self.logDebugMenu.addAction("4",
                                   lambda: self.setMessageLevel("debug",4))
        self.logDebugMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.k5LogDebugMenu'  ],
                                   lambda: self.setMessageLevel("debug",5))
        self.logMenu.addMenu(self.logDebugMenu)

        self.helpMenu = menubar.addMenu(maya.stringTable[ 'y_xgDescriptionEditor.kHelpFileMenu'  ])
        self.helpMenu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kHelpOnXgenHelpMenu'  ], self._showHelp)
        
        return menubar

    def onFileMenuShow( self ):
        igDesc = xg.igDescription( self.currentDescription() )
        self.importGrooming.setEnabled( len(igDesc) )
        self.exportGrooming.setEnabled( len(igDesc) )

    def createDoubleFrame(self):
        frame1 = QtGui.QFrame()
        frame1.setFrameShadow(QtGui.QFrame.Sunken)
        frame1.setFrameShape(QtGui.QFrame.Panel) 
        layout = QtGui.QHBoxLayout()
        layout.setSpacing(0)
        layout.setContentsMargins(0,0,0,0)
        frame2 = QtGui.QFrame()
        frame2.setFrameShadow(QtGui.QFrame.Raised)
        frame2.setFrameShape(QtGui.QFrame.Panel) 
        layout.addWidget( frame2 )
        frame1.setLayout( layout )
        return (frame1,frame2)

    def createSunkenFrame(self):
        frame1 = QtGui.QFrame()
        frame1.setFrameShadow(QtGui.QFrame.Sunken)
        frame1.setFrameShape(QtGui.QFrame.Panel) 
        return (frame1,frame1)

    def createEmptyFrame(self):
        frame1 = QtGui.QWidget()
        return (frame1,frame1)

    def createTopBar(self,theLayout):
        # Create the row for selecting the current palette/description
        (frame1,frame2) = self.createEmptyFrame()
        currentHbox = QtGui.QHBoxLayout()
        currentHbox.setSpacing(4)
        currentHbox.setContentsMargins(4,4,4,4)

        # palettes
        label = QtGui.QLabel( maya.stringTable[ 'y_xgDescriptionEditor.kCollection'  ] )
        label.setAlignment( QtCore.Qt.AlignHCenter | QtCore.Qt.AlignVCenter )
        currentHbox.addWidget(label)
        self.palettes = _ComboBoxUI()
        self.connect(self.palettes, 
                    QtCore.SIGNAL("activated(const QString&)"), 
                    self.onSelectPalette )
        self.palettes.setMinimumWidth(50)
        currentHbox.addWidget(self.palettes)
        currentHbox.setStretchFactor(self.palettes,50)

        # descriptions
        label = QtGui.QLabel( maya.stringTable[ 'y_xgDescriptionEditor.kDescription'  ] )
        label.setAlignment( QtCore.Qt.AlignHCenter | QtCore.Qt.AlignVCenter )
        currentHbox.addWidget(label)
        self.descs = _ComboBoxUI()
        self.connect(self.descs, 
                    QtCore.SIGNAL("activated(const QString&)"), 
                    self.onSelectDescription )

        self.descs.setMinimumWidth(50)
        currentHbox.addWidget(self.descs)
        currentHbox.setStretchFactor(self.descs,50)

        # Assign the layout and pack widgets
        frame2.setLayout(currentHbox)
        theLayout.addWidget(frame1)

    def onSelectDescription( self, descr ):
        oldV = xgg.PlayblastWarning
        self.refresh('Description')
        self.setPreviewWarning( oldV )

        # tell others about the new selected description
        self.xgCurrentDescriptionChanged.emit( self.currentPalette(), self.currentDescription() )
        
    def onSelectPalette( self, palette ):
        oldV = xgg.PlayblastWarning
        self.refresh('Palette')
        self.setPreviewWarning( oldV )

        # tell others about the new selected palette
        self.xgCurrentDescriptionChanged.emit( palette, self.currentDescription() )

    def buildMenus(self):
        self.gmenu.clear()
        self.lmenu.clear()
        self.umenu.clear()
        self.allExprMenus = []
        self.buildMenu(self.gmenu,xg.globalRepo()+"descriptions/")
        self.buildMenu(self.lmenu,xg.localRepo()+"descriptions/")
        self.buildMenu(self.umenu,xg.userRepo()+"descriptions/")

    def buildMenu(self,topmenu,startDir):
        # first verify that the directory exists
        try:
            buf = os.stat(startDir)
        except:
            action = topmenu.addAction("<None>")
            action.setDisabled(True)
            return None
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
                self.allExprMenus.append(menu)
                if len(menus)>depth:
                    menus[depth] = menu
                else:
                    menus.append(menu)
                for item in files:
                    long = os.path.join(dir,item)
                    if os.path.isfile(long):
                        parts = os.path.splitext(item)
                        if parts[1] == ".xdsc":
                            menu.addAction(parts[0],
                                           lambda x=long: self.repoMan(x))
                    else:
                        subdirlist.insert(0,long)
                        depths.insert(0,depth+1)
            except:
                pass
        if topmenu.isEmpty():
            action = topmenu.addAction("<None>")
            action.setDisabled(True)

    def createPalExprs(self,theLayout):
        # UI for adding/deleting expressions
        label = QtGui.QLabel(maya.stringTable[ 'y_xgDescriptionEditor.kName'  ])
        label.setFixedWidth(int(labelWidth()))
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        label.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kNameAnn'  ])
        self.pexprName = QtGui.QLineEdit()
        self.pexprName.setFixedWidth(100)
        self.pexprName.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kExprNameAnn'  ])
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_]*")
        self.pexprName.setValidator(QtGui.QRegExpValidator(rx,self))
        self.pexprType = _ComboBoxUI()
        self.pexprType.addItem('float')
        self.pexprType.addItem('color')
        self.pexprType.addItem('vector')
        self.pexprType.addItem('point')
        self.pexprType.addItem('normal')
        self.pexprType.setFixedWidth(62)
        self.pexprType.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kExprTypeAnn'  ])
        self.pexprAddButton = QtGui.QToolButton()
        self.pexprAddButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgAddExpr.png"))
        self.pexprAddButton.setFixedSize(24,24)
        self.pexprAddButton.setToolTip(maya.stringTable[ 'y_xgDescriptionEditor.kCollectionExprAnn'  ])
        self.connect(self.pexprAddButton, QtCore.SIGNAL("clicked()"), self.addPalExpr)

        # expression names UI
        palExprNameW = QtGui.QWidget()
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)        
        layout.addSpacing(0)
        layout.addWidget(label)
        layout.addWidget(self.pexprName)
        layout.addSpacing(10)
        layout.addWidget(self.pexprType)
        layout.addSpacing(15)
        layout.addWidget(self.pexprAddButton)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        palExprNameW.setLayout(layout)

        # expressions layout
        self.palTabW = QtGui.QWidget()
        self.palTabLayout = QtGui.QVBoxLayout()
        self.palTabLayout.setSpacing(0)
        self.palTabLayout.setContentsMargins(0,0,0,0)
        self.palTabW.setLayout(self.palTabLayout)

        # Empty layout for palette expressions
        palExprW = QtGui.QWidget()
        self.palExprLayout = QtGui.QVBoxLayout()
        self.palExprLayout.setAlignment(QtCore.Qt.AlignTop)
        self.palExprLayout.setSpacing(0)
        self.palExprLayout.setContentsMargins(0,0,0,0)
        palExprW.setLayout(self.palExprLayout)

        self.palTabLayout.layout().addSpacing(5)
        self.palTabLayout.addWidget(palExprNameW)
        self.palTabLayout.addItem(QtGui.QSpacerItem(100,10))
        self.palTabLayout.addWidget(palExprW)
        theLayout.addWidget(self.palTabW)

        self.palExprExpandState = {}
    
    def addAttrExprsLayout(self, attr, expand=False):
        exprUI = PaletteExpressionUI(attr)
        exprUI.refresh()

        pal = self.currentPalette()
        key = pal + " " + attr
        self.palExprExpandState[key] = expand

        frameLayout = PaletteExpressionExpandUI(pal, makeLabel(attr), expand)
        frameLayout.addWidget(exprUI)
        self.palExprLayout.addWidget(frameLayout)

    def refreshPalExprs(self):
        while True:
            item = self.palExprLayout.takeAt(0)
            if not item:
                break
            else:
                itemWidget = item.widget()
                (type, attrName) = itemWidget.header.text.split()
                key = itemWidget.palette + " " + "custom_" + type + "_" + attrName
                self.palExprExpandState[key] = itemWidget.expanded
                destroyWidget(itemWidget)
        de = xgg.DescriptionEditor
        params = xg.customAttrs(de.currentPalette())
        for param in params:
            key = de.currentPalette() + " " + param
            expanded = False
            if self.palExprExpandState.has_key(key):
                expanded = self.palExprExpandState[key]
            self.addAttrExprsLayout(param, expanded)

    def addPalExpr(self):
        if self.pexprName.text()=="":
            return
        attr = "custom_"+str(self.pexprType.currentText())+"_"+str(self.pexprName.text())
        de = xgg.DescriptionEditor
        xg.addCustomAttr(attr,de.currentPalette())
        self.pexprName.setText("")
        self.addAttrExprsLayout(attr, True)
            
    def onRefreshPreviewAuto(self):
        self.setPlayblast( not( xgg.Playblast ) )
        self.updatePreviewControls()

    def onRefreshPreviewMode(self,act):
        self.previewMode = act.data()
        self.updatePreviewControls()

    def onRefreshPreviewSel(self):
        self.previewSel = not( self.previewSel )
        self.updatePreviewControls()

    def setPreviewWarning( self, v ):
        xgg.PlayblastWarning=v
        self.updatePreviewIcon()

    def updatePreviewIcon(self):
        if xgg.Maya:
            icon = self.iconPreview
            if xgg.Playblast:
                icon = self.iconPreviewRefresh
            elif xgg.PlayblastWarning:
                icon = self.iconPreviewWarning
            self.previewButton.setIcon(icon)

    def updatePreviewControls(self):
        self.previewAutoAction.setChecked( xgg.Playblast )
        self.previewGroup.actions()[self.previewMode].setChecked( True )
        self.previewSelAction.setChecked( self.previewSel )
        
        self.updatePreviewIcon()

    def onClearPreviewMode(self,act):
        self.clearMode = act.data()
        self.updateClearControls()

    def onClearPreviewSel(self):
        self.clearSel = not( self.clearSel )
        self.updateClearControls()

    def onClearPreviewCache(self):
        self.clearCache = not( self.clearCache )
        self.updateClearControls()

    def updateClearControls(self):
        self.clearGroup.actions()[self.clearMode].setChecked( True )
        self.clearSelAction.setChecked( self.clearSel )
        self.clearCacheAction.setChecked( self.clearCache )
    
    def onAutoCreateMR(self):
        self.autoCreateMR = not( self.autoCreateMR )
        self.updateMentalrayControls()

    def updateMentalrayControls(self):
        self.mrAutoGeo.setChecked( self.autoCreateMR )

    def getPreviewText(self):
        return self.getSelModeText( self.previewSel, self.previewMode )

    def getClearText(self):
        return self.getSelModeText( self.clearSel, self.clearMode, self.clearCache )

    def getSelModeText( self, sel, mode, cache=False ):
        t =""
        if sel:
            t +=  maya.stringTable[ 'y_xgDescriptionEditor.kSelected'  ] + ": "
        if mode==self.PreviewMode.All:
            t+= maya.stringTable[ 'y_xgDescriptionEditor.kAll'  ]
        elif mode==self.PreviewMode.Collection:
            t+= maya.stringTable[ 'y_xgDescriptionEditor.kCurrentCollection'  ]
        elif mode==self.PreviewMode.Description:
            t+= maya.stringTable[ 'y_xgDescriptionEditor.kCurrentDescription'  ]
        if cache:
            t+= maya.stringTable[ 'y_xgDescriptionEditor.kClearArchiveCache'  ]

        return t

    def cullSelectedPrimitives(self):
        mel.eval('xgmSelectedPrims -c "'+self.currentDescription()+'"')

    def appendFacesAction(self):
        self.modifyBinding("Append")
        
    def replaceFacesAction(self):
        self.modifyBinding("Replace")
        
    def removeFacesAction(self):
        self.modifyBinding("Remove")
        
    def mapFacesAction(self):
        self.modifyBinding("Map")
        
    def addBindActions( self, menu, bar ):
        button = None
        if bar:
            button = bar.addButton("xgBindFaces.png",
                                   maya.stringTable[ 'y_xgDescriptionEditor.kModifyCurrentDescriptionsFaceBindings'  ],
                                   self.appendFacesAction )
            button.setPopupMode(QtGui.QToolButton.MenuButtonPopup)
        else:
            menu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kAddFacesBindMenu'  ], self.appendFacesAction )

        menu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kReplaceFacesBindMenu'  ], self.replaceFacesAction )
        menu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kRemoveFacesBindMenu'  ], self.removeFacesAction )
        menu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kMapFacesBindMenu'  ], self.mapFacesAction )
        menu.addSeparator()
        menu.addAction(maya.stringTable[ 'y_xgDescriptionEditor.kSelectFacesBindMenu'  ], self.selectBinding )

        if button:
            button.setMenu(menu)

    def update(self):
        """ refresh the editor and tell others about the update """
        self.refresh("Full")
        self.xgCurrentDescriptionChanged.emit( self.currentPalette(), self.currentDescription() )

    def createShelfBar(self,theLayout):
        
        #currentRow = QtGui.QWidget()
        (frame1,frame2) = self.createSunkenFrame()
        currentHbox = QtGui.QHBoxLayout()
        currentHbox.setSpacing(0)
        currentHbox.setContentsMargins(0,0,0,0)
        
        # Create the toolbar of shelf buttons
        bar = ToolBarUI(QtCore.QSize(32,32),2)
        
        self.iconPreview = QtGui.QIcon(xg.iconDir()+"xgPreview.png")
        self.iconPreviewRefresh = QtGui.QIcon(xg.iconDir()+"xgPreviewRefresh.png")
        self.iconPreviewWarning = QtGui.QIcon(xg.iconDir()+"xgPreviewWarning.png")

        # Add Preview button
        button = bar.addButton( "xgPreview.png", maya.stringTable[ 'y_xgDescriptionEditor.kPreview'  ], self.previewCIP )
        button.setAutoRaise(True)
        button.setPopupMode(QtGui.QToolButton.MenuButtonPopup)
        button.setToolTip( maya.stringTable[ 'y_xgDescriptionEditor.kUpdateTheXGenPreview'  ] )

        menu = QtGui.QMenu()

        self.previewAutoAction = menu.addAction( maya.stringTable[ 'y_xgDescriptionEditor.kUpdatePreviewAutomatically'  ], self.onRefreshPreviewAuto )
        menu.addSeparator()
        self.previewGroup = QtGui.QActionGroup(menu)
        act = QtGui.QAction(maya.stringTable[ 'y_xgDescriptionEditor.kPreviewCurrentDescriptionOnly'  ], self.previewGroup )
        act.setData(self.PreviewMode.Description)
        act.setCheckable(True)
        act = QtGui.QAction(maya.stringTable[ 'y_xgDescriptionEditor.kPreviewAllDescriptionsinCollection'  ], self.previewGroup )
        act.setData(self.PreviewMode.Collection)
        act.setCheckable(True)
        act = QtGui.QAction(maya.stringTable[ 'y_xgDescriptionEditor.kPreviewAllCollections'  ], self.previewGroup )
        act.setData(self.PreviewMode.All)
        act.setCheckable(True)
        self.previewGroup.triggered.connect( self.onRefreshPreviewMode )
        menu.addActions( self.previewGroup.actions() )
        menu.addSeparator()
        self.previewSelAction = menu.addAction( maya.stringTable[ 'y_xgDescriptionEditor.kPreviewSelectedObjectsOnly'  ], self.onRefreshPreviewSel )

        self.previewAutoAction.setCheckable(True)
        self.previewSelAction.setCheckable(True)

        button.setMenu(menu)
        self.previewButton = button
        self.previewMenu = menu
        self.updatePreviewControls()
        

        # Add Clear button
        button = bar.addButton( "xgPreviewClear.png", maya.stringTable[ 'y_xgDescriptionEditor.kClearPreview'  ], self.clearPreview )
        button.setAutoRaise(True)
        button.setPopupMode(QtGui.QToolButton.MenuButtonPopup)
        button.setToolTip( maya.stringTable[ 'y_xgDescriptionEditor.kClearTheXGenPreview'  ] )

        menu = QtGui.QMenu()
        self.clearGroup = QtGui.QActionGroup(menu)
        act = QtGui.QAction( maya.stringTable[ 'y_xgDescriptionEditor.kClearCurrentDescriptionOnly'  ], self.clearGroup )
        act.setData(self.PreviewMode.Description)
        act.setCheckable(True)
        act = QtGui.QAction( maya.stringTable[ 'y_xgDescriptionEditor.kClearAllDescriptionsInCollection'  ], self.clearGroup )
        act.setData(self.PreviewMode.Collection)
        act.setCheckable(True)
        act = QtGui.QAction( maya.stringTable[ 'y_xgDescriptionEditor.kClearAllCollections'  ], self.clearGroup )
        act.setData(self.PreviewMode.All)
        act.setCheckable(True)
        self.clearGroup.triggered.connect( self.onClearPreviewMode )
        menu.addActions( self.clearGroup.actions() )
        menu.addSeparator()
        self.clearSelAction = menu.addAction( maya.stringTable[ 'y_xgDescriptionEditor.kClearSelectedObjectsOnly'  ], self.onClearPreviewSel )        
        self.clearSelAction.setCheckable(True)
        self.clearCacheAction = menu.addAction( maya.stringTable[ 'y_xgDescriptionEditor.kClearCachedArchives'  ], self.onClearPreviewCache )        
        self.clearCacheAction.setCheckable(True)

        button.setMenu(menu)
        self.clearButton = button
        self.clearMenu = menu
        self.updateClearControls()

        # Create description
        bar.addButton("xgCreateDescription.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kCreateANewDescription'  ],
                      self.createDescription )

        # Bind faces
        self.bindMenu = QtGui.QMenu()
        self.addBindActions( self.bindMenu, bar ) 

       # Add/move guide
        button = bar.addButton("xgGuideContext.png",
                     maya.stringTable[ 'y_xgDescriptionEditor.kAddOrMoveGuidesForTheCurrentDescription'  ],
                     lambda: mel.eval("XgGuideTool"))
        # Toggle guide visibility
        bar.addButton("xgToggleGuide.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kToggleVisibilityOfCurrentDescriptionsGuides'  ],
                      lambda: xg.toggleGuideDisplay(self.currentDescription()))
        # Toggle guide reference
        bar.addButton("xgToggleGuideReference.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kToggleAbilityToSelectCurrentDescriptionsGuides'  ],
                      lambda: xg.toggleGuideReference(self.currentDescription()))
        # Flip guides across model
        bar.addButton("xgFlipGuides.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kFlipSelectedGuidesAcrossXAxis'  ],
                      lambda: mel.eval("xgmFlipGuides(\""+
                                       self.currentDescription()+"\")"))
        # Sync patch to geometry visibility
        #bar.addButton("xgSyncPatchVisibility.png",
        #              _L10N( kMatchXgenPatchVisibilityToGeometryVisibility, "Match XGen patch visibility to geometry visibility." ),
        #              lambda: mel.eval("xgmSyncPatchVisibility"))

        # Toggle selection of xgen and geometry
        bar.addButton("xgSelectionToggle.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kToggleBetweenXgenPatchesAndGeometry'  ],
                      lambda: xg.selectionToggle(self.currentDescription()))

        # Isolate select of primitives
        bar.addButton("xgPrimSelection.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kCreatePrimitiveSelectionBox'  ],
                      self.primSelectionContext )

        # Cull primitives
        bar.addButton("xgCullPrimContextSelect.png",
                      maya.stringTable[ 'y_xgDescriptionEditor.kCullPrimitivesWithinSelectionBox'  ],
                      self.cullSelectedPrimitives )

        # Add the toolbar to main layout
        currentHbox.addWidget(bar)
        currentHbox.addStretch()
        
        frame2.setLayout(currentHbox)
        theLayout.addWidget(frame1)
        
    def createTabBar(self,theLayout):
        """
        Create the tab bar.
        This includes importing the custom UI modules.
        """

        # Create the symbol table for the UI.
        # We take:
        # - all the UI classes from the global namespace
        # - all the UI classes from globalRepo
        # - all the UI classes from localRepo
        # - all the UI classes from userRepo.
        # Each stage can override the previous stages, so the user can override
        # everything.
        self.uiclasses = dict()
        xgenmodules = set(xgapi.availableModules())
        for name in globals():
            cls = globals()[name]
            if _isUI(name, cls, xgenmodules):
                self.uiclasses[name] = cls
        for (name, cls) in _importUI(xgapi.globalRepo()).items():
            self.uiclasses[name] = cls
        for (name, cls) in _importUI(xgapi.localRepo()).items():
            self.uiclasses[name] = cls
        for (name, cls) in _importUI(xgapi.userRepo()).items():
            self.uiclasses[name] = cls

        
        def addTab(tabset, typename, clsname, BlankWidget):
            # It's critical we get the right number of widgets, so if we fail,
            # print an error and put in a blank widget.  Two ways of 
            # failing: either no UI defined, or the UI has an error.
            tabclassname = typename + clsname + 'TabUI'
            if tabclassname not in self.uiclasses:
                print maya.stringTable[ 'y_xgDescriptionEditor.kNoUiDefinedFor'  ] % (typename, clsname)
                tabset.addWidget(BlankWidget(typename))
                return
            try:
                TabClass = self.uiclasses[tabclassname]
                widget = TabClass()
                tabset.addWidget(widget)
            except Exception, e:
                print maya.stringTable[ 'y_xgDescriptionEditor.kErrorBuildingUiFor'  ] % (typename, clsname)
                traceback.print_exc()
                tabset.addWidget(BlankWidget(typename))

        # Create the tabs
        self.tabs = QtGui.QTabWidget()
        self.tabs.setMovable( True )
        
        tabsOpt = QtGui.QStyleOptionTabWidgetFrame()
        tabsOpt.lineWidth = 0
        self.tabs.initStyleOption(tabsOpt)

        # Grooming tab is only available with Maya
        self.brushTab = None
        if xgg.Maya:
            self.brushTab = BrushTabUI(self)
        
        # Primitive tab
        self.primitiveTab = StackUI(margin=0)
        self.primitiveTab.setParent(self)
        self.primitiveTab.setVisible(False)
        for type in xgg.PrimitiveTypes():
            addTab(self.primitiveTab, type, "Primitive", PrimitiveTabBlankUI)
        # FX Module tab
        self.fxStackTab = FXStackTabUI()
        # Generator tab
        self.generatorTab = StackUI()
        for type in xgg.GeneratorTypes():
            addTab(self.generatorTab, type, "Generator", GeneratorTabBlankUI)
        # Renderer tab
        self.rendererTab = StackUI()
        for type in xgg.RendererTypes():
            addTab(self.rendererTab, type, "Renderer", RendererTabBlankUI)
        # LOD tab
        self.lodTab = LodTabUI()

        # Previewer tab
        self.previewerTab = StackUI(margin=0)
        for type in xgg.PreviewerTypes:
            widget = eval(type+'PreviewerTabUI()')
            self.previewerTab.addWidget(widget)

        # tool manager tab
        self.utilitiesTab = UtilitiesTabUI()

        # palette expressions tab
        self.palExprsTab = StackUI()
        self.createPalExprs(self.palExprsTab)

        # Add the tabs, We reorder them to be like the user workflow
        self.tabs.addTab(createScrollArea(self.generatorTab) ,maya.stringTable[ 'y_xgDescriptionEditor.kPrimitives'  ])
        self.tabs.addTab(createScrollArea(self.createPreviewAndRenderTab()),maya.stringTable[ 'y_xgDescriptionEditor.kPreviewRender'  ])
        self.tabs.addTab(createScrollArea(self.fxStackTab),maya.stringTable[ 'y_xgDescriptionEditor.kModifiers'  ])
        if xgg.Maya:
            self.tabs.addTab(createScrollArea(self.brushTab),maya.stringTable[ 'y_xgDescriptionEditor.kGrooming'  ])
        self.tabs.addTab(createScrollArea(self.utilitiesTab),maya.stringTable[ 'y_xgDescriptionEditor.kUtilities'  ])
        self.tabs.addTab(createScrollArea(self.palExprsTab),maya.stringTable[ 'y_xgDescriptionEditor.kExpressions'  ])

        theLayout.addWidget(self.tabs)

    def activateTab( self, whichOne ):
        """ 
            Makes a tab the current widget given a name.
            note: As tab widgets are now localized, you can't just pass the Ascii name. 
            Instead you must use the localize string table to refer the tab you want to activate:
            e.g. maya.stringTable[ 'y_xgDescriptionEditor.kGenerator' ]
        """
        count = self.tabs.count()
        for i in range(count):
            text = self.tabs.tabText(i)
            if text == whichOne:
                self.tabs.setCurrentIndex(i)
                return

    def createPreviewAndRenderTab(self):
        newTab = QtGui.QWidget()
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        layout.setSpacing(0)
        layout.setContentsMargins(3,3,3,3)
        newTab.setLayout(layout)
        
        expand = ExpandUI(maya.stringTable[ 'y_xgDescriptionEditor.kPreviewSettings'  ])
        expand.addWidget(self.previewerTab)
        layout.addWidget(expand)

        expand = ExpandUI(maya.stringTable[ 'y_xgDescriptionEditor.kRenderSettings'  ])
        expand.addWidget(self.rendererTab)
        layout.addWidget(expand)

        expand = ExpandUI(maya.stringTable[ 'y_xgDescriptionEditor.kLODSettings'  ])
        expand.addWidget(self.lodTab)
        layout.addWidget(expand)
        
        return newTab

    def setPlayblast(self, v):
        xgg.Playblast=v
        if ( xgg.Maya and ((xgg.Playblast and not cmds.objExists('xgmRefreshPreview')) or (not xgg.Playblast and not cmds.objExists('xgmPreviewWarning'))) ):
            # this will avoid logging xgmAddExpressions on the undo stack when it's not necessary
            mel.eval("xgmAddExpressions")

    def createDescription(self):
        if ( xgg.Maya ):
             mel.eval('XgCreateDescription();')
        else:
            createDescription()

    def openLibraryWindow(self):
        if ( xgg.Maya ):
             mel.eval("XGenLibraryWindow")

    def playblast(self):
        if xgg.Playblast:
            if (QtGui.QApplication.keyboardModifiers() == QtCore.Qt.ShiftModifier) :
                pass # Holding shift. Ignore preview request.
            else:
                self.preview(False,False)
        else:
            self.setPreviewWarning(True)
        
    def previewCIP(self):
        if xgg.maya:
            mel.eval("XgPreview")
        else:
            self.preview()

    def clearPreview(self):
        self.preview(True)

    def preview(self,clean=False,progress=True,idle=True):
        if not xgg.Maya:
            return

        with self.setAttrGuard():
            # move focus to parent to make sure that any outstanding widget values are set
            # before refreshing.
            self.setFocus()
        
        text = ""
        sel = False
        mode = 0
        cache=False

        cmd = 'xgmPreview '
        if clean:
            cmd += '-clean '
            text = self.getClearText()
            sel = self.clearSel
            mode = self.clearMode
            cache = self.clearCache
            self.setPreviewWarning(True)
        else:
            self.setPreviewWarning(False)
            text = self.getPreviewText()
            sel = self.previewSel
            mode = self.previewMode
            if progress:
                setProgressInfo(maya.stringTable[ 'y_xgDescriptionEditor.kPreviewProgressBar'  ] % text)
                cmd += '-pb '

        if sel:
            cmd += '-s '
        if cache:
            cmd += '-cache '
        cmd += '{'
        first = True
        if mode==self.PreviewMode.All:
            # get all of the descriptions in scene to preview
            # or add as option to xgmPreview
            palettes = uiPalettes()
            for pal in palettes:
                descs = xg.descriptions(pal)
                for desc in descs:
                    if not first:
                        cmd += ','
                    cmd += '"'+desc+'"'
                    first = False
        elif mode==self.PreviewMode.Collection:
            # get all of the descriptions in current palette to preview
            # or add as option to xgmPreview
            descs = xg.descriptions(self.currentPalette())
            for desc in descs:
                if not first:
                    cmd += ','
                cmd += '"'+desc+'"'
                first = False
        elif mode==self.PreviewMode.Description:
            cmd += '"'+self.currentDescription()+'"'
        cmd += '}'

        # register command for idle execution
        if idle:
            self.previewer.add( cmd )
        else:
            mel.eval(cmd)

    def currentPalette(self):
        return str(self.palettes.currentText())

    def setCurrentPalette(self,palette):
        for i in range(self.palettes.count()):
            pal = self.palettes.itemText(i)
            if pal == palette:
                self.palettes.setCurrentIndex(i)
                self.refresh("Palette")
                break
            i+=1

        # tell others about the new description
        self.xgCurrentDescriptionChanged.emit( palette, self.currentDescription() )
    
    def currentDescription(self):
        ns = xg.objNameSpace(self.currentPalette())
        return str(ns+self.descs.currentText())

    def setCurrentDescription(self,description):
        pal = xg.palette(description)
        if pal == "":
            return
        if pal != self.currentPalette():
            self.setCurrentPalette(pal)
        sdesc = xg.stripNameSpace(description)
        for i in range(self.descs.count()):
            desc = self.descs.itemText(i)
            if desc == sdesc:
                self.descs.setCurrentIndex(i)
                self.refresh("Description")
                break
            i+=1

        # tell others about the new description
        self.xgCurrentDescriptionChanged.emit( pal, description )

    def activePrimitive(self):
        return xg.getActive(self.currentPalette(),
                self.currentDescription(),"Primitive")
    
    def activeGenerator(self):
        return xg.getActive(self.currentPalette(),
                self.currentDescription(),"Generator")
    
    def activeRenderer(self):
        return xg.getActive(self.currentPalette(),
                self.currentDescription(),"Renderer")
    
    def activePreviewer(self):
        return xg.getActive(self.currentPalette(),
                self.currentDescription(),"Previewer")
    
    def setActive(self,objectType,newActive,previewer=False,clean=True):
        """Set the active object type both in XGen and the editor."""
        
        oldPlayblast = xgg.Playblast
        if previewer == False:
            xgg.Playblast = False
        
        if previewer:
            current = xg.getActive(self.currentPalette(),
                                   self.currentDescription(),"Previewer")
        else:
            current = xg.getActive(self.currentPalette(),
                                   self.currentDescription(),objectType)
        if current != newActive+objectType:
            xg.setActive(self.currentPalette(),self.currentDescription(),
                         newActive+objectType,previewer)
        if objectType == "Primitive":
            index = xgg.PrimitiveTypes().index(newActive)
            self.primitiveTab.setCurrent(index)
            widget = self.primitiveTab.widget()
            widget.setActiveByTypeName(newActive)
            widget.refresh()
            self.fxStackTab.rebuildFXStackUI()
            if xgg.Maya and clean:
                mel.eval('xgmPreview -clean {"'+self.currentDescription()+'"}')
        elif objectType == "Generator":
            index = xgg.GeneratorTypes().index(newActive)
            self.generatorTab.setCurrent(index)
            widget = self.generatorTab.widget()
            widget.setActiveByTypeName(newActive)
            widget.refresh()
        elif objectType == "Renderer":
            if previewer:
                index = xgg.PreviewerIndex[newActive]
                self.previewerTab.setCurrent(index)
                widget = self.previewerTab.widget()
                #widget.setActiveByTypeName(newActive)
                widget.refresh()
            else:
                index = xgg.RendererTypes().index(newActive)
                self.rendererTab.setCurrent(index)
                widget = self.rendererTab.widget()
                widget.setActiveByTypeName(newActive)
                widget.refresh()

        xgg.Playblast = oldPlayblast
        self.playblast()

    def getFXModules(self):
        """Returns the list of modules for the current description"""
        return xg.fxModules( self.currentPalette(), self.currentDescription() )

    def getFXModulesReversed(self):
        """Returns a list of the modules in reverse order, with the last module executed as the first"""
        return self.getFXModules()[::-1] 

    def setAttr(self,object,attr,value, undoRequired=False):
        """Set an attribute via the editor."""
        desc=""
        obj=""
        if object!="Palette":
            desc = self.currentDescription()
            if object!="Description":
                obj = object
        
        try:            
            if xgg.Maya and undoRequired:
                with xg.undoable(attr):
                    cmds.xgmSetAttr( a=attr, v=value, p=self.currentPalette(), d=desc, o=obj )
            else:
                xg.setAttr( attr, value, self.currentPalette(), desc, obj )
        except:
            import traceback
            traceback.print_exc()            
    
    def getAttr(self,object,attr):
        """Get an attribute via the editor."""
        desc=""
        obj=""
        if object!="Palette":
            desc = self.currentDescription()
            if object!="Description":
                obj = object
        return xg.getAttr(attr,self.currentPalette(),desc,obj)

    def setAttrCmd( self, object, attr, value ):
        """ Set attribute value through an undoable command. Returns True if the value was changed"""         
        current = self.getAttr( object, attr )
        changeValue = current != value
        if changeValue:
            # don't set the attribute if value is different than the current value
            self.setAttr( object, attr, value, self._undoRequired )
        return changeValue
    
    def enableUI(self,state):
        """Enable/disable the whole UI."""
        self.primitiveTab.setVisible(state)
        self.fxStackTab.setVisible(state)
        self.generatorTab.setVisible(state)
        self.rendererTab.setVisible(state)
        self.lodTab.setVisible(state)
        self.previewerTab.setVisible(state)
        self.utilitiesTab.setVisible(state)
        self.palExprsTab.setVisible(state)
        if xgg.Maya:
            self.brushTab.setVisible(state)

        self.welcomeUI.setVisible(not state)
        self.mainUI.setVisible(state)

        self.xgDescriptionEditorEnableUI.emit( state )

    def refresh(self,type):
        """Refresh the contents of the description editor.
        This method supports a full refresh, a palette change, or a
        description change. The mini modification is always made.
        """

        with self.setAttrGuard():            
            self.enableUI(True)
            check = type
            if check == "Full":
                # A full refresh will rebuild the palette list
                cpal = self.currentPalette()
                self.palettes.clear()
                palettes = list(uiPalettes())
                if len(palettes) == 0:
                    self.descs.clear()
                    self.enableUI(False)
                    return
                index, found = 0, 0
                palettes.sort()
                for pal in palettes:
                    self.palettes.addItem(pal)
                    if pal == cpal:
                        found = index
                    index += 1
                self.palettes.setCurrentIndex(found)
                check = "Palette" # fall through                        

            if check == "Palette":
                # The palette changed so set up the description list
                self.refreshPalExprs()
                cpal = self.currentPalette()
                cdesc = xg.stripNameSpace(self.currentDescription())
                self.descs.clear()
                descs = list(xg.descriptions(cpal))
                if len(list(xg.descriptions())) == 0 : 
                    self.enableUI(False)
                    return
                index, found = 0, 0
                descs.sort()
                for desc in descs:
                    sdesc = xg.stripNameSpace(desc)
                    self.descs.addItem(sdesc)
                    if sdesc == cdesc:
                        found = index
                    index += 1
                self.descs.setCurrentIndex(found)
                check = "Description"
            
            if check == "Description":
                # The description changed so update tabs
                cpal = self.currentPalette()
                cdesc = self.currentDescription()

                if len(xg.stripNameSpace(cdesc))==0:
                    return

                value = self.activePrimitive()
                self.setActive('Primitive',value[:len(value)-9],clean=False)
                value = self.activeGenerator()
                self.setActive('Generator',value[:len(value)-9])
                value = self.activeRenderer()
                self.setActive('Renderer',value[:len(value)-8])
                value = self.activePreviewer()
                self.setActive('Renderer',value[:len(value)-8],True)

                self.lodTab.refresh()
                self.generatorTab.widget().refresh()

                self.xgCurrentDescriptionChanged.emit( cpal, cdesc )
            
            if xgg.Maya:
                xg.invokeCallbacks("CurrentDescriptionSet",
                                   [self.currentDescription()])            

    def editPath(self):
        value = xg.getAttr("xgDataPath",self.currentPalette())
        (res,ok) = QtGui.QInputDialog.getText(self,maya.stringTable[ 'y_xgDescriptionEditor.kEditFilePath2'  ],
                    maya.stringTable[ 'y_xgDescriptionEditor.kEditXGenPathDescription'  ],
                    QtGui.QLineEdit.Normal,value)
        if ok:
             self.setAttrCmd(self.currentPalette(),"xgDataPath",str(res))          
    
    def modifyBinding(self,mode):
        if xgg.Maya:
            cpal = self.currentPalette()
            cdesc = self.currentDescription()
            if not cpal:
                return
            if not cdesc:
                return

            with xg.undoable('Face:'+mode):
                if mode=="Map":
                    mapBindings(cpal,cdesc)
                else:
                    xg.modifyFaceBinding(cpal,cdesc,mode)
                if self.autoCreateMR and mel.eval('exists "xgmr"'):
                    # update the bound patches
                    cmds.xgmr( ugs=True, description=cdesc, palette=cpal )
            self.playblast()
       
    def repoMan(self,value):
        # if the value is "save" then we raise a browser in user repo
        if str(value)=="save":
            startDir  = xg.userRepo() + "descriptions/"
            try:
                buf = os.stat(startDir)
            except:
                # if the directory isn't there the browser will send us to
                # some unexpected location
                os.makedirs(startDir)
            result = fileBrowserDlg(self,startDir,"*.xdsc","out")
            if len(result):
                if not result.endswith(".xdsc"):
                    result += ".xdsc"
                xg.exportDescription(self.currentPalette(),
                                     self.currentDescription(),result)
                self.buildMenus()
        else:
            try:
                filename = str(value)
                buf = os.stat(filename)
                name = xg.importDescription(self.currentPalette(),filename)
                self.refresh("Full")
                self.setCurrentDescription(name)
            except:
                xg.XGError(maya.stringTable[ 'y_xgDescriptionEditor.kTheGivenDescriptionDoesntExist'  ] % filename)
                self.buildMenus()
                return

    def selectBinding(self):
        if xgg.Maya:
            cpal = self.currentPalette()
            cdesc = self.currentDescription()
            geoms = xg.boundGeometry(cpal,cdesc)
            faceStr = []
            with xg.undoable('Face:Select'):
                cmds.select(None)
                for geom in geoms:
                    faces = xg.boundFaces(cpal,cdesc,geom,True)
                    for face in faces:
                        faceStr.append(geom+".f["+str(face)+"]")
                cmds.select(faceStr,replace=True)
                    
    def primSelectionContext(self,type="Selection"):
        if xgg.Maya:
            cmd = "xgmPrimSelectionContext -q -ex xgenPrim"+type+"Instance"
            if not mel.eval(cmd):
                cmd = "xgmPrimSelectionContext "
                if type=="Isolate":
                    cmd += "-is "
                cmd += "xgenPrim"+type+"Instance"
                mel.eval(cmd)
            cmds.setToolTo("xgenPrim"+type+"Instance")

    def guideSculptContext(self,options=False):
        if xgg.Maya:
            cmd = "xgmGuideSculptContext -q -ex xgmGuideSculptTool"
            if not mel.eval(cmd):
                cmd = "xgmGuideSculptContext xgmGuideSculptTool"
                mel.eval(cmd)
            cmds.setToolTo("xgmGuideSculptTool")

            if options:
                cmds.toolPropertyWindow()

    def batchExportArchives(self):
		if self.arcBatchExport==None:
			self.arcBatchExport = xgmArchiveExportBatchUI( True )
		self.arcBatchExport.exec_()

    def exportArchives(self):
		if self.arcExport==None:
			self.arcExport = xgmArchiveExportBatchUI( False )
		self.arcExport.exec_()

    def exportPatches(self):
		strCurrentScene = cmds.file( q=True, sn=True )
		strSceneName = ""
		if strCurrentScene:
			strScenePath = os.path.dirname( strCurrentScene )
			strSceneFile = os.path.basename( strCurrentScene )
			strSceneName = os.path.splitext( strSceneFile )[0];
		else:
			xg.XGError(maya.stringTable[ 'y_xgDescriptionEditor.kYouMustSaveTheSceneFirst'  ])
			return 

		dialog = ExportUI()
                dialog.setWindowTitle(maya.stringTable[ 'y_xgDescriptionEditor.kExportPatchesForBatchRenderDialog'  ])
		result = dialog.exec_()
		if result == QtGui.QDialog.Accepted:
			global Anim, ExportStartFrame, ExportEndFrame
			ExportStartFrame = dialog.getStartFrame()
			ExportEndFrame = dialog.getEndFrame()

			cmdAlembicBase = 'AbcExport -j "' 
			Anim = dialog.getAnim()
			if Anim:
				cmdAlembicBase = cmdAlembicBase + '-frameRange '+str(ExportStartFrame)+' '+str(ExportEndFrame)
			cmdAlembicBase = cmdAlembicBase + ' -uvWrite -attrPrefix xgen -worldSpace'
			palette = cmds.ls( exactType="xgmPalette" )
			for p in range( len(palette) ):
				filename = strScenePath+ "/" + strSceneName + "__" + xgmExternalAPI.encodeNameSpace(str(palette[p])) + ".abc"
				descShapes = cmds.listRelatives( palette[p], type="xgmDescription", ad=True )
				cmdAlembic = cmdAlembicBase
				for d in range( len(descShapes) ):
					descriptions = cmds.listRelatives( descShapes[d], parent=True )
					if len(descriptions):
						patches = xg.descriptionPatches(descriptions[0])
						for patch in patches:
							cmd = 'xgmPatchInfo -p "'+patch+'" -g';
							geom = mel.eval(cmd)
							geomFullName = cmds.ls( geom, l=True )
							cmdAlembic += " -root " + geomFullName[0]
                
				cmdAlembic = cmdAlembic + ' -stripNamespaces -file \''+ filename+ '\'";';
				print cmdAlembic
				mel.eval(cmdAlembic)

    def toggleVisualizer(self):
        visual = cmds.ls(type="xgmConnectivity")
        if visual:
            for v in visual:
                p = cmds.listRelatives(v,parent=True)
                cmds.delete(p)
        else:        
            selection = cmds.ls(sl=True)
            parent = cmds.listRelatives(self.currentPalette(),parent=True)
            if parent:
                xform = cmds.createNode("transform",name="xgmConnectivity#",
                                        parent=parent[0])
            else:
                xform = cmds.createNode("transform",name="xgmConnectivity#")
            node = cmds.createNode("xgmConnectivity",name=xform+"Shape",
                                   parent=xform)
            cmds.select(selection,r=True)

    def onPaletteDelete(self, pal):
        for key in self.palExprExpandState.keys():
            if key.startswith(pal + " "):
                del self.palExprExpandState[key]

    def deletePalette(self):
        xg.deletePalette(self.currentPalette())
        self.refresh("Full")
        
    def deleteDescription(self):
        xg.deleteDescription(self.currentPalette(),self.currentDescription())
        self.refresh("Full")

    def getMessageLevel( self, type ):
        """ return message value from option vars or default value if doesn't exist """
        try:
            if xgg.Maya:
                val = xg.getOptionVar( self.optionVars[type] )
            else:
                val = None
        except:
            traceback.print_exc()
            return None

        if val == None:
            val = xg.getMessageLevel(type)
        return val
        
    def setMessageLevel(self,type,level):
        """set message level and save in option var """
        if type=="debug":
            self.logDebugMenu.setTitle(maya.stringTable[ 'y_xgDescriptionEditor.kDebugLevelMenuChange'  ] % str(level))
            xg.setMessageLevel(type,level)
        elif type=="warning":
            self.logWarnMenu.setTitle(maya.stringTable[ 'y_xgDescriptionEditor.kWarningLevelMenuChange'  ] % str(level))
            xg.setMessageLevel(type,level)
        elif type=="stats":
            self.logStatsMenu.setTitle(maya.stringTable[ 'y_xgDescriptionEditor.kStatisticsLevelMenuChange'  ] % str(level))
            xg.setMessageLevel(type,level)
        else:
            raise Exception('setMessageLevel: wrong type')
        
        xg.setOptionVarInt( self.optionVars[type], level )

    def updateMessageLevel( self ):
        """ update message level from option vars """
        val = self.getMessageLevel( 'warning' )
        self.setMessageLevel( 'warning', val )
        val = self.getMessageLevel( 'debug' )
        self.setMessageLevel( 'debug', val )
        val = self.getMessageLevel( 'stats' )
        self.setMessageLevel( 'stats', val )

    def _showHelp(self):
        cmds.showHelp("XGen")

    def quit(self):
        QtGui.qApp.quit()
    
       

def createDescriptionEditor(showIt=True):
    """Create a description editor."""

    if xgg.DescriptionEditor is None:   
        DescriptionEditorUI()
        # delete the previous dock control if there is one
        if cmds.dockControl("XGenDockableWidget", q=True, ex=True):
            cmds.deleteUI("XGenDockableWidget")
        # to set it up in Maya as a panel,  it'll need an object name 
        descui =  xgg.DescriptionEditor
        descui.setObjectName("XGenDescriptionEditor")
        
        
    if showIt:
        # show it in the dock
        # if the user hit the close button, it actually only hides the widget, so we both raise it and make sure it's visible.
        if cmds.dockControl("XGenDockableWidget", q=True, ex=True):
            cmds.dockControl("XGenDockableWidget", e=True, vis=True, r=True)
        else:
            gMainPane = mel.eval('$gMainPane=$gMainPane') # API WORKAROUND: Extract variable from MEL into python as there is no maya.mel.variable() function
            allowedAreas = ['right', 'left']
            cmds.dockControl("XGenDockableWidget", area="right", vis=True, allowedArea=allowedAreas, content="XGenDescriptionEditor", parent=gMainPane, label=maya.stringTable[ 'y_xgDescriptionEditor.kXgen'  ])
        xgg.DescriptionEditor.refresh("Full")

    return xgg.DescriptionEditor


def refreshDescriptionEditor():
    """Refresh the description editor after scene changes."""
    if xgg.DescriptionEditor is None:
        return

    xgg.DescriptionEditor.refresh("Full")

def _refreshCB(param):
    refreshDescriptionEditor()

def postPaletteDeleteCB(pal):
    if xgg.DescriptionEditor is None:
        return
    xgg.DescriptionEditor.onPaletteDelete(pal)

