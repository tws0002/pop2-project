// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file SgCurve.h
 * @brief Contains the declaration of the class SgCurve.
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
 * @author Stephen D. Bowline
 * @author Lawrence Chai
 * @author Ying Liu
 *
 * @version Created 09/05/02
 */

#ifndef SGCURVE_H
#define SGCURVE_H

#include "XgPorting/safevector.h"
#include "XGen/SgVec3T.h"
#include "XgWinExport.h"


/**
 * @brief A simple class for cubic uniform non-rational b-spline curves.
 *
 * This class represents uniform non-rational b-splines. This assumption
 * allows us to not save (or need) knot vectors. This in turns saves a
 * ton on error checking. It is also assumed that the curve is cubic.
 */
class XGEN_EXPORT SgCurve
{
public:

    /* Evaluate the curve. */
    static void eval( const safevector<SgVec3d> &cpt, double t, SgVec3d &pt );

    /* Rebuild the curve to a given number CVs. */
    static void rebuild( safevector<SgVec3d> &result,
                         const safevector<SgVec3d> &cpt,
                         unsigned int num, bool uniform=true,
                         safevector<float> *attr=0 );

    /* Rebuild the curve to a given number of CVs in place. */
    static void rebuild( safevector<SgVec3d> &cpt, unsigned int num,
                         bool uniform=true, safevector<float> *attr=0);

    /* Subdivide the curve. */
    static void subdivide( safevector<SgVec3d> &cpt, int num );

    /* Calc length of curve. */
    static double length( const safevector<SgVec3d> &cpt );

    /* Calc the length of control poly and segments. */
    static double cpolyLength( const safevector<SgVec3d> &cpt,
                               safevector<double> &seglen );
    
    /* Adjust control points to correct length of curve. */
    static void setLength( safevector<SgVec3d> &cpt,
                           double newLength,
                           double currentLength = -1.0 );

    /* Scale a control polygon. */
    static void scalePoly( safevector<SgVec3d> &cpt, double scale, int i=0 );

    /* Cut a curve at the specified parametric position. */
    static void cut( safevector<SgVec3d> &cpt, double tCut, bool reparam );

    /* Cut a curve to the specified length. */
    static double cutToLength( safevector<SgVec3d> &cpt,
                               double length, bool reparam );

    /* Cut a curve from the tip the specified length. */
    static double cutFromTip( safevector<SgVec3d> &cpt, 
                              double length, bool reparam );

    /* Compute the CVs of a space curve for the given curve. */
    static void spaceCurve( const safevector<SgVec3d> &curve,
                            const SgVec3d &norm,
                            const SgVec3d &basePt,
                            safevector<SgVec3d> &scurve );

    /* Compute the normal and binormal at each CV of input curve. */
    static void frame( const safevector<SgVec3d> &curve,
                       const SgVec3d &N,
                       const SgVec3d &U,
                       safevector<SgVec3d> &norm,
                       safevector<SgVec3d> &binorm );
    
    /* Equally space a curve's CVs */
    static void normalize ( safevector<SgVec3d> &cpt );

private:

    /*  Helper function only used by SgCurve::cut() */
    static void cutUtil( SgVec3d * res, safevector<SgVec3d> & cpt,
                        double tCut, double spans, unsigned int ncv );


    /* Rebuild the curve to a given number of CVs. */
    static void rebuildNonUniform( safevector<SgVec3d> &result,
                                   const safevector<SgVec3d> &cpt,
                                   int num, safevector<float> *attr );

    /* Rebuild the curve to a given number of CVs. */
    static void rebuildUniform( safevector<SgVec3d> &result,
                                const safevector<SgVec3d> &cpt,
                                unsigned int num, safevector<float> *attr );
};


namespace SgCurveUtil { 

/**
 * Turn the passed in control points into a polyline.  The vector 'res'
 * will be added to, so if a single curve is desired the vector should
 * be cleared prior to calling this method. If the 'cpoly' flag is set
 * then the control poly will be output, otherwise the poly will contain
 * enough points to best represent the curve.
 *
 * @param cpoly  set if the output shold be the control poly
 * @param pts  passed in control points
 * @param res  vector with spline points appended
 */
template <typename T>
int
mkPolyLine( bool cpoly,
            const safevector<SgVec3d> &pts,
            safevector< SgVec3T<T> > &res, int samplesPerPoint=2 )
{
    SgVec3d pt;
    double t, dt;
    unsigned int totalPts;

    if ( cpoly ) {
        // Special case to output the control poly
        totalPts = (unsigned int)pts.size();
        for ( unsigned int i=0; i<pts.size(); i++ )
            res.push_back( pts[i] );
    } else {    
        // Store points evenly along spline
        unsigned int count = (unsigned int)pts.size();
        totalPts = samplesPerPoint*count;
        
		// Store the start point
        t = 0.0f;
		dt = 1.0/(totalPts-1);
        for ( unsigned int i=0; i<totalPts; i++ ) {
            SgCurve::eval( pts, t, pt );
            res.push_back( pt );
            t += dt;
        }
    }
        
    return totalPts;
}


/**
 * Produce normals and texture coordinates for the given polyline.
 * The faces are determined by adding width to the polyline in the
 * direction of the twist.  The normals for each vertex are found by
 * taking the average of the adjacent faces.  The angle of the faces'
 * edges are not considered for performance reasons.  The texture
 * coordinates are calculated as the param values if there were a
 * uniform knot vector that ran from zero to one. The vectors will be
 * added to, so if a single primitive is desired the vectors should be
 * cleared prior to calling this method.
 *
 * @param cpt the control points
 * @param W the width direction
 * @param width base width of the spline
 * @param taper taper for the spline
 * @param taperStart parameter to start tapering
 * @param widths the width vector for each vertex
 * @param norm normals for each vertex
 * @param texU u texture coords for each vertex
 * @param texV v texture coords for each vertex
 * @param widthScale array of scale factor of each width vector
 */
template <typename T>
void
calcNormTex( const safevector<SgVec3d> &cpt,
             const SgVec3d &W,
             float width,
             float taper,
             float taperStart,
             safevector< SgVec3T<T> > *widths = 0,
             safevector< SgVec3T<T> > *norm = 0,
             safevector< T > *texU = 0,
             safevector< T > *texV = 0,
             const safevector<double> *widthScale = 0)
{
    SgVec3T<T> tmpW = W;
    SgVec3T<T> splineVec;
    
    // Calculate the normals.
    if ( cpt.size() < 3 ) return;

    const T dv = T(1.0) / (cpt.size()-1);
    T v = T(0.0);
    for ( unsigned int i = 0; i < cpt.size(); i++ ) {
        // reuse on last point
        if ( i < (cpt.size()-1) ) {
            SgVec3T<T> tmpS = cpt[i+1] - cpt[i];
            // reuse if the segment is to short
            if ( tmpS.dot(tmpS) > T(1e-10) )
                splineVec = tmpS;
        }
        SgVec3T<T> widthVec = splineVec * ( tmpW * splineVec );
        if ( widthVec.dot(widthVec) < T(1e-10) )
            widthVec = splineVec.orthogonal();
        widthVec.normalize();
        tmpW = widthVec;
        if ( width > T(0.0) ) {
            T scale = width / T(2.0);
            if ( v > taperStart ) { 
                scale *= T(1.0) - taper * ((v-taperStart)/(T(1.0)-taperStart));
            }
            
            if (widthScale)
                scale *= (*widthScale)[i] ;    //to scale each segment.
            widthVec *= scale;
        }
        if ( widths ) {
            widths->push_back( widthVec );
        }
        if ( norm ) {
            SgVec3T<T> normalVec = tmpW * splineVec;
            normalVec.normalize();
            norm->push_back( normalVec );
        }
        v += dv;
    }

    if ( texU || texV ) {
        // Put out texture coords.
        v = T(0.0);
        for ( unsigned int i = 0; i < cpt.size()-1; i++ ) {
            if ( texU ) texU->push_back( T(0.0) );
            if ( texV ) texV->push_back( v );
            v += dv;
        }
        if ( texU ) texU->push_back( T(0.0) );
        if ( texV ) texV->push_back( T(1.0) );
    }
}
    
};


#endif
