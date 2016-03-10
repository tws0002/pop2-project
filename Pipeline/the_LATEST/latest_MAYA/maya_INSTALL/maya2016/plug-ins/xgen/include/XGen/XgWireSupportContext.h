#ifndef XGWIRESUPPORTCONTEXT_H
#define XGWIRESUPPORTCONTEXT_H

#include "XGen/XgFXModuleContext.h"

class XGEN_EXPORT XgWireSupportContext : public XgFXModuleContext
{
public:
    XgWireSupportContext()
        : _xPosRef(&xPosRef)
        , _xNegRef(&xNegRef)
        , _yPosRef(&yPosRef)
        , _yNegRef(&yNegRef)
        , _axisRef(&axisRef)
        , _xPosAni(&xPosAni)
        , _xNegAni(&xNegAni)
        , _yPosAni(&yPosAni)
        , _yNegAni(&yNegAni)
        , _axisAni(&axisAni)
        , _kdtree(&kdtree)
    {}

    /** Members either reference to external attributes or internal attributes. */

    /** The reference wires as coord system curves */
    safevector<SgVec3d> *_xPosRef;
    safevector<SgVec3d> *_xNegRef;
    safevector<SgVec3d> *_yPosRef;
    safevector<SgVec3d> *_yNegRef;
    safevector<SgVec3d> *_axisRef;

    /** The animation wires as coord system curves */
    safevector<SgVec3d> *_xPosAni;
    safevector<SgVec3d> *_xNegAni;
    safevector<SgVec3d> *_yPosAni;
    safevector<SgVec3d> *_yNegAni;
    safevector<SgVec3d> *_axisAni;

    /** Points from the reference wire in searchable form */
    SgKdTree3d *_kdtree;

private:

    /** Members are allocated/deallocated internally */

    /** The reference wires as coord system curves */
    safevector<SgVec3d> xPosRef;
    safevector<SgVec3d> xNegRef;
    safevector<SgVec3d> yPosRef;
    safevector<SgVec3d> yNegRef;
    safevector<SgVec3d> axisRef;

    /** The animation wires as coord system curves */
    safevector<SgVec3d> xPosAni;
    safevector<SgVec3d> xNegAni;
    safevector<SgVec3d> yPosAni;
    safevector<SgVec3d> yNegAni;
    safevector<SgVec3d> axisAni;

    /** Points from the reference wire in searchable form */
    SgKdTree3d kdtree;
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
