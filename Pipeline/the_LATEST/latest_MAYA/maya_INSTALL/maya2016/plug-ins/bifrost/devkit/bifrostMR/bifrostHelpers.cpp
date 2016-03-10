//****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//****************************************************************************

#include "bifrostHelpers.h"

#include "bifrostHaloedVisitor.h"
#include "bifrostMentalrayHelpers.h"
#include "bifrostObjectUserData.h"

#include <bifrostapi/bifrost_layout.h>
#include <bifrostapi/bifrost_visitor.h>
#include <bifrostapi/bifrost_tile.h>
#include <bifrostapi/bifrost_tileaccessor.h>

#include <algorithm>
#include <functional>
#include <limits>
#include <random>

namespace
{

// Compute the union of bounding boxes of voxel tiles
struct TileBoundsVisitor : Bifrost::API::Visitor
{
	amino::Math::vec3i		m_tileBoundsMin;
	amino::Math::vec3i		m_tileBoundsMax;

	TileBoundsVisitor()
	{
		m_tileBoundsMin[0] = m_tileBoundsMin[1] = m_tileBoundsMin[2] = std::numeric_limits<int>::max();
		m_tileBoundsMax[0] = m_tileBoundsMax[1] = m_tileBoundsMax[2] = -std::numeric_limits<int>::max();
	}

	~TileBoundsVisitor() {}
	Bifrost::API::Visitor* copy() const { return new TileBoundsVisitor(); }

	void beginTile(const Bifrost::API::TileAccessor& accessor, const Bifrost::API::TreeIndex& index)
	{
		// Fetch the current tile
		const Bifrost::API::Tile tile = accessor.tile(index);

		// Get the voxel space coordinate and dimention info
		const Bifrost::API::TileCoord	coord	= tile.coord();
		const Bifrost::API::TileInfo	info	= tile.info();

		// Determine the voxel space bounding box of the tile
		amino::Math::vec3i tileBoundsMin, tileBoundsMax;
		tileBoundsMin[0] = coord.i;
		tileBoundsMin[1] = coord.j;
		tileBoundsMin[2] = coord.k;
		tileBoundsMax[0] = coord.i + info.dimInfo.depthWidth;
		tileBoundsMax[1] = coord.j + info.dimInfo.depthWidth;
		tileBoundsMax[2] = coord.k + info.dimInfo.depthWidth;

		// Expand the bounding box
		for (int i = 0; i < 3; i++)
		{
			m_tileBoundsMin[i] = std::min(m_tileBoundsMin[i], tileBoundsMin[i]);
			m_tileBoundsMax[i] = std::max(m_tileBoundsMax[i], tileBoundsMax[i]);
		}
	}


	void join(const Bifrost::API::Visitor& visitor)
	{
		const TileBoundsVisitor& other = dynamic_cast<const TileBoundsVisitor&>(visitor);
		for (int i = 0; i < 3; i++)
		{
			m_tileBoundsMin[i] = std::min(m_tileBoundsMin[i], other.m_tileBoundsMin[i]);
			m_tileBoundsMax[i] = std::max(m_tileBoundsMax[i], other.m_tileBoundsMax[i]);
		}
	}
};

// Compute the bounds of adaptive Aero.
// Both adaptive Aero and Liquid can have valid data in coarse leaf tiles.
// Adaptive Aero is different from Adaptive Liquid because it can have coarse leaf
// tiles anywhere. Adaptive Liquid just have interior coarse leaf tiles.
struct AeroVoxelBoundsVisitor : Bifrost::API::Visitor
{
	const Bifrost::API::TreeIndex::Depth	m_maxDepth;
	const Bifrost::API::VoxelChannel		m_voxelChannel;

	amino::Math::vec3i	m_tileBoundsMin;
	amino::Math::vec3i	m_tileBoundsMax;

	AeroVoxelBoundsVisitor(
		const Bifrost::API::TreeIndex::Depth	maxDepth,
		const Bifrost::API::VoxelChannel		voxelChannel
		) :	m_maxDepth(maxDepth),
			m_voxelChannel(voxelChannel)
	{
		m_tileBoundsMin[0] = m_tileBoundsMin[1] = m_tileBoundsMin[2] =  std::numeric_limits<int>::max();
		m_tileBoundsMax[0] = m_tileBoundsMax[1] = m_tileBoundsMax[2] = -std::numeric_limits<int>::max();
	}

	AeroVoxelBoundsVisitor(const AeroVoxelBoundsVisitor& other)
		:	m_maxDepth(other.m_maxDepth),
			m_voxelChannel(other.m_voxelChannel)
	{
		m_tileBoundsMin[0] = m_tileBoundsMin[1] = m_tileBoundsMin[2] =  std::numeric_limits<int>::max();
		m_tileBoundsMax[0] = m_tileBoundsMax[1] = m_tileBoundsMax[2] = -std::numeric_limits<int>::max();
	}

	~AeroVoxelBoundsVisitor() {}
	Bifrost::API::Visitor* copy() const { return new AeroVoxelBoundsVisitor(*this); }

	void beginTile(const Bifrost::API::TileAccessor& accessor, const Bifrost::API::TreeIndex& index)
	{
		// Get the voxel space coordinate and dimension info
		const Bifrost::API::Tile		tile	= accessor.tile(index);
		const Bifrost::API::TileCoord	coord	= tile.coord();
		const Bifrost::API::TileDimInfo	dim		= tile.info().dimInfo;

		// Voxel bounding box of this tile
		amino::Math::vec3i boundsMin = amino::Math::vec3i(
			coord.i, coord.j, coord.k
		);
		amino::Math::vec3i boundsMax = amino::Math::vec3i(
			coord.i + dim.depthWidth,
			coord.j + dim.depthWidth,
			coord.k + dim.depthWidth
		);

		// We are rendering with samplers. The smoke value in this voxel may
		// affect neighbour voxels. So we extend the bounding box a little.
		int samplerDomain = dim.depthWidth;

		// Include all cells of the finest voxel node.
		if (index.depth == m_maxDepth)
		{
			for (int i = 0; i < 3; i++)
			{
				m_tileBoundsMin[i] = std::min(m_tileBoundsMin[i], boundsMin[i] - samplerDomain);
				m_tileBoundsMax[i] = std::max(m_tileBoundsMax[i], boundsMax[i] + samplerDomain);
			}
			return;
		}

		// Iterate over each cell and include the cell if it has non-zero value.
		const Bifrost::API::TileData<float> tileData = m_voxelChannel.tileData<float>(index);

		for (int ii = 0; ii < dim.tileWidth; ii++) {
		for (int ij = 0; ij < dim.tileWidth; ij++) {
		for (int ik = 0; ik < dim.tileWidth; ik++) {
			// Not a leaf or a cell with zero value !
			if (tile.child(ii, ij, ik).valid() || tileData(ii, ij, ik) < MAYA_EPS)
				continue;

			// Get the bounds of the cell.
			amino::Math::vec3i voxelBoundsMin = amino::Math::vec3i(
				boundsMin[0] + ii * dim.voxelWidth,
				boundsMin[1] + ij * dim.voxelWidth,
				boundsMin[2] + ik * dim.voxelWidth 
			);
			amino::Math::vec3i voxelBoundsMax = amino::Math::vec3i(
				voxelBoundsMin[0] + dim.voxelWidth,
				voxelBoundsMin[1] + dim.voxelWidth,
				voxelBoundsMin[2] + dim.voxelWidth
			);

			// Expand the bounding box by the cell.
			for (int i = 0; i < 3; i++)
			{
				m_tileBoundsMin[i] = std::min(m_tileBoundsMin[i], voxelBoundsMin[i] - samplerDomain);
				m_tileBoundsMax[i] = std::max(m_tileBoundsMax[i], voxelBoundsMax[i] + samplerDomain);
			}
		} } }
	}

	void join(const Bifrost::API::Visitor& visitor)
	{
		const AeroVoxelBoundsVisitor& other = dynamic_cast<const AeroVoxelBoundsVisitor&>(visitor);
		for (int i = 0; i < 3; i++)
		{
			m_tileBoundsMin[i] = std::min(m_tileBoundsMin[i], other.m_tileBoundsMin[i]);
			m_tileBoundsMax[i] = std::max(m_tileBoundsMax[i], other.m_tileBoundsMax[i]);
		}
	}
};

// Sharpen or smooth voxels
struct SharpenVoxelsKernel : HaloedVisitor
{
	const Bifrost::API::VoxelChannel&	m_src;
	Bifrost::API::VoxelChannel&			m_dst;
	Bifrost::API::TileAccessor			m_acc;
	HaloCache<float>::Type				m_srcHaloCache;
	float								m_coeff[4];

	SharpenVoxelsKernel(
		float								in_strength,
		const Bifrost::API::VoxelChannel&	in_src,
		Bifrost::API::VoxelChannel&			in_dst)
		: m_src(in_src), m_dst(in_dst)
	{
		// set up the various filter coefficients based on sharpening strength
		float a = -in_strength / 8, b = 1 + in_strength / 4;
		m_coeff[0] = a * a * a;
		m_coeff[1] = a * a * b;
		m_coeff[2] = a * b * b;
		m_coeff[3] = b * b * b;

		// A new accessor for this thread
		Bifrost::API::Layout layout = m_src.layout();
		m_acc = layout.tileAccessor();

		// prepare the halo cache
		m_srcHaloCache.resize(layout.maxDepth() + 1);
		for (size_t i = 0; i < layout.maxDepth() + 1; ++i)
		{
			m_srcHaloCache[i].first = -1;
		}
	}

	SharpenVoxelsKernel(const SharpenVoxelsKernel& other)
		: m_src(other.m_src), m_dst(other.m_dst)
	{
		// Copy the filter coefficients
		m_coeff[0] = other.m_coeff[0];
		m_coeff[1] = other.m_coeff[1];
		m_coeff[2] = other.m_coeff[2];
		m_coeff[3] = other.m_coeff[3];

		// A new accessor for this thread
		Bifrost::API::Layout layout = m_src.layout();
		m_acc = layout.tileAccessor();

		// prepare the halo cache
		m_srcHaloCache.resize(layout.maxDepth() + 1);
		for (size_t i = 0; i < layout.maxDepth() + 1; ++i)
		{
			m_srcHaloCache[i].first = -1;
		}
	}

	void beginTile(const Bifrost::API::TileAccessor& accessor, const Bifrost::API::TreeIndex& index)
	{
		// get a haloed version of the source tile
		updateHaloCache<float>(index.tile, index.depth, &m_srcHaloCache, m_acc, m_src);
		const HaloedTile<float,1>& srcHaloTile = m_srcHaloCache[index.depth].second;

		// run the filter
		const int kTileWidth = accessor.tile(index).info().dimInfo.tileWidth;
		Bifrost::API::TileData<float> dstTile = m_dst.tileData<float>(index);
		for(int k = 0; k < kTileWidth; k++) for(int j = 0; j < kTileWidth; j++) for(int i = 0; i < kTileWidth; i++)
		{
			dstTile(i,j,k) =
				m_coeff[0] * (
					  srcHaloTile(i-1,j-1,k-1) + srcHaloTile(i+1,j-1,k-1)
					+ srcHaloTile(i-1,j+1,k-1) + srcHaloTile(i+1,j+1,k-1)
					+ srcHaloTile(i-1,j-1,k+1) + srcHaloTile(i+1,j-1,k+1)
					+ srcHaloTile(i-1,j+1,k+1) + srcHaloTile(i+1,j+1,k+1)
					)
				+ m_coeff[1] * (
					  srcHaloTile(i,j-1,k-1) + srcHaloTile(i,j+1,k-1)
					+ srcHaloTile(i,j-1,k+1) + srcHaloTile(i,j+1,k+1)
					+ srcHaloTile(i-1,j,k-1) + srcHaloTile(i+1,j,k-1)
					+ srcHaloTile(i-1,j,k+1) + srcHaloTile(i+1,j,k+1)
					+ srcHaloTile(i-1,j-1,k) + srcHaloTile(i+1,j-1,k)
					+ srcHaloTile(i-1,j+1,k) + srcHaloTile(i+1,j+1,k)
					)
				+ m_coeff[2] * (
					  srcHaloTile(i-1,j,k) + srcHaloTile(i+1,j,k)
					+ srcHaloTile(i,j-1,k) + srcHaloTile(i,j+1,k)
					+ srcHaloTile(i,j,k-1) + srcHaloTile(i,j,k+1)
					)
				+ m_coeff[3] * srcHaloTile(i,j,k);
		}
	}

	Bifrost::API::Visitor* copy() const
	{
		return new SharpenVoxelsKernel(*this);
	}
};

void AddPerturbation(const BifrostObjectUserData& objectRef, double bboxMin[3], double bboxMax[3])
{
	// Add perturbation to the bounding box. The perturbation is required for
	// mentalray to choose the correct volume shader for the box.
	// Otherwise, co-planar bounding boxes will cause autovolume not working properly.
	const float EPSILON = 1.0e-5f;
	std::mt19937 generator((unsigned int)std::hash<std::string>()(objectRef.object()));
#if !defined(__clang__) && defined(__GNUC__) && (__GNUC__ == 4 && __GNUC_MINOR__ <= 4)
	// gcc <= 4.4, TR1
	std::uniform_real<float> distribution(-EPSILON, EPSILON);
	auto perturbation = std::variate_generator<std::mt19937,std::uniform_real<float>>(generator, distribution);
#else
	std::uniform_real_distribution<float> distribution(-EPSILON, EPSILON);
	auto perturbation = std::bind(distribution, generator);
#endif
	for (int i = 0; i < 3; i++)
	{
		bboxMin[i] += bboxMin[i] * perturbation() + perturbation();
		bboxMax[i] += bboxMax[i] * perturbation() + perturbation();
	}
}

} // anonymous namespace

//==============================================================================
// ComputeIsosurfaceVoxelBounds
//==============================================================================

void ComputeIsosurfaceVoxelBounds(const BifrostObjectUserData& objectRef, const Bifrost::API::Channel& channel, double bboxMin[3], double bboxMax[3])
{
	// Find the maximum depth that contains the finest tiles
	Bifrost::API::Layout layout = channel.layout();
	const Bifrost::API::TreeIndex::Depth maxDepth = (Bifrost::API::TreeIndex::Depth)layout.maxDepth();

	// Visit the finest tiles to compute a bounding box that cover all of them
	bboxMin[0] = bboxMin[1] = bboxMin[2] = std::numeric_limits<double>::max();
	bboxMax[0] = bboxMax[1] = bboxMax[2] = -std::numeric_limits<double>::max();
	{
		TileBoundsVisitor visitor;
		layout.traverse(visitor, Bifrost::API::ParallelReduceBreadthFirst, maxDepth, maxDepth);

		if (visitor.m_tileBoundsMin[0] >= visitor.m_tileBoundsMax[0] ||
			visitor.m_tileBoundsMin[1] >= visitor.m_tileBoundsMax[1] ||
			visitor.m_tileBoundsMin[2] >= visitor.m_tileBoundsMax[2])
			return;

		// Translate to world space size.
		const float scaling = layout.voxelScale();
		for (int i = 0; i < 3; i++)
		{
			bboxMin[i] = (float)visitor.m_tileBoundsMin[i] * scaling;
			bboxMax[i] = (float)visitor.m_tileBoundsMax[i] * scaling;
		}
	}

	AddPerturbation(objectRef, bboxMin, bboxMax);
}

//==============================================================================
// ComputeVolumeVoxelBounds
//==============================================================================

void ComputeVolumeVoxelBounds(const BifrostObjectUserData& objectRef, const Bifrost::API::Channel& channel, double bboxMin[3], double bboxMax[3])
{
	// Find the maximum depth that contains the finest tiles
	Bifrost::API::Layout layout = channel.layout();
	const Bifrost::API::TreeIndex::Depth maxDepth = (Bifrost::API::TreeIndex::Depth)layout.maxDepth();

	// Visit the finest and coarse tiles to compute a bounding box that cover all of them
	bboxMin[0] = bboxMin[1] = bboxMin[2] = std::numeric_limits<double>::max();
	bboxMax[0] = bboxMax[1] = bboxMax[2] = -std::numeric_limits<double>::max();
	{
		AeroVoxelBoundsVisitor visitor(maxDepth, channel);
		layout.traverse(visitor, Bifrost::API::ParallelReduceBreadthFirst, 0, maxDepth);

		if (visitor.m_tileBoundsMin[0] >= visitor.m_tileBoundsMax[0] ||
			visitor.m_tileBoundsMin[1] >= visitor.m_tileBoundsMax[1] ||
			visitor.m_tileBoundsMin[2] >= visitor.m_tileBoundsMax[2])
			return;

		// Translate to world space size.
		const float scaling = layout.voxelScale();
		for (int i = 0; i < 3; i++)
		{
			bboxMin[i] = (float)visitor.m_tileBoundsMin[i] * scaling;
			bboxMax[i] = (float)visitor.m_tileBoundsMax[i] * scaling;
		}
	}

	AddPerturbation(objectRef, bboxMin, bboxMax);
}

//==============================================================================
// ComputeParticleBounds
//==============================================================================

void ComputeParticleBounds(const BifrostObjectUserData& objectRef, const Bifrost::API::Channel& channel, double bboxMin[3], double bboxMax[3])
{
	// Using the same implementation as voxel for now. Adaptive Aero might break the assumption.
	ComputeIsosurfaceVoxelBounds(objectRef, channel, bboxMin, bboxMax);
}

//==============================================================================
// TraceIsosurface
//==============================================================================

// Traces input ray (from origin pointing in direction) and attempts to find the first intersection with the zero isosurface
// defined by sampler, starting from ray parameter beginS and going no further than endS, subject to parameters on the ray
// marching (min step size, |sampler(x)|<threshold indicating a good enough intersection, maximum number of steps to take before
// quitting). If an intersection is found, returns true and sets the value of s and the normal of the isosurface at that point
// (pointing in the direction of the positive gradient of the sampled field). Otherwise false is returned.
// Right now, it assumes the field is close to being a distance field according to the magnitude of the ray direction, or in
// particular that a step size of s=|sampler(x)| won't jump too far through the surface.
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
					 amino::Math::vec3f*				out_normal)
{
	float s=in_beginS;
	float d=in_sampler.sample<float>(in_origin+s*in_direction);
	if(std::fabs(d)<in_threshold){
		*out_s=s;
		in_sampler.sampleGradient<float>(in_origin+s*in_direction, *out_normal);
		*out_normal/=mag(*out_normal)+1e-30f;
		return true;
	}

	float deltaS=std::max(in_minStepSize, 0.95f*std::fabs(d));
	deltaS=std::min(in_maxStepSize, deltaS);
	float sNew=s+deltaS;
	if(sNew>in_endS){
		sNew=in_endS;
	}
	float dNew=in_sampler.sample<float>(in_origin+sNew*in_direction);
	if(std::fabs(dNew)<=in_threshold){
		*out_s=sNew;
		in_sampler.sampleGradient<float>(in_origin+sNew*in_direction, *out_normal);
		*out_normal/=mag(*out_normal)+1e-30f;
		return true;
	}

	// advance forward until we get to a sign change (or run out of ray, or fortuitously hit the surface)
	int steps=0;
	while((d<0 && dNew<0) || (d>0 && dNew>0)){
		// if we hit the end of the ray, quit
		if(sNew>=in_endS){
			return false;
		}
		// update old sample
		s=sNew;
		d=dNew;
		// advance to new sample
		deltaS=std::max(in_minStepSize, 0.95f*std::fabs(d));
		deltaS=std::min(in_maxStepSize, deltaS);
		sNew=s+deltaS;
		if(sNew>in_endS){
			sNew=in_endS;
		}
		dNew=in_sampler.sample<float>(in_origin+sNew*in_direction);

		if(std::fabs(dNew)<=in_threshold){
			*out_s=sNew;
			in_sampler.sampleGradient<float>(in_origin+sNew*in_direction, *out_normal);
			*out_normal/=mag(*out_normal)+1e-30f;
			return true;
		}
		if(steps>in_maxSteps){
			return false;
		}
		++steps;
	}

	// have a sign change: secant search down to the surface
	for(int i=0; i<20; ++i){
		float sMid;
		if(i%3==2){ // every third step use bisection instead of secant, to guarantee progress
			sMid=0.5f*(s+sNew);
		}else{
			sMid=s+(sNew-s)*d/(d-dNew);
		}
		if(sMid==s || sMid==sNew){ // if we are now making no more progress...
			break; // quit
		}
		assert(sMid>s && sMid<sNew);
		float dMid=in_sampler.sample<float>(in_origin+sMid*in_direction);

		if(std::fabs(dMid)<=in_threshold){ // early exit?
			*out_s=sMid;
			in_sampler.sampleGradient<float>(in_origin+sMid*in_direction, *out_normal);
			*out_normal/=mag(*out_normal)+1e-30f;
			return true;
		}
		// keep the bracketed sign change, using secant guess as one endpoint
		if((d<0 && dMid>0) || (d>0 && dMid<0)){
			sNew=sMid;
			dNew=dMid;
		}else{
			s=sMid;
			d=dMid;
		}
	}
	// report what we've got so far (not as accurate as we want, but oh well)
	*out_s=s;
	in_sampler.sampleGradient<float>(in_origin+s*in_direction, *out_normal);
	*out_normal/=mag(*out_normal)+1e-30f;
	return true;
}

void SharpenVoxels(float strength, const Bifrost::API::VoxelChannel& src, Bifrost::API::VoxelChannel& dst)
{
	// Run the sharpen kernel on the specified channel.
	Bifrost::API::Layout layout = dst.layout();
	SharpenVoxelsKernel visitor(strength, src, dst);
	layout.traverse(visitor, Bifrost::API::ParallelBreadthFirst);
}

