// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgSpherePrimitive.h
 * @brief Contains the declaration of the class XgSpherePrimitive.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Ernie Petti
 * @author Thomas V Thompson II
 * @author Stephen D. Bowline
 *
 * @version Created 12/04/02
 */

#ifndef XGSPHEREPRIMITIVE_H
#define XGSPHEREPRIMITIVE_H

#include <iostream>
#include <string>

#include "XGen/XgUtil.h"
#include "XGen/XgPrimitive.h"
#include "XGen/SgVec3T.h"
#include "XgWinExport.h"
#include "XGen/XgSpherePrimitiveContext.h"

class XgDescription;
class XgPatch;


/**
 * @brief A primitive of a sphere primitive.
 *
 * This class represents a sphere primitive.  It contains all of the attributes
 * that are needed to completely describe the sphere primitive.
 */
class XGEN_EXPORT XgSpherePrimitive : public XgPrimitive
{
public:

    /* Constructor. */
    XgSpherePrimitive( XgDescription *descr );

    /* Destructor. */
    virtual ~XgSpherePrimitive();

    void createContext();
    virtual XgPrimitiveContext* cloneContextImp();
    XgSpherePrimitiveContext* context() const { return (XgSpherePrimitiveContext*)_context; }
    XgSpherePrimitiveContext* context() { return (XgSpherePrimitiveContext*)_context; }

    /** @name Accessors */
    //@{
    const XgExpression &twist() const { return _twist; }
    //@}
    
    /** Cached attributes */
    //@{
    virtual unsigned int finalCVCount() { return 4; }
    //@}

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );

    /** Return the name of this type of primitive. */
    virtual std::string typeName() const { return "SpherePrimitive"; }

    /* Bounding box for the cached guide. */
    virtual SgBox3d guideBoundingBox( unsigned int index ) const;

    /** Minimum number of CVs allowed for a guide of this primitive. */
    virtual unsigned int minGuideCVCount() const { return 4; }
    
    /* Default shape for a new guide. */
    virtual void defaultGuideGeom( XgGuide &guide );
    
    /* Verify the vertices meet the constraints of the sphere primitive. */
    virtual void verifyGuideGeom( safevector<SgVec3d> &cpts );

    /* Transformation matrix in description space, computed from
     * the cGeom points. */
    SgXform3d transformation() const;

    /** Get external file paths used in the primitive. */
    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

protected:

    /** No definition by design to prevent accidental default construction. */
    XgSpherePrimitive();
    
    /** No definition by design so accidental copying is prevented. */
    XgSpherePrimitive( const XgSpherePrimitive &primitive );

    /** No definition by design so accidental assignment is prevented. */
    XgSpherePrimitive &operator=( const XgSpherePrimitive &primitive );

    /* Make the cached geometry for this primitive. */
    virtual void mkGeometry( double u, double v );
    virtual void mkGeometryInParallel( XgPrimitiveContext &context, double u, double v );

    /* Helper for creating the cached geometry from attributes. */
    void mkGeometryFromAttrs( double u, double v );
    void mkGeometryFromAttrsInParallel( XgPrimitiveContext &context, double u, double v );
    
    /* Helper for creating the cached geometry from guides. */
    void mkGeometryFromGuides( double u, double v );
    void mkGeometryFromGuidesInParallel( XgPrimitiveContext &context, double u, double v );
    
    /* Sphere attributes. */
    XgExpression _twist;
};


#endif
