//*****************************************************************************
/*!
   \file bifrost_const.h
   \brief Constant values declaration used in the Bifrost API classes.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_CONST_H_
#define _BIFROST_CONST_H_

#include <bifrostapi/bifrost_decl.h>

namespace Bifrost {
namespace API {

	/*! 
	\defgroup types Bifrost object types
	@{
	*/
	/*! Undefined object type. This type is used to identify unitialized %Bifrost API objects. */
	extern BIFROST_API_DECL const char* UndefinedType;
	/*! ObjectModel class type */
	extern BIFROST_API_DECL const char* ObjectModelType;
	/*! StateServer class type */
	extern BIFROST_API_DECL const char* StateServerType;
	/*! Dictionary class type */
	extern BIFROST_API_DECL const char* DictionaryType;
	/*! Object class type */
	extern BIFROST_API_DECL const char* ObjectType;
	/*! Component class type */
	extern BIFROST_API_DECL const char* ComponentType;
	/*! Layout class type */
	extern BIFROST_API_DECL const char* LayoutType;
	/*! Channel class type */
	extern BIFROST_API_DECL const char* ChannelType;
	/*! VoxelChannel class type */
	extern BIFROST_API_DECL const char* VoxelChannelType;
	/*! PointChannel class type */
	extern BIFROST_API_DECL const char* PointChannelType;
	/*! The ObjectDictionary Component type */
	extern BIFROST_API_DECL const char* ObjectDictionaryType;
	/*! The Point Component type */
	extern BIFROST_API_DECL const char* PointComponentType;
	/*! The Voxel Component type */
	extern BIFROST_API_DECL const char* VoxelComponentType;
	/*! TileDataAccessor class type */
	extern BIFROST_API_DECL const char* TileDataAccessorType;
	/*! Tile class type */
	extern BIFROST_API_DECL const char* TileType;
	/*! TileIterator class type */
	extern BIFROST_API_DECL const char* TileIteratorType;
	/*! TileAccessor class type */
	extern BIFROST_API_DECL const char* TileAccessorType;
	/*! VoxelSamplerType class type */
	extern BIFROST_API_DECL const char* VoxelSamplerType;
	/*! VoxelSamplerType class type */
	extern BIFROST_API_DECL const char* VoxelSamplerLinearType;
	/*! VoxelSamplerQBSplineType class type */
	extern BIFROST_API_DECL const char* VoxelSamplerQBSplineType;
	/*! VoxelSamplerWENOType class type */
	extern BIFROST_API_DECL const char* VoxelSamplerWENOType;
	/*! ContextType class type */
	extern BIFROST_API_DECL const char* ContextType;
	/*! FileIOType class type */
	extern BIFROST_API_DECL const char* FileIOType;
	/*! TypeBaseType class type */
	extern BIFROST_API_DECL const char* TypeBaseType;
	/*! 
	@}
	*/

	/*! 
	\defgroup BifrostKeys Bifrost standard keys.
	@{
	*/
	/*! State Server identifier context value key. The associated value type is a Bifrost::API::StateID. */
	extern BIFROST_API_DECL const char* StateServerValueKey;
	/*! Time context value key. The associated value type is a float. */
	extern BIFROST_API_DECL const char* TimeValueKey;
	/*! Delta time context value key. The associated value type is a float. */
	extern BIFROST_API_DECL const char* DeltaTimeValueKey;
	/*! Frame context value key. The associated value type is an int. */
	extern BIFROST_API_DECL const char* FrameValueKey;
	/*! Start frame context value key. The associated value type is an int. */
	extern BIFROST_API_DECL const char* StartFrameValueKey;
	/*! Cache path context value key. The associated value type is a Bifrost::API::String. */
	extern BIFROST_API_DECL const char* CachePathValueKey;
    /*! Cache name context value key. The associated value type is a Bifrost::API::String */
    extern BIFROST_API_DECL const char* CacheNameValueKey;
	/*! 
	@}
	*/

	/*! Unknown version number. */
	extern BIFROST_API_DECL const char* UnknownVersion;


} // API
} // Bifrost
#endif // _BIFROST_CONST_H_