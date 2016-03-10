//*****************************************************************************
/*!
   \file bifrost_object.h
   \brief Object class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_OBJECT_H_
#define _BIFROST_OBJECT_H_

#include "bifrostapi/bifrost_typebase.h"

namespace Bifrost {
namespace API {

class Status;
class Component;
class String;
class Dictionary;

//*****************************************************************************
/*! \class Object bifrost_object.h
	\brief The %Object class represents the top object in the %Bifrost object hierarchy. The %Object class
	is a container that can combine several named Component objects, each of which describes 
	how some of the data can be organized.

 */
//*****************************************************************************

class BIFROST_API_DECL Object : public TypeBase
{
	public:
	/*! Default constructor. */
	Object();

	/*! Default destructor. */
	~Object();

	/*! Constructor. 
	*/
	Object(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Object(const Object& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Object object.
	*/
	Object& operator=(const Object& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Object object.
	*/
	Object& operator=(const Ref& ref);

	/*! The type of this object which identifies the object content definition. This type is user-defined and has a different 
	meaning than the %API class type returned by Base::type.
	\return Object user-defined type.
	\sa StateServer::createObject
	*/
	TypeID userType( );

	/*! Returns the dictionary of this object.
	\return Dictionary object.
	*/
	Dictionary dictionary() const ;

	/*! Adds a component to this object. If the component is already part of another object, the component will be removed from it
	before being added to the underlying object. Use this method with care.
	\param comp %Component to add.
	\return Success if ok or Failure if the operation failed.
	*/
	Status addComponent( const Component& comp );

	/*! Removes a Component from this %Object. The component object is only removed from this object and still available in its state server.
	\param name Name of the component to remove.
	\return Success if ok or Failure if the operation failed.
	*/
	Status removeComponent( const String& name );

	/*! Returns the array of Components that belongs to this object.
	\return RefArray object.
	*/
	RefArray components() const;
	
	/*! Returns an existing Component that matches a name. Returned object is empty if the name doesn't match an entry in this %Object.
	\param name Name of the component to find. 
	\return Reference to a %Component.
	*/
	Ref findComponent( const String& name ) const;

	/*! Returns the components of this object that match a type identifier. Returned array is empty if no match is found.
	\param type Type such as ref PointComponentType, \ref ObjectDictionaryType and \ref VoxelComponentType or any user-defined types added with \ref TypeBase.addType.
	\return Reference to an array of %Component.
	*/
	RefArray findComponentsByType( const TypeID& type ) const;
};

}
}

#endif // _BIFROST_BASE_H_