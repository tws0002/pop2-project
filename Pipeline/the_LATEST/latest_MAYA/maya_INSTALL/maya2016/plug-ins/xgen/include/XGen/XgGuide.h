// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef XGGUIDE_H
#define XGGUIDE_H

#include <string>
#include "XgPorting/safevector.h"
#include <map>
#include <set>

#include "XGen/XgDict.h"
#include "XGen/SgVec3T.h"
#include "XGen/SgBox3T.h"
#include "XGen/SgXform3T.h"
#include "XGen/SgKdTreeNT.h"
#include "XgWinExport.h"

class XgPatch;
class XgPalette;

class XGEN_EXPORT XgGuide {
    public:
        XgGuide() : _u(0.0),_v(0.0),_faceId(0),_patch(0),_id("#"),_blend(0.0),_region(0),_transformedToSurface(false)
            {_cached[0]=_cached[1]=false; _radius.resize(1);_radius[0]=0.001;}
        ~XgGuide() {;}
        
        double u() const { return _u; }
        void setU( double u );
        double v() const { return _v; }
        void setV( double v );

        double patchU() const { return _patchU; }
        double patchV() const { return _patchV; }
        void setPatchUV( double u, double v ) { _patchU = u; _patchV = v; }

        bool enabledInExporting() const { return _enabledInExporting; }
        void enableInExporting( bool enable ) { _enabledInExporting = enable; }
        const SgVec3d& exportedNormal() const { return _exportedNormal; }
        const SgVec3d& exportedUTangent() const { return _exportedUTangent; }
        const SgVec3d& exportedVTangent() const { return _exportedVTangent; }
        void setExportedNormal( double* n ) { _exportedNormal.setValue(n); }
        void setExportedUTangent( double* ut ) { _exportedUTangent.setValue(ut); }
        void setExportedVTangent( double* vt ) { _exportedVTangent.setValue(vt); }

        int faceId() const { return _faceId; }
        void setFaceId( int faceId );
        const XgPatch *patch() const { return _patch; }
        void setPatch( const XgPatch *p );
        const std::string &id() const { return _id; }
        void setId( const std::string &id );
        void setId( XgPalette *pal );
        
        double blend() const { return _blend; }
        void setBlend( double b ) { _blend = b; }
        std::string interpolation() const;
        void setInterpolation( const std::string &interp );
        const safevector<double> &radius() const { return _radius; }
        double radius( int i ) const { return _radius[i]; }
        const safevector<double> &angle() const { return _angle; }
        double angle( int i ) const { return _angle[i]; }
        const safevector<double> &delta() const { return _delta; }
        double delta( int i ) const { return _delta[i]; }
        unsigned int region() const { return _region; }
        void setRegion( unsigned int r ) { _region=r; }
        
        const SgVec3d &cGuideP( bool pref=true ) const;			// Turbo: thread-safe if pref==true, since it's already cached by XgPrimitive::initDescription() => XgPrimitive::setupInterpolation() => XgGuide::cGuideP()
        const SgVec3d &cGuideN( bool pref=true ) const;			// Turbo: thread-safe if pref==true, since it's already cached by XgPrimitive::initDescription() => XgPrimitive::setupInterpolation() => XgGuide::cGuideP()
        const SgVec3d &cGuideTangent( bool pref=true ) const;	// Turbo: thread-safe if pref==true, since it's already cached by XgPrimitive::initDescription() => XgPrimitive::setupInterpolation() => XgGuide::cGuideP()
        const SgVec3d &cGuideBinormal( bool pref=true ) const;	// Turbo: thread-safe if pref==true, since it's already cached by XgPrimitive::initDescription() = >XgPrimitive::setupInterpolation() => XgGuide::cGuideP()

        XgDict< safevector<float> > &guideCVAttrs() { return _guideCVAttrs; }
        
        const safevector<SgVec3d> &iGuideGeom() const { return _iGuideGeom; }
        const SgVec3d &iGuideGeom( int i ) { return _iGuideGeom[i]; }
        void setIGeom( const safevector<SgVec3d> &cpts ) { _iGuideGeom=cpts; }

        const safevector<SgVec3d> &iOrigGuideGeom() const { return _iOrigGuideGeom; }
        void setOrigIGeom( const safevector<SgVec3d> &cpts ) { _iOrigGuideGeom=cpts; }

        const safevector<SgVec3d> &cGuideGeom() const { return _cGuideGeom; }
        safevector<SgVec3d> &cGuideGeomRef() { return _cGuideGeom; }
        const SgVec3d &cGuideGeom( int i ) { return _cGuideGeom[i]; }	
        XgDict< SgVec3d > &guideCustomAttrsRef() { return _guideCustomAttrs; } 
        const XgDict< SgVec3d > &guideCustomAttrs() const { return _guideCustomAttrs; } 

        void setTransformedToSurface( bool b ) { _transformedToSurface=b; }
        bool transformedToSurface() { return _transformedToSurface; }

        unsigned int intId() const;
    private:
        void patchFrame( int index ) const;
        double _u, _v;
        double _patchU, _patchV;
        SgVec3d _exportedNormal, _exportedUTangent, _exportedVTangent;
        bool _enabledInExporting;
        int _faceId;
        const XgPatch *_patch;
        std::string _id;
        double _blend;
        unsigned int _region;
        safevector<double> _radius;
        safevector<double> _angle;
        safevector<double> _delta;
        mutable bool _cached[2];
        mutable SgVec3d _cGuideP[2];
        mutable SgVec3d _cGuideN[2];
        mutable SgVec3d _cGuideTangent[2];
        mutable SgVec3d _cGuideBinormal[2];
        XgDict< safevector<float> > _guideCVAttrs;	// Turbo: thread-safe. Modified in CacheUtil::overrideGuides() and XgmGuide::pushAttributes()
        XgDict< SgVec3d > _guideCustomAttrs;		// Turbo: thread-safe. Read-only when generating primitives.
        safevector<SgVec3d> _iGuideGeom;			// interactive/user guide
        safevector<SgVec3d> _iOrigGuideGeom;         // the original guide, used for export the guide. _iGuideGeom may store the guide imported from cache file
        safevector<SgVec3d> _cGuideGeom;			// cached/render guide
        bool _transformedToSurface;
};

#endif
