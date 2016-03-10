#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
.. Project::
 Portal Origins: Part Two
.. Description::
 Manager inits the specific methods from checkout to use for fileIO operations
.. Notes::
 sys.exit() has an interesting role in this module. Instead of exitting Maya altogether,
 sys.exit() just stops the beforeSaveCheck and immediatelly executes the save command.
 If the script instructs Maya to block the save command, the save will fail and vice versa.
.. Author::
 Colin Kennedy
.. TODO::
 Create extensive test cases for these open/save modules
"""

# IMPORT STANDARD LIBRARIES
import sys, os
import getpass
import socket
import functools

# IMPORT THIRD PARTY LIBRARIES
try:
	import maya.OpenMaya as om
	import maya.cmds as cmds
except:
	pass

try:
	import nuke
except ImportError:
	pass

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
from network.controller.network import NetworkManager
import fileio.view.fileproof as fileproof
import checkout
import paths
# import metadatamaya as metamaya
from pysix import six


GLOB_ERROR_MSG = ''


def nuke_get_path_from_write_node(inputH, knob="file"):
	"""
	Gets a file path from a specified node/input

	This function normalizes and attempts to make absolute all paths,
	whether the input is originally absolute or relative

    .. Considerations::
     This method was originally written simply for Nuke objects and getting
     their knobs but it was eventually adopted to take strings with parseable
     text (such as %04d, $F4, ####) and an integer as knob in order to return
     a specific frame number in a sequence. Sorry this method got shoe-horned
     in so poorly

    Exmaple Use #1:
     >>> nukeObject = nuke.toNode("Write1")
     >>> fileKnobName = "file"
     >>> nuke_get_path_from_write_node(nukeObject, fileKnobName)
     "/whatever/is/nuke/node/file/knob/filename_####.tiff"

    Example Use #2:
     >>> filename = r"/some/path/filename_####.tiff"
     >>> indexNumber = 8
     >>> nuke_get_path_from_write_node(filename, indexNumber)
     "/some/path/filename_0008.tiff"

    Args:
        inputH (Nuke object or str): The input node or string to get the full
                                     path from
        knob (str or int): A string to a Nuke object knob or an integer for
                           parsed text

    Returns:
        str: The actual filename to save
	"""
	# LOGGER.info('string inputH:' + str(inputH))
	# LOGGER.info('string knob:' + str(knob))
	# LOGGER.info('string inputH:' + str(type(inputH)))
	# LOGGER.info('string knob:' + str(type(knob)))
	LOGGER.info('INPUT fileToSave:' + str(inputH))

	# replace anjy parseable text with a number sequence with padding
	if isinstance(knob, int) and paths.is_parseable(inputH) \
			and isinstance(inputH, six.string_types):
		fileToSave = paths.get_expanded_str_from_index(inputH, knob)
		fileToSave = os.path.join(os.path.dirname(inputH), fileToSave)
	elif isinstance(knob, int) and isinstance(inputH, six.string_types):
		fileToSave = inputH
	else:
		fileToSave = inputH[knob].value()
	# get absolute path of file
	if os.path.isabs(fileToSave):
		fileToSave = os.path.normpath(fileToSave)  # redundant but just in case
	else:
		baseDir = nuke.Root()['project_directory'].value()
		if baseDir == '[python {nuke.script_directory()}]':
			# :::TO DO::: potentially vulnerable.
			# perhaps process with regex or as TCL and get/run the result?
			#
			baseDir = nuke.script_directory()
		fileToSave = os.path.join(baseDir, fileToSave)
		fileToSave = os.path.normpath(fileToSave)
	# LOGGER.info('string inputH:' + str(inputH))
	# LOGGER.info('string knob:' + str(knob))
	LOGGER.info('string fileToSave:' + fileToSave)
	return fileToSave
# end nuke_get_path_from_write_node


def checkout_nuke_write_render_before(fileIO, filePath, forceSave=consts.FORCE_SAVE):
	"""
	Standard implementation of writing files. Originally built for Nuke but
    later implements Exceptions in order to make the function agnostic. In
    every implementation of each software, this function is wrapped in a
    try/except block which, upon exception, will then handle the issue of
    blocking or allowing saves. This was an alternative to subclassing out
    and maintaining separate classes for each application.

    For a full list of the checks that this function undergoes,
    see :ref:`fileio#checks_to_allow_access`

    Examples
    --------
    The function is used in mayamanager :ref:`mayamanager`, nukemanager
    :ref:`nukemanager`, and houdinimanager :ref:`houmanager`

    fileIO: The FileIO class the be passed and instantiated within
                   the function
     .. Note::
      This has been largely deprecated because, instead of using subclasses
      PASsed directly into the function, this function remains generic and
      simply uses exceptions to escape the script mid-execution when a file is
      allowed/disallowed access permissions. These exceptions are built
      directly in to one of the base classes from within fileio. For more
      information, see: the fileio.controller.checkout module :ref:`fileio`,
      and the fileio.controller.globerror module for the list of exceptions
      :ref:`exceptions`

    Args:
        fileIO (<FileIO object>): fileIO base object (and be any class as long
                                  as it inherits from FileIO)
        filePath (str): The full path to a file location. This location is where
                        read/write access permission is determined
        forceSave (bool): Ignores the entire save method and lets the user save
        .. note::
        	Using this method does NOT lock the file during save, and is thus unsafe

    Returns:
        <IOValidationError or IOValidationPassedError> Technically nothing but
                                                       will almost always raise
                                                       some sort of error for
                                                       exception handling
	"""
	# Null - replace later
	# fileToSave = r"C:\Users\korinkite\Dropbox\Private\my_PROJECT\proj_POP2\Pipeline\the_LATEST_pre_maya_open_close_edits_0001\sys_PY\py_MODULES\fileio\test\test_nuke_project\output\s001_ckenne24_010_MODEL_someDescription.0001.ma"
	fileToSave = filePath  # ::TO DO:: "fileToSave" is redundant. search/replace all in this function to "filePath"
	LOGGER.info(['AIE1601'], {'file': fileToSave})
	global GLOB_ERROR_MSG
	fileIO = fileIO(fileToSave)
	# fileIO.allow_save = True  # by default, let the user save
	# if consts.USERNAME == "kerfuffle":
	# 	LOGGER.info("FILECHECKOUT: Got the value of true and is going to throw the pass error")
	# 	LOGGER.info("ALLOW SAVE WILL SOON BE TRUE")
	# 	fileIO.allow_save = True
	if forceSave == True:
		fileIO.allow_save = True  # exit the script and set the save status

	if not fileIO.is_registered:
		LOGGER.warning(['AIE7700', 'match_false'], {'user': getpass.getuser(),
												  'proj': consts.PROJECT_NAME_LONG})
		fileIO.error_msg = "You are not currently registered on the project\n\n"\
						   "Please contact admin {admins} to get "\
						   "started!".format(admins=consts.ADMIN_CONTACT_INFO)
		fileIO.allow_save = False

	networkManager = NetworkManager()
	networkManager.file = fileToSave

	# DEPRECATED - I'm placing this in the consts file, instead
	# if not networkManager.is_allowed_application():
	# 	LOGGER.warning(['6900', 'match_false'], {'app': os.environ['APP_EXECUTABLE'], 'proj': consts.PROJECT_NAME_LONG})
	# 	fileIO.allow_save = False

	if networkManager.is_local():
		LOGGER.info(['AIE1200'])
		LOGGER.info(['AIE1201'])
		fileIO.allow_save = True
	elif networkManager.is_remote():
		# ::TO DO:: You will need to add a FTP protocol here. Or change some variable here
		# to be used in a future method later
		LOGGER.critical(['AIE1201'])
		msg = "Remote access is disabled. Must be on SCAD network in order to work"
		GLOB_ERROR_MSG = msg
		fileIO.error_msg = msg
		LOGGER.error(['AIE7201', 'match_false'],
					 {'ip': socket.gethostbyname(socket.gethostname())})
		fileIO.allow_save = False

	if not networkManager.has_access():
		LOGGER.warning(["AIE5601", 'match_false'], {'file': fileIO.fullPath})
		contactInfo = networkManager.read_contact_info_from_locked_file()
		isContInfoMissing = networkManager.is_incomplete_read_contact_info(contactInfo)

		if isContInfoMissing:
			msg = "Attempted to get contact info from:\n\n{loc}\n\nbut the user "\
				  "has bad credentials.\n\nSave this: {dict}\n\n"\
				  "Please notify admin\n\n{bug}".format(loc=fileToSave,
				  					   				    dict=contactInfo,
				  										bug=consts.BUG_REPORT_PAGE)
		else:
			msg = "Save Location:\n\n{loc}\n\nis lacking permissions for "\
				  "current account.\nThe current owner of the file is\n"\
				  "username: {username}\n\n"\
				  "name: {name}\n\n"\
				  "ip: {ip}\n"\
				  "room number: {roomnumber}\n"\
				  "machine: {machinenumber}\n"\
				  "time locked: {time}\n"\
				  "date locked: {date}\n"\
				  "e-mail: {email}\n"\
				  "phone number: {phonenumber}\n\n"\
				  "IMPORTANT: IF THIS IS YOU - Please send a bug report "\
				  "to the admin immediately.\n\n{bug}\n\nIf it isn't you and "\
				  "you're in the computer labs, their room number is above. "\
				  "Otherwise, you can just call them, "\
				  "too.".format(loc=fileToSave,
				  		 	    name=contactInfo["USERFULLNAME"],
				  				username=contactInfo["USERNAME"],
				  				ip=contactInfo["IP"],
				  				roomnumber=contactInfo['ROOM'],
				  				machinenumber=contactInfo["MACHINE"],
				  				time=contactInfo["TIME"],
				  				date=contactInfo["DATE"],
				  				email=contactInfo['EMAIL'],
				  				phonenumber=contactInfo["PHONENUMBER"],
				 				bug=consts.BUG_REPORT_PAGE)
		GLOB_ERROR_MSG = msg
		fileIO.error_msg = msg
		LOGGER.error(['AIE9002', 'match_false'], {'file': fileToSave})
		LOGGER.error(msg)
		fileIO.allow_save = False

	if fileIO.check_naming_convention(regex=consts.RE_FILENAME_MATCH) is None:
		LOGGER.warning(["AIE6601", 'match_false'],
					   {'f':fileIO.fullPath, 'convention': consts.MATCH_RE})

		for name in consts.FILE_CONVENTION_EXAMPLE['Nuke']:
			LOGGER.info(['AIE5605'], {'name': name})
		msg = "File: {f} does not match any possible naming "\
			  "conventions".format(f=fileToSave)
		GLOB_ERROR_MSG = msg
		fileIO.error_msg = msg
		fileIO.allow_save = False

	if fileIO.is_character_limit():
		LOGGER.warning(['AIE6500'], {'path': fileIO.fullPath, 'limit': fileIO._sys_character_limit})
		msg = "Path: \"{path}\" exceeds character limit \"{limit}\". Please shorten your file",
		msg = msg.format(path=FileIO.fullPath, limit=FileIO._sys_character_limit)
		GLOB_ERROR_MSG = msg
		fileIO.error_msg = msg
		fileIO.allow_save = False

	if fileIO.is_farm_character_limit():
		LOGGER.warning(['AIE6500'], {'path': fileIO.fullPath, 'limit': fileIO._farm_character_limit})
		msg = "Path: \"{path}\" exceeds character limit \"{limit}\". Please shorten your file",
		msg = msg.format(path=FileIO.fullPath, limit=FileIO._farm_character_limit)
		GLOB_ERROR_MSG = msg
		fileIO.error_msg = msg
		fileIO.allow_save = False

	if not fileIO.allow_save:
		# just in case for some reason the script failed to exit, one last check
		GLOB_ERROR_MSG = msg
		LOGGER.warning(['AIE9700'], {"file": fileToSave})
		fileIO.set_save = False

	# File survived all check conditions
	# Lock the file in preparation for saving if it is not already
	# (if it is already, we presume it's because they're an admin)
	# (or they are the user that locked it)
	#
	if not networkManager.is_locked:
		LOGGER.info('fileToSave' + str(fileToSave))
		# create the nested folder structure for the file
		folderToSaveInto = os.path.dirname(fileToSave)
		if not os.path.isdir(folderToSaveInto):
			if networkManager.is_local():
				LOGGER.info(['AIE5606', 'match_false'], {'folder': folderToSaveInto})
			else:
				LOGGER.info(['NET5606', 'match_false'], {'folder': folderToSaveInto})
			paths.mkdir_p(folderToSaveInto)

		networkManager.locked = True  # lock the file from external editting
		lockedUserInfo = networkManager.collect_contact_info()
		LOGGER.info(['AIE1202'], {"full_name": lockedUserInfo['USERFULLNAME'],
								  "user": lockedUserInfo['USERNAME'],
								  "ip": lockedUserInfo['IP'],
								  "machine": lockedUserInfo['MACHINE'],
								  "email": lockedUserInfo['EMAIL'],
								  "phone": lockedUserInfo['PHONENUMBER']})
		LOGGER.info(['AIE1203'], {"f": fileToSave})
	fileIO.allow_save = True  # exit the script and set the save status
# end checkout_nuke_write_render_before


def checkout_maya_open_check(retCode, clientData):
	"""
	Standard implementation of checking out a file in Maya

	WIP Procedure
	- determine if maya file
	- is the file the proper naming convention?
	- determine if local
	- determine if remote
	- determine if a registered user
	- is the queried file+folder path over the OS's character limit?
	- is the root folder+filename too long for the farm?

	.. AUTHORNOTE::
	 Is that currently even a restriction right now?

	- if in maya, use the maya open command with a file open GUI
	- if in the command shell, use a command shell call method, instead
	- open the file

	- check the open. If open was successful, lock the file
	- init maya with a callback for opening/saving
	"""
	# fileToOpen = '/home/ckenne24/mount/stuhome/s001_ckenne24_069_exampleProject.0001.ma'  # ::TO DO:: remove
	fileToOpen = om.MfileIO.beforeOpenFilename()

	fileIO = checkout.FileCheckoutMaya(fileToOpen)

	if fileIO.fileName.endswith(('untitled.ma', 'untitled.mb')):
		return True  # pass thru for the default maya session

	if not fileIO.is_maya_file_fast():
		LOGGER.error(['MYA5702', 'match_false'], {'file': fileIO.fullPath})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if not fileIO.check_naming_convention(consts.RE_FILENAME_MATCH):
		LOGGER.info(['AIE6601', 'match_false'], {'file': fileIO.fullPath,
												 'convention': consts.MATCH_RE,
												 'match': consts.RE_FILENAME_MATCH})
		# ::AUTHORNOTE:: ::TO DO:: have a print-out of all maya-related name conventions
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	networkManager = NetworkManager()
	networkManager.file = fileToOpen

	if networkManager.is_local():
		LOGGER.info(['AIE1200'])
	elif networkManager.is_remote():
		# ::TO DO:: You will need to add a FTP protocol here.
		# Or change some variable here to be used in a future method later
		LOGGER.info(['AIE1201'])
		# ::TO DO:: Value is set to False to not allow any FTP work currently.
		# Once I have a method for this remove
		fileIO.allow_save = False

	if not fileIO.is_registered:
		LOGGER.critical(['AIE9001'], {'user': consts.USERNAME})
		fileIO.allow_save = False
	if fileIO.is_character_limit or fileIO.is_farm_character_limit:
		LOGGER.error(['MYA5603'], {'file': fileIO.fileName,
								   'path': fileIO.filePath})
		fileIO.allow_save = False

	if not fileIO.allow_save:
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	if fileIO.open_file():
		networkManager.locked = True
	else:
		LOGGER.critical(['AIE9002'], {'file': fileIO.fileName})
# end open_checkout_maya


def cancel_save_maya(msg):
	"""
	Customize the canceled save window
	"""
	allowSave = fileIO.allow_save

	string_key = "s_TfileIOStrings.rFileOpCancelledByUser"
	string_default = "File operation cancelled by user supplied callback."
	string_error = msg
	message = string_error if allowSave else string_default
	cmds.displayString(string_key, replace=True, value=message)
# end cancel_save_maya


def checkout_maya_close_check(retCode, clientData):
	"""
	Method to run when Maya has successfully exitted/closed

	- If file was not locked upon closing - send warning that the file was
	unlocked and could have been editted by another user
	- If the file is locked, unlock it
	- deinitialize the entire Maya session
	"""
	fileToClose = cmds.file(q=True, loc=True)  # current file

	if fileToClose.endswith(('untitled.ma', 'untitled.mb')):
		return True  # pass thru any temporary files

	networkManager = NetworkManager()
	networkManager.file = fileToClose

	if networkManager.is_locked:
		LOGGER.info(['NET5501'], {'file': fileToClose})
		networkManager.locked = False  # remove locked file

	clear_all()  # clear the current session
# end checkout_maya_close_check


def clear_all():
	"""
	Clean-up method to ensure that Maya boots from an initial state between sessions

	The method clears:
	- local environment variables
	- variables specific to the Maya session
	- Maya scriptJobs/callbacks (if applicable)
	"""
	LOGGER.debug(['AIE4800'])

	# Delete all constants and env vars
	for var in consts.ENV_VARS_MA:
		del os.environ[var]

	# Delete all project constants
	del consts.PROJECT_PATH_LINUX
	del consts.PROJECT_PATH_WINDOWS
	del consts.HOSTNAME
	del consts.IPADDRESS
	del consts.NETWORKNAME
	del consts.PROJECT_DIR
	del consts.SYSTEM
	del consts.ROOT_DIR
	del consts.DEV_DIR
	del consts.PUBLISH_DIR
	del consts.CONFIG_DIR
	del consts.MATCH_RE
	del consts.RE_FILENAME_MATCH
	del consts.LOCKED_NOTIFIER
	del consts.SUPPORTED_PLUGINS_MAYA
	del consts.SUPPORTED_APPLICATIONS
	del consts.REGISTERED_ADMINS
	del consts.FILETYPES_MAYA

	# Delete scriptJobs/callbacks
	# del CB_BSC
# end clear_all

if __name__ == "__main__":
	# checkout_maya_open_check()
	# checkout_maya_save_check()
	# checkout_maya_close_check()
	# print(__doc__)
	checkout_nuke_write_check()
