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
# @file xgEditFXChain.py
# @brief Contains the Edit FX Chain UI.
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
# @version Created 06/22/09
#

import os
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.ui.util.xgUtil import makeLabel
if xgg.Maya:
    import maya.mel as mel

# module name mapped to its localized counterpart
_locNames = {"AnimWires"         :maya.stringTable[ 'y_xgEditFXChain.kAnimWires'  ],
             "ApplyNetForce"     :maya.stringTable[ 'y_xgEditFXChain.kApplyNetForce'  ],
             "BakedGroomManager" :maya.stringTable[ 'y_xgEditFXChain.kGroomBake'  ],
             "BlockAnim"         :maya.stringTable[ 'y_xgEditFXChain.kBlockAnim'  ],
             "Clumping"          :maya.stringTable[ 'y_xgEditFXChain.kClumping'  ],
             "Coil"              :maya.stringTable[ 'y_xgEditFXChain.kCoil'  ],
             "Collision"         :maya.stringTable[ 'y_xgEditFXChain.kCollision'  ],
             "ControlWires"      :maya.stringTable[ 'y_xgEditFXChain.kControlwires'  ],
             "Cut"               :maya.stringTable[ 'y_xgEditFXChain.kCut'  ],
             "Debug"             :maya.stringTable[ 'y_xgEditFXChain.kDebug'  ],
             "DirectionalForce"  :maya.stringTable[ 'y_xgEditFXChain.kDirectionalForce'  ],
             "Force"             :maya.stringTable[ 'y_xgEditFXChain.kForce'  ],
             "MeshCut"           :maya.stringTable[ 'y_xgEditFXChain.kMeshcut'  ],
             "Noise"             :maya.stringTable[ 'y_xgEditFXChain.kNoise'  ],
             "Particle"          :maya.stringTable[ 'y_xgEditFXChain.kParticle'  ],
             "PlaneAnim"         :maya.stringTable[ 'y_xgEditFXChain.kPlaneAnim'  ],
             "PlaneForce"        :maya.stringTable[ 'y_xgEditFXChain.kPlaneForce'  ],
             "PolylineForce"     :maya.stringTable[ 'y_xgEditFXChain.kPolylineForce'  ],
             "PreserveClumps"    :maya.stringTable[ 'y_xgEditFXChain.kPreserveClumps'  ],
             "Snapshot"          :maya.stringTable[ 'y_xgEditFXChain.kSnapshot'  ],
             "SphereForce"       :maya.stringTable[ 'y_xgEditFXChain.kSphereForce'  ],
             "Wind"              :maya.stringTable[ 'y_xgEditFXChain.kWind'  ]}

class EditFXChainUI(QtGui.QDialog):
    """A dialog for editing a descriptions FX module chain.

    This provides a list of the available modules, allows the user
    to add/remove modules from the chain, and reorder the modules
    within the chain.
    """
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgEditFXChain.kEditModifierStack'  ])
        self.setGeometry(50,50,400,400)
        self.setSizeGripEnabled(True)
        layout = QtGui.QVBoxLayout()
        self.setLayout(layout)
        # a row for the two lists
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignLeft)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        hbox.addWidget( self.mkAvailable() )
        hbox.addWidget( self.mkChain() )
        row.setLayout(hbox)
        layout.addWidget(row)
        layout.addSpacing(10)
        self.addButtons()

    def mkAvailable(self):
        col = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignLeft)
        vbox.setSpacing(3)
        vbox.setContentsMargins(1,1,1,1)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgEditFXChain.kAvailableModules'  ])
        self.avail = QtGui.QListWidget()
        for modulename in xgg.FXModuleTypes():
            modulename = modulename.replace("FXModule", "")
            self.avail.addItem(modulename)
        vbox.addWidget(label)
        vbox.addWidget(self.avail)    
        col.setLayout(vbox)
        return col

    def mkChain(self):
        col = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout()
        vbox.setAlignment(QtCore.Qt.AlignLeft)
        vbox.setSpacing(3)
        vbox.setContentsMargins(1,1,1,1)
        label = QtGui.QLabel(maya.stringTable[ 'y_xgEditFXChain.kCurrentModules'  ])
        self.chain = QtGui.QListWidget()
        self.refreshChain()
        vbox.addWidget(label)
        vbox.addWidget(self.chain)
        col.setLayout(vbox)
        return col

    def refreshChain(self,name=""):
        self.chain.clear()
        de = xgg.DescriptionEditor
        modules = xg.fxModules(de.currentPalette(),de.currentDescription())
        row = 0
        for module in modules:
            self.chain.addItem(module)
            if module == name:
                self.chain.setCurrentRow(row)
            row += 1

    def addButtons(self):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignCenter)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.addButton = QtGui.QToolButton()
        self.addButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgFXAdd.png"))
        self.addButton.setFixedSize(42,26)
        self.addButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kAddAnn'  ])
        self.connect(self.addButton, QtCore.SIGNAL("clicked()"),
                     self.addCB)
        hbox.addWidget(self.addButton)
        
        self.removeButton = QtGui.QToolButton()
        self.removeButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgFXRemove.png"))
        self.removeButton.setFixedSize(42,26)
        self.removeButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kRemoveAnn'  ])
        self.connect(self.removeButton, QtCore.SIGNAL("clicked()"),
                     self.removeCB)
        hbox.addWidget(self.removeButton)

        self.upButton = QtGui.QToolButton()
        self.upButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgFXMoveUp.png"))
        self.upButton.setFixedSize(42,26)
        self.upButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kUpAnn'  ])
        self.connect(self.upButton, QtCore.SIGNAL("clicked()"),
                     self.upCB)
        hbox.addWidget(self.upButton)
        
        self.downButton = QtGui.QToolButton()
        self.downButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgFXMoveDown.png"))
        self.downButton.setFixedSize(42,26)
        self.downButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kDownAnn'  ])
        self.connect(self.downButton, QtCore.SIGNAL("clicked()"),
                     self.downCB)
        hbox.addWidget(self.downButton)
        
        filler = QtGui.QWidget()
        hbox.addWidget(filler)
        hbox.setStretchFactor(filler,100)

        self.doneButton = QtGui.QPushButton(maya.stringTable[ 'y_xgEditFXChain.kDone'  ])
        self.doneButton.setFixedWidth(90)
        self.doneButton.setAutoRepeat(False)
        self.doneButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kDoneAnn'  ])
        self.connect(self.doneButton, QtCore.SIGNAL("clicked()"),
                     self.reject)
        hbox.addWidget(self.doneButton)
        row.setLayout(hbox)
        self.layout().addWidget(row)
        
    def addCB(self):
        mo=str(self.avail.currentItem().text()+"FXModule")
        de=xgg.DescriptionEditor
        res=xg.addFXModule(de.currentPalette(),de.currentDescription(),mo)
        if res != "":
            self.refreshChain(res)
            xg.invokeCallbacks("PostFXModuleUserAdd", [res,de.currentPalette(),de.currentDescription(),mo])
        
    def removeCB(self):
        mo=str(self.chain.currentItem().text())
        de=xgg.DescriptionEditor
        res=xg.removeFXModule(de.currentPalette(),de.currentDescription(),mo)
        if res:
            self.refreshChain()
        
    def upCB(self):
        mo=str(self.chain.currentItem().text())
        de=xgg.DescriptionEditor
        res=xg.moveFXModule(de.currentPalette(),de.currentDescription(),mo,-1)
        if res:
            self.refreshChain(mo)
        
    def downCB(self):
        mo=str(self.chain.currentItem().text())
        de=xgg.DescriptionEditor
        res=xg.moveFXModule(de.currentPalette(),de.currentDescription(),mo,1)
        if res:
            self.refreshChain(mo)

def getFxModuleIconPath(moduleName):
    path = xg.iconDir()+"fx_"+moduleName[:1].lower()+moduleName[1:]+".png"
    if not os.path.exists(path):
        return xg.iconDir()+"xgLogo.png"
    else:
        return path

class FXChainLoaderUI(QtGui.QDialog):
    """A dialog for loading an FX chain module.

    This provides a list of the available modules, allows the user
    to add/remove modules from the chain.
    """
    def __init__(self,x,y):
        QtGui.QDialog.__init__(self)
        self.setGeometry(x,y,580,330)    
        self.setSizeGripEnabled(True)
        self.setWindowTitle(maya.stringTable[ 'y_xgEditFXChain.kAddModifierWindow'  ])

        self.frame = QtGui.QFrame(self)

        layout = QtGui.QVBoxLayout(self.frame)
        self.setLayout(layout)
        layout.setContentsMargins(10,10,10,10)
        layout.setSpacing(0)
        layout.addWidget( self.mkAvailable() )
        self.addButtons()        


    def mkAvailable(self):
        col = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout(self.frame)
        vbox.setAlignment(QtCore.Qt.AlignLeft)

        # if in localized mode, build tab in horizontal layout to
        # accomodate japanese text better
        isLocalized = mel.eval("about -uiLanguageIsLocalized;")
        self.avail = QtGui.QListWidget()
        self.avail.setSelectionMode( QtGui.QAbstractItemView.MultiSelection )
        self.avail.setMovement(QtGui.QListView.Static)
        self.avail.setResizeMode(QtGui.QListView.Adjust)
        self.avail.setWordWrap(True)
        if isLocalized == 1:
            self.avail.setViewMode(QtGui.QListView.ListMode)
            self.avail.setWrapping(True)
            self.avail.setFlow(QtGui.QListView.LeftToRight)
            self.avail.setIconSize(QtCore.QSize(50,50))
        else:
            self.avail.setViewMode(QtGui.QListView.IconMode)
            self.avail.setGridSize(QtCore.QSize(64,80))


        for modulename in xgg.FXModuleTypes():
            modulename = modulename.replace("FXModule", "")
            # If modifier is in global list, take the name from there.
            # Otherwise create the name through makeLabel.
            if ( modulename in _locNames):
                niceName = _locNames[modulename]
            else:
                niceName = makeLabel(modulename) 

            icon = QtGui.QIcon(getFxModuleIconPath(modulename))

            
            item = QtGui.QListWidgetItem(icon,niceName)
            item.setToolTip(niceName)
            item.setData(QtCore.Qt.UserRole,modulename)
            if isLocalized == 1:
                item.setSizeHint(QtCore.QSize(110,50))
                item.setTextAlignment(QtCore.Qt.AlignLeft | QtCore.Qt.AlignVCenter)
            self.avail.addItem(item)
        
        vbox.addWidget(self.avail)    
        col.setLayout(vbox)
        return col

    def addButtons(self):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout(self.frame)
        hbox.setAlignment(QtCore.Qt.AlignCenter)

        self.okButton = QtGui.QPushButton(maya.stringTable[ 'y_xgEditFXChain.kOk'  ])
        self.okButton.setFixedWidth(90)
        self.okButton.setAutoRepeat(False)
        self.okButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kOkAnn'  ])
        self.connect(self.okButton, QtCore.SIGNAL("clicked()"), self.okCB)
        self.okButton.setDefault(True)

        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgEditFXChain.kCancel'  ])
        self.cancelButton.setFixedWidth(90)
        self.cancelButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kCancelAnn'  ])
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"), self.reject)
        
        hbox.addWidget(self.okButton)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        self.layout().addWidget(row)

    def okCB(self):
        de=xgg.DescriptionEditor
        for m in self.avail.selectedItems():            
            module=str(m.data(QtCore.Qt.UserRole)+"FXModule")
            result=xg.addFXModule(de.currentPalette(),de.currentDescription(),module)
            if result != "":
                xg.invokeCallbacks("PostFXModuleUserAdd", [result,de.currentPalette(),de.currentDescription(),module])
                xgg.DescriptionEditor.fxStackTab.addNewModule( result )
        self.accept()

class FXChainOrderingUI(QtGui.QDialog):
    """A dialog for ordering modules within an FX module chain.
    """
    def __init__(self,x,y):
        QtGui.QDialog.__init__(self)
        self.setWindowFlags(QtCore.Qt.FramelessWindowHint)
        self.setGeometry(x,y,200,300)    
        self.setSizeGripEnabled(True)

        self.frame = QtGui.QFrame(self)
        self.frame.setGeometry(self.rect())
        self.frame.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtGui.QFrame.Plain)

        layout = QtGui.QVBoxLayout(self.frame)
        self.setLayout(layout)
        layout.setContentsMargins(0,0,0,0)
        layout.setSpacing(0)
        layout.addWidget( self.mkChain() )
        self.addButtons()        
        
    def addButtons(self):
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout(self.frame)
        hbox.setAlignment(QtCore.Qt.AlignCenter)
        
        self.okButton = QtGui.QPushButton(maya.stringTable[ 'y_xgEditFXChain.kOk2'  ])
        self.okButton.setFixedWidth(70)
        self.okButton.setAutoRepeat(False)
        self.okButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kOkAnn2'  ])
        self.connect(self.okButton, QtCore.SIGNAL("clicked()"), self.accept)
        self.okButton.setDefault(True)
        hbox.addWidget(self.okButton)

        self.upButton = QtGui.QToolButton()
        self.upButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgFXMoveUp.png"))
        self.upButton.setFixedSize(26,26)
        self.upButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kUpAnn2'  ])
        self.connect(self.upButton, QtCore.SIGNAL("clicked()"), self.upCB)
        hbox.addWidget(self.upButton)
        
        self.downButton = QtGui.QToolButton()
        self.downButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgFXMoveDown.png"))
        self.downButton.setFixedSize(26,26)
        self.downButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kDownAnn2'  ])
        self.connect(self.downButton, QtCore.SIGNAL("clicked()"), self.downCB)
        hbox.addWidget(self.downButton)
        
        self.removeButton = QtGui.QToolButton()
        self.removeButton.setIcon(QtGui.QIcon(xg.iconDir()+"xgDelete.png"))
        self.removeButton.setFixedSize(26,26)
        self.removeButton.setToolTip(maya.stringTable[ 'y_xgEditFXChain.kRemoveAnn2'  ])
        self.connect(self.removeButton, QtCore.SIGNAL("clicked()"), self.removeCB)
        hbox.addWidget(self.removeButton)
        

        row.setLayout(hbox)
        self.layout().addWidget(row)

    def resizeEvent( self, event ):
        r = self.rect()
        s = event.size()
        self.frame.setGeometry( r.x(), r.y(), s.width(), s.height() )
        super(FXChainOrderingUI, self).resizeEvent(event)

    def mkChain(self):
        col = QtGui.QWidget()
        vbox = QtGui.QVBoxLayout(self.frame)
        vbox.setAlignment(QtCore.Qt.AlignLeft)
        self.chain = QtGui.QListWidget()
        self.refreshChain()
        vbox.addWidget(self.chain)
        col.setLayout(vbox)
        return col

    def refreshChain(self,name=""):
        self.chain.clear()
        de = xgg.DescriptionEditor
        modules = xg.fxModules(de.currentPalette(),de.currentDescription())
        row = 0
        for module in modules:
            self.chain.addItem(module)
            if module == name:
                self.chain.setCurrentRow(row)
            row += 1
        
    def removeCB(self):
        mo=str(self.chain.currentItem().text())
        de=xgg.DescriptionEditor
        res=xg.removeFXModule(de.currentPalette(),de.currentDescription(),mo)
        if res:
            self.refreshChain()
        
    def upCB(self):
        mo=str(self.chain.currentItem().text())
        de=xgg.DescriptionEditor
        res=xg.moveFXModule(de.currentPalette(),de.currentDescription(),mo,-1)
        if res:
            self.refreshChain(mo)
        
    def downCB(self):
        mo=str(self.chain.currentItem().text())
        de=xgg.DescriptionEditor
        res=xg.moveFXModule(de.currentPalette(),de.currentDescription(),mo,1)
        if res:
            self.refreshChain(mo)
        
def editFXChain():
    """Function to edit an FX module chain using a dialog.

    This provides a simple dialog to list the available fx modules, allow
    adding/removing from the chain, and reording the modules.
    """
    if not xgg.DescriptionEditor:
        print maya.stringTable[ 'y_xgEditFXChain.kNoDescriptionEditorOpenSoNoCurrentDescription1'  ]
        return
    dialog = EditFXChainUI()
    dialog.exec_()
    xgg.DescriptionEditor.refresh("Full")
    
def showFXChainLoaderDialog( x, y ):
    """Function to add FX module chains using a dialog.
    """
    if not xgg.DescriptionEditor:
        print maya.stringTable[ 'y_xgEditFXChain.kNoDescriptionEditorOpenSoNoCurrentDescription2'  ]
        return
    dialog = FXChainLoaderUI(x,y)
    dialog.exec_()

def showFXChainOrderingDialog( x, y ):
    """Function to order FX module chains using a dialog.
    """
    if not xgg.DescriptionEditor:
        print maya.stringTable[ 'y_xgEditFXChain.kNoDescriptionEditorOpenSoNoCurrentDescription3'  ]
        return
    dialog = FXChainOrderingUI(x,y)
    dialog.exec_()
    xgg.DescriptionEditor.refresh("Full")
    
