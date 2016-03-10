#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Assists user to select shot files faster by letting them select the scene/shot
pair. Once they've selected an application, the application that they selected
is remembered and saved for future reference.

.. TO DO::
 It may be nice to add an environment variable so that people can set their
 preferred scene/shot/application for the tool
"""

# IMPORT STANDARD LIBRARIES
import sys

# IMPORT THIRD-PARTY LIBRARIES
from PyQt4 import QtCore
from PyQt4 import QtGui
from PyQt4 import uic

# IMPORT LOCAL LIBRARIES
import openfiledialog
from constants.model import constants as consts


try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)


class OpenShotScene(QtGui.QMainWindow):
    """
    Inits the UI for the window

    By default, the scenes list is automatically populated by getting the
    folders located in the project's scene folder directory (as defined in
    consts.SCENE_FOLDER_DIR). The shot letter dropdown is automatically
    filtered/acquired based on whatever the scene number is currently selected
    and the finally the application is selected manually by the user.

    Currently, the application that was selected is stored as a user preference
    for later and if the choice is automatic, the latest file is chosen by
    finding the file with the greatest version number/letter pair

    .. TODO::
     Make a environment variable solution so that user's scene/shot preference
     can be acquired from their .bat/.sh file
    """
    def __init__(self):
        super(OpenShotScene, self).__init__()
        """
        Inits the window UI and randomly selects a scene/shot pair
        """
        self.init_ui()
        # self.gridLayout.addLayout(self.sceneCB, 0, 0)
        # self.gridLayout.addLayout(self.shotCB, 0, 0)
        # self.gridLayout.addLayout(self.applicationCB, 0, 0)
        # self.gridLayout.addLayout(self.choiceCB, 0, 1)
        # self.setLayout(self.gridLayout)

        # self.gridLayout = QtGui.QGridLayout(self)
        # self.verticalLayout = QtGui.QVBoxLayout()
        # self.label = QtGui.QLabel(self)
        # self.verticalLayout.addWidget(self.label)
        # self.comboBox = QtGui.QComboBox(self)
        # self.comboBox.setObjectName(_fromUtf8("comboBox"))
        # self.verticalLayout.addWidget(self.comboBox)
        # self.gridLayout.addLayout(self.verticalLayout, 0, 0, 1, 1)
    # end __init__

    def init_ui(self):
        """
        Sets window-specific labels and data for the current window
        """
        self.setWindowTitle("Shot Selection")
        self.setGeometry(500, 500, 500, 250)

        self.gridLayout = QtGui.QGridLayout(self)
        self.mainWidget = QtGui.QWidget(self)
        self.setCentralWidget(self.mainWidget)

        # Create combo boxes for the GUI

        # self.sceneCB = create_combo_box_scene()
        # self.shotCB = create_combo_box_shot()
        # self.applicationCB = create_combo_box_application()
        # self.choiceCB = create_combo_box_choice()

        # self.verticalLayout = QtGui.QVBoxLayout()
        # self.label = QtGui.QLabel(self)
        # self.verticalLayout.addWidget(self.label)
        # self.verticalLayout.addWidget(self.comboBox)
        # self.gridLayout.addLayout(self.verticalLayout, 0, 0, 1, 1)

        self.comboBox = QtGui.QComboBox(self)
        self.verticalLayout = QtGui.QVBoxLayout(self)
        self.verticalLayout.addWidget(self.comboBox)
        self.gridLayout.addLayout(self.verticalLayout, 0, 3, 1, 1)

        # self.gridLayout.addLayout(self.sceneCB, 0, 0, 1, 1)
        # self.gridLayout.addLayout(self.comboWidget, 0, 3)
        # self.gridLayout.addLayout(self.shotCB, 0, 1, 1, 1)
        # self.gridLayout.addLayout(self.applicationCB, 0, 2, 1, 1)
        # self.gridLayout.addLayout(self.choiceCB, 0, 3, 1, 1)

        # Write docs for GUI elements
    # end init_ui
# end OpenShotScene


def create_combo_box_scene():
    """
    Convenience function for creating a fast scene combo box
    """
    comboB = openfiledialog.ComboObjScene("Scene Number",
                                          consts.EDIT_DIR)
    return comboB
# end create_combo_box_scene


def create_combo_box_shot():
    """
    Convenience function for creating a fast shot combo box
    """
    comboB = openfiledialog.ComboObjShot("Shot Letter",
                                         consts.EDIT_DIR)
    return comboB
# end create_combo_box_shot


def create_combo_box_choice():
    """
    Convenience function for creating a way for the user to select files manually
    """
    comboB = openfiledialog.ComboObj()
    comboB.label.setText("Choice")
    comboB.comboB.addItems(["The latest {automatic}",
                            "Let me chooose {manual}"])
    return comboB
# end create_combo_box_choice


def create_combo_box_application():
    """
    Convenience function for creating a fast application type
    """
    comboB = openfiledialog.ComboObj()
    comboB.label.setText("Application")
    comboB.comboB.addItems(["Houdini", "Maya", "Nuke"])
    return comboB
# end create_combo_box_application


def main():
    """
    The function that executes the GUI
    """
    app = QtGui.QApplication(sys.argv)
    window = OpenShotScene()
    window.show()
    sys.exit(app.exec_())
# end main


if __name__ == "__main__":
    main()
