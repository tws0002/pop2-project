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
# @file xgExportFile.py
# @brief Contains the Export File UI.
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
# @version Created 04/08/09
#

import string

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.cmds as cmds
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI
from xgenm.ui.widgets import *
from xgenm.ui.xgSetMapAttr import setMapAttr
import xgenm.xmaya.xgmExternalAPI as xgmExternalAPI
import os.path


def _exportFile(dialog):
    """Export the palette as indicated by the given index."""
    count = len(xg.palettes())
    for i in range(count):
        if dialog.getBoxValue(i):
            fileName = dialog.getFileName(i)
            pal = dialog.getPalette(i)
            if fileName == "" or pal == "":
                continue
            xg.exportPalette(pal,fileName)
    
def fixFileName(fileName, extension):
    (root, ext) = os.path.splitext(fileName)
    if len(root)==0 or root.endswith("\\") or root.endswith("/"):
        return ""

    root += extension
    return root
    
class ExportFileUI(QtGui.QDialog):
    """A dialog to specify the options for exporting an XGen file.

    This provides a browser field for the file name, a text field for the
    namespace, and buttons to import or cancel.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgExportFile.kXgenExport'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(600)
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        self.tabs = QtGui.QTabWidget()
        self.paletteUI()
        self.descriptionUI()
        layout.addWidget(self.tabs)
        self.connect(self.tabs,QtCore.SIGNAL("currentChanged(int)"),
                     self.refreshTip)
        #layout.addSpacing(10)
        self.buttons(layout)
        self.setLayout(layout)
        self.refreshTip(0)
        self.refresh()
        
    def paletteUI(self):
        self.palPart = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignTop)
        self.palPart.setLayout(vbox)
        # add row for each palette
        count=0
        self.palFile = []
        self.box = []
        self.palNames = []
        palettes = xg.palettes()
        multi = len(palettes) > 1
        for pal in palettes:
            browsepal = BrowseUI(pal,
                                 maya.stringTable[ 'y_xgExportFile.kFileNameAnn'   ],
                                 "","*.xgen","out", pal )
            browsepal.optionButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kBrowseForAFileName1'  ])
            self.palFile.append( browsepal )
            self.palFile[count].setValue( self._exportFilename( pal, '.xgen' ) )
            self.palNames.append(pal)
            self.connect( browsepal.textValue, QtCore.SIGNAL("editingFinished()"), self.onPalFileSelected )

            vbox.addWidget(self.palFile[count])
            if multi:
                # add a check box for each palette
                self.box.append(QtGui.QCheckBox())
                self.box[count].setChecked(True)
                self.box[count].setToolTip(maya.stringTable['y_xgExportFile.kExportPaletteAnn1' ] % pal)
                self.palFile[count].layout().addWidget(self.box[count])
            count += 1
        scrollArea = QtGui.QScrollArea()
        scrollArea.setWidget(self.palPart)
        scrollArea.setWidgetResizable(True)
        self.tabs.addTab(scrollArea,maya.stringTable[ 'y_xgExportFile.kCollection1'  ])

    def descriptionUI(self):
        self.descPart = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignTop)
        self.descPart.setLayout(vbox)
        # row for palettes
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignLeft)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgExportFile.kCollection2'  ])
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        label.setToolTip(maya.stringTable[ 'y_xgExportFile.kCollectionAnn1'  ])
        hbox.addWidget(label)
        self.palette = _ComboBoxUI()
        self.palette.setMinimumWidth(220)
        self.palette.setToolTip(maya.stringTable[ 'y_xgExportFile.kCollectionAnn2'  ])
        palettes = xg.palettes()
        for pal in palettes:
            self.palette.addItem(pal)
        self.connect(self.palette, QtCore.SIGNAL("activated(const QString&)"), self.refresh)
        hbox.addWidget(self.palette)
        row.setLayout(hbox)
        vbox.addWidget(row)
        # row for descriptions
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignLeft)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgExportFile.kDescription1'  ])
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        label.setToolTip(maya.stringTable[ 'y_xgExportFile.kDescriptionAnn1'  ])
        hbox.addWidget(label)
        self.description = _ComboBoxUI()
        self.description.setMinimumWidth(220)
        self.description.setToolTip(maya.stringTable[ 'y_xgExportFile.kDescriptionToExport'  ])
        self.description.activated.connect(self.onDescriptionChanged)

        hbox.addWidget(self.description)
        row.setLayout(hbox)
        vbox.addWidget(row)
        # row for file name
        self.descFile = BrowseUI(maya.stringTable[ 'y_xgExportFile.kFileName1'  ],
                                 maya.stringTable[ 'y_xgExportFile.kFilePathAnn1'  ],
                                 "","*.xdsc","out")
        self.descFile.optionButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kBrowseForAFileName2'  ])
        self.connect( self.descFile.textValue, QtCore.SIGNAL("editingFinished()"), self.onDescFileSelected )
        vbox.addWidget(self.descFile)
        self.tabs.addTab(self.descPart,maya.stringTable[ 'y_xgExportFile.kDescription2'  ])

    def buttons(self,layout):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(15)
        hbox.setContentsMargins(1,1,1,1)
        self.exportButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportFile.kExport'  ])
        self.exportButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kExportAnn1'  ])
        self.exportButton.setAutoRepeat(False)
        self.connect(self.exportButton, QtCore.SIGNAL("clicked()"),self.accept)
        hbox.addWidget(self.exportButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportFile.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)

    def refreshTip(self,index):
        if index:
            self.exportButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kExportAnn2'  ])
        else:
            if len(xg.palettes())>1:
                self.exportButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kExportAllAnn'  ])
            else:
                self.exportButton.setToolTip(maya.stringTable[ 'y_xgExportFile.kExportCollectionAnn2'  ])

    def _exportFilename( self, obj, ext ):
        """ returns the filename previously used to export obj """
        filename = 'None'
        try:
            filename = xg.getAttrValue( obj, ('export_filename', 'None') )
            if filename != 'None':
                filename = fixFileName(filename, ext)
        except:
            import traceback
            traceback.print_exc()
            pass

        if filename == 'None' or len(filename)==0:
            filename = xg.userRepo()+xgmExternalAPI.encodeNameSpace(obj)+ext

        return filename

    def refresh(self):
        # put all the descriptions for palette into description list
        pal = self.getPalette()
        self.description.clear()
        descrs = xg.descriptions(pal)
        for descr in descrs:
            self.description.addItem(descr)

        # update the dialog edit widget
        self.descFile.textValue.setText( self._exportFilename( descrs[0], '.xdsc' ) )

    def onDescriptionChanged( self, index ):
        """ Update the description filename edit widget on new selected description. """
        self.descFile.textValue.setText( self._exportFilename( self.description.itemText( index ), '.xdsc' ) )

    def onPalFileSelected(self): 
        for wid in self.palFile:
            self.onFileSelected(wid, '.xgen')

    def onDescFileSelected(self): 
        self.onFileSelected(self.descFile, '.xdsc')

    def onFileSelected(self, widget, extension): 
        fileName = widget.value()
        fileName = fixFileName(fileName, extension)
        if len(fileName):
            widget.setValue(fileName)
    
    def getType(self):
        return self.tabs.currentIndex()
    
    def getPalFile(self,index):
        if index < len(self.palFile):
            return self.palFile[index].value()
        return ""
    
    def getPalName(self,index):
        if index < len(self.palNames):
            return self.palNames[index]
        return ""
    
    def getBoxValue(self,index):
        if index < len(self.box):
            return self.box[index].isChecked()
        return True
    
    def getDescFile(self):
        return self.descFile.value()
    
    def getPalette(self):
        return str(self.palette.currentText())

    def getDescription(self):
        return str(self.description.currentText())


def exportFile():
    """Function to export a file using a dialog.

    This provides a simple dialog to accept the file name and the optional
    nameSpace. The user can use a browser to search for the file.
    """
    if len(xg.palettes()) == 0:
        tellem = QtGui.QMessageBox()
        tellem.setText(maya.stringTable[ 'y_xgExportFile.kThereAreNoCollectionsToExport'  ])
        tellem.exec_()
        return
    dialog = ExportFileUI()
    result = dialog.exec_()
    if result == QtGui.QDialog.Accepted:
        # Save the scene before export.
        # When export a description with initial unsaved scene,
        # textures of xgen's map are not resolved. As we support
        # to export map, their texture (ptex) should be resolved before export.
        sceneName = saveScene()
        if len(sceneName) == 0:
            return

        # When export from xgen menu, set the texture info to attributes
        setMapAttr()

        if dialog.getType() == 0:
            count = len(xg.palettes())
            for i in range(count):
                if dialog.getBoxValue(i):
                    fileName = dialog.getPalFile(i)
                    fileName = fixFileName(fileName, '.xgen')
                    pal = dialog.getPalName(i)
                    if len(fileName) and len(pal):
                        xg.exportPalette(pal,fileName)
                        # save file name for reuse
                        xg.setAttrValue( pal, ('export_filename',fileName,'string') )
                    else:
                        xg.XGError(maya.stringTable[ 'y_xgExportFile.kYouMustSpecifyAFilename'  ])
        else:
            xdscFile = dialog.getDescFile()
            xdscFile = fixFileName(xdscFile, '.xdsc')
            pal = dialog.getPalette()
            desc = dialog.getDescription()
            if len(xdscFile) and len(pal) and len(desc):
                xg.exportDescription(pal,desc,xdscFile)

                # save file name for reuse
                xg.setAttrValue( desc, ('export_filename',xdscFile,'string') )
            else:
                xg.XGError(maya.stringTable[ 'y_xgExportFile.kYouMustSpecifyFilename'  ])
