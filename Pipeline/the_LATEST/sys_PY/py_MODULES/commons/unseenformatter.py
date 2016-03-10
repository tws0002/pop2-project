#!/bin/usr/python

"""
This is a custom formatter that allows for string keys to be explicitly stated
and, if a key is missing that was contained in the str, instead of raising
a KeyError, the class simply prints the format key as a string in its place.

This is used to make logging and general string replacement a bit more flexible

Examples:
 see :ref:`logger.common.loggingServices`

Usage:
 >>> string = "{number_of_sheep} sheep {has} run away"
 >>> other_dict = {'number_of_sheep' : 1}
 >>> fmt = UnseenFormatter()
 >>> print fmt.format(string, **other_dict)
 "1 sheep has run away"
"""

# IMPORT STANDARD LIBRARIES
from string import Formatter

class UnseenFormatter(Formatter):
    """
    This is a custom formatter that allows for string keys to be explicitly stated
    and, if a key is missing that was contained in the str, instead of raising
    a KeyError, the class simply prints the format key as a string in its place.
    """
    def __init__(self):
        """
        Inits the startup method for Python's default Formatter class
        """
        Formatter.__init__(self)
    # end __init__

    def get_value(self, key, args, kwds):
        """
        When values are being swapped in a formatted string, if an exact match,
        the key is replaced by the value provided. If no values exist for a
        given key, simply return the variable name as its value

        Args:
            key (str or other): The expected name for the key in the formatted string
            args (any): The args to put in place of key
            kwds (iterable): key/value pairs

        Returns:
            str: The format-replaced string with all of the keys replaced
        """
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
    """
    Test module for UnseenFormatter
    """
    string = "{number_of_sheep} sheep {has} run away"
    other_dict = {'number_of_sheep' : 1}

    fmt = UnseenFormatter()
    print fmt.format(string, **other_dict)
# end main

if __name__ == "__main__":
    print(__doc__)
