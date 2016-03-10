// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.
#ifndef XGRENDERAPIUTILS_H
#define XGRENDERAPIUTILS_H
//-
// ==================================================================
// ==================================================================
//+

#include <math.h>
#include <stdlib.h>
#include "XgPorting/safevector.h"

#include "XGen/XgRenderAPI.h"

#ifdef WIN32
#define strcasecmp _stricmp
#define snprintf sprintf_s
#endif

// XGenRenderAPI::Utils contains optional utility code used by the RendermanProcedural example dso.
// We avoided adding member functions to mat44 and vec3 because we think it should be replaced by client code.
// Our goal isn't to provide a full blown vector and matrix class, but rather the minimal implementation for an XGen Render Procedural to work.
namespace XGenRenderAPI{
namespace Utils{

/* Compare floats and doubles */
inline bool nearby(const double a, const double b) {
	const double epsilon = 0.0000000000000002;
	return fabs(a - b) <= epsilon;
}

inline bool nearby(const float a, const float b) {
	const float epsilon = 0.000001f;
	return fabs(a - b) <= epsilon;
}

// bbox functions
inline bool isEmpty( const bbox& b )
{
	return 	::fabs((double)b.xmin) < 0.000001 &&
			::fabs((double)b.ymin) < 0.000001 &&
			::fabs((double)b.zmin) < 0.000001 &&
			::fabs((double)b.xmax) < 0.000001 &&
			::fabs((double)b.ymax) < 0.000001 &&
			::fabs((double)b.zmax) < 0.000001;
}

/* Angle conversion functions. */
inline double degtorad( double deg ) { return deg * (M_PI/180); }
inline double radtodeg( double rad ) { return rad * (180/M_PI); }

// mat44 functions
inline void copy( mat44& lhs, const mat44 &rhs );
inline void identity( mat44& lhs );
inline void translation( mat44& lhs, const vec3& dir );
inline void scale( mat44& lhs, const vec3& mag );
inline void rotation( mat44& lhs, const vec3 &axis, float angle );
inline void rotationX( mat44& lhs, float angle );
inline void multiply( mat44& dest, const mat44 &a, const mat44 &b );

// vec3 functions
inline bool operator ==( const vec3& v1, const vec3& v2 );
inline bool operator !=( const vec3& v1, const vec3& v2 );
inline vec3 operator+( const vec3& lhs, const vec3& rhs );
inline vec3 operator-( const vec3& lhs, const vec3& rhs );
inline vec3 operator*( const vec3& lhs, const vec3& rhs );
inline vec3 operator/( const vec3& lhs, const float rhs );
inline vec3 operator*( const vec3& lhs, const float rhs );
inline float length( const vec3& lhs );
inline float dot( const vec3& lhs, const vec3& rhs );
inline float angle( const vec3& lhs, const vec3& rhs );
inline float normalize( vec3& lhs );
inline vec3 rotateBy( const vec3& lhs, const vec3 &in_axis, double angle );

// Grow a vector by a given percent during a push_back
template <class Type>
inline void push_back( safevector< Type > &vec, const Type &elem, float percent=0.5, int minGrowth=10, int maxGrowth=2500 );

// Convert a string into a valid path.
inline std::string validPath( const std::string &path );

// Conversion functions
inline bool stob( const std::string &bstr );
inline std::string itoa( int num, const char *frmt = 0 );
inline std::string ftoa( float num, const char *frmt = 0 );
inline std::string ftoa( double num, const char *frmt = 0 );

inline int arrayindex( const std::string &token );

// Inline implementations
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
inline void copy( mat44& lhs, const mat44 &rhs )
{
    if ( &lhs == &rhs )
    	return;

    memcpy( &lhs, &rhs, sizeof( mat44 ) );
}

// Make this xform an identity matrix.
inline void identity( mat44& lhs )
{
	float* p = &lhs._00;
    p[0] = 1.0;  p[4] = 0.0;  p[8]  = 0.0;  p[12] = 0.0;
    p[1] = 0.0;  p[5] = 1.0;  p[9]  = 0.0;  p[13] = 0.0;
    p[2] = 0.0;  p[6] = 0.0;  p[10] = 1.0;  p[14] = 0.0;
    p[3] = 0.0;  p[7] = 0.0;  p[11] = 0.0;  p[15] = 1.0;
}


// Construct a translation matrix.
inline void translation( mat44& lhs, const vec3& dir )
{
	float* p = &lhs._00;
    p[0] = 1.0;  p[4] = 0.0;  p[8]  = 0.0;  p[12] = dir.x;
    p[1] = 0.0;  p[5] = 1.0;  p[9]  = 0.0;  p[13] = dir.y;
    p[2] = 0.0;  p[6] = 0.0;  p[10] = 1.0;  p[14] = dir.z;
    p[3] = 0.0;  p[7] = 0.0;  p[11] = 0.0;  p[15] = 1.0;
}


// Construct a scale matrix.
inline void scale( mat44& lhs, const vec3& mag )
{
	float* p = &lhs._00;
    p[0] = mag.x;  	p[4] = 0.0;     p[8]  = 0.0;	p[12] = 0.0;
    p[1] = 0.0;     p[5] = mag.y;  	p[9]  = 0.0;	p[13] = 0.0;
    p[2] = 0.0;     p[6] = 0.0;     p[10] = mag.z;	p[14] = 0.0;
    p[3] = 0.0;     p[7] = 0.0;     p[11] = 0.0;	p[15] = 1.0;
}


// Construct a rotation matrix that will rotate a vector about the given axis by the given angle in radians.
inline void rotation( mat44& lhs, const vec3 &axis, float angle )
{
	const float* pAxis = &axis.x;

    float ca = (float)cos((double)angle),
      sa = (float)sin((double)angle),
      ca1 = (1-ca);
    float a01 = pAxis[0]*pAxis[1];
    float a02 = pAxis[0]*pAxis[2];
    float a12 = pAxis[1]*pAxis[2];
    float xAxis2 = pAxis[0]*pAxis[0];
    float yAxis2 = pAxis[1]*pAxis[1];
    float zAxis2 = pAxis[2]*pAxis[2];

    float* p = &lhs._00;

    p[0] = (xAxis2*ca1+ca);
    p[1] = (a01*ca1+pAxis[2]*sa);
    p[2] = (a02*ca1-pAxis[1]*sa);
    p[3] = 0.0;
    p[4] = (a01*ca1-pAxis[2]*sa);
    p[5] = (yAxis2*ca1+ca);
    p[6] = (a12*ca1+pAxis[0]*sa);
    p[7] = 0.0;
    p[8] = (a02*ca1+pAxis[1]*sa);
    p[9] = (a12*ca1-pAxis[0]*sa);
    p[10] = (zAxis2*ca1+ca);
    p[11] = 0.0;
    p[12] = 0.0;
    p[13] = 0.0;
    p[14] = 0.0;
    p[15] = 1.0;
}

/**
 * Construct a rotation matrix that will rotate a vector about the X
 * axis by the given angle in radians.
 */
inline void rotationX( mat44& lhs, float angle )
{
    float ca = (float)cos((double)angle),
      sa = (float)sin((double)angle);

    float* p = &lhs._00;

    p[0] = 1.0;  p[4] = 0.0;  p[8]  = 0.0;  p[12] = 0.0;
    p[1] = 0.0;  p[5] =  ca;  p[9]  = -sa;  p[13] = 0.0;
    p[2] = 0.0;  p[6] =  sa;  p[10] =  ca;  p[14] = 0.0;
    p[3] = 0.0;  p[7] = 0.0;  p[11] = 0.0;  p[15] = 1.0;
}

inline void multiply( mat44& dest, const mat44 &a, const mat44 &b )
{
    static mat44 X;
    const mat44 *A, *B;
    mat44* D = &dest;

    // Get copies if we need them
    if ( &a == D )
    {
        // Xform "a" is the same as "dest" so make a copy in X.
        A = &X;
        copy( X, dest );
        if ( &b == D )
        {
            // Xform "b" is also "dest" so share X.
            B = &X;
        }
        else
        {
            // Set B to use "b" directly.
            B = &b;
        }

    }
    else
    {
        // Set A to use "a" directly.
    	A = &a;
        if ( &b == D )
        {
            // Xform "b" is the same as "dest" so make a copy in X.
            B = &X;
            copy( X, dest);
        }
        else
        {
            // Set B to use "b" directly.
            B = &b;
        }
    }

    float* pD = &(dest._00);
    const float* pA = &(A->_00);
    const float* pB = &(B->_00);

    // Multiply the two putting the result in 'dest'
    for (int i=0,ii=0;i<4;i++,ii+=4)
    {
		for (int j=0,jj=0;j<4;j++,jj+=4)
		{
			pD[i + jj] = 0;
			for ( int k=0,kk=0; k<4; k++,kk+=4 )
			{
				pD[i + jj] += pA[i + kk] * pB[k + jj];
			}
		}
    }
}

// Equality comparison.
inline bool operator ==( const vec3& v1, const vec3& v2 )
{
	return (v1.x == v2.x && v1.y == v2.y && v1.z == v2.z);
}

// Inequality comparison.
inline bool operator !=( const vec3& v1, const vec3& v2 )
{
	return !(v1 == v2);
}

inline vec3 operator+( const vec3& lhs, const vec3& rhs )
{
	vec3 result = lhs;
	result.x += rhs.x;
	result.y += rhs.y;
	result.z += rhs.z;
	return result;
}

inline vec3 operator-( const vec3& lhs, const vec3& rhs )
{
	vec3 result = lhs;
	result.x -= rhs.x;
	result.y -= rhs.y;
	result.z -= rhs.z;
	return result;
}

// Cross Product
inline vec3 operator*( const vec3& lhs, const vec3& rhs )
{
	vec3 result;

	const float* v1 = const_cast<const float*>( &lhs.x );
	const float* v2 = const_cast<const float*>( &rhs.x );

	result.x = v1[1]*v2[2] - v1[2]*v2[1];
	result.y = v1[2]*v2[0] - v1[0]*v2[2];
	result.z = v1[0]*v2[1] - v1[1]*v2[0];
	return result;
}

inline vec3 operator/( const vec3& lhs, const float rhs )
{
	vec3 result = lhs;
	result.x /= rhs;
	result.y /= rhs;
	result.z /= rhs;
	return result;
}

inline vec3 operator*( const vec3& lhs, const float rhs )
{
	vec3 result = lhs;
	result.x *= rhs;
	result.y *= rhs;
	result.z *= rhs;
	return result;
}

inline float length( const vec3& lhs )
{
	return sqrt( dot(lhs,lhs) );
}

inline float dot( const vec3& lhs, const vec3& rhs )
{
	return lhs.x*rhs.x + lhs.y*rhs.y + lhs.z*rhs.z;
}

/**
 * Returns the angle in radians between the current vector and the
 * passed in vector.
 */
inline float angle( const vec3& lhs, const vec3& rhs )
{
	double tmp = (double)dot( lhs, rhs ) / (double)( length(lhs) * length(rhs) );
	return static_cast<float>( acos( std::max( -1.0,std::min( tmp, 1.0 ) ) ) );
}

inline float normalize( vec3& lhs )
{
	double len = length(lhs);
	if ( len < 0.000001 )
	{
		lhs.x = lhs.y = lhs.z = 0.f;
		len = 0.0;
	}
	else
	{
		float fact = 1.0f / (float)len;
		lhs = lhs * fact;
	}
	return (float)len;
}

/**
 * Returns the vector rotated by the angle given in radians about
 * the given axis.
 */
inline vec3 rotateBy( const vec3& lhs, const vec3 &in_axis, double angle )
{
	const float* pVec = const_cast<const float*>( &lhs.x );
	const float* pAxis = const_cast<const float*>( &in_axis.x );

	float ca = static_cast<float>( cos(angle) );
	float sa = static_cast<float>( sin(angle) );
	float ca1 = (1-ca);
	float a01 = pAxis[0]*pAxis[1];
	float a02 = pAxis[0]*pAxis[2];
	float a12 = pAxis[1]*pAxis[2];
	float a00 = pAxis[0]*pAxis[0];
	float a11 = pAxis[1]*pAxis[1];
	float a22 = pAxis[2]*pAxis[2];

	vec3 ret;
	ret.x =	pVec[0]*(a00*ca1+ca) +
			pVec[1]*(a01*ca1-pAxis[2]*sa) +
			pVec[2]*(a02*ca1+pAxis[1]*sa);

	ret.y =	pVec[0]*(a01*ca1+pAxis[2]*sa) +
			pVec[1]*(a11*ca1+ca)+
			pVec[2]*(a12*ca1-pAxis[0]*sa);

	ret.z =	pVec[0]*(a02*ca1-pAxis[1]*sa) +
			pVec[1]*(a12*ca1+pAxis[0]*sa) +
			pVec[2]*(a22*ca1+ca);

	return ret;
}

 /** Grow a vector by a given percent during a push_back */
template <class Type>
inline void push_back( safevector< Type > &vec, const Type &elem, float percent, int minGrowth, int maxGrowth )
{   // If there is no more room then grow by given percentage
	unsigned int size = vec.size();
	if ( size == vec.capacity() )
	{
		int incr = int(size * percent);
		incr = std::max( minGrowth, std::min( incr, maxGrowth )  );
		vec.reserve( size+incr );
	}
	vec.push_back( elem );
}

// Convert a string into a valid path.
inline std::string validPath( const std::string &path )
{
    std::string  result("");
    {
		std::string  stripped("");

		std::string::size_type start = path.find_first_not_of( " \t\v\n" );
		if ( start != path.npos )
		{
			std::string::size_type end = path.find_last_not_of( " \t\v\n" );
			stripped = path.substr( start, end - start + 1 );
		}

		result = stripped;
    }

    if ( result != "" ) {
        if ( result[ result.length()-1 ] != '/' )
            result += "/";
    }
    return result;
}

inline bool stob( const std::string &bstr )
{
    if ( !strcasecmp(bstr.c_str(),"True") ||
         !strcasecmp(bstr.c_str(),"true") ||
         !strcasecmp(bstr.c_str(),"on") ||
         !strcasecmp(bstr.c_str(),"one") ||
         !strcasecmp(bstr.c_str(),"1") )
        return true;
    return false;
}

inline std::string itoa( int num, const char *frmt )
{
	static char str[256];
    if ( frmt )
        snprintf( str, 255, frmt, num );
    else
        snprintf( str, 255, "%d", num );
    return std::string( str );
}

inline std::string ftoa( float num, const char *frmt )
{
	static char str[256];
    if ( frmt )
        snprintf( str, 255, frmt, num );
    else
        snprintf( str, 255, "%f", num );
    return std::string( str );
}

inline std::string ftoa( double num, const char *frmt )
{
	static char str[256];
    if ( frmt )
        snprintf( str, 255, frmt, num );
    else
        snprintf( str, 255, "%f", num );
    return std::string( str );
}

/**
 * Get the index of an array expressed as a string of the form element[#].
 * If no array index is found then -1 is returned.
 *
 * @param token the string token to find the array index from
 */
inline int arrayindex( const std::string &token )
{
    std::string::size_type start, end;
    if ( (start = token.find("[")) != std::string::npos ) {
        start++;
        if ( (end = token.find("]")) != std::string::npos ) {
            end = end - start;
        }
    } else
        return -1;

    std::string stringIndex = token.substr( start, end );
    return std::max(0,atoi( stringIndex.c_str() ));
}

}}
#endif
