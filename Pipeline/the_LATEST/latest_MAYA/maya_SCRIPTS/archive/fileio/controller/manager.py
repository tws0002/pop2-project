#!/usr/bin/python

"""
..Project::
 Portal Origins: Part Two
..Description::
 Manager inits the specific methods from checkout to use for fileIO operations
..Author::
 Colin Kennedy
::TO DO::
 Create extensive test cases for these open/save modules
"""

# IMPORT STANDARD LIBRARIES
import sys, os

# IMPORT THIRD PARTY LIBRARIES
import maya.cmds as cmds

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from constants.model.constants import LOGGER
from network.controller.network_0001 import NetworkManager
from fileio.controller import checkout_0001 as checkout

def checkout_maya_open_check():
	"""
	Standard implementation of checking out a file in Maya

	WIP Procedure
	- determine if maya file
	- is the file the proper naming convention?
	- determine if local
	- determine if remote
	- determine if a registered user
	- is the queried file+folder path over the OS's character limit? 
	- is the root folder+filename too long for the farm? (::AUTHOR NOTE:: is that even a restriction?)

	- if in maya, use the maya open command with a file open GUI
	- if in the command shell, use a command shell call method, instead
	- open the file

	- check the open. If open was successful, lock the file
	- init maya with a callback for opening/saving
	"""

	fileToOpen = '/home/ckenne24/mount/stuhome/s001_ckenne24_069_exampleProject.0001.ma'

	fileIO = checkout.FileCheckoutMaya(fileToOpen)
	if not fileIO.is_maya_file_fast():
		LOGGER.error(['MYA5702', 'match_false'], {'file': fileIO.fullPath})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if not fileIO.check_naming_convention(consts.RE_FILENAME_MATCH_MA):
		LOGGER.info(['AIE6601', 'match_false'], {'file': fileIO.fullPath, 
												 'convention': consts.MATCH_MA,
												 'match': consts.RE_FILENAME_MATCH_MA})
		# ::AUTHOR NOTE:: ::TO DO:: have a print-out of all maya-related name conventions
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	
	networkManager = NetworkManager()
	networkManager.file = fileToOpen

	if networkManager.is_local():
		LOGGER.info(['AIE1200'])
	elif networkManager.is_remote():
		# ::TO DO:: You will need to add a FTP protocol here. Or change some variable here 
		# to be used in a future method later
		LOGGER.info(['AIE1201'])
		fileIO.allow_save = False  # ::TO DO:: Once I have a method for this, remove

	if not fileIO.is_registered:
		LOGGER.critical(['AIE9001'], {'user': consts.USERNAME})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if fileIO.is_character_limit or fileIO.is_farm_character_limit:
		LOGGER.error(['MYA5603'], {'file': fileIO.fileName, 
								   'path': fileIO.filePath})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if fileIO.open_file():
		networkManager.locked = True
	else:
		LOGGER.critical(['AIE9002'], {'file': fileIO.fileName})
# end open_checkout_maya

def checkout_maya_save_check():
	"""
	Standard implementation of checking out a file in Maya

	steps:
	- open GUI for the save dialog
	 - get the filename that the user inputs

	- check if the user is local or network
	- check if they are remote or in the SCAD monty network
	- is the file is locked and the file is not locked by them 
							    or they are not an admin
     - if so, fail the save command

    - check the suggested file's naming convention, if it is not the proper convention
     - if so, fail the save command

    - if the file is not locked
     - create a lock file
    - save the file
    - if the file that was just saved is not the current session, unlock the file

    AUTHOR NOTE:: ::TO DO:: the locked_by_them method should return True if the file is not locked
	"""
	# get the string from the GUI
	# fileToSave = "/home/ckenne24/mount/stuhome/example_file.ma"  # ::TO DO:: delete this later
	fileToSave = "/temp/Temp/example_file.ma"  # ::TO DO:: delete this later
	if not os.path.isfile(fileToSave):
		sys.exit('file does not exist')
	fileIO = checkout.FileCheckoutMaya(fileToSave)
	if fileIO.is_registered:
		fileIO.allow_save = True
	else:
		fileIO.allow_save = False

	networkManager = NetworkManager()
	networkManager.file = fileToSave

	if networkManager.is_local():
		LOGGER.info(['AIE1200'])
	elif networkManager.is_remote():
		# ::TO DO:: You will need to add a FTP protocol here. Or change some variable here 
		# to be used in a future method later
		LOGGER.info(['AIE1201'])
		fileIO.allow_save = False  # ::TO DO:: Once I have a method for this, remove

	if not networkManager.has_access():
		LOGGER.error(["AIE5601", 'match_false'], {'file': fileIO.fullPath})
		fileIO.allow_save = False
		# sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	if not fileIO.check_naming_convention(consts.RE_FILENAME_MATCH_MA):
		LOGGER.warning(["AIE6601", 'match_false'], {'f':fileIO.fullPath,
											'convention': consts.MATCH_MA})
		for name in consts.FILE_CONVENTION_EXAMPLE['Maya']:
			LOGGER.info(['AIE5605'], {'name': name})
		fileIO.allow_save = False
		# sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	if fileIO.allow_save == False:
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	# Lock the file in preparation for saving
	# Unlock the file after saving if the saved version is not the current opened session
	if not networkManager.is_locked:
		networkManager.locked = True
		lockedUserInfo = networkManager.get_contact_info()
		LOGGER.info(['AIE1202'], {"machine": lockedUserInfo['USERNAME'],
								 "ip": lockedUserInfo['IP'],
								 "email": lockedUserInfo['EMAIL'],
								 "phone": lockedUserInfo['PHONE']})
		LOGGER.info(['AIE1203'], {"f": fileToSave})

	if fileIO.is_character_limit:
		LOGGER.warning(['AIE6500'], {'path': fileIO.fullPath, 'limit': 255})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	else:		
		# cmds.file(rename=fileToSave)  # :::TO DO::: implement immediately!!!
		if fileToSave.endswith(('.ma', '.MA')):
			# cmds.file(save=True, type='mayaAscii')  # :::TO DO::: implement immediately!!!
			pass
		elif fileToSave.endswith(('.mb', '.MB')):
			# cmds.file(save=True, type='mayaBinary')  # :::TO DO::: implement immediately!!!
			pass

	# currentMayaSession = cmds.file(q=True, ns=True)  # the current maya file name  # :::TO DO::: CHANGE IMMEDIATELY
	# currentMayaSession = fileToSave
	# currentMayaSession = ''
	# savedMayaSession = os.path.basename(fileToSave)  # the saved maya file

	currentMayaSession = fileToSave
	savedMayaSession = currentMayaSession + '1'

	if savedMayaSession != currentMayaSession:
		LOGGER.debug(['AIE1205'], {"f": fileToSave})
		LOGGER.info(['AIE1204'], {"f": fileToSave})
		networkManager.locked = False
# end checkout_maya_save_check

def close_checkout_maya():
	"""
	Method to run when Maya has successfully exitted/closed

	- If file was not locked upon closing - send warning that the file was
	unlocked and could have been editted by another user
	- If the file is locked, unlock it
	- deinitialize the entire Maya session
	"""
	pass
	# cmds.file(q=True, ns=True)
	# clear_all()
# end close_checkout_maya

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
    del consts.MATCH_MA
    del consts.RE_FILENAME_MATCH_MA
    del consts.LOCKED_NOTIFIER
    del consts.SUPPORTED_PLUGINS_MAYA
    del consts.SUPPORTED_APPLICATIONS
    del consts.REGISTEREDADMINS
    del consts.FILETYPES_MAYA

    # Delete scriptJobs/callbacks
    # del CB_BSC
# end clear_all

if __name__ == "__main__":
	# checkout_maya_open_check()
	# open_checkout_maya()
	checkout_maya_save_check()
	print(__doc__)