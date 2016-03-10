#ifndef XGSPHEREPRIMITIVECONTEXT_H
#define XGSPHEREPRIMITIVECONTEXT_H

#include "XGen/XgPrimitiveContext.h"

class XGEN_EXPORT XgSpherePrimitiveContext: public XgPrimitiveContext
{
    friend class XgSpherePrimitive;

public:
    XgSpherePrimitiveContext(){}
    virtual ~XgSpherePrimitiveContext(){}

	/** Bounding box calculation. */
	virtual SgBox3d boundingBox() const;

    /** Cached attributes */
    //@{
    virtual void packAttrs( safevector<float> &data,
        SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 );
    virtual void unpackAttrs( int version,
        const safevector<float> &data,
        unsigned int &index,
        SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 );
    //@}
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
