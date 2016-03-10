//*****************************************************************************
/*!
   \file bifrost_decl.h
   \brief Defines attribute specifier macros used in the Bifrost API classes.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_DECL_H_
#define _BIFROST_DECL_H_

#if defined(BIFROST_API_NO_API)
	#define BIFROST_API_DECL
#elif defined(_WIN32) || defined (__CYGWIN__)
	#ifdef BIFROST_API_IMPL
		#ifdef __GNUC__
			#define BIFROST_API_DECL __attribute__((dllexport))
		#else
			#define BIFROST_API_DECL __declspec(dllexport)
		#endif
	#else
		#ifdef __GNUC__
			#define BIFROST_API_DECL __attribute__((dllimport))
		#else
			#define BIFROST_API_DECL __declspec(dllimport)
		#endif
	#endif
#else
	#if __GNUC__ >= 4
		#define BIFROST_API_DECL __attribute__((visibility ("default")))
	#else
		#define BIFROST_API_DECL
	#endif
#endif

#ifndef BIFROST_INLINE
	#if defined(_WIN32)
		#define BIFROST_INLINE __forceinline
	#else
		#define BIFROST_INLINE inline
	#endif
#endif

#endif // _BIFROST_DECL_H_