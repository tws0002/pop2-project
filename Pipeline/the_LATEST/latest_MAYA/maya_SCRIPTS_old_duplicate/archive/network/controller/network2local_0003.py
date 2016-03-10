#!/usr/bin/python

"""\
..Project::
 Portal Origins: Part Two
..Description::
 Creates a local copy of a Maya file that exists over the network. network2local
 reads the file directly, determines only what needs to be copied, and then
 copies the relative paths and their folder structure to a user-specified output
 directory
..TO DO::
 Make a FTP-client system to send over multiple addresses in parallel 
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os, sys
import argparse

# IMPORT LOCAL LIBRARIES
from fileio.controller import fileio_0001 as fileio
import constants.model.constants as consts
from constants.model.constants import LOGGER
from fileio.controller import checkout_0001 as checkout

class Network2Local(object):
    def __init__(self):
        super(Network2Local, self).__init__()
    # end __init__
# end Network2Local

def nested_maya_reference_read(references, fileIO, masterList=[]):
    for reference in references:
        # add straight files to a list with their file path intact
        nodetype = type(reference)
        stringPath = pm.getAttr('.'.join(reference, 
                                fileIO.fileStringInputTypes[nodetype]))
        if os.path.abspath(stringPath) and not args.forceRelative:
            # tell user that this path will need to be changed
            pass
        elif os.path.abspath(stringPath) and args.forceRelative:
            if nodetype in fileIO.fileStringInputTypes.keys():
                yield stringPath
            else:
                yield os.path.join("some/project", "sourceimages", stringPath)
        elif os.path.abspath(stringPath):
            # Get absolute path from relative path
            pass
        else:
            # LOG whatever this instance is. I wasn't sure what to do with it
            pass

        if cmds.file(reference, q=True, r=True) != 0:
            # if there are references, evaluate them recursively
            for ref in cmds.file(reference, q=True, r=True):
                if ref.endswith(consts.FILETYPES_MAYA):
                    nestedMayaReferenceRead(ref, fileIO)

    if not os.path.exists():
        pass  # do something soon
# end nested_maya_reference_read

def test_case(forceRelative, ignoreLocked, newestFilesOnly, 
              recursive, projectFolder, sceneFile, outputFolder):
    """
    The actual method
    """
    if projectFolder is None:
        LOGGER.info(['MYA5600'], {'file': sceneFile})
        temp = os.path.join(sceneFile.split(os.sep)[:-2])  # get two folders up
        newProjectFolder = temp
        if os.path.isdir(newProjectFolder):
            LOGGER.info(['MYA5601', 'match_true'], {'file': sceneFile,
                                                   'folder': newProjectFolder})
            projectFolder = os.path.join(newProjectFolder)
        else:
            LOGGER.error(['MYA7601', 'match_false'], {'file': sceneFile,
                                                      'folder': newProjectFolder})

    mayaFileList = [sceneFile]
    mayaSceneList = [sceneFile]

    if not os.path.exists(outputFolder):
        LOGGER.info(['AIE5600'], {'item': 'folder', 'f': outputFolder})
        os.makedirs(outputFolder)


    sceneFilePath = (os.sep).join(sceneFile.split(os.sep)[:-1])
    sceneFileName = (sceneFile).split(os.sep)[-1]
    fileIO = checkout.FileCheckoutMaya(filePath=sceneFilePath,
                                       fileName=sceneFileName)

    if fileIO.check_naming_convention(consts.RE_FILENAME_MATCH_MA) == None:
        LOGGER.error(["AIE6601"], {"f": fileIO.fullPath, 'convention': consts.MATCH_MA})
    
    LOGGER.info(['MYA5901'], {'program' : 'maya.standalone'})
    LOGGER.debug(['MYA1701'], {'file': fileIO.fullPath})
    fileIO.initialize()
    import maya.cmds as cmds
    LOGGER.info(['MYA5901'], {'program' : 'maya.cmds'})
    import pymel.core as pm
    LOGGER.info(['MYA5901'], {'program' : 'pymel.core'})

    for reference in cmds.file(currentFileRead, q=True, r=True):
            if reference.endswith(consts.FILETYPES_MAYA):
                mayaSceneList.append(reference)
    fileIO.uninitialize()

    """
    for root, dirs, files in os.walk(outputFolder + os.sep + mayaSceneFile):
            [os.makedir(root + dir) for dir in dirs if not os.exists]
            for file in files:
                tempIO = fileIO(file)
                if not os.path.isfile(root + file) and not fileIO(file).is_locked() or ignoreLocked:
                    pass  # do something


    fullFileList = nested_maya_reference_read(mayaSceneList, fileIO)
    fullFileList = list(fullFileList)
    """
# end test_case

def test_case_0001():
    """
    Main implementation of the current file. Contains a command-line utility and
    a simple GUI to interface with it
    """
    """
    description = 'Create a local copy of a network scene file'
    parser = argparse.ArgumentParser(description=description)

    message = "Specify the Maya project directory. If nothing is specified, "\
    "the directory two folders up will be chosen"
    parser.add_argument('-p', '--project-folder', nargs=1, 
                        dest="projectFolder", help=message)
    parser.add_argument('-f', '--scene-files', metavar='File Dirs', 
                        nargs='+', dest='sceneFiles',
                        help='Specify one or more maya files to copy from')

    message = 'Force absolute paths into relative paths before copying'
    parser.add_argument('-rp', '--force-relative-paths', 
                        action='store_true', default=False, dest='forceRelative',
                        help=message)

    message = 'Specify whether or not the {name} '\
              'script should'.format(name=os.path.basename(__file__))
    parser.add_argument('-r', '--recursive', action='store_true', default=False,
                        dest="recursive", help=message)
    
    message = 'Specify whether the {name} script should copy files that are '\
              'currently locked by other '\
              'students or not'.format(name=os.path.basename(__file__))
    parser.add_argument('-l', '--ignore-locked-files', action='store_true', 
                        default=False, dest='ignoreLocked', help=message)
    folder = 'POP2_RELATIVE_OUTPUT'
    message = 'Specify an output directory to place the copied files/folders. '\
                'If no output folder is specified, the script will create a' \
                'folder called "{folder}" by default in the same directory as '\
                'the scene file being copied'.format(folder=folder)
    parser.add_argument('-o', '--output-folder', nargs=1, dest="outputFolder", 
                        help=message)
    parser.add_argument('-n', '--newest-files-only', action='store_true', 
                        default=False, dest="newestFilesOnly", help=message)
    args1 = parser.parse_args()

    if args1.sceneFiles is None:
        LOGGER.critical(['AIE9200'], {'item': "file"})
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )
    elif args1.sceneFiles is not None:
        for f in args1.sceneFiles:
            toRemove = []
            fileIOTemp = FileIO(f)
            isFile = fileIO.is_maya_file()
            if not isFile:
                toRemove.append(f)
                LOGGER.info(['AIE7703'], {'file': f, 'list': args1.sceneFiles})
                LOGGER.trace(['AIE1703'], {'container': 'list', 'h': toRemove})

        if toRemove != []:
            LOGGER.trace(['AIE1704'], {'container': 'list', 'h': args1.sceneFiles})
            args1.sceneFiles = args1.sceneFiles.remove(toRemove)
            LOGGER.trace(['AIE1705'], {'container': 'list', 'h': args1.sceneFiles})

        if args1.sceneFiles == []:
            LOGGER.critical(['AIE9200'], {'item': "file"})
            sys.exit('"{script}" Script now exitting'\
                     '...'.format(script=os.path.basename(__file__)) )
    
    if args1.outputFolder is None:
        LOGGER.critical(['AIE9200'], {'item': "folder"})
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )
    
    if not os.path.exists(args1.outputFolder):
        LOGGER.info(['AIE5600'], {'item': 'folder', 'f': args1.outputFolder})
        os.makedirs(outputFolder)


    if args1.newestFilesOnly:
        LOGGER.info(['AIE5604'], {'f': "files"})
    """
    # override the command-line with this temporary class with the same name
    # for testing
    class Args():
        def __init__(self, forceRelative, ignoreLocked, recursive, 
                     newestFilesOnly, projectFolder, sceneFiles, outputFolder):
            self.forceRelative = forceRelative
            self.ignoreLocked = ignoreLocked
            self.newestFilesOnly = newestFilesOnly
            self.recursive = recursive
            self.sceneFiles = sceneFiles
            self.projectFolder = projectFolder
            self.outputFolder = outputFolder
        # end __init__
    # end args

    projectFolderTemp = r'/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project'
    outputFolder = r'/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/output_folder'
    sceneFilesTemp = r'/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes/test_parent_project.0002.ma'
    sceneFilesTemp = r'/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes/s001_ckenne24_007_uving.0001.ma'
    args = Args(forceRelative=False, ignoreLocked=False, recursive=False, 
                newestFilesOnly=False, projectFolder=projectFolderTemp, 
                sceneFiles=[sceneFilesTemp], outputFolder=outputFolder)

    for sceneFile in args.sceneFiles:
        test_case(forceRelative=args.forceRelative, 
                  ignoreLocked=args.ignoreLocked, recursive=args.recursive, 
                  newestFilesOnly=args.newestFilesOnly, 
                  projectFolder=args.projectFolder, 
                  sceneFile=sceneFile, outputFolder=args.outputFolder)

if __name__ == "__main__":
    # main()
    test_case_0001()