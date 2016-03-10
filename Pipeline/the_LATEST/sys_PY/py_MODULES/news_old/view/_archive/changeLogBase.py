# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file '/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/news/view/changeLogBase.ui'
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
        Dialog.resize(479, 513)
        self.gridLayout = QtGui.QGridLayout(Dialog)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.overall_gridLayout = QtGui.QGridLayout()
        self.overall_gridLayout.setObjectName(_fromUtf8("overall_gridLayout"))
        self.changelog_l = QtGui.QLabel(Dialog)
        self.changelog_l.setAlignment(QtCore.Qt.AlignLeading|QtCore.Qt.AlignLeft|QtCore.Qt.AlignTop)
        self.changelog_l.setObjectName(_fromUtf8("changelog_l"))
        self.overall_gridLayout.addWidget(self.changelog_l, 2, 0, 1, 2)
        self.project_l = QtGui.QLabel(Dialog)
        self.project_l.setMaximumSize(QtCore.QSize(16777215, 30))
        self.project_l.setObjectName(_fromUtf8("project_l"))
        self.overall_gridLayout.addWidget(self.project_l, 0, 0, 1, 1)
        self.okcancel_bb = QtGui.QDialogButtonBox(Dialog)
        self.okcancel_bb.setOrientation(QtCore.Qt.Horizontal)
        self.okcancel_bb.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.okcancel_bb.setObjectName(_fromUtf8("okcancel_bb"))
        self.overall_gridLayout.addWidget(self.okcancel_bb, 4, 0, 1, 2)
        self.version_l = QtGui.QLabel(Dialog)
        self.version_l.setMaximumSize(QtCore.QSize(16777215, 30))
        self.version_l.setObjectName(_fromUtf8("version_l"))
        self.overall_gridLayout.addWidget(self.version_l, 0, 1, 1, 1)
        self.hideUntilUpdate_cb = QtGui.QCheckBox(Dialog)
        self.hideUntilUpdate_cb.setObjectName(_fromUtf8("hideUntilUpdate_cb"))
        self.overall_gridLayout.addWidget(self.hideUntilUpdate_cb, 3, 1, 1, 1)
        spacerItem = QtGui.QSpacerItem(20, 20, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.overall_gridLayout.addItem(spacerItem, 1, 0, 1, 1)
        self.gridLayout.addLayout(self.overall_gridLayout, 0, 0, 1, 1)

        self.retranslateUi(Dialog)
        QtCore.QObject.connect(self.okcancel_bb, QtCore.SIGNAL(_fromUtf8("accepted()")), Dialog.accept)
        QtCore.QObject.connect(self.okcancel_bb, QtCore.SIGNAL(_fromUtf8("rejected()")), Dialog.reject)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.changelog_l.setText(_translate("Dialog", "ChangeLog - Date: {date}:\n"
"{changelog}", None))
        self.project_l.setText(_translate("Dialog", "Project: \"{proj}\" Changelog", None))
        self.version_l.setText(_translate("Dialog", "Version: {version}", None))
        self.hideUntilUpdate_cb.setToolTip(_translate("Dialog", "<html><head/><body><p>Disable this so that this window doesn\'t pop up every time you start the program</p></body></html>", None))
        self.hideUntilUpdate_cb.setWhatsThis(_translate("Dialog", "<html><head/><body><p>A config setting which will modify the current Users\'s preferences</p></body></html>", None))
        self.hideUntilUpdate_cb.setText(_translate("Dialog", "Hide on startup until next update", None))

