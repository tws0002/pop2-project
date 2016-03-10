# ===========================================================================
# Copyright 2014 Autodesk, Inc. All rights reserved.
#
# Use of this software is subject to the terms of the Autodesk license
# agreement provided at the time of installation or download, or which
# otherwise accompanies this software in either electronic or hard copy form.
# ===========================================================================
import maya
maya.utils.loadStringResourcesForModule(__name__)


import string

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
import xgenm.XgExternalAPI as base
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI
from xgenm.ui.widgets import *
from maya import OpenMayaUI as omui
from shiboken import wrapInstance
import os

if xgg.Maya:
    import maya
    import maya.cmds as cmds

importPresetDialog = None
importPresetDialogTitle = maya.stringTable[ 'y_xgImportPreset.kImportPresetToSelectedGeometry'  ]

class ImportPresetUI(QtGui.QWidget):
    """A dialog to specify the options for importing an XGen Preset and apply it to the selected geometry.
    """
    def __init__(self, path=None):
        QtGui.QWidget.__init__(self)
        mayaMainWindowPtr = omui.MQtUtil.mainWindow()
        mayaMainWindow = wrapInstance(long(mayaMainWindowPtr), QtGui.QWidget)
        self.setParent(mayaMainWindow)
        self.setWindowFlags(Qt.Window | Qt.WindowStaysOnTopHint)
        self.setWindowTitle(importPresetDialogTitle)
        self.setMinimumWidth(550)
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        self.setLayout(layout)
        self.descriptionUI(layout)
        self.buttons(layout)

        xg.ui.createDescriptionEditor(False)

        self.refresh(path)

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

    def descriptionUI(self,layout):
        self.descPart = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignTop)
        self.descPart.setLayout(vbox)

        self.xgpFile = BrowseUI(maya.stringTable[ 'y_xgImportPreset.kFileNameOfPreset'  ], "", "", "*.xgp", "in")
        self.connect(self.xgpFile.textValue, QtCore.SIGNAL("editingFinished()"), self.onPresetFileEditingFinish)
        vbox.addWidget(self.xgpFile)

        hbox = self._createRowLayout(vbox)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgImportPreset.kNewDescriptionNameForPreset'  ])
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        hbox.addWidget(label)
        self.newDescName = QtGui.QLineEdit()
        rx = QtCore.QRegExp("[A-Za-z]+[A-Za-z0-9_]*")
        self.newDescName.setValidator(QtGui.QRegExpValidator(rx,self))
        hbox.addWidget(self.newDescName)

        rowLayout = self._createRowLayout(vbox)

        # collection radio layout
        radioButtonGroup = self._createVerticalGroupLayout(rowLayout)

        self.addDescriptionToRadio = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kAddPresetToExistingCollection'  ])
        self.addDescriptionToRadio.clicked.connect(self.onClickAddDescriptionToRadio)
        radioButtonGroup.addWidget(self.addDescriptionToRadio)

        self.createNewPaletteRadio = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kCreateNewCollectionForPreset'  ])
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

        separator = QtGui.QFrame()
        separator.setFrameShape(QtGui.QFrame.HLine);
        separator.setFrameShadow(QtGui.QFrame.Sunken);
        vbox.addWidget( separator )

        # guides options
        guideOptionLabel = QtGui.QLabel(maya.stringTable[ 'y_xgImportPreset.kGuideOptionForPreset'  ])
        vbox.addWidget(guideOptionLabel)
        rowLayout1 = self._createRowLayout(vbox)
        generateGuideLabel = QtGui.QLabel(maya.stringTable[ 'y_xgImportPreset.kGenerateGuides'  ])
        generateGuideLabel.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTop)
        generateGuideLabel.setFixedWidth(150)
        rowLayout1.addWidget(generateGuideLabel)
        self.guideOptionGroup = self._createVerticalGroupLayout(rowLayout1)
        self.transferGuide = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kTransferGuide'  ])
        self.transferGuide.clicked.connect(self.onClickTransferGuide)
        self.guideOptionGroup.addWidget(self.transferGuide)
        self.noGuide = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kNoGuide'  ])
        self.noGuide.clicked.connect(self.onClickNoGuide)
        self.guideOptionGroup.addWidget(self.noGuide)

        # guides transfer options
        rowLayout2 = self._createRowLayout(vbox)
        guideTranferLabel = QtGui.QLabel(maya.stringTable[ 'y_xgImportPreset.kGuideTranferForPreset'  ])
        guideTranferLabel.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTop)
        guideTranferLabel.setFixedWidth(150)
        rowLayout2.addWidget(guideTranferLabel)
        self.guideTransferRadioButtonGroup = self._createVerticalGroupLayout(rowLayout2)
        self.posBasedGuideTransfer = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kPosBasedGuideTransfer'  ])
        self.posBasedGuideTransfer.clicked.connect(self.onClickPosBasedGuideTransfer)
        self.guideTransferRadioButtonGroup.addWidget(self.posBasedGuideTransfer)
        self.uvBasedGuideTransfer = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kUVBasedGuideTransfer'  ])
        self.uvBasedGuideTransfer.clicked.connect(self.onClickUVBasedGuideTransfer)
        self.guideTransferRadioButtonGroup.addWidget(self.uvBasedGuideTransfer)

        # orientation
        rowLayout4 = self._createRowLayout(vbox)
        guideOrientionTransfer = QtGui.QLabel(maya.stringTable[ 'y_xgImportPreset.kGuideOrientionTransfer'  ])
        guideOrientionTransfer.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTop)
        guideOrientionTransfer.setFixedWidth(150)
        rowLayout4.addWidget(guideOrientionTransfer)
        self.guideOrientationTransferRadioButtonGroup = self._createVerticalGroupLayout(rowLayout4)
        self.rotateGuideOrientationToNewNormal = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kRotateGuideOrientationToNewNormal'  ])
        self.guideOrientationTransferRadioButtonGroup.addWidget(self.rotateGuideOrientationToNewNormal)
        self.keepGuideOrientation = QtGui.QRadioButton(maya.stringTable[ 'y_xgImportPreset.kKeepGuideOrientation'  ])
        self.guideOrientationTransferRadioButtonGroup.addWidget(self.keepGuideOrientation)

        layout.addWidget(self.descPart)

    def mousePressEvent(self, event):
        focused_widget = QtGui.QApplication.focusWidget()
        if focused_widget == self.xgpFile.textValue:
            focused_widget.clearFocus()
        QtGui.QMainWindow.mousePressEvent(self, event)

    def onPresetFileEditingFinish(self):
        self.refresh(self.xgpFile.textValue.text())

    def refresh(self, path = None):
        presetType = ""
        if path is None:
            path = xg.userRepo()
        else:
            presetType = getPresetType(path)
        self.xgpFile.textValue.setText(path)

        self.palettes.setEnabled(True)
        self.palettes.clear()
        palettes = uiPalettes()
        for pal in palettes:
            self.palettes.addItem(pal)

        self.addDescriptionToRadio.setEnabled(True)
        self.createNewPaletteRadio.setEnabled(True)
        self.newPaletteName.setEnabled(True)
        self.newDescName.setEnabled(True)

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

        # set the description text edit
        (self.descFolderNames,self.descPathMaps) = xg.descriptionFolderNames( )
        descName = xg.buildDescriptionName( str(self.newDescName.text()), self.loadedDescriptions(palName), self.descFolderNames )
        self.newDescName.setText( descName )

        # guides options
        if presetType == "Guide":
            if self.transferGuide.isEnabled() and (self.transferGuide.isChecked() or self.noGuide.isChecked()):
                return
            else:
                self.onClickTransferGuide()
                self.onClickPosBasedGuideTransfer()
                self.transferGuide.setEnabled(True)
                self.noGuide.setEnabled(True)
                self.transferGuide.setChecked(True)
                self.posBasedGuideTransfer.setChecked(True)
                self.rotateGuideOrientationToNewNormal.setChecked(True)
        else:
            self.transferGuide.setEnabled(False)
            self.noGuide.setEnabled(False)
            self.posBasedGuideTransfer.setEnabled(False)
            self.uvBasedGuideTransfer.setEnabled(False)
            self.rotateGuideOrientationToNewNormal.setEnabled(False)
            self.keepGuideOrientation.setEnabled(False)

    def onClickCreateNewPaletteRadio(self):
        self.newPaletteName.setEnabled(True)
        self.palettes.setEnabled(False)

    def onClickAddDescriptionToRadio(self):
        self.newPaletteName.setEnabled(False)
        self.palettes.setEnabled(True)

    def onClickTransferGuide(self):
        self.posBasedGuideTransfer.setEnabled(True)
        self.uvBasedGuideTransfer.setEnabled(True)
        if self.posBasedGuideTransfer.isChecked():
            self.onClickPosBasedGuideTransfer()
        else:
            self.onClickUVBasedGuideTransfer()

    def onClickNoGuide(self):
        self.posBasedGuideTransfer.setEnabled(False)
        self.uvBasedGuideTransfer.setEnabled(False)
        self.rotateGuideOrientationToNewNormal.setEnabled(False)
        self.keepGuideOrientation.setEnabled(False)

    def onClickPosBasedGuideTransfer(self):
        self.rotateGuideOrientationToNewNormal.setEnabled(True)
        self.keepGuideOrientation.setEnabled(True)

    def onClickUVBasedGuideTransfer(self):
        self.rotateGuideOrientationToNewNormal.setEnabled(False)
        self.keepGuideOrientation.setEnabled(False)

    def loadedDescriptions( self, palName ):
        """ return list of all loaded description names in xgen """

        # get all descriptions in the scene
        names = list(xg.descriptions( ))

        # we want to make sure there is no clash with the palette 
        names.append(palName)

        return names

    def loadedPalettes(self):
        return [str(self.palettes.itemText(i)) for i in range(self.palettes.count())]

    def buttons(self,layout):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.importButton = QtGui.QPushButton(maya.stringTable[ 'y_xgImportPreset.kImport'  ])
        self.importButton.setFixedWidth(100)
        self.importButton.setAutoRepeat(False)
        self.connect(self.importButton, QtCore.SIGNAL("clicked()"), self.importCB)
        hbox.addWidget(self.importButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgImportPreset.kCancelImport'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),
                     self.close)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
    
    def getXgpFile(self):
        return self.xgpFile.value()

    def getPalette(self):
        if self.addDescriptionToRadio.isChecked():
            return str(self.palettes.currentText())
        else:
            return str(self.newPaletteName.text())

    def loadedPalettes(self):
        return [str(self.palettes.itemText(i)) for i in range(self.palettes.count())]

    @staticmethod
    def fileExists( file, msg ):
        global importPresetDialog
        import os    
        if not os.path.isfile(file):
            QtGui.QMessageBox.warning(importPresetDialog, importPresetDialogTitle, msg)
            return False
        return True

    def importGroomableSplines(self, descName, palName, xgpFilePath):
        """ Import the grooming settings if the preset is a groomable spline preset """

        igDesc = xg.getAttr('groom', palName, descName)
        if len(igDesc) == 0:
            return

        igmDesc = cmds.listRelatives(igDesc, type='igmDescription')
        if len(igmDesc) == 0:
            return

        filename = os.path.splitext(xgpFilePath)[0] + '_groom'
        if not os.path.isfile(filename):
            baseName = os.path.basename(filename)
            dirName = os.path.dirname(filename)
            cmds.warning(maya.stringTable['y_xgImportPreset.kMissGroom' ] % (baseName, dirName))
            return

        with open(filename, 'r') as groomFile:

            # groom section starts
            groomStart = False

            lines = groomFile.readlines()
            for line in lines:
                # groom name
                if line.startswith('groom_'):
                    groomStart = True
                    continue

                if not groomStart:
                    continue

                # the end
                if 'endAttrs' in line:
                    break

                attr = line.split()
                if len(attr) < 3:
                    continue

                (attrName, attrType, attrValue) = (attr[0], attr[1], attr[2])
                if attrName == 'igAutoExportTpu':
                    xg.setAttrValue(igDesc, (attrName, float(attrValue), attrType))
                    continue

                if attrName == 'visibility':
                    xg.setAttrValue(igDesc, (attrName, attrValue=='True', attrType))
                    continue

                fullName = igmDesc[0] + '.' + attrName
                if attrType == 'string':
                    if attrValue == 'None':
                        attrValue = ''
                    cmds.setAttr( fullName, attrValue, type=attrType )
                elif attrType == 'float':
                    cmds.setAttr( fullName, float(attrValue) )
                elif attrType == 'bool':
                    cmds.setAttr( fullName, attrValue=='True' )
                elif attrType == 'long':
                    cmds.setAttr( fullName, int(attrValue) )
                elif attrType == 'float3':
                    if len(attr) != 5:
                        continue
                    cmds.setAttr( fullName, float(attr[2]), float(attr[3]), float(attr[4]), type='float3' )

    def importMaterial(self, descName, palName, xgpFilePath):

        oldSel = cmds.ls(sl=True)

        # Import the material for non archive based primitive
        defaultShader = True
        filename = os.path.splitext(xgpFilePath)[0]
        materialFile = filename + "_material.ma"
        if os.path.isfile(materialFile):
            nodes  = cmds.file( materialFile, i=True, type="mayaAscii", ignoreVersion=True, ra=True, mergeNamespacesOnClash=True, options="v=0;p=17;f=0", pr=True, rnn=True )
            if nodes: 
                primType = xg.getActive(palName, descName, "Primitive" )
                for node in nodes:
                    if primType != "ArchivePrimitive" and cmds.nodeType(node) == "shadingEngine":
                        cmds.select( descName, r=True )
                        cmds.hyperShade( assign = node )
                        defaultShader = False

                    prefix = os.path.basename(filename) + "_material_"
                    if node.startswith(prefix):
                        newName = node[len(prefix):]
                        if len(newName) > 0:
                            cmds.rename(node, newName)

        # If the preset has no material attached, create a default one for it.
        if defaultShader and mel.eval('exists "xgmr"'):
            cmds.xgmr( applyShader="hair", description=descName, palette=palName )

        if oldSel:
            cmds.select(oldSel, r=True)
        else:
            cmds.select(cl=True)

    def importCB(self):
        # Import description
        xgpFileName = self.getXgpFile()
        if not ImportPresetUI.fileExists(xgpFileName,maya.stringTable[ 'y_xgImportPreset.kPresetFileDoesNotExist'  ]):
            return

        newDesc = ''
        pal = self.getPalette()
        if len(pal) and xgg.Maya:
            # check if selection is appropriate (we require to bind to selection in Maya)
            geometries = cmds.ls(dag=True,type=['mesh'],sl=True)
            faces = cmds.filterExpand(selectionMask=34)
            if not (len(geometries) or faces is not None):
                text = maya.stringTable[ 'y_xgImportPreset.kPleaseSelectAPolygonSurfaceForPresetTip'  ]
                QtGui.QMessageBox.warning(self, importPresetDialogTitle, text)
                self.close()
                return

            action = xg.ADD_TO_NEW_PALETTE if self.createNewPaletteRadio.isChecked() else xg.ADD_TO_EXISTING_PALETTE
            validator = PresetValidator( action, self )
            newDesc = xg.importDescriptionAsPreset( pal, xgpFileName, validator, guides=self.transferGuide.isChecked(),
                        placeGuidesWithUVBasedMethod=self.uvBasedGuideTransfer.isChecked(),
                        rotateGuide=self.rotateGuideOrientationToNewNormal.isChecked())

        if not len(newDesc):
            text = maya.stringTable[ 'y_xgImportPreset.kImportPresetFail'  ]
            QtGui.QMessageBox.warning(self, importPresetDialogTitle, text)
            self.close()
            return

        # get palette from new description as it might have been changed during the validation
        pal = base.palette(newDesc)

        self.importMaterial(newDesc, pal, xgpFileName)

        if (xgg.DescriptionEditor != 0 ):
            xgg.DescriptionEditor.refresh("Full")
            xgg.DescriptionEditor.setCurrentPalette(xg.palette(newDesc))
            xgg.DescriptionEditor.setCurrentDescription(newDesc)
            if xg.igDescription(newDesc) and xgg.Maya:
                # turn off playblast
                xgg.DescriptionEditor.setPlayblast( False )

                # activate grooming tab if required
                self.importGroomableSplines(newDesc, pal, xgpFileName)
                xgg.DescriptionEditor.refresh("Description")
                xgg.DescriptionEditor.activateTab( maya.stringTable[ 'y_xgDescriptionEditor.kGrooming' ] )

        # Generate point map and clump map
        modules = xg.fxModules(pal, newDesc)
        for mod in modules:
            type = xg.fxModuleType(pal, newDesc, mod)
            if type != "ClumpingFXModule" and type != "AnimWiresFXModule":
                continue

            density = xg.getAttr("ptDensity", pal, newDesc, mod)
            mask = xg.getAttr("ptMask", pal, newDesc, mod)
            pointPath = xg.getAttr("pointDir", pal, newDesc, mod)
            mapPath = xg.getAttr("mapDir", pal, newDesc, mod)
            texPerUnit = xg.getAttr("texelsPerUnit", pal, newDesc, mod)
            radVariance = xg.getAttr("radiusVariance", pal, newDesc, mod)
            cmds.xgmPoints(generatePoints=[float(density),mask], module=mod)
            cmds.xgmPoints(savePoints=pointPath, module=mod)
            cmds.xgmClumpMap(progressBar=True, fxmodule=mod, mapDir=mapPath, pointDir=pointPath, texelsPerUnit=float(texPerUnit), radiusVariance=radVariance, description=newDesc)

        # done, accept/close dialog
        self.close()

class PresetValidator(object):
    """ validate palette and description names for importing preset """
    overwrite = False

    def __init__(self, action, uiParent ):
        self._action = action
        self._ui = uiParent  
        self._validDescs = list()
    
    @property
    def action(self):
        return self._action

    @staticmethod
    def onCollideDescription( uiParent, newDesc, desc, descPath ):
        """
        Called by xgen.validateDescription when a new description collides with an existing one. If the user chooses to overwrite 
        the collection then we assume the user also wants to reuse the same description data. 
        """
        # there is a name clash, use newDesc to solve it
        validDesc = newDesc
        if PresetValidator.overwrite:
            # use suggested description name if the collection was overwritten
            validDesc = desc
                    
        return (True, validDesc)

    def __call__(self, descName, palName, id):         
        """ trigger validation """
        (descFolderNames,descPathMaps) = xg.descriptionFolderNames( )        
        (palFolderNames,palPathMaps) = xg.paletteFolderNames( )               
        loadedDescriptions = list(xg.descriptions())
        loadedDescriptions.extend(self._validDescs)
        loadedDescriptions.append(palName)
        loadedPalettes = list(uiPalettes())
        descName = str(self._ui.newDescName.text())

        palInfo = (palName, loadedPalettes, palFolderNames, palPathMaps, None)
        descInfo = (descName, loadedDescriptions, descFolderNames, descPathMaps, PresetValidator.onCollideDescription)
        (result,validDesc,validPalette) = xg.validateDescription( self._action, palInfo, descInfo, self._ui )

        self._validDescs.append(validDesc)
        return (result,validDesc,validPalette)

def getPresetType(filename):
    """Function to get the type of the preset for the given xgp file.
    """
    try:
        with open(filename, 'r') as groomFile:
            for line in groomFile:
                if line.startswith('XGenPresetType'):
                    attr = line.split()
                    if len(attr) != 3:
                        break;
                    elif attr[1] == "ArchivePrimitive":
                        return "Archive"
                    else:
                        return attr[2]
    except:
        pass

    return ""

def importPreset():
    """Function to import a preset using a dialog.
    """
    global importPresetDialog
    if importPresetDialog == None:
        importPresetDialog = ImportPresetUI()
    else:
        importPresetDialog.refresh()

    importPresetDialog.showNormal()


def importPresetWithPath(value):
    """Function to import a preset using a filepath.
    """
    global importPresetDialog
    if importPresetDialog == None:
        importPresetDialog = ImportPresetUI(value)
    else:
        importPresetDialog.refresh(value)

    importPresetDialog.showNormal()
