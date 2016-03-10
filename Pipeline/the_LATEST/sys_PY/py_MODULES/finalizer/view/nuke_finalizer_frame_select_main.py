# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file './nuke_finalizer_frame_select_main.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

# from PyQt4 import QtCore, QtGui
import PySide.QtCore as QtCore
import PySide.QtGui as QtGui

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
        MainWindow.resize(400, 150)
        MainWindow.setMinimumSize(QtCore.QSize(400, 150))
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.globalFrameRange_cb = QtGui.QCheckBox(self.centralwidget)
        self.globalFrameRange_cb.setMaximumSize(QtCore.QSize(16777215, 20))
        self.globalFrameRange_cb.setChecked(True)
        self.globalFrameRange_cb.setObjectName(_fromUtf8("globalFrameRange_cb"))
        self.gridLayout.addWidget(self.globalFrameRange_cb, 0, 0, 1, 2)
        self.startFrame_l = QtGui.QLabel(self.centralwidget)
        self.startFrame_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.startFrame_l.setObjectName(_fromUtf8("startFrame_l"))
        self.gridLayout.addWidget(self.startFrame_l, 1, 0, 1, 1)
        self.endFrame_l = QtGui.QLabel(self.centralwidget)
        self.endFrame_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.endFrame_l.setObjectName(_fromUtf8("endFrame_l"))
        self.gridLayout.addWidget(self.endFrame_l, 1, 1, 1, 1)
        self.startFrame_sb = QtGui.QSpinBox(self.centralwidget)
        self.startFrame_sb.setObjectName(_fromUtf8("startFrame_sb"))
        self.gridLayout.addWidget(self.startFrame_sb, 2, 0, 1, 1)
        self.endFrame_sb = QtGui.QSpinBox(self.centralwidget)
        self.endFrame_sb.setObjectName(_fromUtf8("endFrame_sb"))
        self.gridLayout.addWidget(self.endFrame_sb, 2, 1, 1, 1)
        self.okCancel_bb = QtGui.QDialogButtonBox(self.centralwidget)
        self.okCancel_bb.setOrientation(QtCore.Qt.Vertical)
        self.okCancel_bb.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.okCancel_bb.setObjectName(_fromUtf8("okCancel_bb"))
        self.gridLayout.addWidget(self.okCancel_bb, 1, 2, 2, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 400, 25))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.globalFrameRange_cb.setText(_translate("MainWindow", "Global Frame Range", None))
        self.startFrame_l.setText(_translate("MainWindow", "Start Frame", None))
        self.endFrame_l.setText(_translate("MainWindow", "End Frame", None))

