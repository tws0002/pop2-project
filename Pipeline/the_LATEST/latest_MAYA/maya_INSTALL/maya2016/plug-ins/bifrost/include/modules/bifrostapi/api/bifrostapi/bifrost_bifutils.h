//*****************************************************************************
/*!
   \file bifrost_bifutils.h
   \brief Bifrost BIF utility functions.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_BIFUTILS_H_
#define _BIFROST_BIFUTILS_H_

#include <bifrostapi/bifrost_decl.h>
#include <bifrostapi/bifrost_string.h>
#include <bifrostapi/bifrost_types.h>

namespace Bifrost {
namespace API {
namespace BIF {
	/*! \namespace BIF
		\brief The %BIF namespace defines a region where all types, functions and classes related to %BIF file operations 
		are declared.
	*/

	/*! JobID is the identifier used to describe an operation performed asynchronously like Bifrost::API::FileIO::saveAsync. */	
	typedef uint64_t JobID;

	/*! Compression ratio factors for %BIF files.*/
	enum Compression {
		Level0=0,	/*!< Lowest compression ratio but make saving/loading faster. */ 
		Level1,		/*!< High compression with no precision loss. */
		Level2,		/*!< Higher compression with minimal precision loss. */
		Level3		/*!< Higher compression with precision loss. */
	};

	//*************************************************************************
	/*! \class FileInfo bifrost_bifutils.h
		\brief The %FileInfo structure stores useful information that describes 
		the content of a %BIF file. 
		\sa Bifrost::API::FileIO::info
	*/
	//*************************************************************************
	struct FileInfo
	{
		/*! \class ChannelInfo bifrost_bifutils.h
			\brief The %ChannelInfo structure stores information that describes 
			a channel contained in a %BIF file. 
			\sa Bifrost::API::FileIO::channelInfo
		*/
		struct ChannelInfo
		{
			/*! Default constructor */
			ChannelInfo()
				: dataType( DataType::NoneType )
				, maxDepth( 0 )
				, tileCount( 0 )
				, elementCount( 0 )
			{
			}

			/*! Name of the channel. */
			String name;
			/*! The channel data type. */
			DataType dataType;
			/*! The maximum depth of the channel. */
			TreeIndex::Depth maxDepth;
			/*! The number of tiles stored in the channel. */
			size_t tileCount;
			/*! The total number of tile elements stored in the channel. */
			size_t elementCount;
		};

		/*! Default constructor */
		FileInfo() 
			: version(0)
			, frame(0)
			, channelCount(0)
			, compression(Compression::Level0)
		{
		}

		/*! %BIF file version. */
		size_t version;
		/*! Frame number used for storing objects in the %BIF file. */
		int frame;
		/*! Number of channels stored in the %BIF file. */
		size_t channelCount;
		/*! The name of the component stored in the %BIF file. */
		String componentName;
		/*! The type of the component stored in the %BIF file. */
		TypeID componentType; 
		/*! The component's object name stored in the %BIF file. */
		String objectName;
		/*! The component's layout name stored in the %BIF file. */
		String layoutName;
		/*! The level of compression used for storing the channel data in the %BIF file. */
		Compression compression;
	};

	//*************************************************************************
	/*! \class JobResult bifrost_bifutils.h
		\brief The %JobResult structure contains the information on the results of 
		a %BIF file operation performed asynchonously. 
		\sa Bifrost::API::FileIO::saveAsync
	*/
	//*************************************************************************
	struct JobResult
	{		
		/*! Type of job.*/
		enum Type {
			None=0,	/*!< Unknown type. */ 
			Save,	/*!< Save operation. */ 
			Load	/*!< Load operation. */ 
		};

		/*! State of the job. */
		enum State {
			Success=0,	/*!< Job completed with success. */ 
			Failure,	/*!< Job filed to complete. */ 
			Pending		/*!< Job is pending. */ 
		};

		JobResult() 
			: jobType(None)
			, status(Failure)
			, frame(0)
		{}

		/*! Type of job. */
		Type jobType;	
		/*! Job result state. */
		State status;
		/*! Frame for which the job was submitted. */
		int frame;		
		/*! File path used for the job. */
		String filePath;	
		/*! Component target for the job. */
		String componentName;	
	};

	/*! Query the result of asynchronous %BIF operations like Bifrost::API::FileIO::saveAsync. Once an aynchronous operation is
	terminated, its result is put on a queue and made available for query. If the result is ready, the function returns true along 
	with a new JobResult structure containing the details of the results. The method removes the result entry from the queue if the 
	result is ready. 
	\param job The job id for the operation to query. 
	\param result Output data structure containing the result of the operation.  The returned structure is empty if the operation has not completed yet.
	\return true if the result is ready, false if not ready or the job id is invalid.

	\code
	// Example to illustrate how to query the result of an asynchronous save operation.
	#include <bifrostapi/bifrost_fileio.h>
	#include <bifrostapi/bifrost_om.h>
	#include <bifrostapi/bifrost_stateserver.h>
	#include <bifrostapi/bifrost_component.h>
	#include <bifrostapi/bifrost_types.h>
	#include <bifrostapi/bifrost_bifutils.h>
	#include <iostream>

	using namespace Bifrost::API;

	// create the component 
	ObjectModel om;
	StateServer ss = om.createStateServer();
	Component comp = ss.createComponent( VoxelComponentType, "voxel" );

	// get the FileIO object
	FileIO fio = comp.createFileIO( "test.bif" );

	// Save the component with level1 compression at frame 5
	BIF::JobID job;
	fio.saveAsync( BIF::Compression::Level1, 5, job );	

	// The following code is typically run via a timer or a message posted in the main application loop
	BIF::JobResult jobResult;
	if ( BIF::queryJobResult( job, jobResult ) ) {
		std::cout << "Job #" << job << " is completed" << std::endl;
		std::cout << "Job status: " << jobResult.status << std::endl;
		std::cout << "File name: " << jobResult.filePath << std::endl;
	}
	\endcode
	*/
	BIFROST_API_DECL bool queryJobResult( JobID job, JobResult& result );

} // BIF
} // API
} // Bifrost
#endif // _BIFROST_BIFUTILS_H_