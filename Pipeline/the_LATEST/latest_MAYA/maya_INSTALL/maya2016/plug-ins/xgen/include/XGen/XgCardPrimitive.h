// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgCardPrimitive.h
 * @brief Contains the declaration of the class XgCardPrimitive.
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
 *
 * @version Created 09/26/02
 */

#ifndef XGCARDPRIMITIVE_H
#define XGCARDPRIMITIVE_H

#include <iostream>
#include <string>

#include "XGen/SgVec3T.h"
#include "XGen/XgUtil.h"
#include "XGen/XgPrimitive.h"
#include "XGen/XgExpression.h"
#include "XgWinExport.h"
#include "XGen/XgCardPrimitiveContext.h"

class XgDescription;
class XgPatch;


/**
 * @brief A primitive of a card primitive.
 *
 * This class represents a card primitive.  It contains all of the attributes
 * that are needed to completely describe the card primitive.
 */
class XGEN_EXPORT XgCardPrimitive : public XgPrimitive
{
public:

    /* Constructor. */
    XgCardPrimitive( XgDescription *descr );

    /* Destructor. */
    virtual ~XgCardPrimitive();

    void createContext();
    virtual XgPrimitiveContext* cloneContextImp();
    XgCardPrimitiveContext* context() const { return (XgCardPrimitiveContext*)_context; }
    XgCardPrimitiveContext* context() { return (XgCardPrimitiveContext*)_context; }

    /** @name Accessors */
    //@{
    const XgExpression &twist() const { return _twist; }
    const XgExpression &bendU() const { return _bendU; }
    const XgExpression &bendV() const { return _bendV; }
    const XgExpression &bendParamU() const { return _bendParamU; }
    const XgExpression &bendParamV() const { return _bendParamV; }
    bool faceCamera() const {return _faceCamera; }
    //@}

    /* Scale the card. */
    void scaleCard( double lengthScale, double widthScale );

    /** Cached attributes */
    //@{
    virtual unsigned int finalCVCount() { return 5; }
    //@}


    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );

    /** Return the name of this type of primitive. */
    virtual std::string typeName() const { return "CardPrimitive"; }

    /* Bounding box for the cached guide. */
    virtual SgBox3d guideBoundingBox( unsigned int index ) const;

    /** Minimum number of CVs allowed for a guide of this primitive. */
    virtual unsigned int minGuideCVCount() const { return 5; }
    
    /* Default shape for a new guide. */
    virtual void defaultGuideGeom( XgGuide &guide );

    /* Verify the vertices meet the constraints of the card primitive. */
    virtual void verifyGuideGeom( safevector<SgVec3d> &cpts );

    /** Get external file paths used in the primitive. */
    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;
    
protected:

    /** No definition by design to prevent accidental default construction. */
    XgCardPrimitive();
    
    /** No definition by design so accidental copying is prevented. */
    XgCardPrimitive( const XgCardPrimitive &primitive );

    /** No definition by design so accidental assignment is prevented. */
    XgCardPrimitive &operator=( const XgCardPrimitive &primitive );

    /* Make the cached geometry for this primitive. */
    virtual void mkGeometry( double u, double v );
    virtual void mkGeometryInParallel( XgPrimitiveContext &context, double u, double v );

    /* Helper for creating the cached geometry from attributes. */
    void mkGeometryFromAttrs( double u, double v );
    void mkGeometryFromAttrsInParallel( XgPrimitiveContext &context, double u, double v );
    
    /* Helper for creating the cached geometry from guides. */
    void mkGeometryFromGuides( double u, double v );
    void mkGeometryFromGuidesInParallel( XgPrimitiveContext &context, double u, double v );
    
    /* Card attributes. */
    XgExpression _twist;
    XgExpression _bendU;
    XgExpression _bendV;
    XgExpression _bendParamU;
    XgExpression _bendParamV;

    /* Card display and orientation. */
    bool _faceCamera;
};


namespace XgCardUtil {

/**
 * Turn the cached control points into a polymesh that represents the
 * actual card primitive. The vector 'res' will be added to, so if a
 * single primitive is desired the vector should be cleared prior to
 * calling this method.
 *
 * Note: Currently this method just copies the cached 4x4 mesh.
 *
 * @param res vector with curve points appended
 */
template <typename T>
int
mkPolyMesh( const safevector<SgVec3d> &geom,
            safevector< SgVec3T<T> > &res )
{
    SgVec3d vecU, vecV, tmp;
    SgVec3T<T> bU, bV, bnU, bnV;
    int offset=(int)res.size();
    res.resize( offset+16 );

    // Get the CVs for the negU and negV direections
    vecU = geom[1]-geom[0];
    vecV = geom[2]-geom[0];
    SgVec3d up = vecV * vecU;
    up.normalize();
    SgXform xform;
    xform.rotation( up, M_PI );
    bU = tmp = geom[3] - geom[1];
    xform.multiply(tmp,tmp,true);
    bnU = tmp;
    bnV = tmp = geom[4] - geom[2];
    xform.multiply(tmp,tmp,true);
    bV = tmp;
    
    // Center points
    res[offset+5] = geom[0]-vecU+vecV;
    res[offset+6] = geom[0]+vecU+vecV;
    res[offset+9] = geom[0]-vecU-vecV;
    res[offset+10] = geom[0]+vecU-vecV;
    // Left edge
    res[offset+4] = res[offset+5]+bnU;
    res[offset+8] = res[offset+9]+bnU;
    // Right edge
    res[offset+7] = res[offset+6]+bU;
    res[offset+11] = res[offset+10]+bU;
    // Bottom edge 
    res[offset+1] = res[offset+5]+bnV;
    res[offset+2] = res[offset+6]+bnV;
    // Top edge 
    res[offset+13] = res[offset+9]+bV;
    res[offset+14] = res[offset+10]+bV;
    // Corners
    res[offset+0] = res[offset+5]+bnV+bnU;
    res[offset+3] = res[offset+6]+bnV+bU;
    res[offset+12] = res[offset+9]+bV+bnU;
    res[offset+15] = res[offset+10]+bV+bU;
    
    return 16;
}


/**
 * Produce normals and texture coordinates for the given polymesh. The
 * mesh is assumed to be square. The normals for each vertex are found
 * by taking the average of the adjacent faces. The angle of the faces
 * edges are not considered for performance reasons. The texture
 * coordinates are calculated as the nodal values if there were a
 * uniform knot vector that ran from zero to one. The vectors will be
 * added to, so if a single primitive is desired the vectors should be
 * cleared prior to calling this method.
 *
 * Note: Currently this method only supports 4x4 meshes.
 *
 * @param cpt the control points
 * @param offset index to first cv to use in cpt
 * @param norm normals for each vertex
 * @param texU u texture coords for each vertex
 * @param texV v texture coords for each vertex
 */
template <typename S, typename T>
void
calcNormTex( const safevector< SgVec3T<S> > &cpt,
             unsigned int offset, 
             safevector< SgVec3T<T> > &norm,
             safevector<T> &texU,
             safevector<T> &texV )
{
    int i;
    safevector<SgVec3d> faces(9);
    SgVec3d tmp;
    
    // Calculate all four faces using the corner cross products
    faces.resize(9);
    faces[0] = (cpt[offset+1]-cpt[offset+0])*
        (cpt[offset+4]-cpt[offset+0]);
    faces[1] = (cpt[offset+2]-cpt[offset+1])*
        (cpt[offset+5]-cpt[offset+1]);
    faces[2] = (cpt[offset+7]-cpt[offset+3])*
        (cpt[offset+2]-cpt[offset+3]);
    faces[3] = (cpt[offset+5]-cpt[offset+4])*
        (cpt[offset+8]-cpt[offset+4]);
    faces[4] = (cpt[offset+6]-cpt[offset+5])*
        (cpt[offset+9]-cpt[offset+5]);
    faces[5] = (cpt[offset+11]-cpt[offset+7])*
        (cpt[offset+6]-cpt[offset+7]);
    faces[6] = (cpt[offset+8]-cpt[offset+12])*
        (cpt[offset+13]-cpt[offset+12]);
    faces[7] = (cpt[offset+10]-cpt[offset+9])*
        (cpt[offset+13]-cpt[offset+9]);
    faces[8] = (cpt[offset+14]-cpt[offset+15])*
        (cpt[offset+11]-cpt[offset+15]);
    // Must normalize before adding
    for ( i=0; i<9; i++ )
        faces[i].normalize();
    
    // Average the faces to get vertex values    
    norm.push_back( SgVec3T<T>((T)faces[0][0],(T)faces[0][1],(T)faces[0][2]) );// 0
    tmp = faces[0]+faces[1]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 1
    tmp = faces[1]+faces[2]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 2
    norm.push_back( SgVec3T<T>((T)faces[2][0],(T)faces[2][1],(T)faces[2][2]) );// 3
    
    tmp = faces[0]+faces[3]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 4
    tmp = faces[0]+faces[1]+faces[3]+faces[4]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 5
    tmp = faces[1]+faces[2]+faces[4]+faces[5]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 6
    tmp = faces[2]+faces[5]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 7
    
    tmp = faces[3]+faces[6]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 8
    tmp = faces[3]+faces[4]+faces[6]+faces[7]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 9
    tmp = faces[4]+faces[5]+faces[7]+faces[8]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 10
    tmp = faces[5]+faces[8]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 11
    
    norm.push_back( SgVec3T<T>((T)faces[6][0],(T)faces[6][1],(T)faces[6][2]) );// 12
    tmp = faces[6]+faces[7]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 13
    tmp = faces[7]+faces[8]; tmp.normalize();
    norm.push_back( SgVec3T<T>((T)tmp[0],(T)tmp[1],(T)tmp[2]) );      // 14
    norm.push_back( SgVec3T<T>((T)faces[8][0],(T)faces[8][1],(T)faces[8][2]) );// 15
    
    // Put out texture coords
    T val[4] = { 0.0, 0.25, 0.75, 1.0 };
    for ( i=0; i<16; i++ ) {
        texU.push_back( val[i%4] );
        texV.push_back( val[i/4] );
    }
}

};  // namespace

#endif
