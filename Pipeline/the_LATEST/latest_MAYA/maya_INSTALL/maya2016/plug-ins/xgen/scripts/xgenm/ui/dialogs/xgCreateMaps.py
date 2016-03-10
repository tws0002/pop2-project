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



import string
import os

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets.xgBrowseUI import *
from xgenm.ui.widgets.xgFloatUI import *
from xgenm.ui.util.xgUtil import labelWidth
from xgenm.ui.util.xgComboBox import _ComboBoxUI
from xgenm.ui.widgets.xgFloatUI import _sliderNumSteps

import maya.cmds as cmds
import maya.mel as mel

MAINDIR = str("${DESC}/paintmaps")

class CreateMapsUI(QtGui.QDialog):
    startColorCombo = "basedOnAttribute"
    mapResolution = 5.0
    createDir = False
    cleanFoldername = ""
    """A dialog to specify the options for creating an XGen expression map. """
    def __init__(self,attr,defaultFolder="",useRGB=False):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgCreateMaps.kCreateMap'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(550)
        self.layout = QtGui.QVBoxLayout()
        self.layout.setAlignment(QtCore.Qt.AlignTop)
        self.desc = xgg.DescriptionEditor.currentDescription()
        self.exprAttr = attr
        self.defaultFolder = defaultFolder
        self.isBrowseMode = True if defaultFolder != "" else False
        self.isRGB = useRGB

        # change some defaults if in browse ui mode or RGB mode
        global MAINDIR
        if self.isRGB:
            CreateMapsUI.startColorCombo = "red"
        else:
            CreateMapsUI.startColorCombo = "white"

        if self.isBrowseMode:
            MAINDIR = str("${DESC}")            
        else:
            MAINDIR = str("${DESC}/paintmaps")
        
        self.createUI()
        self.setLayout(self.layout)

    def createUI(self):

        # clean the foldername of unwanted brackets that may come from custom expressions
        self.exprAttr = self.exprAttr.replace('[','_')
        self.exprAttr = self.exprAttr.replace(']','_')

        if self.defaultFolder == "":
            foldername = self.exprAttr
            bareFoldername = self.exprAttr
        else:
            foldername = self.defaultFolder
            bareFoldername = self.defaultFolder

        path = fullPath(MAINDIR)
        if ( not dirExists() ): 
            CreateMapsUI.createDir = True
        else:
            if os.path.isdir(path):
                folders = os.listdir( path )
                
                # search if foldername already exists, increment if it does
                suffix = 1
                for folder in sorted(folders):
                    if foldername == folder:
                        foldername = bareFoldername + str(suffix)
                        suffix += 1

        CreateMapsUI.cleanFoldername = foldername

        # Map name
        maprow = QtGui.QWidget()
        maplayout = QtGui.QHBoxLayout()
        maplayout.setAlignment(QtCore.Qt.AlignLeft)
        maplayout.setContentsMargins(1,1,1,1)
        self.mapLabel = QtGui.QLabel(maya.stringTable[ 'y_xgCreateMaps.kMapName'  ])
        self.mapLabel.setFixedWidth(labelWidth())
        self.mapLabel.setAlignment(QtCore.Qt.AlignRight)
        self.mapLabel.setIndent(10)
        maplayout.addWidget(self.mapLabel)
        self.mapEdit = QtGui.QLineEdit()
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_]*")
        self.mapEdit.setValidator(QtGui.QRegExpValidator(rx,self))
        self.mapEdit.setText(CreateMapsUI.cleanFoldername)
        self.connect(self.mapEdit, QtCore.SIGNAL("editingFinished()"), self.editTextBox )
        maplayout.addWidget(self.mapEdit)
        maprow.setLayout(maplayout)
        self.layout.addWidget(maprow)

        # Map Resolution
        self.resSlider = FloatUI(maya.stringTable[ 'y_xgCreateMaps.kMapResolution'  ],
             maya.stringTable[ 'y_xgCreateMaps.kMapResolutionAnn'  ],
             "",0,)
        self.resSlider.setValue(CreateMapsUI.mapResolution)
        self.resSlider.editChanged()
        # set the slider to update the static member
        self.connect(self.resSlider.slider, QtCore.SIGNAL("valueChanged(int)"), self.sliderChanged )
        self.layout.addWidget(self.resSlider)
        
        # Help Text
        # TO-DO: Make dynamic to object?
        self.texelHelp = QtGui.QLabel(maya.stringTable[ 'y_xgCreateMaps.kTotalResolutionHelp'  ])
        self.texelHelp.setAlignment(QtCore.Qt.AlignLeft)
        self.texelHelp.setIndent(labelWidth())
        #self.layout.addWidget(self.texelHelp)

        # Combo box
        comborow = QtGui.QWidget()
        combobox = QtGui.QHBoxLayout()
        combobox.setAlignment(QtCore.Qt.AlignLeft)
        combobox.setContentsMargins(1,1,1,1)
        self.colorLabel = QtGui.QLabel(maya.stringTable[ 'y_xgCreateMaps.kStartColor'  ])
        self.colorLabel.setToolTip(maya.stringTable[ 'y_xgCreateMaps.kStartColorAnn'  ])
        self.colorLabel.setFixedWidth(labelWidth())
        self.colorLabel.setAlignment(QtCore.Qt.AlignRight)
        self.colorLabel.setIndent(10)
        combobox.addWidget(self.colorLabel)
        self.startColorCB = _ComboBoxUI()
        # choose if maps will be coloured or monochrome
        if self.isRGB:
            self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kRed'  ], "red")
            self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kGreen'  ], "green")
            self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kBlue'  ], "blue")
        else:
            if not self.isBrowseMode:
                self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kBasedOnAttribute'  ],"basedOnAttribute")
            self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kWhite'  ], "white")
            self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kBlack'  ], "black")
            self.startColorCB.addItem(maya.stringTable[ 'y_xgCreateMaps.kGrey'  ], "grey")
        self.startColorCB.setCurrentIndex(self.startColorCB.findData(CreateMapsUI.startColorCombo))
        self.connect(self.startColorCB, QtCore.SIGNAL("activated(int)"),self.typeUIChangedSlot)
        combobox.addWidget(self.startColorCB)
        comborow.setLayout(combobox)
        self.layout.addWidget(comborow)

        buttonRow = QtGui.QWidget()
        buttonLayout = QtGui.QHBoxLayout()
        buttonLayout.setAlignment(QtCore.Qt.AlignRight)
        buttonLayout.setSpacing(3)
        buttonLayout.setContentsMargins(1,1,1,1)
        self.createButton = QtGui.QPushButton(maya.stringTable[ 'y_xgCreateMaps.kCreate'  ])
        self.connect(self.createButton, QtCore.SIGNAL("clicked()"),self.accept)
        buttonLayout.addWidget(self.createButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgCreateMaps.kCancel'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),self.reject)
        buttonLayout.addWidget(self.cancelButton)
        buttonRow.setLayout(buttonLayout)

        self.layout.addWidget(buttonRow)

    def typeUIChangedSlot(self,pos):
        CreateMapsUI.startColorCombo = str(self.startColorCB.itemData(pos))
        self.startColorCB.setCurrentIndex(pos)

    def editTextBox(self):
        CreateMapsUI.cleanFoldername = self.mapEdit.text()

    def sliderChanged(self,val):
        CreateMapsUI.mapResolution = val/float(_sliderNumSteps)
        self.resSlider.editChanged()

def fullPath(path):
    desc = xgg.DescriptionEditor.currentDescription()
    if desc == "":
        return
    return xg.expandFilepath( MAINDIR, desc )

def dirExists():
    dir = fullPath(MAINDIR)
    return True if os.path.exists(dir) else False
 

def createDir():
    dir = fullPath(MAINDIR)
    if not os.path.exists(dir):
        os.makedirs(dir)

def createMap(attr,ptexBaker,defaultFolder="",isRGB=False):
    dialog = CreateMapsUI(attr,defaultFolder,isRGB)
    result = dialog.exec_()

    if result == QtGui.QDialog.Accepted:
        if CreateMapsUI.createDir:
            createDir()
        newAttr = CreateMapsUI.cleanFoldername
        tpu = CreateMapsUI.mapResolution
        startcolor = CreateMapsUI.startColorCombo

        cpal = xgg.DescriptionEditor.currentPalette()
        cdesc = xgg.DescriptionEditor.currentDescription()
        geoms = xg.boundGeometry(cpal,cdesc)

        path = MAINDIR+"/"+newAttr
        expr = str("$a=map('"+path+"');#3dpaint,"+str(tpu)+"\\n$a\\n")
        return (startcolor, expr, newAttr, path)
    else:
        return (0,"","","")
