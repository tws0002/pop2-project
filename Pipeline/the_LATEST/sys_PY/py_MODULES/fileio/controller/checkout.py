#!/usr/bin/env python

"""
.. Project::
 Portal Origins: Part Two

.. Description::
 Checkout contains general methods for reading and writing to files using
 globally defined variables from the root project directory

.. Author::
 Colin Kennedy

.. Improvements::
 - Add named regex groups, instead of querying values as [0]. [1], [2], etc

.. TODO::
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
try:
    import maya.OpenMaya as om  # try to load maya modules
except ImportError:
    print("intepreter: {i} could not load "
          "maya.OpenMaya".format(i=sys.executable))

try:
    import nuke
except ImportError:
    print("intepreter: {i} could not load "
          "nuke".format(i=sys.executable))

try:
    import hou
except ImportError:
    print("intepreter: {i} could not load "
          "hou".format(i=sys.executable))

import network.controller.network as network

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
import paths
import globerror


MAYA_EXEC_LOCATION = os.path.join(consts.ROOT_DIR, 'Pipeline', 'the_LATEST',
                                  'latest_CONFIG', 'conf_SCRIPTS')


class FileIO(object):
    """
    Generic File read/write class that works universally on all files
    """
    def __init__(self, filePath):
        """
        Initialize class with the file name, path, full path, and extension and
        other relevant information about the file

        Args:
            filePath (str): The full path of the file
        """
        super(FileIO, self).__init__()
        self.fullPath = filePath
        self.fileName = paths.path_leaf(self.fullPath)
        self.filePath = os.path.dirname(self.fullPath)
        # self.filePath = filePath[:(-1 * len(self.fileName))]
        self.extension = os.path.splitext(self.fileName)
        self._farm_character_limit = 255  # ::TO DO:: find out the real number for this
        self._sys_character_limit = 255
        self.disallowedFilePathCharacters = ('>', '<', '(', ')', '/', '?', '"',
                                             "'", '\\', '|', '{', '}', '$',
                                             '%', '^')
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
        Checks for an empty file from self.fullPath

        Returns:
            bool: True/False
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

        Returns:
            str: A string that represents the settings and access memory
                 location of the current class
        """
        return '<{mod}.{name}(fullPath="{fPath}", fileName="{flName},'\
               'extension="{ext}", farm_character_limit={fcl},'\
               'sys_character_limit={scl},'\
               'disallowedFilePathCharacters="{disallowedChars}")'\
               'object at {hexI}>'.format(self.__module__,
                                         self.__class__.__name__,
                                         hex(id(self)))
        # return "FileIO(fullpath=%r)" % (self.fullPath)
    # end __repr__

    def __str__(self):
        """
        Prints out a string method for the FileIO class

        Returns:
            str: The string which represents the full path to the file
        """
        return self.fullPath
    # end __str__

    def is_character_limit(self, value=None):
        """
        Checks if the file path is too long for the current OS. The file is
        still readable but this check is done to make sure that the file can
        still be copied/pastied without losing its properties

        Returns:
            bool: True/False
        """
        path = value
        if value is None:
            path = path

        system = sys.platform
        if system  == "win32":
            LOGGER.info(["AIE2102"], {'OS': system})
            maxLength = 260
        elif system == "linux2" or "Mac":
            LOGGER.info(["AIE2102"], {'OS': system})
            maxLength = 255
        else:
            LOGGER.error(["AIE9102"], {'OS': system})

        if len(path) > maxLength:
            LOGGER.warning(["AIE6500"], {'string': sell.fullPath,
                                         "length": maxLength})
            return True

        LOGGER.debug(['AIE4500'], {'string': path, 'OS': system,
                                   'max length': maxLength})
        return False
    # end is_character_limit

    def is_farm_character_limit(self, value=None):
        """
        .. note::
         I named this module poorly. It actually should be "is_above"

        .. TODO::
         I need to determine the character limit for the farm first.
         Does it include file name and project folder or just one or the other?

        Returns:
            bool: True/False
        """
        path = value
        if value is None:
            path = path
        if len(path) > self._farm_character_limit:
            return True
        else:
            return False
    # end is_farm_character_limit

    def is_valid_filepath(self, value=None):
        """
        .. note::
         I named this module poorly. It actually should be "is_above"

        Checks if the current file path contains special characters.
        If so, returns False

        Returns:
            bool: True/False
        """
        for folder in paths.os_path_split_asunder(value):
            if any(c in folder for c \
                   in self.disallowedFilePathCharacters):
                break
        else:
            return True
        return False
    # end is_valid_filepath
# end FileIO


class FileCheckout(FileIO):
    """
    An extension of the FileIO class, which now contains methods to determine
    whether or not a file has read/write access based upon certain criteria
    such as:

     1. If the name is incorrect (the regex to check names comes from the
        constants.model.constants module)
     2. If the file path isn't too long
     3. If the file isn't invalid in any way

     Other verification methods like if the file is locked or if the file is
     in the correct folder or if the user is registered with the project
     can be found in the network module

     :ref:`network.controller.network`
    """
    def __init__(self, filePath):
        """
        Uses many arguments to build the class, the most important are simply
        the args in charge of checking the naming convention (required/optional) args.

        Required Args:
        --------------
         - user: Example username such as ckenne24
         - version: A number with a 3 number padding
         - type: The item type of the asset, typically a word in all capital
                 letters between 4 and 6 characters
         - increment: A number with 4 padding, starting with the number 0 (e.g. 0004)
         - extension: The extension of the file

        Optional Arguments
        ------------------
         - scene/shot: The scene/shot of the intended asset. If specified, must
                       match a folder above it
         - description: A description of the file (as always, no spaces!)

        Args:
            filePath (str): The full path to the prospective file to be accessed
        """
        super(FileCheckout, self).__init__(filePath)
        self.systemOS = ''
        self.fullPathUnpacked = ''
        self._allowSave = True
        self._is_registered = False
        self.lockedName = self.fullPath + consts.LOCKED_NOTIFIER
        self._allowedExtensions = consts.GENERIC_ALLOWED_EXTENSIONS
        self.requiredArgs = ['user', 'version', 'type',
                             'increment', 'extension']
        self.optionalArgs = ['scene/shot', 'description']
        self._sceneParentFolders = ['Previs', 'Edit']
        self.sceneParentFolder = None
    # end __init__

    def check_naming_convention(self, fileName=None,
                                regex=None, override=False):
        """
        Checks the given filename for a proper naming convention

        Args:
            fileName (str): The filename to check the naming convention of
            regex (<type '_sre.SRE_Pattern'>): The compiled regex pattern to
                                               use to check fileName
            override (bool): Can make the script always return as True if needed

        Returns:
            tuple: A struct including the shot, user, version, description,
                   increment, and file-type of the given fileName input
        """

        if override:
            return True  # a quick check to pass the naming convention test

        if fileName is None:
            fileName = self.fileName

        if regex is None:
            regex = consts.RE_FILENAME_MATCH
        self._match = re.match(regex, fileName)

        if self._match is None:
            LOGGER.critical(['AIE9602'], {'name': fileName})
            return None

        self._matchGroupDict = [m.groupdict() for m
                        in regex.finditer(fileName)][0]

        LOGGER.info(['AIE5600'], {'match': self._match, 'f': fileName,
                                 'return': self._match.groups()})
        if self._match.group("shot") is not None:
            self.shot = int(self._match.group("shot"))

        self.shotRevision = self._match.group("shotRevision")
        self.user = self._match.group("user")
        self.version = int(self._match.group("version"))
        self.description = self._match.group("description")
        if self.description is not None and "_" in self.description:
            self.description = self.description.split("_")
        # if the increment string is meant to be parsed
        if self._match.group("increment").startswith(("#", "$", "%")):
            self.increment = self._match.group("increment")
        else:
            self.increment = int(self._match.group("increment"))
        self.extension = self._match.group("extension")
        if self.extension.lower() not in self._allowedExtensions:
            LOGGER.critical(["AIE9604"],
                            {"file": fileName,
                             "allowedExt": self._allowedExtensions})
            return None

        for key, item in self._matchGroupDict.iteritems():
            LOGGER.debug(['AIE4600'], {'attr': key, 'value': item,
                                       'file': fileName})
        return self._matchGroupDict
    # end check_naming_convention

    def is_in_scene_folder(self, searchFolders=None, surpressFolders=False):
        """
        Checks if the file is in a proper scene folder

        Args:
            searchFolders (str): A folder name to search for can be manually
                                 specified. If it is not though, the function
                                 defaults to self._sceneParentFolders
            surpressFolders (bool): Useful only if the file being checked has an
                                    expected folder structure. Example: Maya files
                                    that are used as scenes will always be in a
                                    "scenes" folder. The rules must be defined
                                    within this function

        Returns:
            bool: True/False
        """
        if searchFolders is None:
            # Assumes search is the parent folder if none is specified
            searchFolders = self._sceneParentFolders

        maxFoldersUp = 9001  # some impossibly high number
        if surpressFolders and \
                self.fullPath.lower().endswith(consts.SCENE_DESCRIPTION_TYPES):
            # scene files should always be exactly two folders above
            maxFoldersUp = 2
        folderSplit = paths.os_split_paths_asunder(self.fullPath)

        index = 0
        while index < maxFoldersUp:
            testFolder = folderSplit[len(folderSplit) - 1 - index]
            if testFolder in searchFolders:
                self.sceneParentFolder = testFolder
                break
            index += 1

        if self.sceneParentFolder not in testFolder:
            return False
        return True
    # end is_in_scene_folder

    def elevate_class_by_application(self, application):
        """
        A factory method that returns a class with elevated and
        proprietary methods specific to that application based on an input string
        """
        if application.lower() not in consts.SUPPORTED_APPLICATION_NAMES:
            sys.exit("Application Input: {app!r} not in list of supported "
                     "application names, "
                     "{sapps!r}".format(application,
                                        consts.SUPPORTED_APPLICATION_NAMES))
        elif application == "maya":
            app = FileCheckoutMaya()
        elif application == "nuke":
            app = FileCheckoutNuke()
        elif application == "houdini":
            app = FileCheckoutHoudini()
        return app
    # end elevate_class_by_application

    def check_required_args(self):
        """
        .. TODO::
         Doesn't do anything yet but eventually it could be used to concatenate
         missing args in a list of required arguments if the missing required
         arguments can be queried (example: adding a username into a file that
         doesn't already have one assigned)
        """
        allRequired = True
        for rArgs in self._requiredArgs:
            if self._match.group(rArgs) is None:
                LOGGER.critical(['AIE9601'], {'var': rArgs,
                                              'name': self.fullPath})
                dictTemp = {'match': self._match, 'f': self.fileName,
                            'convention': consts.MATCH_RE}
                LOGGER.critical(['AIE6601'], dictTemp)
                allRequired = False
            if rArgs == "type" and self._match.group(rArgs) is not None \
                    and self._match.group(rArgs) not in consts.ITYP_LIST:
                LOGGER.critical(['AIE9603'],
                                {'type': self._match.group(rArgs),
                                 'name': self.fileName,
                                 'list': consts.ITYP_LIST})
                return None

        if allRequired == False:
            return None
    # end check_required_args

    def save():
        """
        The contents of a generic file save command
        """
        pass
    # end save

    def save_file(self):
        """
        Attempts to save a generic file but checks if the file is locked first

        .. Note::
         This method doesn't imply that a open was successful, just if the file
         is allowed to be opened by the current user

        Returns:
            bool: If the save is able to occurs, returns True. Else False
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

        .. Note::
         This method doesn't imply that a open was successful, just if the file
         is allowed to be opened by the current user

        Returns:
            bool: If the open is able to occurs, returns True. Else False
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
                                                            consts.USERNAME:
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

        Returns:
            str: The OS (possibilities are linux2 or win32)
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
        the current user's OS. It rejoins the file with os.sep

        Returns:
            str: The file path, rejoined
        """
        self.fullPathUnpacked
        fields = re.split(r'(/|\\\\|\\)\s*', line)

        removalMarkers = ('/', '\\', '\\\\', '')
        # print [i for j, i in enumerate(fields) if j not in removal]
        folderPaths = [j for i, j in enumerate(fields) if j not in removal]

        if consts.SYSTEM == "win32":
            folderPaths = os.path.join(fields)
        elif consts.SYSTEM == "linux2":
            folderPaths = '/' + os.path.join(fields)
        else:
            raise EnvironmentError("not sure what OS you're using")

        return folderPaths
    # end split_folders

    def is_locked(self):
        """
        Looks to see if the file being queried is currently being accessed
        over the network

        Returns:
            bool: True/False
        """
        if os.path.isfile(self.lockedName):
            LOGGER.info(['AIE5601', 'match_true'], {'file': self.fullPath})
            return True

        LOGGER.info(['AIE5602', 'match_false'], {'file': self.fullPath})
        return False
    # end is_locked

    def is_locked_file(self, fileHandle=None):
        """
        Determines if the file being inspected falls under the criteria
        of "locked" but does not currently check if the file exists

         Right now, the convention for a locked file is
         "/some/path/foo.bar.lock"
         so I'm testing for the extension suffix here

        Args:
            fileHandle (str): The full path to a prospective file path. If not
                              specified, the script defaults to self.fullPath

        Returns:
            bool: True/False
        """
        if fileHandle is None:
            fileHandle = self.fullPath

        if fileHandle.endswith(consts.LOCKED_NOTIFIER):
            return True
        else:
            return False
    # end is_locked_file

    def get_save(self):
        """
        Generic save function to be overridden.
        Gets the filepath to the object/file/folder being saved
        """
        pass
    # end get_save

    def set_save(self):
        """
        Generic set method - contains the actual code to
        allow or stop a save
        """
        pass
    #end set_save

    @property
    def allow_save(self):
        """
        Changes the permissions on the file, determining whether or not the user
        is allowed to save in the current session
        """
        return self._allowSave
    # end @allow_save.property

    @allow_save.setter
    def allow_save(self, value):
        """
        Set method for the allow_save property. Setting the value will trigger
        either a IOValidationPassedError (True) or IOValidationError (False)
        which is later captured and handled in other modules

        Args:
            value (bool): True/False

        Returns:
            IOValidationError or IOValidationPassedError: Custom Exception
                                                          classes. See
                                                          :ref:`Exceptions`
                                                          for more details
        """
        self._allowSave = value
        if self._allowSave:
            raise globerror.IOValidationPassedError()
        else:
            raise globerror.IOValidationError()
    # end @allow_save.setter

    @allow_save.deleter
    def allow_save(self):
        """
        Delete method for the allow_save property
        """
        del self._allowSave
    # end @allow_save.setter
    # end allow_save

    @property
    def is_registered(self):
        """
        Check if the user is part of the project. Gets crew info from another
        module. If there is information about the person, return True

        Returns:
            bool: True/False
        """
        crewMemberInfo = network.project_member_contact_info(consts.USERNAME)
        if crewMemberInfo is not None:
            self._is_registered = True
        else:
            self._is_registered = False

        return self._is_registered
    # end @is_registered.property

    # @is_registered.setter
    # def is_registered(self):
    #     """
    #     Setter method for is_registered. Adds users to the specified key
    #     if True. Removes them if it is False

    #     .. Note::
    #      No longer implemented
    #     """
    #     pass
    # # end @is_registered.setter

    # @is_registered.deleter
    # def is_registered(self):
    #     """
    #     Setter method for is_registered. Removes class property
    #     but keeps the registration config file
    #     """
    #     del self._is_registered
    # # end @is_registered.deleter
    # # end is_registered
# end FileCheckout


class FileCheckoutFinal(FileCheckout):
    """
    Checks the file naming convention for finalized assets. This class has
    different rules about what makes it "final" and most of the other args are
    actually optional
    """
    def __init__(self, filePath):
        """
        Inits the FileCheckoutFinal object with its required args and the
        expected folder that it would be found in

        Required Arguments
        ------------------
         - _FIN
         - user
         - type (ITYP)
         - increment
         - extension

        Optional Arguments
        ------------------
         - scene/shot
         - description

        Args:
            filePath (str): The full path to a filename that represents a
            "finalized" asset. This class was subclassed because the convention
            rules for final assets are typically different from scene assets
        """
        super(FileCheckoutFinal, self).__init__(filePath)
        self.requiredArgs = ['_FIN (prefix)', 'user', 'type', 'increment',
                             'extension']
        self.optionalArgs = ['scene/shot', 'description']
        self._sceneParentFolders = ['Build', 'Final']
    # end __init__

    def is_final(self):
        """
        Checks if self.fullPath is final based upon where in the folder
        structure it's being saved and also whether or not it has the correct
        regex rules applied to it

        Returns:
            bool: True/False
        """
        folders = paths.split_os_asunder(self.fullPath)
        # test if it's being saved to the right folder
        for f in folders:
            if f.upper() == "FINAL":
                break
        else:
            return False
        # test the filename for the correct string
        matchRe = re.compile("_FIN.+")
        if re.match(matchRe, self.filename) is not None:
            return True
        else:
            return False
    # end is_final
        # write in the new required args here
        # as well as other class-specific vars
# end FileCheckoutFinal


class FileCheckoutMaya(FileCheckout):
    """
    Checks file information and determines whether or not a file is allowed to
    be saved and has its methods customized to suit Maya files
    """
    def __init__(self, filePath):
        """
        Args:
            filePath (str): The full path to a filename that represents a
            "finalized" asset. This class was subclassed because the convention
            rules for final assets are typically different from scene assets
        """
        super(FileCheckoutMaya, self).__init__(filePath)
    # end __init__

    def open(self):
        """
        Open command for a Maya session

        .. TODO::
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
        cmds.file(f=True, type='mayaAscii', save=True)
    # end save

    # def initialize(self):
    #     """
    #     Opens Maya from the python command-line directly, using maya.standalone

    #     .. Note::
    #      Deprecated
    #     """
    #     # maya.standalone.initialize("Python")
    #     pass
    # # end initialize

    def is_maya_file(self):
        """
        Checks if the file input is a valid Maya file, available for opening

        .. TODO::
         Create an exception case - if the path is not openable, then you know
         it is not a valid maya file

        .. AUTHORNOTE::
	 Temporarily applying paths to system. Change these into
         temporary env vars later

        Returns:
            bool: True/False
        """
        LOGGER.trace(["MYA1700"], {'file': self.fullPath})
        # import maya.cmds as cmds  # must be imported in-line, after initialization

        self.plugins_load()

        # Open your file
        try:
            opened_file = cmds.file(self.fullPath, o=True)
            # LOGGER.info(["MYA5701"], {"file", self.fullPath})
            # LOGGER.info(["MYA5702"], {"file", self.fullPath})
            return True
        except RuntimeError:
            # LOGGER.info(["MYA5703"], {"file", self.fullPath})
            # LOGGER.error(["MYA7700"], {"file", self.fullPath})
            return False
        maya.standalone.uninitialize()
    # end is_maya_file

    # def load_plugins(self):
    #     """
    #     Generic method for batch loading all maya plugins for the current project


    #     .. Note::
    #      Deprecated
    #     """
    #     import maya.cmds as cmds
    #     for plugin in consts.SUPPORTED_PLUGINS_MAYA:
    #         LOGGER.info(['MYA5900'], {'plugin': plugin, 'file': self.fullPath})
    #         cmds.loadPlugin(plugin)  # load any required plugs here
    # # end load_plugins

    def is_maya_file_fast(self):
        """
        Less intelligent alternative to checking the maya file. Useful if the
        file that is being checked is very large or has a long read time.

        Returns:
            bool: True/False
        """
        if self.fullPath.upper().endswith(consts.FILETYPES_MAYA):
            LOGGER.info(["MYA5702"], {"file": self.fullPath})
            return True
        else:
            LOGGER.info(["MYA5703"], {"file": self.fullPath})
            return False
    # end is_maya_file_fast

    def get_current_scene(self):
        """
        Gets the current scene name
        """
        fileName = cmds.file(ns=True)
        return fileName
    # end get_current_scene

    # def set_save(self, value, retCode=None, forceSave=False):
    #   """
    #   The actual Maya-based set method that allows for saving
    #   """
    #        if forceSave:
    #            om.MScriptUtil.setBool(retCode, True)
    #        else:
    #            om.MScriptUtil.setBool(retCode, value)
    #    # end set_save

    # def uninitialize(self):
    #     """
    #     Uninitialize maya's command-line connection

    #     .. Note::
    #      Deprecated
    #     """
    #     # import maya.standalone
    #     LOGGER.trace(["MYA1701"], {'file': self.fullPath})
    #     maya.standalone.uninitialize()
    # # end uninitialize
# end FileCheckoutMaya


class FileCheckoutNuke(FileCheckout):
    """
    Checks file information and determines whether or not a file is allowed to
    be saved and has its methods customized to suit Nuke files
    """
    def __init__(self, filePath):
        """
        Inits a FileCheckout class but adds a error message string called
        self._errorMsg. The error message that comes up in Nuke when a user
        is not permitted to save is actually a native Python RuntimeError.
        self._errorMsg keeps tabs on what message gets passed to RuntimeError.

        Args:
            filePath (str): The full path to a filename that represents a
            "finalized" asset. This class was subclassed because the convention
            rules for final assets are typically different from scene assets
        """
        super(FileCheckoutNuke, self).__init__(filePath)
        self._errorMsg = ''  # default error message is nothing
    # end __init__

    def open(self):
        """
        Custom Nuke-based open command
        """
        pass
    # end open

    def save(self, name=None):
        """
        Custom Nuke-based save command
        """
        if name is None:
            name = nuke.toNode("root").name()
        nuke.scriptSaveAs(name)
    # end save

    def get_save(self, thisNode=True, param=None):
        """
        Gets save file from scene or from node

        Args:
            thisNode (Nuke object): A Nuke object node that points to an
                                    existing node
            param (str):  The parameter which would be used to get the save string.
                          On a write node, this would be the "file" knob.

        Returns:
            str: The filestring that is going to be saved
        """
        if not thisNode and param is None:
            sys.exit("Param required")
        elif thisNode and param is not None:
            return nuke.thisNode()[param]
            # file = nuke.filename(nuke.thisNode())
        elif not thisNone:
            # :::TO DO::: Get the nuke .nk scene name here!
            pass
    # end get_save

    def get_current_scene(self):
        """
        Gets the current scene name
        """
        fileName = nuke.toNode("root").name()
        return fileName
    # end get_current_scene

    @property
    def error_msg(self):
        """
        Getter method which allows/disallows save/write access
        """
        return self._errorMsg
    # end @allow_save.property

    @error_msg.setter
    def error_msg(self, value):
        """
        Setter method for the allow_save func

        .. Note::
         Writing into this attribute does NOT automatically generate an error
         message. It simply serves as storage

        Args:
            value (str): The error message to print to the user
        """
        self._errorMsg = value
    # end set_error_msg.setter

    @error_msg.deleter
    def error_msg(self):
        """
        Deleter method for the allow_save func
        """
        del self._errorMsg
    # end @set_error_msg.deleter
    # end error_msg
# end FileCheckoutNuke


class FileCheckoutHoudini(FileCheckout):
    """
    Checks file information and determines whether or not a file is allowed to
    be saved and has its methods customized to suit Houdini files

    .. Note::
     Deprecated
    """
    def __init__(self, filePath):
        super(FileCheckoutHoudini, __init__).__init__(self)
    # end __init__

    def get_current_scene(self):
        """
        Gets the current scene name
        """
        fileName = cmds.file(ns=True)
        return fileName
    # end get_current_scene

    def open():
        """
        Custom Maya-based open command
        """
        pass
    # end open
    def save():
        """
        Custom Houdini-based save command
        """
        hou.hipFile.save()
        pass
    # end save
# end FileCheckoutHoudini


def is_locked(obj):
    """
    Checks the current object for lock

    Args:
        obj (str): The file/folder to check

    Returns:
        bool: True/False
    """
    objCheckout = FileCheckout(obj)
    if objCheckout.is_locked():
        return True
    else:
        False
# end is_locked


def is_locked_file(obj):
    """
    Checks if the current object is actually a locked file

    Args:
        obj (str): The file/folder to check

    Returns:
        bool: True/False
    """
    objCheckout = FileCheckout(obj)
    if objCheckout.is_locked_file():
        return True
    else:
        return False
# end is_locked_file


def test_file_name():
    """
    Testing the file
    """
    filePath = '/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes'
    exampleFileName1 = "s001_ckenne24_007_uving.0001.mb"
    exampleFileName2 = 'test_parent_project.0002.ma'

    filePath = '/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes'
    fileName = 's001_ckenne24_007_uving.0001.ma'
    fullPath = os.path.join(filePath, fileName)
    regex = consts.RE_FILENAME_MATCH
    file_h = FileCheckoutMaya(filePath=fullPath)

    # a = FileCheckoutMaya(filePath, exampleFileName2, consts.RE_FILENAME_MATCH)
    # a = FileCheckoutMaya(filePath=filePath, fileName=exampleFileName1, regex=consts.RE_FILENAME_MATCH)
    # print a.check_naming_convention()

    # match = re.match(consts.RE_FILENAME_MATCH, exampleFileName1)
    # if match is None:
    #     print("Something went wrong")
    # else:
    #     print self._match.groups()
    pass
# end test_file_name

if __name__ == "__main__":
    print(__doc__)