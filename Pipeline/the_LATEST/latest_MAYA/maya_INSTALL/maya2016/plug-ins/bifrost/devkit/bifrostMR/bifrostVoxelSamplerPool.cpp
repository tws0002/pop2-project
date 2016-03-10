//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostVoxelSamplerPool.h"

VoxelSamplerPool::VoxelSamplerPool(
	const Bifrost::API::VoxelChannel& channel,
	const Bifrost::API::SamplerSpace space,
	const size_t threadCount)
{
	// We are always using QBSpline samplers
	const Bifrost::API::TypeID samplerType = Bifrost::API::VoxelSamplerQBSplineType;

	// Create a pool of samplers for threads
	m_samplers.resize(threadCount);
	for (size_t i = 0; i < threadCount; i++)
	{
		m_samplers[i] = channel.createSampler(samplerType, space);
	}
}

Bifrost::API::VoxelSampler VoxelSamplerPool::getSampler(const size_t threadID)
{
	return (threadID < m_samplers.size()) ? m_samplers[threadID] : Bifrost::API::VoxelSampler();
}
