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
import fileio.controller.paths as paths
import view.maingui as maingui
import controller.manager as manager
import controller.maya as maya


__version__ = 1.0


class UIExtension(maingui.Window):
    """
    Extends the layout given from backup_ui with accept/reject functions as well
    as performs the main backup sequence. This class is where all the imported
    modules are leveraged
    """
    def __init__(self, parent=None):
        super(UIExtension, self).__init__(parent)
        self._want_to_close = False
        self.DATADICT = {}
        self.ok_cancel_b.accepted.connect(self.accept)

    # end __init__
    def accept(self):
        """
        The main function that passes the args within the GUI to syncmeister

        Before execution it displays a window that provides a synopsis of
        what will be changed/kept/ignored and for each path
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
                  ''.format()

        self.msgBox = QtGui.QMessageBox().question(self,
                                                   'Message',
                                                   message,
                                                   QtGui.QMessageBox.Yes,
                                                   QtGui.QMessageBox.No,
                                                   )

        if self.msgBox == QtGui.QMessageBox.Yes:
            # user said yes to the message dialog
            Logger().info("Script Execution finished")
        else:
            # close message box but do not close window
            # reset dict to default settings
            self.DATADICT = {}
    # end accept
# end UIExtension


def show_gui():
    """
    The main execution of the GUI
    """
    app = QtGui.QApplication(sys.argv)
    w = UIExtension()

    w.setWindowTitle('Change Maya Paths '
                     '(Now with GUI!) v{}'.format(__version__))
    w.show()

    sys.exit(app.exec_())
# end show_gui


def backup_file(f):
    """
    The function that runs if backups are checked within syncmeister

    Args:
        f (str): The full path to the file/folder

    Returns:
        str: The full path that backup_file was passed
    """
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
    """
    The command-line utility that is used by default if syncmeister is run
    from the command-line. (If the file is double-clicked like a shortcut
    the GUI is automatically opened)

    Args:
        --inputs (str): (-i) The path to the project folder or scene file
        --root-path (str): (-rp) The path that will be used as a root folder.
                           This is critical for resolving relative paths during
                           sync
        --set-relative (bool): (-sr) All paths (relative or absolute) are
                               automatically made relative after copying
        --use-gui (bool): (-g) Ignores all other flags and instead runs the
                          GUI-mode
        --get-subfolders (bool): (-g) The script will recursively acquire
                                 subfolders of any folder that the user
                                 specified
        --dependencies-include (bool): (-di) Searches recursively within files
                                       for other files/folders to add
        --dependencies-only (bool): (-do) Filters folders from file(s)/folder(s)
                                    and only includes files that are used as
                                    dependencies for scene files selected
        --evaluate (bool): (-e) If enabled, considers all paths
                           (relative/absolute/unknown). If disabled, only
                           evaluates absolute paths
        --evaluate-absolutes (bool): (-ea) Note, as a version 1.0.0, this does
                                     nothing. If implemented, it will change
                                     relative paths into absolute paths on copy
        --ignored-locked (bool): (-l) If specified, copies file(s)/folder(s)
                                 even if they are set to locked
        --seek-path (bool): (-sp) Even if a path is above and/or lateral to the
                            parent path, the script will aggressively search and
                            resolve it. Warning: Use with caution
        --empty-copying (bool): (-ec) Copies file(s)/folder(s) even if empty
        --pass-unknown (bool): (-pu) Paths that cannot be proven as absolute or
                               relative are skipped when enabled. Recommended to
                               keep on unless copy performance is an issue
    """
    # General
    parser = argparse.ArgumentParser(description='Make Maya Paths Relative.')
    parser.add_argument('-i', '--inputs', nargs='+', dest='inputs',
                        help='The path to a project folder or scene file(s)')
    parser.add_argument('-rp', '--root-path', dest='rootPath',
                        help='The root path which will be used as a '
                             'reference for all relative paths, if make'\
                             'relative paths has been enabled')
    message = 'Makes all paths of the copied files relative to '\
              'its new copy location'
    parser.add_argument('-sr', '--set-relative', dest='setRelative',
                        action='store_true', help=message)
    parser.add_argument('-g', '--use-gui', action='store_true', dest='useGui',
                        help='When included, ignores all other options and'
                             'runs the GUI version of the script')
    parser.add_argument('-s', '--get-subfolders', action='store_true',
                        dest='getSubfolders',
                        help='Makes the script iterate through all subfolders '
                             'of the specified folders specified (if any)')

    # Application-specific args
    message = 'Takes the regular listings for files/folders and '\
              'also searches valid scene files for additional files/folders'
    parser.add_argument('-di', '--dependencies-include',
                        dest='dependenciesInclude', action='store_true',
                        help=message)
    message = 'Filters folders from files/folders listing and only copies '\
              'the files/folders necessary to build any valid scene files '\
              'specified'
    parser.add_argument('-do', '--dependencies-only',
                        dest='dependenciesOnly', action='store_true',
                        help=message)
    message = "File dependencies, if searched, will process absolute and "\
              "relative paths if enabled. If disabled, only absolute paths "\
              "will be processed. (Requires -di/--dependencies-include)"
    parser.add_argument('-e', '--evaluate', action='store_true',
                        dest='evalAllPaths', help=message)
    message = "NOTE: currently does nothing in the current version as of 1.0."\
              " File dependencies, if searched, returns relative paths as "\
              "absolute paths if enabled. (Requires -e/--evaluate)"
    parser.add_argument('-ea', '--evaluate-absolutes', action='store_true',
                        dest='evaluateAsAbsolutes', help=message)
    message = "If specified, copies files/folders even if they are locked"
    parser.add_argument('-l', '--ignore-locked', action='store_true',
                        dest="ignoreLocked", help=message)

    # abs2rel args
    message = "If specified, relative paths will be fulfilled even if the "\
              "path is above or lateral, relative to the root path. The "\
              "script will seek up until it reaches a common directory "\
              "between the path and the root"
    parser.add_argument('-sp', '--seek-path', dest="seek", action='store_true',
                        help=message)
    parser.add_argument('-ec', '--empty-copying', action='store_true',
                        dest='emptyCopying',
                        help='If specified, script will copy files/folders '
                             'even if they are empty')
    message = 'To some degree, strings can be "proven" to be absolute or '\
              'relative paths without necessarily knowing if the path exists.'\
              ' Strings that cannot be proven can still be processed however.'
    parser.add_argument('-pu', '--pass-unknown', action='store_true',
                        dest="passUnknownPaths", help=message)
    args = parser.parse_args()

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

    if args.useGui:
        # run the GUI, don't execute anything below it
        show_gui()
        return 0

    # required
    if args.setRelative and args.rootPath is not None \
            or not os.path.isdir(args.rootPath):
        sys.exit("Path: {} is invalid. Please use a a valid folder to "
                 "reference the relative paths towards "
                 "(-rp or --root-path)".format(args.rootPath))

    if args.inputs is None:
        sys.exit("No files/folders was specified (-i or --input)")



    # init optional args
    # ::TO DO:: Come back to this and complete it. Currently unfinished
    # not all optional args are represented
    #
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

    # Get files/folders
    # ::TO DO:: Remove hard coding of "output" and replace with a user argument
    fileFolders = []
    fileFoldersAll = []  # list of all files/folders without filtering
    fileObj = maya.FileObject()
    for item in args.inputs:
        items = paths.walkLevel(item, level=level, output="FILES+FOLDERS")
        for obj in items:
            if args.emptyCopying and os.path.isdir(obj) or os.path.isfile(obj):
                # copy the file/folder
                fileFolders.append(obj)
                # Keep a list of all files/folders. We'll need it for later
                # shutil is used to copy the entire file/folder tree in 1 pass
                # fileFoldersAll is referenced against fileFolders
                # to determine which files/folders to ignore
                #
                fileFoldersAll.append(obj)
            if os.path.isdir(obj) \
                    and paths.get_size(obj) != 0 \
                    or os.path.isfile(obj) \
                    and os.stat(obj).st_size != 0 \
                    and not args.emptyCopying:
                # copy the file/folder
                fileFolders.append(obj)

    # Filter files/folders based on user arguments
    if args.onlyDependencyFiles:
        fileFolders = [f for f in fileFolders if os.path.isfile(f)
                       and f.endswith(fileObj.fileExtensionsASCII)]

    if args.includeDependencies:
        # this is basically the abs2rel script but it outputs paths
        # rather than writing the paths to file
        # :::TO DO::: I could output the line and line number and just
        # have another script read the kwargs and replace lines are it reads!!
        # that way I could use one script for both of these utilities
        #
        # ::TO DO:: complete the args listing for this pseudo - function
        # also, complete the function (duh)
        # :::TO DO:::ID A1514 - see notes
        fileFolders = manager.get_dependency_paths(asAbsolute=False)

        # conform all paths to a single seperator type
        # ::TO DO:: ::AUTHORNOTE:: I may want to add back in "forceSep"
        # so that users can control this
        #
        # fileFolders = [paths.replace_sep_with_string(f) for f in fileFolders]
        if not args.evalAllPaths:
            fileFolders = [f for f in fileFolders if not paths.is_relative(f)]

        # normalize pathseps
        # remove duplicates
        # remove parent directories that contain subfolders
        # remove locked files if override not specified
        if not args.ignoreLocked:
            # ::PROJECT SPECIFIC::
            # :::TO DO::: REPLACE LATER with the main function
            fileFolders = [f for f in fileFolders if paths.is_locked(f)]

        fileFolders = [os.path.normpath(f) for f in fileFolders]
        fileFolders = list(set(fileFolders))

    # process files by making them relative to the new copy location
    # add the strings into the copy location as the destination path
    # copy all files/folders
    # ::AUTHORNOTE:: what did I mean when I wrote this?
    #

    ignoredPaths = list(set(fileFoldersAll) - set(fileFolders))

    for f in fileFolders:
        shutil.copytree(f, rootPath, ignore=ignoredPaths)
    # manager.mkdir_p(f) for


    # mayaFile = maya.FileObject()
    # mayaFile.path = f
    # contents = mayaFile.read_ma()
    # manager.change_paths(f,
    #                      args.rootPath,
    #                      contents=contents,
    #                      checkExist=args.checkExists,
    #                      skipPathConfirmation=args.skipPathConfirmation,
    #                      searchForMayaFiles=args.searchForMayaFiles,
    #                      forceOSPaths=args.forceOSPaths,
    #                      seek=args.seek,
    #                      passUnknownPaths=args.passUnknownPaths)
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
