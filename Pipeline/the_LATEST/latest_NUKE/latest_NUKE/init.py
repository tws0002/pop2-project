#!/usr/bin/python

"""
Initialization method for Nuke. Runs in GUI mode and in the terminal
"""

# def we_are_frozen():
#     # All of the modules are built-in to the interpreter, e.g., by py2exe
#     return hasattr(sys, "frozen")

# def module_path():
#     encoding = sys.getfilesystemencoding()
#     if we_are_frozen():
#         return os.path.dirname(unicode(sys.executable, encoding))
#     return os.path.dirname(unicode(__file__, encoding))

# IMPORT STANDARD LIBRARIES
import nuke 
import os, inspect	
import sys
import re

nuke.tprint('running init.py')

CURRENTFILE = inspect.stack()[0][1]

HOMEPATH = inspect.stack()[0][1]
HOMEPATH = os.path.dirname(CURRENTFILE)
TARGETDIRS = [os.path.join(HOMEPATH, dir) for dir in os.listdir(HOMEPATH)
			  if os.path.isdir(os.path.join(HOMEPATH, dir))]

# targetDirs.append(os.getenv('ENVIRON') + os.sep + 'sys.PY' + os.sep + 'sys.MODULES')

NUKEPATTERN = re.compile('^nuke\_([A-Z]+)$')
SYSPATTERN = re.compile('^sys\_([A-Z]+)$')

for i in TARGETDIRS:
	thisDir = os.path.split(i)[1]
	if NUKEPATTERN.match(thisDir):
		nuke.pluginAddPath(i)
	if SYSPATTERN.match(thisDir):
		sys.path.append(i)

# make sure plugins are loaded if not in GUI mode
if not nuke.GUI:
	nuke.tprint('\n\n')
	for i in nuke.pluginPath():
		nuke.tprint(i)
	nuke.tprint('\n\n')
	for i in sys.path:
		nuke.tprint(i)
	nuke.tprint('\n\n')

nuke.CLIPBOARD = {}
nuke.CLIPBOARD['icon'] = None