#!/usr/bin/python

"""\
Project::
 Portal Origins: Part Two
Description::
 Testing module for project naming convention
Author::
 Colin Kennedy
"""

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts
import fileio.controller.checkout as checkout

FILEPATH = '/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes'
def _check_name_maya(filePath, name):
    """
    Short hand method simply for testing.
    Do not use in production
    """
    regex = consts.RE_FILENAME_MATCH_MA
    file_h = checkout.FileCheckoutMaya(filePath=filePath, fileName=name)

    return file_h.check_naming_convention(regex)
# end _check_name

def test_maya_name_correct_ma():
    """
    An example (correct) Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving.0001.ma'
    >>> _check_name_maya(filePath=filepath, name=name)
    ('001', 'ckenne24', '007', 'uving', '0001', 'ma')
    """
    pass
# end test_maya_name_correct_ma

def test_maya_name_correct_mb():
    """
    An example (correct) Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving.0001.mb'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving', '0001', 'mb')
    """
    pass
# end test_maya_name_correct_mb

def test_maya_name_correct_MA():
    """
    An example (correct) Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving.0001.MA'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving', '0001', 'MA')
    """
    pass
# end test_maya_name_correct_MA

def test_maya_name_correct_MB():
    """
    An example (correct) Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving.0001.MB'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving', '0001', 'MB')
    """
    pass
# end test_maya_name_correct_mb

def test_maya_name_correct_long_name_ma():
    """
    An example (correct) long form Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving_and_otherShit.0001.ma'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving_and_otherShit', '0001', 'ma')
    """
    pass
# end test_maya_name_correct_long_name_ma

def test_maya_name_correct_long_name_mb():
    """
    An example (correct) long form Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving_and_otherShit.0001.mb'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving_and_otherShit', '0001', 'mb')
    """
    pass
# end test_maya_name_correct_long_name_mb

def test_maya_name_correct_long_name_MA():
    """
    An example (correct) long form Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving_and_otherShit.0001.MA'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving_and_otherShit', '0001', 'MA')
    """
    pass
# end test_maya_name_correct_long_name_MA

def test_maya_name_correct_long_name_MB():
    """
    An example (correct) long form Maya name
    
    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007_uving_and_otherShit.0001.MB'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', 'uving_and_otherShit', '0001', 'MB')
    """
    pass
# end test_maya_name_correct_long_name_MB

def test_maya_name_long_underscorematch_error():
    """
    Maya filename contains a long underscore formatting

    >>> filepath = FILEPATH
    >>> name = 's001_ckenne24_007___uving.0001.ma'
    >>> _check_name_maya(filepath, name)
    ('001', 'ckenne24', '007', '__uving', '0001', 'ma')
    """
    pass
# end test_maya_name_match_error

def test_maya_name_bad_name():
    """
    Maya filename contains illegal characters

    >>> filepath = FILEPATH
    >>> name = 'derp_$%(*$.ma'
    >>> _check_name_maya(filepath, name)
    """
    pass
# end test_maya_name_bad_name

def test_nuke_name_correct():
    """
    An example (correct) nuke name
    """
    pass
# end test_nuke_name_correct

def test_nuke_name_match_error():
    """
    Nuke filename contains bad formatting
    """
    pass
# end test_nuke_name_match_error

def test_nuke_name_bad_name():
    """
    Nuke filename contains illegal characters
    """
    pass
# end test_nuke_name_bad_name

if __name__ == "__main__":
    import doctest
    doctest.testmod()
