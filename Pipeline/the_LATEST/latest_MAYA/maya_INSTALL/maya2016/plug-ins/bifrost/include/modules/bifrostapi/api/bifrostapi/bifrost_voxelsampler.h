//*****************************************************************************
/*!
   \file bifrost_voxelsampler.h
   \brief VoxelSampler class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_VOXELSAMPLER_H_
#define _BIFROST_VOXELSAMPLER_H_

#include "bifrostapi/bifrost_base.h"
#include "bifrostapi/bifrost_math.h"

namespace Bifrost {
namespace API {

//*****************************************************************************
/*! \class VoxelSampler bifrost_voxelsampler.h
	\brief The VoxelSampler class represents a sampler in %Bifrost. Samplers are 
	used for computing a value at a location in 3D space at	the finest depth possible. 
	
	%Bifrost supports the following sampler types:
	\li Bifrost::API::VoxelSamplerLinearType
	\li Bifrost::API::VoxelSamplerQBSplineType
	\li Bifrost::API::VoxelSamplerWENOType
	
	The following shows how to use the VoxelSampler class. The example iterates over a tile tree to update channel positions.
	\code
	#include <bifrostapi/bifrost_voxelchannel.h>
	#include <bifrostapi/bifrost_voxelsampler.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_tileiterator.h>
	#include <bifrostapi/bifrost_tiledataaccessor.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_tile.h>
	#include <bifrostapi/bifrost_array.h>

	using namespace Bifrost::API;
	
	// load the BIF files for this example
	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ssp = fileio.load( );

	fileio.setFilename("volumes.bif");
	StateServer ssv = fileio.load( );
	if ( ssp && ssv ) {
		// Get the layout for iterating the tree (note: the example assumes that layout is the same for both state servers)
		RefArray layouts = ssp.layouts();
		Layout layout = layouts[0];

		// The component that holds the position channel we want to process
		RefArray components = ssp.components();
		Component pcomp = components[0];

		// The channel to process
		Channel position = ssp.findChannel("voxel_liquid-particle/position");
		VoxelChannel distance = ssv.findChannel("voxel_liquid-volume/distance");

		// create the objects and data we need for computation
		VoxelSampler distanceSampler = distance.createSampler( VoxelSamplerLinearType, SamplerSpace::WorldSpace );
		const Bifrost::Math::Similarity& world = pcomp.world();
		const float dx = layout.voxelScale();
		const float dxInv = 1.0f/dx;

		// start iterating the tile tree
		TileDataAccessor posAccessor = position.tileDataAccessor();
		TileIterator it = layout.tileIterator( TraversalMode::BreadthFirst );

		while (it) {
			const Bifrost::API::Tile& tile = *it;

			// update the positions with sampled values
			TileData<amino::Math::vec3f> pos = posAccessor.tileData<amino::Math::vec3f>( tile.index() );
			for ( size_t i=0; i<pos.count(); i++ ) {
				amino::Math::vec3f wp = world.apply( dx * pos[i]);			

				float dist = distanceSampler.sample<float>(wp);
				amino::Math::vec3f normal;
				distanceSampler.sampleGradient<float>( wp, normal );
				wp -= normal * dist;

				// update the position
				pos[i] = dxInv * world.inverseApply( wp );
			}
			++it;
		}
	}
	\endcode
	\sa Bifrost::API::VoxelChannel::createSampler

 */
//*****************************************************************************
class BIFROST_API_DECL VoxelSampler : public Base
{
	public:

	/*! Default constructor. */
	VoxelSampler();

	/*! Default destructor. */
	~VoxelSampler();

	/*! Constructor. 
	*/
	VoxelSampler(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	VoxelSampler(const VoxelSampler& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %VoxelSampler object.
	*/
	VoxelSampler& operator=(const VoxelSampler& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new VoxelSampler object.
	*/
	VoxelSampler& operator=(const Ref& ref);

	/*! Returns the data type of this sampler as specified by the source channel.
	\return Type of data this sampler supports.
	*/
	DataType dataType() const;

	/*! Returns the sampled value at a given surface location.
	\param location Location on the surface to sample from..
	\return T Sampled value. 
	\tparam T Specify the type of the value to sample.
	*/
	template < typename T >
    T sample( const amino::Math::vec3f& location ) const;

	/*! Returns the sampled gradient value at a given surface location.
	<br><b>Note:</b> sampleGradient is not supported for Bifrost::API::VoxelSamplerWENOType. Calling sampleGradient on a WENO
	sampler is unpredicted. 
	\param location Location on the surface to sample from.
	\param gradient The gradient used by the sampler to sample the value. 
	\return Sampled value. 
	\tparam T Specify the type of the value to sample.
	*/
	template < typename T >
    T sampleGradient(const amino::Math::vec3f& location, amino::Math::vec<3,T>& gradient ) const;
};

}
}

#endif // _BIFROST_VOXELSAMPLER_H_