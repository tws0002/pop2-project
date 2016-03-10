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
        if el != value:
            yield el

def main():
    """
    Runs the command-line utility version of the hdr batch process.
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
    parser.add_argument('-dc', '--define-curve', action='store_true',
                        default=False, dest="defcurve", help=message)

    message = 'Use 32-bit IEEE floating point for HDRI TIFFs'
    parser.add_argument('-f32', '--f32-tiff', action='store_true',
                        default=False, dest="f32", help=message)

    args = parser.parse_args()

    if args.inputs is None:
        sys.exit("No input files/folders specified")

    if args.autoRename is None and args.inputFileNames is None:
        sys.exit("No method to rename files specified")

    if args.ci is None and \
    args.ec is None or args.defcurve:
        sys.exit("No method for defining the camera curve specified")

    if args.sequenceInterval is None:
        # ::HDR BATCH PROCESS TO DO:: Make the sequence interval an auto detect
        sys.exit("No hdr bracket sequence interval number specified")

    if args.fileType is None:
        fileType = 'hdr'
    else:
        fileType = args.fileType

    inputFiles = [f for f in args.inputs if os.path.isfile(f) \
                                            and f.endswith(args.fileType)]
    inputFolders = [f for f in args.inputs if os.path.isdir(f)]

    if args.recursive is None:
        folderSearchLevel = 1
    else:
        folderSearchLevel = 261  # some impossibly high number

    inputFiles.append(recursFolder.find_files(inputFolders,
                                              fileType,
                                              folderSearchLevel))

    if inputFiles == []:
        sys.exit("No input files found")

    # (At this point) All necessary config settings have been found
    # start compiling the requested arguments
    if args.fno is not None:
        args.fno = float(args.fno)  # cast string to float

    # remove the required flags. Only optional flags may remain
    optionalArgs = vars(parser.parse_args())
    optionalArgs = dict((k, v) for k, v in optionalArgs.iteritems() if v)
    optionalArgs.pop("sequenceInterval", None)
    optionalArgs.pop("inputFileNames", None)
    optionalArgs.pop("outputFolder", None)
    optionalArgs.pop("autoRename", None)
    optionalArgs.pop("fileType", None)
    optionalArgs.pop("recursive", None)
    optionalArgs.pop("inputs", None)

    if 'args.estimateCurve' in optionalArgs and \
       'args.curveInput' in optionalArgs:
        optionalArgs.pop('args.curveInput', None)

    if 'args.estimateCurve' in optionalArgs and \
       'args.defineCurve' in optionalArgs:
        optionalArgs.pop('args.defineCurve', None)

    # during the execution loop...
    # if -ait, use file filename as output file name, else, use index of file
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
