#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
A companion helper file that makes the main function more readable.
Syntax sugar at its finest
"""

# IMPORT STANDARD LIBRARIES
import os


class MayaFile(object):
    """
    A generic class for dealing with Maya files.
    Most methods assume that the Maya file is ASCII (.ma)
    """
    def __init__(self, maPath=""):
        super(MayaFile, self).__init__()
        self.mayaFileExtensions = ('.ma', '.Ma', '.mA', '.MA',
                                   '.mb', '.Mb', '.mB', '.MB')
        self._path = maPath
        if maPath != "":
            self._path = maPath
        else:
            self._path = None
    # end __init__

    def read_ma(self):
        with open(self._path, "r") as f:
            data = f.readlines()
        return data
    # end read_ma

    def write_ma(self, data):
        with open(self._path, "w") as f:
            f.writelines(data)
        return data
    # end write_ma

    @property
    def path(self, path):
        """
        Get method to retrieve the path to a valid Maya file
        """
        return self._path
    # end path

    @path.setter
    def path(self, path):
        """
        Set method to a valid Maya file
        """
        if path.endswith(self.mayaFileExtensions):
            self._path = path
        else:
            self._path = None
    # end @path.setter

    @path.deleter
    def path(self, path):
        """
        Delete method for Maya's file path
        """
        del self._path
    # end @path.deleter
    # end @property
# end MayaFile


if __name__ == "__main__":
    print(__doc__)
