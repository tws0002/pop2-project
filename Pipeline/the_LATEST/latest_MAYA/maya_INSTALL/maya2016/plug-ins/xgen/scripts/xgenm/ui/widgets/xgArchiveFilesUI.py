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
# @file xgTextEditUI.py
# @brief Contains the UI for archive group editor
#
# @author Guillaume Laferriere
#
# @version Created 02/04/13
import string
import os

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm import XgExternalAPI as xgapi
from xgenm.ui.util.xgUtil import *

from xgenm.ui.widgets.xgExpressionUI import Slider
from xgenm.ui.widgets.xgExpressionUI import _sliderNumSteps
from xgenm.ui.widgets.xgExpressionUI import _sliderSingleSteps
from xgenm.ui.widgets.xgExpressionUI import _sliderPageSteps  
from xgenm.ui.dialogs.xgEditArchiveGroup import editArchiveGroup

if xgg.Maya:
    import maya.mel as mel
    import maya.cmds as cmds

k_NameTag = "name=\""
k_ColorTag = "color=["
k_ThumbnailTag = "thumbnail=\""
k_DescriptionTag = "description=\""  
k_MaterialsTag = "materials=\""

class ArchiveFilesUI(QtGui.QWidget):
    '''Archive Files editor.'''
    EditMenu = QtCore.Signal()
    RemoveMenu = QtCore.Signal() 
    RefreshCustomParams = QtCore.Signal()
    
    class TableView( QtGui.QTableView ):
        '''Overloaded QTableView to react to double clicks and dlete key.'''
        DoubleClicked = QtCore.Signal()
        DeleteKeyPressed = QtCore.Signal()
        def __init__(self):
            QtGui.QTableView.__init__(self)
        
        def mouseDoubleClickEvent(self,event):
            self.DoubleClicked.emit()
            
        def keyReleaseEvent(self,event):
            if event.key() == Qt.Key_Delete:
                event.accept()
                self.DeleteKeyPressed.emit()
            
    class Model( QtCore.QAbstractTableModel ):
        '''Data Model for Archive Files.'''
        #class contants
        kThumbColumn = 0
        kNameColumn = 1
        kColumnCount = 2
            
        def __init__( self, data ):
            '''Just call the base ctor and hold on to the data'''
            QtCore.QAbstractTableModel.__init__( self )
            self._data = data
        
        def rowCount( self, parent=QtCore.QModelIndex() ) :
            '''QAbstractTableModel virtual method'''
            return len( self._data )
            
        def columnCount( self, parent=QtCore.QModelIndex() ):
            '''QAbstractTableModel virtual method'''
            return ArchiveFilesUI.Model.kColumnCount
            
        def data( self, index, role = Qt.DisplayRole ):
            '''QAbstractTableModel virtual method'''
            if role == Qt.DisplayRole:
                if index.column()==ArchiveFilesUI.Model.kThumbColumn:
                    return ""
                    
                elif index.column()==ArchiveFilesUI.Model.kNameColumn:
                    return self._data[ index.row() ].name
                    
            elif role == Qt.ToolTipRole:
                return self._data[ index.row() ].description
                
            return None
            
        def headerData( self, section, orientation, role = Qt.DisplayRole ):
            '''QAbstractTableModel virtual method'''
            if role == Qt.DisplayRole and orientation == Qt.Vertical:
                return  str(section)
            return None
    
    
    def __init__(self,attr,help="",object="",width=0):
        '''A widget for editing a text value.
        This provides for the label and an text entry box.
        '''
        QtGui.QWidget.__init__(self)
        self.attr = attr
        self.object = object
        self.dirty = False
        self.mode = False
        self.rowSize = 32
        self.minSize = 100
        self.maxSize = 600
        
        # Widgets
        
        # Label
        if object == "":
            self.label = QtGui.QLabel(attr)
        else:
            self.label = QtGui.QLabel(makeLabel(attr))
        self.label.setFixedWidth(labelWidth())
        self.label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTop)
        self.label.setIndent(10)

        # Some button bellow the file list.
        sliderLayout = QtGui.QHBoxLayout()
        sliderLayout.setSpacing(3)
        sliderLayout.setContentsMargins(1,1,1,1)

        # Slider
        self.slider = Slider(QtCore.Qt.Horizontal)
        self.slider.setFixedHeight(18)
        self.slider.setMinimum(int(18))
        self.slider.setMaximum(int(128))
        self.slider.setPageStep(8)
        self.slider.setSingleStep(1)
        self.slider.setValue( self.rowSize )
        self.slider.setToolTip(maya.stringTable[ 'y_xgArchiveFilesUI.kThumbnailSizeAnn'  ])
        self.connect(self.slider, QtCore.SIGNAL("valueChanged(int)"), self.sliderChanged )
        sliderLayout.addWidget( self.slider )

        # Show Thumbnails checkbox
        self.pbMode = QtGui.QCheckBox(maya.stringTable[ 'y_xgArchiveFilesUI.kList'  ])
        self.pbMode.setToolTip(maya.stringTable[ 'y_xgArchiveFilesUI.kListAnn'  ])
        self.pbMode.setChecked(True)
        sliderLayout.addWidget(self.pbMode)
        self.connect(self.pbMode, QtCore.SIGNAL("clicked()"), self.editMode)

        sliderrow = QtGui.QWidget()
        sliderrow.setLayout( sliderLayout )
        
        # Text Edit
        self.textEdit = QtGui.QTextEdit()
        self.textEdit.setUndoRedoEnabled(True)
        self.textEdit.setWordWrapMode(QtGui.QTextOption.NoWrap)
        self.textEdit.setAcceptRichText(False)
        if width:
            self.textEdit.setFixedWidth(width)
            
        # Table View
        self.tableView = ArchiveFilesUI.TableView()
        self.tableView.horizontalHeader().hide()
        self.tableView.setShowGrid( False )
        self.tableView.setSelectionBehavior( QtGui.QAbstractItemView.SelectRows )
        self.tableView.setContextMenuPolicy(Qt.CustomContextMenu);  
        self.tableView.customContextMenuRequested.connect(self.handleMenu)
        self.tableView.verticalHeader().setContextMenuPolicy(Qt.CustomContextMenu)
        self.tableView.verticalHeader().customContextMenuRequested.connect(self.handleMenu)
        self.tableView.DoubleClicked.connect(self.EditMenu)
        self.tableView.DeleteKeyPressed.connect(self.RemoveMenu)

        if width:
            self.tableView.setFixedWidth(width)
        
        # Some button bellow the file list.
        archiveButLayout = QtGui.QHBoxLayout()
        archiveButLayout.setSpacing(3)
        archiveButLayout.setContentsMargins(1,1,1,1)
        
        self.pbCreate = QtGui.QPushButton(maya.stringTable[ 'y_xgArchiveFilesUI.kCreate'  ])
        self.pbCreate.setToolTip(maya.stringTable[ 'y_xgArchiveFilesUI.kCreateAnn'  ])
        archiveButLayout.addWidget(self.pbCreate)
        self.connect(self.pbCreate, QtCore.SIGNAL("clicked()"), xgg.DescriptionEditor.exportArchives )

        self.pbAdd = QtGui.QPushButton(maya.stringTable[ 'y_xgArchiveFilesUI.kAdd'  ])
        self.pbAdd.setToolTip(maya.stringTable[ 'y_xgArchiveFilesUI.kAddAnn'  ])
        archiveButLayout.addWidget(self.pbAdd)
        self.connect(self.pbAdd, QtCore.SIGNAL("clicked()"), self.addArchiveDialog)
        
        self.pbEdit = QtGui.QPushButton(maya.stringTable[ 'y_xgArchiveFilesUI.kEdit'  ])
        self.pbEdit.setToolTip(maya.stringTable[ 'y_xgArchiveFilesUI.kEditAnn'  ])
        archiveButLayout.addWidget(self.pbEdit)
        self.connect(self.pbEdit, QtCore.SIGNAL("clicked()"), self.editArchiveDialog)
        
        self.pbRemove = QtGui.QPushButton(maya.stringTable[ 'y_xgArchiveFilesUI.kRemove'  ])
        self.pbRemove.setToolTip(maya.stringTable[ 'y_xgArchiveFilesUI.kRemoveAnn'  ])
        
        archiveButLayout.addWidget(self.pbRemove)
        self.connect(self.pbRemove, QtCore.SIGNAL("clicked()"), self.removeArchiveDialog)
                
        butrow = QtGui.QWidget()
        butrow.setLayout( archiveButLayout )

        # Vertical layout and dummy holder widget
        vlayout = QtGui.QVBoxLayout()
        vlayout.setSpacing(3)
        vlayout.setContentsMargins(1,1,1,1)
        vlayout.addWidget( sliderrow )
        vlayout.addWidget(self.textEdit)
        vlayout.addWidget(self.tableView)
        vlayout.addWidget( butrow )
        vwidget = QtGui.QWidget()
        vwidget.setLayout(vlayout)
        
         # Horizontal layout
        layout = QtGui.QHBoxLayout()
        layout.setAlignment(QtCore.Qt.AlignLeft)
        layout.setSpacing(3)
        layout.setContentsMargins(1,1,1,1)
        layout.addWidget(self.label)
        layout.addWidget(vwidget)
        self.setSizePolicy( QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Maximum )
        
        self.setMode(True)
        self.setLayout(layout)
        self.setToolTip(help)
        self.connectIt()
    
    def handleMenu( self, pos):
        menu = QtGui.QMenu()
        menu.addAction(maya.stringTable[ 'y_xgArchiveFilesUI.kEditRightClick'  ],self.emitEditMenu)
        menu.addAction(maya.stringTable[ 'y_xgArchiveFilesUI.kRemoveRightClick'  ],self.emitRemoveMenu)
        ret = menu.exec_(QtGui.QCursor.pos())
    def emitEditMenu(self):
        self.EditMenu.emit()
    def emitRemoveMenu(self):
        self.RemoveMenu.emit()

    def sliderChanged(self,v):
        '''Thumbnail size slider callback'''
        self.rowSize = v
        self.tableView.setColumnWidth(0,self.rowSize)
        self.tableView.setColumnWidth(1,self.rowSize)
        for i in range( self.tableView.model().rowCount() ):
            self.tableView.setRowHeight( i, self.rowSize )
        self.fitTableView()
        
    def fitTableView( self ):
        rowBorders = 2
        rowSize = (self.rowSize+rowBorders)
        visibleRows = self.tableView.model().rowCount()
        totalSize = rowSize * visibleRows
        totalSize = min( self.maxSize, totalSize )
        totalSize = max( self.minSize, totalSize )
        self.tableView.setFixedHeight( totalSize )
        self.textEdit.setFixedHeight( totalSize  )
        
    def setMode(self,v):
        '''change the widget mode to text or list'''
        self.mode = v
        if self.mode:
            self.tableView.show()
            self.textEdit.hide()
        else:
            self.textEdit.show()
            self.tableView.hide()
        
    def switchMode(self):
        '''Switches the widget mode to text or list'''
        self.setMode( not self.mode )
        
    def value(self):
        return xg.prepForAttribute(str(self.textEdit.toPlainText()))

    def drawPixmapRect( self, brush, painter, pixmap, s, e ):
        painter.setBrush( brush )
        x0 = s*pixmap.width()
        y0 = s*pixmap.height()
        x1 = e*pixmap.width()
        y1 = e*pixmap.height()
        painter.drawRect( x0, y0, x1-x0, y1-y0 )
        
    def setValue(self,value):
        self.textEdit.setPlainText(xg.prepForEditor(str(value)))
        self.tableView.horizontalHeader().setStretchLastSection( True )
        groups = self.archiveGroups()
        model = ArchiveFilesUI.Model( groups )
        self.tableView.setModel( model )
        self.sliderChanged(self.rowSize)
        
        de = xgg.DescriptionEditor
        curPal = de.currentPalette()
        curDesc = de.currentDescription()

        for i in range( model.rowCount() ):
            g = groups[i]
            
            # Set a custom widget for the thumbnail
            indexThumb = model.index( i, ArchiveFilesUI.Model.kThumbColumn )
            thumbWidget = QtGui.QLabel()
            qColor = QtGui.QColor(g.color[0]*255,g.color[1]*255,g.color[2]*255,255)
            
            pixmap = QtGui.QPixmap()
            
            # Resolve the thumbnail file
            resolvedThumbnail = ""
            if g.thumbnail:
                resolvedThumbnail = xgapi.findFileInXgDataPath( str(g.thumbnail), "", curPal, curDesc, "ArchivePrimitive", False, 0,0,0 )
            
            if len(resolvedThumbnail) and pixmap.load( resolvedThumbnail ):
                # Rect in the lower right corner from 65% to 95% of the image size
                s = 0.65 
                e = 0.95
                painter = QtGui.QPainter()
                painter.begin(pixmap)
                self.drawPixmapRect( QtGui.QBrush( qColor ), painter, pixmap, s, e )
                painter.end()
            else:
                try:
                    pixmap = QtGui.QPixmap( 128, 128 )
                    pixmap.fill( QtGui.QColor(255,255,255,255 ) )
                    painter = QtGui.QPainter()
                    painter.begin(pixmap)
                    self.drawPixmapRect( QtGui.QBrush( qColor ), painter, pixmap, 0.0, 1.0 )
                    painter.end()
                except:
                    print maya.stringTable[ 'y_xgArchiveFilesUI.kCouldntCreateEmptyPixmap'  ]
            
            thumbWidget.setPixmap( pixmap )
            thumbWidget.setScaledContents( True )
                
            self.tableView.setIndexWidget( indexThumb, thumbWidget )
        
        self.fitTableView()
        
    
    def connectIt(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        # track when the value has changed and therefore dirty
        self.connect(self.textEdit,QtCore.SIGNAL("textChanged()"),
                     lambda: self.setDirty())
        # Warning: override the default focusOutEvent method on the embedded
        # textEdit widget. the more correct way to do this would be to derive
        # our own textEdit and implement the method. 
        self.textEdit.focusOutEvent = self.updateValue
        
        self.EditMenu.connect( self.editArchiveDialog )
        self.RemoveMenu.connect( self.removeArchiveDialog )

    def refresh(self):
        if self.object=="" or xgg.DescriptionEditor is None:
            return
        de = xgg.DescriptionEditor
        value = de.getAttr(self.object,self.attr)
        self.setValue(value)

    def setDirty(self):
        self.dirty = True

    def updateValue(self,event=None):
        if self.dirty:
            if xgg.DescriptionEditor.setAttrCmd( self.object, self.attr, self.value() ):
                xgg.DescriptionEditor.playblast()
            self.dirty=False
        if event:
            QtGui.QTextEdit.focusOutEvent(self.textEdit,event)
    
    def fileText(self):
        return unicode(self.textEdit.toPlainText())

    class ArchiveGroup():
        '''Single archive group entry. Splits a line of test into an archive group and converts it into text.'''
        
        def tokenizeWihtinQuotes( self ):
            ret = ""
            lastChar = '\0'
            inQuotes = False
            for curChar in self.line:
                curStr = str(curChar)
                if not inQuotes :
                    if curChar=='\"' and lastChar!='\\':
                        inQuotes = True
                else:
                    if curChar=='\t':
                        curStr = "{__TAB__}"
                    elif curChar==' ':
                        curStr = "{__SPACE__}"
                    elif curChar=='\"' and lastChar!='\\':
                        inQuotes = False

                ret += curStr
                lastChar = curChar
            return ret
        
        def __init__( self, l ):
            self.line = l
            self.lines = [l]
            self.id = -1
            self.name= ""
            self.valid = False
            self.color = [0,0,0]
            self.description = ""
            self.thumbnail = ""
            self.materials = ""
            
            
            tokenizedLine = self.tokenizeWihtinQuotes()
            words = tokenizedLine.split()
            
            for w in words:
                w = w.replace("{__SPACE__}"," ").replace("{__TAB__}","\t")

                if w.startswith(k_NameTag) and w.endswith("\""):
                    self.name = w[len(k_NameTag):-1]
                    self.valid = True
                elif w.startswith(k_ColorTag) and w.endswith("]"):
                    colorStr = w[len(k_ColorTag):-1]
                    rgb = colorStr.split( ',' )
                    if rgb and len(rgb)==3:
                        self.color = [ float(rgb[0]), float(rgb[1]), float(rgb[2]) ]
                elif w.startswith(k_ThumbnailTag) and w.endswith("\""):
                    self.thumbnail = w[len(k_ThumbnailTag):-1]
                elif w.startswith(k_DescriptionTag) and w.endswith("\""):
                    self.description = w[len(k_DescriptionTag):-1]
                elif w.startswith(k_MaterialsTag) and w.endswith("\""):
                    self.materials = w[len(k_MaterialsTag):-1]
	

        def asText( self, index ):
            
            # Always reconstruct the ArchiveGroup Line.
            ret = "#ArchiveGroup " + str(index) \
                + " " + k_NameTag + str(self.name) + "\"" \
                + " " + k_ThumbnailTag + str(self.thumbnail) + "\"" \
                + " " + k_DescriptionTag + str(self.description) + "\"" \
                + " " + k_MaterialsTag + str(self.materials) + "\"" \
                + " " + k_ColorTag + str(self.color[0]) + "," \
                                   + str(self.color[1]) + "," \
                                   + str(self.color[2]) + "]" \
                + "\n"

            # Then add remaining lines.
            ret += "\n".join( self.lines[1:] )
            
            return ret
                
                
    def archiveGroupsFromLines(self, lines):
        '''Returns the archive groups from the text lines.'''
        ret = []
        
        g = None
        for l in lines:
            if l.startswith("#ArchiveGroup " ):
                g = ArchiveFilesUI.ArchiveGroup(l)
                if g.valid:
                    ret.append( g )
            elif g:
                g.lines.append( l )
                
        return ret
        
    def archiveGroups(self):
        '''Returns the archive groups from the files text string.'''
        t = self.fileText()
        lines = t.splitlines()
        return self.archiveGroupsFromLines( lines )
        
    def setArchiveGroups(self,groups):
        '''Replace the files text with the values from the archiveGroups.'''
        val = ""
        for i in range( len(groups) ):
            val += groups[i].asText( i ) + "\n"
        
        self.setValue( val )
        self.setDirty()
        self.updateValue()
        self.RefreshCustomParams.emit()
    
    def addArchiveDialog(self):
        '''Add Archive Dialog callback'''
        dialog = QtGui.QFileDialog(self)
        dialog.setWindowModality( QtCore.Qt.ApplicationModal )
        dialog.setWindowTitle( maya.stringTable[ 'y_xgArchiveFilesUI.kXgenAddArchives'  ] )
        dialog.setFilter( "*.xarc" )
        dialog.setFileMode( QtGui.QFileDialog.ExistingFiles )

        history = dialog.history()
        xgenPresets = []
        xgenPresets.append( xg.globalRepo()+"archives" )
        xgenPresets.append( xg.localRepo()+"archives" )
        xgenPresets.append( xg.userRepo()+"archives" )
        xgenPresets.append( xg.xgenProjectPath()+"/archives" )
        history += xgenPresets

        dialog.setHistory( history )

        if dialog.exec_():
            f = dialog.selectedFiles()
            self.addArchives( f )
            
    def addArchives( self, files ):
        '''Add multiple archives from arc files.'''
        groups = self.archiveGroups()
        importedGroups = []
        for f in files:
            lines = []
            with open( f ) as fp:
                t = fp.read()
                lines = t.splitlines()
                group = self.archiveGroupsFromLines(lines)
                importedGroups.extend( group ) 
                groups.extend( group )
        
        if xgg.Maya:
            materialFiles = []
            de = xgg.DescriptionEditor
            curPal = de.currentPalette()
            curDesc = de.currentDescription()
            for g in importedGroups:
                resolvedMaterials = xgapi.findFileInXgDataPath( str(g.materials), "", curPal, curDesc, "ArchivePrimitive", False, 0,0,0 )
                if resolvedMaterials and len(resolvedMaterials):
                    materialFiles.append( resolvedMaterials )

            if len(materialFiles):
                msgbox = QtGui.QMessageBox(self)
                msgbox.setWindowTitle( maya.stringTable[ 'y_xgArchiveFilesUI.kXgenImportMaterials'  ] )

                strFiles = ""
                for m in materialFiles:
                    strFiles += m + "\n"

                msgbox.setText(maya.stringTable[ 'y_xgArchiveFilesUI.kAddedXarcArchives'  ] % strFiles)
                msgbox.setStandardButtons( QtGui.QMessageBox.Yes | QtGui.QMessageBox.No )
                msgbox.setDefaultButton( QtGui.QMessageBox.Yes)
                if msgbox.exec_() == QtGui.QMessageBox.Yes:
                    for f in materialFiles:
                        sceneName = os.path.basename(f)
                        sceneExt =  os.path.splitext(sceneName)
                        if len(sceneExt[1]):
                            sceneName = sceneExt[0]
                        cmds.file( f, i=True, type="mayaAscii", ignoreVersion=True, ra=True, mergeNamespacesOnClash=False, namespace=sceneName, options="v=0;p=17;f=0", pr=True )

        self.setArchiveGroups(groups)

        
    def uniqueSeq(self, seq):
        '''Filters a list to get unique entries'''
        seen = set()
        seen_add = seen.add
        return [ x for x in seq if x not in seen and not seen_add(x)]
    
    def tableViewSelectedRows( self ):
        '''Returns the selected rows from the Table View.'''
        sel = self.tableView.selectedIndexes()
        if sel:
            l = []
            for s in sel:
                l.append( s.row() )
            return self.uniqueSeq( l )
        return []
        
    def removeArchiveDialog(self):
        '''removes the currently selected archives in list mode. In text mode it pops a dialog that asks which group to remove.'''
        groups = self.archiveGroups()
        if len(groups):
            items = []
            for g in groups:
                items.append( g.name )
                
            if self.mode:
                sel = self.tableViewSelectedRows()
                if len(sel):
                    self.removeArchives( sel )
            else:
                sel, ok = QtGui.QInputDialog.getItem(self, maya.stringTable[ 'y_xgArchiveFilesUI.kXgenRemoveArchive'  ], maya.stringTable[ 'y_xgArchiveFilesUI.kArchive'  ], items, current=0, editable=False  )
                if ok:
                    self.removeArchive( items.index(sel) )
            
    def removeArchive( self, i ):
        '''removes a single archive.'''
        self.removeArchives( [i] )
        
    def removeArchives( self, l ):
        '''removes multiple archives.'''
        rsList = reversed( l )
        groups = self.archiveGroups()
        for i in rsList:
            if i >= 0 and i < len(groups):
                groups.pop(i)
        self.setArchiveGroups(groups)
        
    def editArchiveDialog( self ):
        '''Edit Archive Properties such as Name, Color, Thumbnail. Might show objects/material bindings.'''
        groups = self.archiveGroups()
        if len(groups):
            items = []
            for g in groups:
                items.append( g.name )
                
            editIndex = -1
            if self.mode:
                sel = self.tableViewSelectedRows()
                if len(sel):
                    editIndex = sel[0]
            else:
                sel, ok = QtGui.QInputDialog.getItem(self, maya.stringTable[ 'y_xgArchiveFilesUI.kXgenEditArchive2'  ], maya.stringTable[ 'y_xgArchiveFilesUI.kArchive2'  ], items, current=0, editable=False  )
                if ok:
                    editIndex = items.index(sel)
                
            if editIndex>=0 and editIndex<len(groups):
                g = groups[editIndex]
                
                point = self.rect().topLeft()
                global_point = self.mapToGlobal(point)
                if editArchiveGroup(g,global_point):
                    sel = self.tableViewSelectedRows()
                    
                    self.setArchiveGroups(groups)
                    
                    for r in sel:
                        self.tableView.selectRow( r )
                    
    def editMode( self ):
        self.switchMode()
        self.refresh()
        self.RefreshCustomParams.emit()  
        #if self.mode:
        #    self.pbMode.setText( _L10N( kListEditMode, "List" ) )
        #else:
        #    self.pbMode.setText( _L10N( kTextEditMode, "Text" ) )
