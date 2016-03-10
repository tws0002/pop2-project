#!/usr/bin/python

"""\
..Project::
 Portal Origins: Part Two
..Description::
 Main implementation file to checkout files for Maya, Nuke, and Houdini
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os

# IMPORT THIRD PARTY LIBRARIES 
# import maya.standalone  # These modules combined take 4 seconds to read
# import maya.OpenMaya as OpenMaya # These modules combined take 4 seconds to read

# IMPORT LOCAL LIBRARIES
from fileio.controller import checkout_0001 as checkout
from constants.model import constants as consts

def open_file_maya(fileName, filePath):
    """
    --- Get file name - check for file
    --- Check for lock
     --- if locked and the person who locked it is them, let them in and return
     -/ if locked, give them a message screen, showing person's contact info
     -/ ask if they want to request access from them - if yes, email/slack
    -/ if not locked, open maya and create a locked version of the file
     -/ add the person's contact info in the locked file

    :returns: The status of the opened file - True, False, or None
    :rtype: bool or NoneType
    """
    fileIO = checkout.FileCheckoutMaya(fileName, filePath)

    if not os.path.isfile(fileIO.fullPath) or \
       not fileIO.fullPath.endswith(consts.FILETYPES_MAYA):
        print("AUTHOR NOTE: Add to logger")
        print('The following file, "{f}", is not a valid Maya '\
              'file'.format(f=fileIO.fullPath))
        return None

    if fileIO.is_locked() and \
                not fileIO.get_contact_info()['USER'] == consts.USERNAME:
        # TODO: open Qt object to display message - add lockedFileData contents
        return False

    # TODO:
    # open Maya file
    fileIO.open_file()
    fileIO.set_contact_info()
# end open_file_maya

def main():
    fileName = "s001_ckenne24_010_someDescription.0002.ma"
    filePath = "/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/sys_PY/py_MODULES/fileio/test/test_file_checkout_project/scenes"
    open_file_maya(fileName, filePath)

    Logger().debug('asdfsadfasdf')

if __name__ == "__main__":
    print(__doc__)
