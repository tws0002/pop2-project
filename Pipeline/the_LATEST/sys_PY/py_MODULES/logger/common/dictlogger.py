#!/usr/bin/python
# -*- coding: utf-8 -*-

"""\
.. Project::
 Portal Origins: Part Two
.. Description::
 A generic class that will be inherited by the main logger class.
 Makes the logger replicate dictionary-type operations.
 This module is NOT meant to be read directly
.. Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os
import re
import json

# IMPORT LOCAL LIBRARIES
from pysix import six


LOGGER_MESSAGE_PATH = os.path.join(os.environ['PROJECT_DIR'],
                                   "Pipeline",
                                   "the_LATEST",
                                   "latest_MESSAGES",
                                   "mess_CODES",
                                   "traceback_debug_codes_0003.json")


with open(LOGGER_MESSAGE_PATH) as f:
    LOGGER_MESSAGE_CONFIG = f.read()

LOGGER_MESSAGE_CONFIG = json.loads(LOGGER_MESSAGE_CONFIG)

# key search terms
LOGGER_KEY = r'^[A-Z]{3}\d{4}[A-Z]?'
RE_LOGGER_KEY_MATCH = re.compile(LOGGER_KEY)


class LoggerDictBase(dict):
    """
    The engine which allows the logger for the project to accept regular strings
    as well as keys to an external JSON dictionary.

    This class was because of the sheer body and uncleaniness of traditional
    logging. Now, instead of writing a string directly into the logger, one can
    specify a dictionary key and retrieve its value, which is a string to pass
    to the logger.

    An example of default behavior
     >>> logger.debug(['AIE5100'], {'proj': "The project name"})

    the logger would then retrieve key 'AIE5100' from the dictionary and format
    its string with 'proj'. If 'proj' doesn't exist, it is simply ignored.
    Also, if the string that returned from 'AIE5100' contained more keys than
    just 'proj', instead of raising a KeyError, the variable names contained
    in the formatted string will just replace themselves as regular text. Neat!
    """
    def __init__(self, regex, *initial_data, **kwargs):
        self.regexMethod = regex
        self.matchFormat = {'match_true': '[+]',
                            'match_false': '[-]',
                            'except': '[|]'}
        # Add logger messages to dict
        for dictionary in initial_data:
            for key in dictionary:
                self[key] = dictionary[key]
                # setattr(self, key, dictionary[key])
        for key in kwargs:
            self[key] = kwargs[key]
            # setattr(self, key, kwargs[key])

    # end __init__

    def type(self, query):
        """
        Added a way to quickly get predefined prefixes for the dictionary.
        type() is implemented in __getitem__ basically to prefix whatever is
        returned from __getitem__, assuming that the two types are able to be
        combined

        Args:
            query (str): A preset key which will return some string, usually
                         short. An example return would be 'match_true' > '[+]'.
                         I find it useful to add quick descriptors to make log
                         files more searchable
        Returns:
            str: The returned string from the key
        """
        # return self.get(self.matchFormat[query], "")
        return self.matchFormat.get(query, "")
    # end type

    def search_keys(self, matchString):
        """
        A method to search keys for a string match. This differs from
        __getitem__ in that it returns a dictionary containing all of the
        possible matches within the dictionary

        Args:
            matchString (str or <_sre.Pattern>): A string or pattern match for
                                                 the regex to use to search the
                                                 dict

        Returns:
            dict: All partial and/or full key matches for matchString
        """
        # result = {}
        # for key, value in self.iteritems():
        #     if re.match(matchString, key):
        #         result[key] = value
        result = {}
        for key, value in self.iteritems():
            if re.match(matchString, key):
                result[key] = value
        # result = dict({(key, value) for key, value in self.iteritems()
        #                if re.match(matchString, key)})

        if result == {}:
            return None
        else:
            return result
    # end search_keys

    def __getitem__(self, pos):
        """
        When the dictionary retrieves a key, it will take the passed pos and
        use regex to search for a key. If the passed pos is a
        tuple/list/iterable, the structure assumes that the first index is the
        key and the second is expected type

        Args:
            pos (str or tuple): The value to parse in and used to retrieve
                                dictionary keys

        Returns:
            any: Gets back whatever the matched key's item(s) are
        """
        queryType = ""
        if len(pos) == 2:
            key, queryType = pos
        else:
            key = pos[0]

        if re.match(self.regexMethod, key):
            if queryType != "":
                return ' '.join([self.type(queryType),
                                 key,
                                 super(LoggerDictBase, self).__getitem__(key)])
            else:
                return ' '.join([key,
                                 super(LoggerDictBase, self).__getitem__(key)])
        else:
            return None
    # end __getitem__
# LoggerDictBase


if __name__ == "__main__":
    print(__doc__)
