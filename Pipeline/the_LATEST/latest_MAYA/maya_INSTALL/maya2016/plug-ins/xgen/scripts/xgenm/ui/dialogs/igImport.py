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
# @file igImport.py
# @brief igroom import dialog

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
import maya.cmds as cmds
import maya.mel as mel
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets import *

__all__ = [ 'igImportFile' ]

class igImportUI(QtGui.QDialog):       
    class MapImporter(QtGui.QWidget):
        def __init__(self, tabs):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            expDir = xg.getOptionVarString( 'igAutoExportFolder' )
            self.path = FileBrowserUI(maya.stringTable[ 'y_igImport.kFolderPathMapImport'  ],
                                    maya.stringTable[ 'y_igImport.kFolderPathMapImportAnn'  ])
            self.path.optionButton.setToolTip(maya.stringTable[ 'y_igImport.kBrowseForAFolder'  ])
            self.path.setValue( expDir )
            vbox.addWidget(self.path)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igImport.kAttributeMaps'  ])

        def doIt(self):
            path = self.path.value()
            desc = xgg.DescriptionEditor.currentDescription()
            igDescr = xg.igDescription( desc )

            expandedPath = FileBrowserUI.folderExists(path,desc,self)
            if not expandedPath:
                return False

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'iGroom -im "%s" -d "%s";' % (expandedPath,igDescr) )
            finally:
                cmds.waitCursor( state=False )

            xg.XGWarning( 3, maya.stringTable['y_igImport.kIgImportUIAttrMapsFrom' ] % (desc,expandedPath) )
            return True

    class MaskImporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            expDir = xg.getOptionVarString( 'igAutoExportFolder' )
            self.path = FileBrowserUI(maya.stringTable[ 'y_igImport.kFolderPathMaskImporter'  ],
                                    maya.stringTable[ 'y_igImport.kFolderPathMaskImporterAnn'  ])
            self.path.optionButton.setToolTip(maya.stringTable[ 'y_igImport.kBrowseForAFolder2'  ])
            self.path.setValue( expDir )
            vbox.addWidget(self.path)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igImport.kMask'  ])

        def doIt(self):
            path = self.path.value()
            desc = xgg.DescriptionEditor.currentDescription()
            igDescr = xg.igDescription( desc )

            expandedPath = FileBrowserUI.folderExists(path,desc,self)
            if not expandedPath:
                return False

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'iGroom -ik "%s" -d "%s";' % (expandedPath,igDescr) )
            finally:
                cmds.waitCursor( state=False )

            xg.XGWarning( 3, maya.stringTable['y_igImport.kIgImportUIMaskMapsFrom' ] % (desc,expandedPath) )
            return True

    class RegionImporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            expDir = xg.getOptionVarString( 'igAutoExportFolder' )
            self.path = FileBrowserUI(maya.stringTable[ 'y_igImport.kFolderPathRegionImporter'  ],
                                 maya.stringTable[ 'y_igImport.kFolderPathRegionImporterAnn'  ])
            self.path.optionButton.setToolTip(maya.stringTable[ 'y_igImport.kBrowseForAFolder3'  ])
            self.path.setValue( expDir )
            vbox.addWidget(self.path)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igImport.kRegionMap'  ])

        def doIt(self):
            path = self.path.value()
            desc = xgg.DescriptionEditor.currentDescription()
            igDescr = xg.igDescription( desc )

            expandedPath = FileBrowserUI.folderExists(path,desc,self)
            if not expandedPath:
                return False

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'iGroom -ir "%s" -d "%s";' % (expandedPath,igDescr) )
            finally:
                cmds.waitCursor( state=False )

            xg.XGWarning( 3, maya.stringTable['y_igImport.kIgImportUIRegionMapsFrom' ] % (desc,expandedPath) )
            return True            

    # Dialog init
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_igImport.kIgroomImport'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(400)

        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        self.tabs = QtGui.QTabWidget()
        layout.addWidget(self.tabs)

        igImportUI.MapImporter( self.tabs )
        igImportUI.MaskImporter( self.tabs )
        igImportUI.RegionImporter( self.tabs )

        self.buttons(layout)
        self.setLayout(layout)

    def buttons(self,layout):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.importButton = QtGui.QPushButton(maya.stringTable[ 'y_igImport.kImport'  ])
        self.importButton.setFixedWidth(100)
        self.importButton.setAutoRepeat(False)
        self.connect(self.importButton, QtCore.SIGNAL("clicked()"), self.importCB)
        hbox.addWidget(self.importButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_igImport.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_igImport.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"), self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)
                       
    def importer(self):
        # tabs -> scroll widget -> exporter
        return self.tabs.currentWidget().widget()

    def importCB(self):
        importer = self.importer()
        if importer.doIt():
            # done, accept/close dialog
            self.accept()
                  
def igImportFile():
    if len(xg.palettes()) == 0:
        tellem = QtGui.QMessageBox()
        tellem.setText(maya.stringTable[ 'y_igImport.kThereIsNothingToImport'  ])
        tellem.exec_()
        return

    igImportUI().exec_()
