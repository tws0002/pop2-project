#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Gets html text from my website and autocreates changelog information from it
"""

# IMPORT STANDARD LIBRARIES
import urllib2
import re
import os  # :AUTHORNOTE: When you create a proper test module, remove this
import getpass  # :AUTHORNOTE: When you create a proper test module, remove this

# IMPORT THIRD-PARTY LIBRARIES
from BeautifulSoup import BeautifulSoup

# IMPORT LOCAL LIBRARIES
import constants.model.constants as consts
from fileio.controller import omnibus

# class ChangelogHTML(BeautifulSoup):
#     def __init__(self, html):
#         self._sections = ['MAYA', 'NUKE', 'HOUDINI', 'ALL']
#     # end __init__
#
#     def get_section_info(self, section):
#         if section.upper() not in self._sections:
#             print("Section: {} not in section list, {}".format(section,
#                                                                self._sections))
#             sys.exit()
#         # data = self.body.find('div', attrs={'class':'section', 'id': section})
#         data = self
#         data = type(self)
#         print self.body
#         for x in dir(self):
#             print x
#         return data
#     # end get_section_info
#
#     def __repr__(self):
#         return "<{module}.{name}(sections={section}) object "\
#                "at {hexI}>".format(module=self.__class__.__module__,
#                                    name=self.__class__.__name__,
#                                    section=self._sections,
#                                    hexI=hex(id(self)))
#     # end __repr__
#
#     def __str__(self):
#         return self.html
# # end ChangelogHTML


def prep_html():
    """
    Changes the HTML to make it more readable before it gets passed to
    BeautifulSoup

    .. note::
     only really applies to reading HTML as files (will not make a difference
     if calling directly from the internet)

    Returns:
        str: The entire HTML page
    """
    username = getpass.getuser()
    filename = os.path.join('/home', username, "Dropbox", "Private",
                            "my_PROJECT", "proj_POP2", "Pipeline",
                            "the_LATEST", "latest_DOCS", "sphinx_test_0001",
                            ".build", "html", "changelog.html")
    with open(filename, 'r') as f:
        data = f.readlines()

    data = [x for x in data if x.strip() != ""]
    toString = ''.join(data)
    html = toString
    return html
# end prep_html


def get_changelog():
    """
    Get the changelog from the Internet via urllib2 and BeautifulSoup. Parse
    the page such that the changelog returns a well-structured dict

    Args:
        None (NoneType): Takes no arguments

	Returns:
        dict: A dictionary which represents the changelog information,
              organized by date
    """
    sections = ["All", "Houdini", "Maya", "Nuke"]
    # html = #the HTML code you've written above
    # html = prep_html()
    url = consts.CHANGELOG_URL
    # soup = BeautifulSoup(html)
    # Reference: https://stackoverflow.com/questions/728296
    urlOpen = urllib2.urlopen(url)
    # soup = BeautifulSoup(urllib2.urlopen(URL), convertEntites=BeautifulSoup.ALL_ENTITIES)
    soup = BeautifulSoup(urlOpen)
    reMatch = r"^Date: (?P<yr>\d{4})-(?P<month>\d{2})-(?P<day>\d{2})"\
               "\ (?P<hr>\d{2}):(?P<min>\d{2}):(?P<sec>\d{2})$"
    allDates = soup.body.findAll('h2', text=re.compile(reMatch))
    changelogNotes = {}
    for dateLog in allDates:
        formatDate = re.match(reMatch, dateLog)
        findAtDate = "date-{yr}-{month}-{day}-{hr}-{min}-"\
                     "{sec}".format(yr=formatDate.group('yr'),
                                    month=formatDate.group('month'),
                                    day=formatDate.group('day'),
                                    hr=formatDate.group('hr'),
                                    min=formatDate.group('min'),
                                    sec=formatDate.group('sec'))

        savedDDate = "{yr}-{month}-{day} {hr}:{min}:"\
                     "{sec}".format(yr=formatDate.group('yr'),
                                    month=formatDate.group('month'),
                                    day=formatDate.group('day'),
                                    hr=formatDate.group('hr'),
                                    min=formatDate.group('min'),
                                    sec=formatDate.group('sec'))
        dateHeader = soup.body.find('div', attrs={'class': 'section',
                                                  'id': findAtDate})
        changelogNotes[savedDDate] = changelogNotes.get(savedDDate, {})
        for section in sections:
            changelogNotes[savedDDate].update({section: []})  # add section to date
            # get section information
            sectionsData = dateHeader.findAll('div', attrs={'class': 'section'})

            for sectionData in sectionsData:
                if sectionData.text.encode('ascii', 'ignore').startswith(section):
                    unorderedList = sectionData.find('ul', attrs={'class': 'simple'})
                    ulChildren = unorderedList.findChildren('li')
                    ulChildren = [x.text for x in ulChildren]
                    if ulChildren is not None:
                        changelogNotes[savedDDate][section] += ulChildren
    changelogNotes = omnibus.convert(changelogNotes)  # convert unicode to str
    return changelogNotes
# end get_changelog


if __name__ == "__main__":
    print(__doc__)
    # get_changelog()
