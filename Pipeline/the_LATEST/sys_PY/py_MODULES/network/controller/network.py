#!/usr/bin/python

"""
.. Project::
 Portal Origins: Part Two

.. Description::
 Network module handles requests and changing information about the user and
 their access to the current network.

 Note, this file is not meant to be executed directly

.. Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os
import socket  # for determining user's network location
import json
import getpass
import time

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()

from fileio.controller import omnibus


class NetworkManager(object):
    """
    The main interfacing class that is used to communicate over the network
    between projects/files/applications. It partially leverages the checkout
    module (See :ref:`checkout`) for general file I/O but extends upon it
    to make sure that files are OK and not locked/hidden/unsaveable/corrupted/etc
    """
    def __init__(self):
        """
        Locked name does not necessarily exist but is the convention for
        all locked file names.

        Required Contact Info
        ---------------------
         - MACHINE
         - IP
         - USERNAME
         - USERFULLNAME
         - EMAIL
         - PHONENUMBER
         - ROOM
         - TIME
         - DATE

        User info is stored under self.contactInfo
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
        self._crewListWks = 'Crew_spreadsheet_dup_test'
        self._requiredContactInfo = ['MACHINE', 'IP', 'USERNAME',
                                     'USERFULLNAME', 'EMAIL', 'PHONENUMBER',
                                     'ROOM', 'TIME', 'DATE']
    # end __init__

    # def request_access(self):
    #     """
    #     Looks at file's name to get the username of the person.
    #     Sends that person an e-mail, requesting access to the file

    #     .. TODO::
    #      Possibly integrate this with slack - so that people can get a message
    #      instead of an e-mail
    #     """
    #     pass
    # # end request_access

    # def set_contact_info(self, *args, **kwargs):
    #     """
    #     Sets the contact information on the locked file being queried.
    #     Creates a locked file if none exists

    #     .. Note::
    #      DEPRECATED in favor of :ref:`collect_contact_info`

    #     :returns: Whether or not the set was successful, True/False
    #     :rtype: bool
    #     """
    #     if self._file is None:
    #         LOGGER.error(["AIE7602"])
    #         return None
    #     pass  # ::TO DO:: append to the contact info variable (so that it can be queried)
    # # end set_contact_info

    def is_local(self):
        """
        Used to determine if a user is accessing a file from the local space
        or from over the network collaborative space using self.file

        .. Considerations::
         This method is semi-unintelligent

        .. AUTHORNOTE::
         Change with environment variables in the future and account for 
	 different OSes

        Returns:
            bool: True/False
        """
        if not "COLLABORATIVE" in self.file.upper():
            LOGGER.debug(['AIE4606', 'match_false'], {'file': self._file})
            return True
        else:
            LOGGER.debug(['AIE4607', 'match_true'], {'file': self._file})
            return False
    # end is_local

    def is_remote(self):
        """
        Determine if user is working remotely from home by finding out if
        they're hardwired to the SCAD network by looking up consts.IPADDRESS

        Returns:
            bool: True/False
        """
        # if socket.gethostbyname(socket.gethostname()).startswith('10.7'):
        if consts.IPADDRESS.startswith('10.7'):
            return False
        else:
            return True
    # end is_remote

    # def get_network_path_from_relative(self):
    #     """
    #     Uses a local path and tries to find an exact match over the network
    #     for the same paths/files (if it exists)

    #     .. TODO::
    #      Implement this after getting features for getting the latest file have
    #      been implemented
    #     """
    #     pass
    # # end get_network_path_from_relative

    @property
    def locked(self):
        """
        Locks the current file with a self.lockedName with
        information about the current user inside of the locked file

        Returns:
            bool: Whether or not the file is locked, True/False
        """
        return self._locked
    # end locked.property

    @locked.setter
    def locked(self, status):
        """
        Set method for locking or unlocking a specified file over the network

        Setting the locked method to true will generate a locked file version
        Setting the locked method to false will delete the locked file version

        .. TODO::
         Add a lock method to the current property

        Args:
            status (bool): The new state for file in self.file, True/False
        """
        self._locked = status  # regardless of network condition, set the state

        # test for locked file types and set/delete data if necessary
        if self._locked == True and not os.path.isfile(self.locked_file):
            # userContactInfo = project_member_contact_info(wks=self._crewListWks)  # DEPRECATED - See Note 66
            # userContactInfo = project_member_contact_info()
            userContactInfo = self.collect_contact_info()
            # LOGGER.info("This is what will go in the file")
            # LOGGER.info(str(userContactInfo))
            # LOGGER.info(str(type(userContactInfo)))
            if os.path.isdir(os.path.dirname(self.locked_file)):
                with open(self.locked_file, 'w') as f:
                    json.dump(userContactInfo, f)
            else:
                LOGGER.critical(['AIE9606', 'match_false'],
                                {'folder':os.path.dirname(self.locked_file),
                                 "action": "Write user data to a locked version of file/folder"})



        elif status == False and os.path.isfile(self.locked_file):
            os.remove(self.locked_file)
    # end locked.setter
    # end locked

    @property
    def is_locked(self):
        """
        Given a file path, determine if the locked version of the file
        exists in the same directory

        Returns:
            bool: Whether or not the given file is locked, True/False
        """
        return self._is_locked
    # end @is_locked.property

    @is_locked.setter
    def is_locked(self, value):
        """
        Setter method for is_locked
        Admittedly, this setter method is pointless because whatever value
        the user sets will be overwritten based on whether or not the file
        actually exists on the local machine.

        .. TODO::
         Maybe have this file generate lock files when it's set to True/False

        Args:
            value (bool): The value to set the current lock state of a file
        """
        self._is_locked = value

        if not os.path.isfile(self._lockedFile):
            self._is_locked = False
        else:
            self._is_locked = True
    # end is_locked.setter
    # end is_locked

    def is_admin(self):
        """
        Checks if the current user is a registered admin for the current project

        Returns:
            bool: True/False
        """
        if consts.USERNAME in consts.REGISTERED_ADMINS:
            return True
        else:
            return False
    # end is_admin

    def has_access(self):
        """
        Method to determine if a specific user has access to a given file.

        Default behavior is to assume the user has no access and then grant it.
        Uses self.locked_file to check if a locked file exists

        Returns:
            bool: True/False
        """
        self._has_access = False
        # contactInfo = project_member_contact_info()
        if os.path.isfile(self.locked_file):
            contactInfo = self.read_contact_info_from_locked_file()
            # if contactInfo is not None:
            #     LOGGER.info("TEST: contactInfo is not None")
            # if "USERNAME" in contactInfo:
            #     LOGGER.info("TEST: USERNAME is in the contactINfo")
            # if contactInfo['USERNAME'] == consts.USERNAME:
            #     LOGGER.info("TEST: contactInfo['USERNAME'] is the active user")
            # if consts.USERNAME in consts.REGISTERED_ADMINS:
            #     LOGGER.info("TEST: consts.USERNAME in consts.REGISTERED_ADMINS")

            if (contactInfo is not None and "USERNAME" in contactInfo \
                    and contactInfo['USERNAME'] == consts.USERNAME) or self.is_admin:
                self._has_access = True
            else:
                self._has_access = False
        else:
            self._has_access = True

        return self._has_access
    # end has_access

    def read_contact_info_from_locked_file(self):
        """
        Reads information from the locked file and returns it using
        self.locked_file

        Returns:
            dict or NoneType: Gets the contact info as a dictionary from the
                              locked file as a JSON dict or None
        """
        if not os.path.isfile(self.locked_file):
            return None

        with open(self.locked_file, 'r') as f:
            contactDict = json.load(f)
        # LOGGER.info("json load: " + str(contactDict))
        outputDict = {}
        for cred in self._requiredContactInfo:
            if cred in contactDict:
                outputDict[cred] = contactDict[cred]
        # LOGGER.info("final outputDict: " + str(outputDict))
        return outputDict
    # end read_contact_info_from_locked_file

    def is_incomplete_read_contact_info(self, dictH=None):
        """
        A check to make sure that the contact info that
        was read and received with incomplete info.

        Args:
            dictH (dict): The contact info dict. If nont is specified, the dict
                          is read and parsed from self.locked_file.

        Returns:
            bool: True/False
        """
        contactDict = {}
        if dictH is None:
            contactDict = self.read_contact_info_from_locked_file()
        else:
            contactDict = dictH
        # LOGGER.info("is_incomplet: contact dict from read: " + str(contactDict))

        for cred in self._requiredContactInfo:
            if cred not in contactDict:
                return True
        else:
            return False
    # end is_incomplete_read_contact_info

    def collect_contact_info(self):
        """
        Generates contact information from the current user.
        Intended use is to write information about
        the current session into a locked file

        .. TODO::
         I should really subclass this out and create a way to add/remove rules
         from this import dict and from the is_incomplete_read_contact_info.
         Reference: Type Code with State/Strategy:
         https://sourcemaking.com/refactoring/replace-conditional-with-polymorphism

        Returns:
            dict: A full dictionary containing all of the different user info
        """
        contactInfo = project_member_contact_info()
        LOGGER.info(str(contactInfo))
        currentUserInfo = self.get_network_collection()
        outputDict = {"USERNAME": consts.USERNAME,
                      "IP": currentUserInfo['IP'],
                      "MACHINE": currentUserInfo['MACHINE'],
                      "ROOM": currentUserInfo['ROOM'],
                      "USERFULLNAME": contactInfo['USERFULLNAME'],
                      "EMAIL": contactInfo['EMAIL'],  # :::TO DO::: get user's email from file
                      "PHONENUMBER": contactInfo['PHONENUMBER'],  # ::: TO DO::: dynamically get phone and email info automatically
                      "TIME": time.strftime("%I:%M:%S"),
                      "DATE": time.strftime("%d/%m/%Y")}
        self._lockedIPAddress = consts.IPADDRESS
        self._lockedMachine = consts.HOSTNAME
        self._lockedUserFullName = contactInfo['USERFULLNAME']
        self._lockedUserName = contactInfo['USERNAME']  #interchangeable with consts.USERNAME
        self._lockedEMail = contactInfo['EMAIL']
        self._lockedPhoneNumber = contactInfo['PHONENUMBER']
        LOGGER.debug(["AIE4608"], {'contents': outputDict,
                                   'file': self.file})
        return outputDict
    # end collect_contact_info

    def get_machine_number(self):
        """
        Gets the machine number of the current user

        Returns:
            str: The current machine number of the user
        """
        machineNum = socket.gethostbyname(socket.gethostname()).split('.')[3]
        return machineNum
    # end get_machine_number

    def get_room_number(self):
        """
        Gets the room number of the current user

        Returns:
            str: The room number that the machine exists in
        """
        roomNum = socket.gethostbyname(socket.gethostname()).split('.')[3]
        return roomNum
    # end get_room_number

    def get_network_collection(self):
        """
        Gets a collection of network data about the user
        and packs it into a dict.

        Currently returns the room #, machine #, network ip, and ip prefix

        Returns:
            dict: All of the network-related data is returned as a single dict
        """
        ip = socket.gethostbyname(socket.gethostname())
        ipSplit = ip.split('.')
        roomNum = ipSplit[2]
        machineNum = ipSplit[3]
        networkAddr = '.'.join(ipSplit[:-2])
        outputH = {'ROOM': roomNum,
                   'MACHINE': machineNum,
                   'NETWORKADDR': networkAddr,
                   'IP': ip}
        return outputH
    # end get_network_collection

    @property
    def file(self):
        """
        Gets and sets a handler which points to a file.
        By default, the requested file does not have to be any particular type

        Returns:
            str: A file pointer.
        """
        return self._file
    # end @file.property

    @file.setter
    def file(self, file_h):
        """
        This is the set method for the self._file attribute

        Args:
            file_h (str): The full path file handle
        """
        self._file = file_h
        self._lockedFile = self._file + consts.LOCKED_NOTIFIER
    # end @file.setter

    @file.deleter
    def file(self):
        """
        This is the delete method for the self._file attribute
        """
        del self._file
    # end @file.deleter
    # end file

    @property
    def read_contact_info(self):
        """
        Reads the contact information on the locked file being queried

        Returns:
            dict: Contact info about the user who currently locked the file
        """
        if not os.path.isfile(self._lockedFile):
            # LOGGER.info(['AIE7601', 'match_false'], {'file': self._file})
            return None

        contactInfo = self.collect_contact_info()
        return contactInfo
    # end @read_contact_info.property

    @property
    def locked_file(self):
        """
        Returns:
            str: The full path to a locked file (may or may not actually exist)
        """
        return self._lockedFile
    # end @locked_file.property

    @locked_file.setter
    def locked_file(self, value):
        """
        Originally created to possibly have it so that setting the value to
        True/False would create/delete a locked file but that never happened

        .. Note::
         Currently does not have any network-related functionality built-in

        Args:
            value (str): The locked file name (full path). Overrides the default
                         locked file which is simply self.file +
                         consts.LOCKED_NOTIFIER
        """
        self._lockedFile = value
    # end @locked_file.setter

    @locked_file.deleter
    def locked_file(self):
        """
        Originally created to possibly have it so that deleting the attribute
        would delete a locked file but that never happened

        .. Note::
         Currently does not have any network-related functionality built-in

        """
        del self._lockedFile
    # end @locked_file.deleter
    # end locked_file
# end NetworkManager


# class SpreadSheetConnect(object):
#     """
#     .. Note::
#      Deprecated. Maya/Nuke/Houdini all run on Python 64 bit and, for whatever
#      reason, they don't accept pygame 64 bit as a valid library and won't play
#      music
#     """
#     def __init__(self, wks):
#         """
#         Locked name does not necessarily exist but is the convention for
#         all locked file names.
#         """
#         super(SpreadSheetConnect, self).__init__()
#         self.worksheets = wks
#     # end __init__
#
#     @property
#     def currentWorksheet(self):
#         return self._currentWorksheet
#     # end currentWorksheet.property
#
#     @currentWorksheet.setter
#     def currentWorksheet(self, sheet):
#         self._currentWorksheet = sheet
#     # end @currentWorksheet.setter
#
#     @currentWorksheet.deleter
#     def currentWorksheet(self):
#         self._currentWorksheet
#     # end @currentWorksheet.deleter
#
#     def get_cell_from_username(self, username=None):
#         """
#         Gets the row/column pair by searching the spreadsheet
#         by using the current logged in user's username
#         """
#         if username is not None:
#             output = self.currentWorksheet.find(username)
#         else:
#             output = self.currentWorksheet.find(self.userName)
#         return (output.col, output.row)
#     # end get_cell_from_username
#
#     def collect_contact_info(self):
#         self._userContactInfo = {'USERNAME': self.userName,
#                                  'PHONENUMBER': self.userPhoneNumber,
#                                  'EMAIL': self.userEMail,
#                                  'USERFULLNAME': self.userFullName}
#     # end collect_contact_info
#
#     @property
#     def userContactInfo(self):
#         """
#         Gets contact information about the current user, returns a dict
#         with their information
#         """
#         return self._userContactInfo
#     # end @collect_contact_info.property
#
#     @userContactInfo.setter
#     def userContactInfo(self, contactInfo):
#         credentialsList = ['EMAIL', 'USERNAME', 'PHONENUMBER', 'USERFULLNAME']
#         for cred in credentialsList:
#             if cred not in contactInfo:
#                 break
#         else:
#             self._userContactInfo = contactInfo
#     # end @contactInfo.setter
#
#     @userContactInfo.deleter
#     def userContactInfo(self):
#         del self._userContactInfo
#     # end @contactInfo.deleter
#     # end contactInfo
#
#     @property
#     def userName(self):
#         return self._userName
#     # end username.property
#
#     @userName.setter
#     def userName(self, userName):
#         self._userName = userName
#     # end @userName.setter
#
#     @userName.deleter
#     def userName(self):
#         del self._userName
#     # end @userName.deleter
#     # end userName
#
#     @property
#     def userFullName(self):
#         return self._lockedUserFullName
#     # end @userFullName.property
#
#     @userFullName.setter
#     def userFullName(self, userFullName):
#         self._lockedUserFullName = userFullName
#     # end @userFullName.setter
#
#     @userFullName.deleter
#     def userFullName(self):
#         del self._lockedUserFullName
#     # end @userFullName.deleter
#     # end userFulleName
#
#     @property
#     def userEMail(self):
#         return self._userEMail
#     # end @get_email.property
#
#     @userEMail.setter
#     def userEMail(self, email):
#         self._userEMail = email
#     # end @userEMail.setter
#
#     @userEMail.deleter
#     def userEMail(self):
#         del self._userEMail
#     # end @userEMail.deleter
#     # end userEMail
#
#     @property
#     def userPhoneNumber(self):
#         return self._userPhoneNumber
#     # end @get_email.property
#
#     @userPhoneNumber.setter
#     def userPhoneNumber(self, phoneNumber):
#         self._userPhoneNumber = phoneNumber
#     # end @userEMail.setter
#
#     @userPhoneNumber.deleter
#     def userPhoneNumber(self):
#         del self._userPhoneNumber
#     # end @userPhoneNumber.deleter
#     # end userPhoneNumber
# # end SpreadsheetConnect


def state_change_all(self, rootdir, state):
    """
    Locks/Unlocks every asset in the specified directory.
    Useful to lock/unlock all files in the project directory

    Args:
        rootdir (str): The folder to begin recursively finding files to change
        state (bool): True/False. True creates locked files, False deletes them

    Returns:
        NoneType: None
    """
    if consts.USERNAME not in consts.REGISTERED_ADMINS:
        LOGGER.critical(['AIE900'], {'user': consts.USERNAME,
                                     'admins': consts.REGISTERED_ADMINS})
        return None

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

# def get_crewmember_contact_info(credentials, wks, user=None):
#     """
#     .. Note::
#      Deprecated because Maya/Houdini/Nuke won't recognize pygame as a valid
#      module, even when using the x64 bit compiler
#     """
#     # receive worksheet info
#     gc = gspread.authorize(credentials)
#     wks = gc.open(wks)
#     sprdsht = SpreadSheetConnect(wks)
#     sprdsht.currentWorksheet = sprdsht.worksheets.sheet1
#     sprdsht.userName = user
#
#     # get username, full name, phone number, and email
#     if sprdsht.userName is None:
#         return None  # end script - nothing to search for
#
#     try:
#         userNameCell = sprdsht.currentWorksheet.find(sprdsht.userName)
#         userNameCellColLetter = chr((userNameCell.col - 1) + ord('A'))
#         userNameCellRow = userNameCell.row
#     except gspread.exceptions.CellNotFound:
#         userNameCell = None
#     except:
#         raise
#
#     if userNameCell is not None:
#         cell = "{c}{r}".format(c=userNameCellColLetter,
#                                r=userNameCellRow)
#         cell = sprdsht.currentWorksheet.acell(cell)
#         userNameCell = cell.value
#
#     # use and assume userNameCellRow as the row of information we need
#     # get full name
#     try:
#         userFullName = sprdsht.currentWorksheet.find("Name")
#         userFullNameColLetter = chr((userFullName.col - 1) + ord('A'))
#     except gspread.exceptions.CellNotFound:
#         userFullName = None
#     except:
#         raise
#
#     if userFullName is not None:
#         cell = "{c}{r}".format(c=userFullNameColLetter,
#                                r=userNameCellRow)
#         cell = sprdsht.currentWorksheet.acell(cell)
#         userFullName = cell.value
#
#     # get phone number
#     try:
#         userPhoneNumber = sprdsht.currentWorksheet.find("Phone Number")
#         userPhoneNumberColLetter = chr((userPhoneNumber.col - 1) + ord('A'))
#     except gspread.exceptions.CellNotFound:
#         userPhoneNumber = None
#     except:
#         raise
#
#     if userPhoneNumber is not None:
#         cell = "{c}{r}".format(c=userPhoneNumberColLetter,
#                                r=userNameCellRow)
#         cell = sprdsht.currentWorksheet.acell(cell)
#         userPhoneNumber = cell.value
#
#     # get EMail
#     try:
#         userEMail = sprdsht.currentWorksheet.find("Email")
#         userEMailColLetter = chr((userEMail.col - 1) + ord('A'))
#     except gspread.exceptions.CellNotFound:
#         userEMail = None
#     except:
#         raise
#
#     if userEMail is not None:
#         cell = "{c}{r}".format(c=userEMailColLetter,
#                                r=userNameCellRow)
#         cell = sprdsht.currentWorksheet.acell(cell)
#         userEMail = cell.value
#
#     sprdsht.userPhoneNumber = (203,722,6620)
#     sprdsht.userFullName = userFullName
#     sprdsht.userPhoneNumber = userPhoneNumber
#     sprdsht.userEMail = userEMail
#     sprdsht.collect_contact_info()
#     return sprdsht.userContactInfo
# # end get_crewmember_contact_info

# DEPRECATED - Requires a 32bit python installation - Note 66
# Maya does not support this - and although it can be forced
# it will likely be in vein since Nuke and Houdini are also 64 bti
# if you still want to switch, info is here:
# https://stackoverflow.com/questions/20370100/changing-python-version-in-maya
# https://stackoverflow.com/questions/14656593/how-do-i-change-the-python-version-in-maya-2013/14706115#14706115
# def project_member_contact_info(user=None, wks=None):
#     """
#     Gets the contact info of a crewmember on the project
#     by accessing the private google-docs page
#     """
#     LOGGER.info("START")
#     userName = getpass.getuser()
#     if user is not None:
#         userName = user

#     if 'PIPELINE_DIR' in os.environ:
#         baseDir = os.environ['PIPELINE_DIR']
#         crewSheet = os.path.join(baseDir,
#                              'latest_CONFIG',
#                              'conf_INFO',
#                              'crew_sheet_gdocs_auth.json')
#     elif 'PROJECT_DIR' in os.environ and \
#             'Pipeline' in os.listdir(os.environ['PROJECT_DIR']):
#         baseDir = os.path.join(os.environ['PROJECT_DIR'], 'Pipeline')
#         LOGGER.info("Found path: {f}".format(baseDir))
#         crewSheet = os.path.join(baseDir,
#                              'the_LATEST',
#                              'latest_CONFIG',
#                              'conf_INFO',
#                              'crew_sheet_gdocs_auth.json')
#     else:
#         LOGGER.critical(['AIE9103', 'match_false'],
#                         {'script': os.path.basename(__file__)})

#     json_key = json.load(open(crewSheet))
#     scope = ['https://spreadsheets.google.com/feeds']
#     credentials = SignedJwtAssertionCredentials(json_key['client_email'],
#                                                 json_key['private_key'].encode(),
#                                                 scope)
#     if wks is None:
#         wks = 'Crew_spreadsheet_dup_test'

#     contactInfo = get_crewmember_contact_info(credentials, wks, userName)
#     return contactInfo
# # end project_member_contact_info


def project_member_contact_info(user=None, wks=None):
    """
    Reads crewmember information from consts.CREWSHEET using consts.USERNAME as
    the key and gets that user's information

    Args:
        user (str): Overrides consts.USERNAME if not None
        wks (str): The full path to a JSON file which contains a dictionary

    Returns:
        dict: The user's information
    """
    userName = consts.USERNAME
    if user is not None:
        userName = user

    if wks is not None:
        crewsheet = wks
    else:
        crewsheet = consts.CREWSHEET

    with open(crewsheet, "r") as f:
        crewDict = json.load(f)
    crewDict = omnibus.convert(crewDict)

    if userName in crewDict:
        userInfo = crewDict[userName]
    else:
        userInfo = None

    return userInfo
# end project_member_contact_info


if __name__ == "__main__":
    print (__doc__)
    # print project_member_contact_info()
    # networkM = NetworkManager()
    # networkM.collect_contact_info()

    # print project_member_contact_info(wks='Crew_spreadsheet_dup_test')
