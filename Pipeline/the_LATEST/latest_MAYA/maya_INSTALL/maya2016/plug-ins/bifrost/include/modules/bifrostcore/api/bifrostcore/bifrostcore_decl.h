#ifndef _BIFROSTCORE_DECL_H_
#define _BIFROSTCORE_DECL_H_

#if defined(BIFROSTCORE_API_NO_API)
	#define BIFROSTCORE_API
#elif defined(_WIN32) || defined (__CYGWIN__)
	#ifdef BIFROSTCORE_API_IMPL
		#ifdef __GNUC__
			#define BIFROSTCORE_API __attribute__((dllexport))
		#else
			#define BIFROSTCORE_API __declspec(dllexport) // Note: actually gcc seems to also supports this syntax.
		#endif
	#else
		#ifdef __GNUC__
			#define BIFROSTCORE_API __attribute__((dllimport))
		#else
			#define BIFROSTCORE_API __declspec(dllimport) // Note: actually gcc seems to also supports this syntax.
		#endif
	#endif
#else
	#if __GNUC__ >= 4
		#define BIFROSTCORE_API  __attribute__((visibility ("default")))
	#else
		#define BIFROSTCORE_API
	#endif
#endif

#endif //_BIFROSTCORE_DECL_H_