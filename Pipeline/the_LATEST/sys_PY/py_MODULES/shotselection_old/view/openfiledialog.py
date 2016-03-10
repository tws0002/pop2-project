#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Makes a open dialog box that makes opening scenes faster
"""

# IMPORT STANDARD LIBRARIES
import os
import sys

# IMPORT THIRD-PARTY LIBRARIES
import PyQt4.QtCore as QtCore
import PyQt4.QtGui as QtGui
import PyQt4.uic as uic

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts

"""
A helper module that contains more complicated methods for the combo boxes.
The combo boxes require a little bit more prep and intelligence because their
items have to be created dynamically based on user selection
"""

class ComboObj(QtGui.QWidget):
    """
    The base for all of the other combo box classes. Contains information about
    style and stretch functionality. Safe to ignore
    """
    def __init__(self, parent):
        """
        Init the UI
        """
        super(ComboObj, self).__init__(parent)
        self.init_ui()
    # end __init__

    def init_ui(self):
        """
        Init specific information about the UI that is shared between all of
        the combo boxes
        """
        self.layout = QtGui.QVBoxLayout(self)
        self.label = QtGui.QLabel()
        self.comboB = QtGui.QComboBox()
        self.layout.addWidget(self.label)
        self.layout.addWidget(self.comboB)
        self.setLayout(self.layout)
    # end init_ui
# end ComboObj


class ComboObjScene(ComboObj):
    """
    The scene folder combo box needs to have its items populated by whatever is
    in consts.SCENE_FOLDER_DIR and so a sub-class is used. After the scenes are
    created, the first scene is selected or the user's preferred scene.
    """
    def __init__(self, label, folder):
        """
        Inits the combo box and sets a few small GUI changes

        Args:
            label (str): The title of the combo box (will be placed above the box)
            folder (str): The full path location to a directory
        """
        super(ComboObjScene, self).__init__()

        # init scene info
        self.label.setText(label)
        self.folder = folder
        if not os.path.isdir(self.folder):
            raise EnvironmentError("Input: {} is not a valid "
                                   "folder".format(self.folder))
        self.add_combobox_items()
    # end __init__

    def add_combobox_items(self):
        """
        Populates the combo-box on creation with folders located under
        self.folder
        """
        for f in os.listdir(self.folder):
            if os.path.isdir(os.path,join(self.folder, f)):
                # append folder to combobox. Note: addItems also takes a list
                self.comboB.addItems(f)
    # end add_combobox_items
# end ComboObjScene


class ComboObjShot(ComboObjScene):
    """
    The shot folder combo box needs to have its items populated by whatever is
    currently active in the scene combo box. Its contents are initialized
    afterwards because of this. Only the shots that exist for a given scene
    will be listed.
    """
    def __init__(self, label, folder):
        """
        Init the combo box

        Args:
            label (str): The text that will be displayed over the combo box
            folder (str): The scene folder which will be used to dynamically
                          generate the list of shots
        """
        super(ComboObjShot, self).__init__(label, folder)
    # end __init__

    def add_combobox_items_dyn(self, value):
        """
        This method will get the current scene combo box information and parse
        it as a partial match to determine what shots need to be added into the
        shot combo box.

        .. TODO::
         Make the combo box clear all of its items and repopulate every time
         the scene combo box changes

        Args:
            value (str): The current value active in the scene combo box
        :type value: str
        """
        currentScene = value
        match = re.match(consts.SHOT_MATCH_RE, value)
        matchDict = match.itergroups()
        matchShot = matchDict.get(consts.SHOT_KEY, None)

        shotRList = []
        # Get list of shot letters based on the input scene number
        for f in os.listdir(self.folder):
            matchFolder = re.match(consts.SHOT_MATCH_RE, f)
            if os.path.isdir(os.path,join(self.folder, f)) and \
                    matchFolder is not None:
                matchFDict = matchFolder.itergroups()
                matchFShot = matchFDict.get(consts.SHOT_KEY, None)
                matchFShotR = matchFDict.get(consts.SHOT_REVISION_KEY, None)
                if matchFShot == matchShot and matchFShotR not in shotRList:
                    shotRList.append(matchShotR)
    # end add_combobox_items_dyn
# end ComboObjShot


if __name__ == "__main__":
    print(__doc__)
