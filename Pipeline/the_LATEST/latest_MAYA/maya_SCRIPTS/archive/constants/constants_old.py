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
"""

# IMPORT STANDARD LIBRARIES
import os
import re
import json
import platform

# User directory
# AUTHOR NOTE: Make sure the to use os.path.expanduser and have fallbacks
# in case that doesn't worl https://docs.python.org/2/library/os.path.html

# System-specific variables
"""
PROJECT_PATH_WINDOWS = os.path.join(os.environ['HOME'],
                                    'CollaborativeSpace',
                                    'portal-origins-part-2')
PROJECT_PATH_LINUX = os.path.join(os.environ['HOME'],
                                  'CollaborativeSpace',
                                  'portal-origins-part-2')

USER = os.environ['HOME']
"""

# ::KeyReplace: Temporary variables until I find something better
USER = "null"
PROJECT_PATH_WINDOWS = os.path.join('I:', 'Savannah',
                                    'CollaborativeSpace',
                                    'portal-origins-part-2')
# ::KeyReplace: Find a different variable for user Replace use
PROJECT_PATH_LINUX = os.path.join('home', USER, 'media', 'Collaborative',
                                  'portal-origins-part-2')

# The project's main directory
try:
    ROOT_DIR = os.environ['POP2_PROJECT_DIR']
    print('[+] Project directory found at path, "{p}"').format(p=ROOT_DIR)
except KeyError:
    message = '[-] POP2_PROJECT_DIR was not found. Environment may not run'\
              ' as expected'
    print(message)

    operatingSystem = platform.system()
    if operatingSystem == "Linux":
        projectPath = PROJECT_PATH_WINDOWS
    elif operatingSystem == "Windows":
        projectPath = PROJECT_PATH_LINUX
    elif operatingSystem == "Macintosh":
        projectPath = "[-] Macintosh is not supported"
    else:
        projectPath = "[-] {os} is not supported".format(os=operatingSystem)

    print("{os} operating system detected".format(os=operatingSystem))
    message = '[-] No project dir was found. Attempting to resolve '\
              'directory using path. "{path}"'.format(os=operatingSystem,
                                                      path=projectPath)
    print(message)

    if os.path.isdir(projectPath):
        ROOT_DIR = projectPath
        message = '[+] Project path was successfully '\
                  'resolved using {p}'.format(p=projectPath)
    else:
        message = '[-] Attempt to resolve the project path failed. Please'\
                  ' contact the system admin or TD on the project'
        print(message)
        # AUTHOR NOTE: The script should exit here

DEV_DIR = ROOT_DIR + os.sep + "Pipeline"

# General-Use variables
CONFIG_DIR = DEV_DIR + os.sep + 'my_CONFIG'
PUBLISH_DIR = ROOT_DIR + os.sep + 'Reference'

# File naming convention regex
SHOT = r'[a-zA-Z]\d{3}'
USER = r'[\x00-\x7F]{6}\d{2}'
VERSION = r'\d{3}'
DESCRIPTION = r'[a-zA-Z]+'
INCREMENT = r'\d{4}'
FILETYPE = r'.[a-zA-Z]+'
FULL_INPUT = r'(' + SHOT + r')' + r'_' + \
             r'(' + USER + r')' + r'_' + \
             r'(' + VERSION + r')' + r'_' + \
             r'(' + DESCRIPTION + r')' + r'.' + \
             r'(' + INCREMENT + r')' + r'.' + \
             r'(' + FILETYPE + r')'
RE_FILENAME_MATCH = re.compile(FULL_INPUT)

# Constants used in determining fileIO
POP2_AUTH_KEY = ""
LOCKED_NOTIFIER = ".lock"

# Supported Applications
with open(CONFIG_DIR + os.sep + 'supportedApplications.json') as f:
    SUPPORTED_APPLICATIONS = f.read()

SUPPORTED_APPLICATIONS = json.loads(SUPPORTED_APPLICATIONS)

# Supported ASCII-Based file types
FILETYPES_ASCII = ('.ma', '.MA',
                   '.nk' '.NK')
FILETYPES_SRC = ('.jpeg', '.JPEG',
                 '.png' '.PNG')

# Misc OCD-related global vars
LINE_SEP = '='*80

if __name__ == "__main__":
    print(__doc__)

