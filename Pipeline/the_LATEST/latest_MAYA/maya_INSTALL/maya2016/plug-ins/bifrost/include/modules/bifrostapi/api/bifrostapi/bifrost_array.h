//*****************************************************************************
/*!
   \file bifrost_array.h
   \brief Array class declaration.

	Copyright 2015 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_ARRAY_H_
#define _BIFROST_ARRAY_H_

#include "bifrostapi/bifrost_types.h"
#include "bifrostapi/bifrost_status.h"

namespace Bifrost {
namespace API {

class String;
class Ref;

//*****************************************************************************
/*! \class Array bifrost_array.h
	\brief Array is a template class for holding a list of type elements such as Ref, int or String. 
	Instances of Array classes can be shared with other Array objects of same type through reference 
	counting. The content of an Array is guaranteed to be deleted when the last shared Array is
	destroyed or cleared.

	The following lists all pre-defined arrays available in Bifrost:

	\li \ref RefArray
	\li \ref TreeIndexArray
	\li \ref StringArray
	\li \ref Int32Array
	\li \ref UInt32Array
	\li \ref Int64Array
	\li \ref UInt64Array
	\li \ref FloatArray
 */
//*****************************************************************************

template< typename T >
class BIFROST_API_DECL Array
{
	public:
	/*! Constructs an empty Array object.
	*/
	Array();

	/*! Constructs an Array object and initializes it to a known size.
	\param size Size of array.
	*/
	Array(size_t size);

	/*! Constructs a Array object from another Array object. Rather than copying the other array,
	this constructor shares a reference with the other array. Use Array::copy if you need to copy the array.
	\param other constant Array object.
	\sa Array::copy
	*/
	Array(const Array& other);

	/*! Default destructor. */
	~Array();

	/*! Assigns a Array object to this one. Rather than copying the other array, the assignment operator
	shares a reference with the other array.
	\param other A constant Array object.
	\return A reference to a Array object.
	*/
	Array& operator=( const Array& other );

	/*! Appends the content of a Array object to this one.
	\param other A constant Array object.
	\return A reference to a Array object.
	*/
	Array& operator+=( const Array& other );

	/*! Accessor to elements at a given index. This function can only be called by constant objects, the returned value is read-only.
	\param index Index of the element to retrieve.
	\return A constant reference to an element at index. If the index is out-of-range, the returned value is undefined.
	*/
	const T& operator[]( size_t index ) const;

	/*! Accessor to elements at a given index. This method can also be used for setting elements in this array if previously set with a known size.
	\param index Index of the element to retrieve.
	\return A reference to an element at index. If the index is out-of-range, the returned value is undefined.
	\sa Array::add
	\sa Array::resize
	*/
	T& operator[]( size_t index );

	/*! Equality operator. Returns true if this Array object is the same as other. This function does not perform a comparison element by element.
	\param other Array class object to compare.
	\return true if both Array objects are the same object.
	*/
	bool operator == ( const Array& other ) const;

	/*! Inequality operator. Returns true if this Array object is not the same as other. This function does not perform a comparison element by element.
	\param other Array class object to compare.
	\return true if both Array objects are different objects.
	*/
	bool operator != ( const Array& other ) const;

	/*! Bool operator returning true if the array is non-empty or false otherwise.
	\return true if non-empty, false otherwise.
	*/
	operator bool() const;

	/*! Returns a copy of this Array.
	\return New Array object.
	*/
	Array copy() const;

	/*! Adds an element at the end of this array.
	\param value Element to add.
	*/
	void add( const T& value );

	/*! Removes an element at a specific position in the array.
	\param index Element index.
	\return Returns Success if the element was removed or Failure otherwise.
	*/
	Status remove( size_t index );

	/*! Removes a specific element in the array. The method searches the element by name from the beginning of the array.
	\param name Array element to remove.
	\return Returns Success if the element was removed or Failure otherwise.
	*/
	Status removeFirstByName( const String& name );

	/*! Removes a specific element in the array. The method searches the element by name from the end of the array.
	\param name Array element to find.
	\return Returns Success if the element was removed or Failure otherwise.
	*/
	Status removeLastByName( const String& name );

	/*! Returns the index of a specific element in the array. The search starts from the beginning of the array.
	\param element Array element to find.
	\return Index of the element or npos if the element was not found.
	*/
	size_t findFirst( const T& element ) const;

	/*! Returns the index of a specific element in the array. The search starts from the end of the array.
	\param element Array element to find.
	\return Index of the element or npos if the element was not found.
	*/
	size_t findLast( const T& element ) const;

	/*! Returns the index of a specific element in the array. The method searches the element by name from the beginning of the array.
	\param name Array element to find.
	\return Index of the element or npos if the element was not found.
	*/
	size_t findFirstByName( const String& name ) const;

	/*! Returns the index of a specific element in the array. The method searches the element by name from the end of the array.
	\param name Array element to find.
	\return Index of the element or npos if the element was not found.
	*/
	size_t findLastByName( const String& name ) const;

	/*! Removes all elements contained in this array.
	 */
	void clear();

	/*! Returns the number of elements in this array.
	\return Number of elements of the array.
	*/
	size_t count() const;

	/*! Reallocates memory for this array, preserves its contents if new size is larger than existing size.
	\param size New size of the array.
	*/
	void resize( size_t size );

	/*! npos designates an out of bound array index. */
	static const size_t npos = -1;

	private:
	void* _ptr;
};

/*! Array of TreeIndex objects. 
	\sa TileAccessor::removeTiles
*/
typedef Array<TreeIndex> TreeIndexArray;

/*! Array of Tile identifiers. 
	\sa TileAccessor::removeTiles
*/
typedef Array<TileInfo::ID> TileIDArray;

/*! Array of Tile coordinates. 
*/
typedef Array<TileCoord> TileCoordArray;

/*! 2D Array of Tile coordinates. 
	\sa TileAccessor::addTiles
*/
typedef Array<TileCoordArray> TileCoordArray2D;

/*! Array of String objects. 
	\code
	// Simple example to demonstrate how to use the StringArray class.
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_string.h>
	#include <iostream>

	using namespace Bifrost::API;

	String spam("spam");
	StringArray strings(3);
	strings[0] = "foo";
	strings[1] = String("bar");
	strings[3] = spam;

	std::cout << "strings[0] -> " << strings[0] << std::endl;
	std::cout << "strings[1] -> " << strings[1] << std::endl;

	StringArray strings2;
	strings2.add( "eggs" );
	strings2.add( "nudge" );
	strings += strings2;

	for ( size_t i=0; i<strings.count(); i++ ) {
		std::cout << "strings[" << i << "] -> " << strings[i] << std::endl;
	}

	// Output:
	//strings[0] -> foo
	//strings[1] -> bar
	//strings[0] -> foo
	//strings[1] -> bar
	//strings[2] ->
	//strings[3] -> eggs
	//strings[4] -> nudge

	\endcode
*/
typedef Array<String> StringArray;

/*! Array of Ref objects. 
	// Here's a simple example to demonstrate how to use the RefArray class.
	\code
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_const.h>
	#include <iostream>

	using namespace Bifrost::API;
	ObjectModel om;
	StateServer ss = om.createStateServer();
	Component pcomp = ss.createComponent( PointComponentType, "point" );
	Layout layout = pcomp.layout();

	RefArray refs(2);
	refs[0] = pcomp;
	refs[1] = layout;

	std::cout << "refs[0] -> " << Base(refs[0]).name() << std::endl;
	std::cout << "refs[1] -> " << Base(refs[1]).name() << std::endl;

	RefArray refs2 = ss.components();
	refs2.add( layout );
	refs += refs2;

	for ( size_t i=0; i<refs.count(); i++ ) {
		std::cout << "refs[" << i << "] -> " << Base(refs[i]).name() << std::endl;
	}

	// Output:
	//refs[0] -> point
	//refs[1] -> point_layout
	//refs[0] -> point
	//refs[1] -> point_layout
	//refs[2] -> point
	//refs[3] -> point_layout

	\endcode
*/
typedef Array<Ref> RefArray;

typedef Array<int32_t> Int32Array;
typedef Array<uint32_t> UInt32Array;
typedef Array<int64_t> Int64Array;
typedef Array<uint64_t> UInt64Array;
typedef Array<float> FloatArray;

}
}

#endif // _BIFROST_ARRAY_H_