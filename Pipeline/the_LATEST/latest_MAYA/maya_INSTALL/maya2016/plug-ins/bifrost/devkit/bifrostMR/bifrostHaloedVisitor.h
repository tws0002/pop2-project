//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#ifndef _bifrostHaloedVisitor_h_
#define _bifrostHaloedVisitor_h_

#include <bifrostapi/bifrost_visitor.h>
#include <bifrostapi/bifrost_voxelchannel.h>
#include <bifrostapi/bifrost_tileaccessor.h>

#include <vector>

//==============================================================================
// HaloedTile
//==============================================================================

template<typename T, int H=0, int N=5>
struct HaloedTile
{
	static const int STRIDE_I=1;
	static const int STRIDE_J=N+2*H;
	static const int STRIDE_K=(N+2*H)*(N+2*H);
	static const int SIZE=(N+2*H)*(N+2*H)*(N+2*H);
	static const int CORESIZE=N*N*N;

	const T& operator()(int i, int j, int k) const
	{
		assert(-H<=i && i<N+H);
		assert(-H<=j && j<N+H);
		assert(-H<=k && k<N+H);
		return elem[STRIDE_I*(i+H)+STRIDE_J*(j+H)+STRIDE_K*(k+H)];
	}

	T& operator()(int i, int j, int k)
	{
		assert(-H<=i && i<N+H);
		assert(-H<=j && j<N+H);
		assert(-H<=k && k<N+H);
		return elem[STRIDE_I*(i+H)+STRIDE_J*(j+H)+STRIDE_K*(k+H)];
	}

	void fillCore(const Bifrost::API::TileData<T>& core)
	{
		for(int k=0; k<N; ++k) for(int j=0; j<N; ++j) for(int i=0; i<N; ++i){
			(*this)(i,j,k)=core(i,j,k);
		}
	}

protected:
	T elem[SIZE];
};

//==============================================================================
// HaloedVisitorHelpers
//==============================================================================

namespace HaloedVisitorHelpers
{

// Return tile located at '(in_ti, in_tj, in_tk)' at depth 'in_depth' if it exists, nullptr otherwise
template<typename T>
inline Bifrost::API::TileData<T> findTile(
	int										in_ti,
	int										in_tj,
	int										in_tk,
	Bifrost::API::TreeIndex::Depth			in_depth,
	Bifrost::API::TileAccessor&				in_acc,
	const Bifrost::API::VoxelChannel&		in_channel)
{
	Bifrost::API::TreeIndex locator = in_acc.index(in_ti, in_tj, in_tk, in_depth);

	if(locator.tile<0||in_depth!=locator.depth){
		return Bifrost::API::TileData<T>();
	}else{
		return in_channel.tileData<T>(locator);
	}
}

// helper function for figuring out face values in the halo based on coarse parent.
template<typename T, int N, int STRIDE_I, int STRIDE_J>
inline void extrapolateContinuousFace3x3(
	T			in_dMM,
	T			in_d0M,
	T			in_dPM,
	T			in_dM0,
	T			in_d00,
	T			in_dP0,
	T			in_dMP,
	T			in_d0P,
	T			in_dPP,
	const T*	in_side,
	T*			out_face
)
{
	int i, j, di, d;
	for(i=0, di=0; i<N/2+1; ++i, di+=STRIDE_I){
		float a=(N+1+2*i)/float(2*N);
		T dM=(1-a)*in_dMM + a*in_d0M,
			d0=(1-a)*in_dM0 + a*in_d00,
			dP=(1-a)*in_dMP + a*in_d0P;
		for(j=0, d=di; j<N/2+1; ++j, d+=STRIDE_J){
			float b=(N+1+2*j)/float(2*N);
			out_face[d]=(1-b)*dM + b*d0 - in_side[d];
		}
		for(; j<N; ++j, d+=STRIDE_J){
			float b=(2*j-N+1)/float(2*N);
			out_face[d]=(1-b)*d0 + b*dP - in_side[d];
		}
	}
	for(; i<N; ++i, di+=STRIDE_I){
		float a=(2*i-N+1)/float(2*N);
		T dM=(1-a)*in_d0M + a*in_dPM,
			d0=(1-a)*in_d00 + a*in_dP0,
			dP=(1-a)*in_d0P + a*in_dPP;
		for(j=0, d=di; j<N/2+1; ++j, d+=STRIDE_J){
			float b=(N+1+2*j)/float(2*N);
			out_face[d]=(1-b)*dM + b*d0 - in_side[d];
		}
		for(; j<N; ++j, d+=STRIDE_J){
			float b=(2*j-N+1)/float(2*N);
			out_face[d]=(1-b)*d0 + b*dP - in_side[d];
		}
	}
}

template<typename T, int N, int STRIDE>
inline void extrapolateContinuousEdge3(
	T					in_qM,
	T					in_q0,
	T					in_qP,
	const T*			in_side0,
	const T*			in_side1,
	const T*			in_side2,
	T*					out_edge
)
{
	int i, d;
	for(i=0, d=0; i<N/2+1; ++i, d+=STRIDE){
		float a=(N+1+2*i)/float(2*N);
		out_edge[d]=(1-a)*in_qM + a*in_q0 - in_side0[d] - in_side1[d] - in_side2[d];
	}
	for(; i<N; ++i, d+=STRIDE){
		float a=(2*i-N+1)/float(2*N);
		out_edge[d]=(1-a)*in_q0 + a*in_qP - in_side0[d] - in_side1[d] - in_side2[d];
	}
}


// Root tile case: provide the background value.
template<typename T, int N>
inline void evalContinuousHaloedRootTile(
	const T&							in_backgroundValue,
	const Bifrost::API::TileData<T>&	in_core,
	HaloedTile<T,1,N>*					out_halo
)
{
	assert(out_halo);
	HaloedTile<T,1,N>& halo=*out_halo; // reference makes code look nicer

	// copy over the real values
	halo.fillCore(in_core);

	// compute the halo values by reference to the background value
	const T dbv=2*in_backgroundValue;

	// extrapolate faces
	for(int j=0; j<N; ++j) for(int i=0; i<N; ++i){
		halo(-1,i,j)=dbv-halo(0,i,j);
		halo(N,i,j)=dbv-halo(N-1,i,j);
	}
	for(int j=0; j<N; ++j) for(int i=0; i<N; ++i){
		halo(i,-1,j)=dbv-halo(i,0,j);
		halo(i,N,j)=dbv-halo(i,N-1,j);
	}
	for(int j=0; j<N; ++j) for(int i=0; i<N; ++i){
		halo(i,j,-1)=dbv-halo(i,j,0);
		halo(i,j,N)=dbv-halo(i,j,N-1);
	}

	// work out edges
	for(int i=0; i<N; ++i){
		halo(-1, -1, i)=halo(  0,   0, i);
		halo( N, -1, i)=halo(N-1,   0, i);
		halo(-1,  N, i)=halo(  0, N-1, i);
		halo( N,  N, i)=halo(N-1, N-1, i);
	}
	for(int i=0; i<N; ++i){
		halo(-1, i, -1)=halo(  0, i,   0);
		halo( N, i, -1)=halo(N-1, i,   0);
		halo(-1, i,  N)=halo(  0, i, N-1);
		halo( N, i,  N)=halo(N-1, i, N-1);
	}
	for(int i=0; i<N; ++i){
		halo(i, -1, -1)=halo(i,   0,   0);
		halo(i,  N, -1)=halo(i, N-1,   0);
		halo(i, -1,  N)=halo(i,   0, N-1);
		halo(i,  N,  N)=halo(i, N-1, N-1);
	}

	// extrapolate to hit background value at the tile corner
	halo(-1, -1, -1)=dbv-halo(  0,   0,   0);
	halo( N, -1, -1)=dbv-halo(N-1,   0,   0);
	halo(-1,  N, -1)=dbv-halo(  0, N-1,   0);
	halo( N,  N, -1)=dbv-halo(N-1, N-1,   0);
	halo(-1, -1,  N)=dbv-halo(  0,   0, N-1);
	halo( N, -1,  N)=dbv-halo(N-1,   0, N-1);
	halo(-1,  N,  N)=dbv-halo(  0, N-1, N-1);
	halo( N,  N,  N)=dbv-halo(N-1, N-1, N-1);
}

// Pass in a haloed parent tile, the local indices within the parent of the tile to build a halo around (in_core),
// and the 26 neighbouring tiles to in_core (with null pointers if the neighbour doesn't exist). The "M" stands for minus,
// "P" for plus, and 0 for same coordinate, so for example in_nbrP0M is the tile with a higher x-coordinate, the
// same y-coordinate, and a lesser z-coordinate.
template<typename T, int N>
inline void evalContinuousHaloedTile(
	const HaloedTile<T,1,N>&			in_haloParent,
	const int							li,
	const int							lj,
	const int							lk,
	const Bifrost::API::TileData<T>&	in_nbrMMM,
	const Bifrost::API::TileData<T>&	in_nbr0MM,
	const Bifrost::API::TileData<T>&	in_nbrPMM,
	const Bifrost::API::TileData<T>&	in_nbrM0M,
	const Bifrost::API::TileData<T>&	in_nbr00M,
	const Bifrost::API::TileData<T>&	in_nbrP0M,
	const Bifrost::API::TileData<T>&	in_nbrMPM,
	const Bifrost::API::TileData<T>&	in_nbr0PM,
	const Bifrost::API::TileData<T>&	in_nbrPPM,
	const Bifrost::API::TileData<T>&	in_nbrMM0,
	const Bifrost::API::TileData<T>&	in_nbr0M0,
	const Bifrost::API::TileData<T>&	in_nbrPM0,
	const Bifrost::API::TileData<T>&	in_nbrM00,
	const Bifrost::API::TileData<T>&	in_core,
	const Bifrost::API::TileData<T>&	in_nbrP00,
	const Bifrost::API::TileData<T>&	in_nbrMP0,
	const Bifrost::API::TileData<T>&	in_nbr0P0,
	const Bifrost::API::TileData<T>&	in_nbrPP0,
	const Bifrost::API::TileData<T>&	in_nbrMMP,
	const Bifrost::API::TileData<T>&	in_nbr0MP,
	const Bifrost::API::TileData<T>&	in_nbrPMP,
	const Bifrost::API::TileData<T>&	in_nbrM0P,
	const Bifrost::API::TileData<T>&	in_nbr00P,
	const Bifrost::API::TileData<T>&	in_nbrP0P,
	const Bifrost::API::TileData<T>&	in_nbrMPP,
	const Bifrost::API::TileData<T>&	in_nbr0PP,
	const Bifrost::API::TileData<T>&	in_nbrPPP,
	HaloedTile<T,1,N>*					out_halo
)
{
	assert(N%2==1); // odd sized tiles required to make this work!
	assert(li>=0 && li<N);
	assert(lj>=0 && lj<N);
	assert(lk>=0 && lk<N);
	assert(out_halo);
	HaloedTile<T,1,N>& halo=*out_halo; // reference makes code look nicer

	// shortcut names
	const int STRIDE_I=HaloedTile<T,1,N>::STRIDE_I;
	const int STRIDE_J=HaloedTile<T,1,N>::STRIDE_J;
	const int STRIDE_K=HaloedTile<T,1,N>::STRIDE_K;

	// copy over the real values
	halo.fillCore(in_core);

	//--------------------------------------------------------------------------------------------------------------------
	// go through the 6 halo faces, copying from neighbour or patching into the parent tile if neighbour is missing
	//--------------------------------------------------------------------------------------------------------------------

	if(in_nbrM00.count()>0){
		for(int i=0; i<N; ++i) for(int j=0; j<N; ++j){
			halo(-1, i, j)=in_nbrM00(N-1, i, j);
		}
	}else{
		extrapolateContinuousFace3x3<T,N,STRIDE_J,STRIDE_K>(
			in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1),
			in_haloParent(li-1, lj,   lk-1) + in_haloParent(li, lj,   lk-1),
			in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1),
			in_haloParent(li-1, lj-1, lk)   + in_haloParent(li, lj-1, lk),
			in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li-1, lj+1, lk)   + in_haloParent(li, lj+1, lk),
			in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1),
			in_haloParent(li-1, lj,   lk+1) + in_haloParent(li, lj,   lk+1),
			in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1),
			&halo(0,0,0), &halo(-1,0,0));
	}

	if(in_nbrP00.count()>0){
		for(int i=0; i<N; ++i) for(int j=0; j<N; ++j){
			halo(N, i, j)=in_nbrP00(0, i, j);
		}
	}else{
		extrapolateContinuousFace3x3<T,N,STRIDE_J,STRIDE_K>(
			in_haloParent(li+1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1),
			in_haloParent(li+1, lj,   lk-1) + in_haloParent(li, lj,   lk-1),
			in_haloParent(li+1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1),
			in_haloParent(li+1, lj-1, lk)   + in_haloParent(li, lj-1, lk),
			in_haloParent(li+1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li+1, lj+1, lk)   + in_haloParent(li, lj+1, lk),
			in_haloParent(li+1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1),
			in_haloParent(li+1, lj,   lk+1) + in_haloParent(li, lj,   lk+1),
			in_haloParent(li+1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1),
			&halo(N-1,0,0), &halo(N,0,0));
	}

	if(in_nbr0M0.count()>0){
		for(int i=0; i<N; ++i) for(int j=0; j<N; ++j){
			halo(i, -1, j)=in_nbr0M0(i, N-1, j);
		}
	}else{
		extrapolateContinuousFace3x3<T,N,STRIDE_I,STRIDE_K>(
			in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li-1, lj, lk-1),
			in_haloParent(li,   lj-1, lk-1) + in_haloParent(li,   lj, lk-1),
			in_haloParent(li+1, lj-1, lk-1) + in_haloParent(li+1, lj, lk-1),
			in_haloParent(li-1, lj-1, lk)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj-1, lk)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj-1, lk)   + in_haloParent(li+1, lj, lk),
			in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li-1, lj, lk+1),
			in_haloParent(li,   lj-1, lk+1) + in_haloParent(li,   lj, lk+1),
			in_haloParent(li+1, lj-1, lk+1) + in_haloParent(li+1, lj, lk+1),
			&halo(0,0,0), &halo(0,-1,0));
	}

	if(in_nbr0P0.count()>0){
		for(int i=0; i<N; ++i) for(int j=0; j<N; ++j){
			halo(i, N, j)=in_nbr0P0(i, 0, j);
		}
	}else{
		extrapolateContinuousFace3x3<T,N,STRIDE_I,STRIDE_K>(
			in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li-1, lj, lk-1),
			in_haloParent(li,   lj+1, lk-1) + in_haloParent(li,   lj, lk-1),
			in_haloParent(li+1, lj+1, lk-1) + in_haloParent(li+1, lj, lk-1),
			in_haloParent(li-1, lj+1, lk)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj+1, lk)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj+1, lk)   + in_haloParent(li+1, lj, lk),
			in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li-1, lj, lk+1),
			in_haloParent(li,   lj+1, lk+1) + in_haloParent(li,   lj, lk+1),
			in_haloParent(li+1, lj+1, lk+1) + in_haloParent(li+1, lj, lk+1),
			&halo(0,N-1,0), &halo(0,N,0));
	}

	if(in_nbr00M.count()>0){
		for(int i=0; i<N; ++i) for(int j=0; j<N; ++j){
			halo(i, j, -1)=in_nbr00M(i, j, N-1);
		}
	}else{
		extrapolateContinuousFace3x3<T,N,STRIDE_I,STRIDE_J>(
			in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li-1, lj-1, lk),
			in_haloParent(li,   lj-1, lk-1) + in_haloParent(li,   lj-1, lk),
			in_haloParent(li+1, lj-1, lk-1) + in_haloParent(li+1, lj-1, lk),
			in_haloParent(li-1, lj,   lk-1)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj,   lk-1)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj,   lk-1)   + in_haloParent(li+1, lj, lk),
			in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li-1, lj+1, lk),
			in_haloParent(li,   lj+1, lk-1) + in_haloParent(li,   lj+1, lk),
			in_haloParent(li+1, lj+1, lk-1) + in_haloParent(li+1, lj+1, lk),
			&halo(0,0,0), &halo(0,0,-1));
	}

	if(in_nbr00P.count()>0){
		for(int i=0; i<N; ++i) for(int j=0; j<N; ++j){
			halo(i, j, N)=in_nbr00P(i, j, 0);
		}
	}else{
		extrapolateContinuousFace3x3<T,N,STRIDE_I,STRIDE_J>(
			in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li-1, lj-1, lk),
			in_haloParent(li,   lj-1, lk+1) + in_haloParent(li,   lj-1, lk),
			in_haloParent(li+1, lj-1, lk+1) + in_haloParent(li+1, lj-1, lk),
			in_haloParent(li-1, lj,   lk+1)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj,   lk+1)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj,   lk+1)   + in_haloParent(li+1, lj, lk),
			in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li-1, lj+1, lk),
			in_haloParent(li,   lj+1, lk+1) + in_haloParent(li,   lj+1, lk),
			in_haloParent(li+1, lj+1, lk+1) + in_haloParent(li+1, lj+1, lk),
			&halo(0,0,N-1), &halo(0,0,N));
	}

	//--------------------------------------------------------------------------------------------------------------------------
	// go through the 12 halo edges, copying from neighbour when we can, but patching into the parent tile if any tiles
	// incident on the edge are missing
	//--------------------------------------------------------------------------------------------------------------------------

	// First the X/Y edges -----------------------------------------------------------------------------------------------------
	if(in_nbrMM0.count()>0 && in_nbrM00.count()>0 && in_nbr0M0.count()>0){
		for(int i=0; i<N; ++i){
			halo(-1, -1, i)=in_nbrMM0(N-1, N-1, i);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_K>(
			in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1)
			+ in_haloParent(li-1, lj,   lk-1) + in_haloParent(li, lj,   lk-1),
			in_haloParent(li-1, lj-1, lk)   + in_haloParent(li, lj-1, lk)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1)
			+ in_haloParent(li-1, lj,   lk+1) + in_haloParent(li, lj,   lk+1),
			&halo(-1,0,0), &halo(0,-1,0), &halo(0,0,0), &halo(-1,-1,0));
	}

	if(in_nbrPM0.count()>0 && in_nbrP00.count()>0 && in_nbr0M0.count()>0){
		for(int i=0; i<N; ++i){
			halo(N, -1, i)=in_nbrPM0(0, N-1, i);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_K>(
			in_haloParent(li+1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1)
			+ in_haloParent(li+1, lj,   lk-1) + in_haloParent(li, lj,   lk-1),
			in_haloParent(li+1, lj-1, lk)   + in_haloParent(li, lj-1, lk)
			+ in_haloParent(li+1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li+1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1)
			+ in_haloParent(li+1, lj,   lk+1) + in_haloParent(li, lj,   lk+1),
			&halo(N,0,0), &halo(N-1,-1,0), &halo(N-1,0,0), &halo(N,-1,0));
	}

	if(in_nbrMP0.count()>0 && in_nbrM00.count()>0 && in_nbr0P0.count()>0){
		for(int i=0; i<N; ++i){
			halo(-1, N, i)=in_nbrMP0(N-1, 0, i);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_K>(
			in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1)
			+ in_haloParent(li-1, lj,   lk-1) + in_haloParent(li, lj,   lk-1),
			in_haloParent(li-1, lj+1, lk)   + in_haloParent(li, lj+1, lk)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1)
			+ in_haloParent(li-1, lj,   lk+1) + in_haloParent(li, lj,   lk+1),
			&halo(0,N,0), &halo(-1,N-1,0), &halo(0,N-1,0), &halo(-1,N,0));
	}

	if(in_nbrPP0.count()>0 && in_nbrP00.count()>0 && in_nbr0P0.count()>0){
		for(int i=0; i<N; ++i){
			halo(N, N, i)=in_nbrPP0(0, 0, i);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_K>(
			in_haloParent(li+1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1)
			+ in_haloParent(li+1, lj,   lk-1) + in_haloParent(li, lj,   lk-1),
			in_haloParent(li+1, lj+1, lk)   + in_haloParent(li, lj+1, lk)
			+ in_haloParent(li+1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li+1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1)
			+ in_haloParent(li+1, lj,   lk+1) + in_haloParent(li, lj,   lk+1),
			&halo(N-1,N,0), &halo(N,N-1,0), &halo(N-1,N-1,0), &halo(N,N,0));
	}

	// Now the X/Z edges -------------------------------------------------------------------------------------------------------
	if(in_nbrM0M.count()>0 && in_nbrM00.count()>0 && in_nbr00M.count()>0){
		for(int i=0; i<N; ++i){
			halo(-1, i, -1)=in_nbrM0M(N-1, i, N-1);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_J>(
			in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1)
			+ in_haloParent(li-1, lj-1, lk)   + in_haloParent(li, lj-1, lk),
			in_haloParent(li-1, lj,   lk-1) + in_haloParent(li, lj,   lk-1)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1)
			+ in_haloParent(li-1, lj+1, lk)   + in_haloParent(li, lj+1, lk),
			&halo(-1,0,0), &halo(0,0,-1), &halo(0,0,0), &halo(-1,0,-1));
	}

	if(in_nbrP0M.count()>0 && in_nbrP00.count()>0 && in_nbr00M.count()>0){
		for(int i=0; i<N; ++i){
			halo(N, i, -1)=in_nbrP0M(0, i, N-1);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_J>(
			in_haloParent(li+1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1)
			+ in_haloParent(li+1, lj-1, lk)   + in_haloParent(li, lj-1, lk),
			in_haloParent(li+1, lj,   lk-1) + in_haloParent(li, lj,   lk-1)
			+ in_haloParent(li+1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li+1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1)
			+ in_haloParent(li+1, lj+1, lk)   + in_haloParent(li, lj+1, lk),
			&halo(N,0,0), &halo(N-1,0,-1), &halo(N-1,0,0), &halo(N,0,-1));
	}

	if(in_nbrM0P.count()>0 && in_nbrM00.count()>0 && in_nbr00P.count()>0){
		for(int i=0; i<N; ++i){
			halo(-1, i, N)=in_nbrM0P(N-1, i, 0);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_J>(
			in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1)
			+ in_haloParent(li-1, lj-1, lk)   + in_haloParent(li, lj-1, lk),
			in_haloParent(li-1, lj,   lk+1) + in_haloParent(li, lj,   lk+1)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1)
			+ in_haloParent(li-1, lj+1, lk)   + in_haloParent(li, lj+1, lk),
			&halo(0,0,N), &halo(-1,0,N-1), &halo(0,0,N-1), &halo(-1,0,N));
	}

	if(in_nbrP0P.count()>0 && in_nbrP00.count()>0 && in_nbr00P.count()>0){
		for(int i=0; i<N; ++i){
			halo(N, i, N)=in_nbrP0P(0, i, 0);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_J>(
			in_haloParent(li+1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1)
			+ in_haloParent(li+1, lj-1, lk)   + in_haloParent(li, lj-1, lk),
			in_haloParent(li+1, lj,   lk+1) + in_haloParent(li, lj,   lk+1)
			+ in_haloParent(li+1, lj,   lk)   + in_haloParent(li, lj,   lk),
			in_haloParent(li+1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1)
			+ in_haloParent(li+1, lj+1, lk)   + in_haloParent(li, lj+1, lk),
			&halo(N-1,0,N), &halo(N,0,N-1), &halo(N-1,0,N-1), &halo(N,0,N));
	}

	// Now the Y/Z edges -------------------------------------------------------------------------------------------------------
	if(in_nbr0MM.count()>0 && in_nbr0M0.count()>0 && in_nbr00M.count()>0){
		for(int i=0; i<N; ++i){
			halo(i, -1, -1)=in_nbr0MM(i, N-1, N-1);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_I>(
			in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li-1, lj, lk-1)
			+ in_haloParent(li-1, lj-1, lk)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj-1, lk-1) + in_haloParent(li,   lj, lk-1)
			+ in_haloParent(li,   lj-1, lk)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj-1, lk-1) + in_haloParent(li+1, lj, lk-1)
			+ in_haloParent(li+1, lj-1, lk)   + in_haloParent(li+1, lj, lk),
			&halo(0,-1,0), &halo(0,0,-1), &halo(0,0,0), &halo(0,-1,-1));
	}

	if(in_nbr0PM.count()>0 && in_nbr0P0.count()>0 && in_nbr00M.count()>0){
		for(int i=0; i<N; ++i){
			halo(i, N, -1)=in_nbr0PM(i, 0, N-1);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_I>(
			in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li-1, lj, lk-1)
			+ in_haloParent(li-1, lj+1, lk)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj+1, lk-1) + in_haloParent(li,   lj, lk-1)
			+ in_haloParent(li,   lj+1, lk)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj+1, lk-1) + in_haloParent(li+1, lj, lk-1)
			+ in_haloParent(li+1, lj+1, lk)   + in_haloParent(li+1, lj, lk),
			&halo(0,N,0), &halo(0,N-1,-1), &halo(0,N-1,0), &halo(0,N,-1));
	}

	if(in_nbr0MP.count()>0 && in_nbr0M0.count()>0 && in_nbr00P.count()>0){
		for(int i=0; i<N; ++i){
			halo(i, -1, N)=in_nbr0MP(i, N-1, 0);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_I>(
			in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li-1, lj, lk+1)
			+ in_haloParent(li-1, lj-1, lk)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj-1, lk+1) + in_haloParent(li,   lj, lk+1)
			+ in_haloParent(li,   lj-1, lk)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj-1, lk+1) + in_haloParent(li+1, lj, lk+1)
			+ in_haloParent(li+1, lj-1, lk)   + in_haloParent(li+1, lj, lk),
			&halo(0,0,N), &halo(0,-1,N-1), &halo(0,0,N-1), &halo(0,-1,N));
	}

	if(in_nbr0PP.count()>0 && in_nbr0P0.count()>0 && in_nbr00P.count()>0){
		for(int i=0; i<N; ++i){
			halo(i, N, N)=in_nbr0PP(i, 0, 0);
		}
	}else{
		extrapolateContinuousEdge3<T,N,STRIDE_I>(
			in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li-1, lj, lk+1)
			+ in_haloParent(li-1, lj+1, lk)   + in_haloParent(li-1, lj, lk),
			in_haloParent(li,   lj+1, lk+1) + in_haloParent(li,   lj, lk+1)
			+ in_haloParent(li,   lj+1, lk)   + in_haloParent(li,   lj, lk),
			in_haloParent(li+1, lj+1, lk+1) + in_haloParent(li+1, lj, lk+1)
			+ in_haloParent(li+1, lj+1, lk)   + in_haloParent(li+1, lj, lk),
			&halo(0,N-1,N), &halo(0,N,N-1), &halo(0,N-1,N-1), &halo(0,N,N));
	}

	//----------------------------------------------------------------------------------------------------------------------
	// and last do the 8 halo corners, copying from neighbour or patching into the parent tile if any neighbour is missing

	if(in_nbrMMM.count()>0 && in_nbr0MM.count()>0 && in_nbrM0M.count()>0 && in_nbr00M.count()>0 && in_nbrMM0.count()>0 && in_nbr0M0.count()>0 && in_nbrM00.count()>0){
		halo(-1,-1,-1)=in_nbrMMM(N-1,N-1,N-1);
	}else{
		halo(-1,-1,-1)=in_haloParent(li-1, lj-1, lk-1) + in_haloParent(li, lj-1, lk-1)
			+ in_haloParent(li-1, lj,   lk-1) + in_haloParent(li, lj,   lk-1)
			+ in_haloParent(li-1, lj-1, lk)   + in_haloParent(li, lj-1, lk)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk)
			- halo( 0,0,0) - halo( 0,0,-1) - halo( 0,-1,0) - halo( 0,-1,-1)
			- halo(-1,0,0) - halo(-1,0,-1) - halo(-1,-1,0);
	}

	if(in_nbrPMM.count()>0 && in_nbr0MM.count()>0 && in_nbrP0M.count()>0 && in_nbr00M.count()>0 && in_nbrPM0.count()>0 && in_nbr0M0.count()>0 && in_nbrP00.count()>0){
		halo(N,-1,-1)=in_nbrPMM(0,N-1,N-1);
	}else{
		halo(N,-1,-1)=in_haloParent(li, lj-1, lk-1) + in_haloParent(li+1, lj-1, lk-1)
			+ in_haloParent(li, lj,   lk-1) + in_haloParent(li+1, lj,   lk-1)
			+ in_haloParent(li, lj-1, lk)   + in_haloParent(li+1, lj-1, lk)
			+ in_haloParent(li, lj,   lk)   + in_haloParent(li+1, lj,   lk)
			- halo(N-1, 0, 0) - halo(N-1, 0, -1) - halo(N-1, -1, 0) - halo(N-1, -1, -1)
			- halo(N,   0, 0) - halo(N,   0, -1) - halo(N,   -1, 0);
	}

	if(in_nbrMPM.count()>0 && in_nbr0PM.count()>0 && in_nbrM0M.count()>0 && in_nbr00M.count()>0 && in_nbrMP0.count()>0 && in_nbr0P0.count()>0 && in_nbrM00.count()>0){
		halo(-1,N,-1)=in_nbrMPM(N-1,0,N-1);
	}else{
		halo(-1,N,-1)=in_haloParent(li-1, lj,   lk-1) + in_haloParent(li, lj,   lk-1)
			+ in_haloParent(li-1, lj+1, lk-1) + in_haloParent(li, lj+1, lk-1)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk)
			+ in_haloParent(li-1, lj+1, lk)   + in_haloParent(li, lj+1, lk)
			- halo(0, N-1,0) - halo(0, N-1,-1) - halo(0, N,0) - halo(0,N,-1)
			- halo(-1,N-1,0) - halo(-1,N-1,-1) - halo(-1,N,0);
	}

	if(in_nbrPPM.count()>0 && in_nbr0PM.count()>0 && in_nbrP0M.count()>0 && in_nbr00M.count()>0 && in_nbrPP0.count()>0 && in_nbr0P0.count()>0 && in_nbrP00.count()>0){
		halo(N,N,-1)=in_nbrPPM(0,0,N-1);
	}else{
		halo(N,N,-1)=in_haloParent(li, lj,   lk-1) + in_haloParent(li+1, lj,   lk-1)
			+ in_haloParent(li, lj+1, lk-1) + in_haloParent(li+1, lj+1, lk-1)
			+ in_haloParent(li, lj,   lk)   + in_haloParent(li+1, lj,   lk)
			+ in_haloParent(li, lj+1, lk)   + in_haloParent(li+1, lj+1, lk)
			- halo(N-1, N-1, 0) - halo(N-1, N-1, -1) - halo(N-1, N, 0) - halo(N-1, N, -1)
			- halo(N,   N-1, 0) - halo(N,   N-1, -1) - halo(N,   N, 0);
	}

	if(in_nbrMMP.count()>0 && in_nbr0MP.count()>0 && in_nbrM0P.count()>0 && in_nbr00P.count()>0 && in_nbrMM0.count()>0 && in_nbr0M0.count()>0 && in_nbrM00.count()>0){
		halo(-1,-1,N)=in_nbrMMP(N-1,N-1,0);
	}else{
		halo(-1,-1,N)=in_haloParent(li-1, lj-1, lk)   + in_haloParent(li, lj-1, lk)
			+ in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk)
			+ in_haloParent(li-1, lj-1, lk+1) + in_haloParent(li, lj-1, lk+1)
			+ in_haloParent(li-1, lj,   lk+1) + in_haloParent(li, lj,   lk+1)
			- halo(0, 0,N-1) - halo(0, 0,N) - halo(0, -1,N-1) - halo(0,-1,N)
			- halo(-1,0,N-1) - halo(-1,0,N) - halo(-1,-1,N-1);
	}

	if(in_nbrPMP.count()>0 && in_nbr0MP.count()>0 && in_nbrP0P.count()>0 && in_nbr00P.count()>0 && in_nbrPM0.count()>0 && in_nbr0M0.count()>0 && in_nbrP00.count()>0){
		halo(N,-1,N)=in_nbrPMP(0,N-1,0);
	}else{
		halo(N,-1,N)=in_haloParent(li, lj-1, lk)   + in_haloParent(li+1, lj-1, lk)
			+ in_haloParent(li, lj,   lk)   + in_haloParent(li+1, lj,   lk)
			+ in_haloParent(li, lj-1, lk+1) + in_haloParent(li+1, lj-1, lk+1)
			+ in_haloParent(li, lj,   lk+1) + in_haloParent(li+1, lj,   lk+1)
			- halo(N-1,0,N-1) - halo(N-1,0,N) - halo(N-1,-1,N-1) - halo(N-1,-1,N)
			- halo(N,  0,N-1) - halo(N,  0,N) - halo(N,  -1,N-1);
	}

	if(in_nbrMPP.count()>0 && in_nbr0PP.count()>0 && in_nbrM0P.count()>0 && in_nbr00P.count()>0 && in_nbrMP0.count()>0 && in_nbr0P0.count()>0 && in_nbrM00.count()>0){
		halo(-1, N, N)=in_nbrMPP(N-1, 0, 0);
	}else{
		halo(-1, N, N)=in_haloParent(li-1, lj,   lk)   + in_haloParent(li, lj,   lk)
			+ in_haloParent(li-1, lj+1, lk)   + in_haloParent(li, lj+1, lk)
			+ in_haloParent(li-1, lj,   lk+1) + in_haloParent(li, lj,   lk+1)
			+ in_haloParent(li-1, lj+1, lk+1) + in_haloParent(li, lj+1, lk+1)
			- halo(0, N-1,N-1) - halo(0, N-1,N) - halo(0, N,N-1) - halo(0,N,N)
			- halo(-1,N-1,N-1) - halo(-1,N-1,N) - halo(-1,N,N-1);
	}

	if(in_nbrPPP.count()>0 && in_nbr0PP.count()>0 && in_nbrP0P.count()>0 && in_nbr00P.count()>0 && in_nbrPP0.count()>0 && in_nbr0P0.count()>0 && in_nbrP00.count()>0){
		halo(N,N,N)=in_nbrPPP(0,0,0);
	}else{
		halo(N,N,N)=in_haloParent(li, lj,   lk)   + in_haloParent(li+1, lj,   lk)
			+ in_haloParent(li, lj+1, lk)   + in_haloParent(li+1, lj+1, lk)
			+ in_haloParent(li, lj,   lk+1) + in_haloParent(li+1, lj,   lk+1)
			+ in_haloParent(li, lj+1, lk+1) + in_haloParent(li+1, lj+1, lk+1)
			- halo(N-1,N-1,N-1) - halo(N-1,N-1,N) - halo(N-1,N,N-1) - halo(N-1,N,N)
			- halo(N,  N-1,N-1) - halo(N,  N-1,N) - halo(N,  N,N-1);
	}
}

}

//==============================================================================
// HaloedVisitor
//==============================================================================

// This is a simplified version of internal HaloedVisitor.
// This will be removed once the formal haloed visitor API is ready.
struct HaloedVisitor : Bifrost::API::Visitor
{
	template<typename T>
	struct HaloCache
	{ typedef std::vector<std::pair<Bifrost::API::TreeIndex::Tile,HaloedTile<T,1> > > Type; };

	virtual ~HaloedVisitor() {}

	template<typename T>
	void updateHaloCache(Bifrost::API::TreeIndex::Tile in_index, Bifrost::API::TreeIndex::Depth in_depth,
		typename HaloCache<T>::Type* io_haloCache, Bifrost::API::TileAccessor& in_acc, const Bifrost::API::VoxelChannel& in_channel) const
	{
		using namespace HaloedVisitorHelpers;
		assert(in_depth>=0 && (size_t)in_depth<io_haloCache->size());

		// already got it?
		if((*io_haloCache)[in_depth].first==in_index)
			return; // we're good

		// base case: already at a root
		const Bifrost::API::Tile node = in_acc.tile(in_index, in_depth);
		if(in_depth==0 || node.parent()<0){
			evalContinuousHaloedRootTile(in_channel.backgroundValue<T>(),
				in_channel.tileData<T>(in_index, in_depth), &(*io_haloCache)[in_depth].second);
			(*io_haloCache)[in_depth].first=in_index;
			return;
		}

		// otherwise recursively update the haloed parent
		updateHaloCache<T>(node.parent(), in_depth-1, io_haloCache, in_acc, in_channel);
		assert((*io_haloCache)[in_depth-1].first==node.parent());

		// figure out local coordinates within parent (which child it is)
		int ti=node.coord().i,
			tj=node.coord().j,
			tk=node.coord().k;
		int tw=node.info().dimInfo.depthWidth;
		const Bifrost::API::Tile parent = in_acc.tile(node.parent(), in_depth-1);
		int pi=parent.coord().i,
			pj=parent.coord().j,
			pk=parent.coord().k;
		int li=(ti-pi)/tw,
			lj=(tj-pj)/tw,
			lk=(tk-pk)/tw;

		// and evaluate haloed tile
		evalContinuousHaloedTile<T>((*io_haloCache)[in_depth-1].second, li, lj, lk,
			findTile<T>(ti-tw, tj-tw, tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj-tw, tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj-tw, tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj,    tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj,    tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj,    tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj+tw, tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj+tw, tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj+tw, tk-tw, in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj-tw, tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj-tw, tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj-tw, tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj,    tk,    in_depth, in_acc, in_channel),
			in_channel.tileData<T>(in_index, in_depth),
			findTile<T>(ti+tw, tj,    tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj+tw, tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj+tw, tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj+tw, tk,    in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj-tw, tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj-tw, tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj-tw, tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj,    tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj,    tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj,    tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti-tw, tj+tw, tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti,    tj+tw, tk+tw, in_depth, in_acc, in_channel),
			findTile<T>(ti+tw, tj+tw, tk+tw, in_depth, in_acc, in_channel),
			&(*io_haloCache)[in_depth].second);
		(*io_haloCache)[in_depth].first=in_index;
	}
};

#endif // _bifrostHaloedVisitor_h_
