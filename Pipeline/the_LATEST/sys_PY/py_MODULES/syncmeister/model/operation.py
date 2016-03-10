#!/usr/bin/python
# -*- coding: utf-8

"""

Synopsis
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Determines Go/Stop/Pause and other conditional operations within larger
applications in the form of static methods, objects, or other structures

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
operation.py

"""


class BaseOperation(object):
    ID = None
# end BaseStrategy

class Operation(BaseOperation):
    """
    Warning, deprecated in favor of static methods. See StaticOperation class:

    :ref:`syncmeister-static-operation`

    """
    def __init__(self):
        super(Operation, self).__init__()
        self.STOP = None
        self.START = None
        # self.CONTINUE = None
        self.PAUSE = None
        self.STATUS = None
        self.CONTINUE = None
        self.RECURSIVE_SAME_CLASS = None
        self.PASS = None
        self.SWITCH = None
    # end __init__
# end Operation


class StaticOperation(BaseOperation):
    """
    .. _syncmeister-static-operation:

    This class is not instantiated but instead referenced for its static methods.
    It keeps all application-specific defaults and also determines signals for
    other scripts using static methods.

    The idea is to return these static methods from functions and then detect
    them in the outer execution of a for loop and handle them like exceptions

    .. note::
        In the future, if I need greater functionality from my return objects,
        I might create a similar class that returns class objects but for now,
        static methods are good
        enough

    """
    defaultRootDirText = "{ project path here without {}s }"
    @staticmethod
    def CONTINUE(*argv):
        """
        Use when outer loop (of a regular for loop) must be set to continue
        """
        return argv
    # end CONTINUE

    @staticmethod
    def PASS(*argv):
        """
        Use when outer loop (of a regular for loop) must be set to pass
        """
        return argv
    # end PASS

    @staticmethod
    def SWITCH_OS(*argv):
        """
        When different operating systems are detected and some operation must be
        done to correct this issue, use SWITCH_OS as a return object in a
        conditional statement
        """
        return argv
    # end SWITCH_OS

    @staticmethod
    def RECURSIVE_SAME_CLASS(*argv):
        """
        When some event is done where a recursion must be used on a specific
        elemente, use the following class
        """
        return argv
    # end RECURSIVE_SAME_CLASS

    @staticmethod
    def IS_ABSOLUTE(*argv):
        """
        In reference to file paths - When a path is found to be absolute, use
        the following object in a for-loop+condition or similar structure
        """
        return argv
    # end IS_ABSOLUTE

    @staticmethod
    def IS_RELATIVE(*argv):
        """
        In reference to file paths - When a path is found to be relative, use
        the following object in a for-loop+condition or similar structure
        """
        return argv
    # end IS_RELATIVE
# end Operation


if __name__ == "__main__":
    print(__doc__)
