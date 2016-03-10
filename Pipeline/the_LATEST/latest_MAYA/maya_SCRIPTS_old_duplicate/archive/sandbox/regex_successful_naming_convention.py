import re

SHOT = r's\d{3}'
USER = r'[\x00-\x7F]{6}\d{2}'
VERSION = r'\d{3}'
DESCRIPTION = r'[a-zA-Z]+'
INCREMENT = r'\d{4}'
FILETYPE = r'[a-zA-Z]+'
FULL_INPUT = r'(' + SHOT + r')' + r'_' + \
             r'(' + USER + r')' + r'_' + \
             r'(' + VERSION + r')' + r'_' + \
             r'(' + DESCRIPTION + r')' + r'.' + \
             r'(' + INCREMENT + r')' + r'.' + \
             r'(' + FILETYPE + r')'
RE_FILENAME_MATCH = re.compile(FULL_INPUT)
STRING = "s001_ckenne24_010_someDescription.0001.ma"


print re.match(RE_FILENAME_MATCH, STRING).groups()
