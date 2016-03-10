#!/usr/bin/python
#-*- coding: utf-8 -*-

"""
Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Parses commands and preps specified data before it is executed by mkhdr

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
engine.py
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


MAIN_CMD = os.path.dirname(os.path.realpath(__file__))
MAIN_CMD = os.path.normpath(os.path.join(MAIN_CMD, "../model/mkhdri.exe"))


def all_same(items):
    """
    Gets every item in a list and returns True/False if they are all the same
    (useful for comparing extension, for example)

    Args:
        items (list or iterable): The collection of values to find common value

    Returns:
        bool: True or False
    """
    return all(x == items[0] for x in items)
# all_same

def filter_out_by_value(seq, value):
    """
    Filters out all values in an iterable that are not of specified value

    Args:
        seq (list or iterable): The sequence to compare
        value (any): A value to check for within seq

    Returns:
        <generator>: An iterable that contains only each match for value
    """
    for el in seq:
        if el == value:
            yield el
# end filter_out_by_value


def path_leaf(path):
    """
    Gets the last value in a given path in an OS-independent fashion

    Args:
        path (str): The path to get the last item from

    Returns:
        str: The output item
    """
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)
# end path_leaf


def parse_cmd(string_h):
    """
    Parse a string that represents a command-line command into something
    that hdr_batch_process can use

    Args:
        string_h (str): An entire command-line string to process

    Returns:
        dict or strs or ints: A dictionary containing user arguments
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
        options['seqInt'] = options['si']
        options.pop('si')
    if 'testModule' not in options:
        options['testModule'] = testModule

    return options
# end parse_cmd


def hdr_batch_process(inputs, seqInt, *args, **kwargs):
    """
    The hdr batch process utility

    Args:
        inputs (list of strs): List of files and/or folders to process
        seqInt (int): The number of brackets expected per HDR output

    Returns:
        int: Success/Failure of the HDR batch process. 0 = Success
    """
    cmd = MAIN_CMD
    startTime = time.time()

    if inputs is None:
        sys.exit("No input files/folders specified")
    inputFiles = inputs  # lazy

    if 'fileType' not in kwargs:
        fileType = '.cr2'  # default value for my personal RAW file format
    else:
        fileType = kwargs['fileType']

    if seqInt is None:
        # ::HDR BATCH PROCESS TO DO:: Make the sequence interval an auto detect
        sys.exit("No hdr bracket sequence interval number specified")

    if inputFiles == []:
        sys.exit("No input files found from the specified files/folders")

    if kwargs is None:
        sys.exit("No arguments passed to process images")

    if not kwargs.get('autoRename', False) and 'inputFileNames' not in kwargs:
        sys.exit("No method to rename files specified")

    if 'ci' not in kwargs and kwargs.get('eo', False) and 'defcurve' not in kwargs:
        sys.exit("No method for defining the camera curve specified")

    if kwargs.get('ci', None) is not None and not os.path.isfile(kwargs.get('ci', None)):
            path = os.path.abspath(kwargs['ci'])
            sys.exit("Directory: {dir} for the specified curve file, {crv} does not exist".format(dir=path[0], crv=path))

    if kwargs.get('outputFolder', None) is not None and \
           os.path.isdir(kwargs['outputFolder']):
            message = 'Output directory: {dir} does not exist. Please check '\
                      'your spelling'.format(dir=kwargs['outputFolder'])
            sys.exit(message)

    # (At this point) All necessary config settings have been found
    # start compiling the requested arguments
    if kwargs['fno'] is not None:
        cmd = cmd + ' -fno:{}'.format(kwargs['fno'])

    exposureArgs = ['ec', 'a', 'gr', 'cb', 'f32', 'da']
    for i in enumerate(exposureArgs):
        if kwargs.get(i, False):
            cmd = cmds + " -{}".format(i)

    if kwargs.get('inputFileNames', None) is not None:
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

    if kwargs.get('eo', False):
        cmd = cmd + ' -eo'
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

    # Make a new list, grouped by nth-->nth+1 element, n is seqInt
    inputFiles = [inputFiles[x:x+seqInt]
                  for x in range(0, len(inputFiles), seqInt)]

    if 'inputFileNames' in kwargs and len(inputFiles) != len(fileNameList):
        sys.exit("The provided file name list does does not match "
                 "the number of image files found")

    checkFileNames = []  # check if duplicate name and file path generated
    commandList = []
    for i, group in enumerate(inputFiles):
        if 'outputFolder' not in kwargs and i == 0:
            outputFolder = os.path.dirname(group[0])

        if 'inputFileNames' in kwargs:
            outputName = os.path.join(outputFolder, fileNameList[i])
        elif kwargs.get("autoRename", False):
            outputName = os.path.splitext(path_leaf(group[0]))[0]
            if kwargs.get("outputType", None) is not None:
                outputName += kwargs["outputType"]
            else:
                outputName += "hdr"
            outputName = os.path.join(outputFolder, outputName)

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
    return commandList
# end hdr_batch_process


if __name__ == "__main__":
    print(__doc__)
