#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
.. Project::
 Portal Origins: Part Two
.. Description::
 A list of constants that will be applied, project wide. The methods and
 variables defined here will keep scripts relative and cause system-wide
 changes, where appropriate
.. Author::
 Colin Kennedy

.. TO DO::
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
import fileio.controller.omnibus as omnibus
import fileio.controller.globerror as globerror

import logger.common.loggingServices as loggingservices
# LOGGER = loggingservices.Logger(loggingservices.RE_LOGGER_KEY_MATCH,
#                                 loggingservices.LOGGER_MESSAGE_CONFIG)

LOGGER = loggingservices.init_logger()

__author__ = "Colin Kennedy"
__copyright__ = "2016, Colin Kennedy"
__credits__ = ["emeth (SO Forums)"]
__license__ = "MIT"
__version__ = '1.3.1'  # odd numbered minor value means it's a 'dev' build
__maintainer__ = "Colin Kennedy"
__email__ = "colinvfx@gmail.com"
__status__ = "Production"


################################################################################
# SYSTEM-SPECIFIC VARIABLES
################################################################################
if "LOG_LEVEL" in os.environ:
    LOGGER.setLevel(os.environ['LOG_LEVEL'].lower().strip('"').strip("'"))
else:
    # user removed the log level status so they probably
    # wanted all of the messages to go away. Assume critical status only
    LOGGER.setLevel("critical")

if 'ADMIN_MODE' in os.environ and \
        (os.environ['ADMIN_MODE'].upper() == "TRUE" \
        or os.environ['ADMIN_MODE'].upper() == '"TRUE"'):
    # enables admin priveleges to any user on the project
    # useful but also a security vulnerability
    #
    USERNAME = "SUDO"
    LOGGER.info(['AIE5200', 'match_true'], {'user': getpass.getuser()})
elif getpass.getuser() is not None:
    LOGGER.trace(['AIE1000', 'match_true'], {"Username": getpass.getuser()})
    USERNAME = getpass.getuser()
else:
    LOGGER.critical(['AIE7000'], {'Username': getpass.getuser()})

if 'FTP_LOCK' in os.environ \
        and os.environ['FTP_LOCK'].upper().strip('"').strip("'") == "TRUE":
    FTP_LOCK = True
else:
    FTP_LOCK = False

HOSTNAME = socket.gethostname()
IPADDRESS = socket.gethostbyname(socket.gethostname())
if IPADDRESS.startswith('10.7'):
  NETWORKNAME = 'Montgomery Hall'
else:
  NETWORKNAME = IPADDRESS

SYSTEM = sys.platform
if not SYSTEM == 'linux2' and not SYSTEM == 'win32':
    LOGGER.critical(['AIE9003', 'match_false'], {'OS': SYSTEM})
    # ::: AUTHORNOTE::: :::TO DO::: CHANGE THIS TO APPLICATION-SPECIFIC SHUTDOWN
    sys.exit('OS NOT RECOGNIZED. '\
             'SCRIPT EXITTING...'.format(os.path.basename(__file__)))
else:
    LOGGER.trace(['AIE2102', 'match_true'], {'OS': SYSTEM})

DISALLOWED_FILEPATH_CHARACTERS = ('>', '<', '(', ')', '/', '?', '"', "'", '\\',
                                  '|', '{', '}', '$', '%', '^')

SUPPORTED_OS_LIST = ["linux2", "win32"]
PROJECT_ROOT_WIN = "I:\\Savannah\\CollaborativeSpace"
PROJECT_ROOT_LIN = os.path.join("/home", USERNAME, "mount", "collaborative")

################################################################################
# GLOBAL USERS/CREW INFO
################################################################################
# :AUTHORNOTE: Make sure the to use os.path.expanduser and have fallbacks
# in case that doesn't worl https://docs.python.org/2/library/os.path.html
CREWSHEET = ""
if 'PIPELINE_DIR' in os.environ:
        CREWSHEET = os.path.join(os.environ['PIPELINE_DIR'],
                         'latest_CONFIG',
                         'conf_DATA',
                         'crew_sheet.json')
elif 'PROJECT_DIR' in os.environ and \
        'Pipeline' in os.listdir(os.environ['PROJECT_DIR']):
    CREWSHEET = os.path.join(os.environ['PROJECT_DIR'],
                             'Pipeline',
                             'the_LATEST',
                             'latest_CONFIG',
                             'conf_DATA',
                             'crew_sheet.json')
else:
    LOGGER.critical(['AIE9103', 'match_false'],
                    {'script': os.path.basename(__file__)})

################################################################################
# PROJECT SPECIFIC
################################################################################
PROJECT_CONFIG = os.path.join(os.environ['PIPELINE_DIR'],
                              'latest_CONFIG' ,'conf_DATA', 'project_config.json')
with open(PROJECT_CONFIG, 'r') as f:
    data = json.load(f)

PROJECT_NAME_LONG = data["PROJECT_NAME_LONG"]
PROJECT_NAME_SHORT = data["PROJECT_NAME_SHORT"]
BUG_REPORT_PAGE = data["BUG_REPORT_PAGE"]
FEATURE_REQUEST_PAGE = data["FEATURE_REQUEST_PAGE"]
WELCOME_PAGE = data["WELCOME_PAGE"]
FILE_NAMING_CONVENTION_PAGE = data["FILE_NAMING_CONVENTION_PAGE"]
CHANGELOG_URL = data["CHANGELOG_URL"]
# The project's main directory. Attempt to find it if it isn't
try:
    ROOT_DIR = os.environ['PROJECT_DIR']
    DEV_DIR = os.environ['PIPELINE_DIR']
    LOGGER.trace(['AIE1010', 'match_true'], {'Dir': ROOT_DIR})
    LOGGER.trace(['AIE1010', 'match_true'], {'Dir': DEV_DIR})
except KeyError:
    LOGGER.error(['AIE7010', 'match_false'])
    LOGGER.debug(['AIE4010'])

# General-Use variables
# PUBLISH_DIR = ROOT_DIR + os.sep + 'Reference'
CONFIG_DIR = DEV_DIR + os.sep + data['CONFIG_FOLDER_NAME']
REGISTERED_ADMINS = ('ckenne24', 'selecaotwo', 'SUDO')
EDIT_FOLDER_NAME = data['EDIT_FOLDER_NAME']  # Where scene folders are placed
EDIT_DIR = os.path.join(ROOT_DIR, EDIT_FOLDER_NAME)
FINAL_DIR = os.path.join(ROOT_DIR, "Final")
FINAL_FOOTAGE_DIR = os.path.join(FINAL_DIR, "Footage")
MESSAGE_DIR = os.path.join(DEV_DIR, data['MESSAGE_FOLDER_NAME'])
CHANGELOG_DIR = os.path.join(MESSAGE_DIR, "mess_CHANGELOG")
NUKE_DIR = os.path.join(DEV_DIR, "latest_NUKE")
if not os.path.isdir(EDIT_DIR):
    # Check for folder containing scenes
    raise globerror.ExitApplicationError('Edit folder: {f} does not '
                                         'exist'.format(f=EDIT_DIR))
# REGISTERED_ADMINS = ('asdf', 'SUDO')
ADMIN_CONTACT_INFO = "name: Colin Kennedy, "\
                     "email: colinvfx@gmail.com,"\
                     " phone: 203-722-6620"

# with open(os.path.join())
# BLACKLIST_FILES = [os.path.join()]

FORCE_SAVE = os.environ.get("FORCE_SAVE", "").strip('"')

if FORCE_SAVE.upper() == "ON":
    FORCE_SAVE = True
elif FORCE_SAVE.upper() == "OFF":
    FORCE_SAVE = False
elif FORCE_SAVE == "":
    FORCE_SAVE = False
else:
    raise globerror.ExitApplicationError('Force Save: {f!r} did not get a valid '
                                         'option'.format(f=FORCE_SAVE))


################################################################################
# CURRENT USER INFO
################################################################################
CREW_PREFS_DIR_LOC = os.path.join(DEV_DIR, "latest_CONFIG", "conf_DATA", "users")
CREWMEMBER_PREFERENCES_LOC = os.path.join(CREW_PREFS_DIR_LOC, USERNAME + ".json")
try:
    with open(CREWSHEET, 'r') as f:
        crewdata = json.load(f)
    CREW_SHEET_INFO = crewdata
    CREW_MEMBER_INFO = crewdata[getpass.getuser()]
except (IOError, KeyError):
    raise globerror.ExitApplicationError("The current user, {} is not properly "
                                         "configured in the environment. "
                                         "Missing in the crewsheet."
                                         "".format(USERNAME))
try:
    with open(CREWMEMBER_PREFERENCES_LOC, "r") as f:
        data = json.load(f)
    CREWMEMBER_PREFERENCES = data
except IOError:
    # all the scripts that use this will auto-init it if it doesn't exist so
    # it's okay if there isn't a preference file on load
    #
    pass

BLACKLIST = None
if "BLACKLIST" in CREW_MEMBER_INFO:
    BLACKLIST = CREW_MEMBER_INFO['BLACKLIST']
BLACKLISTED_PLUGINS_NK = ['PLUGINS', 'NUKE']

################################################################################
# NAMING CONVENTION REGEX
################################################################################
GENERIC_ALLOWED_EXTENSIONS = ['ma', 'nk', 'hip', 'hipnc', 'tiff', 'exr', 'bgeo\.sc']
_EXT = "(?P<extension>({ext})+)$".format(ext='|'.join(GENERIC_ALLOWED_EXTENSIONS))
SHOT_MATCH_PATTERN = r"""
                      ^((?P<filenamePrefix>_+)?(?P<shotPrefix>s0)(?P<shot>\d{2})(?P<shotRevision>[A-Z]{1,2})?
                      (?P<shotRedraftWrapper>_v(?P<shotRedraft>\d+)_)?(?P<shotSuffix>_))?
                      """
MATCH_RE = SHOT_MATCH_PATTERN + \
            r'''
             (?P<user>[a-zA-Z]{4,8}(\d{2})?)(?P<userSuffix>_)
             (?P<version>0\d{2})(?P<versionRevision>[A-Z])?(?P<versionSuffix>_)
             (?P<type>[A-Z]{3,5})
             ((?P<descriptionPrefix>_)(?P<description>[a-zA-Z]+)?)?
             ((?P<incrementPrefix>_v|.)(?P<increment>(0\d{3}|\#+|\$F\d+|\%0\d+d))(?P<incrementRevision>[A-Z])?)(?P<incrementSuffix>.)
             ''' + _EXT
RE_FILENAME_MATCH = re.compile(MATCH_RE, re.VERBOSE)

SCENE_DESCRIPTION_TYPES = ("ma", "nk", "hip", "hipnc")
FINAL_ASSETS_FILETYPES = [# Scene files
                          'dvr',
                          # Image formats
                          'tiff', 'tif', 'jpeg', 'jpg', 'exr', 'png', 'tga',
                          'hdr',
                          # Video formats
                          'mov', 'mp4', 'dng', 'avi',
                          # Sound formats
                          'mp3', 'aiff', 'wav',
                          # Script types
                          'py', 'mel', 'c', 'h', 'cpp', 'cc', 'rst',
                          # Data formats
                          "yaml", "json",
                          # Adobe formats
                          'psd', 'ai',
                          # 3D
                          'fbx', 'abc', 'obj'
                          # Production
                          'doc', 'docx', 'xlsx', 'ppt', 'pptx', 'pdf',
                          # Compressed formats
                          'zip', '7z', 'rar', 'tar', 'tar.gz',
                          # Misc
                          'txt'
                          ] + list(SCENE_DESCRIPTION_TYPES)

FINAL_ASSETS_FILETYPES_STR = '|'.join(FINAL_ASSETS_FILETYPES)
# MATCH_FINAL_RE = r'''
#                   ^((_+)FIN_)
#                   (?P<user>[\x00-\x7F]{4,6}\d{2})_
#                   (?P<type>[A-Z]{3,5})
#                   (_(?P<description>[a-zA-Z_]+)?)?
#                   (?P<increment>0\d{3}(?P<incrementRevision>[A-Z])?).
#                   (?P<extension>[ma|mb|MA|MB|nk|NK|hip|HIP|hipnc|HIPNC]+)$
#                   '''
FINAL_EXTENSION_LIST = '(?P<extension>[{f}]+)$'.format(f='|'.join(FINAL_ASSETS_FILETYPES))
MATCH_FINAL_RE = r'''
                  # ^((_+)(?P<phase>[FIN|UNAPPROVED])_)
                  ^((_+)(?P<phase>(FIN|UNAPPROVED))_)
                  (?P<user>[\x00-\x7F]{6}\d{2})_
                  (?P<type>[A-Z]{3,5})
                  (_(?P<description>[a-zA-Z_]+)?)?
                  (?P<increment>0\d{3}(?P<incrementRevision>[A-Z])?)?.
                  ''' + FINAL_EXTENSION_LIST
# string1 = "_FIN_ckenne24_MODEL_Name0001.ma"
# string1 = "_UNAPPROVED_ckenne24_MODEL_0123.ma"
RE_FINAL_FILENAME_MATCH = re.compile(MATCH_FINAL_RE, re.VERBOSE)
# MATCH = re.match(RE_FILENAME_MATCH, string1)
FILE_CONVENTION_EXAMPLE_S_HOU_001 = 's099_rsavag42_042_blazeit420.0001.hip'
FILE_CONVENTION_EXAMPLE_S_MYA_003 = 's017_ckenne24_099_description_withLots_of'\
                                    '_underScores.0001.ma'
FILE_CONVENTION_EXAMPLE_S_NUK_001 = 's001_jsmith20_010_someDescription_v0001.nk'
FILE_CONVENTION_EXAMPLE_S_NUK_002 = 's001_jsmith20_010_someDescription_v0001.NK'
FILE_CONVENTION_EXAMPLE = { 'Houdini': [FILE_CONVENTION_EXAMPLE_S_HOU_001],
                            'Maya': [FILE_CONVENTION_EXAMPLE_S_MYA_003],
                           'Nuke': [FILE_CONVENTION_EXAMPLE_S_NUK_001,
                                    FILE_CONVENTION_EXAMPLE_S_NUK_002]}
ITYP_LIST = [
             # Composite
             'COMP',
             'OUTPT',
             'PASS',
             'PLTBG',
             'PLTFG',
             'VFX',
             'VFXA',
             # Agnostic
             'BOARD',
             'REF',
             'TEX',
             'MOCAP',
             'MODEL',
             'LIGHT',
             # Production

             'DOC',
             # Sound
             'FOLEY',
             'SFX',
             'MUSIC']
# example name: s001_ckenne24_010_someDescription.0001.ma
# Constants used in determining fileIO
PROJECT_AUTH_KEY = ""
LOCKED_NOTIFIER = ".lock"

################################################################################
# SUPPORTED APPLICATIONS
################################################################################
with open(os.path.join(CONFIG_DIR, "conf_DATA",
                       'supportedApplications.json')) as f:
    SUPPORTED_APPLICATIONS = f.read()

SUPPORTED_APPLICATIONS = json.loads(SUPPORTED_APPLICATIONS)['Supported Applications']
SUPPORTED_APPLICATIONS = [str(os.path.normpath(x)) if os.path.isfile(x) or os.path.isdir(x)
                          else str(x) for x in SUPPORTED_APPLICATIONS]

SUPPORTED_APPLICATIONS = [x.replace("$USER", USERNAME) if "$USER" else x for x in SUPPORTED_APPLICATIONS]
LOGGER.info(SUPPORTED_APPLICATIONS)
SUPPORTED_APPLICATION_NAMES = ["houdini", "maya", "nuke"]

# print SUPPORTED_APPLICATIONS
if "APP_EXECUTABLE" in os.environ:
    os.environ['APP_EXECUTABLE'] = os.environ['APP_EXECUTABLE'].strip('"')
    if not os.path.isfile(os.environ['APP_EXECUTABLE']) \
            and not omnibus.is_executable(os.environ['APP_EXECUTABLE']):
        LOGGER.error(['AIE7701'], {'app': os.environ['APP_EXECUTABLE']})
        raise globerror.ExitApplicationError("{} not in allowed in current environment".format(os.environ['APP_EXECUTABLE']))
    if os.environ['APP_EXECUTABLE'] not in SUPPORTED_APPLICATIONS:
        LOGGER.critical(['AIE9900'], {"app": os.environ['APP_EXECUTABLE'],
                                      "supported_app": SUPPORTED_APPLICATIONS,
                                      "proj": PROJECT_NAME_LONG})
        raise globerror.ExitApplicationError("{} not in allowed in current environment".format(os.environ['APP_EXECUTABLE']))

################################################################################
# ASCII-BASED FILE TYPES
################################################################################
FILETYPES_ASCII = ('.ma', '.MA',
                   '.nk' '.NK')
FILETYPES_IMG = ('.jpeg', '.JPEG',
                 '.png' '.PNG')

SUPPORTED_PLUGINS_MAYA = ('Mayatomr', 'fbxmaya', 'BifrostMain',
                          'bifrostshellnode', 'bifrostvisplugin',
                          'RenderMan_for_Maya')
FILETYPES_HOUDINI = (".HIP", ".HIPNC")
FILETYPES_MAYA = ('.MA', '.MB')
FILETYPES_NUKE = (".NK")

# MAYA related glob
GLOB_SCENE_NODE = "MKSMGDescription1"
CONF_H = os.path.join(os.environ['PIPELINE_DIR'], "latest_CONFIG",
                      "conf_DATA", "scene_description_defaults.json")
GLOB_ERROR_MSG = "User blocked from the attempted operation"  # default message
ALL_KEY = "all"
APP_KEY_MA = "maya"

################################################################################
# MISC OCD-GLOB-VARS
################################################################################
ENV_VARS_MA = ('RMANTREE', 'RMSTREE', 'MAYA_MODULE_PATH', 'MAYA_SCRIPT_PATH',
               'MAYA_APP_DIR', 'RMANTREE', 'MAYA_MODULE_PATH', 'MAYA_LOCATION',
               'RMS_SCRIPT_PATHS', 'PIXAR_LICENSE_PATH', 'LD_LIBARY_PATH',
               'MAYA_PLUG_IN_PATH', 'XBMLANGPATH', 'PYTHONPATH', 'SYSMODULES',
               'PROJECT_DIR', 'PIPELINE_DIR', 'MAYA_APP_NET_DIR', 'PYTHONPATH',
               'MI_CUSTOM_SHADER_PATH', 'XBMLANGPATH', 'LOG_CFG')

LINE_SEP = '='*80
SCRIPTEXIT = 'Script: "{s}" will now exit...'

################################################################################
# CHECK FOR ENVIRONMENT-BREAKING PROBLEMS
################################################################################

# def is_allowed_application(self):
#     """
#     Checks the current application against the list of allowed applications
#     """

if __name__ == "__main__":
    #print(__doc__)
    pass
