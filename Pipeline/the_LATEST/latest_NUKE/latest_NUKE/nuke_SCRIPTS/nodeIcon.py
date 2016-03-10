#!/usr/bin/env python

import nuke, os

def setIcon(node, path):
    try:
        if os.path.splitext(path)[1] in ['.jpg', '.jpeg', '.png', '.svg', '.tif', '.tiff']:
            if not os.path.exists(path):
                for dir in nuke.pluginPath():
                    if os.path.exists(os.path.join(dir, os.path.split(path)[1])):
                        path = os.path.join(dir, os.path.split(path)[1])
                        break
            node.knob('icon').setValue(path)
            return True
        elif path is '':
            node.knob('icon').setValue('')
            return True
        else:
            return False
    except:
        return False
    
def addIcons():
    nodes = nuke.selectedNodes()
    path = nuke.getFilename('Select Icon File', '*.jpg;*.jpeg;*.png;*.svg;*.tif;*.tiff')
    results = []
    for node in nodes:
        results.append(setIcon(node, path))
    return results
        
def removeIcons():
    nodes = nuke.selectedNodes()
    results = []
    for node in nodes:
        results.append(setIcon(node, ''))
    return results

def copyIcon():
    node = nuke.selectedNode()
    nuke.CLIPBOARD['icon'] = node.knob('icon').value()
    return nuke.CLIPBOARD['icon']
    
def cutIcon():
    node = nuke.selectedNode()
    nuke.CLIPBOARD['icon'] = node.knob('icon').value()
    setIcon(node, '')
    return nuke.CLIPBOARD['icon']
    
def pasteIcons():
    nodes = nuke.selectedNodes()
    path = nuke.CLIPBOARD['icon']
    results = []
    for node in nodes:
        results.append(setIcon(node, path))
    return results    