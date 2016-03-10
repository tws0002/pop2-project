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
# @file igExport.py
# @brief igroom export dialog
#

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
import maya.cmds as cmds
import maya.mel as mel
from xgenm.ui.util.xgUtil import *
from xgenm.ui.widgets import *

__all__ = [ 'igExportFile' ]

class igExportUI(QtGui.QDialog):
    class PtexUI(QtGui.QWidget):
        def __init__(self,path,tpu):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            self.path = FileBrowserUI(maya.stringTable[ 'y_igExport.kFolderPathPtexExport'  ],
                                 maya.stringTable[ 'y_igExport.kFullPathAnn'  ],"","out")
            self.path.optionButton.setToolTip(maya.stringTable[ 'y_igExport.kBrowseForAFolder'  ])
            self.path.setValue( path )
            vbox.addWidget(self.path)
        
            help =maya.stringTable[ 'y_igExport.kTexelsPerUnitAnn'  ]
            self.tpu = FloatUI( maya.stringTable[ 'y_igExport.kTexelsPerUnit'  ], help, '', 0.001, 10000.0, 0.001, 100.0)
            self.tpu.setValue( tpu )
            vbox.addWidget(self.tpu)

    class MapExporter(QtGui.QWidget):
        def __init__(self, tabs):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            expDir = xg.getOptionVarString( 'igAutoExportFolder' )
            tpu = xg.igDescriptionTpu( xg.igDescription( xgg.DescriptionEditor.currentDescription() ) )

            self.ptexWidget = igExportUI.PtexUI( expDir, tpu )
            vbox.addWidget(self.ptexWidget)

            help=(maya.stringTable[ 'y_igExport.kMethodTypeAnn'  ])
            self.instMeth = RadioUI( maya.stringTable[ 'y_igExport.kInstanceMethod'  ],
                                     [maya.stringTable[ 'y_igExport.kCopyNearest'  ],
                                      maya.stringTable[ 'y_igExport.kInterpolate'  ]], help )
            self.instMeth.setValue( 0 )
            vbox.addWidget(self.instMeth)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igExport.kAttributeMaps'  ]) 

        def doIt(self):
            path = self.ptexWidget.path.value()
            tpu = float(self.ptexWidget.tpu.value())
            instMeth = int(self.instMeth.value())
            desc = xgg.DescriptionEditor.currentDescription()
            expandedPath = FileBrowserUI.createFolder(path,desc,self)
            if not expandedPath:
                return False

            igDescr = xg.igDescription( desc )

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'iGroom -xm "%s" -tpu %f -in %d -d "%s";' % (expandedPath,tpu,instMeth,igDescr) )
            finally:
                cmds.waitCursor( state=False )

            xg.XGWarning( 3, maya.stringTable['y_igExport.kIgExportUIAttrMapsFrom' ] % (desc,expandedPath) )
            return True

    class MaskExporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            expDir = xg.getOptionVarString( 'igAutoExportFolder' )
            tpu = xg.igDescriptionTpu( xg.igDescription( xgg.DescriptionEditor.currentDescription() ) )

            self.ptexWidget = igExportUI.PtexUI( expDir, tpu )
            vbox.addWidget(self.ptexWidget)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igExport.kMask'  ])

        def doIt(self):
            path = self.ptexWidget.path.value()
            tpu = float(self.ptexWidget.tpu.value())
            desc = xgg.DescriptionEditor.currentDescription()
            expandedPath = FileBrowserUI.createFolder(path,desc,self)
            if not expandedPath:
                return False

            igDescr = xg.igDescription( desc )

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'iGroom -xk "%s" -tpu %f -d "%s";' % (expandedPath,tpu,igDescr) )
            finally:
                cmds.waitCursor( state=False )

            xg.XGWarning( 3, maya.stringTable['y_igExport.kIgExportUIMaskMapsFrom' ] % (desc,expandedPath) )
            return True

    class RegionExporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            expDir = xg.getOptionVarString( 'igAutoExportFolder' )
            tpu = xg.igDescriptionTpu( xg.igDescription( xgg.DescriptionEditor.currentDescription() ) )

            self.ptexWidget = igExportUI.PtexUI( expDir, tpu )
            vbox.addWidget(self.ptexWidget)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igExport.kRegionMap'  ])

        def doIt(self):
            path = self.ptexWidget.path.value()
            tpu = float(self.ptexWidget.tpu.value())
            desc = xgg.DescriptionEditor.currentDescription()
            expandedPath = FileBrowserUI.createFolder(path,desc,self)
            if not expandedPath:
                return False

            igDescr = xg.igDescription( desc )

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'iGroom -xr "%s" -tpu %f -d "%s";' % (path,tpu,igDescr) )
            finally:
                cmds.waitCursor( state=False )

            xg.XGWarning( 3, maya.stringTable['y_igExport.kIgExportUIRegionMapsFrom' ] % (desc,expandedPath) )        
            return True

    class ColorSetExporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            values = xg.igGetAttrValues(xg.igDescription( xgg.DescriptionEditor.currentDescription() ), [('colorPath',''), ('colorSet','colorSet1')])
            self.path = BrowseUI(maya.stringTable[ 'y_igExport.kFolderPathColorExport'  ],
                                 maya.stringTable[ 'y_igExport.kFilePathColorExportAnn'  ],
                                 "","","out")
            self.path.optionButton.setToolTip(maya.stringTable[ 'y_igExport.kBrowseForAFolder2'  ])
            self.path.setValue( values['colorPath'] )
            vbox.addWidget(self.path)

            self.colorSet = TextUI( maya.stringTable[ 'y_igExport.kColorset'  ], 
                                    maya.stringTable[ 'y_igExport.kColorSetAnn'  ] )
            self.colorSet.setValue( values['colorSet'] )
            vbox.addWidget(self.colorSet)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igExport.kColors'  ])

        def doIt(self):
            path = self.path.value()
            colorSet = self.colorSet.value()
            igDescr = xg.igDescription( xgg.DescriptionEditor.currentDescription() )
            mesh = cmds.getAttr( '%s.geom' % igDescr )

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'ptexBake -inMesh "%s" -outPtex "%s/%s" -bakeColorSet "%s";' % (mesh,path,colorSet,colorSet) )

            finally:
                cmds.waitCursor( state=False )

            xg.igSetAttrValues( igDescr, [('colorPath',path,'string'), ('colorSet',colorSet,'string')] )

            return True

    class UVSetExporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            values = xg.igGetAttrValues(xg.igDescription( xgg.DescriptionEditor.currentDescription() ), [('uvPath',''), ('uvSet','UvSet1')])
            self.path = BrowseUI(maya.stringTable[ 'y_igExport.kFolderPathUVExport'  ],
                                 maya.stringTable[ 'y_igExport.kFullPathUVExportAnn'  ],
                                 "","","out")
            self.path.optionButton.setToolTip(maya.stringTable[ 'y_igExport.kBrowseForAFolder3'  ])
            self.path.setValue( values['uvPath'] )
            vbox.addWidget(self.path)

            self.uvSet = TextUI( maya.stringTable[ 'y_igExport.kUvset'  ],
                                 maya.stringTable[ 'y_igExport.kUvSetAnn'  ] )
            self.uvSet.setValue( values['uvSet'] )
            vbox.addWidget(self.uvSet)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igExport.kUvs'  ])

        def doIt(self):
            path = self.path.value()
            uvSet = self.uvSet.value()
            igDescr = xg.igDescription( xgg.DescriptionEditor.currentDescription() )
            mesh = cmds.getAttr( '%s.geom' % igDescr )

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'ptexBake -inMesh "%s" -outPtex "%s/%s" -bakeUV "%s";' % (mesh,path,uvSet,uvSet) )

            finally:
                cmds.waitCursor( state=False )

            xg.igSetAttrValues( igDescr, [('uvPath',path,'string'), ('uvSet',uvSet,'string')] )

            return True

    class Texture2DExporter(QtGui.QWidget):
        def __init__( self, tabs ):
            QtGui.QWidget.__init__(self)
            vbox = QtGui.QVBoxLayout()
            vbox.setAlignment(QtCore.Qt.AlignTop)
            self.setLayout(vbox)

            igDesc = xg.igDescription( xgg.DescriptionEditor.currentDescription() )
            values = xg.igGetAttrValues(igDesc, [('texPath',''), ('texTexelPerUnits',35.0), ('tex','') ])
            self.ptexWidget = igExportUI.PtexUI(values['texPath'],values['texTexelPerUnits'])
            vbox.addWidget(self.ptexWidget)

            self.texture = TextUI( maya.stringTable[ 'y_igExport.kTextureNode'  ],
                                   maya.stringTable[ 'y_igExport.kTextureNodeAnn'  ] )
            self.texture.setValue( values['tex'] )
            vbox.addWidget(self.texture)

            scrollArea = QtGui.QScrollArea()
            scrollArea.setWidget(self)
            scrollArea.setWidgetResizable(True)
            tabs.addTab(scrollArea,maya.stringTable[ 'y_igExport.k2dTexture'  ])

        def doIt(self):
            path = self.ptexWidget.path.value()
            tpu = float(self.ptexWidget.tpu.value())
            tex = self.texture.value()
            igDescr = xg.igDescription( xgg.DescriptionEditor.currentDescription() )
            mesh = cmds.getAttr( '%s.geom' % igDescr )

            try:
                cmds.waitCursor( state=True )
                mel.eval( 'ptexBake -inMesh "%s" -outPtex "%s/%s" -bakeTexture "%s" -tpu %f;' % (mesh,path,tex,tex,tpu) )
            finally:
                cmds.waitCursor( state=False )

            xg.igSetAttrValues( igDescr, [('texPath',path,'string'), ('texTexelPerUnits',tpu,'float'), ('tex',tex,'string')] )

            return True

    # Dialog init
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_igExport.kIgroomExport'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(400)

        layout = QtGui.QVBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignTop)
        self.tabs = QtGui.QTabWidget()
        layout.addWidget(self.tabs)

        igExportUI.MapExporter( self.tabs )
        igExportUI.MaskExporter( self.tabs )
        igExportUI.RegionExporter( self.tabs )

        self.buttons(layout)
        self.setLayout(layout)

    def buttons(self,layout):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.exportButton = QtGui.QPushButton(maya.stringTable[ 'y_igExport.kExport'  ])
        self.exportButton.setFixedWidth(100)
        self.exportButton.setAutoRepeat(False)
        self.connect(self.exportButton, QtCore.SIGNAL("clicked()"), self.exportCB)
        hbox.addWidget(self.exportButton)
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_igExport.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_igExport.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"), self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        layout.addWidget(row)
        self.setLayout(layout)
                       
    def exporter(self):
        # tabs -> scroll widget -> exporter
        return self.tabs.currentWidget().widget()

    def exportCB(self):
            exporter = self.exporter()
            if exporter.doIt():
                # done, accept/close dialog
                self.accept()
                  
def igExportFile():
    if len(xg.palettes()) == 0:
        tellem = QtGui.QMessageBox()
        tellem.setText(maya.stringTable[ 'y_igExport.kThereIsNothingToExport'  ])
        tellem.exec_()
        return

    igExportUI().exec_()
