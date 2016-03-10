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
# @file xgImportFile.py
# @brief Contains the Import File UI.
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
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI
from xgenm.ui.widgets import *

if xgg.Maya:
    import maya

class ImportFileUI(QtGui.QDialog):
    """A dialog to specify the options for importing an XGen file.

    This provides a tabbed Ui for importing either a palette or a
    description from a file. For a palette you are given a browser field
    for the file name, a text field for the namespace, and a check box
    for importing patches. For a description you are given a browser
    field for the file name and a combo box for the palette the new
    description should be placed within. Buttons for import and cancel
    are also provided.
    """
    def __init__(self,which):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgImportFile.kImportCollectionsOrDescriptions'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        self.setLayout(layout)
        self.tabs = QtGui.QTabWidget()
        self.paletteUI()
        self.descriptionUI()
        layout.addWidget(self.tabs)
        self.buttons(layout)
        if which == 'description':
            self.tabs.setCurrentWidget( self.descPart )
        else:
            self.tabs.setCurrentWidget( self.palPart )

        xg.ui.createDescriptionEditor(False)

    def paletteUI(self):
        self.palPart = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignTop)
        self.palPart.setLayout(vbox)
        self.palFile = BrowseUI(maya.stringTable[ 'y_xgImportFile.kFileName'  ],
                                maya.stringTable[ 'y_xgImportFile.kFileNameAnn'  ],
                                 "","*.xgen","in")
        self.palFile.optionButton.setToolTip(maya.stringTable[ 'y_xgImportFile.kBrowseForFiles'  ])
        self.palFile.textValue.setText(xg.userRepo())
        vbox.addWidget(self.palFile)
        self.nameSpace = TextUI(maya.stringTable[ 'y_xgImportFile.kNamespace'  ],
                                maya.stringTable[ 'y_xgImportFile.kNamespaceAnn'  ],
                                width=200)
        vbox.addWidget(self.nameSpace)
        if xgg.Maya:
            self.palBindings = CheckBoxUI(maya.stringTable[ 'y_xgImportFile.kIncludePatchBindings'  ],"",
                                          maya.stringTable[ 'y_xgImportFile.kBindingsAnn'  ])
            self.palBindings.setValue(True)
            vbox.addWidget(self.palBindings)
        self.tabs.addTab(self.palPart,maya.stringTable[ 'y_xgImportFile.kCollection'  ])

    def _createRowLayout(self,parent):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setContentsMargins(0,0,0,0)
        row.setLayout(hbox)
        parent.addWidget(row)
        return hbox

    def _createVerticalGroupLayout(self, parentRowLayout ):
        w = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setContentsMargins(0,0,0,0)
        w.setLayout(vbox)
        parentRowLayout.layout().addWidget( w )
        return vbox
    
    def _addSectionLabel(self,parent,text):
        parent.addSpacing(3)
        label = QtGui.QLabel("<b>"+text+"</b>")
        parent.addWidget(label)

    def descriptionUI(self):
        self.descPart = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignTop)
        self.descPart.setLayout(vbox)

        self.descFile = BrowseUI(maya.stringTable[ 'y_xgImportFile.kFileNameDescFile'  ],
                                 maya.stringTable[ 'y_xgImportFile.kFileNameAnn2'  ],
                                 "","*.xdsc","in")
        self.descFile.optionButton.setToolTip(maya.stringTable[ 'y_xgImportFile.kBrowseForFiles2'  ])
        self.descFile.textValue.setText(xg.userRepo())
        vbox.addWidget(self.descFile)

        if xgg.Maya:
            self.descBindings = CheckBoxUI(maya.stringTable[ 'y_xgImportFile.kBindGeometry'  ],"",
                                       maya.stringTable[ 'y_xgImportFile.kBindGeometryAnn'  ])
            self.descBindings.setValue(True)
            vbox.addWidget(self.descBindings)

        rowLayout = self._createRowLayout(vbox)

        # collection radio layout
        radioButtonGroup = self._createVerticalGroupLayout(rowLayout)

        self.addDescriptionToRadio = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportFile.kAddDescriptionToExistingCollection'  ])
        self.addDescriptionToRadio.clicked.connect(self.onClickAddDescriptionToRadio)
        radioButtonGroup.addWidget(self.addDescriptionToRadio)

        self.createNewPaletteRadio = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportFile.kCreateNewCollectionNamed'  ])
        self.createNewPaletteRadio.clicked.connect(self.onClickCreateNewPaletteRadio)
        radioButtonGroup.addWidget(self.createNewPaletteRadio)

        # collection name layout
        paletteNamesGroup = self._createVerticalGroupLayout(rowLayout)

        self.palettes = _ComboBoxUI()
        paletteNamesGroup.addWidget(self.palettes)
        
        self.newPaletteName = QtGui.QLineEdit()
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_:]*")
        self.newPaletteName.setValidator(QtGui.QRegExpValidator(rx,self))
        paletteNamesGroup.addWidget(self.newPaletteName)

        # set palette widgets
        palettes = xg.palettes()
        for pal in palettes:
            self.palettes.addItem(pal)

        if self.palettes.count() > 0:
            self.addDescriptionToRadio.setChecked(True)
            self.newPaletteName.setEnabled(False)
            self.palettes.setCurrentIndex(0)
        else:
            self.addDescriptionToRadio.setEnabled(False)
            self.createNewPaletteRadio.setChecked(True)

        # set the palette text edit
        (self.palFolderNames,self.palPathMaps) = xg.paletteFolderNames( )
        palName = xg.buildPaletteName( str(self.newPaletteName.text()), self.loadedPalettes(), self.palFolderNames )
        self.newPaletteName.setText( palName )

        self.tabs.addTab(self.descPart,maya.stringTable[ 'y_xgImportFile.kDescriptionTab'  ])

    def onClickCreateNewPaletteRadio(self):
        self.newPaletteName.setEnabled(True)
        self.palettes.setEnabled(False)

    def onClickAddDescriptionToRadio(self):
        self.newPaletteName.setEnabled(False)
        self.palettes.setEnabled(True)

    def loadedPalettes(self):
        return [str(self.palettes.itemText(i)) for i in range(self.palettes.count())]

    def buttons(self,layout):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.importButton = QtGui.QPushButton(maya.stringTable[ 'y_xgImportFile.kImport'  ])
        self.importButton.setFixedWidth(100)
        self.importButton.setAutoRepeat(False)
        self.importButton.setToolTip(maya.stringTable[ 'y_xgImportFile.kImportAnn'  ])
        self.connect(self.importButton, QtCore.SIGNAL("clicked()"), self.importCB)
        hbox.addWidget(self.importButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgImportFile.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgImportFile.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)

    def getType(self):
        return self.tabs.currentIndex()
    
    def getPalFile(self):
        return self.palFile.value()
    
    def getNameSpace(self):
        return self.nameSpace.value()
    
    def getDescFile(self):
        return self.descFile.value()

    def getPalette(self):
        if self.addDescriptionToRadio.isChecked():
            return str(self.palettes.currentText())
        else:
            return str(self.newPaletteName.text())

    def loadedPalettes(self):
        return [str(self.palettes.itemText(i)) for i in range(self.palettes.count())]

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
    def getDescriptionName( filename ):
        return xg.getAttrFromFile( 'name', 'Description', filename )
  
    def importCB(self):
        msgImportFailed = maya.stringTable[ 'y_xgImportFile.kImportFail'  ]
        if self.getType() == 0:
            # Import palette
            xgenFile = self.getPalFile()
            if not ImportFileUI.fileExists(xgenFile,maya.stringTable[ 'y_xgImportFile.kFileDoesNotExist'  ]):
                return

            name = ''
            nameSpace = self.getNameSpace()
            if xgg.Maya:
                validator = Validator( xg.ADD_TO_NEW_PALETTE, self )
                name = xg.importBindPalette(xgenFile, nameSpace, validator, self.palBindings.value())
            else:
                name = xg.importPalette(xgenFile,[],nameSpace)

            if not len(name):
                mb = QtGui.QMessageBox()
                mb.setText(msgImportFailed)
                mb.exec_()
                return

            if (xgg.DescriptionEditor != 0 ):
                xgg.DescriptionEditor.refresh("Full")
        else:
            # Import description
            xdscFile = self.getDescFile()
            if not ImportFileUI.fileExists(xdscFile,maya.stringTable[ 'y_xgImportFile.kFileDoesNotExist2'  ]):
                return

            newDesc = ''
            pal = self.getPalette()
            if len(pal) and xgg.Maya:
                if self.descBindings.value():
                    import maya.cmds as cmds
                    # check if selection is appropriate (we require to bind to selection in Maya)
                    geometries = cmds.ls(dag=True,type=['mesh'],sl=True)
                    faces = cmds.filterExpand(selectionMask=34)
                    if not (len(geometries) or faces is not None):
                        mb = QtGui.QMessageBox()
                        mb.setText(maya.stringTable[ 'y_xgImportFile.kPleaseSelectAPolygonSurfaceTip'  ])
                        mb.exec_()
                        return

                action = xg.ADD_TO_NEW_PALETTE if self.createNewPaletteRadio.isChecked() else xg.ADD_TO_EXISTING_PALETTE
                validator = Validator( action, self )
                newDesc = xg.importBindDescription( pal, xdscFile, validator, self.descBindings.value() )
            else:
                newDesc = xg.importDescription(pal,xdscFile)

            if not len(newDesc):
                mb = QtGui.QMessageBox()
                mb.setText(msgImportFailed)
                mb.exec_()
                return

            if (xgg.DescriptionEditor != 0 ):
                xgg.DescriptionEditor.refresh("Full")
                xgg.DescriptionEditor.setCurrentPalette(xg.palette(newDesc))
                xgg.DescriptionEditor.setCurrentDescription(newDesc)
                if xg.igDescription(newDesc) and xgg.Maya:
                    # turn off playblast
                    xgg.DescriptionEditor.setPlayblast( False )
                    # activate grooming tab if required
                    xgg.DescriptionEditor.activateTab( maya.stringTable[ 'y_xgDescriptionEditor.kGrooming' ] )

        # done, accept/close dialog
        self.accept()

class Validator(object):
    """ validate palette and description names for import palette/descriptions """
    overwrite = False
    palette = None

    def __init__(self, action, uiParent ):
        self._action = action
        self._ui = uiParent  
        self._validDescs = list()
    
    @property
    def action(self):
        return self._action

    @staticmethod
    def onCollidePalette( uiParent, newPalette, palette, palettePath ):
        """
        Called by xgen.validateDescription when a new palette collides with an existing one. Gives user a 
        choice to create the new one or overwrite current.
        """
        if not uiParent:
            raise

        title = maya.stringTable[ 'y_xgImportFile.kImportCollectionsOrDescriptionsValidator'  ]
        text = maya.stringTable[ 'y_xgImportFile.kCollectionAlreadyExistsOnDisk'  ] % (palette,palettePath)
        mbox = QtGui.QMessageBox( QtGui.QMessageBox.NoIcon, title, text, QtGui.QMessageBox.NoButton, uiParent )
        newPalNameBtn = QtGui.QPushButton(maya.stringTable[ 'y_xgImportFile.kCreateInstead'  ] % newPalette)
        mbox.addButton( newPalNameBtn, QtGui.QMessageBox.YesRole )
        overPalNameBtn = QtGui.QPushButton(maya.stringTable[ 'y_xgImportFile.kOverwrite'  ] % palette)
        mbox.addButton( overPalNameBtn, QtGui.QMessageBox.AcceptRole )
        mbox.addButton( QtGui.QMessageBox.Cancel )
        mbox.setDefaultButton( newPalNameBtn )
        mbox.exec_()

        if mbox.clickedButton() == newPalNameBtn:
            Validator.overwrite = False
            Validator.palette = newPalette
        elif mbox.clickedButton() == overPalNameBtn:
            Validator.overwrite = True
            Validator.palette = palette
        else:
            return (False, '')
        return (True,Validator.palette)

    @staticmethod
    def onCollideDescription( uiParent, newDesc, desc, descPath ):
        """
        Called by xgen.validateDescription when a new description collides with an existing one. If the user chooses to overwrite 
        the collection then we assume the user also wants to reuse the same description data. 
        """
        # there is a name clash, use newDesc to solve it
        validDesc = newDesc
        if Validator.overwrite:
            # use suggested description name if the collection was overwritten
            validDesc = desc
                    
        return (True, validDesc)

    def __call__(self, descName, palName, id):         
        """ trigger validation """
        (descFolderNames,descPathMaps) = xg.descriptionFolderNames( )        
        (palFolderNames,palPathMaps) = xg.paletteFolderNames( )               
        loadedDescriptions = list(xg.descriptions())
        loadedDescriptions.append(palName)
        loadedDescriptions = list(loadedDescriptions+self._validDescs)
        loadedPalettes = list(xg.palettes())

        if id == 0:
            # validate the palette only once and remember the valid palette
            palInfo = (palName, loadedPalettes, palFolderNames, palPathMaps, Validator.onCollidePalette)
            descInfo = (descName, loadedDescriptions, descFolderNames, descPathMaps, Validator.onCollideDescription)
            (result,validDesc,Validator.palette) = xg.validateDescription( self._action, palInfo, descInfo, self._ui )
        else:
            palInfo = (palName, loadedPalettes, palFolderNames, palPathMaps, None)
            descInfo = (descName, loadedDescriptions, descFolderNames, descPathMaps, Validator.onCollideDescription)
            (result,validDesc,validPalette) = xg.validateDescription( self._action, palInfo, descInfo, self._ui )

        self._validDescs.append(validDesc)
        return (result,validDesc,Validator.palette)

def importFile( which='palette' ):
    """Function to import a file using a dialog.

    This provides a simple dialog to import either a palette or a
    description from a file. The user can use a browser to find the file
    and specify other options specific to the type of input.
    """
    return ImportFileUI( which ).exec_()
