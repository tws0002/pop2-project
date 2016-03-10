#!/usr/bin/python

"""
..Description::
 Manager inits the specific methods from checkout to use for fileIO operations
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import subprocess
import argparse
import ntpath

# IMPORT LOCAL LIBRARIES
PATH = r"C:\Users\SelecaoOne\Dropbox\Private\my_ENV\sys_PY\py_MODULES"
sys.path.append(PATH)
import fileIO.controller.recursive_folder_search as recursFolder

MAIN_CMD = '"C:\Program Files\Picturenaut\mkhdri.exe"'


def filter_out_by_value(seq, value):
    for el in seq:
        if el == value:
            yield el
# end filter_out_by_value


def path_leaf(path):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)
# end path_leaf


def main():
    """
    Wraps a command-line utility around the hdr batch process.
    It takes a list of files or folders, gets their hdr sequences, and outputs
    hdrs based on common, user-specified settings.
    """
    description = 'Batch merge HDR images, using Picturenaut\'s mkhdri.exe '\
                  'command-line tool'
    parser = argparse.ArgumentParser(description=description)

    message = "The files/folders that you wish to process"
    parser.add_argument('-i', '--input', nargs='*',
                        dest="inputs", help=message)

    message = 'Enable recursive file search. (Default: False)'
    parser.add_argument('-r', '--recursive', action='store_true',
                        default=False, dest="recursive", help=message)

    message = "The file-type to process. Default is hdr"
    parser.add_argument('-ti', '--input-type', nargs=1, dest='fileType',
                        help=message)

    message = 'Reads input file to use for the output hdr\'s file names. '\
              'Each name must be separated by commas (requires text file)'
    parser.add_argument('-in', '--input-names', nargs=1, dest='inputFileNames',
                        help=message)

    message = 'Enable automatic filenaming (takes first filename as base)'
    parser.add_argument('-ait', '--auto-renaming', action='store_true',
                        default=False, dest="autoRename", help=message)

    message = 'F-Number override. Will automatically determine F-No if not '\
              'specified'
    parser.add_argument('-fno', '--F-Num', nargs=1, dest='fno',
                        help=message)

    message = 'Read in curve estimation file (requires *.crv file'
    parser.add_argument('-ci', '--curve-input', nargs=1, dest='ci',
                        help=message)

    message = 'The number of brackets per HDR, aka hdr sequence interval'
    parser.add_argument('-si', '--sequence-interval', type=int, nargs=1,
                        dest='sequenceInterval', help=message)

    # message = 'output file number padding'
    message = 'Output folder. Default is "$ROOT/Output"'
    parser.add_argument('-o', '--output-folder', nargs=1,
                        dest='outputFolder', help=message)

    message = 'Enable image alignment'
    parser.add_argument('-a', '--image-alignment', action='store_true',
                        default=False, dest="a", help=message)

    message = 'Enable exposure correction'
    parser.add_argument('-ec', '--exposure-correction', action='store_true',
                        default=False, dest="ec", help=message)

    message = 'Enable ghost removal'
    parser.add_argument('-gr', '--ghost-removal', action='store_true',
                        default=False, dest="gr", help=message)

    message = 'Enable color balancing'
    parser.add_argument('-cb', '--color-balancing', action='store_true',
                        default=False, dest="cb", help=message)

    message = 'Don\'t ask for exposure values if they are missing, (return '\
              'error code -130 instead)'
    parser.add_argument('-da', '--dont-ask', action='store_true',
                        default=False, dest="da", help=message)

    message = 'Estimate curve only (disables any input curve files'
    parser.add_argument('-eo', '--estimate-curve', action='store_true',
                        default=False, dest="eo", help=message)

    message = 'Default camera curve (skips curve estimation)'
    parser.add_argument('-dc', '--default-curve', action='store_true',
                        default=False, dest="defcurve", help=message)

    message = 'Use 32-bit IEEE floating point for HDRI TIFFs'
    parser.add_argument('-f32', '--f32-tiff', action='store_true',
                        default=False, dest="f32", help=message)

    # args = parser.parse_args()

    # split two dicts up - one is required, the other is optional
    # optional keys init with both optional and required keys, so the
    # required keys are then removed so only optional keys remain
    #
    optionalArgs = vars(parser.parse_args())
    # optionalArgs = dict((k, v) for k, v in optionalArgs.iteritems() if v)
    requiredArgs = {'sequenceInterval': optionalArgs.get("sequenceInterval",
                                                         None),
                    'inputs': optionalArgs.get("inputs", None)
                    }

    # remove the required args from the optional dict
    optionalArgs.pop("sequenceInterval", None)
    optionalArgs.pop("inputs", None)

    # interger parameters actually come in as lists. Fixing this now
    requiredArgs['sequenceInterval'] = requiredArgs['sequenceInterval'][0]
    if optionalArgs['fno'] is not None:
        optionalArgs['fno'] = float(optionalArgs['fno'])
    if optionalArgs['outputFolder'] is not None:
        optionalArgs['outputFolder'] = optionalArgs['outputFolder'][0]

    cmd = hdr_batch_process(inputs=requiredArgs['inputs'],
                            sequenceInterval=requiredArgs['sequenceInterval'],
                            **optionalArgs)
    if cmd != 0:
        sys.exit("Command exitted with errcode: {num}".format(num=cmd))
# end main

def hdr_batch_process():
    """
    The hdr batch process utility
    """

def check_hdr_files(inputs, sequenceInterval, *args, **kwargs):
    """
    The hdr batch process utility

    :key inputs: List of files and/or folders to process
    :key sequenceInterval: The number of brackets expected per HDR output
    :type inputs: list of strs
    :type sequenceInterval: int
    :returns: Success/Failure of the HDR batch process. 0 = Success
    :rtype: int
    """
    finalCmd = MAIN_CMD

    if inputs is None:
        sys.exit("No input files/folders specified")

    if sequenceInterval is None:
        # ::HDR BATCH PROCESS TO DO:: Make the sequence interval an auto detect
        sys.exit("No hdr bracket sequence interval number specified")

    if kwargs['fileType'] is None:
        fileType = '.cr2'
    else:
        fileType = kwargs['fileType']

    inputFiles = [f for f in inputs if os.path.isfile(f)
                  and f.endswith(fileType)]
    inputFolders = [f for f in inputs if os.path.isdir(f)]

    if kwargs['recursive'] is None:
        folderSearchLevel = 1
    else:
        folderSearchLevel = 261  # some impossibly high number

    for folder in inputFolders:
        files = recursFolder.find_files(inputFolders[0],
                                        depth=folderSearchLevel)
        files = (x for x in files if x.endswith((fileType,
                                                 fileType.upper(),
                                                 fileType.lower())))
        [inputFiles.append(x) for x in list(files)]  # add the files

    if inputFiles == []:
        sys.exit("No input files found from the specified files/folders")

    if kwargs is None:
        sys.exit("No arguments passed to process images")

    if kwargs['autoRename'] is None and kwargs['inputFileNames'] is None:
        sys.exit("No method to rename files specified")

    if kwargs['ci'] is None and \
       kwargs['ec'] is None or kwargs['defcurve']:
        sys.exit("No method for defining the camera curve specified")

    # (At this point) All necessary config settings have been found
    # start compiling the requested arguments
    if kwargs['fno'] is not None:
        # kwargs['fno'] = float(kwargs['fno'])  # cast string to float
        finalCmd = finalCmd + '-fno {}'.format(kwargs['fno'])

    if kwargs['inputFileNames'] is not None:
        # get the list of names for the files
        with open(kwargs['inputFileNames'][0], "rt") as f:
            data = f.read()

        fileNameList = data.replace('-', "_")
        fileNameList = fileNameList.split(',')
        fileNameList = [x for x in fileNameList if x != '']
        fileNameList = [x.lstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x.rstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x+'.hdr' for x in fileNameList if '.' not in x]  # ext

    # AUTHOR NOTE: I need to make some kind of conditional so that there can only be one or the other. Or something

    if 'eo' in kwargs:
        # kwargs['estimateCurve']
        finalCmd = finalCmd + '-eo'
    elif 'ci' in kwargs and 'defcurve' in kwargs:
        print("The curve input file will be read, instead of the define curve")
        # kwargs['ci']
        finalCmd = finalCmd + '-ci {}'.format(kwargs['ci'])
    elif 'ci' in kwargs and 'defcurve' not in kwargs:
        # kwargs['ci']
        finalCmd = finalCmd + '-ci {}'.format(kwargs['ci'])
    elif 'defcurve' in kwargs:
        # kwargs['defcurve']
        finalCmd = finalCmd + '-defcurve'
    else:
        message = "No curve estimation or curve file provided. Script doesn't"\
                  " know how to interpret the hdr without it. Please specify "\
                  "a curve option"
        sys.exit(message)

    # Make a new list, grouped by nth-->nth+1 element, n is sequenceInterval
    inputFiles = [inputFiles[x:x+sequenceInterval]
                  for x in range(0, len(inputFiles), sequenceInterval)]

    if kwargs['inputFileNames'] is not None and \
       len(inputFiles) != len(fileNameList):
        sys.exit("The provided file name list does does not match "
                 "the number of image files found")

    checkFileNames = []  # check if duplicate name and file path generated
    for i, group in enumerate(inputFiles):
        if kwargs['outputFolder'] is None:
            outputFolder = os.path.dirname(group[0])

        if kwargs['inputFileNames'] is not None:
            outputName = os.path.join(outputFolder, ' '.join(fileNameList[i]))
        elif kwargs['autoRename'] is not None:
            outputName = os.path.join(outputFolder, path_leaf(group[0]))
        else:
            return -130

        if not os.path.isdir(os.path.dirname(outputFolder)):
            message = "Folder: {f} does not exist. Could not create "\
                      "file, \"{name}\"".format(f=outputFolder,
                                                name=outputName)
            print message
            return -120

        if outputName in checkFileNames:
            try:
                userCheck
            except NameError:
                userCheck = raw_input("Filename: {f} was already found.\nDo "
                                      "you want to override the previous "
                                      "file? y/N/yes_all")
            else:
                if userCheck != "yes_all":
                    userCheck = raw_input("Filename: {f} was already found."
                                          "\nDo you want to override the "
                                          "previous file? y/N/yes_all")
            if userCheck == 'y':
                continue
            elif userCheck == 'yes_all':
                print "Assuming you know what you're doing"
            elif userCheck == 'n':
                message = "Please rename file {f} "\
                          "before continuing".format(f=outputName)
                print message
                return -110

    for i, group in enumerate(inputFiles):
        if kwargs['outputFolder'] is None:
            outputFolder = os.path.dirname(group[0])

        finalCmd = finalCmd + ' -out:{}'.format(outputName)
        filesToProcess = ' '.join(group)
        finalCmd = finalCmd + filesToProcess

        subprocess.call(finalCmd)  # run the command to hdr process

    return 0
# end check_hdr_files

if __name__ == "__main__":
    main()
