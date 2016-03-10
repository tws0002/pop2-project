try:
    from PySide import QtGui, QtCore
except:
    from PyQt4 import QtGui, QtCore
import ui
import maya.cmds as cmds
import globalvariable
import maya.mel as mel

message = 'Hotkey maker not working in Maya 2016+. After you press "create" visit "hotkey editor/user directory" to assign buttons on command.'

class MainWidget(QtGui.QMainWindow):
    def __init__(self):
        QtGui.QMainWindow.__init__(self, ui.mayaWindow())
        if mel.eval('getApplicationVersionAsFloat') >= 2016:
            cmds.confirmDialog(m=message, b=['OK'])
        dialog = cmds.confirmDialog(m='What would you like to create?', b=['Standart', 'Presets'], db='Standart')
        if cmds.window('MMtoKeyHotkey', exists=True):
            cmds.deleteUI('MMtoKeyHotkey')
        self.setObjectName('MMtoKeyHotkey')
        self.setWindowFlags(QtCore.Qt.Tool)
        self.setWindowTitle('MMtoKey Create Hotkey')
        self.ui_label0 = QtGui.QLabel('<b>hotkey name</b>', self)
        self.ui_label0.setGeometry(10, 10, 170, 20)
        self.ui_text_name = QtGui.QLineEdit(self)
        self.ui_text_name.setGeometry(10, 30, 170, 20)
        if dialog == 'Standart':
            self.setFixedSize(190, 260)
            self.ui_label1 = QtGui.QLabel('<b>marking menu (optional)</b>', self)
            self.ui_label1.setGeometry(10, 50, 170, 20)
            self.ui_label2 = QtGui.QLabel('<b>command (optional)</b>', self)
            self.ui_label2.setGeometry(10, 90, 170, 20)
            self.ui_label3 = QtGui.QLabel('<b>names</b>', self)
            self.ui_label3.setGeometry(10, 170, 70, 20)
            self.ui_text_menu = QtGui.QLineEdit(self)
            self.ui_text_menu.setGeometry(10, 70, 170, 20)
            self.ui_text_command = QtGui.QLineEdit(self)
            self.ui_text_command.setGeometry(10, 110, 170, 20)
            self.ui_ch_alt = QtGui.QCheckBox('alt', self)
            self.ui_ch_alt.setGeometry(10, 140, 40, 20)
            self.ui_ch_ctrl = QtGui.QCheckBox('ctrl', self)
            self.ui_ch_ctrl.setGeometry(60, 140, 40, 20)
            self.ui_text_button = QtGui.QLineEdit(self)
            self.ui_text_button.setGeometry(110, 140, 30, 20)
            self.ui_text_button.setMaxLength(1)
            self.ui_combo = QtGui.QComboBox(self)
            self.ui_combo.setGeometry(90, 170, 90, 20)
            self.ui_combo.addItems(['no search', 'prefix matches', 'any matches', 'suffix matches', 'absoulute match'])
            self.ui_combo.setCurrentIndex(0)
            self.ui_btn_language = ui.BoolTextButton(self, QtCore.QRect(110, 200, 70, 20), globalvariable.languages, self.none)
            self.ui_btn = ui.RunTextButton(self, QtCore.QRect(110, 230, 70, 20), 'create', self.createhotkey)
        else:
            self.setFixedSize(190, 210)
            self.ui_label1 = QtGui.QLabel('<b>section</b>', self)
            self.ui_label1.setGeometry(60, 60, 120, 20)
            self.ui_label2 = QtGui.QLabel('<b>block</b>', self)
            self.ui_label2.setGeometry(60, 90, 120, 20)
            self.ui_spinBox_section = QtGui.QSpinBox(self)
            self.ui_spinBox_section.setMaximum(9)
            self.ui_spinBox_section.setMinimum(0)
            self.ui_spinBox_section.setValue(2)
            self.ui_spinBox_section.setGeometry(10, 60, 40, 20)
            self.ui_spinBox_block = QtGui.QSpinBox(self)
            self.ui_spinBox_block.setMaximum(9)
            self.ui_spinBox_block.setMinimum(0)
            self.ui_spinBox_block.setValue(2)
            self.ui_spinBox_block.setGeometry(10, 90, 40, 20)
            self.ui_ch_alt = QtGui.QCheckBox('alt', self)
            self.ui_ch_alt.setGeometry(10, 120, 50, 20)
            self.ui_ch_ctrl = QtGui.QCheckBox('ctrl', self)
            self.ui_ch_ctrl.setGeometry(70, 120, 50, 20)
            self.ui_ch_hud = QtGui.QCheckBox('HUD', self)
            self.ui_ch_hud.setGeometry(130, 120, 50, 20)
            self.ui_ch_hud.setChecked(True)
            self.ui_ch_radial = QtGui.QCheckBox('radial', self)
            self.ui_ch_radial.setGeometry(10, 150, 80, 20)
            self.ui_ch_radial.setChecked(True)
            self.ui_text_button = QtGui.QLineEdit(self)
            self.ui_text_button.setGeometry(110, 150, 30, 20)
            self.ui_text_button.setMaxLength(1)
            self.ui_btn = ui.RunTextButton(self, QtCore.QRect(110, 180, 70, 20), 'create', self.createpreset)
            self.connect(self.ui_ch_hud, QtCore.SIGNAL('clicked()'), self.activePos)
        self.show()

    def activePos(self):
        self.ui_spinBox_section.setEnabled(self.ui_ch_hud.isChecked())
        self.ui_spinBox_block.setEnabled(self.ui_ch_hud.isChecked())

    def none(self, *args):
        pass

    def createhotkey(self):
        if cmds.runTimeCommand('%s_press' % self.ui_text_name.text(), exists=True):
            cmds.warning('name is not unique!')
            return
        hotkeyname = self.ui_text_name.text()
        menuname = '"%s"' % self.ui_text_menu.text() if self.ui_text_menu.text() else 'None'
        commandname = '"%s"' % self.ui_text_command.text() if self.ui_text_command.text() else 'None'
        hotkey = self.ui_text_button.text()
        if not hotkey:
            cmds.warning('hotkey field is empty!')
            return
        presscode = 'MMtoKey.press(markingmenu=%s, ctrl=%s, alt=%s, shift=%s, search=%i)' % \
                    (menuname, self.ui_ch_ctrl.isChecked(), self.ui_ch_alt.isChecked(), hotkey.isupper(), self.ui_combo.currentIndex())
        releasecode = 'MMtoKey.release(command=%s, language=%s)' % (commandname, '"%s"' % globalvariable.languages[self.ui_btn_language.getvalue()])

        cmds.hotkey(k=hotkey, name='%s_press' % hotkeyname, releaseName='%s_release' % hotkeyname, ctl=self.ui_ch_ctrl.isChecked(), alt=self.ui_ch_alt.isChecked())
        cmds.runTimeCommand('%s_press' % hotkeyname, command=presscode, category='User', commandLanguage='python', annotation='MMtoKey press command')
        cmds.runTimeCommand('%s_release' % hotkeyname, command=releasecode, category='User', commandLanguage='python', annotation='MMtoKey release command')
        cmds.nameCommand('%s_press' % hotkeyname, annotation='%s_press' % hotkeyname, command='%s_press' % hotkeyname)   #container for runTimeCommand
        cmds.nameCommand('%s_release' % hotkeyname, annotation='%s_release' % hotkeyname, command='%s_release' % hotkeyname)   #container for runTimeCommand

    def createpreset(self):
        if cmds.runTimeCommand('%s_press' % self.ui_text_name.text(), exists=True):
            cmds.warning('name is not unique!')
            return
        hotkeyname = self.ui_text_name.text()
        hotkey = self.ui_text_button.text()
        if not hotkey:
            cmds.warning('hotkey field is empty!')
            return
        presscode = 'MMtoKey.pressPreset(ctrl=%s, shift=%s, alt=%s, radial=%s, hud=%s, section=%i, block=%i)' % \
                    (self.ui_ch_ctrl.isChecked(), self.ui_ch_alt.isChecked(), hotkey.isupper(), self.ui_ch_radial.isChecked(), self.ui_ch_hud.isChecked(), self.ui_spinBox_section.value(), self.ui_spinBox_block.value())
        releasecode = 'MMtoKey.releasePreset()'
        cmds.hotkey(k=hotkey, name='%s_press' % hotkeyname, releaseName='%s_release' % hotkeyname, ctl=self.ui_ch_ctrl.isChecked(), alt=self.ui_ch_alt.isChecked())
        cmds.runTimeCommand('%s_press' % hotkeyname, command=presscode, category='User', commandLanguage='python', annotation='MMtoKey press command')
        cmds.runTimeCommand('%s_release' % hotkeyname, command=releasecode, category='User', commandLanguage='python', annotation='MMtoKey release command')
        cmds.nameCommand('%s_press' % hotkeyname, annotation='%s_press' % hotkeyname, command='%s_press' % hotkeyname)   #container for runTimeCommand
        cmds.nameCommand('%s_release' % hotkeyname, annotation='%s_release' % hotkeyname, command='%s_release' % hotkeyname)   #container for runTimeCommand
