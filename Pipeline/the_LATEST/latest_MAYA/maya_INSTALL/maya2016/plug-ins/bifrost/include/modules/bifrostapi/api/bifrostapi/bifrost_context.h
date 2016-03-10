//*****************************************************************************
/*!
   \file bifrost_context.h
   \brief Context class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_CONTEXT_H_
#define _BIFROST_CONTEXT_H_

#include "bifrostapi/bifrost_base.h"
#include "bifrostapi/bifrost_math.h"

namespace Bifrost {
namespace API {

class StateServer;
class Status;

//*****************************************************************************
/*! \class Context bifrost_context.h
	\brief The Context class represents a runtime context of %Bifrost. A runtime context
	provides a link between the %Bifrost operators, the current execution thread and some
	resources required for evaluating a frame. New runtime context can be created with
	Bifrost::API::ObjectModel::createContext.

	Context objects can be associated to a thread by calling Bifrost::API::ObjectModel::bindRuntimeContext.
	The current runtime context can be accessed by calling Bifrost::API::ObjectModel::runtimeContext.
	When a context is bound to a runtime evaluation, its content is private to the thread running
	the evaluation and therefore cannot be accessed by other threads.

	Call Bifrost::API::ObjectModel::unbindRuntimeContext to unlink the current runtime context from the
	current thread.

	The \ref BifrostKeys can be used for accessing context values that are predefined in %Bifrost. These keys
	can be used to call Bifrost::API::Context::value and Bifrost::API::Context::addValue.

	\code
	// Demonstrates how to build and use a runtime context initialized with meta data.
	#include <bifrostapi/bifrost_context.h>
	#include <bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_status.h>
	#include <tbb/tbb.h>

	using namespace Bifrost::API;

	// meta data struct used for recreating a context on a target evaluation node
	struct MetaData
	{
		unsigned int ssid;
		int frame;
		int startFrame;
		float time;
		float deltaTime;
		char cachePath[256];
		int buflen;
	};

	// Thread worker for creating and consuming the runtime context
	bool _threadFunc(const MetaData& data)
	{
		// create/prepare the runtime context
		ObjectModel om;
		Context ctx = om.createContext();

		ctx.setStateServer( data.ssid );
		ctx.setFrame( data.frame );
		ctx.setStartFrame( data.startFrame );
		ctx.setTime( data.time );
		ctx.setDeltaTime( data.deltaTime );

		// push the path as user data
		String cachePath( data.cachePath, data.buflen );
		ctx.addValue( "path", cachePath );

		// bind context to this thread
		om.bindRuntimeContext(ctx);

		// >>> add code here to consume the context <<<
		{
			Context rtcxt = om.runtimeContext();
			int frame = rtcxt.frame();
			float time = rtcxt.time();
			String path = rtcxt.value<String>( "path" );
			// etc...
		}

		// time to unbind the context from this thread
		om.unbindRuntimeContext();

		return true;
	}

	// Bifrost API code for creating the meta data and the thread
	ObjectModel om;
	FileIO fileio = om.createFileIO( "particles.bif" );
	StateServer ss = fileio.load( );
	if (ss) {
		// Prepare meta data for creating the context on the target evaluation thread
		MetaData data;
		data.ssid = ss.stateID();
		data.frame = 1;
		data.startFrame = 1;
		data.time = 0.0416f;
		data.deltaTime = 0.0f;
		
		// transfer the cache path as a text buffer and byte length
		String path("somepath_to_cache_file");
		data.buflen = path.size();
		memcpy( data.cachePath, path.c_str(), data.buflen );

		// start a local thread just for the sake of this example
		tbb::tbb_thread t(_threadFunc, data);
		t.join();
	}
	\endcode

 */
//*****************************************************************************
class BIFROST_API_DECL Context : public Base
{
	public:

	/*! Default constructor. */
	Context();

	/*! Default destructor. */
	~Context();

	/*! Constructor.
	*/
	Context(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	Context(const Context& obj);

	/*! Creates an object from another object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %Context object.
	*/
	Context& operator=(const Context& obj);

	/*! Creates an object from a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new Context object.
	*/
	Context& operator=(const Ref& ref);

	/// \name State server
	//@{
	/*! Returns the StateServer object for this runtime context. The returned state server is set for the on-going
	evaluation and can be used for updating, adding new objects or removing existing ones.
	<b>Note:</b>The state server is transient and must not be stored by an operator for future access.
	\return Reference to a %StateServer reference or invalid object if called outside the context of an evaluation.

	\code
	// Get the runtime state server available from an operator during an evaluation.
	#include <bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_context.h>
	#include <iostream>

	Bifrost::API::ObjectModel om;
	Bifrost::API::Context ctx = om.runtimeContext();
	Bifrost::API::StateServer ss = ctx.stateServer();
	std::cout << "State server identifier: " << ss.stateID() << std::endl;
	std::cout << "State server persistent identifier: " << ss.persistID() << std::endl;
	\endcode
	*/
	Ref stateServer( ) const;

	/* Sets the state server to use for the runtime evaluation.
	\param serverid The state server identifier.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status setStateServer( const Bifrost::API::StateID& serverid ) ;
	//@}

	/// \name Time
	//@{
	/*! Returns the evaluation time in seconds.
	\return Evaluation time.
	*/
	float time() const;

	/* Sets the time for this evaluation.
	\param time Evaluation time in seconds.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status setTime( float time ) ;

	/*! Returns the time difference with the current frame and the last evaluated frame in seconds.
	\return Evaluation delata time.
	*/
	float deltaTime() const;

	/* Sets the delta time for this evaluation.
	\param time Evaluationd time in seconds.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status setDeltaTime( float time ) ;
	//@}

	/// \name Frame
	//@{
	/*! Returns the frame number for the current evaluation.
	\return Frame number.
	*/
	int frame() const;

	/* Sets the frame for this evaluation.
	\param int Evaluation frame.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status setFrame( int frame );

	/*! Returns the start frame for the current evaluation.
	\return Frame number.
	*/
	int startFrame() const;

	/* Sets the start frame for this evaluation.
	\param int Evaluation frame.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status setStartFrame( int frame ) ;
	//@}

	/// \name Value
	//@{
	/*! This template method adds a new entry in the runtime context value table. Values can be retrieved with Context::value.

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

	\param key Identifier of the value.
	\param value Value associated to key.
	\tparam T Specifies the type of the value. 
	*/
	template < typename T >
    Status addValue( const String& key, const T& value );

	/*! Returns the value associated to a key identifier.
	\param key Identifier of the value to retrieve.
	\return T value.
	\tparam T Specifies the type of the value returned.
	\sa Context::addValue
	*/
	template < typename T >
    const T& value( const String& key ) const;

	/*! Clear all values previously added to this context with Context::addValue.
	\return Status::Success if succeeded or Status::Failure otherwise.
	*/
	Status clearValues();

	/*! Save the current values in a string. The values can be loaded back by calling Context::load.
	\return String Values encoded in a string.
	\sa Context::load
	*/
	String save() const;

	/*! Load the values encoded in a string created with Context::save. The current values are cleared before loading.
	\param values String containing the values to load.
	\return Status::Success if succeeded or Status::Failure otherwise.
	\sa Context::save
	*/
	Status load( const String& values );
	//@}
};

}
}

#endif // _BIFROST_CONTEXT_H_