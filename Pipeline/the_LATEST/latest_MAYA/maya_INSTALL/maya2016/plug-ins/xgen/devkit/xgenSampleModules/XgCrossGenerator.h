// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * Simple generator example that samples primitives on a cross pattern
 * (an X, but XgXGenerator was too hard to say).
 */

#ifndef CROSSGENERATOR_H
#define CROSSGENERATOR_H

#include <XGen/XgUtil.h>
#include <XGen/XgGenerator.h>
#include <XGen/XgExpression.h>

class XgCrossGenerator : public XgGenerator
{
public:

    /* Constructor. */
    XgCrossGenerator( XgDescription *descr );

    /* Density.  Note: it's a double, not an expression. */
    double density() const { return _density; }

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name,
                          const std::string &value,
                          const std::string &type="float",
                          const std::string &uiHint="" );

    /** Return the name of this type of generator. */
    virtual std::string typeName() const { return "CrossGenerator"; }

protected:
    /* Generate primitives. */
    virtual void genPrimitives(
            const int faceId,
            const safevector<XgPatch*> &patches,
            const double startPercent,
            const double percent );

    /** Number of primitives per unit area in UV space. */
    double _density;
};

#endif
