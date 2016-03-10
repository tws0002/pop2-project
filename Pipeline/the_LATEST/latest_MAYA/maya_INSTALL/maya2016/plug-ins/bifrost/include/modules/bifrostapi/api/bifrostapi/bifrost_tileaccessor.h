//*****************************************************************************
/*!
   \file bifrost_tileaccessor.h
   \brief TileAccessor class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_TILEACCESSOR_H_
#define _BIFROST_TILEACCESSOR_H_

#include "bifrostapi/bifrost_tile.h"
#include "bifrostapi/bifrost_array.h"

namespace Bifrost {
namespace API {

class Layout;

//*****************************************************************************
/*! \class TileAccessor bifrost_tileaccessor.h
	\brief The TileAccessor class can be used for optimized node access and node creation.
    Internally it caches the last node used and uses this as the starting point for subsequent 
	accesses. Hence, if the accesses are spatially close, this approach is likely to give speed ups.

	\code
	// Example of building a tile tree with a TileAccessor object
	#include <bifrostapi/bifrost_tileaccessor.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_tileiterator.h>
	#include <bifrostapi/bifrost_const.h>
	#include <bifrostapi/bifrost_tile.h>
	#include <iostream>
	#include <vector>

	using namespace Bifrost::API;

	// creates a voxel component and its layout
	ObjectModel om;
	StateServer ss = om.createStateServer();
	Component vcomp = ss.createComponent( VoxelComponentType, "volume" );
	Layout layout = vcomp.layout();

	// create the root of the tile tree 
	TileAccessor tacc = layout.tileAccessor();
	TreeIndex root = tacc.addRoot();
	TileInfo tinfo = tacc.tileInfo(root);

	// Get the tile and voxel width to compute the data
	TileDimInfo dinfo = tinfo.dimInfo();
	const int tw = dinfo.tileWidth;

	// Set the tile data and add a child tile at every location of a tile data 
	for (int lk=0; lk<tw; ++lk) {
		for (int lj=0; lj<tw; ++lj) {
			for (int li=0; li<tw; ++li) {
				TreeIndex newTile = tacc.addTile(	tinfo.i + dinfo.voxelWidth*li, 
													tinfo.j + dinfo.voxelWidth*lj, 
													tinfo.k + dinfo.voxelWidth*lk, 
													tinfo.depth+1 );
			}
		}
	}

	// log information on the first 10 tiles of the new tile tree
	TileIterator it = layout.tileIterator( 0, layout.maxDepth(), Layout::BreadthFirst);
	std::vector<Bifrost::API::TileCoord> coords(8);
	coords[0] = Bifrost::API::TileCoord( 0, 0, 0 );
	coords[1] = Bifrost::API::TileCoord( 1, 0, 0 );
	coords[2] = Bifrost::API::TileCoord( 1, 1, 0 );
	coords[3] = Bifrost::API::TileCoord( 1, 1, 1 );
	coords[4] = Bifrost::API::TileCoord( 0, 1, 1 );
	coords[5] = Bifrost::API::TileCoord( 0, 0, 1 );
	coords[6] = Bifrost::API::TileCoord( 0, 1, 0 );
	coords[7] = Bifrost::API::TileCoord( 1, 0, 1 );
	size_t counter = 0;
	while ( it && counter++ <= 10 ) {
		Tile tile = *it;
		TileInfo info = tile.info();

		// log the tile info
		std::cout << "tile id: " << info.id << std::endl;
		std::cout << "	tile is valid: " << info.valid << std::endl;
		std::cout << "	tile space coordinates: " << info.i << ", " << info.j  << ", " << info.k << std::endl;
		std::cout << "	tile index: " << info.tile << ":" << info.depth << std::endl;
		std::cout << "	tile parent: " << info.parent << std::endl;
		std::cout << "	tile has children: " << info.hasChildren << std::endl;
		for ( int i=0; i<coords.size(); i++ ) {
			TileCoord tc = coords[i];
			TreeIndex tindex = it.neighbourIndex( tc );		
			std::cout << "	tile neighbour " << tc.i << "," << tc.j << "," << tc.k << " = " << tindex.tile << ":" << tindex.depth << std::endl;
		}

		// next
		++it;
	}
\endcode
\code
	// Output:
	//tile id: 0
	//        tile is valid: 1
	//        tile space coordinates: -195312, -195312, -195312
	//        tile index: 0:0
	//        tile parent: -2
	//        tile has children: 1
	//        tile neighbour 0,0,0 = 0:0
	//        tile neighbour 1,0,0 = -1:-1
	//        tile neighbour 1,1,0 = -1:-1
	//        tile neighbour 1,1,1 = -1:-1
	//        tile neighbour 0,1,1 = -1:-1
	//        tile neighbour 0,0,1 = -1:-1
	//        tile neighbour 0,1,0 = -1:-1
	//        tile neighbour 1,0,1 = -1:-1
	//tile id: 144115188075855872
	//        tile is valid: 1
	//        tile space coordinates: -195312, -195312, -195312
	//        tile index: 0:1
	//        tile parent: 0
	//        tile has children: 0
	//        tile neighbour 0,0,0 = 0:1
	//        tile neighbour 1,0,0 = 1:1
	//        tile neighbour 1,1,0 = 6:1
	//        tile neighbour 1,1,1 = 31:1
	//        tile neighbour 0,1,1 = 30:1
	//        tile neighbour 0,0,1 = 25:1
	//        tile neighbour 0,1,0 = 5:1
	//        tile neighbour 1,0,1 = 26:1
	//tile id: 288230376151711744
	//        tile is valid: 1
	//        tile space coordinates: -117187, -195312, -195312
	//        tile index: 1:1
	//        tile parent: 0
	//        tile has children: 0
	//        tile neighbour 0,0,0 = 1:1
	//        tile neighbour 1,0,0 = 2:1
	//        tile neighbour 1,1,0 = 7:1
	//        tile neighbour 1,1,1 = 32:1
	//        tile neighbour 0,1,1 = 31:1
	//        tile neighbour 0,0,1 = 26:1
	//        tile neighbour 0,1,0 = 6:1
	//        tile neighbour 1,0,1 = 27:1
	// etc....

	\endcode
	\sa Bifrost::API::Layout::tileAccessor

 */
//*****************************************************************************
class BIFROST_API_DECL TileAccessor : public Base
{
	public:
	/*! Default constructor. */
	TileAccessor();

	/*! Default destructor. */
	~TileAccessor();

	/*! Constructor. 
	*/
	TileAccessor(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	TileAccessor(const TileAccessor& obj);

	/*! Assigns obj to this object. This object is set to empty if obj is not compatible.
	\param obj constant class object.
	\return The new %TileAccessor object.
	*/
	TileAccessor& operator=(const TileAccessor& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Tile object.
	*/
	TileAccessor& operator=(const Ref& ref);

	/*! Returns the layout owner of this accessor.
	\return Layout owner object.
	*/
	Layout layout() const;

	/*! Returns a Tile object from a tile and depth index.
	\param index TreeIndex::Tile index of the tile to retrieve.
	\param depth Tile tree depth index of the tile to retrieve.	
	\return Tile tile object.
	*/
	Tile tile( TreeIndex::Tile index, TreeIndex::Depth depth ) const;

	/*! Returns a Tile object from a TreeIndex.
	\param index Index of the tile to retrieve.
	\return Tile tile object.
	*/
	Tile tile( const TreeIndex& index ) const;

	/*! Returns a Tile object from a Tile identifier.
	\param id Tile identifier.
	\return Tile tile object.
	*/
	Tile tile( const TileInfo::ID& id ) const;

	/*! Returns a Tile object from a triplet i,j,k index at the finest depth level.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	\return Tile tile object.
	*/
	Tile tile( int i, int j, int k ) const;

	/*! Returns a Tile object from an triplet i,j,k index and depth index.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	\param depth Tile tree depth index of the tile to retrieve.
	\return Tile tile object.
	*/
	Tile tile( int i, int j, int k, TreeIndex::Depth depth ) const;

	/*! Returns a Tile object from a triplet i,j,k coordinate and depth index.
	\param coord Coordinates of the tile to retrieve.
	\param depth Tile tree depth index of the tile to retrieve.
	\return Tile tile object.
	*/
	Tile tile( const TileCoord& coord, TreeIndex::Depth depth ) const;

	/*! Adds a tile at the root of the tile tree.
	\return TreeIndex New tile index or invalid index if it cannot be created.
	*/
	TreeIndex addRoot( );

	/*! Adds a new tile with a specific id.
	\param id %Tile identifier.
	\return TreeIndex New tile index or invalid index if it cannot be created.
	*/
	TreeIndex addTile( TileInfo::ID id );

	/*! Adds a new tile at coordinates i,j,k and located at the finest depth level.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	\return TreeIndex New tile index or invalid index if it cannot be created.
	*/
	TreeIndex addTile( int i, int j, int k );

	/*! Adds a new tile at coordinates i,j,k and located at a specific depth level.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	\param depth Depth level index.
	\return TreeIndex New tile index or invalid index if it cannot be created.
	*/
	TreeIndex addTile( int i, int j, int k, TreeIndex::Depth depth );

	/*! Adds a new tile at coordinates i,j,k and located at the finest depth level.
	\param coord Tile coordinates.
	\return TreeIndex New tile index or invalid index if it cannot be created.
	*/
	TreeIndex addTile( const TileCoord& coord );

	/*! Adds a new tile at coordinates i,j,k and located at a specific depth level.
	\param coord Tile coordinates.
	\param depth Depth level index.
	\return TreeIndex New tile index or invalid index if it cannot be created.
	*/
	TreeIndex addTile( const TileCoord& coord, TreeIndex::Depth depth );

	/*! Adds multiple tiles at once. 
	\param ids Array of existing tile identifiers.
	\return Returns Success or Failure if the operation failed.
	*/
	Status addTiles( const TileIDArray& ids );

	/*! Adds multiple tiles at once. This method adds new tiles as specified in an array of TileCoordArray elements. The first dimension 
	of the array specifies the depth at which each new tiles are added in the tree. The depth range goes from 0 to the maximum depth
	allowed by the underlying layout (see \ref Layout::maxDepth).
	\param coords Array of tile coordinate arrays. The array length should equal to \ref Layout::maxDepth + 1 otherwise an error is returned.
	\return Returns Success or Failure if the operation failed.
	*/
	Status addTiles( const TileCoordArray2D& coords );

	/*! Removes a tile of a specific identifier.
	\param id Identifier of the tile to remove.
	\return Returns Success or Failure if the operation faied.
	*/
	Status removeTile( const TileInfo::ID& id );

	/*! Removes a tile at a specific index.
	\param index Index to the tile to remove.
	\return Returns Success or Failure if the operation failed.
	*/
	Status removeTile( const TreeIndex& index );

	/*! Removes multiple tiles at once.
	\param ids Array of tile identifiers.
	\return Returns Success or Failure if the operation failed.
	*/
	Status removeTiles( const TileIDArray& ids );

	/*! Removes multiple tiles at once.
	\param ids Array of tile indices.
	\return Returns Success or Failure if the operation failed.
	*/
	Status removeTiles( const TreeIndexArray& ids );

	/*! Returns the index of the smallest possible tile to the tile covering the coordinates i,j,k and located at the finest depth level.
	\param i Coordinate 0 of target tile.
	\param j Coordinate 1 of target tile.
	\param k Coordinate 2 of target tile.
	\return TreeIndex The index of the tile or empty index of the tile doesn't exist.
	*/
	TreeIndex index( int i, int j, int k );

	/*! Returns the index of the smallest possible tile to the tile covering the coordinates i,j,k and located at a specific depth level.
	\param i Coordinate 0 of target tile.
	\param j Coordinate 1 of target tile.
	\param k Coordinate 2 of target tile.
	\param depth Depth level index.
	\return TreeIndex The index of the tile or empty index of the tile doesn't exist.
	*/
	TreeIndex index( int i, int j, int k, TreeIndex::Depth depth );

	/*! Returns the index of the smallest possible tile to the tile covering the coordinates i,j,k and located at the finest depth level.
	\param target Tile coordinates.
	\return TreeIndex The index of the tile or empty index of the tile doesn't exist.
	*/
	TreeIndex index( const TileCoord& target );

	/*! Returns the index of the smallest possible tile to the tile covering the coordinates i,j,k and located at a specific depth level.
	\param target Tile coordinates.
	\param depth Depth level index.
	\return TreeIndex The index of the tile or empty index of the tile doesn't exist.
	*/
	TreeIndex index( const TileCoord& target, TreeIndex::Depth depth );

	/*! Returns the index of the smallest possible neighbour tile to the tile covering the coordinates i,j,k and located at a specific depth level.
	\param offseti 1st dimension index offset of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).
	\param offsetj 2nd dimension index offset of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).
	\param offsetk 3rd dimension index offset of the neighbour in multiples of the tile width (TileDimInfo::tileWidth).
	\param targeti 1st dimension index of target tile.
	\param targetj 2nd dimension index of target tile.
	\param targetk 3rd dimension index of target tile.
	\param depth Depth level index.
	\param exactTile Controls the semantic of the returned index. If no neighbour is found at the specified depth, the returned index is invalid 
	if exactTile is true. If set to false (default), the parent index is returned instead if no neighbour is found.

	\return TreeIndex The index of the neighbour tile based on the setting of the exactTile argument.
	*/
	TreeIndex neighbourIndex( int offseti, int offsetj, int offsetk, int targeti, int targetj, int targetk, TreeIndex::Depth depth, bool exactTile=false );

	/*! Returns the neighbour tiles of a specific tile that are within a distance of one tile. This includes tiles at finer and coarser depth levels. 
	\param index Index of the tile used in the search.
	\param indices The array containing all neighbour tile indices found by this method.
	\param leafVoxels If true (default), the returned tiles are the leaf voxels neighbours. A leaf voxel is a voxel that is not refined further (has no tile children). 
	When we are at coarser depths in a tree of adaptive simulations, returning leaf voxels neighbours can make a huge difference on performance. If leafVoxels is 
	false, all neighbour tiles are returned instead.
	\return Returns Success or Failure if the operation failed.
	*/
	Status neighbourIndices( const TreeIndex& index, TreeIndexArray& indices, bool leafVoxels=true );

	/*! Returns the meta-data information of a tile in one data structure.
	\param index Index of the tile to retrieve.
	\return Tile info data.
	*/
	TileInfo tileInfo( const TreeIndex& index ) const;
};

}
}
#endif // _BIFROST_TILEACCESSOR_H_