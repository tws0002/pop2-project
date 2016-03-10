//*****************************************************************************
/*!
   \file bifrost_fileutils.h
   \brief Bifrost file utility functions.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_FILEUTILS_H_
#define _BIFROST_FILEUTILS_H_

#include <bifrostapi/bifrost_decl.h>
#include <bifrostapi/bifrost_string.h>
#include <bifrostapi/bifrost_types.h>

namespace Bifrost {
namespace API {
namespace File {
	/*! \namespace File
		\brief The %File namespace defines a region where all types, functions and classes related to file and folder
		operations in %Bifrost are declared.
	*/

    /*! Convert the input path separators to forward slashes.
	\param path file path.
	\return New file path with forward slahes.
	*/
	BIFROST_API_DECL String forwardSlashes( const String& path );

    /*! Convert the input path separators to backward slashes.
	\param path file path.
	\return New file path with backward slashes.
	*/
	BIFROST_API_DECL String backwardSlashes( const String& path );

    /*! Convert the input path separators to forward slashes. 
	<b>Note:</b> The function doesn't validate if the path is a valid file.
	\param path File path.
	\return New normalized file path.
	*/
	BIFROST_API_DECL String normalizeFilePath( const String& path );

    /*! Convert the input path separators to forward slashes and appends separator to end of folder path if necessary.
	<b>Note:</b> The function doesn't validate if the path is a valid folder.
	\param path Folder path.
	\return New normalized folder path.
	*/
	BIFROST_API_DECL String normalizeFolderPath( const String& path );

    /*! Convert the input path separators to forward slashes. 
	<b>Note:</b> The function assumes the path points to an existing file or folder. If the path points to an existing folder, 
	an extra separator is appended if necessary. If the path is a folder path that doesn't exist, the path is normalized like a 
	file path. The function doesn t validate the path for an existing file.
	\param path File path or folder path.
	\return New normalized path.
	*/
	BIFROST_API_DECL String normalizePath( const String& path );

    /*! Retrieve the folder from a file path.
	\param path File or folder path. If the path is alredy a folder, the function just returns the path.
	\return Folder path.
	*/
	BIFROST_API_DECL String extractFolderPath( const String& path );

    /*! Returns true if a file path exists, false otherwise. Returns an error message if it doesn't exist.
	\param path File path.
	\param outErrorMsg Error message if something goes wrong.
	\return True if path exists, false otherwise..
	*/
	BIFROST_API_DECL bool filePathExists( const String& path, String& outErrorMsg );

    /*! Resolves a file path with padding for a specific frame value and returns a new resolved file path. The original path
	is returned if the input file path has no padding symbols.

	\param filePath Full file path. Frame position in the filename can be optionally specified with padding symbols like @ and #.
	The symbol # is a shortcut for @@@@@@@@.
	\param frame Frame number (can be negative).
	\return The full path properly formatted.
	\code
	std::cout << "out: " << addPadding( "foo/whale_dad_jump-volume.@.bif", 1 );
	// out: foo/whale_dad_jump-volume.1.bif
	std::cout << "out: " << addPadding( "foo/whale_dad_jump-volume.@@.bif", 1 );
	// out: foo/whale_dad_jump-volume.01.bif
	std::cout << "out: " << addPadding( "foo/whale_dad_jump-volume.@@@.bif", 1 );
	// out: foo/whale_dad_jump-volume.001.bif
	std::cout << "out: " << addPadding( "foo/whale_dad_jump-volume.#.bif", 1 );
	// out: foo/whale_dad_jump-volume.0001.bif
	\endcode
	\sa Bifrost::API::FileIO::setFilename
	*/
	BIFROST_API_DECL String resolveFramePadding( const String& filePath, int frame );

    /*! Returns a unique folder path in the user temp folder.
	\return Newly created folder path or empty path if cannot be created.
	*/
	BIFROST_API_DECL String createTempFolder( );

    /*! Create a folder at a specific location. The function creates intermediate sub folders if they don't exist.
	\param path Folder path.
	\return true if the folder has been created, false otherwise.
	*/
	BIFROST_API_DECL bool createFolder( const String& path );

    /*! Delete the content of a folder and the folder itself.
	\param path Folder path.
	\return true if the folder has been deleted, false otherwise.
	*/
	BIFROST_API_DECL bool deleteFolder( const String& path );

	/*! \struct TempFolder bifrost_fileutils.h
	\brief TempFolder is a utility class for creating a unique temporary folder. The folder is deleted when the TempFolder instance goes out of scope.
	 */
	struct BIFROST_API_DECL TempFolder
	{
		/* Default constructor*/
		TempFolder()
		{
		}

		/* The destructor takes care of delteing the temporary folder along with its content. */
		~TempFolder()
		{
			if (_path.size()) {
				deleteFolder( _path );
			}
		}

		/*! Creates a new temporary folder path and returns it. The new path is stored by the class for subsequent access.
		create one.
		\return Temporary folder path.
		*/
		const String& path()
		{
			if (!_path.size()) {
				_path = createTempFolder();
			}
			return _path;
		}


		private:
		TempFolder( const TempFolder& );
		TempFolder& operator = ( const TempFolder& );
		String _path;
	};
} // API
} // Bifrost
} // File
#endif // _BIFROST_FILEUTILS_H_