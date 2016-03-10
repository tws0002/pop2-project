#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
The main GUI/command-line utility for the absolute to relative path utility.
The script expects and changes Maya ASCII files so that all absolute paths
become relative to a specific location that the user defines as the root path.

This script was made due to a bug in the latest Renderman, where paths that
were set relatively in the Maya session were being stored as absolute paths
on save and save/exit. This caused many problems with our render farm
"""

# IMPORT STANDARD LIBRARIES
import sys
import os
import argparse
import shutil

# IMPORT THIRD PARTY LIBRARIES
from PyQt4 import QtGui

# IMPORT LOCAL LIBRARIES
from view import maingui
from controller import manager_0002 as manager
from controller import paths
from controller import maya

# LOGGER
from common.loggingServices import Logger
from common.logBuffer import LogBuffer
import common.config as config

__version__ = 1.0

BACKUP_UNIQUE_ID = "_backup"


class UIExtension(maingui.Window):
    """
    Extends the layout given from backup_ui with accept/reject functions as well
    as performs the main backup sequence. This class is where all the imported
    modules are leveraged
    """
    def __init__(self, parent=None):
        super(UIExtension, self).__init__(parent)
        self._want_to_close = False
        self.DATADICT = {"license": "", "items": [],
                         "rootPath": '', 'recursive': False,
                         'backupFile': False, 'seek': False,
                         'checkExists': False, 'searchForMayaFiles': False,
                         'skipPathConfirmation': False,
                         'passUnknownPaths': False}
        self.ok_cancel_b.accepted.connect(self.accept)

    # end __init__
    def accept(self):
        """
        The main function that passes the args within the GUI to the
        licensechooser utility
        """
        # embed data to DATADICT
        # process lineEdits
        #
        for f in self.findChildren(QtGui.QLineEdit):
            formText = str(f.text()).strip()

            if f.objectName() == "pathSep_le":
                if formText == '' or formText is None:
                    self.DATADICT["sep"] = False
                else:
                    self.DATADICT["sep"] = formText
            elif f.objectName() == "root_path_le":
                self.DATADICT["rootPath"] = formText
            elif f.objectName() == "folder_file_le" and formText != "":
                if formText not in self.DATADICT["items"]:
                    # value is unique (aka, not a duplicate)
                    self.DATADICT["items"] = \
                        self.DATADICT.get("items", None) + [formText]

        # process checkBoxes
        self.DATADICT['backupFile'] = self.backupFile_cb.isChecked()
        self.DATADICT['seek'] = self.seekPath_cb.isChecked()
        self.DATADICT['checkExists'] = self.checkExists_cb.isChecked()
        self.DATADICT['recursive'] = self.recursive_cb.isChecked()
        self.DATADICT['searchForMayaFiles'] = \
            self.searchForMayaFiles_cb.isChecked()
        self.DATADICT['skipPathConfirmation'] = \
            self.skipPathConfirmation_cb.isChecked()
        self.DATADICT['passUnknownPaths'] = \
            self.skipUnknownRelPaths_cb.isChecked()

        message = 'Take a look at these settings before continuing:\n\n'\
                  'Root Path selected: "{rp}"\n\n'\
                  'The following file(s)/folder(s) will be affected:\n{f}\n\n'\
                  'Search all folders/subfolders? "{cb}"\n'\
                  'Backup files before processing? "{bc}"\n'\
                  'Search for relative paths above root path? "{seek}"\n'\
                  'Only change paths if they are a file or folder? "{ex}"\n'\
                  'Choosen separator? "{sep}"\n'\
                  'Search Maya files recursively for other files? "{m}"\n'\
                  'Skip user confirmation even if path OS differs? "{sc}"\n'\
                  'Do not process all strings - skip unknown paths? "{su}"'\
                  ''.format(rp=self.DATADICT["rootPath"],
                            cb=self.DATADICT['recursive'],
                            bc=self.DATADICT['backupFile'],
                            seek=self.DATADICT['seek'],
                            ex=self.DATADICT['checkExists'],
                            sep=self.DATADICT['sep'],
                            m=self.DATADICT['searchForMayaFiles'],
                            sc=self.DATADICT['skipPathConfirmation'],
                            su=self.DATADICT['passUnknownPaths'],
                            f="\n".join([str(x) for x
                                         in self.DATADICT["items"]]))

        self.msgBox = QtGui.QMessageBox().question(self,
                                                   'Message',
                                                   message,
                                                   QtGui.QMessageBox.Yes,
                                                   QtGui.QMessageBox.No,
                                                   )

        if self.msgBox == QtGui.QMessageBox.Yes:
            # user said yes to the message dialog
            A
            level = 1
            if self.DATADICT['recursive']:
                level = 9001  # some impossibly high number > 256

            files = paths.get_maya_files(self.DATADICT['items'],
                                         level=level,
                                         endswith=('.ma', '.MA', '.Ma', '.mA'))

            files = list(files)
            print files
            files = [str(f) for f in files]  # ::BUG:: Used to fix a type bug

            files = [f for f in files if BACKUP_UNIQUE_ID not in f]  # ignore
            [backup_file(f) for f in files
             if self.DATADICT['backupFile']]  # backup if specified

            print "FILES"
            print files
            print len(files)
            [manager.change_paths(mayaFilePath=f,
                  rootPath=self.DATADICT['rootPath'],
                  checkExist=self.DATADICT['checkExists'],
                  skipPathConfirmation=self.DATADICT['skipPathConfirmation'],
                  searchForMayaFiles=self.DATADICT['searchForMayaFiles'],
                  forceOSPaths=self.DATADICT['sep'],
                  seek=self.DATADICT['seek'],
                  passUnknownPaths=self.DATADICT['passUnknownPaths'])
            for f in files]
            Logger().info("Script Execution finished")
        else:
            # close message box but do not close window
            # reset dict to default settings
            self.DATADICT = {"license": "", "items": [],
                             "rootPath": '', 'recursive': False,
                             'backupFile': False, 'seek': False,
                             'checkExists': False, 'searchForMayaFiles': False,
                             'skipPathConfirmation': False,
                             'passUnknownPaths': False}
    # end accept
# end UIExtension


def init_logger():
    # Init the logger
    if hasattr(sys, "frozen"):
        # Forbid all console outputs
        sys.stderr = BlackHole()
        Logger(defaultStreamHandler=True)
    else:
        Logger()

    # Create the buffer for GUI log
    logStream = LogBuffer()
    Logger().addStreamHandler(logStream)
    Logger().setLevel("info")

    Logger().info("Starting %s..." % os.path.basename(__file__))
    Logger().debug("main(): platform=%s" % config.platform)
# end init_logger


def show_gui():
    app = QtGui.QApplication(sys.argv)
    w = UIExtension()

    w.setWindowTitle('Change Maya Paths '
                     '(Now with GUI!) v{}'.format(__version__))
    w.show()

    sys.exit(app.exec_())
# end show_gui


def backup_file(f):
    # backup file before processing
    backupDir, backupFile = os.path.splitdrive(f)
    backupFile, backupExtension = os.path.splitext(backupFile)
    backupLocation = os.path.join(backupDir,
                                  backupFile +
                                  BACKUP_UNIQUE_ID +
                                  backupExtension)

    if not os.path.isfile(backupLocation):
        shutil.copyfile(f, backupLocation)
    else:
        Logger().error("[+] File: {} already exists. Backup will "
                       "not overwrite file".format(backupLocation))

    if os.path.isdir(backupLocation) or os.path.isfile(backupLocation):
        Logger().info("File: {} was backed up to location, "
                      "{}".format(f, backupLocation))
    else:
        Logger().error("[-] File: {} failed to back up to location, "
                       "{}".format(f, backupLocation))

    return f
# end backp_file


def main(argv):
    parser = argparse.ArgumentParser(description='Make Maya Paths Relative.')
    parser.add_argument('-i', '--inputs', nargs='+', dest='inputs',
                        help='The path to a folder or maya file ending in .ma')
    parser.add_argument('-rp', '--root-path', dest='rootPath',
                        help='The root path which will be used as a '
                             'reference for all relative paths')
    parser.add_argument('-g', '--use-gui', action='store_true', dest='useGui',
                        help='When included, ignores all other options and'
                             'runs licensechooser\'s GUI version')
    parser.add_argument('-r', '--recursive', action='store_true',
                        dest='recursive',
                        help='Makes the script iterate through all subfolders '
                             'of specified folders (if any specified)')
    message = 'Searches for Maya files within Maya files recursively. '\
              'Useful if you want any reference files to also be made relative'
    parser.add_argument('-sm', '--search-mayafiles', action='store_true',
                        dest='searchForMayaFiles', help=message)
    message = 'All absolute OS paths are set to a single OS style. If -e is '\
              'specified, it only does this if the file/folder exists. This '\
              'option effectively turns on -c as it deals with resolving '\
              'multiple OSes. Possible options are "/", "\\", "\\\\"'
    parser.add_argument('-fp', '--force-pathsep', dest='forceOSPaths',
                        nargs=1, help=message)
    message = 'All absolute paths, before being made relative, will be '\
              'checked to see if they exist on the current local machine. '\
              'If they do not, they will not be made relative. Relative '\
              'paths will also be checked for validity. It\'s recommended to '\
              'always have this on unless the file\'s assets exist on '\
              'another machine or network'
    parser.add_argument('-e' '--exists', dest='checkExists', action='store_true', help=message)
    message = "If specified, relative paths will be fulfilled even if the "\
              "path is above or lateral, relative to the root path. The "\
              "script will seek up until it reaches a common directory "\
              "between the path and the root"
    parser.add_argument('-sp', '--seek-path', dest="seek", action='store_true',
                        help=message)
    parser.add_argument('-sc', '--skip-confirmation',
                        dest="skipPathConfirmation", action='store_true',
                        help="Skips asking for user input if path OS and "\
                             "system OS differ before resolving the path OS "\
                             "into a relative path")
    message = 'To some degree, strings can be "proven" to be absolute or '\
              'relative paths without necessarily knowing if the path exists.'\
              ' Strings that cannot be proven can still be processed however.'
    parser.add_argument('-pu', '--pass-unknown', action='store_true',
                        dest="passUnknownPaths", help=message)
    parser.add_argument('-b', '--backup', action='store_true',
                        dest='backupFile',
                        help='Backup files before processing')
    args = parser.parse_args()

    # init_logger()  # Logger() now available

    if args.useGui:
        # run the GUI, don't execute anything below it
        show_gui()
        return 0

    # required
    if args.rootPath is None or not os.path.isdir(args.rootPath):
        sys.exit("Invalid root path to reference for relative paths specified "
                 "(-rp or --root-path)")

    if args.inputs is None:
        sys.exit("No files/folders was specified (-i or --input)")

    popItems = []
    for index, inputs in enumerate(args.inputs):
        if not os.path.isdir(inputs) and not os.path.isfile(inputs) and \
                not args.skipPathConfirmation:
            sys.exit("Invalid file/folder: {}. "
                     "Please fix and resubmit".format(inputs))
        elif not os.path.isdir(inputs) and not os.path.isfile(inputs) and \
                args.skipPathConfirmation:
            popItems.append(index)

    if popItems != []:
        for item in popItems:
            message = "Item: {} was detected invalid and automatically "\
                      "removed from list".format(args.inputs[item])
            Logger().warning(message)

        args.inputs = [i for j, i in enumerate(args.inputs)
                       if j not in popItems]

    # init optional args
    if args.forceOSPaths == []:
        args.forceOSPaths = ''
    elif args.forceOSPaths[0].strip() not in ['/', '//', '\\', '\\\\']:
        sys.exit("Separator: {} is invalid. "
                 "Please re-run '/', '//', '\\', '\\\\', or nothing ''. "
                 "Script cannot continue...".format(args.forceOSPaths[0]))
    else:
        args.forceOSPaths = args.forceOSPaths[0].strip()

    level = 1
    if args.recursive:
        level = 9001  # some really impossibly high number that's > 256

    files = paths.get_maya_files(input=args.inputs,
                                 level=level,
                                 endswith=('.ma', '.MA', '.Ma', '.mA'))

    files = [f for f in files if BACKUP_UNIQUE_ID not in f]  # ignore backups
    [backup_file(f) for f in files if args.backupFile]  # backup files if True

    for f in files:
        manager.change_paths(f,
                             args.rootPath,
                             checkExist=args.checkExists,
                             skipPathConfirmation=args.skipPathConfirmation,
                             searchForMayaFiles=args.searchForMayaFiles,
                             forceOSPaths=args.forceOSPaths,
                             seek=args.seek,
                             passUnknownPaths=args.passUnknownPaths)
# end main


# def test_main():
#     rootPath = r"C:\Users\SelecaoOne\Dropbox\Private\my_ENV\sys_PY\py_MODULES\abs2relpaths\test\new\created_project"
#     mayaFilePath = r"C:\Users\SelecaoOne\Dropbox\Private\my_ENV\sys_PY\py_MODULES\abs2relpaths\test\new\created_project\scenes\advanced_test.ma"

#     import shutil
#     shutil.copyfile(mayaFilePath, mayaFilePath+'_old')
#     if os.path.isfile(mayaFilePath+"_old"):
#         Logger().info("Sucessfully copied")
#         manager.change_paths(mayaFilePath,
#                              rootPath,
#                              checkExist=True,
#                              skipPathConfirmation=True,
#                              forceOSPaths='/')
#         # if os.path.isfile(mayaFilePath):
#         #     os.remove(mayaFilePath)
#         # os.rename(mayaFilePath+'_old', mayaFilePath)
#     else:
#         Logger().error("COPY FAILED")

if __name__ == "__main__":
    # Use GUI if the user double-clicks or runs from terminal.
    # Else, if any flags were passed, parse
    if len(sys.argv) == 1:
        show_gui()
    else:
        main(sys.argv[1:])
