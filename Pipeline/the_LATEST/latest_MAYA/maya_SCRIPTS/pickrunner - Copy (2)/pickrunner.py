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
    # from PyQt4.QtCore import pyqtSignal as Signal
    # from PyQt4.QtCore import pyqtSlot as Slot    
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
    # from PySide.QtCore import Signal as Signal
    # from PySide.QtCore import Slot as Slot
except:
    raise

import pymel.core as pm

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
# reload(basegui)
import view.basegui as basegui


class ClickableLineEdit(QtGui.QLineEdit):
    # def __init__(self, parent):
    #     super(MyLineEdit, self).__init__(parent)
    #     self.parentWindow = parent
    # # end __init__

    # def mousePressEvent(self, event):
    #     print 'forwarding to the main window'
    #     self.parentWindow.mousePressEvent(event)
    # # end mousePressEvent        

    # mousePressed = QtCore.pyqtProperty(QtGui.QMouseEvent) 

    def __init__(self, parent):
        super(ClickableLineEdit, self).__init__(parent)

    def mousePressEvent(self, event):
        # self.mousePressed.emit(event)
        self.emit(QtCore.SIGNAL("clicked()"))  # send click signal

        self.menu = QtGui.QMenu(self)
        deleteAction = QtGui.QAction('Delete Metadata', self)
        deleteAction.triggered.connect(self.delete_node)
        # disconnectAction = QtGui.QAction('Disconnect Attribute', self)
        # disconnectAction.triggered.connect(self.disconnect_node)
        # self.menu.addAction(disconnectAction)
        self.menu.addAction(deleteAction)
        self.menu.popup(QtGui.QCursor.pos())
    # mousePressEvent

    def delete_node(self):
        prefix, text = self.get_text(self.text())
        motor = engine.MotorMaya(text)
        motor.delete()

        # remove the node's name from the current ClickableLineEdit
        self.setText(prefix)
    # end delete_node

    def disconnect_node(self):
        prefix, text = self.get_text(self.text())
        if text == "":
            return  # do nothing


        motor = engine.MotorMaya(text)
        dest = motor.nodeName + ".message"
        src = pm.connectionInfo(dest, dfs=True)
        attr = app.ApplicationMaya.scriptPrefix + prefix.rstrip(":")
        for s in src:
            if s.endswith(attr):
                src = s
                break
        else:
            raise RuntimeError("Ran function: disconnect_node, assuming a valid"
                               " connection could be found but found none")
        pm.setAttr(src, l=False)
        pm.disconnectAttr(dest, src)
        # pm.setAttr(src, "")        
        # pm.setAttr(src, l=True)
        # self.setText(prefix)
        # motor.disconnect(motor.nodeName)

        # if motor.has_metadata():
        #     # disconnect the detected metadata
        #     pm.disconnectAttr(motor.nodeName + ".message", 
        #                       self.text() + "." + prefix.split(":")[0])
        #     # print getattr(motor.members, prefix.split(":")[0])
        #     self.setText(prefix)
    # end disconnect_node

    def get_text(self, text):
        text = str(text)
        # changes a string like "up: nodeName" to "nodeName"
        prefix, text = text.split(":")
        prefix += ":"
        text = text.strip()
        return prefix, text
    # end get_text
# end ClickableLineEdit


class ClickableTreeView(QtGui.QTreeView):
    def __init__ (self, parent=None):
        super(ClickableTreeView, self).__init__(parent)
        self.pressed.connect(self.click_event)
    # end __init__

    def click_event(self, currentQModelIndex):
        # Use QModelIndex to show current data pressed
        # print currentQModelIndex.column(), currentQModelIndex.row()
        # 
        # Only consider information from the first column
        if currentQModelIndex.column() != 0:
            return  # exit

        item = currentQModelIndex.data()   # .toString()
        self.app = app.ApplicationMaya()

        try:
            self.app.select(item.strip())
        except pm.MayaNodeError:
            self.app.select(cl=True)
        # Also can implement your QStandardItemModel here
        # currentQStandardItemModel = currentQModelIndex.model()
    # end click_event
# end ClickableTreeView


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

        # default step size for movement
        self.step_sb.setValue(1)
        self.step_sb.setMinimum(0)

        # line edits (in the button view)
        [x.setEnabled(True) for x in self.buttonViewLineEditsNew]

        # Add button for deleting the current object
        self.delete_loaded_node_pb = QtGui.QPushButton()
        self.delete_loaded_node_pb.setText("Delete Loaded Selection")
        self.gridLayout_2.addWidget(self.delete_loaded_node_pb, 10, 1, 1, 1)

        # the QTreeWidget default header settings
        self.itemModel = QtGui.QStandardItemModel(0, 4)
        self.treeView_tw.setModel(self.itemModel)
        self.itemModel.setHeaderData(0, QtCore.Qt.Horizontal, 'Node')
        self.itemModel.setHeaderData(1, QtCore.Qt.Horizontal, 'Direction')
        self.itemModel.setHeaderData(2, QtCore.Qt.Horizontal, 'Number Of Items')
        self.itemModel.setHeaderData(3, QtCore.Qt.Horizontal, '')  # blank space
    # end init_ui

    def print_text(self):
        print "ASDAS"

    # def mousePressEvent(self, event):
    #     print "Main Widget Mouse Press"
    #     super(Window, self).mousePressEvent(event)

    # def eventFilter(self, obj, event):
    #     # you could be doing different groups of actions
    #     # for different types of widgets and either filtering
    #     # the event or not.
    #     # Here we just check if its one of the layout widgets
    #     print "Widget click", obj
    #             # if I returned True right here, the event
    #             # would be filtered and not reach the obj,
    #             # meaning that I decided to handle it myself

    #     # regardless, just do the default
    #     return super(Window, self).eventFilter(obj, event)


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

        # replace specified lineEdits with my version, which has click menus
        self.buttonViewLineEdits = [self.up_le, self.left_le, 
                                    self.down_le, self.right_le]
        self.buttonViewLineEditsNew = []
        for index, lineEdit in enumerate(self.buttonViewLineEdits):
            # get grid position, delete lineEdit, replace with click lineEdit
            idx = self.gridLayout_2.indexOf(lineEdit)
            if idx == -1:
                raise RuntimeError("Something went wrong. A QLineEdit from list"
                                   " {} couldn't be queried in the layout, "
                                   "{}.".format(lineEdit, self.gridLayout))
            location = self.gridLayout_2.getItemPosition(idx)
            lineEdit.deleteLater()


            lineEdit = ClickableLineEdit(self)
            self.gridLayout_2.addWidget(lineEdit, *location)
            # self.buttonViewLineEdits.pop(index)
            self.buttonViewLineEditsNew.append(lineEdit)

        # replace the default QTreeView with a clickable version
        idx = self.connectionTree_gridLayout.indexOf(self.treeView_tw)
        if idx == -1:
            raise RuntimeError("Something went wrong. A QTreeView: "
                               "{} couldn't be queried in the layout, "
                               "{}.".format(self.treeView_tw, 
                                            self.connectionTree_gridLayout))
        location = self.connectionTree_gridLayout.getItemPosition(idx)

        self.treeView_tw.deleteLater() 
        self.treeView_tw = ClickableTreeView(self)
        self.connectionTree_gridLayout.addWidget(self.treeView_tw, *location)
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
        # :TX:
        self.sJ = functools.partial(self.script_job_update_from_selection)
        self.selectionScriptJob = self.app.init_gui_selection(self.sJ, True)
        # :TX:

        self.delete_loaded_node_pb.clicked.connect(self.delete_loaded_node)
        # Window Shortcuts
        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.reject)
    # end triggers

    def eventFilter(self, obj, event):
        if obj == self.line and isinstance(event, QMouseEvent) and event.buttons() & Qt.LeftButton:
            self.lineClicked(event.pos())
            return True
        return False
    # end eventFilter

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
        # :TX:
        if self.app.has_gui_selection(self.selectionScriptJob):
            self.app.kill_gui_selection(self.selectionScriptJob)
        # :TX:
        sys.exit()
    # end reject

    def draw_button_view(self,):
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
        guiDirections = self.buttonViewLineEditsNew
        [guiDirections[i].setText(prefixes[i] + x.metadataNode.linkedNodeName) \
         if x is not None else guiDirections[i].setText(prefixes[i]) \
         for i, x in enumerate(directions)]
    # end draw_button_view

    def draw_tree_widget(self):
        """
        Updates the tree view by going through all of the nodes that are
        connected via the master metadata node
        """
        # masterMetadata = membership.MasterMetadataObjectMaya()
        # outC = self.app.get_outgoing_connections(masterMetadata)
        # unpackedInfo = self.app.get_connection_info(outC)
        # for node, info in unpackedInfo:
        #     # create nested information here
        #     # make a row based on the keys of the dictionary information
        #     #
        #     for direction in info["direction"]:
        #         self.treeView_tw.addItem([node, direction, info["depth"] + 1])
        motor = engine.MotorMaya()
        connections = motor.get_object_hierarchy()

        if connections is None:
            # clear the graph and exit script prematurely
            root = tree.invisibleRootItem()
            for item in tree.selectedItems():
                (item.parent() or root).removeChild(item)
            return

        model = QtGui.QStandardItemModel()
        model.setHorizontalHeaderLabels(['Node', 'Direction', 'Number of Items'])
        self.treeView_tw.setModel(model)

        treeWidgetsToAdd = []
        for connection in connections:
            key = connection[0]
            items = connection[1]
            # treeWidgetsToAdd.append(QtGui.QTreeWidgetItem("1"))  # create QTreeWidgetItem's and append them
            meta = membership.MetadataObjectMaya(self.app.metadataNodeType, key)
            name = meta.get_name_from_uuid(meta.uuid)
            parent = QtGui.QStandardItem(unicode(name))

            # widget = QtGui.QTreeWidgetItem(self.treeView_tw, [key, "", items["items"]])
            # treeWidgetsToAdd.append(parent)

            for direction in self.app.allowedDirections:
                # widget = QtGui.QTreeWidgetItem(self.treeView_tw, [key, direction, ""])
                name = ""
                if items.get(direction, None) is not None:
                    meta = membership.MetadataObjectMaya(self.app.metadataNodeType, 
                                                         items[direction])
                    name = meta.get_name_from_uuid(meta.uuid).nodeName()

                k = QtGui.QStandardItem(name)
                d = QtGui.QStandardItem(direction)
                depth = QtGui.QStandardItem("")
                parent.appendRow([k, d, depth])
            treeWidgetsToAdd.append(parent)
        treeWidgetsToAdd = sorted(treeWidgetsToAdd, key=lambda x: x.text())
        [model.appendRow(x) for x in treeWidgetsToAdd]
        # self.treeView_tw.addTopLevelItems(treeWidgetsToAdd)
        # for key, items in connections.iteritems():
        #     for k, i in items.iteritems():
        #         print k, i
            # for k, i in items.iteritems():
            #     QtGui.QTreeWidgetItem(self.treeView_tw, [key, k, items["items"]])
        # self.treeView_tw.addItem([node, direction, info["depth"] + 1])
    # end draw_tree_widget

    def draw_gui(self):
        """
        Whenever the GUI needs to be updated with the latest values,
        the following function must be run
        """
        self.draw_button_view()
        self.draw_tree_widget()
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
            # :TX:
            if not self.app.has_gui_selection(self.selectionScriptJob):
                self.selectionScriptJob = self.app.init_gui_selection(self.sJ)
            # :TX:                
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
            # :TX:
            self.app.kill_gui_selection(self.selectionScriptJob)
            # :TX:
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

    def delete_loaded_node(self):
        """

        .. note::
            self.draw_gui() will force a new node to be created (so metadata 
            is never truly 100% removed)
        """
        motor = engine.MotorMaya(self.loadedNode.currentNode)
        motor.delete()
        # self.draw_gui()
    # end delete_loaded_node

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
                motor.members.left = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.right = motor
            elif direction == "down":
                motor.members.down = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.up = motor
            elif direction == "right":
                motor.members.right = selection
                if self.swapObjs_cb.isChecked():
                    selection.members.left = motor

            # update GUI with the new info
            self.draw_gui()
        else:
            # Check direction for validity
            motor = engine.MotorMaya(self.app.get_selection()[0])
            member = motor.walk(direction, self.step_sb.value())

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

    # :TX:
    # window.draw_tree_widget()
    # :TX:
    # sys.exit(app.exec_())
# end show_gui


def main():
    show_gui()
# end main


if __name__ == "__main__":
    main()
