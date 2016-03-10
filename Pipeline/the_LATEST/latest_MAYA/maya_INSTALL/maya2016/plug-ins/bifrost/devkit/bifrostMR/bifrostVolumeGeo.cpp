//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostHelpers.h"
#include "bifrostMentalrayHelpers.h"
#include "bifrostObjectUserData.h"

#include <geoshader.h>

//==============================================================================
// bifrost_volume_geo 
//==============================================================================

struct bifrost_volume_geo_params
{
	miTag		object;
	miTag		file;
	miScalar	frame;
};

extern "C" DLLEXPORT
miBoolean bifrost_volume_geo(miTag* result, miState* state, bifrost_volume_geo_params* paras)
{
	// Determine the location of Bifrost data
	std::string object		= miTag2String(*mi_eval_tag(&paras->object));
	std::string file		= miTag2String(*mi_eval_tag(&paras->file));

	// Check if we have hot data in the current state server
	BifrostObjectUserData objectRef(object, file);
	if (!objectRef.objectExists())
	{
		// The specified object doesn't exist in the current state server.
		// Try to load the object from the cache file.
		const float frame = *mi_eval_scalar(&paras->frame);
		const bool loaded = objectRef.loadFromFile(frame);

		if (!loaded || !objectRef.objectExists())
		{
			// Object not found
			mi_warning("Unable to resolve bifrost object: %s %s", file.c_str(), object.c_str());
			return miFALSE;
		}
	}

	// Create a box geometry shader
	miTag tagBoxGeo = miNULLTAG;
	{
		miFunctionCall boxGeoCall("mib_geo_cube");
		tagBoxGeo = boxGeoCall.end();
	}

	// Create an instance for the cube.
	// Tweak the matrix to move the cube to fill the bounding box.
	miTag tagBoxInst = miNULLTAG;
	{
		miInstanceCall boxInst("bifrost_volume_geo[i]");
		
		// Compute the matrix to transform the unit cube to cover simulation domain
		miMatrix cubeMatrix;
		double bboxMin[3] = {0.0, 0.0, 0.0}, bboxMax[3] = {0.0, 0.0, 0.0} ;

		Bifrost::API::Channel chnl = objectRef.findVoxelChannel("smoke");
		ComputeVolumeVoxelBounds(objectRef, chnl, bboxMin, bboxMax);

		// Check if the bounds is valid
		if (bboxMin[0] >= bboxMax[0] || bboxMin[1] >= bboxMax[1] || bboxMin[2] >= bboxMax[2])
		{
			mi_warning("Warning: Empty bounds");
			return miFALSE;
		}

		miBBox2CubeMatrix(bboxMin, bboxMax, cubeMatrix);
		memcpy(boxInst->tf.local_to_global, cubeMatrix, sizeof(miMatrix));
		mi_matrix_invert(boxInst->tf.global_to_local, boxInst->tf.local_to_global);

		// Transfer flags from the parent instance
		{
			miObjectAccess<miInstance> stateInst(state->instance);
			miTransferInstanceFlags(stateInst, boxInst);
		}

		// Attach user data on the instance
		miAttachBifrostObjectUserData(objectRef, boxInst, "bifrost_volume_geo[fosc]");

		tagBoxInst = boxInst.end(tagBoxGeo);
	}

	// Echo the output of this geometry shader for debugging
	miEchoGeoShader(tagBoxInst);

	// Done!
	mi_geoshader_add_result(result, tagBoxInst);
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_volume_geo_version(void)
{
	return 1;
}

//==============================================================================
// bifrost_volume_swatch_geo 
//==============================================================================

struct bifrost_volume_swatch_geo_params
{
	miTag		file;		// Swatch BIF cache file path
	miScalar	frame;		// Swatch BIF cache frame number
};

extern "C" DLLEXPORT
miBoolean bifrost_volume_swatch_geo(miTag* result, miState* state, bifrost_volume_swatch_geo_params* paras)
{
	// Determine the location of Bifrost data
	const std::string	file	= miTag2String(*mi_eval_tag(&paras->file));
	const float			frame	= *mi_eval_scalar(&paras->frame);

	// Load the swatch cache file
	BifrostObjectUserData objectRef("{\"StateServerID\":0,\"Object\":\"AeroObject\"}", file);
	if (!objectRef.loadFromFile(frame) || !objectRef.objectExists())
	{
		mi_warning("Unable to load swatch cache: %s", file.c_str());
		return miFALSE;
	}

	// Create object
	if (miObject* object = mi_api_object_begin(
		mi_mem_strdup("miSwatchPreviewReserved_bifrostAeroShape")))
	{
		miVector v[] = {{-.5,-.5,-.5},{-.5, .5,-.5},{ .5, .5,-.5},{ .5,-.5,-.5},
						{-.5,-.5, .5},{-.5, .5, .5},{ .5, .5, .5},{ .5,-.5, .5}};
		int poly[][4] = {{0,3,7,4},{3,2,6,7},{2,1,5,6},{1,0,4,5},{0,1,2,3},{4,7,6,5}};

		object->visible	 = miTRUE;
		object->shadow   = 0x03;
		object->reflection  = 0x03;
		object->refraction  = 0x03;
		object->finalgather = 0x00;
		object->transparency = 0x03;

		mi_api_basis_list_clear();
		mi_api_object_group_begin(0.0);

		for (int i = 0; i < 8; i++)
		{
			mi_api_vector_xyz_add(&v[i]);
			mi_api_vertex_add(i);
		}

		for (int i = 0; i < 6; i++)
		{
			mi_api_poly_begin_tag(1, 0);
			for (int k = 0; k < 4; k++)
				mi_api_poly_index_add(poly[i][k]);
			mi_api_poly_end();
		}

		mi_api_object_group_end();
		mi_api_object_end();

		// Create Instance
		if (miInstance* instance = mi_api_instance_begin(
			mi_mem_strdup("miSwatchPreviewReserved_bifrostAeroInst")))
		{
			instance->caustic = 3;
			instance->globillum = 3;

			// A hard-code world matrix to fit into the swatch
			miMatrix cubeMatrix;
			double bboxMin[3] = {-10.0, -10.0, -10.0}, bboxMax[3] = {10.0, 10.0, 10.0} ;

			miBBox2CubeMatrix(bboxMin, bboxMax, cubeMatrix);
			memcpy(instance->tf.local_to_global, cubeMatrix, sizeof(miMatrix));
			mi_matrix_invert(instance->tf.global_to_local, instance->tf.local_to_global);

			// Attach user data on the instance
			miAttachBifrostObjectUserData(objectRef, instance, "bifrost_volume_geo[fosc]");

			mi_geoshader_add_result(result, mi_api_instance_end(
				mi_mem_strdup("miSwatchPreviewReserved_bifrostAeroShape"), 0, 0));
			return miTRUE;
		}
	}

	return miFALSE;
}

extern "C" DLLEXPORT
int bifrost_volume_swatch_geo_version(void)
{
	return 1;
}
