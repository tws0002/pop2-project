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

CONVENTION = consts.RE_FILENAME_MATCH_MA

def test_maya_correct_generic():
    """
    The simplest "right" maya filename

    >>> filePath = "/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/constants/test"
    >>> fileName = "s001_ckenne24_007_uving.0001.ma"
    >>> regex = consts.RE_FILENAME_MATCH_MA
    >>> fCheck = FileCheckoutMaya(filePath, fileName, regex)
    >>> fCheck.description
    uving
    """
    pass
# end test_maya_correct_generic


def test_maya_correct_longform():
    """
    The simplest "right" maya filename

    >>> filePath = "/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/constants/test"
    >>> fileName = "s001_ckenne24_007_uving_and_otherStuff.0001.ma"
    >>> regex = consts.RE_FILENAME_MATCH_MA
    >>> fCheck = FileCheckout(filePath, fileName, regex)
    >>> fCheck.description
    uving_and_otherStuff
    """
    pass
# end test_maya_correct_longform

def test_maya_wrong_generic():
    """
    The simplest "wrong" maya filename

    >>> filePath = "/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/constants/test"
    >>> fileName = "derp.mb"
    >>> try:
    >>>     fCheck = FileCheckout(filePath, fileName, consts.RE_FILENAME_MATCH_MA)
    >>> except TypeError:
    >>>     fCheck = None
    >>> fCheck
    None
    """
    pass
# end test_maya_wrong_generic

def test_maya_wrong_partial():
    """
    The simplest "wrong" maya filename

    >>> filePath = "/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/constants/test"
    >>> fileName = "derp.mb"
    >>> try:
    >>>     fCheck = FileCheckout(filePath, fileName, consts.RE_FILENAME_MATCH_MA)
    >>> except TypeError:
    >>>     fCheck = None
    >>> fCheck
    None
    """
    pass
# end test_maya_wrong_partial



if __name__ == "__main__":
    import doctest
    doctest.testmod()