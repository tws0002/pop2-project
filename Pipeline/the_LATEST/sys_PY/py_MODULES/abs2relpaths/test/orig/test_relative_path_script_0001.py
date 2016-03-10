#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Testing module for the relative paths script to make sure each example
executes as expected
"""

# IMPORT STANDARD LIBRARIES
import doctest

# IMPORT LOCAL LIBRARIES
from test_get_relative_path_delete_me_0002 import get_relative_path

def pathsep_mismatch():
    """
    >>> absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py"
    >>> rootPath = "C:\Users\SelecaoOne\Desktop\sandbox\license_script\__init__.py"
    >>> get_relative_path(rootPath, absPath)
    '../license_script/__init__.py'
    """
    pass
# end pathsep_mismatch

def exact_match():
    """
    >>> absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py"
    >>> rootPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py"
    >>> get_relative_path(rootPath, absPath)
    'C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py'
    """
    pass
# exact_match

def near_match():
    """
    >>> absPath = "C:/Users/SelecaoOne/Desktop/sandbox/"\
                  "relative_path_script/config.py"
    >>> rootPath = 'C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/'
    >>> get_relative_path(rootPath, absPath)
    'config.py'
    """
    pass
# end near_match

def near_away_parent_path():
    """
    >>> absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/"\
              "config.py"
    >>> rootPath = 'C:/Users/SelecaoOne/Desktop/sandbox'
    >>> get_relative_path(rootPath, absPath)
    '../relative_path_script/config.py'
    """
    pass
# end near_away_parent_path

def far_away_nonparent_mismatch_path():
    """
    >>> absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py"
    >>> rootPath = "C:\Users\Public"
    >>> get_relative_path(rootPath, absPath)
    '../../../../Public'
    """
    pass
# end far_away_nonparent_mismath_path

def failing_condition():
    """
    >>> absPath = "asdfasdfsd"
    >>> rootPath = "goodeats.jpeg"
    >>> get_relative_path(rootPath, absPath)
    False
    """
    pass
# end failing_condition

if __name__ == "__main__":
    doctest.testmod()

