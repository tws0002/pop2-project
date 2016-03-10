#!/usr/bin/env python

"""
..Project::
 Portal Origins: Part Two
..Description::
 Checkout contains general methods for reading and writing to files using
 globally defined variables from the root project directory
..Author::
 Colin Kennedy

..Improvements::
 - Add named regex groups, instead of querying values as [0]. [1], [2], etc
..::TO DO::
 - Add a check to make sure that people are 
  A. using a registered username for the group 
  B. That they're using a registered PREFIX in beginning of the description
"""

# IMPORT STANDARD LIBRARIES
import os, sys
import re
import json  # data handling
import socket  # for determining remote user access
import subprocess  # for calling applications from the command-line
import ntpath  # to allow OS-independent filepath leafing

# IMPORT THIRD PARTY LIBRARIES
from pprint import pprint
sys.path.append(r"C:\Python27")
sys.path.append(r"C:\Program Files\Autodesk\Maya2016\Python\Lib\site-packages")
sys.path.append(r"C:\Program Files\Autodesk\mentalrayForMaya2016\scripts\mentalray")
sys.path.append('/usr/autodesk/maya/lib/python2.7/site-packages')
sys.path.append('/usr/autodesk/mentalrayForMaya2016')
# import maya.standalone
# import maya.OpenMaya as OpenMaya
# Error on Linux
# https://software.intel.com/en-us/forums/intel-threading-building-blocks/topic/297307
# http://stackoverflow.com/questions/19585302/linking-shared-libraries-to-c-project-on-the-cluster

# import pymel.core as pm

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from constants.model.constants import LOGGER

MAYA_EXEC_LOCATION = os.path.join(consts.ROOT_DIR, 'Pipeline', 'the_LATEST', 
                                  'latest_CONFIG', 'conf_SCRIPTS')

def path_leaf(path):
    """
    Return path sep for all OSes, on all OSes
    Reference: http://stackoverflow.com/questions/8384737
    """
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)
# end path_leaf

class FileIO(object):
    """
    Generic File read/write class that works universally on all files
    """
    def __init__(self, filePath):
        """
        Initialize class with the file name, path, full path, and extension and
        other relevant information about the file

        :key fileName: Name of the file
        :key filePath: The full path of the file
        :type fileName: str
        :type filePath: str

        :returns: FileIO class
        :rtype: <FileIO>
        """
        super(FileIO, self).__init__()
        self.fileName = path_leaf(filePath)
        self.filePath = filePath[:(-1 * len(self.fileName))]
        self.fullPath = filePath
        self.extension = os.path.splitext(self.fileName)
    # end __init__
    def save_file(self):
        """
        File read method
        """
        pass
    # end save_file
    def open_file(self):
        """
        File open method
        """
        pass
    # end open_file
    def is_empty(self):
        """
        Checks for an empty file

        :returns: Whether or not the file is empty or None
        :rtype: bool or NoneType
        """
        try:
            if os.stat(self.fullPath).st_size > 0:
                return False
            else:
                return True
        except OSError:
            LOGGER.error(['AIE7900', 'match_false', {'file': self.fullPath}])
            return None
    # end is_empty
    def __repr__(self):
        """
        An unambiguous print of class FileIO, used for logging/debugging
        """
        return "FileIO(fullpath=%r)" % (self.fullPath)
    # end __repr__
    def __str__(self):
        """
        Prints out a string method for the FileIO class
        """
        return self.fullPath
    # end __str__
    @property
    def is_character_limit(self):
        """
        Checks if the file path is too long for the current OS. The file is
        still readable but this check is done to make sure that the file can
        still be copied/pastied without losing its properties
        """
        system = sys.platform
        if system  == "win32":
            LOGGER.info(["AIE2102"], {'OS': system})
            maxLength = 260
        elif system == "linux2" or "Mac":
            LOGGER.info(["AIE2102"], {'OS': system})
            maxLength = 255
        else:
            LOGGER.error(["AIE9102"], {'OS': system})

        if len(self.fullPath) > maxLength:
            LOGGER.warning(["AIE6500"], {'string': sell.fullPath, 
                                         "length": maxLength})            
            return True

        LOGGER.debug(['AIE4500'], {'string': self.fullPath, 'OS': system, 
                                   'max length': maxLength})
        return False
    # end is_character_limit
    @property
    def is_farm_character_limit(self):
        """

        ::AUTHOR NOTE::
        ::TO DO::
         I need to determine the character limit for the farm first
        """
        return False
    # end is_farm_character_limit
# end FileIO

class FileCheckout(FileIO):
    """
    An elevated generic class that contains methods for interfacing between
    the local user and the project's network directory

    :returns: FileCheckout class
    :rtype: <FileCheckout>
    """
    def __init__(self, filePath):
        super(FileCheckout, self).__init__(filePath)
        self.systemOS = ''
        self.fullPathUnpacked = ''
        self._allow_save = True
        self._is_registered = False
    # end __init__
    def check_naming_convention(self, regex, override=False):
        """
        Checks the given filename for a proper naming convention

        :type regex: <type '_sre.SRE_Pattern'>
        :returns: A Tuple including the shot, user, version, description,
                  increment, and file-type of the given fileName input
        :rtype: tuple

        ..AUTHOR NOTE::
         Not done
        """
        if override:
            return True  # a quick check to pass the naming convention test

        if regex == "":
            print("I really need to add a exception log statement for this")
            return False

        match = re.match(regex, self.fileName)

        if match is None:
            LOGGER.info([x for x in self.get_naming_convention_examples()])
            dictTemp = {'match': match, 'f': self.fileName,
                        'convention': consts.FULL_INPUT}
            # LOGGER.error(['AIE6601','match_false'], dictTemp )
            return None

        LOGGER.info(['AIE5600'], {'match': match, 'f': self.fileName, 
                                 'return': match.groups()})

        regexOutput = match.groups()

        if len(regexOutput) < 5:
            return None

        self.extension = regexOutput[5]
        self.shot = regexOutput[0]
        self.user = regexOutput[1]
        self.version = regexOutput[2]
        self.description = regexOutput[3]
        self.increment = regexOutput[4]
        self.lockedName = self.fullPath + consts.LOCKED_NOTIFIER

        LOGGER.debug(['AIE4600'], {'ext': self.extension, 'file': self.fileName})
        LOGGER.debug(['AIE4601'], {'shot': self.shot, 'file': self.fileName})
        LOGGER.debug(['AIE4602'], {'user': self.user, 'file': self.fileName})
        LOGGER.debug(['AIE4603'], {'version': self.version, 'file': self.fileName})
        LOGGER.debug(['AIE4604'], {'description': self.description, 
                                   'file': self.fileName})
        LOGGER.debug(['AIE4605'], {'increment': self.increment, 
                                   'file': self.fileName})

        return regexOutput
    # end check_naming_convention
    def get_naming_convention_examples(self):
        """
        Shows all of the most up-to-date examples of naming conventions allowed
        on the project
        """
        for key, item in consts.FILE_CONVENTION_EXAMPLE.iteritems():
            for item_h in item:
                yield ' '.join([key, ':', item_h])
    # end get_naming_convention_examples
    def save():
        """
        The contents of a generic file save command
        """
        pass
    # end save
    def save_file(self):
        """
        Attempts to save a generic file but checks if the file is locked first
        """
        if not self.is_locked():
            LOGGER.trace(["AIE5602"], {"file": self.fullPath})
            LOGGER.trace(["AIE1601"], {"file": self.fullPath})
            self.save()
            return True
        elif self.is_locked() and self.get_contact_info()['USER'] == \
                                                            consts.USER:
            LOGGER.warning(['AIE6600'], {"file": self.fullPath})        
            LOGGER.trace(["AIE5601"], {"file": self.fullPath})
            LOGGER.trace(["AIE1601"], {"file": self.fullPath})
            self.save()
            return True

        LOGGER.error(["AIE5601"], {'file': self.fullPath})
        return False
    # end save_file
    def open(self):
        """
        The contents of a generic file open command
        """
        pass
    # end open
    def open_file(self):
        """
        Attempts to open a generic file but checks if the file is locked first
        """
        if not os.path.isfile(self.fullPath):
            LOGGER.error(["AIE7602"], {"file": self.fullPath})
            return False

        if not self.is_locked():
            LOGGER.trace(["AIE5602"], {"file": self.fullPath})
            LOGGER.trace(["AIE1602"], {"file": self.fullPath})
            self.open()  # customized open method
            return True
        elif self.is_locked() and self.get_contact_info()['USER'] == \
                                                            consts.USER:
            LOGGER.trace(["AIE1602"], {"file": self.fullPath})
            LOGGER.warning(['AIE6600'], {"file": self.fullPath})
            self.open()  # customized open method
            return True

        LOGGER.info(["AIE5601"], {'file': self.fullPath})
        return False
    # end open_file
    def get_path_os(self):
        """
        Unintelligent module for testing if a string is meant for a certain 
        operating system. The method does not use the os module, because os.path
        assumes that the string you're querying works with your operating system
        """
        if fileIO.fullPath.startswith('/'):
            systemOS = 'linux2'
            fileIO.systemOS = systemOS
            return systemOS
        else:
            systemOS = 'win32'
            fileIO.systemOS = systemOS
            return systemOS
    # end get_path_os
    def split_folders(self):
        """
        Unintelligent folder path split method that does not assume 
        the current user's OS
        """
        self.fullPathUnpacked
        fields = re.split(r'(/|\\\\|\\)\s*', line)

        removalMarkers = ('/', '\\', '\\\\', '')
        # print [i for j, i in enumerate(fields) if j not in removal]
        folderPaths = [j for i, j in enumerate(fields) if j not in removal]

        if sys.platform == "win32":
            folderPaths = os.path.join(fields)
        elif sys.platform == "linux2":
            folderPaths = '/' + os.path.join(fields)
        else:
            "not sure what OS you're using"

        return folderPaths
    # end split_folders
    def is_locked(self):
        """
        Looks to see if the file being queried is currently being accessed
        over the network

        :returns: True/False or None
        :rtype: bool or NoneType
        """
        if os.path.isfile(self.lockedName):
            LOGGER.info(['AIE5601', 'match_true'], {'file': self.fullPath})
            return True

        LOGGER.info(['AIE5602', 'match_false'], {'file': self.fullPath})
        return False
    # end is_locked
    @property
    def allow_save(self):
        """
        Changes the permissions on the file, determining whether or not the user
        is allowed to save in the current session
        """
        return self._allow_save
    # end allow_save.property
    @allow_save.setter
    def allow_save(self, value):
        """
        Set method for the allow_save property
        """
        self._allow_save == value
    # end allow_save.setter
    @allow_save.deleter
    def allow_save(self):
        """
        Delete method for the allow_save property
        """
        del self._allow_save
    # end allow_save.setter
    # end allow_save
    @property
    def is_registered(self):
        """
        Check if the user is part of the project
        """
        regUserPath = os.path.join(consts.ROOT_DIR,
                                   'Pipeline', 'the_LATEST', 
                                   'latest_CONFIG', 'conf_INFO')

        with open(regUserPath + os.sep + 'project_member_information.json', "r") as f:
            dataOutput = f.read()

        regUserInformation = json.loads(dataOutput)
        if consts.USERNAME in regUserInformation['USERS']:
            self._is_registered = True
        else:
            self._is_registered = False

        return self._is_registered
    # end is_registered.property
    @is_registered.setter
    def is_registered(self):
        """
        Setter method for is_registered. Adds users to the specified key if True. Removes them if it is False
        """
        pass
    # end is_registered.setter
    @is_registered.deleter
    def is_registered(self):
        """
        asdfsadfdsa
        """
        pass
    # end is_registered.deleter
    # end is_registered
# end FileCheckout

class FileCheckoutMaya(FileCheckout):
    def __init__(self, filePath):
        super(FileCheckoutMaya, self).__init__(filePath)
        # self.initialize()
        # self.load_plugins()
        # import pymel.core as pm
        # self.fileStringInputInfo = {pm.nodetypes.CacheFile: "cachePath",
        #                             pm.nodetypes.AlembicNode: "abc_File",
        #                             pm.nodetypes.DiskCache: "cacheName",
        #                             pm.nodetypes.File: "fileTextureName",
								#     pm.nodetypes.PxrTexture: "filename",
        #                             pm.nodetypes.PxrBump: "filename",
        #                             pm.nodetypes.PxrStdEnvMapLight: "rman__EnvMap"}
        # self.fileStringInputTypes = tuple((element for tupl in 
        #                                    self.fileStringInputInfo.items() 
        #                                    for element in tupl))[::2]
    # end __init__
    def open(self):
        """
        Open command for a Maya session

        ..To Do:
         Add an exception case for invalid file types, so the command doesn't
         fail mid-execution
        """
        if consts.SYSTEM == 'linux2':
            scriptEnding = '.sh'
        else:
            scriptEnding = '.bat'

        LOGGER.info(["MYA5700"], {"file": self.fullPath})
        # subprocess.call('{exec} -o {f}'.format(exec=MAYA_EXEC_LOCATION + os.sep + 
        #                                    pop2_maya + scriptEnding,
        #                               f=self.fullPath))
    # end open
    def save(self):
        """
        Custom Maya-based save command
        """
        pass
    # end save
    def initialize(self):
        """
        Opens Maya from the python command-line directly, using maya.standalone
        """
        # maya.standalone.initialize("Python")
        pass
    # end initialize
    def is_maya_file(self):
        """
        Checks if the file input is a valid Maya file, available for opening

        ..To Do::
         Create an exception case - if the path is not openable, then you know
         it is not a valid maya file

        ..Considerations::
         AUTHOR NOTE: Temporarily applying paths to system. Change these into
         temporary env vars later
        """
        LOGGER.trace(["MYA1700"], {'file': self.fullPath})
        # import maya.cmds as cmds  # must be imported in-line, after initialization

        self.plugins_load()

        # Open your file
        try:
            opened_file = cmds.file(self.fullPath, o=True)
            LOGGER.info(["MYA5701"], {"file", self.fullPath})
            LOGGER.info(["MYA5702"], {"file", self.fullPath})
            return True
        except RuntimeError:
            LOGGER.info(["MYA5703"], {"file", self.fullPath})
            LOGGER.error(["MYA7700"], {"file", self.fullPath})
            return False
        maya.standalone.uninitialize()
    # end is_maya_file
    def load_plugins(self):
        """
        Generic method for batch loading all maya plugins for the current project
        """
        import maya.cmds as cmds
        for plugin in consts.SUPPORTED_PLUGINS_MAYA:
            LOGGER.info(['MYA5900'], {'plugin': plugin, 'file': self.fullPath})
            cmds.loadPlugin(plugin)  # load any required plugs here
    # end load_plugins
    def is_maya_file_fast(self):
        """
        Less intelligent alternative to checking the maya file. Useful if the
        file that is being checked is very large or has a long read time.
        """
        if self.fullPath.endswith(consts.FILETYPES_MAYA):
            LOGGER.info(["MYA5702"], {"file": self.fullPath})
            return True
        else:
            LOGGER.info(["MYA5703"], {"file": self.fullPath})
            return False
    # end is_maya_file_fast
    def uninitialize(self):
        # import maya.standalone
        LOGGER.trace(["MYA1701"], {'file': self.fullPath})
        maya.standalone.uninitialize()
    # end uninitialize
# end FileCheckoutMaya

class FileCheckoutNuke(FileCheckout):
    def __init__(self, filePath):
        super(FileCheckoutNuke, __init__).__init__(self)
    # end __init__
    def open():
        """
        Custom Maya-based open command
        """
        pass
    # end open
    def save():
        """
        Custom Maya-based save command
        """
        pass
    # end save
# end FileCheckoutNuke

class FileCheckoutHoudini(FileCheckout):
    def __init__(self, filePath):
        super(FileCheckoutHoudini, __init__).__init__(self)
    # end __init__
    def open():
        """
        Custom Maya-based open command
        """
        pass
    # end open
    def save():
        """
        Custom Maya-based save command
        """
        pass
    # end save
# end FileCheckoutHoudini

def main():
    filePath = '/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes'
    exampleFileName1 = "s001_ckenne24_007_uving.0001.mb"
    exampleFileName2 = 'test_parent_project.0002.ma'

    filePath = '/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes'
    fileName = 's001_ckenne24_007_uving.0001.ma'
    fullPath = os.path.join(filePath, fileName)
    regex = consts.RE_FILENAME_MATCH_MA
    file_h = FileCheckoutMaya(filePath=fullPath)

    # a = FileCheckoutMaya(filePath, exampleFileName2, consts.RE_FILENAME_MATCH)
    # a = FileCheckoutMaya(filePath=filePath, fileName=exampleFileName1, regex=consts.RE_FILENAME_MATCH_MA)
    # print a.check_naming_convention()
    
    # match = re.match(consts.RE_FILENAME_MATCH, exampleFileName1)
    # if match is None:
    #     print("Something went wrong")
    # else:
    #     print match.groups()
    pass
# end main

if __name__ == "__main__":
    # print(__doc__)
    main()