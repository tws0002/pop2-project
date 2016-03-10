//*****************************************************************************
/*!
   \file bifrost_tileiterator.h
   \brief TileIterator class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_TILEITERATOR_H_
#define _BIFROST_TILEITERATOR_H_

#include "bifrostapi/bifrost_base.h"

namespace Bifrost {
namespace API {

class Tile;

//*****************************************************************************
/*! \class TileIterator bifrost_tileiterator.h
	\brief The TileIterator class is a utility for iterating over tiles of a tile tree.
	\sa Layout::tileIterator

	\code
	// Load a BIF file and iterate over a tile tree
	#include <bifrostapi/bifrost_tileiterator.h>
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_array.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ss = fileio.load( );
	if ( ss ) {
		// Loop over the tile tree of the loaded layout and iterate the tile children with an iterator.
		RefArray layouts = ss.layouts();
		Layout layout = layouts[0];
		TileIterator it = layout.tileIterator( 0, layout.maxDepth(), BreadthFirst );
		while( it ) {
			Tile tile = *it;
			TileInfo info = tile.info();

			// log the tile info
			TreeIndex tindex = it.neighbourIndex( 0, 0, 0 );

			std::cout << "tile id: " << info.id << std::endl;
			std::cout << "	tile is valid: " << info.valid << std::endl;
			std::cout << "	tile space coordinates: " << info.i << ", " << info.j  << ", " << info.k << std::endl;
			std::cout << "	tile index: " << info.tile << ":" << info.depth << std::endl;
			std::cout << "	tile parent: " << info.parent << std::endl;
			std::cout << "	tile has children: " << info.hasChildren << std::endl;
			std::cout << "	tile neighbour: " << tindex.tile << ":" << tindex.depth << std::endl;

			// next
			++it;
		}
	}
	\endcode
*/
//*****************************************************************************

class BIFROST_API_DECL TileIterator : public Base
{
	public:

	/*! Default constructor. */
	TileIterator();

	/*! Constructor.
	*/
	TileIterator(const Ref& ref);

	/*! Copy constructor.
	\param other Constant TileIterator object.
	*/
	TileIterator( const TileIterator& other );

	/*! Default destructor. */
	~TileIterator();

	/*! Assigns other to this iterator. This iterator is set to empty if obj is empty.
	\param other Tile iterator..
	\return A new %TileIterator object.
	*/
	TileIterator& operator=(const TileIterator& other);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Tile object.
	*/
	TileIterator& operator=(const Ref& ref);

	/*! Returns true if this iterator points to the same element as other.
	\return True if equals, false otherwise.
	*/
    bool operator==(const TileIterator& other) const;

	/*! Returns true if this iterator doesn't point to the same element as other.
	\return True if equals, false otherwise.
	*/
    bool operator!=(const TileIterator& other) const;

	/*! Returns the Tile object pointed by the iterator.
	\return Tile Current tile pointed by the iterator.
	*/
    Tile operator*() const;

	/*! Moves the iterator forward.
	\return The updated iterator.
	*/
    TileIterator& operator++();

	/*! Returns true if the iterator is pointing to a valid tile.
	*/
    operator bool() const;

	/*! Moves the iterator to the next branch in the tree.
	<br><b>Note:</b> This method is ignored for BreadthFirst iterators.
	*/
	void skip();

	/*! Returns the index of the smallest possible neighbour tile to the tile pointed by the iterator.
	\param offseti 1st dimension index offset of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).
	\param offsetj 2nd dimension index offset of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).
	\param offsetk 3rd dimension index offset of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).

	\return TreeIndex The index of the neighbour tile or empty index if the tile doesn't exist.
	<br><b>Note:</b> The neighbour may be the parent in the case where the fine tile neighbour of a fine tile internal in the domain of the parent tile does not exist.
	*/
	TreeIndex neighbourIndex( int offseti, int offsetj, int offsetk ) const;

	/*! Returns the index of the smallest possible neighbour tile to the tile pointed by the iterator.
	\param offset offset coordinates of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).

	\return TreeIndex The index of the neighbour tile or empty index if the tile doesn't exist.
	<br><b>Note:</b> The neighbour may be the parent in the case where the fine tile neighbour of a fine tile internal in the domain of the parent tile does not exist.
	*/
	TreeIndex neighbourIndex( const TileCoord& offset ) const;

	/*! Returns the tile index of the tile pointed by the iterator.
	\return TreeIndex The index of the tile or empty index of the tile doesn't exist.
	*/
	TreeIndex index( ) const;

	/*! Returns the meta-data information of tile pointed by the iterator.
	\return Tile info data.
	*/
	TileInfo tileInfo( ) const;
};

}
}

#endif // _BIFROST_TILEITERATOR_H_