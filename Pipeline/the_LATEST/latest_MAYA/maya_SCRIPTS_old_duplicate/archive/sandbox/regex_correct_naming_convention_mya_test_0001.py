import os
import re

from constants.model import constants as consts
from constants.model.constants import LOGGER
from pprint import pprint

def main_0004():
    matchMA = r'^s(\d{3})_([a-zA-Z_]+?).(0\d{3}$)'
    filename = 's001_someText_asdfasdf.0001'

    RE_FILENAME_MATCH_MA = re.compile(matchMA)

    print re.match(RE_FILENAME_MATCH_MA, filename).groups()
# end main_0004

def main_0003():
    matchMA = r'^s(\d{3})_([a-zA-Z_]+?).(0\d{3}$)'
    filename = 's001_someText_asdfasdf_SFD.0001'

    RE_FILENAME_MATCH_MA = re.compile(matchMA)

    print re.match(RE_FILENAME_MATCH_MA, filename).groups()
# end main_0003

def main_0002():
    # matchMA = r'^s\d{3}_[a-zA-Z]+.0\d{3}$'
    matchMA = r'^s\d{3}_a-zA-Z_+*.0\d{3}$'
    filename = 's001_someText.0001'
    RE_FILENAME_MATCH_MA = re.compile(matchMA)

    print re.match(RE_FILENAME_MATCH_MA, filename).group()

def main_0001():
    # matchMA = r's(\d{3})_([\x00-\x7F]{6}\d{2})_(\d{3})_([a-zA-Z]+).(0\d{3}).([mb|MB]+)'
    matchMA = r's(\d{3})_([\x00-\x7F]{6}\d{2})_(\d{3})_([a-zA-Z]+).(0\d{3}).([mb|MB]+)'
    # matchMA = r's(\d{3})_([\x00-\x7F]{6}\d{2})_(\d{3})_([a-zA-Z]+).(0\d{3}).([mb|MB]+)'
    RE_FILENAME_MATCH_MA = re.compile(matchMA)

    print re.match(RE_FILENAME_MATCH_MA, filename).groups()

main_0004()