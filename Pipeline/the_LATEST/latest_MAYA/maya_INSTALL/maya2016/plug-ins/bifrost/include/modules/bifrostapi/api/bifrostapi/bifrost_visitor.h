//*****************************************************************************
/*!
   \file bifrost_visitor.h
   \brief Visitor class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_VISITOR_H_
#define _BIFROST_VISITOR_H_

#include "bifrostapi/bifrost_types.h"

namespace Bifrost {
namespace API {

class TileAccessor;

//*****************************************************************************
/*! \class Visitor bifrost_visitor.h
	\brief The %Visitor class defines the protocol for iterating over a %Bifrost tile tree
	using the visitor design pattern. Clients must specialize this class to process individual tiles. Tree traversals 
	are launched with Layout::traverse.

	<br> This example shows how to use a visitor to scale all values of a position channel with parallel computation.
	\code
	#include <bifrostapi/bifrost_visitor.h>
	#include <bifrostapi/bifrost_pointchannel.h>
	#include <bifrostapi/bifrost_tiledataaccessor.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_fileio.h>

	using namespace Bifrost::API;
	
	// PositionScaler extends the Visitor class to scale all values contained in a position channel.
	class PositionScaler : public Visitor
	{
		public:
		// the tile data accessor containing the data to scale
		TileDataAccessor _accessor;
		float _value;

		PositionScaler() : _value(1.0f)
		{
		}

		PositionScaler( const TileDataAccessor& accessor, float value ) : _accessor(accessor), _value(value)
		{
		}

		~PositionScaler()
		{
		}

		void beginTile( const TileAccessor& accessor, const TreeIndex& index ) 
		{
			// rescale all particle positions in the tile
			TileData<amino::Math::vec3f> data = _accessor.tileData<amino::Math::vec3f>( index );
			for ( size_t i=0; i<data.count(); i++ ) {
				data[i] *= _value;
			}
		}

		virtual Visitor* copy( ) const
		{
			// Required for parallel computation
			return new PositionScaler( _accessor, _value );
		}

	};

	// load a BIF particle file for this example
	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ss = fileio.load( );
	if ( ss ) {
		// Get the layout for traversing the tree
		RefArray layouts = ss.layouts();
		Layout layout = layouts[0];

		// The position channel to scale
		PointChannel posChannel = ss.findChannel("voxel_liquid-particle/position");

		// Create the PositionScaler visitor with a scale value of 2
		PositionScaler scaler;
		scaler._value = 2.0f;
		scaler._accessor = posChannel.tileDataAccessor();

		// Traverse the tree in ParallelBreadthFirst mode to process all positions 
		layout.traverse( scaler, TraversalMode::ParallelBreadthFirst );
	}
	\endcode

	\sa Layout::traverse
 */
//*****************************************************************************

class BIFROST_API_DECL Visitor
{
	public:

	/*! Default constructor. */
	Visitor()
	{
	}

	/*! Default destructor. */
	virtual ~Visitor()
	{
	}

	/*! Called before the traversal takes place. Typically used to setup some internal states.
	\param accessor The tile accessor of the tile tree being treversed. The accessor is required for creating the 
	Tile object being visited if needs be. Passing the accessor as argument is convenient as it saves you from storing 
	it in the specialized visitor class.
	*/
	virtual void beginTraverse( const TileAccessor& accessor ) 
	{
	}

	/*! Called after the traversal terminates. Typically used to perform some post-traversal tasks.
	\param accessor The tile accessor of the tile tree being treversed. The accessor is required for creating the 
	Tile object being visited if needs be. Passing the accessor as argument is convenient as it saves you from storing 
	it in the specialized visitor class.
	*/
	virtual void endTraverse( const TileAccessor& accessor ) 
	{
	}

	/*! Called before visiting a tile. Typically used to setup some internal states for this particular tile.
	\param accessor The tile accessor of the tile tree being treversed. The accessor is required for creating the 
	Tile object being visited if needs be. Passing the accessor as argument is convenient as it saves you from storing 
	it in the specialized visitor class.
	\param index The index of the tile being visited.
	*/
	virtual void beginTile( const TileAccessor& accessor, const TreeIndex& index ) 
	{
	}

	/*! Called for each voxel of a tile.
	-# %visitVoxel is called with the tile coordinates of the voxel being visited.
	-# %visitVoxel can return false to tell the traverser to skip children processing during a depth first traversal.
	-# %visitVoxel is not called for tiles located at the finest depth level.

	\param accessor The tile accessor of the tile tree being treversed. The accessor is required for creating the 
	Tile object being visited if needs be. Passing the accessor as argument is convenient as it saves you from storing 
	it in the specialized visitor class.
	\param index The index of the tile being visited.
	\param coord The coordinate of the voxel data in tile space.
	\return Returns true to continue iterating over children or false to jump to the next tree branch. 
	<br><b>Note:</b> The return value is only significant for depth first traversals.
	*/
	virtual bool visitVoxel( const TileAccessor& accessor, const TreeIndex& index, const TileCoord& coord ) 
	{ 
		return true; 
	}

	/*! Called the traverser is done iterating a tile. Typically used to perform post-traversal tasks for this particular tile.
	\param accessor The tile accessor of the tile tree being treversed. The accessor is required for creating the 
	Tile object being visited if needs be. Passing the accessor as argument is convenient as it saves you from storing 
	it in the specialized visitor class.
	\param index The index of the tile being visited.
	*/
	virtual void endTile( const TileAccessor& accessor, const TreeIndex& index ) 
	{
	}

	/*! Returns a copy of a specialized Visitor object. This method is required by the traverser to spawn a new visitor 
	instance when the traversal mode is set to one of these values:
	\li Bifrost::API::TraversalMode::ParallelBreadthFirst,
    \li Bifrost::API::TraversalMode::ParallelBreadthFirstBottomUp,
    \li Bifrost::API::TraversalMode::ParallelDepthFirst,
    \li Bifrost::API::TraversalMode::ParallelReduceDepthFirst,
    \li Bifrost::API::TraversalMode::ParallelReduceBreadthFirst,
    \li Bifrost::API::TraversalMode::ParallelReduceBreadthFirstBottomUp
	\return Pointer to a new instance of the Visitor class. The memory must be allocated with the new operator. 
	\sa Layout::traverse
	*/
	virtual Visitor* copy( ) const
	{
		return 0;
	}

	/*! This method can be implemented for parallel reduction algorithms. The method is used by the traverser to join the results 
	of two visitor objects.	Parallel reduction is enabled when the traversal mode is set to one of the following values:
    \li Bifrost::API::TraversalMode::ParallelReduceDepthFirst
    \li Bifrost::API::TraversalMode::ParallelReduceBreadthFirst
    \li Bifrost::API::TraversalMode::ParallelReduceBreadthFirstBottomUp	
	\param visitor A %Visitor object to join.
	\sa Layout::traverse
	*/
	virtual void join( const Visitor& visitor ) 
	{
	}
};

}}

#endif // _BIFROST_VISITOR_H_