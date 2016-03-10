# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file './nuke_finalizer_frame_select.ui'
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

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName(_fromUtf8("Dialog"))
        Dialog.resize(400, 100)
        Dialog.setMinimumSize(QtCore.QSize(400, 100))
        self.gridLayout_2 = QtGui.QGridLayout(Dialog)
        self.gridLayout_2.setObjectName(_fromUtf8("gridLayout_2"))
        self.gridLayout = QtGui.QGridLayout()
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.startFrame_sb = QtGui.QSpinBox(Dialog)
        self.startFrame_sb.setObjectName(_fromUtf8("startFrame_sb"))
        self.gridLayout.addWidget(self.startFrame_sb, 2, 0, 1, 1)
        self.globalFrameRange_cb = QtGui.QCheckBox(Dialog)
        self.globalFrameRange_cb.setMaximumSize(QtCore.QSize(16777215, 20))
        self.globalFrameRange_cb.setChecked(True)
        self.globalFrameRange_cb.setObjectName(_fromUtf8("globalFrameRange_cb"))
        self.gridLayout.addWidget(self.globalFrameRange_cb, 0, 0, 1, 2)
        self.endFrame_sb = QtGui.QSpinBox(Dialog)
        self.endFrame_sb.setObjectName(_fromUtf8("endFrame_sb"))
        self.gridLayout.addWidget(self.endFrame_sb, 2, 1, 1, 1)
        self.endFrame_l = QtGui.QLabel(Dialog)
        self.endFrame_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.endFrame_l.setObjectName(_fromUtf8("endFrame_l"))
        self.gridLayout.addWidget(self.endFrame_l, 1, 1, 1, 1)
        self.startFrame_l = QtGui.QLabel(Dialog)
        self.startFrame_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.startFrame_l.setObjectName(_fromUtf8("startFrame_l"))
        self.gridLayout.addWidget(self.startFrame_l, 1, 0, 1, 1)
        self.okCancel_bb = QtGui.QDialogButtonBox(Dialog)
        self.okCancel_bb.setOrientation(QtCore.Qt.Vertical)
        self.okCancel_bb.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.okCancel_bb.setObjectName(_fromUtf8("okCancel_bb"))
        self.gridLayout.addWidget(self.okCancel_bb, 1, 2, 2, 1)
        self.gridLayout_2.addLayout(self.gridLayout, 0, 0, 1, 1)

        self.retranslateUi(Dialog)
        QtCore.QObject.connect(self.okCancel_bb, QtCore.SIGNAL(_fromUtf8("accepted()")), Dialog.accept)
        QtCore.QObject.connect(self.okCancel_bb, QtCore.SIGNAL(_fromUtf8("rejected()")), Dialog.reject)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.globalFrameRange_cb.setText(_translate("Dialog", "Global Frame Range", None))
        self.endFrame_l.setText(_translate("Dialog", "End Frame", None))
        self.startFrame_l.setText(_translate("Dialog", "Start Frame", None))

