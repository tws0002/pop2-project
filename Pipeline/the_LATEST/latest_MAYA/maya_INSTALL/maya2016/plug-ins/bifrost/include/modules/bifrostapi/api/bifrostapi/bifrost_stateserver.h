//*****************************************************************************
/*!
   \file bifrost_stateserver.h
   \brief StateServer class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_STATESERVER_H_
#define _BIFROST_STATESERVER_H_

#include "bifrostapi/bifrost_base.h"

namespace Bifrost {
namespace API {

class Component;
class String;
class Status;
class Layout;
class Dictionary;

//*****************************************************************************
/*! \class StateServer bifrost_stateserver.h
	\brief The %StateServer class. The %Bifrost State Server is a specialized storage 
	service. It provides ways of creating, retrieving and deleting %Bifrost objects such 
	as Channel and Layout objects. %StateServer objects are created via the ObjectModel %API class. 
	
	The StateServer has 2 main services: 
	\li Factory for creating objects.
	\li Central object repository for storing and accessing objects.
		
	\code
	// The following demonstrates the use of the StateServer class to create %Bifrost objects such as Channels and Layouts.
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_object.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_pointchannel.h>
	#include <bifrostapi/bifrost_voxelchannel.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_status.h>

	using namespace Bifrost::API;

	// Create a StateServer object. 
	ObjectModel om;
	StateServer ss = om.createStateServer( );
	
	// Create an instance of type Object.
	Object object = ss.createObject( "MyObjectType", "MyObject" );

	// Create an instance of type Layout.
	Layout layout = ss.createLayout( "MyLayout" );

	// Create an instance of type Point component.
	Component point = ss.createComponent( PointComponentType, "MyPoint", layout );

	// Add component 'MyPoint' to object 'MyObject
	object.addComponent( point );

	// Create an instance of type Voxel component.
	Component voxel = ss.createComponent( VoxelComponentType, "MyVoxel", layout );

	// Add component 'MyVoxel' to object 'MyObject
	object.addComponent( voxel );

	// Create an instance of type Channel FloatV3Type parented to a point component.
	PointChannel v3fch = ss.createChannel( point, FloatV3Type, "MyV3FloatChannel" );

	// Create an instance of type Channel FloatType parented to a voxel component.
	VoxelChannel fch = ss.createChannel( voxel, FloatType, "MyFloatChannel" );
	\endcode

	\sa ObjectModel::createStateServer
	\sa ObjectModel::stateServer
 */
//*****************************************************************************

class BIFROST_API_DECL StateServer : public Base
{
	public:
	/*! Default constructor. */
	StateServer();

	/*! Default destructor. */
	~StateServer();

	/*! Constructor. 
	*/
	StateServer(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	StateServer(const StateServer& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %StateServer object.
	*/
	StateServer& operator=(const StateServer& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new %StateServer object.
	*/
	StateServer& operator=(const Ref& ref);

	///@{ \name State server
	/*! Returns the state server identifier. This identifier represents the state server in the current Bifrost process.
	\return StateServer identifier. Returns -1 if the state server is invalid.
	*/
	StateID stateID( ) const;

	/*! Returns the state server persistent identifier. This identifier is a long-lasting reference to a state server object.
	\return StateServer persistent identifier.
	/sa StateServer Bifrost::API::ObjectModel::createStateServer( const PersistID& identifier ) const
	*/
	PersistID persistID( ) const;

	/*! Join the content of an existing StateServer to this state server. Duplicates of the source components and channels are 
	not merged and simply ignored. Target layouts are overwritten with the source ones if there is a name match.
	\param source State server to merge in.
	\return Success if ok or Failure if the operation failed.
	*/
	Status merge( const StateServer& source );

	/*! Returns the dictionary of this state server.
	\return Dictionary object.
	*/
	Dictionary dictionary() const ;
	///@}

	///@{ \name Creation
	/*! Creates a new object. The new object is stored in this %StateServer.
	\param typeID User-defined Object type.
	\param name Name of the new object. 
	\return Reference to an %Object.
	*/
	Ref createObject( const TypeID& typeID, const String& name );

	/*! Creates a new object. The new object is stored in this %StateServer.
	\param name Name of the new object. Defaults to the type id if omitted.
	\return Reference to a %Layout.
	*/
	Ref createLayout( const String& name );

	/*! Creates a channel of a given data type for the input component. The new channel is created with its parent component type.
	\param component Component parent.
	\param dataType Channel data type.
	\param name Name of the new channel. 
	\return Reference to a %Channel.
	*/
	Ref createChannel( const Component& component, const DataType& dataType, const String& name );

	/*! Creates a new Component object of a specific base type. The new component is stored in this %StateServer and added 
	to a layout supplied by the caller.
	\param typeID Base component type such as Bifrost::API::PointComponentType and Bifrost::API::VoxelComponentType.
	\param name Name of the new component to create. 
	\param layout Layout for the new component to create. 
	\return Reference to a %Component.
	*/
	Ref createComponent( const TypeID& typeID, const String& name, const Layout& layout );

	/*! Creates a new Component object of a specific base type. The new component is stored in this %StateServer.
	
	This version creates a layout for the new component. The new layout is created with the name: "component name" + "_layout". 
	You can accessed the new layout with Component::layout to rename it with a name of your own. 
	
	\param typeID Base component type such as Bifrost::API::PointComponentType and Bifrost::API::VoxelComponentType.
	\param name Name of the new component to create. 
	\param voxelScale An optional voxel scale factor for the new layout to create. Default is 0.5f.
	\return Reference to a %Component.
	*/
	Ref createComponent( const TypeID& typeID, const String& name, float voxelScale=0.5f );

	///@}

	///@{ \name Deletion
	/*! Removes an Object from this state server.
	\param name Name of the object to remove.
	\return Success if ok or Failure if the operation failed.
	*/
	Status removeObject( const String& name );

	/*! Removes a Layout from this state server.
	\param name Name of the layout to remove.
	\return Success if ok or Failure if the operation failed.
	*/
	Status removeLayout( const String& name );

	/*! Removes a Component from this state server.
	\param name String representing the component to remove. The string can be either the name, the partial path or the full path name of a 
	component.
	\return Success if ok or Failure if the operation failed.
	\sa Component::Name
	\sa Component::partialPathName
	\sa Component::fullPathName
	*/
	Status removeComponent( const String& name );

	/*! Removes all components owned by a specific object from this state server. All channels owned by the components to remove are also removed.
	\param name Object name owner.
	\return Success if ok or Failure if the operation failed.
	*/
	Status removeComponents( const String& name );

	/*! Removes a Channel from this state server.
	\param name String representing the channel to remove. The string can be either the name, the partial path or the full path name of a 	channel.	\return Success if ok or Failure if the operation failed.
	\sa Channel::Name
	\sa Channel::partialPathName
	\sa Channel::fullPathName
	*/
	Status removeChannel( const String& name );

	/*! Removes all channels owned by a specific component from this state server.
	\param name Component name owner.
	\return Success if ok or Failure if the operation failed.
	*/
	Status removeChannels( const String& name );

	/*! Remove all entries in this state server storage. This method will invalidate existing API objects that are referencing 
	the objects stored in the state server.
	\return Success if ok or Failure if the operation failed.
	*/
	Status clear( );
	///@}

	///@{ \name Search
	/*! Returns an existing Channel matching a name representing a channel. Returned object is empty if the name doesn't match an entry in 
	the state server.
	\param name String representing the channel to find. The string can be either the name, the partial path or the full path name of a channel.	\return Reference to a %Channel.
	\sa Channel::Name
	\sa Channel::partialPathName
	\sa Channel::fullPathName
	*/
	Ref findChannel( const String& name ) const;

	/*! Returns an existing Component matching a name representing a component. Returned object is empty if the name doesn't match an entry in 
	the state server.
	\param name String representing the name of the component to find. 	\return Reference to a %Component.
	\sa Component::Name
	*/
	Ref findComponent( const String& name ) const;

	/*! Returns an existing Object that matches a name. Returned object is empty if the name doesn't match an entry in the state server.
	\param name Name of the object to find. 
	\return Reference to an %Object.
	*/
	Ref findObject( const String& name ) const;

	/*! Returns an existing Layout that matches a name. Returned object is empty if the name doesn't match an entry in the state server.
	\param name Name of the layout to find. 
	\return Reference to a %Layout.
	*/
	Ref findLayout( const String& name ) const;

	/*! Returns all objects stored in this state server that match a type identifier. Returned array is empty if no match is found.
	\param type %Object type identifier as specified with \ref createObject or any user-defined types added with \ref TypeBase.addType.
	\return Reference to an array of Object.
	*/
	RefArray findObjectsByType( const TypeID& type ) const;

	/*! Returns all components stored in this state server that match a type identifier. Returned array is empty if no match is found.
	\param type Component type such as \ref PointComponentType, \ref ObjectDictionaryType and \ref VoxelComponentType or any user-defined types 
	added with \ref TypeBase.addType.
	\return Reference to an array of Component.
	*/
	RefArray findComponentsByType( const TypeID& type ) const;

	/*! Returns all channels stored in this state server that match a type identifier. Returned array is empty if no match is found.
	\param type %Channel type such as \ref PointChannelType and \ref VoxelChannelType or any user-defined types added with \ref TypeBase.addType.
	\return Reference to an array of Channel.
	*/
	RefArray findChannelsByType( const TypeID& type ) const;

	/*! Returns all channels stored in this state server that match a data type. Returned array is empty if no match is found.
	\param type %Channel data type. 
	\return Reference to an array of Channel.
	*/
	RefArray findChannelsByType( const DataType& type ) const;

	/*! Returns all layouts stored in this state server that match a type identifier. Returned array is empty if no match is found.
	\param type Any user-defined types added with \ref TypeBase.addType.
	\return Reference to an array of Layout.
	*/
	RefArray findLayoutsByType( const TypeID& type ) const;

	///@}

	///@{ \name Arrays
	/*! Returns an array of all components stored in this state server. 
	\return Array of Component references.
	*/
	RefArray components( ) const;

	/*! Returns an array of all objects stored in this state server. 
	\return Array of Object references.
	*/
	RefArray objects( ) const;

	/*! Returns an array of all channels stored in this state server. 
	\return Array of Channel references.
	*/
	RefArray channels( ) const;

	/*! Returns an array of all layouts stored in this state server. 
	\return Array of Layout references.
	*/
	RefArray layouts( ) const;

	///@}
};

}
}

#endif // _BIFROST_BASE_H_