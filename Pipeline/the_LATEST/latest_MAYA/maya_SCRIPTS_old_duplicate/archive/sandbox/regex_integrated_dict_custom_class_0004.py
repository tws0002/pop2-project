# IMPORT STANDARD LIBRARIES
import os
import re
import json

# IMPORT THIRD PARTY LIBRARIES
from logger.common import config
# from logger.common.configManager import ConfigManager
# from logger.common.helpers import hmsAsStrToS, hmsToS, sToHms, sToHmsAsStr
from logger.common.loggingServices_0002 import Logger
# from logger.plugins.pluginsManager  import PluginsManager
# from logger.controller.abstractController import AbstractModalDialogController
# from logger.view.messageDialog import WarningMessageDialog

os.environ["POP2_PROJECT_DIR"] = "/home/ckenne24/mount/collaborative/portal-origins-part-2"

LOGGER_MESSAGE_PATH = os.path.join(os.environ["POP2_PROJECT_DIR"],
                                   "Pipeline",
                                   "my_MESSAGES",
                                   "mess_CODES",
                                   "traceback_debug_codes_0002.json")

with open(LOGGER_MESSAGE_PATH) as f:
    LOGGER_MESSAGE_CONFIG = f.read()

LOGGER_MESSAGE_CONFIG = json.loads(LOGGER_MESSAGE_CONFIG)

# key search terms
LOGGER_KEY = r'^[A-Z]{3}\d{4}[A-Z]?'
RE_LOGGER_KEY_MATCH = re.compile(LOGGER_KEY)

class CustomDict(dict):
    def __init__(self, regex, *initial_data, **kwargs):
        super(CustomDict, self).__init__()
        self.regexMethod = regex
        self.matchFormat = {'Match_True': '[+]',
                            'Match_False': '[-]',
                            'Except': '[|]'}

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
        key, queryType = pos
        if re.match(self.regexMethod, key):
            if self.type(queryType) != "":
                return ' '.join([self.type(queryType),
                                 key,
                                 super(CustomDict, self).__getitem__(key)])
            else:
                return ' '.join([key,
                                 super(CustomDict, self).__getitem__(key)])
        else:
            return None
    # end __getitem__

if __name__ == "__main__":
    string_thing = 'ConfigController.__onCameraOrientationComboBoxCurrent'\
                   'IndexChanged(): orientation='
    Logger().debug(string_thing)