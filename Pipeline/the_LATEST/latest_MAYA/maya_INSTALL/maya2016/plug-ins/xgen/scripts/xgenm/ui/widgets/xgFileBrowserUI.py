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
# @file xgFileBrowserUI.py
# @brief Contains the UI for PyQt file browser dialog window.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Ying Liu
# @author Thomas V Thompson II
#
# @version Created 07/27/09
#

import string
from PySide import QtGui, QtCore
import os
from xgenm.xgUtil import fixPath, isPathRelative, fixFolderPath
import xgenm as xg

def currentWorkDir():
    pwd = os.getcwd()
    dir = fixPath(pwd)
    if not dir.endswith('/'):
        dir = dir + '/'
    return dir

def defaultDir():
    return str(xg.localRepo())

def fileBrowserDlg(parent,startDir,fileType="",inOrOut="in"):
    # Get setup with a full path given users input value
    startDir = str(startDir)
    if isPathRelative(startDir):
        base = currentWorkDir()
        startDir = base + startDir
        
    if not os.path.exists(startDir):
        startDir = defaultDir()

    if len(fileType):
        if inOrOut == "in":
            (selectedFile, _) = QtGui.QFileDialog.getOpenFileName(parent,
                                    maya.stringTable[ 'y_xgFileBrowserUI.kSelectFile'  ], startDir,
                                    maya.stringTable[ 'y_xgFileBrowserUI.kFileType'  ]+"("+fileType+")",
                                    "",QtGui.QFileDialog.DontUseNativeDialog)
        else:
            (selectedFile, _) = QtGui.QFileDialog.getSaveFileName(parent,
                                    maya.stringTable[ 'y_xgFileBrowserUI.kSaveFile'  ], startDir,
                                    maya.stringTable[ 'y_xgFileBrowserUI.kFileType2'  ]+"("+fileType+")",
                                    "",QtGui.QFileDialog.DontUseNativeDialog)
        if len(selectedFile):
            selectedFile = fixPath(str(selectedFile))
    else:
        selectedFile = QtGui.QFileDialog.getExistingDirectory(parent,
                                    maya.stringTable[ 'y_xgFileBrowserUI.kSelectDirectory'  ], startDir,
                                    QtGui.QFileDialog.ShowDirsOnly |
                                    QtGui.QFileDialog.DontResolveSymlinks)
        if len(selectedFile):
            selectedFile = fixFolderPath(str(selectedFile))
    
    return selectedFile
