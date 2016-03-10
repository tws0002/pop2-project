#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
"""

# IMPORT STANDARD LIBRARIES
import sys

# IMPORT THIRD-PARTY LIBRARIES
try:
    import PyQt4.QtCore as QtCore
    import PyQt4.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

# IMPORT LOCAL LIBRARIES
import basegui


class Window(QtGui.QMainWindow, basegui.Ui_MainWindow):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        self.setupUi(self)
    # end __init__
# end Window


def show_gui():
    """
    Acquires the current window instance (if one exists) and displays the GUI
    """
    app = QtGui.QApplication.activeWindow()
    if app is None:
        app = QtGui.QApplication.instance()
    if app is None:
        app = QtGui.QApplication(sys.argv)

    window = Window()
    window.show()
    sys.exit(app.exec_())
# end show_gui


def main():
    show_gui()
# end main


if __name__ == "__main__":
    main()
