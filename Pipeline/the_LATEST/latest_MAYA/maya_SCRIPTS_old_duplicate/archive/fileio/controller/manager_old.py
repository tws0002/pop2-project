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
import os

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from constants.model.constants import LOGGER
from network.controller.network_0001 import NetworkManager
from fileio.controller import checkout_0001 as checkout
def open_checkout_maya(file_h):
	"""
	Standard implementation of checking out a file in Maya

	WIP Procedure
	- is maya file
	- is the file the proper naming convention?
	- determine if local
	- determine if remote
	- determine if a registered user
	- is the queried file+folder path over the OS's character limit? 
	- is the root folder+filename too long for the farm?

	- if successful open, lock the file
	- init maya with a new scriptjob for opening/saving (since the old one 
	  will die as soon as the new file is opened)
	"""
	fileIO = FileIO(file_h)
	if not fileIO.is_maya_file_fast():
		LOGGER.error(['MYA5702', 'match_false', {'file': self.fullPath}])
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if not fileIO.check_naming_convention():
		LOGGER.info(['AIE6601', 'match_false', {'file': self.fullPath}])
		# ::AUTHOR NOTE:: ::TO DO:: have a print-out of all maya-related name conventions
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if not fileIO.is_local:
		LOGGER.info(['AIE4200'], {'user': consts.USERNAME, 
								  'network': consts.NETWORKNAME})
	if fileIO.is_remote:
		LOGGER.info(['AIE4200'], {'user': consts.USERNAME, 
								  'ip': consts.IPADDRESS})
	if not fileIO.is_registered:
		LOGGER.critical(['AIE9001'], {'user': consts.USERNAME})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if fileIO.is_character_limit() or fileIO.is_farm_character_limit():
		LOGGER.error(['MYA5603'], {'file': fileIO.fileName, 
								   'path': fileIO.filePath})
		sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))
	if fileIO.open_file():
		fileIO.set_lock()
	else:
		LOGGER.critical(['AIE9002'], {'file': fileIO.fileName})
# end open_checkout_maya

def save_checkout_maya():
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
	fileIO.allow_save = True
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
# end save_checkout_maya

if __name__ == "__main__":
	save_checkout_maya()
	# print(__doc__)