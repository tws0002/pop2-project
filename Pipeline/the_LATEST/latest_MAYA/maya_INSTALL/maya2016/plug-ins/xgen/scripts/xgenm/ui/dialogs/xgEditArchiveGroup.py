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

from PySide import QtGui, QtCore
import xgenm as xg
from xgenm.ui.widgets import *


class EditArchiveGroupUI(QtGui.QDialog):
    """A dialog to specify the stray percentage of a description.

    This provides an input field for editing the stray percentage expression
    of the current description.
    """
    def __init__(self, n, t, c, d, f):
        QtGui.QDialog.__init__(self)
        self.setWindowTitle(maya.stringTable[ 'y_xgEditArchiveGroup.kEditArchiveGroup'  ])
        self.setSizeGripEnabled(True)
        self.setMinimumWidth(400)
        
        
        layout = QtGui.QVBoxLayout()
        
        self.aName = TextUI(maya.stringTable[ 'y_xgEditArchiveGroup.kNameLayout'  ], maya.stringTable[ 'y_xgEditArchiveGroup.kNameLayoutTip'  ], "" )
        self.aName.setValue( n )
        layout.addWidget(self.aName)
        
        self.aThumb = BrowseUI(maya.stringTable[ 'y_xgEditArchiveGroup.kThumbnailName'  ], maya.stringTable[ 'y_xgEditArchiveGroup.kThumbnailAnn'  ], "","*.png *.jpg *.tif","in")
        self.aThumb.setValue( t )
        layout.addWidget(self.aThumb)
        
        self.aColor = ColorExpressionUI( parent=None, object="", attr="aColor", strLabel="Color", mode="", r=c[0], g=c[1], b=c[2], pos=0, printableName=maya.stringTable[ 'y_xgEditArchiveGroup.kColor'  ])
        layout.addWidget(self.aColor)
        
        self.aDescription = TextUI(maya.stringTable[ 'y_xgEditArchiveGroup.kDescriptionName'  ], maya.stringTable[ 'y_xgEditArchiveGroup.kDescriptionAnn'  ], "")
        self.aDescription.setValue( d )
        layout.addWidget(self.aDescription)
        
        
        self.aFiles = TextEditUI( maya.stringTable[ 'y_xgEditArchiveGroup.kFilesName'  ], maya.stringTable[ 'y_xgEditArchiveGroup.kFilesAnn'  ], "" )
        self.aFiles.setValue( "\n".join(f) )
        layout.addWidget(self.aFiles)
        
        layout.addStretch()
        
        
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignRight)
        hbox.setSpacing(3)
        hbox.setContentsMargins(1,1,1,1)
        self.okButton = QtGui.QPushButton(maya.stringTable[ 'y_xgEditArchiveGroup.kOk'  ])
        self.okButton.setFixedWidth(100)
        self.okButton.setAutoRepeat(False)
        self.okButton.setDefault(True)
        self.connect(self.okButton, QtCore.SIGNAL("clicked()"), self.accept)
        hbox.addWidget(self.okButton)
        
        self.cancelButton = QtGui.QPushButton(maya.stringTable[ 'y_xgEditArchiveGroup.kCancel'  ])
        self.cancelButton.setFixedWidth(100)
        self.cancelButton.setAutoRepeat(False)
        self.connect(self.cancelButton, QtCore.SIGNAL("clicked()"),self.reject)
        hbox.addWidget(self.cancelButton)
        row.setLayout(hbox)
        
        layout.addWidget(row)
        self.setLayout(layout)


def editArchiveGroup( g, pos ):
    """Function to set the stray percentage of a description.

    This provides an input field for editing the stray percentage expression
    of the current description.
    """
    dialog = EditArchiveGroupUI( g.name, g.thumbnail, g.color, g.description, g.lines[1:] )
    dialog.move(pos)
    ret = dialog.exec_()
    if ret:
        g.name = dialog.aName.value()
        g.thumbnail = dialog.aThumb.value()
        g.color = [dialog.aColor.r, dialog.aColor.g, dialog.aColor.b]
        g.description = dialog.aDescription.value()
        g.lines = g.lines[0:1] + dialog.aFiles.value().splitlines()
    return ret
