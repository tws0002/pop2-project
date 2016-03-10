#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Manages file permissions for Nuke in GUI-mode
"""

# IMPORT THIRD PARTY LIBRARIES
import os
import nuke

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths_0002 as paths


def foo():
	return False
# end foo


def write_render_check(thisNode, param):
	"""
	Standard implementation of checking out a file in Nuke

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
	if thisNode is None:
		thisNode = True
	if param is None:
		param = "file"
	checkout = checkout.FileCheckoutNuke()
	fileToSave = checkout.get_save_file(thisNode=thisNode, 
										param=param)
	fileIO = checkout.FileCheckoutNuke(fileToSave)
	fileIO.set_save = True  # by default, let the user save

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
		LOGGER.info(["AIE5601", 'match_false'], {'file': fileIO.fullPath})
		fileIO.allow_save = False
		# sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	if not fileIO.check_naming_convention(consts.RE_FILENAME_MATCH_MA):
		LOGGER.warning(["AIE6601", 'match_false'], {'f':fileIO.fullPath,
											'convention': consts.MATCH_MA})
		for name in consts.FILE_CONVENTION_EXAMPLE['Maya']:
			LOGGER.info(['AIE5605'], {'name': name})
		fileIO.allow_save = False
		# sys.exit(consts.SCRIPTEXIT.format(s=os.path.basename(__file__)))

	if fileIO.is_character_limit():
		LOGGER.warning(['AIE6500'], {'path': fileIO.fullPath, 'limit': fileIO._sys_character_limit})
		fileIO.allow_save = False

	if fileIO.is_farm_character_limit():
		LOGGER.warning(['AIE6500'], {'path': fileIO.fullPath, 'limit': fileIO._farm_character_limit})
		fileIO.allow_save = False

	if fileIO.allow_save == False:
		LOGGER.crtical(['AIE9700'], {"file": fileToSave})
		fileIO.set_save(False)  # actually kills the maya save command
		# sys.exit('asdf')  # kills the current check

	# File at this point is ready for saving
	# Lock the file in preparation for saving if it is not already
	if not networkManager.is_locked:
		networkManager.locked = True  # lock the file from external editting
		lockedUserInfo = networkManager.get_contact_info()
		LOGGER.info(['AIE1202'], {"machine": lockedUserInfo['USERNAME'],
								 "ip": lockedUserInfo['IP'],
								 "email": lockedUserInfo['EMAIL'],
								 "phone": lockedUserInfo['PHONE']})
		LOGGER.info(['AIE1203'], {"f": fileToSave})

	# Unlock the file after saving if the saved version is not the current opened session
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
	
	# permission to render is now True
	fileDir = os.path.dirname(filePath)
	if not os.path.isdir(fileDir):
		paths.mkdir_p(fileDir)
# end write_render_check


if __name__ == "__main__":
	print(__doc__)
