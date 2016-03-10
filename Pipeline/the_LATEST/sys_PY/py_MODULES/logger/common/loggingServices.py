#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
The code is mostly the result of Frédéric Mantegazza with only slight
modifications to allow for my logging structure

Module purpose
--------------------------------------------

Logging

Implements
--------------------------------------------
 - DefaultFormatter
 - ColorFormatter
 - Logger

:author: Frédéric Mantegazza and Colin Kennedy
.. @copyright: (C) 2007-2011 Frédéric Mantegazza
.. @license: CeCILL
"""

__revision__ = "$Id$"

# IMPORT STANDARD LIBRARIES
import logging
import logging.handlers
import StringIO
import traceback
import os.path

# IMPORT THIRD PARTY LIBRARIES
from commons.unseenformatter import UnseenFormatter
from logger.common import config
from logger.common.loggingFormatter import DefaultFormatter, ColorFormatter, \
                                           SpaceFormatter, SpaceColorFormatter
from pysix import six  # Python 2.x/3.x string types checking

logger = None

# IMPORT LOCAL LIBRARIES
from dictlogger import LoggerDictBase, \
                       LOGGER_MESSAGE_CONFIG, \
                       RE_LOGGER_KEY_MATCH

class LoggerObject(LoggerDictBase):
    """
    Logger object that is instantiated by the factory method
    """
    def __init__(self, defaultStreamHandler, defaultFileHandler):
        """
        Init object

        Args:
            DefaultStreamHandler (bool): If enabled, the logger will print
                                         to stdout
            DefaultFileHandler (bool): If enabled, a rotating file handler
                                       will be created in wherever is specified
                                       in config.TMP_DIR
        """
        super(LoggerDictBase, self).__init__()  # takes no arguments
        super(LoggerObject, self).__init__(defaultStreamHandler, defaultFileHandler)
        logging.TRACE = logging.DEBUG - 5
        logging.EXCEPTION = logging.ERROR + 5
        logging.raiseExceptions = 0
        logging.addLevelName(logging.TRACE, "TRACE")
        logging.addLevelName(logging.EXCEPTION, "EXCEPTION")

        # FormattersTypeError: must be type, not classobj

        #defaultFormatter = DefaultFormatter(config.LOGGER_FORMAT)
        spaceFormatter = SpaceFormatter(config.LOGGER_FORMAT)
        #colorFormatter = ColorFormatter(config.LOGGER_FORMAT)
        spaceColorFormatter = SpaceColorFormatter(config.LOGGER_FORMAT)

        # Logger
        self.__logger = logging.getLogger('POP2')
        self.__logger.setLevel(logging.TRACE)

        # Handlers
        if defaultStreamHandler:
            stdoutStreamHandler = logging.StreamHandler()
            #stdoutStreamHandler.setFormatter(colorFormatter)
            stdoutStreamHandler.setFormatter(spaceColorFormatter)
            self.__logger.addHandler(stdoutStreamHandler)
        if defaultFileHandler:
            loggerFilename = os.path.join(config.TMP_DIR, config.LOGGER_FILENAME)
            fileHandler = logging.handlers.RotatingFileHandler(loggerFilename, 'w',
                                                               config.LOGGER_MAX_BYTES,
                                                               config.LOGGER_BACKUP_COUNT)
            fileHandler.setFormatter(spaceFormatter)
            self.__logger.addHandler(fileHandler)

    def addStreamHandler(self, stream, formatter=DefaultFormatter):
        """
        Add a new stream handler.
        Can be used to register a new GUI handler.

        Args:
            stream (???): open stream where to write logs
            formatter (L{DefaultFormatter<loggingFormatter>}): Associated
                                                               formatter
        """
        handler = logging.StreamHandler(stream)
        handler.setFormatter(formatter(config.LOGGER_FORMAT))
        self.__logger.addHandler(handler)
    # end addStreamHandler

    def get_value(self, key, args, kwds):
        """
        Gets whatever value in the dictionary using a key and then uses it to
        get the item from kwds. This logger expects strings as keywords. If it
        isn't, the value has to be passed to a formatter that can safely handle
        the exception.

        Args:
            key (str or other): The key to get the item of
            args (other): Additional arguments to pass to
                          string.Formatter.get_value
                          (see it's documentation for more details)
            kwds (dict): The dictionary to retrieve items from, using key

        Returns:
            (str or any): The the item(s) from kwds. It will typically be a
                          string but could theoretically be anything
        """
        if isinstance(key, str):
            try:
                return kwds[key]
            except KeyError:
                return key
        else:
            fmt.get_value(key, args, kwds)
    # end get_value

    def setLevel(self, level):
        """
        Change logging level.

        Args:
            level (str): new level, in ('trace', 'debug', 'info', 'warning',
                                        'error', 'exception', 'critical')
        """
        loggerLevels = ('trace', 'debug', 'info', 'warning', 'error', 'exception', 'critical')
        if level not in loggerLevels:
            raise ValueError("Logger level must be in %s" % loggerLevels)
        levels = {'trace': logging.TRACE,
                  'debug': logging.DEBUG,
                  'info': logging.INFO,
                  'warning': logging.WARNING,
                  'error': logging.ERROR,
                  'exception': logging.EXCEPTION,
                  'critical': logging.CRITICAL}
        self.__logger.setLevel(levels[level])
    # end setLevel

    def trace(self, pos, format=None, *args, **kwargs):
        """
        Logs a message with level TRACE.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        if format is None:
            message = self.__getitem__(pos)
        else:
            message = self.__getitem__(pos)
            message = str(message)
            fmt = UnseenFormatter()
            message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.log(logging.TRACE, message, *args, **kwargs)

    def debug(self, pos, format=None, *args, **kwargs):
        """
        Logs a message with level DEBUG.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        if format is None:
            message = self.__getitem__(pos)
        else:
            message = self.__getitem__(pos)
            message = str(message)
            fmt = UnseenFormatter()
            message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.debug(message, *args, **kwargs)
    # end debug

    def info(self, pos, format=None, *args, **kwargs):
        """
        Logs a message with level INFO.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """

        if format is None:
            message = self.__getitem__(pos)
        else:
            message = self.__getitem__(pos)
            message = str(message)
            fmt = UnseenFormatter()
            message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.info(message, *args, **kwargs)
    # end info

    def warning(self, pos, format=None, *args, **kwargs):
        """
        Logs a message with level WARNING.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        if format is None:
            message = self.__getitem__(pos)
        else:
            message = self.__getitem__(pos)
            message = str(message)
            fmt = UnseenFormatter()
            message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.warning(message, *args, **kwargs)
    # end warning

    def error(self, pos, format=None, *args, **kwargs):
        """
        Logs a message with level ERROR.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        if format is None:
            message = self.__getitem__(pos)
        else:
            message = self.__getitem__(pos)
            message = str(message)
            fmt = UnseenFormatter()
            message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.error(message, *args, **kwargs)
    # end error

    def critical(self, pos, format=None, *args, **kwargs):
        """
        Logs a message with level CRITICAL.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        if format is None:
            message = self.__getitem__(pos)
        else:
            message = self.__getitem__(pos)
            message = str(message)
            fmt = UnseenFormatter()
            message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.critical(message, *args, **kwargs)
    # end critical

    def exception(self, pos, debug=False, format=None, *args, **kwargs):
        """
        Logs a message within an exception.

        Args:
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            debug (bool): Flag to log exception on DEBUG level instead of EXCEPTION one
            format (dict): An optional dictionary which can contain strings as
                           "key"/"item" pairs, which would be used to replace
                           formatted text that's passed from self.__getitem__
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        kwargs['exc_info'] = True
        message = self.__getitem__(pos)
        message = str(message)
        fmt = UnseenFormatter()
        message = fmt.format(message, **format)

        if debug:
            if isinstance(pos, six.string_types):
                message = pos

            self.debug(message, *args, **kwargs)
        else:
            if isinstance(pos, six.string_types):
                message = pos

            self.log(logging.EXCEPTION, message, *args, **kwargs)

    def log(self, level, pos, message, *args, **kwargs):
        """
        Logs a message with given level.

        Args:
            level (int): log level to use
            pos (str): Either a string to use to send a message to the
                       StreamHandler or a key that's used to access a
                       dictionary, passed through format
            message (str): Message to log
            args (any): Any additional variables to pass to the logger instance
            kwargs (any): Any additional keywords to pass to the logger instance
        """
        message = self.__getitem__(pos)
        message = str(message)
        fmt = UnseenFormatter()
        message = fmt.format(message, **format)

        if isinstance(pos, six.string_types):
            # override previous if pos is a regular logging string
            message = pos

        self.__logger.log(level, message, *args, **kwargs)
    # end log

    def getTraceback(self):
        """
        Return the complete traceback. Should be called in an except statement.

        Returns:
            str: The traceback from within the exception block
        """
        tracebackString = StringIO.StringIO()
        traceback.print_exc(file=tracebackString)
        message = tracebackString.getvalue().strip()
        tracebackString.close()
        return message
    # end getTraceback

    def shutdown(self):
        """
        Shutdown the logging service.
        """
        logging.shutdown()
    # end shutdown

# Logger factory
def Logger(defaultStreamHandler=True, defaultFileHandler=True):
    """
    The logger factory that creates a global logger and ensures that only one
    instance of the logger class exists at a time

    Args:
        defaultStreamHandler (bool): When enabled, sets the StreamHandler to
                                     stdout
        defaultFileHandler (bool): When enabled, sets local files to save in
                                   config.TMP_DIR

    Returns:
        <LoggerObject>: A global logger instance
    """
    global logger
    if logger is None:
        logger = LoggerObject(defaultStreamHandler, defaultFileHandler)

    return logger
# end Logger


def init_logger():
    """
    Initialized a basic logger
    """
    logger = Logger(RE_LOGGER_KEY_MATCH, LOGGER_MESSAGE_CONFIG)
    return logger
# end init_logger


def test_logger():
    """
    quick test
    """
    dictNew = LoggerDictBase(RE_LOGGER_KEY_MATCH, LOGGER_MESSAGE_CONFIG)

    logger = Logger(RE_LOGGER_KEY_MATCH, LOGGER_MESSAGE_CONFIG)
    # logger.debug(['AIE3000', "Match_True"], {'name':'Joe'})
    logger.debug(['AIE5605', "Match_True"], {'name':'Joe'})
# end test_logger

if __name__ == "__main__":
    test_logger()
