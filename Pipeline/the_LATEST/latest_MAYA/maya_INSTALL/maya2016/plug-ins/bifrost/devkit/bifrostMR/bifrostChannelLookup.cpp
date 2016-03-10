//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostMentalrayHelpers.h"
#include "bifrostObjectUserData.h"

#include <bifrostapi/bifrost_voxelchannel.h>
#include <bifrostapi/bifrost_voxelsampler.h>

#include <shader.h>

#include <cctype>
#include <string>

namespace
{

// Matching the maya_vertexdata inputs in mayabase.mi
// PVN -> PerVertexNomenclature
struct PVNEntry
{
	miTag name;
	miInteger type;
	miInteger size;
	miInteger offset;
};

struct PVNArray
{
	int i;
	int n;
	PVNEntry e[1];
};

struct PVNUserData
{
	miInteger magic;
	PVNArray data;
	PVNArray uvs;
	PVNArray cpv;
};

const miInteger		gPVNMagic		= 1298749048;
const std::string	gPVNDeclName	= "maya_vertexdata";

// Templates to help convert Bifrost types to Shader types
template<typename FROM, typename TO>
TO ConvertType(const FROM& src) { mi_warning("Bad type conversion"); return TO(); }

// float -> miScalar/miVector/miColor
template<>
miScalar ConvertType<float,miScalar>(const float& src)
{
	return src;
}

template<>
miVector ConvertType<float,miVector>(const float& src)
{
	miVector dst = {src, src, src};
	return dst;
}

template<>
miColor ConvertType<float,miColor>(const float& src)
{
	miColor dst = {src, src, src, 1.0f};
	return dst;
}

// amino::Math::vec2f -> miScalar/miVector/miColor
template<>
miScalar ConvertType<amino::Math::vec2f,miScalar>(const amino::Math::vec2f& src)
{
	return std::sqrt(src[0] * src[0] + src[1] * src[1]);
}

template<>
miVector ConvertType<amino::Math::vec2f,miVector>(const amino::Math::vec2f& src)
{
	miVector dst = {src[0], src[1], 0.0f};
	return dst;
}

template<>
miColor ConvertType<amino::Math::vec2f,miColor>(const amino::Math::vec2f& src)
{
	miColor dst = {src[0], src[1], 0.0f, 1.0f};
	return dst;
}

// amino::Math::vec3f -> miScalar/miVector/miColor
template<>
miScalar ConvertType<amino::Math::vec3f,miScalar>(const amino::Math::vec3f& src)
{
	return std::sqrt(src[0] * src[0] + src[1] * src[1] + src[2] * src[2]);
}

template<>
miVector ConvertType<amino::Math::vec3f,miVector>(const amino::Math::vec3f& src)
{
	miVector dst = {src[0], src[1], src[2]};
	return dst;
}

template<>
miColor ConvertType<amino::Math::vec3f,miColor>(const amino::Math::vec3f& src)
{
	miColor dst = {src[0], src[1], src[2], 1.0f};
	return dst;
}

// Retreive a colorSet index by name
// This requires the "Export Vertex Colors" global mental ray option to be turned on.
int getMayaColorSetIndex(const miTag& instance, const std::string& cpvName)
{
	// Get the object from the instance
	miTag tagItem = miNULLTAG;
	{
		mi_query(miQ_INST_ITEM, NULL, instance, &tagItem);
		if (tagItem == miNULLTAG)
			return -1;
	}

	// Loop over the user data chain
	miTag tagUserData = miNULLTAG;
	for (mi_query(miQ_OBJ_DATA, NULL, tagItem, &tagUserData);
		tagUserData != miNULLTAG;
		mi_query(miQ_DATA_NEXT, NULL, tagUserData, &tagUserData))
	{
		// Check the user data declaration
		miTag tagUserDataDecl = miNULLTAG;
		{
			// Check for NULL declaration
			mi_query(miQ_DATA_DECL, NULL, tagUserData, &tagUserDataDecl);
			if (tagUserDataDecl == miNULLTAG)
				continue;

			// Check declaration name
			const char* name = mi_api_tag_lookup(tagUserDataDecl);
			if (!name || gPVNDeclName != name)
				continue;
		}

		// Check the magic number
		const PVNUserData* datablock = NULL;
		{
			// Check for NULL user data
			mi_query(miQ_DATA_PARAM, NULL, tagUserData, &datablock);
			if (datablock == NULL)
				continue;

			// Check for the magic number
			if (datablock->magic !=gPVNMagic)
				continue;
		}

		// Loop over the cpv entries to search for the specified name
		const PVNEntry* entry = (const PVNEntry*)(datablock->cpv.e + datablock->cpv.i);
		for (int i = 0; i < datablock->cpv.n; i++)
		{
			if (cpvName == miTag2String(entry[i].name))
			{
				// Found it
				return entry[i].offset + datablock->data.n;
			}
		}
	}

	// Special case for render swatches
	const char* shapeName = mi_api_tag_lookup(tagItem);
	if (shapeName)
	{
		if (std::string(shapeName) == "swatch::miSwatchPreviewReserved_bifrostLiquidShape")
		{
			if (cpvName == "bifrostVelocity")
				return 0;
			if (cpvName == "bifrostVorticity")
				return 1;
		}
	}

	return -1;
}

// Find the user vector index by its name in vertex info
int getNamedUserVectorIndex(miState* state, const char* name)
{
	// Query the number of user vectors
	int numUserVectors = 0;
	mi_query(miQ_NUM_USERS, state, 0, &numUserVectors);

	if (numUserVectors == 0)
		return -1;

	// Query the vertex info by name
	miApi_vertexinfo vertexInfo;
	if (!mi_query(miQ_PRI_VERTEX_INFO, state, 0, &vertexInfo, name))
		return -1;

	if (vertexInfo.kind != 'u' || vertexInfo.type != miAPI_VERTEXINFO_TYPE_COLOR)
		return -1;

	return (int)vertexInfo.index;
}

// Evaluate a float3 colorset by name
bool evalColorSet(miState* state, const std::string& cpvName, miVector& result)
{
	// Try index from Maya colorset
	int cpvIndex = getMayaColorSetIndex(state->instance, cpvName);

	// Try index from named user vector
	if (cpvIndex == -1)
		cpvIndex = getNamedUserVectorIndex(state, cpvName.c_str());

	if (cpvIndex >= 0)
	{
		// Get the cpv values at index
		const miVector* cpv[3];
		if (mi_tri_vectors(state, '*', cpvIndex, cpv + 0, cpv + 1, cpv + 2))
		{
			result.x = cpv[0]->x * state->bary[0] + cpv[1]->x * state->bary[1] + cpv[2]->x * state->bary[2];
			result.y = cpv[0]->y * state->bary[0] + cpv[1]->y * state->bary[1] + cpv[2]->y * state->bary[2];
			result.z = cpv[0]->z * state->bary[0] + cpv[1]->z * state->bary[1] + cpv[2]->z * state->bary[2];
			return true;
		}
	}

	return false;
}

// Evaluate a particle map field by name
template<typename T>
bool evalMapField(miState* state, const std::string& fieldName, T& result)
{
	// Get the map object from state instance
	miObjectAccess<miInstance> instance(state->instance);
	miObjectAccess<miObject> object(instance->item);

	// Get the tag of the map object
	miTag tagMap;
	if (object->type == miOBJECT_PLACEHOLDER)
	{
		miObjectAccess<miObject> placeholder(object->geo.placeholder_list.object);
		tagMap = placeholder->geo.map;
	}
	else if (object->type == miOBJECT_MAP)
		tagMap = object->geo.map;
	else
		return false;

	mi::shader::Map_status status;
	mi::shader::Access_map map(tagMap);

	// Special treatment of position
	if (fieldName == "position")
	{
		miUint particleIndex = 0;

		// Hit particle index
		if (!mi_query(miQ_PRI_PARTICLE_INDEX, state, tagMap, &particleIndex))
			return false;

		// Point the hit particle
		mi::shader::Map_iterator_access it(map);
		status = it->set_to(particleIndex);

		if (!status.is_ok())
			return false;

		// Return the position
		miVector position;
		status = it->get_position(position);

		if (!status.is_ok())
			return false;

		result = ConvertType<amino::Math::vec3f,T>(
			amino::Math::vec3f(position.x, position.y, position.z)
		);
		return true;
	}

	// Get the field id
	mi::shader::Map_declaration declaration(map, &status);
	if (!status.is_ok())
		return false;

	mi::shader::Map_field_id fieldId = declaration->get_field_id(fieldName.c_str(), &status);
	if (!status.is_ok())
		return false;

	// Get the field info
	mi::shader::Map_field_type	fieldType;
	miUint						fieldDimension;
	bool						fieldIsGlobal;
	status = declaration->get_field_info(fieldId, fieldType, fieldDimension, fieldIsGlobal);
	if (!status.is_ok() || fieldIsGlobal)
		return false;

	// Assume we are not getting a global field
	miUint particleIndex = 0;

	// Hit particle index
	if (!mi_query(miQ_PRI_PARTICLE_INDEX, state, tagMap, &particleIndex))
		return false;

	// Point the hit particle
	mi::shader::Map_iterator_access it(map);
	status = it->set_to(particleIndex);

	if (!status.is_ok())
		return false;

	// Get and convert the field value
	switch (fieldType.type())
	{
	case mi::shader::Map_field_type::Scalar:
		{
			miScalar v;
			if (!it->get(fieldId, v).is_ok())
				return false;
			result = ConvertType<float,T>(v);
			return true;
		}
	case mi::shader::Map_field_type::Vector:
		{
			miVector v;
			if (!it->get(fieldId, v).is_ok())
				return false;
			result = ConvertType<amino::Math::vec3f,T>(
				amino::Math::vec3f(v.x, v.y, v.z)
			);
			return true;
		}
	case mi::shader::Map_field_type::Color:
		{
			miColor v;
			if (!it->get(fieldId, v).is_ok())
				return false;
			result = ConvertType<amino::Math::vec3f,T>(
				amino::Math::vec3f(v.r, v.g, v.b)
			); // note that we don't have float4 channel yet
			return true;
		}
	}

	return false;
}


template<typename T>
bool SampleValue(const amino::Math::vec3f& p, const Bifrost::API::VoxelSampler& sampler, T& result)
{
	// Handle different channel types
	switch (sampler.dataType())
	{
	case Bifrost::API::FloatType:
		result = ConvertType<float,T>(sampler.sample<float>(p));
		return true;

	case Bifrost::API::FloatV2Type:
		result = ConvertType<amino::Math::vec2f,T>(sampler.sample<amino::Math::vec2f>(p));
		return true;

	case Bifrost::API::FloatV3Type:
		result = ConvertType<amino::Math::vec3f,T>(sampler.sample<amino::Math::vec3f>(p));
		return true;
	}

	return false;
}

template<typename T>
bool SampleGradient(const amino::Math::vec3f& p, const Bifrost::API::VoxelSampler& sampler, T& result)
{
	// Handle different channel types
	if (sampler.dataType() == Bifrost::API::FloatType)
	{
		amino::Math::vec3f gradient;
		sampler.sampleGradient<float>(p, gradient);
		result = ConvertType<amino::Math::vec3f,T>(gradient);
		return true;
	}
	else
	{
		// We only support float1 channel
		return false;
	}
}

// The channel lookup shader looks up a voxel channel in world space by the
// given voxel channel name.
// Note that per-instance shader is already allocated per-thread so we don't need a sampler pool.
template<typename T, bool GRADIENT = false>
class ChannelLookupShader
{
public:
	struct Params
	{
		T		defaultValue;	// Default value if sampling fails
		miTag	channel;		// Name of the channel
	};

	ChannelLookupShader()
		: m_channelIsVelocity(false)
	{}

	miBoolean init(miState* state, Params* paras);
	miBoolean execute(T* result, miState* state, Params* paras);
	miBoolean exit(miState* state, Params* paras) { return miTRUE; }

	bool handleColorSets(T* result, miState* state, Params* paras);
	bool handleMapFields(T* result, miState* state, Params* paras);
	bool handleVoxelChannel(T* result, miState* state, Params* paras);

private:
	// Voxel sampler for the specified channel
	Bifrost::API::VoxelSampler m_sampler;

	// Special treatment for velocity channel because it consists of 3 channels
	bool						m_channelIsVelocity;
	Bifrost::API::VoxelSampler	m_samplerVelocityU;
	Bifrost::API::VoxelSampler	m_samplerVelocityV;
	Bifrost::API::VoxelSampler	m_samplerVelocityW;

	// When rendering a mesh, we use the colorsets if possible
	std::string m_colorsetName;

	// When rendering a map object, we use the fields if possible
	std::string m_mapFieldName;
};

template<typename T, bool GRADIENT>
miBoolean ChannelLookupShader<T,GRADIENT>::init(miState* state, Params* paras)
{
	// Get the channel name
	const std::string channelName = miTag2String(*mi_eval_tag(&paras->channel));
	if (channelName.empty())
		return miTRUE;  // Use default instead of failure

	// Convert the channel name to colorset name. e.g. velocity -> bifrostVelocity
	m_colorsetName = "bifrost";
	m_colorsetName += (char)std::toupper(channelName[0]);
	if (channelName.size() > 1)
		m_colorsetName += channelName.c_str() + 1;

	// The map field name is identical to the channel name
	m_mapFieldName = channelName;

	// Find the object user data on the instance
	BifrostObjectUserData objectRef;
	if (!miFindBifrostObjectUserData(state, objectRef))
		return miTRUE;  // Use default instead of failure

	// Initialize the voxel channel sampler
	if (channelName == "velocity")
	{
		// Sampling 3 velocity channels: velocity_u, velocity_v and velocity_w
		m_channelIsVelocity = true;

		// Find the 3 velocity voxel channels from the state server
		Bifrost::API::VoxelChannel velocityU = objectRef.findVoxelChannel("velocity_u");
		Bifrost::API::VoxelChannel velocityV = objectRef.findVoxelChannel("velocity_v");
		Bifrost::API::VoxelChannel velocityW = objectRef.findVoxelChannel("velocity_w");
		if (!velocityU.valid() || !velocityV.valid() || !velocityW.valid())
		{
			mi_warning("Can't find voxel channel: %s velocity_u velocity_v velocity_w", objectRef.object().c_str());
			return miTRUE;  // Use default instead of failure
		}

		// Create the samplers for the velocity channel
		mi_debug("Using voxel channel: %s velocity_u velocity_v velocity_w", objectRef.object().c_str());
		m_samplerVelocityU = velocityU.createSampler(Bifrost::API::VoxelSamplerQBSplineType, Bifrost::API::WorldSpace);
		m_samplerVelocityV = velocityV.createSampler(Bifrost::API::VoxelSamplerQBSplineType, Bifrost::API::WorldSpace);
		m_samplerVelocityW = velocityW.createSampler(Bifrost::API::VoxelSamplerQBSplineType, Bifrost::API::WorldSpace);
	}
	else
	{
		// Find the voxel channel from the state server
		Bifrost::API::VoxelChannel channel = objectRef.findVoxelChannel(channelName.c_str());
		if (!channel.valid())
		{
			mi_warning("Can't find voxel channel: %s %s", objectRef.object().c_str(), channelName.c_str());
			return miTRUE;  // Use default instead of failure
		}

		// Create the sampler for the specified channel
		mi_debug("Using voxel channel: %s %s", objectRef.object().c_str(), channelName.c_str());
		m_sampler = channel.createSampler(Bifrost::API::VoxelSamplerQBSplineType, Bifrost::API::WorldSpace);
	}

	return miTRUE;
}

template<typename T, bool GRADIENT>
miBoolean ChannelLookupShader<T,GRADIENT>::execute(T* result, miState* state, Params* paras)
{
	// Use colorset if possible
	bool success = handleColorSets(result, state, paras);

	// Use map field if possible
	if (!success)
	{
		success = handleMapFields(result, state, paras);
	}

	// Use voxel samplers
	if (!success)
	{
		success = handleVoxelChannel(result, state, paras);
	}

	// Eval the default value on failure
	if (!success)
	{
		*result = *(T*)mi_eval(state, &paras->defaultValue);
	}

	return miTRUE;
}

template<typename T, bool GRADIENT>
bool ChannelLookupShader<T,GRADIENT>::handleColorSets(T* result, miState* state, Params* paras)
{
	// Gradient is not available from colorsets
	if (GRADIENT)
		return false;

	// Check for NULL state instance
	if (!state->instance)
		return false;

	// Get the values from colorset
	miVector value = {0.0f, 0.0f, 0.0f};
	if (!evalColorSet(state, m_colorsetName, value))
		return false;

	// Convert to the requested type
	*result = ConvertType<amino::Math::vec3f,T>(
		amino::Math::vec3f(value.x, value.y, value.z)
	);
	return true;
}

template<typename T, bool GRADIENT>
bool ChannelLookupShader<T,GRADIENT>::handleMapFields(T* result, miState* state, Params* paras)
{
	// Gradient is not available from map objects
	if (GRADIENT)
		return false;

	// Check for NULL state instance
	if (!state->instance)
		return false;

	// Get the values from colorset
	return evalMapField(state, m_mapFieldName, *result);
}

template<typename T, bool GRADIENT>
bool ChannelLookupShader<T,GRADIENT>::handleVoxelChannel(T* result, miState* state, Params* paras)
{
	// Convert the current intersection point to world space
	amino::Math::vec3f p;
	mi_point_to_world(state, (miVector*)&p, &state->point);

	bool success = false;
	if (m_channelIsVelocity)
	{
		// Sampling velocity_u, velocity_v and velocity_w channels
		if (m_samplerVelocityU.valid() &&
			m_samplerVelocityV.valid() &&
			m_samplerVelocityW.valid() &&
			!GRADIENT)
		{
			miVector velocity = {0.0f, 0.0f, 0.0f};

			success =            SampleValue<miScalar>(p, m_samplerVelocityU, velocity.x);
			success = success && SampleValue<miScalar>(p, m_samplerVelocityV, velocity.y);
			success = success && SampleValue<miScalar>(p, m_samplerVelocityW, velocity.z);

			if (success)
			{
				*result = ConvertType<amino::Math::vec3f,T>(
					amino::Math::vec3f(velocity.x, velocity.y, velocity.z)
				);
			}
		}
	}
	else
	{
		// Sample the voxel channel by the given world space location
		if (m_sampler.valid())
		{
			if (GRADIENT)
			{
				success = SampleGradient<T>(p, m_sampler, *result);
			}
			else
			{
				success = SampleValue<T>(p, m_sampler, *result);
			}
		}
	}

	return success;
}

} // anonymous namespace

//==============================================================================
// bifrost_scalar_channel
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_scalar_channel(miScalar* result, miState* state, void* paras)
{
	return miShaderUserPerInstanceExecute<ChannelLookupShader<miScalar> >(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_scalar_channel_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserPerInstanceInit<ChannelLookupShader<miScalar> >(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_scalar_channel_exit(miState* state, void* paras)
{
	miShaderUserPerInstanceExit<ChannelLookupShader<miScalar> >(state, paras);
}

extern "C" DLLEXPORT
int bifrost_scalar_channel_version(void)
{
	return 1;
}

//==============================================================================
// bifrost_vector_channel
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_vector_channel(miVector* result, miState* state, void* paras)
{
	return miShaderUserPerInstanceExecute<ChannelLookupShader<miVector> >(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_vector_channel_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserPerInstanceInit<ChannelLookupShader<miVector> >(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_vector_channel_exit(miState* state, void* paras)
{
	miShaderUserPerInstanceExit<ChannelLookupShader<miVector> >(state, paras);
}

extern "C" DLLEXPORT
int bifrost_vector_channel_version(void)
{
	return 1;
}

//==============================================================================
// bifrost_color_channel
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_color_channel(miColor* result, miState* state, void* paras)
{
	return miShaderUserPerInstanceExecute<ChannelLookupShader<miColor> >(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_color_channel_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserPerInstanceInit<ChannelLookupShader<miColor> >(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_color_channel_exit(miState* state, void* paras)
{
	miShaderUserPerInstanceExit<ChannelLookupShader<miColor> >(state, paras);
}

extern "C" DLLEXPORT
int bifrost_color_channel_version(void)
{
	return 1;
}

//==============================================================================
// bifrost_scalar_channel_grad
//==============================================================================

extern "C" DLLEXPORT
miBoolean bifrost_scalar_channel_grad(miVector* result, miState* state, void* paras)
{
	return miShaderUserPerInstanceExecute<ChannelLookupShader<miVector,true> >(result, state, paras);
}

extern "C" DLLEXPORT
void bifrost_scalar_channel_grad_init(miState* state, void* paras, miBoolean* inst_req)
{
	miShaderUserPerInstanceInit<ChannelLookupShader<miVector,true> >(state, paras, inst_req);
}

extern "C" DLLEXPORT
void bifrost_scalar_channel_grad_exit(miState* state, void* paras)
{
	miShaderUserPerInstanceExit<ChannelLookupShader<miVector,true> >(state, paras);
}

extern "C" DLLEXPORT
int bifrost_scalar_channel_grad_version(void)
{
	return 1;
}

