import maya.cmds as cmds
import ui
import globalvariable
import maya.mel as mel
import os

#return list of selected nodes (2 is max)
def selectedDagNode():
    selected = []
    for mask in globalvariable.objects: #check selected for objects
        if cmds.filterExpand(sm=mask):
            selected.append(globalvariable.objects[mask])
        if len(selected) == 2:
            break
    if len(selected) == 0:
        sel = cmds.ls(sl=True, an=True)
        if sel:
            listRel = cmds.listRelatives(sel[0], shapes=True, f=True)
            node = cmds.nodeType(listRel)
            if node:
                selected.append(node)
    return selected


def selectedNonDagNode():
    sel = cmds.ls(sl=True, an=True)
    if sel:
        return cmds.nodeType(sel[0])


#return name of key from start
def findMatch(ls, key, searchtype):
    #don't search
    if not key or searchtype == 0:
        return None
    #by prefix
    elif searchtype == 1:
        for obj in ls:
            ln = len(obj)
            if key[0][:ln] == obj:
                return obj
    #any search
    elif searchtype == 2:
        for obj in ls:
            if obj in key[0]:
                return obj
    #by suffix
    elif searchtype == 3:
        for obj in ls:
            ln = len(obj)
            if key[0][ln:] == obj:
                 return obj
    #absolute match
    else:
        for obj in ls:
            if key[0] == obj:
                 return obj
    return None


class MMtoKey(object):
    def __init__(self):
        object.__init__(self)
        self.data = dict()
        self.data_dagnode, self.data_dagnode_cache = self.loadData('dagnode')
        self.data_nondagnode, self.data_nondagnode_cache = self.loadData('nondagnode')
        self.data_panel, self.data_panel_cache = self.loadData('panel')
        self.data_name, self.data_name_cache = self.loadData('name')
        self.data_tool, self.data_tool_cache = self.loadData('tool')
        self.data_preset, self.data_preset_cache = self.loadData('preset')
        if not self.data_panel:
            for var in globalvariable.UI:
                self.data_panel[var] = [None, '', False, False]
        self.clicked = False
        self.filename = ''
        self.activepreset = None

    #{node : [menu, command, language, specialkey]}
    def loadData(self, filename):
        try:
            with open('%s/userdata/data_%s.mm' % (globalvariable.pluginpath, filename), 'r') as data:
                cluster = dict()
                lines = [line.rstrip() for line in data.readlines()]
                for line in xrange(0, len(lines[:-1]), 5):
                    cluster[lines[line]] = [
                        None if not lines[line+1] else lines[line+1], lines[line+2], globalvariable.tLoad[lines[line+3]], int(lines[line+4])]
        except:
            cluster = dict()
        finally:
            self.data[filename] = cluster
            return cluster, cluster.keys()

    def saveData(self, filename, value):
        with open('%s/userdata/data_%s.mm' % (globalvariable.pluginpath, filename), 'w') as data:
            for key in value.keys():
                data.write('%s\n%s\n%s\n%i\n%i\n' % (key, value[key][0] if value[key][0] else '', value[key][1], value[key][2], value[key][3]))
            data.close()

    def press(self, markingmenu, ctrl, shift, alt, search):
        self.clicked = False
        self.mm = None
        #clear marking menu
        if cmds.popupMenu('mmtokeymenu1', exists=True):
            cmds.deleteUI('mmtokeymenu1')
        if cmds.popupMenu('mmtokeymenu2', exists=True):
            cmds.deleteUI('mmtokeymenu2')
        #create popup menu
        cmds.popupMenu('mmtokeymenu2', button=2, ctl=ctrl, alt=alt, sh=shift, allowOptionBoxes=True, parent=mel.eval('findPanelPopupParent'), mm=True, postMenuCommand=self.click)
        context = cmds.currentCtx()
        cmds.contextInfo(context, title=True)
        if context in self.data_tool_cache and self.data_tool[context][0]:
            mel.eval('source "menu_%s";' % self.data_tool[context][0])
        cmds.popupMenu('mmtokeymenu1', button=1, ctl=ctrl, alt=alt, sh=shift, allowOptionBoxes=True, parent=mel.eval('findPanelPopupParent'), mm=True, postMenuCommand=self.click)
        #custom marking menu
        if markingmenu:
            mel.eval('source "menu_%s";' % markingmenu)
            return
        self.mm, self.filename = self.getkey(search)
        #MayaWindow
        if not self.mm:
            self.mm = self.data_panel['MayaWindow']
        if self.mm[0]:
            mel.eval('source "menu_%s";' % self.mm[0])

    def release(self, command=None, language='mel'):
        if cmds.popupMenu('mmtokeymenu1', exists=True):
            cmds.deleteUI('mmtokeymenu1')
        if cmds.popupMenu('mmtokeymenu2', exists=True):
            cmds.deleteUI('mmtokeymenu2')
        #custom command and no-click
        if command and not self.clicked:
            if language == 'mel':
                mel.eval(command)
            else:
                exec(command)
            return
        #no custom marking menu
        if self.mm and not self.clicked:
            if self.mm[1] == '*':
                with open(('%s/userdata/%s.mm') % (globalvariable.pluginpath, self.filename), 'r') as nodefile:
                    command = nodefile.read()
            else:
                command = self.mm[1]
            if self.mm[2] is True:
                exec(command)
            else:
                mel.eval(command)

    def pressPreset(self, ctrl, shift, alt, radial, hud, section, block):
        self.clicked = False
        if cmds.popupMenu('mmtokeymenu1', exists=True):
            cmds.deleteUI('mmtokeymenu1')
        if cmds.popupMenu('mmtokeymenu2', exists=True):
            cmds.deleteUI('mmtokeymenu2')
        cmds.popupMenu('mmtokeymenu2', button=2, ctl=ctrl, alt=alt, sh=shift, allowOptionBoxes=True, parent=mel.eval('findPanelPopupParent'), mm=True, postMenuCommand=self.click)
        for i in xrange(len(self.data_preset_cache)):
            if radial and i < 8:
                cmds.menuItem(sourceType='python', command='MMtoKey.mmtokey.setActivePreset("%s", %i, %i, %i)' % (self.data_preset_cache[i], hud, section, block), label=self.data_preset_cache[i], radialPosition=globalvariable.popupDiretions[i])
            else:
                cmds.menuItem(sourceType='python', command='MMtoKey.mmtokey.setActivePreset("%s", %i, %i, %i)' % (self.data_preset_cache[i], hud, section, block), label=self.data_preset_cache[i])
        cmds.setParent(u=True)
        cmds.popupMenu('mmtokeymenu1', button=1, ctl=ctrl, alt=alt, sh=shift, allowOptionBoxes=True, parent=mel.eval('findPanelPopupParent'), mm=True, postMenuCommand=self.click)
        if self.activepreset and self.data_preset[self.activepreset][0]:
            mel.eval('source "menu_%s";' % self.data_preset[self.activepreset][0])

    def releasePreset(self):
        if cmds.popupMenu('mmtokeymenu1', exists=True):
            cmds.deleteUI('mmtokeymenu1')
        if cmds.popupMenu('mmtokeymenu2', exists=True):
            cmds.deleteUI('mmtokeymenu2')
        if not self.clicked and self.activepreset:
            if self.data_preset[self.activepreset][1] == '*':
                with open('%s/userdata/%s.mm' % (globalvariable.pluginpath, 'preset_%s' % self.activepreset), 'r') as nodefile:
                    command = nodefile.read()
            else:
                command = self.data_preset[self.activepreset][1]
            if self.data_preset[self.activepreset][2]:
                exec(command)
            else:
                mel.eval(command)

    def setActivePreset(self, preset, hud, section, block):
        self.activepreset = preset
        if cmds.headsUpDisplay('MMtoKeyHUD', ex=True):
            cmds.headsUpDisplay('MMtoKeyHUD', remove=True)
        if hud:
            cmds.headsUpDisplay('MMtoKeyHUD', s=section, b=block, l='MMtoKey preset', ba='center', lfs='large', dfs='large', c=self.getActivePreset, ev='idle')

    def getActivePreset(self):
        return self.activepreset

    def getkey(self, searchtype):
        panel = cmds.getPanel(underPointer=True)
        if panel in self.data_panel_cache:
            #search for name
            if globalvariable.tName[self.data_panel[panel][3]]:
                namekey = findMatch(self.data_name_cache, cmds.ls(sl=True), searchtype)
                if namekey:
                    return self.data_name[namekey], 'name_%s' % namekey
            #search by non dag node
            if globalvariable.tNode[self.data_panel[panel][3]]:
                nondag = selectedNonDagNode()
                if nondag in self.data_nondagnode_cache:
                    return self.data_nondagnode[nondag], 'nondagnode_%s' % nondag
            #search by panel
            if self.data_panel[panel][0]:
                return self.data_panel[panel], 'panel_%s' % panel
            else:
                return None, None
        #looking 3D editor. by name
        namekey = findMatch(self.data_name_cache, cmds.ls(sl=True), searchtype)
        if namekey:
            return self.data_name[namekey], 'name_%s' % namekey
        #select dag node
        select = selectedDagNode()
        if len(select) == 2:
            if ' '.join(select) in self.data_dagnode_cache:
                select = ' '.join(select)
            elif select[0] in self.data_dagnode_cache:
                select = select[0]
            elif select[1] in self.data_dagnode_cache:
                select = select[1]
            else:
                return None, None
        elif len(select) == 1 and select[0] in self.data_dagnode_cache:
            select = select[0]
        else:
            return None, None
        return self.data_dagnode[select], 'dagnode_%s' % select

    def click(self, *args):
        self.clicked = True

    def ui(self):
        self.ui_mainwindow = ui.MainWidget(self)

    def saveConfig(self):
        map(lambda x: self.saveData(x, self.data[x]), self.data.keys())

    def import_04(self):
        filename = cmds.fileDialog2(fm=1, ff='userdata', cap='import from 0.4', dir=globalvariable.pluginpath)
        if not filename:
            return
        map(lambda file: os.remove('%s/userdata/%s' % (globalvariable.pluginpath, file)), os.listdir('%s/userdata' % globalvariable.pluginpath))
        importfile = open(filename[0], 'r')
        dagnodes = importfile.readline().split(' * ')
        for i in xrange(4, int(len(dagnodes)*1.25), 5):
            dagnodes.insert(i, '0')
        with open('%s/userdata/data_dagnode.mm' % globalvariable.pluginpath, 'w') as filewrite:
            filewrite.write('\n'.join(dagnodes))
        dagnodes = importfile.readline().split(' * ')
        for i in xrange(4, int(len(dagnodes)*1.25), 5):
            dagnodes.insert(i, '0')
        with open('%s/userdata/data_panel.mm' % globalvariable.pluginpath, 'w') as filewrite:
            filewrite.write('\n'.join(dagnodes))
        self.__init__()
        self.ui()

    def update(self):
        map(lambda x: x.updateui(), self.ui_mainwindow.ui_allwidget)
