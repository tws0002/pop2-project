#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
This module is meant to handle sequences of files. Applications have
their own notation for handling sequences and each will get its own functions.
"""

# IMPORT STANDARD LIBRARIES
import os
import re
import ntpath


# EXAMPLE_STRING_0001 = "/some/path/foo_{}.bar"
# EXAMPLE_STRING_0002 = "/some/path/foo.{}.bar"
# EXAMPLE_STRING_0003 = r"C:\some\path\foo_{}.bar"
# EXAMPLE_STRING_0004 = r"C:\some\path\foo.{}.bar"
# EXAMPLE_STRING_0005 = r"C:\\some\\path\\foo.{}.bar"
# EXAMPLE_STRING_0005 = r"C:\\some\\path\\foo_{}.bar"
# EXAMPLE_STRING_0006 = r"C:/some\path\\foo.{}.bar"
# EXAMPLE_STRING_0007 = r"C:/some\path\\foo_{}.bar"
# EXAMPLE_STRING_0008 = r"C:\some\path\\foo.{}.bar"
# EXAMPLE_STRING_0009 = r"C:\some\path\\foo_{}.bar"
# EXAMPLE_STRING_0010 = r"C:/some/path\foo.{}.bar"
# EXAMPLE_STRING_0011 = r"C:/some/path\foo_{}.bar"
# EXAMPLE_STRING_0001 = "/some/path/{}_foo.bar"
# EXAMPLE_STRING_0002 = "/some/path/{}.foo.bar"
# EXAMPLE_STRING_0003 = r"C:\some\path\{}_foo.bar"
# EXAMPLE_STRING_0004 = r"C:\some\path\{}.foo.bar"
# EXAMPLE_STRING_0005 = r"C:\\some\\path\\{}.foo.bar"
# EXAMPLE_STRING_0005 = r"C:\\some\\path\\{}_foo.bar"
# EXAMPLE_STRING_0006 = r"C:/some\path\\{}.foo.bar"
# EXAMPLE_STRING_0007 = r"C:/some\path\\{}_foo.bar"
# EXAMPLE_STRING_0008 = r"C:\some\path\\{}.foo.bar"
# EXAMPLE_STRING_0009 = r"C:\some\path\\{}_foo.bar"
# EXAMPLE_STRING_0010 = r"C:/some/path\{}.foo.bar"
# EXAMPLE_STRING_0001 = "/some/path/foo_{}_asdf_.bar"
# EXAMPLE_STRING_0002 = "/some/path/foo.{}_asdf.bar"
# EXAMPLE_STRING_0003 = r"C:\some\path\foo_{}_asdf_.bar"
# EXAMPLE_STRING_0004 = r"C:\some\path\foo.{}_asdf.bar"
# EXAMPLE_STRING_0005 = r"C:\\some\\path\\foo.{}_asdf.bar"
# EXAMPLE_STRING_0005 = r"C:\\some\\path\\foo_{}_asdf_.bar"
# EXAMPLE_STRING_0006 = r"C:/some\path\\foo.{}_asdf.bar"
# EXAMPLE_STRING_0007 = r"C:/some\path\\foo_{}_asdf_.bar"
# EXAMPLE_STRING_0008 = r"C:\some\path\\foo.{}_asdf.bar"
# EXAMPLE_STRING_0009 = r"C:\some\path\\foo_{}_asdf_.bar"
# EXAMPLE_STRING_0010 = r"C:/some/path\foo.{}_asdf.bar"
# EXAMPLE_STRING_0012 = "{}"

# POSSIBLE_PARSE_CASES = ['#', '##', '###', '####', '$F1', '$F2', '$F3', '$F4',
#                         '%04d', '%03d', '%02d', '%01d']

# FILENAME_LIST = [EXAMPLE_STRING_0001, EXAMPLE_STRING_0002,
#                  EXAMPLE_STRING_0003, EXAMPLE_STRING_0004,
#                  EXAMPLE_STRING_0005, EXAMPLE_STRING_0006,
#                  EXAMPLE_STRING_0007, EXAMPLE_STRING_0008]

MATCH_SEQENCE_PARSE_G = re.compile(r"""
                                    (?:[\w|\.]?)+(\#+)(?:[\w|\.]?)+        # ####
                                  | (?:[\w|\.]?)+\$[F|f](\d+)(?:[\w|\.]?)+  # $F4
                                  | (?:[\w|\.]?)+\%[0](\d+)d(?:[\w|\.]?)+   # %04d
                                    """, re.VERBOSE)

MATCH_SEQENCE_NAME_G = re.compile(r"""
                                   ([\w|\.]+)?(\#+)(\w+)?              # #### name
                                 | ([\w|\.]+)?\$[F|f](\d+)([\w|\.]+)?  # $F4 name
                                 | ([\w|\.]+)?\%[0](\d+)d([\w|\.]+)?   # %04d name
                                   """, re.VERBOSE)


# def path_leaf(path):
#     head, tail = ntpath.split(path)
#     return tail or ntpath.basename(head)
# # end path_leaf


def sequence_match(filename, reMatch=None):
    """
    This will determine if it has a sequential range inside of it

    Args:
        filename (str): The filename that or may not have a sequential range
                        inside of it
        reMatch (<_sre.Pattern>): A compiled regex pattern to use for
                                  determining a sequential range

    Returns:
        list: A list which represents the file's capture groups, but with
              increments and numbers casted from str to int
        within a file with a sequential range.

        .. Note::
            I'm pretty sure that this function actually doesn't support number
            padding (####) but it definitely will work with TCL/Houdini-Style
            number expressions
    """
    if reMatch is None:
        reMatch = MATCH_SEQENCE_PARSE_G

    match = re.match(reMatch, str(filename))
    if match is None:
        return match
    else:
        output = list(x for x in match.groups() if x is not None)
        for i, x in enumerate(output):
            try:
                x = int(x)
                output[i] = x
            except ValueError:
                pass
            except TypeError:
                raise
        return output
# end sequence_match


def get_padding(filename, reMatch=None):
    """
    Gets the padding of a file name, presuming that it has one

    Args:
        filename (str): The filename whose increment padding will be queried
        reMatch (<_sre.Pattern>): The compiled regex which gets the
                                  number/padding

    Returns:
        int or None: Returns the padding or None, if there is no padding match
    """
    if reMatch is None:
        reMatch = MATCH_SEQENCE_PARSE_G

    match = sequence_match(filename, reMatch)
    if match is None:
        return None

    match = match[0]
    try:
        padding = int(match)
    except ValueError:
        if "#" in match:
            padding = len(match)
    except TypeError:
        raise

    return padding
# end get_padding


def expand_sequence(filename, reMatch=None, mustExist=False, zeroPadding=0):
    """
    Takes a string to a file path, a file that has a sequential range, and
    gets back a generator  which contains every possible file combination,
    ending with the last index in its designated padding (padding 4=1000 files,
    starting from 0 and ending at 999)

    See :ref:`paths` for an example of the function in use

    Args:
        filename (str): The filename with a sequential range to expand
        reMatch (<_sre.Pattern>): The regex capture group which is used to
                                  initially parse the file string for a
                                  sequential range
        mustExist (bool): If enabled, a string filename will only be returned
                          if the file/folder actually exists. (Pass in full
                          paths to make use of this functionality)
        zeroPadding (int): The number padding for the given sequence

    Yields:
        str: An iterable of strings that represent every file that could
                   or does exist from a given sequential range string
    """
    if reMatch is None:
        reMatch = MATCH_SEQENCE_PARSE_G

    padding = get_padding(filename, reMatch)

    if padding is None:
        yield None

    if padding is not None:
        matchName = sequence_match(filename, reMatch=MATCH_SEQENCE_NAME_G)
        if padding == 1:
            num = 10
        else:
            num = pow(10,  padding - 1)
        for i in xrange(num):
            matchNameRevised = []
            for m in matchName:
                if sequence_match(m, reMatch=MATCH_SEQENCE_PARSE_G) is not None\
                        or isinstance(m, int):
                    matchNameRevised.append(str(i).zfill(padding +
                                                         zeroPadding))
                else:
                    matchNameRevised.append(m)

            outputFileName = ''.join(matchNameRevised)
            if mustExist and not os.path.isfile(outputFileName)  \
                         and not os.path.isdir(outputFileName):
                continue
            yield outputFileName
# end expand_sequence


# def main():
#     fileNameList = FILENAME_LIST

#     fileList = []
#     for p in FILENAME_LIST:
#         for f in POSSIBLE_PARSE_CASES:
#             fileList.append(p.format(f))

#     for f in fileList:
#         filename = path_leaf(f)
#         fileNameBase, fileNameExt = os.path.splitext(filename)
#         seq = expand_sequence(fileNameBase)
#         print list(seq)
# # end main


# def main_0001():
#     seq = expand_sequence("foo_####")
#     print list(seq)
# # end main_0001


# # MATCH_SEQENCE_NAME_G = re.compile(r"(\w+)")
# def main_001():
#     string = "foo_#_ASDASD"
#     reMatch = MATCH_SEQENCE_NAME_G
#     match = re.match(reMatch, string)
#     print match.group()
#     print match
#     print match.groups()
# # end main_0001


# def main_houdini_0001():
#     string = "foo_$F10"
#     string1 = "foo_$F4"
#     string2 = "foo_$F4_asdfasd"
#     listH = [string, string1, string2]
#     for f in listH:
#         MATCH_SEQENCE_PARSE_G = re.compile(r"(?:\w?)+(#+)(?:\w?)+")
#         reMatch = re.compile(r"(?:\w?)+\$[F|f](\d+)(?:\w?)+")
#         match = re.match(reMatch, f)
#         print match
#         print match.group()
#         print match.groups()
# # end main_houdini_0001


# def test_dots():
#     string1 = "foo1.##_asdsf"
#     string1 = "asdf.###_asdfasdf"
#     stringMatch = r"^(?:\w?)+(\#+)(?:\w?)+$"
#     stringMatch = r"^(?:[\w|\.]?)+(\#+)(?:[\w|\.]?)+$"
#     reMatch = re.compile(stringMatch)
#     match = re.match(reMatch, string1)
#     print match
#     print match.group()
#     print match.groups()

#     string1 = "foo1.##_asdsf"
#     string1 = "asdf.$F4.asdfasdf"
#     stringMatch = "(?:[\w|\.]?)+\$[F|f](\d+)(?:[\w|\.]?)+"
#     reMatch = re.compile(stringMatch)
#     match = re.match(reMatch, string1)
#     print match
#     print match.group()
#     print match.groups()

#     string1 = "foo1.##_asdsf"
#     string1 = "asdf.%08d.asdfasdf"
#     stringMatch = "(?:[\w|\.]?)+\%[0](\d+)d(?:[\w|\.]?)+"
#     reMatch = re.compile(stringMatch)
#     match = re.match(reMatch, string1)
#     print match
#     print match.group()
#     print match.groups()
# # end test_dots


if __name__ == "__main__":
    # main()
    print(__doc__)
