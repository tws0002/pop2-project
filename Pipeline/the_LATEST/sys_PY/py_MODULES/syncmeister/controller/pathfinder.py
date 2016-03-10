#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Takes a Maya .ma file as input and changes all absolute paths into relative
paths. Useful for quick batch-file processing and render-farm prep

This file is the underbelly of syncmeister's GUI and command-line modes
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import re
import collections

# IMPORT LOCAL LIBRARIES
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
import fileio.controller.paths as paths
import network.controller.network as network
import engine
import syncmeister.model.operation as op


# :AUTHORNOTE: include in a logger traceback?
# Reference: https://stackoverflow.com/questions/6200270/decorator-to-print-function-call-details-parameters-names-and-effective-values
#
def dump_args(func):

        # init triggers"This decorator dumps out the arguments passed to a function before calling it"
    argnames = func.func_code.co_varnames[:func.func_code.co_argcount]
    fname = func.func_name
    def echo_func(*args,**kwargs):
        print fname, "(", ', '.join(
            '%s=%r' % entry
            for entry in zip(argnames,
                             args[:len(argnames)])+\
                             [("args",list(args[len(argnames):]))]+\
                             [("kwargs",kwargs)]) +")"
    return echo_func
# end dump_args


def default_condition_try_behavior(f):
    """
    This ensures, that if a key condition is retrieved that does not exist,
    that functions will fail gracefully with proper logger output. Also, if the
    output of a function is None, it will automatically reassign it to the
    operation class's PASS method
    """
    def wrap(*args, **kwargs):
        try:
            # print "Hello"
            output = f(*args, **kwargs)
            if output is None:
                return op.StaticOperation.PASS
            else:
                return output
        except KeyError:
            LOGGER.critical(["AIE9901", "match_false"], {func:f})
            LOGGER.getTraceback()
    # end wrap
    return wrap
# end default_condition_try_behavior


class PathFinder(object):
    """
    WIP class that will take the place of change_paths for syncmeister. When
    completed, it will copy locations that the user specifies, relative to a
    root folder path.
    """
    def __init__(self, filePath, rootPath=op.StaticOperation.defaultRootDirText,
                 checkExist=True, seek=False, recursiveSearchFiles=False,
                 passUnknownPaths=False, autoResolveOSPaths=True,
                 normalizePaths=True, addDependencyFiles=True):
        """
        Args:
            filePath (str): The full file path of the file to be queried
            rootPath (str): The root directory, from which relative paths will
                            be set
            checkExist (bool): Only allows the operation of a file if it exists
            seek (bool): When enabled, will find relative paths above the root
                         directory
            .. warning::
                This is NOT advised for programs that do not support ../ syntax
                for dependencies (ex: Maya can use ../ for references but not
                for textures)

            recursiveSearchFiles (bool): When enabled, will search referencial
                                         scene files for other dependencies,
                                         until the script runs out of new scene
                                         files to parse and search.
            passUnknownPaths (bool): If a path cannot be proven to be absolute
                                     or relative, the script will not attempt
                                     to "find" the file and simply pass it.
                                     Enable if script execution is slow
            autoResolveOSPaths (bool): Even if a path originates from another
                                       OS, presuming that the path is on an
                                       identical folder structure on a
                                       dual-boot network machine (our setup),
                                       the script will get process the path by
                                       removing the OS component and swapping
                                       it with the current OS.

            .. important::
                For the current project, it looks in the
                collaborative_space/project_name to perform this

            :AUTHORNOTE: Test this when you've got the script working before
            creating a commit to the environment
        """
        super(PathFinder, self).__init__()
        # application-specific information
        self.sceneFileExtensions = ()
        self.maxParentCount = 1
        self.validConditionKeys = ["Expected Output", "Exceptions"]
        self.outputPaths = None
        self.filePath = filePath
        self.rootPath = rootPath
        self.init_root_path()
        self.checkExist = checkExist
        self.recursiveSearchFiles = recursiveSearchFiles
        self.seek = seek
        self.passUnknownPaths = passUnknownPaths
        self.autoResolveOSPaths = autoResolveOSPaths
        self.normalizePaths = normalizePaths
        self.addDependencyFiles = addDependencyFiles

        self.currentMatch = ""
        self.matchIsAbsolute = False
        self.matchIsRelative = False

        # init manager which will decide how matches pass or fail
        self.op = op.StaticOperation()
        self.init_match_conditions()
    # end __init__

    def init_root_path(self):
        if self.rootPath == op.StaticOperation.defaultRootDirText:
            self.rootPath = path.os_path_split_asunder(self.filePath)
            self.rootPath = self.rootPath[-1 * self.maxParentCount]
            self.rootPath = (os.sep).join(self.rootPath)
            if sys.platform == "linux2" and not self.rootPath.startswith('/'):
                self.rootPath = "/" + self.rootPath
    # end init_root_path

    def init_match_conditions(self):
        """
        Creates the match conditions for the current class. In short, because
        of the flexibility of dictionaries to take function objects as arguments,
        the dictionary acts as a pseudo-checklist. But since the order of the
        checks matter, a collections.OrderedDict was used.

        I have two options for how I handle the output of these methods
        I could either have each of them pass if the ideal condition is met and
        fail if failure or I can create a wrapper method that handles individual,
        universal conditions like continue, pass, etc which are bound to operate
        the same, no matter which condition I use
        """
        self.conds = collections.OrderedDict()
        self.conds[self.match_is_empty] = {"Expected Output": self.op.PASS,
                                           "Exceptions": {None: self.op.CONTINUE}}
        self.conds[self.match_to_normalize] = {"Expected Output": self.op.PASS,
                                               "Exceptions": {None: None}}
        self.conds[self.match_is_in_root] = {"Expected Output": self.op.PASS,
                                             "Exceptions": {None: None}}
        # I must detect early if the match is from a different OS and change it
        # if it is.
        # :NOTE: This feature works only on assumption that the user is
        # working under the Montgomery Hall network machines.
        #
        self.conds[self.match_differs_os] = {"Expected Output": self.op.IS_ABSOLUTE,
                                              "Exceptions": {None: None}}
        self.conds[self.match_is_absolute] = {"Expected Output": self.op.IS_ABSOLUTE,
                                              "Exceptions": {None: None}}
        self.conds[self.match_is_relative] = {"Expected Output": self.op.IS_RELATIVE,
                                              "Exceptions": {None: None}}
        self.conds[self.match_must_exist] = {"Expected Output": self.op.PASS,
                                              "Exceptions": {None: self.op.CONTINUE}}
        # The recursive op must instantiate another class of the same type
        # and then run the script again for more matches if it is a scene file
        #
        self.conds[self.match_is_scene_file] = {"Expected Output": self.op.RECURSIVE_SAME_CLASS,
                                                "Exceptions": {None: None}}
        self.conds[self.match_unknown_path_status] = {"Expected Output": self.op.PASS,
                                                      "Exceptions": {None: self.op.CONTINUE}}
    # end init_match_conditions

    def match_is_empty(self):
        """
        Tests if the match is empty or not and whether or not the match should
        be skipped over in the main execution of the current class
        """
        if self.currentMatch == [] or self.currentMatch == {} or \
                self.currentMatch is None or self.currentMatch.strip() == "" or \
                self.currentMatch == "/" or self.currentMatch == "//" or \
                self.currentMatch == "\\" or self.currentMatch == "\\\\":
            return self.op.CONTINUE
        else:
            return self.op.PASS
    # end match_is_empty

    def match_to_normalize(self):
        """
        Simply normalizes the case of the given match string
        if the user specifies to do so
        """
        if self.normalizePaths:
            self.currentMatch = os.path.normcase(self.currentMatch)
            return self.op.PASS
        else:
            return self.op.PASS
    # end match_to_normalize

    def match_is_in_root(self):
        """
        Checks that the current match is within the root dir. If it isn't and
        the user cares, then the current match should be skipped
        """
        if not self.seek and \
                (paths.is_current_dir(self.currentMatch, self.maxParentCount) or \
                paths.is_abs_path_in_current_dir(self.rootPath, self.currentMatch)):
            return self.op.CONTINUE
        else:
            return self.op.PASS
    # end match_is_in_root

    def match_is_scene_file(self):
        """
        Checks if the current match is a valid scene file whose contents can be
        read recursively.

        If is a file and user wants a recursive search, the potential path
        is checked
        """
        if self.addDependencyFiles and \
                self.currentMatch.endswith(self.sceneFileExtensions) and \
                os.path.isfile(self.currentMatch):
            return self.op.RECURSIVE_SAME_CLASS
        else:
            return self.op.PASS
    # end match_is_scene_file

    def match_differs_os(self):
        """
        Compares the current string, assuming that it is actually a path (it
        doesn't check to know whether it is one for a fact before computing) to
        the current system. If the two do not match, it checks for advice about
        how to process the path from the user

        .. note::
            If the path doesn't start with a drive-letter, the output basically
            assumes that the path is linux-based

        """
        networkManager = network.NetworkManager()
        pathOS = get_path_os(self.currentMatch)

        sysOS = sys.platform
        if pathOS == sysOS:
            return self.op.CONTINUE
            # elif (pathOS != sysOS and self.autoResolveOSPaths) and \
            #         not networkManager.is_remote():
        elif (pathOS != sysOS and self.autoResolveOSPaths):
            return self.op.SWITCH_OS
        elif (pathOS != sysOS and self.autoResolveOSPaths) and \
                networkManager.is_remote():
            LOGGER.info("The following computer is not on Montgomery Hall's "
                        "network, cannot auto resolve path")
            return self.op.CONTINUE
    # end match_differs_os

    def match_is_absolute(self):
        """
        Method to determine if path can be proven as absolute by testing if it
        exists on the local machine
        """
        if os.path.isabs(self.currentMatch) \
                and not os.path.isdir(self.currentMatch) and \
                not os.path.isfile(self.currentMatch):
            return self.op.CONTINUE  # doesn't exist - skip
        elif os.path.isabs(self.currentMatch) \
                and (os.path.isfile(self.currentMatch) \
                or os.path.isdir(self.currentMatch)):
            self.matchIsAbsolute = True
            return self.op.IS_ABSOLUTE
    # end match_is_absolute

    def match_is_relative(self):
        """
        Method to determine if path can be proven as relative beyond doubt. It
        does this by normalizing the match to the root directory and, if some
        file/folder exists, then we can infer that the path is definitely meant
        to be relative.
        """
        # relative path processing starts with the simplest type
        # of relative path - a path with no relative prefix
        # attempt an aggressive merge of rootPath and the matched object
        #
        resolvedPath = os.path.normpath(os.path.join(self.rootPath, self.currentMatch))
        if os.path.isdir(os.path.join(self.rootPath, self.currentMatch)) or \
           os.path.isfile(os.path.join(self.rootPath, self.currentMatch)):
            self.op.IS_RELATIVE
        else:
            self.op.PASS
    # end match_is_relative

    # def match_may_not_seek(self, match):
    #     """
    #     If the user has specified that the match is not allowed to seek above the
    #     parent directory and the (presumably) relative path is above the parent
    #     directory, treat as a failed condition. But if seek is enabled and it is,
    #     send it through. Else If the path is within the parent path then it
    #     doesn't matter what seek is
    #     """
    #     pass
    # # end match_may_not_seek

    def match_must_exist(self):
        """
        Checks if the user cares if the file must be proven to exist.

        .. important::
            This method is going to be run AFTER our checks for proving if a
            file/folder is absolute or relative. That way, any file beyond that
            point must be resolved or it will be thrown away
        """
        if self.checkExist and not os.path.exists(self.currentMatch):
            return self.op.CONTINUE
        elif self.checkExist and os.path.exists(self.currentMatch):
            return self.op.PASS
        elif not self.checkExist:
            return self.op.PASS
    # end match_must_exist

    def match_unknown_path_status(self):
        """
        Makes sure that if the user specifies to not process unknown paths that
        any and all unknown paths are not processed.

        .. important::
            The if self.passUnknownPaths condition ASSUMES that this method
            is being run at the very end of the script, after all other known
            methods of determining paths have been exhausted
        """
        if self.passUnknownPaths:
            return self.op.CONTINUE  # user wants to skip the path
        else:
            return self.op.PASS

        # if os.path.exists(self.currentMatch):
        #     if checkExist and not os.path.isdir(currentMatch):
        #         # print "caught os.path.exists() exception"
        #         return op.Operation.CONTINUE  # skip

        #     relativePath = os.path.relpath(self.currentMath, self.rootPath)
        #     self.currentMath = relativePath

        #     temp = '[+] "{p}" relative path created from the '\
        #            'absolute path, "{p1}"'.format(p=relativePath,
        #                                           p1=match)
        #     Logger().info(temp)
    # end match_unknown_path_status

    @default_condition_try_behavior
    def eval_match_conditions(self, originalString=None):
        """
        Looks through the dictionary of match conditions and passes each
        function's output based on what each function returns

        .. authornote::
            Experimental. Don't use in production yet

        """
        if originalString is None:
            self.originalString = self.currentMatch
        else:
            self.originalString = originalString

        for condition, item in self.conds.iteritems():
            self.is_valid_keys(item.keys())
            if condition() == self.op.CONTINUE:
                continue
            if condition() == self.op.PASS:
                pass
            if condition() == self.op.SWITCH_OS:
                self.currentMatch = change_path_to_current_os(self.currentMatch)
            if condition() == self.op.IS_RELATIVE:
                # any file that is relative will be changed to absolute handled
                #
                self.currentMatch = os.path.join(self.rootDir, self.currentMatch)
                self.matchIsAbsolute = True  # overwrite for later evaluation
            if os.path.isfile(self.currentMatch) or \
                    os.path.isdir(self.currentMatch):
                # check if it is a scene file and if it is, do a recursion.
                # Else, return it
                #
                if condition() == self.op.RECURSIVE_SAME_CLASS and \
                        self.addDependencyFiles:
                    # do some recursion here and make a new class
                    newClass = self.__class__(filePath=self.currentMatch,
                                              rootPath=self.rootPath,
                                              checkExist=self.checkExist,
                                              seek=self.seek,
                                              recursiveSearchFiles=self.recursiveSearchFiles,
                                              passUnknownPaths=self.passUnknownPaths,
                                              autoResolveOSPaths=self.autoResolveOSPaths,
                                              normalizePaths=self.normalizePaths,
                                              addDependencyFiles=self.addDependencyFiles)
                    matchOut = newClass.eval_match_conditions()
            if self.checkExist and (os.path.isdir(self.currentMatch) or \
                    os.path.isfile(self.currentMatch)):
                return (self.originalString, self.currentMatch)
            elif self.checkExist:
                return (self.originalString, None)
            else:
                return (self.originalString, None)

            # set this condition last, in case all others fail
            # if condition() != item["Expected Output"]:
            #     raise RuntimeError("Condition: {cond!r} went wrong. The "
            #                        "expected output, {out!r}  could be not "
            #                        "be obtained".format(cond=condition,
            #                                             out=item['Expected Output']))
    # end eval_match_conditions

    def is_valid_keys(self, listH):
        """
        Syntax sugar to check to make sure that given list keys are valid for
        during evaluating match objects.
        """
        tempConditionListKeys = [x.lower() for x in self.validConditionKeys]
        for it in listH:
            if it.lower() not in tempConditionListKeys:
                raise RuntimeError("Got bad key: {k!r} for "
                                   "match evaluation".format(k=it))
        return True
    # end is_valid_keys

    def get_relative_path(self, childPath, parentPath,
                          searchParentDirectories=False):
        """
        NOTE: replace with os.path.relpath and simply remove ("/", "\\" from
        the beginning of the string)

        .. Danger::
         Actually, didn't I already make this in the paths.py module?

        Args:
            childPath (str): The path that is suspected to be within the
                             parentPath
            parentPath (str): The suspected parent folder of childPath, which
                              shares a common root
            searchParentDirectories (bool): Searches up the parentPath for a
                                            relative path

		Returns:
            str: The relative path between childPath and parentPath
        """
        relPath = os.path.relpath(childPath, parentPath)
        if relPath.startswith("..") and not searchParentDirectories:
            return  # returns None, because the operation is not allowed

        while True:
            # relpath occassionally prefixes paths with '/' in Linux, which
            # will break windows paths. Remove now
            #
            if relPath.startswith('/', '\\'):
                relPath = relPath[1:]
            else:
                break
        return relPath
    # end get_relative_path

    # def change_path_to_current_os(self):
    #     """
    #     .. note::
    #         Only works on the Montgomery Hall machines (assumes a specific
    #         folder structure)
    #     """
    #     pathOS = get_path_os(self.currentMatch)
    #     sysOS = sys.platform
    #     re.
    #     if pathOS != "linux2" and sysOS == "linux2":
    #         temp = paths.os_path_split_asunder(self.currentMatch,
    #                                            replaceSeparators=True)[4]
    #         self.currentMatch = os.path.join(consts.PROJECT_ROOT_LIN, temp)
    #         return self.currentMatch
    #     elif pathOS != "win32" and sysOS == "win32":
    #         temp = paths.os_path_split_asunder(self.currentMatch,
    #                                            replaceSeparators=True)[3]
    #         self.currentMatch = os.path.join(consts.PROJECT_ROOT_WIN, temp)
    #         return self.currentMatch
    #     elif pathOS not in consts.SUPPORTED_OS_LIST:
    #         LOGGER.critical("The Path OS given is not supported by the current "
    #                         "environment. Please contact system admin")
    #         return None
    #     elif sysOS not in consts.SUPPORTED_OS_LIST:
    #         LOGGER.critical("The OS given is not supported by the current "
    #                         "environment. Please contact system admin")
    #         return None
    # # end change_path_to_current_os

    def change_relative_to_absolute_path(self):
        """
        Convenience method for change a relative path into its absolute path
        using self.rootDir as its base
        """
        pass
    # end change_relative_to_absolute_path

    def change_paths(self, dictH, contentLines):
        """
        Originally called set_abs_path_to_rel_path but renamed because the
        script now supports the processing of absolute paths and relative paths.
        In addition, the path the ability to change separators, attempt to find
        relative paths that are in parent directories, and more
        """
        for key, item in dictH:
            for condition, output in self.conds.iteritems():
                if condition() == output:
                    # do something
                    pass

                temp = '[+] "{p}" relative path created from the '\
                       'absolute path, "{p1}"'.format(p=matchNew,
                                                      p1=match)
                Logger().info(temp)
    # end change_paths
# end PathFinder


class PathFinderMaya(PathFinder):
    def __init__(self, filePath, rootPath=op.StaticOperation.defaultRootDirText,
                 checkExist=True, seek=False, recursiveSearchFiles=False,
                 passUnknownPaths=False, autoResolveOSPaths=False,
                 normalizePaths=True):
        """
        Args:
            filePath (str): The full file path of the file to be queried
            rootPath (str): The root directory, from which relative paths will
                            be set
            checkExist (bool): Only allows the operation of a file if it exists
            seek (bool): When enabled, will find relative paths above the root
                         directory
            .. warning::
                This is NOT advised for programs that do not support ../ syntax
                for dependencies (ex: Maya can use ../ for references but not
                for textures)

            recursiveSearchFiles (bool): When enabled, will search referencial
                                         scene files for other dependencies,
                                         until the script runs out of new scene
                                         files to parse and search.
            passUnknownPaths (bool): If a path cannot be proven to be absolute
                                     or relative, the script will not attempt
                                     to "find" the file and simply pass it.
                                     Enable if script execution is slow
            autoResolveOSPaths (bool): Even if a path originates from another
                                       OS, presuming that the path is on an
                                       identical folder structure on a
                                       dual-boot network machine (our setup),
                                       the script will get process the path by
                                       removing the OS component and swapping
                                       it with the current OS.

            .. important::
                For the current project, it looks in the
                collaborative_space/project_name to perform this

            :AUTHORNOTE: Test this when you've got the script working before
            creating a commit to the environment
        """
        super(PathFinderMaya, self).__init__(filePath, rootPath)
        # configuration options (application-specific)
        self.sceneFileExtensions = ('.ma')
        self.maxParentCount = 3
        self.rootPath = rootPath
        self.init_root_path()
    # end __init__
# end PathFinderMaya


def get_path_os(path):
    """
    OS-independent method to predict the system's path OS
    """
    pathSplit = paths.os_path_split_asunder(path, replaceSeparators=True)
    if re.match('^[a-zA-Z]:', pathSplit[0]) is not None:
        return "win32"
    else:
        return "linux2"
# end get_path_os


def find(c, listH):
    for i, colour in enumerate(listH):
        try:
            j = colour.index(c)
        except ValueError:
            continue
        yield [i, j]
# end find


def change_path_to_current_os(path):
    """
    .. danger::
        This script is meant for use in Montgomery Hall's labs. Don't use
        outside of the SCAD environment

    This will convert absolute paths that are from a different OS to the OS
    that the user is currently using (so linux to windows and windows to linux)

    .. note::
        Right now, the function supports the conversion of the following:
            - The local machine's custom temporary drive
            - The student home space
            - the network drive

    """
    multiSep = "[" + "|".join(["\\", "\\\\", "/", "//"]) + "]"
    winTemp = r"D:{}".format(multiSep)
    linuxTemp = "/Temp/"
    linNet = r"/home"
    # I can't presume that the person messing with absolute/relative paths
    # is actually the current user so instead, I'll attempt to find a valid
    # name for a username
    #
    """
    try:
        linNet = [os.path.join(linNet, x) for x in os.listdir(linNet) \
                  if re.match("([a-zA-Z]{4,6}[0-9]{0,2})",
                              os.path.join(linNet, x)) is not None][0]
    except KeyError:
        # No valid username was found in the /home directory
        return None
    """
    linNet = "/home/ckenne24"
    linuxStuhome = os.path.join(linNet, "mount", "stuhome/")
    linNet = os.path.join(linNet, "mount", "collaborative/")
    winStuhome = r"H:{}".format(multiSep)
    winNetwork = r"I:{}Savannah{}CollaborativeSpace{}".format(multiSep,
                                                              multiSep,
                                                              multiSep)
    compileString = """
                    ^(?P<linuxTemp>{})?
                    (?P<winTemp>{})?
                    (?P<linuxStuhome>{})?
                    (?P<winStuhome>{})?
                    (?P<linNet>{})?
                    (?P<winNetwork>{})?
                    """.format(linuxTemp, winTemp,
                               linuxStuhome, winStuhome,
                               linNet, winNetwork)
    matchSectionPairs = [["linuxTemp", "winTemp"],
                         ["linuxStuhome", "winStuhome"],
                         ["linNet", "winNetwork"]]
    matchInfo = {"linuxTemp": linuxTemp, "winTemp": winTemp,
                 "linuxStuhome": linuxStuhome, "winStuhome": winStuhome,
                 "linNet": linNet, "winNetwork": winNetwork}
    possibleMatchSections = [x for sublist in matchSectionPairs for x in sublist]
    reCompile = re.compile(compileString, re.VERBOSE)
    reMatch = re.match(reCompile, path)
    for section in possibleMatchSections:
        matchReturn = reMatch.group(section)
        if matchReturn is not None and matchReturn.strip() != "":
            foundIndex, nestedIndex = next(find(section, matchSectionPairs))
            matchText = matchInfo[section]
            nestedIndex = 1 - nestedIndex  # invert to find the section's pair
            listBlock = matchSectionPairs[foundIndex][nestedIndex]
            replaceText = matchInfo[listBlock]
            replaceOutput = path.replace(matchReturn, replaceText)
            return os.path.normpath(replaceOutput)
    # if the script got this far, then no match was found and replaced
    # just reset it to keep the script sane
    #
    return path
# end change_path_to_current_os


def main():
    """
    quick test
    """
    path1 = "/home/ckenne24/mount/stuhome/"
    path2 = "/home/ckenne24/mount/collaborative/"
    path3 = "Temp/"
    path4 = "H:\\"
    path5 = "I:\\Savannah\\CollaborativeSpace\\"
    path6 = "D:\\"
    path = [path1, path2, path3, path4, path5, path6]
    for p in path:
        change_path_to_current_os(p)
# end main

def copytree(src, dest):
    """ Mimics the functionality of shutil.copytree() without its recursivion

    directories are built using os.makedirs()
    file literals are copied with shutil.copy2()
    """
    if not os.path.isdir(src) and not os.path.isfile(src):
        raise IOError("Invalid path: {} specified. "
                      "Not file or folder".format(src))

    if os.path.isdir(src) and not os.path.isdir(dest):
        mkdir_p(dest)
    elif os.path.isfile(src) and not os.path.isfile(dest):
        dir, f = os.path.splitdrive(dest)
        mkdir_p(dir)
        shutil.copy2(src, dest)
# end copytree


def test_syncmeister_0001():
    """
    Quick test module
    """
    rootDir = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/syncmeister/test/src_location/created_project"
    filePath = os.path.join(rootDir, "scenes/simple.ma")

    # rootDir = r"/home/selecaotwo/Desktop"
    # filePath = os.path.join(rootDir, "simple.ma")

    # rootDir = r"/media/TOSHIBA EXT/the_LATEST/sys_PY/py_MODULES/syncmeister/test/src_location/created_project"
    # filePath = os.path.join(rootDir, "scenes", "simple.ma")
    if not os.path.isdir(rootDir):
        raise IOError("Path: {!r} does not exist!".format(rootDir))
    elif not os.path.isfile(filePath):
        raise IOError("File: {!r} does not exist!".format(filePath))

    LOGGER.info("Using Maya file %s..." % filePath)

    with open(filePath, "r") as f:
        contents = f.readlines()

    sysOS = sys.platform
    pathFinder = PathFinderMaya(filePath, rootDir)
    quotedLines = engine.get_substring_from_quotes(contents)
    for index, match in quotedLines.iteritems():
        for m in match:
            pathFinder.currentMatch = m
            orig, modified = pathFinder.eval_match_conditions()
            if modified is not None and orig != modified:
                # do something
                pass
    #     print contents[index]
    #     print line
# end test_syncmeister_0001


if __name__ == "__main__":
    test_syncmeister_0001()
