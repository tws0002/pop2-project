//*****************************************************************************
/*!
   \file bifrost_fileio.h
   \brief FileIO class declaration.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_FILEIO_H_
#define _BIFROST_FILEIO_H_

#include "bifrostapi/bifrost_base.h"
#include "bifrostapi/bifrost_fileutils.h"
#include "bifrostapi/bifrost_bifutils.h"
#include "bifrostapi/bifrost_array.h"

namespace Bifrost {
namespace API {

class Component;
class Status;
class String;

//*****************************************************************************
/*! \class FileIO bifrost_fileio.h
	\brief The %FileIO class provides methods for saving and loading %BIF files. Instances of
	%FileIO are created with \ref ObjectModel::createFileIO.

	%FileIO can	save files synchronously and asynchronously. You call \ref load for loading a %BIF file.
	The file load operation is always performed synchronously in the calling thread. The method
	\ref save is used for saving files in synchronous mode.

	You call \ref saveAsync to save a file asynchronously. This operation is performed in a background
	thread which means the calling thread doesn't block. Calls to saveAsync is usually done without blocking,
	but it is possible though to write code for blocking the thread and wait for the result of the
	asynchronous save. If you are interested in the result of an asynchronous save without blocking the thread,
	you can call \ref BIF::queryJobResult from the dedicated GUI thread of your application event loop.

	\code
	// Examples to demonstrate how to create a FileIO object.
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_status.h>
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_string.h>

	using namespace Bifrost::API;

	// Create a FileIO object for loading a BIF file
	ObjectModel om;
	FileIO f = om.createFileIO( "whale_dad_jump-volume.1.bif" );
	StateServer ss = f.load( );

	// Create a FileIO object for storing a component in a BIF file
	ss = om.createStateServer();
	Component comp = ss.createComponent( VoxelComponentType, "voxel" );

	FileIO fcomp = om.createFileIO( "component.bif" );
	fcomp.save( comp, BIF::Compression::Level0, 1 );
	\endcode

 */
//*****************************************************************************
class BIFROST_API_DECL FileIO : public Base
{
	public:

	/*! Default constructor. */
	FileIO();

	/*! Default destructor. */
	~FileIO();

	/*! Constructor.
	*/
	FileIO(const Ref& ref);

	/*! Copy constructor.
	\param obj constant class object.
	*/
	FileIO(const FileIO& obj);

	/*! Creates an object with an other object. The newly created object is set to
	empty if the input object is not compatible.
	\param obj constant class object.
	\return The new %FileIO object.
	*/
	FileIO& operator=(const FileIO& obj);

	/*! Creates an object with a reference object. The newly created object is
	set to empty if the input reference object is not compatible.
	\param ref constant class object.
	\return The new FileIO object.
	*/
	FileIO& operator=(const Ref& ref);

	/// \name Persistence
	//@{
	/*! Returns the %BIF file name associated to this %FileIO. The file name can be used for saving, loading or to query information
	about its content such as the component and the channel names stored (see \ref info for details).
	\return %BIF file path.
	\sa resolvedFilename
	\sa save
	\sa load
	\sa saveAsync
	*/
	const String& filename( ) const;

	/*! If the associated %BIF file of the %FileIO is set with frame padding, this function will return the resolved version by using
	the frame number used for saving the %BIF file.
	\return %BIF file path. Returns an empty string if the %FileIO file has never been saved.
	\sa filename
	\sa save
	\sa load
	\sa saveAsync
	*/
	const String& resolvedFilename( ) const;

	/*! Loads the content of the %FileIO %BIF file. The method returns a StateServer object initialized with the objects and data loaded from the file.
	\return Reference to a %StateServer. Returns an invalid object if the file can not be loaded.

	\code
	// Create a new state server populated with the objects loaded from a BIF file.
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_layout.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_status.h>
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_string.h>
	#include <iostream>

	using namespace Bifrost::API;

	ObjectModel om;
	FileIO fio = om.createFileIO( "whale_dad_jump-volume.1.bif" );
	StateServer ss = fio.load( );
	if ( ss ) {
		RefArray components = ss.components();
		Component component = components[0];
		Layout layout = component.layout();
		RefArray channels = component.channels();
		std::cout << "Component count: " << components.count();
		std::cout << "Component: " << component.name();
		std::cout << "Layout: " << layout.name();
		std::cout << "Channel count: " << channels.count();
		for ( size_t i=0; i<channels.count(); i++ ) {
			std::cout << "Channel: " << Base(channels[i]).name() << std::endl;
		}
	}
	\endcode
	\sa save
	\sa saveAsync
	*/
	Ref load( ) const;

	/*! Saves a component object to the %FileIO %BIF file. This version saves all channels of the component.

	\param component %Component object to save.
	\param factor %BIF Compression factor.
	\param frame Frame number associated to the %BIF file. Defaults to 1.

	\return Success if ok or Failure if the operation failed.

	\code
	// Example to illustrate how to save a component to a BIF file.
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_channel.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_status.h>
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_string.h>

	using namespace Bifrost::API;

	// create the component and channel to save
	ObjectModel om;
	StateServer ss = om.createStateServer();
	Component comp = ss.createComponent( VoxelComponentType, "voxel" );
	Channel ch = ss.createChannel( comp, FloatType, "voxel-channel" );

	// get the FileIO object
	FileIO fio = om.createFileIO( "test.@@@@.bif" );

	// Save with level1 compression at frame 5
	// Note: the content will be saved under 'test.0005.bif'
	fio.save( comp, BIF::Compression::Level1, 5 );
	\endcode
	\sa saveAsync
	*/
	Status save( const Component& component, BIF::Compression factor, size_t frame=1 ) const;

	/*! Saves a component object to the %FileIO %BIF file. The channelNames argument is used for saving a subset of
	the component channels.

	\param component %Component object to save.
	\param channelNames Array of channel names to save. Channels must exist in the component.
	\param factor %BIF Compression factor.
	\param frame Frame number associated to the %BIF file.

	\return Success if ok or Failure if the operation failed.
	\code
	// Example to illustrate how to save a subset of component channels to a BIF file.
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_channel.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_status.h>
	#include <bifrostapi/bifrost_array.h>
	#include <bifrostapi/bifrost_string.h>

	using namespace Bifrost::API;

	// create the component and channel to save
	ObjectModel om;
	StateServer ss = om.createStateServer();
	Component comp = ss.createComponent( VoxelComponentType, "voxel" );
	Channel ch = ss.createChannel( comp, FloatType, "voxel-channel" );
	Channel ch2 = ss.createChannel( comp, FloatType, "voxel-channel2" );

	// get the FileIO object
	FileIO fio = om.createFileIO( "test.@@@@.bif" );

	// Save a single channel with level1 compression at frame 5
	StringArray channels(1);
	channels[0] = ch2;

	// Note: the content will be saved under 'test.0005.bif'
	fio.save( comp, channels, BIF::Compression::Level1, 5 );
	\endcode
	\sa saveAsync
	*/
	Status save( const Component& component, const StringArray& channelNames, BIF::Compression factor, size_t frame ) const;

	/*! Saves a component object asynchronously to the %FileIO %BIF file.

	The save operation is performed asynchronously in a thread different than the running thread. Therefore, the calling thread
	doesn't wait for the operation to complete. Use \ref BIF::queryJobResult if you want to get the result of the operation once
	it completes. saveAsync is designed to be used in a GUI application like Maya, its usage from a console application is not
	recommended.

	\param component %Component object to save.
	\param factor %BIF Compression factor.
	\param frame Frame number associated to the %BIF file.
	\param job The JobID created for this operation.
	\return Success if ok or Failure if the operation failed.
	\sa BIF::queryJobResult
	*/
	Status saveAsync( const Component& component, BIF::Compression factor, size_t frame, BIF::JobID& job ) const;

	/*! Saves a component object asynchronously to the %FileIO %BIF file. The channelNames argument is used for saving a subset of
	the component channels.

	The save operation is performed asynchronously in a thread different than the running thread. Therefore, the calling thread
	doesn't wait for the operation to complete. Use \ref BIF::queryJobResult if you want to get the result of the operation once
	it completes. saveAsync is designed to be used in a GUI application like Maya, its usage from a console application is not
	recommended.

	\param component Component object to save.
	\param channelNames Array of channel names to save. Channels must exist in the component.
	\param factor %BIF Compression factor.
	\param frame Frame number associated to the %BIF file.
	\param job The JobID created for this operation.
	\return Success if ok or Failure if the operation failed.
	\sa BIF::queryJobResult
	*/
	Status saveAsync( const Component& component, const StringArray& channelNames, BIF::Compression factor, size_t frame, BIF::JobID& job ) const;

	/*! Saves a component object asynchronously to the %FileIO %BIF file. This is a convenient method for a caller who doesn't need to query for the result of
	the operation.

	The save operation is performed asynchronously in a thread different than the running thread. Therefore, the calling thread doesn't wait for the operation to
	complete. saveAsync is designed to be used in a GUI application like Maya, its usage from a console application is not recommended.

	\param component %Component object to save.
	\param factor %BIF Compression factor.
	\param frame Frame number associated to the %BIF file.
	\return Success if ok or Failure if the operation failed.
	*/
	Status saveAsync( const Component& component, BIF::Compression factor, size_t frame ) const;

	/*! Saves a component object asynchronously to the %FileIO %BIF file. This is a convenient method for a caller who doesn't need to query for the result of
	the operation. The channelNames argument is used for saving a subset of the component channels.

	The save operation is performed asynchronously in a thread different than the running thread. Therefore, the calling thread doesn't wait for the operation to
	complete. Use \ref BIF::queryJobResult if you want to get the result of the operation when it completes. saveAsync is designed to be used in a GUI application like
	Maya, its usage from a console application is not recommended.

	\param component %Component object to save.
	\param channelNames Array of channel names to save. Channels must exist in the component.
	\param factor %BIF Compression factor.
	\param frame Frame number associated to the %BIF file.
	\return Success if ok or Failure if the operation failed.
	*/
	Status saveAsync( const Component& component, const StringArray& channelNames, BIF::Compression factor, size_t frame ) const;
	//@}

	/// \name Information
	//@{
	/*! Returns a structure describing the content of the %FileIO %BIF file.
	\return BIF::FileInfo structure.
	*/
	const BIF::FileInfo& info( ) const;

	/*! Returns a structure describing a channel stored in the %FileIO %BIF file.
	\param index Index of the channel to retrieve. The index must be smaller than the number of channels in the file. The number of channels
	is available from the \ref BIF::FileInfo structure.
	\return BIF::FileInfo::ChannelInfo data structure.
	*/
	const BIF::FileInfo::ChannelInfo& channelInfo( size_t index ) const;
	//@}
};

}
}

#endif // _BIFROST_FILEIO_H_