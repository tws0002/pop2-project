// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef XgExport_h
#define XgExport_h

////////////////////////////////////////////////////////////////////////////////
//	On Windows, global symbols must be marked for export when referenced by
//	code in the DLL where the symbol is defined, and marked for import when
//	referenced by code from other DLLs.
//
//	By default, all global symbols on Linux and OS X are exported from the
//	shared libraries in which they are defined.
////////////////////////////////////////////////////////////////////////////////

#if defined(OSWin_)
// C4231: Disable warnings on extern before template instantiation
// C4251: 'identifier' : class 'type' needs to have dll-interface to be used by clients of class 'type2'
// - For example when exporting a class that contains a STL member we get this warning
// C4275: non  DLL-interface classkey 'identifier' used as base for DLL-interface classkey 'identifier'
// - For example when exporting a class that derives from boost
#pragma warning (disable : 4231 4251 4275)
#endif // OSWin_

// until I have time to check on linux, just do windows and osx
#if defined(OSWin_) || defined(OSMac_)
	#define USE_DECLEXPORT
#endif

#if defined(__GNUC__)
	#define DLL_EXPORT __attribute__ ((visibility ("default")))
	#define DLL_IMPORT 
#else
	#define DLL_EXPORT __declspec(dllexport)
	#define DLL_IMPORT __declspec(dllimport)
#endif


/* FabricGeom */
#if defined(USE_DECLEXPORT)
	#if defined( XGEN_FABRICGEOM_DLL )       // Defined when building FabricGeom DLL
		#define XGEN_FABRICGEOM_EXPORT DLL_EXPORT
		#define XGEN_FABRICGEOM_EXTERN
	#else
		#define XGEN_FABRICGEOM_EXPORT DLL_IMPORT
		#define XGEN_FABRICGEOM_EXTERN extern
	#endif
#else
	#define XGEN_FABRICGEOM_EXPORT
#endif

/* FabricMath */
#if defined(USE_DECLEXPORT)
	#if defined( XGEN_FABRICMATH_DLL )       // Defined when building FabricMath DLL
		#define XGEN_FABRICMATH_EXPORT DLL_EXPORT
		#define XGEN_FABRICMATH_EXTERN
	#else
		#define XGEN_FABRICMATH_EXPORT DLL_IMPORT
		#define XGEN_FABRICMATH_EXTERN extern
	#endif
#else
	#define XGEN_FABRICMATH_EXPORT
#endif

/* GLee */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_GLEE_DLL )       // Defined when building GLee DLL
#define XGEN_GLEE_EXPORT DLL_EXPORT
#define XGEN_GLEE_EXTERN
#else
#define XGEN_GLEE_EXPORT DLL_IMPORT
#define XGEN_GLEE_EXTERN extern
#endif
#else
#define XGEN_GLEE_EXPORT
#endif

/* libcaf */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_LIBCAF_DLL )       // Defined when building libcaf DLL
#define XGEN_LIBCAF_EXPORT DLL_EXPORT
#define XGEN_LIBCAF_EXTERN
#else
#define XGEN_LIBCAF_EXPORT DLL_IMPORT
#define XGEN_LIBCAF_EXTERN extern
#endif
#else
#define XGEN_LIBCAF_EXPORT
#endif

/* partio */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_PARTIO_DLL )       // Defined when building partio DLL
#define XGEN_PARTIO_EXPORT DLL_EXPORT
#define XGEN_PARTIO_EXTERN
#else
#define XGEN_PARTIO_EXPORT DLL_IMPORT
#define XGEN_PARTIO_EXTERN extern
#endif
#else
#define XGEN_PARTIO_EXPORT
#endif

/* SeExpr */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_SEEXPR_DLL )       // Defined when building SeExpr DLL
#define XGEN_SEEXPR_EXPORT DLL_EXPORT
#define XGEN_SEEXPR_EXTERN
#else
#define XGEN_SEEXPR_EXPORT DLL_IMPORT
#define XGEN_SEEXPR_EXTERN extern
#endif
#else
#define XGEN_SEEXPR_EXPORT
#endif

/* SubEngine */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_SUBENGINE_DLL )       // Defined when building SubEngine DLL
#define XGEN_SUBENGINE_EXPORT DLL_EXPORT
#define XGEN_SUBENGINE_EXTERN
#else
#define XGEN_SUBENGINE_EXPORT DLL_IMPORT
#define XGEN_SUBENGINE_EXTERN extern
#endif
#else
#define XGEN_SUBENGINE_EXPORT
#endif

/* XGen - the core */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_DLL )               // Defined when building XGen DLL
#define XGEN_EXPORT DLL_EXPORT
#define XGEN_EXTERN
#else
#define XGEN_EXPORT DLL_IMPORT
#define XGEN_EXTERN extern
#endif
#else
#define XGEN_EXPORT
#endif

/* XpdFile */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_XPDFILE_DLL )       // Defined when building XpdFile DLL
#define XGEN_XPDFILE_EXPORT DLL_EXPORT
#define XGEN_XPDFILE_EXTERN
#else
#define XGEN_XPDFILE_EXPORT DLL_IMPORT
#define XGEN_XPDFILE_EXTERN extern
#endif
#else
#define XGEN_XPDFILE_EXPORT
#endif

/* XgUI */
#if defined(USE_DECLEXPORT)
#if defined( XGEN_XGUI_DLL )       // Defined when building XgUI DLL
#define XGEN_XGUI_EXPORT DLL_EXPORT
#define XGEN_XGUI_EXTERN
#else
#define XGEN_XGUI_EXPORT DLL_IMPORT
#define XGEN_XGUI_EXTERN extern
#endif
#else
#define XGEN_XGUI_EXPORT
#endif

#endif // XgExport_h
