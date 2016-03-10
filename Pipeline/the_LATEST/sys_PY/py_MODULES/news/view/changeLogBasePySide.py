# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file './changeLogBase.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!


from PySide import QtCore
from PySide import QtGui


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

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(643, 668)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        spacerItem = QtGui.QSpacerItem(20, 20, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout.addItem(spacerItem, 1, 0, 1, 1)
        self.ok_pb = QtGui.QPushButton(self.centralwidget)
        self.ok_pb.setStyleSheet(_fromUtf8("background-color: orange;"))
        self.ok_pb.setObjectName(_fromUtf8("ok_pb"))
        self.gridLayout.addWidget(self.ok_pb, 3, 1, 1, 1)
        self.project_l = QtGui.QLabel(self.centralwidget)
        self.project_l.setMaximumSize(QtCore.QSize(16777215, 30))
        self.project_l.setObjectName(_fromUtf8("project_l"))
        self.gridLayout.addWidget(self.project_l, 0, 0, 1, 1)
        self.hideUntilUpdate_cb = QtGui.QCheckBox(self.centralwidget)
        self.hideUntilUpdate_cb.setObjectName(_fromUtf8("hideUntilUpdate_cb"))
        self.gridLayout.addWidget(self.hideUntilUpdate_cb, 2, 1, 1, 2)
        self.version_l = QtGui.QLabel(self.centralwidget)
        self.version_l.setMaximumSize(QtCore.QSize(16777215, 30))
        self.version_l.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.version_l.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTrailing|QtCore.Qt.AlignVCenter)
        self.version_l.setObjectName(_fromUtf8("version_l"))
        self.gridLayout.addWidget(self.version_l, 0, 2, 1, 1)
        self.cancel_pb = QtGui.QPushButton(self.centralwidget)
        self.cancel_pb.setObjectName(_fromUtf8("cancel_pb"))
        self.gridLayout.addWidget(self.cancel_pb, 3, 2, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 643, 25))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.ok_pb.setText(_translate("MainWindow", "Colin, I love you", None))
        self.project_l.setText(_translate("MainWindow", "Project: \"{proj}\" Changelog", None))
        self.hideUntilUpdate_cb.setToolTip(_translate("MainWindow", "<html><head/><body><p>Disable this so that this window doesn\'t pop up every time you start the program</p></body></html>", None))
        self.hideUntilUpdate_cb.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>A config setting which will modify the current Users\'s preferences</p></body></html>", None))
        self.hideUntilUpdate_cb.setText(_translate("MainWindow", "Hide on startup until next update", None))
        self.version_l.setText(_translate("MainWindow", "Version: {version}", None))
        self.cancel_pb.setText(_translate("MainWindow", "Got it", None))

