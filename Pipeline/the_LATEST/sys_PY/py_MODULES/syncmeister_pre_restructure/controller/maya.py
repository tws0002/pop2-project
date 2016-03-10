#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
A companion helper file that makes the main function more readable.
Syntax sugar at its finest
"""

# IMPORT STANDARD LIBRARIES
import os


class FileObject(object):
    def __init__(self, maPath=""):
        super(FileObject, self).__init__()
        self.fileExtensions = ('.ma', '.Ma', '.mA', '.MA',
                               '.mb', '.Mb', '.mB', '.MB')
        self.fileExtensionsASCII = ('.ma', '.Ma', '.mA', '.MA')
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

    def locked(self, path):
        """
        ::::PROJECT SPECIFIC::::
        TEMPORARY - remove later and replace with the main module for locked
        and is_locked. Don't use the method in this library
        """
        if os.path.isdir(path) or os.path.isfile(path):
            return True
        else:
            return False
    # end locked

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
        if path.endswith(self.fileExtensions):
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
# end FileObject


if __name__ == "__main__":
    print(__doc__)
