// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file SgKdTreeNT.h
 * @brief Contains the declaration of the template class SgKdTree.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Brent Burley
 * @author Thomas V Thompson II
 * @author Ying Liu
 *
 * @version Created 03/15/07
 */


#ifndef SGKDTREENT_H
#define SGKDTREENT_H

#include <string.h>
#include <limits>
#include "XgPorting/safevector.h"
#include <algorithm>

#include <tbb/mutex.h>

#ifdef WIN32
#ifdef max
#pragma push_macro("max")
#undef max
#define POP_MAX
#endif
#endif

/**
 * @brief Balanced Kd-Tree
 *
 * The tree is left-balanced (i.e. the left subtree is always
 * complete).  The nodes are stored in traversal order ("pre-order")
 * to optimize memory lookahead and cache-coherence during traversal.
 *
 * This means that:
 * 1) The root node is node 0, depth 0.
 * 2) Any given subtree is stored in a contiguous memory block.
 * 3) The left child of node n is node n+1.
 * 4) The right child of node n is node n+(size of left subtree).
 * 5) The size of the left subtree of any node can be easily
 *    determined based on the node's overall subtree size (left+right+1).
 *    This can be propagated down during traversal.
 *
 * The const methods are thread safe. Once the tree is built, it can
 * be queried from multiple threads concurrently.
 */
template <int k, typename T> class SgKdTree
{
public:
    SgKdTree();
    ~SgKdTree();
	void clear();
    void reserve(int n) { _points.reserve(n); }
	int size() const { return _points.size(); }
    const T* point(int i) const { return _points[i].p; }
    int id(int i) const { return _ids[i]; }
    void setPoints(T* p, unsigned int n);
    void sort();
    void findPoints(safevector<int>& points, 
		    const T pmin[k], const T pmax[k]) const;
    void findPoints(safevector<int>& points, 
		    T radius, const T center[k]) const;
    void findClosest(int& point, const T p[k]) const;
    void findNClosest( safevector<int>& result, int num, const T p[k] ) const;

private:
    void ensureSorted() const;
    void sortSubtree(int n, int count, int j);
    struct ComparePointsById {
	T* points;
	ComparePointsById(T* p) : points(p) {}
	bool operator() (int a, int b) { return points[a*k] < points[b*k]; }
    };


    void findBoxPoints(int n, int size, int j,
        const T* pmin, const T* pmax, safevector<int>* findResult) const;
    void findSpherePoints(int n, int size, int j,
        const T* pcenter, T pradius2, const T* pmin, const T* pmax,
        safevector<int>* findResult) const;

    class ClosestPoints {
    public:
        ClosestPoints(int m)
            {maxNum=m; foundNum=0; isHeap=0;value.reserve(m+1);
             value.push_back(std::pair<int,T>(-1,
                                              std::numeric_limits<T>::max()));}
        int maxNum;
        int foundNum;
        int isHeap;

        T maxValue() { return value[0].second; }
        static bool less(std::pair<int,T> x,std::pair<int,T> y)
        { return (x.second < y.second); }
         
        safevector< std::pair<int,T> > value;
    };

    void findClosest(int n, int size, int j,
        const T* pcenter, T& pdist, int* pnear) const;
    void findNClosest( ClosestPoints *cpts, int n, int size, int j,
        const T* pcenter) const;

    // Heap sort
    static void buildHeap( ClosestPoints *cpts );
    static void insertToHeap( ClosestPoints *cpts, int id, T dist2 );

    static inline bool inBoxBounds(const T p[k],
                                   const T min[k], const T max[k])
        {
            for (int i = 0; i < k; i++)
                if (p[i] < min[i] || p[i] > max[i]) return 0;
            return 1;
        }
    static inline bool inSphereBounds(const T p[k],
                                      const T c[k], const T radius)
        {
            T dist=0,tmp;
            for (int i = 0; i < k; i++) {
                tmp = p[i] - c[i];
                dist += tmp*tmp;
            }
            if ( dist > radius ) return 0;
            return 1;
        }
    static inline void ComputeSubtreeSizes(int size, int& left, int& right)
        {
            // if (size+1) is a power of two, then subtree is balanced
            bool balanced = ((size+1) & size) == 0;
            if (balanced) {
                // subtree size = (size-1)/2
                left = right = size>>1; // ignore -1 since size is always odd
            }
            else if (size == 2) {
                // special case
                left = 1;
                right = 0;
            }
            else {
                // left subtree size = (smallest power of 2 > half size)-1
                int i = 0;
                for (int c = size; c != 1; c >>= 1) i++;
                left = (1<<i)-1;
                right = size - left - 1;
            }
        }

    static inline safevector<int>::iterator inBound( safevector<int>& v, int value )
    {
        // ensure v.begin()+value is not out of bound, returns end iterator otherwise
        return value > v.size()-1 ? v.end() : v.begin()+value; 
    } 

    struct Point { T p[k]; };
    safevector<Point> _points;
    safevector<int> _ids;
    volatile bool _sorted;
    mutable tbb::mutex _mutex;
};

typedef SgKdTree<3,double> SgKdTree3d;
typedef SgKdTree<3,float>  SgKdTree3f;


template <int k, typename T> 
SgKdTree<k,T>::SgKdTree()
    : _sorted(0)
{}

template <int k, typename T>
SgKdTree<k,T>::~SgKdTree()
{}

template <int k, typename T> 
void SgKdTree<k,T>::clear()
{
	 _sorted = 0;
	 safevector<Point> p;
	 _points.swap(p);
	 safevector<int> ids;
	 _ids.swap(ids);
}

template <int k, typename T>
void SgKdTree<k,T>::setPoints(T* p, unsigned int n)
{
    // copy points
    _points.resize(n);
    memcpy(&_points[0], p, sizeof(Point)*n);

    // assign sequential ids
    _ids.clear();
    _ids.reserve(n);
    while ( (unsigned int)(_ids.size()) < n) 
        _ids.push_back(_ids.size());
    _sorted = 0;
}

template <int k, typename T>
void SgKdTree<k,T>::sort()
{
    if (_sorted) return;

    // reorder ids to sort points
    int np = _points.size();
    if (!np) return;
    if (np > 1) sortSubtree(0, np, 0);

    // reorder points to match id order
    safevector<Point> newpoints(np);
    for (int i = 0; i < np; i++)
	newpoints[i] = _points[_ids[i]];
    std::swap(_points, newpoints);

    _sorted = 1;
}

// This private method should only be called from const methods to
// ensure the kd tree is sorted. This method is thread safe.
// It's assumed that only sort() will change the content of the tree.
// Once the tree is sorted, calling const methods is thread safe since
// no one else will change the tree again.
template <int k, typename T>
void SgKdTree<k,T>::ensureSorted() const
{
    // _sorted must be volatile to prevent any compiler optimize..
    if (!_sorted) {
        tbb::mutex::scoped_lock lock(_mutex);
        if (!_sorted) {
            SgKdTree<k,T>* nonConstThis = const_cast<SgKdTree<k,T>*>(this);
            nonConstThis->sort();
        }
    }
    assert(_sorted);
}

template <int k, typename T> 
void SgKdTree<k,T>::sortSubtree(int n, int size, int j)
{
    int left, right; ComputeSubtreeSizes(size, left, right);

    // partition range [n, n+size) along axis j into two subranges:
    //   [n, n+leftSize+1) and [n+leftSize+1, n+size)
    safevector<int>::iterator it_n = inBound( _ids, n );
    safevector<int>::iterator it_nleft = inBound( _ids, n+left );
    safevector<int>::iterator it_nsize = inBound( _ids, n+size );
    std::nth_element( it_n, it_nleft, it_nsize, ComparePointsById(&_points[0].p[j]));

    // move median value (nth element) to front as root node of subtree
    std::swap( *it_n, *it_nleft );

    // sort left and right subtrees using next discriminant 
    if (left <= 1) return;
    if (k > 1) j = (j+1)%k;
    sortSubtree(n+1, left, j);
    if (right <= 1) return;
    sortSubtree(n+left+1, right, j);
}

template <int k, typename T>
void SgKdTree<k,T>::findPoints(safevector<int>& result,
                               const T pmin[k], const T pmax[k]) const
{
    if (!size()) return;
    ensureSorted();
    result.clear();
    findBoxPoints(0, size(), 0, &pmin[0], &pmax[0], &result);
}

template <int k, typename T>
void SgKdTree<k,T>::findBoxPoints(int n, int size, int j,
    const T* pmin, const T* pmax, safevector<int>* findResult) const
{
    // check point at n for inclusion
    const T* p = &_points[n].p[0];
    if (inBoxBounds(p, pmin, pmax))
	findResult->push_back(n);

    if (size == 1) return;

    // visit left subtree
    int left, right; ComputeSubtreeSizes(size, left, right);
    int nextj = (k > 1)? (j+1)%k : j;
    if (p[j] >= pmin[j])
	findBoxPoints(n+1, left, nextj, pmin, pmax, findResult);

    // visit right subtree
    if (right && p[j] <= pmax[j])
	findBoxPoints(n+left+1, right, nextj, pmin, pmax, findResult);
}

template <int k, typename T>
void SgKdTree<k,T>::findPoints(safevector<int>& result, 
                               T radius, const T center[k]) const
{
    if (!size()) return;
    ensureSorted();
    result.clear();
    T pmin[k], pmax[k];
    for ( unsigned int i=0; i<k; i++ ) {
        pmin[i] = center[i]-radius;
        pmax[i] = center[i]+radius;
    }
    findSpherePoints(0, size(), 0,
        &center[0], radius*radius, &pmin[0], &pmax[0], &result);
}

template <int k, typename T>
void SgKdTree<k,T>::findSpherePoints(int n, int size, int j,
    const T* pcenter, T pradius2, const T* pmin, const T* pmax,
    safevector<int>* findResult) const
{
    // check point at n for inclusion
    const T* p = &_points[n].p[0];
    if (inSphereBounds(p, pcenter, pradius2))
	findResult->push_back(n);

    if (size == 1) return;

    // visit left subtree
    int left, right; ComputeSubtreeSizes(size, left, right);
    int nextj = (k > 1)? (j+1)%k : j;
    if (p[j] >= pmin[j])
	findSpherePoints(n+1, left, nextj, pcenter, pradius2, pmin, pmax, findResult);

    // visit right subtree
    if (right && p[j] <= pmax[j])
	findSpherePoints(n+left+1, right, nextj, pcenter, pradius2, pmin, pmax, findResult);
}

template <int k, typename T>
void SgKdTree<k,T>::findClosest(int& point, const T p[k]) const
{
	if (!size()) { point = -1; return; }
    ensureSorted();
    T pdist = std::numeric_limits<T>::max();
    point = -1;
    findClosest( 0, size(), 0, &p[0], pdist, &point );
}

template <int k, typename T>
void SgKdTree<k,T>::findClosest(int n, int size, int j,
    const T* pcenter, T& pdist, int* pnear) const
{
    // compare to current point
    const T* p = &_points[n].p[0];

    if ( size > 1 ) {

        // Setup for visiting at least one subtree
        int left, right; ComputeSubtreeSizes(size, left, right);
        int nextj = (k > 1)? (j+1)%k : j;
    
        T dist = pcenter[j] - p[j];
        
        if ( dist > 0.0 ) {
            // visit right subtree (if there is one)
            if ( right ) findClosest( n+left+1, right, nextj, pcenter, pdist, pnear );
            if ( dist*dist < pdist ) {
                // only visit left if necessary (point still possibly there)
                findClosest( n+1, left, nextj, pcenter, pdist, pnear );
            }
        } else {
            // visit left subtree
            findClosest( n+1, left, nextj, pcenter, pdist, pnear );
            if ( right && dist*dist < pdist ) {
                // only visit right if necessary (point still possibly there)
                findClosest( n+left+1, right, nextj, pcenter, pdist, pnear );
            }
        }
    }

    // Compute squared distance for this entry
    T dist=0,tmp;
    for (int i = 0; i < k; i++) {
        tmp = p[i] - pcenter[i];
        dist += tmp*tmp;
    }
    if ( dist < pdist ) {
        pdist = dist;
        *pnear = n;
    }
}

template <int k, typename T>
void SgKdTree<k,T>::findNClosest( safevector<int>& result, int num, 
				  const T p[k] ) const
{
    if ( !size() ) return;
    ensureSorted();
    
    ClosestPoints closestPts(num);

    findNClosest( &closestPts, 0, size(), 0, &p[0] );

    // Sort the results
    std::sort( ++closestPts.value.begin(), closestPts.value.end(),
               ClosestPoints::less );
    
    // Write the result to the vector
    result.clear();
    result.reserve( num );
    for ( unsigned int i = 1; i < closestPts.value.size(); i++ ) {
        result.push_back( closestPts.value[i].first );
    }
}

template <int k, typename T>
void SgKdTree<k,T>::findNClosest( ClosestPoints *cpts,
    int n, int size, int j, const T* pcenter) const
{
    // compare to current point
    const T* p = &_points[n].p[0];

    if ( size > 1 ) {

        // Setup for visiting at least one subtree
        int left, right; 
        ComputeSubtreeSizes( size, left, right );
        int nextj = ( k > 1 ) ? ( j + 1 ) % k : j;
    
        T dist = pcenter[j] - p[j];
        
        if ( dist > 0.0 ) {
            // visit right subtree (if there is one)
            if ( right ) 
                findNClosest( cpts, n + left + 1, right, nextj, pcenter );
            
            if ( dist * dist < cpts->maxValue() ) {
                // only visit left if necessary (point still possibly there)
                findNClosest( cpts, n + 1, left, nextj, pcenter );
            }
        } else {
            // visit left subtree
            findNClosest( cpts, n + 1, left, nextj, pcenter );
            
            if ( right && dist * dist < cpts->maxValue() ) {
                // only visit right if necessary (point still possibly there)
                findNClosest( cpts, n + left + 1, right, nextj, pcenter );
            }
        }
    }

    // Compute squared distance for this entry
    T dist2 = 0, tmp;
    for ( int i = 0; i < k; i++ ) {
        tmp = p[i] - pcenter[i];
        dist2 += tmp * tmp;
    }

    // we found a point - insert it in the candidate list
    if ( dist2 < cpts->maxValue() ) {
        if ( cpts->foundNum < cpts->maxNum ) {
            // heap is not full; use array
            cpts->foundNum++;
            cpts->value.push_back( std::pair<int,T>(n,dist2) );
	    if ( cpts->foundNum == cpts->maxNum ) {
		buildHeap( cpts );
	    }
        } else {
            insertToHeap( cpts, n, dist2 ); 
        }
    }
}

template <int k, typename T>
void SgKdTree<k,T>::buildHeap( ClosestPoints *cpts )
{
    if ( cpts->isHeap )
        return;

    // Build heap
    T dst2;
    int m, parent, id;
    int half_found = cpts->foundNum >> 1;
    for ( int i = half_found; i >= 1; i-- )
    {
        parent = i;
        id = cpts->value[i].first;
        dst2 = cpts->value[i].second;
        while ( parent <= half_found )
        {
            m = parent + parent;
            if ( m < cpts->foundNum && 
                    cpts->value[m].second < cpts->value[m+1].second ) 
                m++;

            if ( dst2 >= cpts->value[m].second ) 
                break;

            cpts->value[parent] = cpts->value[m];

            parent = m;
        }

        if ( dst2 < cpts->value[parent].second )
        {
            cpts->value[parent] = std::pair<int,T>(id,dst2);
        }
        }
    cpts->value[0].second = cpts->value[1].second;

    cpts->isHeap = 1;
}


template <int k, typename T>
void SgKdTree<k,T>::insertToHeap( ClosestPoints *cpts, int id, T dist2 )
{
    // insert new point into max heap
    // delete largest element, insert new and reorder the heap
    int parent = 1, m = 2;
    while ( m <= cpts->foundNum )
    {
        if ( m < cpts->foundNum &&
             cpts->value[m].second < cpts->value[m+1].second ) 
            m++;

        if ( dist2 > cpts->value[m].second ) 
            break;

        cpts->value[parent] = cpts->value[m];

        parent = m;
        m += m;
    }

    cpts->value[parent] = std::pair<int,T>(id,dist2);

    cpts->value[0].second = cpts->value[1].second;
}

#ifdef POP_MAX
#pragma pop_macro("max")
#undef POP_MAX
#endif

#endif
