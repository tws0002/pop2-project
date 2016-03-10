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
# @file xgGeneratorTab.py
# @brief Contains the UI for Generator tab
##

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.util.xgUtil import *
import weakref

class ToolIconView(QtGui.QListWidget):
    def __init__( self, parentTab ):
        QtGui.QListWidget.__init__( self )
        self.parentTab = weakref.proxy(parentTab)
        self.freezeNotifications = False
        
    def  selectionChanged(self, selected, deselected):
        super(ToolIconView,self).selectionChanged(selected,deselected)
        
        if not self.freezeNotifications:
            model = self.model()
    
            changes = []
            for item in selected.indexes():
                changes.append(model.data(item,QtCore.Qt.UserRole))
            if len(changes) > 0 :
                self.parentTab.toolAddedCallback(changes)
            
            changes = []
            for item in deselected.indexes():
                changes.append(model.data(item,QtCore.Qt.UserRole))
            if len(changes) > 0 :
                self.parentTab.toolRemovedCallback(changes)

    def setSelectionFromUserRoles(self,itemList):
        self.freezeNotifications = True
        self.clearSelection()
        count = self.count()
        for i in range(0,count):
            item = self.item(i)
            if (item.data(QtCore.Qt.UserRole) in itemList):
                item.setSelected(True)
        self.freezeNotifications = False

class UtilitiesTabUI( QtGui.QWidget ):
    """ tab that presents what is internally called "xgen tool" and the xgen tool manager
    """
    def __init__( self ):
        QtGui.QWidget.__init__( self )
        self.createUI = True

    def doCreateUI( self ):
        layout = QtGui.QVBoxLayout()
        layout.setAlignment( QtCore.Qt.AlignTop )
        layout.setSpacing( 0 )
        layout.setContentsMargins(3,3,3,3) 
        self.setLayout( layout )

        self.splitter = QtGui.QSplitter( QtCore.Qt.Vertical )
        layout.addWidget( self.splitter )
        
        if xgg.Maya:
            self.splitter.addWidget(self.createIconView())
            self.splitter.addWidget(self.createEditorArea())

        self.splitter.setSizes([200,800])
        if xgg.Maya:
            self.tmRestoreStateFromOptionVars()

    def createIconView(self):
        # if in localized mode, build tab in horizontal layout to
        # accomodate japanese text better 
        isLocalized = mel.eval("about -uiLanguageIsLocalized;")
        self.iconView = ToolIconView(self)
        self.iconView.setSelectionMode( QtGui.QAbstractItemView.MultiSelection )
        self.iconView.setMovement(QtGui.QListView.Static)
        self.iconView.setResizeMode(QtGui.QListView.Adjust)
        self.iconView.setWordWrap(True)
        if isLocalized == 1:
            self.iconView.setViewMode(QtGui.QListView.ListMode)
            self.iconView.setWrapping(True)
            self.iconView.setFlow(QtGui.QListView.LeftToRight)
            self.iconView.setIconSize(QtCore.QSize(50,50))
        else:
            self.iconView.setViewMode(QtGui.QListView.IconMode)
            self.iconView.setGridSize(QtCore.QSize(56,86))
        self.iconView.itemDoubleClicked.connect(self.toolDoubleClicked)

        toolNameList = mel.eval('lookupTableGetColumn($gxgmTMLookupTable,"toolName");')
        toolIconList = mel.eval('lookupTableGetColumn($gxgmTMLookupTable,"toolIcon");')
        toolDescList = mel.eval('lookupTableGetColumn($gxgmTMLookupTable,"toolDescr");')
        toolCreateFunc = mel.eval('lookupTableGetColumn($gxgmTMLookupTable,"toolCreateUIMethod");')


        for i in range(0,len(toolNameList)):            
            iconPath =  path = xg.iconDir()+toolIconList[i]
            icon = QtGui.QIcon(iconPath)
            item = QtGui.QListWidgetItem(icon, toolNameList[i])
            item.setToolTip(toolDescList[i])
            item.setData(QtCore.Qt.UserRole,toolCreateFunc[i])
            if isLocalized == 1:
                item.setSizeHint(QtCore.QSize(110,50))
                item.setTextAlignment(QtCore.Qt.AlignLeft | QtCore.Qt.AlignVCenter)
            self.iconView.addItem(item)

        return self.iconView

    def createEditorArea(self):
        self.editorArea = QtGui.QWidget()
        layout = QtGui.QVBoxLayout()
        layout.setContentsMargins(0,0,0,0)
        layout.setObjectName("XGenToolEditorAreaParent")
        self.editorArea.setLayout(layout)
        mel.eval('columnLayout -parent "XGenToolEditorAreaParent"-adjustableColumn true XGenToolEditorArea;')

        return createScrollArea(self.editorArea)

    def paintEvent(self,event):
        super(UtilitiesTabUI,self).paintEvent(event)
        if self.createUI:
            self.createUI = False
            self.doCreateUI() 

    def toolAddedCallback(self, toolNameList ):
        for tool in toolNameList:
            self.tmLoadTool(tool)

    def toolRemovedCallback(self, toolNameList ):
        for tool in toolNameList:
            self.tmUnloadTool(tool)

    def toolDoubleClicked(self,listWidgetItem ):
       self.iconView.clearSelection()
       listWidgetItem.setSelected(True) 

    def tmLoadTool(self, toolName):
        melCommand = 'tmLoadTool("XGenToolEditorArea","' + toolName + '", false);'
        mel.eval(melCommand)
        self.tmUpdateOptionVars()

    def tmUnloadTool(self, toolName):
        melCommand = 'tmUnloadTool("XGenToolEditorArea","' + toolName + '");'
        mel.eval(melCommand)
        self.tmUpdateOptionVars()
        
    def tmRestoreStateFromOptionVars(self):
        toolNameList = mel.eval('tmRestoreStateFromOptionVars("XGenToolEditorArea");')

        # the tool's UI has been created, now we just need to update the iconView
        self.iconView.setSelectionFromUserRoles(toolNameList)

    def tmUpdateOptionVars(self):
         mel.eval('tmUpdateOptionVars("XGenToolEditorArea");');
