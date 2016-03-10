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
import subprocess

# IMPORT THIRD-PARTY LIBRARIES
# sys.path.append(r"/usr/autodesk/maya2016/lib/python2.7/site-packages")
# sys.path.append(r"/usr/autodesk/maya2016/bin")
# sys.path.append(r"/usr/local/Nuke9.0v8/pythonextensions/site-packages")
# from PyQt4 import QtCore
# from PyQt4 import QtGui
# from PyQt4 import uic
import PySide.QtGui as QtGui
import PySide.QtCore as QtCore
# import PySide.QtUiTools.QUiLoader
# import pyside_uic as uic
# import PySide.uic as uic

# IMPORT LOCAL LIBRARIES
import fileio.model.userconfig as userconfig
import constants.model.constants as consts
import controller.engine as engine

CURRENTDIR = os.path.dirname(os.path.realpath(__file__))
FORMCLASS_WINDOW = uic.loadUiType(os.path.join(CURRENTDIR, 'view',
                                               "shotSelectionBase.ui"))[0]


class Window(QtGui.QMainWindow, FORMCLASS_WINDOW):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        # super(Window, self).__init__(parent)
        self.setupUi(self)
        self.appSceneFTypes = {"houdini": consts.FILETYPES_HOUDINI,
                                          "maya": consts.FILETYPES_MAYA,
                                          "nuke":consts.FILETYPES_NUKE}
        self.apps = self.appSceneFTypes.keys()
        self.reCompile = re.compile(consts.SHOT_MATCH_PATTERN, re.VERBOSE)
        self.shotsFolder = consts.EDIT_DIR
        self.get_scenes()
        self.get_shots()

        # init user's last-used settings for the quick select window
        initialPrefs = userconfig.get_user_prefs()
        initPrefs = initialPrefs.get("FOPEN_PREFS", None)
        if initPrefs is not None:
            initScene = initPrefs.get("UI_PREF_SCENE", "")
            index = self.scene_cb.findText(initScene, QtCore.Qt.MatchFixedString)
            if index >= 0 and initScene != "":
                self.scene_cb.setCurrentIndex(index)

            initShot = initPrefs.get("UI_PREF_SHOT", "")
            index = self.shot_cb.findText(initShot, QtCore.Qt.MatchFixedString)
            if index >= 0 and initShot != "":
                self.shot_cb.setCurrentIndex(index)

            initApp = initPrefs.get("UI_PREF_APPLICATION", "")
            index = self.applications_cb.findText(initApp, QtCore.Qt.MatchFixedString)
            if index >= 0 and initApp != "":
                self.applications_cb.setCurrentIndex(index)

            initChoice = initPrefs.get("UI_PREF_CHOICE", "")
            index = self.choose_cb.findText(initChoice, QtCore.Qt.MatchFixedString)
            if index >= 0 and initChoice != "":
                self.choose_cb.setCurrentIndex(index)


        # buttons/triggers
        QtCore.QObject.connect(self.scene_cb,
                               QtCore.SIGNAL("currentIndexChanged(int)"),
                               self.get_shots)
        self.loadLast_pb.clicked.connect(self.load_last_loaded_file)
    # end __init__

    def accept(self):
        currentScene = str(self.scene_cb.currentText())
        currentShot = str(self.shot_cb.currentText())
        self.currentApp = str(self.applications_cb.currentText())
        currentChoice = str(self.choose_cb.currentText())
        folder = "s" + str(currentScene).zfill(3) + currentShot
        self.currentFolder = os.path.join(self.shotsFolder, folder)
        self.currentFolder = self.get_app_folder(self.currentFolder,
                                                 self.currentApp)
        appSceneTypes = self.appSceneFTypes[self.currentApp]
        filesToCompare = [os.path.join(self.currentFolder, x) \
                          for x in os.listdir(self.currentFolder) \
                          if os.path.isfile(os.path.join(self.currentFolder, x))]

        if currentChoice == "Manual {let me choose}":
            fileOpen = self.open_dialog(self.currentFolder)

        elif currentChoice == "Automatic {by filename}":
            fileOpen = engine.get_latest_by_filename(filesToCompare)

        elif currentChoice == "Automatic {by date}":
            fileOpen = engine.get_latest_by_date(filesToCompare)

        if fileOpen is not None:
            # set dialog box open preferences for next time
            userConfigH = userconfig.get_user_prefs()
            fileOpenRelative = os.path.relpath(fileOpen, consts.DEV_DIR)
            userConfigH["FOPEN_PREFS"] = {"UI_PREF_SCENE": currentScene,
                                          "UI_PREF_SHOT": currentShot,
                                          "UI_PREF_APPLICATION": self.currentApp,
                                          "UI_PREF_CHOICE": str(self.choose_cb.currentText()),
                                          "LAST_OPENED": fileOpenRelative,
                                          "LAST_OPENED_APPLICATION": self.currentApp}
        self.open_file(fileOpen, self.currentApp)
        userconfig.set_user_config(userConfigH)
    # end accept

    def reject(self):
        sys.exit(self)
    # end reject

    def open_file(self, fileToOpen, application):
        """
        Actually opens the files to the project using whichever application is
        most appropriate

        .. note::
         Normally I'd just use modules from within each application to open files
         but because the current python interpreter is actually just the regular
         python interpreter, I can't actually use the maya.cmds or hou or nuke
         modules. Thankfully though, every program I'm supporting has valid
         command-line methods!

        :AUTHORNOTE: I NEED TO REPLACE THESE subprocess calls
        """
        if application.lower() == "nuke":
            if consts.SYSTEM == "linux2":
                execPath = "/usr/local/bin/nukex"
                subprocess.call(execPath, fileToOpen)
            elif consts.SYSTEM == "win32":
                execPath = r"C:\\Program Files\\Nuke9.0v6\Nuke9.0.exe"
                subprocess.call([execPath, "-b", "--nukex", fileToOpen])
        elif application.lower() == "maya":
            if consts.SYSTEM == "linux2":
                # use the custom maya executable
                execPath = os.path.join(os.environ['PIPELINE_DIR'], 
                                        "latest_MAYA", "maya_INSTALL", 
                                        "maya2016", "bin", "maya2016")
            elif consts.SYSTEM == "win32":
                execPath = r"C:\\Program Files\\Autodesk\\Maya2016\\bin\\maya.exe"
            subprocess.call([execPath, fileToOpen])
        elif application.lower() == "houdini":
            raise NotImplementedError("Houdini open files are not implemented "
                                      "for the current tool")
    # end open_file

    def load_last_loaded_file(self):
        """
        Loads whatever you had loaded previously
        """
        userConfigH = userconfig.get_user_prefs()
        # :AUTHORNOTE: load the file in the application-specific way here
        lastFile = userConfigH["FOPEN_PREFS"]["LAST_OPENED"]
        lastOpenedFile = os.path.normpath(os.path.join(CURRENTDIR, lastFile))
        if os.path.isfile(lastOpenedFile):
            self.open_file(lastOpenedFile, self.currentApp)
        # end load_last_loaded_file

    def get_app_folder(self, rootDir, application):
        """
        Joins a base scene/shot folder directory and finds its respective folder
        where scene files are likely to be based on propietary rules about the project

        .. important::
         This function assumes that the passed application folder is set, which
         must be done using the ApplicationFolderRule class
        """
        if application.lower() == "maya":
            folder = os.path.join(rootDir, "maya", "scenes")
        elif application.lower() == "nuke":
            folder = os.path.join(rootDir, "nuke", "drafts")
        elif application.lower() == "houdini":
            raise NotImplementedError("Houdini has not been implemented with "
                                      "this tool")
        return folder
    # end get_app_folder

    def open_dialog(self, folderPrefix):
        """
        Opens folder location that starts at the given scene folder
        """
        # fname = QtGui.QFileDialog.getOpenFileName(self, 'Open file', folderPrefix)
        print folderPrefix
        fname = QtGui.QFileDialog.getOpenFileName(self, 'Select scene file',
                                                  folderPrefix)
        f = open(fname, 'r')
        return fname
    # end open_dialog

    def get_scenes(self):
        """
        Gets scenes
        """
        folder = self.shotsFolder
        sceneList = engine.get_scenes(folder, self.reCompile)
        for num in sceneList:
            self.scene_cb.addItem(str(num))
    # end get_scenes

    def get_shots(self):
        """
        .. important::
         This function requires the use of self.folder, which is initialized in
         self.get_scenes(). If you want to do get_shots before get_scenes, you
         will need to break out self.folder into a variable and initialize it
         before self.get_shots() can run
        """
        self.shot_cb.clear()  # reset the fields before each run
        folder = self.shotsFolder
        currentText = self.scene_cb.currentText()
        sceneFolderName = 's' + str(currentText).zfill(3)
        shotFolder = self.shotsFolder
        shotsFolderList = engine.get_folders(shotFolder)
        shotList = engine.get_shots(currentText, shotsFolderList,
                                    sceneFolderName, self.reCompile)
        for shot in shotList:
            self.shot_cb.addItem(shot)
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
