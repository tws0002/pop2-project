# -*- coding: utf-8 -*-

"""
The code is mostly the result of Frédéric Mantegazza with only slight
modifications to allow for my logging structure

Module purpose
==============

Logging

Implements
==========

- DefaultFormatter
- ColorFormatter
- Logger

:author: Frédéric Mantegazza and Colin Kennedy
.. @copyright: (C) 2007-2011 Frédéric Mantegazza
.. @license: CeCILL
"""

__revision__ = "$Id$"

import sys

from papywizard.common import config


class LogBuffer(object):
    """
    Log buffer storage.

    Implement a log buffer, which automatically appends
    a record at the end, and limit the size to a specified value.
    """
    def __init__(self):
        """
        Init the log buffer.
        """
        self.__buffer = []

    def write(self, logMessage):
        """
        Write a log message a the end of the buffer.

        Args:
            logMessage (str): log to write

        Returns:
            NoneType: None
        """
        self.__buffer.append(logMessage)
        if len(self.__buffer) > config.LOGGER_MAX_COUNT_LINE:
            del self.__buffer[0]

    def flush():
        """
        Dummy method.

        Needed to use this class as logging stream.
        """
        pass

    def getHtml(self):
        """
        A small convenience method to link to doc pages by reading in the
        HTML string from the doc-pages

        Returns:
            text (str): The output HTML from self.__buffer
        """
        text = u""
        for line in self.__buffer:
            if isinstance(line, str):
                text += u"<br />" + line.decode(sys.getfilesystemencoding())
            else:
                text += u"<br />" + line
        return text

    def clear(self):
        """
        Clear the buffer.
        """
        self.__buffer = []
