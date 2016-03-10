//*****************************************************************************
/*!
   \file bifrost_layout.h
   \brief Layout class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_LAYOUT_H_
#define _BIFROST_LAYOUT_H_

#include "bifrostapi/bifrost_typebase.h"
#include "bifrostapi/bifrost_types.h"

namespace Bifrost {
namespace API {

class Visitor;
class Status;
class Tile;
class TileAccessor;
class TileIterator;
class Dictionary;

//*****************************************************************************
/*! \class Layout bifrost_layout.h
	\brief The %Layout class. All the Channels in a Component have the same %Layout. 
	A %Layout indicates exactly how many elements there are in every channel (how many voxels, 
	how many particles, etc.), and for the currently implemented Components, it also defines 
	essentially how they are mapped into 3D space.

	\sa TileAccessor
	\sa TileIterator
	\sa StateServer::createLayout	
	\sa Visitor
 */
//*****************************************************************************

class BIFROST_API_DECL Layout : public TypeBase
{
	public:

	/*! Default constructor. */
	Layout();

	/*! Default destructor. */
	~Layout();

	/*! Constructor. 
	*/
	Layout(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Layout(const Layout& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Layout object.
	*/
	Layout& operator=(const Layout& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Layout object.
	*/
	Layout& operator=(const Ref& ref);

	/*! Returns the voxel scale factor value for this layout.
	\return Voxel scale value.
	*/
	float voxelScale( ) const;

	/*! Sets the voxel scale factor value for this layout.
	\param value Scale value.
	*/
	void setVoxelScale( float value ) ;

	/*! Returns the number of tree depth levels for this layout.
	\return size_t number of levels.
	*/
	size_t depthCount() const;

	/*! Returns the maximum depth level of the underlying tile tree. The max depth is usually the finest level where most of the data is stored.
	\return TreeIndex::Depth Finest depth level.
	*/
	TreeIndex::Depth maxDepth() const;

	/*! Returns the number of tiles at a specific depth for this layout.
	\param depth Depth level.
	\return size_t number of tiles.
	*/
	size_t tileCount( TreeIndex::Depth depth ) const;

	/*! Returns the number of tiles for all depth levels of this layout.
	\return size_t number of tiles.
	*/
	size_t tileCount( ) const;

	/*! Returns the tile dimension values for this layout at a specific depth level.
	\param depth Depth level.
	\return Tile dimension info data.
	*/
	TileDimInfo tileDimInfo( TreeIndex::Depth depth=0 ) const;

	/*! Returns the index of a tile located at coordinate i,j,k.
	\param i Coordinate 0
	\param j Coordinate 1
	\param k Coordinate 2
	\param depth Tile tree depth index of the tile to locate.
	\return TreeIndex tile index.
	*/
	TreeIndex treeIndex( int i, int j, int k, TreeIndex::Depth depth=0 ) const;

	/*! Returns the index of a tile located at coordinate i,j,k.
	\param coord Coordinates of the tile to retrieve.
	\param depth Tile tree depth index of the tile to locate.
	\return TreeIndex tile index.
	*/
	TreeIndex treeIndex( const TileCoord& coord, TreeIndex::Depth depth=0 ) const;

	/*! Returns the index of a tile from its identifier.
	\param id Tile identifier.
	\return TreeIndex tile index.
	*/
	TreeIndex treeIndex( const TileInfo::ID& id ) const;

	/*! Returns all Tile identifiers of this layout for a depth range. 
	\param startDepth Starting depth level.
	\param endDepth Ending depth level.
	\return TileIDArray Array of Tile identifiers. Returns an empty array if depth parameters are out of range.
	*/
	TileIDArray tileIDs( TreeIndex::Depth startDepth=0, TreeIndex::Depth endDepth=TreeIndex::maxDepth ) const;

	/*! Creates a TileAccessor object on this layout.
	\return TileAccessor New %TileAccessor object.
	*/
	TileAccessor tileAccessor( ) const;

	/*! Returns an iterator to the first tile element of the underlying tile tree. The returned
	iterator covers all tiles in the tree from first to last depth level. 
	\param mode The traversal mode. If not specified, the traversal is performed with the Layout::DepthFirst mode.
	\return TileIterator
	\sa Layout::endTile
	*/
	TileIterator tileIterator(TraversalMode mode=TraversalMode::DepthFirst) const;

	/*! Returns an iterator to the first tile element of the underlying tile tree. The traversal is preformed from first to last depth.
	\param first The depth level to start the traversal.
	\param last The depth level to stop the traversal.
	\param mode The traversal mode. 
	<br><b>Note:</b>Layout::BreadthFirst is the only mode supported for now. other modes defaults to Layout::DepthFirst.
	\return TileIterator
	\sa Layout::endTile
	*/
	TileIterator tileIterator(TreeIndex::Depth first, TreeIndex::Depth last, TraversalMode mode) const;

	/*! Traverses a %Bifrost tile tree using the visitor design pattern. Each tile of the tree is visited exactly once systematically. 
	Type of traversals are classified by the order in which the tiles are visited. Several types are available, including breadth-first 
	and depth-first. Traversals can be performed in sequential or parallel computation. See Bifrost::API::TraversalMode for more details about 
	the different modes available.
	
	To traverse a tile tree, one must extend the Bifrost::API::Visitor class for implementing a visitor class. The visitor class must 
	implement the methods required by the %Bifrost tree traverser to visit each tile. Each method receives the tree information required to 
	operate on the tile data.

	\param visitor The visitor object used by the traverser.
	\param mode The tree traversal mode.
	\return Status::Success is the traversal succeeded or Status::Success otherwise.

	<br>This example demonstrates how to navigate a tile tree using the visitor pattern.
	\code
	\endcode
	*/
	Status traverse( Visitor& visitor, TraversalMode mode );

	/*! Traverses a %Bifrost tile tree using the visitor design pattern. This method is similar to Layout::traverse( Visitor& client, TraversalMode mode ),
	but also allows traversing a tree from a start to an end depth level. Each tile within these levels are systematically visited.

	\param visitor The visitor object used by the traverser.
	\param mode The traversal mode.
	\param startDepth Starting depth level.
	\param endDepth Ending depth level.
	\return Status::Success is the traversal succeeded or Status::Success otherwise.

	<br>This example demonstrates how to navigate a tile tree using the visitor pattern.
	\code
	\endcode
	*/
	Status traverse( Visitor& visitor, TraversalMode mode, TreeIndex::Depth startDepth, TreeIndex::Depth endDepth );

	/*! Returns the dictionary of this layout.
	\return Dictionary object.
	*/
	Dictionary dictionary() const ;
};

}
}

#endif // _BIFROST_BASE_H_