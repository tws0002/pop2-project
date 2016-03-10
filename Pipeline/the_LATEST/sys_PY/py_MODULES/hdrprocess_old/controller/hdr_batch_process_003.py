#!/usr/bin/python

"""
..Description::
 Manager inits the specific methods from checkout to use for fileIO operations
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os, sys
import math
import shlex, subprocess
import argparse

# IMPORT LOCAL LIBRARIES
sys.path.append(r"C:\Users\SelecaoOne\Dropbox\Private\my_ENV\sys_PY\py_MODULES")
import fileIO.controller.recursive_folder_search as recursFolder

# MAIN_CMD = '"C:\Program Files\Picturenaut\mkhdri.exe" -fno:2 -ci:"C:\Users\SelecaoOne\Dropbox\Private\my_ENV\sys_PY\py_MODULES\panorama_batch\canon_t3i_response_curve.crv"'

MAIN_CMD = '"C:\Program Files\Picturenaut\mkhdri.exe"'

def filter_out_by_value(seq, value):
    for el in seq:
        if el == value:
            yield el

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
    optionalArgs = dict((k, v) for k, v in optionalArgs.iteritems() if v)
    requiredArgs = {'sequenceInterval': optionalArgs.get("sequenceInterval",
                                                         None),
                    'inputs': optionalArgs.get("inputs", None)
                    }

    # remove the required args from the optional dict
    optionalArgs.pop("sequenceInterval", None)
    optionalArgs.pop("inputs", None)

    hdr_batch_process(inputs=requiredArgs['inputs'],
                      sequenceInterval=requiredArgs['sequenceInterval'],
                      **optionalArgs)
# end main


def hdr_batch_process(inputs, sequenceInterval, *args, **kwargs):
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
        kwargs['fno'] = float(kwargs['fno'])  # cast string to float
        finalCmd = finalCmd + '-fno {}'.format(kwargs['fno'])

    if kwargs['inputFileNames'] is not None:
        # get the list of names for the files
        with open(kwargs['inputFileNames'][0], "rt") as f:
            data = f.read()

        fileNameList = data.replace('-', "_")
        fileNameList = fileNameList.split(',')
        fileNameList = [x.lstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x.rstrip(' \t\r\n') for x in fileNameList]

    # AUTHOR NOTE: I need to make some kind of conditional so that there can only be one or the other. Or something

    if 'eo' in kwargs:
        # kwargs['estimateCurve']
        finalCmd = finalCmd + '-eo'
    elif 'ci' in kwargs and 'defcurve' in kwargs:
        print("The curve input file will be raed, instead of the define curve")
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

    # during the execution loop...
    # check the file type of each file
    # check if an output folder is specified, otherwise, use the current
    # add the input file name to the end of the final cmd

    # setup divisor for batch script
    divisionNum = 0
    tempList = []
    finalArgs = []
    for i, f in enumerate(filesToProcess):
        if
        if i/sequenceInterval == divisionNum:
            # if floor(1/5) is the same as it was previously
            # load the index into a temporary list
            tempList.append(f)
        elif i/sequenceInterval == divisionNum+1:
            # if the value is +1 greater, then that means we've gone past the interval
            # the list needs to be processed in hdri, reset, and filled again

            # do some process while combining the original command with our
            # parsed information for the output information
            tempList = ' '.join(tempList)

            output_h = os.path.join(argsBDict["fl"],fileNameList[divisionNum])
            finalArgs = argsA + ["-out:{o}".format( o=output_h )] + [[tempList]]
            subprocess.call( finalArgs )

            # reset the list and reassign divisionNum
            finalArgs = []
            tempList = []
            tempList.append(os.path.join(argsBDict["fl"], f))
            divisionNum = divisionNum + 1
        else:
            raise RuntimeError("Indexing failed, the process must be shut down")

    # if -ait, use file filename as output file name, else, use index of file
    """
    return 0
# end main

if __name__ == "__main__":
    main()





















def temp():
    '-si=5 -p=4 -fl="{}C:\Users\SelecaoOne\Desktop\cap08" -lfn="C:\Users\SelecaoOne\Desktop\cap07_tests\session_01_batch_names.txt"'
    # si = spaced interval
    # p = (name) padding
    argsA = shlex.split(cmdA)
    argsB = shlex.split(cmdB)

    # argsA will be applied directly as a command
    # argsB must be parsed based on the users's information

    argsBDict = {}
    for arg in argsB:
        argsBDict[arg.split("=")[0].lstrip('-')] = arg.split("=")[1]

    # get the list of names for the files
    with open(argsBDict["lfn"], "rt") as f:
        data = f.read()


    fileNameList = data.replace('-', "_")
    fileNameList = data.replace('\n', "")
    fileNameList = data.replace('\t', "")
    fileNameList = data.split(',')
    fileNameList = [x.strip() for x in fileNameList]
    fileNameList = filter_out_by_value(fileNameList, "")
    a = list(fileNameList)

    # get files to be processed
    filesToProcess = [ os.path.join(argsBDict["fl"], f) for f in os.listdir(argsBDict["fl"]) if os.path.isfile(os.path.join(argsBDict["fl"],f)) ]
    filesToProcess = [ f for f in filesToProcess if f.endswith(".CR2") ]

    # setup divisor for batch script
    interval = int(argsBDict["si"])
    divisionNum = 0
    tempList = []
    finalArgs = []
    for i, f in enumerate(filesToProcess):
        if i/interval == divisionNum:
            # if floor(1/5) is the same as it was previously
            # load the index into a temporary list
            tempList.append(f)
        elif i/interval == divisionNum+1:
            # if the value is +1 greater, then that means we've gone past the interval
            # the list needs to be processed in hdri, reset, and filled again

            # do some process while combining the original command with our
            # parsed information for the output information
            tempList = ' '.join(tempList)

            output_h = os.path.join(argsBDict["fl"],fileNameList[divisionNum])
            finalArgs = argsA + ["-out:{o}".format( o=output_h )] + [[tempList]]
            subprocess.call( finalArgs )

            # reset the list and reassign divisionNum
            finalArgs = []
            tempList = []
            tempList.append(os.path.join(argsBDict["fl"], f))
            divisionNum = divisionNum + 1
        else:
            raise RuntimeError("Indexing failed, the process must be shut down")
