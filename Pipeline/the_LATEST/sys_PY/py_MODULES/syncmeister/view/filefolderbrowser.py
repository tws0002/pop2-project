
#!/usr/bin/env python
# -*- coding: utf-8 -*-

# IMPORT STANDARD LIBRARIES
import os, sys

# IMPORT THIRD-PARTY LIBRARIES
from PyQt4 import QtCore, QtGui, uic

class FileFolderBrowser(QtGui.QFileDialog):
    """
    The FileDialog is a regular QFileDialog that allows for the selection of files
    and folders and also can return multiple selections.

    The module creates a new window in an existing QApplication by creating a 
    new instance and then calling its .exec_() function. You can return a list
    of the selected items with .filesSelected()

    :Example:

    >>> ...
    >>> fname = FileFolderBrowser()
    >>> fname.exec_()                 # shows FileFolderBrowser
    >>> fname = fname.filesSelected() # returns list of selected file(s)/folder(s)

    ** Considerations **
     Currently does not have a method of parsing multiple selections. If you want
     this functionality, you have to implement it outside of the class
    """
    def __init__(self, *args):
        QtGui.QFileDialog.__init__(self, *args)
        self.setOption(self.DontUseNativeDialog, True)
        self.setFileMode(self.ExistingFiles)
        btns = self.findChildren(QtGui.QPushButton)
        self.openBtn = [x for x in btns if 'open' in str(x.text()).lower()][0]
        self.openBtn.clicked.disconnect()
        self.openBtn.clicked.connect(self.openClicked)
        self.tree = self.findChild(QtGui.QTreeView)
    # end __init__
    def openClicked(self):
        """
        Runs the initial method which determines what file(s)/folder(s) were selected 
        in the FileDialog box 

        :returns:   None
        :rtype:     NoneType
        """
        inds = self.tree.selectionModel().selectedIndexes()
        files = []
        for i in inds:
            if i.column() == 0:
                files.append(os.path.join(str(self.directory().absolutePath()),str(i.data().toString())))
        self.selectedFiles = files
        self.hide()
    # end openClicked
    def filesSelected(self):
        """
        Gets the list of selected files/folders when the window is closed via the
        "OK" button

        :returns:   List of file(s)/folder(s)
        :rtype:     list
        """
        return self.selectedFiles
    # end filesSelected
# end FileFolderBrowser


def main():
    app = QtGui.QApplication(sys.argv)
    w = FileFolderBrowser()

    w.setWindowTitle('Example')
    w.show()
    
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()