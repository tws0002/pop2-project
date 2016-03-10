//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#ifndef _bifrostAABB_h_
#define _bifrostAABB_h_

#include <aminomath/vec.h>
#include <shader.h>

template<typename TraceIn, int T>
int aabb_dmin(const TraceIn& r)
{
	return r.sign[T] + T*2;
}

template<typename TraceIn, int T>
int aabb_dmax(const TraceIn& r)
{
	return 1 - r.sign[T] + T*2;
}

template<typename TraceIn, int T>
void aabb_tminmax(float& tmin, float& tmax, const amino::Math::vec3f* bounds, const TraceIn& r)
{
	tmin = (bounds[  r.sign[T]][T] - r.org[T]) * r.idir[T];
	tmax = (bounds[1-r.sign[T]][T] - r.org[T]) * r.idir[T];
}

// Axis aligned bounding box test that returns which sides of the box were hit.
// hitMin or hitMax returns -1 are set to -1 when no hit occurs.
//  Negative X = 0 Positive X = 1
//  Negative Y = 2 Positive Y = 3
//  Negative Z = 4 Positive Z = 5
template<typename TraceIn>
bool aabb_test(const amino::Math::vec3f* bounds, const TraceIn& r, int& hitMin, int& hitMax, float& t0, float& t1)
{
	float tmin, tmax, tymin, tymax, tzmin, tzmax;
	int dmin, dmax;

	aabb_tminmax<TraceIn,0>(tmin,  tmax,  bounds, r);
	aabb_tminmax<TraceIn,1>(tymin, tymax, bounds, r);
	if ((tmin > tymax) || (tymin > tmax))
	{
		hitMin = hitMax = -1;
		return false;
	}

	if (tymin > tmin)
	{
		tmin = tymin;
		dmin = aabb_dmin<TraceIn,1>(r);
	}
	else
	{
		dmin = aabb_dmin<TraceIn,0>(r);
	}

	if (tymax < tmax)
	{
		tmax = tymax;
		dmax = aabb_dmax<TraceIn,1>(r);
	}
	else
	{
		dmax = aabb_dmax<TraceIn,0>(r);
	}

	aabb_tminmax<TraceIn,2>(tzmin, tzmax, bounds, r);
	if ((tmin > tzmax) || (tzmin > tmax))
	{
		hitMin = hitMax = -1;
		return false;
	}

	if (tzmin > tmin)
	{
		tmin = tzmin;
		dmin = aabb_dmin<TraceIn,2>(r);
	}
	if (tzmax < tmax)
	{
		tmax = tzmax;
		dmax = aabb_dmax<TraceIn,2>(r);
	}

	if (tmin > r.start)
	{
		hitMin = dmin;
		t0 = tmin;
	}
	else
	{
		hitMin = -1;
		t0 = r.start;
	}
	if (tmax < r.end)
	{
		hitMax = dmax;
		t1 = tmax;
	}
	else
	{
		hitMax = -1;
		t1 = r.end;
	}

	return true;
}

bool roots(const float &a, const float &b, const float &c, float &x0, float &x1)
{
	float discr = b*b - 4*a*c;
	if (discr < 0)
	{
		return false;
	}
	else if (discr == 0)
	{
		x0 = x1 = -0.5f * b/a;
	}
	else
	{
		float q = (b > 0) ?
			-0.5f * (b + sqrt(discr)) :
			-0.5f * (b - sqrt(discr));
		x0 = q/a;
		x1 = c/q;
	}

	if (x0 > x1)
		std::swap(x0, x1);
	return true;
}

template<typename TraceIn>
bool intersect(const TraceIn& ray, float& hit, const amino::Math::vec3f& center, float radius2)
{
	amino::Math::vec3f L = ray.org - center;
	float b = 2.0f * mi_vector_dot((miVector*)&ray.dir, (miVector*)&L);
	float c = mi_vector_dot((miVector*)&L, (miVector*)&L) - radius2;

	float x0, x1;
	if (!roots( 1.0f, b, c, x0, x1))
		return false;

	if (x0 > ray.end || x0 < ray.start)
		return false;

	hit = x0;
	return true;
}

#endif // _bifrostAABB_h_
