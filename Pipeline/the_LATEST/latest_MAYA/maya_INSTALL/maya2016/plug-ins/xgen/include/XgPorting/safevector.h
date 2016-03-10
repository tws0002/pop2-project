// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file safevector.h
 * @brief Contains the declaration of a safe for debug vector class.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 *
 * @author Brent Burley
 * @author Thomas V Thompson II
 *
 * @version Created 10/06/06
 */


//*****************************************************************************
/*!
   \file safearray.h
	Copyright 2012 Autodesk, Inc.  All rights reserved.
	Use of this software is subject to the terms of the Autodesk license agreement
	provided at the time of installation or download, or which otherwise accompanies
	this software in either electronic or hard copy form.
*/
//*****************************************************************************


#ifndef SAFEVECTOR_H
#define SAFEVECTOR_H

#include <stddef.h>		// for size_t
#include <vector>
#include <assert.h>

/**
 * @brief Safe version of std::vector for use in debuging.
 *
 * Wrap around the std::vector vector class such that all access to the
 * members via the [] operator will instead use the at() method when
 * compiled using debug. This will cause xgen to throw an exception if
 * the reference is out of bounds. The goal is making it easier to find
 * where xgen is corrupting memory easier, but not affecting performance
 * of the released version.
 */

template<typename _Tp, typename _Alloc = std::allocator<_Tp> >
class safevector : public std::vector<_Tp, _Alloc>
{
    typedef std::vector<_Tp, _Alloc>         _base;

public:
    
    typedef typename _base::reference        reference;
    typedef typename _base::const_reference  const_reference;
    typedef typename _base::allocator_type   allocator_type;

    explicit
    safevector(const allocator_type& _a = allocator_type()) : _base(_a) {}
    safevector(size_t n, const _Tp& val) : _base(n, val) {}
    safevector(size_t n) : _base(n) {}
    safevector(const safevector& vec) : _base(vec) {}

    reference
    operator[] (size_t n) {
		assert(n <= _base::size());
#if _ITERATOR_DEBUG_LEVEL == 2
		if( _base::size() == n )
			printf( "STL vector out of bounds. Fix me please! \n" );
		return (*(this->_Myfirst + n));
#endif		
        return _base::operator[](n);
    }
    
    const_reference
    operator[] (size_t n) const {
		assert(n <= _base::size());
#if _ITERATOR_DEBUG_LEVEL == 2
		if( _base::size() == n )
			printf( "STL vector out of bounds. Fix me please! \n" );
		return (*(this->_Myfirst + n));
#endif		

		return _base::operator[](n);
    }
};

template<typename _Alloc>
class safevector<bool, _Alloc> : public std::vector<bool, _Alloc>
{
    typedef std::vector<bool, _Alloc>         _base;

public:
    
    typedef typename _base::reference        reference;
    typedef typename _base::const_reference  const_reference;
    typedef typename _base::allocator_type   allocator_type;

    explicit
    safevector(const allocator_type& _a = allocator_type()) : _base(_a) {}
    safevector(size_t n, const bool& val) : _base(n, val) {}
    safevector(size_t n) : _base(n) {}
    safevector(const safevector& vec) : _base(vec) {}

    reference
    operator[] (size_t n) {
        return _base::operator[](n);
    }
    
    const_reference
    operator[] (size_t n) const {
		return _base::operator[](n);
    }

};
#endif
