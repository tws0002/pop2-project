// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#include "XgGravityFXModule.h"

#include <XGen/XgCreator.h>
#include <XGen/XgDescription.h>
#include <XGen/XgPatch.h>
#include <XGen/XgPrimitive.h>

// Register the module.
XgRegisterFXModule(Gravity);

// Create all the expressions and set default values.
XgGravityFXModule::XgGravityFXModule( XgDescription *descr )
    : XgFXModule( descr, typeName() )
    , _gravity( "gravity", typeName(), descr, "0.3;" )
    , _downVector( "down", typeName(), descr, "[0.0,-1.0,0.0];", "vector" )
{
    setAttr( "name",    "Gravity"           );
    setAttr( "gravity", "0.3",              "expr" );
    setAttr( "down",    "[0.0,-1.0,0.0]",   "expr" );
}


// Do any cleanup you need (we need none).
XgGravityFXModule::~XgGravityFXModule()
{
}


// Evaluate the expressions and edit the spline points.
bool
XgGravityFXModule::compute()
{
    XgPrimitive *prim = _description->activePrimitive();
    const XgPatch *patch = prim->cPatch();

    const double primU = prim->cu();
    const double primV = prim->cv();
    const int primFaceID = prim->cFaceId();
    const std::string *patchName = &patch->name();

    // Evaluate the arguments.
    double g     = _gravity.eval(primU, primV, primFaceID, patchName)[0];
    SgVec3d down = _downVector.eval(primU, primV, primFaceID, patchName);
    if (down.length() < 1e-4) {
        return true;
    }
    down.normalize();

    // Get a reference to the array of spline control points.
    safevector<SgVec3d> & CVs = prim->cGeom();
    size_t numCVs = CVs.size();

    // Compute the geodesic distance of each point from the base
    // (hack: assumes we have a polyline rather than a spline).
    safevector<double> distances;
    distances.resize(numCVs);
    distances[0] = 0;

    for (size_t i = 1; i < numCVs; ++i) {
        SgVec3d v = CVs[i] - CVs[i - 1];
        double len = v.length();
        distances[i] = distances[i - 1] + len;
    }

    // For each control point, follow the down vector a distance relative
    // to the distance (along the curve) from the base.  Since CVs is
    // a reference to the points, the += changes the spline itself.
    for (size_t i = 1; i < numCVs; ++i) {
        CVs[i] += g * distances[i] * down;
    }

    return true;
}


// Set attribute values.
bool
XgGravityFXModule::setAttr( const std::string &name,
                         const std::string &value,
                         const std::string &type,
                         const std::string &uiHint )
{
    if ( XgFXModule::setAttr( name,value,type,uiHint ) ) return true;

    if (name == "gravity") {
        _gravity = value;
        return true;
    }

    if (name == "down") {
        _downVector = value;
        return true;
    }

    return false;
}
