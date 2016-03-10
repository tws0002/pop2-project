# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file './shotSelectionBase.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

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
        Dialog.resize(624, 113)
        Dialog.setMinimumSize(QtCore.QSize(624, 113))
        self.gridLayoutWidget = QtGui.QWidget(Dialog)
        self.gridLayoutWidget.setGeometry(QtCore.QRect(9, 9, 611, 101))
        self.gridLayoutWidget.setObjectName(_fromUtf8("gridLayoutWidget"))
        self.gridLayout = QtGui.QGridLayout(self.gridLayoutWidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.shot_vLay = QtGui.QVBoxLayout()
        self.shot_vLay.setObjectName(_fromUtf8("shot_vLay"))
        self.shot_l = QtGui.QLabel(self.gridLayoutWidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.shot_l.sizePolicy().hasHeightForWidth())
        self.shot_l.setSizePolicy(sizePolicy)
        self.shot_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.shot_l.setObjectName(_fromUtf8("shot_l"))
        self.shot_vLay.addWidget(self.shot_l)
        self.shot_cb = QtGui.QComboBox(self.gridLayoutWidget)
        self.shot_cb.setObjectName(_fromUtf8("shot_cb"))
        self.shot_vLay.addWidget(self.shot_cb)
        self.gridLayout.addLayout(self.shot_vLay, 1, 1, 1, 1)
        self.applications_vLay = QtGui.QVBoxLayout()
        self.applications_vLay.setObjectName(_fromUtf8("applications_vLay"))
        self.applications_l = QtGui.QLabel(self.gridLayoutWidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.applications_l.sizePolicy().hasHeightForWidth())
        self.applications_l.setSizePolicy(sizePolicy)
        self.applications_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.applications_l.setObjectName(_fromUtf8("applications_l"))
        self.applications_vLay.addWidget(self.applications_l)
        self.applications_cb = QtGui.QComboBox(self.gridLayoutWidget)
        self.applications_cb.setMinimumSize(QtCore.QSize(100, 0))
        self.applications_cb.setObjectName(_fromUtf8("applications_cb"))
        self.applications_cb.addItem(_fromUtf8(""))
        self.applications_cb.addItem(_fromUtf8(""))
        self.applications_cb.addItem(_fromUtf8(""))
        self.applications_vLay.addWidget(self.applications_cb)
        self.gridLayout.addLayout(self.applications_vLay, 1, 2, 1, 1)
        self.choose_vLay = QtGui.QVBoxLayout()
        self.choose_vLay.setObjectName(_fromUtf8("choose_vLay"))
        self.choose_l = QtGui.QLabel(self.gridLayoutWidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.choose_l.sizePolicy().hasHeightForWidth())
        self.choose_l.setSizePolicy(sizePolicy)
        self.choose_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.choose_l.setObjectName(_fromUtf8("choose_l"))
        self.choose_vLay.addWidget(self.choose_l)
        self.choose_cb = QtGui.QComboBox(self.gridLayoutWidget)
        self.choose_cb.setMinimumSize(QtCore.QSize(200, 0))
        self.choose_cb.setObjectName(_fromUtf8("choose_cb"))
        self.choose_cb.addItem(_fromUtf8(""))
        self.choose_cb.addItem(_fromUtf8(""))
        self.choose_cb.addItem(_fromUtf8(""))
        self.choose_vLay.addWidget(self.choose_cb)
        self.gridLayout.addLayout(self.choose_vLay, 1, 3, 1, 1)
        self.scene_vLay = QtGui.QVBoxLayout()
        self.scene_vLay.setObjectName(_fromUtf8("scene_vLay"))
        self.scene_l = QtGui.QLabel(self.gridLayoutWidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Preferred, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.scene_l.sizePolicy().hasHeightForWidth())
        self.scene_l.setSizePolicy(sizePolicy)
        self.scene_l.setMinimumSize(QtCore.QSize(100, 0))
        self.scene_l.setMaximumSize(QtCore.QSize(16777215, 20))
        self.scene_l.setObjectName(_fromUtf8("scene_l"))
        self.scene_vLay.addWidget(self.scene_l)
        self.scene_cb = QtGui.QComboBox(self.gridLayoutWidget)
        self.scene_cb.setObjectName(_fromUtf8("scene_cb"))
        self.scene_vLay.addWidget(self.scene_cb)
        self.gridLayout.addLayout(self.scene_vLay, 1, 0, 1, 1)
        self.quickSelect_l = QtGui.QLabel(self.gridLayoutWidget)
        self.quickSelect_l.setObjectName(_fromUtf8("quickSelect_l"))
        self.gridLayout.addWidget(self.quickSelect_l, 0, 0, 1, 1)
        self.bb = QtGui.QDialogButtonBox(self.gridLayoutWidget)
        self.bb.setOrientation(QtCore.Qt.Vertical)
        self.bb.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.bb.setObjectName(_fromUtf8("bb"))
        self.gridLayout.addWidget(self.bb, 1, 4, 1, 1)
        self.loadLast_pb = QtGui.QPushButton(self.gridLayoutWidget)
        self.loadLast_pb.setStyleSheet(_fromUtf8("background-color: cyan;"))
        self.loadLast_pb.setObjectName(_fromUtf8("loadLast_pb"))
        self.gridLayout.addWidget(self.loadLast_pb, 0, 4, 1, 1)

        self.retranslateUi(Dialog)
        self.applications_cb.setCurrentIndex(0)
        self.choose_cb.setCurrentIndex(0)
        QtCore.QObject.connect(self.bb, QtCore.SIGNAL(_fromUtf8("rejected()")), Dialog.reject)
        QtCore.QObject.connect(self.bb, QtCore.SIGNAL(_fromUtf8("accepted()")), Dialog.accept)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.shot_l.setText(_translate("Dialog", "Shot:", None))
        self.applications_l.setText(_translate("Dialog", "Application:", None))
        self.applications_cb.setItemText(0, _translate("Dialog", "nuke", None))
        self.applications_cb.setItemText(1, _translate("Dialog", "maya", None))
        self.applications_cb.setItemText(2, _translate("Dialog", "houdini", None))
        self.choose_l.setText(_translate("Dialog", "Choose:", None))
        self.choose_cb.setItemText(0, _translate("Dialog", "Automatic {by filename}", None))
        self.choose_cb.setItemText(1, _translate("Dialog", "Automatic {by date}", None))
        self.choose_cb.setItemText(2, _translate("Dialog", "Manual {let me choose}", None))
        self.scene_l.setText(_translate("Dialog", "Scene:", None))
        self.quickSelect_l.setText(_translate("Dialog", "Quick Select", None))
        self.loadLast_pb.setText(_translate("Dialog", "Load Last", None))

