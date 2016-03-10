#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Quickly selects scene files
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import re
import time
import datetime

# IMPORT THIRD-PARTY LIBRARIES
from PyQt4 import QtCore
from PyQt4 import QtGui
from PyQt4 import uic

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts
import fileio.controller.paths as paths
import shotSelectionBase as base

CURRENTDIR = os.path.dirname(os.path.realpath(__file__))
FORMCLASS_WINDOW = uic.loadUiType(os.path.join(CURRENTDIR,
                                               "shotSelectionBase.ui"))[0]

class Window(QtGui.QMainWindow, FORMCLASS_WINDOW):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        # super(Window, self).__init__(parent)
        self.setupUi(self)
        self.appSceneFTypes = {"houdini": consts.FILETYPES_HOUDINI,
                                          "maya": consts.FILETYPES_MAYA,
                                          "nuke":consts.FILETYPES_NUKE}
        string1 = "s001A_v4"
        self.regex = r"^((_+)?s0(?P<shot>\d{2})(?P<shotRevision>[A-Z]{1,2})?(_v(?P<shotRedraft>\d+))_?)"

        self.regex = r"^((_+)?s0(?P<shot>\d{2})(?P<shotRevision>[A-Z]{1,2})?"\
                       "(_v(?P<shotRedraft>\d+)|_)?)"
        self.reCompile = re.compile(self.regex)
        match = re.match(self.reCompile, string1)
        self.shotsFolder = consts.EDIT_DIR
        self.get_scenes()
        self.get_shots()

        QtCore.QObject.connect(self.scene_cb,
                               QtCore.SIGNAL("currentIndexChanged(int)"),
                               self.get_shots)
        # self.connect(self.shot_cb, QtCore.SIGNAL("currentIndexChanged(const "
        #                                          "QString&)"),
        #                                          self.get_shots)
    # end __init__

    def get_folder(self, rootDir):
        """
        Gets folders in the scene/shot directory
        """
        for root, dirs, files in os.walk(rootDir):
            for d in dirs:
                yield os.path.join(root, d)
     # end get_folder

    def get_scenes(self):
        """
        Creates items based on the what's in the Edit scenes folder
        """
        comboBoxItemIndex = -1  # so that += will start at index to 0
        sceneList = []
        folderListing = self.get_folder(self.shotsFolder)
        for folder in folderListing:
            folderName = paths.path_leaf(folder)
            reMatch = re.match(self.reCompile, folderName)
            if reMatch is not None:
                comboBoxItemIndex += 1
                sceneNum = reMatch.group("shot")
                sceneNum = int(sceneNum)
                if sceneNum not in sceneList:
                    sceneList.append(sceneNum)

        sceneList.sort()
        for num in sceneList:
            self.scene_cb.addItem(base._fromUtf8(str(num)))
    # end get_scenes

    def get_shots(self):
        """
        Auto gets shots, based on the current scene number displayed
        """
        self.shot_cb.clear()
        currentText = str(self.scene_cb.currentText())
        currentTextAsInt = int(currentText)
        shotList = []
        for folder in self.get_folder(self.shotsFolder):
            folderName = paths.path_leaf(folder)
            reMatch = re.match(self.reCompile, folderName)
            scene = reMatch.group("shot")
            if int(scene) == currentTextAsInt:
                toReplace = "s0" + scene
                shot = folderName[len(toReplace):]
                shotList.append(shot)

        shotList.sort(key=len)
        for shot in shotList:
            self.shot_cb.addItem(base._fromUtf8(shot))
    # end get_shots

    def accept(self):
        currentScene = str(self.scene_cb.currentText())
        currentShot = str(self.shot_cb.currentText())
        self.currentApp = str(self.applications_cb.currentText())
        currentChoice = str(self.choose_cb.currentText())
        # self.currentFolder = os.path.join(self.shotsFolder,
        #                                   "s0" + currentScene + currentShot,
        #                                   self.currentApp)
        self.currentFolder = r""
        if currentChoice == "Manual {let me choose}":
            self.open_dialog(self.currentFolder)

        elif currentChoice == "Automatic {by filename}":
            self.get_latest_by_filename(self.currentFolder)
    # end accept

    def reject(self):
        pass
    # end reject

    def open_dialog(self, folderPrefix):
        """
        Opens folder location that starts at the given scene folder
        """
        dialogBox = QtGui.QFileDialog(self)
    # end open_dialog

    def get_latest_by_filename(self):
        """
        Parses the current filename and gets the latest file
        """
        pass
    # end get_latest_by_filename

    def get_latest_by_date(self, rootDir):
        """
        Gets metadata of file and selects the most recent
        """
        fileList = []
        for files in os.listdir(rootDir):
            if os.path.isfile(files) and \
                    files.upper().endswith(self.appSceneFTypes[self.currentApp]):
                # :AUTHORNOTE: Get file metadata
                fileTime = time.ctime(os.path.getmtime(files))
                fileList.append((os.path.join(files), fileTime))
        fileList.sort(key=lambda x: datetime.datetime(x[1]))
        fileToAccess = fileList[0]
        self.set_project_file(fileToAccess)
    # end get_latest_by_date

    def set_project_file(self, applicationType):
        """
        Open the project file, whose method depends on the application type
        """
        pass
    # end set_project_file
# end Window


def main():
    """
    The function that executes the GUI
    """
    app = QtGui.QApplication(sys.argv)
    window = Window()
    window.show()
    sys.exit(app.exec_())
# end main


if __name__ == "__main__":
    main()
