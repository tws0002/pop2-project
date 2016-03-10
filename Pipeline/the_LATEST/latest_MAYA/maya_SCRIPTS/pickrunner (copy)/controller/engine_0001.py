#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
An enhanced, lightwight, user-defined hierarchy between nodes in Maya
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
sys.path.append("F:\transfer\to_monty\the_LATEST\latest_MAYA\maya_SCRIPTS\pickrunner")
# sys.path.append("F:\transfer\to_monty\the_LATEST\sys_PY\py_MODULES")

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
import controller.membership as membership
import controller.engine as engine
import view.basegui as basegui


class Window(QtGui.QMainWindow, basegui.Ui_MainWindow):
    def __init__(self):
        super(Window, self).__init__()
        self.setupUi(self)
        self.init_defaults()
        self.init_ui()
        self.triggers()
    # end __init__
    
    def init_ui(self):
        """
        Inits the default behavior of the GUI
        """
        # diectional buttons
        self.up_pb.setStyleSheet(self.buttonStyle)
        self.left_pb.setStyleSheet(self.buttonStyle)
        self.down_pb.setStyleSheet(self.buttonStyle)
        self.right_pb.setStyleSheet(self.buttonStyle)        
        
        # lower lineEdits
        self.up_le.setEnabled(False)
        self.left_le.setEnabled(False)
        self.down_le.setEnabled(False)
        self.right_le.setEnabled(False)
    # end init_ui

    def init_defaults(self):
        self.db = {}
        self.assignDirections = False
        self.loadedNode = None
        self.buttonStyle = "background-color: #e6ffff; border: 1px solid black; padding: 4px;"        
        self.buttonStyleOn = "background-color: #ccffcc;"
        self.buttonAssignOff = "background-color: #ffcccc;"
        self.buttonError = "background-color: red;"
        self.motor = engine.MotorMaya()
    # end init_defaults
    
    def triggers(self):
        """
        Creates the interactivity functionality of the GUI
        """
        self.assignLayout_pb.clicked.connect(self.toggle_pickwalk_directions)
        addAttrLeft = functools.partial(engine.MotorMaya, direction="left")
        self.left_pb.clicked.connect(self.add_attr)
        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.reject)
    # end triggers

    def reject(self):
        """
        Executes when the user wants to close the current window class
        """
        sys.exit()
    # end reject    

    def toggle_pickwalk_directions(self):
        """
        Turns on/off the ability to add buttons to the current node loaded
        """
        if not self.assignDirections:
            # enable the buttons
            self.assignDirections = True            
            self.assignLayout_pb.setStyleSheet(self.buttonStyleOn)
            self.up_pb.setStyleSheet(self.buttonStyleOn)
            self.left_pb.setStyleSheet(self.buttonStyleOn)
            self.down_pb.setStyleSheet(self.buttonStyleOn)
            self.right_pb.setStyleSheet(self.buttonStyleOn) 
            currentSelection = self.motor.get_selection()
            if currentSelection == 0:
                self.loadSelection_pb.setStyleSheet(self.buttonError)
                self.loadedNode = None
            else:
                self.loadedNode = currentSelection[-1]
        else:
            # disable the buttons
            self.assignDirections = False
            self.assignLayout_pb.setStyleSheet(self.buttonAssignOff)
            self.up_pb.setStyleSheet(self.buttonStyle)
            self.left_pb.setStyleSheet(self.buttonStyle)
            self.down_pb.setStyleSheet(self.buttonStyle)
            self.right_pb.setStyleSheet(self.buttonStyle)
            self.loadSelection_pb.setStyleSheet(self.buttonStyle)
    # end toggle_pickwalk_directions
# end Windows 


def show_gui():
    """
    Shows the main GUI to the application
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