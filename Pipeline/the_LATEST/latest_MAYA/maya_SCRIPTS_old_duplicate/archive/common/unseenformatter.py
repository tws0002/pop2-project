#!/bin/usr/python

"""
Example
>>> string = "{number_of_sheep} sheep {has} run away"
>>> other_dict = {'number_of_sheep' : 1}

>>> fmt = UnseenFormatter()
>>> print fmt.format(string, **other_dict)
"1 sheep has run away"
"""

# IMPORT STANDARD LIBRARIES
from string import Formatter

class UnseenFormatter(Formatter):
    def __init__(self):
        Formatter.__init__(self)
    # end __init__
    def get_value(self, key, args, kwds):
        if isinstance(key, str):
            try:
                return kwds[key]
            except KeyError:
                return key
        else:
            Formatter.get_value(key, args, kwds)
    # end get_value
# end UnseenFormatter

def main():
    string = "{number_of_sheep} sheep {has} run away"
    other_dict = {'number_of_sheep' : 1}

    fmt = UnseenFormatter()
    print fmt.format(string, **other_dict)
# end main

if __name__ == "__main__":
    print(__doc__)