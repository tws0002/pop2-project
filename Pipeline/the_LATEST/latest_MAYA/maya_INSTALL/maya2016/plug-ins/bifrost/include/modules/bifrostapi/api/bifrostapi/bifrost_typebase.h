//*****************************************************************************
/*!
   \file bifrost_typebase.h
   \brief TypeBase class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_TYPEBASE_H_
#define _BIFROST_TYPEBASE_H_

#include "bifrostapi/bifrost_base.h"

namespace Bifrost {
namespace API {

class Status;

//*****************************************************************************
/*! \class TypeBase bifrost_typebase.h
	\brief The %TypeBase class provides services to Bifrost objects, such as Channel 
	and Component, for managing multiple types. 

	%TypeBase enables object categorization based on user-defined and Bifrost standard types. For 
	instance, one could use these types for querying channels with \ref Component.findChannelsByType or 
	for performing type introspection with \ref Base.isA.

	%TypeBase is designed as a base class and cannot be used as a standalone object like 
	%Channel or a %Layout.
 */
//*****************************************************************************

class BIFROST_API_DECL TypeBase : public Base
{
	public:
	/*! Default constructor. */
	TypeBase();

	/*! Default destructor. */
	~TypeBase();

	/*! Constructor. 
	*/
	TypeBase(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	TypeBase(const TypeBase& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %TypeBase object.
	*/
	TypeBase& operator=(const TypeBase& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new TypeBase object.
	*/
	TypeBase& operator=(const Ref& ref);

	/*! Adds a new type to this instance. 
	\param type New type.
	\return Returns Status::Success if the operation was successful or Status::Failure if the type to add already exists. 
	*/
	Status addType( const TypeID& type );

	/*! Remove a type from this instance. Types defined by Bifrost, such as VoxelChannelType and LayoutType, cannot be removed.
	\param type Type to remove.
	\return Returns Status::Success if the operation was successful or Status::Failure if the type doesn't exists or if it's a Bifrost defined type. 
	*/
	Status removeType( const TypeID& type );

	/*! Clears all types added to this object.
	\return Array of types.
	*/
	void clearTypes();

};

}
}

#endif // _BIFROST_TYPEBASE_H_