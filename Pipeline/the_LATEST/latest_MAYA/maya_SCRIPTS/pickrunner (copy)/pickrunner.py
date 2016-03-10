#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
An enhanced, lightwight, user-defined hierarchy between nodes in Maya

.. considerations::
    The scriptJob that lives and dies with the current window instance could
    be more efficiently created if it were created/kill depending on assign
    mode and not simply with the current window instance (like it is now)
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import functools

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
# :AUTHORNOTE: :DELETELATER: :START:
# try:
#     reload(pickrunner)
# except NameError:
#     pass
# except:
#     raise
    
# try:
#     reload(app)
#     reload(membership)
#     reload(engine)
#     reload(basegui)
# except NameError:
#     controller.application as app
#     controller.membership as membership
#     controller.engine as engine
#     view.basegui as basegui
# except:
#     raise
# :AUTHORNOTE: :DELETELATER: :END:    

import controller.application as app
import controller.membership as membership
import controller.engine as engine
import view.basegui as basegui


class Window(QtGui.QMainWindow, basegui.Ui_MainWindow):
    """
    The window that creates the main GUI, which provides the user an interface
    """
    def __init__(self, parent=None):
        """
        Separate calls are used to define default data in the __init__, as well
        as UI default elements and triggers (aka interactivity)

        Args:
            parent (QtGui.QApplication): The current window
                                         instance/application, if applicable
        """
        super(Window, self).__init__(parent)
        self.setupUi(self)
        self.init_defaults()
        self.init_ui()
        self.triggers()
    # end __init__

    def init_ui(self):
        """
        Inits the default behavior of the directional buttons get certain
        colors and certain elements are locked off by default.
        """
        self.swapObjs_cb.setChecked(True)

        # directional buttons
        self.up_pb.setStyleSheet(self.buttonStyle)
        self.left_pb.setStyleSheet(self.buttonStyle)
        self.down_pb.setStyleSheet(self.buttonStyle)
        self.right_pb.setStyleSheet(self.buttonStyle)
        self.up_pbPrefix = "up"
        self.left_pbPrefix = "left"
        self.down_pbPrefix = "down"
        self.right_pbPrefix = "right"

        # lower lineEdits
        self.up_le.setEnabled(False)
        self.left_le.setEnabled(False)
        self.down_le.setEnabled(False)
        self.right_le.setEnabled(False)

        # the QTreeWidget settings
        self.itemModel = QtGui.QStandardItemModel(0, 4)
        self.treeView_tw.setModel(self.itemModel)
        self.itemModel.setHeaderData(0, QtCore.Qt.Horizontal, 'Node')
        self.itemModel.setHeaderData(1, QtCore.Qt.Horizontal, 'Direction')
        self.itemModel.setHeaderData(2, QtCore.Qt.Horizontal, 'Depth')
        self.itemModel.setHeaderData(3, QtCore.Qt.Horizontal, '')  # blank space
    # end init_ui

    def init_defaults(self):
        """
        Data-specific defaults (not related to the direct presentation of GUI
        elements) are initialized here
        """
        self.db = {}
        self.assignDirections = False
        self.loadedNode = None
        self.buttonStyle = "background-color: #e6ffff; "\
                           " border: 1px solid black; padding: 4px;"
        self.buttonStyleOn = "background-color: #ccffcc;"
        self.buttonAssignOff = "background-color: #ffcccc;"
        self.buttonError = "background-color: red;"
        self.membership = membership.MembershipMaya()
        self.app = app.ApplicationMaya()
    # end init_defaults

    def triggers(self):
        """
        Creates the interactivity functionality of the GUI
        """
        # The Button View triggers
        self.assignLayout_pb.clicked.connect(self.toggle_pickwalk_directions)
        self.loadSelection_pb.clicked.connect(self.load_selected)
        trigger_up = functools.partial(self.trigger_button, direction="up")
        trigger_left = functools.partial(self.trigger_button, direction="left")
        trigger_down = functools.partial(self.trigger_button, direction="down")
        trigger_right = functools.partial(self.trigger_button, direction="right")

        self.up_pb.clicked.connect(trigger_up)
        self.left_pb.clicked.connect(trigger_left)
        self.down_pb.clicked.connect(trigger_down)
        self.right_pb.clicked.connect(trigger_right)

        # Maya scriptJob that updates the GUI whenever something is selected
        self.sJ = functools.partial(self.script_job_update_from_selection)
        self.selectionScriptJob = self.app.init_gui_selection(self.sJ, True)

        # Window Shortcuts
        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.reject)
    # end triggers

    def foo(self, window):
        """
        While the window exists, if selected nodes have metadata information,
        that data is automatically updated in the GUI

        .. note::
            If the window is in assign-mode, this script Job
        """
        print window

    def script_job_update_from_selection(self):
        """
        While the window exists, if selected nodes have metadata information,
        that data is automatically updated in the GUI

        .. note::
            If the window is in assign-mode, this script Job
        """
        if self.assignDirections:
            return

        selectedObj = self.app.get_selection()
        if len(selectedObj) != 1:
            return
        selectedObj = selectedObj[0]

        motor = engine.MotorMaya(selectedObj) 
        if motor.has_metadata():
            # redraw the GUI for the new information
            self.loadedNode = motor
            self.draw_gui()
    # end script_job_update_from_selection

    def reject(self):
        """
        Executes when the user wants to close the current window class.
        A scriptJob that is instantiated on load is killed before exiting.
        """
        if self.app.has_gui_selection(self.selectionScriptJob):
            self.app.kill_gui_selection(self.selectionScriptJob)
        sys.exit()
    # end reject

    def draw_button_view(self):
        """
        Whenever the GUI needs to be updated with the latest values,
        the following function must be run
        """
        motor = self.loadedNode
        # motor = engine.MotorMaya(app.ApplicationMaya().get_selection()[0])
        if not motor.has_metadata():
            motor.init_metadata_proxy()

        prefixes = ["up: ", "left: ", "down: ", "right: "]
        directions = [motor.members.up, motor.members.left, 
                      motor.members.down, motor.members.right]
        guiDirections = [self.up_le, self.left_le, self.down_le, self.right_le] 
        [guiDirections[i].setText(prefixes[i] + x.metadataNode.linkedNodeName) \
         if x is not None else guiDirections[i].setText(prefixes[i]) \
         for i, x in enumerate(directions)]
    # end draw_button_view

    def draw_tree_widget(self):
        """
        Updates the tree view by going through all of the nodes that are
        connected via the master metadata node
        """
        masterMetadata = membership.MasterMetadataObjectMaya()
        outC = self.app.get_outgoing_connections(masterMetadata)
        unpackedInfo = self.app.get_connection_info(outC)
        for node, info in unpackedInfo:
            # create nested information here
            # make a row based on the keys of the dictionary information
            #
            for direction in info["direction"]:
                self.treeView_tw.addItem([node, direction, info["depth"] + 1])
    # end draw_tree_widget

    def draw_gui(self):
        """
        Whenever the GUI needs to be updated with the latest values,
        the following function must be run
        """
        self.draw_button_view()
        # self.draw_tree_widget()
        pass
    # end draw_gui

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

            # re-init scriptJob, if it was deleted previously
            if not self.app.has_gui_selection(self.selectionScriptJob):
                self.selectionScriptJob = self.app.init_gui_selection(self.sJ)
        else:
            # disable the buttons
            self.assignDirections = False
            self.assignLayout_pb.setStyleSheet(self.buttonAssignOff)
            self.up_pb.setStyleSheet(self.buttonStyle)
            self.left_pb.setStyleSheet(self.buttonStyle)
            self.down_pb.setStyleSheet(self.buttonStyle)
            self.right_pb.setStyleSheet(self.buttonStyle)
            self.loadSelection_pb.setStyleSheet(self.buttonStyle)

            # delete scriptJob, temporarily
            self.app.kill_gui_selection(self.selectionScriptJob)
    # end toggle_pickwalk_directions

    def load_selected(self):
        """
        When Load Selection button is clicked, the following method is executed.
        This function will ask for the current selection and load it for the
        GUI to use/modify if the selection is determined as valid
        """
        # get selection and make sure it's valid
        selection = self.app.get_selection()
        if len(selection) == 0:
            raise ValueError('Nothing was selected')
        elif len(selection) > 1:
            raise ValueError('Select and "Load Selection" one object at at time')

        temp = selection[0]
        if not self.membership.is_valid_loaded_object(temp):
            # checks to make sure that the loaded object is OK to use
            self.loadSelection_pb.setStyleSheet(self.buttonError)
            raise ValueError("Object: {} was not a valid object "
                             "for loading.".format(temp))

        self.loadedNode = engine.MotorMaya(temp)
        if not self.loadedNode.has_metadata():
            self.loadedNode.init_metadata_proxy()
        self.loadSelection_pb.setStyleSheet(self.buttonStyleOn)

        # Setup the loaded node or acquire its metadata
        # Get any pre-existing connections and update the GUI
        #
        self.draw_gui()
    # end load_selected

    def trigger_button(self, direction):
        """
        Executed when the user presses a directional button. The function is a
        "one-size-fits-all" whose execution varies slightly based on the
        direction that was picked

        Args:
            direction (str): Picks a specified direction and runs either
                             assigns or selects the direction to the
                             associated object(s). Valid directions are
                             specified using self.allowedDirections
        """
        if direction.lower() not in self.app.allowedDirections:
            raise ValueError("Direction: {d!r} is not valid. Please choose "
                             "one from list, {l}".format(l=motor.allowedDirections,
                                                         d=direction))

        if self.assignDirections:
            # Get selection
            motor = self.loadedNode
            if not motor.has_metadata():
                motor.init_metadata_proxy()  # make a metadata node

            selection = self.app.get_selection()
            if len(selection) == 0:
                raise ValueError("Could not assign, selection is empty")
            elif len(selection) > 1:
                raise ValueError("Could not assign, selection got "
                                 "more than one object")
            selection = engine.MotorMaya(selection[0])
            if not selection.has_metadata():
                selection.init_metadata_proxy()  # make a metadata node

            if selection == motor:
                print "User attempted to assign an object a pickrunner "\
                      "direction to itself. Nothing to do (Skipping)"
                return

            # Parse the direction
            if direction == "up":
                motor.members.up = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.down = motor
            elif direction == "left":
                print selection
                motor.members.left = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.right = motor
            elif direction == "down":
                motor.members.down = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.up = motor
            elif direction == "right":
                print selection
                motor.members.right = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.left = motor

            # update GUI with the new info
            self.draw_gui()
        else:
            # Check direction for validity
            motor = engine.MotorMaya(self.app.get_selection()[0])
            direction = direction.lower()
            if direction not in motor.allowedDirections:
                raise RuntimeError("Something went wrong. GUI got an "
                                   "invalid direction")

            # Parse the direction
            elif direction == "up":
                member = motor.members.up
            elif direction == "left":
                member = motor.members.left
            elif direction == "down":
                member = motor.members.down
            elif direction == "right":
                member = motor.members.right

            # select the object
            if member is not None:
                # Get selected object's movement information
                objName = member.metadataNode.linkedNodeName
                self.app.select(objName)
                motor = engine.MotorMaya(objName)
                self.loadedNode = motor
                self.draw_button_view()
    # end trigger_up_button
# end Windows


def show_gui():
    """
    Shows the main GUI to the application
    """
    application = QtGui.QApplication.activeWindow()
    if application is None:
        application = QtGui.Qapp.instance()
    if application is None:
        application = QtGui.QApplication(sys.argv)

    window = Window(application)
    window.show()
    # sys.exit(app.exec_())
# end show_gui


def main():
    show_gui()
# end main


if __name__ == "__main__":
    main()