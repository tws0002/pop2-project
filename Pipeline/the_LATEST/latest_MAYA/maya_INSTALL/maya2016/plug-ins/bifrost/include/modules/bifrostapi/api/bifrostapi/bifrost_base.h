//*****************************************************************************
/*!
   \file bifrost_base.h
   \brief Base class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_BASE_H_
#define _BIFROST_BASE_H_

#include "bifrostapi/bifrost_types.h"
#include "bifrostapi/bifrost_ref.h"

namespace Bifrost {
namespace API {

class String;

//*****************************************************************************
/*! \class Base bifrost_base.h
	\brief %Base is a base class used for accessing %Bifrost core objects through generic %Ref objects. %Base supports a runtime 
	type information sytem (RTTI) and %Ref attachment support for %API classes. The RTTI is a mechanism that allows %API classes 
	to determine the type of reference objects during program execution.

	The %API classes must be attached to compatible %Ref objects in order to operate on %Bifrost objects. A %Ref object can only 
	map to one %Bifrost object at a time, and an %API class can only have one %API class type. However, a %Ref object can be 
	compatible with many %API classes. This compatibility model follows the hierarchy class, thus a %Ref object of type 
	VoxelChannelType would be compatible with ChannelType but not with PointChannelType.

	%Ref objects expose the following functions for querying its underlying object class type and to determine its
	compatibility with a given %API class: Ref::type and Ref::isA.

	%Base provides functions similar to %Ref to determine if an %API class is compatible with a given %Bifrost %API
	type or a specific %Ref instance.

	Most of the %API classes derive from %Base class. The virtual Base::isA and Base::type functions are implemented by the derived 
	classes.	
	
	Additionnally, %API classes can also accept any kind of objects without knowing how to operate on it. In such a case if a %Ref
	object used to construct an %API class is incompatible, then the %API class will be put in an invalid state and all its functions 
	would return an error.

 */
//*****************************************************************************

class BIFROST_API_DECL Base
{
	public:
	/*! Default constructor. */
	Base();

	/*! Construct a %Base object from a %Ref object. 
	\param ref A reference object.
	*/
	Base( const Ref& ref );

	/*! Default destructor. */
	virtual ~Base();

	/*! Returns the type of the %API class.
	\return The class type.
	*/
	TypeID type() const;

	/*! Returns true if a given class type is compatible with this %API class.
	\param type Class type.
	\return True if the class is compatible, false otherwise.
	*/
	bool isA( const TypeID& type ) const;

	/*! Returns the name of the underlying object.
	\return The object name.
	*/
	String name() const;

	/*! Sets the name of the underlying object.
	\param name %String name.
	*/
	void setName( const String& name );

	/*! Resets this %API object by invalidating its %Ref object.
	*/
	void reset();

	/*! Returns true if the object is valid.
	\return True if valid, false otherwise.
	*/
	bool valid() const;

	/*! Bool operator returning true if the object is valid or false otherwise.
	\return true if valid; false otherwise.
	*/
	operator bool() const;

	/*! Returns the %Base's reference object (%Ref).
	\return A reference to a %Ref object.
	*/
	const Ref& ref() const;

	/*! Converts from %Base to its reference object (%Ref).
	\return A reference to a %Ref object.
	*/
	operator const Ref&() const;

	/*! Equality operator
	\param obj %API class object to compare.
	\return true if both %API class objects are identical, false otherwise.
	*/
	bool operator == ( const Base& obj ) const;

	/*! Inequality operator
	\param obj %API class object to compare.
	\return true if the objects are not identical, false otherwise.
	*/
	bool operator != ( const Base& obj ) const;

	protected:
	void ptr( void* p );
	void ref( const Ref& ref );
	void* ptr(void) const;

	private:
	Base & operator=( const Base & );

	Ref _ref;
};

}
}

#endif // _BIFROST_BASE_H_