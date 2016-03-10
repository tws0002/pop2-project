// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file SgBox3T.h
 * @brief Contains the declaration of the class SgBox3T.
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
 * @version Created 05/15/02
 */

#ifndef SGBOX3T_H
#define SGBOX3T_H

#include <algorithm>

#include "XgPorting/safevector.h"
#include "XGen/SgVec3T.h"


/**
 * @brief A 3d box/rectangle class.
 *
 * This class represents a 3d box by storing two SgVec3<T> vectors representing
 * an origin and offset (which are all positive values).
 */
template <typename T>
class SgBox3T
{
public:

    /** Default constructor. */
    SgBox3T() : _origin(), _offset(), _set(false) {}

    /** Origin and offset constructor. */
    SgBox3T( const SgVec3T<T> &origin, SgVec3T<T> &offset )
        { setValue( origin, offset ); }

    /* Constructor using 4 geometry face points. */
    SgBox3T( const SgVec3T<T> &basePt, const SgVec3T<T> &lengthPt, 
             const SgVec3T<T> &widthPt, const SgVec3T<T> &depthPt );

    /* Constructor from a series of points */
    SgBox3T( const safevector< SgVec3T<T> > &pts );
    
    /** Component constructor. */
    SgBox3T( T xo, T yo, T zo, T dx, T dy, T dz )
        { setValue( xo, yo, zo, dx, dy, dz); }
    
    /** Copy constructor. */
    SgBox3T( const SgBox3T &b )
        { _origin = b._origin; _offset = b._offset; _set = b._set; }

    /** Destructor. */
    ~SgBox3T() {;}

    /** Assignment. */
    SgBox3T<T> &operator =( const SgBox3T &b )
        { setValue( b._origin, b._offset ); return *this; }

    /* Equality comparison. */
    bool operator ==( const SgBox3T &b ) const
        { return _origin == b._origin && _offset == b._offset; }
    
    /** Inequality comparison. */
    bool operator !=( const SgBox3T &b ) const
        { return !(*this == b); }

    /* Intersection. */
    SgBox3T<T> operator &( const SgBox3T &b ) const;

    /** Intersection. In-place version. */
    SgBox3T<T> &operator &=( const SgBox3T &b )
        { *this = *this & b; return *this; }
    
    /* Union. */
    SgBox3T<T> operator |( const SgBox3T &b ) const;
    
    /** Union. In-place version.*/
    SgBox3T<T> &operator|=( const SgBox3T &b )
        { *this = *this | b; return *this; }
    
    /** Get origin coordinates. */
    void getOrigin( T &x, T &y, T &z ) const
        { _origin.getValue( x, y, z ); }
    
    /** Get origin. Constant version. */
    const SgVec3T<T> &getOrigin() const
        { return _origin; }

    /** Get offset coordinates. */
    void getOffset( T &x, T &y, T &z ) const
        { _offset.getValue( x, y, z ); }
    
    /** Get offset. Constant version. */
    const SgVec3T<T> &getOffset() const
        { return _offset; }

    /** Get minimum values. */
    void getMin( SgVec3T<T> &bmin ) const
        { bmin = _origin; }

    /** Get maximum values. */
    void getMax( SgVec3T<T> &bmax ) const
        { bmax = _origin + _offset; }

    /** Get width. */
    T getWidth() const
        { return _offset[0]; }

    /** Get height. */
    T getHeight() const
        { return _offset[1]; }
    
    /** Get depth. */
    T getDepth() const
        { return _offset[2]; }

    /** Set origin coordinates. */
    void setOrigin( T x, T y, T z )
        { _origin.setValue( x, y, z ); _set=true; }
    
    /** Set origin. */
    void setOrigin( const SgVec3T<T> &origin )
        { _origin = origin; _set=true; }

    /** Set offset coordinates. */
    void setOffset( T x, T y, T z )
        { setWidth(x); setHeight(y); setDepth(z); }
    
    /** Set offset. */
    void setOffset( const SgVec3T<T> &offset )
        { setOffset( offset[0], offset[1], offset[2] ); }

    /** Set width. */
    void setWidth( T w )
        { _offset[0] = ( w > 0.0 ? w : 0.0 ); _set=true; }
    
    /** Set height. */
    void setHeight( T h )
        { _offset[1] = ( h > 0.0 ? h : 0.0 ); _set=true; }
    
    /** Set depth. */
    void setDepth( T d )
        { _offset[2] = ( d > 0.0 ? d : 0.0 ); _set=true; }

    /** Set height, width, and depth. */
    void setHWD( T h, T w, T d )
        { setHeight(h); setWidth(w); setDepth(d); }
    
    /* Extend box. */
    void extend( const T margin );
    void extend( const SgVec3T<T> &pt );
    void extend( const safevector< SgVec3T<T> > &pts );
    
    /* Check for intersection. */
    bool intersects( const SgBox3T &b ) const;

    /* Check for point containment. */
    bool contains( const SgVec3T<T> &pt, double tolerance ) const;
    
    /** Set values for whole box. */
    void setValue( const SgVec3T<T> &origin, const SgVec3T<T> &offset )
        { setOrigin( origin ); setOffset( offset ); }

    /** Set values component-wise for whole box. */
    void setValue( T xo, T yo, T zo,
                   T dx, T dy, T dz)
        { setOrigin(xo, yo, zo); setOffset(dx, dy, dz); }
    
    /** Zero area. */
    bool isEmpty() const
        { return (_offset[0] == 0.0 &&
                  _offset[1] == 0.0 && 
                  _offset[2] == 0.0); }

    /** Reset the bounding box to empty and unused. */
    void reset() { setValue( 0.0,0.0,0.0, 0.0,0.0,0.0 ); _set=false; }
    
    /** Compute the volume of the box. */
    T getVolume() { return _offset[0] * _offset[1] * _offset[2]; }

private:

    /** Geometry of the box. */
    SgVec3T<T>  _origin;
    SgVec3T<T>  _offset;

    /** Flag set when the box has been set. */
    bool _set;
};


typedef SgBox3T<double> SgBox3d;
typedef SgBox3T<float>  SgBox3f;


/**
 * Construct a 3d box to contain a series of points.
 *
 * @param pts the points to be covered by the box
 */
template <typename T>
SgBox3T<T>::SgBox3T( const safevector< SgVec3T<T> > &pts )
{
    _set = false;
    extend( pts );
}


/**
 * Constructor using 4 geometry points that define a box from a central
 * base point. This means the four points are on the bounding box, but
 * do not sufficiently define it. 
 * 
 * @param basePt  origin of the geometry centered in base face
 * @param lengthPt  point centered on the top face defining length vector
 * @param widthPt  point centered on the right face defining width vector
 * @param depthPt  point centered on the front face defining depth vector
 */
template <typename T>
SgBox3T<T>::SgBox3T( const SgVec3T<T> &basePt, const SgVec3T<T> &lengthPt, 
                     const SgVec3T<T> &widthPt, const SgVec3T<T> &depthPt )
{
    // Compute all the corner points of the bounding box from the given points
    safevector< SgVec3T<T> > cpt(8);
    SgVec3T<T> midPt, dVec, wVec;
    midPt = (lengthPt - basePt)*T(0.5) + basePt;
    dVec = depthPt-midPt;
    wVec = widthPt-midPt;
    
    cpt[0] = basePt + dVec - wVec;
    cpt[1] = basePt + dVec + wVec;
    cpt[2] = basePt - dVec - wVec;
    cpt[3] = basePt - dVec + wVec;

    cpt[4] = lengthPt + dVec - wVec;
    cpt[5] = lengthPt + dVec + wVec;
    cpt[6] = lengthPt - dVec - wVec;
    cpt[7] = lengthPt - dVec + wVec;

    _set = false;
    extend( cpt );
}


/**
 * Determine the intersection of two 3d boxes. If no intersection
 * exists then the empty box will be returned as the result.
 *
 * @param b the second box ('this' being the first)
 */
template <typename T>
SgBox3T<T>
SgBox3T<T>::operator&( const SgBox3T<T> &b ) const
{
    SgBox3T<T> retBox;

    // See if there is an intersection.
    if ( !intersects( b ) )
        return retBox;

    // At this point there is definitely some intersection.
    SgVec3T<T> retO = retBox.getOrigin();
    retO[0] = std::max(_origin[0], b._origin[0]);
    retO[1] = std::max(_origin[1], b._origin[1]);
    retO[2] = std::max(_origin[2], b._origin[2]);
    retBox.setOrigin( retO );
    
    retBox.setWidth( std::min( _origin[0] + _offset[0],
                               b._origin[0] + b._offset[0] ) - retO[0] );
    retBox.setHeight( std::min( _origin[1] + _offset[1],
                                b._origin[1] + b._offset[1]) - retO[1] );
    retBox.setDepth( std::min( _origin[2] + _offset[2],
                               b._origin[2] + b._offset[2]) - retO[2] );

    return retBox;
}


/**
 * Determine the union of two 3d boxes. If either box is the empty
 * box then a copy of the second will be returned (possibly empty).
 *
 * @param b the second box ('this' being the first)
 */
template <typename T>
SgBox3T<T>
SgBox3T<T>::operator |( const SgBox3T<T> &b ) const
{
    // Make sure this isn't the identity.
    if ( isEmpty() )
        return b;
    if ( b.isEmpty() )
        return *this;

    SgBox3T<T> retBox;
    SgVec3T<T> retO = retBox.getOrigin();
    retO[0] = std::min(_origin[0], b._origin[0]);
    retO[1] = std::min(_origin[1], b._origin[1]);
    retO[2] = std::min(_origin[2], b._origin[2]);
    retBox.setOrigin( retO );

    retBox.setWidth( std::max( _origin[0] + _offset[0],
                     b._origin[0] + b._offset[0] ) - retO[0] );
    retBox.setHeight( std::max( _origin[1] + _offset[1],
                      b._origin[1] + b._offset[1] ) - retO[1] );
    retBox.setDepth( std::max( _origin[2] + _offset[2],
                     b._origin[2] + b._offset[2] ) - retO[2] );

    return retBox;
}


/**
+ * Extend a 3d box by the given margin in all directions.
+ *
+ * @param margin the amount to extend the box (>0)
+ */
template <typename T>
void
SgBox3T<T>::extend( const T margin )
{
	if ( !_set || margin <= 0 )
		return;

	_origin[0] -= margin;
	_origin[1] -= margin;
	_origin[2] -= margin;

	T amount = 2 * margin;
	_offset[0] += amount;
	_offset[1] += amount;
	_offset[2] += amount;
}


/**
 * Extend a 3d box to contain the given point.
 *
 * @param pt the point to extend box around
 */
template <typename T>
void
SgBox3T<T>::extend( const SgVec3T<T> &pt )
{
    // If the box hasnt been used yet then place the origin at the given
    // point and mark the box used. We cant just check the "isEmpty"
    // method since we would never get to the second point, which would
    // set the "offset".
    if ( !_set ) {
        _origin = pt;
        _set = true;
        return;
    }
    
    // Figure out the other corner of the box.
    SgVec3T<T> other = _origin + _offset;

    _origin[0] = std::min( _origin[0], pt[0] );
    _origin[1] = std::min( _origin[1], pt[1] );
    _origin[2] = std::min( _origin[2], pt[2] );

    other[0] = std::max( other[0], pt[0] );
    other[1] = std::max( other[1], pt[1] );
    other[2] = std::max( other[2], pt[2] );

    setOffset( other[0]-_origin[0],
               other[1]-_origin[1],
               other[2]-_origin[2] );
}


/**
 * Extend a 3d box to contain a series of points.
 *
 * @param pts the points to extend box around
 */
template <typename T>
void
SgBox3T<T>::extend( const safevector< SgVec3T<T> > &pts )
{
    unsigned int size = (unsigned int)pts.size();
    if ( !size )
        return;
    
    // If the box hasnt been used yet, 
    // then place the origin at the given point.
    int startPos = 0;
    if ( !_set ) {
        setOrigin( pts[0] );
        if ( size < 2 ) // only one point
            return;
        startPos = 1;
    }
       
    SgVec3T<T> other = pts[0];

    // Extend the box to include all the points
    for ( unsigned int i = startPos; i < size; i++ )
    {
        _origin[0] = std::min( _origin[0], pts[i][0] );
        _origin[1] = std::min( _origin[1], pts[i][1] );
        _origin[2] = std::min( _origin[2], pts[i][2] );
        other[0] = std::max( other[0], pts[i][0] );
        other[1] = std::max( other[1], pts[i][1] );
        other[2] = std::max( other[2], pts[i][2] );
    }
    
    // Set the offset of the box
    setOffset( other[0] - _origin[0],
               other[1] - _origin[1],
               other[2] - _origin[2] );
}


/**
 * Check for intersection with another box.
 *
 * @param b box to check for intersection with
 */
template <typename T>
bool
SgBox3T<T>::intersects( const SgBox3T<T> &b ) const
{
    // Check for zero extent.
    if ( isEmpty() )
        return false;
    if ( b.isEmpty() )
        return false;

    // Check for no overlap.
    if ( _origin[0] + _offset[0] <= b._origin[0] )
        return false;
    if ( _origin[1] + _offset[1] <= b._origin[1] )
        return false;
    if ( _origin[2] + _offset[2] <= b._origin[2] )
        return false;
    if ( b._origin[0] + b._offset[0] <= _origin[0] )
        return false;
    if ( b._origin[1] + b._offset[1] <= _origin[1] )
        return false;
    if ( b._origin[2] + b._offset[2] <= _origin[2] )
        return false;

    // There is an intersection.
    return true;
}


/**
 * Check for point containment with box.
 *
 * @param pt point to check for containment
 */
template <typename T>
bool
SgBox3T<T>::contains( const SgVec3T<T> &pt, double tolerance ) const
{
    // Check for zero extent.
    if ( isEmpty() )
        return false;

    // Check for no containment.
    if ( _origin[0] + _offset[0] + tolerance <= pt[0] )
        return false;
    if ( _origin[1] + _offset[1] + tolerance <= pt[1] )
        return false;
    if ( _origin[2] + _offset[2] + tolerance <= pt[2] )
        return false;
    if ( pt[0] <= _origin[0] - tolerance )
        return false;
    if ( pt[1] <= _origin[1] - tolerance )
        return false;
    if ( pt[2] <= _origin[2] - tolerance )
        return false;

    // There is containment.
    return true;
}

#endif
