//*****************************************************************************
/*!
   \file bifrost_voxelchannel.h
   \brief VoxelChannel class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_VOXELCHANNEL_H_
#define _BIFROST_VOXELCHANNEL_H_

#include "bifrostapi/bifrost_channel.h"

namespace Bifrost {
namespace API {

class VoxelSampler;

//*****************************************************************************
/*! \class VoxelChannel bifrost_voxelchannel.h
	\brief The %VoxelChannel class represents a voxel channel. Voxel channels are owned by VoxelComponentType 
	components and store voxel data per tile. Voxel data can be accessed through the TileData class. The number of elements 
	in each tile is fixed. 

	\code
	// Create a voxel channel object.
	#include <bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_voxelchannel.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_const.h>
	#include <iostream>

	Bifrost::API::ObjectModel om;
	Bifrost::API::StateServer ss = om.createStateServer();

	// VoxelChannels need a parent voxel component 
	Bifrost::API::Component vcomp = ss.createComponent( Bifrost::API::VoxelComponentType, "volume" );

	// Create a channel of type FloatV3 
	Bifrost::API::VoxelChannel ch = ss.createChannel( vcomp, Bifrost::API::FloatV3Type, "density" );

    std::cout << "channel: " << ch.name() << std::endl;        
    std::cout << "type: " << ch.type() << std::endl;      
    std::cout << "stride: " << ch.stride() << std::endl;      
	std::cout << "arity: " << ch.arity() << std::endl;      
	std::cout << "type size: " << ch.typeSize() << std::endl;      
    std::cout << "elements: " << ch.elementCount() << std::endl;
	std::cout << "offset type: " << ch.offsetType() << std::endl;
	amino::Math::vec3f v = ch.offsetValue();
	std::cout << "offset value: " << v[0] << ", " << v[1] << ", " << v[2] << std::endl;
	\endcode

	\sa VoxelComponent
 */
//*****************************************************************************

class BIFROST_API_DECL VoxelChannel : public Channel
{
	public:
	/*! Default constructor. */
	VoxelChannel();

	/*! Default destructor. */
	~VoxelChannel();

	/*! Constructor. 
	*/
	VoxelChannel(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	VoxelChannel(const VoxelChannel& obj);

	/*! Copy constructor.
	\param obj constant Channel class object.
	*/
	VoxelChannel(const Channel& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %VoxelChannel object.
	*/
	VoxelChannel& operator=(const VoxelChannel& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new %VoxelChannel object.
	*/
	VoxelChannel& operator=(const Ref& ref);

	/*! Creates an object from another %Channel. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %VoxelChannel object.
	*/
	VoxelChannel& operator=(const Channel& obj);

	/*! Returns the location within a tile where samples are stored. The return value can be one of eight offset types described 
	by Bifrost::API::VoxelOffsetType.
	\return Offset value for this channel. 
	*/
	amino::Math::vec3f offsetValue( ) const;

	/*! Sets the voxel offset type. The type can be one of eight offset types described with Bifrost::API::VoxelOffsetType.
	\return Status::Success if the operation succeeded or Status::Failure otherwise. 
	*/
	Status setOffsetType( VoxelOffsetType offsetType );

	/*! Returns the location within a tile where samples are stored. The return value can be 
	one of eight offset types described with Bifrost::API::VoxelOffsetType.
	\return Offset type for this channel. 
	*/
	VoxelOffsetType offsetType( ) const;
	
	/*! Creates a sampler object for this channel. Samplers are used for computing a value at a location in 3D space at 
	the finest depth possible. VoxelSampler objects can only be created on voxel channels of type FloatType or FloatV3Type.
	\param samplerType The type of sampler to create. The following samplers are supported in %Bifrost:
	\li Bifrost::API::VoxelSamplerLinearType
	\li Bifrost::API::VoxelSamplerQBSplineType
	\li Bifrost::API::VoxelSamplerWENOType

	\param space The sampler space used for interpolating the value.
	\return A reference to the newly created %VoxelSampler object. The returned object is empty if the channel type is different than
	FloatType or FloatV3Type.
	*/
	Ref createSampler( const TypeID& samplerType, SamplerSpace space ) const;
};

}
}

#endif // _BIFROST_VOXELCHANNEL_H_