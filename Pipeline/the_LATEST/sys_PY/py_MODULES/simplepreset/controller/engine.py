#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Drives most of the main functions within the script


--- make folders from json
- make script to ignore formats if they don't exist
- read in folders/files as a dictionary
- make a function that will allow relative paths to files (relative to the config file)
- in the gui, when reading in the relative path, convert it to absolute, relative to the config file
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import json
import shutil

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths as paths


CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))


class RootDict(object):
    """
    """
    def __init__(self):
        super(RootDict, self).__init__()
        self.dictPath = None
        self.configPath = None
    # end __init__

    def path_to_dict(self, someDir, level=9001, relativeFolders=True, relativeFiles=False):
        """
        Reads a directory of folder(s)/file(s) and outputs them as a
        relative dictionary

        Args:
            someDir (str): The directory to walk through and get
                           subfolder(s)/file(s
            level (bool): The number of subfolders permitted to move down. The
                          default number is set impossibly high, simply to
                          mimic a recursive behavior
            relativeFolders (bool): Folders found will stored as dict keys using
                                    only their leafed name, not as a full path,
                                    if the option is enabled.
            relativeFiles (bool): Files can be stored as absolute paths or as
                                  relative paths (which are set relative to
                                  the config file)

        Returns:
            dict: The file/folder structure
        """
        someDir = someDir.rstrip(os.path.sep)
        assert os.path.isdir(someDir)
        numSep = someDir.count(os.path.sep)

        outputDict = {}
        for root, dirs, files in os.walk(someDir):
            for d in dirs + files:
                path = os.path.join(root, d)[(len(someDir)):]
                path = path.rstrip(os.sep).lstrip(os.sep)
                pathSplit = paths.os_path_split_asunder(path)
                if os.path.isfile(os.path.join(root, d)) and not relativeFiles:
                    pathSplit[-1] = os.path.join(root, d)
                if len(pathSplit) == 1:
                    outputDict[pathSplit[0]] = {}
                else:
                    nestedDict = self.list_flattened_to_dict(pathSplit)
                    mergedDict = dict(mergedicts(outputDict, nestedDict))
                    for key in nestedDict.keys():
                        outputDict = dict(outputDict, **nestedDict)
                    outputDict = dict(outputDict, **mergedDict)

            numSepCurrent = root.count(os.path.sep)
            if numSep + level <= numSepCurrent:
                del dirs[:]
        return outputDict
    # end path_to_dict

    def list_flattened_to_dict(self, listH, defaultItem={}):
        """
        Flattens a list into a dict of dicts, with list indices as keys

        Args:
            listH (list): An iterable that contains values that can be valid
                          dictionary keys.
            defaultItem (any): The current script uses this function to produce
                               an empty dictionary by default but it could
                               theoretically take any argument, as long as it's
                               a valid item for a dictionary

        Returns:
            dict: A dictionary containing keys from the list with the same item
        """
        dictList = defaultItem
        for name in reversed(listH):
            dictList = {name: dictList}
        return dictList
    # end list_flattened_to_dict

    def mkdicttree(self, dictH):
        """
        Takes a dictionary and, assuming that there is only one top level key
        and that key is absolute, the keys underneath will be generated

        Currently, the dict must be relative, support for absolute paths
        in the future (maybe)

        Args:
            dictH (dict): Makes a tree of file(s)/folder(s) from a dict

        Returns:
            NoneType: None
        """
        for key in dictH.keys():
            if os.path.isfile(key):
                sys.exit("Key: {key} cannot be a file. "
                         "Directories only".format(key=key))
            elif os.path.isabs(key) and not os.path.isdir(key):
                os.makedirs(key)

            if not os.path.isabs(key):
                sys.exit('Got: "{f}", expected absolute path'.format(f=key))
            elif os.path.isabs(key) and isinstance(dictH[key], dict):
                self.traverse_dict_and_add(rootDir=key, dictH=dictH[key])
    # end mkdicttree

    def traverse_dict_and_add(self, rootDir, dictH):
        """
        Runs through a dictionary type and creates file(s)/folder(s) relative
        to the rootDir

        .. Note::
         dictH currently does NOT support formatted text elements

        Args:
            rootDir (str): The root directory to move through and create from
            dictH (dict): The dictionary of information to create from.

        Returns:
            NoneType: None
        """
        origRootDir = rootDir
        for key, item in dictH.iteritems():
            if item is None or item == {} or item == []:
                attemptedJoin = os.path.normpath(os.path.join(rootDir, key))
                keyPath = None
                if not os.path.isabs(key) and (os.path.isdir(attemptedJoin) or
                                               os.path.isfile(attemptedJoin)):
                    # copy the found file/folder to directory
                    keyPath = attemptedJoin
                if os.path.isabs(key) and (os.path.isfile(key) or
                                           os.path.isdir(key)):
                    # copy file/folder to the root location
                    if not os.path.isdir(rootDir):
                        paths.mkdir_p(rootDir)
                    keyPath = paths.path_leaf(key)
                    copyLoc = os.path.join(rootDir, keyPath)
                    shutil.copy2(key, copyLoc)
                    continue  # skip the rest of this iteration

                if keyPath is not None and not os.path.isdir(keyPath):
                    # the string was either not a file/folder or couldn't be
                    # resolved from a relative path into a file/folder
                    #
                    copyLoc = paths.path_leaf(keyPath)
                    copyLoc = os.path.join(rootDir, copyLoc)
                    print copyLoc
                    shutil.copy2(key, copyLoc)
                elif keyPath is None:
                    # no directory exists at this location, create one
                    dirToMake = os.path.normpath(os.path.join(rootDir, key))
                    os.makedirs(dirToMake)
                    # sys.exit('Got: "{f}", couldn\'t resolve '
                    #          'into file or folder'.format(f=key))

            elif isinstance(item, dict):
                newRootDir = os.path.join(rootDir, key)
                newRootDir = os.path.normpath(newRootDir)
                self.traverse_dict_and_add(rootDir=newRootDir,
                                           dictH=dictH[key])
            else:
                sys.exit('Got: "{f}", expected a dictionary, '
                         '\{\} or None'.format(f=item))
    # end traverse_dict
# end RootDict


def main():
    # WAS an unfinished testing module for engine. Deprecated and no longer
    # used for testing
    rootDict = RootDict()

    # paths to json files
    jsonPath = os.path.dirname(os.path.realpath(__file__))
    testPath = jsonPath
    relativePath = "../model"
    jsonPath = os.path.normpath(jsonPath, relativePath)
    jsonFiles = [os.path.join(jsonPath, x) for x in os.listdir(jsonPath)]

    # path to testing module
    relativePath = "../test"
    testPath = os.path.normpath(testPath, relativePath)

    for fh in jsonFiles:
        with open(fh, "r") as f:
            data = json.load(fh)
# end main


def mergedicts(dict1, dict2):
    """
    Custom merge dictionary operation. It currently creates a union based on
    each dictionary's keys and attempts to resolve conflicts and also to
    recursively add nested dictionary structures

    .. Considerations::
     Conflicts are resolved by giving dict2 priority

    Args:
        dict1 (dict): The base dictionary to start with
        dict2 (dict): An additional dictionary to merge into dict1. Conflicts
                      are resolved by giving dict2 priority

    Returns:
        dict: A merged dictionary containing the new key/value pairs
    """
    for k in set(dict1.keys()).union(dict2.keys()):
        if k in dict1 and k in dict2:
            if isinstance(dict1[k], dict) and isinstance(dict2[k], dict):
                yield (k, dict(mergedicts(dict1[k], dict2[k])))
            else:
                # If one of the values is not a dict, you can't continue merging it.
                # Value from second dict overrides one in first and we move on.
                yield (k, dict2[k])
                # Alternatively, replace this with exception raiser to alert you of value conflicts
        elif k in dict1:
            yield (k, dict1[k])
        else:
            yield (k, dict2[k])
# end mergedicts
