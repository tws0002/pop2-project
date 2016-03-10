#!/usr/bin/python

"""
..Project::
 Portal Origins: Part Two
..Description::
 Network module handles requests and changing information about the user and
 their access to the current network.

 Note, this file is not meant to be executed directly
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os
import socket  # for determining user's network location
import json

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from constants.model.constants import LOGGER

class NetworkManager(object):
    def __init__(self):
        """
        Locked name does not necessarily exist but is the convention for 
        all locked file names.
        """
        super(NetworkManager, self).__init__()
        self.user = None
        self.contactInfo = {}        
        self._file = ''
        self._locked = None
        self._lockedFile = self._file + consts.LOCKED_NOTIFIER
        self._is_local = None
        self._is_locked = False
        self._has_access = None
    # end __init__
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
    def set_contact_info(self, *args, **kwargs):
        """
        Sets the contact information on the locked file being queried.
        Creates a locked file if none exists

        :returns: Whether or not the set was successful, True/False
        :rtype: bool
        """
        if self._file is None:
            LOGGER.error(["AIE7602"])
            return None
        pass  # ::TO DO:: append to the contact info variable (so that it can be queried)
    # end set_contact_info
    def is_local(self):
        """
        Used to determine if a user is accessing a file from the local space
        or from over the network collaborative space

        ..Considerations::
         This method is semi-unintelligent AUTHOR NOTE - Change with environment
         variables in the future and account for different OSes
        """
        if not "COLLABORATIVE" in self._file.upper():
            LOGGER.debug(['AIE4606', 'match_false'], {'file': self._file})
            return True
        else:
            LOGGER.debug(['AIE4607', 'match_true'], {'file': self._file})
            return False
        return self._is_local
    # end is_local
    def is_remote(self):
        """
        Determine if user is working remotely from home by finding out if 
        they're hardwired to the SCAD network
        """
        if socket.gethostbyname(socket.gethostname()).startswith('10.7'):
            return False
        else:
            return True
    # end is_remote
    def is_registered(self):
        """
        Check if the current user is registered in the group. Also useful to
        perform checks to make sure that the current file was last saved by the
        current user
        """
        if self.user == getpass.getuser():
            return True
        else:
            return False
    # end is_registered
    @property
    def locked(self):
        """
        Locks the current file with a self.lockedName with
        information about the current user inside of the locked file
        """
        return self._locked
    # end locked.property
    @locked.setter
    def locked(self, status):
        """
        Set method for locking or unlocking a specified file over the network

        Setting the locked method to true will generate a locked file version
        Setting the locked method to false will delete the locked file version

        ::TO DO::
        Add a lock method to the current property
        """
        self._locked = status  # regardless of network condition, set the state

        # test for locked file types and set/delete data if necessary
        if status == True and not os.path.isfile(self._lockedFile):
            lockedInfoDict = self.get_contact_info()

            with open(self._lockedFile, 'w') as f:
                json.dump(lockedInfoDict, f)

        elif status == False and os.path.isfile(self._lockedFile):
            os.remove(self._lockedFile)
    # end locked.setter
    # end locked
    @property
    def is_locked(self):
        """
        Given a file path, determine if the locked version of the file
        exists in the same directory
        """
        return self._is_locked
    # end is_locked.property
    @is_locked.setter
    def is_locked(self):
        """
        Setter method for is_locked
        """
        if not os.path.isfile(self.file) or not os.path.isfile(self._lockedFile):
            self._is_locked = False
        else:
            self._is_locked = True
    # end is_locked.setter
    # end is_locked
    @property
    def is_admin(self):
        """
        Checks if the current user is a registered admin for the current project
        """
        return self._is_admin
    # end is_admin.property
    @is_admin.setter
    def is_admin(self):
        if consts.USERNAME in consts.REGISTEREDADMINS:
            return True
        else:
            return False
    # end is_admin.setter
    @is_admin.deleter
    def is_admin(self):
        del self._is_admin
    # end is_admin.deleter
    # end is_admin
    def has_access(self):
        """
        Method to determine if a specific user has access to a given file
        """
        self._has_access = False

        if self.read_contact_info is not None:
            if self.read_contact_info['USERNAME'] == consts.USERNAME or \
               consts.USERNAME in consts.REGISTEREDADMINS:
                self._has_access = True

        return self._has_access
    # end has_access
    @property
    def file(self):
        """
        Gets and sets a handler which points to a file.
        By default, the requested file does not have to be any particular type
        """
        return self._file
    @file.setter
    def file(self, file_h):
        """
        This is the set method for the self._file attribute
        """
        if os.path.exists(file_h):
            self._file = file_h
            self._lockedFile = self._file + consts.LOCKED_NOTIFIER
            self.locked = self.is_locked
        else:
            self._file = None
            self._lockedFile = None
    # end file.setter
    @file.deleter
    def file(self):
        """
        This is the delete method for the self._file attribute
        """
        del self._file
    # end file.deleter
    # end file
    @property
    def read_contact_info(self):
        """
        Reads the contact information on the locked file being queried

        :returns: Contact info about the user who currently locked the file
        :rtype: dict
        """
        if not os.path.isfile(self._lockedFile):
            LOGGER.error(['AIE7601', 'match_false'], {'file': self._file})
            return None

        with open(self._lockedFile) as f:
            contactInfo = f.read()

        contactInfo = json.loads(contactInfo)
        LOGGER.debug(["AIE4608"], {'contents': contactInfo, 
                                   'file': self._file})

        self._LOCKEDUSERNAME = contactInfo['USERNAME']
        self._LOCKEDMACHINE = contactInfo['MACHINE']
        self._LOCKEDIP = contactInfo['IP']
        self._LOCKEDEMAIL = contactInfo['EMAIL']
        self._LOCKEDPHONE = contactInfo['PHONE']
        return contactInfo
    # end read_contact_info
    def get_contact_info(self):
        """
        Generates contact information from the current user.
        Used to insert information about the current session to a locked file
        """
        outputDict = {"USERNAME": consts.USERNAME,
                      "IP": consts.IPADDRESS, 
                      "MACHINE": consts.HOSTNAME, 
                      "EMAIL": 'ckenne24@student.scad.edu', 
                      "PHONE": '203-722-6620'}  # ::: TO DO::: dynamically get phone and email info automatically
        return outputDict
    # end get_contact_info
# end NetworkManager

def state_change_all(self, rootdir, state):
    """
    Locks/Unlocks every asset in the specified directory.
    Useful to lock all files in the project directory
    """
    if state == "unlock":
        stateChange = False
    elif state == "lock":
        stateChange = True
    else:
        LOGGER.error(['NET7800'], {'script':inspect.stack()[1], 'parameter':stateChange})
        return None

    for subdir, dirs, files in os.walk(rootdir):
        for file in files:
            networkManager = NetworkManager()
            networkManager.file = file
            networkManager.locked = stateChange  # change all
# end state_change_all

if __name__ == "__main__":
    print (__doc__)