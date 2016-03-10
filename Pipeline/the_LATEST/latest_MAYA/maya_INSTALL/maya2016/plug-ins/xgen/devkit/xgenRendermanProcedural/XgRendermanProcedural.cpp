// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <stdio.h>
#include <unistd.h>
#include <libgen.h>
#include <alloca.h>
#include <string.h>

#include <fstream>

#include <ri.h>
#include <rx.h>

#include <XGen/XgRenderAPIUtils.h>
#include "XgRendermanProcedural.h"

using namespace std;
using namespace XGenRenderAPI;
using namespace XGenRenderAPI::Utils;

#define XGDebug( y ) {}
#define XGError( x ) {}
#define XGDebugLevel 4

#define XGRenderAPIError XGError
#define XGRenderAPIWarning XGWarning
#define XGRenderAPIStats XGStats
#define XGRenderAPIDebug XGDebug

void RendermanCallbacks::log( const char* in_str )
{
	printf( in_str );
}

extern "C" RtVoid
FreeStringData(RtPointer data)
{
    RtString* sData = (RtString*) data;
    free( sData[0] );
    free( sData );
}

#define RXINFO_NOT_FLOAT_AND_INT (resulttype != RxInfoInteger && resulttype != RxInfoFloat)
#define RXINFO_FLOAT (resulttype == RxInfoFloat)

// Static data
std::vector<RtToken> RendermanCallbacks::_tokens;
std::vector<RtPointer> RendermanCallbacks::_params;

const char* RendermanCallbacks::get( EStringAttribute in_attr )const
{
	int resultcount=0, resultlen=sizeof(char*);
    RxInfoType_t resulttype;
    char* resultString=0;
    int status = 0;

    #define RXATTR( a ) (status = RxAttribute( a, &resultString, resultlen, &resulttype, &resultcount ))
	#define RXOPTION( o ) (status = RxOption( o, &resultString, resultlen, &resulttype, &resultcount ))

    static string result;

    if( in_attr == BypassFXModulesAfterBGM )
    {
		// Attribute bypassFXModulesAfterBGM
		if( !RXATTR( "user:xgen_bypassFXModulesAfterBGM" ) && RXINFO_NOT_FLOAT_AND_INT )
		{
			result = resultString;
			return result.c_str();
		}
	}

    else if( in_attr == CacheDir )
	{
		result = "xgenCache/";
		if( !RXATTR( "user:xgenCache" ) )
		{
			if( RXINFO_NOT_FLOAT_AND_INT )
			{
				result = validPath(resultString);
				XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "user:xgenCache: " + result );
			}
			else
				XGRenderAPIError("user:xgenCache has incorrect type.");
		}
		return result.c_str();
	}
	else if( in_attr == Off )
	{
		if( !RXATTR("user:xgen_OFF" ) && RXINFO_NOT_FLOAT_AND_INT )
		{
			result = resultString;
			if( stob( result ) )
			{
				XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "Ribbox disabled XGen patch " + _patch->name() + " from rendering." );
				return "xgen_OFF";
			}
		}
	}
	else if( in_attr == Generator )
	{
		result = "undefined";
		if ( !RXOPTION("user:generator") )
		{
			if( RXINFO_NOT_FLOAT_AND_INT )
			{
				result = string(resultString);
				XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "user:generator: " + result );
			}
			else
				XGRenderAPIError("user:generator has incorrect type.");
		}
		return result.c_str();
	}
	else if( in_attr == RenderCam )
	{
        if( !RXATTR("user:irRenderCam" ) )
        {
            result = resultString;
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|2,*/"Camera token: " + result);
            return result.c_str();
        }
        else
            XGRenderAPIError("No Camera attribute found in rib.");

	}
	else if( in_attr == RenderCamFOV )
	{
        if( !RXATTR("user:irRenderCamFOV") )
        {
            result = resultString;
            XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "Camera FOV token: " + result);
            return result .c_str();
        }
        else
            XGRenderAPIError("No Camera FOV attribute found in rib.");

	}
	else if( in_attr == RenderCamXform )
	{
		// Import the camera inverse Xform.
        if( !RXATTR("user:irRenderCamXform") )
        {
            result = resultString;
            XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "Camera Transform token: " + result);
            return result.c_str();
        }
        else
            XGRenderAPIError("No Camera Xform attribute found in rib.");
	}
	else if( in_attr == RenderCamRatio )
	{
		// Import the camera ratio
        if( !RXATTR("user:irRenderCamRatio") )
        {
            result = resultString;
            XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "Camera Ratio token: " + result);
            return result.c_str();
        }
        else
            XGRenderAPIError("No Camera Ratio attribute found in rib.");
	}
	else if( in_attr == RenderMethod )
	{
		if( !RXATTR("user:xgen_renderMethod") && RXINFO_NOT_FLOAT_AND_INT )
		{
			result = resultString;
			return result.c_str();
		}
	}
	else if( in_attr == Phase )
	{
		// Check the current render phase
        if( !RXOPTION("user:phase") )
        {
            if( RXINFO_NOT_FLOAT_AND_INT )
            {
            	result = resultString;
				XGRenderAPIDebug( /*msg::C|msg::RENDERER|2,*/ "user:phase: " + result);
				return result.c_str();
            }
            else
                XGRenderAPIError("user:phase has incorrect type.");
        }
	}
	return "";

	#undef RXATTR
	#undef RXOPTION
}

bool RendermanCallbacks::get( EBoolAttribute in_attr ) const
{
	 if( in_attr == ClearDescriptionCache )
	 {
		 return false;
	 }

	 return false;
}

float RendermanCallbacks::get( EFloatAttribute in_attr ) const
{
	int resultcount=0, resultlen=sizeof(float);
    RxInfoType_t resulttype;
    float resultFloat[1];
    int status = 0;

    #define RXATTR( a ) (status = RxAttribute( a, &resultFloat, resultlen, &resulttype, &resultcount ))
	#define RXOPTION( o ) (status = RxOption( o, &resultFloat, resultlen, &resulttype, &resultcount ))

    if( in_attr == ShadowMotionBlur )
    {
		// Determine if shadows should be motion blurred
		if ( !RXATTR("user:shadowMotionBlur") )
		{
			if( RXINFO_FLOAT )
				return resultFloat[0];
			else
				XGRenderAPIError("user:shadowMotionBlur has incorrect type.");
		}
    }
    else if( in_attr == ShutterOffset )
    {
    	if( !RXOPTION("shutter:offset") && RXINFO_FLOAT )
				return resultFloat[0];
    }

    #undef RXATTR
	#undef RXOPTION

	return 0.f;
}

const float* RendermanCallbacks::get( EFloatArrayAttribute in_attr) const
{
	int resultcount=0, resultlen=sizeof(float);
    RxInfoType_t resulttype;
    static float resultFloat[20];
    int status = 0;

    #define RXATTR( a,s ) (status = RxAttribute( a, &resultFloat, resultlen*s, &resulttype, &resultcount ))
	#define RXOPTION( o,s ) (status = RxOption( o, &resultFloat, resultlen*s, &resulttype, &resultcount ))


    if( in_attr==DensityFalloff )
    {
		if( !RXATTR("user:xgen_densityFalloff", 7) )
		{
			if( RXINFO_FLOAT )
			{
				if ( resultcount == 7 )
					return resultFloat;
				else
					XGRenderAPIError("User attribute xgen_densityFalloff has invalid size ("+itoa(resultcount)+"!=7).");
			}
			else
				XGRenderAPIError("User attribute xgen_densityFalloff has invalid type (float).");
		}
    }
    else if( in_attr==LodHi )
    {
		if ( !RXATTR("user:xgen_lodHi", 2) )
		{
			if( RXINFO_FLOAT )
			{
				if ( resultcount == 2 )
					return resultFloat;
				else
					XGRenderAPIError("User attribute xgen_lodHi has invalid size ("+itoa(resultcount)+"!=2).");
			}
			else
				XGRenderAPIError("User attribute xgen_lodHi has invalid type (float).");
		}

    }
    else if( in_attr==LodLow )
    {
		if( !RXATTR("user:xgen_lodLo", 2) )
		{
			if( RXINFO_FLOAT )
			{
				if( resultcount == 2 )
					return resultFloat;
				else
					XGRenderAPIError("User attribute xgen_lodLo has invalid size ("+itoa(resultcount)+"!=2).");
			}
			else
				XGRenderAPIError("User attribute xgen_lodLo has invalid type (float).");
		}

    }
    else if( in_attr==LodMed )
    {
		if( !RXATTR("user:xgen_lodMed", 2 ) )
		{
			if( RXINFO_FLOAT )
			{
				if( resultcount == 2 )
					return resultFloat;
				else
					XGRenderAPIError("User attribute xgen_lodMed has invalid size ("+itoa(resultcount)+"!=2).");
			}
			else
				XGRenderAPIError("User attribute xgen_lodMed has invalid type (float).");
		}

    }
    else if( in_attr==Shutter )
    {
    	RXOPTION("Ri:Shutter", 20);
    	return resultFloat;
    }

    #undef RXATTR
	#undef RXOPTION

	return NULL;
}

unsigned int RendermanCallbacks::getSize( EFloatArrayAttribute in_attr )const
{
	int resultcount=0, resultlen=sizeof(float);
    RxInfoType_t resulttype;
    static float resultFloat[20];
    int status = 0;

    #define RXATTR( a,s ) (status = RxAttribute( a, &resultFloat, resultlen*s, &resulttype, &resultcount ))
	#define RXOPTION( o,s ) (status = RxOption( o, &resultFloat, resultlen*s, &resulttype, &resultcount ))

    if( in_attr==DensityFalloff )
    {
		if( !RXATTR( "user:xgen_densityFalloff", 7 ) )
		{
			if( RXINFO_FLOAT )
			{
				if( resultcount == 7 )
					return resultcount;
				else
					XGRenderAPIError("User attribute xgen_densityFalloff has invalid size ("+itoa(resultcount)+"!=7).");
			}
			else
				XGRenderAPIError("User attribute xgen_densityFalloff has invalid type (float).");
		}
    }
    else if( in_attr==LodHi )
    {
		if( !RXATTR("user:xgen_lodHi", 2) )
		{
			if( RXINFO_FLOAT )
			{
				if( resultcount == 2 )
					return resultcount;
				else
					XGRenderAPIError("User attribute xgen_lodHi has invalid size ("+itoa(resultcount)+"!=2).");
			}
			else
				XGRenderAPIError("User attribute xgen_lodHi has invalid type (float).");
		}

    }
    else if( in_attr==LodLow )
    {
		if( !RXATTR("user:xgen_lodLo", 2 ) )
		{
			if( RXINFO_FLOAT )
			{
				if( resultcount == 2 )
					return resultcount;
				else
					XGRenderAPIError("User attribute xgen_lodLo has invalid size ("+itoa(resultcount)+"!=2).");
			}
			else
				XGRenderAPIError("User attribute xgen_lodLo has invalid type (float).");
		}

    }
    else if( in_attr==LodMed )
    {
		if( !RXATTR("user:xgen_lodMed", 2) )
		{
			if ( RXINFO_FLOAT )
			{
				if( resultcount == 2 )
					return resultcount;
				else
					XGRenderAPIError("User attribute xgen_lodMed has invalid size ("+itoa(resultcount)+"!=2).");
			}
			else
			{
				XGRenderAPIError("User attribute xgen_lodMed has invalid type (float).");
			}
		}

    }
    else if( in_attr==Shutter )
    {
    	RXOPTION("Ri:Shutter", 20);
    	return resultcount;
    }

    #undef RXATTR
	#undef RXOPTION

    return 0;
}

const char* RendermanCallbacks::getOverride( const char* in_name )const
{
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

bool RendermanCallbacks::getArchiveBoundingBox( const char* in_filename, bbox& out_bbox )const
{
	std::string fname( in_filename );

    // Do not attempt to read non-RIB archives (e.g. .caf)
    if (XGDebugLevel >= 2)
        XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/ "Reading "+ fname);

    if (fname.find(".rib") != (fname.length()-4)) {
        XGRenderAPIDebug(/*msg::C|msg::PRIMITIVE|2,*/ fname + " is not a .rib file");
        return false;
    }

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

    return false;
}

void RendermanCallbacks::getTransform( float in_time, mat44& out_mat )const
{
	RxTransform(const_cast<char*>("object"), const_cast<char*>("world"), in_time, *((RtMatrix*)&out_mat) );
}

// Primitive cache get macro.
// To avoid writing PrimitiveCache:: for every get.
#define PC( x ) ( XGenRenderAPI::PrimitiveCache:: x )


/**
 * Emit the renderman Ri calls for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void RendermanCallbacks::flush(  const char* geomName, PrimitiveCache* pc )
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
 * Emit the renderman Ri calls for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void RendermanCallbacks::flushSplines( const char *geomName, PrimitiveCache* pc )
{

    RtFloat *floatPtr;
    RtPoint *pointPtr;

    // Setup an attribute block for the prims.
    RiAttributeBegin();
    RiBasis( RiBSplineBasis, RI_BSPLINESTEP, RiBSplineBasis, RI_BSPLINESTEP );

    // If the spline isnt facing camera then we turn off raster
    // oriented dicing so that edge on primitives still supply
    // enough micropolygons for displacements, and to prevent them
    // from chattering.
    RtInt flag = 0;
    if ( !pc->get( PC(FaceCamera) ) ) {
        RiAttribute(const_cast<char*>("dice"),"rasterorient",
                    (RtPointer)&flag,RI_NULL);
    }


    unsigned int numSamples = pc->get( PC(NumMotionSamples) );
    unsigned int shutterSize = pc->getSize( PC(Shutter) );

    unsigned int cacheCount = pc->get( PC(CacheCount) );

    // Begin motion block if necessary.
    if ( numSamples > 1 ) {
    	float* shutter = (float*)pc->get( PC(Shutter) );
        RiMotionBeginV( shutterSize, shutter );
        if ( XGDebugLevel > 2 ) {
            string msg("MotionBegin [");
            for ( unsigned int i=0; i<shutterSize; i++ )
                msg += ftoa(shutter[i]," %lf");
            msg += " ]";
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|3,*/msg);
        }
    }


    for ( RtInt i=0; i < (RtInt)numSamples; i++ ) {
        // Add the points.
        XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding points." );
        pointPtr = (RtPoint *)( pc->get( PC(Points), i ) );
        push_back<RtToken>( _tokens,
                            const_cast<char*>("vertex point P") );
        push_back<RtPointer>( _params, (RtPointer)pointPtr );

        // Add the normals if necessary.
        if ( !pc->get( PC(FaceCamera) ) ) {
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding normals." );
            pointPtr = (RtPoint *)( pc->get( PC(Norms), i ) );
            push_back<RtToken>( _tokens,
                                const_cast<char*>("varying normal N") );
            push_back<RtPointer>( _params, (RtPointer)pointPtr );
        }

        unsigned int widthsSize = pc->getSize( PC(Widths) );

        // Add the widths.
        XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding widths." );
        if ( widthsSize > 0 ) {
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Non-constant width.");
            floatPtr = (float*)pc->get( PC(Widths) );
            push_back<RtToken>( _tokens,
                                const_cast<char*>("varying float width") );
            push_back<RtPointer>( _params, (RtPointer)floatPtr );
        } else {
        	float constantWidth = pc->get( PC(ConstantWidth) );
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Constant width: " +
                    ftoa(constantWidth));
            push_back<RtToken>( _tokens, RI_CONSTANTWIDTH );
            push_back<RtPointer>( _params,
                                  (RtPointer)&constantWidth );
        }

        // Add the shader parameters if necessary.
        // No need to do one for each motion sample since shader
        // parameters are referenced only once for a motion block.
        std::vector<std::string> stringdata;
        std::vector<RtString> stringhandles;
        pushParams( stringdata, stringhandles, 0, geomName, pc );

        // Make the actual RiCurvesV call, one for each
        // motion sample.
        RtToken *tokenPtr = &(_tokens[0]);
        RtPointer *paramPtr = &(_params[0]);

        XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Making RiCurvesV call: "+
                itoa(cacheCount) );

        RtInt* numVertsPtr = (RtInt*)pc->get( PC(NumVertices), i );
        RiCurvesV( RI_CUBIC, cacheCount, numVertsPtr,
                   RI_NONPERIODIC, _tokens.size(),
                   tokenPtr, paramPtr);

        // Clear out tokens and params for next primitive.
        _tokens.clear();
        _params.clear();
    }

    // End motion block if necessary.
    if ( numSamples > 1 )
        RiMotionEnd();

    RiAttributeEnd();
}


/**
 * Emit the renderman Ri calls for the cached primitives. This might be called
 * as primitives are emitted to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void RendermanCallbacks::flushCards( const char *geomName, PrimitiveCache* pc )
{
    RtPoint        *pointPtr;
    static RtFloat  knots[7] = {0, 0, 0, 0.5, 1, 1, 1};

    unsigned int cacheCount = pc->get( PC(CacheCount) );
    unsigned int numSamples = pc->get( PC(NumMotionSamples) );

    for ( unsigned int j=0; j<cacheCount; j++ ) {

        // Begin motion block if necessary.
        if ( numSamples > 1 ) {
        	unsigned int shutterSize = pc->getSize( PC(Shutter) );
        	float* shutter = (float*)pc->get( PC(Shutter) );
            RiMotionBeginV( shutterSize, shutter );
            if ( (j==0) && (XGDebugLevel > 2) ) {
                string msg("MotionBegin [");
                for ( unsigned int i=0; i<shutterSize; i++ )
                    msg += ftoa(shutter[i]," %lf");
                msg += " ]";
                XGRenderAPIDebug(/*msg::C|msg::RENDERER|3,*/msg);
            }
        }

        // Build up the token and parameter lists to output for all
        // passes of motionBlur.
        for ( unsigned int i=0; i < numSamples; i++ ) {

            // Add the points.
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Adding points.");
            pointPtr = (RtPoint *)(void*)( &(pc->get( PC(Points), i )[j*16]) );
            push_back<RtToken>( _tokens,
                                const_cast<char*>("vertex point P") );
            push_back<RtPointer>( _params, (RtPointer)pointPtr );

            // Add the shader parameters if necessary.
            // No need to do one for each motion sample since shader
            // parameters are referenced only once for a motion block.
            std::vector<std::string> stringdata;
            std::vector<RtString> stringhandles;
            pushParams( stringdata, stringhandles, j, geomName, pc );

            // Make the actual RiNuPatchV call, one for each motion sample.
            RtToken *tokenPtr = &(_tokens[0]);
            RtPointer *paramPtr = &(_params[0]);
            XGRenderAPIDebug(/*msg::C|msg::RENDERER|4,*/ "Making RiNuPatchV call.");
            RiNuPatchV(4, 3, knots, 0.0, 1.0,
                       4, 3, knots, 0.0, 1.0,
                       _tokens.size(), tokenPtr, paramPtr);

            // Clear out tokens and params for next primitive.
            _tokens.clear();
            _params.clear();
        }

        // End motion block if necessary.
        if ( numSamples > 1 ) {
            RiMotionEnd();
        }
    }

}


/**
 * Emit the renderman Ri calls for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void RendermanCallbacks::flushSpheres( const char *geomName, PrimitiveCache* pc )
{
	unsigned int cacheCount = pc->get( PC(CacheCount) );
	unsigned int numSamples = pc->get( PC(NumMotionSamples) );
	unsigned int shutterSize = pc->getSize( PC(Shutter) );
	float* shutter = (float*)pc->get( PC(Shutter) );

	bool normalParam = pc->get( PC(NormalParam) );
	bool flipParam = pc->get( PC(FlipParam) );

    for ( unsigned int j=0; j<cacheCount; j++ ) {

        RiTransformBegin();

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

        for ( unsigned int i=0; i < numSamples; i++ ) {
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

        // Begin motion block if necessary.
        if ( numSamples > 1 ) {
            RiMotionBeginV( shutterSize, shutter );
            if ( (j==0) && (XGDebugLevel > 2) ) {
                string msg("MotionBegin [");
                for ( unsigned int i=0; i<shutterSize; i++ )
                    msg += ftoa(shutter[i]," %lf");
                msg += " ]";
                XGRenderAPIDebug(/*msg::C|msg::RENDERER|3,*/msg);
            }
        }
        for ( unsigned int i=0; i < numSamples; i++ ) {
        	const float* xPi = &xP[i]._00;
            RtMatrix tmp = {{RtFloat(xPi[0]),RtFloat(xPi[1]),
                             RtFloat(xPi[2]),RtFloat(xPi[3])},
                            {RtFloat(xPi[4]),RtFloat(xPi[5]),
                             RtFloat(xPi[6]),RtFloat(xPi[7])},
                            {RtFloat(xPi[8]),RtFloat(xPi[9]),
                             RtFloat(xPi[10]),RtFloat(xPi[11])},
                            {RtFloat(xPi[12]),RtFloat(xPi[13]),
                             RtFloat(xPi[14]),RtFloat(xPi[15])}};
            RiConcatTransform(tmp);
        }
        // End motion block if necessary.
        if ( numSamples > 1 ) {
            RiMotionEnd();
        }

        // Add custom parameters and call sphere.
        pc->inverseXformParams( j, xP[0], xN );
        std::vector<std::string> stringdata;
		std::vector<RtString> stringhandles;
		pushParams( stringdata, stringhandles, j, geomName, pc );
        RtToken *tokenPtr = &(_tokens[0]);
        RtPointer *paramPtr = &(_params[0]);
        RiSphereV( 0.5, -0.5, 0.5, -360.0, _tokens.size(),
                   tokenPtr, paramPtr );

        RiTransformEnd();

        // Clear out tokens and params for next primitive.
        _tokens.clear();
        _params.clear();
    }
}


/**
 * Emit the renderman Ri calls for the cached primitives. This might be called
 * as primitives are emited to the renderer (to keep the size of the cache
 * down) or can be called from endPatch to flush the remaining cache.
 */
void RendermanCallbacks::flushArchives( const char *geomName, PrimitiveCache* pc )
{
	// Default to 1.0 so that it has no effect for archive files that
	// do not contain BBOX information
	double bbox_scale = 1.0 / pc->get( PC(ArchiveSize) );

    unsigned int cacheCount = pc->get( PC(CacheCount) );
    unsigned int numSamples = pc->get( PC(NumMotionSamples) );


    unsigned int shutterSize = pc->getSize( PC(Shutter) );
	float* shutter = (float*)pc->get( PC(Shutter) );

	bool normalParam = pc->get( PC(NormalParam) );

	int lodLevels = pc->get( PC(LodLevels) );
	const bool* useLevel = pc->get( PC(ArchiveUseLevel) );
	const float* minVis = (const float*)&pc->get( PC(MinVis) ).x;
	const float* maxVis = (const float*)&pc->get( PC(MaxVis) ).x;
	const float* loTrans = (const float*)&pc->get( PC(LoTrans) ).x;
	const float* upTrans = (const float*)&pc->get( PC(UpTrans) ).x;

	// Get archive name string pointers
	unsigned int archivesSize = pc->getSize( PC(Archives) );
	const char** archives = new const char*[archivesSize];
	const char** archivesAbsolute = new const char*[archivesSize];
	for ( unsigned int a = 0; a < archivesSize; a++ )
	{
		archives[a] = pc->get( PC(Archives), a );
		archivesAbsolute[a] = pc->get( PC(ArchivesAbsolute), a );
	}

    for ( unsigned int j = 0; j < cacheCount; j++ ) {
        RiAttributeBegin();

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

        for ( unsigned int i=0; i <numSamples; i++ ) {
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
        RtInt jj=j*lodLevels*numSamples;

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

        // If the positions are the same across the entire shutter then
        // skip emitting any motion blocks

        bool skip = _numSamples > 1;
        if (skip) {
        	for (int s = 1; s < _numSamples; s++) {
        		skip &= (nearby(xP[0][0], xP[s][0]) &&
        				nearby(xP[0][1], xP[s][1]) &&
        				nearby(xP[0][2], xP[s][2]) &&
        				nearby(xP[0][3], xP[s][3]) &&
        				nearby(xP[0][4], xP[s][4]) &&
        				nearby(xP[0][5], xP[s][5]) &&
        				nearby(xP[0][6], xP[s][6]) &&
        				nearby(xP[0][7], xP[s][7]) &&
        				nearby(xP[0][8], xP[s][8]) &&
        				nearby(xP[0][9], xP[s][9]) &&
        				nearby(xP[0][10], xP[s][10]) &&
        				nearby(xP[0][11], xP[s][11]) &&
        				nearby(xP[0][12], xP[s][12]) &&
        				nearby(xP[0][13], xP[s][13]) &&
        				nearby(xP[0][14], xP[s][14]) &&
        				nearby(xP[0][15], xP[s][15]));
        	}
        }

        if (skip && XGDebugLevel > 2) {
        	XGRenderAPIDebug(msg::C|msg::RENDERER|3,
        		"Transforms are identical: skipping motion blocks");
        }

        // Begin motion block if necessary.
        if ( !skip && _numSamples > 1 ) {
            RiMotionBeginV( shutterSize, shutter );
            if ( (j==0) && (XGDebugLevel > 2) ) {
                string msg("MotionBegin [");
                for ( unsigned int i=0; i<shutterSize; i++ )
                    msg += ftoa(shutter[i]," %lf");
                msg += " ]";
                XGRenderAPIDebug(/*msg::C|msg::RENDERER|,*/msg);
            }
        }
        for ( RtInt i=0; i < (skip ? 1 : _numSamples); i++ ) {
        	float* xPi = &xP[i]._00;
            RtMatrix tmp = {{RtFloat(xPi[0]),RtFloat(xPi[1]),
                             RtFloat(xPi[2]),RtFloat(xPi[3])},
                            {RtFloat(xPi[4]),RtFloat(xPi[5]),
                             RtFloat(xPi[6]),RtFloat(xPi[7])},
                            {RtFloat(xPi[8]),RtFloat(xPi[9]),
                             RtFloat(xPi[10]),RtFloat(xPi[11])},
                            {RtFloat(xPi[12]),RtFloat(xPi[13]),
                             RtFloat(xPi[14]),RtFloat(xPi[15])}};
            RiConcatTransform(tmp);
        }
        // End motion block if necessary.
        if ( !skip && _numSamples > 1 ) {
            RiMotionEnd();
        }

        // Add custom parameters.
        pc->inverseXformParams( j, xP[0], xN );
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
    }

    delete [] archives;
}

#define FLOAT_CONVERT_PTR RtFloat* ptr = &(((RtFloat*)pc->get( in_attr ))[i])
#define INT_CONVERT_PTR RtInt* ptr = &(((RtInt*)pc->get( in_attr ))[i])
#define VEC3_CONVERT_PTR RtPoint* ptr = &(((RtPoint*)pc->get( in_attr ))[i])

#define PUSHPARAM_IMPL( t, conv ) \
void RendermanCallbacks:: PUSHPARAM_DECL( t ) \
{ \
	if ( pc->get( in_add ) ) \
	{ \
        XGDebug( /*msg::C|msg::RENDERER|4,*/ in_message ); \
        conv; \
        stringdata.push_back( in_shader_parameter ); \
        push_back<RtToken>( _tokens, const_cast<char*>( const_cast<char*>(stringdata[stringdata.size()-1].c_str()) ) ); \
        push_back<RtPointer>( _params, (RtPointer)ptr ); \
    } \
}
PUSHPARAM_IMPL( EFloatArrayAttribute, FLOAT_CONVERT_PTR )
PUSHPARAM_IMPL( EIntArrayAttribute, INT_CONVERT_PTR )
PUSHPARAM_IMPL( EVec3ArrayAttribute, VEC3_CONVERT_PTR )

/**
 * Push the shader parameters into the tokens and params arrays. Shader
 * parameters are assumed to have ONE motion sample.
 *
 * @param i index into param array
 * @param patch the patch for which parameters are being pushed
 */
void RendermanCallbacks::pushParams( std::vector<std::string>& stringdata, std::vector<RtString>& stringhandles, int i, const char *geomName, PrimitiveCache* pc )
{
    bool primIsSpline = pc->get( PC( PrimIsSpline ) );
    bool primIsArchive = pc->get( PC( PrimIsArchive ) );

    std::string strPrefix = primIsSpline ? "uniform " : "constant ";

    // Simplify the calling of push_param for each type.
	#define PUSH_FLOAT( add, attr, name ) pushParam( stringdata, i, pc, PC( add ),  PC( attr ), (strPrefix + "float " name ).c_str(), "Adding " name "." )
    #define PUSH_INT( add, attr, name ) pushParam( stringdata, i, pc, PC( add ), PC( attr ), (strPrefix + "int " name ).c_str(), "Adding " name "." )
    #define PUSH_VECTOR( add, attr, name ) pushParam( stringdata, i, pc, PC( add ), PC( attr ), (strPrefix + "vector " name ).c_str(), "Adding " name "." )
    #define PUSH_NORMAL( add, attr, name ) pushParam( stringdata, i, pc, PC( add ), PC( attr ), (strPrefix + "normal " name ).c_str(), "Adding " name "." )
    #define PUSH_POINT( add, attr, name ) pushParam( stringdata, i, pc, PC( add ), PC( attr ), (strPrefix + "point " name ).c_str(), "Adding " name "." )

    PUSH_FLOAT( Add_Length, Length_XP, "length_XP" );
    PUSH_FLOAT( Add_Width, Width_XP, "width_XP" );
    PUSH_INT( Add_PrimitiveID, PrimitiveID_XP, "id_XP" );
    PUSH_INT( Add_DescID, DescID_XP, "descid_XP" );
    PUSH_INT( Add_RandomInt, RandomInt_XP, "ri_XP" );
    PUSH_FLOAT( Add_RandomFloat, RandomFloat_XP, "rf_XP" );
    PUSH_VECTOR( Add_T, T_XP, "T_XP" );
    PUSH_INT( Add_Stray, Stray_XP, "stray_XP" );
    PUSH_FLOAT( Add_U, U_XS, "u_XS" );
    PUSH_FLOAT( Add_V, V_XS, "v_XS" );
    PUSH_INT( Add_FaceID, FaceID_XS, "faceid_XS" );
    PUSH_INT( Add_GeomID, GeomID_XS, "geomid_XS" );

    PUSH_POINT( Add_P, P_XS, "P_XS" );
    PUSH_POINT( Add_Pref, Pref_XS, "Pref_XS" );
    PUSH_POINT( Add_Pg, Pg_XS, "Pg_XS" );
    PUSH_POINT( Add_Prefg, Prefg_XS, "Prefg_XS" );

    PUSH_NORMAL( Add_N, N_XS, "P_XS" );
    PUSH_NORMAL( Add_Nref, Nref_XS, "Nref_XS" );
    PUSH_NORMAL( Add_Ng, Ng_XS, "Ng_XS" );
    PUSH_NORMAL( Add_Nrefg, Nrefg_XS, "Nrefg_XS" );

    PUSH_VECTOR( Add_dPdu, dPdu_XS, "dPdu_XS" );
    PUSH_VECTOR( Add_dPdv, dPdv_XS, "dPdv_XS" );
    PUSH_VECTOR( Add_dPduref, dPduref_XS, "dPduref_XS" );
    PUSH_VECTOR( Add_dPdvref, dPdvref_XS, "dPdvref_XS" );
    PUSH_VECTOR( Add_dPdug, dPdug_XS, "dPdug_XS" );
    PUSH_VECTOR( Add_dPdvg, dPdvg_XS, "dPdvg_XS" );
    PUSH_VECTOR( Add_dPdurefg, dPdurefg_XS, "dPdurefg_XS" );
    PUSH_VECTOR( Add_dPdvrefg, dPdvrefg_XS, "dPdvrefg_XS" );

	#undef PUSH_FLOAT
    #undef PUSH_INT
    #undef PUSH_VECTOR
    #undef PUSH_NORMAL
    #undef PUSH_POINT

    // GeomName comes directly from the argument
    if ( pc->get( PC( Add_GeomName ) ) )
	{
        XGDebug( /*msg::C|msg::RENDERER|4,*/ "Adding geomName." );

        stringdata.push_back( primIsArchive ? "uniform string geomName_XS" : "constant string geomName_XS" );
        push_back<RtToken>( _tokens, const_cast<char*>(stringdata[stringdata.size()-1].c_str()) );

        stringdata.push_back( geomName );
        stringhandles.push_back( const_cast<char*>(stringdata[stringdata.size()-1].c_str()) );
		push_back<RtPointer>( _params, (RtPointer)&stringhandles[stringhandles.size()-1] );
    }

    // We only push out cv attrs all at once. Otherwise we will need
    // to track the number of points in each vector, which we don't
    // except for splines. In the future maybe this can be expanded
    // but currently (2/9/5) there are only cv attrs on spline anyway
    // and they always go out in a single pushParam call.
    if ( i == 0 )
    {
    	unsigned int cvAttrsSize = pc->getSize( PC( CVAttrNames ) );

    	RtPoint *pointPtr = NULL;

    	for( unsigned int a=0; a<cvAttrsSize; ++a )
    	{
    		const char* cvAttrsName_a = pc->get( PC( CVAttrNames ), a );
    		const float* cvAttrsValues_a = pc->get( PC( CVAttrValues ), a );

    		push_back<RtToken>( _tokens, (char *)(cvAttrsName_a) );
            pointPtr = (RtPoint *)( cvAttrsValues_a );
            push_back<RtPointer>( _params, (RtPointer)pointPtr );
    	}
    }

    // Push any user-defined custom attributes.
    pushCustomParams( i, pc );
}

/**
 * Push the custom shader parameters into the tokens and params arrays. Shader
 * parameters are assumed to have ONE motion sample.
 *
 * @param i index into param array
 */
void RendermanCallbacks::pushCustomParams( int i, PrimitiveCache* pc )
{
	RtFloat *floatPtr = NULL;
    RtPoint *pointPtr = NULL;

    unsigned int customAttrCount = pc->getSize( PC( CustomAttrNames ) );
    // Push any user-defined custom attributes.
    for ( unsigned int j = 0; j<customAttrCount; j++ ) {

    	string attrName = pc->get( PC( CustomAttrNames ), j );
    	const float* attrValue = pc->get( PC( CustomAttrValues ), j );

        // See if the entry is an array and if so the number of elements
        int count = arrayindex( attrName );
        if ( count<1 ) count = 1;

        // Push out the token
        XGDebug( /*msg::C|msg::RENDERER|4,*/ "Adding " + attrName );
        push_back<RtToken>( _tokens, (char *)attrName.c_str() );

        // Push out the data. If the expression is a float then we push out
        // a single value, otherwise we push out three values.
        if ( attrName.find(" float ") != string::npos ||
             attrName.find(" float[") != string::npos ) {
            floatPtr = (RtFloat*)&(attrValue[i*count]);
            push_back<RtPointer>( _params, (RtPointer)floatPtr );
        } else {
            pointPtr = (RtPoint *)( &(attrValue[i*count*3]) );
            push_back<RtPointer>( _params, (RtPointer)pointPtr );
        }
    }
}

/* Mutex to prevent multiple thread access to XGen data. */
pthread_mutex_t  xgMutex = PTHREAD_MUTEX_INITIALIZER;

/**
 * Convert the passed in string parameters to useable data.
 * Import the specified file(s) and create a new palette, storing all of
 * the descriptions in a static description manager from which they can
 * later be retrieved.
 */
RtPointer
ConvertParameters( RtString paramstr )
{
    pthread_mutex_lock( &xgMutex );
    string parameters( paramstr );

    // This is where we link our callbacks to the PatchRenderer.
    static RendermanCallbacks s_callbacks;
    PatchRenderer* patch = PatchRenderer::init( (ProceduralCallbacks*)&s_callbacks, parameters.c_str() );

    RendermanUserData* ptr = new RendermanUserData( patch, NULL );

    pthread_mutex_unlock( &xgMutex );
    return ptr;
}


/**
 * Cast the pointer so that it can be deleted.
 */
RtVoid
Free( RtPointer d )
{
    if ( d ) {
        pthread_mutex_lock( &xgMutex );
        delete (RendermanUserData *)d;
        d = 0;
        pthread_mutex_unlock( &xgMutex );
    }
}

/**
 * If this procedural is at the patch level subdivide it into a collection
 * of per face procedurals. If it is one of the face level procedurals we
 * can go ahead and render that face.
 */
RtVoid
Subdivide( RtPointer d, RtFloat detail )
{
    if ( d ) {
        pthread_mutex_lock( &xgMutex );
        RendermanUserData* ud = (RendermanUserData *)d;

        // Patch case, call RiProcedural for each face
        if( ud->m_patch )
        {
			bbox b;
			unsigned int f = -1;
			while( ud->m_patch->nextFace( b, f ) )
			{
				// Skip camera culled bounding boxes.
				if( isEmpty( b ) )
					continue;

				RtBound bounds = { 	(RtFloat)b.xmin, (RtFloat)b.xmax,
									(RtFloat)b.ymin, (RtFloat)b.ymax,
									(RtFloat)b.zmin, (RtFloat)b.zmax };

				FaceRenderer* face = FaceRenderer::init( ud->m_patch, f );

				RendermanUserData* rp = new RendermanUserData( NULL, face );
				RiProcedural((RtPointer)rp, bounds, Subdivide, Free);
			}
        }
        // Face case, call render
        else if( ud->m_face )
        {
        	ud->m_face->render();
        }

        pthread_mutex_unlock( &xgMutex );
    }
}
