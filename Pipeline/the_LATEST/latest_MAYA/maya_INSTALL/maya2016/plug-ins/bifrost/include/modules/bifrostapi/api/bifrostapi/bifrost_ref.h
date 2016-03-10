//*****************************************************************************
/*!
   \file bifrost_ref.h
   \brief Ref class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_REF_H_
#define _BIFROST_REF_H_

#include "bifrostapi/bifrost_types.h"
#include "bifrostapi/bifrost_const.h"
#include "bifrostapi/bifrost_string.h"

namespace Bifrost {
namespace API {

//*****************************************************************************
/*! \class Ref bifrost_ref.h
	\brief The %Ref class is used for encapsulating %Bifrost core objects. %Ref instances are attached to 
	%Bifrost %API classes for manipulating the %Bifrost core objects.	
	
	Each instance of a %Ref maintains a link with only one single object at a time, it cannot refer to multiple objects. 
	
	%Ref has no base or derived class hierarchy and only contains methods for accessing the type of the underlying %Bifrost 
	object.

	%Ref provides the core of the runtime type information (RTTI) system for performing type introspection on %Bifrost 
	objects. RTTI is used to determine if an object is of a specific type; for example, to ensure that the compatibility 
	between the reference and a given API class is valid by checking it against	an object TypeID. 
 */
//*****************************************************************************

class BIFROST_API_DECL Ref
{
	public:
	/*! Default constructor. */
	Ref();

	/*! Construct a Ref object from another Ref object.
	\param ref constant reference object.
	*/
	Ref( const Ref& ref );

	/*! Default destructor. */
	~Ref();

	/*! Assigns a Ref object to this one.
	\param ref A source reference object
	\return A new reference object.
	*/
	Ref& operator = (const Ref& ref);

	/*! Returns true if the object is valid.
	\return True if valid, false otherwise.
	*/
	bool valid() const;

	/*! Bool operator returning true if the object is valid or false otherwise.
	\return true if valid; false otherwise.
	*/
	operator bool() const;

	/*! Equality operator
	\param obj API class object to compare.
	\return true if both API class objects are identical, false otherwise.
	*/
	bool operator == ( const Ref& obj ) const;

	/*! Inequality operator
	\param obj API class object to compare.
	\return true if the objects are not identical, false otherwise.
	*/
	bool operator != ( const Ref& obj ) const;

	/*! Returns the type of the API class.
	\return The class type.
	*/
	TypeID type() const;

	/*! Returns true if a given class type is compatible with this API class.
	\param type Class type.
	\return True if the class is compatible, false otherwise.
	*/
	bool isA( const TypeID& type ) const;

	/*! This will detach the referenced object and invalidate this Ref object. The referenced object is not deleted nor 
	destroyed.
	*/
	void reset( );

	private:
	void* _ptr;
};

}
}

#endif // _BIFROST_REF_H_