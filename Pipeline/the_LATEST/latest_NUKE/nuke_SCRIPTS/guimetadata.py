#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Initializes a nuke node which contains
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import struct  # for determining whether python is x32/x64 in 2.x or 3.x python
from pysix import six

# IMPORT THIRD-PARTY LIBRARIES
import nuke

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts

class NukeMetadata(object):
    def __init__(self):
        super(NukeMetadata, self).__init__()
        # Config
        self.projectMsg = ""
        self.projectSubtitle = "Are you happy now, Tyler?"
        self.nodeName = "POP2" + "Metadata"
        self.fontSize = 70
        self.bgColor = (1,1,1)

        # Create with initial config and set parameters
        self.nodeType = nuke.nodes.BackdropNode
        self.nodeObj = nuke.toNode(self.nodeName)
        if self.nodeObj is None:
            self.nodeObj = self.nodeType()
            self.set_node_knobs()
            lines = self.nodeObj["label"].value().split('\n')
            height = self.nodeObj['note_font_size'].value() * len(lines) * 3
            width = height * 0.9
            self.nodeObj.knob("bdwidth").setValue(width)
            self.nodeObj.knob("bdheight").setValue(height)
    # end __init__

    def display_icon(self, value):
        """
        """
        iconPath = '<img src="{value}">'.format(value=value)
        return iconPath
    # end display_icon

    def project_msg_default_header(self):
        """
        - get number of days without accident  # ::TO DO::
        """
        msgOutput = '<pre><center>'
        msgOutput += self.display_icon(os.path.join(os.environ['PIPELINE_DIR'], 
                                       'latest_MESSAGES',
                                       'mess_ICONS',
                                       'project_logo_work_file_0001_medium.png'))

        msgOutput += '\nProject: "{proj}"\n"Subtitle: {subtitle}"\n'\
                     'Version: {version}'.format(proj=consts.PROJECT_NAME_LONG,
                                         subtitle=self.projectSubtitle,
                                         version=consts.__version__)
        
        msgOutput += '\n<pre style="background-color: gray;">Crew List {}</pre>'.format('\n' + '\n'.join(self.get_crew_from_crewsheet("TITLE", "Composit")))
        msgOutput += '\nShot Notes:\n'
        if consts.USERNAME in consts.REGISTERED_ADMINS:
            msgOutput += "\nPython Version\n" + str(sys.version_info) + \
                         ' x{}bit'.format(8 * struct.calcsize("P"))
            # msgOutput += "\nNuke plugin path" + str(nuke.pluginPath())
            # msgOutput += "\nPATH Env Var" + os.environ.get('PATH', '')
        
        msgOutput += '\n</pre>'
        msgOutput += '\n<div style="background-color: orange; align: left;">'
        
        self.projectMsg = msgOutput
        return self.projectMsg
    # end project_msg_default_header

    def get_crew_from_crewsheet(self, key, value):
        """
        Gets crew (mainly compositors) from the crew sheet that's sourced
        in the constants folder
        """
        return list(get_crew_by_key(key, value))
    # end get_crew_from_crewsheet

    def set_node_knobs(self):
        """
        Convenience function for setting the knobs on the node in question

        - set color of node
        - set font to self.fontSize
        - set label to self.project_msg_default_header
        """
        bgColor = rgb_to_6_digit_hex(self.bgColor)
        bgColor = hex_to_color_chip(bgColor)
        self.nodeObj['tile_color'].setValue(bgColor)
        self.nodeObj['note_font_size'].setValue(self.fontSize)
        self.nodeObj['label'].setValue(self.project_msg_default_header())
    # end set_node_knobs
# end NukeMetadata


def rgb_to_6_digit_hex(rgb, as255=True):
    """
    Converts array of 3 indices that represent rgb values 
    into a 6 digit hex. (255, 255, 255) --> #ffffff
    """
    if len(rgb) != 3:
        return None

    multiplier = 1
    if as255:
        multiplier = 255
    if rgb[0]*multiplier > 255 or rgb[1]*multiplier > 255 \
        or rgb[2]*multiplier > 255:
        return None

    return '%02x%02x%02x' % (rgb[0]*multiplier, rgb[1]*multiplier, rgb[2]*multiplier)
# end rgb_to_6_digit_hex


def hex_to_color_chip(hex, allow6DigitHex=True):
    """
    Changes a 8 or 6 digit hex value to a nuke-friendly color-chip
    """
    if not isinstance(hex, six.string_types):
        return None

    if len(hex) != 6 and len(hex) != 8:
        return None
    if len(hex) == 6 and allow6DigitHex:
        hex += "ff"  # adds a transparency of 100%
    elif len(hex) == 6 and not allow6DigitHex:
        return None

    return int(hex, 16)
# end hex_8_digit_to_color_chip


def get_crew_by_key(keySearch, crewSearch):
    """
    Gets information about the crew on the top level using key 
    and item search parms
    """
    dictH = consts.CREW_SHEET_INFO
    print dictH
    for key, items in dictH.iteritems():
        if keySearch in items and crewSearch.upper() in items[keySearch].upper():
            yield items['USERFULLNAME']
# end get_crew_by_key


def nuke_metadata_init():
    """
    Adds a node within the Nuke GUI that represents metadata about the scene,
    as well as serves as a place to send messages to people on the project
    """
    nukeMetadataObj = NukeMetadata()
# end nuke_metadata_init


def main():
    asfd = list(get_crew_by_key("TITLE", "Composit"))
# end main


if __name__ == "__main__":
    # print(__doc__)
    nuke_metadata_init()
    # print main()
