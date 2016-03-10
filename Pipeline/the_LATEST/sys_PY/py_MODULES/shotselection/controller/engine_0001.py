#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Main implementation of the shotselection module, contains methods that
get/set information to populate the GUI with and submodules.
"""

# IMPORT STANDARD LIBRARIES
import os
import re
import time
import datetime

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts
import commons.paramdict as paramdict
import pysix.six as six
import fileio.controller.paths as paths


class FileNameScoreboard(object):
    """
    There are 4 different idenifiers from which to determine the "latest" file.
    Version, version revision, increment, and increment revision

    Both revisions are based on letters and there are 26 letters in the english
    alphabet

    I must make each section's next increment higher than the next so that, for
    example, version gets the highest priority and increment revision is the lowest

    Each section will need some way of telling what an increment multiplies by,
    and the counters need to be able to add together

    incrementRevision = 1 point each  - assuming that A starts at 1. :AUTHORNOTE: CONFIRM THIS
    increment = 27 points each
    versionRevision = 27,000 points each
    version = 702,000 points each
    """
    def __init__(self, fileName):
        super(FileNameScoreboard, self).__init__()
        self.fileName = fileName

        self.matchConfig = paramdict.ParamDict({
            "incrementRevision": 1,
            "increment": lambda self: (self['incrementRevision'] * 26) + 1,
            "versionRevision": lambda self: (self['increment'] * 1000) + 1,
            "version": lambda self: (self['versionRevision'] * 26) + 1
        })

        self.get_score()
    # end __init__

    def get_score(self, dictH={}, *kwargs):
        """
        Procedurally creates the scoreboard in one pass
        When a group is retrieved, it expects a string or an int. If an int is
        found, it's converted to a number. If it's a string, theoretically it
        could be multiple letters
        """
        if dictH is None:
            dictH.update(self.matchConfig)
        if kwargs is not None:
            dictH.update(kwargs)

        # init the scoreboard counters
        reMatch = re.match(consts.RE_FILENAME_MATCH, self.fileName)
        tally = FileNameCounter("")
        tally.outValue = 0
        for key, items in self.matchConfig.iteritems():
            scorePoint = reMatch.group(key)
            if scorePoint is not None:
                temporaryCounter = FileNameCounter(self.fileName)
                temporaryCounter.inValue = scorePoint
                temporaryCounter.multiplier = self.matchConfig[key]
                temporaryCounter.get_score()
                tally.score = tally + temporaryCounter
        return tally.score
    # end get_score
# end FileNameScoreboard


class FileNameCounter(object):
    def __init__(self, filePath, inValue=0):
        super(FileNameCounter, self).__init__()
        self.filePath = filePath
        self.multiplier = 1
        self._inValue = inValue
        self._score = 0
    # end __init__

    def get_score(self):
        self.score = self.inValue * self.multiplier
    # end get_score

    @property
    def score(self):
        """
        The getter method for the score of the current counter
        """
        # finalCalculatedValue = self._inValue * self.multiplier
        # if self._score != finalCalculatedValue:
        #     # the user set the score manually
        #     return self._score
        # else:
        #     return finalCalculatedValue
        return self._score
    # end score.property

    @score.setter
    def score(self, value):
        """
        .. warning::
         It's very unsafe to set because the getter method of the property is
         meant to evaluate other parameters
         but you can do it if you need to

        The setter method for the score of the current counter
        """
        self._score = value
    # end score.setter

    @property
    def inValue(self):
        """
        The getter method for the initial value that the user passed for the value
        """
        return self._inValue
    # end inValue.property

    @inValue.setter
    def inValue(self, value):
        """
        The setter method for the inValue of the current counter
        """
        try:
            self._inValue = float(value)
        except ValueError:
            # the passed value is not a float or int
            if not isinstance(value, six.string_types):
                raise NotImplementedError("FileNameCounter doesn't have a way"
                                          "to process int or str")
            tally = 0
            for char in value:
                tally += letter_to_index(char, offset=1)
            self._inValue = tally
    # end inValue.setter

    def __add__(self, other):
        """
        Add method for counters
        """
        return self.score + other.score
    # end __add__
# end FileNameCounter


def get_scenes(rootDir, reCompile):
    """
    Creates items based on the what's in the Edit scenes folder
    """
    comboBoxItemIndex = -1  # so that += will start at index to 0
    sceneList = []
    folderListing = get_folders(rootDir)
    for folder in folderListing:
        folderName = paths.path_leaf(folder)
        reMatch = re.match(reCompile, folderName)
        if reMatch is not None:
            comboBoxItemIndex += 1
            sceneNum = reMatch.group("shot")
            sceneNum = int(sceneNum)
            if sceneNum not in sceneList:
                sceneList.append(sceneNum)

    sceneList.sort()
    return sceneList
# end get_scenes


def get_shots(currentText, shotsFolders, sceneFolderName, reCompile):
    """
    Auto gets shots, based on the current scene number displayed
    """
    currentText = str(currentText)
    currentTextAsInt = int(currentText)
    shotList = []
    for index, folder in enumerate(shotsFolders):
        folderName = paths.path_leaf(folder)
        reMatch = re.match(reCompile, folderName)
        scene = reMatch.group("shot")
        if int(scene) == currentTextAsInt:
            toReplace = "s0" + scene
            shot = folderName[len(toReplace):]
            shotList.append(shot)

    shotList.sort(key=len)
    return shotList
# end get_shots


def get_folders(rootDir):
    """
    Gets folders in the scene/shot directory
    """
    for d in os.listdir(rootDir):
        yield os.path.join(rootDir, d)
# end get_folders


def get_latest_by_filename(filePaths):
    """
    Parses the current filename and gets the latest file
    """
    scoreKeeper = 0
    highScorer = ""
    for f in filePaths:
        fileName = paths.path_leaf(f)
        fileScoreboard = FileNameScoreboard(fileName)
        count = fileScoreboard.get_score()
        if count > scoreKeeper:
            scoreKeeper = count
            highScorer = f
    return highScorer
# end get_latest_by_filename


def get_latest_by_date(filePaths):
    """
    Gets metadata of file and selects the most recent
    """
    fileList = []
    endswith = (x.lower() for x in endswith)  # conform entries for easier comparing
    endswith = tuple(endswith)
    for f in filePaths:
        # (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(f)
        (_, _, _, _, _, _, _, _, mtime, _) = os.stat(f)
        fileList.append((f, mtime))

    # fileList.sort(key=lambda x: datetime.datetime(x[1]))
    fileList.sort(key=lambda x: x[1])
    fileToAccess = fileList[-1][0]
    return fileToAccess
# end get_latest_by_date


def letter_to_index(letter, offset=1):
    _alphabet = 'abcdefghijklmnopqrstuvwxyz'
    letter = letter.lower()
    return next((i+offset for i, _letter in enumerate(_alphabet) if _letter == letter), None)
# end letter_to_index


def test_get_latest_by_filename():
    rootDir = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Edit/s001/maya/scenes"
    filesToCompare = [os.path.join(rootDir, x) \
                      for x in os.listdir(rootDir) \
                      if os.path.isfile(os.path.join(rootDir, x))]
    return get_latest_by_filename(filesToCompare)
# end test_get_latest_by_filename


if __name__ == "__main__":
    # print letter_to_index('D', False)
    # print(__doc__)
    print test_get_latest_by_filename()
    # print get_latest_by_date(rootDir, '.ma')
