// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef XgGravityFXModule_h
#define XgGravityFXModule_h

class XgDescription;
class XgPatch;

#include <XGen/XgFXModule.h>

/**
 * @brief A custom XGen module to simulate gravity.
 *
 * Gravity pulls control points down.  The first control point doesn't move.
 * Each subsequent control point moves along the direction of gravity by
 * gravity * downVector.
 *
 * There's no hint of physical behaviour here, this is really just an example
 * of how to write an FX module.
 */
class XgGravityFXModule : public XgFXModule
{
public:
    XgGravityFXModule( XgDescription *descr );
    virtual ~XgGravityFXModule();

    // Name of the module.  Must end in "FXModule".
    // Need not be related to the class name.
    virtual std::string typeName() const { return "GravityFXModule"; }

    // Only works on spline primitives
    virtual bool worksOn( const std::string & primType ) const {
        return primType == "SplinePrimitive";
    }

    // Callback to actually run the simulation on the current active primitive
    virtual bool compute();

    // Handle setting custom attributes.
    virtual bool setAttr(const std::string &name,
                         const std::string &value,
                         const std::string &type="float",
                         const std::string &uiHint="" );

private:
    XgExpression _gravity;    // ratio how much to move along down vector
    XgExpression _downVector; // normally (0,-1,0) -- which way is down?
};

#endif
