# -*- coding: utf-8 -*-

""" Panohead remote control.

License
=======

 - B{Papywizard} (U{http://www.papywizard.org}) is Copyright:
  - (C) 2007-2011 Frédéric Mantegazza

This software is governed by the B{CeCILL} license under French law and
abiding by the rules of distribution of free software.  You can  use,
modify and/or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
U{http://www.cecill.info}.

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited
liability.

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or
data to be ensured and,  more generally, to use and operate it in the
same conditions as regards security.

The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.

Module purpose
==============

Logging

Implements
==========

- DefaultFormatter
- ColorFormatter
- Logger

@author: Frédéric Mantegazza
@copyright: (C) 2007-2011 Frédéric Mantegazza
@license: CeCILL
"""

__revision__ = "$Id$"

# IMPORT STANDARD LIBRARIES
import logging
import logging.handlers
import StringIO
import traceback
import os.path

# IMPORT THIRD PARTY LIBRARIES
from logger.common import config
from logger.common.loggingFormatter import DefaultFormatter, ColorFormatter, \
                                           SpaceFormatter, SpaceColorFormatter

logger = None

# IMPORT LOCAL LIBRARIES
from sandbox.regex_integrated_dict_custom_class_0005 import LoggerDictBase, \
                                                            LOGGER_MESSAGE_CONFIG, \
                                                            RE_LOGGER_KEY_MATCH

"""
AUTHOR NOTE: Add default key for the formatter: 
http://stackoverflow.com/questions/23407295/default-kwarg-values-for-pythons-str-format-method
"""

class LoggerObject(LoggerDictBase):
    """ Logger object
    """
    def __init__(self, defaultStreamHandler, defaultFileHandler, regexCompile, 
                 messageConfig):
        """ Init object.
        """
        print defaultStreamHandler, \
              defaultFileHandler, \
              RE_LOGGER_KEY_MATCH, \
              LOGGER_MESSAGE_CONFIG

        print 'super', super(LoggerDictBase, self).__init__(RE_LOGGER_KEY_MATCH, 
                                           LOGGER_MESSAGE_CONFIG)
        logging.TRACE = logging.DEBUG - 5
        logging.EXCEPTION = logging.ERROR + 5
        logging.raiseExceptions = 0
        logging.addLevelName(logging.TRACE, "TRACE")
        logging.addLevelName(logging.EXCEPTION, "EXCEPTION")

        # Formatters
        #defaultFormatter = DefaultFormatter(config.LOGGER_FORMAT)
        spaceFormatter = SpaceFormatter(config.LOGGER_FORMAT)
        #colorFormatter = ColorFormatter(config.LOGGER_FORMAT)
        spaceColorFormatter = SpaceColorFormatter(config.LOGGER_FORMAT)

        # Logger
        self.__logger = logging.getLogger('papywizard')
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
        """ Add a new stream handler.

        Can be used to register a new GUI handler.

        @param stream: open stream where to write logs
        @type stream: ???

        @param formatter: associated formatter
        @type formatter: L{DefaultFormatter<common.loggingFormatter>}
        """
        handler = logging.StreamHandler(stream)
        handler.setFormatter(formatter(config.LOGGER_FORMAT))
        self.__logger.addHandler(handler)

    def setLevel(self, level):
        """ Change logging level.

        @param level: new level, in ('trace', 'debug', 'info', 'warning', 'error', 'exception', 'critical')
        @type level: str
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

    def trace(self, pos, format, *args, **kwargs):
        """ Logs a message with level TRACE.

        @param message: message to log
        @type message: string
        """
        message = self.__getitem__(pos).format(**format)
        self.__logger.log(logging.TRACE, message, *args, **kwargs)

    def debug(self, pos, format, *args, **kwargs):
        """ Logs a message with level DEBUG.

        @param message: message to log
        @type message: string
        """
        message = self.__getitem__(pos).format(**format)
        self.__logger.debug(message, *args, **kwargs)

    def info(self, pos, format, *args, **kwargs):
        """ Logs a message with level INFO.

        @param message: message to log
        @type message: string
        """
        message = self.__getitem__(pos).format(**format)
        self.__logger.info(message, *args, **kwargs)

    def warning(self, pos, format, *args, **kwargs):
        """ Logs a message with level WARNING.

        @param message: message to log
        @type message: string
        """
        message = self.__getitem__(pos).format(**format)
        self.__logger.warning(message, *args, **kwargs)

    def error(self, pos, format, *args, **kwargs):
        """ Logs a message with level ERROR.

        @param message: message to log
        @type message: string
        """
        message = self.__getitem__(pos).format(**format)
        self.__logger.error(message, *args, **kwargs)

    def critical(self, pos, format, *args, **kwargs):
        """ Logs a message with level CRITICAL.

        @param message: message to log
        @type message: string
        """
        message = self.__getitem__(pos).format(**format)
        self.__logger.critical(message, *args, **kwargs)

    def exception(self, pos, format, debug=False, *args, **kwargs):
        """ Logs a message within an exception.

        @param message: message to log
        @type message: string

        @param debug: flag to log exception on DEBUG level instead of EXCEPTION one
        @type debug: bool
        """
        kwargs['exc_info'] = True
        message = self.__getitem__(pos).format(**format)

        if debug:
            self.debug(message, *args, **kwargs)
        else:
            self.log(logging.EXCEPTION, message, *args, **kwargs)

    def log(self, level, message, *args, **kwargs):
        """ Logs a message with given level.

        @param level: log level to use
        @type level: int

        @param message: message to log
        @type message: string
        """
        self.__logger.log(level, message, *args, **kwargs)

    def getTraceback(self):
        """ Return the complete traceback.

        Should be called in an except statement.
        """
        tracebackString = StringIO.StringIO()
        traceback.print_exc(file=tracebackString)
        message = tracebackString.getvalue().strip()
        tracebackString.close()
        return message

    def shutdown(self):
        """ Shutdown the logging service.
        """
        logging.shutdown()

# Logger factory
def Logger(regexCompile, messageConfig, defaultStreamHandler=True, 
           defaultFileHandler=True,):
    global logger
    if logger is None:
        logger = LoggerObject(defaultStreamHandler, defaultFileHandler, 
                              regexCompile, messageConfig)
    return logger

def main():
    """
    dictNew = LoggerDictBase(RE_LOGGER_KEY_MATCH, LOGGER_MESSAGE_CONFIG)

    print dictNew['AIE3000', "Match_True"].format(name="Joe")
    """
    print
    print
    print "start"
    logger = Logger(defaultStreamHandler=False, defaultFileHandler=False,
                    regexCompile=RE_LOGGER_KEY_MATCH, 
                    messageConfig=LOGGER_MESSAGE_CONFIG)
    print "done"
    logger.debug(['AIE3000', "match_true"], {'name':'Joe'})
# end main

if __name__ == "__main__":
    main()