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


import subprocess
import os
import signal
import time
import platform

import xgenm as xg
from PySide import QtGui, QtCore
from xgenm.ui.util.xgUtil import *
from xgenm.ui.util.xgComboBox import _ComboBoxUI
import maya.cmds as cmds
import maya.mel as mel

class xgmArchiveExportBatchUI( QtGui.QDialog ):
    '''xgmArchiveExportBatchUI is a UI wrapper around the batch export python script.
        A dialog is used to pick a maya file or directories to export.
        It shows a progress bar and status messages from the ongoing mayapy process.
        It's also possible to cancel the process during execution.
    '''
    class IconProvider( QtGui.QFileIconProvider ):
        '''IconProvider to show thumbnail on directory.'''
        def __init__( self ):
            QtGui.QFileIconProvider.__init__( self )
            
        def icon( self, info ):
            try:
                isDir = info.isDir()
                if isDir:
                    thumb = info.absoluteFilePath() + os.sep + "thumb.jpg"
                    if os.path.exists( thumb ):
                        return QtGui.QIcon( thumb )
                    
            except:
                pass
            return QtGui.QFileIconProvider.icon( self, info )
            

    class SourceListModel( QtGui.QStringListModel ):
        '''A non editable list model '''
        def __init__( self ):
            QtGui.QStringListModel.__init__( self )
        def flags( self, index ):
            return QtCore.Qt.ItemIsSelectable|QtCore.Qt.ItemIsEnabled
    
    class SourceListView( QtGui.QListView ):
        '''QListView for the source files.'''
        deleteKeyPressed = QtCore.Signal()
        def __init__( self ):
            QtGui.QListView.__init__( self)
            self.setMinimumHeight( 90 ) 
            self.setModel( xgmArchiveExportBatchUI.SourceListModel() )
            self.setSelectionMode( QtGui.QAbstractItemView.ExtendedSelection )

        def keyReleaseEvent(self,event):
            if event.key() == QtCore.Qt.Key_Delete:
                event.accept()
                self.deleteKeyPressed.emit()

    class Thread(QtCore.QThread):
        '''Simple Thread class that implements only run().'''
        
        ''' Signals '''
        update = QtCore.Signal( int )
        failed = QtCore.Signal()
        done = QtCore.Signal()
        
        def __init__(self, parent):
            '''Just keeps a ref to the parent'''
            QtCore.QThread.__init__( self, parent )
            self.parent = parent
            
        def getLineInfo( self, lastLine ):
            if len(lastLine) > 10:
                #"[  x.xx%]"
                if lastLine[0]==',':
                    lastLine = lastLine[1:]
                if lastLine[0]=='[' and lastLine[7]=='%' and lastLine[8]==']':
                    percent = int(lastLine[1:4]) 
                    msg = lastLine[9:].strip() 
                    return (True,percent,msg) 
                
            return (False,-1,lastLine.strip())
            
        def run(self):
            '''Runs the export on a seperate thread and polls for return code'''
            if self.parent.export():
                retCode = None
                
                while( retCode==None ):
                    
                    self.parent.p.poll()
                    retCode = self.parent.p.returncode
                    
                    if retCode == None:
                        time.sleep(1)
                        
                        lastLine = ""
                        r = False
                        percent = -1
                        msg = ""
                        
                        with open(self.parent.logFile) as fp:
                            lfp = list(fp)
                            if len(lfp)>=1:
                                for i in range( len(lfp) ):
                                    (r,percent,msg) = self.getLineInfo( lfp[-i] )
                                    if r:
                                        break
                        self.update.emit( percent )
                
                self.done.emit()
            else:
                self.failed.emit()

    def createLodPercentWidget( self, lay, percent ):
        lineEdit = QtGui.QLineEdit( str( percent ) )
        lineEdit.setFixedWidth( self.intEditWidth )
        lineEdit.setFixedHeight( self.intEditHeight)
        lineEdit.setAlignment( self.editAlign )
        lineEdit.setValidator( self.percentValidator )
        lay.addWidget( lineEdit )
        return lineEdit

    def createLodSuffixWidget( self, lay, suffix ):
        lineEdit = QtGui.QLineEdit( str( suffix ) )
        lineEdit.setFixedWidth( self.intEditWidth )
        lineEdit.setFixedHeight( self.intEditHeight)
        lineEdit.setAlignment( self.labelAlign )
        lay.addWidget( lineEdit )
        return lineEdit

    def createLodWidgets( self, lay ):
        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)

        self.lodEdit = self.createComboWidget( linelayout, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kLevelOfDetail'  ],
                               [maya.stringTable[ 'y_xgmArchiveExportBatchUI.kDisabled'  ], 
                            maya.stringTable[ 'y_xgmArchiveExportBatchUI.kAutomatic'  ], 
                            maya.stringTable[ 'y_xgmArchiveExportBatchUI.kManual'  ]] )
        self.lodEdit.currentIndexChanged.connect( self.updateLodWidgets )
        self.loLabel = QtGui.QLabel( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kLow'  ] )
        self.loLabel.setFixedWidth( self.label2Size )
        self.loLabel.setAlignment( self.editAlign )
        linelayout.addWidget( self.loLabel )
        self.loReduce = self.createLodPercentWidget( linelayout, 80 )
        self.loSuffix = self.createLodSuffixWidget( linelayout, "_lo" )
        
        self.medLabel = QtGui.QLabel( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kMedium'  ] )
        self.medLabel.setFixedWidth( self.label2Size )
        self.medLabel.setAlignment( self.editAlign )
        linelayout.addWidget( self.medLabel  )
        self.medReduce = self.createLodPercentWidget( linelayout, 30 )
        self.medSuffix = self.createLodSuffixWidget( linelayout, "_med" )

        self.updateLodWidgets( self.lodEdit.currentIndex() )

        row = QtGui.QWidget( )
        row.setLayout(linelayout)
        lay.addWidget(row)

    def updateLodWidgets( self, currentIndex ):
        
        suffixVis = False
        percentVis = False
        if currentIndex == 1:
            percentVis = True
        elif currentIndex == 2:
            suffixVis = True

        self.loReduce.setVisible( False )
        self.medReduce.setVisible( False )
        self.loSuffix.setVisible( False )
        self.medSuffix.setVisible( False )
        self.medLabel.setVisible( False )
        self.loLabel.setVisible( False )

        self.loReduce.setVisible( percentVis )
        self.medReduce.setVisible( percentVis )
        self.loSuffix.setVisible( suffixVis )
        self.medSuffix.setVisible( suffixVis )
        self.medLabel.setVisible( percentVis or suffixVis )
        self.loLabel.setVisible( percentVis or suffixVis )

    def createCheckboxWidget( self, lay, labelText, v ):
        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        label = QtGui.QLabel( labelText )
        label.setFixedWidth( self.labelSize )
        label.setAlignment( self.labelAlign )
        linelayout.addWidget( label )
        
        boxEdit= QtGui.QCheckBox()
        boxEdit.setCheckState( v )
        linelayout.addWidget( boxEdit )
        linelayout.addStretch()
        lay.addLayout( linelayout )
        return boxEdit

    def createComboWidget( self, lay, labelText, items, fixedComboWidth=True ):
        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        label = QtGui.QLabel( labelText )
        label.setFixedWidth( self.labelSize )
        label.setAlignment( self.labelAlign )
        linelayout.addWidget( label )
        comboEdit = _ComboBoxUI( )
        for i in items:
            comboEdit.addItem( i )
        if fixedComboWidth:
            comboEdit.setFixedWidth( self.comboSize )
        linelayout.addWidget( comboEdit)
        linelayout.addStretch()
        lay.addLayout( linelayout )
        return comboEdit

    def createAnimWidgets( self, lay, labelText, v, startFrame, endFrame ):
        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        
        label = QtGui.QLabel( labelText )
        label.setFixedWidth( self.labelSize )
        label.setFixedHeight( self.intEditHeight )
        label.setAlignment( self.labelAlign )
        linelayout.addWidget( label )

        self.editAnim = QtGui.QCheckBox()
        self.editAnim.setCheckState( v )
        self.editAnim.stateChanged.connect( self.updateAnimWidgets )
        linelayout.addWidget( self.editAnim )
        linelayout.addStretch()

        self.startFrameLabel = QtGui.QLabel( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kStartFrame'  ] )
        self.startFrameLabel.setFixedWidth( self.label2Size )
        self.startFrameLabel.setAlignment( self.editAlign )
        linelayout.addWidget( self.startFrameLabel )

        self.editStartFrame = QtGui.QLineEdit( str( startFrame ) )
        self.editStartFrame.setFixedWidth( self.intEditWidth)
        self.editStartFrame.setFixedHeight( self.intEditHeight)
        self.editStartFrame.setAlignment( self.editAlign )
        self.editStartFrame.setValidator( self.frameValidator )
        linelayout.addWidget( self.editStartFrame )
        
        self.endFrameLabel = QtGui.QLabel( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kEndFrame'  ] )
        self.endFrameLabel.setAlignment( self.editAlign )
        self.endFrameLabel.setFixedWidth( self.label2Size )
        linelayout.addWidget( self.endFrameLabel )

        self.editEndFrame = QtGui.QLineEdit( str( endFrame ) )
        self.editEndFrame.setFixedWidth( self.intEditWidth )
        self.editEndFrame.setFixedHeight( self.intEditHeight)
        self.editEndFrame.setAlignment( self.editAlign )
        self.editEndFrame.setValidator( self.frameValidator )
        linelayout.addWidget( self.editEndFrame )

        lay.addLayout( linelayout )
        self.updateAnimWidgets( self.editAnim.checkState() )

    def updateAnimWidgets( self, state ):
        val = state==QtCore.Qt.Checked
        self.startFrameLabel.setVisible( val )
        self.editStartFrame.setVisible( val )
        self.endFrameLabel.setVisible( val )
        self.editEndFrame.setVisible( val )

    def createSourceWidgets( self, lay, labelText ):
        vlayout = QtGui.QVBoxLayout()
        vlayout.setContentsMargins(0, 0, 0, 0)

        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        label = QtGui.QLabel( labelText )
        label.setAlignment( self.labelAlign )
        linelayout.addWidget( label )
        linelayout.addStretch()

        self.browseSource = QtGui.QPushButton( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kBrowse'  ] )
        self.browseSource.clicked.connect( self.browseSourceClicked )
        self.browseSource.setFocusPolicy( QtCore.Qt.StrongFocus )
        linelayout.addWidget( self.browseSource )
        self.browseSource.setVisible( self.batchMode )

        self.removeSource = QtGui.QPushButton( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kRemove'  ] )
        self.removeSource.clicked.connect( self.deleteSourcePressed )
        self.removeSource.setFocusPolicy( QtCore.Qt.StrongFocus )
        linelayout.addWidget( self.removeSource )

        row = QtGui.QWidget( )
        row.setLayout(linelayout)
        vlayout.addWidget(row)

        self.editSource = xgmArchiveExportBatchUI.SourceListView( )
        self.editSource.deleteKeyPressed.connect( self.deleteSourcePressed )
        selmode = self.editSource.selectionModel()
        selmode.selectionChanged.connect( self.sourceChanged )
        vlayout.addWidget(self.editSource)

        lay.addLayout( vlayout )

    def browseSourceClicked( self ):
        dlg = QtGui.QFileDialog( self )
        dlg.setWindowTitle( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kSelectScenesToBeConverted'  ] )
        dlg.setDirectory( self.sourceDir )
        dlg.setFileMode( QtGui.QFileDialog.ExistingFiles )
        dlg.setNameFilter( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kMayaSceneFiles'  ] + "(*.ma *.mb)")
        dlg.setNameFilterDetailsVisible( False )
        dlg.setLabelText( QtGui.QFileDialog.Accept, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kSelect'  ] )
        if dlg.exec_() == QtGui.QDialog.Accepted and len( dlg.selectedFiles() ) > 0:
            self.sourceFiles += dlg.selectedFiles()
            self.updateSourceWidgets()
            self.sourceDir = dlg.directory()
    
    def deleteSourcePressed( self ):
        indices = self.editSource.selectedIndexes()
        if indices and len( indices )>0:
            removeRows = []
            for i in indices:
                removeRows.append( i.row() )
            removeRows = reversed( sorted( removeRows ) )
            for i in removeRows:
                self.sourceFiles.pop(i)
            self.updateSourceWidgets()

    def sourceChanged( self, a1, a2 ):
        self.okButton.setEnabled( len( self.sourceFiles )>0 )
        selmode = self.editSource.selectionModel()
        self.removeSource.setEnabled( selmode.hasSelection() )

    def updateSourceWidgets( self ):
        # Keep the source files unique and sorted
        self.sourceFiles = sorted(list(set(self.sourceFiles)))
        self.editSource.model().setStringList( self.sourceFiles )
        self.sourceChanged(0,0)

    def createDestinationWidgets( self, lay, labelText ):
        vlayout = QtGui.QVBoxLayout()
        vlayout.setContentsMargins(0, 0, 0, 0)

        self.comboDestination = self.createComboWidget( vlayout, labelText, \
            [ \
            maya.stringTable[ 'y_xgmArchiveExportBatchUI.kUserArchives'  ], \
            maya.stringTable[ 'y_xgmArchiveExportBatchUI.kLocalArchives'  ], \
            maya.stringTable[ 'y_xgmArchiveExportBatchUI.kGlobalArchives'  ], \
            maya.stringTable[ 'y_xgmArchiveExportBatchUI.kCustom'  ] \
            ], False )
        self.comboDestination.currentIndexChanged.connect( self.updateDestinationWidgets )

        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        self.editDestination = QtGui.QLineEdit( )
        self.editDestination.setEnabled( False )
        self.editDestination.setAlignment( self.labelAlign )
        self.editDestination.textEdited.connect( self.updateCustomDest )
        linelayout.addWidget( self.editDestination )
        self.browseDestination = QtGui.QToolButton()
        self.browseDestination.setIcon(QtGui.QIcon(xg.iconDir()+"xgBrowse.png"))
        self.browseDestination.setFixedSize(24,24)
        self.browseDestination.clicked.connect( self.browseDestinationClicked )
        linelayout.addWidget( self.browseDestination )
        row = QtGui.QWidget( )
        row.setLayout(linelayout)
        vlayout.addWidget(row)

        if not self.batchMode:
            linelayout = QtGui.QHBoxLayout()
            linelayout.setContentsMargins(0, 0, 0, 0)
            label = QtGui.QLabel( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kArchiveName'  ] )
            label.setFixedWidth( self.labelSize )
            label.setAlignment( self.labelAlign )
            linelayout.addWidget( label )
            self.archiveNameEdit = QtGui.QLineEdit( "Archive" )
            self.archiveNameEdit.setFixedWidth( self.comboSize )
            self.archiveNameEdit.setAlignment( self.labelAlign )
            linelayout.addWidget( self.archiveNameEdit )
            linelayout.addStretch()
            row = QtGui.QWidget( )
            row.setLayout(linelayout)
            vlayout.addWidget(row)

        lay.addLayout( vlayout )
        self.updateDestinationWidgets( self.comboDestination.currentIndex() )

    def updateCustomDest(self, path):
        self.customDest = path
        self.destPath = self.customDest

    def updateDestinationWidgets( self, currentIndex ):
        self.destPath = ""
        if currentIndex == 0:
            self.destPath = xg.userRepo() + "archives"
        elif currentIndex == 1: 
            self.destPath = os.path.expandvars("${XGEN_ROOT}/archives")
        elif currentIndex == 2: 
            self.destPath = xg.globalRepo() + "archives"
        elif currentIndex == 3: 
            self.destPath = self.customDest
        
        self.editDestination.setText( self.destPath )
        self.editDestination.setEnabled( currentIndex==3 )
        self.browseDestination.setEnabled( currentIndex==3 )

    def browseDestinationClicked( self ):
        dlg = QtGui.QFileDialog( self )
        dlg.setWindowTitle( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kSelectCustomDestination'  ] )
        dlg.setOption( QtGui.QFileDialog.ShowDirsOnly, True  )
        dlg.setFileMode( QtGui.QFileDialog.Directory )
        dlg.setDirectory( self.customDest )
        dlg.setLabelText( QtGui.QFileDialog.Accept, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kSelect2'  ] )
        if dlg.exec_() == QtGui.QDialog.Accepted and len( dlg.selectedFiles() ) > 0:
            self.customDest = dlg.selectedFiles()[0]
            self.updateDestinationWidgets( self.comboDestination.currentIndex() )

    def createCheckboxWidget( self, lay, labelText, v ):
        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        label = QtGui.QLabel( labelText )
        label.setAlignment( self.labelAlign )
        linelayout.addWidget( label )
        
        boxEdit= QtGui.QCheckBox()
        boxEdit.setCheckState( v )
        linelayout.addWidget( boxEdit )
        linelayout.addStretch()
        lay.addLayout( linelayout )
        return boxEdit

    def showEvent(self,event):
        self.updateDestinationWidgets( self.comboDestination.currentIndex() )
        QtGui.QDialog.showEvent(self,event)

    def __init__(self, batchMode ):
        '''xgmArchiveExportBatchUI ctor'''
        
        # Call parent ctor
        QtGui.QDialog.__init__(self)
        
        self.batchMode = batchMode
        self.labelSize = 120
        self.label2Size = 80
        self.comboSize = 200
        self.intEditWidth = 70
        self.intEditHeight = 18
        self.labelAlign = QtCore.Qt.AlignLeft|QtCore.Qt.AlignVCenter
        self.editAlign = QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter
        self.customDest = xg.userRepo() + "archives"
        self.destPath = ""
        
        # Use the current project scenes folder as the initial directory.
        rootDir = cmds.workspace( query=True, rootDirectory=True)
        fileRules = cmds.workspace( query=True, fileRule=True)
        lenFileRules = len( fileRules )
        for r in range(0,lenFileRules,2):
            if fileRules[r] == 'scene':
                    self.sourceDir = rootDir + fileRules[r+1]
        self.sourceFiles = []
        self.objects = []

        if self.batchMode:
            title = maya.stringTable[ 'y_xgmArchiveExportBatchUI.kBatchConvertScenesToXgenArchives'  ]
            okButtonText = maya.stringTable[ 'y_xgmArchiveExportBatchUI.kConvert2'  ]
        else:
            title = maya.stringTable[ 'y_xgmArchiveExportBatchUI.kExportSelectionAsArchives'  ]
            okButtonText = maya.stringTable[ 'y_xgmArchiveExportBatchUI.kExport2'  ]
            
        self.setLayout( QtGui.QVBoxLayout() )
        self.setMinimumWidth( 666 ) 
        self.setSizeGripEnabled( True )
        
        self.setWindowTitle( title )

        # Create buttons first for tab order
        self.okButton = QtGui.QPushButton( okButtonText )
        self.okButton.clicked.connect( self.onDialogExport )
        self.cancelButton = QtGui.QPushButton( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kCancel2'  ])
        self.cancelButton.clicked.connect( self.onDialogCancel )
        self.helpButton = QtGui.QPushButton( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kHelp2'  ])
        self.helpButton.clicked.connect( self.onDialogHelp )
        
        # Create a frame to hold the controls
        self.topFrame = QtGui.QFrame()
        self.topFrame.setFrameStyle( QtGui.QFrame.StyledPanel )
        self.topFrame.setLineWidth(2)
        self.toplayout = QtGui.QVBoxLayout()
        self.topFrame.setLayout( self.toplayout )
        self.percentValidator = QtGui.QIntValidator( 0, 100, self )
        self.frameValidator = QtGui.QIntValidator( self )
        
        # add some widgets
        if self.batchMode:
            self.createSourceWidgets( self.toplayout, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kScenesToBeConverted'  ] )
        self.createDestinationWidgets( self.toplayout, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kDestinationFolder'  ] )
        #self.editSplitByGroup = self.createComboWidget( self.toplayout, _L10N( kSaveGroups, "Save Groups: " ), 
        #                        [_L10N( kIntoASingleArchive, "into a single archive" ), 
        #                         _L10N( kIntoSeparateArchives, "into separate archives" )])
        self.createLodWidgets( self.toplayout )
        self.createAnimWidgets( self.toplayout, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kIncludeAnimation'  ], QtCore.Qt.Unchecked, 1, 24 )

        # add the framsourceFilese to the layout
        self.layout().addWidget( self.topFrame )
        
        # add dialog's buttons
        linelayout = QtGui.QHBoxLayout()
        linelayout.setContentsMargins(0, 0, 0, 0)
        linelayout.addWidget( self.helpButton )
        linelayout.addStretch()
        linelayout.addWidget( self.okButton )
        linelayout.addWidget( self.cancelButton )
        row = QtGui.QWidget( )
        row.setLayout(linelayout)
        self.layout().addWidget( row )

        # Create thread job
        self.thread = xgmArchiveExportBatchUI.Thread( self )
        self.thread.update.connect( self.onProgressUpdate )
        self.thread.done.connect( self.onProgressDone )
        self.thread.failed.connect( self.onProgressFailed )
        
        # Create progress dialog
        self.progress = QtGui.QProgressDialog( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kProgressTitle'  ] % title, maya.stringTable[ 'y_xgmArchiveExportBatchUI.kCancel'  ], 0, 100)
        self.progress.setWindowFlags( QtCore.Qt.WindowStaysOnTopHint )
        self.progress.setWindowTitle( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kProgressWindowTitle'  ] % title )
        #self.progress.setWindowModality( QtCore.Qt.ApplicationModal )
        self.progress.setAutoReset( False )
        self.progress.setAutoClose( False )
        self.connect( self.progress, QtCore.SIGNAL('canceled()'), self.onProgressCancel )
        
        # Variables the dialog will retreive
        self.p = None
        self.dirName = ""
        self.reducePercentLo = 0.0
        self.reducePercentMed = 0.0
        self.fpLog = None
        self.logFile = ""
        self.resetAnim()

        self.resize( QtCore.QSize(1,1) )
        if self.batchMode:
            self.sourceChanged( 0,0 )
        
    def resetAnim(self):
        self.startFrame = cmds.currentTime( query=True )
        self.endFrame = self.startFrame

    def onDialogExport(self):

        '''Dialog Export button callback'''
        self.archiveName = ""
        if not self.batchMode:
            self.sourceFiles = []
            self.objects = []
            self.archiveName = self.archiveNameEdit.text()
            try:
                sceneName = saveScene()
                if len( sceneName ) > 0 and len( self.archiveName ) > 0:
                    self.objects = cmds.ls( selection=True, long=True )
                    self.sourceFiles = [sceneName]

            except RuntimeError:
                pass
        else:
            sceneName = cmds.file( query=True, sceneName=True )

        if len(self.sourceFiles) > 0 and ( self.batchMode or len(self.objects) > 0):
            # Retreive the selected directory name
            self.dirName = self.destPath.replace("\\","/") + "/"
            if self.lodEdit.currentIndex()==1:
                self.reducePercentLo = float( self.loReduce.text() )
                self.reducePercentMed = float( self.medReduce.text() )
            if self.lodEdit.currentIndex()==2:
                self.suffixLo = self.loSuffix.text()
                self.suffixMed = self.medSuffix.text()
                
            self.resetAnim()
            if self.editAnim.checkState()==QtCore.Qt.Checked:
                self.startFrame = float( self.editStartFrame.text() )
                self.endFrame = float( self.editEndFrame.text() )

            if 'XGEN_EXPORT_ARCHIVE_STANDALONE' in os.environ and \
                    os.environ['XGEN_EXPORT_ARCHIVE_STANDALONE'] == '0':
                cmds.waitCursor(state=True)
                self.exportDirect()
                # The original scene may be changed, restore the original scene
                if len( sceneName ) > 0:
                    cmds.file( sceneName, f=True, options="v=0;", o=True )
                cmds.waitCursor(state=False)
            else:
                # Show a nice progress bar
                self.progress.setEnabled( True )
                self.progress.setLabelText( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kStartingProcess'  ] )
                self.progress.setValue( 0 )
                self.progress.show()
                self.thread.start()
                #QtGui.QApplication.setOverrideCursor(QtCore.Qt.WaitCursor)
        self.close()

    def onDialogHelp(self):
        if self.batchMode:
            cmds.showHelp("XGenBatchConvertScenes")
        else:
            cmds.showHelp("XGenExportSelectedAs")

    def onDialogCancel(self):
        '''Dialog Cancel button callback'''
        #print "xgmArchiveExportBatchUI DialogCancel"
        self.close()
        
    def onProgressDone(self):
        '''Thread Done callback'''
        #print "xgmArchiveExportBatchUI ProgressDone"
        self.progress.setLabelText( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kDoneCleaningUpProcess'  ] )
        self.exportCleanup()
        
    def onProgressCancel(self):
        '''Thread Cancel callback'''
        #print "xgmArchiveExportBatchUI ProgressCanceled"
        self.progress.setLabelText( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kCancelCleaningUpProcess'  ] )
        self.exportCleanup()
        
        
    def onProgressFailed(self):
        '''Thread Failed callback'''
        #print "xgmArchiveExportBatchUI ProgressFailed"
        self.progress.setLabelText( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kFailedCleaningUpProcess'  ] )
        self.exportCleanup()
        
    def onProgressUpdate(self, percent):
        '''Thread Update callback'''
        #print "xgmArchiveExportBatchUI ProgressUpdate " + str(percent) + " " + message
        self.progress.setLabelText( maya.stringTable[ 'y_xgmArchiveExportBatchUI.kProcessing'  ] )   
        if percent!=-1:
            self.progress.setValue( percent )
    
    def exportInit( self ):
        try:
            xg.invokeCallbacks( "ArchiveExportInit", [str(id(self))] )
        except:
            print maya.stringTable['y_xgmArchiveExportBatchUI.kArchiveExportInitErr' ]
    
    def exportDirect( self ):
        # Call Init callbacks to fill the list of required plugins to load
        self.batch_plugins = []
        self.batch_plugins.append("AbcExport")
        self.exportInit()

        strLODMode = str(self.lodEdit.currentIndex())
        if strLODMode == "0":
            strLODLo = "0"
            strLODMed = "0"
        elif strLODMode == "1":
            strLODLo = self.reducePercentLo
            strLODMed = self.reducePercentMed
        else:
            strLODLo = self.suffixLo
            strLODMed = self.suffixMed

        import xgenm.xmaya.xgmArchiveExportBatch
        xgenm.xmaya.xgmArchiveExportBatch.exportWithoutStandalone(self.batch_plugins, \
                                self.archiveName, self.dirName, self.sourceFiles, self.objects, \
                                self.lodEdit.currentIndex(), strLODLo, strLODMed, \
                                self.startFrame, self.endFrame)

    def export( self ):
        '''Export method. Creates a separated process, make it log to a file and keep a reference to the process object.'''
        ret = False
        try:
            # Create the log file, the file is closed later on.
            if self.batchMode:
                self.logFile = self.dirName + "archiveExportBatch.log"
            else:
                self.logFile = self.dirName + self.archiveName + ".log"
            if not os.path.isdir( self.dirName ):
                os.makedirs( self.dirName )

            # Call Init callbacks to fill the list of required plugins to load
            # and the list of script path to append
            self.batch_script_paths = []
            self.batch_script_paths.append( os.path.join(os.environ['MAYA_LOCATION'], "plug-ins", "xgen", "scripts" ) )
            self.batch_plugins = []
            self.batch_plugins.append("AbcExport")

            self.exportInit()

            batch_script_paths = []
            for s in self.batch_script_paths:
                batch_script_paths.append( '\''+str(s)+'\'' )
            batch_script_paths = "-scriptPaths " + str(batch_script_paths)

            batch_plugins = []
            for s in self.batch_plugins:
                batch_plugins.append( '\''+str(s)+'\'' )
            batch_plugins = "-loadPlugins " + str(batch_plugins)

            print maya.stringTable['y_xgmArchiveExportBatchUI.kXgmArchiveExportLoggingTo' ] + self.logFile
            self.fpLog = open( self.logFile, "w" )
            
            # Build a string out of arrays
            # We'll need to handle the space in paths.
            sourceFilenames = []
            for s in self.sourceFiles:
                sourceFilenames.append( '\''+str(s)+'\'' )
            sourceFilenames = "-sourceFiles " + str( sourceFilenames )
            objNames = ""
            if len(self.objects) > 0:
                objs = []
                for obj in self.objects:
                    objs.append('\''+str(obj)+'\'')
                objNames = "-objects " + str(objs)
            destDir = "-destDir " + str( ['\''+ str( self.dirName )+'\''] )
            destArchiveName = "-destName " + str( ['\''+str( self.archiveName )+'\''] )
            strLODMode = str(self.lodEdit.currentIndex())
            if strLODMode == "0":
                strLODLo = "0"
                strLODMed = "0"
            elif strLODMode == "1":
                strLODLo = str( self.reducePercentLo )
                strLODMed = str( self.reducePercentMed )
            else:
                strLODLo = str( self.suffixLo )
                strLODMed = str( self.suffixMed )

            # Create a new process
            mayapy = "\"" + os.path.join( os.environ['MAYA_LOCATION'], "bin", "mayapy" ) + "\""
            mayapy_args = [ mayapy, "\""+os.environ['XGEN_LOCATION'] + "scripts/xgenm/xmaya/xgmArchiveExportBatch.py" + "\"", \
                strLODMode, strLODLo, strLODMed, \
                str(self.startFrame), str(self.endFrame), destArchiveName, destDir, sourceFilenames, objNames, batch_script_paths, batch_plugins ]

            cmd = " ".join( mayapy_args )
            print cmd
            
            plat = platform.system()
            if plat == "Linux":
                self.p = subprocess.Popen( cmd, bufsize=1, shell=True, stdout=self.fpLog, stderr=self.fpLog, preexec_fn=os.setsid )
            elif plat == "Windows":
                self.p = subprocess.Popen( cmd, bufsize=1, shell=True, stdout=self.fpLog, stderr=self.fpLog, stdin=subprocess.PIPE )
            else:
                self.p = subprocess.Popen( cmd, bufsize=1, shell=True, stdout=self.fpLog, stderr=self.fpLog )
            #print "xgmArchiveExportBatchUI Running mayapy process " + str(self.p.pid) + " and logging to " + self.logFile
            
            ret = True
        except Exception as e:
            print str(e)
        return ret
    
    def exportCleanup( self ):
        '''Export Cleanup method. Release the file pointer, process and resets cursor''' 
        if self.p != None and platform.system() == "Windows":
            self.p.stdin.close()

        if self.p!=None and self.p.returncode == None:
            os.killpg( self.p.pid, signal.SIGTERM )
            self.p.wait()
        
        if self.fpLog:
            self.fpLog.close()
        #QtGui.QApplication.setOverrideCursor(QtCore.Qt.ArrowCursor)
        self.progress.hide()

        # Print log content
        with open( self.logFile, "r" ) as fp:
            print fp.read()
        
