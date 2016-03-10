//*****************************************************************************
/*!
   \file bifrost_status.h
   \brief Status class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_STATUS_H_
#define _BIFROST_STATUS_H_

#include "bifrostapi/bifrost_types.h"

namespace Bifrost {
namespace API {
//*****************************************************************************
/*! \class Status bifrost_status.h
	\brief Encapsulates status types for error handling purpose. The class also
	exposes methods to query and set the error code.
 */
//*****************************************************************************

class BIFROST_API_DECL Status
{
	public:
	//! Error code enumerator.
	enum Code
	{
		Success = 0,				/*!< Success */
		Failure = -1				/*!< Failure */
	} ;

	/*! Constructs a status object from a given error code.
	\param code Error code
	*/
	Status(Code code=Success);

	/*! Returns the underlying error code.
	\return Error code
	*/
	Code code() const;

	/*! Returns true if the status is Success .
	\return true if Success or false otherwise.
	*/
	bool succeeded() const;

	/*! Sets the error code type
	\param code Error code
	*/
	void code(Code code);

	/*! Sets the Status object with a given error code.
	\param code Error code
	\return Status object.
	*/
	Status& operator = ( Code code );

	/*! Bool operator returning true if the state is Success.
	\return true if Success, false otherwise.
	*/
	operator bool() const;

	/*! The equality operator that takes another Status object.
	\param rhs status object
	\return bool
	*/
	bool operator== ( const Status & rhs ) const;

	/*! The equality operator that takes a Status::Code.
	\param rhs status code
	\return bool
	*/
	bool operator== ( Code rhs ) const;

	/*! The inequality operator that takes a Status object.
	\param rhs status object
	\return bool
	*/
	bool operator!= ( const Status & rhs ) const;

	/*! The inequality operator that takes a Status::Code.
	\param rhs status code
	\return bool
	*/
	bool operator!= ( Code rhs ) const;

private:
	Code _code;
};

}
}

/*! The equality operator that takes a Code on the left side and a Status object on the right side.
\param lhs status code
\param rhs status object
\return bool
*/
BIFROST_API_DECL bool operator== ( Bifrost::API::Status::Code lhs, const Bifrost::API::Status & rhs);

/*! The inequality operator that takes a Code
 * on the left side and a Status object on the right side.
\param lhs status code
\param rhs status object
\return bool
*/
BIFROST_API_DECL bool operator!= ( Bifrost::API::Status::Code lhs, const Bifrost::API::Status & rhs);


#endif // _BIFROST_STATUS_H_