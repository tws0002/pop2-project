//*****************************************************************************
/*!
   \file bifrost_component.h
   \brief Component class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_COMPONENT_H_
#define _BIFROST_COMPONENT_H_

#include "bifrostapi/bifrost_typebase.h"
#include "bifrostapi/bifrost_math.h"

namespace Bifrost {
namespace API {

class Layout;
class Status;
class Dictionary;

//*****************************************************************************
/*! \class Component bifrost_component.h
	\brief The %Component class. A component defines the tile tree topology itself, 
	the tile parameter scale, and the transform to world space. Components contain and 
	own channels which are defining the sample value in every voxel of every tile, the background value, 
	and the offset. %Component acts as the base class for specialized component classes
	such as VoxelComponent and PointComponent.

	Components are created with StateServer::createComponent and defined either as a voxel or 
	point (e.g. particle) component.

	\sa Channel
	\sa VoxelComponent
	\sa PointComponent
	\sa VoxelComponentType
	\sa PointComponentType
	\sa StateServer
 */
//*****************************************************************************

class BIFROST_API_DECL Component : public TypeBase
{
	public:
	/*! Default constructor. */
	Component();

	/*! Default destructor. */
	~Component();

	/*! Constructor. 
	*/
	Component(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Component(const Component& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Component object.
	*/
	Component& operator=(const Component& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Component object.
	*/
	Component& operator=(const Ref& ref);

	/*! Returns a transform matrix from tile space to world space.
	\return Similarity Transform matrix in world space.
	*/
	const Bifrost::Math::Similarity& world() const;

	/*! Returns an array of channels defined in this component.
	\return RefArray object.
	*/
	RefArray channels() const;

	/*! Returns an existing Channel that matches a name. Returned object is empty if the name doesn't match an entry in the component.
	\param name Name of the channel to find. 
	\return Reference to a %Channel.
	*/
	Ref findChannel( const String& name ) const;

	/*! Returns all channels stored in this component that match a data type. Returned array is empty if no match is found.
	\param type %Channel data type. 
	\return Reference to an array of %Channel.
	*/
	RefArray findChannelsByType( const DataType& type ) const;

	/*! Returns all channels stored in this component that match a type identifier. Returned array is empty if no match is found.
	\param type Type like \ref PointChannelType and \ref VoxelChannelType or any user-defined types added with \ref TypeBase.addType.
	\return Reference to an array of Channel.
	*/
	RefArray findChannelsByType( const TypeID& type ) const;

	/*! Returns the number of elements of this component for all depth levels. The definition of elements depends of the underlying type
	of the Component object. For instance, this method will	return the number of voxels defined on a voxel component or the number of 
	points (or particles) defined on a point component.
	\return size_t Number of elements.
	*/
	size_t elementCount() const;

	/*! Returns the number of elements of this component at a specific depth level.
	\param depth Depth level to get the element from.
	\return size_t Number of elements.
	*/
	size_t elementCount( size_t depth ) const;
	
	/*! Returns the number of elements at specific tile index. The number of elements is guaranteed to be the same for all channels of this 
	component.
	\param index Index of the tile to locate. 
	\return size_t Number of elements. 
	*/
	size_t elementCount( const TreeIndex& index ) const;
	
	/*! Sets the layout for this Component.
	\param layout Layout to set.
	\return Success if ok or Failure if the operation failed.
	*/
	Status setLayout( const Layout& layout );

	/*! Returns the layout for this Component.
	\return Reference to a Layout object.
	*/
	Ref layout() const;

	/*! Returns the object this component belongs to.
	\return Reference to an Object object.
	*/
	Ref object() const;

	/*! Returns the dictionary of this component.
	\return Dictionary object.
	*/
	Dictionary dictionary() const ;

};

}
}

#endif // _BIFROST_BASE_H_