#ifndef XGARCHIVEPRIMITIVECONTEXT_H
#define XGARCHIVEPRIMITIVECONTEXT_H

#include "XGen/XgPrimitiveContext.h"

class XGEN_EXPORT XgArchivePrimitiveContext: public XgPrimitiveContext
{
	friend class XgArchivePrimitive;

public:
	XgArchivePrimitiveContext() :
        _archiveFrame( 0.0 ),
        _aIndex( 0 )
        {}
	virtual ~XgArchivePrimitiveContext(){}

    /** Bounding box calculation. */
    virtual SgBox3d boundingBox() const;

    /** @name Accessors */
    //@{
    int index(unsigned int i) const { return _index[i]; }
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

    /* Animation Frame for the archive*/
    double archiveFrame() const { return _archiveFrame; }

private:
    double _archiveFrame;
    static const int INDEX_COUNT = 4;   // Turbo: TODO: XgArchivePrimitive::INDEX
    int _index[INDEX_COUNT];
    unsigned int _aIndex;
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
