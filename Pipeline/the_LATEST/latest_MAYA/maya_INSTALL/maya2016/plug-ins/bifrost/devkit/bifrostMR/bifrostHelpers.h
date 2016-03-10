//****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//****************************************************************************

#ifndef _bifrostHelpers_h_
#define _bifrostHelpers_h_

#include <bifrostapi/bifrost_voxelchannel.h>
#include <bifrostapi/bifrost_voxelsampler.h>

class BifrostObjectUserData;

//==============================================================================
// ComputeIsosurfaceVoxelBounds
//==============================================================================

void ComputeIsosurfaceVoxelBounds(const BifrostObjectUserData& objectRef, const Bifrost::API::Channel& channel, double bboxMin[3], double bboxMax[3]);

//==============================================================================
// ComputeVolumeVoxelBounds
//==============================================================================

void ComputeVolumeVoxelBounds(const BifrostObjectUserData& objectRef, const Bifrost::API::Channel& channel, double bboxMin[3], double bboxMax[3]);

//==============================================================================
// ComputeParticleBounds
//==============================================================================

void ComputeParticleBounds(const BifrostObjectUserData& objectRef, const Bifrost::API::Channel& channel, double bboxMin[3], double bboxMax[3]);

//==============================================================================
// TraceIsosurface
//==============================================================================

// This function computes the intersection of a ray and an isosurface
bool TraceIsosurface(const amino::Math::vec3f&			in_origin,
					 const amino::Math::vec3f&			in_direction,
					 const float						in_beginS,
					 const float						in_endS,
					 const Bifrost::API::VoxelSampler&	in_sampler,
					 const float						in_minStepSize,
					 const float						in_maxStepSize,
					 const float						in_threshold,
					 const float						in_maxSteps,
					 float*								out_s,
					 amino::Math::vec3f*				out_normal);

//==============================================================================
// SharpenVoxels
//==============================================================================

// This function runs a sharpen kernel on voxel tiles.
void SharpenVoxels(float strength, const Bifrost::API::VoxelChannel& src, Bifrost::API::VoxelChannel& dst);

#endif // _bifrostHelpers_h_
