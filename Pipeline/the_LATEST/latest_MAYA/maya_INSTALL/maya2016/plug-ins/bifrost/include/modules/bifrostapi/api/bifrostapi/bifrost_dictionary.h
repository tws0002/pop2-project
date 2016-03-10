//*****************************************************************************
/*!
   \file bifrost_dictionary.h
   \brief Dictionary class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_DICTIONARY_H_
#define _BIFROST_DICTIONARY_H_

#include "bifrostapi/bifrost_base.h"
#include "bifrostapi/bifrost_math.h"

namespace Bifrost {
namespace API {

class Status;
class String;

//*****************************************************************************
/*! \class Dictionary bifrost_dictionary.h
	\brief The %Dictionary class is a container for storing key/value pairs. A dictionary
	is convenient for attaching user defined data to a particular %Bifrost object such as \ref Channel
	and \ref Object. The content of a dictionary is persisted along with its object owner in %BIF files.
	
	Keys are specified as \ref String object, these keys are guanranteed be unique across the dictionary. 
	
	The following value types are supported in a dictionary:
		\li bool
		\li float
		\li int8_t
		\li int16_t
		\li int32_t
		\li int64_t
		\li uint8_t
		\li uint16_t
		\li uint32_t
		\li uint64_t
		\li Bifrost::API::String
		\li amino::Math::vec2i
		\li amino::Math::vec3i
		\li amino::Math::vec2f
		\li amino::Math::vec3f
		\li amino::Math::vec4f
		\li amino::Math::mat44f

	\sa Channel::dictionary
	\sa Component::dictionary
	\sa Layout::dictionary
	\sa Object::dictionary
	\sa StateServer::dictionary

	\code
	// This example demonstrates how to access and use a dictionary from a component object.
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_const.h>
	#include <bifrostapi/bifrost_dictionary.h>
	#include <bifrostapi/bifrost_status.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	StateServer ss = om.createStateServer();

	Component comp = ss.createComponent( VoxelComponentType, "vcomp" );
	Dictionary d = comp.dictionary();

	// add a few entries
	d.setValue( "myfloat", 45.0f );
	d.setValue( "myint", 345 );
	d.setValue( "mystring", String("mystring") );
	d.setValue( "mybool", true );

	std::cout << "myfloat: " << d.value<float>("myfloat") << std::endl;        
	std::cout << "myint: " << d.value<int>("myint") << std::endl;        
	std::cout << "mystring: " << d.value<String>("mystring") << std::endl;        
	std::cout << "mybool: " << d.value<bool>("mybool") << std::endl;      
	\endcode

	\code
	// This example demonstrates how to add multiple directories on an Object instance.
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_const.h>
	#include <bifrostapi/bifrost_dictionary.h>
	#include <bifrostapi/bifrost_status.h>
	#include <bifrostapi/bifrost_object.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_string.h>
	#include <bifrostapi/bifrost_fileutils.h>
	
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	StateServer ss = om.createStateServer();

	Object obj = ss.createObject( "myobject-type", "myobject" );

	// Objects come with a default dictionary
	Dictionary defaultDict = obj.dictionary();

	// Bifrost uses internally the ObjectDictionary component type for creating the Object default dictionary. You can 
	// also use the ObjectDictionary type for adding multiple directories to an Object. 
	Component comp1 = ss.createComponent( ObjectDictionaryType, "myobject-dictionary1" );
	Component comp2 = ss.createComponent( ObjectDictionaryType, "myobject-dictionary2" );

	// Make sure the dictionary components are added to the object
	obj.addComponent( comp1 );
	obj.addComponent( comp2 );

	// add a few entries to each dictionary
	obj.dictionary().setValue( "myfloat", 10.0f );
	comp1.dictionary().setValue( "myfloat", 20.0f );
	comp2.dictionary().setValue( "myfloat", 30.0f );

	// Dictionary objects can be stored in BIF files by saving their component owners
	File::TempFolder tempfolder;
	String bifDir = tempfolder.path();
	StringArray bifFiles;

	RefArray compArray = obj.components();
	for (size_t i=0; i<compArray.count(); i++ ) {
		Component comp = compArray[i];
		String bif = bifDir + comp.name() + ".bif";
		bifFiles.add( bif );

		FileIO fsave = om.createFileIO(bif);
		fsave.save( comp, BIF::Compression::Level0 );
	}

	// reload the BIF files to get the dictionary objects back in "myobject"
	// note: for the purpose of the demonstration we remove the object from its state server. Loading the BIF
	// files will recreate "myobject" and will add it back to the state server.
	ss.removeObject( obj.name() );

	for ( size_t i=0; i<bifFiles.count(); i++ ) {
		FileIO fload = om.createFileIO(bifFiles[i]);
		StateServer loadss = fload.load( );

		// merge state servers
		ss.merge( loadss );
	}

	// Get "myobject" and iterate over its components to access each dictionary object
	obj = ss.findObject( "myobject" );
	// Retrieve all 3 dictionaries
	compArray = obj.findComponentsByType(ObjectDictionaryType);

	for (size_t i=0; i<compArray.count(); i++ ) {
		Component comp = compArray[i];
		std::cout << comp.name() << " myfloat: " << comp.dictionary().value<float>("myfloat") << std::endl; 
	}
	\endcode

 */
//*****************************************************************************

class BIFROST_API_DECL Dictionary : public Base
{
	public:
	/*! Default constructor. */
	Dictionary();

	/*! Default destructor. */
	~Dictionary();

	/*! Constructor. 
	*/
	Dictionary(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Dictionary(const Dictionary& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Dictionary object.
	*/
	Dictionary& operator=(const Dictionary& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Dictionary object.
	*/
	Dictionary& operator=(const Ref& ref);

	/// \name Value
	//@{
	/*! This method sets an entry in the underlying dictionary. If the entry does not exist, a new one is created. Values can be retrieved with \ref value.

	The following types are supported:
			\li bool
			\li float
			\li int8_t
			\li int16_t
			\li int32_t
			\li int64_t
			\li uint8_t
			\li uint16_t
			\li uint32_t
			\li uint64_t
			\li Bifrost::API::String
			\li amino::Math::vec2i
			\li amino::Math::vec3i
			\li amino::Math::vec2f
			\li amino::Math::vec3f

	\param key Identifier of the value. This key may exist or not, if the entry associated to the key doesn't exist, a new one is created.
	\param value Value associated to key.
	\tparam T Specifies the type of the value. 
	\return Status::Success if succeeded, Status::Failure if the entry already exists in the dictionary.
	*/
	template < typename T >
    Status setValue( const String& key, const T& value );

	/*! Returns the value associated to a key identifier.
	\param key Identifier of the value to retrieve.
	\return T value.
	\tparam T Specifies the type of the value returned.
	\sa \ref setValue
	*/
	template < typename T >
    T value( const String& key ) const;

	/*! Returns true if a specific value entry exists in the dictionary.
	\param key The value key to test.
	\return True if the value exists, false otherwise.
	*/
	bool hasValue( const String& key ) const;

	/*! Remove a value entry from the dictionary.
	\param key The value key to remove.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status removeValue( const String& key );

	/*! Clear all values previously added to this dictionary with \ref setValue.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status clear();

	/*! Returns true if this dictionary is empty.
	\return True if the dictionary is empty, false otherwise.
	*/
	bool empty( ) const;

	//@}

	/// \name Persistence
	//@{
	/*! Save the current values in a string. The values can be loaded back by calling Dictionary::load.
	\return String Values encoded in a string.
	\sa \ref load
	*/
	String save() const;

	/*! Load the values encoded in a string created with Dictionary::save. The current values are cleared before loading.
	\param values String containing the values to load.
	\return Status::Success if succeeded or Status::Failure otherwise.
	\sa \ref save
	*/
	Status load( const String& values );
	//@}
};

}
}

#endif // _BIFROST_BASE_H_