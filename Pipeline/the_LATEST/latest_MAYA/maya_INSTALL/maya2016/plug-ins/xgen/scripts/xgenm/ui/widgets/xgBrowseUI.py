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
# @file xgBrowseUI.py
# @brief Contains the browser UI
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
# @author Ying Liu
#
# @version Created 06/30/09
#

import string
import os
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets.xgFileBrowserUI import *

class BrowseUI(QtGui.QWidget):
    """A widget for editing a path or filename.

    This provides for the label, a text entry field, and a button
    to be bound to a file browser.
    """
    def __init__(self,attr,help="",object="",fileType="",inOrOut="in",mainlabel=""):
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        self.fileType = fileType
        self.inOrOut = inOrOut
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
        self.textValue = QtGui.QLineEdit()
        self.textValue.setMinimumWidth(50)
        self.optionButton = QtGui.QToolButton()
        self.optionButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgBrowse.png"))
        self.optionButton.setFixedSize(24,24)
        self.optionButton.setToolTip(maya.stringTable[ 'y_xgBrowseUI.kRaiseFileBrowser'  ])
        # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.addWidget(self.label)
        layout.addWidget(self.textValue)
        layout.addWidget(self.optionButton)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()

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
        if len(cdesc):
            startDir = startDir.replace("${DESC}",cdesc)
        if len(self.object):
            startDir = startDir.replace("${FXMODULE}",self.object)

        # expand start dir fully
        startDir = xg.expandFilepath( startDir, cdesc )

        # bring up the browswer dialog window
        selectedFile = fileBrowserDlg(self,startDir,self.fileType,self.inOrOut)

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
            # set the value in ui and xgen
            self.textValue.setText(selectedFile)
            self.textValue.emit(QtCore.SIGNAL("editingFinished()"))
            if self.object=="" or xgg.DescriptionEditor is None:
                return
            de = xgg.DescriptionEditor
            de.setAttr(self.object,self.attr,selectedFile)

    def value(self):
        return str(self.textValue.text())

    def setValue(self,value):
        self.textValue.setText(value)

    def connectIt(self):
        self.connect(self.optionButton,
                     QtCore.SIGNAL("clicked()"),
                     self.fileBrowser)
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        self.connect(self.textValue, QtCore.SIGNAL("editingFinished()"), 
                     lambda : de.setAttrCmd( self.object, self.attr, self.value() ) )

    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        value = de.getAttr(self.object,self.attr)
        self.setValue(value)

class FileBrowserUI(BrowseUI):
    """ File or directory handling with no support for xgen attributes """
    def __init__(self,label,help,fileType="",inOrOut="in"):
        BrowseUI.__init__(self,label,help,"",fileType,inOrOut)

    @staticmethod
    def fileExists( file, msg ):
        import os    
        if not (os.path.isfile(file) and os.path.exists(file)):
            mb = QtGui.QMessageBox()
            mb.setText(msg)
            mb.exec_()
            return False
        return True

    @staticmethod
    def defaultPath(desc):
        """ returns palette path """
        pal = xgg.DescriptionEditor.currentPalette()
        path = xg.getAttr("xgDataPath",pal)
        path = path.split(";")
        path = path[0]
        return xg.expandFilepath( path, desc )

    @staticmethod
    def folderExists( folder, desc, uiParent ):
        """ Check if folder exists, returns default if empty """
        import os    
        folder = str(folder)
        desc = str(desc)

        if not folder:
            #use palette xgDataPath by default
            path = FileBrowserUI.defaultPath(desc)
        else:
            path = xg.expandFilepath( folder, desc )

        if not (os.path.isdir(path) and os.path.exists(path)):
            mb = QtGui.QMessageBox(uiParent)
            text = maya.stringTable[ 'y_xgBrowseUI.kFolderDoesNotExist' ] % path
            mb.setText(text)
            mb.exec_()
            #use palette xgDataPath if the previous path does not exist
            path = FileBrowserUI.defaultPath(desc)

        return path

    @staticmethod
    def createFolder(folder,desc,uiParent):
        """ creates folder if requested, returns default if empty """
        folder = str(folder)
        desc = str(desc)
        if not folder:
            #use palette xgDataPath by default
            path = FileBrowserUI.defaultPath(desc)
        else:
            path = xg.expandFilepath( folder, desc )

        if not os.path.exists(path):
            title = maya.stringTable[ 'y_xgBrowseUI.kFileBrowserUI'  ]
            text = maya.stringTable[ 'y_xgBrowseUI.kFolderDoesNotExist2' ] % path
            mbox = QtGui.QMessageBox( QtGui.QMessageBox.NoIcon, title, text, QtGui.QMessageBox.NoButton, uiParent )
            newFolderBtn = QtGui.QPushButton(maya.stringTable[ 'y_xgBrowseUI.kCreateNewFolder'  ])
            mbox.addButton( newFolderBtn, QtGui.QMessageBox.YesRole )
            mbox.addButton( QtGui.QMessageBox.Cancel )
            mbox.setDefaultButton( newFolderBtn )
            mbox.exec_()
            if mbox.clickedButton() == newFolderBtn:
                # expand and create folder
                return xg.expandFilepath( path, desc, True, True )
            else:
                return ""      
        return path

    def fileBrowser(self):
        # Get setup with a full path given users input value
        value = str(self.textValue.text())
        if not self.fileType:
            # folder dialog
            if self.inOrOut == 'out':
                # create folder if requested
                value = FileBrowserUI.createFolder( value, xgg.DescriptionEditor.currentDescription(), self )
                if not value:
                    return
            else:
                value = FileBrowserUI.folderExists( value, xgg.DescriptionEditor.currentDescription(), self )
                if not value:
                    return
        # todo: add support for file dialog                        
            
        # bring up the browser dialog window
        selected = fileBrowserDlg(self,value,self.fileType,self.inOrOut)

        # set the value in ui
        if len(selected):            
            self.textValue.setText(selected)
