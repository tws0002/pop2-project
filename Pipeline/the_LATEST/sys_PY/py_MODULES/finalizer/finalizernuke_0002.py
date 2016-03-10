#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
The finalizer for Nuke
"""

# IMPORT STANDARD LIBRARIES
import sys

# IMPORT THIRD-PARTY LIBRARIES
try:
    import nuke
    import nukemanager
except ImportError:
    print("Not in a proper nuke environment")

import PySide.QtCore as QtCore
import PySide.QtGui as QtGui

# IMPORT LOCAL LIBRARIES
import view.nuke_finalizer_frame_select_main as finalizernukeui


class BaseWindow(QtGui.QMainWindow, finalizernukeui.Ui_MainWindow):
    def __init__(self, parent=None):
        super(BaseWindow, self).__init__(parent)
        self.startFrame = 1
        self.endFrame = 24

        self.setupUi(self)  # init the parent UI
        self.init_ui()

        self.triggers()
        self.spinbox_status()  # run once in the init
    # end __init__

    def init_ui(self):
        """
        Inits application-specific information into the UI
        """
        self.setWindowTitle("Select your output frame range")
        self.startFrame_sb.setValue(self.startFrame)
        self.endFrame_sb.setValue(self.endFrame)
    # end init_ui

    def triggers(self):
        """
        Sets up the triggers of the GUI
        """
        self.globalFrameRange_cb.stateChanged.connect(self.spinbox_status)
    # end triggers

    def spinbox_status(self):
        """
        Enables/Disables spinboxes in the GUI, depending on a checkbox
        """
        enableStatus = self.globalFrameRange_cb.isChecked()
        self.startFrame_sb.setEnabled(not enableStatus)
        self.endFrame_sb.setEnabled(not enableStatus)
    # spinbox_status

    def accept(self):
        """
        Runs the execution of my main script
        """
        raise NotImplementedError("BaseWindow does not have a proper accept method")
    # end accept

    def reject(self):
        """
        Cancels and closes the current window
        """
        sys.exit()
    # end reject
# end BaseWindow


def WindowNuke(BaseWindow):
    def __init__(self, parent=None):
        super(WindowNuke, self).__init__(parent)
        self.projectRoot = nuke.root()
        self.startFrame = self.projectRoot.knob("first_frame").getValue()
        self.endFrame = self.projectRoot.knob("last_frame").getValue()
    # end __init__

    def accept(self):
        """
        Runs the execution of my main script
        """
        nukemanager.finalize_shot(nuke.selectedNodes())
    # end accept
# end WindowNuke


def show_gui():
    app = QtGui.QApplication.instance()
    if app is None:
        app = QtGui.QApplication.activeWindow()
    if app is None:
        app = QtGui.QApplication(sys.argv)

    window = BaseWindow()
    window.show()
    # sys.exit(app.exec_())
# end show_gui


if __name__ == "__main__":
    show_gui()
    # print(__doc__)
