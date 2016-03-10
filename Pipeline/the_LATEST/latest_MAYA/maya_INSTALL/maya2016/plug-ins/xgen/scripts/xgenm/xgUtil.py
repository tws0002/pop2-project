# Copyright (C) 1997-2013 Autodesk, Inc., and/or its licensors.
# All rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its licensors,
# which is protected by U.S. and Canadian federal copyright law and by
# international treaties.
#
# The Data is provided for use exclusively by You. You have the right to use,
# modify, and incorporate this Data into other products for purposes authorized 
# by the Autodesk software license agreement, without fee.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. AUTODESK
# DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
# INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
# OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS
# LICENSORS BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK AND/OR ITS
# LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.

##
# @file xgUtil.py
# @brief Contains utility functions for use in the base API.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Thomas V Thompson II
#
# @version Created 03/02/09
#

__all__ = [
    'stringToBool'
    ,'boolToString'
    ,'fixPath'
    ,'fixFolderPath'
    ,'callStack'
    ,'removeEndingSlash'
    ,'deleteFolder'
    ,'deleteEmptyFolder'
    ,'deleteEmptyFolderRecursive'
    ,'deleteContentFolder'
    ,'createFolder'
    ,'copyFolder'
    ,'promoteFuncTest'
]

def stringToBool(value):
    """Convert a string into a boolean."""
    value = str(value).lower()
    if value == 'True' or value == 'true' or value == 'on' or \
           value == '1' or value == 'one':
        return True
    return False

def boolToString(value):
    """Convert a boolean into a string."""
    if value:
        return "true"
    return "false"

def isPathRelative( path ):
    if path.startswith('/'):
        return False
    if len(path)>=3:
        if path[1] == ':' and (path[2] == '/' or path[2] == '\\'): #windows drive 
            return False
        if path[1] == '\\' and path[2] == '\\': # windows UNC
            return False
        if path[1] == '/'  and path[2] == '/' : # windows UNC
            return False
    return True

def fixPath( path ):
    """Fix a path for volumes that are moved around."""
    import os 
    if os.name == 'nt':
        path = path.replace( '\\', '/')    # we always use forward slashes in xgen

    return path

def fixFolderPath( path ):
    """ Fix up a folder path"""
    path = fixPath(path)
    if not path.endswith('/'):
        path = path + '/'
    return path    

def callStack(msg=''):
    """ print out a call stack trace """
    import inspect
    print 'call stack: %s' % msg
    for t in inspect.stack()[1:-1]:
        fp = t[0]
        print fp.f_code.co_filename, fp.f_lineno, fp.f_code.co_name

# folder/path helpers 
def removeEndingSlash( path ):
    if path.endswith('/'):
        path = path[:-1]
    return path

def deleteFolder( path ):
    """ delete folder path along with its content"""
    try:
        import shutil, os
        # delete content
        deleteContentFolder( path )
        # delete folder
        if os.path.exists(path):
            shutil.rmtree(path)
    except:
        import sys
        print sys.exc_info()[1]

def deleteEmptyFolder( path ):  
    """ delete folder path only if empty """  
    try:
        import os
        os.rmdir(path)
    except OSError as ex:
        import errno
        if ex.errno == errno.ENOTEMPTY:
            return False
    return True

def deleteEmptyFolderRecursive( path ):
    """ Remove all empty subdirs for the specified directory. Returns True on success, otherwise False """
    import os
    for root, dirs, files in os.walk(path, topdown=False):
        deleteEmptyFolder( root )

def deleteContentFolder( path ):
    """ Delete all files/folders in path """
    try:
        import shutil
        import os
        # get things from bottom to top to be able to remove fir content first
        for root, dirs, files in os.walk(path,topdown=False):
            for f in files:
                #print 'deleteContentFolder: ', os.path.join(root, f)
                os.unlink(os.path.join(root, f))
            for d in dirs:
                #print 'deleteContentFolder: ', os.path.join(root, d)
                shutil.rmtree(os.path.join(root, d))
    except:
        import sys
        print sys.exc_info()[1]

def createFolder( path ):
    """ create a folder if it doesn't exist yet """
    try:
        import os
        os.makedirs( path )
    except OSError as ex:
        import errno
        # ignore the error if the folder already exists
        if not ex.errno == errno.EEXIST:
            import sys
            print sys.exc_info()[1]

def copyFolder(src, dst, symlinks=False, ignore=None):
    import os
    import shutil
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        try:
            if os.path.isdir(s):
                if os.path.exists(d):
                    copyFolder(s, d, symlinks, ignore)
                else:
                    shutil.copytree(s, d, symlinks, ignore)
            else:
                # do not override existed file
                if os.path.abspath(s) != os.path.abspath(d):
                    shutil.copy2(s, d)
        except:
            print "Fail to copy file %s to %s" % (s, d)

def promoteFuncTest( filename ):
    """ promoteFuncTest is an example of a promote callback function."""
    print "promoteFuncTest called with '%s'\nFile content:\n" % filename
    with open(filename,'r') as f:
        print( f.read() )
