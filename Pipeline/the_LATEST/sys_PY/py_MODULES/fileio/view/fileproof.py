#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
GUI
"""

# IMPORT STANDARD LIBRARIES
import sys

# IMPORT THIRD-PARTY LIBRARIES
try:
    import PyQt.QtCore as QtCore
    import PyQt.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

# IMPORT LOCAL LIBARIES
import basefileproof as basefileproof
from fileio.controller.checkout import FileCheckout


class Window(QtGui.QMainWindow, basefileproof.Ui_MainWindow):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        self.conditionRows = []
        self.setupUi(self)
        self.triggers()
    # end __init__

    def setupUi(self, parent):
        super(Window, self).setupUi(self)
        fileIO = FileCheckout("null")
        for condition in fileIO.checkoutList:
            row = self.add_condition_row(condition)
            row.resize(row.frameGeometry().width(), 20)
            currentWindowSize = (self.frameGeometry().width(), self.frameGeometry().height())
            newHeight = currentWindowSize[1] + row.frameGeometry().height()
            newMinHeight = currentWindowSize[1] + 20
            self.resize(currentWindowSize[0], newHeight)
            self.setMinimumSize(QtCore.QSize(currentWindowSize[0], newMinHeight))

    # end setupUi

    def triggers(self):
        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.close)
    # end triggers

    def add_condition_row(self, label):
        row = CheckRow()
        self.gridLayout.addLayout(row.layout, self.gridLayout.rowCount(), 1, 1, 1)
        row.condition_l.setText(label)
        self.conditionRows.append(row)
        return row
    # end add_condition_row

    def execute(self):
        for condition in self.conditionRows:
            condition.icon.setIconTo("Done!")
    # end execute

    def close(self):
        sys.exit()
    # end close
# end Window


class CheckRow(QtGui.QWidget):
    def __init__(self):
        super(CheckRow, self).__init__()
        self.init_ui()
    # end __init__

    def init_ui(self):
        self.layout = QtGui.QHBoxLayout()
        self.condition_l = QtGui.QLabel()
        font = QtGui.QFont()
        font.setFamily("Ubuntu")
        font.setPointSize(14)
        self.condition_l.setFont(font)
        self.progressBar = QtGui.QProgressBar()
        self.progressBar.hide()
        checkboxPath = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/fileio/view/icons/checkbox_50x50.png"
        self.icon = QtGui.QLabel()
        self.icon.setPixmap(checkboxPath)
        self.icon.hide()
        self.layout.addWidget(self.condition_l)
        self.layout.addWidget(self.progressBar)
        self.layout.addWidget(self.icon)
        self.setMinimumSize(QtCore.QSize(0, 20))
    # end init_ui
# end CheckRow


def show_gui():
    """
    Shows the GUI (currently set to show the GUI if the user passes in no
    arguments or the GUI option within the command-line)
    """
    app = QtGui.QApplication.instance()
    if app is None:
        app = QtGui.QApplication.activeWindow()
    if app is None:
        app = QtGui.QApplication(sys.argv)

    window = Window()
    window.show()
    sys.exit(app.exec_())
# end show_gui


if __name__ == "__main__":
    show_gui()
