// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgUtil.h
 * @brief Contains the declaration of various utility functions.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Ernie Petti
 * @author Thomas V Thompson II
 * @author Stephen D. Bowline
 * @author Ying Liu
 * @author Kelly Ward
 *
 * @version Created 06/12/02
 */

#ifndef XGUTIL_H
#define XGUTIL_H

#include <string>
#include <algorithm>
#ifdef OSWin_
    #define _USE_MATH_DEFINES
    #define WIN32_LEAN_AND_MEAN
#endif
#include <math.h>
#ifndef OSWin_
    #include <sys/time.h>
#endif
#include <istream>
#include <ostream>
#include <sstream>
#include <stdint.h>

#include "XgPorting/safevector.h"
#include "XGen/XgDict.h"
#include "XGen/SgXform3T.h"
#include "XGen/SgVec3T.h"
#include "XgWinExport.h"

#ifdef OSWin_
    #define round(x)    ((x) > 0 ? ::floor((x) + 0.5) : -::floor(0.5 - (x)))
#endif

#define DEFAULT_EXPR_VALUE(x,y) y

class XgDescription;
class XgPatch;
class MdTriangleMesh;
class MdBoundingTree;
class XgGuide;
class XgObject;

#define kDblQteChar     "\""
#define kSpaceChar      " "
#define kWrapString     "\n\t\t"

typedef int (*addCategoryFuncPtr)(const char*);
typedef int (*eventBeginFuncPtr)(int, int, const char*, const char*);
typedef void (*eventEndFuncPtr)(int);

namespace xgutil
{
    class XGEN_EXPORT XgMessage
    {
    public:
        XgMessage() {}
        virtual ~XgMessage() {}

        /* Log a message */
        virtual void log( const unsigned int  descriptor,
                          const char *srcFile,
                          const int lineNumber,
                          const std::string &message );

        virtual std::string typeName() const { return "shell"; }
	
	virtual std::string getLocalized(const std::string &name,
					 const std::string &arg1="",
					 const std::string &arg2="",
					 const std::string &arg3="",
					 const std::string &arg4="",
					 const std::string &arg5="",
					 const std::string &arg6="",
					 const std::string &arg7="",
					 const std::string &arg8="",
					 const std::string &arg9="",
					 const std::string &arg10="")
	  { return ""; }
    };

    class XGEN_EXPORT XgProfiler
    {
    public:
        static addCategoryFuncPtr addCategoryFunc;
        static eventBeginFuncPtr eventBeginFunc;
        static eventEndFuncPtr eventEndFunc;
        static int sXGenCategory;
    private:
        XgProfiler();
        ~XgProfiler();
    };

    // A pseudo-random number generator.
    // The implementation is boost::random::mt19937 but I prefer to keep
    // it opaque here.
    class XGEN_EXPORT PRNG {
    public:
        PRNG();
        PRNG(uint64_t seed);
        PRNG(double seed);
        ~PRNG();

        double random01();

    private:
		PRNG( const PRNG& );
		const PRNG& operator=( const PRNG& );

        void *_generator;
    };
    
        
    /*  Bit field categories and message types */
    namespace msg
    {
        const unsigned int  msgERROR     = 0x01000000;
        const unsigned int  msgWARNING   = 0x02000000;
        const unsigned int  msgSTAT      = 0x04000000;
        const unsigned int  msgXgDEBUG   = 0x08000000;
        const unsigned int  msgTIP	     = 0x10000000;

        const unsigned int  C            = 0x00010000;
        const unsigned int  MAYA         = 0x00020000;
        const unsigned int  PIPE         = 0x00040000;
        const unsigned int  MFA          = 0x00080000;

        const unsigned int  RENDERER     = 0x00000010;
        const unsigned int  GENERATOR    = 0x00000020;
        const unsigned int  PRIMITIVE    = 0x00000040;
        const unsigned int  PALETTE      = 0x00000080;
        const unsigned int  DESCRIPTION  = 0x00000100;
        const unsigned int  PATCH        = 0x00000200;
        const unsigned int  GUIDE        = 0x00000400;
        const unsigned int  EXPRESSION   = 0x00000800;
        const unsigned int  FX           = 0x00001000;
        const unsigned int  IO           = 0x00002000;

        const unsigned int  maskALL      = 0xFFFFFFF0;
        const unsigned int  maskTYPE     = 0xFF000000;
        const unsigned int  maskSIDE     = 0x00FF0000;
        const unsigned int  maskMODULE   = 0x0000FFF0;
        const unsigned int  maskLEVEL    = 0x0000000F;

        /** The singleton instance of the message GUI. */
        extern XgDict<XgMessage *> _log;

		extern XGEN_EXPORT void clearLogger( );

        /* Add a message logger. */
        extern XGEN_EXPORT void addLogger( XgMessage *lgr=0 );

		extern XGEN_EXPORT void eraseLogger( XgMessage *lgr );

    }

    /** Functor for less than operation on char* to be used in sorted maps. */
    struct ltstr
    {
        bool operator()(const char* s1, const char* s2) const
            {
                return strcmp(s1, s2) < 0;
            }
    };

    /* Methods to convert numbers into strings. */
    extern XGEN_EXPORT std::string itoa( int num, const char *frmt = 0 );
    extern XGEN_EXPORT std::string ftoa( double num, const char *frmt = 0 );
    extern XGEN_EXPORT std::string btoa( bool val, const char *frmt = 0 );
    extern XGEN_EXPORT std::string vtoa( const SgVec3d &val, const char *frmt = 0 );

    /* Methods to converts strings into numbers. */
    extern XGEN_EXPORT bool  stob( const std::string &bstr );
    extern XGEN_EXPORT bool  stox( const std::string &xstr, SgXform &res, int frame = 1 );
    extern XGEN_EXPORT bool  stov( const std::string &vstr, SgVec3d &res );
    extern XGEN_EXPORT bool  stovs( const std::string &vstr, safevector<SgVec3d> &res,
                                    const bool append=false );
    extern XGEN_EXPORT bool  stovvs( const std::string &estr,
                                     safevector< safevector<SgVec3d> > &res );
    extern XGEN_EXPORT bool  stovvs( const std::string &estr, 
                                     safevector< safevector<double> > &res );
    extern XGEN_EXPORT bool  stofs( const std::string &estr, safevector<double> &res,
                                    const bool append=false );

    extern XGEN_EXPORT std::string checkFrameArray( const std::string &frameArrayStr,
                                                    int frame );

    /* Simple tokenizer */
    extern XGEN_EXPORT bool  stoss( const std::string &str,
                                    safevector< std::string > &res,
                                    const std::string &token="," );

    /* Method to replace a substring in a string to another string */
    extern XGEN_EXPORT void replaceSubStrs( std::string &baseStr, 
                                    const std::string &oldStr,
                                    const std::string &newStr);

    /* Prep a string with encoded control characters for an editor. */
    extern XGEN_EXPORT std::string prepForEditor( const std::string &inStr );

    /* Prep a string control characters for an attribute by encoding. */
    extern XGEN_EXPORT std::string prepForAttribute( const std::string &inStr );
    
    /* Get the XGen root directory. */
    extern XGEN_EXPORT std::string rootDir();

    /* Get the XGen icon directory. */
    extern XGEN_EXPORT std::string iconDir();

    /* Get the system temp path (ex: /tmp/). Always ends with a slash */
    extern XGEN_EXPORT std::string tempDir();

    /* Get the XGen version. */
    extern XGEN_EXPORT std::string version();
    
    /* Triangulate quad mesh in place*/
    extern XGEN_EXPORT void triangulate( const safevector<unsigned int> &faces,
                                         safevector<unsigned int> &triangles );

    /* Angle conversion functions. */
    inline XGEN_EXPORT double degtorad( double deg ) { return deg * (M_PI/180); }
    inline XGEN_EXPORT double radtodeg( double rad ) { return rad * (180/M_PI); }

    /* Step function. */
    extern XGEN_EXPORT double boxstep(double x, double a);
    extern XGEN_EXPORT double linearstep(double x, double a, double b);
    extern XGEN_EXPORT double smoothstep(double x, double a, double b);
    extern XGEN_EXPORT double gaussstep(double x, double a, double b);
    
    /* Timing functions. */
#ifdef OSWin_
    typedef __int64 TimerVal;
#else
    typedef struct timeval TimerVal;
#endif
    extern XGEN_EXPORT void beginTiming( TimerVal &time );
	extern XGEN_EXPORT void endTiming( TimerVal &time, std::string &res );

    /* Memory usage method. */
    extern XGEN_EXPORT long memUsage();
    
    /* Noise methods. */
    extern XGEN_EXPORT double noise( double t );
    extern XGEN_EXPORT double noise( double x, double y );
    extern XGEN_EXPORT double noise( double x, double y, double z );

    /* Scaled noise function. Return noise in [-1, 1] */
    extern XGEN_EXPORT double snoise( double x, double y, double z );

    /* Periodic noise functions. */
    extern XGEN_EXPORT double pnoise( double x, double y, double z, int period );

    /* Looping noise functions. */
    extern XGEN_EXPORT double loopingNoise( double x, double y, double z, double t );

    /* Minimum point-to-segment distance. */
    extern XGEN_EXPORT double pointToSegmentDistance( const SgVec3d &p,
                                                      const SgVec3d &origin,
                                                      const SgVec3d &direction,
                                                      double extent,
                                                      SgVec3d &closestPt );

    /* Minimum point-to-line distance. */
    extern XGEN_EXPORT double pointToLineDistance( const SgVec3d &p,
                                                   const SgVec3d &origin,
                                                   const SgVec3d &direction );
    
    /* String parsing an array index. */
    extern XGEN_EXPORT int arrayindex( const std::string &token );

    /* Extract a string from its surrounding whitespace. */
    extern XGEN_EXPORT std::string stripWhitespace( const std::string &token,
                                                    const bool stripQuotes=false );


    /* Safe get Line from file, in order to better handle EOL issue for different platforms*/
    extern XGEN_EXPORT std::istream& safeGetline(std::istream& is, std::string& t);

    /** Bound values between two end-points. */
    template <class Type>
    inline Type bound( Type lo, Type hi, Type x )
    { return std::max( lo, std::min( x, hi ) ); }

    /** Grow a vector by a given percent during a push_back */
    template <class Type>
    inline void push_back( safevector< Type > &vec, const Type &elem,
                           float percent=0.5, int minGrowth=10,
                           int maxGrowth=2500 )
    {   // If there is no more room then grow by given percentage
        size_t size = vec.size();
        if ( size == vec.capacity() ) {
            int incr = int(size * percent);
            incr = bound( minGrowth, maxGrowth, incr );
            vec.reserve( size+incr );
        }
        vec.push_back( elem ); }
    
    /** Round to five significant digits. */
    inline double round5( double val )
    { return round( val * 100000.0 ) / 100000.0; }

    /** Round to two significant digits. */
    inline double round2( double val )
    { return round( val * 100.0 ) / 100.0; }

    /* Get the object name from a Maya scenegraph full path name. */
    extern XGEN_EXPORT std::string sgObjName( const std::string &fullname );

    /* Convert a transform name into a shape name. */
    extern XGEN_EXPORT std::string sgXformToShape( const std::string &fullname,
                                                   bool hardWay = false );

    /* Hash a string into an unsigned int via the PJ Weiberger algorithm */
    extern XGEN_EXPORT unsigned int hashString( const std::string &str );

    /* Find 2D coordinates for a 3D vector in terms of two 3D vectors */
    extern XGEN_EXPORT void cramersConversion( const SgVec3d &v1, const SgVec3d &v2, 
                                               const SgVec3d &v3, double &u, double &v );

    /* Change the coordinate frame for a vector of points. */
    extern XGEN_EXPORT safevector<SgVec3d> changeFrame( const safevector<SgVec3d> &start,
                                                        const SgVec3d &s_P, 
                                                        const SgVec3d &s_N,
                                                        const SgVec3d &s_U,
                                                        const SgVec3d &s_V,
                                                        safevector<SgVec3d> &finish,
                                                        const SgVec3d &f_P, 
                                                        const SgVec3d &f_N, 
                                                        const SgVec3d &f_U, 
                                                        const SgVec3d &f_V );

    /* Change from animated geometry space to reference geometry space. */
    extern XGEN_EXPORT safevector<SgVec3d> fromAnimToRefFrame( 
                                                        const safevector<SgVec3d> &animCVs, 
                                                        const XgPatch *patch,
                                                        const double u, const double v, 
                                                        const int faceId,
                                                        safevector<SgVec3d> &refCVs );

    /** @name Unique identifier color encoding. */
    //@{
    /* Encode an unsigned int value into a color. */
    XGEN_EXPORT void encodeId2RGB( unsigned int id, unsigned char c[3] );
    
    /* Decode a color into an unsigned int value. */
    XGEN_EXPORT unsigned int decodeRGB2Id( const SgVec3d &color );
    //@}
    
    /** @name File handling helpers. */
    //@{
    
    /* Convert a string into a valid path. */
    extern XGEN_EXPORT std::string validPath( const std::string &path );

    /* Returns true if the given path is a valid directory path */
    extern XGEN_EXPORT bool validDirPath( const std::string &path );

    /* Cleanup a path; the latter makes sure the path ends in '/' */
    extern XGEN_EXPORT bool fileCleanup( std::string &filename );
    extern XGEN_EXPORT bool pathCleanup( std::string &path );
    
    /* Convert a path with backslashes to forward slashes */
    extern XGEN_EXPORT std::string forwardSlashes( const std::string& path );

    /* Create the directory for the file if it does not exist. */
    extern XGEN_EXPORT bool createDir( const std::string &fullName, 
                                       bool containsFileName = true );

#ifdef OSWin_
    extern XGEN_EXPORT std::string convertPathSeperateToWindows( const std::string &fullName, bool containsFileName );
#endif

    /* Returns true if the given file name is not a relative path */
    extern XGEN_EXPORT bool isAbsolutePath( const std::string &filename );

    /* Return the base name for a file without extension. */
    extern XGEN_EXPORT std::string baseFileName( const std::string &fileName );

    /* Clear out the cached file locations. */
    extern XGEN_EXPORT void clearFileCache();

    /* Expand string marcos within an attribute */
    extern XGEN_EXPORT std::string expandMacros( const std::string &param,
                                                 const std::string &patchName,
                                                 const XgDescription *descr,
                                                 const std::string &moduleName="",
                                                 double u=0.0, 
                                                 double v=0.0, 
                                                 int faceId=0 );
    
    /* Search for given filename through the xgDataPath list */
    extern XGEN_EXPORT bool findFileInXgDataPath( std::string &expandedFileName,
                                                  const std::string &origFileName,
                                                  const std::string &patchName,
                                                  const XgDescription *descr,
                                                  const std::string &moduleName = "",
                                                  bool quiet = false,
                                                  double u = 0, double v = 0,
                                                  int faceId = 0 );

    /* Get a full path for a filename through the xgDataPath list */
    extern XGEN_EXPORT std::string resolveFileInXgDataPath( const std::string &origFileName,
                                                const std::string &patchName,
                                                const XgDescription *descr,
                                                const std::string &moduleName = "" );
    
    /* Expand input map reference prior to evaluation. */
    extern XGEN_EXPORT std::string expandInputMapName( const std::string &origFileName,
                                                       const XgDescription *descr,
                                                       const std::string &moduleName = "");

    /* Expand an output file name for a data file. */
    extern XGEN_EXPORT bool expandOutputFileName( std::string &expandedFileName,
                                                  const std::string &origFileName,
                                                  const std::string &patchName,
                                                  const XgDescription *descr, 
                                                  const std::string &moduleName = "",
                                                  bool createDir = true );

    extern XGEN_EXPORT std::string expandFilepath(  const std::string &path, 
                                                    const std::string &descr, 
                                                    bool isDir=true,
                                                    bool createDir=false,
                                                    const std::string &patch="", 
                                                    const std::string &moduleName="" );

    /* Returns true if a given filepath exists. Otherwise, returns false along with an error message. */
    extern XGEN_EXPORT bool filepathExists( const std::string& filepath, std::string& errorMsg );

    //@}
#ifndef XGNOCOLLISION
    /* Build a triangle mesh from the vertices and triangles. */
    extern XGEN_EXPORT bool buildMdTriangleMesh( const safevector<SgVec3d> &vertices, 
                                                 const safevector<unsigned int> &triangles,
                                                 MdTriangleMesh* triMesh );
    
    /* Build a bounding tree out of the vertices and triangles. */
    extern XGEN_EXPORT MdBoundingTree* buildMdBoundingTree( 
                                                 const safevector<SgVec3d> &vertices, 
                                                 const safevector<unsigned int> &triangles );
#endif
    
    /* Return the namespace of the given object. */
    extern XGEN_EXPORT std::string objNameSpace( const std::string &obj );

    /* Return the namespace of the given object in its short form. */
    extern XGEN_EXPORT std::string objBaseNameSpace( const std::string &objName );

    /* Strip the namespace from the given object. */
    extern XGEN_EXPORT std::string stripNameSpace( const std::string &obj );
	
	/* Check if the base name of the object is emptry. */
    extern XGEN_EXPORT bool isBaseNameEmpty( const std::string &objName );

    extern XGEN_EXPORT void encodePathNameSpace( std::string& filepath );

    /* Find the object given a full attribute name. */
    extern XGEN_EXPORT XgObject* getObject(	const std::string &palette,
    						const std::string &description="",
    						const std::string &object="" );

    /* Get an attribute value given an attribute name. */
    extern XGEN_EXPORT std::string getAttr( const std::string &attrName,
                         const std::string &palette,
                         const std::string &description="",
                         const std::string &object="" );

    /* Set an attribute given an attribute name. */
    extern XGEN_EXPORT bool setAttr( const std::string &attrName,
                  const std::string &value,
                  const std::string &palette,
                  const std::string &description="",
                  const std::string &object="" );

	/* Get an texture attribute given an attribute name. */
	extern XGEN_EXPORT std::string getTexture( const std::string &attrName,
		const std::string &palette,
		const std::string &description="",
		const std::string &object="" );
	
	/* Set an texture attribute given an attribute name. */
    extern XGEN_EXPORT bool setTexture( const std::string &attrName,
                        const std::string &texture,
                        const std::string &palette,
                        const std::string &description="",
                        const std::string &object="" );

    extern XGEN_EXPORT std::string palette( const std::string &description );

    /* xgen default values for igroom */
    inline double igAutoExportTpuDefault()
    {
        return 5.0;
    }

    inline bool igAutoExportDefault()
    {
        return true;
    }

    inline std::string igAutoExportFolderDefault()
    {
        return "${DESC}/groom";
    }

    extern XGEN_EXPORT void dumpSeExprBuiltins( const std::string& filename );
}


/**
 * This variable stores the current file version for all newly exported files.
 */
XGEN_EXPORT extern const unsigned int XGFileVersion;

/** Current file version of the file being imported. */
XGEN_EXPORT extern unsigned int XGImportFileVersion;

/** Filter mask for debug messages. */
XGEN_EXPORT extern unsigned int XGMessageFilter;

XGEN_EXPORT extern const std::string XgArgUnused;

XGEN_EXPORT extern std::string xgLocName( const std::string &name=XgArgUnused,
					  const std::string &arg1=XgArgUnused,
					  const std::string &arg2=XgArgUnused,
					  const std::string &arg3=XgArgUnused,
					  const std::string &arg4=XgArgUnused,
					  const std::string &arg5=XgArgUnused,
					  const std::string &arg6=XgArgUnused,
					  const std::string &arg7=XgArgUnused,
					  const std::string &arg8=XgArgUnused,
					  const std::string &arg9=XgArgUnused,
					  const std::string &arg10=XgArgUnused);

/*
 * Each of the methods provided below are actually called through a
 * macro. This macro allows the file and line number to be
 * reported. For each method there is a 'level' bit field
 * provided. Level 0, in all cases, stands for "no messages" and each
 * level value after that increases the amount of information
 * reported.
 */
XGEN_EXPORT extern int xgmessage( const unsigned int descriptor,
                                  const char *srcFile, int lineNumber,
                                  const std::string &message );

// Strip Source Code Location from xgen messages on Release Builds
#ifdef _DEBUG
#define XG__FILE__ __FILE__
#define XG__LINE__ __LINE__
#else
#define XG__FILE__ ""
#define XG__LINE__ 0
#endif

/**
 * This function is for debug messages. Basic program workings.
 */
XGEN_EXPORT extern unsigned int XGDebugLevel;
#define XGDebug(d,mesg) \
 ( ((((unsigned int)(d)) & xgutil::msg::maskLEVEL) <= XGDebugLevel) && \
          ( \
            (XGMessageFilter == xgutil::msg::maskALL) || \
            (((unsigned int)(d)) & xgutil::msg::maskMODULE) == 0 || \
              ( \
                ((((unsigned int)(d)) & XGMessageFilter) & \
                    xgutil::msg::maskSIDE) && \
                ((((unsigned int)(d)) & XGMessageFilter) & \
                    xgutil::msg::maskMODULE) \
              ) \
          ) \
        ) \
    ? xgmessage( d | xgutil::msg::msgXgDEBUG, XG__FILE__, XG__LINE__, mesg) \
    : 0


/**
 * This function is for reporting statistics. Maybe you want to be able
 * to print out the number of primitives generated, use this function.
 */
XGEN_EXPORT extern unsigned int XGStatsLevel;
#define XGStats(d,mesg) \
 ( ((((unsigned int)(d)) & xgutil::msg::maskLEVEL) <= XGStatsLevel) && \
          ( \
            (XGMessageFilter == xgutil::msg::maskALL) || \
            (((unsigned int)(d)) & xgutil::msg::maskMODULE) == 0 || \
              ( \
                ((((unsigned int)(d)) & XGMessageFilter) & \
                    xgutil::msg::maskSIDE) && \
                ((((unsigned int)(d)) & XGMessageFilter) & \
                    xgutil::msg::maskMODULE) \
              ) \
          ) \
        ) \
    ? xgmessage( d | xgutil::msg::msgSTAT, XG__FILE__, XG__LINE__, mesg) \
    : 0


/**
 * This function is for reporting warnings. Similar to errors, but this
 * is most likely something you just want the user to know, not a problem.
 * No filtering is used by warnings, only the level has effect.
 */
XGEN_EXPORT extern unsigned int XGWarningLevel;
#define XGWarning( d, mesg ) \
 (((unsigned int)(d) & xgutil::msg::maskLEVEL) <= XGWarningLevel) ? xgmessage( d | xgutil::msg::msgWARNING, XG__FILE__, XG__LINE__, mesg) : 0


/**
 * This function is for error reporting. When something goes wrong, but
 * we can recover from it, report it with this function.
 */
XGEN_EXPORT extern bool XGQuitOnError;
#define XGError( mesg ) xgmessage( xgutil::msg::msgERROR, XG__FILE__, XG__LINE__, mesg)
#define XGTip( d, mesg ) \
(((unsigned int)(d) & xgutil::msg::maskLEVEL) > XGWarningLevel) ? xgmessage( 0 | xgutil::msg::msgTIP, XG__FILE__, XG__LINE__, mesg) : \
	xgmessage( d | xgutil::msg::msgTIP, XG__FILE__, XG__LINE__, mesg)

#ifdef OSWin_
#undef round
#endif

#endif
