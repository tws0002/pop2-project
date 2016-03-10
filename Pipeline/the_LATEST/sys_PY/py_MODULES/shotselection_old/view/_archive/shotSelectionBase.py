# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file './shotSelectionBase.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore
from PyQt4 import QtGui

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
        Dialog.resize(505, 101)
        self.gridLayout = QtGui.QGridLayout(Dialog)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.scene_vLay = QtGui.QVBoxLayout()
        self.scene_vLay.setObjectName(_fromUtf8("scene_vLay"))
        self.scene_l = QtGui.QLabel(Dialog)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.scene_l.sizePolicy().hasHeightForWidth())
        self.scene_l.setSizePolicy(sizePolicy)
        self.scene_l.setMinimumSize(QtCore.QSize(100, 0))
        self.scene_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.scene_l.setObjectName(_fromUtf8("scene_l"))
        self.scene_vLay.addWidget(self.scene_l)
        self.scene_cb = QtGui.QComboBox(Dialog)
        self.scene_cb.setObjectName(_fromUtf8("scene_cb"))
        self.scene_vLay.addWidget(self.scene_cb)
        self.gridLayout.addLayout(self.scene_vLay, 1, 0, 1, 1)
        self.shot_vLay = QtGui.QVBoxLayout()
        self.shot_vLay.setObjectName(_fromUtf8("shot_vLay"))
        self.shot_l = QtGui.QLabel(Dialog)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.shot_l.sizePolicy().hasHeightForWidth())
        self.shot_l.setSizePolicy(sizePolicy)
        self.shot_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.shot_l.setObjectName(_fromUtf8("shot_l"))
        self.shot_vLay.addWidget(self.shot_l)
        self.shot_cb = QtGui.QComboBox(Dialog)
        self.shot_cb.setObjectName(_fromUtf8("shot_cb"))
        self.shot_vLay.addWidget(self.shot_cb)
        self.gridLayout.addLayout(self.shot_vLay, 1, 1, 1, 1)
        self.applications_vLay = QtGui.QVBoxLayout()
        self.applications_vLay.setObjectName(_fromUtf8("applications_vLay"))
        self.applications_l = QtGui.QLabel(Dialog)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.applications_l.sizePolicy().hasHeightForWidth())
        self.applications_l.setSizePolicy(sizePolicy)
        self.applications_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.applications_l.setObjectName(_fromUtf8("applications_l"))
        self.applications_vLay.addWidget(self.applications_l)
        self.applications_cb = QtGui.QComboBox(Dialog)
        self.applications_cb.setMinimumSize(QtCore.QSize(200, 0))
        self.applications_cb.setObjectName(_fromUtf8("applications_cb"))
        self.applications_cb.addItem(_fromUtf8(""))
        self.applications_cb.addItem(_fromUtf8(""))
        self.applications_cb.addItem(_fromUtf8(""))
        self.applications_vLay.addWidget(self.applications_cb)
        self.gridLayout.addLayout(self.applications_vLay, 1, 2, 1, 1)
        self.quickSelect_l = QtGui.QLabel(Dialog)
        self.quickSelect_l.setObjectName(_fromUtf8("quickSelect_l"))
        self.gridLayout.addWidget(self.quickSelect_l, 0, 0, 1, 1)
        self.bb = QtGui.QDialogButtonBox(Dialog)
        self.bb.setOrientation(QtCore.Qt.Vertical)
        self.bb.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.bb.setObjectName(_fromUtf8("bb"))
        self.gridLayout.addWidget(self.bb, 1, 3, 1, 1)

        self.retranslateUi(Dialog)
        QtCore.QObject.connect(self.bb, QtCore.SIGNAL(_fromUtf8("accepted()")), Dialog.accept)
        QtCore.QObject.connect(self.bb, QtCore.SIGNAL(_fromUtf8("rejected()")), Dialog.reject)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.scene_l.setText(_translate("Dialog", "Scene:", None))
        self.shot_l.setText(_translate("Dialog", "Shot:", None))
        self.applications_l.setText(_translate("Dialog", "Application:", None))
        self.applications_cb.setItemText(0, _translate("Dialog", "Houdini", None))
        self.applications_cb.setItemText(1, _translate("Dialog", "Maya", None))
        self.applications_cb.setItemText(2, _translate("Dialog", "Nuke", None))
        self.quickSelect_l.setText(_translate("Dialog", "Quick Select", None))
