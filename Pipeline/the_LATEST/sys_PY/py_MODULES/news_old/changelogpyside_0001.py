#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
.. module:: changelog
 :synopsis: Creates a changelog with pyqt/pyside as its display

@author: Colin Kennedy
@copyright: (C) 2016 Colin Kennedy
@license: MIT
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import glob
import re
import time
import json
import collections

# IMPORT THIRD-PARTY LIBRARIES
from PySide import QtCore
from PySide import QtGui

# IMPORT LOCAL LIBRARIES
from constants.model import constants as consts
import controller.htmlparser as htmlparser
import view.changeLogDialogPySide as basePySide
import view.changeLogOKPySide as okPySide


CHANGELOG_KEY = "CHANGELOG_DISPLAY_ON_STARTUP"


class Window(QtGui.QMainWindow, basePySide.Ui_Dialog):
    """ Main window"""
    def __init__(self, parent=None):
        """
        Inits the GUI with application-specific information and connects up
        the OK/Cancel buttons to thier respective methods
        """
        # super(Window, self).__init__(parent=parent)
        super(Window, self).__init__(parent)
        self.setupUi(self)
        self.init_ui()
        applicationType = ""
        self.applicationType = applicationType

        # triggers
        self.ok_pb.clicked.connect(self.ok_trigger)
        self.cancel_pb.clicked.connect(self.cancel_trigger)
    # end __init__

    def init_ui(self):
        """
        Init the GUI and its project-specific information

        Creates a tab widget in the center of the QMainWindow grid and
        populates it information from the project's changelog URL. A tab is
        added for each update and its contents are automatically populated

        .. TODO::
         Clean this function up. It's overly verbose and could use classes
        """
        # customize GUI
        self.ok_pb.setText("Colin, I love you!")
        self.cancel_pb.setText("Okay, got it")
        self.okWindow = OKWindow()

        # init changelog information
        # make a tab for each date recorded
        #
        changelog = Changelog()
        self.tabWidget = QtGui.QTabWidget(self.centralwidget)

        # Reorder the dict from most recent to least
        htmlDict = htmlparser.get_changelog()
        htmlDict = collections.OrderedDict(sorted(htmlDict.items(),
                                          key=lambda t: t[0]))
        htmlDict = htmlDict.items()
        htmlDict.reverse()
        htmlDict = collections.OrderedDict(htmlDict)

        # set the sections to upper to simplify testing
        sectionGlobal = [x.upper() for x in changelog.sectionGlob]
        sectionList = [x.upper() for x in changelog.sectionList]
        for key, items in htmlDict.iteritems():
            label = QtGui.QLabel(self.tabWidget)
            label.setAlignment(QtCore.Qt.AlignLeading|QtCore.Qt.AlignLeft|QtCore.Qt.AlignTop)
            tabToAdd = QtGui.QWidget()
            gridLayout = QtGui.QGridLayout(tabToAdd)
            gridLayout.addWidget(label)
            text = ''
            for k, itms in htmlDict[key].iteritems():
                if (k.upper() in sectionGlobal or k.upper() in sectionList) \
                        and itms != []:
                    text += k + '\n'  # add the section name as text
                    itms = ['- ' + x for x in itms]
                    text += '\n'.join(itms)  # add each point as text
                    text += '\n\n'
                label.setText(text)
            tabIndex = self.tabWidget.addTab(tabToAdd, key)
            # add grid to the new tab page and place QLabel inside of it

        self.tabWidget.setCurrentIndex(0)
        # add tab widget to main
        self.gridLayout.addWidget(self.tabWidget, 1, 0, 1, 3)

        # change the all the text
        for f in self.findChildren(QtGui.QLabel):
            formText = str(f.text()).strip()
            if f.objectName() == "project_l":
                f.setText(formText.format(proj=consts.PROJECT_NAME_LONG))
            elif f.objectName() == "version_l":
                f.setText(formText.format(version=consts.__version__))
    # end init_ui

    def ok_trigger(self):
        """
        Runs when the user selects the "Ok" button from ok/cancel
        It will write changes to the crewsheet config file and also adds
        +1 love to every admin on the crewsheet (just for fun)
        """
        self.set_config()
        self.okWindow.setWindowTitle("+1 Love Acquired!")
        self.okWindow.exec_()

        QtCore.QCoreApplication.instance().quit()
    # end ok_trigger

    def cancel_trigger(self):
        """
        Runs when the user selects the "cancel" button from ok/cancel. It sets
        the configuration file over the network so that applications don't
        display the start-up message or changelog
        """
        self.set_config(False)
        self.closeEvent
        QtCore.QCoreApplication.instance().quit()
    # end cancel_trigger

    def add_love(self):
        """
        Adds to the admin love counter (just for fun). "Love" is added to
        every admin listed under consts.CREWSHEET
        """
        with open(consts.CREWSHEET, "r") as f:
            data = json.load(f)

        for admin in consts.REGISTERED_ADMINS:
            if admin in data:
                data[admin]['Love'] = data[admin].get("Love", 0) + 1

        with open(consts.CREWSHEET, "w") as f:
            data = json.dump(data, f, indent=4)
    # end add_love

    def set_config(self, ignoreAdmins=True):
        """
        Sets the current user's preference to display/hide changelog

        Admins are ignored in this operation by default because hiding the
        window wouldn't allow admins to troubleshoot if the function is broken.
        Given this, ignoreAdmins is True by default

        Args:
            ignoreAdmins (bool): If True, does not allow admins to change their
                                 config preferences

        Returns:
            bool: Based on whether or not setting the configuration
                  was successful
        """
        if consts.USERNAME in consts.REGISTERED_ADMINS and ignoreAdmins:
            return True  # do nothing

        with open(consts.CREWSHEET, "r") as f:
            data = json.load(f)

        hideUntilUpdate = self.hideUntilUpdate_cb.isChecked()

        if CHANGELOG_KEY in data[consts.USERNAME]:
            hideUntilUpdateConf = data[consts.USERNAME][CHANGELOG_KEY]
        else:
            hideUntilUpdateConf = False

        if hideUntilUpdateConf == hideUntilUpdate:
            # No change required
            return True

        data[consts.USERNAME][CHANGELOG_KEY] = hideUntilUpdate
        with open(consts.CREWSHEET, "w") as f:
            json.dump(data, f, indent=4)
        return True
    # end set_config
# end Window

class OKWindow(QtGui.QDialog, okPySide.Ui_Dialog):
    """
    Create a window that displays a brief message and then closes itself
    """
    def __init__(self, parent=None, secondsVisible=5):
        super(OKWindow, self).__init__(parent)
        self.time = secondsVisible
        self.setupUi(self)
    # end __init__

    def __repr__(self):
        return '<{mod}.{name}(time={t})'\
               'object at {hexI}>'.format(mod=self.__module__,
                                          name=self.__class__.__name__,
                                          time=self.time,
                                          hexI=hex(id(self)))
        # return "FileIO(fullpath=%r)" % (self.fullPath)
    # end __repr__
# end OKWindow


class Changelog(object):
    def __init__(self, folder=None):
        """
        Inits a changelog instance. The most important variables are
        self.sectionList and self.sectionGlob, which control when and how
        it's a appropriate for an application to be saved
        """
        super(Changelog, self).__init__()
        self.sectionList = ['MAYA', 'NUKE', 'HOUDINI', 'ALL']
        self.sectionGlob = ['ALL']
        self.folder = folder
        if self.folder is None:
            self.folder = consts.CHANGELOG_DIR
        # self.get_latest_file()
        self.datetime_match()
    # end __init__

    def get_changelog(self):
        """
        Takes a text file as input, separated by blank spaces. Dates are parsed
        and lines starting with "-" are added as points

        Instead of using json or a data format, I decided to keep my changelogs
        readable. The text is read per-line.

        The file starts with the Date: yyyy-mm-dd HH-MM-SS
        followed by a section
        followed by each change point, which starts with '-'

        Once the file reaches a blank line, the changelog is at "end"


        Returns:
            dict: The changelog, sorted by date as its keys
        """
        with open(self.newestlog, 'r') as f:
            data = f.readlines()
        changePoint = []
        changelogDict = {}
        currentSection = "All"  # default header points will go under "All"
        for index, line in enumerate(data):
            matchDate = re.match(self.datetimeMatchRe, line)
            lineStripped = line.strip()
            if matchDate is not None:
                dt = matchDate
                currentDate = "{yr}-{month}-{day} {hr}:{min}:"\
                              "{sec}".format(yr=dt.group("yr"),
                                             month=dt.group("month"),
                                             day=dt.group("day"),
                                             hr=dt.group("hr"),
                                             min=dt.group("min"),
                                             sec=dt.group("sec"))
                changelogDict['Date'] = currentDate

            if lineStripped.startswith('-'):
                changePoint.append(lineStripped)

            if lineStripped.upper() in self.sectionList:
                # record the current section and reset the change points
                changelogDict[currentSection] = changePoint
                currentSection = lineStripped
                changePoint = []

            if line.strip() == "" or index + 1 == len(data):
                # end of current changelog
                return changelogDict
    # end get_changelog

    def get_latest_file(self, folder=None, byDateModified=True):
        """
        Gets the latest changelog file in a given directory based on the file's
        Last Modified metadata

        Args:
            folder (str): The folder to search for changelog files. If None
                          specified, the function will default to the class
                          instance self.folder
            byDateModified (bool): Determines which file to return based on the
                                   how recently the file was modified

        Returns:
            str: The full path to the most recent changelog file
        """
        if not byDateModified:
            # :AUTHORNOTE: Currently not implemented a name conventionfied:
            return None

        if folder is not None:
            folder = self.folder

        extension= 'changelog'
        extRegex = ''
        for letter in extension:
            extRegex += '[' + letter.lower() + letter.upper() + ']'
        self.newestlog = max(glob.iglob('{f}/*.'\
                             '{ext}'.format(f=folder, ext=extension)),
                             key=os.path.getctime)
        return self.newestlog
    # end get_latest_file

    def datetime_match(self):
        """
        Keeps information about the date/time regex match groups


        Returns:
        <_sre.Pattern object>:  A compiled regex pattern object
        """
        # date/time regex
        self.datetimeCompileRe = r".+(?P<yr>\d{4})-(?P<month>\d{2})-(?P<day>\d{2})"\
                                  "\ (?P<hr>\d{2}):(?P<min>\d{2}):(?P<sec>\d{2}).+"
        self.datetimeMatchRe = re.compile(self.datetimeCompileRe, re.VERBOSE)
        return self.datetimeMatchRe
    # end datetime_match

    def __repr__(self):
        """
        repr of Changelog
        """
        return '<{mod}.{name}(self.sectionList={sectionList}, '\
               'self.folder="{f}", self.newestlog="{newestLog}", '\
               'self.datetimeCompileRe="{dt}") '\
               'object at {hexI}>'.format(mod = self.__module__,
                                          name = self.__class__.__name__,
                                          sectionList = self.sectionList,
                                          f = self.folder,
                                          newestLog = self.newestlog,
                                          dt = self.datetimeCompileRe,
                                          hexI=hex(id(self)))
    # end __repr__
# end Changelog


def reset_all_users(value, forceKey=False):
    """
    Gets all users in the project config and sets their CHANGELOG_KEY to True.
    When you're ready to roll out a new update to the system, it's recommended
    that the docs are updated online and that reset_all_users(False, True) is
    run so that everyone in the project will see the new changelog information
    at least once on startup

    Args:
        value (bool): The value to change the user preferences to.
        forceKey (bool): Even if the user does not have preference information,
                         the script will write the given value and create new
                         keys

	Returns:
        bool: True/False
    """
    with open(consts.CREWSHEET, "r") as f:
        data = json.load(f)
    for key, item in data.iteritems():
        if key in consts.REGISTERED_ADMINS and not forceKey:
            continue  # Do not change the on startup setting
        if (CHANGELOG_KEY in item and value != item[CHANGELOG_KEY]) or forceKey:
            data[key][CHANGELOG_KEY] = value

    with open(consts.CREWSHEET, "w") as f:
        json.dump(data, f, indent=4)

    # check the value
    with open(consts.CREWSHEET, "r") as f:
        data = json.load(f)

    for key, item in data.iteritems():
        if forceKey and CHANGELOG_KEY not in item:
            return False  # the force failed on the current user
        if item[CHANGELOG_KEY] != value:
            return False  # the value was not written properly
    return True
# end reset_all_users

def show_gui(application):
    """
    Runs the GUI application

    Args:
        Application (str): When the changelog is created, only changes to the
                           current application and anything under sectionGlob
                           are listed. This variable is passed to the changelog
                           so that only relevant info is displayed to the user
    """
    app = QtGui.QApplication(sys.argv)
    w = Window()
    w.setWindowTitle(application + " Changelog")
    w.show()
    sys.exit(app.exec_())
# end show_gui


if __name__ == "__main__":
    show_gui("Maya")
    # reset_all_users(False, True)
    # print(__doc__)
