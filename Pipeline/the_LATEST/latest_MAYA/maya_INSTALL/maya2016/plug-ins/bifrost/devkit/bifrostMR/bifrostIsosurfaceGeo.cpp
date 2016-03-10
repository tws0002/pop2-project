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
// bifrost_isosurface_geo 
//==============================================================================

enum IsosurfaceGeoMode
{
	kVoxelMode = 0,
	kParticleMode = 1
};

struct bifrost_isosurface_geo_params
{
	miTag		object;
	miTag		file;
	miScalar	frame;
	miScalar	threshold;
	miScalar	minStepSize;
	miScalar	maxStepSize;
	miScalar	maxSteps;
	miScalar	shadowBias;
	miBoolean	computeRedistance;
	miInteger	mode;
	miScalar	particleSize;
	miBoolean	faceCamera;
	miScalar	sharpenVoxels;
};

extern "C" DLLEXPORT
miBoolean bifrost_isosurface_geo(miTag* result, miState* state, bifrost_isosurface_geo_params* paras)
{
	// Determine the working mode: Voxel or Particle
	const IsosurfaceGeoMode mode = (IsosurfaceGeoMode)*mi_eval_integer(&paras->mode);

	// Determine the location of Bifrost data
	std::string object	= miTag2String(*mi_eval_tag(&paras->object));
	std::string file	= miTag2String(*mi_eval_tag(&paras->file));

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

	// Determine the component and channel name
	Bifrost::API::TypeID	componentType;
	std::string				channel;
	{
		if (mode == kVoxelMode)
		{
			componentType	= Bifrost::API::VoxelComponentType;
			channel			= "distance";
		}
		else
		{
			componentType	= Bifrost::API::PointComponentType;
			channel			= "position";
		}
	}

	// Apply sharpen filter to the distance channel
	const miScalar sharpenVoxels = *mi_eval_scalar(&paras->sharpenVoxels);
	if (std::fabs(sharpenVoxels) > miSCALAR_EPSILON && mode == kVoxelMode)
	{
		// Create a temporary sharpen distance channel
		Bifrost::API::VoxelChannel srcChannel = objectRef.findVoxelChannel(channel.c_str());
		Bifrost::API::VoxelChannel dstChannel = 
			objectRef.createChannel(componentType, Bifrost::API::FloatType, "distance_mrsharp");
		dstChannel.setOffsetType(srcChannel.offsetType());
		dstChannel.setBackgroundValue<float>(srcChannel.backgroundValue<float>());

		// Run the sharpen filter (minus strength means smoothing)
		if (srcChannel.valid() && dstChannel.valid())
		{
			SharpenVoxels(-sharpenVoxels, srcChannel, dstChannel);
			channel = "distance_mrsharp";
		}
	}

	// Create a box geometry shader
	miTag tagBoxGeo = miNULLTAG;
	{
		miFunctionCall boxGeoCall("mib_geo_cube");
		tagBoxGeo = boxGeoCall.end();
	}

	// Create a volume shader
	miTag tagVolume = miNULLTAG;
	{
		const char* voxelVolume		= "bifrost_isosurface_volume";
		const char* particleVolume	= "bifrost_isosurface_particle_volume";
		miFunctionCall volumeCall(mode == kParticleMode ? particleVolume : voxelVolume);

		// Copy parameters from the geometry shader
		volumeCall.setScalarParameter("threshold", mi_eval_scalar(&paras->threshold));
		volumeCall.setScalarParameter("minStepSize", mi_eval_scalar(&paras->minStepSize));
		volumeCall.setScalarParameter("maxStepSize", mi_eval_scalar(&paras->maxStepSize));
		volumeCall.setScalarParameter("maxSteps", mi_eval_scalar(&paras->maxSteps));
		volumeCall.setScalarParameter("shadowBias", mi_eval_scalar(&paras->shadowBias));
		volumeCall.setBoolParameter("computeRedistance", mi_eval_boolean(&paras->computeRedistance));

		// Additional voxel or particle specific parameters
		if (mode == kParticleMode)
		{
			volumeCall.setScalarParameter("particleSize", mi_eval_scalar(&paras->particleSize));
			volumeCall.setBoolParameter("faceCamera", mi_eval_boolean(&paras->faceCamera));
		}

		// Transfer object info to volume shader
		volumeCall.setStringParameter("file", objectRef.file().c_str());
		volumeCall.setStringParameter("object", objectRef.object().c_str());
		volumeCall.setStringParameter("shape", componentType.c_str());
		volumeCall.setStringParameter("channel", channel.c_str());

		// Connect the material from the current state 
		// to the material parameter on the volume shader
		// Handle the material list and single material cases
		{
			miObjectAccess<miInstance> stateInst(state->instance);
			if (stateInst->mtl_array_size == 0)
			{
				volumeCall.setTagParameter("material", &stateInst->material);
			}
			else if (stateInst->material)
			{
				miArrayAccess<miTag> materialList(stateInst->material);
				volumeCall.setTagParameter("material", &materialList[0]);
			}
		}

		tagVolume = volumeCall.end();
	}

	// Create a material and assign the volume shader to it.
	miTag tagBoxMaterial = miNULLTAG;
	{
		miMaterialCall boxMaterial("bifrost_isosurface_geo[m]");

		boxMaterial->opaque = miFALSE;
		boxMaterial->volume = tagVolume;

		tagBoxMaterial = boxMaterial.end();
	}

	// Create an instance for the cube.
	// Override the material to make it use the volume shader
	// Tweak the matrix to move the cube to fill the bounding box.
	miTag tagBoxInst = miNULLTAG;
	{
		miInstanceCall boxInst("bifrost_isosurface_geo[i]");
		
		boxInst->material = tagBoxMaterial;

		// Compute the matrix to transform the unit cube to cover simulation domain
		miMatrix cubeMatrix;
		double bboxMin[3] = {0.0, 0.0, 0.0}, bboxMax[3] = {0.0, 0.0, 0.0} ;

		// Get the channel
		Bifrost::API::Channel chnl = objectRef.findChannel(componentType, channel.c_str());

		if (mode == kVoxelMode)
			ComputeIsosurfaceVoxelBounds(objectRef, chnl, bboxMin, bboxMax);
		else
			ComputeParticleBounds(objectRef, chnl, bboxMin, bboxMax);

		// Check if the bounds is valid
		if (bboxMin[0] >= bboxMax[0] || bboxMin[1] >= bboxMax[1] || bboxMin[2] >= bboxMax[2])
		{
			mi_warning("Warning: Empty bounds");
			return miFALSE;
		}

		// Expand the bounding box to take particle radius into account
		if (mode == kParticleMode)
		{
			const miScalar particleSize = *mi_eval_scalar(&paras->particleSize) + MAYA_EPS;
			bboxMin[0] -= particleSize; bboxMin[1] -= particleSize; bboxMin[2] -= particleSize;
			bboxMax[0] += particleSize; bboxMax[1] += particleSize; bboxMax[2] += particleSize;
		}

		miBBox2CubeMatrix(bboxMin, bboxMax, cubeMatrix);
		memcpy(boxInst->tf.local_to_global, cubeMatrix, sizeof(miMatrix));
		mi_matrix_invert(boxInst->tf.global_to_local, boxInst->tf.local_to_global);

		// Transfer flags from the parent instance
		{
			miObjectAccess<miInstance> stateInst(state->instance);
			miTransferInstanceFlags(stateInst, boxInst);
		}

		// Render both front and back faces of the box
		// We do front or back face culling in the volume shader instead
		boxInst->face = 'a';

		// Attach user data on the instance
		miAttachBifrostObjectUserData(objectRef, boxInst, "bifrost_isosurface_geo[fosc]");

		tagBoxInst = boxInst.end(tagBoxGeo);
	}

	// Set the instance tag on the volume shader
	{
		miFunctionEdit volumeEdit(tagVolume);
		volumeEdit.setParameter("instance", miTYPE_GEOMETRY, tagBoxInst);
	}
	
	// Echo the output of this geometry shader for debugging
	miEchoGeoShader(tagBoxInst);

	// Done!
	mi_geoshader_add_result(result, tagBoxInst);
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_isosurface_geo_version(void)
{
	return 1;
}
