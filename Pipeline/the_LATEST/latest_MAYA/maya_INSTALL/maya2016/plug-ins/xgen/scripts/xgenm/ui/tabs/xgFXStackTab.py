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
# @file xgFXStackTab.py
# @brief Contains the FX stackUI.
#


import os
import string
import traceback

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets import *
from xgenm.ui.dialogs.xgEditFXChain import editFXChain, showFXChainLoaderDialog, showFXChainOrderingDialog,getFxModuleIconPath
from xgenm.ui.fxmodules import *
import tempfile

_globalFXMenu = None
_localFXMenu = None
_userFXMenu = None
_allFXMenus = []


class FXStackTabUI( QtGui.QWidget ):
    """ for the fx tab, we have a list widget to pick the 
        the current fx, with its parameters in the StackUI below
    """
    def __init__( self ):
        QtGui.QWidget.__init__( self )
        layout = QtGui.QVBoxLayout()
        layout.setAlignment( QtCore.Qt.AlignTop )
        layout.setSpacing( 0 )
        layout.setContentsMargins(3,3,3,3) 
        self.setLayout( layout )

        self.splitter = QtGui.QSplitter( QtCore.Qt.Vertical )
        layout.addWidget( self.splitter )
        
        self.layerUI = FXModuleLayerUI()
        self.layerUI.layerList.currentItemChanged.connect( self.currentLayerSelectionChanged )
        self.layerUI.setContentsMargins(8,0,8,0) 

        expandUI = ExpandUI(maya.stringTable[ 'y_xgFXStackTab.kModifiers'  ],True)
        expandUI.addWidget(self.layerUI)
        expandUI.layout().addStretch()
        
        self.splitter.addWidget( expandUI)
        
        self.stackUI = StackUI(margin=0)
        self.splitter.addWidget( self.stackUI )
        
        self.splitter.setSizes([50,800])
        
        self.moduleToIndexMap = {}

    # when we add a widget to the stack, add it in a scroll area
    def addWidget( self, widget, name ):
        printableName = widget.printableName
        if printableName == "":
            printableName = name
        expandUI = ExpandUI(printableName,True)
        expandUI.addWidget(widget)
        expandUI.layout().addStretch()
        
        scrollArea = QtGui.QScrollArea()
        scrollArea.setWidget( expandUI )
        scrollArea.setWidgetResizable( True )
        scrollArea.setFrameStyle( QtGui.QFrame.NoFrame )
        scrollArea.setContentsMargins(0,0,0,0)
        self.stackUI.addWidget( scrollArea )

    # get the stack widget, a child of a scroll area
    def getCurrentStackUIWidget( self ):
        return self.stackUI.widget().widget().contentsLayout.itemAt(0).widget()

    def setCurrentFXModule( self, module ):
        widgetIndex = self.moduleToIndexMap[module]
        if ( widgetIndex >= 0 ) and ( widgetIndex < self.stackUI.currentWidgetNum() ) :
            widgetIndex = self.moduleToIndexMap[module]
            self.stackUI.setCurrent( widgetIndex )
            self.layerUI.setCurrentLayerByName( module )
        self.getCurrentStackUIWidget().refresh()

    def currentLayerSelectionChanged( self, current, previous ):
        if current:
            # check if the module UI is created, if not, create it
            module = self.layerUI.getCurrentModuleName()
            if not self.moduleToIndexMap.has_key(module):
                self.createModuleWidget( module )
            self.setCurrentFXModule( module )

    # rebuild the whole UI.
    def rebuildFXStackUI( self, moduleNameToSelect = "" ):
        self.stackUI.clear()
        self.moduleToIndexMap.clear()
        modules = xgg.DescriptionEditor.getFXModulesReversed()

        self.layerUI.rebuildLayerList()

        if not modules:
            widget = EmptyFXModuleTabUI( "<None>" )
            self.addWidget(widget,"")
        else:
            indexToSelect = 0
            if moduleNameToSelect != "" :
                try:
                    indexToSelect = modules.index( moduleNameToSelect )
                except ValueError:
                    pass
            
            self.createModuleWidget( modules[indexToSelect] )
            self.setCurrentFXModule( modules[indexToSelect] )
    
    def createModuleWidget(self, module):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        
        fxType = xg.fxModuleType( pal, desc, module )
        try:
            cls = de.uiclasses[ fxType + "TabUI" ]
            widget = cls(module)
        except Exception, e:
            print maya.stringTable[ 'y_xgFXStackTab.kErrorRefreshingUiFor'  ] % module
            traceback.print_exc()
            widget = EmptyFXModuleTabUI( "<None>" )

        self.moduleToIndexMap[module] = self.stackUI.currentWidgetNum()
        self.addWidget( widget, fxType )
    
    def addNewModule(self, module):
        self.layerUI.rebuildLayerList()
        self.createModuleWidget( module )
        self.setCurrentFXModule( module )
        
def loadFXModuleIcon(moduleName):
    de = xgg.DescriptionEditor
    pal = de.currentPalette()
    desc = de.currentDescription()

    fxType = xg.fxModuleType( pal, desc, moduleName)
    fxType = fxType.replace("FXModule", "")
    icon = QtGui.QIcon(getFxModuleIconPath(fxType))
    return icon

class FXModuleLayerUI(QtGui.QWidget):
    
    def __init__(self):
        QtGui.QWidget.__init__(self)

        toolbarContainer = QtGui.QWidget(self)
        toolbarContainerLayout = QtGui.QHBoxLayout(toolbarContainer)
        toolbarContainer.setLayout(toolbarContainerLayout)
    
        # build the toolbar buttons, right-aligned
        toolbarContainerLayout.setSpacing(0)
        toolbarContainerLayout.setContentsMargins(0,0,0,0)
        toolbarContainerLayout.addStretch()
        iconList = [ ":/moveLayerUp.png", ":/moveLayerDown.png", ":/newLayerEmpty.png", xg.iconDir()+"xgBrowse.png"]
        tooltips = [ maya.stringTable['y_xgFXStackTab.kMoveUpAnn' ],maya.stringTable['y_xgFXStackTab.kMoveDownAnn' ],maya.stringTable['y_xgFXStackTab.kAddFxAnn' ],maya.stringTable['y_xgFXStackTab.kModFxAnn' ]]
        self.buttonList = []
        self.iconList = []
        for i in range(4):
            button = QtGui.QToolButton(toolbarContainer)
            button.setFixedSize(24,24)
            button.setAutoRaise(True)
            self.iconList.append(QtGui.QIcon(iconList[i]))
            button.setIcon(self.iconList[ i ])
            button.setIconSize(QtCore.QSize(20,20))
            button.setToolTip(tooltips[i])
            self.buttonList.append(button)
            toolbarContainerLayout.addWidget(button)

        self.buttonList[0].clicked.connect( self.onClickMoveLayerUp )
        self.buttonList[1].clicked.connect( self.onClickMoveLayerDown )
        self.buttonList[2].clicked.connect( self.onAddFXModuleButton )
        self.buildOptionMenu( self.buttonList[3] )

        toolbarContainer.setSizePolicy( QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed )      
    
        self.layerList = QtGui.QListWidget(self)
        self.layerList.setDragDropMode( QtGui.QAbstractItemView.InternalMove )
        self.layerList.setContextMenuPolicy( QtCore.Qt.CustomContextMenu )
        self.layerList.customContextMenuRequested.connect( self.contextMenu )
        self.layerList.itemChanged.connect( self.activeClicked )
        listModel = self.layerList.model()
        listModel.rowsMoved.connect(self.rowsMoved)

        selfLayout = QtGui.QVBoxLayout(self)
        selfLayout.setContentsMargins(0,0,0,0)
        selfLayout.addWidget(toolbarContainer)
        selfLayout.addWidget(self.layerList)
        self.setLayout(selfLayout)        

    def getSizeHint(self):
        return QtCore.QSize(48,48)
  
    def onAddFXModuleButton( self ):
        globalPos = self.buttonList[2].mapToGlobal(QtCore.QPoint(0,0))
        showFXChainLoaderDialog( globalPos.x()-600, globalPos.y()+10 )

    def onClickMoveLayerUp( self, checked = False ):
        self.onMoveLayerButton(-1)

    def onClickMoveLayerDown( self, checked = False ):
        self.onMoveLayerButton( 1)

    def getCurrentModuleName( self ):
        if self.layerList.currentRow() >= 0:
            return str(self.layerList.currentItem().text())
        else:
            return ""
    
    def onMoveLayerButton(self,direction):
        count = self.layerList.count()
        currentRow = self.layerList.currentRow()
        if count < 2 or currentRow == -1 :
            return
        if direction < 0 and currentRow < 1 :
            return
        if direction > 0 and currentRow >= (count - 1) :
            return

        moduleName = self.getCurrentModuleName()
        self.performFxModuleMove( moduleName, direction, 1)

    # callback for drag-and-drop
    def rowsMoved( self, sourceParent ,sourceIndex, sourceEnd, destinationParent, destIndex ):
        modules = xgg.DescriptionEditor.getFXModulesReversed()
        moduleName = modules[ sourceIndex ]

        if destIndex > sourceIndex:
            direction = 1
            repeat = destIndex - sourceIndex - 1;
        else:
            direction = -1
            repeat = sourceIndex - destIndex;
            
        # using timer is necessary to do this on idle only after the drag and drop ends 
        QtCore.QTimer.singleShot( 1, lambda :  self.performFxModuleMove( moduleName, direction, repeat) )

    def performFxModuleMove( self, moduleName, direction, repeat ):
        direction = direction * -1
        de = xgg.DescriptionEditor
        for i in range(0,repeat):
            xg.moveFXModule( de.currentPalette(), de.currentDescription(), moduleName, direction)

        # we need to update the StackUI below and set the current module again to see the right page
        # some module moves are illegal.. find the module again to see where it ended up
        self.rebuildLayerList()
        xgg.DescriptionEditor.fxStackTab.setCurrentFXModule( moduleName )

    def setCurrentLayer(self,index):
        self.layerList.setCurrentRow(index)
    
    def setCurrentLayerByName(self, module):
        itemList = self.layerList.findItems( module, Qt.MatchExactly )
        if len( itemList ) > 0:
            self.layerList.setCurrentItem( itemList[0] )

    def rebuildLayerList(self):
        modules = xgg.DescriptionEditor.getFXModulesReversed()
        self.layerList.clear()

        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()

        for row, module in enumerate( modules ):
            newItem = QtGui.QListWidgetItem()
            newItem.setText( module )
            newItem.setFlags( newItem.flags() | QtCore.Qt.ItemIsUserCheckable )
            newItem.setIcon(loadFXModuleIcon( module ))
            isActive = xg.stringToBool( xgg.DescriptionEditor.getAttr(module,"active") )
            newItem.setCheckState( QtCore.Qt.Checked if isActive else QtCore.Qt.Unchecked )
            self.layerList.addItem( newItem )

    def contextMenu( self, pos ):
        pos = self.layerList.mapToGlobal( pos )
        self.menu.popup( pos )

    def activeClicked( self, item ):
        isChecked = ( item.checkState() == QtCore.Qt.Checked ) 
        xgg.DescriptionEditor.setAttrCmd( str(item.text()), "active", xg.boolToString( isChecked ) )
        xgg.DescriptionEditor.playblast()
        xgg.DescriptionEditor.fxStackTab.getCurrentStackUIWidget().activeUpdate()

    def buildOptionMenu( self, button ):
        # Warning: override the mousePressEvent for the toolButton
        self.menu = QtGui.QMenu()
        action = self.menu.addAction(maya.stringTable[ 'y_xgFXStackTab.kSaveModifier'  ], lambda: self.repoMan("save"))
        self.buildMenus()
        self.menu.addMenu(_globalFXMenu)
        self.menu.addMenu(_localFXMenu)
        self.menu.addMenu(_userFXMenu)
        self.menu.addAction(maya.stringTable[ 'y_xgFXStackTab.kDuplicate'  ], lambda: self.duplicateModule())
        self.menu.addSeparator()
        self.menu.addAction(maya.stringTable[ 'y_xgFXStackTab.kDelete'  ], lambda: self.deleteModule())
        button.setMenu(self.menu)
        button.setPopupMode(QtGui.QToolButton.InstantPopup)

    def buildMenus(self):   
        global _globalFXMenu
        global _localFXMenu
        global _userFXMenu
        global _allFXMenus

        if not _globalFXMenu:
            _globalFXMenu = QtGui.QMenu(maya.stringTable[ 'y_xgFXStackTab.kLoadGlobal'  ])
            _localFXMenu = QtGui.QMenu(maya.stringTable[ 'y_xgFXStackTab.kLoadLocal'  ])
            _userFXMenu = QtGui.QMenu(maya.stringTable[ 'y_xgFXStackTab.kLoadUser'  ])

        _globalFXMenu.clear()
        _localFXMenu.clear()
        _userFXMenu.clear()
        _allFXMenus = []
        self.buildMenu(_globalFXMenu,xg.globalRepo()+"fxmodules/")
        self.buildMenu(_localFXMenu,xg.localRepo()+"fxmodules/")
        self.buildMenu(_userFXMenu,xg.userRepo()+"fxmodules/")

    def buildMenu(self,topmenu,startDir):
        # first verify that the directory exists
        try:
            buf = os.stat(startDir)
        except:
            action = topmenu.addAction(maya.stringTable[ 'y_xgFXStackTab.kNone'  ])
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
                _allFXMenus.append(menu)
                if len(menus)>depth:
                    menus[depth] = menu
                else:
                    menus.append(menu)
                for item in files:
                    long = os.path.join(dir,item)
                    if os.path.isfile(long):
                        parts = os.path.splitext(item)
                        if parts[1] == ".xgfx":
                            menu.addAction(parts[0],
                                           lambda x=long: self.loadFromRepo(x))
                    else:
                        subdirlist.insert(0,long)
                        depths.insert(0,depth+1)
            except:
                pass
        if topmenu.isEmpty():
            action = topmenu.addAction(maya.stringTable[ 'y_xgFXStackTab.kNone2'  ])
            action.setDisabled(True)

    def loadFromRepo( self, filename ):
        self.repoMan( filename )

    def repoMan(self,value):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        # if the value is "save" then we raise a browser in user repo
        if str(value)=="save":
            moduleName = self.getCurrentModuleName()
            if ( moduleName == "" ):
                return
            startDir  = xg.userRepo() + "fxmodules/"
            try:
                buf = os.stat(startDir)
            except:
                # if the directory isn't there the browser will send us to
                # some unexpected location
                os.makedirs(startDir)
            result = fileBrowserDlg(self,startDir,"*.xgfx","out")
            if len(result):
                if not result.endswith(".xgfx"):
                    result += ".xgfx"
                xg.exportFXModule( pal, desc, moduleName, result)
                self.buildMenus()
        else:
            try:
                filename = str(value)
                buf = os.stat(filename)
                mod = xg.importFXModule(pal,desc,filename)
                xgg.DescriptionEditor.fxStackTab.rebuildFXStackUI( mod )
            except:
                xg.XGError(maya.stringTable[ 'y_xgFXStackTab.kTheGivenmodifierDoesntExist'  ] % filename)
                self.buildMenus()
                return

    def duplicateModule(self):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        moduleName = self.getCurrentModuleName()
        if ( moduleName == "" ):
            return
        tempFileName = str(tempfile.gettempdir()) + "/xgen_dup.xgfx"
        tempFileName = tempFileName.replace( "\\", "/" )
        xg.exportFXModule(pal, desc, moduleName, tempFileName )
        dup = xg.importFXModule( pal, desc, tempFileName )
        if dup:
            xgg.DescriptionEditor.fxStackTab.addNewModule( dup )

    def deleteModule(self):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        moduleName = self.getCurrentModuleName()
        if ( moduleName == "" ):
            return
        xg.removeFXModule( pal, desc, moduleName )
        xgg.DescriptionEditor.fxStackTab.rebuildFXStackUI()



