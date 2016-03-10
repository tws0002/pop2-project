//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#ifndef _bifrostObjectUserData_h_
#define _bifrostObjectUserData_h_

#include <bifrostapi/bifrost_om.h>
#include <bifrostapi/bifrost_stateserver.h>
#include <bifrostapi/bifrost_object.h>
#include <bifrostapi/bifrost_layout.h>
#include <bifrostapi/bifrost_channel.h>
#include <bifrostapi/bifrost_component.h>
#include <bifrostapi/bifrost_fileio.h>
#include <bifrostapi/bifrost_status.h>

#include <string>

//==============================================================================
// BifrostObjectUserData
//==============================================================================

class BifrostObjectUserData
{
public:
	BifrostObjectUserData() {}
	BifrostObjectUserData(const std::string& object, const std::string& file);
	~BifrostObjectUserData() {}

	const std::string& object() const { return m_object; }
	const std::string& file()   const { return m_file; }

	// Check whether the state server and object exist
	bool objectExists() const;

	// Return the state server
	Bifrost::API::Ref stateServer() const;

	// Find the channel within this object
	Bifrost::API::Ref findChannel(const Bifrost::API::TypeID& componentType, const char* channelName) const;

	// Find the voxel channel within the default voxel component
	Bifrost::API::Ref findVoxelChannel(const char* channelName) const;

	// Find the point channel within the default point component
	Bifrost::API::Ref findPointChannel(const char* channelName) const;

	// Create a new channel
	Bifrost::API::Ref createChannel(
		const Bifrost::API::TypeID&		componentType,
		const Bifrost::API::DataType&	dataType,
		const char*						channelName);

	// Load the object data from the file
	bool loadFromFile(const float frame);

	// JSON object serialization
	static bool parseJsonObject(const std::string& json, unsigned int& ssid, std::string& object);
	static std::string writeJsonObject(const unsigned int ssid, const std::string& object);

private:
	std::string m_object;
	std::string	m_file;
};

#endif // _bifrostObjectUserData_h_
