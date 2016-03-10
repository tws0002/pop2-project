#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Finalizing project assets

:AUTHORNOTE: Get Maya's interpreter and add a case for when it's automatically acquired

.. considerations::
 You must be within an application (maya, nuke, houdini) in order to function

Requires:
    - a GUI
        --- Must have its items populated dynamically
            --- each item must be selectable
        --- A create new folder option
        -/- When executed, the script will
            --- get the current selection
            --- make sure the proposed folder path is valid (use fileio)
            --- if the proposed folder doesn't exist, and isn't "", make it
            --- find a way to determine what software I'm in
            --- save the current scene file (using the application-specific save)
            --- get the current scene file
            --- different methods or types for each software
            --- read the file's contents and parse it
            --- get a list of files
    - syncmeister
        - once a list of files are collected, the script must
          - create a folder which is called the name of the current file/script
            - find the top-level dependencies and place them in
            - create subfolders/dependency locations as it goes
"""

# IMPORT STANDARD LIBRARIES
import os
import sys

# IMPORT THIRD-PARTY LIBRARIES
import PyQt4.QtGui as QtGui
import PyQt4.QtCore as QtCore
import PyQt4.uic as uic

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts
import fileio.controller.paths as paths
import fileio.controller.checkout as checkout
import syncmeister.controller.engine as engine
import controller.applications as apps


CURRENTDIR = os.path.dirname(os.path.realpath(__file__))
FORMCLASS_WINDOW = uic.loadUiType(os.path.join(CURRENTDIR, 'view',
                                               "test_ui_delete_me_later_main.ui"))[0]


class BaseWindow(QtGui.QMainWindow, FORMCLASS_WINDOW):
    def __init__(self, parent=None):
        super(BaseWindow, self).__init__(parent)
        self.folder = consts.FINAL_DIR
        self.setupUi(self)
        self.init_ui()
    # end __init__

    def init_ui(self):
        """
        Creates the project-specific information necessary to make the GUI
        """
        # init the would-be listWidget items
        finalTypeFolders = [os.path.join(self.folder, x) \
                            for x in os.listdir(self.folder) \
                            if os.path.isdir(os.path.join(self.folder, x))]
        for folder in finalTypeFolders:
            item = QtGui.QListWidgetItem(paths.os_path_split_asunder(folder)[-1])
            item.setFlags(QtCore.Qt.ItemIsEnabled | QtCore.Qt.ItemIsSelectable)
            self.listWidget.addItem(item)
    # end init_ui
# end BaseWindow


class Window(BaseWindow):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        self.defaultTextListWidget = "{New Folder Name}"

        # triggers/buttons
        self.pushButton.clicked.connect(self.make_final_folder_type)
        self.buttonBox.accepted.connect(self.accept)
        self.buttonBox.rejected.connect(self.reject)
        # self.listWidget.itemChanged.connect(self.set_list_widget_item_as_uneditable)
    # end __init__

    def is_valid_folder_path(self, folderName=None, rootDir=None):
        """
        Checks to make sure the folder is valid, according to the
        system/project standards and does not contain any reserved characters
        """
        if folderName is None:
            folderName = self.selectedItemText
        if rootDir is None:
            rootDir = self.rootDir

        if len(paths.os_path_split_asunder(folderName)) > 1:
            errorMsg = 'Nesting folders is not allowed. '\
                       'Remove any "\" or "/" from the folder name'
            messageBox = QtGui.QMessageBox.about(self, "File Name Error", errorMsg)
            raise RuntimeError(errorMsg)

        if folderName == self.defaultTextListWidget or self.selectedItemText.strip() == "":
            errorMsg = "The selected folder must have a valid name"
            messageBox = QtGui.QMessageBox.about(self, "Selection Error", errorMsg)
            raise RuntimeError(errorMsg)


        fileIO = checkout.FileIO(rootDir)
        if fileIO.is_farm_character_limit(folderName) or \
                fileIO.is_character_limit(rootDir):
            errorMsg = "Path: {path!r} is too long. Please shorten the "\
                       "name".format(path=fileIO.fullPath)
            messageBox = QtGui.QMessageBox.about(self, "Length Error", errorMsg)
            raise RuntimeError(errorMsg)

        if fileIO.is_valid_filepath(rootDir):
            errorMsg = "Path: {path!r} is not valid. It contains one or more "\
                       "system reserved characters, "\
                       "{chars!r}".format(path=fileIO.fullPath,
                                          chars=fileIO.disallowedFilePathCharacters)
            messageBox = QtGui.QMessageBox.about(self, "File Name Error", errorMsg)
            raise RuntimeError(errorMsg)

        return True
    # end is_valid_folder_path

    def make_final_folder_type(self):
        """
        When the add folder button is selected
        """
        item = QtGui.QListWidgetItem()
        item.setFlags(QtCore.Qt.ItemIsSelectable | QtCore.Qt.ItemIsEditable | QtCore.Qt.ItemIsEnabled)
        item.setText(self.defaultTextListWidget)
        self.listWidget.addItem(item)
    # make_final_folder_type

    def write_to_folder(self):
        """
        Gets the current selected QListWidgetItem and uses it as an output.
        If the folder name is self.defaultTextListWidget or .strip() == "",
        raise ValueError
        """
        selectedItem = self.listWidget.selectedItems()
        if len(selectedItem) > 1 or len(selectedItem) <= 0:
            errorMsg = "Please select one folder at a time"
            messageBox = QtGui.QMessageBox.about(self, "Selection Error", errorMsg)
            raise RuntimeError(errorMsg)

        self.selectedItemText = str(selectedItem[0].text())
        self.rootDir = os.path.join(self.folder, self.selectedItemText)
        self.is_valid_folder_path(self.selectedItemText, self.rootDir)

        fileIO = checkout.FileIO(self.rootDir)
        if not os.path.isdir(fileIO.fullPath):
            # recursively add folders until the path exists
            paths.mkdir_p(fileIO.fullPath)

        # determine the application type and use that to save the current file
        app = folders.get_application_type()
        application = checkout.FileCheckout("Null")
        application = application.elevate_class_by_application(app)
        application.save()  # save the current file so that newest changes are kept

        with open(application.get_current_scene(), "r") as f:
            data = f.readlines()

        # run syncmeister on the current scene
    # end write_to_folder

    # def set_list_widget_item_as_uneditable(self, item):
    #     """
    #     Quick method to lock a QListWidgetItem from being edited. Used when the
    #     user renames the widget in order to "set" the folder name
    #     """
    #     item.setFlags(QtCore.Qt.ItemIsEnabled | QtCore.Qt.ItemIsSelectable)
    # # end set_list_widget_item_as_uneditable


    def accept(self):
        """
        Accept method when the user presses "OK"
        """
        self.write_to_folder()
    # end accept

    def reject(self):
        """
        Reject method when the user presses "Cancel"
        """
        pass
    # end reject
# end Window


def show_gui():
    """
    Shows the GUI in the current environment
    """
    app = QtGui.QApplication(sys.argv)
    window = Window()
    window.show()
    sys.exit(app.exec_())
# end show_gui


if __name__ == "__main__":
    show_gui()
