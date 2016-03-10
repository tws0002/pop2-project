# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file '/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/syncmeister/view/maingui.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

try:
    from PyQt4 import QtCore, QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    pass

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
        MainWindow.resize(718, 582)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        spacerItem = QtGui.QSpacerItem(17, 13, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout.addItem(spacerItem, 0, 0, 1, 1)
        self.gridLayout_top = QtGui.QGridLayout()
        self.gridLayout_top.setObjectName(_fromUtf8("gridLayout_top"))
        self.root_path_l = QtGui.QLabel(self.centralwidget)
        self.root_path_l.setObjectName(_fromUtf8("root_path_l"))
        self.gridLayout_top.addWidget(self.root_path_l, 1, 0, 1, 1)
        self.root_path_le = QtGui.QLineEdit(self.centralwidget)
        self.root_path_le.setObjectName(_fromUtf8("root_path_le"))
        self.gridLayout_top.addWidget(self.root_path_le, 1, 1, 1, 1)
        self.ok_cancel_b = QtGui.QDialogButtonBox(self.centralwidget)
        self.ok_cancel_b.setOrientation(QtCore.Qt.Vertical)
        self.ok_cancel_b.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.ok_cancel_b.setObjectName(_fromUtf8("ok_cancel_b"))
        self.gridLayout_top.addWidget(self.ok_cancel_b, 0, 2, 2, 1)
        self.application_l = QtGui.QLabel(self.centralwidget)
        self.application_l.setObjectName(_fromUtf8("application_l"))
        self.gridLayout_top.addWidget(self.application_l, 0, 0, 1, 2)
        self.gridLayout.addLayout(self.gridLayout_top, 1, 0, 1, 2)
        spacerItem1 = QtGui.QSpacerItem(700, 249, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Expanding)
        self.gridLayout.addItem(spacerItem1, 2, 0, 1, 2)
        self.horizontalLayout_3 = QtGui.QHBoxLayout()
        self.horizontalLayout_3.setObjectName(_fromUtf8("horizontalLayout_3"))
        spacerItem2 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem2)
        self.backupFile_cb = QtGui.QCheckBox(self.centralwidget)
        self.backupFile_cb.setChecked(False)
        self.backupFile_cb.setObjectName(_fromUtf8("backupFile_cb"))
        self.horizontalLayout_3.addWidget(self.backupFile_cb)
        self.gridLayout.addLayout(self.horizontalLayout_3, 3, 0, 1, 2)
        self.verticalLayout = QtGui.QVBoxLayout()
        self.verticalLayout.setObjectName(_fromUtf8("verticalLayout"))
        self.recursive_cb = QtGui.QCheckBox(self.centralwidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.recursive_cb.sizePolicy().hasHeightForWidth())
        self.recursive_cb.setSizePolicy(sizePolicy)
        self.recursive_cb.setMinimumSize(QtCore.QSize(300, 0))
        self.recursive_cb.setChecked(True)
        self.recursive_cb.setObjectName(_fromUtf8("recursive_cb"))
        self.verticalLayout.addWidget(self.recursive_cb)
        self.seekPath_cb = QtGui.QCheckBox(self.centralwidget)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.seekPath_cb.sizePolicy().hasHeightForWidth())
        self.seekPath_cb.setSizePolicy(sizePolicy)
        self.seekPath_cb.setMinimumSize(QtCore.QSize(300, 0))
        self.seekPath_cb.setObjectName(_fromUtf8("seekPath_cb"))
        self.verticalLayout.addWidget(self.seekPath_cb)
        self.gridLayout.addLayout(self.verticalLayout, 4, 0, 1, 1)
        self.verticalLayout_2 = QtGui.QVBoxLayout()
        self.verticalLayout_2.setObjectName(_fromUtf8("verticalLayout_2"))
        self.searchForMayaFiles_cb = QtGui.QCheckBox(self.centralwidget)
        self.searchForMayaFiles_cb.setChecked(True)
        self.searchForMayaFiles_cb.setObjectName(_fromUtf8("searchForMayaFiles_cb"))
        self.verticalLayout_2.addWidget(self.searchForMayaFiles_cb)
        self.checkExists_cb = QtGui.QCheckBox(self.centralwidget)
        self.checkExists_cb.setChecked(True)
        self.checkExists_cb.setObjectName(_fromUtf8("checkExists_cb"))
        self.verticalLayout_2.addWidget(self.checkExists_cb)
        self.gridLayout.addLayout(self.verticalLayout_2, 4, 1, 1, 1)
        self.horizontalLayout_2 = QtGui.QHBoxLayout()
        self.horizontalLayout_2.setObjectName(_fromUtf8("horizontalLayout_2"))
        self.folder_file_le = QtGui.QLineEdit(self.centralwidget)
        self.folder_file_le.setObjectName(_fromUtf8("folder_file_le"))
        self.horizontalLayout_2.addWidget(self.folder_file_le)
        self.detail_b = QtGui.QToolButton(self.centralwidget)
        self.detail_b.setObjectName(_fromUtf8("detail_b"))
        self.horizontalLayout_2.addWidget(self.detail_b)
        self.more_b = QtGui.QPushButton(self.centralwidget)
        self.more_b.setObjectName(_fromUtf8("more_b"))
        self.horizontalLayout_2.addWidget(self.more_b)
        self.gridLayout.addLayout(self.horizontalLayout_2, 5, 0, 1, 2)
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)
        self.actionNew = QtGui.QAction(MainWindow)
        self.actionNew.setObjectName(_fromUtf8("actionNew"))
        self.actionOpen = QtGui.QAction(MainWindow)
        self.actionOpen.setObjectName(_fromUtf8("actionOpen"))
        self.actionSave_Config = QtGui.QAction(MainWindow)
        self.actionSave_Config.setObjectName(_fromUtf8("actionSave_Config"))
        self.actionAbout = QtGui.QAction(MainWindow)
        self.actionAbout.setObjectName(_fromUtf8("actionAbout"))
        self.actionContact = QtGui.QAction(MainWindow)
        self.actionContact.setObjectName(_fromUtf8("actionContact"))

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.root_path_l.setToolTip(_translate("MainWindow", "<html><head/><body><p>Write the type of license you want. Possible options are commercial, student, educational, institutional</p></body></html>", None))
        self.root_path_l.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>The license type that the Maya files/folders will be changed to.</p></body></html>", None))
        self.root_path_l.setText(_translate("MainWindow", "Root Path", None))
        self.root_path_le.setToolTip(_translate("MainWindow", "<html><head/><body><p>Write the type of license you want. Possible options are commercial, student, educational, institutional</p></body></html>", None))
        self.root_path_le.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>The license type that the Maya files/folders will be changed to.</p></body></html>", None))
        self.root_path_le.setText(_translate("MainWindow", "{ project path here without the {}s }", None))
        self.application_l.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>You can choose Maya files or search entire folders and subfolders to change their license types. This script is to avoid Maya\'s pop-up window when opening files stating that the file was saved in a student version of Maya. Under no circumstances should this script be used to create projects that monetize their products.</p></body></html>", None))
        self.application_l.setText(_translate("MainWindow", "Absolute to Relative Path Changer - Accepts files/folders as input", None))
        self.backupFile_cb.setToolTip(_translate("MainWindow", "<html><head/><body><p>(Optional) Makes a copy of the file before processing it.</p></body></html>", None))
        self.backupFile_cb.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Makes a copy of the file before processing it.</p></body></html>", None))
        self.backupFile_cb.setText(_translate("MainWindow", "Backup Files", None))
        self.recursive_cb.setToolTip(_translate("MainWindow", "<html><head/><body><p>(Optional) Enable to search all folders and subfolders for Maya files to change</p></body></html>", None))
        self.recursive_cb.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Searches within folders you specify recursively for valid Maya files</p></body></html>", None))
        self.recursive_cb.setText(_translate("MainWindow", "Search folders for scene files recursively", None))
        self.seekPath_cb.setToolTip(_translate("MainWindow", "<html><head/><body><p>(Optional) Aggressively searches for a relative path, even if above the root path</p></body></html>", None))
        self.seekPath_cb.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Searches for a relative path to the root path no matter what, even if the source string lies above the root path. Uses notation ..\\, ..\\\\ or ../ to indicate when the script goes &quot;up&quot; a parent folder.<br/><br/>This option can break some Maya scenes because not all Maya nodes support ..\\ notation.</p></body></html>", None))
        self.seekPath_cb.setText(_translate("MainWindow", "Search up parent directories for relative paths", None))
        self.searchForMayaFiles_cb.setToolTip(_translate("MainWindow", "<html><head/><body><p>(Optional) If a Maya file is found within the current Maya file being processed, it will have its paths processed, too</p></body></html>", None))
        self.searchForMayaFiles_cb.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Maya can reference other Maya files within an ASCII scene file. If any such file is found and the option is enabled, those Maya reference files will be processed, too.</p></body></html>", None))
        self.searchForMayaFiles_cb.setText(_translate("MainWindow", "Search within files for other files", None))
        self.checkExists_cb.setToolTip(_translate("MainWindow", "<html><head/><body><p>(Optional) This option will only allow edits to a string or path to be made if the script can prove that it can be proven that it actually exists on the current machine. HIGHLY RECOMMENDED that it is ENABLED but it can also be turned off if you\'re working remotely or off the SCAD network.</p></body></html>", None))
        self.checkExists_cb.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>This option was created to remove strings that were being flagged despite being false positives. It is very dangerous to run the script without using this option.</p></body></html>", None))
        self.checkExists_cb.setText(_translate("MainWindow", "Allow edits only if paths/files exist", None))
        self.folder_file_le.setToolTip(_translate("MainWindow", "<html><head/><body><p>Enter the file or folder location you wish to backup</p></body></html>", None))
        self.folder_file_le.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Enter the file or folder location you wish to backup</p></body></html>", None))
        self.detail_b.setToolTip(_translate("MainWindow", "<html><head/><body><p>Press to open a browser window for a file/folder that you wish to backup</p></body></html>", None))
        self.detail_b.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>A button that lets you browse for a folder or file</p></body></html>", None))
        self.detail_b.setText(_translate("MainWindow", "...", None))
        self.more_b.setToolTip(_translate("MainWindow", "<html><head/><body><p>Press this to add another folder/file to backup</p></body></html>", None))
        self.more_b.setWhatsThis(_translate("MainWindow", "<html><head/><body><p>Adds another folder/file field so you can add more to your backup</p></body></html>", None))
        self.more_b.setText(_translate("MainWindow", "+", None))
        self.actionNew.setText(_translate("MainWindow", "New", None))
        self.actionOpen.setText(_translate("MainWindow", "Open...", None))
        self.actionSave_Config.setText(_translate("MainWindow", "Save...", None))
        self.actionAbout.setText(_translate("MainWindow", "About", None))
        self.actionContact.setText(_translate("MainWindow", "Contact", None))

