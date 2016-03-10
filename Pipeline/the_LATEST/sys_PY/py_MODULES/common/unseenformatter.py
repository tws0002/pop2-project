#!/bin/usr/python

"""
This is a custom formatter that allows for string keys to be explicitly stated
and, if a key is missing that was contained in the str, instead of raising
a KeyError, the class simply prints the format key as a string in its place.

This is used to make logging and general string replacement a bit more flexible

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
