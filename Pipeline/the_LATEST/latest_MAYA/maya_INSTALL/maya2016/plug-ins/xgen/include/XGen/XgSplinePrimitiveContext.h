#ifndef XGSPLINEPRIMITIVECONTEXT_H
#define XGSPLINEPRIMITIVECONTEXT_H

#include "XGen/SgVec3T.h"
#include "XGen/XgPrimitiveContext.h"
#include <XgWinExport.h>
#include <XgPorting/safevector.h>


class XgPatch;
class XgDescription;

class XGEN_EXPORT XgSplinePrimitiveContext: public XgPrimitiveContext
{
	friend class XgSplinePrimitive;

public:
	XgSplinePrimitiveContext():
	  _cTaper( 0.0 ),
	  _cTaperStart( 0.0 ),
	  _cW( SgVec3d(0.0,0.0,0.0) ),
	  _bestGuide(-1)
	{}
	virtual ~XgSplinePrimitiveContext(){}

    /** Bounding box calculation. */
    virtual SgBox3d boundingBox() const;

	/** @name Accessors */
	//@{
	int bestGuide() { return _bestGuide; }
	bool breakUp() { return _breakUp; }
	//@}

	/** @name Cached value accessors */
	//@{
	float cTaper() const { return _cTaper; }
	float cTaperStart() const { return _cTaperStart; }
	SgVec3d cW() const { return _cW; }
	void setWidth( SgVec3d &w ) { _cW = w; }
	//@}

    //@}
    
    /** Cached attributes */
    //@{
    virtual void packAttrs( safevector<float> &data,
        SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 );
    virtual void unpackAttrs( int version,
        const safevector<float> &data,
        unsigned int &index,
        SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 );
    //@}

protected:

	/* Compute the length of the spline. */
	virtual double computeLength() const;

	/* Cached spline attributes. */
	float _cTaper;         // Taper of the spline.
	float _cTaperStart;    // Start of taper of the spline.
	SgVec3d _cW;           // Width vector.

	/* Interpolation overrides. */
	bool _breakUp;
	int _bestGuide;
};

#endif

// ==================================================================
// Copyright 2014 Autodesk, Inc.  All rights reserved.
// 
// This computer source code  and related  instructions and comments are
// the unpublished confidential and proprietary information of Autodesk,
// Inc. and are  protected  under applicable  copyright and trade secret
// law. They may not  be disclosed to, copied or used by any third party
// without the prior written consent of Autodesk, Inc.
// ==================================================================
