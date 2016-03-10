// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgGenerator.h
 * @brief Contains the declaration of the class XgGenerator.
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
 * @author Ernie Petti
 * @author Stephen D. Bowline
 * @author Lawrence Chai
 * @author Ying Liu
 *
 * @version Created 05/23/02
 */

#ifndef XGGENERATOR_H
#define XGGENERATOR_H

#include <string>
#include <map>

#include "XGen/XgObject.h"
#include "XGen/XgExpression.h"
#include "XGen/XgGeneratorContext.h"
#include "XgWinExport.h"

class XgDescription;
class XgPatch;
class XgRenderer;
class XgPrimitive;
class XgPrimitiveContext;

/**
 * @brief A base generator class for populating patches with primitives.
 *
 * This class is the base class for all primitive generators. The basic
 * flow of the generate algorithm is encoded here, as well as general
 * generator variables. Sub-classes define the specifics for the method
 * of primitive placement.
 */
class XGEN_EXPORT XgGenerator : public XgObject
{
public:

    /* Constructor. */
    XgGenerator( XgDescription *descr, const std::string &objectType );

    /* Destructor. */
    virtual ~XgGenerator();

    /** Maps primitive IDs to emitted count number (for culling/preview) */
    typedef std::map<unsigned int, bool> CullMapType;

    /* Initialize and finish a description. */
    virtual void initDescription();
	virtual void initDescriptionInParallel( XgPrimitiveContext& context ) {}
    virtual void finishDescription();
	virtual void finishDescriptionInParallel( XgPrimitiveContext& context ) {}

    /* Generate primitives. */
    void generate( const int faceId, const safevector<XgPatch*> &patches,
                   const double startPercent=1.0f, const double percent=1.0f );
    void generateInParallel( XgPrimitiveContext& context, const int faceId, const safevector<XgPatch*> &patches,
                   const double startPercent=1.0f, const double percent=1.0f );
    
    /** Reset generator regions. */
    void clearRegions() { _regionIds.clear(); }
    
    /** @name Accessors. */
    //@{
    XgExpression &regionExpr() { return _regionExprInternal; }
    safevector<unsigned int> &regionIds() { return _regionIds; }
    const XgExpression &displacement() const { return _displacement; }
    bool vectorDisplacement() const { return _vectorDisplacement; }
    const XgExpression &bump() const { return _bump; }
    const XgExpression &offset() const { return _offset; }
    bool cullPrims() const { return _cullFlag; }
    unsigned int numCulled() const { return _numCulled; }	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
    const XgExpression &cullExpr() const { return _cullExpr; }
    bool cullBackface() const { return _cullBackface; }
    bool cullFrustrum() const { return _cullFrustrum; }
    double cullAngleBF() const { return _cullAngleBF; }
    double cullAngleF() const { return _cullAngleF; }
    //@}

    /* Copy the displacement and culling attributes to another generator. */
    void copyBaseAttrs( XgGenerator *toGenerator );

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
                          const std::string &uiHint="" );
    
    /** Return the name of this type of generator. */
    virtual std::string typeName() const = 0;

	virtual bool canRunInParallel() { return false; }

    virtual XgGeneratorContext* newGeneratorContext() { return new XgGeneratorContext(); }

    /* Initialize and finish the generator. */
    virtual void initGenerator() {};
    virtual void finishGenerator() {};

    /* Method to provide data release/reset when the generator is deactivated. */
    virtual void deactivate(){};

    /** Get external file paths used in the generator. */
    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

private:
    std::string wrapLodOffset(std::string &offset);

protected:

    /** No definition by design to prevent accidental default construction. */
    XgGenerator();
    
    /** No definition by design so accidental copying is prevented. */
    XgGenerator( const XgGenerator &generator );

    /** No definition by design so accidental assignment is prevented. */
    XgGenerator &operator=( const XgGenerator &generator );

    /* Returns true if prim should be culled before geometry is made. */
    virtual bool cullPreGeometry( const double u,
                                  const double v,
                                  const int faceId,
                                  XgPrimitive *activePrim,
                                  XgPatch *patch );

    virtual bool cullPreGeometryInParallel( XgPrimitiveContext& context,
                                  const double u,
                                  const double v,
                                  const int faceId,
                                  XgPrimitive *activePrim,
                                  XgPatch *patch );

    /* Returns true if prim should be culled after geometry is made. */
    virtual bool cullPostGeometry( const double u,
                                   const double v,
                                   const int faceId,
                                   const XgPrimitive *activePrim,
                                   XgPatch *patch );

    virtual bool cullPostGeometryInParallel( XgPrimitiveContext& context,
                                   const double u,
                                   const double v,
                                   const int faceId,
                                   XgPatch *patch );

    /* Instructs our calling renderer to emit the freshly generated prim. */
    virtual bool emitIfOk( const double u,
                           const double v,
                           const int faceId,
                           const safevector<XgPatch*> &patches );

    virtual bool emitIfOkInParallel( XgPrimitiveContext& context, const double u,
                           const double v,
                           const int faceId,
                           const safevector<XgPatch*> &patches );

    /* Derived classes must define how to generate the primitives. */
    virtual void genPrimitives( const int faceId,
                                const safevector<XgPatch*> &patches,
                                const double startPercent = 1.0f,
                                const double percent = 1.0f ) = 0;

    virtual void genPrimitivesInParallel( XgPrimitiveContext& context,
                                const int faceId,
                                const safevector<XgPatch*> &patches,
                                const double startPercent = 1.0f,
                                const double percent = 1.0f )
    { assert(0); }


    /* Fill in geometry in generator specific way. */
    virtual bool fillGeometry( unsigned int s, const double u,
                               const double v, const int faceId );

    virtual bool fillGeometryInParallel( XgPrimitiveContext& context, unsigned int s, const double u,
                               const double v, const int faceId );

    /* Whether to check and only generate primitives in specified regions. */
    bool renderRegionCheck();

    /* Check if a position is valid to generate primitives. */
    bool validRenderRegion( const double u, const double v, 
                            const int faceId, const std::string &patchName );

    /** Region control expression */
    XgExpression _regionExprInternal;

    /** Regions Ids to generate primitives on */
	safevector<unsigned int> _regionIds;    // Turbo: thread-safe, modified in XgmPreviewCmd::beginRenderer()

    /** Displacement expression. */
    XgExpression _displacement;
    bool _vectorDisplacement;

    /** Bump expression. */
    XgExpression _bump;

    /** Offset (displacement without normal adjustment) expression. */
    XgExpression _offset;
    std::string _lodOffset;

    /** Width for lod calculation */
    double _lodWidth;

    /** Turns culling on and off */
    bool _cullFlag;

    /** If this expression evaluates true, then the prim is culled */
    XgExpression _cullExpr;

    /** Different ways to cull with the camera. */
    bool   _cullBackface;
    bool   _cullFrustrum;

    /** Culling threshold angles for backface and frustrum */
    double _cullAngleBF;
    double _cullAngleF;

    /** Number of primitives that were culled */
    unsigned int  _numCulled;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.

    /** The current kind of primitive we're generating. */
    XgPrimitive *_activePrim;

    /** The renderer which requested us to generate. */
    XgRenderer *_activeRenderer;
};


#endif
