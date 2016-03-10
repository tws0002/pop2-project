//*****************************************************************************
/*!
   \file bifrost_pointchannel.h
   \brief PointChannel class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_POINTCHANNEL_H_
#define _BIFROST_POINTCHANNEL_H_

#include "bifrostapi/bifrost_channel.h"

namespace Bifrost {
namespace API {

class TileDataAccessor;

//*****************************************************************************
/*! \class PointChannel bifrost_pointchannel.h
	\brief The %PointChannel class represents a point channel. Point channels are owned by components of type PointComponentType.
	Like voxel channels, point channels stores data per tile which can be accessed through the TileData class. But unlike
	voxel channels, the number of elements in each tile of a point channels can varied. The elements of a point channel tile
	can be manipulated with the Bifrost::API::TileDataAccesor class.

	\code
	// Create a point channel object.
	#include <bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_pointchannel.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_const.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	StateServer ss = om.createStateServer();

	// Channels need a parent component 
	Component pcomp = ss.createComponent( PointComponentType, "point" );

	// Create a channel of type FloatV3 with a point component parent
	PointChannel ch = ss.createChannel( pcomp, FloatV3Type, "position" );

    std::cout << "channel: " << ch.name() << std::endl;        
    std::cout << "type: " << ch.type() << std::endl;      
    std::cout << "stride: " << ch.stride() << std::endl;      
	std::cout << "arity: " << ch.arity() << std::endl;      
	std::cout << "type size: " << ch.typeSize() << std::endl;      
    std::cout << "elements: " << ch.elementCount() << std::endl;
	\endcode

	\sa PointComponent
 */
//*****************************************************************************

class BIFROST_API_DECL PointChannel : public Channel
{
	public:
	/*! Default constructor. */
	PointChannel();

	/*! Default destructor. */
	~PointChannel();

	/*! Constructor. 
	*/
	PointChannel(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	PointChannel(const PointChannel& obj);

	/*! Constructor.
	\param obj constant Channel class object.
	*/
	PointChannel(const Channel& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %PointChannel object.
	*/
	PointChannel& operator=(const PointChannel& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new %PointChannel object.
	*/
	PointChannel& operator=(const Ref& ref);

	/*! Creates an object from another %Channel. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %PointChannel object.
	*/
	PointChannel& operator=(const Channel& obj);

	/*! Returnes a tile data accessor for this channel. 
	\return TileDataAccessor object. 
	*/
	TileDataAccessor tileDataAccessor( ) const;
};

}
}

#endif // _BIFROST_POINTCHANNEL_H_