#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
###############################################################################
# The MIT License (MIT) Copyright (c) 2016 Colin Kennedy                      #
#                                                                             #
# Permission is hereby granted, free of charge, to any person obtaining a     #
# copy of this software and associated documentation files (the "Software"),  #
# to deal in the Software without restriction, including without limitation   #
# the rights to use, copy, modify, merge, publish, distribute, sublicense,    #
# and/or sell copies of the Software, and to permit persons to whom the       #
# Software is furnished to do so, subject to the following conditions:        #
#                                                                             #
# The above copyright notice and this permission notice shall be included in  #
# all copies or substantial portions of the Software.                         #
#                                                                             #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         #
# DEALINGS IN THE SOFTWARE.                                                   #
###############################################################################

Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Pickrunner creates a way to define arbitrary relationships between nodes in
Autodesk Maya using PyMEL/python. It has a GUI and GUI-less mode and can be
sourced into rigs/scriptJobs/scriptNodes for added automation

.. considerations::
    The scriptJob that lives and dies with the current window instance could
    be more efficiently created if it were created/kill depending on assign
    mode and not simply with the current window instance (like it is now)

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
pickrunner.py
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import functools
from collections import defaultdict

# IMPORT THIRD-PARTY LIBRARIES
try:
    import PyQt4.QtCore as QtCore
    import PyQt4.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

import pymel.core as pm

# IMPORT LOCAL LIBRARIES
import model.header as header
import controller.application as app
import model.membership as membership
import controller.engine as engine
import controller.natsort.natsort as natsort
import view.basegui as basegui


__author__ = header.__author__
__copyright__ = header.__author__
__license__ = header.__license__
__version__ = header.__version__
__email__ = header.__email__
__status__ = header.__status__


class ClickableLineEdit(QtGui.QLineEdit):
    """
    A standard QtGui.QLineEdit with some functions for when it's clicked on.
    Currently, it creates a QMenu that allows the user to delete any node that
    the ClickableLineEdit is referencing
    """
    def __init__(self, parent):
        super(ClickableLineEdit, self).__init__(parent)
    # end __init__

    def mousePressEvent(self, event):
        """
        Args:
            event (<QtGui.QEvent>): Built-in method to PyQt4/PySide. Executes
                                    whenever the user left-clicks
                                    over the given QObject
        """
        self.emit(QtCore.SIGNAL("clicked()"))  # send click signal

        self.menu = QtGui.QMenu(self)
        deleteAction = QtGui.QAction('Delete Metadata', self)
        deleteAction.triggered.connect(self.delete_node)
        self.menu.addAction(deleteAction)
        self.menu.popup(QtGui.QCursor.pos())
    # mousePressEvent

    def delete_node(self):
        """
        Gets the current ClickableLineEdit's text which expects to be
        "{direction}: {nodeName}" (example: "up: pSphere1") and
        then deletes that node's metadata
        """
        prefix, text = self.get_text(self.text())
        motor = engine.MotorMaya(text)
        motor.delete()

        # remove the node's name from the current ClickableLineEdit
        self.setText(prefix)
    # end delete_node

    def disconnect_node(self):
        """
        Gets the current ClickableLineEdit's text which expects to be
        "{direction}: {nodeName}" (example: "up: pSphere1") and
        then gets the connection of the currently loaded node in the GUI and
        separates the node's metadata
        """
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
    # end disconnect_node

    def get_text(self, text):
        """
        Parses the text in the current ClickableLineEdit to be used in other
        functions such as self.disconnect_node and self.delete_node

        Args:
            text (str or unicode): The text from the ClickableLineEdit to parse.

        Returns:
            tuple: Outputs the text, now split into a tuple with two indexes,
                   separated by the input text's ":" character
        """
        text = str(text)
        # changes a string like "up: nodeName" to "nodeName"
        prefix, text = text.split(":")
        prefix += ":"
        text = text.strip()
        return prefix, text
    # end get_text
# end ClickableLineEdit


class ClickableTreeView(QtGui.QTreeView):
    """
    A standard QtGui.QTreeView with some functions for when it's clicked on.
    Currently, it creates a QMenu that allows the user to delete any node that
    the ClickableLineEdit is referencing
    """
    def __init__ (self, parent=None):
        super(ClickableTreeView, self).__init__(parent)
        self.pressed.connect(self.click_event)
    # end __init__

    def click_event(self, currentQModelIndex):
        """
        When the QTreeView is clicked, the following function is executed. If
        the text retrieved is a valid Maya node, the node is selected. If
        the arg passed to the function is empty (they clicked a blank cell) or
        the column number is not 0 (aka the left-most column where we expect
        the names of nodes to be), the function does nothing

        Args:
            currentQModelIndex (<QtGui.QModelIndex>): The current QTreeView
                                                      context (from which we)
                                                      get column/row number and
                                                      text information
        """
        # Use QModelIndex to show current data pressed
        # print currentQModelIndex.column(), currentQModelIndex.row()
        #
        # Only consider information from the first column
        if currentQModelIndex.column() != 0:
            return  # exit


        self.itemIndex = self.selectedIndexes()[0]
        self.crawler = self.itemIndex.model().itemFromIndex(self.itemIndex)
        self.itemText = self.crawler.text()

        self.item = currentQModelIndex.data()   # .toString()
        self.app = app.ApplicationMaya()

        try:
            self.app.select(self.item.strip())
        except pm.MayaNodeError:
            self.app.select(cl=True)
        foundItems = self.find_item_in_view(self.itemText)
        self.select_items(foundItems)
    # end click_event

    def find_item_in_view(self, text, col=0):
        """
        Finds an item based on string input - looks only in the specified column

        Args:
            text (str): The search term to look for
            col (int): the column value to search within. Default is 0 (first)

        Returns:
            dict: A dictionary containing top-level indices as well as
                  any child indices of a given parent item
        """
        model = self.model()
        itemIndex = None
        numberOccurrences = {}
        for index in xrange(model.rowCount()):
            dictH = defaultdict(dict)
            item = model.item(index)

            # get parent elements that match
            row = item.row()
            col = item.column()
            if item.text() == text:
                dictH.update({"parent Indices": [(row, col)]})

            # get child elements that match
            for i in xrange(item.rowCount()-1):
                child = item.child(i, col)
                if child is not None and child.text() == text:
                    index = self.model().index(row, col)
                    dictH[(item.row(), item.column())].update({index: None})

            if dictH != {}:
                numberOccurrences.update(dictH)

        if numberOccurrences == defaultdict(dict):
            return None

        return numberOccurrences
    # end find_item_in_view

    def select_items(self, dictH, selectMode=QtGui.QItemSelectionModel.Clear):
        """
        Selects one or more items and expands parent rows

        Args:
            dictH (dict): Contains dictionaries and items that represent
                          (row, col) index pairs to select/expand
            selectMode (<QtGui.QItemSelectionModel>): The mode to select in.
                                                      Possible value list is
                                                      available in the PyQt4
                                                      documentation here
                                                      :url:`some url`
        """
        selection = self.selectionModel()
        # Expand parents if any were found at the top level
        if dictH.get("parent Indices", []) != []:
            for item in dictH["parent Indices"]:
                index = self.model().index(*item)
                self.expand(index)
                selection.select(index, selectMode)
                scrollTo = self.model().index(item[0]+1, item[1])
                self.scrollTo(scrollTo)

            del dictH["parent Indices"]

        if dictH == {}:
            # if there were no child elements, there's nothing left to do
            return

        # for key, items in dictH.iteritems():

        #     for item in items:
        #         # get the parent object and select its children
        #         selection.select(item, QtGui.QItemSelectionModel.Select)
    # end select_items
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
        self.appTitle_l.setText("PickRunner")
        # self.appSubtitle_l.setText("You must run before you can walk")
        self.appSubtitle_l.setText("Why walk when you can run?")
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

        self.delete_all_nodes_pb = QtGui.QPushButton()
        self.delete_all_nodes_pb.setText("Delete All")
        self.gridLayout_2.addWidget(self.delete_all_nodes_pb, 11, 1, 1, 1)

        # QTreeView defaults
        self.model = QtGui.QStandardItemModel(0, 4)
        self.treeView_tw.setModel(self.model)
        self.model.setHeaderData(0, QtCore.Qt.Horizontal, 'Node')
        self.model.setHeaderData(1, QtCore.Qt.Horizontal, 'Direction')
        self.model.setHeaderData(2, QtCore.Qt.Horizontal, 'Number Of Items')
        self.model.setHeaderData(3, QtCore.Qt.Horizontal, '')  # blank space
        self.treeView_tw.setAutoScroll(False)
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
                           " border: 1px solid black; padding: 4px; color: black;"
        self.buttonStyleOn = "background-color: #ccffcc; color: black;"
        self.buttonAssignOff = "background-color: #ffcccc; color: black;"
        self.buttonError = "background-color: red; color: black;"
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
        trigger_rt = functools.partial(self.trigger_button, direction="right")

        self.up_pb.clicked.connect(trigger_up)
        self.left_pb.clicked.connect(trigger_left)
        self.down_pb.clicked.connect(trigger_down)
        self.right_pb.clicked.connect(trigger_rt)

        # TreeView tab
        func = functools.partial(self.delete_node, name=self.get_tree_widget_item)
        self.delete_pb.clicked.connect(func)
        func = functools.partial(self.move_node)
        self.moveUp_pb.clicked.connect(func)
        self.search_pb.clicked.connect(self.search_tree_view)
        self.search_le.returnPressed.connect(self.search_pb.click)

        # Maya scriptJob that updates the GUI whenever something is selected
        self.sJ = functools.partial(self.script_job_update_from_selection)
        self.selectionScriptJob = self.app.init_gui_selection(self.sJ, True)

        # Misc. Deletion methods
        func = functools.partial(self.delete_node, name=self.get_loaded_node_current)
        self.delete_loaded_node_pb.clicked.connect(func)
        self.delete_all_nodes_pb.clicked.connect(self.delete_all_nodes)

        # Window Shortcuts
        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.closeEvent)
    # end triggers

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
            # redraw the button view with the current selections's information
            self.loadedNode = motor
            self.draw_button_view()
    # end script_job_update_from_selection

    def closeEvent(self, event):
        """
        Executes when the user wants to close the current window class.
        A scriptJob that is instantiated on load is killed before exiting.

        Args:
            event (<QtGui.QEvent>): Built-in method to PyQt4/PySide. Executes
                                    whenever the user attempts to exit window
        """

        self.app.kill_gui_selection(self.selectionScriptJob)
    # end closeEvent

    def draw_button_view(self):
        """
        Whenever the GUI needs to be updated with the latest values,
        the following function must be run
        """
        motor = self.loadedNode
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
        motor = engine.MotorMaya()
        connections = motor.get_object_hierarchy()

        if connections is None:
            # clear the graph and exit script prematurely
            root = tree.invisibleRootItem()
            for item in tree.selectedItems():
                (item.parent() or root).removeChild(item)
            return

        model = QtGui.QStandardItemModel()
        model.setHorizontalHeaderLabels(['Node', 'Direction',
                                         'Number of Items'])
        self.treeView_tw.setModel(model)

        treeWidgetsToAdd = []
        nodeType = self.app.metadataNodeType
        for connection in connections:
            key = connection[0]
            items = connection[1]
            meta = membership.MetadataObjectMaya(self.app.metadataNodeType, key)
            name = meta.get_name_from_uuid(meta.uuid)
            parent = QtGui.QStandardItem(unicode(name))
            parent.setEditable(False)

            for direction in self.app.allowedDirections:
                name = ""
                if items.get(direction, None) is not None:
                    meta = membership.MetadataObjectMaya(nodeType,
                                                         items[direction])
                    name = meta.get_name_from_uuid(meta.uuid).nodeName()

                k = QtGui.QStandardItem(name)
                d = QtGui.QStandardItem(direction)
                d.setEditable(False)
                depth = QtGui.QStandardItem("")
                depth.setEditable(False)
                parent.appendRow([k, d, depth])
            treeWidgetsToAdd.append(parent)

        treeWidgetsToAdd = natsort.natsorted(treeWidgetsToAdd,
                                             key=lambda x: x.text())
        [model.appendRow(x) for x in treeWidgetsToAdd]
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
            allowedDirs = motor.allowedDirections
            raise ValueError("Direction: {d!r} is not valid. Please choose "
                             "one from list, "
                             "{l!r}".format(l=allowedDirs, d=direction))

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
            #
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

    def search_tree_view(self):
        """
        Search and select item(s) in the tree view based on the value passed
        though self.search_le
        """
        text = self.search_le.text()
        items = self.treeView_tw.find_item_in_view(text)
        self.treeView_tw.select_items(items, QtGui.QItemSelectionModel.Select)
    # end search_tree_view

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
            raise ValueError('Select and "Load Selection" '
                             'one object at at time')

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

    def get_tree_widget_item(self):
        """
        Gets the currently selected item from the QTreeView within the GUI

        Returns:
            str: The string which returns from QtGui.QStandardItem.text()
                 (which, in this case, is the currently selected item)
        """
        try:
            return self.treeView_tw.itemText
        except AttributeError:
            raise RuntimeError("Nothing was selected in the "
                               "Existing Connections View")
    # end get_tree_widget_item

    def get_loaded_node_current(self):
        """
        Gets the name of the current node that is loaded within the GUI

        Returns:
            str: The name of the node which is currently loaded
        """
        return self.loadedNode.currentNode
    # end get_loaded_node_current

    def move_node(self, direction):
        #
        #
        #
        """
        --- get the selected item in the QTreeView
        - Get the parent item in the QTreeView
        -\- if there is no parent, do nothing
        -/- Using the parent node as a base, make a motor
        -/ using the button's passed direction argument, get motor.members.direction
        -/- get selected item's direction (from left of the item in row/column)
         -/- check that the returned string is in the allowedStrings
          --- if it's not, return a RuntimeError
        -/- using the motor.members.selectedNodeDirection, get item
        - if any, swap the two and reassign both of them as each other
        """
        # item = self.self.treeView_tw.crawler
        # for x in dir(item):
        #     print x  # how do I get the parent object?

        # if parent is None:
        #     return None  # do nothing
        # parentMotor = motor.MotorMaya(parent.strip())
        # parentMotorObj = getattr(parentMotor.members, direction)
        # itemMotor = motor.MotorMaya(item.text().strip())

        # itemIndex = self.treeView_tw.itemIndex
        # row, col = itemIndex.row(), itemIndex.col()

        # itemDirection = itemIndex.model().itemFromIndex(itemIndex + col)
        # if itemDirection not in self.app.allowedDirections:
        #     return ValueError("Direction: {} was not a valid direction as "
        #                       "specified in list, "
        #                       "{}".format(itemDirection,
        #                                   self.app.allowedDirections))
        # itemMotorObj = getattr(, itemDirection)
        # if parentMotorObj is None:
        pass
    # end move_node

    def delete_node(self, name):
        """
        Deletes whatever node was last loaded in the GUI

        .. note::
            self.draw_gui() will force a new node to be created (so metadata
            is never truly 100% removed)

        Args:
            name: The name of the node to delete
        """
        motor = engine.MotorMaya(name())
        motor.delete()
    # end delete_node

    def delete_all_nodes(self):
        """
        Deletes every node created in the system
        """
        motor = engine.MotorMaya(membership.MASTER_NODE_NAME)
        connections = motor.get_object_hierarchy()

        try:
            for connection in connections:
                pm.delete(connection[0])
            pm.delete(motor.currentNode)
        except pm.MayaNodeError:
            # one or more node didn't exist so it's safe to ignore the error
            pass
        except:
            raise
    # end delete_all_nodes
# end Windows


def pickRun(direction=None, steps=None):
    """
    The main command which overrides the default Up/Down/Left/Right arrow keys
    so that they now support and prioritize PickRunner over pickWalking. If no
    PickRunner metadata is found, the function defaults to a regular pickWalk

    Args:
        direction (str): The direction in which to pickRun/pickWalk. Because
                         pickWalk's args require all lowercase letters, do not
                         put in capital letters into direction
        steps (int): The number of movements in the route of direction
    """
    if direction is None and steps is None:
        return  # do nothing

    motor = engine.MotorMaya(pm.ls(sl=True)[0])
    if motor.has_metadata():
        member = motor.walk(direction, steps)
        app.ApplicationMaya().select(member.metadataNode.linkedNodeName)
    else:
        pm.pickWalk(d=direction)
# end pickRun


def pickRun_hotkey(direction):
    """
    Inits a Maya-native hotkey. The function's purpose is essentially a wrapper
    for the pickRun function.

    Args:
        direction (str): The arrow direction to replace
    """
    # The command needs to be run once in order be availabled
    # in the current interactive Maya-Python session
    #
    pickRun(None, None)
    direction = direction.lower()  # force lower-case

    nameCmd = "hotkey{}".format(direction.capitalize())
    annotation = 'Replaces the {} hotkey to give priority to pickRunner '\
                 'before trying to pickWalk'.format(direction)
    execCmd = "import pickrunner.pickrunner as pickrunner;"
    execCmd += ' pickrunner.pickRun(\\"{}\\", {})'.format(direction, 1)
    execCmd = 'python("{}")'.format(execCmd)
    pm.nameCommand(nameCmd, ann=annotation, c=execCmd)

    # clear existing command and replace it with the new custom command
    pm.hotkey(keyShortcut=direction.capitalize(), name='')
    pm.hotkey(keyShortcut=direction.capitalize(), name=nameCmd)
# end pickRun_hotkey


def reassign_arrow_hotkeys():
    """
    Up, down, left, and right given priority to pickRun before pickWalk by
    replacing their hotkeys in the Maya UI
    """
    directions = app.ApplicationMaya.allowedDirections
    for direction in directions:
        pickRun_hotkey(direction)
# end reassign_arrow_hotkeys


def show_gui():
    """
    Shows the main GUI to the application
    """
    reassign_arrow_hotkeys()
    application = QtGui.QApplication.activeWindow()
    if application is None:
        application = QtGui.Qapp.instance()
    if application is None:
        application = QtGui.QApplication(sys.argv)

    window = Window(application)
    window.show()
# end show_gui


def main():
    """
    The main execution of the current script, which shows PickRunner's GUI
    """
    show_gui()
# end main


if __name__ == "__main__":
    main()
