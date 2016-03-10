import re
from PySide import QtGui, QtCore
import globalvariable
import maya.cmds as cmds
import ui

class Element(QtGui.QListWidgetItem):
    convert_lan = ['mel', 'python']
    convert_lancode = {'mel': 0, 'python': 1}

    def __init__(self, textblock, line):
        QtGui.QListWidgetItem.__init__(self)
        self.textblock = textblock
        self.submenu = False
        #global var
        self.info_label = ''
        self.info_image = ''
        self.cur_language = ''
        self.cur_command = ''
        self.pos_language = 0
        self.pos_command = 0
        line += 1
        while '-' in self.textblock[line]:
            #static source
            if '-label' in self.textblock[line]:
                self.info_label = re.match('(.*)-label "(.*)"(.*)', self.textblock[line]).group(2)
                self.setText(self.info_label)
            if '-image' in self.textblock[line]:
                self.info_image = re.match('(.*)-image "(.*)"(.*)', self.textblock[line]).group(2)
            #dynamic source
            if '-sourceType' in self.textblock[line]:
                self.cur_language = re.match('(.*)-sourceType "(.*)"( .*)', self.textblock[line]).group(2)
                self.pos_language = line
            if '-command ' in self.textblock[line]:
                self.cur_command = self.textblock[line].split('-command "')[1].rsplit('"', 1)[0]
                self.pos_command = line
            #breaker
            if '-subMenu 1' in self.textblock[line]:
                self.submenu = True
                break
            if '-optionBox 1' in self.textblock[line]:
                self.submenu = True
                break
            line += 1

    def getCommand(self):
        return self.cur_command.replace('\\"', '"').replace('\\n', '\n')

    def getLanguage(self):
        return self.convert_lancode[self.cur_language]

    def setCommand(self, command):
        command = command.replace('"', '\\"').replace('\n', '\\n')
        self.textblock[self.pos_command] = self.textblock[self.pos_command].replace(self.cur_command, command)
        self.cur_command = command

    def setLanguage(self, language):
        language = self.convert_lan[language]
        self.textblock[self.pos_language] = self.textblock[self.pos_language].replace(self.cur_language, language)
        self.cur_language = language


class Widget(QtGui.QMainWindow):
    def __init__(self):
        QtGui.QMainWindow.__init__(self, ui.mayaWindow())
        if cmds.window('MMtoKeyPyUI', ex=True):
            cmds.deleteUI('MMtoKeyPyUI')
        if cmds.control('MMtoKeyPyIconWidget', ex=True):
            cmds.deleteUI('MMtoKeyPyIconWidget')
        self.setFixedSize(350, 220)
        self.setWindowTitle('PopupMenu mel/python switcher')
        self.setWindowFlags(QtCore.Qt.Tool)
        self.setObjectName('MMtoKeyPyUI')
        self.ui_combobox = QtGui.QComboBox(self)
        self.ui_combobox.setGeometry(180, 30, 80, 20)
        self.ui_combobox.addItems(['mel', 'python'])
        self.ui_listwidget = QtGui.QListWidget(self)
        self.ui_listwidget.setGeometry(10, 30, 160, 180)
        self.ui_listwidget.setSelectionMode(QtGui.QListWidget.ExtendedSelection)
        self.ui_textedit = QtGui.QTextEdit(self)
        self.ui_textedit.setGeometry(180, 100, 160, 110)
        self.ui_textedit.setEnabled(False)
        self.ui_textedit.setLineWrapMode(QtGui.QTextEdit.NoWrap)
        self.widget = QtGui.QWidget(self)
        self.widget.setGeometry(180, 60, 32, 32)
        self.ui_vbox = QtGui.QVBoxLayout(self.widget)
        self.ui_vbox.setContentsMargins(0, 0, 0, 0)
        self.ui_vbox.setSpacing(0)
        self.ui_vbox.setObjectName('MMtoKeyPyIcon')
        self.ui_button = ui.RunTextButton(self, QtCore.QRect(220, 60, 120, 30), 'save command', self.savecommand)
        self.ui_button.setEnabled(False)
        cmds.image('MMtoKeyPyIconWidget', p='MMtoKeyPyIcon')
        self.connect(self.ui_listwidget, QtCore.SIGNAL('itemSelectionChanged()'), self.updatetext)
        self.connect(self.ui_combobox, QtCore.SIGNAL('currentIndexChanged(int)'), self.updatelan)
        self.menuBar().addAction('open', self.selectMM)
        self.menuBar().addAction('save', self.saveMM)
        self.show()

    def savecommand(self):
        print self.ui_textedit.toPlainText()
        self.ui_listwidget.currentItem().setCommand(self.ui_textedit.toPlainText())

    def selectMM(self):
        self.enterData(cmds.fileDialog2(fm=1, ff='menu_*.mel', dir=globalvariable.markingmenu, cap='open Marking Menu')[0])

    def saveMM(self):
        with open(self.fileread, 'w') as fileread:
            fileread.write(''.join(self.textblock))

    def updatelan(self):
        items = self.ui_listwidget.selectedItems()
        for item in items:
            item.setLanguage(self.ui_combobox.currentIndex())

    def updatetext(self):
        items = self.ui_listwidget.selectedItems()
        self.ui_textedit.setText('')
        cmds.image('MMtoKeyPyIconWidget', e=True, vis=False)
        self.ui_textedit.setEnabled(False)
        self.ui_button.setEnabled(False)
        if items:
            self.ui_combobox.setCurrentIndex(items[0].getLanguage())
        if len(items) == 1:
            self.ui_textedit.setText(items[0].getCommand())
            cmds.image('MMtoKeyPyIconWidget', e=True, vis=True, i=items[0].info_image)
            self.ui_textedit.setEnabled(True)
            self.ui_button.setEnabled(True)

    def enterData(self, fileread):
        self.ui_listwidget.clear()
        self.ui_listwidget.setCurrentRow(-1)
        self.ui_textedit.setText('')
        self.ui_button.setEnabled(False)
        cmds.image('MMtoKeyPyIconWidget', e=True, vis=False)
        self.fileread = fileread
        with open(self.fileread, 'r') as filelink:
            self.textblock = filelink.readlines()
        for line in xrange(len(self.textblock)):
            if 'menuItem' in self.textblock[line]:
                element = Element(self.textblock, line)
                if not element.submenu:
                    self.ui_listwidget.addItem(element)
