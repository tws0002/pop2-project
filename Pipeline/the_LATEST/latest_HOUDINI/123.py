#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
..Description::
 This module initializes houdini's environment, as well as the project-wide
 logger and a couple other independent scripts
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import getpass

# IMPORT THIRD PARTY LIBRARIES
import hou

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths as paths

# add houdini-specific modules to the current project
try:
    os.environ['PIPELINE_DIR']
except KeyError:
    sys.exit("No PIPELINE_DIR found, cannot continue")

MODULE_PATH = os.path.join(os.environ['PIPELINE_DIR'], 'latest_HOUDINI', 'hou_PY')
sys.path.append(MODULE_PATH)

# IMPORT LOCAL LIBRARIES
import houmanager as houmanager

# load file
# hou.hipFile.load('/home/selecaotwo/Desktop/quick/untitled.hipnc')

# NODE DEFAULTS
# WRITE NODE-TYPES DEFAULT
# $HIP/geo/`$SC`_`$USER`_$HIPNAME.$OS.$F4.bgeo.sc

################################################################################
# ADD HSCRIPT VARS
################################################################################
sceneFolder = paths.os_path_split_asunder(hou.expandString('$HIP'))
sceneFolder = os.path.join(*sceneFolder[:-2])  # look back two folders for scene number
hou.hscript('set SC="' + sceneFolder + '"')
hou.hscript('set USER="' + getpass.getuser() + '"')  # get username

