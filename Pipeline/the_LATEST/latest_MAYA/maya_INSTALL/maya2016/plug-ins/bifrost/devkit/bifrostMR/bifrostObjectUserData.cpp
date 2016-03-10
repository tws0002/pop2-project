//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostObjectUserData.h"
#include "rapidjson.h"

#include <bifrostapi/bifrost_array.h>
#include <bifrostapi/bifrost_ref.h>

#include <shader.h> // for mi_warning only

#include <map>
#include <iomanip>

namespace
{

// A global cache to hold the state servers for cache files.
static std::map<std::string,Bifrost::API::StateID> gFileStateServers;

}

BifrostObjectUserData::BifrostObjectUserData(const std::string& object, const std::string& file)
	: m_object(object), m_file(file)
{}

bool BifrostObjectUserData::objectExists() const
{
	// Parse the JSON object representation
	unsigned int ssid;
	std::string object;
	if (!parseJsonObject(m_object, ssid, object))
		return false;

	// Find the state server.
	Bifrost::API::ObjectModel om;
	Bifrost::API::StateServer state = om.stateServer(ssid);
	if (!state.valid())
		return false;

	// Find the object within the state server.
	Bifrost::API::Object obj = state.findObject(object.c_str());
	if (!obj.valid())
		return false;

	return true;
}

Bifrost::API::Ref BifrostObjectUserData::stateServer() const
{
	// Parse the JSON object representation
	Bifrost::API::StateID ssid;
	std::string object;
	if (!parseJsonObject(m_object, ssid, object))
		return Bifrost::API::Ref();

	// Find the state server
	Bifrost::API::ObjectModel om;
	return om.stateServer(ssid);
}

Bifrost::API::Ref BifrostObjectUserData::findChannel(const Bifrost::API::TypeID& componentType, const char* channelName) const
{
	// Parse the JSON object representation
	Bifrost::API::StateID ssid;
	std::string objectName;
	if (!parseJsonObject(m_object, ssid, objectName))
		return Bifrost::API::Ref();

	// Find the state server
	Bifrost::API::ObjectModel om;
	Bifrost::API::StateServer state = om.stateServer(ssid);
	if (!state.valid())
		return Bifrost::API::Ref();

	// Find the object
	Bifrost::API::Object object = state.findObject(objectName.c_str());
	if (!object.valid())
		return Bifrost::API::Ref();

	// Find the first component that matches the component type
	Bifrost::API::Component component;
	{
		Bifrost::API::RefArray components = object.findComponentsByType(componentType);
		if (components.count() == 0)
			return Bifrost::API::Ref();
		component = components[0];

		// Workaround: When scratch cache is off, we have both flip and render components
		//             in AeroObject. FLIP component is used in simulation so we should
		//             not use them for display.
		//             We don't have this problem when scratch cache is on because flip
		//             channels are not scoped.
		//             Currently, we have to distinguish the components by name..
		Bifrost::API::String preferredComponentName;
		if (componentType == Bifrost::API::VoxelComponentType)
			preferredComponentName = object.name() + "-volume";
		else if (componentType == Bifrost::API::PointComponentType)
			preferredComponentName = object.name() + "-particle";

		for (size_t i = 0; i < components.count(); i++)
		{
			const Bifrost::API::String componentName =
				Bifrost::API::Component(components[i]).name();
			if (componentName == preferredComponentName)
			{
				component = components[i];
				break;
			}
		}
	}

	// New style: object.component.channel
	Bifrost::API::Channel channel = component.findChannel(channelName);

	// Old style: object-component/channel
	if (!channel.valid())
	{
		Bifrost::API::String componentName = component.name();
		Bifrost::API::String oldStyleName  = componentName + "/" + channelName;

		// Already prefixed by object- ?
		Bifrost::API::String objectPrefix  = Bifrost::API::String(objectName.c_str()) + "-";
		if (oldStyleName.compare(0, objectPrefix.length(), objectPrefix) != 0)
			oldStyleName = objectPrefix + oldStyleName;

		// Now the channel name is in the form of object-component/channel
		channel = component.findChannel(oldStyleName);
	}

	// Not found ..
	return channel;
}

Bifrost::API::Ref BifrostObjectUserData::findVoxelChannel(const char* channelName) const
{
	return findChannel(Bifrost::API::VoxelComponentType, channelName);
}

Bifrost::API::Ref BifrostObjectUserData::findPointChannel(const char* channelName) const
{
	return findChannel(Bifrost::API::PointComponentType, channelName);
}

Bifrost::API::Ref BifrostObjectUserData::createChannel(
	const Bifrost::API::TypeID&		componentType,
	const Bifrost::API::DataType&	dataType,
	const char*						channelName)
{
	// Parse the JSON object representation
	Bifrost::API::StateID ssid;
	std::string objectName;
	if (!parseJsonObject(m_object, ssid, objectName))
		return Bifrost::API::Ref();

	// Find the state server
	Bifrost::API::ObjectModel om;
	Bifrost::API::StateServer state = om.stateServer(ssid);
	if (!state.valid())
		return Bifrost::API::Ref();

	// Find the object
	Bifrost::API::Object object = state.findObject(objectName.c_str());
	if (!object.valid())
		return Bifrost::API::Ref();

	// Delete the existing channel with the same name
	Bifrost::API::Channel channel = findChannel(componentType, channelName);
	if (channel.valid())
	{
		state.removeChannel(channel.partialPathName());
		channel = Bifrost::API::Ref();
	}

	// Find the first component that matches the component type
	Bifrost::API::Component component;
	{
		Bifrost::API::RefArray components = object.findComponentsByType(componentType);
		for (size_t i = 0; i < components.count(); i++)
		{
			if (components[i].valid())
			{
				component = components[i];
				break;
			}
		}

		if (!component.valid())
			return Bifrost::API::Ref();
	}

	// Create the new channel
	return state.createChannel(component, dataType, channelName);
}

bool BifrostObjectUserData::loadFromFile(const float frame)
{
	// Parse the JSON object representation
	unsigned int ssid;
	std::string object;
	if (!parseJsonObject(m_object, ssid, object))
		return false;

	// Strip the |main|1 part of the object name when loading from a file
	{
		size_t firstBar = object.find('|');
		if (firstBar != std::string::npos)
			object = object.substr(0, firstBar);
	}

	// file includes both the cacheDir and the cacheName. This was done to reduce the changes to the .mi parameters.
	// file has the cacheDir and cacheName so we extract them
	std::string cacheDir, cacheName;
	{
		if (m_file.size() > 1) // protect size()-1
		{
			size_t lastSlash = m_file.rfind('/');
			if (lastSlash != std::string::npos && lastSlash != m_file.size()-1)
			{
				cacheDir  = m_file.substr(0, lastSlash);
				cacheName = m_file.substr(lastSlash + 1);
			}
		}
	}

	// Determine the final BIF file name
	std::string bif;
	{
		const std::string path = cacheDir + cacheName + ".#.bif";
		const int frameNumber  = (int)floorf(frame);
		bif = Bifrost::API::File::resolveFramePadding(path.c_str(), frameNumber).c_str();
	}

	// Load BIF cache now
	Bifrost::API::ObjectModel om;
	Bifrost::API::FileIO fileio = om.createFileIO( bif.c_str() );
	Bifrost::API::StateServer state = fileio.load();
	if (!state.valid())
	{
		mi_warning("Unable to load BIF cache: %s", bif.c_str());
		return false;
	}

	// Update the JSON object
	m_object = writeJsonObject((unsigned int)state.stateID(), object);

	// Dispose the previous file state server.
	// This means we are rendering a second frame and this usually happen when calling mental ray standalone with a sequence of files.
	{
		// Find the state server that we were using
		std::map<std::string,Bifrost::API::StateID>::iterator it =
			gFileStateServers.find(m_file);
		if (it != gFileStateServers.end())
		{
			// Delete the previous state server
			om.removeStateServer(it->second);
			gFileStateServers.erase(it);
		}
	}

	// Keep the StateID to the file state server.
	// In our case, we want one state server per bifrostShape, and we clear it manually every time a render starts.
	gFileStateServers[m_file] = state.stateID();
	return true;
}

bool BifrostObjectUserData::parseJsonObject(const std::string& json, unsigned int& ssid, std::string& object)
{
	if (json.empty())
		return false;

	// Parse the JSON object representation
	rapidjson::Document doc;
	doc.Parse<0>(json.c_str());

	// Check the DOM object
	if (!doc.HasParseError() && doc.HasMember("StateServerID") && doc.HasMember("Object"))
	{
		ssid	= doc["StateServerID"].GetUint();
		object	= doc["Object"].GetString();
		return true;
	}

	return false;
}

std::string BifrostObjectUserData::writeJsonObject(const unsigned int ssid, const std::string& object)
{
	rapidjson::StringBuffer buff;
	rapidjson::Writer<rapidjson::StringBuffer> writer(buff);

	writer.StartObject();
	writer.String("StateServerID");
	writer.Uint(ssid);
	writer.String("Object");
	writer.String(object.c_str());
	writer.EndObject();

	std::string json(buff.GetString());
	return json;
}
