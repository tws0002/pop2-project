# IMPORT STANDARD LIBRARIES
import os
import re
import json

LOGGER_MESSAGE_PATH = os.path.join(os.environ["POP2_PROJECT_DIR"],
                                   "Pipeline",
                                   "my_MESSAGES",
                                   "mess_CODES",
                                   "traceback_debug_codes_0002.json")

with open(LOGGER_MESSAGE_PATH) as f:
    LOGGER_MESSAGE_CONFIG = f.read()

LOGGER_MESSAGE_CONFIG = json.loads(LOGGER_MESSAGE_CONFIG)

# key search terms
# LOGGER_KEY = r'[A-Z]{3}[0-9]{4}[A-Z]'
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

def main_0001():
    dict_h = {}
    dict_h["New"] = "asdfasdfasdf"
    print dict_h["New"]
    dictNew = CustomDict()

    dictNew['New'] = "WOo"
    print dictNew['New']
# end main_0001

def main():
    dictNew = CustomDict(RE_LOGGER_KEY_MATCH, LOGGER_MESSAGE_CONFIG)

    print dictNew['AIE3000', "Match_True"].format(name="Joe")

    """

    logKey = 'MYA'
    print dictNew.search_keys(logKey)
    # print dictNew['AIE3000']
    """
# end main

if __name__ == "__main__":
    main()














"""

    class matrix(dict):
        def __init__(self, regex, *initial_data, **kwargs):
            super(matrix, self).__init__()
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
            return self.get(self.matchFormat[query], default="")
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
            x,y = pos
            return "fetching %s, %s" % (x, y)

    m = matrix(RE_LOGGER_KEY_MATCH, LOGGER_MESSAGE_CONFIG)
    print m["AIE3000", 3]
    print m[1,2]



# Reference: http://stackoverflow.com/questions/4014621
class GenericDict():
    def __setitem__(self, key, item):
        self.__dict__[key] = item

    def __getitem__(self, key):
        return self.__dict__[key]

    def __repr__(self):
        return repr(self.__dict__)

    def __len__(self):
        return len(self.__dict__)

    def __delitem__(self, key):
        del self.__dict__[key]

    def clear(self):
        return self.__dict__.clear()

    def copy(self):
        return self.__dict__.copy()

    def has_key(self, k):
        return self.__dict__.has_key(k)

    def pop(self, k, d=None):
        return self.__dict__.pop(k, d)

    def update(self, *args, **kwargs):
        return self.__dict__.update(*args, **kwargs)

    def keys(self):
        return self.__dict__.keys()

    def values(self):
        return self.__dict__.values()

    def items(self):
        return self.__dict__.items()

    def pop(self, *args):
        return self.__dict__.pop(*args)

    def __cmp__(self, dict):
        return cmp(self.__dict__, dict)

    def __contains__(self, item):
        return item in self.__dict__

    def __iter__(self):
        return iter(self.__dict__)

    def __unicode__(self):
        return unicode(repr(self.__dict__))
"""
