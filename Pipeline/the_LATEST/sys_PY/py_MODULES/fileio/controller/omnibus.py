#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Mixture of methods for dealing with executables and complex data-types. I
couldn't think of a better name to represent this file because it's somewhat
misc.
"""

# IMPORT STANDARD LIBRARIES
import os
import stat
import collections

def convert(data):
    """
    Lightweight convenience function to read in JSON (unicode) info as strings

    Args:
        data (dict): The dictionary that contains unicode data to convert

    Returns:
        str: A dictionary with converted strings
    """
    if isinstance(data, basestring):
        return str(data)
    elif isinstance(data, collections.Mapping):
        return dict(map(convert, data.iteritems()))
    elif isinstance(data, collections.Iterable):
        return type(data)(map(convert, data))
    else:
        return data
# end convert

def which(program):
    """
    Portable equivalent to UNIX "which" command but works in Windows and Linux,
    unlike distutils.spawn.find_executable, which is limited only to .exes on
    Windows

    .. AUTHORNOTE::
     Consider moving to a separate module
     This function operates beyond the scope of the module.
     Also, depending on its consistency in the production, consider using
     is_executable instead of is_exe

    Args:
        program (str): Absolute path to an executable file

    Returns:
        str or NoneType: Returns the full path to an executable, even if that
                         file was sourced over PATH
    """
    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file
    return None
# end which


def is_executable(filename):
	"""
    Tests if the given input file is executable

    .. AUTHORNOTE::
     Consider moving to a separate module
     This function operates beyond the scope of the module

    Args:
        filename (str): A full path to a file to query

    Returns:
        bool: True/False
    """
	if stat.S_IXUSR & os.stat(filename)[stat.ST_MODE]:
		return True
	return False
# end is_executable


def nested_dict_return(dictH, keys):
    """
    Queries values in a nested dictionary using a series of keys that are in
    the form of a list of strings

    Args:
        dictH (dict): The dictionary to query key-values
        keys (iterable): The iterable of strings to query as keys

    Returns:
        any:  The dictionary value of the last known key in the list of keys.
              If the function sends a KeyError before the end of the list, the
              most recent value of the last known key is returned
    """
    index = 0
    output = dictH
    while index < len(keys):
        try:
            output = output[keys[index]]
        except KeyError:
            break
        index += 1
    return output
# end nested_dict_return


# dictH = {
#     "korinkite":
#     {
#         "USERNAME": "korinkite",
#         "USERFULLNAME": "Colin Kennedy",
#         "PHONENUMBER": [
#             203,
#             722,
#             6620
#         ],
#         "EMAIL": "colinvfx@gmail.com"
#     },
#     "ckenne24":
#     {
#         "USERNAME": "ckenne24",
#         "USERFULLNAME": "Colin Kennedy",
#         "PHONENUMBER": [
#             203,
#             722,
#             6620
#         ],
#         "EMAIL": "colinvfx@gmail.com"
#     },
#     "danger20" :
#     {
#         "USERNAME": "danger20",
#         "USERFULLNAME": "David Anger",
#         "PHONENUMBER": [
#             "some",
#             "number",
#             "here"
#         ],
#         "EMAIL": "asdf@gmail.com",
#         "BLACKLIST":
#         {
#             "PLUGINS":
#             {
#                 "NUKE": ["tabtabtab"]
#             }
#         }
#     }
# }

# import json
# filePath = r"/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/latest_CONFIG/conf_INFO/crew_sheet.json"
# with open(filePath, 'r') as f:
#     crewdata = json.load(f)
# CREW_MEMBER_INFO = crewdata['danger20']


# nestedkeys = ['danger20', 'BLACKLIST', 'PLUGINS', 'NUKE']
# print nested_dict_return(dictH, nestedkeys)

if __name__ == "_main__":
    print(__doc__)
