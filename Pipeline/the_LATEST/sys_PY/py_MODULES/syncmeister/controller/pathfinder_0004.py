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
import collections

# IMPORT LOCAL LIBRARIES
import logger.common.loggingServices as loggingservices
LOGGER = loggingservices.init_logger()
import engine
import syncmeister.model.operation as op


# :AUTHORNOTE: include in a logger traceback?
# Reference: https://stackoverflow.com/questions/6200270/decorator-to-print-function-call-details-parameters-names-and-effective-values
#
def dump_args(func):
    "This decorator dumps out the arguments passed to a function before calling it"
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
    def __init__(self, filePath, rootPath, checkExist=True, seek=False,
                 recursiveSearchFiles=False, passUnknownPaths=False,
                 autoResolveOSPaths=False, normalizePaths=True):
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
        self.outputPaths = None
        self.filePath = filePath
        self.rootPath = rootPath
        self.checkExist = checkExist
        self.recursiveSearchFiles = recursiveSearchFiles
        self.seek = seek
        self.passUnknownPaths = passUnknownPaths
        self.autoResolveOSPaths = autoResolveOSPaths
        self.normalizePaths = normalizePaths
        self.currentMatch = ""

        # application-specific information
        self.sceneFileExtensions = ()
        self.validConditionKeys = ["Expected Output", "Exceptions"]
        # init manager which will decide how matches pass or fail
        self.op = op.StaticOperation()
        self.init_match_conditions()
    # end __init__

    def init_application_specific_members(self):
        """
        Creates any application information, like valid scene files and the like.
        This was broken into a separate function so that it could be operwritten
        """
        raise NotImplementedError("Base class should not be used directly. "
                                  "Subclass PathFinder to add "
                                  "application-specific information")
    # end init_application_specific_members

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
                                           "Exceptions": {self.op.CONTINUE}}
        self.conds[self.match_to_normalize] = {"Expected Output": self.op.PASS,
                                               "Exceptions": {None: None}}
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

    def match_is_scene_file(self, match):
        """
        Checks if the current match is a valid scene file whose contents can be
        read recursively.

        If is a file and user wants a recursive search, the potential path
        is checked
        """
        if self.searchForFile and match.endswith(self.sceneFileExtensions) and \
                os.path.isfile(match):
            return self.op.RECURSIVE_SAME_CLASS
        else:
            return self.op.PASS
    # end match_is_scene_file

    def match_process_from_different_os(self, match):
        """
        Compares the current string, assuming that it is actually a path (it
        doesn't check to know whether it is one for a fact before computing) to
        the current system. If the two do not match, it checks for advice about
        how to process the path from the user

        .. note::
            If the path doesn't start with a drive-letter, the output basically
            assumes that the path is linux-based

        """
        pathOS = get_path_os(self.filePath)
        sysOS = sys.platform()

        if pathOS != sysOS and self.autoResolveOSPaths:
            return self.op.SWITCH
    # end match_process_from_different_os

    def match_is_absolute(self, match):
        """
        Method to determine if path can be proven as absolute by testing if it
        exists on the local machine
        """
        if os.path.isabs(match) and not os.path.isdir(match) and \
                not os.path.isfile(match):
            return self.op.Operation.CONTINUE  # doesn't exist - skip
        elif os.path.isabs(match) and (os.path.isfile(match) or os.path.isdir(match)):
            return self.op.Operation.SOMETHING  # :AUTHORNOTE: What do I do if the method passes? I just proved that a file/folder exists there
    # end match_is_absolute

    def match_is_relative(self, match):
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
        resolvedPath = os.path.normpath(os.path.join(rootPath, match))
        if os.path.isdir(os.path.join(rootPath, match)) or \
           os.path.isfile(os.path.join(rootPath, match)):
            self.op.Operation.SOMETHING  # :AUTHORNOTE: I just proved it was relative. Now what?
    # end match_is_relative

    def match_may_not_seek(self, match):
        """
        If the user has specified that the match is not allowed to seek above the
        parent directory and the (presumably) relative path is above the parent
        directory, treat as a failed condition. But if seek is enabled and it is,
        send it through. Else If the path is within the parent path then it
        doesn't matter what seek is
        """
        pass
    # end match_may_not_seek

    def match_must_exist(self, match):
        """
        Checks if the user cares if the file must be proven to exist.

        .. important::
            This method is going to be run AFTER our checks for proving if a
            file/folder is absolute or relative. That way, any file beyond that
            point must be resolved or it will be thrown away
        """
        if self.checkExist and not os.path.exists(match):
            return op.Operation.CONTINUE
        elif self.checkExist and os.path.exists(match):
            return op.Operation.SOMETHING  # :AUTHORNOTE: What do I write if it passes?
        elif not self.checkExist:
            # the user doesn't care if the object exists, so you might as well
            # continue processing it
            return op.Operation.SOMETHING
    # end match_must_exist

    def match_unknown_path_status(self, match):
        """
        Makes sure that if the user specifies to not process unknown paths that
        any and all unknown paths are not processed.

        .. important::
            The if self.passUnknownPaths condition ASSUMES that this method
            is being run at the very end of the script, after all other known
            methods of determining paths have been exhausted
        """
        if self.passUnknownPaths:
            return op.Operation.CONTINUE  # user wants to skip the path

        if os.path.exists(absPathAttempt):
            if checkExist and not os.path.isdir(absPathAttempt):
                # print "caught os.path.exists() exception"
                return op.Operation.CONTINUE  # skip

            if forceOSPaths is not None:
                # 707: change with os.path.relpath(match, rootPath)
                relativePath = get_relative_path(rootPath,
                                                 absPathAttempt,
                                                 forceOSPaths)
            else:
                # 707: change with os.path.relpath(match, rootPath)
                relativePath = get_relative_path(rootPath,
                                                 absPathAttempt,
                                                 forceOSPaths)

            temp = '[+] "{p}" relative path created from the '\
                   'absolute path, "{p1}"'.format(p=relativePath,
                                                  p1=match)
            Logger().info(temp)
    # end match_unknown_path_status

    @default_condition_try_behavior
    def eval_match_conditions(self):
        """
        Looks through the dictionary of match conditions and passes each
        function's output based on what each function returns

        .. authornote::
            Experimental. Don't use in production yet

        """
        for condition, item in self.conds.iteritems():
            self.is_valid_keys(item.keys())
            if condition() == self.op.CONTINUE:
                continue
            if condition() == self.op.PASS:
                pass
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
    def __init__(self, filePath, rootPath, checkExist=True, seek=False,
                 recursiveSearchFiles=False, passUnknownPaths=False,
                 autoResolveOSPaths=False, normalizePaths=True):
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
    def __init__(self):
        super(PathFinderMaya, self).__init__()

        # configuration options (application-specific)
        self.sceneFileExtensions = ('.ma')
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
    filePath = os.path.join(rootDir, "scenes/fake_truncated_mini_basic_test.ma")

    rootDir = r"/home/selecaotwo/Desktop"
    filePath = os.path.join(rootDir, "basic_test.ma")
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
            pathFinder.eval_match_conditions()

    #     print contents[index]
    #     print line
# end test_syncmeister_0001


if __name__ == "__main__":
    test_syncmeister_0001()
