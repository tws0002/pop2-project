#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The software backup ui module is an extension to the software_backup_layout.ui.
All edits here are meant to modify and extend the UI without making edits directly
within it.
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import functools

# IMPORT THIRD PARTY LIBRARIES
try:
    import PyQt4.QtCore as QtCore
    import PyQt4.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

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


class RemoveButton(QtGui.QPushButton):
    def __init__( self, parent=None):
        super(RemoveButton, self).__init__(parent)
        self.retranslate_ui()
    # end __init__

    def retranslate_ui(self):
        self.setToolTip(_translate("MainWindow", "<html><head/><body><p>Press this to remove folder/file from backup</p></body></html>", None))
        self.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Removes current line from your backup</p></body></html>", None))
        self.setText(_translate("MainWindow", "-", None))
    # end retranslate_ui
# end RemoveButton


class DetailButton(QtGui.QToolButton):
    def __init__( self, parent=None):
        super(DetailButton, self).__init__(parent)
        self.retranslate_ui()
    # end __init__

    def retranslate_ui(self):
        self.setToolTip(_translate("MainWindow", "<html><head/><body><p>Press to open a browser window for a file/folder that you wish to backup</p></body></html>", None))
        self.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>A button that lets you browse for a folder or file</p></body></html>", None))
        self.setText(_translate("MainWindow", "...", None))
    # end retranslate_ui
# end RemoveButton


class LineEdit(QtGui.QLineEdit):
    def __init__( self, parent=None):
        super(LineEdit, self).__init__(parent)
    # end __init__

    def retranslate_ui(self):
        self.folder_file_l.setToolTip(_translate("MainWindow", "<html><head/><body><p>All of the files/folders that you want to select for the backup. Please note that adding a subfolder of another folder will result in a redundant backup.</p></body></html>", None))
        self.folder_file_l.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>All of the files/folders that you want to select for the backup. Please note that adding a subfolder of another folder will result in a redundant backup.</p></body></html>", None))
        self.folder_file_l.setText(_translate("MainWindow", "Folders/Files to Backup:", None))
    # end retranslate_ui
# end LineEdit


class CombinedRow(QtGui.QHBoxLayout):
    """
    A combined class which takes three other custom classes to create a horizontalLayout
    in the final backup ui whenever the add_new_line function is called. This was
    broken into a separate class to allow each row to be its own individual instance.

    That way, if the rows were added/deleted, it would only delete itself and not
    any of the other rows.

    .. seealso:: LineEdit, DetailButton, and RemoveButton
    """
    def __init__(self, parent=None):
        super(CombinedRow, self).__init__(parent)
        self.lineEdit = LineEdit()
        self.detailButton = DetailButton()

        self.lineEdit.setObjectName(_fromUtf8("folder_file_le"))
        self.detailButton.setObjectName(_fromUtf8("detail_b"))

        self.addWidget(self.lineEdit)
        self.addWidget(self.detailButton)

        self.detailButton.clicked.connect(functools.partial(self.show_dialog, parent))
    # end __init__

    def remove_button(self):
        """
        Initializes the RemoveButton instance to remove row on click

        :returns: None
        :rtype:   NoneType
        """
        self.removeButton = RemoveButton()
        self.removeButton.setObjectName(_fromUtf8("remove_tb"))
        self.addWidget(self.removeButton)

        self.removeButton.clicked.connect(self.delete_widget)
    # end remove_button

    def add_button(self):
        """
        Initializes the RemoveButton instance to remove row on click

        :returns: None
        :rtype:   NoneType
        """
        self.addButton = AddButton()
        self.addButton.setObjectName(_fromUtf8("add_tb"))
        self.addWidget(self.addButton)

        self.addButton.clicked.connect(self.add_widget)
    # end add_button

    def show_dialog(self, win):
        """
        Creates a custom QFileDialog which can select files or folders and attaches
        its methods to the main window

        :param win: The window instance that is linked to the QApplication instance
        :type win:  QApplication
        :returns:   None
        :rtype:     NoneType
        """
        fname = FileFolderBrowser()
        fname.exec_()

        fname = fname.filesSelected()

        addedLine = False
        if fname:
            if os.path.isdir(fname[0]) or fname[0].endswith('.ma'):
                self.lineEdit.setText(fname[0])
                addedLine = True

            if len(fname) > 1:
                for f in fname[1:]:
                    if os.path.isdir(f) or f.endswith('.ma'):
                        addedLine = 1
                        win.add_folder_line(defaultText=f)

            if addedLine:
                win.add_folder_line()
    # end show_dialog

    def delete_widget(self):
        """
        Deletes the current CombinedRow instance when executed

        :returns:   None
        :rtype:     NoneType
        """
        for i in reversed(range(self.count())):
            self.itemAt(i).widget().deleteLater()

        window = self.parent().parent().parent()
        windowSize = window.geometry()
        window.resize( windowSize.width(), windowSize.height() - 29 )
    # end delete_widget

    def add_widget():
        """
        Creates a separate instance of the current widget
        """
        pass
    # end add_widget
# end CombinedRow


if __name__ == "__main__":
    print(__doc__)
