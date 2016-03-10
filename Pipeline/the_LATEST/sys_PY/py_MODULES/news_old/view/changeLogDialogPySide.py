# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file './changeLogBaseDialog.ui'
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

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName(_fromUtf8("Dialog"))
        Dialog.resize(961, 685)
        self.ok_pb = QtGui.QPushButton(Dialog)
        self.ok_pb.setGeometry(QtCore.QRect(399, 531, 205, 27))
        self.ok_pb.setStyleSheet(_fromUtf8("background-color: orange;"))
        self.ok_pb.setObjectName(_fromUtf8("ok_pb"))
        self.hideUntilUpdate_cb = QtGui.QCheckBox(Dialog)
        self.hideUntilUpdate_cb.setGeometry(QtCore.QRect(399, 406, 415, 22))
        self.hideUntilUpdate_cb.setObjectName(_fromUtf8("hideUntilUpdate_cb"))
        self.cancel_pb = QtGui.QPushButton(Dialog)
        self.cancel_pb.setGeometry(QtCore.QRect(610, 531, 204, 27))
        self.cancel_pb.setObjectName(_fromUtf8("cancel_pb"))
        self.project_l = QtGui.QLabel(Dialog)
        self.project_l.setGeometry(QtCore.QRect(189, 150, 204, 30))
        self.project_l.setMaximumSize(QtCore.QSize(16777215, 30))
        self.project_l.setObjectName(_fromUtf8("project_l"))
        self.version_l = QtGui.QLabel(Dialog)
        self.version_l.setGeometry(QtCore.QRect(610, 150, 204, 30))
        self.version_l.setMaximumSize(QtCore.QSize(16777215, 30))
        self.version_l.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.version_l.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignTrailing|QtCore.Qt.AlignVCenter)
        self.version_l.setObjectName(_fromUtf8("version_l"))

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.ok_pb.setText(_translate("Dialog", "Colin, I love you", None))
        self.hideUntilUpdate_cb.setToolTip(_translate("Dialog", "<html><head/><body><p>Disable this so that this window doesn\'t pop up every time you start the program</p></body></html>", None))
        self.hideUntilUpdate_cb.setWhatsThis(_translate("Dialog", "<html><head/><body><p>A config setting which will modify the current Users\'s preferences</p></body></html>", None))
        self.hideUntilUpdate_cb.setText(_translate("Dialog", "Hide on startup until next update", None))
        self.cancel_pb.setText(_translate("Dialog", "Got it", None))
        self.project_l.setText(_translate("Dialog", "Project: \"{proj}\" Changelog", None))
        self.version_l.setText(_translate("Dialog", "Version: {version}", None))

