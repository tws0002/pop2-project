//*****************************************************************************
/*!
   \file bifrost_channel.h
   \brief Channel class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_CHANNEL_H_
#define _BIFROST_CHANNEL_H_

#include "bifrostapi/bifrost_typebase.h"
#include "bifrostapi/bifrost_tiledata.h"

namespace Bifrost {
namespace API {

class Status;
class Dictionary;

//*****************************************************************************
/*! \class Channel bifrost_channel.h
	\brief The %Channel class represents a channel associated with 3D tree data structures
	that can be indexed by means of a depth and a linear index (tree index) at each depth level. 
	A (tree-index,depth) pair identifies a tile which may not have a constant size but is assumed to 
	be cubic. The %Channel class is independent of the type of data it stores. 
	
	The %Channel class is the common base class for point and voxel channels:
	\li Point channels (aka particle channels) are owned by PointComponentType components and store data 
	(e.g. positions and velocities) in blocks of data accessible through the TileData class. The number of elements in each tile can 
	vary. The class PointChannel is used to perform specific operations on point channels.	
	\li Voxel channels are owned by VoxelComponentType components and store voxel data per tile. Voxel data can be accessed 
	through the TileData class. The number of elements in each tile is fixed. The class VoxelChannel is used to perform specific 
	operations on voxel channels.	

	\code
	// Create a point channel object.
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_channel.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_array.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	StateServer ss = om.createStateServer();

	// Channels need a parent component 
	Component pcomp = ss.createComponent( PointComponentType, "point" );

	// Create a channel of type FloatV3 with a point component parent
	Channel ch = ss.createChannel( pcomp, FloatV3Type, "position" );

    std::cout << "channel: " << ch.name() << std::endl;        
    std::cout << "type: " << ch.type() << std::endl;      
    std::cout << "stride: " << ch.stride() << std::endl;      
	std::cout << "arity: " << ch.arity() << std::endl;      
	std::cout << "type size: " << ch.typeSize() << std::endl;      
    std::cout << "elements: " << ch.elementCount() << std::endl;
	\endcode

	\sa Component
	\sa VoxelChannel
	\sa PointChannel
	\sa StateServer::createChannel
 */
//*****************************************************************************

class BIFROST_API_DECL Channel : public TypeBase
{
	public:
	/*! Default constructor. */
	Channel();

	/*! Default destructor. */
	~Channel();

	/*! Constructor. 
	*/
	Channel(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Channel(const Channel& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Channel object.
	*/
	Channel& operator=(const Channel& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Channel object.
	*/
	Channel& operator=(const Ref& ref);

	/*! Returns the partial path name of this channel. This string is '.' (dot) separated and represents the partial path from the root of the 	%Bifrost hierarchy to this object. The partial path is the minimum path that is still unique in this channel's state server. For instance, 	the partial path 'point.position' identifies uniquely a specifc channel where 'point' is the channel component owner and 'position' the 
	channel name.

	The partial path name is typically required by functions where a unique channel identifier is expected, StateServer::findChannel and 
	Component::findChannel are such API. However, Component::findChannel can take either a partial path name or a single channel name. Note that 
	the full path name of a channel can also be used by APIs expecting a partial path.

	\return Partial path name.
	\sa fullPathName
	\sa StateServer::findChannel
	\sa Component::findChannel
	*/
	String partialPathName() const;

	/*! Returns the full path name of this channel. This string is '.' (dot) separated and represents the full path from the root of the 	%Bifrost hierarchy to this object. The full path is unique in this channel's state server. For instance, the full path 'mesh.point.position' 
	identifies uniquely a specifc channel where 'mesh' is the object owner, 'point' the component owner and 'position' the channel name.
	\return Full path name.
	\sa partialPathName
	*/
	String fullPathName() const;

	/*! Returns the data type of this channel.
	\return Type of data this channel supports.
	*/
	DataType dataType() const;

	/*! Number of values per channel element. For instance, the number of values of a position channel element is 3 since the type is a FloatV3Type.
	\return Arity value.
	*/
	size_t arity() const;

	/*! Size of a channel element type in bytes. For instance, the size of a position channel element is 4 bytes since the element type is a float.
	\return Size value.
	*/
	size_t typeSize() const;

	/*! Size of a channel element in bytes. For instance, if the data type is FloatV3Type, the stride is 12 bytes
	(4 bytes per float X 3 value per element).
	\return Size value.
	*/
	size_t stride() const;

	/*! Returns the dictionary of this channel.
	\return Dictionary object.
	*/
	Dictionary dictionary() const ;
	
	/*! Returns the layout for this Channel.
	\return Reference to a Layout object.
	*/
	Ref layout() const;

	/*! Returns the component owner for this Channel.
	\return Reference to a Component object.
	*/
	Ref component() const;

	/*! Returns the number of data elements of this channel for all depth levels. 
	\return size_t number of elements.
	*/
	size_t elementCount() const;

	/*! Returns the number of data elements of this channel at a specific depth level.
	\param depth Depth level to get the element from.
	\return size_t number of elements.
	*/
	size_t elementCount( size_t depth ) const;	

	/*! Returns the number of elements at a specific tile index. The number of elements is guaranteed to be the same for all sibling channels of the parent
	component.
	\param index Index of the tile to locate. 
	\return size_t Number of elements. 
	*/
	size_t elementCount( const TreeIndex& index ) const;

	/*! Returns a TileData object of a specific type as specified with parameter T. The returned object is empty if the channel type doesn't match the requested type.
	\param index Tile index to access the tile data. The index must be smaller than the number of tiles in the channel, otherwise the results are unpredicted.
	\return TileData object. 
	\tparam T Specify the data type of TileData.

	\code
	// Demonstrate how to access the data stored in a channel 
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_channel.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_array.h>
	#include <iostream>

	using namespace Bifrost::API;

	// load a particle BIF file
	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ss = fileio.load( );
	if ( ss ) {
		// iterate over the position channel found in the file
		Component component = ss.components()[0];
		Channel ch = component.findChannel( "voxel_liquid-particle/position" );

		std::cout << "position channel data type: " << ch.dataType() << std::endl;

		// iterate over the tile tree at each level
		Layout layout = component.layout();
		size_t depthCount = layout.depthCount();
		for ( size_t d=0; d<depthCount; d++ ) {
			for ( size_t t=0; t<layout.tileCount(d); t++ ) {
				TreeIndex tindex(t,d);
				if ( !ch.elementCount( tindex ) ) {
					// nothing there
					continue;
				}
				std::cout << "tile:" << t << " depth:" << d << std::endl;
				const TileData<amino::Math::vec3f>& f3 = ch.tileData<amino::Math::vec3f>( tindex );
				for (size_t i=0; i<f3.count(); i++ ) {
					const amino::Math::vec3f& val = f3[i];
					std::cout << "\t" << val[0] << " " << val[1] << " " << val[2] << std::endl;
				}
				std::cout << std::endl;
			}
		}
		std::cout << std::endl;
	}
	\endcode
	*/
	template < typename T >
	TileData<T> tileData( const TreeIndex& index ) const;

	/*! Returns a TileData object of a specific type as specified with parameter T. The returned object is empty if the channel type doesn't match the requested type.
	\param tindex Index of the tile in the channel.
	\param dindex Tile tree depth of the tile in the channel.
	\return TileData object. 
	\tparam T Specify the data type of TileData.
	*/
	template < typename T >
	TileData<T> tileData( TreeIndex::Tile tindex, TreeIndex::Depth dindex ) const;

	/*! Access to the internal tile data array. The returned buffer is not type-safe, the caller is responsible to cast the pointer to the right type. The buffer cannot 
	be modified and should not be accessed after the content of the original %Channel object changes or is destroyed. 
	\param index Tile index to access the tile data. 
	\param size The number of elements in the returned buffer.
	\return Pointer to internal tile data array. 
	*/
	const void* tileDataPtr( const TreeIndex& index, size_t& size ) const;

	/*! Access to the internal tile data array. The returned buffer is not type-safe, the caller is responsible to cast the pointer to the right type. The buffer can 
	be modified but cannot be resized. It should not be accessed after the content of the original %Channel object has changed or was destroyed. 
	\param index Tile index to access the tile data. 
	\param size The number of elements in the returned buffer.
	\return Pointer to internal tile data array. 
	*/
	void* tileDataPtr( const TreeIndex& index, size_t& size );

	/*! Returns the default value used for initializing the channel tiles as set with Channel::setBackgroundValue. The user is responsible to 
	call this method with a parameter T that matches the channel data type (Channel::dataType).
	\return The background value as specified by the parameter T. 
	\tparam T Specify the data type of the background value.
	*/
	template < typename T >
	T backgroundValue( ) const;

	/*! Sets the background value (or default value) for initializing the channel tiles. The user is responsible to call this method 
	with a parameter T that matches the channel data type (Channel::dataType).
	\param value Background value.
	\return Returns Status::Success if the operation was successful or Status::Failure otherwise. 
	\tparam T Specify the data type of the background value.
	*/
	template < typename T >
	Status setBackgroundValue( const T& value );
};

}
}

#endif // _BIFROST_Channel_H_