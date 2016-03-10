#!/usr/bin/python
# -*- coding: utf-8 -*-

"""\
..Project::
 Portal Origins: Part Two
..Description::
 Testing module for my regex file convention naming methods
..Author::
 Colin Kennedy
"""


# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
from fileio.controller.checkout_0001 import FileCheckoutMaya
FileCheckoutMaya


CONVENTION = consts.RE_FILENAME_MATCH


def test_maya_correct_generic():
    """
    The simplest "right" maya filename
    >>> filePath = "/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/constants/test"
    >>> fileName = "s001_ckenne24_007_uving.0001.ma"
    >>> regex = consts.RE_FILENAME_MATCH
    >>> fCheck = FileCheckoutMaya(filePath, fileName, regex)
    >>> fCheck.description
    uving
    """
    pass
# end test_maya_correct_generic
#

def test_all_at_once():
    """
    Testing is the greatest imperative
    """
    sceneNameList = [""]
    fileNameList = ['']

    for f in sceneNameList:
        try:
            fCheck = None
            if f.upper().upper().endswith('.MA'):
                fCheck = FileCheckoutMaya(filePath,
                                          fileName,
                                          consts.RE_FILENAME_MATCH)
            elif f.upper().endswith('.NK'):
                fCheck = FileCheckoutNuke(filePath,
                                          fileName,
                                          consts.RE_FILENAME_MATCH)
            elif f.upper().endswith(('.HIP', '.HIPNC')):
                fCheck = FileCheckoutHoudini(filePath,
                                             fileName,
                                             consts.RE_FILENAME_MATCH)
            else:
                # assume it's meant to be a "final" asset
                fCheck = FileCheckout()
            fCheck = True
        except TypeError:
            fCheck = False
        fCheck
# test_all_at_once


if __name__ == "__main__":
    import doctest
    doctest.testmod()
