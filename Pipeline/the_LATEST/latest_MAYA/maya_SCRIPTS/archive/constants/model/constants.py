#!/usr/bin/env python

"""\
Project::
 Portal Origins: Part Two
Description::
 A list of constants that will be applied, project wide. The methods and
 variables defined here will keep scripts relative and cause system-wide
 changes, where appropriate
Author::
 Colin Kennedy

..To Do::
 Currently, the regex only supports one _ between groupings. I need to make it
 so that it can accept multiple_underscores_in_a_name_like_this.0001.ma
"""

# IMPORT STANDARD LIBRARIES
import os, sys
import re
import json
import platform

import getpass
import socket

# IMPORT LOCAL LIBRARIES
import logger.common.loggingServices_0004d as loggingservices
LOGGER = loggingservices.Logger(loggingservices.RE_LOGGER_KEY_MATCH, 
                                loggingservices.LOGGER_MESSAGE_CONFIG)

# User directory
# AUTHOR NOTE: Make sure the to use os.path.expanduser and have fallbacks
# in case that doesn't worl https://docs.python.org/2/library/os.path.html

# System-specific variables
# ::KeyReplace: Temporary variables until I find something better
if getpass.getuser() is not None:
    LOGGER.trace(['AIE1000', 'match_true'], {"Username": getpass.getuser()})
    USERNAME = getpass.getuser()
else:
    LOGGER.error(['AIE7000'], {'Username': getpass.getuser()})

PROJECT_PATH_WINDOWS = os.path.join('I:\\', 'Savannah',
                                    'CollaborativeSpace',
                                    'portal-origins-part-2')

HOSTNAME = socket.gethostname()
IPADDRESS = socket.gethostbyname(socket.gethostname())
if IPADDRESS.startswith('10.7'):
  NETWORKNAME = 'Montgomery Hall'
else:
  NETWORKNAME = IPADDRESS

SYSTEM = sys.platform
if not SYSTEM == 'linux2' and not SYSTEM == 'win32':
    LOGGER.critical(['AIE9003', 'match_false'], {'OS': SYSTEM})
    sys.exit('OS NOT RECOGNIZED. '\
             'SCRIPT EXITTING...'.format(os.path.basename(__file__)))
else:
    LOGGER.trace(['AIE2102', 'match_true'], {'OS': SYSTEM})

if SYSTEM == 'linux2':
    PROJECT_PATH_WINDOWS = None
    # ::KeyReplace: Find a different variable for user Replace USERNAME
    PROJECT_PATH_LINUX = os.path.join('/home', USERNAME, 'mount',
                                      'collaborative',
                                      'portal-origins-part-2')

    if os.path.isdir(PROJECT_PATH_LINUX):
        LOGGER.trace(['AIE2101', 'match_true'], {"Linux Path": 
                                                 PROJECT_PATH_LINUX})
    else:
        LOGGER.error(['AIE7002'], {"Linux Path": PROJECT_PATH_LINUX})
        LOGGER.error(['AIE7012'])
        PROJECT_PATH_LINUX = None  # FLAG    
else:
    PROJECT_PATH_LINUX = None
    if os.path.isdir(PROJECT_PATH_WINDOWS):
        LOGGER.trace(['AIE1001', 'match_true'], {"Windows Path": PROJECT_PATH_WINDOWS})
    else:
        LOGGER.error(['AIE7001'], {"Windows Path": PROJECT_PATH_WINDOWS})
        LOGGER.error(['AIE7011'])
        PROJECT_PATH_WINDOWS = None  # FLAG

# The project's main directory. Attempt to find it if it isn't
try:
    ROOT_DIR = os.environ['PROJECT_DIR']
    LOGGER.trace(['AIE1010', 'match_true'], {'Dir': ROOT_DIR})
except KeyError:
    LOGGER.error(['AIE7010', 'match_false'])
    LOGGER.debug(['AIE4010'])

    if SYSTEM == "linux2":
        projectPath = PROJECT_PATH_LINUX
    elif SYSTEM == "win32":
        projectPath = PROJECT_PATH_WINDOWS
    elif SYSTEM == "Macintosh":
        LOGGER.critical(['AIE9100'])
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )
    else:
        LOGGER.critical(['AIE9100'], {'OS': SYSTEM})
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )
    LOGGER.info(['AIE5100'], {'OS':SYSTEM, 'path':projectPath})

    if os.path.isdir(projectPath):
        ROOT_DIR = projectPath
        LOGGER.info(["AIE5001", "match_true"], {'path':projectPath})
    else:
        LOGGER.critical(['AIE9101', 'match_false'])
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )

DEV_DIR = os.path.join(ROOT_DIR, "Pipeline", "the_LATEST")

# General-Use variables
PUBLISH_DIR = ROOT_DIR + os.sep + 'Reference'
CONFIG_DIR = DEV_DIR + os.sep + 'latest_CONFIG'

# File naming convention regex
SHOT = r's\d{3}'
USER = r'[\x00-\x7F]{6}\d{2}'
VERSION = r'\d{3}'
DESCRIPTION = r'[a-zA-Z]+'
INCREMENT = r'\d{4}'
FILETYPE = r'[a-zA-Z]+'
FULL_INPUT = r'(' + SHOT + r')' + r'_' + \
             r'(' + USER + r')' + r'_' + \
             r'(' + VERSION + r')' + r'_' + \
             r'(' + DESCRIPTION + r')' + r'.' + \
             r'(' + INCREMENT + r')' + r'.' + \
             r'(' + FILETYPE + r')'
RE_FILENAME_MATCH = re.compile(FULL_INPUT)
MATCH_MA = r'^s0(\d{2})_([\x00-\x7F]{6}\d{2})_(\d{3})_([a-zA-Z_]+?).(0\d{3}).([ma|mb|MA|MB]+)$'
# MATCH_MA = r'^s(\d{3})_'
RE_FILENAME_MATCH_MA = re.compile(MATCH_MA)
FILE_CONVENTION_EXAMPLE_S_HOU_001 = 's099_rsavag42_042_blazeit420.0001.hip'
FILE_CONVENTION_EXAMPLE_S_MYA_001 = 's001_jsmith20_010_someDescription.0001.mb'
FILE_CONVENTION_EXAMPLE_S_MYA_002 = 's017_ckenne24_099_description_withLots_of'\
                                    '_underScores.0001.MB'
FILE_CONVENTION_EXAMPLE_S_MYA_003 = 's017_ckenne24_099_description_withLots_of'\
                                    '_underScores.0001.ma'
FILE_CONVENTION_EXAMPLE_S_MYA_004 = 's017_ckenne24_099_description_withLots_of'\
                                    '_underScores.0001.MA'
FILE_CONVENTION_EXAMPLE_S_NUK_001 = 's001_jsmith20_010_someDescription_v0001.nk'
FILE_CONVENTION_EXAMPLE_S_NUK_002 = 's001_jsmith20_010_someDescription_v0001.NK'
FILE_CONVENTION_EXAMPLE = { 'Houdini': [FILE_CONVENTION_EXAMPLE_S_HOU_001],
                            'Maya': [FILE_CONVENTION_EXAMPLE_S_MYA_001, 
                                    FILE_CONVENTION_EXAMPLE_S_MYA_002,
                                    FILE_CONVENTION_EXAMPLE_S_MYA_003,
                                    FILE_CONVENTION_EXAMPLE_S_MYA_004],
                           'Nuke': [FILE_CONVENTION_EXAMPLE_S_NUK_001,
                                    FILE_CONVENTION_EXAMPLE_S_NUK_002]}
# example name: s001_ckenne24_010_someDescription.0001.ma
# Constants used in determining fileIO
PROJECT_AUTH_KEY = ""
LOCKED_NOTIFIER = ".lock"

# Supported Applications
with open(CONFIG_DIR + os.sep + 'supportedApplications.json') as f:
    SUPPORTED_APPLICATIONS = f.read()

SUPPORTED_APPLICATIONS = json.loads(SUPPORTED_APPLICATIONS)


# Supported ASCII-Based file types
FILETYPES_ASCII = ('.ma', '.MA',
                   '.nk' '.NK')
FILETYPES_IMG = ('.jpeg', '.JPEG',
                 '.png' '.PNG')

SUPPORTED_PLUGINS_MAYA = ('Mayatomr', 'fbxmaya', 'BifrostMain', 
                          'bifrostshellnode', 'bifrostvisplugin', 
                          'RenderMan_for_Maya')
FILETYPES_MAYA = ('.ma', '.MA', '.mb', '.MB')

# Misc OCD-related global vars
REGISTEREDADMINS = ('ckenne24')
ENV_VARS_MA = ('RMANTREE', 'RMSTREE', 'MAYA_MODULE_PATH', 'MAYA_SCRIPT_PATH',
               'MAYA_APP_DIR', 'RMANTREE', 'MAYA_MODULE_PATH', 'MAYA_LOCATION',
               'RMS_SCRIPT_PATHS', 'PIXAR_LICENSE_PATH', 'LD_LIBARY_PATH',
               'MAYA_PLUG_IN_PATH', 'XBMLANGPATH', 'PYTHONPATH', 'SYSMODULES', 
               'PROJECT_DIR', 'PIPELINE_DIR', 'MAYA_APP_NET_DIR', 'PYTHONPATH',
               'MI_CUSTOM_SHADER_PATH', 'XBMLANGPATH', 'LOG_CFG')

LINE_SEP = '='*80
SCRIPTEXIT = 'Script: "{s}" will now exit...'

if __name__ == "__main__":
    print(__doc__)
