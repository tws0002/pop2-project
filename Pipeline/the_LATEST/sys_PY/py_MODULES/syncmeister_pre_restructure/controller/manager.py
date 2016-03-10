#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Takes a Maya .ma file as input and changes all absolute paths into relative
paths. Useful for quick batch-file processing and render-farm prep
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import re
import argparse
import errno


class PathFinder(object):
    def __init__(self):
        super(PathFinder, self).__init__()
        self.outputPaths = None
        self.filePath = None
        self.rootPath = None
        self.checkExist = False
        self.skipPathConfirmation = True
        self.searchForFiles = False
        self.forceOSPaths = None
        self.seek = False
        self.passUnknownPaths = False
    # end __init__

    def get_relative_path(self, childPath, parentPath,
                          searchParentDirectories=False):
        """
        - attempt to subtract the rootPath as a substring of absPath
         - if failure, attempt to search for the correct path
        """
        relPath = os.path.relpath(childPath, parentPath)
        if not searchParentDirectories and relPath.startswith('.'):
            return None

        return relPath
    # end get_relative_path
# end PathFinder



# def mkdir_p(path, exists_ok=True):
#     try:
#         os.makedirs(path)
#     except OSError as exc:  # Python >2.5
#         if exists_ok and exc.errno == errno.EEXIST and os.path.isdir(path):
#             pass
#         else:
#             raise
# # end mkdir_p


# def copytree(src, dest):
#     """
#     Mimics the functionality of shutil.copytree() without its recursivion
#
#     directories are built using os.makedirs()
#     file literals are copied with shutil.copy2()
#     """
#     if not os.path.isdir(src) and not os.path.isfile(src):
#         raise IOError("Invalid path: {} specified. "
#                       "Not file or folder".format(src))
#
#     if os.path.isdir(src) and not os.path.isdir(dest):
#         mkdir_p(dest)
#     elif os.path.isfile(src) and not os.path.isfile(dest):
#         dir, f = os.path.splitdrive(dest)
#         mkdir_p(dir)
#         shutil.copy2(src, dest)
# # end copytree


def change_paths(mayaFilePath,
                 rootPath,
                 checkExist=False,
                 skipPathConfirmation=True,
                 searchForMayaFiles=False,
                 forceOSPaths=None,
                 seek=False,
                 passUnknownPaths=False):
    """
    Originally called set_abs_path_to_rel_path but renamed because the
    script now supports the processing of absolute paths and relative paths.
    In addition, the path the ability to change separators, attempt to find
    relative paths that are in parent directories, and more
    """
    Logger().info("Using Maya file %s..." % mayaFilePath)

    pathMatch = r'"([^"]*)"'
    fMatch_re = re.compile(pathMatch)
    contents = mayaFile.read_ma()
    sysOS = sys.platform

    for index, line in enumerate(contents):
        matchAll = re.findall(fMatch_re, line)

        if matchAll is None:
            continue  # skip

        for match in matchAll:
            if match == [] or match is None or match == "" or \
                    match == " " or match == "/" or match == "//" or \
                    match == "\\" or match == "\\\\":
                continue  # skip

            # if is a maya file and user wants recursive, relative files
            # A known absolute path is checked
            #
            if searchForMayaFiles and \
                    match.endswith(('.ma', '.MA', '.Ma', '.mA')) and \
                    os.path.isfile(match):
                change_paths(match,
                             rootPath,
                             checkExist,
                             skipPathConfirmation,
                             searchForMayaFiles,
                             forceOSPaths,
                             seek)

            # Determine if the path's OS is the same as the system's
            # if not and the user didn't specify skipping, ask how to proceed
            #
            pathOS = paths.get_os_from_path_string(match)
            skipAllPrompts = skipPathConfirmation

            try:
                if rememberConfirmation:
                    skipAllPrompts = True
                    pass  # user specified to allow all paths
                elif not rememberConfirmation and pathOS != sysOS:
                    continue  # skip the current file
                elif not rememberConfirmation:
                    pass
                else:
                    Logger().critical("Something really unexpected happened")
                    sys.exit("Something really unexpected happened")
            except NameError:
                pass  # rememberConfirmation not be defined yet, prompt user

            if not skipAllPrompts and not skipPathConfirmation and \
                    pathOS != sysOS:
                # If the path is from a different OS but the user hasn't
                # said whether or not they are OK with editting across OS
                # stop the script mid execution and ask for confirmation
                #
                message = 'Path OS is {os1} but the system OS is {os2}. '\
                          'Awaiting user input.'.format(os1=pathOS,
                                                        os2=sysOS)
                Logger().info(message)

                options = 'Y/n/yToAll/nToAll'
                message = "Path: {p} \nis of type OS: {OS1} but the current "\
                          "system is OS, {OS2}.\nDo you wish to process "\
                          "path? {options}\n".format(p=match,
                                                     OS1=pathOS,
                                                     OS2=sysOS,
                                                     options=options)

                while True:  # issue message until user submits valid option
                    userInput = raw_input(message)

                    if userInput.upper() in options.upper():
                        if userInput.upper() == "YTOALL":
                            rememberConfirmation = True
                        elif userInput.upper() == "NTOALL":
                            rememberConfirmation = False
                            # continue  # skip
                        elif userInput.upper() == "Y":
                            skipAllPrompts = True  # temporary assignment
                            pass  # allow continuation of script
                        elif userInput.upper() == "N":
                            pass
                            # continue  # skip the next iterationrest of the script
                        break

            # methods for if path can be proven as absolute
            #
            matchNew = match
            if os.path.isabs(match) and forceOSPaths is not None:
                if checkExist and not os.path.isdir(match) and \
                                  not os.path.isfile(match):
                    continue  # skip, is invalid

                # user either doesn't care if file/folder exists or it exists
                matchNew = paths.conform_path(match, forceOSPaths)

            if os.path.isabs(match):
                if checkExist and not os.path.isdir(matchNew) and \
                                  not os.path.isfile(matchNew):
                    continue  # file/folder doesn't exists so skip

                if forceOSPaths is not None:
                    matchNew = get_relative_path(rootPath,  # 707: change with os.path.relpath(match, rootPath)
                                                 match,
                                                 forceOSPaths)  # relative
                else:
                    matchNew = get_relative_path(rootPath, match)  # relative# 707: change with os.path.relpath(match, rootPath)

                temp = '[+] "{p}" relative path created from the '\
                       'absolute path, "{p1}"'.format(p=matchNew,
                                                      p1=match)
                Logger().info(temp)
                contents[index] = line.replace(match, matchNew)
                continue  # skip the rest

            # methods for if path can be proven as relative
            #
            if not os.path.isabs(match) and \
                    paths.is_relative(match) and forceOSPaths is not None:
                matchNew = paths.conform_path(match, forceOSPaths)

            # relative path processing starts with the simplest type
            # of relative path - a path with no relative prefix
            # attempt an aggressive merge of rootPath and the matched object
            #
            if os.path.isdir(os.path.join(rootPath, match)) or \
               os.path.isfile(os.path.join(rootPath, match)):
                if forceOSPaths is not None:
                    matchNew = paths.conform_path(matchNew, forceOSPaths)
                contents[index] = line.replace(match, matchNew)
                continue  # skip - match found, no need to continue the script

            # attempt to "find" the file/folder as an absolute path
            absPathAttempt = os.path.join(rootPath, match)
            # if is a maya file and user wants recursive, relative files
            # An unknown absolute path is checked
            #
            if searchForMayaFiles and \
                    absPathAttempt.endswith(('.ma', '.MA', '.Ma', '.mA')) and \
                    os.path.isfile(absPathAttempt):
                change_paths(absPathAttempt,
                             rootPath,
                             checkExist,
                             skipPathConfirmation,
                             searchForMayaFiles,
                             forceOSPaths,
                             seek)

            # manipulate the path based on the assumption that it is relative
            # all relative paths with prefixes ../ or ./ will be processed
            # attempt to use this manipulated path to find files/folders
            # if found > path is relative > it can be safely modified
            #
            relIntermediatePath = ''
            absPathCheck = ''
            if seek \
               and not os.path.isabs(match) \
               and paths.is_relative(match) \
               and not paths.search_parent_count(match)['is_current_dir']:
                # the current relative path references above the root dir
                foldersUp = paths.search_parent_count(match)['count']
                sep = paths.get_sep(match)
                driveSplit, pathSplit = os.path.splitdrive(rootPath)
                relIntermediatePath = paths.os_path_split_asunder(pathSplit)
                relIntermediatePath = [f for f in relIntermediatePath
                                       if f != "\\"]
                relIntermediatePath.insert(0, driveSplit)
                relIntermediatePath = (sep).join(
                                        relIntermediatePath[:(-1 * foldersUp)])
                # relIntermediatePath = (sep).join(rootPath[:(-1 * foldersUp)])
                relPathInfo = paths.search_parent_count(match)
                # ::TO DO:: Remove this later because it is inefficient
                # replace with a regex that matches the non-relative prefix
                relSuffix = match[len(relPathInfo['match']) *
                                  relPathInfo['count']:]
                absPathCheck = os.path.join(relIntermediatePath, relSuffix)
            elif not os.path.isabs(match) and paths.is_relative(match) and \
                    paths.search_parent_count(match)['is_current_dir']:
                removeStr = len(paths.search_parent_count(match)['match'])
                relIntermediatePath = match[removeStr:]
                absPathCheck = os.path.join(rootPath, relIntermediatePath)

            if checkExist and absPathCheck != '' \
                          and relIntermediatePath != '' \
                          and not os.path.isdir(absPathCheck) \
                          and not os.path.isfile(absPathCheck):
                # file was proven to be relative but it doesn't exist
                continue  # skip the rest, path is invalid upon checking
            elif checkExist and forceOSPaths is not None \
                            and os.path.isfile(absPathCheck) \
                            or os.path.isdir(absPathCheck):
                matchNew = paths.conform_path(match, forceOSPaths)
            elif not checkExist and forceOSPaths is not None:
                matchNew = paths.conform_path(match, forceOSPaths)

            # if is a maya file and user wants recursive, relative files
            # A known relative path is checked for existence
            #
            if searchForMayaFiles and \
                    absPathCheck.endswith(('.ma', '.MA', '.Ma', '.mA')) and \
                    os.path.isfile(absPathCheck):
                change_paths(absPathCheck,
                             rootPath,
                             checkExist,
                             skipPathConfirmation,
                             searchForMayaFiles,
                             forceOSPaths,
                             seek)

            if not os.path.isabs(match) and paths.is_relative(match):
                if checkExist and not os.path.isdir(matchNew) and \
                                  not os.path.isfile(matchNew):
                    # user has specified that they care about paths
                    # and the path doesn't exist
                    continue  # skip
                contents[index] = line.replace(match, matchNew)
                continue  # skip the rest

            # methods for if path cannot be proven as relative
            # more vague methods will be taken to resolve the paths
            #
            if passUnknownPaths:
                continue  # skip - User wants to skip unknown relative paths

            if os.path.exists(absPathAttempt):
                if checkExist and not os.path.isdir(absPathAttempt):
                    # print "caught os.path.exists() exception"
                    continue  # skip

                if forceOSPaths is not None:
                    relativePath = get_relative_path(rootPath, # 707: change with os.path.relpath(match, rootPath)
                                                     absPathAttempt,
                                                     forceOSPaths)
                else:
                    relativePath = get_relative_path(rootPath, # 707: change with os.path.relpath(match, rootPath)
                                                     absPathAttempt,
                                                     forceOSPaths)

                temp = '[+] "{p}" relative path created from the '\
                       'absolute path, "{p1}"'.format(p=relativePath,
                                                      p1=match)
                Logger().info(temp)
                contents[index] = line.replace(match, relativePath)

    contents = mayaFile.write_ma(contents)
# end change_paths


if __name__ == "__main__":
    print(__doc__)
