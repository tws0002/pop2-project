// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgConfig.h
 * @brief Contains the declaration of the class XgConfig.
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
 *
 * @version Created 05/10/11
 */

#ifndef XGCONFIG_H
#define XGCONFIG_H

#include <string>
#include "XgWinExport.h"

/**
 * @brief This class holds configuration settings for XGen.
 *
 * This class holds any global configuration settings for XGen controlled
 * by the environment. These would be things like where expressions are
 * saved, documentation lives, and so forth.
 */
class XGEN_EXPORT XgConfig
{
public:

    /** Configuration state singleton. */
    static XgConfig *state();

    /** Init the XgConfig singleton object. */
    void init( const std::string& projectPath );

    /** @name Config accessors */
    //@{
    const std::string &globalRepo() const { return _globalRepo; }
    const std::string &localRepo() const { return _localRepo; }
    const std::string &userRepo() const { return _userRepo; }
    const std::string &docs() const { return _docs; }
    const std::string &promoteFunc() const { return _promoteFunc; }
    bool flipParam() const { return _flipParam; }
    //@}

    /** @name Project path accessors */
    //@{
    void setProjectPath( const std::string& path );
    std::string getProjectPath( ) const;
    //@}

protected:

    /** Constructor. */
    XgConfig();
    
    /* Copy constructor.  Not defined so it is not accidentally called. */
    XgConfig(const XgConfig &config);
    
    /* Assignment operator.  Not defined so it is not accidentally called. */
    XgConfig &operator=(const XgConfig &config);

private:

    /* Load the config file */
    bool loadConfig( const std::string &fileName, bool quiet=false );

    /* Load custom modules */
    void loadModules( const std::string &path );

    /* Print the configuration as warnings. */
    void printConfig(int warnlevel=1);
    
    /** Location of the global repository. */
    std::string _globalRepo;

    /** Location of the local repository. */
    std::string _localRepo;

    /** Location of the user repository. */
    std::string _userRepo;

    /** Location of the documentation. */
    std::string _docs;

    /** Function to handle promotion of primitive to elements. */
    std::string _promoteFunc;

    /** Current XGen project path **/
    std::string _projectPath;

    /** Initialization state **/
    bool _init;

    /** Flag for flipping parameterization on render. */
    bool _flipParam;
    
    /** Configuration state singleton. */
    static XgConfig *_state;
};

#endif
