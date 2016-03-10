# IMPORT STANDARD LIBRARIES
import os
import re
import json

"""\
..Project::
 Portal Origins: Part Two
..Description::
 A generic class that will be inherited by the main logger class. 
 Makes the logger replicate dictionary-type operations.
 This module is NOT meant to be read directly
..Author::
 Colin Kennedy
"""

LOGGER_MESSAGE_PATH = os.path.join(os.environ["POP2_PROJECT_DIR"],
                                   "Pipeline",
                                   "the_LATEST",
                                   "latest_MESSAGES",
                                   "mess_CODES",
                                   "traceback_debug_codes_0002.json")

with open(LOGGER_MESSAGE_PATH) as f:
    LOGGER_MESSAGE_CONFIG = f.read()

LOGGER_MESSAGE_CONFIG = json.loads(LOGGER_MESSAGE_CONFIG)

# key search terms
LOGGER_KEY = r'^[A-Z]{3}\d{4}[A-Z]?'
RE_LOGGER_KEY_MATCH = re.compile(LOGGER_KEY)

class LoggerDictBase(dict):
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
        # return self.get(self.matchFormat[query], "")
        return self.matchFormat.get(query, "")
    # end type
    def search_keys(self, matchString):
        result = dict({(key, value) for key, value in self.iteritems()
                       if re.match(matchString, key)})

        if result == {}:
            return None
        else:
            return result
    # end search_keys
    def __getitem__(self, pos):
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

if __name__ == "__main__":
    print(__doc__)