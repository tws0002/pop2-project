#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Module for storing/reading user information. Admittedly, this module is going
to stay very lightweight but I had no other place that made sense to put this
"""

# IMPORT STANDARD LIBRARIES
import os
import json

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts


def get_user_prefs(configH=None):
    """
    Gets user's personal information/preferences on the project.
    Technically the crewmember preferences is read in constants too but, because
    that information could have been changed since the last time it was loaded,
    the function prefers to load it.
    """
    configData = None
    if configH is None and consts.CREWMEMBER_PREFERENCES is None:
        configH = consts.CREWMEMBER_PREFERENCES_LOC
        if not os.path.isfile(configH):
            init_config_data(configH)  # make some default values
        with open(configH, "r") as f:  # load the newly made file or existing
            data = json.load(f)
        configData = data
    elif configH is None and consts.CREWMEMBER_PREFERENCES is not None:
        configData = consts.CREWMEMBER_PREFERENCES

    if configData is None:
        # either a file didn't exist or the read contents were empty
        init_config_data(configH)
        with open(configH, "r") as f:  # load the newly made file or existing
            data = json.load(f)
        configData = data

    return configData
# end get_user_prefs


def init_config_data(configH=None, user=None):
    """
    Creates initial data for the current user

    .. note::
     Specifying a user to create a config file is currently not supported

    .. authornote::
     make user specify the username to write a config file towards

    """
    initDict = {
                    "FOPEN_PREFS": {
                        "LAST_OPENED_APPLICATION": "nuke",
                        "LAST_OPENED": "",
                        "UI_PREF_APPLICATION": "nuke",
                        "UI_PREF_SCENE": "1",
                        "UI_PREF_SHOT": "",
                        "UI_PREF_CHOICE": "Automatic {by filename}"
                    }
                }

    if configH is None and user is None:
        configH = consts.CREWMEMBER_PREFERENCES_LOC
    with open(configH, "w") as f:
        json.dump(initDict, f)
    if os.path.isfile(configH):
        return True
    else:
        return False
# end init_config_data


def set_user_config(dictH, configH=None):
    """
    Sets the user's entire config file

    .. important::
     Only do if you've properly reconstructed the entire config file in its
     entirety
    """
    if configH is None:
        configH = consts.CREWMEMBER_PREFERENCES_LOC

    with open(configH, "w") as f:
        json.dump(dictH, f, indent=4)
# end set_user_config


def set_user_config_single(param, value, configH=None):
    """
    Sets user's personal information/preferences on the project
    """
    if configH is None:
        configH = consts.CREWMEMBER_PREFERENCES_LOC
    userConfigData = get_user_config(configH)
    userConfigData[param] = value
    with open(configH, "w") as f:
        json.dump(userConfigData, f, indent=4)
# end set_user_config_single


if __name__ == "__main__":
    print(__doc__)
