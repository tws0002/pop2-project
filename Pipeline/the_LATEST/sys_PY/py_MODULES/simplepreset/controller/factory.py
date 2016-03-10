#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Automate, making a bunch of preset folder at once
"""

# IMPORT STANDARD LIBRARIES
import os
import json

# IMPORT LOCAL LIBRARIES
import engine

def make_tree_from_dict(jsonFile, rootDir=None):
    """
    The main implementation of the current package. It will look for and expect
    formatted text, {root}, and replace it with the rootDir variable that the
    user has passed

    Args:
        jsonFile (str): The full path of a json file to be read and processed
        rootDir (str): The full path to a directory where the generated
                       file(s)/folder(s) can be placed
    """
    with open(jsonFile, "r") as f:
        dictH = json.load(f)

    rootDict = engine.RootDict()
    if rootDir is not None:
        for key in dictH.keys():
            if key == '{root}':
                dictH[rootDir] = dictH[key]
                dictH.pop("{root}", None)
            rootDict.mkdicttree(dictH)
    # check if rootDir isn't none and, if the dict root key is parsable, replace the key with the folderpath given in rootDir
# end make_tree_from_dict


def make_scene_folders(jsonFile, rootDir):
    # A deprecated test function
    for i in xrange(100):
        shotFolder = "s" + str(i).zfill(3)
        shotFolder = os.path.join(rootDir, shotFolder)
        make_tree_from_dict(jsonFile, shotFolder)
# end make_scene_folders

def make_scene_folders_0001(jsonFile, rootDir):
    """
    The director on the project asked to make a list of scene/shot folders
    with the structure s0\d{2}[A-Z]{2,3}. This function addresses the need by
    simply writing the scene number once, followed by every shot letter that he
    wanted created. The script creates scene/shot directories for every shot
    letter using its scene index number a prefix

    .. Note::
     In order for the JSON file to create directories properly, the root
     key must be replaced with the formatted text {root} so that it can be
     searched/replaced by the current function execution

    Args:
        jsonFile (str): The full path to a json file to read from.
        rootDir (str): The root directory to create directories into

    Returns:
        NoneType: None
    """
    sceneShotList = [[1, ['A', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AJ', 'AK',
                          'C', 'D', 'E', 'E_v2', 'G', 'H', 'N']],
                     [8, ['D', 'DA', 'DB', 'DC', 'D_v2']],
                     [9, ['A', 'A_v2', 'B', 'B_v2']],
                     [11, ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'G_v2',
                           'K', 'K_v2', 'K_v3', 'K_v4', 'K_v5', 'K_v6',
                           'M', 'M_v2', 'M_v3', 'M_v4', 'M_v5', 'M_v6', 'M_v7',
                           'N', 'N_v2', 'N_v3', 'N_v4', 'N_v5', 'R', 'R_v2', 'R_v3', 'R_v4', 'R_v5']],
                     [12, ['A', 'A_v2', 'B', 'C', 'C_v2', 'C_v3', 'C_v4', 'D',
                           'E', 'E_v2']],
                     [13, ['A', 'C', 'D', 'E', 'F']],
                     [14, ['A', 'B', 'B_v2', 'B_v3', 'B_v4', 'B_v5', 'B_v6',
                           'C', 'C_v2', 'C_v3', 'C_v4', 'D', 'F', 'FF', 'H',
                           'H_v2', 'J', 'JJ', 'JJ_v2', 'K', 'L', 'M', 'M_v2',
                           'M_v3', 'M_v4', 'M_v5', 'N', 'P', 'P_v2', 'P_v3',
                           'R', 'R_v2', 'T', 'T_v2']],
                     [15, ['A', 'J', 'J_v2', 'K', 'K_v2', 'L']]]

    for i, l in enumerate(sceneShotList):
        shotFolder = "s" + str(l[0]).zfill(3)  # gives padding of 4
        shotFolderFinal = shotFolder
        if len(l) == 1 or l[1] == []:
            shotFolderFinal = os.path.join(rootDir, shotFolder)
            make_tree_from_dict(jsonFile, shotFolderFinal)
        else:
            for shot in l[1]:
                shotFolderFinal = shotFolder + shot
                shotFolderFinal = os.path.join(rootDir, shotFolderFinal)
                make_tree_from_dict(jsonFile, shotFolderFinal)
# end make_scene_folders_0001

def make_one_hundred_scene_trees():
    rootDir = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/simplepreset/test/attempt_0004"
    jsonFile = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/simplepreset/attempt_0002.json"
    make_scene_folders(jsonFile, rootDir)
    # make_scene_folders_0001(jsonFile, rootDir)
# end make_one_hundred_scene_trees


def make_project_directory_structure():
    rootDir = r"/tmp/output"
    jsonFile = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/latest_CONFIG/conf_DATA/default_scene_shot_folder_struct.json"
    make_scene_folders_0001(jsonFile, rootDir)
# end make_project_directory_structure


if __name__ == "__main__":
    # print(__doc__)
    # make_one_hundred_scene_trees()
    make_project_directory_structure()
