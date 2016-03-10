#!/usr/bin/python
#-*- coding: utf-8 -*-

"""
:::Project:::
 Personal
:::Description:::
 Manager inits the specific methods from checkout to use for fileIO operations
:::Author:::
 Colin Kennedy
::TO DO::
 make testing modules for the module
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import subprocess
import ntpath
import re
import logging
import time
import shlex  # for processing a string that represents a shell command

from functools import partial
from multiprocessing.dummy import Pool


MAIN_CMD = '"C:\Program Files\Picturenaut\mkhdri.exe"'


class HdrBatch():
    def __init__(self, ):
        super((HdrBatch, self).__init__()
    # end __init__
# end HdrBatch


def filter_out_by_value(seq, value):
    for el in seq:
        if el == value:
            yield el
# end filter_out_by_value


def path_leaf(path):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)
# end path_leaf


def parse_cmd(string_h, testModule=False):
    """
    Parse a string that represents a command-line command into something
    that hdr_batch_process can use

    :key string_h: An entire command-line string to process
    :type string_h: str
    :returns: A dictionary containing your arguments
    :rtype: dict of strs and ints
    """
    args = shlex.split(string_h)
    options = {k.replace("-", ""): True if v.startswith('-') else v
           for k, v in zip(args, args[1:]+["--"]) if k.startswith('-')}

    for key, value in options.iteritems():
        try:
            options[key] = int(options[key])
        except ValueError:
            pass

    # swap out any variable argument that is required by hdr_batch_process
    # with its long-name equivalent
    #
    if 'i' in options:
        options['inputs'] = options['i']
        options.pop('i')
    if 'si' in options:
        options['sequenceInterval'] = options['si']
        options.pop('si')
    if 'testModule' not in options:
        options['testModule'] = testModule

    return options
# end parse_cmd


def hdr_batch_process(inputs, sequenceInterval, testModule=False,
                      *args, **kwargs):
    """
    The hdr batch process utility

    :key inputs: List of files and/or folders to process
    :key sequenceInterval: The number of brackets expected per HDR output
    :type inputs: list of strs
    :type sequenceInterval: int
    :returns: Success/Failure of the HDR batch process. 0 = Success
    :rtype: int
    """
    cmd = MAIN_CMD
    startTime = time.time()

    if inputs is None:
        sys.exit("No input files/folders specified")

    if sequenceInterval is None:
        # ::HDR BATCH PROCESS TO DO:: Make the sequence interval an auto detect
        sys.exit("No hdr bracket sequence interval number specified")

    if 'fileType' not in kwargs:
        fileType = '.cr2'
    else:
        fileType = kwargs['fileType']

    inputFiles = [f for f in inputs if os.path.isfile(f)
                  and f.endswith(fileType)]
    inputFolders = [f for f in inputs if os.path.isdir(f)]

    if kwargs.get('recursive', False) is True:
        folderSearchLevel = 261  # some impossibly high number
    else:
        folderSearchLevel = 0

    for folder in inputFolders:
        files = paths.os_walk(folder, depth=folderSearchLevel,  output="Files")
        files = (x for x in files if x.endswith((fileType,
                                                 fileType.upper(),
                                                 fileType.lower())))
        [inputFiles.append(x) for x in list(files)]  # add the files

    if inputFiles == []:
        sys.exit("No input files found from the specified files/folders")

    if kwargs is None:
        sys.exit("No arguments passed to process images")

    if 'autoRename' not in kwargs and 'inputFileNames' not in kwargs:
        sys.exit("No method to rename files specified")

    if 'ci' not in kwargs and \
       kwargs.get('ec', False) is True and 'defcurve' not in kwargs:
        sys.exit("No method for defining the camera curve specified")

    if kwargs['ci'] is not None and not os.path.isfile(kwargs['ci']):
            path = os.path.split(os.path.abspath(kwargs['ci']))
            sys.exit("Directory: {dir} for the specified curve file, {crv} does not exist".format(dir=path[0], crv=path[1]))

    if 'outputFolder' in kwargs:
        if kwargs['outputFolder'] is not None and \
           os.path.isdir(kwargs['outputFolder']):
            message = 'Output directory: {dir} does not exist. Please check '\
                      'your spelling'.format(dir=kwargs['outputFolder'])
            sys.exit(message)

    # (At this point) All necessary config settings have been found
    # start compiling the requested arguments
    if kwargs['fno'] is not None:
        cmd = cmd + ' -fno:{}'.format(kwargs['fno'])

    if kwargs['inputFileNames'] is not None:
        # get the list of names for the files
        with open(kwargs['inputFileNames'], "rt") as f:
            data = f.read()

        fileNameList = data.replace('-', "_")
        fileNameList = fileNameList.split(',')
        fileNameList = [x.lstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x.rstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x for x in fileNameList if x != '']
        fileNameList = [x+'.hdr' for x in fileNameList if '.' not in x]  # ext

    # AUTHOR NOTE: I need to make some kind of conditional so that there can only be one or the other. Or something

    if kwargs.get('ec', False) is False:
        cmd = cmd + ' -ec'
    elif 'ci' in kwargs and 'defcurve' in kwargs:
        logging.info("The curve input file will be read, "\
                     "instead of the define curve")
        # kwargs['ci']
        cmd = cmd + ' -ci:{}'.format(kwargs['ci'])
    elif 'ci' in kwargs and 'defcurve' not in kwargs:
        # kwargs['ci']
        cmd = cmd + ' -ci:{}'.format(kwargs['ci'])
    elif 'defcurve' in kwargs:
        # kwargs['defcurve']
        cmd = cmd + ' -defcurve'
    else:
        message = "No curve estimation or curve file provided. Script doesn't"\
                  " know how to interpret the hdr without it. Please specify "\
                  "a curve option"
        sys.exit(message)

    # Make a new list, grouped by nth-->nth+1 element, n is sequenceInterval
    inputFiles = [inputFiles[x:x+sequenceInterval]
                  for x in range(0, len(inputFiles), sequenceInterval)]

    if 'inputFileNames' in kwargs and len(inputFiles) != len(fileNameList):
        sys.exit("The provided file name list does does not match "
                 "the number of image files found")

    checkFileNames = []  # check if duplicate name and file path generated
    commandList = []
    for i, group in enumerate(inputFiles):
        if 'outputFolder' not in kwargs and i == 0:
            outputFolder = os.path.dirname(group[0])
            tempDir = re.match(r'(\d+).\d+',
                               str(os.stat(outputFolder).st_mtime)).group(1)

            tempDir = "_".join(["Output", tempDir])
            outputFolder = os.path.join(outputFolder, tempDir)
            if not os.path.isdir(outputFolder):
                logging.info("Making directory: {}".format(outputFolder))
                os.makedirs(outputFolder)  # make new folder for output
        elif 'outputFolder' in kwargs:
            outputFolder = kwargs['outputFolder']

        if 'inputFileNames' in kwargs:
            outputName = os.path.join(outputFolder, fileNameList[i])
        elif 'autoRename' in kwargs:
            outputName = os.path.join(outputFolder, path_leaf(group[0]))

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
                    logging.info("Auto-override has been set. Continuing")
                elif userCheck == 'n':
                    message = "Please rename file {f} "\
                              "before continuing".format(f=outputName)
                    sys.exit(message)

        if os.path.isdir(os.path.dirname(outputFolder)):
            finalCmd = cmd + ' -out:{}'.format('"' + outputName + '"')
            group = ['"' + x + '"' for x in group]
            filesToProcess = ' ' + ' '.join(group)
            finalCmd = finalCmd + filesToProcess
            commandList.append(finalCmd)
        else:
            message = "Folder: {f} does not exist. Could not create "\
                      "file, \"{name}\"".format(f=outputFolder,
                                                name=outputName)
            logging.error(message)

    if testModule:
        return commandList  # used for testing

    # Reference: https://stackoverflow.com/questions/14533458
    pool = Pool(kwargs['threads'])  # concurrent commands at a time
    for i, returncode in enumerate(pool.imap(
                                   partial(subprocess.call, shell=True),
                                   commandList)):
        if returncode != 0:
            logging.error("%d command failed: %d" % (i, returncode))

    logging.debug("--- {} seconds ---".format(time.time() - startTime))
    return 0
# end hdr_batch_process


if __name__ == "__main__":
    main()
