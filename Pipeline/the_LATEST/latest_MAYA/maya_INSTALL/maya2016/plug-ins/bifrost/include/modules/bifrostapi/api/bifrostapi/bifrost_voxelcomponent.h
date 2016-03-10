//*****************************************************************************
/*!
   \file bifrost_voxelcomponent.h
   \brief VoxelComponent class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_VOXELCOMPONENT_H_
#define _BIFROST_VOXELCOMPONENT_H_

#include "bifrostapi/bifrost_component.h"

namespace Bifrost {
namespace API {


//*****************************************************************************
/*! \class VoxelComponent bifrost_voxelcomponent.h
	\brief %VoxelComponent is a specialized class for voxel component types.

	\sa Component
	\sa VoxelChannel
	\sa VoxelComponentType
	\sa StateServer
*/
//*****************************************************************************

class BIFROST_API_DECL VoxelComponent : public Component
{
	public:
	/*! Default constructor. */
	VoxelComponent();

	/*! Default destructor. */
	~VoxelComponent();

	/*! Constructor. 
	*/
	VoxelComponent(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	VoxelComponent(const VoxelComponent& obj);

	/*! Constructor.
	\param obj constant Component class object.
	*/
	VoxelComponent(const Component& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Component object.
	*/
	VoxelComponent& operator=(const VoxelComponent& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Component object.
	*/
	VoxelComponent& operator=(const Ref& ref);

	/*! Creates an object from another component. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %VoxelComponent object.
	*/
	VoxelComponent& operator=(const Component& obj);

	/*! Convert from tile coordinates to world coordinates at a given offset and depth.
	\return Point in world space coordinates.
	*/
    amino::Math::vec3f toWorldSpace( const amino::Math::vec3f& tileCoord, VoxelOffsetType offsetType=Center, TreeIndex::Depth depth=0) const;

	/*! Convert from world coordinates to tile coordinates at a given offset and depth.
	\return Point in tile space coordinates.
	*/
    amino::Math::vec3f toTileSpace( const amino::Math::vec3f& worldCoord, VoxelOffsetType offsetType=Center, TreeIndex::Depth depth=0) const;
};

}
}

#endif // _BIFROST_BASE_H_