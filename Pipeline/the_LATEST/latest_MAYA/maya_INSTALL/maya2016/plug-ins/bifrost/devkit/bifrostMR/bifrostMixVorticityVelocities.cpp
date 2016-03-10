//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include <shader.h>

#include "bifrostMentalrayHelpers.h"

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

// Evaluate a float colorset by name
bool evalColorSet(miState* state, const std::string& cpvName, miScalar& result)
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
			result = cpv[0]->x * state->bary[0] + cpv[1]->x * state->bary[1] + cpv[2]->x * state->bary[2];
			return true;
		}
	}

	return false;
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
bool evalMapField(miState* state, const std::string& fieldName, mi::shader::Map_field_type fieldType, T& result)
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

	// Get the field id
	mi::shader::Map_declaration declaration(map, &status);
	if (!status.is_ok())
		return false;

	mi::shader::Map_field_id fieldId = declaration->get_field_id(fieldName.c_str(), &status);
	if (!status.is_ok())
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

	// Get the field value
	status = it->get(fieldId, result);
	return status.is_ok();
}


} // anonymous namespace

//=============================================================================
// bifrost_mix_vorticity_velocities
//=============================================================================

struct bifrost_mix_vorticity_velocities_params
{
	miScalar	vorticity;
	miScalar	vorticity_factor;
	miScalar	velocity_u;
	miScalar	velocity_v;
	miScalar	velocity_w;
	miScalar	velocity_factor;
};

extern "C" DLLEXPORT
miBoolean bifrost_mix_vorticity_velocities(miScalar* result, miState* state, bifrost_mix_vorticity_velocities_params* paras)
{
	*result = 0.0f;

	// Vorticity Factor
	miScalar vorticityFactor = *mi_eval_scalar(&paras->vorticity_factor);
	if (vorticityFactor > 0.f)
	{
		// Try to evaluate the "bifrostVorticity" colorset, if it fails evaluate the vorticity directly
		miScalar vorticity = 0.f;
		if (!evalColorSet(state, "bifrostVorticity", vorticity) &&
			!evalMapField(state, "vorticity", mi::shader::Map_field_type::Scalar, vorticity))
		{
			vorticity = *mi_eval_scalar(&paras->vorticity);
		}
		*result += vorticity * vorticityFactor;
	}

	// Velocity Factor
	miScalar velocityFactor = *mi_eval_scalar(&paras->velocity_factor);
	if (velocityFactor > 0.f)
	{
		// Try to evaluate the "bifrostVelocity" colorset, if it fails evaluate the velocities directly
		miVector velocity = {0.f,0.f,0.f};
		if (!evalColorSet(state, "bifrostVelocity", velocity) &&
			!evalMapField(state, "velocity", mi::shader::Map_field_type::Vector, velocity))
		{
			velocity.x = *mi_eval_scalar(&paras->velocity_u);
			velocity.y = *mi_eval_scalar(&paras->velocity_v);
			velocity.z = *mi_eval_scalar(&paras->velocity_w);
		}
		miScalar velocityMag = mi_vector_norm(&velocity);

		*result += velocityMag * velocityFactor;
	}

	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_mix_vorticity_velocities_version(void)
{
	return 1;
}
