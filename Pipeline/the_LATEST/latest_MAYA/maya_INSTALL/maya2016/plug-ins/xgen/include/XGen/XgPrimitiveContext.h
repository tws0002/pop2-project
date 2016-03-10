#ifndef XGPRIMITIVECONTEXT_H
#define XGPRIMITIVECONTEXT_H

#include "XGen/SgVec3T.h"
#include <XgWinExport.h>
#include <XgPorting/safevector.h>
#include <string>
#include "XGen/XgGuide.h"
#include "XGen/XgRendererContext.h"
#include "XGen/XgGeneratorContext.h"

class XgPatch;
class XgDescription;
class XpdReader;
class XgPrimitive;
class XgExpression;
class XgFXModule;
class XgFXModuleContext;

class XGEN_EXPORT XgPrimitiveContext
{
	friend class XgPrimitive;
	friend class XgSplinePrimitive;
	friend class XgCardPrimitive;
	friend class XgSpherePrimitive;
	friend class XgArchivePrimitive;
	friend class XgRenderer;
	friend class XgGenerator;
	friend class XgRandomGenerator;
    friend class XgGuideGenerator;

public:
	XgPrimitiveContext():
		_cLength(0.0), _cWidth(0.0), _cDepth(0.0), _dirtyCLength(false),
		_cPatch(NULL), _cFaceId(0), _id(0), _cull(false), _xFile(NULL), _currentModuleIndex(0)
	{}
	virtual ~XgPrimitiveContext(){}

    /** Bounding box calculation. */
    virtual SgBox3d boundingBox() const = 0;

	void setDescription(XgDescription* desc) { _description = desc; }
	XgDescription* description() { return _description; }
	void setRendererContext( XgRendererContext& rc ) { _rendererContext = &rc; }
	XgRendererContext& rendererContext() { assert(_rendererContext); return *_rendererContext; }
    void setGeneratorContext( XgGeneratorContext& gc ) { _generatorContext = &gc; }
    XgGeneratorContext& generatorContext() { assert(_generatorContext); return *_generatorContext; }

	//////////////////////////////////////////////////////////////////////////
	//						states from modifiers
	//////////////////////////////////////////////////////////////////////////

    /** @name FX Pipeline data. */
    //@{
    bool getPipeData( const std::string &name,
        safevector<SgVec3d> &val );
    void setPipeData( const std::string &name, 
        const safevector<SgVec3d> &val )
    { _pipeData[name.c_str()] = val; }
    void removePipeData( const std::string &name )
    { _pipeData.erase( name.c_str() ); }
    void removeAllPipeData()
    { _pipeData.clear(); }
    //@}

	//////////////////////////////////////////////////////////////////////////
	//						states from the base primitive
	//////////////////////////////////////////////////////////////////////////

	double cu( bool pref=false ) const { return _cu[(pref?2:3)]; }
	double cv( bool pref=false ) const { return _cv[(pref?2:3)]; }
	const SgVec3d &cP( double u, double v, bool pref=false );
	const SgVec3d &cN( double u, double v, bool pref=false );
	const SgVec3d &cU( double u, double v, bool pref=false );
	const SgVec3d &cV( double u, double v, bool pref=false );
	const SgVec3d &cdPdu( double u, double v, bool pref=false );
	const SgVec3d &cdPdv( double u, double v, bool pref=false );
	const SgVec3d &cPg( double u, double v, bool pref=false );
	const SgVec3d &cNg( double u, double v, bool pref=false );
	const SgVec3d &cUg( double u, double v, bool pref=false );
	const SgVec3d &cVg( double u, double v, bool pref=false );
	const SgVec3d &cdPdug( double u, double v, bool pref=false );
	const SgVec3d &cdPdvg( double u, double v, bool pref=false );
	float cKu( double u, double v, bool pref=false );
	float cKv( double u, double v, bool pref=false );
	SgVec3d evalColor( const std::string& colorExprStr, const XgExpression& colorExpr, double u, double v, int faceId, const std::string& patchName );
    SgVec3d evalInterpGuideColor( const XgExpression& guideColorExpr, const XgPrimitive* primitive );

	/* Helper to evaluate the patch and gather cached geometry values.*/
	void evalPatch( int index, double u, double v );
	void evalCurvature( int index, double u, double v );

	/** @name Primitive geometry */
	//@{

	/* Read-only access to the geometry. */
	const safevector<SgVec3d> &getGeom() const { return _cGeom; }

	/* Read-write access to the geometry. */
	safevector<SgVec3d> &cGeom() { return _cGeom; }
	SgVec3d &cGeom( int i ) { return _cGeom[i]; }

	/* Convert cvs to reference geometry space. */
	void toRefGeomSpace( double u, double v, safevector<SgVec3d> &refCVs );
	//@}

    /** Class for passing location of point CV attributes. */
    class Location {
    public:
        Location() {;}
        Location(const std::string &patchName, int faceId, double u, double v)
        { _patchName=patchName;_fuv.setValue((double)faceId,u,v); }
        SgVec3d &fuv() { return _fuv; }
        std::string &patchName() { return _patchName; }
    private:
        SgVec3d _fuv;
        std::string _patchName;
    };

    /** @name CV attributes */
    //@{
    /* Create and get cv attributes. */
    safevector<SgVec3d> *addCVAttr( const std::string &name,
                                    const std::string &type );
    safevector<SgVec3d> *getCVAttr( const std::string &name,
                                    const std::string &type );

    /* Locations for point cv attributes. */
    void setCVAttrLoc( const std::string &name, Location *loc=0 );
    bool getCVAttrLoc( const std::string &name, Location &loc );
    
    XgDict< safevector<SgVec3d> > &cvAttrs() { return _cvAttrs; }
    safevector< safevector<SgVec3d> * > cvAttrs( const std::string &type );

    XgDict<XgPrimitiveContext::Location> &cvAttrsLoc() { return _cvAttrsLoc; } // Turbo: new added function for multi-threaded mode.

    /* Get cv attributes that are animatable (points) in both reference and 
     * animated geometry space. 
     */
    void animatableCVAttrs( safevector< safevector<SgVec3d> > &refCVs,
                            safevector< safevector<SgVec3d> * > &animCVs );
    //@}

	/** @name Cached value accessors */
	//@{
	unsigned int id() const { return _id; }
	void resetId() { _id = 0; }
	void setId( unsigned int id ) { _id = id; }
	void incrId() { _id++; }
	double cLength() const { return (_dirtyCLength?computeLength():_cLength); }
	void overrideCLength( double v ) { _cLength = v; _dirtyCLength = false;}
	void dirtyCLength() { _dirtyCLength = true; }
	double cWidth() const { return _cWidth; }
	void overrideCWidth( double v ) { _cWidth = v; }
	double cDepth() const { return _cDepth; }
	void overrideCDepth( double v ) { _cDepth = v; }
	bool cullPrim() const { return _cull; }
	void setCullPrim( bool b ) { _cull = b; }
	//@}


	/** @name Interpolation values */
	//@{
	const XgPatch *cPatch() const { return _cPatch; }
    void setcPatch(XgPatch &patch) { _cPatch = &patch; }
	int cFaceId() const { return _cFaceId; }
	const safevector<int> &activeGuides() { return _activeGuides; }
	const safevector<double> &weight() { return _ws; }
	double weight(unsigned int i)
	{ return _ws[std::min(i,(unsigned int)_ws.size()-1)]; }
	double weightN() { return _wn; }
	//@}

    /** Cached attributes */
    //@{
    virtual void packAttrs( safevector<float> &data,
        SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 ) = 0;
    virtual void unpackAttrs( int version,
        const safevector<float> &data,
        unsigned int &index,
        SgVec3d *X=0, SgVec3d *Y=0, SgVec3d *Z=0 ) = 0;
    void packCVAttrs( safevector<float> &data,
                      const std::map<std::string,int> &keyToId );
    void unpackCVAttrs( const safevector<float> &data, unsigned int &index,
                        const safevector<std::string> &keys );
    //@}

	/* Allow derived classes a way to compute the length. */
	virtual double computeLength() const
	{ _dirtyCLength=false; _cLength=0.0; return _cLength; }

	/** @name Render Control Methods */
	//@{

	/* Set the patch and face for primitive geometry work. */
	void setActivePatchFace( const XgPatch &patch, int faceId );
	//@}

	bool getAttrValue( const std::string& attrsName, SgVec3d& attrVal, const XgPrimitive* primitive );

	//////////////////////////////////////////////////////////////////////////
	//						states from generators
	//////////////////////////////////////////////////////////////////////////
	unsigned int numCulled() const { return _numCulled; }

	//////////////////////////////////////////////////////////////////////////
	//						states from descriptions
	//////////////////////////////////////////////////////////////////////////
	double lodAdjustment() const
	{ return _lodAdjustment; }
	void setLodAdjustment( double val )
	{ _lodAdjustment = val; }

	//////////////////////////////////////////////////////////////////////////
	//						states from modifiers
	//////////////////////////////////////////////////////////////////////////
	XgFXModuleContext &fxModuleContext( const XgFXModule& module );
	void addModuleContext( const XgFXModule& module );
	void removeAllModuleContext();

protected:
	/** Description back pointer. */
	XgDescription *_description;

	XgRendererContext *_rendererContext;

    XgGeneratorContext *_generatorContext;

	//////////////////////////////////////////////////////////////////////////
	//						states from the base primitive
	//////////////////////////////////////////////////////////////////////////

	/* Cached values for pre-displacement pref[0] and base[1], and
	 * post-displacement pref[2] and base[3].
	 */
	double _cu[6];         // u coordinate of face.
	double _cv[6];         // v coordinate of face.
	SgVec3d _cU[4];        // Patch normalized dPdu.
	SgVec3d _cV[4];        // Patch normalized dPdv.
	SgVec3d _cdPdu[4];     // Patch dPdu.
	SgVec3d _cdPdv[4];     // Patch dPdv.
	SgVec3d _cN[4];        // Patch normal.
	SgVec3d _cP[4];        // Patch point.
	float _cKu[2];         // Surface curvature in u
	float _cKv[2];         // surface curvature in v

	/* Cached attributes (see getNumCachedAttr()). */
	mutable double _cLength;
	double _cWidth;
	double _cDepth;
	mutable bool _dirtyCLength;

	/** Cached active patch. */
	XgPatch *_cPatch;

	/** Cached active face. */
	int _cFaceId;

	/** Cull primitive. */
	bool _cull;

    /** Collection of cv attributes. */
    XgDict< safevector<SgVec3d> > _cvAttrs;

    /** Collection of point cv attribute locations. */
    XgDict<XgPrimitiveContext::Location> _cvAttrsLoc;

	/** Id for the current cached primitive. */
	unsigned int _id;

	/** Cached geometry. */
	safevector<SgVec3d> _cGeom;

	/** Guides currently being used for the primitive. */
	safevector<int> _activeGuides;

	/** Guide weights. */
	safevector<double> _ws;

	/** Weight normalization. */
	double _wn;


    // UV color support
    struct UVColor
    {
        static SgVec3d bad;

        double _uv[2];
        SgVec3d _color;
        bool _recurse;
        UVColor() : _recurse(false)
        {
            reset();
        }

        bool match( double u, double v, SgVec3d& color )
        {
            if ( _uv[0] != u || _uv[1] != v ) 
                return false;
            color = _color;
            return true;
        }

        void reset()
        {
            _uv[0] = _uv[1] = -1.0;
            _color = 0.0;
            _recurse = false;
        }

        void update( double u, double v, SgVec3d& color )
        {
            _uv[0] = u;
            _uv[1] = v;
            if ( !_recurse )
                _color = color;
        }

        bool& recursive()
        {
            return _recurse;
        }
    };
	UVColor _uvColor;

	//////////////////////////////////////////////////////////////////////////
	//						states from modifiers
	//////////////////////////////////////////////////////////////////////////

    /**
     * FX pipeline data. This can be used to store data that can be created
     * in one module and then used in another. It is the responsibility
     * of the FX modules to not step on each other when creating entries.
     */
    XgDict< safevector<SgVec3d> > _pipeData;

	//////////////////////////////////////////////////////////////////////////
	//						states from generators
	//////////////////////////////////////////////////////////////////////////

	/** Number of primitives that were culled */
	unsigned int  _numCulled;

	//////////////////////////////////////////////////////////////////////////
	//						states from random generators
	//////////////////////////////////////////////////////////////////////////

	/** File name. */
	std::string _fileName;

	/** I/O control for xuv data. */
	XpdReader *_xFile;
	std::string _currentGeom;
	int _blockIndex;

	/** Flag for indicating an error has occurred. */
	bool _errOccurred;

	//////////////////////////////////////////////////////////////////////////
	//						states from descriptions
	//////////////////////////////////////////////////////////////////////////
	double _lodAdjustment;

	//////////////////////////////////////////////////////////////////////////
	//						states from modifiers
	//////////////////////////////////////////////////////////////////////////
	safevector<XgFXModuleContext*> _fxModuleContexts;
    size_t _currentModuleIndex;

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
