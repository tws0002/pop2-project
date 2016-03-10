//*****************************************************************************
/*!
   \file bifrost_om.h
   \brief ObjectModel class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_OM_H_
#define _BIFROST_OM_H_

#include "bifrostapi/bifrost_base.h"

/*! \namespace Bifrost
	\brief The %Bifrost namespace defines a region where all classes, types, functions and other
	identifiers are declared in the %Bifrost system. Namespaces are used to prevent global namespace 
	pollution and name clashing.

	Members of the %Bifrost namespace can be identified explicitly with the symbol %Bifrost for code clarity. 
	To simplify the code however, namespace members can be referenced without the namespace symbol by using the 
	C++ 'using' directive.

	Namespaces can also be nested. For instance, all API classes defined in %Bifrost are assigned to 
	the Bifrost::API::API namespace. 

	Demonstrates the use of namespace
	\code
		// namespace qualification
		Bifrost::API::Object myObj;

		// Object referenced without explicit qualification
		using namespace Bifrost::API::API;
		Object myObj;
	\endcode
*/
namespace Bifrost {

/*! \namespace API
	\brief The %API namespace defines a region where all %API classes are declared in %Bifrost.
*/

namespace API {

class StateServer;
class Context;
class Status;
class String;

//*****************************************************************************
/*! \class ObjectModel bifrost_om.h
	\brief The %ObjectModel class represents the running instance of the %Bifrost %Object Model
	and it is the top most entity of the %Bifrost C++ object hierarchy. %ObjectModel gives access
	to state servers and other objects defined in Bifrost.

	For example, you can create an empty StateServer by calling ObjectModel::createStateServer or 
	create a FileIO object to load a BIF file. StateServer objects are created with an identifier 
	(\ref StateID) and are kept in an internal cache for later use. These identifiers can 
	be used to retrieve existing state server objects by calling ObjectModel::stateServer.

	Unlike most other %Bifrost %API objects, it is not necessary to intialize an %ObjectModel object based 
	on a Ref object. As soon as you create this object is it ready for use, as shown in the example below.

	\code
	// Create a state server and add a new object.
	#include <bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_object.h>
	#include <bifrostapi/bifrost_array.h>
	#include <iostream>

	Bifrost::API::ObjectModel om;
	Bifrost::API::StateServer ss = om.createStateServer();
	Bifrost::API::Object obj = ss.createObject("MyObjectType", "MyObjectName");
	std::cout << "Object Name: " << obj.name() << std::endl;
	std::cout << "Object is a kind of MyObjectType: " << obj.isA("MyObjectType") << std::endl;
	std::cout << "Object count: " << ss.objects().size() << std::endl;
	\endcode
	\sa StateServer
 */
//*****************************************************************************

class BIFROST_API_DECL ObjectModel : public Base
{
	public:
	/*! Default constructor. */
	ObjectModel();

	/*! Default destructor. */
	~ObjectModel();

	/*! Constructor. It is not normally necessary to use this version of the constructor,
	because the default constructor also produces an initialized %ObjectModel object.
	\param ref constant reference object.
	*/
	ObjectModel(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	ObjectModel(const ObjectModel& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %ObjectModel object.
	*/
	ObjectModel& operator=(const ObjectModel& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new ObjectModel object.
	*/
	ObjectModel& operator=(const Ref& ref);

	///@{ \name State server
	/*! Creates and returns a new StateServer object.
	\return Reference to a %StateServer.
	*/
	Ref createStateServer( ) const;

	/*! Creates a %StateServer object from a persistent identifier. 
	\param identifier %StateServer persistent identifier.
	\return Reference to a %StateServer initialized from a persistent identifier. The method returns an empty %StateServer object if the identifier is invalid or unknown.
	*/
	Ref createStateServer( const PersistID& identifier ) const;

	/*! Invalidates a state server and removes it from the internal cache.
	<b>Note:</b> Other StateServer objects pointing to the same state server identifier will also become invalid.
	\param server StateServer object to delete.
	\return Status::Success if the operation succeeded or Status::Failure otherwise.
	*/
	Status removeStateServer( StateServer& server ) const;

	/*! Invalidates a state server and removes it from the internal cache.
	<b>Note:</b> Other StateServer objects pointing to the same state server identifier will also become invalid.
	\param identifier StateID of the state server to remove.
	\return Status::Success if the operation succeeded or Status::Failure otherwise.
	*/
	Status removeStateServer( const StateID& identifier ) const;

	/*! Returns an existing StateServer object from an identifier.
	\param identifier %StateServer identifier.
	\return Reference to a %StateServer.
	*/
	Ref stateServer( const StateID& identifier ) const;
	///@}

	///@{ \name Context
	/*! Creates a new context object.
	\return A reference to a new context.
	*/
	Ref createContext() const;

	/*! Returns the runtime context for the current evaluation as set with ObjectModel::bindRuntimeContext.
	\return The current runtime context.
	*/
	Ref runtimeContext() const;

	/*! Associates a context to the current thread. This method is typically used during the setup phase of an evaluation.
	\param context The context to bind.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status bindRuntimeContext( const Context& context );

	/*! Unbind the current runtime context from this thread. Call this method when the runtime context is no longer needed.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status unbindRuntimeContext( ) const;
	///@}

	/*! This method is used for creating a FileIO object for loading an %BIF file or saving a Component object.
	\param filename The %BIF file name of the %FileIO object to create. For save operations, frame padding can be optionally specified 
	in the filename with symbols like @ and #. The symbol # is a shortcut for @@@@@@@@. See \ref File::resolveFramePadding for examples 
	about how to specify frame symbols in a file path. 

	\return Reference to a %FileIO.
	*/
	Ref createFileIO( const String& filename ) const;
	
	/*! Returns the version number of the %Bifrost %Object Model library %API. The format of the version information is {ReleaseNumber}.{UpdateNumber}.
	Both ReleaseNumber and UpdateNumber contain numeric characters. 

	This method is typically used at run-time for versioning control. For compile-time versioning control see \ref BIFROST_VERSION.
	\return Version number.
	*/
	String version( ) const;
};

}
}

#endif // _BIFROST_OM_H_