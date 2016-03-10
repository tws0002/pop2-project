import os
import re

from constants.model import constants as consts
from constants.model.constants import LOGGER
from pprint import pprint

matchMA = r's(\d{3})_([\x00-\x7F]{6}\d{2})_(\d{3})_([a-zA-Z]+).(0\d{3}).([mb|MB]+)'
RE_FILENAME_MATCH_MA = re.compile(matchMA)

class FileIO(object):
    """
    Generic File read/write class that works universally on all files
    """
    def __init__(self, fileName, filePath):
        """
        Initialize class with the file name, path, full path, and extension and
        other relevant information about the file

        :key fileName: Name of the file
        :key filePath: The base path of the file
        :type fileName: str
        :type filePath: str

        :returns: FileIO class
        :rtype: <FileIO>
        """
        super(FileIO, self).__init__()
        self.fileName = fileName
        self.filePath = filePath
        self.fullPath = filePath + os.sep + fileName
        self.extension = os.path.splitext(fileName)
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
        return "FileIO(this=%r,that=%r)" % (self.fileName,self.filePath)
    # end __repr__
    def __str__(self):
        """
        Prints out a string method for the FileIO class
        """
        return fileName + os.sep + filePath
    # end __str__
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

        LOGGER.debug(["AIE2002"], {'OS': system})
        if len(self.fullPath) > maxLength:
            LOGGER.warning(["AIE6500"], {'string': sell.fullPath, 
                                         "length": maxLength})            
            return True

        LOGGER.debug(['AIE4500'], {'string': self.fullPath, 'OS': system, 
                                   'max length': maxLength})
        return False
    # end is_character_limit
# end FileIO

class FileCheckout(FileIO):
    """
    An elevated generic class that contains methods for interfacing between
    the local user and the project's network directory

    :returns: FileCheckout class
    :rtype: <FileCheckout>
    """
    def __init__(self, fileName, filePath, regex):
        super(FileCheckout, self).__init__(fileName, filePath)

        self.regex = regex

        _nameOutput = self.check_naming_convention(self.regex)
        if _nameOutput is None:
            print "AUTHOR NOTE: Add the PyQt dialog box here. File does not conform to a proper naming convention"

        self.extension = _nameOutput[5]
        self.shot = _nameOutput[0]
        self.user = _nameOutput[1]
        self.version = _nameOutput[2]
        self.description = _nameOutput[3]
        self.increment = _nameOutput[4]
        self.lockedName = self.filePath + os.sep + \
                          self. fileName + consts.LOCKED_NOTIFIER

        LOGGER.debug(['AIE4600'], {'ext': self.extension})
        LOGGER.debug(['AIE4601'], {'shot': self.shot})
        LOGGER.debug(['AIE4602'], {'user': self.user})
        LOGGER.debug(['AIE4603'], {'version': self.version})
        LOGGER.debug(['AIE4604'], {'description': self.description})
        LOGGER.debug(['AIE4605'], {'increment': self.increment})
    # end __init__
    def check_naming_convention(self, regex=""):
        """
        Checks the given filename for a proper naming convention

        :key fileName: The name of the file, excluding its absolute file-path
        :key regex: The pre-compiled Reg-Ex pattern that match against fileName
        :type fileName: str
        :type regex: <type '_sre.SRE_Pattern'>
        :returns: A Tuple including the shot, user, version, description,
                  increment, and file-type of the given fileName input
        :rtype: tuple

        ..AUTHOR NOTE::
         Not done
        """

        print self.fileName
        print re.match(RE_FILENAME_MATCH_MA, self.fileName).groups()

        if regex == "" and self.regex == "":
            print("I really need to add a exception log statement for this")
            return False

        match = re.match(self.regex, self.fileName)
        print 'match', match
        if match is None:
            [pprint(x) for x in self.get_naming_convention_examples()]  # EXAMPL
            dictTemp = {'match': match, 'f': self.fileName,
                        'convention': self.regex}
            LOGGER.error(['AIE6601','match_false'], dictTemp )
            return None

        LOGGER.info(['AIE5600'], {'match': match, 'f': self.fileName, 
                                 'return': match.groups()})
        return match.groups()
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
    def is_locked(self):
        """
        Looks to see if the file being queried is currently being accessed
        over the network

        :key filePath: The full, absolute path to the file being checked
        :type filePath: str
        :returns: True/False or None
        :rtype: bool or NoneType
        """
        if os.path.isfile(self.lockedName):
            LOGGER.info(['AIE5601', 'match_true'], {'file': self.fullPath})
            return True

        LOGGER.info(['AIE5602', 'match_false'], {'file': self.fullPath})
        return False
    # end is_locked
    def is_local(self):
        """
        Used to determine if a user is accessing a file from the local space
        or from over the network collaborative space

        ..Considerations::
         This method is semi-unintelligent AUTHOR NOTE - Change with environment
         variables in the future and account for different OSes
        """
        if not "COLLABORATIVE" in self.fullPath.upper():
            LOGGER.debug(['AIE4606', 'match_false'], {'file': self.fullPath})
            return False
        else:
            LOGGER.debug(['AIE4607', 'match_true'], {'file': self.fullPath})
            return True
    # end is_local
    def request_access(self):
        """
        Looks at file's name to get the username of the person.
        Sends that person an e-mail, requesting access to the file

        ..TODO::
         Possibly integrate this with slack - so that people can get a message
         instead of an e-mail
        """
        pass
    # end request_access
    def set_contact_info():
        """
        Sets the contact information on the locked file being queried.
        Creates a locked file if none exists

        :returns: Whether or not the set was successful, True/False
        :rtype: bool
        """
        pass
    def get_contact_info(self):
        """
        Gets the contact information on the locked file being queried

        :returns: Contact info about the user who currently locked the file
        :rtype: dict
        """
        if not os.path.isfile(self.lockedName):
            LOGGER.error(['AIE7601', 'match_false'], {'file': self.fullPath})
            return None

        with open(self.lockedName) as f:
            contactInfo = f.read()

        contactInfo = json.loads(contactInfo)
        LOGGER.debug(["AIE4608"], {'contents': contactInfo, 
                                   'file': self.fullPath})
        return contactInfo
    # end get_contact_info
    def set_locked(self):
        """
        Locks the current file with a self.lockedName with
        information about the current user inside of the locked file
        """
    # end set_locked
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
                self.open()
                return True
            elif self.is_locked() and self.get_contact_info()['USER'] == \
                                                                consts.USER:
                LOGGER.trace(["AIE1602"], {"file": self.fullPath})
                LOGGER.warning(['AIE6600'], {"file": self.fullPath})
                self.open()
                return True

            LOGGER.info(["AIE5601"], {'file': self.fullPath})
            return False
    # end open_file
# end FileCheckout

class FileCheckoutMaya(FileCheckout):
    def __init__(self, fileName, filePath, regex):
        super(FileCheckoutMaya, self).__init__(fileName, filePath, regex)
        self.check_naming_convention(consts.RE_FILENAME_MATCH_MA)
        """
        self.fileStringInputTypes({pm.nodetypes.CacheFile: ("cachePath", 
                                                            'cacheName'),
                                  pm.nodetypes.AlembicNode: "abc_File",
                                  pm.nodetypes.DiskCache: "cacheName",
                                  pm.nodetypes.File: "fileTextureName",
                                  pm.nodetypes.PxrTexture: "filename",
                                  pm.nodetypes.PxrBump: "filename",
                                  pm.nodetypes.PxrStdEnvMapLight: "rman__EnvMap"})
        """
    # end __init__
    def open():
        """
        Custom Maya-based open command

        ..To Do:
         Add an exception case for invalid file types, so the command doesn't
         fail mid-execution
        """
        LOGGER.info(["MYA5700"], {"file": self.fullPath})
        shutil('maya -o {f}'.format(f=self.fullPath))
    # end open
    def save():
        """
        Custom Maya-based save command
        """
        pass
    # end save
    def open_shell(self):
        """
        Opens Maya from the python command-line directly, using maya.standalone
        """
        maya.standalone.initialize("Python")
    # end open_shell
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
        maya.standalone.initialize("Python")
        LOGGER.trace(["MYA1700"], {'file': self.fullPath})
        import maya.cmds as cmds  # must be imported in-line, after initialization

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
    def plugins_load(self):
        """
        Generic method for batch loading all maya plugins for the current project
        """
        for plugin in consts.SUPPORTED_PLUGINS_MAYA:
            LOGGER.info(['MYA5900'], {'plugin': plugin, 'file': self.fullPath})
            cmds.loadPlugin(plugin)  # load any required plugs here
    # end plugins_load
    def is_maya_file_fast(self):
        """
        Less intelligent alternative to checking the maya file. Useful if the
        file that is being checked is very large or has a long read time.
        """
        if self.fullPath.endswith(consts.FILETYPES_MAYA):
            LOGGER.info(["MYA5702"], {"file", self.fullPath})
            return True
        else:
            LOGGER.info(["MYA5703"], {"file", self.fullPath})
            return False
    def uninitialize(self):
        LOGGER.trace(["MYA1701"], {'file': self.fullPath})
        maya.standalone.uninitialize()
    # end uninitialize
# end FileCheckoutMaya



def main():
    # matchMA = r's\d{3}[\x00-\x7F]{6}\d{2}\d{3}[a-zA-Z]\d{4}[mb|MB]+'
    matchMA = r's(\d{3})_([\x00-\x7F]{6}\d{2})_(\d{3})_([a-zA-Z]+).(0\d{3}).([mb|MB]+)'
    RE_FILENAME_MATCH_MA = re.compile(matchMA)
    filePath = '/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes'
    exampleFileName1 = "s001_ckenne24_007_uving.0001.mb"
    
    a = FileCheckoutMaya(exampleFileName1, filePath, RE_FILENAME_MATCH_MA)
    filename = 's001_ckenne24_007_uving.0001.mb'

    print re.match(RE_FILENAME_MATCH_MA, filename).groups()
# end main


main()
