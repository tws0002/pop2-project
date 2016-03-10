//*****************************************************************************
/*!
   \file bifrost_string.h
   \brief String class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_STRING_H_
#define _BIFROST_STRING_H_

#include <stdlib.h>
#include <ostream>
#include <bifrostapi/bifrost_decl.h>
#include <bifrostapi/bifrost_array.h>

namespace Bifrost {
namespace API {

//*****************************************************************************
/*! \class String bifrost_string.h
	\brief Character strings in the %Bifrost SDK %API are represented with the %String class. 
	%String is a thin wrapper around the standard library string class, though iterators are 
	not exposed. The %String class has also in-house methods for processing strings	such as 
	String::trim and String::split.

	\sa StringArray
 */
//*****************************************************************************

class BIFROST_API_DECL String
{
	public:

	/// \name Standard Library string methods
	//@{
	String();
	String(const String& str);
	String(const String& str, size_t pos, size_t len = npos);
	String(const char* s);
	String(const char* s, size_t n);
	String(size_t n, char c);

	~String();

	String& append(const String& str);
	String& append(const String& str, size_t subpos, size_t sublen);
	String& append(const char* s);
	String& append(const char* s, size_t n);
	String& append(size_t n, char c);

	String& assign(const String& str);
	String& assign(const String& str, size_t subpos, size_t sublen);
	String& assign(const char* s);
	String& assign(const char* s, size_t n);
	String& assign(size_t n, char c);

	char& at(size_t pos);
	const char& at(size_t pos) const;

	size_t capacity() const;

	void clear();

	int compare(const String& str) const;
	int compare(size_t pos, size_t len, const String& str) const;
	int compare(size_t pos, size_t len, const String& str, size_t subpos, size_t sublen) const;
	int compare(const char* s) const;
	int compare(size_t pos, size_t len, const char* s) const;
	int compare(size_t pos, size_t len, const char* s, size_t n) const;

	size_t copy(char* s, size_t len, size_t pos = 0) const;

	const char* c_str() const;
	const char* data() const;
	bool empty() const;

	String& erase(size_t pos = 0, size_t len = npos);

	size_t find(const String& str, size_t pos = 0) const;
	size_t find(const char* s, size_t pos = 0) const;
	size_t find(const char* s, size_t pos, size_t n) const;
	size_t find(char c, size_t pos = 0) const;

	size_t find_first_not_of(const String& str, size_t pos = 0) const;
	size_t find_first_not_of(const char* s, size_t pos = 0) const;
	size_t find_first_not_of(const char* s, size_t pos, size_t n) const;
	size_t find_first_not_of(char c, size_t pos = 0) const;

	size_t find_first_of(const String& str, size_t pos = 0) const;
	size_t find_first_of(const char* s, size_t pos = 0) const;
	size_t find_first_of(const char* s, size_t pos, size_t n) const;
	size_t find_first_of(char c, size_t pos = 0) const;

	size_t find_last_not_of(const String& str, size_t pos = npos) const;
	size_t find_last_not_of(const char* s, size_t pos = npos) const;
	size_t find_last_not_of(const char* s, size_t pos, size_t n) const;
	size_t find_last_not_of(char c, size_t pos = npos) const;

	size_t find_last_of(const String& str, size_t pos = npos) const;
	size_t find_last_of(const char* s, size_t pos = npos) const;
	size_t find_last_of(const char* s, size_t pos, size_t n) const;
	size_t find_last_of(char c, size_t pos = npos) const;

	String& insert(size_t pos, const String& str);
	String& insert(size_t pos, const String& str, size_t subpos, size_t sublen);
	String& insert(size_t pos, const char* s);
	String& insert(size_t pos, const char* s, size_t n);
	String& insert(size_t pos, size_t n, char c);

	size_t length() const;

	size_t max_size() const;

	String& operator+=(const String& str);
	String& operator+=(const char* s);
	String& operator+=(char c);

	String& operator=(const String& str);
	String& operator=(const char* s);
	String& operator=(char c);

	char& operator[](size_t pos);
	const char& operator[](size_t pos) const;

	void push_back(char c);

	String& replace(size_t pos,  size_t len,  const String& str);
	String& replace(size_t pos,  size_t len,  const String& str, size_t subpos, size_t sublen);
	String& replace(size_t pos,  size_t len,  const char* s);
	String& replace(size_t pos,  size_t len,  const char* s, size_t n);
	String& replace(size_t pos,  size_t len,  size_t n, char c);

	void reserve(size_t n = 0);

	void resize(size_t n);
	void resize(size_t n, char c);

	size_t rfind(const String& str, size_t pos = npos) const;
	size_t rfind(const char* s, size_t pos = npos) const;
	size_t rfind(const char* s, size_t pos, size_t n) const;
	size_t rfind(char c, size_t pos = npos) const;

	size_t size() const;

	String substr(size_t pos = 0, size_t len = npos) const;

	void swap(String& str);

	static const size_t npos = -1;
	//@}

	/// \name String specific methods and operators
	//@{
	bool operator==(const Bifrost::API::String& str) const;
	bool operator==(const char* s) const;

	bool operator!=(const Bifrost::API::String& str) const;
	bool operator!=(const char* s) const;

	bool operator<(const Bifrost::API::String& str) const;
	bool operator<(const char* s) const;

	bool operator<=(const Bifrost::API::String& str ) const;
	bool operator<=(const char* s ) const;

	bool operator>(const Bifrost::API::String& str ) const;
	bool operator>(const char* s ) const;

	bool operator>=(const Bifrost::API::String& str ) const;
	bool operator>=(const char* s ) const;

	/*! Bool operator returning true if the string is non-empty or false otherwise.
	\return true if non-empty, false otherwise.
	*/
	operator bool() const;

	/*! Convert this string to a lower-case character string.
	\return Returns a reference on this string.
	\sa String::upper
	*/
	String& lower();

	/*! Convert this string to an upper-case character string.
	\return Returns a reference on this string.
	\sa String::lower
	*/
	String& upper();

	/*! Removes a character or a group of characters from the beginning of this string. When called with no
	argument, the method removes newline, space and tab characters.
	\param target The characters to trim.
	\return Returns a reference on this string.
	\sa String::trimRight
	
	\code
		// Demonstrates trimLeft usage.
		#include <bifrostapi/bifrost_string.h>
		#include <iostream>

		using namespace Bifrost::API;

		String str( "\n\n\t \t 0123456789   \n" ) ;

		// Trim blank characters
		str.trimLeft( );
		std::cout << str << std::endl;
		// "0123456789   \n"

		// Trim "01234" characters
		str = "0123456789";
		str.trimLeft( "42130" );
		std::cout << str << std::endl;
		// "56789"

		// Trim " *** \t" characters
		str = " *** \t0123456789";
		str.trimLeft( " *\t" );
		std::cout << str << std::endl;
		// "0123456789"
	\endcode

	*/
	String& trimLeft( const String& target = String() );

	/*! Removes a character or a group of characters at the end of this string. When called with no
	argument, the method removes newline, space and tab characters.
	\param target The characters to trim.
	\return Returns a reference on this string.
	\sa String::trimLeft

	\code
		// Demonstrates trimRight usage.
		#include <bifrostapi/bifrost_string.h>
		#include <iostream>

		using namespace Bifrost::API;

		String str( "\n\n\t \t 0123456789   \n" ) ;

		// Trim blank characters
		str.trimRight( );
		std::cout << str << std::endl;
		// "\n\n\t \t 0123456789"

		// Trim "789" characters
		str = "0123456789";
		str.trimRight( "978" );
		std::cout << str << std::endl;
		// "0123456"

		// Trim " *** \t" characters
		str = "0123456789 *** \t";
		str.trimRight( " *\t" );
		std::cout << str << std::endl;
		// "0123456789"
	\endcode
	*/
	String& trimRight( const String& target = String() );

	/*! Removes a character or a group of characters at both ends of this string. When called with no
	argument, the method removes newline, space and tab characters.
	\param target The characters to trim.
	\return Returns a reference on this string.
	\sa String::trimLeft

	\code
		// Demonstrates trim usage.
		#include <bifrostapi/bifrost_string.h>
		#include <iostream>

		using namespace Bifrost::API;

		String str( "\n\n\t \t 0123456789   \n" ) ;

		// Trim blank characters
		str.trim( );
		std::cout << str << std::endl;
		// "0123456789"
	\endcode
	*/
	String& trim( const String& target = String() );

	/*! Parses the string and returns the sub-strings delimited by a given string. If the delimiter is empty or split is called with no 
	argument, the space	character is used. If the underlying string is empty, the function returns an empty array.
	\param delimiter String delimiter. 
	\return StringArray Array containing the sub-strings.
	*/
	StringArray split( const String& delimiter=String() ) const;

	/*! Parses the string and returns the sub-strings delimited by a given character. If the underlying string is empty, 
	the function returns an empty array.
	\param delimiter Character delimiter.
	\return StringArray Array containing the sub-strings.
	*/
	StringArray split( const char delimiter ) const;

	//@}

	private:
	class Impl;
    Impl* _ptr;

	/*! String content.
		This data member points to the content of String and is typically used to inspect a String instance from the debugger.
	*/
	char* _cstr;
};

/*! TypeID is the type used for defining object types in %Bifrost. */
typedef String TypeID;
/*! PersistID represents the persistent identifier of a StateServer object. */
typedef String PersistID;

}
}

// Global String operators 
BIFROST_API_DECL Bifrost::API::String operator+(const Bifrost::API::String& lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL Bifrost::API::String operator+(const Bifrost::API::String& lhs, const char* rhs);
BIFROST_API_DECL Bifrost::API::String operator+(const char* lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL Bifrost::API::String operator+(const Bifrost::API::String& lhs, char rhs);
BIFROST_API_DECL Bifrost::API::String operator+(char lhs, const Bifrost::API::String& rhs);

BIFROST_API_DECL bool operator==(const char* lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL bool operator!=(const char* lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL bool operator<(const char* lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL bool operator<=(const char* lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL bool operator>(const char* lhs, const Bifrost::API::String& rhs);
BIFROST_API_DECL bool operator>=(const char* lhs, const Bifrost::API::String& rhs);

BIFROST_API_DECL std::ostream& operator<<( std::ostream& os, const Bifrost::API::String& str );

#endif // _BIFROST_STRING_H_
