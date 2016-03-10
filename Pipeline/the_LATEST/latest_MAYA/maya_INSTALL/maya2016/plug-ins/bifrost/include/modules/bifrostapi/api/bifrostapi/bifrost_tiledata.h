//*****************************************************************************
/*!
   \file bifrost_tiledata.h
   \brief TileData class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_TILEDATA_H_
#define _BIFROST_TILEDATA_H_

#include <bifrostapi/bifrost_types.h>
#include <bifrostapi/bifrost_math.h>
#include <assert.h>

namespace Bifrost {
namespace API {

class Channel;
class TileDataAccessor;

//*****************************************************************************
/*! \class TileData bifrost_tiledata.h
	\brief TileData is a template class that holds the data of a tile for a given channel.
	A channel stores data partitioned into blocks, where a block is a zero-based array. 
	The data corresponds to the tile residing in the tile tree. 

	\sa Channel::tileData

	\tparam T The type of data supported by TileData, which includes the following:
		\li float
		\li int32_t
		\li int64_t
		\li uint64_t
		\li amino::Math::vec2f
		\li amino::Math::vec3f
		\li amino::Math::vec2i
		\li amino::Math::vec3i
	
	The T parameter must match the data type of the channel where the TileData object is coming from. Results
	are unpredicted otherwise.
 */
//*****************************************************************************
template< typename T >
class TileData
{
	public:
	friend class Channel;
	friend class TileDataAccessor;

	/*! \typedef T Type
	\brief Type is the data type of a TileData instance.
	*/
	typedef T Type;

	/*! Default constructor. */
	TileData() : _data(0), _count(0), _width(0)
	{}

	/*! Accessor to elements at a given index. This operator is called when reading the data so the return value is read-only.
	\param index Index in the array. The index must be smaller than the number of elements in the array, otherwise results are unpredicted.
	\return A read-only reference to the indexed item.
	*/
	BIFROST_INLINE const T& operator[]( size_t index ) const;

	/*! Accessor to elements at a given index.
	\param index Index in this zero based array. The index must be smaller than the number of elements in the array, otherwise results are unpredicted.
	\return A reference to the indexed item.
	*/
	BIFROST_INLINE T& operator[]( size_t index );

	/*! Returns a read-only element located at position (i,j,k) in tile space.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	<br><b>Note:</b> This works for voxel tiles only, the results are unpredicted with point tiles.
	\return A read-only reference to the indexed item.
	*/
	BIFROST_INLINE const T& operator()( size_t i, size_t j, size_t k ) const;

	/*! Access an element located at position (i,j,k) in tile space.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	<br><b>Note:</b> This works for voxel tiles only, the results are unpredicted with point tiles.
	\return A reference to the indexed item.
	*/
	BIFROST_INLINE T& operator()( size_t i, size_t j, size_t k );

	/*! Returns a read-only element located at position (i,j,k). 
	\param coord Tile coordinate.
	<br><b>Note:</b> This works for voxel tiles only, the results are unpredicted with point tiles.
	\return A read-only reference to the indexed item.
	*/
	BIFROST_INLINE const T& operator()( TileCoord coord ) const;

	/*! Returns a read-only element located at position (i,j,k). 
	\param coord Tile coordinate.
	<br><b>Note:</b> This works for voxel tiles only, the results are unpredicted with point tiles.
	\return A reference to the indexed item.
	*/
	BIFROST_INLINE T& operator()( TileCoord coord );

	/*! Returns the number of elements for this tile array.
	\return Number of elements in the array.
	*/
	BIFROST_INLINE size_t count() const;

	private:
	Type* _data;
	size_t _count;
	size_t _width;
};

template< class T >
BIFROST_INLINE const T& TileData<T>::operator[]( size_t index ) const
{
	assert(_data && index < this->count());
	return _data[index];
}

template< class T >
BIFROST_INLINE T& TileData<T>::operator[]( size_t index )
{
	assert(_data && index < this->count());
	return _data[index];
}

template< class T >
BIFROST_INLINE const T& TileData<T>::operator()( size_t i, size_t j, size_t k ) const
{
	assert(_data && (i + j*_width + k*_width*_width) < this->count());
	return _data[ i + j*_width + k*_width*_width ];
}

template< class T >
BIFROST_INLINE T& TileData<T>::operator()( size_t i, size_t j, size_t k )
{
	assert(_data && (i + j*_width + k*_width*_width) < this->count());
	return _data[ i + j*_width + k*_width*_width ];
}

template< class T >
BIFROST_INLINE const T& TileData<T>::operator()( TileCoord coord ) const
{
	assert(_data && (coord.i + coord.j*_width + coord.k*_width*_width) < this->count());
	return _data[ coord.i + coord.j*_width + coord.k*_width*_width ];
}

template< class T >
BIFROST_INLINE T& TileData<T>::operator()( TileCoord coord )
{
	assert(_data && (coord.i + coord.j*_width + coord.k*_width*_width) < this->count());
	return _data[ coord.i + coord.j*_width + coord.k*_width*_width ];
}

template< class T >
BIFROST_INLINE size_t TileData<T>::count() const
{
	return _count;
}

}
}

#endif // _BIFROST_BASE_H_