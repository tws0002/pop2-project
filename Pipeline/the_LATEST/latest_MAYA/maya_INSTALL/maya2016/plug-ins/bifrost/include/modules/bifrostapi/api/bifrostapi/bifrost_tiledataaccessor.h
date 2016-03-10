//*****************************************************************************
/*!
   \file bifrost_tiledataaccessor.h
   \brief TileDataAccessor class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_TILEDATAACCESSOR_H_
#define _BIFROST_TILEDATAACCESSOR_H_

#include "bifrostapi/bifrost_base.h"
#include "bifrostapi/bifrost_tiledata.h"

namespace Bifrost {
namespace API {

//*****************************************************************************
/*! \class TileDataAccessor bifrost_tiledataaccessor.h
	\brief The TileDataAccessor class can be used for adding elements to a channel
	and removing existing elements. It also gives access to the tile data of a channel.

	<b>Note:</b>%TileDataAccessor is available for point channels only.

	\code
	// Demonstrates how to get a TileDataAccessor object from a point channel.
	#include <bifrostapi/bifrost_tiledataaccessor.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_pointchannel.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_const.h>
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_status.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	StateServer ss = om.createStateServer();
	Component comp = ss.createComponent( PointComponentType, "point" );
	PointChannel ch = ss.createChannel( comp, FloatV3Type, "pos" );
	TileDataAccessor posacc = ch.tileDataAccessor();
	TreeIndex tindex(0,0);
	std::cout << "Name: " << posacc.name() << std::endl;
	std::cout << "Kind of TileDataAccessor: " << posacc.isA(TileDataAccessorType) << std::endl;
	std::cout << "Data count at tile 0, depth 0: " << posacc.tileData<amino::Math::vec3f>( tindex ).count() << std::endl;
	\endcode
	\sa Bifrost::API::TileDataAccessor
	\sa Bifrost::API::TileData
	\sa Bifrost::API::PointChannel

 */
//*****************************************************************************
class BIFROST_API_DECL TileDataAccessor : public Base
{
	public:

	/*! Default constructor. */
	TileDataAccessor();

	/*! Default destructor. */
	~TileDataAccessor();

	/*! Constructor.
	*/
	TileDataAccessor(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	TileDataAccessor(const TileDataAccessor& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %TileDataAccessor object.
	*/
	TileDataAccessor& operator=(const TileDataAccessor& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new TileDataAccessor object.
	*/
	TileDataAccessor& operator=(const Ref& ref);

	/*! Returns the data type of the underlying channel.
	\return Type of data supported by this accessor.
	*/
	DataType dataType() const;

	/*! Returns a TileData object of a specific type as specified with parameter T. The returned object is empty if the
	underlying channel type doesn't match the requested type.
	\param index Tile index to access the tile data. The index must be smaller than the number of tiles in the channel, o
	therwise the results are unpredicted.
	\return TileData object.
	\tparam T Specify the data type of TileData.
	*/
	template < typename T >
	TileData<T> tileData( const TreeIndex& index ) const;

	/*! Update the underlying channel based on the elements previously added and removed. As the tile data array size of the underlying
	channel might change, this method will also update the tile data array of sibling channels as well. Calling this method at the
	wrong time or too often may lead to performance issues, use it with cautious.
	\sa TileDataAccessor::addElement
	\sa TileDataAccessor::removeElement
	*/
	void update();

	/*! Removes an element by index. The operation for removing the element is deferred until TileDataAccessor::update is called.
	\param tindex Tile index of the element to remove.
	\param dindex Tile tree depth index of the element to remove.
	\param eindex Tile data array index of the element to remove. The index must be smaller than the number of elements in the tile, otherwise
	the results are unpredicted.
	\sa TileDataAccessor::removeElement( const TreeIndex& index, size_t eindex )
	*/
	void removeElement( TreeIndex::Tile tindex, TreeIndex::Depth dindex, size_t eindex );

	/*! Removes an element by index. The operation for removing the element is deferred until TileDataAccessor::update is called.
	\param index TreeIndex index of the element to remove..
	\param eindex Index of the element in the Tile data array. The index must be smaller than the number of elements in the tile, otherwise
	the results are unpredicted.

	\code
	// Demonstrates how to remove elements from a tile with the TileDataAccessor class.
	#include <bifrostapi/bifrost_tiledataaccessor.h>
	#include <bifrostapi/bifrost_pointchannel.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_status.h>
	#include <iostream>

	Bifrost::API::ObjectModel om;
	FileIO fileio = om.createFileIO( "volume.bif" );
	StateServer ss = fileio.load( );

	if ( ss ) {
		const Bifrost::API::PointChannel& p = ss.findChannel( "voxel_liquid-particle/position" );
		Bifrost::API::TileDataAccessor pacc = p.tileDataAccessor();

		// remove elements 5,10,15 at tile 10, depth 7
		Bifrost::API::TreeIndex tindex(10,7);
		pacc.removeElement( tindex, 5 );
		pacc.removeElement( tindex, 10 );
		pacc.removeElement( tindex, 15 );
		// update the tile
		pacc.update();
	}
	\endcode
	*/
	void removeElement( const TreeIndex& index, size_t eindex );

	/*! Add an element to the tile data array of the underlying channel. TileDataAccessor::update must be used to update the total element count of the channel.
	\param tindex Tile index.
	\param dindex Tile tree depth index.
	\param value Element value to add.
	\tparam T Specify the value type of add.
	\sa TileDataAccessor::addElement( const TreeIndex& index, const T& value )
	*/
	template< typename T>
	void addElement( TreeIndex::Tile tindex, TreeIndex::Depth dindex, const T& value );

	/*! Add an element to a tile data array of the underlying channel. TileDataAccessor::update must be used to update the total element count of the channel.
	\param index TreeIndex object.
	\param value Element value to add.
	\tparam T Specify the value type of add.

	\code
	// Demonstrates how to add elements to a tile with the TileDataAccessor class.
	#include <bifrostapi/bifrost_tiledataaccessor.h>
	#include <bifrostapi/bifrost_pointchannel.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_status.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ss = fileio.load( );
	if ( ss ) {
		const PointChannel& v = ss.findChannel( "voxel_liquid-particle/velocity" );
		TileDataAccessor vacc = v.tileDataAccessor();

		// add new elements at tile 10, depth 7
		TreeIndex tindex(10,7);
		vacc.addElement<amino::Math::vec3f>( tindex, amino::Math::vec3f(1,1,1) );
		vacc.addElement<amino::Math::vec3f>( tindex, amino::Math::vec3f(100,100,100) );
		// update the tile
		vacc.update();
	}
	\endcode
	*/
	template< typename T>
	void addElement( const TreeIndex& index, const T& value );
};

}
}

#endif // _BIFROST_TILEDATAACCESSOR_H_