// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef XgPrimitiveUtils_h
#define XgPrimitiveUtils_h

#include "XgPorting/safevector.h"
#include "XGen/SgVec3T.h"
#include "XGen/SgXform3T.h"
#include "XgWinExport.h"

/**
 * Utility functions for xgen primitives: common bits of code between some (but
 * not all) of the primitive types.
 */
namespace XgPrimitiveUtils
{
    //
    // The sphere and archive primitive use a 4-point description of their
    // position, scale, and orientation.  The archive has another scale too.
    // Convert all that into a 4x4 affine transformation matrix.
    //
    XGEN_EXPORT SgXform3d get4PointTransform(
            const safevector<SgVec3d> & geom,
            double scale = 1.0);
};


#endif
