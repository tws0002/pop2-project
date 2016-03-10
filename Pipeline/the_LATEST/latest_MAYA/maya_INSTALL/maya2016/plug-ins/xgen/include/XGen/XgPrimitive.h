// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgPrimitive.h
 * @brief Contains the declaration of the class XgPrimitive.
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
 * @author Ying Liu
 *
 * @version Created 05/22/02
 */

#ifndef XGPRIMITIVE_H
#define XGPRIMITIVE_H


#include <algorithm>
#include <string>
#include "XgPorting/safevector.h"
#include <map>
#include <set>

#include "XGen/XgDict.h"
#include "XGen/SgVec3T.h"
#include "XGen/SgBox3T.h"
#include "XGen/SgXform3T.h"
#include "XGen/SgKdTreeNT.h"
#include "XGen/XgGuide.h"
#include "XGen/XgUtil.h"
#include "XGen/XgObject.h"
#include "XGen/XgExpression.h"
#include "XgWinExport.h"
#include "XGen/XgPrimitiveContext.h"
#include "XGen/XgDescription.h"

class XgPatch;
class XgFXModule;
class XgDescription;
class XgGenerator;
class XgPendingGuidesImp;

#ifdef WIN32
#ifdef min
#pragma push_macro("min")
#undef min
#define POP_MIN
#endif
#endif

/**
 * @brief A base primitive to represent primitive types.
 *
 * This class is the base class for all primitives.  It contains all attributes
 * necessary to describe the primitive that will populate a set of patches.
 */
class XGEN_EXPORT XgPrimitive : public XgObject
{
    friend class XgPrimitiveContext;

public:

    /* Constructor. */
    XgPrimitive( XgDescription *descr, const std::string &objectType );

    /* Destructor. */
    virtual ~XgPrimitive();

    /** Bounding box calculation. */
	SgBox3d boundingBox() const { return _context->boundingBox(); };

    /* Make the cached geometry for this primitive. */
	void makeGeometry( double u, double v, XgFXModule *stop=0);
	void makeGeometryInParallel( XgPrimitiveContext& context, double u, double v, XgFXModule *stop=0);

    /* Get the maximum CV count for active guides. */
    unsigned int maximumCVCount();
    unsigned int maximumCVCountInParallel( XgPrimitiveContext& context );
    
    /* Find the appropriate guides and calculate their relative weights. */
	void findGuidesAndWeights( double u, double v );
	void findGuidesAndWeightsInParallel( XgPrimitiveContext& context, double u, double v );

    /* Orient the primitive. */
    static void orient( const SgVec3d &P, const SgVec3d &N,
                        const SgVec3d &U, const SgVec3d &V,
                        double offU, double offV, double twist,
                        double offN, double aboutN,
                        safevector<SgVec3d> &cpt,
                        bool oneHemi = true );

    /* Find the local orientation. */
    static void findOrient( safevector<SgVec3d> &cpt, const SgVec3d &N,
                            const SgVec3d &U, const SgVec3d &V,
                            double &offU, double &offV,
                            bool oneHemi = true );
    
    /** Enumerated type for the guide interpolation method being used. */
    enum InterpMethod
    {
        Attribute=0,
        CV=1,
        INVALID_IMETHOD=2
    };
    
    /** @name Render Control Methods */
    //@{
    /* Initialize and finish a description. */
    virtual void initDescription();
    virtual void initDescriptionInParallel( XgPrimitiveContext& context);
    virtual void finishDescription();
    virtual void finishDescriptionInParallel( XgPrimitiveContext& context);

	XgPrimitiveContext* cloneContext()
	{
		XgPrimitiveContext* context = cloneContextImp();
		// copy states from the description
		context->setLodAdjustment(context->description()->lodAdjustment());
		return context;
	}

	XgPrimitiveContext* context() { return _context; }

    /* Setup interpolation structures. */
    void setupInterpolation( bool quiet=false );
    
    /* Set the patch and face for primitive geometry work. */
    void setActivePatchFace( const XgPatch &patch, int faceId ) { _context->setActivePatchFace( patch, faceId ); }
    //@}
    
    /* Interpolation initialization */
    bool initInterpolation( const std::string &fileName );

    /** Clear out candidate guides if face binding changes. */
    void clearCandidates() { _candidateGuides.clear(); }

    /** @name Accessors */
    //@{
    InterpMethod iMethod() const { return _iMethod; }
    const XgExpression &length() const { return _length; }
    const XgExpression &width() const { return _width; }
    const XgExpression &depth() const { return _depth; }
    const XgExpression &offU() const { return _offU; }
    const XgExpression &offV() const { return _offV; }
    const XgExpression &offN() const { return _offN; }
    const XgExpression &aboutN() const { return _aboutN; }
    const std::string  &regionMap() const { return _regionMap; }
    const XgExpression &regionMask() const { return _regionMask; }
    //@}

    /* Copy attributes from an existing primitive. */
    void copyAttrs( XgPrimitive *prim );
    
    /** @name FX module accessors */
    //@{
    XgFXModule *addFXModule( const std::string &type );
    bool removeFXModule( const std::string &name );
    XgFXModule *findFXModule( const std::string &name, int *idx=0 ) const;
    safevector<XgFXModule *> findFXModules( const std::string &typeName, 
                                          safevector<int> &indices );
    bool moveFXModule( const std::string &name, int dir );
    bool applyFXModules( XgFXModule *stop=NULL );
	bool canRunInParallel( XgFXModule *stop=NULL );
	bool applyFXModulesParallel( XgPrimitiveContext& context, XgFXModule *stop=NULL );
    void deactivateFXModules( unsigned int i, safevector<bool> &origStatus );
    void setFXModulesStatus( unsigned int i, const safevector<bool> &status );

    int bakedGroomManagerPosition() const;

    safevector<XgFXModule *> &modules() { return _modules; }
    XgFXModule *modules( unsigned int i )
        { return (_modules.size()>i ? _modules[i] : 0); }

    std::string uniqueFXName( const std::string &name ) const;
    //@}
    
    /** @name Cached value accessors */
    //@{
    unsigned int id() const { return _context->id(); }
    void resetId() { _context->resetId(); }
    void setId( unsigned int id ) { _context->setId(id); }
    void incrId() { _context->incrId(); }
    double cLength() const { return _context->cLength(); }
    void overrideCLength( double v ) { _context->overrideCLength(v);}
    void dirtyCLength() { _context->dirtyCLength(); }
    double cWidth() const { return _context->cWidth(); }
    void overrideCWidth( double v ) { _context->overrideCWidth(v); }
    double cDepth() const { return _context->cDepth(); }
    void overrideCDepth( double v ) { _context->overrideCDepth(v); }
    bool cullPrim() const { return _context->cullPrim(); }
    void setCullPrim( bool b ) { _context->setCullPrim(b); }
    
    double cu( bool pref=false ) const { return _context->cu(pref); }
    double cv( bool pref=false ) const { return _context->cv(pref); }
    const SgVec3d &cP( double u, double v, bool pref=false ) { return _context->cP(u, v, pref); }
    const SgVec3d &cN( double u, double v, bool pref=false ) { return _context->cN(u, v, pref); }
    const SgVec3d &cU( double u, double v, bool pref=false ) { return _context->cU(u, v, pref); }
    const SgVec3d &cV( double u, double v, bool pref=false ) { return _context->cV(u, v, pref); }
    const SgVec3d &cdPdu( double u, double v, bool pref=false ) { return _context->cdPdu(u, v, pref); }
    const SgVec3d &cdPdv( double u, double v, bool pref=false ) { return _context->cdPdv(u, v, pref); }
    const SgVec3d &cPg( double u, double v, bool pref=false ) { return _context->cPg(u, v, pref); }
    const SgVec3d &cNg( double u, double v, bool pref=false ) { return _context->cNg(u, v, pref); }
    const SgVec3d &cUg( double u, double v, bool pref=false ) { return _context->cUg(u, v, pref); }
    const SgVec3d &cVg( double u, double v, bool pref=false ) { return _context->cVg(u, v, pref); }
    const SgVec3d &cdPdug( double u, double v, bool pref=false ) { return _context->cdPdug(u, v, pref); }
    const SgVec3d &cdPdvg( double u, double v, bool pref=false ) { return _context->cdPdvg(u, v, pref); }
    float cKu( double u, double v, bool pref=false ) { return _context->cKu(u, v, pref); }
    float cKv( double u, double v, bool pref=false ) { return _context->cKv(u, v, pref); }

	const std::string&  colorExprStr() { return _colorExprStr; }
	const XgExpression& colorExpr() { return _colorExpr; }

	void setColorCache(const std::string& color) { _colorExprStr = color; _colorExpr = color; }
	SgVec3d evalColor( double u, double v, int faceId, const std::string& patchName ) { return _context->evalColor( _colorExprStr, _colorExpr, u, v, faceId, patchName ); }
    SgVec3d evalInterpGuideColor();
    //@}
    
    /** @name Primitive geometry */
    //@{

    /* Read-only access to the geometry. */
    const safevector<SgVec3d> &getGeom() const { return _context->getGeom(); }

    /* Read-write access to the geometry. */
    safevector<SgVec3d> &cGeom() { return _context->cGeom(); }
    SgVec3d &cGeom( int i ) { return _context->cGeom(i); }

    /* Convert cvs to reference geometry space. */
    void toRefGeomSpace( double u, double v, safevector<SgVec3d> &refCVs ) { return _context->toRefGeomSpace(u, v, refCVs); }
    //@}
    
    /** @name CV attributes */
    //@{
    /* Create and get cv attributes. */
    safevector<SgVec3d> *addCVAttr( const std::string &name,
                                    const std::string &type ) { return _context->addCVAttr( name, type); }
    safevector<SgVec3d> *getCVAttr( const std::string &name,
                                    const std::string &type ) { return _context->getCVAttr( name, type); }

    /* Locations for point cv attributes. */
    void setCVAttrLoc( const std::string &name, XgPrimitiveContext::Location *loc=0 ) { _context->setCVAttrLoc( name, loc); }
    bool getCVAttrLoc( const std::string &name, XgPrimitiveContext::Location &loc ) { return _context->getCVAttrLoc( name, loc); }
    
    XgDict< safevector<SgVec3d> > &cvAttrs() { return _context->cvAttrs(); }
    safevector< safevector<SgVec3d> * > cvAttrs( const std::string &type ) { return _context->cvAttrs( type ); }

    /* Get cv attributes that are animatable (points) in both reference and 
     * animated geometry space. 
     */
    void animatableCVAttrs( safevector< safevector<SgVec3d> > &refCVs,
                            safevector< safevector<SgVec3d> * > &animCVs ) { _context->animatableCVAttrs( refCVs, animCVs ); }
    //@}

	//@{
    /* Bounding box for the cached guide. */
    virtual SgBox3d guideBoundingBox( unsigned int index ) const = 0;
    /* Minimum number of CVs allowed for a guide of this primitive. */
    virtual unsigned int minGuideCVCount() const = 0;
    /* Default shape for a new guide. */
    virtual void defaultGuideGeom( XgGuide &guide ) = 0;
    /* Transform guides to surface. */
    void transformGuidesToSurface();
    /* Strip guides that use a given patch. */
    void stripGuidePatch( const XgPatch *patch );
    /** Verify the validity of potential guide geometry. */
    virtual void verifyGuideGeom( safevector<SgVec3d> &cpts ) {}
    /** Prepare the guide cached geometry. */
    virtual void prepGuideCGeom( unsigned int index )
        { _guides[index].cGuideGeomRef() = _guides[index].iGuideGeom(); }
    /* Create guides based on another primitives guides. */
    bool newCopiedGuides( XgPrimitive *otherPrim );
    /* Override guides with data from a cache file. */
    virtual void overrideGuidesWithCache();

	/** Resize the guide array (prepare for pushing new guides.) */
	void setGuideCount( unsigned int count ) { _guides.resize( count ); }
	/** Reserve space for guides during import. */
	void reserveGuideSpace( unsigned int count ) { _guides.reserve( count ); }
	/** Get the number of guides. */
	int numGuides() { return (int)_guides.size(); }
	/** Get a guide from the primitive. */
	XgGuide *guide( unsigned int i ) { return (i<_guides.size() ? &_guides[i] : NULL); }
	const XgGuide *guide( unsigned int i ) const { return (i<_guides.size() ? &_guides[i] : NULL); }
	XgGuide *guide( const std::string& id );
    //@}

	/** Pending guides */
	//@{
	void setOriginalPatchBBox(const SgVec3d& origin, const SgVec3d& offset)
		{ _originalPatchBBox.setOrigin(origin); _originalPatchBBox.setOffset(offset); }
	const SgBox3d& originalPatchBBox() { return _originalPatchBBox; }
	void appendPendingGuide(unsigned int faceId, double u, double v, double patchU, double patchV,
							const SgVec3d& normal, const SgVec3d& uTangent, const SgVec3d& vTangent,
							double blend, std::string interp, safevector<SgVec3d>& cvs);
	size_t numOfPendingGuides();
	void getPendingGuide(size_t index, unsigned int* faceId, double* u, double* v,
		double* patchU, double* patchV,	SgVec3d* normal, SgVec3d* uTangent, SgVec3d* vTangent,
		safevector<SgVec3d>** cvs);
	void setPendingGuidePos(size_t index, unsigned int faceId, double u, double v,
		const SgVec3d& normal, const SgVec3d& uTangent, const SgVec3d& vTangent);
	void clearPendingGuide();
	static safevector<XgPrimitive*>& primitivesWithPendingGuides();
	static void clearPrimitivesWithPendingGuides();
	//@}

    /** @name Interpolation values */
    //@{
    const XgPatch *cPatch() const { return _context->cPatch(); }
    void setcPatch(XgPatch &patch) { _context->setcPatch(patch); }
    int cFaceId() const { return _context->cFaceId(); }
    const safevector<int> &activeGuides() { return _context->activeGuides(); }
    const safevector<double> &weight() { return _context->weight(); }
    double weight(unsigned int i) { return _context->weight(i); }
    double weightN() { return _context->weightN(); }
    //@}
    
    /** Cached attributes */
    //@{
    /**
     * version 3: Add "index" and "frame" field for archive primitive. MAYA-42448 2014/11/28
     */
    virtual int versionAttrs() { return 3; }
    virtual unsigned int finalCVCount() = 0;
    void packAttrs( safevector<float> &data,
                     SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 ) { _context->packAttrs(data, X, Y, Z); }
    void unpackAttrs( int version,
                              const safevector<float> &data,
                              unsigned int &index,
                              SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 ) { _context->unpackAttrs(version, data, index, X, Y, Z); }
    void packCVAttrs( safevector<float> &data,
                      const std::map<std::string,int> &keyToId ) { _context->packCVAttrs( data, keyToId ); }
    void unpackCVAttrs( const safevector<float> &data, unsigned int &index,
                        const safevector<std::string> &keys ) { _context->unpackCVAttrs( data, index, keys ); }
    //@}

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );
    
    /** Return the name of this type of primitive. */
    virtual std::string typeName() const = 0;

    /** @name IO functions */
    //@{
    bool exportFXModules( std::ostream &os ) const;
    bool exportFXModulesAsPreset( std::ostream &os, bool activeModuleOnly = false ) const;
    bool exportGuides( std::ostream &os, XgPatch *patch ) const;
    bool importGuides( std::istream &is, XgPatch *patch );
	void bindPendingGuide(size_t index, XgPatch *patch, unsigned int faceId, double u, double v,
		const SgVec3d& normal, const SgVec3d& uTangent, const SgVec3d& vTangent, bool useRawCV);
    //@}

	bool getAttrValue( const std::string& attrsName, SgVec3d& attrVal );
    bool getAttrValueInParallel( XgPrimitiveContext& context, const std::string& attrsName, SgVec3d& attrVal );
    void getFXTextures( safevector<std::string> &textures ) const;

	safevector<std::string> &wireNames( const std::string patchName );

    virtual void initModules() {;}
    virtual void finishModules() {;}

    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

protected:

    /** No definition by design to prevent accidental default construction. */
    XgPrimitive();
    
    /** No definition by design so accidental copying is prevented. */
    XgPrimitive( const XgPrimitive &primitive );

    /** No definition by design so accidental assignment is prevented. */
    XgPrimitive &operator=( const XgPrimitive &primitive );

	virtual XgPrimitiveContext* cloneContextImp() = 0;

    /* Helper to evaluate the patch and gather cached geometry values.*/
    void evalPatch( int index, double u, double v ) { _context->evalPatch(index, u, v); }
    void evalCurvature( int index, double u, double v ) { _context->evalCurvature(index, u, v); }

    /* Calculate the weights for interpolation. */
    void calcCVWeights( double u, double v );
	void calcCVWeightsInParallel( XgPrimitiveContext& context, double u, double v );

    /** Let derived class build its type specific geometry. */
    virtual void mkGeometry( double u, double v ) = 0;
	virtual void mkGeometryInParallel( XgPrimitiveContext& context, double u, double v )
	{}

    /** Opportunity for derived class to 'touch-up' after fx are applied. */
    virtual bool postApplyFX() { return true;}
    virtual bool postApplyFxInParallel(XgPrimitiveContext& context) { return true;}

    /* Interpolation initialization. */
    void gatherNeighbors( safevector<SgVec3d> &basePoint,
                          safevector<SgVec3d> &norm,
                          safevector< std::set<int> > &neighbor );
    void checkBox( XgPatch *patch, int faceId,
                   const SgVec3d &Pa, const SgVec3d &Na,
                   const SgVec3d &Pb, const SgVec3d &Nb, 
                   const SgVec3d &Pc, const SgVec3d &Nc,
                   const SgVec3d &Pd, const SgVec3d &Nd,
                   double u0, double v0, double u1, double v1,
                   int level, int limit,
                   safevector<SgVec3d> &norm,
                   safevector< std::set<int> > &neighbor,
                   SgKdTree3d &kdtree );
    void processGuides( const safevector<SgVec3d> &basePoint,
                        const safevector<SgVec3d> &norm,
                        const safevector< std::set<int> > &neighbor,
                        const std::string &fileName );
                     

    /* Allow derived classes a way to compute the length. */
    double computeLength() const
        { return _context->computeLength(); }


	XgPrimitiveContext* _context;

    /** @name Generic attributes. */
    //@{
    XgExpression _length;
    XgExpression _width;
    XgExpression _depth;
    XgExpression _offU;
    XgExpression _offV;
    XgExpression _offN;
    XgExpression _aboutN;
    //@}

    /** FX Modules. */
    safevector<XgFXModule *> _modules;

    /** Region control. */
    //@{
    bool _regionFlag;
    XgExpression _regionMask;
    XgExpression _regionExpr;
    std::string _regionMap;
    //@}

    /** Animated guide control. */
    //@{
    bool _useCache;
    std::string _cacheFileName;

	/** Flag to get the curves cv from Maya */
	bool _liveMode;

    /** Name of the anim wires. */
    safevector<std::string> _wireNames;

    safevector<std::string> _patchNames;
	XgDict< safevector<std::string> > _patchWireNames;
	
	/** Put the wireNames to the right patch */
	bool setWireNames( );

    //@}
    
	/** Guides for this primitive. */
	safevector<XgGuide> _guides;
    XgExpression _guideColorExpr;

    /** Color for this primitive. */
    std::string  _colorExprStr;
    XgExpression _colorExpr;

    /** Name of live generator. */
    std::string _liveGen;

    /** Interpolation variables. */
    //@{

    /** Interpolation method. */
    InterpMethod _iMethod;

    /** Candidate guides per face. */
	/* Written in:
	 * XgPrimitive::setupInterpolation()
	 * XgPrimitive::clearCandidates()
	 */
    XgDict< std::map< int, safevector<int> > > _candidateGuides;
    //@}

	SgBox3d _originalPatchBBox;
	XgPendingGuidesImp* _pendingGuides;
	static safevector<XgPrimitive*> _pendingPrimitives;
};

#ifdef POP_MIN
#pragma pop_macro("min")
#undef POP_MIN
#endif

#endif
