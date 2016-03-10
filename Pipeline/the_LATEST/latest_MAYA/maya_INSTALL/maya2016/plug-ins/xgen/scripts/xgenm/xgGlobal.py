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
# @file xgGlobal.py
# @brief Contains global variables for use in the XGen API.
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

import string
import os
import xgenm as xgen

try:
    import maya.cmds
    Maya = 'about' in maya.cmds.__dict__
except:
    Maya = False

# Available modules

# List the modules of a given type, in alphabetic order, removing the suffix.
# On purpose, we don't cache, since we might be registering new modules at
# runtime, or deregestering the old.
def _getModules(typesuffix):
    n = len(typesuffix)
    modules = xgen.XgExternalAPI.availableModules()
    # remove the n-character suffix from the modules that match, ditch
    # the rest.
    modules = [ x[:-n] for x in modules if x.endswith(typesuffix) ]
    return sorted(modules)

def GeomTypes():
    """
    Return the Patch modules that are registered with XGen.
    """
    return _getModules("Patch")

def PrimitiveTypes():
    """
    Return the Primitive modules that are registered with XGen.
    """
    return _getModules("Primitive")

def GeneratorTypes():
    """
    Return the Generator modules that are registered with XGen.
    """
    return _getModules("Generator")

def FXModuleTypes():
    """
    Return the FXModule modules that are registered with XGen.
    """
    return _getModules("FXModule")

def RendererTypes():
    """
    Return the Renderer modules that are registered with XGen.
    """
    # There are three builtin renderers that are special: the GL previewer, and
    # two others used for internal purposes.  They shouldn't be listed.
    modules = _getModules("Renderer")
    filterlist = ( 'GL', 'Promote', 'Null' )
    return [ x for x in modules if x not in filterlist ]

PreviewerTypes = ['GL']
PreviewerIndex = {'GL':0}

# Callbacks
CallbackEvents = [':',':',':',':',':',':',':',':',':',':']
CallbackIndex = {'PostPaletteCreate':0,
                 'PostPaletteDelete':1,
                 'PostDescriptionCreate':2,
                 'CurrentDescriptionSet':3,
                 'RenderAPIRendererTabUIInit':4,
                 'RenderAPIRendererTabUIRefresh':5,
                 'ArchiveExport':6,
                 'ArchiveExportInfo':7,
                 'ArchiveExportInit':8,
                 'PostFXModuleUserAdd':9}

# UI globals
DescriptionEditor = None
Playblast = True
PlayblastWarning = True
LabelWidth = 0
Progress = None

def initXGen():
    """ Called from Maya when the xgen plugin gets loaded. initXGen is used for initializing 
        xgen components like XgConfig.
    """
    # get xgen project 
    projectpath = _getXGenProject( )

    if len(projectpath):
        # Only initialize things if we have a valid project. 

        # init XgConfig()
        xgen.XgExternalAPI.initConfig( projectpath )

        #create the user folder
        xgen.createFolder( xgen.XgExternalAPI.userRepo() )            

        # tell xgen about the new project 
        try:
            import xmaya.xgmExternalAPI as xgmapi
            xgmapi.setProjectPath( projectpath )
        except:
            pass

# xgen project path support
_xgProjectPathCBID = None

def onMayaProjectChangedCB():
    """ set xgen project path when the maya workspace is changed """
    try:    
        projectpath = _getXGenProject()
        import xmaya.xgmExternalAPI as xgmapi
        xgmapi.setProjectPath( projectpath )

    except:
        pass   

def _getXGenProject():
    """ 
    Set XGen with the current Maya workspace if we are in Maya and returns the new path. 
    Otherwise just fails and return an empty path.
    """
    global _xgProjectPathCBID

    projectpath = ''
    try:    
        import maya.cmds
        projectpath = maya.cmds.workspace(fn=True)
    except:
        pass   

    # setup a callback to automatically update the XGen project path when the current project is changed
    try:
        if _xgProjectPathCBID == None:
            import maya.cmds
            _xgProjectPathCBID = maya.cmds.scriptJob( event = ["workspaceChanged", onMayaProjectChangedCB] )    
    except:
        pass

    return str(projectpath)

class FolderTracker(object):
    """
    Helper for tracking down folders created in xgen. The tracker holds folder paths and deletes 
    them on request. Typically used for tracking folders created for collections and descriptions, 
    but could probably be used for other folder management tasks.
    """    

    # singleton instance for description builtin support
    _descInstance = None

    class Cache:
        """ Holds folder cache for a specific root path """
        def __init__(self,path):
            self._root = path # root of folders to manage
            self._folders = {}

        def add( self, path ):
            """ add new folder entry """
            key,folderPath = FolderTracker.pathKey( path )
            if key in self._folders:
                return

            if not folderPath.startswith( self._root ):
                # it should be at least a subdir of the current root 
                return

            # keep first in folder cache
            self._folders[key] = folderPath

        def remove( self, path ):
            """ remove folder entry without deleting the disk folder """
            key,folderPath = FolderTracker.pathKey( path )
            try:
                del self._folders[key]
            except:
                pass

        def removeAll( self ):
            """ clear the folder cache without deleting the disk folders """
            self._folders = {}

        def delete( self, path ):
            """ Delete path """
            key = self._deleteFolder( path )
            try:
                del self._folders[key] 
            except:
                pass

        def deleteAll( self ):
            """ Delete all paths stored in the cache """
            for key in self._folders:
               self._deleteFolder( self._folders[key] )        
            self._folders = {}

        def rename( self, oldPath, newPath ):
            """ replace oldPath with newPath """ 
            if self.hasPath( oldPath ):
                self.remove( oldPath )                
                self.add( newPath )                

        def hasPath( self, path ):
            key, folderPath = FolderTracker.pathKey( path )
            return key in self._folders
                
        def _deleteFolder( self, path ):
            """ Delete this path and its empty parent paths. """            
            key,folderPath = FolderTracker.pathKey( path )
            if key in self._folders:            
                xgen.deleteEmptyFolderRecursive( folderPath )
            
            # get all subpaths starting from root and delete them if they are empty
            folders = self._parentPaths( folderPath )
            for f in folders:
                xgen.deleteEmptyFolder( f )
            return key

        def _parentPaths( self, path, maxdepth=30 ):
            """ Return list of parent paths for path """            
            i = 0
            subpaths = []
            while i < maxdepth:
                head,tail = os.path.split(path)
                i += 1
                if head == self._root:
                    break;
                path = head
                subpaths.append( path )
            return subpaths
    
    def __init__(self,type):        
        """ FolderTracker init """
        self._type = type
        self._cache = None # current root cache
        self._rootCache = {} # all root caches
        self._tracking = True # enable the tracker 

    @property
    def tracking(self):
        return self._tracking

    @tracking.setter
    def tracking(self,value):
        self._tracking = value

    @property
    def type(self):
        return _type

    @property
    def root(self):
        """ current root """
        try:
            return self._cache._root
        except:
            return ''

    @property
    def paths(self):
        """ all paths from the current root """
        self._ensureCache()
        return self._cache._folders.values()
        
    @staticmethod
    def create( type ):    
        """ 
        Creates an instance of this class for managing folders. 
        """
        if type == 'description':
            # builtin support for collection and description folders
            # Create as singleton instance which will be deleted when the module is unloaded. 
            if FolderTracker._descInstance == None:        
                try:
                    FolderTracker._descInstance = FolderTracker( type )
                except:
                    pass
            return FolderTracker._descInstance
        else:
            return FolderTracker( type )

    @staticmethod
    def pathKey( path ):
        folderpath = xgen.XgExternalAPI.fileCleanup(xgen.removeEndingSlash(path))
        return (hash(folderpath),folderpath)

    def _ensureCache(self):
        """ make sure we always use a cache object """
        if self._cache == None:
            try:
                #default to current project if not set
                import xmaya.xgmExternalAPI as xgmapi
                self.addRoot( xgmapi.paletteRootPath() )
            except:
                self.addRoot( 'undefined' )
        return self._cache

    def addRoot( self, path ):
        """ 
        Creates an entry in the root cache and sets the tracker with the new root cache. 
        note: adding root is ok when we are not in tracking mode.
        """
        key,rootPath = FolderTracker.pathKey( path )        
        if not key in self._rootCache:
            self._rootCache[key] = FolderTracker.Cache(rootPath)
        self._cache = self._rootCache[key]

    def add( self, path ):
        """ 
        Add folder to current cache. Always add only in tracking mode.
        """
        #print '>>>>>>>>>>> tracking:',self._tracking
        if self._tracking:
            self._cache = self._ensureCache()
            self._cache.add( path )

    def delete( self, path ):
        """ 
        Delete this path if part of the current cache 
        note: deleting is ok when we are not in tracking mode, whatever is in the cache should always be deletable.
        """        
        self._cache = self._ensureCache()
        self._cache.delete( path )

    def deleteAll( self ):
        """ Delete all paths and empty folders for all roots """
        for cache in self._rootCache:
            self._rootCache[cache].deleteAll( )

    def remove( self, path ):
        """ Remove this path """
        self._cache = self._ensureCache()
        self._cache.remove( path )

    def removeAll( self ):
        """ Remove the whole root cache """
        for cache in self._rootCache:
            self._rootCache[cache].removeAll( )
        self._cache = None

    def rename( self, oldPath, newPath ):
        """ Rename entry oldPath in current root to newPath """
        self._cache = self._ensureCache()
        self._cache.rename( oldPath, newPath )

    def hasPath( self, path ):
        """ return True if the path is contained in one of the roots """
        for cache in self._rootCache:
            if self._rootCache[cache].hasPath( path ):
                return True
        return False
    
    def dump( self ):
        self._cache = self._ensureCache()
        print '\n\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
        print 'current root:', self._cache._root
        for key in self._rootCache:
            print '---------------------------------------'
            print 'root : ', key, self._rootCache[key]._root
            for folder in self._rootCache[key]._folders:
                print '\t' + self._rootCache[key]._folders[folder]
        print '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n'

    @staticmethod
    def desc():
        """ return the folder tracker for description and collections (in Maya only) """
        if Maya:
            return FolderTracker.create('description')
        return None
