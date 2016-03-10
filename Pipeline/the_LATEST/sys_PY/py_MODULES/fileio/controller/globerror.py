#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Contains custom error methods for project/system admin use. These errors are
designed to stop certain scripts mid-execution. Although all of these are
"errors" and "exceptions" in native Python, in some cases, they're used to
simply stop scripts and aren't actually errors at all.

Examples:
 IOValidationPassedError -
  To keep with PEP8, the exception has "Error" at the end but it's used for
  saving Maya/Nuke/Houdini mid-script, if the user has permission to save
 IOValidationError -
  This error is strictly speaking not an exception in the sense that it's an
  error but it's made to stop an save script mid-execution if there is some
  evidence that the user does not have permission to save
 ExitApplicationError -
  This is the most "traditional" error. When a user is using a deprecated
  application or isn't registered in the project or has some violation, this
  exception is used to kick them out of the program so that they know to fix
  their configuration.
"""


# IMPORT STANDARD LIBRARIES
import functools

# IMPORT THIRD-PARTY LIBRARIES
try:
    import maya.OpenMaya as om
    import maya.cmds as cmds
except:
    pass

try:
    import nuke
except ImportError:
    pass

try:
    import hou
except ImportError:
    pass
    

class ExitApplicationError(Exception):
    """
    Used to exit user from the current application if there is an error
    large enough to make the environment potentially unsafe

    Reference: https://stackoverflow.com/questions/1319615
    """
    def __init__(self, message=None, errors=None):
        """
        Args:
            message (str): The information printed to the user, followed after
                           the stack-trace for the error
            error (int): An error code can also be passed - Used by errno module

        Returns:
            ExitApplicationError: An custom exception
        """
        super(ExitApplicationError, self).__init__(message)
        self.message = message
        if errors is None:
            self.errors = 0
        else:
            self.errors = errors
    # end __init__
# end ExitApplicationError


class IOValidationPassedError(Exception):
    """
    Not technically an error but simply a way to end scripts prematurely
    and allows users to save

    Reference: https://stackoverflow.com/questions/1319615
    """
    def __init__(self, message=None, errors=None):
        """
        Args:
            message (str): The information printed to the user, followed after
                           the stack-trace for the error
            error (int): An error code can also be passed - Used by errno module

        Returns:
            IOValidationPassedError: An custom exception
        """
        super(IOValidationPassedError, self).__init__(message)
        self.message = message
        if errors is None:
            self.errors = 0
        else:
            self.errors = errors
    # end __init__
# end IOValidationPassedError


class IOValidationError(Exception):
    """
    Creates a custom exception for when I'm saving/loading/opening
    file(s)/folder(s) from my custom tools. That way it'll be more searchable
    and also it's less generic than RuntimeError, which could happen for
    any number of reasons

    Used to keep users from saving

    Reference: https://stackoverflow.com/questions/1319615
    """
    def __init__(self, message=None, errors=None):
        """
        Args:
            message (str): The information printed to the user, followed after
                           the stack-trace for the error
            error (int): An error code can also be passed - Used by errno module

        Returns:
            IOValidationError: An custom exception
        """
        super(IOValidationError, self).__init__(message)
        self.message = message
        if errors is None:
            self.errors = 0
        else:
            self.errors = errors
    # end __init__
# end IOValidationError


def exit_application(application="maya"):
    """
    This script is like close_script_job but it is much more aggressive and 
    forces the current application to shut off
    """
    if application == "maya":
        closeApp = functools.partial(cmds.quit(f=True))
        cmds.scriptJob(runOnce=True, e=['idle', closeApp])
    elif application == "nuke":
        nuke.scriptExit()
    elif application == "houdini":
        hou.exit()
# end close_application


if __name__ == "__main__":
    print(__doc__)
