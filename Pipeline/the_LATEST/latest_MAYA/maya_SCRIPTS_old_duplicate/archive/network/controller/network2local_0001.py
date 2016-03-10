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
from constants.model.constants import LOGGER
from fileio.controller import checkout_0001 as checkout

class Network2Local(object):
    def __init__(self):
        super(Network2Local, self).__init__()
    # end __init__
# end Network2Local

def main():
    """
    Main implementation of the current file. Contains a command-line utility and
    a simple GUI to interface with it
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
    parser.add_argument('-i', '--ignore-locked-files', action='store_true', 
                        default=False, dest='ignoreLocked', help=message)
    folder = 'POP2_RELATIVE_OUTPUT'
    message = 'Specify an output directory to place the copied files/folders. '\
                'If no output folder is specified, the script will create a' \
                'folder called "{folder}" by default in the same directory as '\
                'the scene file being copied'.format(folder=folder)
    parser.add_argument('-o', '--output-folder', nargs=1, dest="outputFolder", 
                        help=message)
    args = parser.parse_args()

    if args.sceneFiles is None:
        LOGGER.critical(['AIE9200'])
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )
    # elif args.outputFolder is None:

    if args.projectFolder is None:
        args.projectFolder
    """
    --- Create config so that it can be run from the command-line
    - Create GUI implementation of that command-line application
    - IN GUI: A file window with a simple string with a default set to either
    /var/tmp or D:\\temp, depending on the OS
     - at the bottom, have a checkbox that says "force relative paths" so that
       users can make their scenes into all relative paths
    - if override locked files is specified, create a confirm window

    -/ Create a while loop
    -/ add an attribute for maya files and add the parent maya file to it
    -/ Read Maya file
    -/ if any files are recursive, read their contents
     -/ continue a recursive read until 

    -/ if path is absolute and user has set force relative paths to false, flag it
    - if path is absolute and user has set force relative paths to true
     -/ if from supported list of files
      -/ add to copy list
     -/ if not from supported list
      -/ add to copy list's sourceimages
    -/ if path is relative, compare to the project folder and add to copy list

    -/ create the parent dir that all files will exist within
     -/ copy the main project folder structure 
     - copy the files to the specified paths - before copy, check if locked. Do not copy if locked and log it as an error UNLESS the option to override locked files is specified
     - copy the parent maya file and the other folders required
    - check the file transfer. Was it 100% successful? if so, exit
     - if not - Was there data loss? Flag files didn't copy or have data loss (differing file sizes)
    """
    # fileIO = fileio.FileIOMaya()

    mayaFileList = [args.sceneFiles[0]]
    for mayaSceneFile in args.sceneFiles[1:]:
        mayaFileList.append(mayaSceneFile)  # may be useless. Delete later if I do not use this var
        mayaSceneList = [mayaSceneFile]

        # load maya file, scan for OTHER maya files, recursively search the files until end is reached
        if not os.path.exists(args.outputFolder):
            os.makedirs(args.outputFolder)        
        elif not os.path.exists(args.outputFolder + os.sep + mayaSceneFile):  # copy the maya project into the output folder
            os.makedirs(args.outputFolder + os.sep + mayaSceneFile)       
            for root, dirs, files in os.walk(args.outputFolder + os.sep + mayaSceneFile):
                [os.makedir(root + dir) for dir in dirs if not os.exists]
                for file in files:
                    tempIO = fileIO(file)
                    if not os.path.isfile(root + file) and not fileIO(file).is_locked() or args.ignoreLocked:
                        # AUTHOR NOTE:: ::TO DO::
                        print("LOG ME")
                        pass
        
        fileIO = checkout.FileCheckoutMaya()
        fileIO.open_shell()
        # import pymel.core as pm
        # import maya.cmds as cmds


        for reference in cmds.file(currentFileRead, q=True, r=True):
                if reference.endswith(consts.FILETYPES_MAYA):
                    mayaSceneList.append(reference)

        def nestedMayaReferenceRead(references, fileIO, masterList=[]):
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
                pass  # come back to this

    fullFileList = nestedMayaReferenceRead(mayaSceneList, fileIO)
    fullFileList = list(fullFileList)
# end main
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
    sceneFile = os.path.join('scenes', sceneFile)
    if projectFolder is None:
        LOGGER.info(['MYA5600'], {'file': mayaSceneFile})
        temp = (os.sep).split(args.sceneFiles[0])[:-2]  # get two folders up
        newProjectFolder = os.path.join(temp)
        if os.path.isdir(newProjectFolder):
            LOGGER.info(['MYA5601', 'match_true'], {'file': args.sceneFiles,
                                                   'folder': newProjectFolder})
            args.projectFolder = os.path.join(newProjectFolder)
        else:
            LOGGER.error(['MYA7601', 'match_false'], {'file': args.sceneFiles,
                                                      'folder': newProjectFolder})

    fileIO = fileio.FileCheckoutMaya()
    mayaFileList = [args.sceneFiles]
    for mayaSceneFile in args.sceneFiles:
        mayaFileList.append(mayaSceneFile)  # may be useless. Delete later if I do not use this var
        mayaSceneList = [mayaSceneFile]

        # load maya file, scan for OTHER maya files, recursively search the files until end is reached
        if not os.path.exists(args.outputFolder):
            os.makedirs(args.outputFolder)        
        elif not os.path.exists(args.outputFolder + os.sep + mayaSceneFile):  # copy the maya project into the output folder
            os.makedirs(args.outputFolder + os.sep + mayaSceneFile)       
            for root, dirs, files in os.walk(args.outputFolder + os.sep + mayaSceneFile):
                [os.makedir(root + dir) for dir in dirs if not os.exists]
                for file in files:
                    tempIO = fileIO(file)
                    if not os.path.isfile(root + file) and not fileIO(file).is_locked() or args.ignoreLocked:
                        pass  # do something
        
        fileIO = checkout.FileCheckoutMaya()
        fileIO.initialize()
        import pymel.core as pm
        import maya.cmds as cmds


        for reference in cmds.file(currentFileRead, q=True, r=True):
                if reference.endswith(consts.FILETYPES_MAYA):
                    mayaSceneList.append(reference)
        fileIO.uninitialize()

    fullFileList = nested_maya_reference_read(mayaSceneList, fileIO)
    fullFileList = list(fullFileList)

    """
    --- Create config so that it can be run from the command-line
    - Create GUI implementation of that command-line application
    - IN GUI: A file window with a simple string with a default set to either
    /var/tmp or D:\\temp, depending on the OS
     - at the bottom, have a checkbox that says "force relative paths" so that
       users can make their scenes into all relative paths
    - if override locked files is specified, create a confirm window

    -/ Create a while loop
    -/ add an attribute for maya files and add the parent maya file to it
    -/ Read Maya file
    -/ if any files are recursive, read their contents
     -/ continue a recursive read until 

    -/ if path is absolute and user has set force relative paths to false, flag it
    - if path is absolute and user has set force relative paths to true
     -/ if from supported list of files
      -/ add to copy list
     -/ if not from supported list
      -/ add to copy list's sourceimages
    -/ if path is relative, compare to the project folder and add to copy list

    -/ create the parent dir that all files will exist within
     -/ copy the main project folder structure 
     - copy the files to the specified paths - before copy, check if locked. Do not copy if locked and log it as an error UNLESS the option to override locked files is specified
     - copy the parent maya file and the other folders required
    - check the file transfer. Was it 100% successful? if so, exit
     - if not - Was there data loss? Flag files didn't copy or have data loss (differing file sizes)
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
    elif args1.outputFolder is None:
        LOGGER.critical(['AIE9200'], {'item': "folder"})
        sys.exit('"{script}" Script now exitting'\
                 '...'.format(script=os.path.basename(__file__)) )

    if args1.newestFilesOnly:
        LOGGER.info("only newer versions of files will be copied. Anything that hasn't been changed or is older will not be copied")
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
    sceneFilesTemp = ['test_parent_project.0002.ma']
    args = Args(forceRelative=False, ignoreLocked=False, recursive=False, 
                newestFilesOnly=False, projectFolder=projectFolderTemp, 
                sceneFiles=sceneFilesTemp, outputFolder=outputFolder)

    for sceneFile in args.sceneFiles:
        test_case(forceRelative=args.forceRelative, 
                  ignoreLocked=args.ignoreLocked, recursive=args.recursive, 
                  newestFilesOnly=args.newestFilesOnly, 
                  projectFolder=args.projectFolder, 
                  sceneFile=sceneFile, outputFolder=args.outputFolder)

if __name__ == "__main__":
    # main()
    test_case_0001()