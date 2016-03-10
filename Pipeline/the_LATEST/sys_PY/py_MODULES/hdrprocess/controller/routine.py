#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Deals with processing/filtering/sorting existing information, from the GUI
or simply from other modules
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import re
import json
import math
from cStringIO import StringIO

# IMPORT THIRD-PARTY LIBRARIES
import natsort

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths as paths


class Capturing(list):
    """
    Class to extend and capture print statements sent to stdout. Used primarily
    to get relevant output information from mkhdri.exe as it executes
    """
    def __enter__(self):
        self._stdout = sys.stdout
        sys.stdout = self._stringio = StringIO()
        return self
    # end __enter__

    def __exit__(self, *args):
        self.extend(self._stringio.getvalue().splitlines())
        sys.stdout = self._stdout
    # end __exit__
# end Capturing


def get_sequences(filesH, seqInterval):
    """
    Figures out which sequences of files belong together, first by giving
    priority to files whose names are explicitly stated in parseable files, and
    then the method will use a fixed number as a fallback, in case not all
    files could be resolved using pre-existing metadata


    Args:
        filesH (list or iterable): A collection of strings which represent
                                   valid image files and text files. The text
                                   files are comma-separated lists of HDR
                                   filenames. If these files exist, the script
                                   will group them together. Any images that
                                   are not still not assigned are put together
        seqInterval (int): The number of brackets meant to create a single HDR

    Returns:
        list of lists: Creates a list which contains lists which represent
                       individual HDR files. The contents of each inner list
                       are the files that will be used to make the HDR image
    """
    # split up all text files from images
    textFiles = [x for x in filesH if x.lower().endswith(".txt")]
    imgFiles = [x for x in filesH if not x.lower().endswith(".txt")]
    bracketSequences = []
    for textH in textFiles:
        with open(textH, "r") as f:
            data = f.readlines()
        filenames = data.strip().split(",")
        bracketSequences.append(filesnames)

    # remove the sequences that are accounted for from the list of images
    for seq in bracketSequences:
        for s in seq:
            if s in imgFiles:
                i = imgFiles.index(s)
                imgFiles.pop(i)

    # group up the remaining images that didn't have text files every nth
    # element (where n is the seqInterval)
    if filesH == []:
        return None  # the thing to return
    elif len(filesH) % seqInterval != 0:
        raise RuntimeError("Got a bad number of files left. Expected to find "
                           "a number divisable by {div!r} but got "
                           "{num!r}".format(div=seqInterval,
                                             num=len(filesH)))
    staticSequence = [filesH[seqInterval*i:seqInterval*i+seqInterval] \
                      for i in range(0,int(math.ceil(float(len(filesH))/\
                                           seqInterval)))]
    return staticSequence + bracketSequences
# end get_sequences


def process_files(dataH, allowedExtensions, defaultPhrases):
    """
    Gets files and processes a dictionary's "item" key differently, depending
    on the user's inputs. If the dataH["recursiveSearch"] is True, it will
    collapse folders into subfolders and then into all retrieved files, for
    example

    Args:
        dataH (dict): The data to process. Requires a key "items" to have a
                      list of file(s)/folder(s)
        allowedExtensions (tuple of strs): A collection of strings to test as
                                           file extensions
        defaultPhrases (list or iterable): If an item in dataH["items"] is in
                                           defaultPhrases, it is excluded in
                                           the output
    Returns:
        list: The processed files that made it through filtering/expansion
    """
    if dataH.get("recursiveSearch", False):
        for item in dataH["items"]:
            if os.path.isdir(item):
                raise RuntimeError("Folders like: {f!r} are not allowed "
                                   "if recursive search is not "
                                   "enabled".format(f=item))

    dataH["items"] = [x for x in dataH.get("items", []) \
                              if os.path.isfile(x) or os.path.isdir(x)]

    allowedExtensions = tuple(x.lower() for x in allowedExtensions)
    if dataH["items"] == []:
        raise RuntimeError("No valid file(s)/folder(s) found")

    if dataH["recursiveSearch"]:
        # remove folders and get their file counterparts
        toRemove = []
        for index, item in enumerate(dataH['items']):
            if os.path.isdir(item):
                toRemove.append(index)
                filesToAdd = [os.path.join(item, f) for f in os.listdir(item) \
                              if os.path.isfile(os.path.join(item, f))]
                dataH["items"] = dataH.get("items", []) + filesToAdd
            elif not os.path.isfile(item):
                raise IOError("Item: {item!r} was not detected as a valid "
                              "file or folder. Do you have permission to "
                              "read the current item?".format(item=item))

        [dataH["items"].pop(i) for i in toRemove]

    # filter out the remaining results
    dataH["items"] = [x for x in dataH.get("items", []) \
                              if x.lower().endswith(allowedExtensions)]
    dataH["items"] = [x for x in dataH.get("items", []) \
                              if x not in defaultPhrases]

    # last check to make sure we have enough items
    if dataH["items"] == []:
        raise RuntimeError("No valid file(s)/folder(s) found")

    return dataH["items"]
# end process_files


def sort_by_ext_and_name(filesH):
    """
    Takes a list of objects and sorts them by their extensions, alphabetically.
    For convenience, the script currently uses and external dependency called
    `natsort <http some url>`_ but perhaps in the future it will be replaced
    with my own method

    Args:
        filesH

    Returns:
        list: A sorted sequence of files, by filename/number
    """
    sortedFiles = natsort.natsorted(filesH, alg=natsort.ns.IGNORECASE)
    return sortedFiles
# end sort_by_ext_name


def truncate_filename_ranges(filesH, maxNumber=20):
    """
    Takes a list of files (assumed to already be sorted) and detects range
    patterns and returns first/last pairs of each given sequential range

    If you have a file convention such as IMG_####.cr2 (very common in cameras),
    the script will pick up on this convention and use it

    Args:
        filesH (list or iterable): A sequence of files to shorten
        maxNumber (int): The max allowed number of items in a sequence. If a
                         sequence is truncated but it is still over the limit,
                         every nth element is removed until it is within
                         acceptable limits

    Retruns:
        list: A list of concatenated/removed/shortened items. No matter what,
              the output is always less than maxNumber
    """
    reCompile = re.compile(r"^(?P<fileName>[a-zA-Z]+)_(?P<fileNumber>[0-9]+).[a-zA-Z0-9]+$")
    currentNamePrefix = ""
    currentNumberSuffix = 129233698012431234  # some impossibly specific number
    currentRange = []
    intermediateOutput = []

    def test_range(matchObject, currentNamePrefix, currentNumberSuffix):
        reMatchFileName = reMatch.group("fileName")
        reMatchFileNumber = reMatch.group("fileNumber")
        if reMatch is not None and reMatchFileName != currentNamePrefix and \
                int(reMatchFileNumber) != currentNumberSuffix + 1:
            return True
        else:
            return False
    # end test_range

    for index, fH in enumerate(filesH):
        filename = paths.os_path_split_asunder(fH)[-1]
        reMatch = re.match(reCompile, filename)
        reMatchFileName = reMatch.group("fileName")
        if test_range(reMatch, currentNamePrefix, currentNumberSuffix) or \
                index + 1 == len(filesH):
            # test for a reset of inital parameters and record the range
            currentNamePrefix = reMatchFileName
            currentNumberSuffix = 129233698012431234
            if len(currentRange) > 2:
                first, last = currentRange[0], currentRange[-1]
                intermediateOutput.append(first + ":" + last)
            elif len(currentRange) == 1:
                intermediateOutput = currentRange[0]
            else:
                # range was none, do nothing
                pass
            currentRange = [fH]
        else:
            currentRange.append(fH)

    # If the list is too long, even after collapsing the ranges, just pick
    # every nth element until the result is under 20. #SORRYFORNOTHING
    #
    if len(intermediateOutput) > maxNumber:
        step = len(intermediateOutput) % maxNumber
        for x in xrange(intermediateOutput[0::step]):
            finalOutput.append(intermediateOutput)
    else:
        return intermediateOutput
    return finalOutput
# end truncate_filename_ranges


def test_ext_sort():
    currentDir = os.path.dirname(os.path.realpath(__file__))

    files = os.path.join(currentDir, "../test/asdf.json")
    with open(files, "r") as f:
        data = json.load(f)
    data = [str(x) for x in data]

    sortedFiles = sort_by_ext_and_name(data)
    sortedFiles = truncate_filename_ranges(sortedFiles)
# end test_ext_sort


if __name__ == "__main__":
    print(__doc__)
    # test_ext_sort()
