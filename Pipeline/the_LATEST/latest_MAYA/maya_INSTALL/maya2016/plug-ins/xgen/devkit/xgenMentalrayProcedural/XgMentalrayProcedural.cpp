// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#include <algorithm>
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <vector>
#include <boost/format.hpp>
#include <iostream>
#include <fstream>
#include <sstream>
#include <zlib.h>
#include <cmath>

#include <shader.h>
#include <geoshader.h>

#include <XGen/XgRenderAPIUtils.h>
#include <XGen/XgDescription.h>
#include <XGen/XgPrimitive.h>
#include <XGen/XgPalette.h>
#include <XGen/SgCurve.h>

#include <SePlatform.h>

#include "XgHelpers.h"
#include "XgHairUtil.h"
#include "XgMentalrayProcedural.h"

#ifndef DLLEXPORT
#define DLLEXPORT
#endif

#define MAX_NAME_SIZE 65535
#define MAX_MOTION_TRANFORMS 9

#define MR_TYPE_FLOAT 0

#undef XGDebug
#undef XGError
#define XGError( x ) {}
#define XGDebug( x ) {}
#define XGDebugLevel 4

#define XGRenderAPIError XGError
#define XGRenderAPIWarning XGWarning
#define XGRenderAPIStats XGStats
#define XGRenderAPIDebug XGDebug

using namespace XGenRenderAPI::Utils;
using namespace XGenMR;
using namespace std;

// Tracing Macros
#if 0
#define DEBUG_TRACE(x) printf("%s %p\n",x, this)
#define DEBUG_TRACEP(x,p) printf("%s %p\n",x, p)
#else
#define DEBUG_TRACE(x)
#define DEBUG_TRACEP(x,p)
#endif

static bool s_bCleanDescriptionCache = true;
static int s_iProceduralID = 0;
static std::map<std::string, std::string> s_archives;
static const std::string k_strArchivesPrefix( "xgen_archives" );

// Doesn't come with shader.h or geoshader.h, must declare it manually
extern "C" void *mi_scene_create( miTag* const tag, const miScene_types type, ... );

// Some hair api constants
const int k_iPerPrim = 0;
const int k_iPerPoint = 1;
const char k_cRadius = 'r';
const char k_cNormal = 'n';
const char k_cTexture = 't';
const char k_cMotion = 'm';
const int k_maxPointsPerHairObject = 1000000;

// Interpolate Components Constants
const int k_iInterpolateFirstMotionVectorX = 10;
const int k_iInterpolateFirstMotionVectorY = 11;
const int k_iInterpolateFirstMotionVectorZ = 12;
const int k_iInterpolateOtherMotionVectorX = 13;
const int k_iInterpolateOtherMotionVectorY = 14;
const int k_iInterpolateOtherMotionVectorZ = 15;

namespace {
    // bbox helper functions
    static const double huge   = 1e36f;	// greatest storable +/- number

    void setEmptyBbox(bbox &b) {
        b.xmax = -huge; b.xmin = huge;
        b.ymax = -huge; b.ymin = huge;
        b.zmax = -huge; b.zmin = huge;
    }

    bool isEmptyBox(const bbox& b) {
        return (b.xmin > b.xmax || b.ymin > b.ymax || b.zmin > b.zmax);
    }

    void addBbox(bbox& result, const bbox& addBbox) {

        result.xmax = max(result.xmax, addBbox.xmax);
        result.ymax = max(result.ymax, addBbox.ymax);
        result.zmax = max(result.zmax, addBbox.zmax);

        result.xmin = min(result.xmin, addBbox.xmin);
        result.ymin = min(result.ymin, addBbox.ymin);
        result.zmin = min(result.zmin, addBbox.zmin);
    }

    // helper class for setting default object flags
    void initObjectFlags(miObject* object )
    {
        object->visible = miTRUE;
        object->shadow = object->reflection = object->refraction =
            object->transparency = object->caustic = object->globillum =
            object->finalgather = 3;
    }

    void addVector(miScalar	a, miScalar b, miScalar c)
    {
        miVector v;
        v.x=a; v.y=b; v.z=c;
        mi_api_vector_xyz_add(&v);
    }

    void addTriangle(int a, int b, int c)
    {
        mi_api_poly_begin_tag(1, 0);
        mi_api_poly_index_add(a);
        mi_api_poly_index_add(b);
        mi_api_poly_index_add(c);
        mi_api_poly_end();
    }

    // Create a sphere object. Called by a placeholder callback. 
    miTag createSphere(
        miTag tag,
        miInteger u_sub,
        miInteger v_sub)
    {

        miVector	v, tex;
        miInteger	i, j, nv=0;
        miScalar	p, r;

        assert (u_sub >= 3);
        assert (v_sub >= 1);

        string objName = mi_api_tag_lookup(tag);

        // Start Sphere object, add incremental statement for placeholder object
        mi_api_incremental(true);
        /*miObject *pObject =*/ mi_api_object_begin( mi_mem_strdup(objName.c_str() ));
        mi_api_basis_list_clear();
        mi_api_object_group_begin(0.0);

        tex.z = 0;
        for (i=1; i <= v_sub; i++) {
            v.z = -cos(i*M_PI/(v_sub+1));
            tex.x = i/miScalar(v_sub);
            r   = sqrt(1.-v.z*v.z);
            for (j=0; j < u_sub; j++, nv++) {
                p = j*2*M_PI/u_sub;
                v.x = r * cos(p);
                v.y = r * sin(p);
                tex.y = j/miScalar(u_sub);
                mi_api_vector_xyz_add(&v);	/* point */
                mi_api_vector_xyz_add(&v);	/* normal */
                mi_api_vector_xyz_add(&tex);/* tex coords */
            }
        }

        addVector(0, 0, -1);	/* south pole */
        addVector(0, 0, -1);
        addVector(0, 0, 0);

        addVector(0, 0, +1);	/* north pole */
        addVector(0, 0, +1);
        addVector(1, 1, 0);

        for (i=0; i < nv; i++) {
            mi_api_vertex_add(i*3);
            mi_api_vertex_normal_add(i*3+1);
            mi_api_vertex_tex_add(i*3+2, -1, -1); /* tex coords, no derivatives */
        }

        mi_api_vertex_add(nv*3+0);
        mi_api_vertex_normal_add(nv*3+1);
        mi_api_vertex_tex_add(nv*3+2, -1, -1);

        mi_api_vertex_add(nv*3+3);
        mi_api_vertex_normal_add(nv*3+4);
        mi_api_vertex_tex_add(nv*3+5, -1, -1);

        /* southpole */
        for (j=0; j < u_sub; j++)
            addTriangle(nv, (j+1)%u_sub, j);

        /* northpole */
        for (j=0; j < u_sub; j++)
            addTriangle(nv+1, nv-u_sub+j, nv-u_sub+((j+1)%u_sub));

        for (i=0; i < v_sub-1; i++) {
            for (j=0; j < u_sub; j++) {
                int p1 = i*u_sub+j;
                int p2 = i*u_sub+((j+1)%u_sub);
                int p3 = (i+1)*u_sub+((j+1)%u_sub);
                int p4 = (i+1)*u_sub+j;
                addTriangle(p1, p2, p4);
                addTriangle(p2, p3, p4);
            }
        }
        mi_api_object_group_end();
        return mi_api_object_end();
    }

	/*
	 * Evaluate the 4 control points to build a matrix frame
	 * This code is shared by spheres and archives
	 */
	void evalMatrix( miMatrixClass& matrix, mat44* out_xP, mat44* out_xN, const vec3* points_i, unsigned int j, double& prevAngle2, double bbox_scale, bool normalParam )
	{
		double length_ = 0.0;
		double width = 0.0;
		double depth = 0.0;
		vec3 P;
		vec3 lengthVec;
		vec3 axis1;
		double angle1 = 0.0;
		vec3 axis2;
		double angle2 = 0.0;
		vec3 zeroAxis = { 0.f, 0.f, 0.f };

		// Determine scaling values.
		const int p0 = j * 4; // Start of first point
		const int p1 = j * 4 + 1; // Start of second point
		const int p2 = j * 4 + 2; // Start of third point
		const int p3 = j * 4 + 3; // Start of fourth point


		P = points_i[p0];
		vec3 lengthP(points_i[p1]);
		vec3 midP((P + lengthP) / 2.0);
		vec3 widthP(points_i[p2]);
		vec3 depthP(points_i[p3]);
		lengthVec = lengthP - P;
		vec3 widthVec = widthP - midP;
		length_ = length(lengthVec);
		width = length(widthVec) * 2.0;
		depth = length(depthP - midP) * 2.0;

		// Determine axis and angle of rotation.
		vec3 yAxis = { 0.0, 1.0, 0.0 };
		vec3 xAxis = { 1.0, 0.0, 0.0 };
		vec3 xChange;

		axis1 = yAxis * lengthVec;
		if (normalize(axis1) > 0.0)
		{
			angle1 = angle(yAxis, lengthVec);
			xChange = rotateBy(xAxis, axis1, angle1);
		}
		else
		{
			angle1 = 0.0;
			axis1 = xAxis;
			xChange = xAxis;
		}
		axis2 = xChange * widthVec;
		if (normalize(axis2) > 0.0)
		{
			angle2 = angle(xChange, widthVec);
			if (dot(axis2, lengthVec) < 0.0)
				angle2 *= -1.0;
		}
		else
		{
			angle2 = 0.0;
		}
		axis2 = yAxis;

		// We want to make sure motion frames take the shortest
		// distance from an angular position.
		if (out_xP==NULL)
		{
			if (angle2 - prevAngle2 > 3.14159)
			{
				angle2 -= 6.28319;
			}
			else if (angle2 - prevAngle2 < -3.14159)
			{
				angle2 += 6.28319;
			}
		}
		prevAngle2 = angle2;

		// Now use these values to create the transforms for each motion
		// sample and put in a motion block
		mat44 xP;
		{
			mat44 tmp;
			// Translation
			translation(tmp, P);
			xP = tmp;

			// Rotation 1
			if (axis1 != zeroAxis)
			{
				rotation(tmp, axis1, (float) angle1);
				multiply(xP, xP, tmp);
				if (normalParam && out_xN)
					*out_xN = tmp;
			}

			// Rotation 2
			if (axis2 != zeroAxis)
			{
				rotation(tmp, axis2, (float) angle2);
				multiply(xP, xP, tmp);
				if (normalParam && out_xN)
					multiply(*out_xN, *out_xN, tmp);
			}

			// Scale
			vec3 scaleV;
			scaleV.x = (float) (bbox_scale * width);
			scaleV.y = (float) (bbox_scale * length_);
			scaleV.z = (float) (bbox_scale * depth);
			scale(tmp, scaleV);
			multiply(xP, xP, tmp);

			if( out_xP )
				*out_xP = xP;
		}
		//
		// Convert to miMatrix
		const float* xPi = &xP._00;
		miMatrix tmp = { miScalar(xPi[0]), miScalar(xPi[1]), miScalar(
				xPi[2]), miScalar(xPi[3]), miScalar(xPi[4]), miScalar(
				xPi[5]), miScalar(xPi[6]), miScalar(xPi[7]), miScalar(
				xPi[8]), miScalar(xPi[9]), miScalar(xPi[10]), miScalar(
				xPi[11]), miScalar(xPi[12]), miScalar(xPi[13]), miScalar(
				xPi[14]), miScalar(xPi[15]) };

		mi_matrix_copy( matrix.m, tmp);
	}

	// Compute motion bounding box of the object
	void computeMotionBox(miObject* object, PatchRenderer* patch)
	{
		// Empty the out motion box
		bbox mbox;
		setEmptyBbox(mbox);

		// Get the bounding box of the first sample
		bbox bboxFirst;
		patch->motionBoundingBox(bboxFirst, 0);

		// Iterate through motion samples and compute the approx motion box
		bbox bboxOther;
		unsigned int sample = 1;
		while (patch->motionBoundingBox(bboxOther, sample++))
		{
			double mv[24] = {
				bboxOther.xmin-bboxFirst.xmin, bboxOther.ymin-bboxFirst.ymin, bboxOther.zmin-bboxFirst.zmin,
				bboxOther.xmax-bboxFirst.xmax, bboxOther.ymin-bboxFirst.ymin, bboxOther.zmin-bboxFirst.zmin,
				bboxOther.xmin-bboxFirst.xmin, bboxOther.ymax-bboxFirst.ymax, bboxOther.zmin-bboxFirst.zmin,
				bboxOther.xmin-bboxFirst.xmin, bboxOther.ymin-bboxFirst.ymin, bboxOther.zmax-bboxFirst.zmax,
				bboxOther.xmax-bboxFirst.xmax, bboxOther.ymax-bboxFirst.ymax, bboxOther.zmin-bboxFirst.zmin,
				bboxOther.xmin-bboxFirst.xmin, bboxOther.ymax-bboxFirst.ymax, bboxOther.zmax-bboxFirst.zmax,
				bboxOther.xmax-bboxFirst.xmax, bboxOther.ymin-bboxFirst.ymin, bboxOther.zmax-bboxFirst.zmax,
				bboxOther.xmax-bboxFirst.xmax, bboxOther.ymax-bboxFirst.ymax, bboxOther.zmax-bboxFirst.zmax
			};
			for (int i = 0; i < 8; i++)
			{
				mbox.xmin = std::min(mbox.xmin, mv[i*3]);
				mbox.ymin = std::min(mbox.ymin, mv[i*3+1]);
				mbox.zmin = std::min(mbox.zmin, mv[i*3+2]);
				mbox.xmax = std::max(mbox.xmax, mv[i*3]);
				mbox.ymax = std::max(mbox.ymax, mv[i*3+1]);
				mbox.zmax = std::max(mbox.zmax, mv[i*3+2]);
			}
		}

		// Set the motion box attributes
		if (!isEmptyBox(mbox))
		{
			object->mbox_explicit = miTRUE;
			object->bbox_min_m.x = (miScalar)mbox.xmin;
			object->bbox_min_m.y = (miScalar)mbox.ymin;
			object->bbox_min_m.z = (miScalar)mbox.zmin;
			object->bbox_max_m.x = (miScalar)mbox.xmax;
			object->bbox_max_m.y = (miScalar)mbox.ymax;
			object->bbox_max_m.z = (miScalar)mbox.zmax;
        }
	}
} // closing anonymous namespace

// Auto Xgen Mutex
/////////////////////////////////////////////////////////////////////////////////
SeExprInternal::_Mutex xgMutex;
class XgAutoMutex
{
public:
	XgAutoMutex()
	{
		xgMutex.lock();
	}
	~XgAutoMutex()
	{
		xgMutex.unlock();
	}
};

namespace XGenMR {

// A simple string tokenizer
void split(std::vector<std::string>& out_vec, const std::string& in_str, const std::string& in_delimiters )
{
	size_t current;
	size_t next = (size_t)-1;
	do
	{
		current = next + 1;
		next = in_str.find_first_of(in_delimiters, current);
		out_vec.push_back(in_str.substr(current, next - current));
	}
	while (next != string::npos);
}

// Get a string value out of a miTag
void eval_string(miState* state, miTag& io_tag, std::string& out_str)
{
	miTag tag = *mi_eval_tag( &io_tag );
	char* str = (char*) mi_db_access(tag);
	out_str = str;
}

// Get tokens from user/override strings
void tokenize(const std::string& s, std::vector<std::string>& tokens)
{
	int state = 0;
	string::size_type size = s.size();
	if (size <= 2)
		return;

	string::size_type startString = 0;

	string::size_type i = 0;
	while (i < size)
	{
		const char c = s.at(i);
		const char c_last = (i > 0) ? s.at(i - 1) : '\0';

		if (state == 0)
		{
			if (c == ' ')
			{
				string tmp = s.substr(startString, i - startString);
				tokens.push_back(tmp);
				startString = i;
				state = 2;
			}
		}
		else if (state == 1)
		{
			if (c == '"' && c_last != '\\')
			{
				string tmp = s.substr(startString, i - startString);
				tokens.push_back(tmp);
				startString = i;
				state = 2;
			}
		}
		else if (state == 2)
		{
			if (c == ' ')
			{
				startString = i;
			}
			else if (c == '"')
			{
				startString = i + 1;
				state = 1;
			}
			else if (c != ' ')
			{
				startString = i;
				state = 0;
			}
		}

		i++;
	}
}

std::string quotifyWithSpace( const char* s )
{
	return std::string("\"") + std::string(s) +std::string("\" ");
}

std::string buildArchiveKey( const char* parentName, const char* archivesAbsolute, const char* archivesObjects, const char*archivesMaterial, miScalar archivesFrame )
{
	std::string key;
	key += quotifyWithSpace(parentName);
	key += quotifyWithSpace(archivesAbsolute);
	key += quotifyWithSpace(archivesObjects); 
	key += quotifyWithSpace(archivesMaterial);
	key += boost::str( boost::format("%0.2f") % archivesFrame );
	return key;
}

// File extension check
/////////////////////////////////////////////////////////////////////////////////
enum ArchiveExtension
{
	eUnsupported, eAssembly, eAssemblyGZ, eAbc
};

ArchiveExtension getArchiveExtension(const std::string& filename)
{
	std::string ext3 = filename.size() > 3 ? filename.substr(filename.size() - 3) : "";
	std::string ext2 = filename.size() > 3 ? filename.substr(filename.size() - 2) : "";
	std::string ext5 = filename.size() > 6 ? filename.substr(filename.size() - 5) : "";
	if (ext2 == "mi")
		return eAssembly;
	else if (ext5 == "mi.gz")
		return eAssemblyGZ;
	else if (ext3 == "abc")
		return eAbc;
	else
		return eUnsupported;
}
// BaseProcedural
/////////////////////////////////////////////////////////////////////////////////
BaseProcedural::BaseProcedural( const BaseProcedural* parentProc )
{
	if( parentProc!=NULL )
	{
		m_user = parentProc->m_user;
		m_overrides = parentProc->m_overrides;
	}
}

BaseProcedural::~BaseProcedural()
{

}

bool BaseProcedural::getString(const ParamMap& in_params, const char* in_name, const char*& out_value, bool in_user ) const
{
	ParamMap::const_iterator it = in_params.find(in_name);
	if (it == in_params.end() || !it->second->isString())
		return false;

	out_value = it->second->asString()->c_str();
	return true;
}

bool BaseProcedural::getFloat(const ParamMap& in_params, const char* in_name, float& out_value, bool in_user) const
{
	ParamMap::const_iterator it = in_params.find(in_name);
	if (it == in_params.end() || !it->second->isFloat())
		return false;

	out_value = *it->second->asFloat();
	return true;
}

bool BaseProcedural::getFloatArray(const ParamMap& in_params, const char* in_name, const float*& out_value, bool in_user) const
{
	ParamMap::const_iterator it = in_params.find(in_name);
	if (it == in_params.end() || !it->second->isFloatArray())
		return false;

	out_value = &(*it->second->asFloatArray())[0];
	return true;
}

bool BaseProcedural::getMatrixArray(const ParamMap& in_params, const char* in_name, const miMatrix*& out_value, bool in_user) const
{
	ParamMap::const_iterator it = in_params.find(in_name);
	if (it == in_params.end() || !it->second->isMatrixArray())
		return false;

	out_value = &((*it->second->asMatrixArray())[0].m_matrix);
	return true;
}

unsigned int BaseProcedural::getArraySize(const ParamMap& in_params, const char* in_name, int in_eType, bool in_user) const
{
	ParamMap::const_iterator it = in_params.find(in_name);

	unsigned int ret = 0;
	if (it != in_params.end())
	{
		if (it->second->isMatrixArray())
		{
			ret = (unsigned int) it->second->asMatrixArray()->size();
		}
		else if (it->second->isFloatArray())
		{
			ret = (unsigned int) it->second->asFloatArray()->size();
		}
	}
	return ret;
}

bool BaseProcedural::get(EBoolAttribute in_attr) const
{
	if (in_attr == ProceduralCallbacks::ClearDescriptionCache)
	{
		bool ret = s_bCleanDescriptionCache;
		s_bCleanDescriptionCache = false;
		return ret;
	}
	else if (in_attr == ProceduralCallbacks::DontUsePaletteRefCounting)
	{
		return false;
	}

	return false;
}

const char* BaseProcedural::get(EStringAttribute in_attr) const
{
	static string result;
	const char* cstr = NULL;

	if (in_attr == BypassFXModulesAfterBGM)
	{
		if (getString(m_user, "xgen_bypassFXModulesAfterBGM", cstr, true))
		{
			return cstr;
		}
	}
	else if (in_attr == CacheDir)
	{
		result = "xgenCache/";

		if (getString(m_user, "xgenCache", cstr, true))
		{
			string tmp = cstr;
			if (tmp.size()) {
				result = tmp;
			}
		}
		return result.c_str();
	}
	else if (in_attr == Off)
	{
		if (getString(m_user, "xgen_OFF", cstr, true))
		{
			if (stob(cstr))
			{
				//XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "Ribbox disabled XGen patch " + _patch->name() + " from rendering." );
				return "xgen_OFF";
			}
		}
	}
	else if (in_attr == Generator)
	{
		if (getString(m_user, "generator", cstr, true))
			return cstr;
	}
	else if (in_attr == RenderCam)
	{
		if (getString(m_user, "irRenderCam", cstr, true))
			return cstr;
	}
	else if (in_attr == RenderCamFOV)
	{
		if (getString(m_user, "irRenderCamFOV", cstr, true))
			return cstr;
	}
	else if (in_attr == RenderCamXform)
	{
		if (getString(m_user, "irRenderCamXform", cstr, true))
			return cstr;
	}
	else if (in_attr == RenderCamRatio)
	{
		if (getString(m_user, "irRenderCamRatio", cstr, true))
			return cstr;
	}
	else if (in_attr == RenderMethod)
	{
		if (getString(m_user, "xgen_renderMethod", cstr, true))
			return cstr;
	}
	else if (in_attr == Phase)
	{
		if (getString(m_user, "phase", cstr, true))
			return cstr;
	}
	return "";
}

float BaseProcedural::get(EFloatAttribute in_attr) const
{
	float result = 0.f;

	if (in_attr == ShadowMotionBlur)
	{
		if (getFloat(m_user, "shadowMotionBlur", result, true))
			return result;
	}
	else if (in_attr == ShutterOffset)
	{
		float shutter_start = 0.0f;
		float shutter_end = 0.f;

		getFloat(m_user, "shutter_start", shutter_start, false);
		getFloat(m_user, "shutter_end", shutter_end, false);

		float shutter_offset = shutter_start
				+ 0.5f * (shutter_end - shutter_start);
		return shutter_offset;
	}

	return 0.f;
}

const float* BaseProcedural::get(EFloatArrayAttribute in_attr) const
{
	const float* resultPtr = NULL;
	unsigned int uiArraySize = 0;

	if (in_attr == DensityFalloff)
	{
		uiArraySize = getArraySize(m_user, "xgen_densityFalloff", MR_TYPE_FLOAT, true);
		if (uiArraySize == 7)
		{
			if (getFloatArray(m_user, "xgen_densityFalloff", resultPtr, true))
				return resultPtr;
		}
	}
	else if (in_attr == LodHi)
	{
		uiArraySize = getArraySize(m_user, "xgen_lodHi", MR_TYPE_FLOAT, true);
		if (uiArraySize == 2)
		{
			if (getFloatArray(m_user, "xgen_lodHi", resultPtr, true))
				return resultPtr;
		}
	}
	else if (in_attr == LodLow)
	{
		uiArraySize = getArraySize(m_user, "xgen_lodLo", MR_TYPE_FLOAT, true);
		if (uiArraySize == 2)
		{
			if (getFloatArray(m_user, "xgen_lodLo", resultPtr, true))
				return resultPtr;
		}
	}
	else if (in_attr == LodMed)
	{
		uiArraySize = getArraySize(m_user, "xgen_lodMed", MR_TYPE_FLOAT, true);
		if (uiArraySize == 2)
		{
			if (getFloatArray(m_user, "xgen_lodMed", resultPtr, true))
				return resultPtr;
		}
	}
	else if (in_attr == Shutter)
	{
		uiArraySize = getArraySize(m_user, "time_samples", MR_TYPE_FLOAT, true);
		if (getFloatArray(m_user, "time_samples", resultPtr, false))
			return resultPtr;
	}

	return NULL;
}

unsigned int BaseProcedural::getSize(EFloatArrayAttribute in_attr) const
{
	if (in_attr == DensityFalloff)
	{
		return getArraySize(m_user, "xgen_densityFalloff", MR_TYPE_FLOAT, true);
	}
	else if (in_attr == LodHi)
	{
		return getArraySize(m_user, "xgen_lodHi", MR_TYPE_FLOAT, true);
	}
	else if (in_attr == LodLow)
	{
		return getArraySize(m_user, "xgen_lodLo", MR_TYPE_FLOAT, true);
	}
	else if (in_attr == LodMed)
	{
		return getArraySize(m_user, "xgen_lodMed", MR_TYPE_FLOAT, true);
	}
	else if (in_attr == Shutter)
	{
		return getArraySize(m_user, "time_samples", MR_TYPE_FLOAT, false);
	}

	return 0;
}

const char* BaseProcedural::getOverride(const char* in_name) const
{
	const char* cstr = NULL;
	if (getString(m_overrides, in_name, cstr, true) && cstr != NULL)
	{
		return cstr;
	}

	return "";
}
// Procedural ctor
/////////////////////////////////////////////////////////////////////////////////
Procedural::Procedural()
: BaseProcedural( NULL )
, m_patch(NULL)
, m_face(NULL)
, m_node(miNULLTAG)
, m_result(miNULLTAG)
, m_dummy(miNULLTAG)
, m_tagUserData(miNULLTAG)
, m_tagPlaceholderObject(miNULLTAG)
, m_numHairPoints(0)
, m_numHairPrims(0)
, m_faceBegin(0)
, m_faceEnd(0)
, m_state(NULL)
, m_bPerFaceAssemblies(false)
, m_bSyncArchives(false)
, m_archives(NULL)
, m_bEcho(false)
, m_approx_degree(1)
, m_approx_mode(1)
, m_approx_parametric_subdivisions(3)
, m_approx_fine_sub_pixel_size(0.1f)
, m_motion_blur(false)
, m_motion_blur_mode(0)
, m_motion_blur_steps(1)
, m_motion_blur_factor(1.f)
, m_motion_blur_multiplier(1.f)
, m_max_displace(0.f)
, m_sphere_subdiv_u(40)
, m_sphere_subdiv_v(40)
{
}

// Procedural dtor
/////////////////////////////////////////////////////////////////////////////////
Procedural::~Procedural()
{
	DEBUG_TRACE( "Procedural::~Procedural()" );

	/*if( m_patch!=NULL && m_archives!=NULL )
	 {
	 delete m_archives;
	 }*/

	if (m_face)
	{
		delete m_face;
		m_face = NULL;
	}

	for( TProcList::iterator it = m_patches.begin(); it != m_patches.end(); ++it )
	{
		if( *it )
		{
			delete *it;
			*it = NULL;
		}
	}
	m_patches.clear();

	if (m_patch)
	{
		delete m_patch;
		m_patch = NULL;
	}
}

// Next face on the patch
/////////////////////////////////////////////////////////////////////////////////
bool Procedural::nextFace(bbox& b, unsigned int& f)
{
	return m_patch->nextFace(b, f);
}

// Init a patch renderer
/////////////////////////////////////////////////////////////////////////////////
bool Procedural::initPatchRenderer(const char* in_params)
{
	DEBUG_TRACE( "Procedural::initPatchRenderer()" );

	m_patch = PatchRenderer::init((ProceduralCallbacks*) this, in_params);
	if (m_patch == NULL)
		return false;

	Description* pDesc = m_patch->getDescription();
	if (pDesc == NULL)
	{
		delete m_patch;
		m_patch = NULL;
		return false;
	}

	m_primType = pDesc->get(Description::PrimitiveType);

	// Get the patch bounding box.
	bbox boxPref, box;
	m_patch->boundingBox( boxPref, true );
	m_patch->boundingBox( box, false );
	
	// The patch bounding boxes would be useful if we were to generate nested assemblies.
	// printf( "boxPref=(%f,%f,%f) (%f,%f,%f)\n", boxPref.xmin, boxPref.ymin, boxPref.zmin, boxPref.xmax, boxPref.ymax, boxPref.zmax );
	// printf( "box=(%f,%f,%f) (%f,%f,%f)\n", box.xmin, box.ymin, box.zmin, box.xmax, box.ymax, box.zmax );
	
	// If echo is turned, we don't want per face assemblies.
	if( m_bEcho )
	{
	    m_bPerFaceAssemblies = false;
	}
	else // Otherwise, use per face assemblies for anything but archives. Spheres and splines are rendered per patch.
	{
	    m_bPerFaceAssemblies = m_primType != std::string("ArchivePrimitive");
	}
	return true;
}

// Init a face renderer
/////////////////////////////////////////////////////////////////////////////////
bool Procedural::initFaceRenderer(Procedural* pProc, unsigned int f)
{
	DEBUG_TRACE( "Procedural::initFaceRenderer()" );
	pProc->m_face = FaceRenderer::init(m_patch, f, pProc);
	return pProc->m_face != NULL;
}

// Render a hair object (one per patch)
/////////////////////////////////////////////////////////////////////////////////
bool Procedural::renderHairObject(miTag* result, const miState* state)
{
    // write the hair object header
    miHair_list* pHair = beginHairObject();

    // Run a face callback to initialize the user data and determine sizes (scalarsPerPrim/perPoint)
    UserDataList userData;
    unsigned int f = (unsigned int)-1;
    bbox b;
    unsigned int numScalars = 0;

    // For the first face, we write out the user data format and compute number of scalars per point/prim.
    InitHairDataProcedural dataProc(*this, &userData, pHair);
    while (nextFace(b, f) && !dataProc.isValid())
    {
        InitHairDataProcedural::initFaceRenderer(&dataProc, m_patch, f);
        dataProc.render();
    }
    if (dataProc.isValid()) {
        numScalars = m_numHairPoints * dataProc.getNumScalarsPerPoint()
            +  m_numHairPrims * dataProc.getNumScalarsPerPrim();
        
        // Allocate the scalar array and the index list
        miScalar* pHairScalars = mi_api_hair_scalars_begin( (int) numScalars );
        miGeoIndex* pHairIndices = mi_api_hair_hairs_begin( m_numHairPrims + 1);
    
        // Write out the hair data
        FlushHairDataProcedural flushProc(*this, pHairIndices, pHairScalars, &userData,
            dataProc.getNumScalarsPerPoint(), 
            dataProc.getNumScalarsPerPrim(),
            dataProc.getNumInterpolateComponents(), numScalars, m_numHairPrims+1);
        f =  m_faceBegin;
        while (nextFace(b, f) && f <= m_faceEnd)
        {
            if (isEmpty(b))
                continue;
            FlushHairDataProcedural::initFaceRenderer(&flushProc, m_patch, f);
            flushProc.render();
        }
    }
    endHairObject(numScalars, dataProc.getUserDataStrFormat());
    return true;
}

// Render a face
/////////////////////////////////////////////////////////////////////////////////
bool Procedural::render(miTag* result, const miState* state)
{
	DEBUG_TRACE( "Procedural::render()" );

	m_result = miNULLTAG;
	m_state = state;
    bool b = false;

    // Assert that hair objects (splines) are always rendered on the patch level.
    assert( m_primType != std::string("SplinePrimitive") || m_patch != 0 );
    assert( m_primType != std::string("SpherePrimitive") || m_patch != 0 );
    if (m_primType == std::string("SplinePrimitive") && m_patch != 0) {
        b = renderHairObject(result,  state);
    } else if (m_primType == std::string("SpherePrimitive") && m_patch != 0) {
        b = renderSphereAssembly();
    } else{

	    if (m_face == NULL)
		    return false;
        b = m_face->render();
    }
	// Return the dummy group if the result is null.
	*result = m_result!=0 ? m_result : m_dummy;
	m_state = NULL;
	return b;
}

// Init MR entry point
/////////////////////////////////////////////////////////////////////////////////
void Procedural::init(miState* state, Params* paras, miBoolean *inst_init_req)
{
	DEBUG_TRACE( "Procedural::init()" );
	// Patch Init
	if (m_patch == NULL && m_face == NULL && m_patches.size()==0 )
	{
		// Transfert the echo flag.
		m_bEcho = *mi_eval_boolean(&paras->echo)==miTRUE;

		// Eval and validate the approximation settings
		{
			m_approx_degree = *mi_eval_integer(&paras->approx_degree);
			if( m_approx_degree < 1 ) m_approx_degree = 1;
			else if( m_approx_degree > 3 ) m_approx_degree = 3;

			m_approx_mode = *mi_eval_integer(&paras->approx_mode);
			if( m_approx_degree == 1 ) m_approx_mode = 0;
			else if( m_approx_mode < 0 ) m_approx_mode = 0;
			else if( m_approx_mode > 2 ) m_approx_mode = 2;

			m_approx_parametric_subdivisions = *mi_eval_integer(&paras->approx_parametric_subdivisions);
			if( m_approx_parametric_subdivisions < 0 ) m_approx_parametric_subdivisions = 0;

			m_approx_fine_sub_pixel_size = *mi_eval_scalar(&paras->approx_fine_sub_pixel_size);
			if( m_approx_fine_sub_pixel_size < 0.f ) m_approx_fine_sub_pixel_size = 0.f;
		}

		// Eval parameters that are added with version 2
		int version = 1;
		if (!mi_query(miQ_DECL_VERSION, state, 0, &version))
			mi_warning("xgen_geo init failed, decl version not available");

		if (version > 1) {
			m_max_displace = *mi_eval_scalar(&paras->max_displace);
            m_sphere_subdiv_u = *mi_eval_integer(&paras->m_sphere_subdiv_u);
            m_sphere_subdiv_v = *mi_eval_integer(&paras->m_sphere_subdiv_v);
        }
		// Eval the data string
		eval_string( state, paras->data, m_data );

		// Eval the user string
		std::string strUser;
		eval_string( state, paras->user, strUser );

		// Overload the frame parameter
		miScalar frame = *mi_eval_scalar( &paras->frame );
		miScalar mayaMotionLength = 0.0f;
		{
			miScalar shutterOpen  = 0.0f;
			miScalar shutterClose = 0.0f;

			// Get the shutterOpen and shutterClose from camera user data block.
			miTag cameraUserdata = state->camera->userdata;
			while (cameraUserdata != miNULLTAG)
			{
				miUserdata* data = (miUserdata*)mi_db_access(cameraUserdata);

				miParam_type type;
				int offset;

				if (mi_api_parameter_lookup(&type, 0, &offset, data->data_decl, miFALSE, mi_mem_strdup("shutterOpen"))
						&& type == miTYPE_SCALAR)
					shutterOpen = *(const miScalar*)(data->parameters + offset);

				if (mi_api_parameter_lookup(&type, 0, &offset, data->data_decl, miFALSE, mi_mem_strdup("shutterClose"))
						&& type == miTYPE_SCALAR)
					shutterClose = *(const miScalar*)(data->parameters + offset);

				miTag nextUserData = data->next_data;
				mi_db_unpin(cameraUserdata);
				cameraUserdata = nextUserData;
			}

			// Mentalray sets the current frame to the last sample time when rendering motion blur.
			// The frame parameter from the time node is not the correct rendering frame.
			// We check this situation and override the frame by the current time from camera.
			// Note that if the frame is not the the last sample time, we assume there is a re-timing.
			if (state->options->motion && shutterOpen != 0.0f && shutterClose != 0.0f &&
				std::fabs(frame - shutterClose) < 0.0001)
			{
				frame = state->camera->frame_time;
				mayaMotionLength = shutterClose - shutterOpen;
			}

			// Output the frame parameter
			char buf[256];
			snprintf(buf, 256, " -frame %f", frame);
			m_data += buf;
		}

		// Eval and validate the motion blur settings
		{
			m_motion_blur = *mi_eval_boolean(&paras->motion_blur)==miTRUE;

			m_motion_blur_mode = *mi_eval_integer(&paras->motion_blur_mode);
			if( m_motion_blur_mode < 0 ) m_motion_blur_mode = 0;
			else if( m_motion_blur_mode > 2 ) m_motion_blur_mode = 2;

			m_motion_blur_steps = *mi_eval_integer(&paras->motion_blur_steps);
			if( m_motion_blur_steps < 1 ) m_motion_blur_steps = 1;
			else if( m_motion_blur_steps > 15 ) m_motion_blur_steps = 15;

			m_motion_blur_factor = *mi_eval_scalar(&paras->motion_blur_factor);
			m_motion_blur_multiplier = *mi_eval_scalar(&paras->motion_blur_multiplier);

			// Count the number of samples.
			// It's forced to zero when motion blur is deactivated or factor is zero or multiplier is zero.
			bool wantBlur = m_motion_blur && fabs(m_motion_blur_factor)>0.000001f && fabs(m_motion_blur_multiplier)>0.000001f;
			miInteger numSamples = wantBlur ? m_motion_blur_steps+1 : 0;
			if( numSamples>=2 )
			{
				// Compute the motion samples
				std::vector<float> samples;

				// motionlength = motionBlurBy * (motionCamera ? shutter : 1.0)
				miScalar motionlength = m_motion_blur_factor *
					(mayaMotionLength != 0.0f ? mayaMotionLength : 1.0f);

				// motionoffset: start, middle or end
				miScalar motionoffset = 0.5f;
				switch (m_motion_blur_mode)
				{
				case 0: motionoffset = 0.0f; break;
				case 1: motionoffset = 0.5f; break;
				case 2: motionoffset = 1.0f; break;
				}

				// start = time - (motionlength * motionOffset)
				// end   = time + (motionlength * (1 - motionOffset)
				miScalar sampleStart = - motionlength * motionoffset;
				samples.push_back(sampleStart);

				miScalar sampleTime = sampleStart;
				miScalar sampleStep = motionlength / m_motion_blur_steps;
				for (miInteger i = 1; i < m_motion_blur_steps; i++)
				{
					sampleTime += sampleStep;
					samples.push_back(sampleTime);
				}

				miScalar sampleEnd = motionlength * (1.0f - motionoffset);
				samples.push_back(sampleEnd);

				// Format samples to init arguments.
				std::string strMotionSamplesUser, strMotionSamplesData;
				const size_t bufsize = 100;
				char buf[bufsize];
				for( size_t s=0; s<samples.size(); ++s )
				{
					// Data string expects floats separated by spaces
					snprintf( buf, bufsize, "%f%s", samples[s], s!=samples.size()-1 ? " " : "" );
					strMotionSamplesData += buf;

					// User string expects floats separated by spaces
					snprintf( buf, bufsize,"%f%s", samples[s], s!=samples.size()-1 ? "," : "" );
					strMotionSamplesUser += buf;
				}

				// Overload the data and user string
				m_data += " -motionSamplesLookup " + strMotionSamplesData;
				m_data += " -motionSamplesPlacement " + strMotionSamplesData;
				strUser += " time_samples \"" + strMotionSamplesUser + "\"]";
			}

		}

		// Tokenize the user attributes
		{
			std::vector < std::string > tokens;
			tokenize(strUser, tokens);

			for( std::vector<std::string>::const_iterator it = tokens.begin(); it != tokens.end(); ++it )
			{
				const std::string& key = *(it++);
				if (key == "xgen_bypassFXModulesAfterBGM" || key == "xgenCache"
						|| key == "xgen_OFF" || key == "generator"
						/*|| key == "irRenderCam" || key == "irRenderCamFOV"
						|| key == "irRenderCamXform"
						|| key == "irRenderCamRatio"*/
						|| key == "xgen_renderMethod") {
					m_user[key] = new Param(*it);
				} else if (key == "shadowMotionBlur" || key == "shutter_start"
						|| key == "shutter_end") {
					string value = *it;
					float f = 0.0f;
					/*int num = */sscanf(value.c_str(), "%f", &f);
					m_user[key] = new Param(f);
				}
				else if (key == "time_samples") {
					std::vector<float> vf;
					std::vector<std::string> vs;
					XGenMR::split( vs, *it, "," );

					for( std::vector<std::string>::const_iterator s=vs.begin(); s!=vs.end(); ++s )
					{
						float f = 0.0f;
						/*int num = */sscanf(s->c_str(), "%f", &f);
						vf.push_back(f);
					}
					m_user[key] = new Param(vf);
				}
			}

			// Take camera information from the mi state
			{
				char buf[1024];
				miVector cam = { 0.f, 0.f, 0.f };
				{
					miVector internalSpace = { 0.f, 0.f, 0.f };
					mi_point_from_camera( state, &internalSpace, &cam );
					mi_point_to_world( state, &cam, &internalSpace );
				}
				snprintf( buf, 1024, "false,%f,%f,%f", cam.x, cam.y, cam.z );
				m_user["irRenderCam"] = new Param( std::string(buf) );

				float camFov = 45.f;
				{
					float f = state->camera->focal;
					float a_div_2 = state->camera->aperture*0.5f;
					camFov = 2.f*atan2( a_div_2, f ) / (float)M_PI * 180.f;
				}
				snprintf( buf, 1024,"%f, %f", state->camera->aspect*camFov, camFov );
				m_user["irRenderCamFOV"] = new Param( std::string(buf) );

				snprintf( buf, 1024, "%f", state->camera->aspect );
				m_user["irRenderCamRatio"] = new Param( std::string(buf) );

				miInstance* inst = (miInstance*)mi_db_access( state->camera_inst );
				miMatrix& im = inst->tf.local_to_global;
				miMatrix& m = inst->tf.global_to_local;

				// I had trouble building the same matrix that was being used in the viewport.
				// The matrix format is inverted plus the translation components aren't on the right spot.
				// I'm also puzzled by the need to use m[12],m[13],m[14] for translation instead of im[].
				snprintf( buf, 1024, "%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f", im[0], im[4], im[8], im[3],
																						im[1], im[5], im[9], im[7], 
																						im[2], im[6], im[10], im[11], 
																						m[12], m[13], m[14], im[15] );
				m_user["irRenderCamXform"] = new Param( std::string(buf) );
				mi_db_unpin( state->camera_inst );
			}
			

		}

		// // Eval and tokenize the Overrides
		{
			std::vector < std::string > tokens;
			std::string s;
			eval_string(state, paras->overrides, s);
			tokenize(s, tokens);

			for( std::vector<std::string>::const_iterator it = tokens.begin(); it != tokens.end(); ++it )
			{
				const std::string& key = *(it++);
				m_overrides[key] = new Param(*it);
			}
		}

		// Eval the patch string
		{
			std::string strPatches;
			eval_string( state, paras->patches, strPatches );

			std::vector < std::string > vecPacthes;
			XGenMR::split( vecPacthes, strPatches, " " );

			// Create the list of patch procedurals.
			for( std::vector<std::string>::const_iterator it = vecPacthes.begin(); it != vecPacthes.end(); ++it )
			{
				Procedural* patchProc = new Procedural();

				if( patchProc->initPatchProcedural( this, *it ) )
				{
					m_patches.push_back(patchProc);
				}
				else
				{
					delete patchProc;
					patchProc = NULL;
				}
			}
		}

		
	}
}

// create a single patch procedural
/////////////////////////////////////////////////////////////////////////////////
bool Procedural::initPatchProcedural( Procedural* pParent, const std::string& strPatch )
{
	m_bEcho = pParent->m_bEcho;
	m_data = pParent->m_data;
	m_user = pParent->m_user;
	m_overrides = pParent->m_overrides;
	m_approx_degree = pParent->m_approx_degree;
	m_approx_mode = pParent->m_approx_mode;
	m_approx_parametric_subdivisions = pParent->m_approx_parametric_subdivisions;
	m_approx_fine_sub_pixel_size = pParent->m_approx_fine_sub_pixel_size;
	m_motion_blur = pParent->m_motion_blur;
	m_motion_blur_mode = pParent->m_motion_blur_mode;
	m_motion_blur_steps = pParent->m_motion_blur_steps;
	m_motion_blur_factor = pParent->m_motion_blur_factor;
	m_motion_blur_multiplier = pParent->m_motion_blur_multiplier;
    m_max_displace = pParent->m_max_displace;
    m_sphere_subdiv_u = pParent->m_sphere_subdiv_u;
    m_sphere_subdiv_v = pParent->m_sphere_subdiv_v;
	m_patchName = strPatch;

	// Replace ${PATCH} in the data string by the input patch name.
	{
		const std::string k_strPatchVar = "${PATCH}";
		const size_t k_ulPatchVarLen = k_strPatchVar.size();
		string::size_type pos = m_data.find( k_strPatchVar );
		if ( pos != string::npos )
		{
			m_data = m_data.replace( pos, k_ulPatchVarLen, m_patchName );
		}
	}

	// This is where we link our callbacks to the PatchRenderer.
	return initPatchRenderer( m_data.c_str() );
}

// Exit MR
/////////////////////////////////////////////////////////////////////////////////
void Procedural::exit(miState* state, Params* paras)
{
	DEBUG_TRACE( "Procedural::exit()" );
}

// top level assembly exit
/////////////////////////////////////////////////////////////////////////////////
static miBoolean asm_delete(miTag, void * args)
{
	DEBUG_TRACEP( "asm_delete", args );
	XgAutoMutex autoMutex;
	Procedural* proc = (Procedural*) args;
	delete proc;
	return miTRUE;
}

// top level assembly exec, it calls the face renderer
/////////////////////////////////////////////////////////////////////////////////
static miTag asm_exec(const miState * state, void * args)
{
	DEBUG_TRACEP( "asm_exec", args );

	XgAutoMutex autoMutex;
	Procedural* proc = (Procedural*) args;

	miTag result = miNULLTAG;
	proc->render(&result, state);

	return result;
}
// placeholder object exit
/////////////////////////////////////////////////////////////////////////////////
static miBoolean placeholder_patch_exit(miTag tag, miObject *object, void * args)
{
    assert( object != NULL);
    if (object->userdata != miNULLTAG) {
        const string dataName = mi_api_tag_lookup(object->userdata);
        mi_api_delete( mi_mem_strdup(dataName.c_str()) );
    }
	return miTRUE;
}

// placeholder object delete
/////////////////////////////////////////////////////////////////////////////////
static miBoolean placeholder_patch_delete(miTag tag, void * args)
{
    XgAutoMutex autoMutex;
    Procedural* proc = (Procedural*) args;
    delete proc;
    return miTRUE;
}

// placeholder object exec, it calls the patch renderer which calls the face renderers
/////////////////////////////////////////////////////////////////////////////////
static miBoolean placeholder_patch_exec(miTag tag, miObject *object, void * args)
{
	XgAutoMutex autoMutex;
	Procedural* proc = (Procedural*) args;
    proc->setPlaceholderObjectTag(tag);

	miTag result = miNULLTAG;
	proc->render(&result, NULL); // state is not needed for hair.
	return result != miNULLTAG;
}


// sphere placeholder parameters
/////////////////////////////////////////////////////////////////////////////////
struct Sphere_placeholder_params 
{
    Sphere_placeholder_params(
        unsigned int subdiv_u,
        unsigned int subdiv_v)
        : subdivU(subdiv_u), subdivV(subdiv_v)
    {}

    unsigned int subdivU;
    unsigned int subdivV;
};

// sphere placeholder exec, creates a sphere tessellation
/////////////////////////////////////////////////////////////////////////////////
static miBoolean sphere_placeholder_exec(miTag tag, miObject *object, void * args)
{
    Sphere_placeholder_params* params = (Sphere_placeholder_params*) args;
    miTag result = createSphere(tag, params->subdivU, params->subdivV);
    return result != miNULLTAG;
}

// sphere placeholder delete: delete args pointer
/////////////////////////////////////////////////////////////////////////////////
static miBoolean sphere_placeholder_delete(miTag tag, void * args)
{
    Sphere_placeholder_params* params = (Sphere_placeholder_params*) args;
    delete params;
    return miTRUE;
}

namespace {
void initInstanceFlags(miInstance* inst, bool in_visible )
{
	if (in_visible)
	{
		inst->visible = miFALSE;
		inst->shadow = 	inst->reflection = inst->refraction =
						inst->transparency = inst->caustic = inst->globillum =
						inst->finalgather = 3;
	}
	else
	{
		inst->visible = miTRUE;
		inst->shadow = 	inst->reflection = inst->refraction =
						inst->transparency = inst->caustic = inst->globillum =
						inst->finalgather = 0;
	}

}


// List all the optional built in user data
void listInstanceUserData( PrimitiveCache* pc, UserDataList& out_ud, std::string& out_strFormat, std::vector<float>& out_scalars )
{
	out_ud.listUserData( pc, false );

	size_t optNumScalarsPerPoint = 0;
	size_t optNumScalarsPerPrim = 0;

	// Get the format string
	UserDataFormat fmt;
	fmt.setType( UserDataFormat::eInplace ); // User data appears after the format string directly in the user data.
	out_ud.registerUserData( optNumScalarsPerPrim, optNumScalarsPerPoint, fmt );
	fmt.buildMap();
	fmt.toString( out_strFormat );

	out_scalars.resize( optNumScalarsPerPrim );
}

miTag createUserData(bool in_bIsSpline, const std::string& in_dataName, const std::string& in_strFormat, const std::vector<float>* in_pScalars )
{
    miTag resultTag = miNULLTAG;
	// Add XGMR hair format in user data.
	if( in_strFormat.size()>0)
	{
		int sizeString = (int)in_strFormat.size()+1; // size of string + 1 for '/0'
		int sizeScalars = 0; // size of inplace float buffer
		int sizeTotal = sizeString; // total size
		if( !in_bIsSpline )
		{
			// Add XGMR user data format in user data.
			// The user data contains a string + floating point scalars.
			if( in_pScalars && in_pScalars->size()>0  )
			{
				sizeScalars = (int)(in_pScalars->size()*sizeof(float));
				sizeTotal += sizeScalars;
			}
		}

		if( sizeTotal >0 )
		{
			miUserdata* ud = mi_api_data_begin( mi_mem_strdup(in_dataName.c_str()), 0/*mode0*/, (void*)sizeTotal );
			if( ud )
			{
				miUchar* buf = (miUchar*)mi_mem_allocate( sizeTotal );

				memcpy( buf, in_strFormat.c_str(), sizeString );
				buf[sizeString-1] = '\0';

				if( sizeScalars>0 )
				{
					memcpy( buf+sizeString, &(*in_pScalars)[0], sizeScalars );
				}

				mi_api_data_byte_copy( sizeTotal, buf ); // it performs the deallocation
				resultTag = mi_api_data_end();
			}
		}
	}
    return resultTag;
}

void initInstanceUserData(miInstance* io_pInst, bool in_bIsSpline, const std::string& in_dataName, const std::string& in_strFormat, const std::vector<float>* in_pScalars )
{
	// Add XGMR hair format in user data.
	if( io_pInst!=NULL )
		io_pInst->userdata =  createUserData(in_bIsSpline, in_dataName, in_strFormat, in_pScalars);
}

// Create a sphere placeholder object (fixed subdivision 20*20), instantiate it and attach to an instance group.
// Return the tag of the instance group.
miTag createSphereInstanceGroup(const string& name, const miScalar maxDisplace, 
                                const unsigned int subdivU, const unsigned int subdivV) {

    const size_t bufSize = 1024;
    char strSphereObject[bufSize];
    char strSphereInstance[bufSize];
    char strSphereGroup[bufSize];
    snprintf(strSphereObject, bufSize, "xgen_%s_sphere[o]", name.c_str() );
    snprintf(strSphereInstance, bufSize, "xgen_%s_sphere[i]", name.c_str() );
    snprintf(strSphereGroup, bufSize, "xgen_%s_sphere[g]", name.c_str() );

    miObject* object = mi_api_object_begin( mi_mem_strdup(strSphereObject));

    object->bbox_min.x = object->bbox_min.y = object->bbox_min.z = (float) -1;
    object->bbox_max.x = object->bbox_max.y = object->bbox_max.z = (float) 1;
    object->maxdisplace = maxDisplace;
    initObjectFlags(object);
    Sphere_placeholder_params* params = new Sphere_placeholder_params(subdivU, subdivV);
    mi_api_object_placeholder_callback_x( sphere_placeholder_exec, NULL, sphere_placeholder_delete, (void*) params);
    miTag sphereTag = mi_api_object_end();

    miInstance* inst = mi_api_instance_begin( mi_mem_strdup(strSphereInstance) );
    mi_matrix_ident(inst->tf.local_to_global);
    inst->tf.local_to_global[0] = inst->tf.local_to_global[5] =
        inst->tf.local_to_global[10] = 0.5f;
    inst->tf.local_to_global[13] = 0.5f;
    mi_matrix_invert(inst->tf.global_to_local,
        inst->tf.local_to_global);
    miTag sphere_inst = mi_api_instance_end(mi_mem_strdup(strSphereObject), miNULLTAG,
        miNULLTAG);

    mi_api_instgroup_begin(mi_mem_strdup(strSphereGroup));
    mi_api_instgroup_additem(mi_mem_strdup(strSphereInstance));
    return mi_api_instgroup_end();
}

}

// Execute entry point
/////////////////////////////////////////////////////////////////////////////////
miBoolean Procedural::execute(miTag* result, miState* state, Params* paras)
{
	DEBUG_TRACE( "Procedural::execute" );

	const int patchID = m_patches.size()>0 ? s_iProceduralID++ : s_iProceduralID;
	const size_t bufSize = 1024;

	// Patch list execute
	if( m_patches.size()>0 )
	{
        // clear the cached archive when start to render new xgen_geo ( new description)
        s_archives.clear();
		for( TProcList::iterator it = m_patches.begin(); it != m_patches.end(); ++it )
		{
			(*it)->execute( result, state, paras );
		}
	}

	// Patch execute
	else if( m_patch != NULL && m_face == NULL )
	{
		miTag sphere_group = miNULLTAG;

		// Create a dummy instance group. We'll return it when a face doesn't
		miTag dummy_group = miNULLTAG;
		{
			char strDummyGroup[bufSize];
			snprintf(strDummyGroup, bufSize, "xgen_%s_dummy[g]", m_patchName.c_str() );
			mi_api_instgroup_begin(mi_mem_strdup(strDummyGroup));
			dummy_group = mi_api_instgroup_end();
		}
		 

		// Keep a map of archives
		m_archives = &s_archives; //new std::map<std::string,std::string>();
		bool bSyncArchives = m_bPerFaceAssemblies && m_primType == std::string("ArchivePrimitive");

        std::string strAssemblyBase = "xgen_" + m_patchName +  "_" + m_primType + "_" + itoa( patchID );
        std::string strAssemblyNoFace = strAssemblyBase + "[a]";

        // For sphere primitives, create one assembly that instantiates the spheres. The sphere is defined as placeholder object inside the assembly.
        if (m_primType == std::string("SpherePrimitive")) {

            bbox b;
            bool success = m_patch->boundingBox(b);
            if (success) {
                // Clone this procedural. It needs to be called again by the assembly-callback.
                Procedural* pProc = new Procedural(*this);
                pProc->m_parentName = strAssemblyBase;
                pProc->m_patch = PatchRenderer::init((ProceduralCallbacks*) pProc, m_data.c_str());

                if (!m_bEcho) {
                    // Create an assembly for the patch. Add max-displace to the assembly bounding box.
                    // TODO: this should take scaling into account. Query the maximum scaling and multiply max_displace.
                    miAssembly* assem = mi_api_assembly_begin( mi_mem_strdup(strAssemblyNoFace.c_str()) );
                    assem->bbox_min.x = assem->bbox_min_m.x = (float) b.xmin - m_max_displace;
                    assem->bbox_max.x = assem->bbox_max_m.x = (float) b.xmax + m_max_displace;
                    assem->bbox_min.y = assem->bbox_min_m.y = (float) b.ymin - m_max_displace;
                    assem->bbox_max.y = assem->bbox_max_m.y = (float) b.ymax + m_max_displace;
                    assem->bbox_min.z = assem->bbox_min_m.z = (float) b.zmin - m_max_displace;
                    assem->bbox_max.z = assem->bbox_max_m.z = (float) b.zmax + m_max_displace;
                    mi_api_assembly_callback_x( asm_exec, NULL, asm_delete, (void*) pProc );
                    /*miTag assemTag =*/mi_api_assembly_end();

                    // Create an instance to instantiate the assembly
                    std::string strInstance = strAssemblyBase + "[i]";
                    miInstance* inst = mi_api_instance_begin( mi_mem_strdup(strInstance.c_str()) );
                    mi_matrix_ident( inst->tf.local_to_global );
                    mi_matrix_invert( inst->tf.global_to_local, inst->tf.local_to_global );

                    miTag instTag = mi_api_instance_end( mi_mem_strdup(strAssemblyNoFace.c_str()), miNULLTAG, miNULLTAG );
                    mi_geoshader_add_result( result, instTag );
                } else {
					// For echo, we execute the assembly callback in-place.
                    miTag asmTag = asm_exec(state, (void*) pProc);
                    if( asmTag != dummy_group )
                        mi_geoshader_add_result(result, asmTag);
                    m_tagsHiddenGroup = pProc->m_tagsHiddenGroup;
                    asm_delete(asmTag, (void*) pProc);
                }
            }
        }
        // For spline, create hair objects for this patch by assembling enough faces to have a decent sized object.
        else if (m_primType == std::string("SplinePrimitive")) {

            // Starting with version 2, the splitting into hairObject is configurable with a shader parameter allowing
            // to multiply the maximum number of control points per hair object by this number.
            int maxPointsPerHairObject = k_maxPointsPerHairObject;
            int version = 1;
            if (mi_query(miQ_DECL_VERSION, state, 0, &version))
                if (version > 1) {
                    miScalar sizeMultplier = *mi_eval_scalar(&paras->m_hair_object_size);
                    maxPointsPerHairObject *= sizeMultplier;
                }

            // Loop over all faces and collect the number of points/prims and the bounding box. 
            // This should be replaced by calls to xgen.
            unsigned int objectIndex = 0;
            unsigned int f = (unsigned int)-1;
            bbox b;
            bbox patch_bbox;
            CountHairDataProcedural countProc(*this);

            bool toContinue = true;
            while (toContinue)
            {
                unsigned int firstIndex = f;
                setEmptyBbox(patch_bbox);
                countProc.reset();
                while (toContinue && countProc.getNumPoints() < maxPointsPerHairObject) {

                    toContinue = nextFace(b,f);
                    if (isEmpty(b) || !toContinue)
                        continue;
                    CountHairDataProcedural::initFaceRenderer(&countProc, m_patch, f);
                    countProc.render(); 
                    addBbox(patch_bbox, b);
                }
                // Init a procedural to render these faces
                if (countProc.getNumPoints() > 0) {

                    // Create a placeholder object for the hair primitives
                    std::string strAssemblyBaseObject = strAssemblyBase + itoa( objectIndex );
                    objectIndex++;
                    miObject* object = mi_api_object_begin( mi_mem_strdup(strAssemblyBaseObject.c_str()) );
                    object->bbox_min.x = object->bbox_min_m.x = (float) patch_bbox.xmin;
                    object->bbox_max.x = object->bbox_max_m.x = (float) patch_bbox.xmax;
                    object->bbox_min.y = object->bbox_min_m.y = (float) patch_bbox.ymin;
                    object->bbox_max.y = object->bbox_max_m.y = (float) patch_bbox.ymax;
                    object->bbox_min.z = object->bbox_min_m.z = (float) patch_bbox.zmin;
                    object->bbox_max.z = object->bbox_max_m.z = (float) patch_bbox.zmax;
                    computeMotionBox(object, m_patch);
                    initObjectFlags(object);
                    // Clone this procedural. It needs to be called again by the placeholder-callback.
                    Procedural* newProc = new Procedural(*this);
                    newProc->m_parentName = strAssemblyBaseObject;
                    newProc->m_patch = PatchRenderer::init((ProceduralCallbacks*) newProc, m_data.c_str());
                    newProc->m_numHairPoints = countProc.getNumPoints();
                    newProc->m_numHairPrims = countProc.getNumPrims();
                    newProc->m_faceBegin = firstIndex;
                    newProc->m_faceEnd = f;

                    mi_api_object_placeholder_callback_x( 
                        placeholder_patch_exec, placeholder_patch_exit, placeholder_patch_delete, (void*) newProc);
                    miTag objTag = mi_api_object_end();

                    // Special handling needed for hair object
                    object = (miObject *)mi_scene_edit(objTag);
                    object->geo.placeholder_list.type = miOBJECT_HAIR;
                    mi_scene_edit_end(objTag);

                    // Create an instance to instantiate the placeholder
                    std::string strInstance = strAssemblyBaseObject + "[i]";
                    miInstance* inst = mi_api_instance_begin( mi_mem_strdup(strInstance.c_str()) );
                    mi_matrix_ident( inst->tf.local_to_global );
                    mi_matrix_invert( inst->tf.global_to_local, inst->tf.local_to_global );

                    miTag instTag = mi_api_instance_end( mi_mem_strdup(strAssemblyBaseObject.c_str()), miNULLTAG, miNULLTAG );
                    mi_geoshader_add_result( result, instTag );
                }
            }
        } 
        // Treat other primitive types by creating an assembly per face.
        else {

		    bbox b;
		    unsigned int f = (unsigned int)-1;
		    while (nextFace(b, f))
		    {
			    // Skip camera culled bounding boxes.
			    if (isEmpty(b))
				    continue;

			    std::string strFaceID = std::string("_face") + itoa( f );
			    std::string strAssembly = strAssemblyBase + strFaceID + "[a]";

			    // Sync the archive inplace before creating the assemblies
			    if (bSyncArchives)
			    {
				    Procedural* pSyncProc = new Procedural();
				    pSyncProc->m_dummy = dummy_group;
				    pSyncProc->m_parentName = k_strArchivesPrefix;
				    pSyncProc->m_parentNameNoFace = k_strArchivesPrefix;
				    pSyncProc->m_archives = m_archives;
				    pSyncProc->m_bSyncArchives = true;
				    pSyncProc->m_bPerFaceAssemblies = m_bPerFaceAssemblies;
				    pSyncProc->m_tagsHiddenGroup = m_tagsHiddenGroup;
				    initFaceRenderer(pSyncProc, f);

				    miTag syncResult = miNULLTAG;
				    pSyncProc->render(&syncResult, state);

				    m_tagsHiddenGroup = pSyncProc->m_tagsHiddenGroup;
				    delete pSyncProc;
			    }

				// Create a new per face procedural and sync its data with the parent one.
			    Procedural* pProc = new Procedural();
			    pProc->m_dummy = dummy_group;
			    pProc->m_parentName = strAssembly;
			    pProc->m_parentNameNoFace = k_strArchivesPrefix;
			    pProc->m_archives = m_archives;
			    pProc->m_bPerFaceAssemblies = m_bPerFaceAssemblies;
			    pProc->m_tagsHiddenGroup = m_tagsHiddenGroup;
				pProc->m_approx_degree = m_approx_degree;
				pProc->m_approx_mode = m_approx_mode;
				pProc->m_approx_parametric_subdivisions = m_approx_parametric_subdivisions;
				pProc->m_approx_fine_sub_pixel_size = m_approx_fine_sub_pixel_size;
                pProc->m_max_displace = m_max_displace;
                pProc->m_sphere_subdiv_u = m_sphere_subdiv_u;
                pProc->m_sphere_subdiv_v = m_sphere_subdiv_v;
				pProc->m_user = m_user;
				pProc->m_overrides = m_overrides;
			    initFaceRenderer(pProc, f);

			    // We can use per face assemblies for spheres and nurbs.
			    if (m_bPerFaceAssemblies)
			    {
					// Create an assembly for the face Add max-displace to the assembly bounding box.
					// TODO: this should take scaling into account. Query the maximum scaling and multiply max_displace.
				    miAssembly* assem = mi_api_assembly_begin( mi_mem_strdup(strAssembly.c_str()) );
				    assem->bbox_min.x = assem->bbox_min_m.x = (float) b.xmin - m_max_displace;
				    assem->bbox_max.x = assem->bbox_max_m.x = (float) b.xmax + m_max_displace;
				    assem->bbox_min.y = assem->bbox_min_m.y = (float) b.ymin - m_max_displace;
				    assem->bbox_max.y = assem->bbox_max_m.y = (float) b.ymax + m_max_displace;
				    assem->bbox_min.z = assem->bbox_min_m.z = (float) b.zmin - m_max_displace;
				    assem->bbox_max.z = assem->bbox_max_m.z = (float) b.zmax + m_max_displace;
				    mi_api_assembly_callback_x( asm_exec, NULL, asm_delete, (void*) pProc );
				    /*miTag assemTag =*/mi_api_assembly_end();

				    // Create an instance to instantiate the assembly
				    std::string strInstance = strAssemblyBase + strFaceID + "[i]";
				    miInstance* inst = mi_api_instance_begin( mi_mem_strdup(strInstance.c_str()) );
				    mi_matrix_ident( inst->tf.local_to_global );
				    mi_matrix_invert( inst->tf.global_to_local, inst->tf.local_to_global );

				    miTag instTag = mi_api_instance_end( mi_mem_strdup(strAssembly.c_str()), miNULLTAG, miNULLTAG );
				    mi_geoshader_add_result( result, instTag );

                }
			    // For archives, the archive itself is an assembly and mentalray doesn't support nested assemblies.
			    // In that case, we just call the asm_exec callback directly.
                // For echo, we also call the asm_exec callback directly to get the assembly content.
			    else
			    {
				    miTag asmTag = asm_exec(state, (void*) pProc);
				    if( asmTag != dummy_group )
					    mi_geoshader_add_result(result, asmTag);
				    m_tagsHiddenGroup = pProc->m_tagsHiddenGroup;
				    asm_delete(asmTag, (void*) pProc);
			    }
            }
        }

		if( result == NULL )
			mi_geoshader_add_result(result, dummy_group);

	}

	return miTRUE;
}

/**
 * Exports the whole geoshader content to disk.
 */
void Procedural::echo( miTag* result, miState* state, Params* paras )
{
	DEBUG_TRACE( "Procedural::echo" );
	if( !paras->echo || result==NULL )
		return;
	
	// resolve filename
	std::string strFilenameUnresolved;
	std::string strFilename;
	{
		eval_string( state, paras->echo_filename, strFilenameUnresolved );
	
		strFilename = strFilenameUnresolved;
		xgutil::fileCleanup(strFilename);
	}
	
	// Fill echo struct
	miEchoOptions opts;
	{
		memset( (void*)&opts, sizeof(miEchoOptions), 0 );
		opts.ascii_output =  paras->echo_ascii;
		opts.verbatim_textures =  paras->echo_verbatim_textures; 
		opts.explode_objects =  (miUint)paras->echo_explode_objects; 
		opts.dont_echo =  (miUint)paras->echo_dont;
		opts.dont_recurse =  (miUint)paras->echo_dont_recurse;
	}
	miBoolean ret = mi_geoshader_echo_tag_file( strFilename.c_str(), false, NULL, *result, &opts );
	if( !ret )
	{
		std::string msg = "mi_geoshader_echo_tag_file of xgen_geo returned failure. " + strFilenameUnresolved + " -> " + strFilename;
		mi_warning( mi_mem_strdup( msg.c_str() ) );
		return;
	}

}

// Primitive cache get macro.
// To avoid writing PrimitiveCache:: for every get.
/////////////////////////////////////////////////////////////////////////////////
#define PC( x ) ( XGenRenderAPI::PrimitiveCache:: x )

/**
 * Emit the mental ray objects for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void Procedural::flush(const char* geomName, PrimitiveCache* pc)
{
	DEBUG_TRACE( "Procedural::flush" );

	if (m_bSyncArchives)
	{
		syncArchives(geomName, pc);
	}
	else
	{
		bool bIsSpline = pc->get(PC(PrimIsSpline));
		const char* strPrimType = pc->get(PC(PrimitiveType));
        assert( !bIsSpline);
        assert( strcmp(strPrimType, "SpherePrimitive")); 
		if (strcmp(strPrimType, "CardPrimitive") == 0)
			flushCards(geomName, pc);
		else if (strcmp(strPrimType, "ArchivePrimitive") == 0)
			flushArchives(geomName, pc);
	}
}

// Call mi_api_hair_info with counters
/////////////////////////////////////////////////////////////////////////////////
miBoolean hair_info( int perPoint, char t, size_t num, unsigned int& numScalarsPerPrim, unsigned int& numScalarsPerPoint )
{
	miBoolean ret = mi_api_hair_info(perPoint, t, (int)num);
	if (ret == miTRUE)
	{
		if (perPoint == 0)
			numScalarsPerPrim += (unsigned int) num;
		else
			numScalarsPerPoint += (unsigned int) num;
	}
	return ret;
}
#define _mi_api_hair_info(a,b,c) hair_info(a,b,c,numScalarsPerPrim,numScalarsPerPoint)

// Convert a Bspline to a Bezier curve
/////////////////////////////////////////////////////////////////////////////////
void convertBsplineToBezier(float* out_cp, const float* in_cp, const int* in_interpolate, size_t in_count, size_t in_components, float in_motion_mult  )
{
	size_t k = 0;
	for (size_t i = 0; i < in_count - 3; i+=3, k += 3*in_components)
	{
		const float* p1 = in_cp + k;
		const float* p2 = p1 + in_components;
		const float* p3 = p2 + in_components;
		const float* p4 = p3 + in_components;

		float* o1 = out_cp + k;
		float* o2 = o1 + in_components;
		float* o3 = o2 + in_components;
		float* o4 = o3 + in_components;

		for (size_t c = 0; c < in_components; ++c)
		{
			if (in_interpolate[c]) {
				o1[c] = p1[c];
				o2[c] = (2*p4[c]-9*p3[c]+18*p2[c]-5*p1[c]) / 6.f;
				o3[c] = (5*p4[c]-18*p3[c]+9*p2[c]-2*p1[c]) / -6.f;
				o4[c] = p4[c];
			} else {
				o1[c] = p1[c];
				o2[c] = p2[c];
				o3[c] = p3[c];
				o4[c] = p4[c];
			}
		}
		// Second reverse order pass to compute motion vectors
		for (size_t ci = 0; ci < in_components; ++ci)
		{
			size_t c = in_components-1-ci;
			int interpolateC = in_interpolate[c];

			// First Motion vector computation
			if( interpolateC>=k_iInterpolateFirstMotionVectorX && interpolateC<=k_iInterpolateFirstMotionVectorZ )
			{
				const size_t xyz = interpolateC-k_iInterpolateFirstMotionVectorX;
				o1[c] = (o1[c] - o1[xyz]) * in_motion_mult;
				o2[c] = (o2[c] - o2[xyz]) * in_motion_mult;
				o3[c] = (o3[c] - o3[xyz]) * in_motion_mult;
				o4[c] = (o4[c] - o4[xyz]) * in_motion_mult;
			}
			// Other Motion vector computation
			else if( interpolateC>=k_iInterpolateOtherMotionVectorX && interpolateC<=k_iInterpolateOtherMotionVectorZ )
			{
				const size_t xyz = c - 3; // Just go back 3 components
				o1[c] = (o1[c] - o1[xyz]) * in_motion_mult;
				o2[c] = (o2[c] - o2[xyz]) * in_motion_mult;
				o3[c] = (o3[c] - o3[xyz]) * in_motion_mult;
				o4[c] = (o4[c] - o4[xyz]) * in_motion_mult;
			}
			
		}
		
	}

}

//#define assertbr if( br==0 ) { printf("assert failed at line %d\n", __LINE__ ); }
#define assertbr assert( br!=0 )

/**
 * Emit the nurbs for the cached primitives. This might be called
 * as primitives are emitted to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void Procedural::flushCards(const char *geomName, PrimitiveCache* pc)
{
	miBoolean br = miTRUE;

	unsigned int cacheCount = pc->get(PC(CacheCount));
	unsigned int numSamples = pc->get(PC(NumMotionSamples));

	// List all the optional built in user data
	std::vector<float> scalars;
	std::string strFormat;
	UserDataList ud;
	listInstanceUserData( pc, ud, strFormat, scalars );

	for (unsigned int j = 0; j < cacheCount; j++)
	{
		// Add per instance user data
		{
			size_t k = 0;
			ud.pushUserData( j, &scalars[0], k, k_iPerPrim );
		}

		// Build names
		string strID = itoa((int) m_tags.size());
		string objName = m_parentName + string("_card[o][") + strID + string("]");
		string surfName = m_parentName + string("_card[s][") + strID + string("]");
		string instName = m_parentName + string("_card[i][") + strID + string("]");
		string dataName = m_parentName + string("_card[d][") + strID + string("]");

		// Start by defining the miObject
		miObject* pObject = mi_api_object_begin(
				mi_mem_strdup( objName.c_str() ));
		initObjectFlags(pObject);
		pObject->maxdisplace = m_max_displace;

		// Add 2 basis
		br = mi_api_basis_add(mi_mem_strdup("BSpline1"), miTRUE,
				miBASIS_BSPLINE, (miUshort) 1, 0, NULL);
		assertbr;
		br = mi_api_basis_add(mi_mem_strdup("BSpline3"), miTRUE,
				miBASIS_BSPLINE, (miUshort) 3, 0, NULL);
		assertbr;

		// Start object group
		br = mi_api_object_group_begin(0.0);
		assertbr;

		// Add the points.
		XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/"Adding points.");

		// Push vertex data and indices
		{

			miVector* pointPtr = (miVector *) (void*) (&(pc->get(PC(Points), 0)[j * 16]));
			for (unsigned int v = 0; v < 16; v++)
			{
				br = mi_api_vector_xyz_add(&pointPtr[v]);
				assertbr;
			}

			miVector textureVectors[4] = { { 1.0, 0.0, 0.0 }, { 0.0, 0.0, 0.0 }, { 1.0, 1.0, 0.0 }, { 0.0, 1.0, 0.0 } };

			for (unsigned int v = 0; v < 4; v++)
				mi_api_vector_xyz_add(&textureVectors[v]);

			for( unsigned int m=1; m<numSamples; ++m )
			{
				miVector* prevPtr = pointPtr;//(miVector *) (void*) (&(pc->get(PC(Points), m-1)[j * 16]));
				miVector* samplePtr = (miVector *) (void*) (&(pc->get(PC(Points), m)[j * 16]));
				for (unsigned int v = 0; v < 16; v++)
				{
					miVector motion;
					motion.x = (samplePtr[v].x - prevPtr[v].x) * m_motion_blur_multiplier;
					motion.y = (samplePtr[v].y - prevPtr[v].y) * m_motion_blur_multiplier;
					motion.z = (samplePtr[v].z - prevPtr[v].z) * m_motion_blur_multiplier;
					br = mi_api_vector_xyz_add(&motion);
					assertbr;
				}
			}

			for (unsigned int vid = 0; vid < 20; vid++) {
				
				br = mi_api_vertex_add(vid);
				assertbr;

				if( vid<16 )
				{
					for( unsigned int m=0; m<numSamples-1; ++m )
					{
						mi_api_vertex_motion_add( 20 + m*16 + vid );
					}
				}
			}

		}

		// Start the surface
		br = mi_api_surface_begin_tag(mi_mem_strdup(surfName.c_str()), m_state->material);
		assertbr;
		miDlist* ulist = mi_api_dlist_create(miDLIST_GEOSCALAR);
		miDlist* vlist = mi_api_dlist_create(miDLIST_GEOSCALAR);
		miGeoScalar uvlist[8] = { 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0 };
		for (size_t k = 0; k < 8; ++k)
		{
			br = mi_api_dlist_add(ulist, (void*) &(uvlist[k]));
			assertbr;
			br = mi_api_dlist_add(vlist, (void*) &(uvlist[k]));
			assertbr;
		}

		br = mi_api_surface_params(miU, mi_mem_strdup("BSpline3"), 0, 1, ulist, miTRUE);
		assertbr;
		br = mi_api_surface_params(miV, mi_mem_strdup("BSpline3"), 0, 1, vlist, miTRUE);
		assertbr;

		for (int k = 0; k < 16; ++k)
		{
			br = mi_api_vertex_ref_add(k, 1.0);
			assertbr;
		}

		// Add texture coords
		miDlist* tulist = mi_api_dlist_create(miDLIST_GEOSCALAR);
		miDlist* tvlist = mi_api_dlist_create(miDLIST_GEOSCALAR);
		miGeoScalar tuvlist[4] = { 0.0, 0.0, 1.0, 1.0 };
		for (size_t k = 0; k < 4; ++k)
		{
			br = mi_api_dlist_add(tulist, (void*) &(tuvlist[k]));
			assertbr;
			br = mi_api_dlist_add(tvlist, (void*) &(tuvlist[k]));
			assertbr;
		}

		br = mi_api_surface_texture_begin(miTRUE, miFALSE,
				mi_mem_strdup("BSpline1"), tulist, miFALSE,
				mi_mem_strdup("BSpline1"), tvlist, miFALSE);
		assertbr;

		for (int k = 16; k < 20; ++k)
		{
			br = mi_api_vertex_ref_add(k, 1.0);
			assertbr;
		}

		br = mi_api_surface_end();
		assertbr;

		// Set surface approximation
		{
			miApprox approx;
			

			if( m_approx_mode == 1 )
			{
				miInteger subdi = 1 << m_approx_parametric_subdivisions;
				miAPPROX_DEFAULT(approx);
				approx.cnst[0] = approx.cnst[1] = ((miScalar)subdi) / ((miScalar)3.f);
				approx.subdiv[0] = m_approx_parametric_subdivisions;
				approx.subdiv[1] = m_approx_parametric_subdivisions;
			}
			else if( m_approx_mode == 2 )
			{
				miAPPROX_FINE_DEFAULT(approx);
				approx.cnst[0] = m_approx_fine_sub_pixel_size;
			}
			else
			{
				miAPPROX_NONE(approx);
			}


			
			br = mi_api_surface_approx(mi_mem_strdup(surfName.c_str()),
					&approx);
			assertbr;
		}

		// Add custom renderer parameters.
		//pushCustomParams( nodeCard, pc );

		br = mi_api_object_group_end();
		assertbr;
        miTag tagObj = mi_api_object_end();

		// Add an instance of the surface object to make it visible
		miInstance* inst = mi_api_instance_begin( mi_mem_strdup(instName.c_str()) );
		initInstanceUserData( inst, /*isSpline=*/false, dataName, strFormat, &scalars );
		mi_matrix_ident(inst->tf.local_to_global);
		mi_matrix_invert(inst->tf.global_to_local, inst->tf.local_to_global);
		miTag tagInst = mi_api_instance_end(NULL, tagObj, miNULLTAG);
		mi_geoshader_add_result(&m_result, tagInst);

		m_tags.push_back(tagInst);
	}

}

template< class T, class E, int N >
TUserData< T, E, N >::TUserData( PrimitiveCache* pc, PrimitiveCache::EBoolAttribute bAdd, E eArray, int context, const char* name )
{
	m_name = name;
	m_context = context;
	m_add = pc->get( bAdd );
	if(m_add)
	{
		m_p = pc->get( eArray );
		m_add = m_p != NULL;
	}
}

template< class T, class E, int N >
TUserData< T, E, N >::TUserData( const T* p, int context, const char* name )
{
	m_name = name;
	m_context = context;
	m_p = p;
	m_add = m_p != NULL;
}

template< class T, class E, int N >
T TUserData< T, E, N >::get(size_t j) const
{
	return m_p[j];
}

template< class T, class E, int N >
void TUserData< T, E, N >::registerUserData( size_t& io_perPrim, size_t& io_perPoint, XGenMR::UserDataFormat& fmt, size_t& k, int* interpolateComponent )
{
	if(m_add)
	{
		if( m_context == 0 )
			io_perPrim+=N;
		else
			io_perPoint+=N;

		fmt.registerUserData( m_name, N, m_context );

		for( int i=0; i<N; ++i )
			interpolateComponent[k++] = 0;
	}
}

template< class T, class E, int N >
void TUserData< T, E, N >::registerUserData( size_t& io_perPrim, size_t& io_perPoint, XGenMR::UserDataFormat& fmt )
{
	if(m_add)
	{
		if( m_context == 0 )
			io_perPrim+=N;
		else
			io_perPoint+=N;

		fmt.registerUserData( m_name, N, m_context );
	}
}

template< class T, class E, int N >
void TUserData< T, E, N >::copy( size_t j, float* cur, size_t& k, int context )
{
	if( isValid(context) )
		cur[k++] = (float)get(j);
}

template< class T, class E, int N >
bool TUserData< T, E, N >::isValid( int context )
{
	return m_add && m_context==context;
}

template<>
void TVec3UserData::copy( size_t j, float* cur, size_t& k, int context )
{
	if( m_add && m_context==context )
	{
		vec3 v = get(j);
		cur[k++] = v.x;
		cur[k++] = v.y;
		cur[k++] = v.z;
	}
}

// Iterate over all the user data vectors
void UserDataList::pushUserData( size_t j, float* cur, size_t& k, int context )
{
	for( TIntUserDataList::iterator it=vecInt.begin(); it!=vecInt.end(); ++it )
		it->copy( j, cur, k, context );

	for( TFloatUserDataList::iterator it=vecFloat.begin(); it!=vecFloat.end(); ++it )
		it->copy( j, cur, k, context );

	for( TVec3UserDataList::iterator it=vecVec3.begin(); it!=vecVec3.end(); ++it )
		it->copy( j, cur, k, context );
}

// List all the optional built in user data
void UserDataList::listUserData( PrimitiveCache* pc, bool isSpline )
{
	#define FLOAT_USER_DATA(a,b,c,d) vecFloat.push_back( TFloatUserData(pc,PC(a),PC(b),c,d) )
	#define INT_USER_DATA(a,b,c,d) vecInt.push_back( TIntUserData(pc,PC(a),PC(b),c,d) )
	#define VEC3_USER_DATA(a,b,c,d) vecVec3.push_back( TVec3UserData(pc,PC(a),PC(b),c,d) )

	FLOAT_USER_DATA( Add_Width, Width_XP, k_iPerPrim, "width" );

	if( isSpline )
		FLOAT_USER_DATA( Add_Width, Widths, k_iPerPoint, "widths" );

	FLOAT_USER_DATA( Add_U,U_XS, k_iPerPrim, "U" );
	FLOAT_USER_DATA( Add_V,V_XS, k_iPerPrim, "V" );
	FLOAT_USER_DATA( Add_Length, Length_XP, k_iPerPrim, "length" );
	FLOAT_USER_DATA( Add_RandomFloat, RandomFloat_XP, k_iPerPrim, "randomfloat" );

	INT_USER_DATA( Add_FaceID, FaceID_XS, k_iPerPrim, "faceid" );
	INT_USER_DATA( Add_DescID, DescID_XP, k_iPerPrim, "descid" );
	INT_USER_DATA( Add_GeomID, GeomID_XS, k_iPerPrim, "geomid" );
	INT_USER_DATA( Add_Stray, Stray_XP, k_iPerPrim, "stray" );
	INT_USER_DATA( Add_PrimitiveID, PrimitiveID_XP, k_iPerPrim, "primid" );
	INT_USER_DATA( Add_RandomInt, RandomInt_XP, k_iPerPrim, "randomint" );

	VEC3_USER_DATA( Add_dPdu, dPdu_XS, k_iPerPrim, "dPdu" );
	VEC3_USER_DATA( Add_dPdug, dPdug_XS, k_iPerPrim, "dPdug" );
	VEC3_USER_DATA( Add_dPduref, dPduref_XS, k_iPerPrim, "dPduref" );
	VEC3_USER_DATA( Add_dPdurefg, dPdurefg_XS, k_iPerPrim, "dPdurefg" );
	VEC3_USER_DATA( Add_dPdv, dPdv_XS, k_iPerPrim, "dPdv" );
	VEC3_USER_DATA( Add_dPdvg, dPdvg_XS, k_iPerPrim, "dPdvg" );
	VEC3_USER_DATA( Add_dPdvref, dPdvref_XS, k_iPerPrim, "dPdvref" );
	VEC3_USER_DATA( Add_dPdvrefg, dPdvrefg_XS, k_iPerPrim, "dPdvrefg" );
	VEC3_USER_DATA( Add_N, N_XS, k_iPerPrim, "N" );
	VEC3_USER_DATA( Add_Ng, Ng_XS, k_iPerPrim, "Ng" );
	VEC3_USER_DATA( Add_Nref, Nref_XS, k_iPerPrim, "Nref" );
	VEC3_USER_DATA( Add_Nrefg, Nrefg_XS, k_iPerPrim, "Nrefg" );
	VEC3_USER_DATA( Add_P, P_XS, k_iPerPrim, "P" );
	VEC3_USER_DATA( Add_Pg, Pg_XS, k_iPerPrim, "Pg" );
	VEC3_USER_DATA( Add_Pref, Pref_XS, k_iPerPrim, "Pref" );
	VEC3_USER_DATA( Add_Prefg, Prefg_XS, k_iPerPrim, "Prefg" );
	VEC3_USER_DATA( Add_T, T_XP, k_iPerPrim, "T" );

	#undef FLOAT_USER_DATA
	#undef INT_USER_DATA
	#undef VEC3_USER_DATA

	unsigned int customAttrCount = pc->getSize( PC( CustomAttrNames ) );
	// Push any user-defined custom attributes.
	for ( unsigned int j = 0; j<customAttrCount; j++ )
	{
		string attrName = pc->get( PC( CustomAttrNames ), j );
		const float* attrValue = pc->get( PC( CustomAttrValues ), j );

		std::vector<std::string> tokens;
		split( tokens, attrName, " " );

		if( tokens.size() == 3 )
		{
			if( tokens[1] == "float" )
			{
				vecFloat.push_back( TFloatUserData(attrValue,k_iPerPrim,tokens[2].c_str()) );
			}
			else if( tokens[1] == "vector" || tokens[1] == "color" || tokens[1] == "point" || tokens[1] == "normal" )
			{
				vecVec3.push_back( TVec3UserData((const vec3*)attrValue,k_iPerPrim,tokens[2].c_str()) );
			}

		}
	}
}

// Register Hair Optional User Data
void UserDataList::registerUserData( size_t& io_perPrim, size_t& io_perPoint, XGenMR::UserDataFormat& fmt, size_t& k, int* interpolateComponent )
{
	for( TIntUserDataList::iterator it=vecInt.begin(); it!=vecInt.end(); ++it )
		it->registerUserData( io_perPrim, io_perPoint, fmt, k, interpolateComponent );

	for( TFloatUserDataList::iterator it=vecFloat.begin(); it!=vecFloat.end(); ++it )
		it->registerUserData( io_perPrim, io_perPoint, fmt, k, interpolateComponent );

	for( TVec3UserDataList::iterator it=vecVec3.begin(); it!=vecVec3.end(); ++it )
		it->registerUserData( io_perPrim, io_perPoint, fmt, k, interpolateComponent );
}

// Register Hair Optional User Data
void UserDataList::registerUserData( size_t& io_perPrim, size_t& io_perPoint, XGenMR::UserDataFormat& fmt )
{
	for( TIntUserDataList::iterator it=vecInt.begin(); it!=vecInt.end(); ++it )
		it->registerUserData( io_perPrim, io_perPoint, fmt );

	for( TFloatUserDataList::iterator it=vecFloat.begin(); it!=vecFloat.end(); ++it )
		it->registerUserData( io_perPrim, io_perPoint, fmt );

	for( TVec3UserDataList::iterator it=vecVec3.begin(); it!=vecVec3.end(); ++it )
		it->registerUserData( io_perPrim, io_perPoint, fmt );
}

// Compute the number of output vertices given the input number of vertrices, the output curve degree and the number of subdivisions.
size_t computeNumVerts( size_t numVerts, size_t degree, size_t subdi )
{
	if( degree==1 )
    {
        if( subdi<1 )
            subdi=1;
		return (numVerts-1)*( subdi-1 ) + numVerts;
    }
	else if( degree==3 )
		return (numVerts-1)*( degree-1 ) + numVerts;
	else
		return numVerts;
}

// Create and Evaluate Points on an SgCurve
inline void evalSgCurve( miScalar* outScalars, const miScalar* inScalars, safevector<SgVec3d>& tmpPoints, size_t numScalarsPerPoint, size_t numVertsIn, size_t numVertsOut )
{
	for( int curS=0; curS<numScalarsPerPoint; curS+=3 )
	{
		bool valid1 = curS+1<numScalarsPerPoint;
		bool valid2 = curS+2<numScalarsPerPoint;

		tmpPoints.resize(numVertsIn-2);
		for( int curV=1; curV<numVertsIn-1; ++curV )
		{
			size_t offset = curV*numScalarsPerPoint+curS;

			SgVec3d p;
			p[0] = inScalars[offset];
			p[1] = valid1 ? inScalars[offset+1] : 0.0;
			p[2] = valid2 ? inScalars[offset+2] : 0.0;
			tmpPoints[curV-1] = p;
		}
		
		for( int curV=0; curV<numVertsOut; ++curV )
		{
			double t = (double)curV / (double)(numVertsOut-1);

			SgVec3d p;
			SgCurve::eval( tmpPoints, t, p );

			size_t offset = curV*numScalarsPerPoint+curS;
			outScalars[offset] = (miScalar)p[0];
			if(valid1) outScalars[offset+1] = (miScalar)p[1];
			if(valid2) outScalars[offset+2] = (miScalar)p[2];
		}
	}
}


/////////////////////////////////////////////////////////////////////////////////
FlushHairDataProcedural::FlushHairDataProcedural(
    const Procedural& parentProc,
    miGeoIndex* pHairIndices,
    miScalar* pHairScalars,
    UserDataList* pUserData,
    miGeoIndex numScalarsPerPoint,
    miGeoIndex numScalarsPerPrim,
    miGeoIndex numInterpolateComponents,
    miGeoIndex numScalarsTotal,
    miGeoIndex numIndicesTotal)
    : BaseProcedural( (BaseProcedural*)&parentProc )
    , m_approx_degree(parentProc.m_approx_degree)
    , m_approx_mode(parentProc.m_approx_mode)
    , m_approx_parametric_subdivisions(parentProc.m_approx_parametric_subdivisions)
    , m_approx_fine_sub_pixel_size(parentProc.m_approx_fine_sub_pixel_size)
    , m_motion_blur_multiplier(parentProc.m_motion_blur_multiplier)
    , m_pHairIndices(pHairIndices)
    , m_pHairScalars(pHairScalars)
    , m_pUserData(pUserData)
    , m_numScalarsPerPoint(numScalarsPerPoint)
    , m_numScalarsPerPrim(numScalarsPerPrim)
    , m_numInterpolateComponents(numInterpolateComponents)
    , m_hairScalarsOffset(0) 
    , m_hairIndicesOffset(0)
    , m_numScalarsTotal(numScalarsTotal) 
    , m_numIndicesTotal(numIndicesTotal) 
{}

/////////////////////////////////////////////////////////////////////////////////
bool FlushHairDataProcedural::initFaceRenderer(FlushHairDataProcedural* dProc, 
    PatchRenderer* patch, unsigned int f)
{
	DEBUG_TRACE( "FlushHairDataProcedural::initFaceRenderer()" );
	dProc->m_face.reset(FaceRenderer::init(patch, f, dProc));
	return dProc->m_face.get() != NULL;
}

/////////////////////////////////////////////////////////////////////////////////
void FlushHairDataProcedural::flush(const char *geomName, PrimitiveCache* pc) 
{
	unsigned int numSamples = pc->get(PC(NumMotionSamples));
	unsigned int numPointsTotal = pc->getSize2(PC(NumVertices), 0);
	unsigned int normalsSize = pc->getSize2(PC(Norms), 0);
	unsigned int widthsSize = pc->getSize(PC(Widths));
    miGeoIndex firstScalarIndex = m_hairScalarsOffset;

	bool bFaceCamera = pc->get(PC(FaceCamera)) && normalsSize == 0;

	// Build User data Layout
	miGeoIndex numScalarsPerPoint = m_numScalarsPerPoint; 
	miGeoIndex numScalarsPerPrim = m_numScalarsPerPrim;
	size_t offsetPosition = m_numScalarsPerPrim;
	int interpolateComponent[100];
	memset( interpolateComponent, 0, sizeof(int)*100 );
    bool success = true;

	// Fill the big scalar array
	{
        assert(m_hairScalarsOffset < m_numScalarsTotal);
        miScalar* pHairScalars = m_pHairScalars + m_hairScalarsOffset;

        // Work buffers we want to reuse and keep outside the loops. 
		std::vector<miScalar> tmpBspline; // The rough bspline control points from XGen
		std::vector<miScalar> tmpEval;    // A temporary buffer used when converting to bezier.
		safevector<SgVec3d> tmpPoints;    // A tmp point buffer used by the evalSgCurve when evaluating curves.
		// First sample, we get everything except motion vectors
		{
			const vec3* points = pc->get(PC(Points), 0);
			const vec3* norms = pc->get(PC(Norms), 0);
			const float* widths = pc->get(PC(Widths));
			//
			// Get the point for motion samples
			// Since mental ray hair objects support only one motion vector, we ignore the intermediate motion steps.
			// A warning is written in the HairDataInit::flush function.
			std::vector<const vec3*> motions;
			//assert(!numSamples || numSamples>1);
			if (numSamples > 1) {
				motions.push_back( pc->get(PC(Points),0) );
				motions.push_back( pc->get(PC(Points),numSamples-1) );
			}
			miScalar* cur = pHairScalars;

			size_t jj = 0;
			const int* numVertsPtr = pc->get(PC(NumVertices), 0);
			for (size_t j = 0; j < pc->getSize2(PC(NumVertices), 0); ++j) 
			{
				
				// Add per hair user data
				assert( m_hairScalarsOffset + numScalarsPerPrim <= m_numScalarsTotal);
				if (m_hairScalarsOffset + numScalarsPerPrim <= m_numScalarsTotal){
					size_t k = 0;
					m_pUserData->pushUserData( j, cur, k, k_iPerPrim );
					cur += numScalarsPerPrim;
					m_hairScalarsOffset += numScalarsPerPrim;
				} else
					success = false;

				// Add per point data
				{
					const int curNumVerts = numVertsPtr[j];
					int curNumVertsOut = 0;
					curNumVertsOut = computeNumVerts( curNumVerts, m_approx_degree, m_approx_parametric_subdivisions );

					size_t k = 0;
					size_t numScalars = numScalarsPerPoint * curNumVerts;
					size_t numScalarsOut = numScalarsPerPoint * curNumVertsOut;
					tmpBspline.resize(numScalars);

					assert( m_hairScalarsOffset + numScalarsOut <= m_numScalarsTotal);
					if (m_hairScalarsOffset + numScalarsOut <= m_numScalarsTotal) 
					{
						for (size_t v = 0; v < curNumVerts; ++v)
						{
							bool bIncrementVarying = !(v == 0 || v == curNumVerts - 2);

							// Add Per Point Data
							//printf( "points_%d_%d=(%f,%f,%f)\n", j,k, points->x, points->y, points->z );
							tmpBspline[k++] = points->x;
							tmpBspline[k++] = points->y;
							tmpBspline[k++] = points->z;

							// Add Per Point Radius
							if (widthsSize != 0)
							{
								//printf( "widths_%d_%d=%f\n", j,k, *widths * 0.5f );
								tmpBspline[k++] = *widths * 0.5f;
								if (bIncrementVarying)
									++widths;
							}

							// Add Per Point orientation
							if (!bFaceCamera)
							{
								if (norms)
								{
									//printf( "norms_%d_%d=(%f,%f,%f)\n", j,k, norms->x, norms->y, norms->z );
									tmpBspline[k++] = norms->x;
									tmpBspline[k++] = norms->y;
									tmpBspline[k++] = norms->z;
									if (bIncrementVarying)
										++norms;
								}
								else
								{
									//printf( "default_norms_%d_%d=(%f,%f,%f)\n", j,k, 1.f, 0.f, 0.f );
									tmpBspline[k++] = 1.f;
									tmpBspline[k++] = 0.f;
									tmpBspline[k++] = 0.f;
								}
							}

							// Per point user data
							{
								m_pUserData->pushUserData( jj++, &tmpBspline[0], k, k_iPerPoint );
							}

							if( numSamples > 1 )
							{
								assert(motions.size() == 2);
								vec3 prev = *motions[0];
								motions[0]++;
								const vec3*& motion = motions[1];
								if( m_approx_degree==1 || m_approx_degree == 3 )
								{
									tmpBspline[k++] = (motion->x - prev.x) * m_motion_blur_multiplier;
									tmpBspline[k++] = (motion->y - prev.y) * m_motion_blur_multiplier;
									tmpBspline[k++] = (motion->z - prev.z) * m_motion_blur_multiplier;
								}
								else
								{
									tmpBspline[k++] = motion->x;
									tmpBspline[k++] = motion->y;
									tmpBspline[k++] = motion->z;
								}

								motion++;
							}

							++points;
						}

						// For linear splines, we can write the evaluation directly into cur[].
						if( m_approx_degree==1 )
						{
							evalSgCurve( cur, &tmpBspline[0], tmpPoints, numScalarsPerPoint, curNumVerts, curNumVertsOut );
						} 
						// For Cubic, we end up with 4 control points per bezier segments.The last one from previous segment is also the first one for next segment.
						// We must first perform an evaluation of the curve positions and then we run the convertion function
						else if( m_approx_degree==3 )
						{
							tmpEval.resize(numScalarsOut);
							evalSgCurve( &tmpEval[0], &tmpBspline[0], tmpPoints, numScalarsPerPoint, curNumVerts, curNumVertsOut );
							convertBsplineToBezier( cur, &tmpEval[0], interpolateComponent, curNumVertsOut, numScalarsPerPoint, m_motion_blur_multiplier );
						}
						else // This case should not really happen. TODO: add Quadratic bezier curve support.
							convertBsplineToBezier(cur, &tmpBspline[0], interpolateComponent, curNumVerts, numScalarsPerPoint, m_motion_blur_multiplier );

						// Increment the current position in the hair scalars output buffer
						cur += numScalarsOut;
						m_hairScalarsOffset += numScalarsOut;
					} else 
						success = false;
				}
			}
		}
	}

	// Fill the index list
	assert( m_hairIndicesOffset + numPointsTotal <= m_numIndicesTotal);
	if (m_hairIndicesOffset + numPointsTotal <= m_numIndicesTotal) {
        miGeoIndex k = firstScalarIndex;
        miGeoIndex* cur = m_pHairIndices + m_hairIndicesOffset;

		const int* numVertsPtr = pc->get(PC(NumVertices), 0);
		for (unsigned int j = 0; j < numPointsTotal; ++j) {
			// printf( "geoindex_%d=%d\n", m_hairIndicesOffset+j,k);
			*cur = k;
			k += numScalarsPerPrim + 
                (numScalarsPerPoint * (miGeoIndex) computeNumVerts( numVertsPtr[j], m_approx_degree, m_approx_parametric_subdivisions));
			++cur;
		}
		*cur = k;
        m_hairIndicesOffset += numPointsTotal;
	} else 
		success = false;

	if (!success) {
		std::string msg = "An error occurred when generating hair object " + std::string(geomName) + ". The geometry may contain errors.";
		mi_warning( mi_mem_strdup( msg.c_str() ) );
	}
}

/////////////////////////////////////////////////////////////////////////////////
InitHairDataProcedural::InitHairDataProcedural( 
    const Procedural& parentProc, UserDataList* pUserData, miHair_list* pHair)
            : BaseProcedural( (BaseProcedural*)&parentProc )
            , m_approx_degree(parentProc.m_approx_degree)
            , m_approx_mode(parentProc.m_approx_mode)
		    , m_approx_parametric_subdivisions(parentProc.m_approx_parametric_subdivisions)
            , m_approx_fine_sub_pixel_size(parentProc.m_approx_fine_sub_pixel_size)
            , m_pUserData(pUserData)
            , m_pHair(pHair)
            , m_numScalarsPerPoint(3)  // Start with 3 floats for Position Per Point
            , m_numScalarsPerPrim(0)
            , m_numInterpolateComponents(-1)
        {}


/////////////////////////////////////////////////////////////////////////////////
bool InitHairDataProcedural::initFaceRenderer(InitHairDataProcedural* dProc, 
    PatchRenderer* patch, unsigned int f)
{
	DEBUG_TRACE( "InitHairDataProcedural::initFaceRenderer()" );
	dProc->m_face.reset(FaceRenderer::init(patch, f, dProc));
	return dProc->m_face.get()!=NULL;
}

namespace {
/**
 * Initialize the instance transform and motion transforms.
 * Identity transform and no motion blur when givving no samples.
 * No motion blur when giving a single sample.
 * Using the new 3.11 multiple motion transforms when given 3,4,5,6,7 and 8 samples.
 * Using single motion transform with 2 samples or when given more than MAX_MOTION_TRANFORMS transforms.
 */
void initInstanceTransforms( miInstance* inst, const std::vector<miMatrixClass>& matrices )
{
	unsigned int numSamples = matrices.size();

	// No transform, set to identity and no need to do anyrthing for motion transforms
	if( numSamples == 0 )
	{
		mi_matrix_ident( inst->tf.local_to_global );
		mi_matrix_ident( inst->tf.global_to_local );
	}
	// Instance Transform
	else
	{
		mi_matrix_copy( inst->tf.local_to_global, matrices[0].m);
		mi_matrix_invert(inst->tf.global_to_local, inst->tf.local_to_global);

		// Motion transformations, when having more than a sample
		if( numSamples>1 )
		{
			// Active the motion transform blur
			inst->gen_motion = miGM_TRANSFORM;

			// Single Motion Transform or more than maximal limit.
			// My first tests show we can't use more than 4 motion transforms
			if( numSamples==2 || numSamples>MAX_MOTION_TRANFORMS )
			{
				mi_matrix_invert( inst->motion_transform, matrices[numSamples-1].m );
			}
			// Multiple Motion transformations
			else
			{
				// Create a scalar array object
				// mi_scene_create needed to be declared on top of the file
				miTag tagMotionTransforms = miNULLTAG;
				{
					int numScalars = 16*(numSamples-1);
					miScalar* scalars = (miScalar*)mi_scene_create( &tagMotionTransforms, miSCENE_SCALAR, numScalars );
					for( unsigned int i=1; i<numSamples; ++i )
					{
						mi_matrix_invert( scalars, matrices[i].m );
						scalars+=16;
					}
					mi_scene_edit_end( tagMotionTransforms );
				}
				// Assign to instance
				inst->time_motion_transform = tagMotionTransforms;
			}
		}
	}
}
}

/**
 * Dump the user data format to mental ray and write out the number of scalars per primitive and point, as well as the number of 
 * intpolateComponents. This is needed to allocate the scalars buffer. InterpolateComponents could also be computed
 * in the FlushHairData callback again.
 * Execute this callback only once. For this, it has to be part of a loop over faces because some faces may be empty so that
 * the callback is not called. Break after the first execution.
 */
void InitHairDataProcedural::flush(const char* geomName, PrimitiveCache* pc)
{
	DEBUG_TRACE( "InitHairDataProcedural::flush" );

    unsigned int numSamples = pc->get(PC(NumMotionSamples));
	unsigned int normalsSize = pc->getSize2(PC(Norms), 0);
	unsigned int widthsSize = pc->getSize(PC(Widths));
	float constantWidth = pc->get(PC(ConstantWidth)) * 0.5f;

	bool bFaceCamera = pc->get(PC(FaceCamera)) && normalsSize == 0;

    if (numSamples > 2) {
        mi_warning("xgen hair object %s: motion_steps > 1 is not supported for hair. Setting to 1.", geomName);
        numSamples = 2;
    }
    if (!isValid()) {

        // List all the optional built in user data
	    // The hair user data can't reuse the same helper for init as other primitive types.
	    m_pUserData->listUserData(pc, true);

	    // Build User data Layout
	    size_t offsetPosition = 0;
	    int interpolateComponent[100];
	    memset( interpolateComponent, 0, sizeof(int)*100 );
	    {
		    // Build User data Layout

		    UserDataFormat fmt;
		    fmt.setType( UserDataFormat::eTexList ); // User data is in state->tex_list.

		    size_t k = 0;
		    interpolateComponent[k++] = 2; // pos.x
		    interpolateComponent[k++] = 2; // pos.y
		    interpolateComponent[k++] = 2; // pos.z

		    // Radius per point
		    if (widthsSize != 0)
		    {
			    hair_info( k_iPerPoint, k_cRadius, 1, m_numScalarsPerPrim, m_numScalarsPerPoint);
			    interpolateComponent[k++] = 1;
		    }
		    else
		    {
			    m_pHair->radius = constantWidth;
		    }

		    // Orientation / Normal
		    if (!bFaceCamera)
		    {
			    hair_info( k_iPerPoint, k_cNormal, 3, m_numScalarsPerPrim, m_numScalarsPerPoint);
			    interpolateComponent[k++] = 1;
			    interpolateComponent[k++] = 1;
			    interpolateComponent[k++] = 1;
		    }

		    // Register Hair Optional User Data
		    {
			    size_t optNumScalarsPerPoint = 0;
			    size_t optNumScalarsPerPrim = 0;

			    m_pUserData->registerUserData( optNumScalarsPerPrim, optNumScalarsPerPoint, fmt, k, interpolateComponent );

			    hair_info( k_iPerPrim, k_cTexture, optNumScalarsPerPrim, m_numScalarsPerPrim, m_numScalarsPerPoint);
			    hair_info( k_iPerPoint, k_cTexture, optNumScalarsPerPoint, m_numScalarsPerPrim, m_numScalarsPerPoint);
		    }
		

            // Motion
            if (numSamples > 1)
            {
                hair_info( k_iPerPoint, k_cMotion, 3*(numSamples-1), m_numScalarsPerPrim, m_numScalarsPerPoint);
                for( size_t m=0; m<numSamples-1; ++m )
                {
                    if( m==0 ) // First motion sample, will use position to compute it self
                    {
                        interpolateComponent[k++] = k_iInterpolateFirstMotionVectorX;
                        interpolateComponent[k++] = k_iInterpolateFirstMotionVectorY;
                        interpolateComponent[k++] = k_iInterpolateFirstMotionVectorZ;
                    }
                    else // Other motion vectors are using previous motion samples
                    {
                        interpolateComponent[k++] = k_iInterpolateFirstMotionVectorX;
                        interpolateComponent[k++] = k_iInterpolateFirstMotionVectorY;
                        interpolateComponent[k++] = k_iInterpolateFirstMotionVectorZ;
                    }
                }
            }

		    offsetPosition = m_numScalarsPerPrim;

		    fmt.buildMap();
		    fmt.toString( m_userDataStrFormat );
            
            m_numInterpolateComponents = (unsigned int)k;
	    }
    }

	//printf( "numScalarsPerPoint=%d, numScalarsPerPrim=%d, offsetPosition=%d\n", numScalarsPerPoint, numScalarsPerPrim, offsetPosition );
}

/////////////////////////////////////////////////////////////////////////////////
CountHairDataProcedural::CountHairDataProcedural( 
    const Procedural& parentProc )
            : BaseProcedural( (BaseProcedural*)&parentProc )
            , m_approx_degree(parentProc.m_approx_degree)
            , m_approx_mode(parentProc.m_approx_mode)
		    , m_approx_parametric_subdivisions(parentProc.m_approx_parametric_subdivisions)
            , m_approx_fine_sub_pixel_size(parentProc.m_approx_fine_sub_pixel_size)
            , m_numPrims(0)
            , m_numPoints(0)
        {}

/////////////////////////////////////////////////////////////////////////////////
bool CountHairDataProcedural::initFaceRenderer(CountHairDataProcedural* dProc, 
    PatchRenderer* patch, unsigned int f)
{
	DEBUG_TRACE( "InitHairDataProcedural::initFaceRenderer()" );
	dProc->m_face.reset(FaceRenderer::init(patch, f, dProc));
	return dProc->m_face.get()!=NULL;
}

/**
 * Collect the number of primitives and points per face. 
 * Once the number of points/prims is known in advance, we can remove this part and only init the user data.
 */
void CountHairDataProcedural::flush(const char* geomName, PrimitiveCache* pc)
{
	DEBUG_TRACE( "CountHairDataProcedural::flush" );
	unsigned int numPointsTotal = pc->getSize2(PC(NumVertices), 0);
  
    m_numPrims += numPointsTotal;
    const int* numVertsPtr = pc->get(PC(NumVertices), 0);
    for (size_t j = 0; j < numPointsTotal; ++j) {
        size_t curVertsPerPoints = (size_t)(numVertsPtr[j]);
        curVertsPerPoints = computeNumVerts( curVertsPerPoints, m_approx_degree, m_approx_parametric_subdivisions );
        m_numPoints += (unsigned int) curVertsPerPoints;
    }
}


/**
 * Write the header part of the hair object. Allocate buffers for writing scalar data and indices.
 */
miHair_list* Procedural::beginHairObject( ) 
{
	// Build names
    string strID = itoa((int) m_tags.size());
	string dataName = m_parentName + string("_hair[d][") + strID + string("]");

    miTag tagObj = m_tagPlaceholderObject;
    string objName = mi_api_tag_lookup(tagObj);
	
	// Start Hair Object, add incremental statement for placeholder object
    mi_api_incremental(true);
	/*miObject* pObject =*/mi_api_object_begin( mi_mem_strdup(objName.c_str() ));
	miHair_list* pHair = mi_api_hair_begin();
	pHair->degree = m_approx_degree;
	pHair->space_max_depth = 20;
	pHair->space_max_size = 5;

	if( m_approx_mode == 1 )
	{
		miInteger approx = 1 << m_approx_parametric_subdivisions;
		miAPPROX_DEFAULT(pHair->approx);
		pHair->approx.cnst[0] = ((miScalar)approx) / ((miScalar)pHair->degree);
	}
	else if( m_approx_mode == 2 )
	{
		miAPPROX_FINE_DEFAULT(pHair->approx);
		pHair->approx.cnst[0] = m_approx_fine_sub_pixel_size;
	}
	else
	{
        miAPPROX_NONE(pHair->approx);
	}
	return pHair;
}


void Procedural::endHairObject(unsigned int numScalarsTotal, const string& strFormat) {

    // Done filling the scalars
    mi_api_hair_scalars_end((int)numScalarsTotal);
    mi_api_hair_hairs_end();

	// Done with the hair object
	mi_api_hair_end();
	miTag hairObjTag = mi_api_object_end();
  
    mi_api_incremental(false);

    string strID = itoa((int) m_tags.size());
	string dataName = m_parentName + string("_hair[d][") + strID + string("]");
    m_tagUserData = createUserData(true, dataName, strFormat, NULL);
    miObject* pObject = (miObject *)mi_scene_edit(hairObjTag);
    pObject->userdata = m_tagUserData;
    mi_scene_edit_end(hairObjTag);

    // Keep our new tags. 
	m_tags.push_back(hairObjTag);
}


/////////////////////////////////////////////////////////////////////////////////
FlushSphereProcedural::FlushSphereProcedural(
    const Procedural& parentProc,
    miTag sphereTag)
    : BaseProcedural( (BaseProcedural*)&parentProc )
    , m_parentName(parentProc.getParentName())
    , m_sphere(sphereTag)
    , m_result(miNULLTAG)
{}

/////////////////////////////////////////////////////////////////////////////////
bool FlushSphereProcedural::initFaceRenderer(FlushSphereProcedural* dProc, 
                                               PatchRenderer* patch, unsigned int f)
{
    DEBUG_TRACE( "FlushHairDataProcedural::initFaceRenderer()" );
    dProc->m_face.reset(FaceRenderer::init(patch, f, dProc));
    return dProc->m_face.get() != NULL;
}


// Render a sphere assembly (one per patch)
bool Procedural::renderSphereAssembly()
{
    // Create a sphere placeholder object and attach it to an instance group 
    miTag sphereTag = createSphereInstanceGroup(m_parentName, m_max_displace, m_sphere_subdiv_u, m_sphere_subdiv_v);

    // Write out the hair data
    FlushSphereProcedural flushProc(*this, sphereTag);
    unsigned int f = (unsigned int)-1;
    bbox b;
    while (nextFace(b, f))
    {
        if (isEmpty(b))
            continue;
        FlushSphereProcedural::initFaceRenderer(&flushProc, m_patch, f);
        flushProc.render();
    }
    m_result = flushProc.getResultTag();
    return true;
}


/*
 * Emit the Sphere instances for the cached primitives. This might be called
 * as primitives are emitted to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void FlushSphereProcedural::flush( const char *geomName, PrimitiveCache* pc )
{
	DEBUG_TRACE( "Procedural::flushSpheres" );

	unsigned int cacheCount = pc->get(PC(CacheCount));
	unsigned int numSamples = pc->get(PC(NumMotionSamples));

	bool normalParam = pc->get(PC(NormalParam));

	// List all the optional built in user data
	std::vector<float> scalars;
	std::string strFormat;
	UserDataList ud;
	listInstanceUserData( pc, ud, strFormat, scalars );

	std::vector<miMatrixClass> matrices;
	matrices.resize(numSamples);

	for (unsigned int j = 0; j < cacheCount; j++)
	{
		// Add per instance user data
		{
			size_t k = 0;
			ud.pushUserData( j, &scalars[0], k, k_iPerPrim );
		}

		// Evaluate all the matrices
		// For the first frame, return xP and xN.
		mat44 xP, xN;
		double prevAngle2 = 0.0; // evalMatrix uses previous angle from last evaluation to find shortest rotations.
		for (unsigned int i = 0; i < numSamples; i++)
		{
			evalMatrix( matrices[i], (i==0) ? &xP : NULL, (i==0) ? &xN : NULL, pc->get(PC(Points), i), j, prevAngle2, /*bbox_scale=*/1.0, normalParam );
		}

		// Add custom parameters and call sphere.
		pc->inverseXformParams(j, xP, xN);

		string strID = itoa((int) m_tags.size());

		// and a sphere instance.
		string instName = m_parentName + string("_sphere[i][") + strID + string("]");
        string dataName = m_parentName + string("_sphere[d][") + strID + string("]");

		miInstance* inst = mi_api_instance_begin( mi_mem_strdup(instName.c_str()) );
		initInstanceUserData( inst, /*isSpline=*/false, dataName, strFormat, &scalars );
		initInstanceTransforms( inst, matrices );

        string sphereName = mi_api_tag_lookup(m_sphere);
        miTag sphere_inst = mi_api_instance_end( mi_mem_strdup(sphereName.c_str()), miNULLTAG, miNULLTAG);
        mi_geoshader_add_result(&m_result, sphere_inst);

		// Add custom renderer parameters.
		//pushCustomParams( nodeInstance, pc );

		// Keep our new tags.
		m_tags.push_back(sphere_inst);
	}
}

// Create the instance group of the shared archive.
/////////////////////////////////////////////////////////////////////////////////
miTag Procedural::makeArchiveInstanceGroup(PrimitiveCache* pc,
		const std::string& in_instanceName, const std::string& instanceGroupName,
		const std::string& in_filename, const std::string& in_select, const std::string& in_material, miScalar frame,
		miInteger assembly)
{
	unsigned int numSamples = pc->get(PC(NumMotionSamples));
	std::vector<miMatrixClass> matrices;
	matrices.resize( numSamples );
	for( unsigned int i=0; i<numSamples; ++i )
	{
		mi_matrix_ident( matrices[i].m );
	}

	miTag archiveGeo = miNULLTAG;

	std::vector < std::string > vecFilenames, vecSelect, vecMaterial;
	XGenMR::split( vecFilenames, in_filename, "\n" );
	XGenMR::split( vecSelect, in_select, "\n" );
	XGenMR::split( vecMaterial, in_material, "\n" );
	
	bool bValidSelect = vecFilenames.size() == vecSelect.size();
	for( std::vector < std::string >::iterator it=vecSelect.begin(); it!=vecSelect.end(); ++it )
	{
		std::replace( it->begin(), it->end(), '|', '/' );
	}

	bool bValidMaterial = vecFilenames.size() == vecMaterial.size();
	std::string strEmptyString = "";
	
	std::vector < std::string > vecInstanceNames;
	for( size_t i=0; i<vecFilenames.size(); ++i )
	{
		std::string filename = vecFilenames[i];

		// Expand the ${FRAME} token.
		{
			size_t pos = filename .find("${FRAME}");
			while ( pos != string::npos ) {
				filename .replace(pos,8, itoa((int)floor(frame),"%4.4d") );
				pos = filename .find("${FRAME}",pos+1);
			}
		}

		const std::string& select = bValidSelect ? vecSelect[i] : strEmptyString;
		const std::string& material = bValidMaterial ? vecMaterial[i] : strEmptyString;
		
		std::string instanceName = in_instanceName;
		if( i>0 )
			instanceName += std::string( itoa((int)i) );
		
		int ext = getArchiveExtension(filename);

		if (ext == eAssembly || ext == eAssemblyGZ)
		{
			// Ask for a bounding box
			bbox bbox;
			pc->getArchiveBoundingBox(filename.c_str(), bbox);

			// Create a file assembly
			miAssembly* assem = mi_api_assembly_begin(NULL);
			assem->bbox_min.x = assem->bbox_min_m.x = (float) bbox.xmin;
			assem->bbox_max.x = assem->bbox_max_m.x = (float) bbox.xmax;
			assem->bbox_min.y = assem->bbox_min_m.y = (float) bbox.ymin;
			assem->bbox_max.y = assem->bbox_max_m.y = (float) bbox.ymax;
			assem->bbox_min.z = assem->bbox_min_m.z = (float) bbox.zmin;
			assem->bbox_max.z = assem->bbox_max_m.z = (float) bbox.zmax;
			assem->bbox_min_m.x -= 1.f;
			assem->bbox_min_m.y -= 1.f;
			assem->bbox_min_m.y -= 1.f;
			assem->bbox_max_m.x += 1.f;
			assem->bbox_max_m.y += 1.f;
			assem->bbox_max_m.z += 1.f;
			mi_api_assembly_filename(mi_mem_strdup(filename.c_str()));
			archiveGeo = mi_api_assembly_end();
		}
		else if (ext == eAbc)
		{
			// Make an alembic archive instance
			mi_api_function_call(mi_mem_strdup("abcimport"));
			mi_api_parameter_name(mi_mem_strdup("filename"));
			mi_api_parameter_value(miTYPE_STRING, mi_mem_strdup(filename.c_str()),NULL, NULL);
			mi_api_parameter_name(mi_mem_strdup("select"));
			mi_api_parameter_value(miTYPE_STRING, mi_mem_strdup(select.c_str()),NULL, NULL);
			mi_api_parameter_name(mi_mem_strdup("time"));
			mi_api_parameter_value(miTYPE_SCALAR, &frame, NULL, NULL);
			mi_api_parameter_name(mi_mem_strdup("assembly"));
			mi_api_parameter_value(miTYPE_INTEGER, &assembly, NULL, NULL);
			archiveGeo = mi_api_function_call_end(miNULLTAG);
		}

		miInstance* inst = mi_api_instance_begin( mi_mem_strdup(instanceName.c_str()) );
		initInstanceFlags( inst, true );
		initInstanceTransforms( inst, matrices );
		
		// Search for the material by name
		miTag tagMaterial = mi_api_name_lookup( mi_mem_strdup(material.c_str()) );
		if( tagMaterial!=miNULLTAG )
		{
			inst->material = tagMaterial;
			inst->mtl_override = miTRUE;
		}
		else
		{
			inst->material = m_state->material;
			inst->mtl_override = miTRUE;
		}
				
		mi_matrix_ident(inst->tf.local_to_global);
		mi_matrix_invert(inst->tf.global_to_local, inst->tf.local_to_global);
		/*miTag archive_inst = */mi_api_instance_end(NULL, archiveGeo, miNULLTAG);
		
		vecInstanceNames.push_back( instanceName );
	}

	// Create a Group, to allow us to do instancing of instances
	mi_api_instgroup_begin(mi_mem_strdup(instanceGroupName.c_str()));
	
	for( std::vector < std::string >::const_iterator it=vecInstanceNames.begin(); it!=vecInstanceNames.end(); ++it )
		mi_api_instgroup_additem(mi_mem_strdup(it->c_str()));
	miTag archiveGroup = mi_api_instgroup_end();

	return archiveGroup;
}



// flushArchives, abc, mi and mi.gz are supported
/////////////////////////////////////////////////////////////////////////////////
void Procedural::flushArchives(const char *geomName, PrimitiveCache* pc)
{
	DEBUG_TRACE( "Procedural::flushArchives" );

	// Default to 1.0 so that it has no effect for archive files that
	// do not contain BBOX information
	double bbox_scale = 1.0 / pc->get(PC(ArchiveSize));

	unsigned int cacheCount = pc->get(PC(CacheCount));
	unsigned int numSamples = pc->get(PC(NumMotionSamples));

//    unsigned int shutterSize = pc->getSize( PC(Shutter) );
//	float* shutter = (float*)pc->get( PC(Shutter) );

	bool normalParam = pc->get(PC(NormalParam));

	int lodLevels = pc->get(PC(LodLevels));
//	const bool* useLevel = pc->get( PC(ArchiveUseLevel) );
//	const float* minVis = (const float*)&pc->get( PC(MinVis) ).x;
//	const float* maxVis = (const float*)&pc->get( PC(MaxVis) ).x;
//	const float* loTrans = (const float*)&pc->get( PC(LoTrans) ).x;
//	const float* upTrans = (const float*)&pc->get( PC(UpTrans) ).x;

	// Get archive name string pointers
	//double archiveScale = pc->get( PC(ArchiveSize) );
	unsigned int archivesSize = pc->getSize(PC(Archives));
	const char** archives = new const char*[archivesSize];
	const char** archivesAbsolute = new const char*[archivesSize];
	const char** archivesObjects = new const char*[archivesSize];
	const char** archivesMaterial = new const char*[archivesSize];
	for (unsigned int a = 0; a < archivesSize; a++)
	{
		archives[a] = pc->get(PC(Archives), a);
		archivesAbsolute[a] = pc->get(PC(ArchivesAbsolute), a);
		archivesObjects[a] = pc->get(PC(ArchivesObjects), a);
		archivesMaterial[a] = pc->get(PC(ArchivesMaterial), a);
	}
	const double* archivesFrame = pc->get(PC(ArchivesFrame_XP));

	std::vector<miMatrixClass> matrices;
	matrices.resize(numSamples);

	// List all the optional built in user data
	std::vector<float> scalars;
	std::string strFormat;
	UserDataList ud;
	listInstanceUserData( pc, ud, strFormat, scalars );

	for (unsigned int j = 0; j < cacheCount; j++)
	{
		// Add per instance user data
		{
			size_t k = 0;
			ud.pushUserData( j, &scalars[0], k, k_iPerPrim );
		}
		
		// Eval all the matrices
		// For the first frame, return xP and xN.
		mat44 xP, xN;
		double prevAngle2 = 0.0; // evalMatrix uses previous angle from last evaluation to find shortest rotations.
		for (unsigned int i = 0; i < numSamples; i++)
		{
			evalMatrix( matrices[i], (i==0) ? &xP : NULL, (i==0) ? &xN : NULL, pc->get(PC(Points), i), j, prevAngle2, bbox_scale, normalParam );
		}

		// Add custom parameters.
		pc->inverseXformParams(j, xP, xN);

		string strID = itoa((int) m_tags.size());
		string basename = m_parentName + string("_archive_") + strID;
		string strInstance = basename + string("[i]");
		string strAbcInstance = basename + string("[abci]");
		string strAbcInstanceGroup = basename + string("[abcig]");
		string strInstanceUserData = basename + string("[d]");

		miInteger jj = j * lodLevels * numSamples  + 2;// +2 for hi index.
		std::string key = buildArchiveKey( m_parentNameNoFace.c_str(), archivesAbsolute[jj], archivesObjects[jj], archivesMaterial[jj], (miScalar) archivesFrame[j] );
		std::map<std::string, std::string>::const_iterator it = m_archives->find(key);

		// Reuse existing abc assembly
		if (it != m_archives->end())
		{
			strAbcInstanceGroup = it->second;
		}
		else if (!m_bPerFaceAssemblies) // Create a new one
		{
			miTag archiveGroup = makeArchiveInstanceGroup(pc, strAbcInstance,
					strAbcInstanceGroup, archivesAbsolute[jj], archivesObjects[jj], archivesMaterial[jj],
					(miScalar) archivesFrame[j], miFALSE);
			(*m_archives)[key] = strAbcInstanceGroup;
			m_tagsHiddenGroup.push_back(archiveGroup);
		}
		else
		{
			strAbcInstanceGroup = "";
		}

		if (strAbcInstanceGroup != "")
		{
			// Create an instance to instantiate the abc instance
			miInstance* inst = mi_api_instance_begin( mi_mem_strdup(strInstance.c_str()) );

			initInstanceFlags(inst, true);
			initInstanceUserData( inst, /*isSpline=*/false, strInstanceUserData, strFormat, &scalars );
			initInstanceTransforms( inst, matrices );

			miTag instTag = mi_api_instance_end( mi_mem_strdup(strAbcInstanceGroup.c_str()), miNULLTAG, miNULLTAG );
			mi_geoshader_add_result(&m_result, instTag);

			m_tags.push_back(instTag);
		}
	}

	delete[] archives;
	delete[] archivesAbsolute;
}

// Do a preprocess to get the used archive list.
/////////////////////////////////////////////////////////////////////////////////
void Procedural::syncArchives(const char *geomName, PrimitiveCache* pc)
{
	DEBUG_TRACE( "Procedural::syncArchives" );

	unsigned int cacheCount = pc->get(PC(CacheCount));
	unsigned int numSamples = pc->get(PC(NumMotionSamples));
	int lodLevels = pc->get(PC(LodLevels));

	// Get archive name string pointers
	unsigned int archivesSize = pc->getSize(PC(Archives));
	const char** archives = new const char*[archivesSize];
	const char** archivesAbsolute = new const char*[archivesSize];
	const char** archivesObjects = new const char*[archivesSize];
	const char** archivesMaterial = new const char*[archivesSize];
	for (unsigned int a = 0; a < archivesSize; a++)
	{
		archives[a] = pc->get(PC(Archives), a);
		archivesAbsolute[a] = pc->get(PC(ArchivesAbsolute), a);
		archivesObjects[a] = pc->get(PC(ArchivesObjects), a);
		archivesMaterial[a] = pc->get(PC(ArchivesMaterial), a);
	}
	const double* archivesFrame = pc->get(PC(ArchivesFrame_XP));

	for (unsigned int j = 0; j < cacheCount; j++)
	{
		miInteger jj = j * lodLevels * numSamples  + 2;	// +2 for hi index.

		std::string key = buildArchiveKey( m_parentNameNoFace.c_str(), archivesAbsolute[jj], archivesObjects[jj], archivesMaterial[jj], (miScalar) archivesFrame[j] );
		std::map<std::string, std::string>::const_iterator it = m_archives->find(key);

		// Create a new abc assembly
		if (it == m_archives->end())
		{
			string strID = itoa((int) m_archives->size());
			string basename = m_parentName + string("_archive_") + strID;
			string strAbcInstance = basename + string("[abci]");
			string strAbcInstanceGroup = basename + string("[abcig]");

			miTag archiveGroup = makeArchiveInstanceGroup(pc, strAbcInstance,
					strAbcInstanceGroup, archivesAbsolute[jj], archivesObjects[jj], archivesMaterial[jj],
					(miScalar) archivesFrame[j], miFALSE);
			(*m_archives)[key] = mi_api_tag_lookup(archiveGroup);
			m_tagsHiddenGroup.push_back(archiveGroup);
		}
	}

	delete[] archives;
	delete[] archivesAbsolute;
}

const char* Procedural::getUniqueName(char* buf, const char* basename)
{
	static unsigned int g_counter = 0;
	sprintf(buf, "%s__%X", basename, g_counter++);
	return buf;
}


// ifstream like wrapper for mi.gz
/////////////////////////////////////////////////////////////////////////////////
#define CHUNK 16384
#define READ_CHARACTERS 20000
class zlib_ifstream
{
public:
	zlib_ifstream( const char* in_filename )
	{
		m_file = gzopen( in_filename, "r" );
		m_init = true;
	}
	~zlib_ifstream()
	{
		if( m_file )
			gzclose( m_file );
	}
	bool good()
	{
		return m_file!=NULL;
	}

	bool getline( std::string& strLine )
	{
		if( m_file == NULL )
			return false;

		if( m_init )
		{
			m_init = false;
			//gzbuffer( m_file, CHUNK );
		}

		m_buf[0] = '\0';
		if( gzgets( m_file, m_buf, CHUNK ) != NULL )
		{
			strLine = m_buf;
			return true;
		}
		else
			return  false;
	}

private:

	gzFile m_file;
	bool m_init;
	char m_buf[CHUNK+1];

};

// Dumb wrapper around std::ifstream
/////////////////////////////////////////////////////////////////////////////////
class simple_ifstream : public std::ifstream
{
public:
	simple_ifstream( const char* in_filename ) :
	std::ifstream( in_filename, std::ios_base::in )
	{
	}
	virtual ~simple_ifstream()
	{
	}
	bool getline( std::string& strLine )
	{
		return std::getline( *this, strLine ).good();
	}
};

// read the bounding box from a file
/////////////////////////////////////////////////////////////////////////////////
template< class ISTREAM >
void readBoundingBox( const char* in_filename, bbox& out_bbox )
{
	// Comment includes the 6 values for the bounding box
	// # assembly root bbox: -3.782213 -0.0617536 -7.229313 7.528092 9.701033 8.196919
	const std::string k_strStart = "# assembly root bbox: ";
	const std::string k_strFormat = k_strStart + "%lf %lf %lf %lf %lf %lf";

	// Open the file
	ISTREAM file( in_filename );
	if( file.good() )
	{
		try
		{
			int curLine = 0;
			// Loop over all the first 50 decompressed lines
			for( std::string strLine; file.getline( strLine ) && curLine<50; ++curLine )
			{
				// Check if the line starts with the right comment
				if( strLine.size() > k_strStart.size() && strLine.find( k_strStart ) == 0 )
				{
					// Scan the line to retrieve the 6 numbers
					double b[6];
					if( sscanf(strLine.c_str(), k_strFormat.c_str(), &b[0], &b[1], &b[2], &b[3], &b[4], &b[5] ) == 6)
					{
						out_bbox.xmin = b[0];
						out_bbox.ymin = b[1];
						out_bbox.zmin = b[2];

						out_bbox.xmax = b[3];
						out_bbox.ymax = b[4];
						out_bbox.zmax = b[5];

						// We are good, break the getline loop
						break;
					}
				}
			}
		}
		catch( int e )
		{
			std::cout << e << std::endl;
		}
	}
}

// Xgen callback to read the bounding box.
/////////////////////////////////////////////////////////////////////////////////
bool BaseProcedural::getArchiveBoundingBox(const char* in_filename, bbox& out_bbox ) const
{
	// Default bounding box
	out_bbox.xmin = -0.5;
	out_bbox.ymin = 0.0;
	out_bbox.zmin = -0.5;
	out_bbox.xmax = 0.5;
	out_bbox.ymax = 1.0;
	out_bbox.zmax = 0.5;

	ArchiveExtension ext = getArchiveExtension( in_filename );
	if( ext == eAssemblyGZ )
		readBoundingBox<zlib_ifstream>( in_filename, out_bbox );
	else if( ext == eAssembly )
		readBoundingBox<simple_ifstream>( in_filename, out_bbox );

	return true;
}

void BaseProcedural::convertMatrix(const miMatrix in_mat, mat44& out_mat) {
	memcpy(&out_mat, in_mat, sizeof(float) * 16);
}

void BaseProcedural::getTransform(float in_time, mat44& out_mat) const {
	miMatrix result;
	mi_matrix_ident(result);

	convertMatrix(result, out_mat);
}

} // namespace XGenMR

// mental ray init callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT void xgen_geo_init(miState* state, void* paras, miBoolean *inst_init_req )
{
	if (!paras) /* main shader init */
	{
		s_archives.clear();
		s_bCleanDescriptionCache = true;
		std::vector<string> pals = XgPalette::palettes();
		for( std::vector<string>::const_iterator pal=pals.begin(); pal!=pals.end(); ++pal )
		{
			if( pal->find( "XG_RENDER_") == 0 )
			{
				delete XgPalette::palette(*pal);
			}
		}

		s_iProceduralID = 0;

		DEBUG_TRACEP( "xgen_geo_init", (void*)NULL );
		*inst_init_req = miTRUE; /* want inst inits too */
	}
	else /* shader instance init */
	{
		void **user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		Procedural* ud = new Procedural();
		DEBUG_TRACEP( "xgen_geo_init_instance", (void*)ud );
		ud->init(state, (Procedural::Params*) paras, inst_init_req);
		*user = (void*) ud;
	}
}

// mental ray exit callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT void xgen_geo_exit(miState* state, void* paras )
{
	if (!paras) /* main shader exit */
	{
		DEBUG_TRACEP( "xgen_geo_exit", (void*)NULL );
		/* no further inst exits will occur */
	}
	else /* shader instance exit */
	{

		void **user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		Procedural* ud = (Procedural*) *user;
		DEBUG_TRACEP( "xgen_geo_exit_instance", (void*)ud );
		ud->exit(state, (Procedural::Params*) paras);
		delete ud;
		*user = NULL;
	}
}

// mental ray version callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT int xgen_geo_version(void)
{
	return 2;
}

// mental ray execute callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT miBoolean xgen_geo(miTag* result, miState* state, void* in_paras)
{
	void **user;
	mi_query(miQ_FUNC_USERPTR, state, 0, &user);

	Procedural* ud = (Procedural*) *user;
	DEBUG_TRACEP( "xgen_geo", ud );

	Procedural::Params* paras = (Procedural::Params*)in_paras;
	
	// Execute geoshader and echo to file
	miBoolean ret = ud->execute( result, state, paras );
	ud->echo( result, state, paras );
	return ret;

}
