// Copyright 2013 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.

/**
 * @file XgExternalAPI.h
 * @brief Contains the declaration of various external API methods.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Thomas V Thompson II
 * @author Ying Liu
 *
 * @version Created 06/30/08
 */
#ifndef __XGEXTERNALAPI_H__
#define __XGEXTERNALAPI_H__

#include <stddef.h>
#include <string>
#include <vector>
#include <set>
#include "XgWinExport.h"

namespace xgapi
{
    //
    // Creation
    //

    /* Create a new description. */
    extern XGEN_EXPORT std::string createDescription( const std::string &palette,
                                   const std::string &description,
                                   const std::string &primitive,
                                   const std::string &generator,
                                   const std::string &renderer,
                                   const std::string &method );

    /* Create a new palette. */
    extern XGEN_EXPORT bool createPalette( const std::string &palette );

    //
    // Deletion
    //

    /* Delete a palette. */
    extern XGEN_EXPORT bool deletePalette( const std::string &palette );

    /* Delete a description. */
    extern XGEN_EXPORT bool deleteDescription( const std::string &palette,
                            const std::string &description );

    //
    // Object access
    //

    /* Get the list of palettes. */
    extern XGEN_EXPORT std::vector<std::string> palettes();

    /* Get the list of descriptions for a palette. */
    extern XGEN_EXPORT std::vector<std::string> descriptions( const std::string &palette="" );

    /* Get the palette for a description. */
    extern XGEN_EXPORT std::string palette( const std::string &description );

    /* Get the active object subtype from a description. */
    extern XGEN_EXPORT std::string getActive( const std::string &palette,
                           const std::string &description,
                           const std::string &type );

    /* Set the active object subtype from a description. */
    extern XGEN_EXPORT bool setActive( const std::string &palette,
                    const std::string &description,
                    const std::string &subtype,
                    bool previewer=false );

    /* Get a list of all objects for a description. */
    extern XGEN_EXPORT std::vector<std::string> objects( const std::string &palette,
                                      const std::string &description,
                                      bool activeOnly=false );

    /* Initialize the descriptions interpolation. */
    extern XGEN_EXPORT bool initInterpolation( const std::string &palette,
                            const std::string &description,
                            const std::string &fileName="" );

    //
    // Attribute access
    //

    /* Query the existance of an attribute. */
    extern XGEN_EXPORT bool attrExists( const std::string &attrName,
                     const std::string &palette,
                     const std::string &description="",
                     const std::string &object="" );

    /* Get an attribute value given an attribute name. */
    extern XGEN_EXPORT std::string getAttr( const std::string &attrName,
                         const std::string &palette,
                         const std::string &description="",
                         const std::string &object="" );

    /* Set an attribute given an attribute name. */
    extern XGEN_EXPORT bool setAttr( const std::string &attrName,
                  const std::string &value,
                  const std::string &palette,
                  const std::string &description="",
                  const std::string &object="" );

    /* Set an texture attribute given an attribute name. */
    extern XGEN_EXPORT bool setTextureAttr( const std::string &attrName,
                         const std::string &texture,
                         const std::string &palette,
                         const std::string &description="",
                         const std::string &object="" );

    /* Get the list of attributes. */
    extern XGEN_EXPORT std::vector<std::string> attrs(const std::string &palette,
                                   const std::string &description="",
                                   const std::string &object="" );

    /* Add a custom attribute given an attribute name. */
    extern XGEN_EXPORT void addCustomAttr( const std::string &attrName,
                        const std::string &palette,
                        const std::string &description="",
                        const std::string &object="" );

    /* Remove a custom attribute given a long form attribute name. */
    extern XGEN_EXPORT void remCustomAttr( const std::string &attrName,
                        const std::string &palette,
                        const std::string &description="",
                        const std::string &object="" );

    /* Get the list of custom attributes. */
    extern XGEN_EXPORT std::vector<std::string> customAttrs(const std::string &palette,
                                         const std::string &description="",
                                         const std::string &object="" );

    /* Get the list of all attributes. */
    extern XGEN_EXPORT std::vector<std::string> allAttrs(const std::string &palette,
                                      const std::string &description="",
                                      const std::string &object="" );

    /* Get the attribute values from an xGen file.
        @param name attribute name
        @param requestedType xGen types such as Palette and Description.
        @param fileName file name containing the attributes such as .xgen and .xdsc file types.
        @return vector of attribute values
    */
    extern XGEN_EXPORT std::vector<std::string> getAttrFromFile(   const std::string &name,
                                                const std::string &requestedType,
                                                const std::string &fileName );

    //
    // Namespace support
    //

    /* Return the namespace of the given object. */
    extern XGEN_EXPORT std::string objNameSpace( const std::string &objName );

    /* Return the namespace of the given object in its short form. */
    extern XGEN_EXPORT std::string objBaseNameSpace( const std::string &objName );

    /* Strip the namespace from the given object. */
    extern XGEN_EXPORT std::string stripNameSpace( const std::string &objName );

    //
    // FX Modules
    //

    /* Get the list of registered modules of all types (FX, primitives, etc). */
    extern XGEN_EXPORT std::vector<std::string> availableModules();

    /* Get the list of fx modules for active primitive. */
    extern XGEN_EXPORT std::vector<std::string> fxModules( const std::string &palette,
                                        const std::string &description );

    /* Get the type for a particular fx module. */
    extern XGEN_EXPORT std::string fxModuleType( const std::string &palette,
                              const std::string &description,
                              const std::string &name );

    /* Add an fx module to the description. */
    extern XGEN_EXPORT std::string addFXModule( const std::string &palette,
                             const std::string &description,
                             const std::string &type,
                             const std::string &name="" );

    /* Remove a named fx module from description. */
    extern XGEN_EXPORT bool removeFXModule( const std::string &palette,
                         const std::string &description,
                         const std::string &name );

    /* Move a named fx module up or down chain. */
    extern XGEN_EXPORT bool moveFXModule( const std::string &palette,
                       const std::string &description,
                       const std::string &name,
                       int dir );

    /* Return if the given fx module will be included when exporting the description as preset. */
    extern XGEN_EXPORT bool fxModuleIncludedInPreset( const std::string &palette,
                       const std::string &description,
                       const std::string &name );

    //
    // Culling
    //

    /* Return the names of the patches with culled primtives. */
    extern XGEN_EXPORT std::vector<std::string> culledPrimPatches(const std::string &palette,
                                               const std::string &description);

    /* Return the faces on a patch where primtives are culled. */
    extern XGEN_EXPORT std::vector<int> culledPrimFaces( const std::string &palette,
                                      const std::string &description,
                                      const std::string &patchName );

    /* Return culled primitives on a face. */
    extern XGEN_EXPORT std::set<unsigned int> culledPrims( const std::string &palette,
                                        const std::string &description,
                                        const std::string &patchName,
                                        const int faceId );

    //
    // Patch
    //

    /* Get the names of the geometry bound to a description. */
    extern XGEN_EXPORT std::vector<std::string> boundGeometry( const std::string &palette,
                                            const std::string &description );

    /* Get the faces bound to a piece of geometry. */
    extern XGEN_EXPORT std::vector<int> boundFaces( const std::string &palette,
                                 const std::string &description,
                                 const std::string &patchName,
                                 bool base=false );

    //
    // File IO
    //

    /* Import a palette, apply deltas, optionally into a namespace. */
    extern XGEN_EXPORT std::string importPalette( const std::string &palette,
                               const std::vector<std::string> &deltas,
                               const std::string &nameSpace="" );

    /* Export a palette. */
    extern XGEN_EXPORT bool exportPalette( const std::string &palette,
                        const std::string &fileName );

    /* Create a snapshot if there is no snapshot for this palette. */
    extern XGEN_EXPORT bool initSnapshot(const std::string &palette );

    /* Check if delta file can be created for the palette. */
    extern XGEN_EXPORT bool canCreateDelta( const std::string &palette );

    /* Create delta file for the palette. */
    extern XGEN_EXPORT int createDelta( const std::string &palette,
                     const std::string &newDelta );

    /* Apply delta to an existing palette. */
    extern XGEN_EXPORT bool applyDelta( const std::string &paletteName,
                     const std::string &delta );

    /* Import a description. */
    extern XGEN_EXPORT std::string importDescription( const std::string &palette,
                                   const std::string &fileName );

    /* Export a description. */
    extern XGEN_EXPORT bool exportDescription( const std::string &palette,
                            const std::string &description,
                            const std::string &fileName,
                            bool guides = false );

	    /* Import a preset. */
    extern XGEN_EXPORT std::string importDescriptionAsPreset( const std::string &palette,
                                   const std::string &fileName );

    /* Export a description as preset. */
    extern XGEN_EXPORT bool exportDescriptionAsPreset( const std::string &palette, 
                            const std::string &description, 
                            const std::string &fileName, 
                            bool activeModuleOnly = false,
                            bool guides = false );

    /* Import an fx module. */
    extern XGEN_EXPORT std::string importFXModule( const std::string &palette,
                                const std::string &description,
                                const std::string &fileName );

    /* Export an fx module. */
    extern XGEN_EXPORT bool exportFXModule( const std::string &palette,
                         const std::string &description,
                         const std::string &name,
                         const std::string &fileName );

    //
    // Messages
    //

    /* Set the level for the types of messages. */
    extern XGEN_EXPORT void setMessageLevel( const std::string &type, unsigned int level );

    /* Get the level for the types of messages. */
    extern XGEN_EXPORT int getMessageLevel( const std::string &type );

    /* Log a message to the console. */
    extern XGEN_EXPORT void logMessage( const std::string &type, unsigned int level,
                     const std::string &mesg, const std::string &filename,
                     int linenum );

    //
    // Utilities
    //

    /* Get the XGen root directory. */
    extern XGEN_EXPORT std::string rootDir();

    /* Get the XGen icon directory. */
    extern XGEN_EXPORT std::string iconDir();

    /* Get the XGen version. */
    extern XGEN_EXPORT std::string version();

    /* Global repo directory. */
    extern XGEN_EXPORT std::string globalRepo();

    /* Local repo directory. */
    extern XGEN_EXPORT std::string localRepo();

    /* User repo directory. */
    extern XGEN_EXPORT std::string userRepo();

    /* Directory that holds index.html for the XGen docs. */
    extern XGEN_EXPORT std::string docsDir();

    /* Expand a string parameter into the textual name of a directory/file. */
    extern XGEN_EXPORT std::string fileCleanup( const std::string &inStr );

    /*
        Expand a string path into the textual name of a directory/file. The return value is prepended with
        the palette's xgDataPath if the path is relative and desc is valid, if desc is not valid path is prepended
        with ${PROJECT}/xgen where ${PROJECT} is the value returned by XgConfig::getProjectPath().

        The original path value is returned if path cannot be fully expanded.
    */
    extern XGEN_EXPORT std::string expandFilepath( const std::string &path,
                                const std::string &descr,
                                bool isDir=true,
                                bool createDir=false,
                                const std::string &patch="",
                                const std::string &moduleName="" );

    /* Promote function. */
    extern XGEN_EXPORT std::string promoteFunc();

    /* Prepare a string for a text editor. */
    extern XGEN_EXPORT std::string prepForEditor(const std::string &inStr);

    /* Prepare a string for an attribute. */
    extern XGEN_EXPORT std::string prepForAttribute(const std::string &inStr);
    /* Expand a string parameter into a map name with full path and find the file in the xgPath.
       Return expandedFileName if the file was found within the xgPath and empty string  otherwise. */
    extern XGEN_EXPORT std::string findFileInXgDataPath( const std::string &origFileName,
                                  const std::string &patchName="",
                                  const std::string & palette="",
                                  const std::string & description="",
                                  const std::string &moduleName="",
                                  bool quiet=false,
                                  double u=0.0, double v=0.0, int faceId=0 );

    /* Setup the configuration for Xgen. */
    extern XGEN_EXPORT void initConfig( const std::string& path );

    /* set the project path for XGen */
    extern XGEN_EXPORT void setProjectPath( const std::string& path );

    /* returns the current project path for XGen */
    extern XGEN_EXPORT std::string getProjectPath( );

    // Here are some things in the maya Cmd list that should be converted
    // to be python API things. They aren't maya specific so need not be
    // commands in maya.

    // XgmClumpMapCmd  --  left as command since closest point is maya only
    // XgmCopyDescriptionCmd  --  but need to wrap result...
    // XgmDensityCompCmd
}
#endif
