// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#include <ai.h>
#include <string>
#include <vector>
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <pthread.h>
#include <iostream>

#include <XGen/XgRenderAPIUtils.h>
#include "XgArnoldProcedural.h"



#define MAX_NAME_SIZE 65535

#define XGDebug( x ) {}
#define XGError( x ) {}
#define XGDebugLevel 4

#define XGRenderAPIError XGError
#define XGRenderAPIWarning XGWarning
#define XGRenderAPIStats XGStats
#define XGRenderAPIDebug XGDebug

using namespace XGenRenderAPI::Utils;
using namespace XGenArnold;
using namespace std;



pthread_mutex_t  xgMutex = PTHREAD_MUTEX_INITIALIZER;
class XgAutoMutex
{
public:
	XgAutoMutex()
	{
		pthread_mutex_lock( &xgMutex );
	}
	~XgAutoMutex()
	{
		pthread_mutex_unlock( &xgMutex );
	}
};

namespace XGenArnold
{


Procedural::Procedural()
: m_node( NULL )
, m_node_face( NULL )
, m_options( NULL )
, m_camera( NULL )
, m_sphere( NULL )
, m_shaders( NULL )
, m_patch( NULL )
, m_face( NULL )
{
}

Procedural::~Procedural()
{
	if( m_patch )
	{
		delete m_patch;
		m_patch = NULL;
	}
}

bool Procedural::nextFace( bbox& b, unsigned int& f )
{
	XgAutoMutex autoMutex;
	return m_patch->nextFace( b, f );
}

bool Procedural::initPatchRenderer( const char* in_params )
{
	XgAutoMutex autoMutex;
	m_patch = PatchRenderer::init( (ProceduralCallbacks*)this, in_params );
	return m_patch!=NULL;
}

bool Procedural::initFaceRenderer( Procedural* pProc, unsigned int f )
{
	XgAutoMutex autoMutex;
	pProc->m_face = FaceRenderer::init( m_patch, f, pProc );
	return pProc->m_face!=NULL;
}

bool Procedural::render()
{
	XgAutoMutex autoMutex;
	m_face->render();
	return true;
}

const char* Procedural::getUniqueName( char* buf, const char* basename )
{
	static unsigned int g_counter = 0;
	sprintf( buf, "%s__%X", basename, g_counter++ );
	return buf;
}

int Procedural::Init(AtNode* node)
{
	char buf[512];

	string parameters( AiNodeGetStr( node, "data" ) );

	m_options = AiUniverseGetOptions();
	m_camera = AiUniverseGetCamera();

	// Cleanup Init
	if( parameters == "cleanup" )
	{
		// Noop!
	}

	// Patch Init
	else if( m_patch==NULL && m_face==NULL )
    {

		m_node = node;
		m_shaders = AiNodeGetArray( m_node, "shader" );

		string strParentName = AiNodeGetName( m_node );
		string strParentDso = AiNodeGetStr( m_node, "dso" );

		bool bLoadAtInit = AiNodeGetBool( m_node, "load_at_init" );

		// Create a sphere shape node
		{
			m_sphere = AiNode("sphere");
			AiNodeSetStr( m_sphere, "name", getUniqueName(buf,( strParentName + string("_sphere_shape") ).c_str() ) );
			AiNodeSetFlt( m_sphere, "radius", 0.5f );
			AiNodeSetPnt( m_sphere, "center", 0.0f, 0.0f, 0.0f );
			AiNodeSetInt( m_sphere, "visibility", 0 );
			m_nodes.push_back( m_sphere );
		}

		// This is where we link our callbacks to the PatchRenderer.
		initPatchRenderer( parameters.c_str() );

		bbox b;
		unsigned int f = -1;
		while( nextFace( b, f ) )
		{
			// Skip camera culled bounding boxes.
			if( isEmpty( b ) )
				continue;

			string strFaceProcName = strParentName + string("_face") + itoa( f );

			Procedural* pProc = new Procedural();
			pProc->m_node = m_node;
			pProc->m_sphere = m_sphere;
			pProc->m_shaders = m_shaders;

			initFaceRenderer( pProc, f );

			// Clone ourself, this will help us keep all the user parameters.
			// We could also provide a back pointer to the original top level node.
			AtNode* nodeFaceProc = AiNode( "procedural" );
			pProc->m_node_face = nodeFaceProc;

			// Change name, dso, userdata, and bounding box
			AiNodeSetStr( nodeFaceProc, "name", getUniqueName(buf,strFaceProcName.c_str()) );
			AiNodeSetStr( nodeFaceProc, "dso", strParentDso.c_str() );
			AiNodeSetBool( nodeFaceProc, "load_at_init", bLoadAtInit );
			AiNodeSetPtr( nodeFaceProc, "userptr", (void*)new ProceduralWrapper( pProc, false ) );
			AiNodeSetPnt( nodeFaceProc, "min", (AtFloat)b.xmin, (AtFloat)b.ymin, (AtFloat)b.zmin );
			AiNodeSetPnt( nodeFaceProc, "max", (AtFloat)b.xmax, (AtFloat)b.ymax, (AtFloat)b.zmax );

			m_nodes.push_back( nodeFaceProc );
		}

		// Add a cleanup procedural that will be responsible to cleanup the Top Level Patch data.
		{
			AtNode* nodeCleanupProc = AiNode( "procedural" );
			string strCleanupProcName =  strParentName + "_cleanup";

			AiNodeSetStr( nodeCleanupProc, "name", getUniqueName(buf,strCleanupProcName.c_str()) );
			AiNodeSetStr( nodeCleanupProc, "dso", strParentDso.c_str() );
			AiNodeSetStr( nodeCleanupProc, "data", "cleanup" );
			AiNodeSetBool( nodeCleanupProc, "load_at_init", bLoadAtInit );
			AiNodeSetPtr( nodeCleanupProc, "userptr", (void*)new ProceduralWrapper( this, true ) );

			AtPoint minParentBBox = AiNodeGetPnt( m_node, "min" );
			AtPoint maxParentBBox = AiNodeGetPnt( m_node, "max" );

			AiNodeSetPnt( nodeCleanupProc, "min", minParentBBox.x, minParentBBox.y, minParentBBox.z );
			AiNodeSetPnt( nodeCleanupProc, "max", maxParentBBox.x, maxParentBBox.y, maxParentBBox.z );

			m_nodes.push_back( nodeCleanupProc );
		}
    }

	// Face Init
    else if( m_face!=NULL )
    {
    	render();
    }

	return 1;
}

int Procedural::Cleanup()
{
	m_nodes.clear();
	m_node = m_node_face = m_options = m_sphere = NULL; // Don't delete.

	if( m_face )
	{
		delete m_face;
		m_face = NULL;
	}
	return 1;
}

int Procedural::NumNodes()
{
	return (int)m_nodes.size();
}

AtNode* Procedural::GetNode(int i)
{
	return m_nodes[i];
}

bool Procedural::getFloat( AtNode* in_node, const char* in_name, float& out_value, bool in_user  ) const
{
	if( in_user )
	{
		const AtUserParamEntry* upe = AiNodeLookUpUserParameter( in_node, in_name );
		if( upe && AiUserParamGetType(upe)==AI_TYPE_FLOAT )
		{
			out_value = AiNodeGetFlt( in_node, in_name );
			return true;
		}
	}
	else
	{
		// We are assuming the parameter exists
		out_value = AiNodeGetFlt( in_node, in_name );
		return true;
	}
	return false;
}

bool Procedural::getString( AtNode* in_node, const char* in_name, const char*& out_value, bool in_user  ) const
{
	if( in_user )
	{
		const AtUserParamEntry* upe = AiNodeLookUpUserParameter( in_node, in_name );
		if( upe && AiUserParamGetType(upe)==AI_TYPE_STRING )
		{
			out_value = AiNodeGetStr( in_node, in_name );
			return true;
		}
	}
	else
	{
		// We are assuming the parameter exists
		out_value = AiNodeGetStr( in_node, in_name );
		return true;
	}
	return false;
}

bool Procedural::getFloatArray( AtNode* in_node, const char* in_name, const float*& out_value, bool in_user  ) const
{
	bool bExists = !in_user;
	if( in_user )
	{
		const AtUserParamEntry* upe = AiNodeLookUpUserParameter(in_node, in_name );
		bExists = ( upe && AiUserParamGetType(upe)==AI_TYPE_ARRAY && AiUserParamGetArrayType(upe)==AI_TYPE_FLOAT );
	}

	if( bExists )
	{
		AtArray* a = AiNodeGetArray( in_node, in_name );
		if( a )
		{
			out_value = ((float*)a->data);
			return true;
		}
	}

	return false;
}

bool Procedural::getMatrixArray( AtNode* in_node, const char* in_name, const AtMatrix*& out_value, bool in_user  ) const
{
	bool bExists = !in_user;
	if( in_user )
	{
		const AtUserParamEntry* upe = AiNodeLookUpUserParameter(in_node, in_name );
		bExists = ( upe && AiUserParamGetType(upe)==AI_TYPE_ARRAY && AiUserParamGetArrayType(upe)==AI_TYPE_MATRIX );
	}

	if( bExists )
	{
		AtArray* a = AiNodeGetArray( in_node, in_name );
		if( a )
		{
			out_value = ((const AtMatrix*)a->data);
			return true;
		}
	}

	return false;
}

unsigned int Procedural::getArraySize( AtNode* in_node, const char* in_name, int in_eType, bool in_user  ) const
{
	if( in_user )
	{
		const AtUserParamEntry* upe = AiNodeLookUpUserParameter(in_node, in_name );
		if( upe && AiUserParamGetType(upe)==AI_TYPE_ARRAY && AiUserParamGetArrayType(upe)==in_eType )
		{
			AtArray* a = AiNodeGetArray( in_node, in_name );
			if( a )
				return a->nelements;
		}
	}
	else
	{
		AtArray* a = AiNodeGetArray( in_node, in_name );
		if( a )
			return a->nelements;
	}

	return 0;
}

const char* Procedural::get( EStringAttribute in_attr ) const
{
	static string result;
	const char* cstr = NULL;
    if( in_attr == BypassFXModulesAfterBGM )
    {
    	if( getString( m_node, "xgen_bypassFXModulesAfterBGM", cstr, true  ) )
    	{
    		return cstr;
    	}
	}

    else if( in_attr == CacheDir )
	{
		result = "xgenCache/";

		if( getString( m_node, "xgenCache", cstr, true  ) )
		{
			string tmp = cstr;
			if( tmp.size() )
			{
				result = tmp;
			}
		}
		return result.c_str();
	}
	else if( in_attr == Off )
	{
		if( getString( m_node, "xgen_OFF", cstr, true  ) )
		{
			if( stob( cstr ) )
			{
				//XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "Ribbox disabled XGen patch " + _patch->name() + " from rendering." );
				return "xgen_OFF";
			}
		}
	}
	else if( in_attr == Generator )
	{
		if( getString( m_options, "generator", cstr, true  ) )
			return cstr;
	}
	else if( in_attr == RenderCam )
	{
		if( getString( m_node, "irRenderCam", cstr, true  ) )
			return cstr;
	}
	else if( in_attr == RenderCamFOV )
	{
		if( getString( m_node, "irRenderCamFOV", cstr, true  ) )
			return cstr;
	}
	else if( in_attr == RenderCamXform )
	{
		if( getString( m_node, "irRenderCamXform", cstr, true  ) )
			return cstr;
	}
	else if( in_attr == RenderCamRatio )
	{
		if( getString( m_node, "irRenderCamRatio", cstr, true  ) )
			return cstr;
	}
	else if( in_attr == RenderMethod )
	{
		if( getString( m_node, "xgen_renderMethod", cstr, true  ) )
			return cstr;
	}
	else if( in_attr == Phase )
	{
		if( getString( m_options, "phase", cstr, true  ) )
			return cstr;
	}
	return "";
}

bool Procedural::get( EBoolAttribute in_attr ) const
{
	 if( in_attr == ClearDescriptionCache )
	 {
		 return false;
	 }

	 return false;
}

float Procedural::get( EFloatAttribute in_attr ) const
{
	float result=0.f;

    if( in_attr == ShadowMotionBlur )
    {
    	if( getFloat( m_node, "shadowMotionBlur", result, true ) )
			return result;
    }
    else if( in_attr == ShutterOffset )
    {
    	float shutter_start = 0.0f;
    	float shutter_end = 0.f;

    	getFloat( m_camera, "shutter_start", shutter_start, false );
    	getFloat( m_camera, "shutter_end", shutter_end, false );

    	float shutter_offset = shutter_start + 0.5*(shutter_end-shutter_start);
    	return shutter_offset;
    }

	return 0.f;
}

const float* Procedural::get( EFloatArrayAttribute in_attr) const
{
    const float* resultPtr=NULL;
    unsigned int uiArraySize = 0;

    if( in_attr==DensityFalloff )
    {
    	uiArraySize = getArraySize( m_node, "xgen_densityFalloff", AI_TYPE_FLOAT, true );
    	if( uiArraySize == 7 )
    	{
    		if( getFloatArray( m_node, "xgen_densityFalloff", resultPtr, true ) )
    			return resultPtr;
    	}
    }
    else if( in_attr==LodHi )
    {
    	uiArraySize = getArraySize( m_node, "xgen_lodHi", AI_TYPE_FLOAT, true );
    	if( uiArraySize == 2 )
    	{
    		if( getFloatArray( m_node, "xgen_lodHi", resultPtr, true ) )
    			return resultPtr;
    	}
    }
    else if( in_attr==LodLow )
    {
    	uiArraySize = getArraySize( m_node, "xgen_lodLo", AI_TYPE_FLOAT, true );
    	if( uiArraySize == 2 )
    	{
    		if( getFloatArray( m_node, "xgen_lodLo", resultPtr, true ) )
    			return resultPtr;
    	}
    }
    else if( in_attr==LodMed )
    {
    	uiArraySize = getArraySize( m_node, "xgen_lodMed", AI_TYPE_FLOAT, true );
    	if( uiArraySize == 2 )
    	{
    		if( getFloatArray( m_node, "xgen_lodMed", resultPtr, true ) )
    			return resultPtr;
    	}
    }
    else if( in_attr==Shutter )
    {
    	uiArraySize = getArraySize( m_camera, "time_samples", AI_TYPE_FLOAT, false );
    	if( getFloatArray( m_camera, "time_samples", resultPtr, false ) )
    		return resultPtr;
    }

	return NULL;
}

unsigned int Procedural::getSize( EFloatArrayAttribute in_attr )const
{
    if( in_attr==DensityFalloff )
    {
    	return getArraySize( m_node, "xgen_densityFalloff", AI_TYPE_FLOAT, true );
    }
    else if( in_attr==LodHi )
    {
    	return getArraySize( m_node, "xgen_lodHi", AI_TYPE_FLOAT, true );
    }
    else if( in_attr==LodLow )
    {
    	return getArraySize( m_node, "xgen_lodLo", AI_TYPE_FLOAT, true );
    }
    else if( in_attr==LodMed )
    {
    	return getArraySize( m_node, "xgen_lodMed", AI_TYPE_FLOAT, true );
    }
    else if( in_attr==Shutter )
    {
    	return getArraySize( m_camera, "time_samples", AI_TYPE_FLOAT, false );
    }

    return 0;
}

const char* Procedural::getOverride( const char* in_name )const
{
	const char* cstr = NULL;
	if( getString( m_node, in_name, cstr, true  ) && cstr!=NULL )
	{
		return cstr;
	}

	return "";
}

// Auto close the file descriptor.
class auto_fclose
{
public:
	auto_fclose( FILE* fd )
	{
		m_fd = fd;
	}

	~auto_fclose()
	{
		if(m_fd)
			fclose(m_fd);
	}
	FILE* m_fd;
};

bool Procedural::getArchiveBoundingBox( const char* in_filename, bbox& out_bbox )const
{
	std::string fname( in_filename );

    // Do not attempt to read non-RIB archives (e.g. .caf)
    if (XGDebugLevel >= 2)
        XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/ "Reading "+ fname);

    if (fname.find(".abc") == (fname.length()-4))
    {
    	out_bbox.xmin = -1.0;
    	out_bbox.ymin = -1.0;
    	out_bbox.zmin = -1.0;

    	out_bbox.xmax = 1.0;
    	out_bbox.ymax = 1.0;
    	out_bbox.zmax = 1.0;

        return true;
    }

    if (fname.find(".ass") == (fname.length()-4))
    {
		FILE *fd = fopen(in_filename, "rb");
		if (!fd) {
			if (XGDebugLevel >= 2)
				XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/ "Could not open "+ fname);
			return false;
		}

		// Use an auto_fclose since we are returning from the function all over the place.
		auto_fclose afd( fd );

		// Scan the first N lines searching for "## BBOX ...."
		const int limit = 13;
		const int inner_limit = 192;
		int matched;
		int count = 0;
		int inner_count = 0;

		while (count < limit) {
			count++;
			inner_count = 0;
			matched = fscanf(fd, "## BBOX %lf %lf %lf %lf %lf %lf",
							 &out_bbox.xmin, &out_bbox.xmax, &out_bbox.ymin, &out_bbox.ymax, &out_bbox.zmin, &out_bbox.zmax);

			if (matched == 0) {
				// Skip this line
				char c = fgetc(fd);
				if (/*EOF == c ||*/ feof(fd))
					return false;

				while (c != '\n') {
					c = fgetc(fd);
					// Guard against really long lines
					if (inner_limit <= inner_count++)
						break;
					if (/*EOF == c ||*/ feof(fd)) {
						if (XGDebugLevel >= 2)
							XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/ "EOF");
						return false;
					}
				}
				continue;
			}

			if (matched == 6) {
				if (XGDebugLevel >= 2)
					XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/
							"DRA BBOX" +
							std::string(" ") + std::to_string((long double)out_bbox.xmin) +
							std::string(" ") + std::to_string((long double)out_bbox.xmax) +
							std::string(" ") + std::to_string((long double)out_bbox.ymin) +
							std::string(" ") + std::to_string((long double)out_bbox.ymax) +
							std::string(" ") + std::to_string((long double)out_bbox.zmin) +
							std::string(" ") + std::to_string((long double)out_bbox.zmax));

				return true;
			}
			if (EOF == matched || feof(fd)) {
				if (XGDebugLevel >= 2)
					XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/ "EOF");
				break;
			}
		}
    }

    return false;
}

void Procedural::convertMatrix( const AtMatrix in_mat, mat44& out_mat )
{
	memcpy( &out_mat, in_mat, sizeof(float)*16 );
}

void Procedural::getTransform( float in_time, mat44& out_mat )const
{
	AtMatrix result;
	AiM4Identity( result );
	//AiArrayInterpolateMtx( AiNodeGetArray( m_node, "matrix" ), in_time, 0, result );

	convertMatrix( result, out_mat );
}

// Primitive cache get macro.
// To avoid writing PrimitiveCache:: for every get.
#define PC( x ) ( XGenRenderAPI::PrimitiveCache:: x )


/**
 * Emit the Arnold nodes for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void Procedural::flush(  const char* geomName, PrimitiveCache* pc )
{
	bool bIsSpline = pc->get( PC(PrimIsSpline) );
	const char* strPrimType = pc->get( PC(PrimitiveType) );

    if( bIsSpline )
    	flushSplines( geomName, pc );
    else if ( strcmp( strPrimType, "CardPrimitive" )==0 )
        flushCards( geomName, pc );
    else if ( strcmp( strPrimType, "SpherePrimitive" )==0 )
        flushSpheres( geomName, pc );
    else if ( strcmp( strPrimType, "ArchivePrimitive" )==0 )
        flushArchives( geomName, pc );
}

/**
 * Emit the Arnold nodes for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void Procedural::flushSplines( const char *geomName, PrimitiveCache* pc )
{
    bool bFaceCamera = pc->get( PC(FaceCamera) );

    unsigned int numSamples = pc->get( PC(NumMotionSamples) );
    //unsigned int shutterSize = pc->getSize( PC(Shutter) );
    //unsigned int cacheCount = pc->get( PC(CacheCount) );

    unsigned int pointsTotal = pc->getSize2( PC(Points), 0 );
    unsigned int numPointsTotal = pc->getSize2( PC(NumVertices), 0 );
    //unsigned int orientationsTotal = pc->getSize2( PC(Norms), 0 );
    unsigned int widthsSize = pc->getSize( PC(Widths) );

    AtArray* num_points = AiArrayAllocate( numPointsTotal, numSamples, AI_TYPE_UINT );
    AtArray* points = AiArrayAllocate( pointsTotal, numSamples, AI_TYPE_POINT );
    AtArray* radius = AiArrayAllocate( widthsSize>0 ? widthsSize : 1, 1, AI_TYPE_FLOAT );
    AtArray* orientations = bFaceCamera ? NULL : AiArrayAllocate( pointsTotal, numSamples, AI_TYPE_VECTOR );

    AtUInt* curNumPoints = (AtUInt*)num_points->data;
    AtPoint* curPoints = (AtPoint*)points->data;
    AtVector* curOrientations = orientations ? (AtVector*)orientations->data : NULL;
    AtFloat* curRadius = (AtFloat*)radius->data;

    // Add NumPoints
    for ( AtInt i=0; i < (AtInt)numSamples; i++ )
    {
        // Add the points.
        XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding points." );
        memcpy( curPoints, pc->get( PC(Points), i ), sizeof( AtPoint )*pointsTotal );
        curPoints+=pointsTotal;

        const vec3* pNorms = pc->get( PC(Norms), i );

        int* numVertsPtr = (int*)pc->get( PC(NumVertices), i );
        for( unsigned int j=0; j<pc->getSize2( PC(NumVertices), i ); ++j )
        {
        	*curNumPoints = (AtUInt)numVertsPtr[j];

        	// Add the normals if necessary.
			if( orientations )
			{
				XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding normals." );

				unsigned int numVarying = *curNumPoints - 2;

				memcpy( curOrientations, &pNorms[0], sizeof(AtVector) );
				curOrientations++;

				memcpy( curOrientations, pNorms, sizeof(AtVector)*numVarying );
				curOrientations+=numVarying;

				memcpy( curOrientations, &pNorms[numVarying-1], sizeof(AtVector) );
				curOrientations++;

				pNorms += numVarying;
			}

        	curNumPoints++;
        }

    }

    // Arnold crashes if the radius is too small.
    const AtFloat k_minRadius = 0.001;

    // Add the constant widths.
    if( widthsSize==0 )
	{
    	float constantWidth = pc->get( PC(ConstantWidth) );

		XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Constant width: " + ftoa(constantWidth));
		{string s = "Constant width: " + ftoa(constantWidth) + "\n";
		printf( s.c_str() );}
		*curRadius = constantWidth * 0.5f;
		if( *curRadius < k_minRadius )
			*curRadius = k_minRadius;
	}
    // Add Varying Widths
    else
	{
    	const float* pWidths = pc->get( PC(Widths) );

		XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Non-constant width.");
		for( unsigned int w=0; w<widthsSize; ++w )
		{
			curRadius[w] = pWidths[w] * 0.5f;
			if( curRadius[w] < k_minRadius )
				curRadius[w] = k_minRadius;
		}
	}

    char buf[512];

    AtNode* nodeCurves = AiNode("curves");
    string strParentName = AiNodeGetName( m_node_face );
	string strID = itoa( m_nodes.size() );
	AiNodeSetStr( nodeCurves, "name", getUniqueName(buf,( strParentName + string("_curves_") + strID).c_str()) );
	AiNodeSetStr( nodeCurves, "mode", bFaceCamera ? "ribbon" : "oriented");
    AiNodeSetStr( nodeCurves, "basis", "b-spline" );
    AiNodeSetInt( nodeCurves, "max_subdivs", 1000 );
    AiNodeSetArray( nodeCurves, "num_points", num_points );
    AiNodeSetArray( nodeCurves, "points", points );
	AiNodeSetArray( nodeCurves, "radius", radius );
	if( orientations ) AiNodeSetArray( nodeCurves, "orientations", orientations );
	AiNodeSetArray( nodeCurves, "shader", m_shaders ? AiArrayCopy(m_shaders) : NULL );

	// Add custom renderer parameters.
	pushCustomParams( nodeCurves, pc );

	// Keep our new nodes.
	m_nodes.push_back( nodeCurves );
}

/**
 * Emit the Arnold Sphere nodes for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void Procedural::flushSpheres( const char *geomName, PrimitiveCache* pc )
{
	string strParentName = AiNodeGetName( m_node_face );

	unsigned int cacheCount = pc->get( PC(CacheCount) );
	unsigned int numSamples = pc->get( PC(NumMotionSamples) );
	//unsigned int shutterSize = pc->getSize( PC(Shutter) );
	//float* shutter = (float*)pc->get( PC(Shutter) );

	bool normalParam = pc->get( PC(NormalParam) );
	bool flipParam = pc->get( PC(FlipParam) );

    for ( unsigned int j=0; j<cacheCount; j++ )
    {
    	AtArray* matrix = AiArrayAllocate( 1, numSamples, AI_TYPE_MATRIX );

        // Build up the token and parameter lists to output for all
        // passes of motionBlur.
        double length_[2];
        double width[2];
        double depth[2];
        vec3 P[2];
        vec3 lengthVec[2];
        vec3 axis1[2];
        double angle1[2];
        vec3 axis2[2];
        double angle2[2];
        vec3 zeroAxis = { 0.f, 0.f, 0.f };

        for ( unsigned int i=0; i < numSamples; i++ )
        {
            // Determine scaling values.
            int p0 = j*4; // Start of first point
            int p1 = j*4 + 1; // Start of second point
            int p2 = j*4 + 2; // Start of third point
            int p3 = j*4 + 3; // Start of fourth point

            const vec3* points_i = pc->get( PC(Points), i );

            P[i] = points_i[p0];
            vec3 lengthP( points_i[p1] );
            vec3 midP(( P[i] + lengthP )/2.0 );
            vec3 widthP( points_i[p2] );
            vec3 depthP( points_i[p3] );
            lengthVec[i] = lengthP - P[i];
            vec3 widthVec = widthP - midP;
            length_[i] = length(lengthVec[i]);
            width[i] = length(widthVec) * 2.0;
            depth[i] = length((depthP - midP)) * 2.0;

            // Determine axis and angle of rotation.
            vec3 yAxis = { 0.f, 1.f, 0.f };
            vec3 xAxis = { 1.f, 0.f, 0.f };
            vec3 xChange;

            axis1[i] = yAxis * lengthVec[i];
            if( normalize( axis1[i] ) > 0.0 ) {
                angle1[i] = angle( yAxis, lengthVec[i] );
                xChange = rotateBy( xAxis, axis1[i], angle1[i] );
            } else {
                angle1[i] = 0.0;
                axis1[i] = xAxis;
                xChange = xAxis;
            }
            axis2[i] = xChange * widthVec;
            if ( normalize( axis2[i] ) > 0.0 ) {
                angle2[i] = angle( xChange, widthVec );
                if ( dot( axis2[i], lengthVec[i] ) < 0.0 )
                    angle2[i] *= -1.0;
            } else {
                angle2[i] = 0.0;
            }
            axis2[i] = yAxis;

            // We want to make sure motion frames take the shortest
            // distance from an angular position.
            if ( i > 0 ) {
                if ( angle2[i] - angle2[i-1] > 3.14159 ) {
                    angle2[i] -= 6.28319;
                } else if ( angle2[i] - angle2[i-1] < -3.14159 ) {
                    angle2[i] += 6.28319;
                }
            }
        }

        // Now use these values to create the transforms for each motion
        // sample and put in a motion block

        mat44 xP[2], xN, tmp;

        for ( unsigned int i=0; i < numSamples; i++ ) {
            // Translation
            translation( tmp, P[i] + lengthVec[i] / 2.0 );
            xP[i] = tmp;
            
            // Rotation 1
            if ( axis1[i] != zeroAxis ) {
                rotation( tmp, axis1[i], angle1[i] );
                multiply( xP[i], xP[i], tmp );
                if ( normalParam && (i==0) )
                    xN = tmp;
            }
            
            // Rotation 2
            if ( axis2[i] != zeroAxis ) {
                rotation( tmp, axis2[i], angle2[i] );
                multiply( xP[i], xP[i], tmp );
                if ( normalParam && (i==0) )
                    multiply( xN, xN, tmp );
            }
            
            // Scale
			vec3 scaleV;
			scaleV.x = width[i];
			scaleV.y = length_[i];
			scaleV.z = depth[i];
			scale( tmp, scaleV );

            multiply( xP[i], xP[i], tmp );
            if ( flipParam ) {
                rotationX( tmp, degtorad(-90.0) );
            } else {
                rotationX( tmp, degtorad(90) );
            }
            multiply( xP[i], xP[i], tmp );
            if ( normalParam && (i==0) )
                multiply( xN, xN, tmp );
        }

        for ( unsigned int i=0; i < numSamples; i++ ) {
        	const float* xPi = &xP[i]._00;
            AtMatrix tmp = {{AtFloat(xPi[0]),AtFloat(xPi[1]),AtFloat(xPi[2]),AtFloat(xPi[3])},
                            {AtFloat(xPi[4]),AtFloat(xPi[5]),AtFloat(xPi[6]),AtFloat(xPi[7])},
                            {AtFloat(xPi[8]),AtFloat(xPi[9]),AtFloat(xPi[10]),AtFloat(xPi[11])},
                            {AtFloat(xPi[12]),AtFloat(xPi[13]),AtFloat(xPi[14]),AtFloat(xPi[15])}};

            AiArraySetMtx( matrix, i, tmp );
        }

        // Add custom parameters and call sphere.
        pc->inverseXformParams( j, xP[0], xN );

        string strID = itoa( m_nodes.size() );

        char buf[512];

        // and a geometry instance node.
        AtNode* nodeInstance = AiNode("ginstance");
    	AiNodeSetStr( nodeInstance, "name", getUniqueName(buf,( strParentName + string("_ginstance_") + strID).c_str()) );
    	AiNodeSetArray( nodeInstance, "matrix", matrix );
    	AiNodeSetPtr( nodeInstance, "node", (void*)m_sphere );
    	AiNodeSetArray( nodeInstance, "shader", m_shaders ? AiArrayCopy(m_shaders) : NULL );
    	AiNodeSetInt( nodeInstance, "visibility", 65535 );

    	// Add custom renderer parameters.
    	pushCustomParams( nodeInstance, pc );

    	// Keep our new nodes.
    	m_nodes.push_back( nodeInstance );
    }
}

/**
 * Emit the Arnold nodes for the cached primitives. This might be called
 * as primitives are emitted to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void Procedural::flushCards( const char *geomName, PrimitiveCache* pc )
{
	string strParentName = AiNodeGetName( m_node_face );

    AtArray* knots = AiArrayAllocate( 7, 1, AI_TYPE_FLOAT );
    AtFloat* pKnots = (AtFloat*)knots->data;
    pKnots[0] = 0;
    pKnots[1] = 0;
    pKnots[2] = 0;
    pKnots[3] = 2;
    pKnots[4] = 4;
    pKnots[5] = 4;
    pKnots[6] = 4;

    unsigned int cacheCount = pc->get( PC(CacheCount) );
    unsigned int numSamples = pc->get( PC(NumMotionSamples) );

    static bool s_bFirst = true;
    if( !s_bFirst )
    	return;
    s_bFirst = false;
    for ( unsigned int j=0; j<cacheCount; j++ ) {

		// Add the points.
		XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding points.");
		AtPoint* pointPtr = (AtPoint *)(void*)( &(pc->get( PC(Points), 0 )[j*16]) );


		AtArray* cvs = AiArrayAllocate( 16*3, numSamples, AI_TYPE_FLOAT );
		memcpy( cvs->data, pointPtr, sizeof(AtPoint)*16*numSamples );

		 string strID = itoa( m_nodes.size() );

		char buf[512];

		// and a geometry instance node.
		AtNode* nodeCard = AiNode( "nurbs" );
		AiNodeSetStr( nodeCard, "name", getUniqueName(buf,( strParentName + string("_nurbs_") + strID).c_str()));
		AiNodeSetArray( nodeCard, "shader", m_shaders ? AiArrayCopy(m_shaders) : NULL );

		AiNodeSetInt( nodeCard, "degree_u", 4 );
		AiNodeSetInt( nodeCard, "degree_v", 4 );
		AiNodeSetArray( nodeCard, "knots_u", AiArrayCopy( knots ) );
		AiNodeSetArray( nodeCard, "knots_v", AiArrayCopy( knots ) );
		AiNodeSetArray( nodeCard, "cvs", cvs );

		// Add custom renderer parameters.
    	pushCustomParams( nodeCard, pc );

		// Keep our new nodes.
		m_nodes.push_back( nodeCard );

    }

}

struct CustomParamTypeEntry
{
	string m_xgen;
	string m_arnold;
	size_t m_sizeOf;
	size_t m_components;
	AtByte m_type;
};

const static CustomParamTypeEntry g_mapCustomParamTypes[]=
{
	{ "uniform float ", 	"uniform FLOAT", 	sizeof(AtFloat), 	1, AI_TYPE_FLOAT },
	{ "uniform color ", 	"uniform RGB", 		sizeof(AtRGB), 		3, AI_TYPE_RGB },
	{ "uniform vector ", 	"uniform VECTOR", 	sizeof(AtVector), 	3, AI_TYPE_VECTOR },
	{ "uniform normal ", 	"uniform VECTOR", 	sizeof(AtVector), 	3, AI_TYPE_VECTOR },
	{ "uniform point ", 	"uniform POINT", 	sizeof(AtPoint), 	3, AI_TYPE_POINT },
};
const static size_t g_ulCustomParamTypesCount = sizeof(g_mapCustomParamTypes) / sizeof(CustomParamTypeEntry);

/**
 * Push the custom shader parameters into the tokens and params arrays. Shader
 * parameters are assumed to have ONE motion sample.
 *
 * @param i index into param array
 */
void Procedural::pushCustomParams( AtNode* in_node, PrimitiveCache* pc )
{
	unsigned int customAttrCount = pc->getSize( PC( CustomAttrNames ) );
	// Push any user-defined custom attributes.
	for ( unsigned int j = 0; j<customAttrCount; j++ ) {
		string attrName = pc->get( PC( CustomAttrNames ), j );
		const float* attrValue = pc->get( PC( CustomAttrValues ), j );
		unsigned int attrCount = pc->getSize2( PC( CustomAttrValues ), j );

		// See if the entry is an array and if so the number of elements
		int count = arrayindex( attrName );
		if ( count<1 ) count = 1;

		for( size_t i=0; i<g_ulCustomParamTypesCount; ++i )
		{
			const CustomParamTypeEntry& e = g_mapCustomParamTypes[i];
			if ( attrName.find( e.m_xgen ) != string::npos)
			{
				string fixedAttrName = attrName.substr( e.m_xgen.size() );
				unsigned int fixAttrCount = attrCount/e.m_components;

				AiNodeDeclare( in_node, fixedAttrName.c_str(), e.m_arnold.c_str() );
				AtArray* a = AiArrayAllocate( fixAttrCount, 1, e.m_type );
				memcpy( a->data, attrValue, e.m_sizeOf*fixAttrCount );
				AiNodeSetArray( in_node, fixedAttrName.c_str(), a );
				break;
			}
		}

    }
}

void Procedural::flushArchives( const char *geomName, PrimitiveCache* pc )
{
/*
    // DEBUG INFO
    {
        // Get num of archives
        unsigned int cacheCount = pc->get( PC(CacheCount) );
        unsigned int numSamples = pc->get( PC(NumMotionSamples) );
        double archiveSize = pc->get( PC(ArchiveSize) );
        unsigned int archivesCount = pc->getSize( PC(Archives) );
        unsigned int archivesAbsCount = pc->getSize( PC(ArchivesAbsolute) );

        char buf[1024];
        sprintf( buf, "Procedural::flushArchives: Patch(%s), \
            CacheCount(%d), MotionSamples(%d), \
            ArchiveSize(%f), ArchivesCount(%d), \
            AbsArchivesCount(%d)\n",
            geomName, cacheCount, numSamples,
            archiveSize, archivesCount, archivesAbsCount );
        std::cout << buf;

        // Get archive
        const char* archivesAbs = pc->get( PC(ArchivesAbsolute), 0 );
        std::cout << "Procedural::flushArchives: Archive: " << archivesAbs << "\n";
    }
*/



	// Default to 1.0 so that it has no effect for archive files that
	// do not contain BBOX information
	double bbox_scale = 1.0 / pc->get( PC(ArchiveSize) );

    unsigned int cacheCount = pc->get( PC(CacheCount) );
    unsigned int numSamples = pc->get( PC(NumMotionSamples) );


//    unsigned int shutterSize = pc->getSize( PC(Shutter) );
//	float* shutter = (float*)pc->get( PC(Shutter) );

	bool normalParam = pc->get( PC(NormalParam) );

	int lodLevels = pc->get( PC(LodLevels) );
//	const bool* useLevel = pc->get( PC(ArchiveUseLevel) );
//	const float* minVis = (const float*)&pc->get( PC(MinVis) ).x;
//	const float* maxVis = (const float*)&pc->get( PC(MaxVis) ).x;
//	const float* loTrans = (const float*)&pc->get( PC(LoTrans) ).x;
//	const float* upTrans = (const float*)&pc->get( PC(UpTrans) ).x;

	// Get archive name string pointers
	double archiveScale = pc->get( PC(ArchiveSize) );
	unsigned int archivesSize = pc->getSize( PC(Archives) );
	const char** archives = new const char*[archivesSize];
	const char** archivesAbsolute = new const char*[archivesSize];
	for ( unsigned int a = 0; a < archivesSize; a++ )
	{
		archives[a] = pc->get( PC(Archives), a );
		archivesAbsolute[a] = pc->get( PC(ArchivesAbsolute), a );
	}
	const double* archivesFrame = pc->get( PC(ArchivesFrame_XP) );


    for ( unsigned int j = 0; j < cacheCount; j++ ) {

        AtArray* matrix = AiArrayAllocate( 1, numSamples, AI_TYPE_MATRIX );

        // Build up the token and parameter lists to output for all
        // passes of motionBlur.
        double length_[2];
        double width[2];
        double depth[2];
        vec3 P[2];
        vec3 lengthVec[2];
        vec3 axis1[2];
        double angle1[2];
        vec3 axis2[2];
        double angle2[2];
        vec3 zeroAxis = { 0.f, 0.f, 0.f };

        for ( unsigned int i=0; i <numSamples; i++ )
        {
            // Determine scaling values.
            int p0 = j*4; // Start of first point
            int p1 = j*4 + 1; // Start of second point
            int p2 = j*4 + 2; // Start of third point
            int p3 = j*4 + 3; // Start of fourth point

            const vec3* points_i = pc->get( PC(Points), i );

            P[i] = points_i[p0];
            vec3 lengthP( points_i[p1] );
            vec3 midP(( P[i] + lengthP )/2.0 );
            vec3 widthP( points_i[p2] );
            vec3 depthP( points_i[p3] );
            lengthVec[i] = lengthP - P[i];
            vec3 widthVec = widthP - midP;
            length_[i] = length(lengthVec[i]);
            width[i] = length( widthVec ) * 2.0;
            depth[i] = length(depthP - midP)* 2.0;

            // Determine axis and angle of rotation.
            vec3 yAxis={ 0.0, 1.0, 0.0 };
            vec3 xAxis={ 1.0, 0.0, 0.0 };
            vec3 xChange;

            axis1[i] = yAxis * lengthVec[i];
            if ( normalize(axis1[i]) > 0.0 ) {
                angle1[i] = angle(yAxis, lengthVec[i] );
                xChange = rotateBy(xAxis, axis1[i], angle1[i] );
            } else {
                angle1[i] = 0.0;
                axis1[i] = xAxis;
                xChange = xAxis;
            }
            axis2[i] = xChange * widthVec;
            if ( normalize(axis2[i]) > 0.0 ) {
                angle2[i] = angle( xChange, widthVec );
                if ( dot( axis2[i], lengthVec[i] ) < 0.0 )
                    angle2[i] *= -1.0;
            } else {
                angle2[i] = 0.0;
            }
            axis2[i] = yAxis;


            // We want to make sure motion frames take the shortest
            // distance from an angular position.
            if ( i > 0 ) {
                if ( angle2[i] - angle2[i-1] > 3.14159 ) {
                    angle2[i] -= 6.28319;
                } else if ( angle2[i] - angle2[i-1] < -3.14159 ) {
                    angle2[i] += 6.28319;
                }
            }
        }

        // Now use these values to create the transforms for each motion
        // sample and put in a motion block

        mat44 xP[2], xN, tmp;
        AtInt jj=j*lodLevels*numSamples;

        for ( unsigned int i=0; i<numSamples; i++ ) {
            // Translation
            translation( tmp, P[i] );
            xP[i] = tmp;

            // Rotation 1
            if ( axis1[i] != zeroAxis ) {
                rotation( tmp, axis1[i], angle1[i] );
                multiply( xP[i], xP[i], tmp );
                if ( normalParam && (i==0))
                    xN = tmp;
            }

            // Rotation 2
            if ( axis2[i] != zeroAxis ) {
                rotation( tmp, axis2[i], angle2[i] );
                multiply( xP[i], xP[i], tmp );
                if ( normalParam && (i==0) )
                    multiply( xN, xN, tmp );
            }

            // Scale
            vec3 scaleV;
            scaleV.x = bbox_scale * width[i];
            scaleV.y = bbox_scale * length_[i];
            scaleV.z = bbox_scale * depth[i];
            scale( tmp, scaleV );
            multiply( xP[i], xP[i], tmp );

        }


/*
		// NOTE: Ported from renderMan procedural code and the following is not activated yet

        // Begin motion block if necessary.
        if ( numSamples > 1 ) {
            RiMotionBeginV( shutterSize, shutter );
            if ( (j==0) && (XGDebugLevel > 2) ) {
                string msg("MotionBegin [");
                for ( unsigned int i=0; i<shutterSize; i++ )
                    msg += ftoa(shutter[i]," %lf");
                msg += " ]";
                XGRenderAPIDebug(//msg::C|msg::RENDERER|,
                                msg);
            }
        }
*/

		string strParentName = AiNodeGetName( m_node_face );
		string strID = itoa(m_nodes.size());

		string instance_name = strParentName + string("_archive_") + strID;
		//std::cout << "Procedural::flushArchives: " << "Creating Instance: " << instance_name << "\n";


        for ( unsigned int i=0; i < numSamples; i++ ) {
        	float* xPi = &xP[i]._00;
            AtMatrix tmp = {{AtFloat(xPi[0]),AtFloat(xPi[1]),AtFloat(xPi[2]),AtFloat(xPi[3])},
                            {AtFloat(xPi[4]),AtFloat(xPi[5]),AtFloat(xPi[6]),AtFloat(xPi[7])},
                            {AtFloat(xPi[8]),AtFloat(xPi[9]),AtFloat(xPi[10]),AtFloat(xPi[11])},
                            {AtFloat(xPi[12]),AtFloat(xPi[13]),AtFloat(xPi[14]),AtFloat(xPi[15])}};
            AiArraySetMtx( matrix, i, tmp );

            //std::cout << "Procedural::flushArchives: Transform: " << instance_name << ": " << AtFloat(xPi[12])<< ": " <<AtFloat(xPi[13])<< ": " <<AtFloat(xPi[14])<< ": " <<AtFloat(xPi[15]) << "\n";
        }

/*
		// NOTE: Ported from renderMan procedural code and the following is not activated yet

        // End motion block if necessary.
        if ( numSamples > 1 ) {
            RiMotionEnd();
        }
*/

        // Add custom parameters.
        pc->inverseXformParams( j, xP[0], xN );

        // Get archive bbox
		bbox arcbox;
		if( !pc->getArchiveBoundingBox( archivesAbsolute[jj], arcbox ) )
		{
			std::cerr << "ERROR: XgArnoldProcedural: Unable to get asset information for " << archivesAbsolute[jj] << "\n";
			continue;
		}

		// Scale the bbox by the archive bbox
		arcbox.xmin *= archiveScale;
		arcbox.ymin *= archiveScale;
		arcbox.zmin *= archiveScale;
		arcbox.xmax *= archiveScale;
		arcbox.ymax *= archiveScale;
		arcbox.zmax *= archiveScale;


		AtNode* archive_procedural = getArchiveProceduralNode( archivesAbsolute[jj], instance_name.c_str(), arcbox, archivesFrame[j] );
		if ( archive_procedural )
		{
			AiNodeSetStr( archive_procedural, "name", instance_name.c_str() );
			AiNodeSetArray( archive_procedural, "matrix", matrix );
			AiNodeSetArray( archive_procedural, "shader", m_shaders ? AiArrayCopy(m_shaders) : NULL );

			// Add custom renderer parameters.
			pushCustomParams( archive_procedural, pc );

			m_nodes.push_back( archive_procedural );
		}

/*
		// NOTE: Ported from renderMan procedural code and the following is not activated yet

        std::vector<std::string> stringdata;
		std::vector<RtString> stringhandles;
		pushParams( stringdata, stringhandles, j, geomName, pc );
        RtToken *tokenPtr = &(_tokens[0]);
        RtPointer *paramPtr = &(_params[0]);
        RiAttributeV( const_cast<char*>("user"), _tokens.size(),
                      tokenPtr, paramPtr );


        // Start with the unit cube
        RtBound box = {-0.5, 0.5, 0.0, 1.0, -0.5, 0.5};
        int count = 0;

        // Accomodate DRA bboxes
        bool rib_bbox = false;


        // Find the largest LOD's bounding box
        for (RtInt k=0; k < 3; k++) {
            if ( useLevel[k] ) {

            	const char* filename = archivesAbsolute[jj+count];

                bbox arcbox;
                if( pc->getArchiveBoundingBox( filename, arcbox ) )
                {
					box[0] = std::min( box[0], (float)arcbox.xmin );
					box[1] = std::max( box[1], (float)arcbox.xmax );

					box[2] = std::min( box[2], (float)arcbox.ymin );
					box[3] = std::max( box[3], (float)arcbox.ymax );

					box[4] = std::min( box[4], (float)arcbox.zmin );
					box[5] = std::max( box[5], (float)arcbox.zmax );

                    rib_bbox = true;
                }
                count++;
            }
        }

        // Set a bounding box around all LODs
        if ( lodLevels > 1 ) {
            RiDetail(box);
        }

        count = 0;



        // hard-coded to 3 per the original code
        for ( RtInt i=0; i < 3; i++ ) {
            if ( useLevel[i] ) {
                if ( lodLevels > 1 ) {
                    RiDetailRange(minVis[i] * bbox_scale,
                                  loTrans[i] * bbox_scale,
                                  upTrans[i] * bbox_scale,
                                  maxVis[i] * bbox_scale);
                }

                // The user archive will be referenced into the rib through a
                // delayed read archive call. This will REQUIRE the user build
                // the archive within the -.5,.5,0,1,-.5,.5 cube
                // or provide an embedded "## BBOX ..." comment in the file.
                RtString *data=static_cast<RtString*>(malloc(sizeof(RtString)));
                data[0] = strdup(archives[jj+count]);

                RtBound procbox = {-0.5, 0.5, 0.0, 1.0, -0.5, 0.5};

                const char* filename = archivesAbsolute[jj+count];
                bbox arcbox;
                if( pc->getArchiveBoundingBox( filename, arcbox ) )
                {
                	// Convert to float RtBound
                	for( unsigned int bbi=0; bbi<6; ++bbi )
                		procbox[bbi] = (float)(((double*)&arcbox)[bbi]);
                }

                // Make archive call.
                RiProcedural(data, procbox, RiProcDelayedReadArchive, FreeStringData);
                count++;
            }
        }

        RiAttributeEnd();

        // Clear out tokens and params for next primitive.
        _tokens.clear();
        _params.clear();
*/
    }

    delete [] archives;
    delete [] archivesAbsolute;
}

// Get info from archive file and create procedural node
AtNode* Procedural::getArchiveProceduralNode( const char* file_name, const char* instance_name, const bbox& arcbox, double frame )
{
	// Assuming the archive is exported at 24fps
	frame /= 24.0;

	char strFrame[256];
	snprintf( strFrame, 255, "%lf", frame );

	// Get arnold info
	static string dso = string(getenv("MTOA_PATH")) + string("/procedurals/libAbcArnold.so");
	std::string dso_data;

	dso_data += string(" -filename ") + string(file_name);
	dso_data += string(" -nameprefix ") + string(instance_name);
	dso_data += string(" -frame ") + string(strFrame);
	dso_data += string(" -fps 24 ");
	dso_data += string(" -shutteropen 0.0 " );
	dso_data += string(" -shutterclose 0.0 " );
	dso_data += string(" -makeinstance ");

	// Return a procedural node
	AtNode* abcProc = AiNode("procedural");
	AiNodeSetStr( abcProc, "dso", dso.c_str() );
	AiNodeSetStr( abcProc, "data", dso_data.c_str() );
	AiNodeSetPnt( abcProc, "min", arcbox.xmin, arcbox.ymin, arcbox.zmin );
	AiNodeSetPnt( abcProc, "max", arcbox.xmax, arcbox.ymax, arcbox.zmax );

	return abcProc;
}

}

// Redirect Init/Cleanup/NumNodes/GetNode to our XGenArnoldProcedural class wrapped in the user data.
static int Init( AtNode* node, void** user_ptr )
{
	//AiMsgInfo("[xgArnoldProcedural] Init()");

	ProceduralWrapper* ud = (ProceduralWrapper*)AiNodeGetPtr( node, "userptr" );

	// Create a brand new one.
	if( ud==NULL )
	{
		ud = new ProceduralWrapper( new Procedural(), false /* Won't do cleanup */ );
		if( !ud )
			return 0;
	}

	*user_ptr = (void*)ud;

	return ud->Init( node );
}

// Cleanup
static int Cleanup( void* user_ptr )
{
	//AiMsgInfo("[xgArnoldProcedural] Cleanup()");

	ProceduralWrapper* ud = (ProceduralWrapper*)user_ptr;
	if( !ud )
		return 0;
	int ret = ud->Cleanup();
	delete ud;
	return ret;
}

// Get number of nodes
static int NumNodes( void* user_ptr )
{
	//AiMsgInfo("[xgArnoldProcedural] NumNodes()");

	ProceduralWrapper* ud = (ProceduralWrapper*)user_ptr;
	if( !ud )
		return 0;
	return ud->NumNodes();
}

// Get the i_th node
static AtNode* GetNode( void* user_ptr, int i )
{
	//AiMsgInfo("[xgArnoldProcedural] GetNode()");

	ProceduralWrapper* ud = (ProceduralWrapper*)user_ptr;
	if( !ud )
		return 0;
	return ud->GetNode(i);
}

// DSO hook
#ifdef __cplusplus
extern "C"
{
#endif

AI_EXPORT_LIB int ProcLoader(AtProcVtable *vtable)
{
	vtable->Init = Init;
	vtable->Cleanup = Cleanup;
	vtable->NumNodes = NumNodes;
	vtable->GetNode = GetNode;

	sprintf(vtable->version, AI_VERSION);
	return 1;
}

#ifdef __cplusplus
}
#endif

