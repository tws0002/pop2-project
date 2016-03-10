//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#ifndef _bifrostVoxelSamplerPool_h_
#define _bifrostVoxelSamplerPool_h_

#include <bifrostapi/bifrost_voxelchannel.h>
#include <bifrostapi/bifrost_voxelsampler.h>

#include <vector>

//==============================================================================
// VoxelSamplerPool
//==============================================================================

// This class is a pool of bifrost voxel samplers.
// Samplers are not thread-safe so each thread needs a dedicated sampler.
class VoxelSamplerPool
{
public:
	VoxelSamplerPool(const Bifrost::API::VoxelChannel& channel,
					 const Bifrost::API::SamplerSpace space,
					 const size_t threadCount);
	~VoxelSamplerPool() {}

	// Get a sampler for the specified thread.
	Bifrost::API::VoxelSampler getSampler(const size_t threadID);

private:
	std::vector<Bifrost::API::VoxelSampler> m_samplers;
};

#endif // _bifrostVoxelSamplerPool_h_
