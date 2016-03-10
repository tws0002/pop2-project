#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
All methods that work with or manipulate folders here
"""

# IMPORT STANDARD LIBRARIES
import sys

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths as paths


def get_application_type(applicationOverride="", automatic=True):
    """
    Gets the current python interpreter of the interactive shell, whose path
    will differ depending on application, to determine which application a person
    is in. The output application can also be manually overwritten if it's given
    the string "maya", "nuke" or "houdini"
    """
    if applicationOverride != "":
        return applicationOverride

    if applicationOverride == "" and not automatic:
        sys.exit("applicationOverride or automatic must be specified")

    currentExecutable = sys.executable
    for app in consts.SUPPORTED_APPLICATION_NAMES:
        if app.lower() in paths.path_leaf(currentExecutable.lower())[-1]:
            applicationType = app
            break
        else:
            applicationType = None
# end get_application_type
