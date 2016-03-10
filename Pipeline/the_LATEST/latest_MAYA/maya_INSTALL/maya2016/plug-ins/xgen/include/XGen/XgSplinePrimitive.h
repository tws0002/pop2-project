// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgSplinePrimitive.h
 * @brief Contains the declaration of the class XgSplinePrimitive.
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
 * @author Stephen D. Bowline
 * @author Ying Liu
 * @author Lawrence Chai
 *
 * @version Created 08/18/03
 */

#ifndef XGSPLINEPRIMITIVE_H
#define XGSPLINEPRIMITIVE_H

#include <string>

#include "XGen/XgUtil.h"
#include "XGen/XgPrimitive.h"
#include "XGen/XgExpression.h"
#include "XGen/SgVec3T.h"
#include "XGen/SgCurve.h"
#include <XgWinExport.h>
#include "XGen/XgSplinePrimitiveContext.h"

#include <XGen/SgRampUIComp.h>
#include <XgPorting/safevector.h>

class XgDescription;
class XgPatch;


/**
 * @brief A primitive of a spline primitive.
 *
 * This class represents a spline primitive.  It contains all of the attributes
 * that are needed to completely describe the spline primitive.
 */
class XGEN_EXPORT XgSplinePrimitive : public XgPrimitive
{
public:

    /* Constructor. */
    XgSplinePrimitive( XgDescription *descr );

    /* Destructor. */
    virtual ~XgSplinePrimitive();

	virtual void createContext();
	virtual XgPrimitiveContext* cloneContextImp();
	XgSplinePrimitiveContext* context() const { return (XgSplinePrimitiveContext*)_context; }
	XgSplinePrimitiveContext* context() { return (XgSplinePrimitiveContext*)_context; }

    /* Calculate the base width vector. */
    static void calcWidthVec( const SgVec3d &A, const SgVec3d &B,
                              const SgVec3d &N, const SgVec3d &U,
                              SgVec3d &W );
    
    /** @name Accessors */
    //@{
    unsigned int attrCVCount() const { return _attrCVCount; }
    unsigned int fxCVCount() const { return _fxCVCount; }
    bool uniformCVs() const { return _uniformCVs; }
    const safevector<double> &widthScale() const {return _widthScale; }
    void calulateWidthScale( int numCVs );
    
    const XgExpression &taper() const { return _taper; }
    const XgExpression &taperStart() const { return _taperStart; }
    const XgExpression &bendParam( int i ) const { return *(_bendParam[i]); }
    const XgExpression &bendU( int i ) const { return *(_bendU[i]); }
    const XgExpression &bendV( int i ) const { return *(_bendV[i]); }
    bool displayWidth() const { return _displayWidth; }
    bool faceCamera() const { return _faceCamera; }
    bool tubeShade() const { return _tubeShade; }

    int bestGuide() { return context()->_bestGuide; }
    bool breakUp() { return context()->_breakUp; }
    //@}

    /** @name Cached value accessors */
    //@{
    float cTaper() const { return context()->_cTaper; }
    float cTaperStart() const { return context()->_cTaperStart; }

    SgVec3d cW() const { return context()->_cW; }
    void setWidth( SgVec3d &w ) { context()->_cW = w; }
    //@}

    /** Cached attributes */
    //@{
    virtual unsigned int finalCVCount() { return _fxCVCount; }
    //@}

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value,
                          const std::string &type="float",
			  const std::string &uiHint="" );
    

    /** Return the name of this type of primitive. */
    virtual std::string typeName() const { return "SplinePrimitive"; }

    /* Bounding box for the cached guide. */
    virtual SgBox3d guideBoundingBox( unsigned int index ) const;

    /** Minimum number of CVs allowed for a guide of this primitive. */
    virtual unsigned int minGuideCVCount() const { return 3; }
    
    /* Default shape for a new guide. */
    virtual void defaultGuideGeom( XgGuide &guide );
    
    /* Prepare the guide cached geometry. */
    virtual void prepGuideCGeom( unsigned int index );

    /* Override interpolation for animated guides. */
    virtual void overrideGuidesWithCache();

    virtual void initModules();
    virtual void finishModules();

    /** Get external file paths used in the primitive. */
    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;
    
protected:

    /** No definition by design to prevent accidental default construction. */
    XgSplinePrimitive();
    
    /** No definition by design so accidental copying is prevented. */
    XgSplinePrimitive( const XgSplinePrimitive &primitive );

    /** No definition by design so accidental assignment is prevented. */
    XgSplinePrimitive &operator=( const XgSplinePrimitive &primitive );

    /* Make the cached geometry for this primitive. */
    virtual void mkGeometry( double u, double v );
	virtual void mkGeometryInParallel( XgPrimitiveContext& context, double u, double v );

    /* Helper for creating the cached geometry from attributes. */
    void mkGeometryFromAttrs( double u, double v );
	void mkGeometryFromAttrsInParallel( XgSplinePrimitiveContext& context, double u, double v );
    
    /* Helper for creating the cached geometry from guides. */
    void mkGeometryFromGuides( double u, double v );
	void mkGeometryFromGuidesInParallel( XgSplinePrimitiveContext& context, double u, double v );
    
    /* Record length changes after fx are applied. */
    virtual bool postApplyFX() { dirtyCLength(); return true; }
    virtual bool postApplyFxInParallel(XgPrimitiveContext& context) { context.dirtyCLength(); return true;}
    
    /* Set the number of cvs when using attributes. */
    void setAttrCVCount( unsigned int value );

    /* Spline attributes. */
    unsigned int _fxCVCount;
    unsigned int _attrCVCount;
    bool _uniformCVs;
    XgExpression _taper;
    XgExpression _taperStart;
    safevector<XgExpression*> _bendParam;
    safevector<XgExpression*> _bendU;
    safevector<XgExpression*> _bendV;

    /* Spline display and orientation. */
    bool _displayWidth;
    bool _faceCamera;
    bool _tubeShade;

    /* Width RampUIComp */
    SgRampUIComp            _widthRampUIComp;
    safevector<double>      _widthScale;

};

#endif
