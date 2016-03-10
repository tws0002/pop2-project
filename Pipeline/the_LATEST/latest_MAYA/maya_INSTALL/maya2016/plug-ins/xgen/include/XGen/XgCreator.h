// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgCreator.h
 * @brief Contains the declaration of the XgCreateObject function.
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
 * @version Created 05/28/02
 */

#ifndef XGCREATOR_H
#define XGCREATOR_H

#include <string>
#include "XgPorting/safevector.h"
#include "XgWinExport.h"


class XgDescription;

// XgCreatorFunction is a function that takes a XgDescription* and outputs
// an XgPrimitive*, XgFXModule*, XgPatch*, XgRenderer*, or XgGenerator*.
typedef void* (*XgCreatorFunction)(XgDescription *);

// Modules must register themselves, then they can be created.
// Returns true normally; return false if the name is already used.
// The easiest way to call this is to use XgRegisterFXModule or another
// one of those macros.
XGEN_EXPORT bool XgRegisterModule( const std::string & typeName, XgCreatorFunction create);

// Template helper class for registering a module.
// Note: this class is used in the define(s) below which are meant to be
//       used from the modules.  Therefore this class should not be exported
//       from this DLL.
template <class T>
class XgRegisterOnLoad {
    static void *create(XgDescription* descr) {
        return new T(descr);
    }
    public:
    XgRegisterOnLoad (const std::string& typeName) {
        XgRegisterModule(typeName, create);
    }
};
#define XgRegisterType__(name, type) \
    namespace { \
        namespace Xg##name##type##Registration { \
            static XgRegisterOnLoad<Xg##name##type> _(#name #type); \
        } \
    }
#define XgRegisterFXModule(name)    XgRegisterType__(name, FXModule)
#define XgRegisterPrimitive(name)   XgRegisterType__(name, Primitive)
#define XgRegisterGenerator(name)   XgRegisterType__(name, Generator)
#define XgRegisterPatch(name)       XgRegisterType__(name, Patch)
#define XgRegisterRenderer(name)    XgRegisterType__(name, Renderer)


// Create an object given a registered type.
XGEN_EXPORT void *XgCreateObject( const std::string &typeName, XgDescription *descr );

// Get the list of registered modules of any type.
XGEN_EXPORT void XgGetRegisteredModules( safevector<std::string> & out_modules );

#endif
