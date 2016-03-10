// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/** 
 * @file SgXform3T.h
 * @brief Contains the declaration of transformation matrix class SgXform3T.
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
 *
 * @version Created 04/30/03
 */

#ifndef SGXFORM3T_H
#define SGXFORM3T_H

#include <algorithm>

#include <string.h>
#include <stdio.h>

#include "XGen/SgVec3T.h"
#include "XGen/SgBox3T.h"


/**
 * @brief A class representing a transformation matrix.
 *
 * A transformation matrix. The values are stored in column order with
 * multiplication being column vector on the right.
 */
template <typename T>
class SgXform3T
{
public:

    enum Indices { SX =  0, SY =  5, SZ = 10,
                   TX = 12, TY = 13, TZ = 14 };
                   
    /* Constructor. */
    SgXform3T() { identity(); }
    SgXform3T( const SgXform3T &x ) { copy( x ); }

    /**  Constructor for 4x4 arrays from Maya's MMatrix::get() */
    SgXform3T( const T C[4][4] ) 
        { memcpy( _mat, C, sizeof(T) * 16); }

    /** Column vector constructor.  */
    SgXform3T(const SgVec3T<T> &C0,const SgVec3T<T> &C1,const SgVec3T<T> &C2)
    {
        _mat[0] = C0[0]; _mat[4] = C1[0]; _mat[8]  = C2[0]; _mat[12] = 0.0;
        _mat[1] = C0[1]; _mat[5] = C1[1]; _mat[9]  = C2[1]; _mat[13] = 0.0;
        _mat[2] = C0[2]; _mat[6] = C1[2]; _mat[10] = C2[2]; _mat[14] = 0.0;
        _mat[3] = 0.0;   _mat[7] = 0.0;   _mat[11] = 0.0;   _mat[15] = 1.0;
    }

    /** Full column vector constructor.  */
    SgXform3T( const SgVec3T<T> &C0, const SgVec3T<T> &C1,
               const SgVec3T<T> &C2, const SgVec3T<T> &C3 )
    {
        _mat[0] = C0[0]; _mat[4] = C1[0]; _mat[8]  = C2[0]; _mat[12] = C3[0];
        _mat[1] = C0[1]; _mat[5] = C1[1]; _mat[9]  = C2[1]; _mat[13] = C3[1];
        _mat[2] = C0[2]; _mat[6] = C1[2]; _mat[10] = C2[2]; _mat[14] = C3[2];
        _mat[3] = 0.0;   _mat[7] = 0.0;   _mat[11] = 0.0;   _mat[15] = 1.0; 
    }

    /** Element by element */
    SgXform3T( const T  c0, const T  c1, const T  c2,
               const T  c4, const T  c5, const T  c6,
               const T  c8, const T  c9, const T c10,
               const T c12, const T c13, const T c14 )
    {
        _mat[0] = c0;  _mat[4] = c4;  _mat[8]  = c8;  _mat[12] = c12;
        _mat[1] = c1;  _mat[5] = c5;  _mat[9]  = c9;  _mat[13] = c13;
        _mat[2] = c2;  _mat[6] = c6;  _mat[10] = c10; _mat[14] = c14;
        _mat[3] = 0.0; _mat[7] = 0.0; _mat[11] = 0.0; _mat[15] = 1.0; 
    }

    /* Destructor. */
    virtual ~SgXform3T() {}
    

    /* Down conversion to float */
    operator SgXform3T<float>() const
    {
        return SgXform3T<float>(
            (float)_mat[ 0], (float)_mat[ 1], (float)_mat[ 2],
            (float)_mat[ 4], (float)_mat[ 5], (float)_mat[ 6],
            (float)_mat[ 8], (float)_mat[ 9], (float)_mat[10],
            (float)_mat[12], (float)_mat[13], (float)_mat[14] );
    }

    /** Assignment. */
    SgXform3T<T> &operator =( const SgXform3T<T> &x )
        { copy( x ); return *this; }

    /* Accesses indexed component of xform. */
    T       &operator []( int i )          { return _mat[i]; }
    const T &operator []( int i ) const    { return _mat[i]; }

    /* operations */
    inline void identity();
    void transpose();
    void transpose( const SgXform3T<T> &a );
    void copy( const SgXform3T<T> &x );
    void multiply( const SgXform3T<T> &a, const SgXform3T<T> &b );
    void multiply( const SgVec3T<T> &pt, SgVec3T<T> &res,
                   bool vec=false, int dir=1 ) const;
    void  map_bb( const SgBox3T<T> &b, SgBox3T<T> &res );
    T inverse( );
    T inverse( const SgXform3T<T> &a );
    T scale_comp();

    /* Transformation builders */
    void rotation( const SgVec3T<T> &src, const SgVec3T<T> &dest );
    void rotation( const SgVec3T<T> &axis, T angle );
    void rotationX( T angle );
    void rotationY( T angle );
    void rotationZ( T angle );
    void translation( const SgVec3T<T> &dir );
    void scale( const SgVec3T<T> &mag );
    void basis( const SgVec3T<T> &origin, const SgVec3T<T> &xPt,
                const SgVec3T<T> &yPt, const SgVec3T<T> &zPt );
    
    /* accessor methods */
    T      *mat()               { return _mat; }
    T       mat( int i ) const  { return _mat[i]; }
    T      &mat( int i )        { return _mat[i]; }
    T      &mat( int r, int c ) { return _mat[r + c*4]; }
    T       mat( int r, int c ) const { return _mat[r + c*4]; }
    
    SgVec3T<T> getTranslation() const;
    
    /* Print out the xform. */
    void print() const;

    /* Convert to and from string. */
    std::string toString() const;
    bool fromString( const std::string &x );

private:
    T      _mat[16];    /* matrix value in column order */
};


typedef SgXform3T<double> SgXform;
typedef SgXform3T<double> SgXform3d;
typedef SgXform3T<float>  SgXform3f;


/**
 * Make this xform an identity matrix. 
 */
template <typename T>
inline void
SgXform3T<T>::identity( )
{
    _mat[0] = 1.0;  _mat[4] = 0.0;  _mat[8]  = 0.0;  _mat[12] = 0.0;
    _mat[1] = 0.0;  _mat[5] = 1.0;  _mat[9]  = 0.0;  _mat[13] = 0.0;
    _mat[2] = 0.0;  _mat[6] = 0.0;  _mat[10] = 1.0;  _mat[14] = 0.0;
    _mat[3] = 0.0;  _mat[7] = 0.0;  _mat[11] = 0.0;  _mat[15] = 1.0;
}


/**
 * Construct a translation matrix.
 */
template <typename T>
inline void
SgXform3T<T>::translation( const SgVec3T<T> &dir )
{
    _mat[0] = 1.0;  _mat[4] = 0.0;  _mat[8]  = 0.0;  _mat[12] = dir[0];
    _mat[1] = 0.0;  _mat[5] = 1.0;  _mat[9]  = 0.0;  _mat[13] = dir[1];
    _mat[2] = 0.0;  _mat[6] = 0.0;  _mat[10] = 1.0;  _mat[14] = dir[2];
    _mat[3] = 0.0;  _mat[7] = 0.0;  _mat[11] = 0.0;  _mat[15] = 1.0;
}


/**
 * Construct a scale matrix.
 */
template <typename T>
inline void
SgXform3T<T>::scale( const SgVec3T<T> &mag )
{
    _mat[0] = mag[0];  _mat[4] = 0.0;     _mat[8]  = 0.0;     _mat[12] = 0.0;
    _mat[1] = 0.0;     _mat[5] = mag[1];  _mat[9]  = 0.0;     _mat[13] = 0.0;
    _mat[2] = 0.0;     _mat[6] = 0.0;     _mat[10] = mag[2];  _mat[14] = 0.0;
    _mat[3] = 0.0;     _mat[7] = 0.0;     _mat[11] = 0.0;     _mat[15] = 1.0;
}


/**
 * Transpose the xform in place.
 */
template <typename T>
void
SgXform3T<T>::transpose( )
{
    for (int i=0,ii=0;i<3;i++,ii+=4) {
	for (int j=i+1,jj=((i+1)*4);j<4;j++,jj+=4) {
	    std::swap( _mat[i + jj], _mat[j + ii] );
        }
    }
}


/**
 * Transpose the given xform and store in 'this' xform.
 */
template <typename T>
void
SgXform3T<T>::transpose( const SgXform3T<T> &a )
{
    // If passed in xform is 'this' then call in place version
    if ( this == &a ) {
	transpose();
	return;
    }
    
    _mat[0]  = a._mat[0];
    _mat[5]  = a._mat[5];
    _mat[10] = a._mat[10];
    _mat[15] = a._mat[15];
    for (int i=0,ii=0;i<3;i++,ii+=4) {
	for (int j=i+1,jj=((i+1)*4);j<4;j++,jj+=4) {
	    _mat[i + jj] = a._mat[j + ii];
	    _mat[j + ii] = a._mat[i + jj];
	}
    }
}


/**
 * Copy the given xform into 'this' xform.
 */
template <typename T>
void
SgXform3T<T>::copy( const SgXform3T<T> &x )
{
    // If passed in xform is 'this' then done
    if ( this == &x ) {
	return;
    }
    for (int i=0; i<16; i++) {
        _mat[i] = x._mat[i];
    }
}


/**
 * Multiply the given point (as a column vector) on the right of
 * this xform and return the resulting point. If the 'dir' parameter
 * given is -1 then the inverse (assuming this matrix has no scale
 * component) will be used instead of 'this'. If 'vec' is true then
 * the input point will be treated as a vector, meaning the translate
 * part of the the xform will not be applied. 'pt' and 'res' can
 * be the same point.
 */
template <typename T>
void
SgXform3T<T>::multiply( const SgVec3T<T> &pt,
                        SgVec3T<T>       &res,
                        bool             vec,
                        int              dir ) const
{
    SgVec3T<T> lpt = pt;
    if ( dir == -1 ) {
	// Inverse method
	if ( !vec ) {
	    lpt[0] -= _mat[12];
	    lpt[1] -= _mat[13];
	    lpt[2] -= _mat[14];
	}
        res[0] = lpt[0] * _mat[0] + lpt[1] * _mat[1] + lpt[2] * _mat[2];
        res[1] = lpt[0] * _mat[4] + lpt[1] * _mat[5] + lpt[2] * _mat[6];
        res[2] = lpt[0] * _mat[8] + lpt[1] * _mat[9] + lpt[2] * _mat[10];
    } else {
	// Forward method
        res[0] = lpt[0] * _mat[0] + lpt[1] * _mat[4] + lpt[2] * _mat[8];
        res[1] = lpt[0] * _mat[1] + lpt[1] * _mat[5] + lpt[2] * _mat[9];
        res[2] = lpt[0] * _mat[2] + lpt[1] * _mat[6] + lpt[2] * _mat[10];
	if ( !vec ) {
	    res[0] += _mat[12];
	    res[1] += _mat[13];
	    res[2] += _mat[14];
	}
    }
}


/**
 * Multiply the two given xforms and store the result in 'this'. The
 * given xforms can be different or the same as 'this'.
 */
template <typename T>
void
SgXform3T<T>::multiply( const SgXform3T<T> &a, const SgXform3T<T> &b )
{
    SgXform3T<T> X;
    const SgXform3T<T> *A, *B;

    // Get copies if we need them
    if ( &a == this ) {
        // Xform "a" is the same as "this" so make a copy in X.
        A = &X;
        X.copy( *this );
        if ( &b == this ) {
            // Xform "b" is also "this" so share X.
            B = &X;
        } else {
            // Set B to use "b" directly. 
            B = &b;
        }
    } else {
        // Set A to use "a" directly. 
	A = &a;
        if ( &b == this ) {
            // Xform "b" is the same as "this" so make a copy in X.
            B = &X;
            X.copy( *this );
        } else {
            // Set B to use "b" directly. 
            B = &b;
        }
    }

    // Multiply the two putting the result in 'this'
    for (int i=0,ii=0;i<4;i++,ii+=4) {
	for (int j=0,jj=0;j<4;j++,jj+=4) {
	    _mat[i + jj] = 0;
	    for ( int k=0,kk=0; k<4; k++,kk+=4 ) {
		_mat[i + jj] += A->_mat[i + kk] * B->_mat[k + jj];
            }
	}
    }
}


/**
 * Map the given bounding box 'b' through 'this' and put the resulting
 * bounding box in 'res'. The Bbox 'b' can be the same as 'res'.
 */
template <typename T>
void
SgXform3T<T>::map_bb( const SgBox3T<T> &b, SgBox3T<T> &res )
{
    // All eight corners must be mapped so that that bounds on the
    // resulting box can be found as the result. This is necessary
    // since all Bbox represents is an axis aligned bounding box.
    SgVec3T<T> c[8];

    // Construct the bottom four corners
    c[0] = SgVec3T<T>( b.getOrigin()[0],
                       b.getOrigin()[1],
                       b.getOrigin()[2] );
    c[1] = SgVec3T<T>( b.getOrigin()[0] + b.getOffset()[0],
                       b.getOrigin()[1],
                       b.getOrigin()[2] );
    c[2] = SgVec3T<T>( b.getOrigin()[0] + b.getOffset()[0],
                       b.getOrigin()[1],
                       b.getOrigin()[2] + b.getOffset()[2] );
    c[3] = SgVec3T<T>( b.getOrigin()[0],
                       b.getOrigin()[1],
                       b.getOrigin()[2] + b.getOffset()[2] );
    
    // Construct the top four corners
    c[4] = SgVec3T<T>( b.getOrigin()[0],
                       b.getOrigin()[1] + b.getOffset()[1],
                       b.getOrigin()[2] );
    c[5] = SgVec3T<T>( b.getOrigin()[0] + b.getOffset()[0],
                       b.getOrigin()[1] + b.getOffset()[1],
                       b.getOrigin()[2] );
    c[6] = SgVec3T<T>( b.getOrigin()[0] + b.getOffset()[0],
                       b.getOrigin()[1] + b.getOffset()[1],
                       b.getOrigin()[2] + b.getOffset()[2] );
    c[7] = SgVec3T<T>( b.getOrigin()[0],
                       b.getOrigin()[1] + b.getOffset()[1],
                       b.getOrigin()[2] + b.getOffset()[2] );
    
    // Map all eight corners and find new bounds
    res.reset();
    for ( int i=0; i<8; i++ ) {
	multiply( c[i], c[i] );
        res.extend( c[i] );
    }
}


/**
 * Wrapper for computing inverse of matrix other than 'this'.
 */
template <typename T>
T
SgXform3T<T>::inverse( const SgXform3T<T> &a )
{
    *this = a;
    return inverse();
}


/**
 * Invert 'this' matrix in place and return the determinant. The
 * technique used is the standard Guass-Jordan method.
 *
 * This code is public domain and comes from the book
 * "Graphics Gems II" (1991) edited by James Arvo,
 * pp. 559-561 ("View Correlation").
 */
template <typename T>
T
SgXform3T<T>::inverse( )
{
    int i,j,k;
    int pvt_i[4], pvt_j[4];   // Locations of pivot elements
    T pvt_val;           // Value of current pivot element
    T hold;
    T determ;

    // Initialize determinant
    determ = 1.0;

    for ( k = 0; k < 4; k++ ) {
        // Locate k'th pivot element
        pvt_val = mat(k,k); // Initialize for search
        pvt_i[k] = k;
        pvt_j[k] = k;
        for ( i = k; i < 4; i++ ) {
	    for ( j = k; j < 4; j++ ) {
		if ( fabs(mat(i,j)) > fabs(pvt_val) ) {
		    pvt_i[k] = i;
		    pvt_j[k] = j;
		    pvt_val = mat(i,j);
		}
            }
        }

        // Product of pivots, gives determinant when finished
        determ *= pvt_val;
        if ( determ == 0.0 ) {
            // Matrix is singular (zero determinant)
            return 0.0;
        }

        // "Interchange" rows (with sign change stuff)
        i = pvt_i[k];
        if ( i != k ) {
            // If rows are different
	    for ( j = 0; j < 4; j++ ) {
		hold = -mat(k,j);
		mat(k,j) = mat(i,j);
		mat(i,j) = hold;
	    }
        }

        // "Interchange" columns
        j = pvt_j[k];
        if ( j != k ) {
            // If columns are different
	    for ( i = 0; i < 4; i++ ) {
		hold = -mat(i,k);
		mat(i,k) = mat(i,j);
		mat(i,j) = hold;
	    }
        }

        // Divide column by minus pivot value
        for ( i = 0; i < 4; i++ ) {
	    if ( i != k ) {                 // Don't touch pivot
		mat(i,k) /= ( -pvt_val );
            }
        }

        // Reduce the matrix
        for ( i = 0; i < 4; i++ ) {
            hold = mat(i,k);
            for ( j = 0; j < 4; j++ ) {
		if ( i != k && j != k ) {  // Don't touch pivot.
		    mat(i,j) += hold * mat(k,j);
                }
            }
        }

        // Divide row by pivot
        for ( j = 0; j < 4; j++ ) {
	    if ( j != k ) {                // Don't touch pivot
		mat(k,j) /= pvt_val;
            }
        }

        // Replace pivot by reciprocal (at last we can touch it).
        mat(k,k) = 1.0/pvt_val;
    }

    // That was most of the work, one final pass of row/column
    // interchange to finish.
    for ( k = 4-2; k >= 0; k-- ) {   // Don't need to work with 1 by 1
	// corner
        i = pvt_j[k];		// Rows to swap correspond to pivot COLUMN
        if ( i != k ) {
            // If rows are different
	    for( j = 0; j < 4; j++ )
	    {
		hold = mat(k,j);
		mat(k,j) = -mat(i,j);
		mat(i,j) = hold;
	    }
        }

        j = pvt_i[k];		// Columns to swap correspond to pivot ROW
        if ( j != k ) {
            // If columns are different
	    for ( i = 0; i < 4; i++ )
	    {
		hold = mat(i,k);
		mat(i,k) = -mat(i,j);
		mat(i,j) = hold;
	    }
        }
    }

    return determ;    
}


/**
 * Calculate the scale component of this xform. This is only
 * worthwhile if this xform represents a view matrix or a
 * matrix with uniform scale.
 */
template <typename T>
T
SgXform3T<T>::scale_comp()
{
    SgVec3T<T> world_cov(0,0,0);   // center in world
    SgVec3T<T> world_z(0,0,1);     // world z vector
    SgVec3T<T> view_cov;           // view space center
    SgVec3T<T> view_z;             // view z vector
    SgVec3T<T> offset;             // offset in world
    T scale;                       // the scale component
    
    // Determine the center of view in world coords.
    multiply( world_cov, view_cov );

    // Determine view space (0,0,1) in world coordinates.
    multiply( world_z, view_z );

    // The distance between them is the scale
    offset = view_z - view_cov;
    scale = offset.dot( offset );
    scale = (T)sqrt( (double)scale );

    return scale;
}


/**
 * Construct a rotation matrix that will rotate a vector 
 * into another vector.
 */
template <typename T>
void
SgXform3T<T>::rotation( const SgVec3T<T> &src, const SgVec3T<T> &dest )
{
    SgVec3T<T> axis = src * dest;
    axis.normalize();
    T angle = src.angle(dest);
    return rotation(axis, angle);
}


/**
 * Construct a rotation matrix that will rotate a vector about the
 * given axis by the given angle in radians.
 */
template <typename T>
void
SgXform3T<T>::rotation( const SgVec3T<T> &axis, T angle )
{
    T ca = (T)cos((double)angle),
      sa = (T)sin((double)angle),
      ca1 = (1-ca);
    T a01 = axis[0]*axis[1];
    T a02 = axis[0]*axis[2];
    T a12 = axis[1]*axis[2];
    T xAxis2 = axis[0]*axis[0]; 
    T yAxis2 = axis[1]*axis[1]; 
    T zAxis2 = axis[2]*axis[2]; 

    _mat[0] = (xAxis2*ca1+ca);
    _mat[1] = (a01*ca1+axis[2]*sa);
    _mat[2] = (a02*ca1-axis[1]*sa);
    _mat[3] = 0.0;
    _mat[4] = (a01*ca1-axis[2]*sa);
    _mat[5] = (yAxis2*ca1+ca);
    _mat[6] = (a12*ca1+axis[0]*sa);
    _mat[7] = 0.0;
    _mat[8] = (a02*ca1+axis[1]*sa);
    _mat[9] = (a12*ca1-axis[0]*sa);
    _mat[10] = (zAxis2*ca1+ca);
    _mat[11] = 0.0;
    _mat[12] = 0.0;
    _mat[13] = 0.0;
    _mat[14] = 0.0;
    _mat[15] = 1.0;
}


/**
 * Construct a rotation matrix that will rotate a vector about the X
 * axis by the given angle in radians.
 */
template <typename T>
void
SgXform3T<T>::rotationX( T angle )
{
    T ca = (T)cos((double)angle),
      sa = (T)sin((double)angle);

    _mat[0] = 1.0;  _mat[4] = 0.0;  _mat[8]  = 0.0;  _mat[12] = 0.0;
    _mat[1] = 0.0;  _mat[5] =  ca;  _mat[9]  = -sa;  _mat[13] = 0.0;
    _mat[2] = 0.0;  _mat[6] =  sa;  _mat[10] =  ca;  _mat[14] = 0.0;
    _mat[3] = 0.0;  _mat[7] = 0.0;  _mat[11] = 0.0;  _mat[15] = 1.0;
}


/**
 * Construct a rotation matrix that will rotate a vector about the Y
 * axis by the given angle in radians.
 */
template <typename T>
void
SgXform3T<T>::rotationY( T angle )
{
    T ca = (T)cos((double)angle),
      sa = (T)sin((double)angle);

    _mat[0] =  ca;  _mat[4] = 0.0;  _mat[8]  =  sa;  _mat[12] = 0.0;
    _mat[1] = 0.0;  _mat[5] = 1.0;  _mat[9]  = 0.0;  _mat[13] = 0.0;
    _mat[2] = -sa;  _mat[6] = 0.0;  _mat[10] =  ca;  _mat[14] = 0.0;
    _mat[3] = 0.0;  _mat[7] = 0.0;  _mat[11] = 0.0;  _mat[15] = 1.0;
}


/**
 * Construct a rotation matrix that will rotate a vector about the Z
 * axis by the given angle in radians.
 */
template <typename T>
void
SgXform3T<T>::rotationZ( T angle )
{
    T ca = (T)cos((double)angle),
      sa = (T)sin((double)angle);

    _mat[0] =  ca;  _mat[4] = -sa;  _mat[8]  = 0.0;  _mat[12] = 0.0;
    _mat[1] =  sa;  _mat[5] =  ca;  _mat[9]  = 0.0;  _mat[13] = 0.0;
    _mat[2] = 0.0;  _mat[6] = 0.0;  _mat[10] = 1.0;  _mat[14] = 0.0;
    _mat[3] = 0.0;  _mat[7] = 0.0;  _mat[11] = 0.0;  _mat[15] = 1.0;
}


/**
 * Construct an inverse transform given four points that define a basis for a
 * coordinate system.
 *
 * @param origin  The origin of the new coordinate system
 * @param xPt     A point on the X-axis
 * @param yPt     A point on the Y-axis
 * @param zPt     A point on the Z-axis
 */
template <typename T>
void
SgXform3T<T>::basis( const SgVec3T<T> &origin, const SgVec3T<T> &xPt,
                     const SgVec3T<T> &yPt, const SgVec3T<T> &zPt )
{
    SgXform3T<T>  Tr,  //  Translations matrix
                  S,   //  Scale matrix
                  Rx,  //  Matrix to lock down X axis
                  Ry;  //  Matrix to lock down Y axis

    SgVec3T<T>  xDir = xPt - origin,  //  Directions along each axis
               yDir = yPt - origin,
               zDir = zPt - origin,
               xAxis(1,0,0),
               yAxis(0,1,0);

    T   xScale = xDir.length(),   //  Compute the scale for each axis
        yScale = yDir.length(),
        zScale = zDir.length();


    //  How much each point is scaled about the origin determines scale.
    S.scale( SgVec3T<T>(1.0/xScale, 1.0/yScale, 1.0/zScale) );

    //  The origin defines the translation...
    Tr.translation( -origin );

    //  Make sure are directions are now unit vectors.
    xDir.normalize();
    yDir.normalize();
    zDir.normalize();

    //  Compute the orientation of our basis's X axis.
    T   angle = (T)acos( (double)xDir.dot(xAxis) );
    SgVec3T<T>  axisOfRotation = xAxis * xDir;

    //  Rotate the basis's Y and Z axes around this axis.  X axis is now
    // locked down.
    axisOfRotation.normalize();
    Rx.rotation( axisOfRotation, -angle );
    Rx.multiply( yDir, yDir, true );
    Rx.multiply( zDir, zDir, true );

    //  Compute the orientation of the partially locked down coordinate
    // system's Y axis.
    angle = (T)acos( (double)yDir.dot(yAxis) );

    //  Rotate the basis's Z axis about the X axis to lock down Y.
    Ry.rotationX( -angle );
    Ry.multiply( zDir, zDir, true ); 
 
    //  Build the final transform by combining all into one...
    this->identity();
    this->multiply( *this, S );
    this->multiply( *this, Ry );
    this->multiply( *this, Rx );
    this->multiply( *this, Tr );
}

/**
 * Get the translation vector out of the matrix.
 */
template <typename T>
SgVec3T<T> 
SgXform3T<T>::getTranslation() const
{
    return SgVec3T<T>( _mat[12], _mat[13], _mat[14] );
}

/**
 * Print out the matrix.
 */
template <typename T>
void
SgXform3T<T>::print( ) const
{
    fprintf(stderr,"SgXform 0x%p\n",this);
    fprintf(stderr,"   %11.6f %11.6f %11.6f %11.6f\n",
            _mat[0],_mat[4],_mat[8],_mat[12]);
    fprintf(stderr,"   %11.6f %11.6f %11.6f %11.6f\n",
            _mat[1],_mat[5],_mat[9],_mat[13]);
    fprintf(stderr,"   %11.6f %11.6f %11.6f %11.6f\n",
            _mat[2],_mat[6],_mat[10],_mat[14]);
    fprintf(stderr,"   %11.6f %11.6f %11.6f %11.6f\n",
            _mat[3],_mat[7],_mat[11],_mat[15]);
}

/**
 * Convert the matrix to a string representation.
 */
template <typename T>
std::string
SgXform3T<T>::toString() const
{
    char s[355];

    snprintf(s, 354,
             "(%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e,%.14e)",
             _mat[0],_mat[1],_mat[2],_mat[3],
             _mat[4],_mat[5],_mat[6],_mat[7],
             _mat[8],_mat[9],_mat[10],_mat[11],
             _mat[12],_mat[13],_mat[14],_mat[15]);

    return std::string(s);
}

/**
 * Assign the values of the matrix from the given string.
 */
template <typename T>
bool
SgXform3T<T>::fromString( const std::string &x )
{
    double val[16];
    int num = sscanf( x.c_str(),
           "(%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf)",
           &val[0], &val[1], &val[2], &val[3],
           &val[4], &val[5], &val[6], &val[7],
           &val[8], &val[9], &val[10], &val[11],
           &val[12], &val[13], &val[14], &val[15] );
    
    if (num==16) {
        for ( unsigned int i=0; i<16; i++ ) _mat[i] = (T)(val[i]);
        return true;
    }
      
    return false;
}


#endif
