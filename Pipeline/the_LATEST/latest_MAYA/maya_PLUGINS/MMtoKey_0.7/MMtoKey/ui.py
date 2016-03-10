try:
    from PySide import QtGui, QtCore
except:
    from PyQt4 import QtGui, QtCore
import maya.cmds as cmds
import shiboken
import maya.OpenMayaUI as OpenMayaUI
import MMtoKey
import globalvariable
import os
import maya.mel as mel
import hotkeymaker
import MMpy

def mayaWindow():
    return shiboken.wrapInstance(long(OpenMayaUI.MQtUtil.mainWindow()), QtGui.QWidget)


#class for many-values button. [False, True]
class BoolTextButton(QtGui.QLabel):
    def __init__(self, parent, geo, changetext, command):
        QtGui.QLabel.__init__(self, parent)
        self.setGeometry(geo)
        self.changetext = changetext
        self.value = False
        self.command = command
        self.setAlignment(QtCore.Qt.AlignCenter)
        self.setStyleSheet('background-color: transparent; border-radius: 3px;')
        self.setText('<b>%s</b>' % self.changetext[self.value])

    #returns current value
    def getvalue(self):
        return self.value

    #replace value
    def setvalue(self, value):
        self.value = value
        self.setText('<b>%s</b>' % self.changetext[self.value])

    def enterEvent(self, *args, **kwargs):
        if self.isEnabled():
            self.setStyleSheet('background-color: rgb(80, 80, 80); border-radius: 3px;')

    def leaveEvent(self, *args, **kwargs):
        self.setStyleSheet('background-color: transparent; border-radius: 3px;')

    def mousePressEvent(self, QMouseEvent):
        self.value = not self.value
        self.setText('<b>%s</b>' % self.changetext[self.value])
        self.setStyleSheet('background-color: rgb(100, 100, 100); border-radius: 3px;')
        self.command(self.value)    #launches command

    def mouseReleaseEvent(self, QMouseEvent):
        self.setStyleSheet('background-color: rgb(80, 80, 80); border-radius: 3px;')


#class for flat run-time buttons dummy
class RunTextButton(QtGui.QLabel):
    def __init__(self, parent, geo, labeltext, command):
        QtGui.QLabel.__init__(self, parent)
        self.setGeometry(geo)
        self.command = command
        self.setAlignment(QtCore.Qt.AlignCenter)
        self.setStyleSheet('background-color: transparent; border-radius: 3px;')
        self.setText('<b>%s</b>' % labeltext)

    def enterEvent(self, *args, **kwargs):
        if self.isEnabled():
            self.setStyleSheet('background-color: rgb(80, 80, 80); border-radius: 3px;')

    def leaveEvent(self, *args, **kwargs):
        self.setStyleSheet('background-color: transparent; border-radius: 3px;')

    def mousePressEvent(self, QMouseEvent):
        self.setStyleSheet('background-color: rgb(100, 100, 100); border-radius: 3px;')
        self.command()

    def mouseReleaseEvent(self, QMouseEvent):
        self.setStyleSheet('background-color: rgb(80, 80, 80); border-radius: 3px;')


#UI widget dummy. data: {set : [menu, no-click, language]} data_cache: [set, set, set]
class Widget(QtGui.QWidget):
    def __init__(self, data, data_cache, name):
        QtGui.QWidget.__init__(self, mayaWindow())
        self.setObjectName(name)
        self.name = name
        self.data = data
        self.data_cache = data_cache
        self.ui_list1 = QtGui.QListWidget(self)
        self.ui_list1.setGeometry(10, 10, 180, 200)
        self.ui_list1.addItems(data.keys())
        self.ui_list2 = QtGui.QListWidget()
        self.ui_list2.addItems(map(lambda x: x[5:-4], os.listdir(globalvariable.markingmenu)))
        self.ui_list2.setMinimumHeight(35)
        self.ui_commandeditor = QtGui.QTextEdit()
        self.ui_commandeditor.setLineWrapMode(QtGui.QTextEdit.NoWrap)
        self.ui_commandeditor.setMinimumHeight(25)
        #panelayout
        self.ui_listwidget = QtGui.QWidget()
        self.ui_listwidget.setObjectName('%s_widget' % name)

        self.ui_listwidgetTop = QtGui.QWidget()
        self.ui_listwidgetTop.setObjectName('%s_widgetTop' % name)
        self.ui_vboxTop = QtGui.QVBoxLayout(self.ui_listwidgetTop)
        self.ui_vboxTop.setContentsMargins(0, 0, 1, 0)
        self.ui_vboxTop.setSpacing(0)

        self.ui_listwidgetBottom = QtGui.QWidget()
        self.ui_listwidgetBottom.setObjectName('%s_widgetBottom' % name)
        self.ui_vboxBottom = QtGui.QVBoxLayout(self.ui_listwidgetBottom)
        self.ui_vboxBottom.setContentsMargins(0, 0, 1, 0)
        self.ui_vboxBottom.setSpacing(0)

        if cmds.control('%s_pane' % name, ex=True):
            cmds.deleteUI('%s_pane' % name)
        cmds.paneLayout('%s_pane' % name, configuration='horizontal2', p='%s_widget' % name)
        cmds.control('%s_widgetTop' % name, e=True, p='%s_pane' % name)
        cmds.control('%s_widgetBottom' % name, e=True, p='%s_pane' % name)
        cmds.paneLayout('%s_pane' % name, e=True, ps=[1, 0, 67])
        self.ui_listwidget.setParent(self)
        self.ui_listwidget.setGeometry(201, 10, 180, 200)
        self.ui_vboxTop.addWidget(self.ui_list2)
        self.ui_vboxBottom.addWidget(self.ui_commandeditor)
        #code editor buttons
        self.ui_commandeditorbuttons = QtGui.QWidget()
        self.ui_commandeditorbuttons.setFixedSize(180, 24)
        self.ui_vboxBottom.addWidget(self.ui_commandeditorbuttons)
        self.ui_btn_savecode = RunTextButton(self.ui_commandeditorbuttons, QtCore.QRect(2, 3, 59, 20), 'save', self.saveCommand)
        self.ui_btn_changelanguage = BoolTextButton(self.ui_commandeditorbuttons, QtCore.QRect(61, 3, 59, 20), ['mel', 'python'], self.changeCommandLanguage)
        #connect
        self.connect(self.ui_list1, QtCore.SIGNAL('itemClicked(QListWidgetItem*)'), self.listoneselect)
        self.connect(self.ui_list2, QtCore.SIGNAL('itemClicked(QListWidgetItem*)'), self.listtwoselect)
        self.connect(self.ui_list1, QtCore.SIGNAL('currentRowChanged(int)'), self.listoneselect)
        self.connect(self.ui_list2, QtCore.SIGNAL('currentRowChanged(int)'), self.listtwoselect)

        self.ui_btn_add = RunTextButton(self, QtCore.QRect(11, 212, 59, 20), 'add', self.listoneadd)
        self.ui_btn_remove = RunTextButton(self, QtCore.QRect(71, 212, 59, 20), 'remove', self.listonedelete)

    #changed valub presets list
    def listoneselect(self):
        if not self.ui_list1.currentItem():
            self.ui_list2.setCurrentItem(None)
            self.ui_commandeditor.setText('')
            self.ui_commandeditor.setEnabled(False)
            self.ui_list2.setEnabled(False)
            self.ui_btn_changelanguage.setEnabled(False)
            self.ui_btn_savecode.setEnabled(False)
            return
        self.ui_commandeditor.setEnabled(True)
        self.ui_list2.setEnabled(True)
        self.ui_btn_changelanguage.setEnabled(True)
        self.ui_btn_savecode.setEnabled(True)
        dictkey = self.ui_list1.currentItem().text()
        searchkey = self.data[dictkey][0]
        commandeditortext = self.data[dictkey][1]
        language = self.data[dictkey][2]
        try:
            currentitem = self.ui_list2.findItems(searchkey, QtCore.Qt.MatchExactly)[0]
        except:
            currentitem = None
        #update view
        if commandeditortext == '*':
            try:
                with open('%s/userdata/%s_%s.mm' % (globalvariable.pluginpath, self.name, self.ui_list1.currentItem().text()), 'r') as nodefile:
                    self.ui_commandeditor.setText(nodefile.read())
            except IOError:
                self.ui_commandeditor.setText(None)
        else:
            self.ui_commandeditor.setText(commandeditortext)
        self.ui_list2.setCurrentItem(currentitem)
        self.ui_btn_changelanguage.setvalue(language)

    #changed value in marking menu list
    def listtwoselect(self):
        try:
            searchkey = self.ui_list2.currentItem().text()
            dictkey = self.ui_list1.currentItem().text()
            self.data[dictkey][0] = searchkey
        except:
            pass

    #replaces mel with python
    def changeCommandLanguage(self, value):
        dictkey = self.ui_list1.currentItem().text()
        self.data[dictkey][2] = value

    #updates save command text
    def saveCommand(self):
        dictkey = self.ui_list1.currentItem().text()
        command = self.ui_commandeditor.toPlainText()
        if '\n' in command:
            with open('%s/userdata/%s_%s.mm' % (globalvariable.pluginpath, self.name, dictkey), 'w') as nodefile:
                nodefile.write(command)
            self.data[dictkey][1] = '*'
        else:
            self.data[dictkey][1] = command
            try:
                os.remove('%s/userdata/%s_%s.mm' % (globalvariable.pluginpath, self.name, dictkey))
            except:
                pass

    def listonedelete(self):
        try:
            dictkey = self.ui_list1.currentItem().text()
            self.data.pop(dictkey)
            for i in xrange(len(self.data_cache)):
                if self.data_cache[i] == dictkey:
                    self.data_cache.pop(i)
                    break
            self.ui_list1.takeItem(self.ui_list1.currentRow())
            self.listoneselect()
        except:
            pass

    def listodeadd(self):
        pass

    def updateui(self):
        self.ui_list2.clear()
        self.ui_list2.addItems(map(lambda x: x[5:-4], os.listdir(globalvariable.markingmenu)))
        self.listoneselect()

    def listonecheck(self, result):
        if not result or result in self.data.keys():
            return
        self.ui_list1.addItem(result)
        self.data[result] = [None, '', False, False]
        self.data_cache.append(result)
        self.listoneselect()

    def checkerror(self):
        menus = ['data_%s.mm' % self.name]
        markingmenus = os.listdir(globalvariable.markingmenu)
        for obj in self.data_cache:
            key = self.data[obj]
            if key[0] and 'menu_%s.mel' % key[0] not in markingmenus:
                key[0] = None
            if key[1] == '*':
                if os.path.isfile('%s/userdata/%s_%s.mm' % (globalvariable.pluginpath, self.name, obj)):
                    menus.append('%s_%s.mm' % (self.name, obj))
                else:
                    key[1] = None
        return menus

#dagnode widget widget
class WidgetDagNode(Widget):
    def __init__(self, *args):
        Widget.__init__(self, *args)
        self.listoneselect()

    def listoneadd(self):
        preset = MMtoKey.selectedDagNode()
        if preset:
            self.listonecheck(' '.join(preset))


#dagnode widget widget
class WidgetNonDagNode(Widget):
    def __init__(self, *args):
        Widget.__init__(self, *args)
        self.listoneselect()

    def listoneadd(self):
        self.listonecheck(MMtoKey.selectedNonDagNode())


#widget panel
class WidgetPanel(Widget):
    def __init__(self, *args):
        Widget.__init__(self, *args)
        self.ui_btn_break = RunTextButton(self, QtCore.QRect(131, 212, 59, 20), 'break', self.listonebreak)
        self.ui_btn_apply = RunTextButton(self, QtCore.QRect(312, 212, 69, 20), 'apply to all', self.applytoall)
        self.ui_combobox_node = QtGui.QComboBox(self)
        self.ui_combobox_node.setGeometry(201, 212, 100, 20)
        self.ui_combobox_node.addItems(['off', 'name', 'non-dag', 'name, non-dag'])
        self.connect(self.ui_combobox_node, QtCore.SIGNAL('currentIndexChanged(int)'), self.node)
        self.listoneselect()

    def applytoall(self):
        if self.ui_list1.currentItem():
            index = self.ui_combobox_node.currentIndex()
            for i in self.data:
                self.data[i][3] = index

    def listoneadd(self):
        self.listonecheck(raw_input().replace(' ', ''))

    def listonebreak(self):
        try:
            dictkey = self.ui_list1.currentItem().text()
            self.data[dictkey][0] = None
            self.listoneselect()
        except:
            pass

    def node(self):
        try:
            dictkey = self.ui_list1.currentItem().text()
            param = self.ui_combobox_node.currentIndex()
            self.data[dictkey][3] = param
            self.listoneselect()
        except:
            pass

    def listoneselect(self):
        if not self.ui_list1.currentItem():
            self.ui_combobox_node.setEnabled(False)
            self.ui_combobox_node.setCurrentIndex(-1)
        else:
            dictkey = self.ui_list1.currentItem().text()
            self.ui_combobox_node.setEnabled(True)
            self.ui_combobox_node.setCurrentIndex(self.data[dictkey][3])
        Widget.listoneselect(self)
        

class WidgetName(Widget):
    def __init__(self, *args):
        Widget.__init__(self, *args)
        self.listoneselect()

    def listoneadd(self):
        self.listonecheck(raw_input().replace(' ', ''))


class WidgetPreset(Widget):
    def __init__(self, *args):
        Widget.__init__(self, *args)
        self.listoneselect()

    def listoneadd(self):
        self.listonecheck(raw_input())


class WidgetTool(Widget):
    def __init__(self, *args):
        Widget.__init__(self, *args)
        self.ui_listwidget.setParent(None)
        self.ui_list2.setParent(self)
        self.ui_list2.setGeometry(201, 10, 180, 200)
        self.listoneselect()

    def listoneadd(self):
        result = cmds.currentCtx()
        cmds.contextInfo(result, c=True)
        self.listonecheck(result)


class MainWidget(QtGui.QMainWindow):
    def __init__(self, mmtokey):
        QtGui.QMainWindow.__init__(self, mayaWindow())
        if cmds.window('MMtoKeyUI', exists=True):
            cmds.deleteUI('MMtoKeyUI')
        self.setWindowTitle('MMtoKey %s' % globalvariable.version)
        self.setObjectName('MMtoKeyUI')
        self.setFixedSize(390, 275)
        self.mmtokey = mmtokey
        self.ui_tabwidget = QtGui.QTabWidget(self)
        self.ui_tabwidget.setGeometry(0, 20, 390, 255)
        self.ui_tabwidget.setDocumentMode(True)
        self.ui_tabwidget.setTabPosition(QtGui.QTabWidget.North)
        #generate node editor tab
        self.ui_window_dagnode = WidgetDagNode(self.mmtokey.data_dagnode, self.mmtokey.data_dagnode_cache, 'dagnode')
        self.ui_tabwidget.addTab(self.ui_window_dagnode, 'DAG')
        #non-dag
        self.ui_window_nondagnode = WidgetNonDagNode(self.mmtokey.data_nondagnode, self.mmtokey.data_nondagnode_cache, 'nondagnode')
        self.ui_tabwidget.addTab(self.ui_window_nondagnode, 'non-DAG')
        #generate node editor tab
        self.ui_window_name = WidgetName(self.mmtokey.data_name, self.mmtokey.data_name_cache, 'name')
        self.ui_tabwidget.addTab(self.ui_window_name, 'name')
        #generate panel editor tab
        self.ui_window_panel = WidgetPanel(self.mmtokey.data_panel, self.mmtokey.data_panel_cache, 'panel')
        self.ui_tabwidget.addTab(self.ui_window_panel, 'panel')
        #generate tool tab
        self.ui_window_tool = WidgetTool(self.mmtokey.data_tool, self.mmtokey.data_tool_cache, 'tool')
        self.ui_tabwidget.addTab(self.ui_window_tool, 'tool')
        #generate preset tab
        self.ui_window_preset = WidgetPreset(self.mmtokey.data_preset, self.mmtokey.data_preset_cache, 'preset')
        self.ui_tabwidget.addTab(self.ui_window_preset, 'preset')
        self.ui_allwidget = [self.ui_window_preset, self.ui_window_dagnode, self.ui_window_nondagnode, self.ui_window_name, self.ui_window_panel, self.ui_window_tool]
        #menubar
        menu_file = QtGui.QMenu('file')
        menu_file.addAction('save', mmtokey.saveConfig)
        menu_file.addAction('import', mmtokey.import_04)
        menu_file.addAction('update', mmtokey.update)
        menu_file.addAction('check error', self.checkerrors)
        menu_tools = QtGui.QMenu('tools')
        menu_tools.addAction('hotkey maker', self.hotkeymaker)
        menu_tools.addAction('mel/python switch', MMpy.Widget)
        menu_tools.addAction('marking menu editor', self.markingmenu)
        self.menuBar().addMenu(menu_file)
        self.menuBar().addMenu(menu_tools)
        self.menuBar().addAction('about', About)
        self.show()

    def hotkeymaker(self):
        hotkeymaker.MainWidget()

    def markingmenu(self):
        mel.eval('menuEditorWnd;')

    def checkerrors(self):
        files = list()
        map(lambda widget: files.extend(widget.checkerror()), self.ui_allwidget)
        filesToDelete = filter(lambda x: x not in files, os.listdir('%s\userdata' % globalvariable.pluginpath))
        if filesToDelete:
            result = cmds.confirmDialog(m='%i files to delete. Continue?' % len(filesToDelete), b=['OK', 'Cancel', 'Files'])
            if result == 'OK':
                try:
                    map(lambda f: os.remove('%s/userdata/%s' % (globalvariable.pluginpath, f)), filesToDelete)
                except:
                    pass
            elif result == 'Files':
                cmds.confirmDialog(m=str(filesToDelete), b=['OK'])


class About(QtGui.QMainWindow):
    def __init__(self, *args):
        QtGui.QMainWindow.__init__(self, mayaWindow())
        self.setFixedSize(160, 130)
        self.setWindowTitle('About')
        self.setWindowFlags(QtCore.Qt.Tool)
        if cmds.window('MMtoKeyAbout', ex=True):
            cmds.deleteUI('MMtoKeyAbout')
        self.setObjectName('MMtoKeyAbout')
        self.ui_text = QtGui.QLabel('MMtoKey\nv%s\n\n\nMenshikov Andrey\nDavide Alidosi, 2015' % globalvariable.version, self)
        self.ui_text.setGeometry(10, 10, 140, 80)
        self.ui_btn = QtGui.QPushButton('OK', self)
        self.ui_btn.setGeometry(40, 100, 75, 20)
        self.connect(self.ui_btn, QtCore.SIGNAL('clicked()'), self.close)
        self.show()

    def close(self):
        cmds.deleteUI('MMtoKeyAbout')