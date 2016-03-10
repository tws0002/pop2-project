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
# @file xgUtil.py
# @brief Contains utility functions for use in the ui module.
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

import re
from PySide import QtGui
from PySide.QtCore import Qt
import xgenm as xg
import xgenm.xgGlobal as xgg
import maya.mel as mel
import maya.cmds as cmds


def makeLabel(label):
    """Adds spaces to a camel case string.

    >>> _makeLabel('HTMLServicesByTom')
    'HTML Services By Tom'
    """
    if label is None:
        return None

    # Check to see if this is a custom attribute
    if label[:7] == "custom_":
        return label[7:].replace("_"," ",1)

    if label[:8] == "archive_":
        return label[8:].replace("_"," ",1)

    pattern = re.compile('([A-Z][A-Z][a-z])|([a-z][A-Z])')
    result = pattern.sub(lambda m: m.group()[:1] + " " + m.group()[1:], label)
    return result[:1].capitalize() + result[1:]


def labelWidth():
    """Sets the label widgets width given the current font metrics.
    """
    if xgg.LabelWidth > 0:
        return xgg.LabelWidth
    label = QtGui.QLabel("")
    currentFont = label.font()
    fontMetrics = QtGui.QFontMetrics(currentFont)
    brect = fontMetrics.boundingRect("XGen Generates Primitives")
    xgg.LabelWidth = brect.width()
    return xgg.LabelWidth


def destroyWidget(wid):
    """Destroy a widget as completely and quickly as possible.
    """
    if not wid:
        return
    wid.hide()
    wid.setParent(None)
    wid.deleteLater()

def createScrollArea( widget ):
          scrollArea = QtGui.QScrollArea()
          scrollArea.setWidget(widget)
          scrollArea.setWidgetResizable(True)
          scrollArea.setFrameStyle(QtGui.QFrame.NoFrame)
          scrollArea.setContentsMargins(0,0,0,0)
          return scrollArea

def currentPalette():
    """Get the current palette. This requires the description editor
    to exist but not necessarily be open.
    """
    if xgg.DescriptionEditor is None:
        return ""
    return xgg.DescriptionEditor.currentPalette()


def currentDescription():
    """Get the current description. This requires the description editor
    to exist but not necessarily be open.
    """
    if xgg.DescriptionEditor is None:
        return ""
    return xgg.DescriptionEditor.currentDescription()


def information(parent, title, message=None, details=None, informative_text=None):
    """Show information with the provided title and message."""
    if message is None:
        message = title
    mbox = QtGui.QMessageBox(parent)
    mbox.setStandardButtons(QtGui.QMessageBox.Close)
    mbox.setDefaultButton(QtGui.QMessageBox.Close)
    mbox.setWindowTitle(title)
    mbox.setWindowModality(Qt.WindowModal)
    mbox.setTextFormat(Qt.PlainText)
    mbox.setText(message)
    if informative_text:
        mbox.setInformativeText(informative_text)
    if details:
        mbox.setDetailedText(details)
    pixmap = mbox.style().standardPixmap(QtGui.QStyle.SP_MessageBoxInformation)
    mbox.setIconPixmap(pixmap)
    mbox.exec_()

def executeDeferred( script ):
    try:
        import maya.utils as utils
        utils.executeDeferred( script )
    except ImportError:
        # just evaluate the script if maya is not loaded
        try:
            eval( script )
        except:
            import sys
            print sys.exc_info()[1]
            raise
    except:
        import sys
        print sys.exc_info()[1]
        raise

def parseFilePath( path ):
    """parse a file path to obtain a custom attribute - the name of the final folder of the path
    expects "/" as filepath delimiter, regardless of os."""
    splitList = path.split("/")
    if len(splitList) == 0:
        return ""
    newattr = splitList[-1]
    # allow for file paths ending relative, such as ${DESC}/Region/
    if newattr == "":
        return splitList[-2]
    else:
        return newattr

def saveScene():
    """ Save scene if the scene has not been saved or modified after last save. """
    sceneName = ""
    try:
        sceneName = cmds.file( query=True, sceneName=True )
        saveSceneStr = maya.stringTable[ 'y_xgUtil.kSaveScene' ]
        if len( sceneName ) > 0:
            modified = cmds.file( query=True, modified=True )
            if modified:
                # modified after last save, prompt to save the scene
                msgBox = QtGui.QMessageBox(QtGui.QMessageBox.NoIcon, saveSceneStr, maya.stringTable[ 'y_xgUtil.kSaveModifiedScene' ], QtGui.QMessageBox.Save | QtGui.QMessageBox.Cancel) #, Qt.Dialog | Qt.MSWindowsFixedSizeDialogHint)
                ret = msgBox.exec_()
                if ret == QtGui.QMessageBox.Save:
                    cmds.file( save=True )
                else:
                    sceneName = ""
        else:
            # not saved
            msgBox = QtGui.QMessageBox(QtGui.QMessageBox.NoIcon, saveSceneStr, maya.stringTable[ 'y_xgUtil.kSaveSceneToContinue' ], QtGui.QMessageBox.Save | QtGui.QMessageBox.Cancel) #, Qt.Dialog | Qt.MSWindowsFixedSizeDialogHint)
            ret = msgBox.exec_()
            if ret == QtGui.QMessageBox.Save:
                mel.eval("SaveScene")
            
            sceneName = cmds.file( query=True, sceneName=True )
    except RuntimeError:
        pass
    
    return sceneName

def uiPalettes():
    """ Filters out the collections generated by MR rendering. Returns those can be used in UI display """
    pals = xg.palettes()
    ret = []
    for pal in pals:
        if not pal.startswith("XG_RENDER_"):
            ret.append( pal )
    return ret
