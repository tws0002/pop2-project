//*****************************************************************************
/*!
   \file bifrost_tile.h
   \brief Tile class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_TILE_H_
#define _BIFROST_TILE_H_

#include "bifrostapi/bifrost_base.h"

namespace Bifrost {
namespace API {

//*****************************************************************************
/*! \class Tile bifrost_tile.h
	\brief The Tile class represents an item of a tile tree. It stores meta data and link information
	to other tiles. 

	\code
	// Demonstrate how to get tile objects by iterating over a tile tree.
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_tileiterator.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_array.h>
	#include <iostream>

	// load a BIF files with tile objects
	Bifrost::API::ObjectModel om;
	Bifrost::API::FileIO fileio = om.createFileIO( "particles.bif" );
	Bifrost::API::StateServer ss = fileio.load( );
	if ( ss ) {
		// Iterate over the tile tree of the loaded layout
		Bifrost::API::RefArray layouts = ss.layouts();	
		Bifrost::API::Layout layout = layouts[0];
		Bifrost::API::TileIterator it = layout.tileIterator();
		while( it ) {
			Bifrost::API::Tile tile = *it;
			Bifrost::API::TileInfo info = tile.info();

			// log the tile info
			std::cout << "tile id: " << info.id << std::endl;
			std::cout << "	tile is valid: " << info.valid << std::endl;
			std::cout << "	tile space coordinates: " << info.i << ", " << info.j  << ", " << info.k << std::endl;
			std::cout << "	tile index: " << info.tile << ":" << info.depth << std::endl;
			std::cout << "	tile parent: " << info.parent << std::endl;
			std::cout << "	tile has children: " << info.hasChildren << std::endl;

			// next
			++it;
		}
	}
	\endcode
	\sa Bifrost::API::TileData
	\sa Bifrost::API::TileDataAccessor
	\sa Bifrost::API::TileIterator

 */
//*****************************************************************************
class BIFROST_API_DECL Tile : public Base
{
	public:
	/*! Default constructor. */
	Tile();

	/*! Default destructor. */
	~Tile();

	/*! Constructor. 
	*/
	Tile(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Tile(const Tile& obj);

	/*! Assigns obj to this object. This object is set to empty if obj is not compatible.
	\param obj constant class object.
	\return The new %Tile object.
	*/
	Tile& operator=(const Tile& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Tile object.
	*/
	Tile& operator=(const Ref& ref);

	/*! Returns the tile index of this tile.
	\return Tile tree index.
	*/
	TreeIndex index() const;

	/*! Returns the tile identifier.
	\return Tile identifier.
	*/
	TileInfo::ID id() const;

	/*! Returns the index of the tile's parent.
	\return Tile index of the parent.
	*/
	TreeIndex::Tile parent() const;

	/*! Returns the coordinates of this tile.
	\return TileCoord object.
	*/
	TileCoord coord() const;

	/*! Returns all the meta-data information of a tile in one data structure.
	\return Tile info data.
	*/
	TileInfo info() const;

	/*! Returns the tile index of a child at location i,j,k in tile space coordinates.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	\return The tree index of the child. An invalid index is returned if the child doesn't exist.
	\sa TreeIndex::valid
	\code
	// This example demonstrates how to iterate over children tiles.
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_tileiterator.h>
	#include <bifrostapi/bifrost_tileaccessor.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_array.h>
	#include <iostream>

	using namespace Bifrost::API;

	// load a BIF files with tile objects
	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ss = fileio.load( );
	if ( ss ) {
		// traverse the tree and iterate tile children
		RefArray layouts = ss.layouts();	
		Layout layout = layouts[0];
		TileAccessor tacc = layout.tileAccessor();
		size_t depth = layout.maxDepth();
		TileIterator it = layout.tileIterator(depth,depth, BreadthFirst);

		while( it ) {
			// Get tile info to access children
			Tile tile = *it;
			TreeIndex itIndex = it.index();
			TreeIndex tindex = tile.index();
			TileInfo info = tile.info();

			// access children with i,j,k coordinates
			if ( info.hasChildren ) {
				TileDimInfo dinfo = tile.dimInfo();
				for (int i=0; i<dinfo.tileWidth; i++ ) {
					for (int j=0; j<dinfo.tileWidth; j++ ) {
						for (int k=0; k<dinfo.tileWidth; k++ ) {							
							TreeIndex cindex = tile.child( i, j, k );

							// log the child tile info
							if (cindex.valid()) {
								Tile child = tacc.tile( cindex );							
								TileInfo cinfo = child.info();

								std::cout << "tile id: " << cinfo.id << std::endl;
								std::cout << "	tile is valid: " << cinfo.valid << std::endl;
								std::cout << "	tile space coordinates: " << cinfo.i << ", " << cinfo.j  << ", " << cinfo.k << std::endl;
								std::cout << "	tile index: " << cinfo.tile << ":" << cinfo.depth << std::endl;
								std::cout << "	tile parent: " << cinfo.parent << std::endl;
								std::cout << "	tile has children: " << cinfo.hasChildren << std::endl;
							}							
						}
					}
				}			
			}
			++it;
		}
	}
	\endcode
	*/
	TreeIndex child( int i, int j, int k ) const;
};

}
}

#endif // _BIFROST_TILE_H_