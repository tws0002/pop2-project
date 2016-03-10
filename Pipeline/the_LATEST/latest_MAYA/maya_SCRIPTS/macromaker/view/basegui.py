# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file '/media/selecaotwo/TOSHIBA EXT/transfer/to_monty/guis/macromaker/basegui.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

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

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(755, 653)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout_2 = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout_2.setObjectName(_fromUtf8("gridLayout_2"))
        self.gridLayout = QtGui.QGridLayout()
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.add_pb = QtGui.QPushButton(self.centralwidget)
        self.add_pb.setMaximumSize(QtCore.QSize(100, 16777215))
        self.add_pb.setObjectName(_fromUtf8("add_pb"))
        self.gridLayout.addWidget(self.add_pb, 3, 3, 1, 1)
        self.getCode_pb = QtGui.QPushButton(self.centralwidget)
        self.getCode_pb.setObjectName(_fromUtf8("getCode_pb"))
        self.gridLayout.addWidget(self.getCode_pb, 8, 1, 1, 1)
        self.moveDown_pb = QtGui.QPushButton(self.centralwidget)
        self.moveDown_pb.setObjectName(_fromUtf8("moveDown_pb"))
        self.gridLayout.addWidget(self.moveDown_pb, 6, 3, 1, 1)
        spacerItem = QtGui.QSpacerItem(20, 20, QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Minimum)
        self.gridLayout.addItem(spacerItem, 3, 2, 1, 1)
        self.moveUp_pb = QtGui.QPushButton(self.centralwidget)
        self.moveUp_pb.setObjectName(_fromUtf8("moveUp_pb"))
        self.gridLayout.addWidget(self.moveUp_pb, 5, 3, 1, 1)
        self.sendToShelf_pb = QtGui.QPushButton(self.centralwidget)
        self.sendToShelf_pb.setStyleSheet(_fromUtf8("background-color: orange;"))
        self.sendToShelf_pb.setObjectName(_fromUtf8("sendToShelf_pb"))
        self.gridLayout.addWidget(self.sendToShelf_pb, 7, 1, 1, 1)
        self.minus_pb = QtGui.QPushButton(self.centralwidget)
        self.minus_pb.setObjectName(_fromUtf8("minus_pb"))
        self.gridLayout.addWidget(self.minus_pb, 4, 3, 1, 1)
        spacerItem1 = QtGui.QSpacerItem(0, 20, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout.addItem(spacerItem1, 2, 1, 1, 1)
        spacerItem2 = QtGui.QSpacerItem(100, 20, QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Minimum)
        self.gridLayout.addItem(spacerItem2, 3, 0, 4, 1)
        self.title_l = QtGui.QLabel(self.centralwidget)
        self.title_l.setMaximumSize(QtCore.QSize(16777215, 22))
        font = QtGui.QFont()
        font.setFamily(_fromUtf8("DejaVu Sans Mono"))
        font.setPointSize(18)
        self.title_l.setFont(font)
        self.title_l.setAlignment(QtCore.Qt.AlignCenter)
        self.title_l.setObjectName(_fromUtf8("title_l"))
        self.gridLayout.addWidget(self.title_l, 0, 0, 1, 4)
        self.subtitle_l = QtGui.QLabel(self.centralwidget)
        self.subtitle_l.setMaximumSize(QtCore.QSize(16777215, 12))
        font = QtGui.QFont()
        font.setBold(True)
        font.setWeight(75)
        self.subtitle_l.setFont(font)
        self.subtitle_l.setAlignment(QtCore.Qt.AlignCenter)
        self.subtitle_l.setObjectName(_fromUtf8("subtitle_l"))
        self.gridLayout.addWidget(self.subtitle_l, 1, 0, 1, 4)
        self.cmd_lv = QtGui.QListView(self.centralwidget)
        self.cmd_lv.setObjectName(_fromUtf8("cmd_lv"))
        self.gridLayout.addWidget(self.cmd_lv, 3, 1, 4, 1)
        self.gridLayout_2.addLayout(self.gridLayout, 0, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 755, 25))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.add_pb.setText(_translate("MainWindow", "+", None))
        self.getCode_pb.setText(_translate("MainWindow", "Get Code", None))
        self.moveDown_pb.setText(_translate("MainWindow", "Move Down", None))
        self.moveUp_pb.setText(_translate("MainWindow", "Move Up", None))
        self.sendToShelf_pb.setText(_translate("MainWindow", "Send to Shelf", None))
        self.minus_pb.setText(_translate("MainWindow", "-", None))
        self.title_l.setText(_translate("MainWindow", "Macro Save", None))
        self.subtitle_l.setText(_translate("MainWindow", "by Colin Kennedy", None))

