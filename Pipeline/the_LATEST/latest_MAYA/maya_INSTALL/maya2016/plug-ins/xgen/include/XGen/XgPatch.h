// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgPatch.h
 * @brief Contains the declaration of the class XgPatch.
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
 * @author Lee Gramling
 * @author Lawrence Chai
 *
 * @version Created 05/30/02
 */

#ifndef XGPATCH_H
#define XGPATCH_H

#include <iostream>
#include <map>
#include <set>
#include <string>

#include "XGen/XgDescription.h"
#include "XGen/XgPrimitive.h"
#include "XGen/XgUtil.h"
#include "XgWinExport.h"

class SgSurface;
class XgExpression;

class XGEN_EXPORT SgSurfaceCache
{
public:
    static void addSgSurface(const std::string& name, SgSurface* surface);
    static SgSurface* find(const std::string& name);

    static void ref(SgSurface* surface);
    static void unref(SgSurface* surface);

private:
    SgSurfaceCache();
    ~SgSurfaceCache();

    static std::map<std::string, SgSurface*> _surfaces;
    static std::map<SgSurface*, std::pair<std::string, int> > _cache;
};

/**
 * @brief A base class that acts as a wrapper around geometry.
 *
 * This class is the base class for all patch wrapper classes.  The class is
 * meant to act as a wrapper over geometry such as a NURBS surface which
 * abstracts the information which is needed to populate the geometry with a
 * primitive.  It also allows for optimizations by storing area, arc length,
 * and other information so that does not need to be calculated more than
 * once.
 */
class XGEN_EXPORT XgPatch
{
public:

    /* Constructor. */
    XgPatch( XgDescription *descr );

    /* Destructor. */
    virtual ~XgPatch();

    /** @name Accessors */
    //@{
    const std::string &name() const { return _name; }
    void setName(const std::string &name);
    const std::map< int, std::set<unsigned int> > &culledPrims() const
        { return _culledPrims; }
    bool isCulled( const int faceId, const unsigned int primId );
    void cullPrim( const int faceId, const unsigned int primId )
        { _culledPrims[faceId].insert(primId); }
    void unCullPrim( const int faceId, const unsigned int primId );
    void cullReset() { _culledPrims.clear(); }
    unsigned int index() const { return _index; }
    void setIndex( unsigned int i ) { _index = i; }
    XgDescription *description() const { return _description; }
    //@}

    /** @name Patch Evaluators */
    //@{
    virtual SgBox3d boundingBox( bool pref=false ) const = 0;
    virtual SgBox3d boundingBox( int faceId, bool pref=false ) const = 0;
    
    bool evalGeom( double u, double v, int faceId, SgVec3d &P,
                   bool pref=false ) const;
    bool evalGeom( double u, double v, int faceId, SgVec3d &P, SgVec3d &N,
                   SgVec3d &dPdu, SgVec3d &dPdv, bool pref ) const;
    bool evalGeom( double u, double v, int faceId,
                   const XgExpression &displacement,
		   const bool vectorDisplacement, const XgExpression &bump,
                   const XgExpression &offset, SgVec3d &P, SgVec3d &N,
                   SgVec3d &dPdu, SgVec3d &dPdv, bool pref ) const;

    bool evalFrame( double u, double v, int faceId, SgVec3d &P, SgVec3d &N,
                    SgVec3d &U, SgVec3d &V, bool pref=false ) const;

    bool evalCurvature( double u, double v, int faceId, float &ku, float &kv,
                        bool pref ) const
        { return pureEvalCurvature( u, v, faceId, ku, kv, pref ); }

    unsigned int numFaces() const { return (unsigned int)_faceIds.size(); }
    bool hasFaceId( int faceId ) const;
	bool hasOrigFaceId( int origFaceId ) const;
    const int faceId( int index ) const { return _faceIds[index]; }
    safevector<int> &faceIds() { return _faceIds; }
    virtual safevector<int> origFaceIds() const = 0;
    void sortFaceIds();
    virtual unsigned int numGeomFaces() const = 0;
    virtual void origToLogical( int faceId,safevector<int> &logical,
                                bool clearLogicalIds = true ) const = 0;
    virtual void logicalToOrig( int faceId,safevector<int> &orig,
                                bool clearOrigIds = true ) const = 0;

    virtual double calculateSubAreas( int faceId, int subdivs, int &m, int &n,
                                      safevector<double> &subArea ) const = 0;
    virtual double area( int faceId ) const = 0;
    virtual double lengthU( double u, int faceId ) const = 0;
    virtual double lengthV( double v, int faceId ) const = 0;    
    //@}

    /* Returns the memory used and computes the resolution per face. */
    virtual double computeResolution(std::map<XgPatch *,
                                     safevector<unsigned short> > &resmap,
                                     const double texelsPerUnit ) = 0;
    /* Returns the memory used and computes the resolution per face. */
    virtual double computeFaceResolution( safevector<unsigned short> &res, 
                                          const safevector<int> &faceids, 
                                          double texelsPerUnit ) = 0;
    /* Returns the number of texels and computes the resolution of face. */
    virtual int computeFaceResolution( unsigned short &resU,
                                       unsigned short &resV, 
                                       const int faceid, 
                                       double texelsPerUnit ) = 0;

    /** true if the patch is bound to geometry. */
    virtual bool isBound() const { return false; }

    /** true if the patch is referenced (Pref). */
    virtual bool isReferenced() const { return false; }

    /** Geometry Binding Methods */
    //@{
    virtual void bindGeometry( SgSurface *pref, SgSurface *base,
                               bool translateFaceIds )= 0;
    virtual void unbindGeometry() = 0;
    //@}

    /** Return the name of this type of patch. */
    virtual std::string typeName() const = 0;

    /** @name IO functions. */
    //@{
    bool exportObj( std::ostream &os) const;
    bool importObj( std::istream &is );
    bool processToken( const std::string &token, std::istream &is );
    //@}

	class XGEN_EXPORT AnimCurves
	{
	public:
		AnimCurves()
			:_description(0),
			_moduleName(""),
			_patchName("")

		{}
		AnimCurves( XgDescription *description, std::string moduleName, std::string patchName ) 
			:_description(description),
			_moduleName(moduleName),
			_patchName(patchName)
		{} 
		AnimCurves( const AnimCurves &o )
		{ 
			_wires = o._wires;
			_wireNames = o._wireNames;
			_description = o._description; 
			_moduleName = o._moduleName; 
			_patchName = o._patchName; 
		}
		safevector< safevector<SgVec3d> > &wires() { return _wires; } 
		safevector<std::string> &wireNames();
		bool guideAnimation();

	private:
		safevector< safevector<SgVec3d> > _wires; 
		safevector<std::string> _wireNames; 
		XgDescription *_description;
		std::string _moduleName; 
		std::string _patchName;

	};

	XgDict< SgVec3d > &customAttrs() { return _customAttrs; } 

	XgDict< AnimCurves > &animCurves() { return _animCurves; } 

	bool getAttrValue( const std::string& attrsName, SgVec3d& attrVal );
			    

protected:

    /** No definition by design to prevent accidental default construction. */
    XgPatch();
    
    /** No definition by design so accidental copying is prevented. */
    XgPatch( const XgPatch &patch );

    /** No definition by design so accidental assignment is prevented. */
    XgPatch &operator=( const XgPatch &patch );


    /** Derived class version for "pure" evaluation. */
    virtual bool pureEvalGeom( double u, double v, int faceId,
                               SgVec3d &P, SgVec3d &N, SgVec3d &dPdu,
                               SgVec3d &dPdv, bool pref ) const = 0;
    virtual bool pureEvalCurvature( double u, double v, int faceId, 
                                    float &ku, float &kv,
                                    bool pref ) const = 0;

    /** Name of the geometry to which patch is bound. */
    std::string _name;

    /** Description back pointer. */
    XgDescription *_description;

    /** The set of culled primitives on this patch. */
    std::map< int, std::set<unsigned int> > _culledPrims;

    /** The face ids */
    safevector<int> _faceIds;

    /** Index within the description. */
    unsigned int _index;

	XgDict< SgVec3d > _customAttrs;


	XgDict< AnimCurves > _animCurves; 
};


#endif
