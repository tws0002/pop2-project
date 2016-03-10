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
if xgg.Maya:
    import maya.cmds as cmds
    import maya.mel as mel
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI
from xgenm.ui.widgets import *
from xgenm.ui.xgSetMapAttr import setMapAttr
from xgenm.ui.widgets.xgFileBrowserUI import *
from xgenm.ui.dialogs.xgExportFile import fixFileName
from maya import OpenMaya as om
from maya import OpenMayaUI as omui
from maya import OpenMayaRender as omr
from shiboken import wrapInstance
import os
import shutil 

exportPresetDialog = None
exportPresetDialogTitle = maya.stringTable[ 'y_xgExportPreset.kXgenExportPreset'  ]

class ExportPresetUI(QtGui.QWidget):
    """A dialog to specify the options for exporting XGen description/collection as preset.
    """
    # Define the groom attributes can be included when exporting a description as preset
    igAttrsAsPreset = {'igAutoExportTpu', \
            'visibility', \
            'density', \
            'interpStyle', \
            'mask' , \
            'xuvDir', \
            'tipColor', \
            'baseColor', \
            'displayType', \
            'length', \
            'width'}

    # Define the file version for the grooming settings when exporting a description as preset
    groomFileVersion = 1

    def __init__(self):
        QtGui.QWidget.__init__(self)

        xgg.DescriptionEditor.xgCurrentDescriptionChanged.connect(self.refresh)

        mayaMainWindowPtr = omui.MQtUtil.mainWindow()
        mayaMainWindow = wrapInstance(long(mayaMainWindowPtr), QtGui.QWidget)
        self.setParent(mayaMainWindow)
        self.setWindowFlags(Qt.Window | Qt.WindowStaysOnTopHint)
        self.setWindowTitle(exportPresetDialogTitle)
        self.setMinimumWidth(600)
        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        self.descriptionUI(layout)
        self.thumbnailUI(layout)
        self.buttons(layout)
        self.setLayout(layout)

        self.currentCtx = ""

        self.refresh(True)

    def descriptionUI(self,layout):
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
        label = QtGui.QLabel(maya.stringTable[ 'y_xgExportPreset.kCollectionToExportPreset'  ])
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        hbox.addWidget(label)
        self.palette = _ComboBoxUI()
        self.palette.setMinimumWidth(220)
        self.connect(self.palette, QtCore.SIGNAL("activated(const QString&)"), self.update)
        hbox.addWidget(self.palette)
        row.setLayout(hbox)
        vbox.addWidget(row)
        # row for descriptions
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignLeft)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgExportPreset.kDescriptionToExportAsPreset'  ])
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
        label.setIndent(10)
        hbox.addWidget(label)
        self.description = _ComboBoxUI()
        self.description.setMinimumWidth(220)
        self.description.activated.connect(self.onDescriptionChanged)

        hbox.addWidget(self.description)
        row.setLayout(hbox)
        vbox.addWidget(row)
        # row for file name
        self.xgpFile = BrowseUI(maya.stringTable[ 'y_xgExportPreset.kFileNameForPreset'  ], "", "", "*.xgp", "out")
        self.connect(self.xgpFile.textValue, QtCore.SIGNAL("editingFinished()"), self.onFileSelected)
        vbox.addWidget(self.xgpFile)

        self.exportActiveModule = CheckBoxUI(maya.stringTable[ 'y_xgExportPreset.kExportActivatedModifiersOnly'  ],"")
        self.exportActiveModule.setValue(False)
        vbox.addWidget(self.exportActiveModule)

        layout.addWidget(self.descPart)

    def thumbnailUI(self,layout):
        self.thumbnailToCopy = ""
        self.thumbnailPart = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setSpacing(10)
        hbox.setContentsMargins(1,1,1,20)

        label = QtGui.QLabel(maya.stringTable[ 'y_xgExportPreset.kXGenPresetThumbnail'  ])
        label.setFixedWidth(labelWidth())
        label.setAlignment(QtCore.Qt.AlignRight)
        hbox.addWidget(label)

        defaultImage = os.path.normpath(os.path.join(os.environ['MAYA_LOCATION'], "icons/mayaico.png"))
        self.thumbnailIcon = QtGui.QLabel()
        self.thumbnailIcon.setPixmap(defaultImage)
        self.thumbnailIcon.setFixedWidth(128)
        self.thumbnailIcon.setFixedHeight(128)
        self.thumbnailIcon.setAlignment(QtCore.Qt.AlignLeft)
        self.thumbnailIcon.setSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Expanding)
        self.thumbnailIcon.setScaledContents(True)
        hbox.addWidget(self.thumbnailIcon)

        buttonWidget = QtGui.QWidget()
        buttonVbox = QtGui.QVBoxLayout()
        buttonVbox.setAlignment(QtCore.Qt.AlignTop)
        buttonVbox.setContentsMargins(1,1,1,1)
        self.snapshotButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportPreset.kSnapshotButtonForPresetThumbnail'  ])
        self.snapshotButton.setFixedWidth(120)
        self.snapshotButton.setAutoRepeat(False)
        self.connect(self.snapshotButton, QtCore.SIGNAL("clicked()"), self.snapshotContext)
        buttonVbox.addWidget(self.snapshotButton)
        self.browseButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportPreset.kBrowseButtonForPresetThumbnail'  ])
        self.browseButton.setFixedWidth(120)
        self.browseButton.setAutoRepeat(False)
        self.connect(self.browseButton, QtCore.SIGNAL("clicked()"), self.fileBrowser)
        buttonVbox.addWidget(self.browseButton)
        buttonWidget.setLayout(buttonVbox)
        hbox.addWidget(buttonWidget)

        self.thumbnailPart.setLayout(hbox)
        layout.addWidget(self.thumbnailPart)

    def buttons(self,layout):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(15)
        hbox.setContentsMargins(1,1,1,1)
        self.exportButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportPreset.kExportPreset'  ])
        self.exportButton.setFixedWidth(100)
        self.exportButton.setAutoRepeat(False)
        self.connect(self.exportButton, QtCore.SIGNAL("clicked()"),self.exportCB)
        hbox.addWidget(self.exportButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgExportPreset.kCancelExportPreset'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"), self.close)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)

    def keyPressEvent(self, e):
        if e.key() == QtCore.Qt.Key_Escape:
            self.restoreContext();

    def closeEvent(self, e):
        self.restoreContext();

    def snapshotContext(self):
        currentCtx = cmds.currentCtx() 
        if currentCtx != "xgmPresetSnapshotInstance":

            cmd = "xgmPresetSnapshotContext -q -ex xgmPresetSnapshotInstance"
            if not mel.eval(cmd):
                cmd = "xgmPresetSnapshotContext xgmPresetSnapshotInstance"
                mel.eval(cmd)

            cmds.setToolTo("xgmPresetSnapshotInstance")

            self.currentCtx = currentCtx

    def defaultSnapshot(self):
        view = omui.M3dView().active3dView()
        portWidth = view.portWidth()
        portHeight = view.portHeight()
        scale = min(portWidth, portHeight) / 2
        startX = ( portWidth - scale ) / 2 
        startY = ( portHeight - scale ) / 2

        self.createSnapshot(startX, startY, scale)

    def createSnapshot(self, startX, startY, scale):
        view = omui.M3dView().active3dView()
        portWidth = view.portWidth()
        portHeight = view.portHeight()
        srcImage = om.MImage()
        srcImage.create(portWidth, portHeight)
        if not view.readColorBuffer(srcImage, True):
            rangeX = scale
            rangeY = scale
            if startX < 0:
                rangeX = scale + startX
                startX = 0

            if startY < 0:
                rangeY = scale + startY
                startY = 0

            if (startX + scale) > portWidth:
                rangeX = portWidth -1 - startX 

            if (startY + scale) > portHeight:
                rangeY = portHeight -1 - startY

            srcBuffer = srcImage.pixels()
            self.destImage = QtGui.QImage(rangeX, rangeY, QtGui.QImage.Format_RGB32 )
            
            for x in range(rangeX):
                for y in range(rangeY):
                    w = startX + x
                    h = startY + rangeY - y
                    srcIndex = h * portWidth * 4 + w * 4

                    r = om.MScriptUtil.getUcharArrayItem(srcBuffer, srcIndex + 0)
                    g = om.MScriptUtil.getUcharArrayItem(srcBuffer, srcIndex + 1)
                    b = om.MScriptUtil.getUcharArrayItem(srcBuffer, srcIndex + 2)

                    self.destImage.setPixel(x, y, QtGui.qRgb(r, g, b))

            self.pixmap = QtGui.QPixmap.fromImage(self.destImage)
            self.thumbnailIcon.setPixmap( self.pixmap )

        self.restoreContext();

    def restoreContext(self):
        if self.currentCtx != "":
            cmds.setToolTo(self.currentCtx)
        else:
            cmds.setToolTo("selectSuperContext")

        self.currentCtx = ""

    def fileBrowser(self):
        self.thumbnailToCopy = fileBrowserDlg(self, xg.userRepo(), "*.png *.jpg", "in")
        if len(self.thumbnailToCopy) > 0:
            self.thumbnailIcon.setPixmap(self.thumbnailToCopy)

    def exportFilename( self, obj, ext ):
        """ returns the filename previously used to export obj """
        
        if len(obj)==0:
            return

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
            filename = xg.userRepo() + xg.stripNameSpace(obj) + ext

        return filename

    def update(self):
        # put all the descriptions for palette into description list
        pal = self.getPalette()
        self.description.clear()
        descrs = xg.descriptions(pal)
        currentDesc = xgg.DescriptionEditor.currentDescription()
        index = 0
        for descr in descrs:
            self.description.addItem(descr)
            if descr == currentDesc:
                self.description.setCurrentIndex(index)
            index += 1

        # update the dialog edit widget
        self.xgpFile.textValue.setText( self.exportFilename( currentDesc, '.xgp' ) )

    def refresh(self, defaultSnapshot=False):
        # put all the descriptions for palette into description list

        self.palette.clear()
        palettes = uiPalettes()
        currentPal = xgg.DescriptionEditor.currentPalette()
        index = 0
        for pal in palettes:
            self.palette.addItem(pal)
            if pal == currentPal:
                self.palette.setCurrentIndex(index)
            index += 1

        self.description.clear()
        descrs = xg.descriptions(currentPal)
        currentDesc = xgg.DescriptionEditor.currentDescription()
        index = 0
        for descr in descrs:
            self.description.addItem(descr)
            if descr == currentDesc:
                self.description.setCurrentIndex(index)
            index += 1

        # update the dialog edit widget
        self.xgpFile.textValue.setText( self.exportFilename( currentDesc, '.xgp' ) )

        if defaultSnapshot == True:
            self.defaultSnapshot()

    def onDescriptionChanged( self, index ):
        """ Update the description filename edit widget on new selected description. """
        self.xgpFile.textValue.setText( self.exportFilename( self.description.itemText( index ), '.xgp' ) )

    def onFileSelected(self):
        xgpFileName = self.xgpFile.value()
        xgpFileName = fixFileName(xgpFileName, '.xgp')
        if len(xgpFileName):
             self.xgpFile.setValue(xgpFileName)
    
    def getXgpFile(self):
        return self.xgpFile.value()
    
    def getPalette(self):
        return str(self.palette.currentText())

    def getDescription(self):
        return str(self.description.currentText())

    def groomExportHeader(self):
        text = '# XGen Description Preset File for Grooming Settings\n\n'
        text += '# Author:   ' + mel.eval( 'getenv("USER")' ) + '\n'
        text += '# Date:     ' + cmds.date() + '\n\n'
        text += 'FileVersion ' + str(self.groomFileVersion)  + '\n\n'
        return text

    def exportGroomableSplines(self, pal, desc, xgpFilePath):
        """ Export the groomable settings of the given description to the same folder of the xgp file """
        
        groomDesc = xg.getAttr('groom', pal, desc)
        if len(groomDesc) == 0:
            return

        igmDesc = cmds.listRelatives(groomDesc, type='igmDescription')
        if len(igmDesc) == 0:
            return

        # start a new section
        text = self.groomExportHeader()
        text += xg.stripNameSpace(groomDesc) + '\n'

        for attr in self.igAttrsAsPreset:

            # tpu is defined in the groom transform object instead of the igmDescription object
            if attr == 'igAutoExportTpu':
                attrType = 'float'
                attrValue = str(xg.igDescriptionTpu(groomDesc))
            elif attr == 'visibility':
                fullName = groomDesc + '.' + attr
                attrType = cmds.getAttr(fullName, type=True)
                attrValue = cmds.getAttr(fullName)
            else:
                fullName = igmDesc[0] + '.' + attr
                attrType = cmds.getAttr(fullName, type=True)
                attrValue = cmds.getAttr(fullName)

            text += '\t' + attr

            length = len(attr)
            if length < 8:
                text += '\t\t\t' + attrType
            elif length < 16:
                text += '\t\t' + attrType
            else:
                text += '\t' + attrType

            if attrType == 'float3':
                (r, g, b) = attrValue[0]
                text += '\t\t\t' + str(r) + '\t' + str(g) + '\t' + str(b)
            else:
                text += '\t\t\t' + str(attrValue)

            text += '\n'
        
        text += '\t' + 'endAttrs' + '\n'

        filename = os.path.splitext(xgpFilePath)[0] + '_groom'
        with open(filename, 'w') as groomFile:
            groomFile.write(text)

    def exportMaterial(self, pal, desc, xgpFilePath):
        """ Export the material of the given description to the same folder of the xgp file """
        oldSel = cmds.ls(sl=True)

        shadingEngines = []
        shapes = cmds.listRelatives( desc, shapes=True )
        if shapes:
            for shape in shapes:
                if cmds.objExists(shape) :
                    dest = cmds.listConnections( shape, destination=True, source=False, plugs=False, type="shadingEngine" )
                    if dest and len(dest):
                        shadingEngines = shadingEngines + dest


        archiveMats = []
        primType = xg.getActive(pal, desc, "Primitive" )
        if primType == "ArchivePrimitive":
            files = xg.getAttr( "files", pal, desc, primType)
            files = files.decode("string_escape")
            lines = files.splitlines()
            for line in lines:
                words = line.split()
                for w in words:
                    if w.startswith("material="):
                        mat = w[len("material="):]
                        # Make sure that the material has been imported in maya, then export it.
                        if cmds.objExists(mat):
                            archiveMats.append(mat)

        cmds.select( shadingEngines, r=True, ne=True )
        cmds.select( archiveMats, add=True , ne=False)

        filename = os.path.splitext(xgpFilePath)[0]
        materialFile = filename + "_material.ma"
        result = cmds.file( materialFile, force=True, options="v=0;", typ="mayaAscii", pr=True, es=True )
        
        if oldSel:
            cmds.select( oldSel, r=True )
        else:
            cmds.select( cl=True )

        return result

    def exportThumbnail(self, xgpFilePath):

        try:
            filename = os.path.splitext(xgpFilePath)[0] + ".png"
            pixmap = self.thumbnailIcon.pixmap()
            pixmap.save( filename, "png")
        except:
            return False
        
        return True

    def validateModifiers(self, pal, desc):

        modNotIncluded = "" 

        modules = xg.fxModules(pal, desc)
        for mod in modules:
            type = xg.fxModuleType(pal, desc, mod)
            active = xg.getAttr("active", pal, desc, mod).lower()

            if type == "BakedGroomManagerFXModule" and active == "true": 
                text = maya.stringTable['y_xgExportPreset.kGroomBakeModifierNotSupport'  ] % mod
                text += maya.stringTable['y_xgExportPreset.kGroomBakeModifierNotSupportDetail' ]

                selection = QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text, QtGui.QMessageBox.Ok | QtGui.QMessageBox.Cancel)
                if selection == QtGui.QMessageBox.Cancel:
                    return False

            included = xg.fxModuleIncludedInPreset(pal, desc, mod)
            if not included:
                if not self.exportActiveModule.value() or active == "true":
                    modNotIncluded += "    " + mod + "\n"
            
                        
        if len(modNotIncluded) != 0:
            text = maya.stringTable[ 'y_xgExportPreset.kModifiersNotSupportInPreset'  ]
            text += "\n\n" + modNotIncluded
            text += maya.stringTable[ 'y_xgExportPreset.kDoYouWantToContinueAgain' ]

            selection = QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text, QtGui.QMessageBox.Ok | QtGui.QMessageBox.Cancel)
            if selection == QtGui.QMessageBox.Cancel:
                return False

        return True
        
    def exportCB(self):

        # When export from xgen menu, set the texture info to attributes
        setMapAttr()
        
        xgpFileName = self.getXgpFile()
        xgpFileName = fixFileName(xgpFileName, '.xgp')

        if os.path.isfile(xgpFileName):
            text = maya.stringTable['y_xgExportPreset.kPresetFileExists' ] % xgpFileName
            selection = QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text, QtGui.QMessageBox.Ok | QtGui.QMessageBox.Cancel)
            if selection == QtGui.QMessageBox.Cancel:
                return

        pal = self.getPalette()
        desc = self.getDescription()
        if len(xgpFileName) and len(pal) and len(desc):
 
            if not self.validateModifiers(pal, desc):
                self.close()
                return

            primType = xg.getActive( pal, desc, 'Primitive' )
            if 'SplinePrimitive' == primType:
                result = xg.exportDescriptionAsPreset( pal, desc, xgpFileName, self.exportActiveModule.value(), guides=True )
            else:
                result = xg.exportDescriptionAsPreset( pal, desc, xgpFileName, self.exportActiveModule.value(), guides=False )
            if result:
                # save file name for reuse
                xg.setAttrValue( desc, ('export_filename',xgpFileName,'string') )
            else:
                text = maya.stringTable[ 'y_xgExportPreset.kExportPresetFail'  ]
                QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text)
                self.close()
                return

            self.exportGroomableSplines(pal, desc, xgpFileName)

            result = self.exportMaterial(pal, desc, xgpFileName)
            if not result:
                text = maya.stringTable[ 'y_xgExportPreset.kExportMaterialFail'  ]
                QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text)

            result = self.exportThumbnail(xgpFileName)
            if not result:
                text = maya.stringTable[ 'y_xgExportPreset.kExportThumbnailFail'  ]
                QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text)

        else:
            text = maya.stringTable[ 'y_xgExportPreset.kYouMustSpecifyFilenameWhenExportPreset'  ]
            QtGui.QMessageBox.warning(self, exportPresetDialogTitle, text)
            return

        # done, accept/close dialog
        self.close()

def exportPreset():
    """Function to export a preset using a dialog.
    """
    global exportPresetDialog

    if len(uiPalettes()) == 0:
        tellem = maya.stringTable[ 'y_xgExportPreset.kThereAreNoCollectionsToExportPreset'  ]
        QtGui.QMessageBox.warning(exportPresetDialog, exportPresetDialogTitle, tellem)
        return

    if exportPresetDialog == None:
        exportPresetDialog = ExportPresetUI()
    else:
        exportPresetDialog.refresh(True)

    exportPresetDialog.showNormal()

def grabSnapshotInExportPresetDialog(x, y, scale):
    global exportPresetDialog
    if exportPresetDialog != None:
        exportPresetDialog.createSnapshot(x, y, scale)

def hasExportPresetDialog():
    return exportPresetDialog != None
